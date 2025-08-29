Return-Path: <linux-kernel+bounces-791124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72181B3B246
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC0C1C27F44
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FC935979;
	Fri, 29 Aug 2025 05:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ydadmk1P"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A3FB652
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756443813; cv=none; b=GMtwq0ZT3fe1Qezj5+GJ42/tNhF4uO5gEExn31Q0Ek/0DxE+j5mJjkTnc8BLIlgotpbcanvZRMeu6V0eWYNG/SvlnELMxFasYPvdwnbl3VACJpkbmdR017MyujHSfm86lziUBR2Y4u97UZ6FUOTUOO8G3irpMuYj2w2gyHUBM6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756443813; c=relaxed/simple;
	bh=HgGs1nmyr93hWqKJb/wArPT5hRVjZy9lGlIN/F+3xkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQKqY/0bKGSVz1j2VvsCiEk0/3WwI70UUs5cmqeMHFYs8LoQKp1fuWbaDszpS3YG6r3J3zl0XXdA2w8QUnM13R3c1gKLDjAftJxutu6mILY8KOcJ0r4/5LUPwT78EyaguQn4NW45B0fOkRGLJtJDeNFZdGnHZ/BWmTwTswRcaZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ydadmk1P; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b0c8867so14270305e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756443810; x=1757048610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bb9BFU+tpEf23jDV6mWRZSZIrfp5E5QZk6jdr2Nh69s=;
        b=Ydadmk1PgLqjPNaXaBDo75Tg6EI9AJNfPsTJHzGlF+QbqEnFP/5kO/Mn397NNpHfZ8
         m89EfTTV6xbNWWWoZA+2qNmoGrda2UAbsUekBtznzAxt23q/qNkx3JCiYpfCwZrWa51R
         DHydSrB27xuSwjiY1ltCeWdX1n4GSPSO+/gVSiGrEPKfMkZBz61zeuVGo+xkS1z1tn2L
         zakFQVK0a6AWYFk9QwYd5s0jZBAijdCLuVlVZLODgkH96tUBFt/mobjZfAS6uPNFwE0K
         5GSd+UZYvjPnDCO7Lzf9MWBd3ijqeys2hHj39b7oIZ4rfu3oc0OCiXpW+H0zqdzLVUYy
         epXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756443810; x=1757048610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bb9BFU+tpEf23jDV6mWRZSZIrfp5E5QZk6jdr2Nh69s=;
        b=UtzEMEpChU4Whnpc4G/TCxdaYOsVep7JgsaHlebYLXRG536AQirwRUUPYd2nkvH5IT
         7gcbDCvgZg20yWAeOcyVPfVrjie3T2OsRignFz9MYQ4xsrLIggAKbn1wvUoTSNTTeH5r
         XEASmFyawqdr1saLTGpL8G1Tet0GjOCF6HHldW4YVp1Uay555EbeOAIlGpuz1x7sc7pr
         QAIVVH3zT1qrxIyI9gOTbXCnkziLXOJuUNyfOyTIION/pzKOWXBeuI3/KtakuWhs2JqX
         I02E4biGy29Le2jbwAXO/kc93EMShyh2D26drnx8Yg8rWCZawhxi0EOID3jtfUlZif5t
         4/7w==
X-Forwarded-Encrypted: i=1; AJvYcCX47heZxFZ1hB6+lOFhRGrY5H/mlUOjLrQcQNXlUCy/QxAUJRaS5OQbOzN/v4JR0vGKpd6oUJ0qiAx7hVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4tx7RHeE+5UxVp8haF9vGNwYcfrLsiRVCK5Nau9rZJaIYmC61
	Zgyt+jJhJPm0Y84rG/x0i3MB+MDnsMVR10ZKTK0jeYaoGbC0gr/VxTe9FIjFL41DJYk=
X-Gm-Gg: ASbGnctZv2XBu6SPiRG78ODTVsBpUQfZHcbQ4wqKXSsQMZM9r53rRYny6Qnaj3KnquR
	U6CYN6oReen4WS+buNG61N92qV2S7bFPw+Ceu474HtXsQourJ/vsWzd4q7PH9YkBSW1R1sqjR1r
	YinwRoVtXsSfAkC8rSkVtv+tdV4xQj3mdmL16DNTUntdYxeT+SritVu7pdZA6DC1ZE+B7Y1A6RX
	KTtyfSv9py4E8ERLk7ugF53nl1h3Jx0QoJ2IYhFjDyQxScfEdeNMPMyjLjFVrUOWfCmo2t89jkm
	0IjNj3myEoDHHcJ1l+m1rXKbp0lU7xJKxTGahNSaAnJzQMVitEwEf3YhquCbyuqxRmcCLmHZarq
	l7kBANAZthlp1L2q0Gbecp0dITnvJZcaO/CQCVmSP3IkKEf3mNTczDtmXE0hgGeynARv/xaMi1R
	oNXvbjEYScKpil
