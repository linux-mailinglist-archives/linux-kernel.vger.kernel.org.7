Return-Path: <linux-kernel+bounces-790600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF683B3AAAE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68AAD3A9AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC6A338F22;
	Thu, 28 Aug 2025 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BHfHteux"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326FB3128C8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756408324; cv=none; b=E6u8qhUK5K4tBpPhbx8ePtKPvp00c8DMFyRf32ZmsgygiYO3/HIvBAHIgd6xXvvV+4FG75cfG4/NNSTHcxBkkl2srzsKO0bIwQL9OLuJavIP5skODSoM+PgYd/iTTARKn6s63VJCC7tGlLLrDKGyUCGatdQntaUcZK5EHy/q2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756408324; c=relaxed/simple;
	bh=1axduUcJD8exsNtEb/zHqMufgApuREGyC2fKUpMy8xY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rMpQTeE9brS9/mNpPtOBivmji7nR1FMkG1Cf6FA9Ohx6XpJhKIit2SAXVMk+9pOneSWKMvrz5WOvnRaKV6dDxnvUKfycwFPdGEgEFPfk0AZq/AwyMefESaTVC4kmE1GVRGX4QbmwWyFN9G30MPkkbX1Tc0JYE6Ne2c5UEKjGLkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BHfHteux; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3cbe70a7923so1110851f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756408319; x=1757013119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k/gIAWzLi/dYVjmDUDiAyhdJpQJDLZnDh9I4LCgtu6Y=;
        b=BHfHteuxlLcgKS1zCD11ia2aiPS9utlA8yfdnZy37WSRDf0KHAKJ2H/bgrPB8vQubP
         XaLuTewAXDJgn1DBv99TKrrMMDuxifwTHrAw7LCit88yY5KdxcgyRfuw+iuJyOCOzTSh
         FCRYbu3qdK1D24wKzFcbKPKM7efMyuatxW8fH6qsLpieSTw+SbwlmruBXtWOB88m+Q/P
         y/37qD/jgJI8mn2evXt5vg07IWgyr47hNe1rtx5TAUFd4hyKB0NBerAsFPIdl27beCcM
         ngVGbEbQy0awTd0JRqR/GmzQGWmY3rW97FIdFuaHCbQKYwMwzTRLPsKQnhBfrOUhDcH/
         V/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756408319; x=1757013119;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/gIAWzLi/dYVjmDUDiAyhdJpQJDLZnDh9I4LCgtu6Y=;
        b=JC7qxgvn2w3khIxZG9qgsVUvlE2+Fm8PtDpqG/MkGO34PTIIFc3yItwTalzp0xRl3U
         KzPccfjb1/+xQ+4HI38CF6ImB8EFkA71+VYX6t5DQS2/rMspb0pjmM4x8EEJEzb05QyX
         EadSgjoptB+VtRLkVdtjt7XLWvdnWvOo2tac2oId/N9ezhJncx+0q+e/E7uBCmL3p4I7
         xToRj4GzonEMnavTcXCbhu7s9GP5Wm1NEXbxvNA9a1PLoHmVLd24nBKA6hcBNy2aGS/n
         /zQiRydh9qriqM1ip29zG875z6q2wSWjkH5vdgr+vxXUCMZbihaKjIy5yKCUAsPxG87f
         DmOA==
X-Forwarded-Encrypted: i=1; AJvYcCVEVOcF+TWIxzbRi6r3RgHuQcrkYUzOw+4ybWHecqTvuf+hKWzwF7ZYXXtZZnpyvuM9DAoMRYAFO78+Xus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqp5SitF/0B3Wg9Hcw7/4AD5iWqW9h5YCrE+GfAAIcSnK9f1GF
	Nf+LzpTecDpV/PQdc0ZlmonVaJzxb476C0sQ61fGtOt8og11JG5O+FgmygpE7z0NaSw=
X-Gm-Gg: ASbGncu04iCDutxGG+jMHzBCBJgGBKNtr6uBCZ+HCveUfnLcDdgvEItzUgM9Tt9Vy+K
	MF1yU7Wmcr562iDQczFbvUHpZOvMFIRgJ2AgVFedhvl92/tnCgOOJ+rCU49IZnvuyIS9FChfLM9
	UdLpucP6f25jIUQgsyE2YmZAEUkh5VHlg2OWyAzEsODZ5Ka2vRtG/hs6Z3JRcWjRoEeiBWfdlly
	XcOO0GjN82VKLrPDMn23hPtQhen5FDgItHdUUshtn9RDFxisd3yetqyKoV1KV3YRYwLB/Jm8DbZ
	W1Uejpa/pU/ew8iBRfTEmJtMuD5EjduFT8BLSaea8AU+g6d9KfNPtPd0WHkoxOQzZMqiThLvXnp
	TxFwuIawyU0+MAGJ82FrS4L6I0cf3I5Ju+TY4C97Hbgq1bOuSBGMTrR2FMCEFpK1QMHKirM4N5C
	KGqmkzZkUmEut5
