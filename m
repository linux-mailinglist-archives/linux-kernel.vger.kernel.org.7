Return-Path: <linux-kernel+bounces-819628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F276DB5A3C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6A9486533
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399322877C1;
	Tue, 16 Sep 2025 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b="UaKh37wl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EZ7tx/gM"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26222283FF0;
	Tue, 16 Sep 2025 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057731; cv=none; b=nyXj0SeOrYPqZjbhH7vIbt6NBjzLAwUtvFxzAneODsTtqv/1CX3cS9u8JKRfju4GJ0sfF/OpB36awi+L3YoBbwoD67hPx4Hx4tY2OpoGDu9h5YCvyq8Xu7TItncXPAnV8YSD5Vf/qf5cDI6llwjfJrzJf0e0ivANLmJwwcio6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057731; c=relaxed/simple;
	bh=3SbTO4vzXD864bsh3AB7JLbIIijaYBcFvEXTUelLAvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+rbENo5uxGnBRU+M+y7lQAPwHwDyVXfIWdl+PqF/wBQ16yzPq9WfnH5E1XL4ckt/Qznpdo0mKGeEgBvUlPq2uCLPUcXyzE9M6fi1teEy2vo/yzlYEGB0vPcAXEPGuPqI/cUEiLF0KprItUPva3IsfLStyUZe89j0+QUrFbbs5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com; spf=fail smtp.mailfrom=bsdio.com; dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b=UaKh37wl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EZ7tx/gM; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bsdio.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E98EC1D00013;
	Tue, 16 Sep 2025 17:22:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 16 Sep 2025 17:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1758057727;
	 x=1758144127; bh=FNr3jSgck4Jl1pEEorXXSsO/QSdN0TeOX27XjWwmQk4=; b=
	UaKh37wlbPKHlBiGONx3UjBj5NgdojVqfo8d3QxGRsauJnwIXj2jgGCNgDCp25qa
	/B5KIWykoM13chpDfbneih6g5Zo+29Z/NtOgFFLKU0uJ4w7GtvepB2ul7AAQFB8p
	1+kvgKyD/JhPoojC2vUD/N5GPwIh9/7Lu6unmB3nhtDa0KWYVkdKBoXb5Y0s0w/a
	4WyXyWKs2RX3KC1rb66QyV1+xy6uHucOrU/iCLu+wMjBaZIApHT97VMbYdiN7IlW
	95YVLa2XxiJOGf2BYtLS89u6ElOGY+o8cr2+fyA5nEmaRc/UxmhD3jV5hYBEfV+s
	eyDA4UT/XOQN6QlG3nOS0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758057727; x=
	1758144127; bh=FNr3jSgck4Jl1pEEorXXSsO/QSdN0TeOX27XjWwmQk4=; b=E
	Z7tx/gMX+JHnfBo28xUh1LQhXMbww/GQURpZbheyiYKUde1AonfnGScS0+OYzFOv
	jzWuH0Lb28j67bJBhujQVR488bNfaWAu3EVAE9UL4pioiV5gv2ZF8/1SsnyMozGs
	acHErhAmLXUYwHlFYhBAeuCRkVz4KGg+08Ez5JOs2XPSJfIjhtI0rAbwY+iY+ybV
	pIXrasuNQRa8RkY57Gt/X11jQtj5TWkotsGWF3cNqJiX/I+VHJASeIJNCeIL6sh3
	BfsJiY4WTZSj0YvWDuSPeqieYXK4dWB9UMRWDPhPxyMajBwQCmb3BFfdNZQSQetH
	i9IqCVJ9LzbHqQJv6Sv3w==
X-ME-Sender: <xms:_tTJaAKQKp7Zx4a7W-0SuIKbrn4Bbn4qt7HlFyGLUFnS45Hr4me-3A>
    <xme:_tTJaPU3JOP9QYcDrO8NSjeqRuXYaH48mIe0V78puLRtATa_7psA-UUwPLauP5PJh
    noT7ED6IlmZQ4CLDow>
X-ME-Received: <xmr:_tTJaDZcvwkXms7lKTTYJvyhdOqy2qX2s3qBXipxcxf9KCGMawsg2CXnOsjjfkAgjI3F4gQR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptfgvsggvtggt
    rgcuvehrrghnuceorhgvsggvtggtrgessghsughiohdrtghomheqnecuggftrfgrthhtvg
    hrnhephfekvdekvdfhtddvteehueeuleetjefhieehjeeuhfdtuddtvdeguddtkeevlefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgvsg
    gvtggtrgessghsughiohdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhope
    hrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohgvlhesjhhmshdrihgurdgruhdprhgtphhtthhopegrnhgurhgvfies
    tghouggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthhtohepuggvvhhitggvth
    hrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghr
    mhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqrghsphgvvggusehlihhsthhsrdhoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:_tTJaGwAbLGEIWQxH1_sErMKpB4r7kcgnDzjmrYpHY9WofmhEt3joA>
    <xmx:_tTJaD1zm9G09z0Bz4RuXAMs5vHrs9mDe4HL6Wkg2Q8vOtRzv0togQ>
    <xmx:_tTJaHl1f1GFfbgnQKogxvFKOQk8RaHDvyUO4u5Jt2wfqTCugEdmPQ>
    <xmx:_tTJaC-MWptvSdycC-vRg_NaG9Rd3YNHQsUMXVLnP6c_P9DPQgbnPw>
    <xmx:_9TJaPLRa3mNp1XgIDDKwGqhASuZQIht9nOJpR7B8O5flWLDdlVBYBJi>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 17:22:05 -0400 (EDT)
Message-ID: <e9b0d9c8-9117-4c75-93a7-1c334d823d99@bsdio.com>
Date: Tue, 16 Sep 2025 15:22:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250911051009.4044609-1-rebecca@bsdio.com>
 <20250911051009.4044609-3-rebecca@bsdio.com>
 <58a092c5-5dd0-4718-831a-e25ecb184087@lunn.ch>
 <5ccc4945-87f6-4325-b034-ca3f2f90257a@bsdio.com>
 <74e68c53-2696-4f86-97d3-c0b0a74d4669@lunn.ch>
 <92bcdac9-44b1-4fc8-892a-01ef0ed0b7e0@bsdio.com>
 <3f5e82ec-d96e-4258-b117-9876313f5402@lunn.ch>
Content-Language: en-US
From: Rebecca Cran <rebecca@bsdio.com>
In-Reply-To: <3f5e82ec-d96e-4258-b117-9876313f5402@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/25 13:07, Andrew Lunn wrote:

> Now, it looks like all other aspeed-g5 boards also don't link to the
> PHY. But the driver does seem to support adding an 'mdio' node within
> the ethernet node, and listing the PHYs. Something like:
>
>         mdio {
>                  #address-cells = <1>;
>                  #size-cells = <0>;
>
>                  ethphy0: ethernet-phy@0 {
>                          reg = <0>;
>                  };
>          };
>
> And then you can add a phy-handle to point to it.
>
> Then the question is, did Aspeed mess up the RGMII delays for g5? You
> can try phy-mode = 'rgmii-id' and see if it works.

I can't get that to work, with either 'rgmii-id' or 'rgmii'.

It says "Failed to connect to phy".


-- 
Rebecca Cran


