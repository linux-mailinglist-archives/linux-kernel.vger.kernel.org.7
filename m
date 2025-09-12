Return-Path: <linux-kernel+bounces-814920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC51B55A65
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 292854E1522
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF92286408;
	Fri, 12 Sep 2025 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b="NxKfWVKQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RvKv6szh"
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CF9270EBF;
	Fri, 12 Sep 2025 23:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757720229; cv=none; b=FjU/LR/wKw2RupbsioDH9PpmxIf1/9rdHFzXR5yVbdTMtDTPA/PqMWEQxx0Dvgr3ZImtftVI8pFA22fI+wEQOrKWIw8IlDwXxx9h+cvK59nxoXwXc4beHlGxnBigCn4pXhn9Xus75VzF1l9TM08EvVd7CLMqNvAIpX029L72P28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757720229; c=relaxed/simple;
	bh=UpNCpUB25TCiVfx1g+tZY5qvRbCbukbCF1ca8RYNruU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=W5lMV4QMLexq3JBgX0TQh/jL/696GpMABOcZ9va/cV2RWD36BAStZg+RJ5UZgDG5J2CIBVVrhR4sC1MrqVF4RccKNWYMxiPL907oV/TjWK1mYCc/m7do01s5HRQBWjk7716mAgxqTHy+JaFslf/AhltAp0MMLik552mSshvPfCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com; spf=fail smtp.mailfrom=bsdio.com; dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b=NxKfWVKQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RvKv6szh; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bsdio.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B74147A0183;
	Fri, 12 Sep 2025 19:37:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 12 Sep 2025 19:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1757720225;
	 x=1757806625; bh=40KXg9kUsO5+HICeEL0Iq0HUslxsWdLGZ0xsN27NPfo=; b=
	NxKfWVKQ4CZWI0LoscpaJX6WEp/yA+hcrArsFRjvTb1Yh/ZSoPIpBPtL4KYOU00M
	38QVUlT/7a7YMf72tkR097ADhnPbtOkw7DyOZLLwbX6BIOoe7MHHzZb0d/X/gWpi
	S15rmczJcIaW+7HGY1U/CvmRG0ZkpjEGiaRRzoUzy/9wL5O6W+NwTRXa/OB1CCQC
	UDb9uoxAQ49XZKMUyLFcx46B0ZUBrSUvtucWYguKS2k03kerl3p4XI68kJqP82Mt
	0iqgS9PHrmUTnkK33tWqpJCNcKTuLUVQg3NlHKmFxxOHGhpPWzM4eVhjReRaHb/s
	ZuiSR3iiG/Awpps8xfCiew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757720225; x=1757806625; bh=4
	0KXg9kUsO5+HICeEL0Iq0HUslxsWdLGZ0xsN27NPfo=; b=RvKv6szhC/uAWRcFF
	qLZYBUM/JzLSb/NJYPC5xOdDg7UZlCXmlT2+ZNqZ4NVFI1AvHGAWvpLCH6+NqGQq
	Q5X5XBnHGImJG3vOGOqi/bH/dWFOMFXZWX2Mz3PhdQ1c4mTaMc/hNZs6lEko+qbS
	OhxxZgnexJMz+KhEH5PbXt77zd1SXVHcr+QZTazEJ66/BoIL0hkpOp2VIbno6vdV
	pJhFKOxSkgkKtXBPo7oBpPSwRQuQhrIJgdl7W5CqMLjviXfTDZDWEpQ+9OYY2KLO
	1B7VrxXtq+vjmU3KrAEZPpObI2UOVepofCwCekRdnZjinhuQhNerjqOGnWD/Kx9h
	cv1JQ==
X-ME-Sender: <xms:oK7EaJWYWiIWWi1ubcmf9R1QkKK68HTnHhD5xmKA-HllO9gwbUeDDA>
    <xme:oK7EaIzwz7QQSi2KUGDzwg6g-Ms4dVfQZuAutLIULmlkMhRdn1C3jNkFKENjVGeBA
    L8Z2w30mXE5sERHVt0>
