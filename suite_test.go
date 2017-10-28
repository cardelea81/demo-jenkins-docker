package main_test

import (
	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"

	"testing"
)

func TestDemoGoLapi(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "DemoGoLapi Suite")
}

var _ = Describe("Demo Test", func() {
	It("should be true", func() {
		Expect(true).To(BeTrue())
	})
})