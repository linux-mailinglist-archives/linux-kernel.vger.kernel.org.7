Return-Path: <linux-kernel+bounces-725360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE6DAFFE0D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94A93BF192
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5BD2980DF;
	Thu, 10 Jul 2025 09:27:24 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B334A0C;
	Thu, 10 Jul 2025 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139644; cv=none; b=ugJgzogKjnyU5WaoihbYacZlrk3/KN0Nvmgnys8JlodPQmLrWMKz4e4lM5yv0W1kuHj6tGZK8GBiKZMf4LGJqNlKDZ1Rcm0kjtb6wiP1oeAeS8SzAmCVWKesxEsx7JMDwKB+mCAzWVnpPw1ll6QQNpmcVtPRkz5kso/C42VCuxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139644; c=relaxed/simple;
	bh=h+I4PESBExTwFLSyj1x6avtCbIxfti7hBaT17gq0P4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uET4vsm5dWRRlZQgqYfvdoaus/pdVcPaIlMr8Y68eeDWlZhRYhBZrAlybcYbUr6ilg41UQD1R2PEHgQL0oqHAP4aITvOzTv+C5dQaeqga5w3Sisfmq7v6uYTB2qy8DhvJ5LLwcTLCsbo3KhoszmnmlftqsS4AUiaO4RoWzh1/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: esmtpsz10t1752139574t2e477d4c
X-QQ-Originating-IP: fVANaU33qzx/j+OxAgI6zbPV9xjAYtm3YAX+hwq3ekA=
Received: from localhost ( [183.17.231.23])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Jul 2025 17:26:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13541076069648255284
EX-QQ-RecipientCnt: 14
Date: Thu, 10 Jul 2025 17:26:12 +0800
From: Nick Li <nick.li@foursemi.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz,
	tiwai@suse.com, xiaoming.yang@foursemi.com,
	danyang.zheng@foursemi.com, like.xy@foxmail.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: Add schema for FS2104/5S audio
 amplifiers
Message-ID: <BCEA350532C6759B+aG-HNOXmswyEHs2v@foursemi.com>
References: <20250703035639.7252-1-nick.li@foursemi.com>
 <20250708112901.25228-1-nick.li@foursemi.com>
 <20250708112901.25228-3-nick.li@foursemi.com>
 <20250709-invisible-frigatebird-of-felicity-7e87c4@krzk-bin>
 <BD2D8A14FDC941B8+aG91lowfru0KiWWW@foursemi.com>
 <3bb34074-8ce0-4f0e-b7c7-1d77a8cd6ea3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3bb34074-8ce0-4f0e-b7c7-1d77a8cd6ea3@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NkGXhzp6HyG+sxMnQkNrON5aauU0WL52mGuy5/1yrfmyfuULqTUUMOXR
	nf5IghGFk9cLQ28EQWn8/uInMKn7yv+x5T5o4/U6cLnn6Lo7XpGCzTljrdWslCSXX9RTgRk
	DhNCFKVoFq+pFMLg4MR0Oz6x7JqIpMe1azXkO77CPcqdZIXg4VHFBbyhMXf528YFtX1TYwh
	taQdlpzz4p92tR+nwPwIJ8gJu7zg3veQ1+NC+ruOuAdVmZvLle00LtVM627UAN+lv5sfXpI
	0rkV5vo/gVtEOEeFUBm7TttejWCsXBaIfax3fDWyNanorNz5SMiwNTTD4NrOafisZ+tiwER
	E+u+7U16hv2cBpqj85wL1+/dAumCYQzgA+s/gibwH8bdKjaBYduXnL1ErCX0FSuwcwwwEKJ
	ai37S/pUhrcoaGHEAP2cNO9bNWTSyJFUJNu1Fj19lTF4uedJQTCt+sjb3VUOQYhNDAtCf3R
	3b7J2tW7IuXbqsoky5Gf+20uF/LCBMx/7QsxL1XBwgNUxqtasbIP3UdUYk7BCw1ELsDsvLB
	c12XkHLoDLY1WN7wQzogvvBjialf5zV8ZWt3rnSSjaMRmJX7TVdcjNUNC8Gvk5XGW4HBL/z
	ISJE/fccVBk0kToGZzlK3rC8Lye+XSIzamOUEeg8T1D6k5XcvaHXIwrS9lXzcVxhW6tvIRJ
	Dze2am5XczG7zVDjFkTOKKWQsQdLxO32ZLHsnlr1CUOu0JzuavK7Ascnpf/NjAy2s895lJV
	8XLKtPrimXJLduqJzJVDtuO3wu+dA7km4wGtHDPDpsTqOTBywuvTjwE97cVrKlT4tAMhtQp
	XqKzPowl3tH6elm/5CU3Vvouk4Qr0B/4rgIHDKqaaVX1QXmw7nIdZSip/e9RNxgi0jIPBPY
	WujG0gG62hp62USi98PN1mXN5aiLPgBOS6PYop9NWN9Pf7MOOEICFyq1LSq44b6sPC2ZVJJ
	097VRwWGGCMKijFh5VK/Dlp7MaKUMVOVBrbhgFnSjFfN1HDo+BtU7NFwnQ9H1HgnCFi7KUI
	mCONhcOgF3m3RKdzRvo9fXhgJ2HyycVPbHFmKskV6Nd1N9fYyOHtnP9ip0XjSuWn1sWKBa6
	32NDplcEqRC
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Thu, Jul 10, 2025 at 10:27:59AM +0200, Krzysztof Kozlowski wrote:
> On 10/07/2025 10:11, Nick Li wrote:
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +  - reset-gpios
> >>> +  - firmware-name
> >>> +  - '#sound-dai-cells'
> >>
> >> Keep the same order as in list of properties. OTOH, missing supplies.
> > 
> > OK, we will fix the order, but the supplies may not be used as regulator,
> 
> Hm? What does it mean in terms of hardware?
> 
> > we mark them as required, is it OK?
> 
> How codec driver can work without power?

The power may be connected to the baterry/adapter directly,
it may not be under the control of the software,
in this case, the supplies are use as dummy regulators?

Best regards,
Nick

> 
> 
> Best regards,
> Krzysztof
> 