X-ME-Received: <xmr:oK7EaIGe6LRlxraxQZL_KowjeX4CU3Ow2Li3_S0w6HcCogDyvmROIHmuIwEtufnWy_I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeftdeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfhuffvfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpeftvggsvggttggr
    ucevrhgrnhcuoehrvggsvggttggrsegsshguihhordgtohhmqeenucggtffrrghtthgvrh
    hnpeevheehieegvddujeeiudffffdtheeifefhteetledvveehudffiefghfevieejueen
    ucffohhmrghinheplhhinhgrrhhordhorhhgpdguvghvihgtvghtrhgvvgdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvggsvggt
    tggrsegsshguihhordgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepkhhriihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehr
    ohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjohgvlhesjhhmshdrihgurdgruhdprhgtphhtthhopegrnhgurhgvfiestg
    houggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthhtohepuggvvhhitggvthhr
    vggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmh
    dqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    lhhinhhugidqrghsphgvvggusehlihhsthhsrdhoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:oK7EaFucsMrYmPiOzaLV5Joh5nyfmWetEsObfDVTDsCDNRVmkAStbA>
    <xmx:oK7EaACSPjqS8GeqrVllmbcDFFjpsygEjTtdZhehqkGveIAHoavnnw>
    <xmx:oK7EaIDAWuJJarms6BbMKlVyAvbbtnCb9TsGiS1g4d4rTqiGhfBQvw>
    <xmx:oK7EaCrIlYqTfavDdVcugJ8lwrNDX45sk83lJljnJRFozs5xjrL9JA>
    <xmx:oa7EaJ8VYrSyWOWQR9gC9FDzBO0j_Ikl6dLEyIEqBwFOqz6jMAvU686L>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 19:37:03 -0400 (EDT)
Message-ID: <04b0799e-b0a3-4dbc-98f3-239869c79305@bsdio.com>
Date: Fri, 12 Sep 2025 17:37:02 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Rebecca Cran <rebecca@bsdio.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250911051009.4044609-1-rebecca@bsdio.com>
 <20250911051009.4044609-3-rebecca@bsdio.com>
 <1e4c65c6-4745-45e2-9e20-9d2e69ae2ea4@kernel.org>
Content-Language: en-US
In-Reply-To: <1e4c65c6-4745-45e2-9e20-9d2e69ae2ea4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/11/25 00:29, Krzysztof Kozlowski wrote:
> Never tested.
>
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).


Am I doing something wrong, or are a certain number of validation issues 
expected?

For example, I'm seeing these - most of which are from aspeed-g5.dtsi, 
not my dts file:

arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: 
/ahb/apb/memory-controller@1e6e0000: failed to match any schema with 
compatible: ['aspeed,ast2500-sdram-edac']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: 
/ahb/apb/syscon@1e6e2000/p2a-control@2c: failed to match any schema with 
compatible: ['aspeed,ast2500-p2a-ctrl']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: 
/ahb/apb/display@1e6e6000: failed to match any schema with compatible: 
['aspeed,ast2500-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: 
/ahb/apb/timer@1e782000: failed to match any schema with compatible: 
['aspeed,ast2400-timer']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: 
/ahb/apb/pwm-tacho-controller@1e786000: failed to match any schema with 
compatible: ['aspeed,ast2500-pwm-tacho']
/home/bcran/src/linux/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: 
fan@0: aspeed,fan-tach-ch: b'\x00\x08' is not of type 'object', 
'integer', 'array', 'boolean', 'null'
     from schema $id: http://devicetree.org/schemas/dt-core.yaml#

...

/home/bcran/src/linux/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: 
lpc@1e789000 (aspeed,ast2500-lpc-v2): reg-io-width: 4 is not of type 
'object'
     from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
/home/bcran/src/linux/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: 
lpc@1e789000 (aspeed,ast2500-lpc-v2): lpc-snoop@90: 'clocks' does not 
match any of the regexes: '^pinctrl-[0-9]+$'
     from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
/home/bcran/src/linux/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: 
kcs@24 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the 
regexes: '^pinctrl-[0-9]+$'
     from schema $id: 
http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#

...

arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: 
/ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with 
compatible: ['aspeed,ast2500-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: 
/ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with 
compatible: ['aspeed,ast2500-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: 
/ahb/apb/bus@1e78a000/i2c@100/power-supply@3c: failed to match any 
schema with compatible: ['pmbus']
/home/bcran/src/linux/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: 
gpio@1c (nxp,pca9557): '#address-cells', '#size-cells', 'gpio@0', 
'gpio@1', 'gpio@2', 'gpio@3', 'gpio@4', 'gpio@5', 'gpio@6', 'gpio@7' do 
not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 
'^pinctrl-[0-9]+$'
     from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#


-- 
Rebecca Cran


