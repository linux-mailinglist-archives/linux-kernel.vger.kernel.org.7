Return-Path: <linux-kernel+bounces-853495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75540BDBCEF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F13F547430
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B112E888A;
	Tue, 14 Oct 2025 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MvC2hoFm"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3437B2DD60F;
	Tue, 14 Oct 2025 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760484589; cv=none; b=lXxUYN7X6XaxFSRka+aSdcPVkeXDcXdYXGRo/XjOZEDfqJ7Toi3arPZY/D7JlGhPTb/VpQESKs9/aIvUK5SY1CthSIcE+pZhvxq7YIWSLW3+da0hK5gIDkNAbXUMyPS6a+sc9lwU2dkMx4264V85NQ0SjsaF/XdqphS2iARUUUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760484589; c=relaxed/simple;
	bh=DbfxI4gIZ2YyPcrjUKBC3FhOTnQ2mCIIwkZ4hgseiNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWc+hqYWhVyNpyTNJS74kW+109t50dHyNADqyjomdYhucLlWEPP3H0e/MUCt254oLzzzRhXOiUIkoXLMCh3sH4KNEHQAq3tEXOpH+N5uIN+rXxNVbx5jGlHSY4zUWo7Opr/pAClvbTRe3ir/h4dbxlwwj2JYFOXzplHqFyRQ4LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MvC2hoFm; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cmVmm55FMz9t55;
	Wed, 15 Oct 2025 01:29:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760484584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9EgudNb1t2H04X3Uxf3sckikMBJDc7XWFtowvqn87DA=;
	b=MvC2hoFmjRlE08Z2cpHd91R496RZQ73YHbMmRpbQ8bRaEwPs/YKcfYcU5Oa02aHUqu/hhp
	kudwEr50YG+idlJGiVkH+q5YzmmDRFXBR47vXIsg/e9PEicA/XZcrfLJCor89jJozhEL1o
	WQq0jzaM2fMo2+IiZ2CM1cUoZzzYW0p7MMFUx/KIihW6UnJ4kDCWDeZpdHtv3iueBPnioG
	XunJSCHsXoGoQfY3+1WC7pI4t+RqCzp0BBNNmcBBOIWBTWnlCGFcDFFR7eLTHeyY29Rhi2
	RhT7MPyrDaIYzo+Z8CPwApX3rhCQauOrs5by6uJR+Y+jMVbyFxBFuAwxCikXdQ==
Message-ID: <24287186-1b97-434f-929f-a391a2fd9784@mailbox.org>
Date: Wed, 15 Oct 2025 01:29:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/8] ARM: dts: imx: add power-supply for lcd panel
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@dh-electronics.com
References: <20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com>
 <20251014-imx6_dts_clean_2-v1-1-508b36e5a3fd@nxp.com>
 <ddc44948-4816-452f-8b78-b1dfe44d507b@nabladev.com>
 <aO7IOCdq013j3rre@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aO7IOCdq013j3rre@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 1gdpq4cmtt4pmqpa7trd33o7sk81o6h4
X-MBO-RS-ID: 93991c12fdee1fd4b15

On 10/15/25 12:01 AM, Frank Li wrote:
> On Tue, Oct 14, 2025 at 10:46:56PM +0200, Marek Vasut wrote:
>> On 10/14/25 9:38 PM, Frank Li wrote:
>>> Add power-supply for lcd panel to fix below CHECK_DTBS warnings:
>>>     arch/arm/boot/dts/nxp/imx/imx6q-evi.dtb: panel (sharp,lq101k1ly04): 'power-supply' is a required property
>>
>> ...
>>
>>> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts
>>> index b29713831a74489e8cc0e651c18a40d85f9f9113..04e570d76e42cd67a38e0f3b2301598f712e6bd4 100644
>>> --- a/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts
>>> +++ b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts
>>> @@ -199,7 +199,7 @@ touchscreen@38 {
>>>    		reg = <0x38>;
>>>    		interrupt-parent = <&gpio5>;
>>>    		interrupts = <4 IRQ_TYPE_EDGE_FALLING>; /* GPIO E */
>>> -		power-supply = <&reg_panel_3v3>;
>>> +		vcc-supply = <&reg_panel_3v3>;
>> This looks like a different kind of change ?
> 
> It is touchscreen, It needs sperate patch fix it to align
> edt-ft5x06.yaml.
Can you please split this fix from the series, include the error message 
you get from DT check, and possibly add Fixes: tag ?

Thank you

