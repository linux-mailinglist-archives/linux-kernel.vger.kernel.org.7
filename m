Return-Path: <linux-kernel+bounces-802244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB719B44F87
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0AF4B611A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367E82D7DD0;
	Fri,  5 Sep 2025 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx18sxkf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710A42D6E63;
	Fri,  5 Sep 2025 07:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057032; cv=none; b=WYLWRlnU7zvCzp/aWIyYBZsu7q/NkxjwCdjAZIFBX9NnLcj/T1ajgGbT5IA6BxBrdF+9WnbUdKRbQX0PJNQpe84vDed6snmJpAT2asmJ8ZkX08m0zQgiKWb6Dhqx9nYwH0dMsyn0f6801M6IJ2ZB5CmYzKlYLdROjGt4OPBZsIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057032; c=relaxed/simple;
	bh=XRDAGJO3J7xfVFZ68FR2LEPnLTAvZtxytqz1IEgOaKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2EmK50b/GUDPdTmZ/eqMr3VrY/mtxxOlEuPXuczti0jYKcSJON1TkDDk/BBNLVkoY/PS7M2Lt/QBPA4ScyNY5Jm896TZ+4I4UQ096Sx6xc/y2KcHAIwWwEAf466m00Cm0n7GEkAFVxJ6e3nHawUXJSX9kY9Vxgrt4cUL3Ms3xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kx18sxkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92D6C4CEF1;
	Fri,  5 Sep 2025 07:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757057032;
	bh=XRDAGJO3J7xfVFZ68FR2LEPnLTAvZtxytqz1IEgOaKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kx18sxkfbY7IWN0m6R7S4C99w7nk6D8MH0ICf8AvGbCecK9veRLOzjFdCAEZZG1E0
	 qVKhP0G1kJsORAk8EPU8nLI9eXqpFhPw3ERK6EsdSSOkroZppSV8GOTQSdaS/YFH9t
	 jBWBWNpi9pV+WRXMNqnWBsSJ+6CgEeOjDUz+3Hl+kFO/7r7e+T9MHg1h942T6Wbd0G
	 vDItsLGzsbBmMQHTnhrScPE1KzIsrZN/HxqV79by/2Ozb0U50SZzq3crUjpttwATDi
	 kprl2xgfzd3rEbfp+KIa+kL9erD1o6e2283XIuVSk6U2HwNZhThZ+ZEXJuYso5XLVj
	 JgPl4qA+unZsQ==
Message-ID: <179f19c0-d9fc-4efb-bc78-8dc1e7505b13@kernel.org>
Date: Fri, 5 Sep 2025 09:23:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] arm64: dts: bst: add support for Black Sesame
 Technologies C1200 CDCU1.0 board
To: Albert Yang <yangzh0906@thundersoft.com>
Cc: adrian.hunter@intel.com, arnd@arndb.de, conor+dt@kernel.org,
 devicetree@vger.kernel.org, gordon.ge@bst.ai, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org
References: <05665d48-72d7-4304-9dd1-1f337235ecd4@kernel.org>
 <20250903070609.3475214-1-yangzh0906@thundersoft.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250903070609.3475214-1-yangzh0906@thundersoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/09/2025 09:06, Albert Yang wrote:
>>
>> No, you need to finally read and follow DTS coding style.
>>
>>>             gic: interrupt-controller@32800000 {
>>>                     compatible = "arm,gic-v3";
>>>
> 
> Thank you for pointing out the DTS coding style requirements. I have now
> carefully reviewed the documentation and updated the GIC node as follows.
> 
> I have a question regarding the property ordering. According to the DTS
> coding style documentation at:
> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
> 
> The preferred order of properties in device nodes is:
> 
> 1.“compatible”
> 2.“reg”
> 3.“ranges”
> 4.Standard/common properties (defined by common bindings, e.g. without vendor-prefixes)
> 5.Vendor-specific properties
> 6.“status” (if applicable)
> 7.Child nodes, where each node is preceded with a blank line
> 
> However, I'm uncertain about how to order properties that start with "#".
> I have treated them as standard/common properties and updated the node as follows.
> Could you please confirm if this approach is correct?

They go as standard common properties. Whether you group all '#'
together or sort by name skipping '#' is up to you, because common style
does not define that.

> 
> 
> 		gic: interrupt-controller@32800000 {
> 			compatible = "arm,gic-v3";
> 			reg = <0x0 0x32800000 0x0 0x10000>,
> 			      <0x0 0x32880000 0x0 0x100000>;
> 			ranges;
> 			#address-cells = <2>;
> 			#interrupt-cells = <3>;
> 			interrupt-controller;
> 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
> 			#size-cells = <2>;

I would keep #size-cells after #address-cells, because they describe
same thing - addressing of children.



Best regards,
Krzysztof