X-Google-Smtp-Source: AGHT+IFVd6qIssetNf0PlgYJI19qTYNEIHf0vWYP6G6M987Vw9zUraqTXmyhlT/MrqFSPHzJ1uz73g==
X-Received: by 2002:a05:600c:3544:b0:45b:7c4c:cfbf with SMTP id 5b1f17b1804b1-45b7c4cd1e7mr35520595e9.23.1756443809583;
        Thu, 28 Aug 2025 22:03:29 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:6103:4200:a4c6:4e84:e72c:19fd? ([2a02:2f04:6103:4200:a4c6:4e84:e72c:19fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66bbcf19sm66990015e9.4.2025.08.28.22.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 22:03:29 -0700 (PDT)
Message-ID: <27d76eac-6141-45db-a347-edfc3bb593d4@tuxon.dev>
Date: Fri, 29 Aug 2025 08:03:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add
 documentation for the PCIe IP on Renesas RZ/G3S
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
References: <20250828193605.GA957994@bhelgaas>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20250828193605.GA957994@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Bjorn,

On 8/28/25 22:36, Bjorn Helgaas wrote:
> On Thu, Aug 28, 2025 at 10:11:55PM +0300, claudiu beznea wrote:
>> On 8/8/25 14:25, Claudiu Beznea wrote:
>>> On 08.07.2025 19:34, Bjorn Helgaas wrote:
>>>> On Fri, Jul 04, 2025 at 07:14:04PM +0300, Claudiu wrote:
>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>
>>>>> The PCIe IP available on the Renesas RZ/G3S complies with the PCI Express
>>>>> Base Specification 4.0. It is designed for root complex applications and
>>>>> features a single-lane (x1) implementation. Add documentation for it.
>> ...
> 
>> Renesas HW team replied to me that there are no clock, reset, or interrupt
>> signals dedicated specifically to the Root Port. All these signals are
>> shared across the PCIe system.
>>
>> Taking this and your suggestions into account, I have prepared the following
>> device tree:
>>
>> pcie: pcie@11e40000 {
>> 	compatible = "renesas,r9a08g045-pcie";
>> 	reg = <0 0x11e40000 0 0x10000>;
>> 	ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x8000000>;
>> 	/* Map all possible DRAM ranges (4 GB). */
>> 	dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0x1 0x0>;
>> 	bus-range = <0x0 0xff>;
>> 	interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
>> 		     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
>> 		     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
>> 		     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
>> 		     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
>> 		     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
>> 		     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
>> 		     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
>> 		     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
>> 		     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
>> 		     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
>> 		     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
>> 		     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
>> 		     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
>> 		     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
>> 		     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
>> 	interrupt-names = "serr", "serr_cor", "serr_nonfatal",
>> 			  "serr_fatal", "axi_err", "inta",
>> 			  "intb", "intc", "intd", "msi",
>> 			  "link_bandwidth", "pm_pme", "dma",
>> 			  "pcie_evt", "msg", "all";
>> 	#interrupt-cells = <1>;
>> 	interrupt-controller;
>> 	interrupt-map-mask = <0 0 0 7>;
>> 	interrupt-map = <0 0 0 1 &pcie 0 0 0 0>, /* INTA */
>> 			<0 0 0 2 &pcie 0 0 0 1>, /* INTB */
>> 			<0 0 0 3 &pcie 0 0 0 2>, /* INTC */
>> 			<0 0 0 4 &pcie 0 0 0 3>; /* INTD */
>> 	clocks = <&cpg CPG_MOD R9A08G045_PCI_ACLK>,
>> 		 <&cpg CPG_MOD R9A08G045_PCI_CLKL1PM>;
>> 	clock-names = "aclk", "pm";
>> 	resets = <&cpg R9A08G045_PCI_ARESETN>,
>> 		 <&cpg R9A08G045_PCI_RST_B>,
>> 		 <&cpg R9A08G045_PCI_RST_GP_B>,
>> 		 <&cpg R9A08G045_PCI_RST_PS_B>,
>> 		 <&cpg R9A08G045_PCI_RST_RSM_B>,
>> 		 <&cpg R9A08G045_PCI_RST_CFG_B>,
>> 		 <&cpg R9A08G045_PCI_RST_LOAD_B>;
>> 	reset-names = "aresetn", "rst_b", "rst_gp_b", "rst_ps_b",
>> 		      "rst_rsm_b", "rst_cfg_b", "rst_load_b";
>> 	power-domains = <&cpg>;
>> 	device_type = "pci";
>> 	#address-cells = <3>;
>> 	#size-cells = <2>;
>> 	renesas,sysc = <&sysc>;
>> 	status = "disabled";
>>
>> 	pcie_port0: pcie@0,0 {
>> 		reg = <0x0 0x0 0x0 0x0 0x0>;
>> 		ranges;
>> 		clocks = <&versa3 5>;
>> 		clock-names = "ref";
>> 		device_type = "pci";
>> 		vendor-id = <0x1912>;
>> 		device-id = <0x0033>;
>> 		bus-range = <0x1 0xff>;
> 
> I don't think you need this bus-range.  The bus range for the
> hierarchy below a Root Port is discoverable and configurable via
> config space.

Thank you for the pointer. I'll update and send a new version.

Claudiu