X-Google-Smtp-Source: AGHT+IGVuJymha8VKQyO64M6kJMfy+4YYQgBArp3qJU6xZoYfGieRMXhDd0nPPTezX5Ph1gUf3sViw==
X-Received: by 2002:a05:6000:430c:b0:3c7:a2d5:b299 with SMTP id ffacd0b85a97d-3c7a2e4fee4mr14496227f8f.17.1756408319369;
        Thu, 28 Aug 2025 12:11:59 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:6103:4200:a4c6:4e84:e72c:19fd? ([2a02:2f04:6103:4200:a4c6:4e84:e72c:19fd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fc09bsm398093f8f.11.2025.08.28.12.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 12:11:58 -0700 (PDT)
Message-ID: <fe7afeb5-e009-4f68-a3a8-58ff967d3780@tuxon.dev>
Date: Thu, 28 Aug 2025 22:11:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add
 documentation for the PCIe IP on Renesas RZ/G3S
From: claudiu beznea <claudiu.beznea@tuxon.dev>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, catalin.marinas@arm.com,
 will@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 p.zabel@pengutronix.de, lizhi.hou@amd.com, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20250708163407.GA2149616@bhelgaas>
 <71d109a1-211a-45ee-8525-03f1859b789a@tuxon.dev>
Content-Language: en-US
In-Reply-To: <71d109a1-211a-45ee-8525-03f1859b789a@tuxon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Bjorn,

On 8/8/25 14:25, Claudiu Beznea wrote:
> Hi, Bjorn,
> 
> On 08.07.2025 19:34, Bjorn Helgaas wrote:
>> On Fri, Jul 04, 2025 at 07:14:04PM +0300, Claudiu wrote:
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> The PCIe IP available on the Renesas RZ/G3S complies with the PCI Express
>>> Base Specification 4.0. It is designed for root complex applications and
>>> features a single-lane (x1) implementation. Add documentation for it.
>>
>>> +++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml
>>
>> The "r9a08g045s33" in the filename seems oddly specific.  Does it
>> leave room for descendants of the current chip that will inevitably be
>> added in the future?  Most bindings are named with a fairly generic
>> family name, e.g., "fsl,layerscape", "hisilicon,kirin", "intel,
>> keembay", "samsung,exynos", etc.
>>
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/r9a08g045-cpg.h>
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +
>>> +    bus {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <2>;
>>> +
>>> +        pcie@11e40000 {
>>> +            compatible = "renesas,r9a08g045s33-pcie";
>>> +            reg = <0 0x11e40000 0 0x10000>;
>>> +            ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x8000000>;
>>> +            dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0 0x38000000>;
>>> +            bus-range = <0x0 0xff>;
>>> +            clocks = <&cpg CPG_MOD R9A08G045_PCI_ACLK>,
>>> +                     <&cpg CPG_MOD R9A08G045_PCI_CLKL1PM>;
>>> +            clock-names = "aclk", "pm";
>>> +            resets = <&cpg R9A08G045_PCI_ARESETN>,
>>> +                     <&cpg R9A08G045_PCI_RST_B>,
>>> +                     <&cpg R9A08G045_PCI_RST_GP_B>,
>>> +                     <&cpg R9A08G045_PCI_RST_PS_B>,
>>> +                     <&cpg R9A08G045_PCI_RST_RSM_B>,
>>> +                     <&cpg R9A08G045_PCI_RST_CFG_B>,
>>> +                     <&cpg R9A08G045_PCI_RST_LOAD_B>;
>>> +            reset-names = "aresetn", "rst_b", "rst_gp_b", "rst_ps_b",
>>> +                          "rst_rsm_b", "rst_cfg_b", "rst_load_b";
>>> +            interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
>>> +                         <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
>>> +                         <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
>>> +                         <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
>>> +                         <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
>>> +                         <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
>>> +                         <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
>>> +                         <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
>>> +                         <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
>>> +                         <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
>>> +                         <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
>>> +                         <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
>>> +                         <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
>>> +                         <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
>>> +                         <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
>>> +                         <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
>>> +            interrupt-names = "serr", "serr_cor", "serr_nonfatal",
>>> +                              "serr_fatal", "axi_err", "inta",
>>> +                              "intb", "intc", "intd", "msi",
>>> +                              "link_bandwidth", "pm_pme", "dma",
>>> +                              "pcie_evt", "msg", "all";
>>> +            #interrupt-cells = <1>;
>>> +            interrupt-controller;
>>> +            interrupt-map-mask = <0 0 0 7>;
>>> +            interrupt-map = <0 0 0 1 &pcie 0 0 0 0>, /* INT A */
>>> +                            <0 0 0 2 &pcie 0 0 0 1>, /* INT B */
>>> +                            <0 0 0 3 &pcie 0 0 0 2>, /* INT C */
>>> +                            <0 0 0 4 &pcie 0 0 0 3>; /* INT D */
>>
>> The spec styles these closed up: "INTA", "INTB", etc.
> 
> I'll update it.
> 
>>
>>> +            device_type = "pci";
>>> +            num-lanes = <1>;
>>> +            #address-cells = <3>;
>>> +            #size-cells = <2>;
>>> +            power-domains = <&cpg>;
>>> +            vendor-id = <0x1912>;
>>> +            device-id = <0x0033>;
>>
>> Some of this is specific to a Root Port, not to the Root Complex as a
>> whole.  E.g., device-type = "pci", num-lanes, vendor-id, device-id,
>> are Root Port properties.  Some of the resets, clocks, and interrupts
>> might be as well.
>>
>> I really want to separate those out because even though this
>> particular version of this PCIe controller only supports a single Root
>> Port, there are other controllers (and possibly future iterations of
>> this controller) that support multiple Root Ports, and it makes
>> maintenance easier if the DT bindings and the driver structures are
>> similar.
> 
> I'll ask the Renesas HW team about the resets and clocks as the HW manual
> don't offer any information about this.

Renesas HW team replied to me that there are no clock, reset, or interrupt 
signals dedicated specifically to the Root Port. All these signals are shared 
across the PCIe system.

Taking this and your suggestions into account, I have prepared the following 
device tree:

pcie: pcie@11e40000 {
	compatible = "renesas,r9a08g045-pcie";
	reg = <0 0x11e40000 0 0x10000>;
	ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x8000000>;
	/* Map all possible DRAM ranges (4 GB). */
	dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0x1 0x0>;
	bus-range = <0x0 0xff>;
	interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
	interrupt-names = "serr", "serr_cor", "serr_nonfatal",
			  "serr_fatal", "axi_err", "inta",
			  "intb", "intc", "intd", "msi",
			  "link_bandwidth", "pm_pme", "dma",
			  "pcie_evt", "msg", "all";
	#interrupt-cells = <1>;
	interrupt-controller;
	interrupt-map-mask = <0 0 0 7>;
	interrupt-map = <0 0 0 1 &pcie 0 0 0 0>, /* INTA */
			<0 0 0 2 &pcie 0 0 0 1>, /* INTB */
			<0 0 0 3 &pcie 0 0 0 2>, /* INTC */
			<0 0 0 4 &pcie 0 0 0 3>; /* INTD */
	clocks = <&cpg CPG_MOD R9A08G045_PCI_ACLK>,
		 <&cpg CPG_MOD R9A08G045_PCI_CLKL1PM>;
	clock-names = "aclk", "pm";
	resets = <&cpg R9A08G045_PCI_ARESETN>,
		 <&cpg R9A08G045_PCI_RST_B>,
		 <&cpg R9A08G045_PCI_RST_GP_B>,
		 <&cpg R9A08G045_PCI_RST_PS_B>,
		 <&cpg R9A08G045_PCI_RST_RSM_B>,
		 <&cpg R9A08G045_PCI_RST_CFG_B>,
		 <&cpg R9A08G045_PCI_RST_LOAD_B>;
	reset-names = "aresetn", "rst_b", "rst_gp_b", "rst_ps_b",
		      "rst_rsm_b", "rst_cfg_b", "rst_load_b";
	power-domains = <&cpg>;
	device_type = "pci";
	#address-cells = <3>;
	#size-cells = <2>;
	renesas,sysc = <&sysc>;
	status = "disabled";

	pcie_port0: pcie@0,0 {
		reg = <0x0 0x0 0x0 0x0 0x0>;
		ranges;
		clocks = <&versa3 5>;
		clock-names = "ref";
		device_type = "pci";
		vendor-id = <0x1912>;
		device-id = <0x0033>;
		bus-range = <0x1 0xff>;
		#address-cells = <3>;
		#size-cells = <2>;
	};
};

and added clocks in the port section, populated with the reference clock that is 
provided by a board specific clock generator (that I failed to noticed 
previously on schematics; this clock is always on).

Please let me know if you find something wrong with this format.

Thank you,
Claudiu


> 
> If they will confirm some of the clocks and/or resets could be controlled
> as part of a port then patch 3/9 "PCI: of_property: Restore the arguments
> of the next level parent" in this series will not be needed anymore. Would
> you prefer me to abandon it or post it as individual patch, if any?
> 
>>
>> This email includes pointers to sample DT bindings and driver code
>> that is structured to allow multiple Root Ports:
>>
>>    https://lore.kernel.org/linux-pci/20250625221653.GA1590146@bhelgaas/
> 
> Thank you for this!
> 
> And, thank you for your review,
> Claudiu
> 
>>
>> Bjorn
> 


