Return-Path: <linux-kernel+bounces-821735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1ADB821A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7AD1C22CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE4E30C118;
	Wed, 17 Sep 2025 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b="GnyFuQsE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cjS6Tyca"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB7134BA30;
	Wed, 17 Sep 2025 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146845; cv=none; b=lgZUoiqlQLMb7LKMo6jKITPTAbghRzrrkOQrMShD2eo7MldYBbXn21rAXyrLaO22dTh1Fj/tbnP9fPAllTOuVvrtH9HNoOhYxLtV4QICrEZti0K7Is3OjHrqri57EWSZNP3BYvXjvh5ZKfq7Mawy2SiC86xpDb51zMj8UDdFluY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146845; c=relaxed/simple;
	bh=jwU9y7BeypRsEQCnku/soTHT3raPcT0fpdaluKNRgR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frDPCHiFGMhU6OIBY1mD8LaqQSbnyiZ8TystuC+f1thIByK/YyA5yDBUJr+jINRzQ0+7lzlqSGmDpe/179BLP5IvSfTAHXBzd4fSksUaKSgyHI2iGzTYKS2/Wf8krQ4UnexLfl6pzbecNH4ybPdn8O1yz0pDf4sUvJ6QmYJRPD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com; spf=fail smtp.mailfrom=bsdio.com; dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b=GnyFuQsE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cjS6Tyca; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bsdio.com
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 906BCEC0294;
	Wed, 17 Sep 2025 18:07:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 17 Sep 2025 18:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1758146842;
	 x=1758233242; bh=u4T4Y+htEHk0Kb10DGACvmH0TTe+99pyaFvj37z6/wg=; b=
	GnyFuQsEKF2IuQGMNvo9BwlxBb5jX4kHD4votbFAGjxKrwFfUSJYmllYV85P4h1l
	V/OhdskoOYAmG21Kb1jc4Ge/6d6Mg5br3YN0qVpnl/E1FWPn4lT0BI/jzUixCm5C
	METW3z+BDaHm8wBRGQjmf19Kzlx+RHS/abGnksvprQUjlPfC6BYtoc0SABNby/oG
	2HBbGqcBelDRDUhRIEDnMmDG0VvFrCtS4d+WyvNYeKQE3T3PqrRxSTuuF0U7wgKv
	eKVJG/SJTf/zEWJ/zeGQ1n3JBLn9e+xysydgW1iRtYWVU/lYZiUs9IrZW8S6oApq
	LCmEVrMRJcj/9tIEK4IdSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758146842; x=
	1758233242; bh=u4T4Y+htEHk0Kb10DGACvmH0TTe+99pyaFvj37z6/wg=; b=c
	jS6Tyca1YI5+/Ml5n6Zv44XcnJH277ch3KUi3J50S5ENRl8WcyxcfncfQuGr++Ng
	7TO2Eem7GT8rrINW1FKZG9a76GOcEsD49YYjZfFyyMBFga8+1x2rbz6SkiIP4w6P
	qyjKryn/uHVRnqBg4cG5L4TQUa8+4vcnTjBie+yUQhRUU+HNiDeHS95xJDYROQcT
	GojHS1uSWwt8KWmnhb7CjyMBor/mm/pHA//xQnXKvT+JF/xC6hnE556nZnUta1xJ
	oqZSdd2bvOtSnB6DASJBON63q7vZRjIHUzwwylyg2r7qHDh5874QrlpR/93eu1kB
	2OhJyYH8/yzVxMTjqvf2g==
X-ME-Sender: <xms:GTHLaGRU6ie16DyxXOMBGRfYaBIMGtHrauOk4RN2ZDARaZAmi-SlPA>
    <xme:GTHLaK_hktpwucTvYO0UAfF97ZtlaX3lLYKIBSUvOQ8ey6zPvk502-C7Hn6DsuHTA
    S3pvvrbsBtTkXHx-u8>
X-ME-Received: <xmr:GTHLaGi80pOI6MFvlMGJhY5aPagZ7LFfEz52-29coRxXpLqHPb-DPwqUVkZlh5XTJMTZTopY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeeitdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:GTHLaLbhMO5zUH2oImyWNfvzJgSsabXu2pBe4O5jyXtJ7UtD9hHCMQ>
    <xmx:GTHLaL_bD3CujM01bn6a3OGstVlhe6WxadDNXZLBkNo9Ch9Ds0_iHg>
    <xmx:GTHLaNPAzHLJZsafqLU0_TGdG_0WOka9ID7cbuQAWiEqw_jiRG9KOw>
    <xmx:GTHLaIF97r2dpKj9SqD4afZIHb2zHr9-7xF5L3kPSZPXu_oCZQloVw>
    <xmx:GjHLaFSh6Lpz6c87qmzXNVP0KiwxTrDNvyQnzyWfhDSsquPoxCQcR6nf>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 18:07:20 -0400 (EDT)
Message-ID: <93193358-9818-4c63-bd55-9b910631e2a9@bsdio.com>
Date: Wed, 17 Sep 2025 16:07:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250917180428.810751-1-rebecca@bsdio.com>
 <20250917180428.810751-3-rebecca@bsdio.com>
 <8b5625a5-56bf-49bc-b4cf-82c60460db65@lunn.ch>
Content-Language: en-US
From: Rebecca Cran <rebecca@bsdio.com>
In-Reply-To: <8b5625a5-56bf-49bc-b4cf-82c60460db65@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/25 15:04, Andrew Lunn wrote:
> I see you did not manage to get phy-handle to work.

No, I didn't. I added a printk and it said the addr is 0, but adding the 
phy node with a reg value of 0 doesn't work.


-- 

Rebecca Cran


