Return-Path: <linux-kernel+bounces-827847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A06B9342E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6421905502
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3688225B1FC;
	Mon, 22 Sep 2025 20:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b="YVujiShf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ciI1v/nZ"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71F78F51;
	Mon, 22 Sep 2025 20:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574054; cv=none; b=oFw6YG02/MFFHiSPdCL0Qew9/akwOBGXLhEHknAZP3uHwFDoUAcrOh/uIWiLgdMOkQIM8XZ72HjTIkWfBUTQJjpcmIKd5rRdZuWSFqfp56TDQv3uNRtxgqrXGlZnjYaWENKUthrCX8Gm4V1jGUT/6DWVlIsDck9yu45qfO9yH2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574054; c=relaxed/simple;
	bh=nrzlzufW1psyT6tNhuVbg81pyA3WDd2+Vut1Irj0YM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cKmoup9ui07jVixmxMLRXqa8C7jXlVfCkYfk2bRZdXH97DXVIbe43a7ekJZQNo/svPD5IZrRo7NGWTLo/xKyDzVZ8FI/c/rlo742Yvn5MJ3Xk10Lm3tb4G8KbGTPSAVqcJlUvLCCYzTlu4tJsMnWWXxtlnDT49EMNVVRkLGHnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com; spf=fail smtp.mailfrom=bsdio.com; dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b=YVujiShf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ciI1v/nZ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bsdio.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C8FEBEC012A;
	Mon, 22 Sep 2025 16:47:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 22 Sep 2025 16:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1758574051;
	 x=1758660451; bh=A553X7N9M+vhzwoNgciCzyvWzHigGYwmy7BQYXezrBk=; b=
	YVujiShfvgM+CfbKo9GDdj7f3lL74gxBDnrH2t404h0/fbNUOQffMV72lrLzzNFK
	ZhWg6iCppuLo/35Qb70Ws40X95WR6fAkDrxZk1kuKeB0MkGMsrw1RZ9Pp26N00c8
	XglnCqU7WRui7590XXdg0ClBZlhSzAE950djE4wW5aY/AopDZI9JY9bkkLIOA0E2
	7y27c/FvaxgShS1wab0r7v0Cg7lj+e/54atQr9V3OQj3v/hJcIfxyaEgeUI0TXED
	GVfCyV0qEKgZWeWHrrmw1hVgS5blWV2FuFl1eB+fOxDbGfFrAtTLFfZLPpY4huYW
	QK2i/FrdRBGS6NpAXkuJ/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758574051; x=1758660451; bh=A
	553X7N9M+vhzwoNgciCzyvWzHigGYwmy7BQYXezrBk=; b=ciI1v/nZY6Wzq1Tgd
	g6ZgLC7bcshhHzaA94LeuE1vFlm6qDScFSuJPEKCCyZ28DI3uLmGXqIAMZfVp+Fo
	3swp7bA42YrnadgklTYBBz7ZaSDBLUyrvAsx8V44WTKgkJs8qTFbRHgPMxFGu8yK
	dvFoB0O7MLyCsUFRh0k/BMNzp8tr44bSt8T50gb786uKzxuGaHYKValVD5p0lzTh
	+GeXPS4UyJiDCDgfvwYKwdnv5NbuiwnfN3qGxNT5q1jqa+qFrYN1XXfk1SlNwTYq
	UNAWQAuIsLJLM4yxyauHy9iyi7xxeT5gJgBmfdGq0NMa56lqqYEzY329kPZ2KsN+
	xy6Ew==
X-ME-Sender: <xms:47XRaEE2DGs_1UxAv5U70Hqv6B-AWJWLWbbdnsOQ2ISkheX-5O5Rgg>
    <xme:47XRaKvonYKz-J6oY1v8dK0zGD1s9_dkiWe0kvGTZvyUNOWLcpeVm1ANnN8m6wTzM
    tNjNkGWAmTFVAx3aTBQHQs3Z4_tm6IlP81hDESXt61Hs6iuKqjsVAHM>
X-ME-Received: <xmr:47XRaHrDWwbmdTPgXjfL6uN3Bf_HTdaB0xvndQQC9LIwWhTVIi5MQ3VlI4IlBGZfBf67-KlL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeftvggsvggttggr
    ucevrhgrnhcuoehrvggsvggttggrsegsshguihhordgtohhmqeenucggtffrrghtthgvrh
    hnpeffgeegveeufefhffejvdeuhfdvleeuffegleegffetgfettdeglefhtefguddtveen
    ucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprhgvsggvtggtrgessghsughiohdrtgho
    mhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphhtthhopehr
    ohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjohgvlhesjhhmshdrihgurdgruhdprhgtphhtthhopeguvghvihgtvghtrh
    gvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhm
    qdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    hlihhnuhigqdgrshhpvggvugeslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:47XRaBWZpLBX1eJKQIJ2gPPSRXY9wbMCZ4ngR99F50OPcsQZ0PLMxA>
    <xmx:47XRaP2Rcs_UrRGOEZoqc-2D1tjMnCkogjzmRxZwPOWfzBi9Z2veNA>
    <xmx:47XRaGu6ezXamZ0YE4vHimM8DNHyg3vwHmeWmbEMwvAZ35e-rrmisg>
    <xmx:47XRaHVUs4q7BkaxzZJA4_MNgsFrH1Fd4yCMY5aAzMq_1dbcvx5uUg>
    <xmx:47XRaIRjPEDG6raKmL3DvvaMs_d6RFLTJdKnApW657FpHDV9wk6wHx5D>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 16:47:30 -0400 (EDT)
Message-ID: <2cecaf0b-9fb4-49f9-a346-ea3f44627a15@bsdio.com>
Date: Mon, 22 Sep 2025 14:47:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add device tree for ASRock Rack ALTRAD8 BMC
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250917180428.810751-1-rebecca@bsdio.com>
 <dd660ce0388afb61e476f164335600f3fc2b1fb6.camel@codeconstruct.com.au>
Content-Language: en-US
From: Rebecca Cran <rebecca@bsdio.com>
In-Reply-To: <dd660ce0388afb61e476f164335600f3fc2b1fb6.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/25 20:40, Andrew Jeffery wrote:

> On Wed, 2025-09-17 at 12:04 -0600, Rebecca Cran wrote:
>> aspeed-bmc-asrock-altrad8.dts:578.16-581.6: Warning (unique_unit_address_if_enabled): /ahb/spi@1e630000/flash@0/partitions/code@400000: duplicate unit-address (also used in node /ahb/spi@1e630000/flash@0/partitions/tfa@400000)
> It seems odd that the partitions intersect. Are the offsets correct? If
> they are, can you add comments to the DTS discussing what's going on
> there?
I'll delete the code partition. I added it to make it easier for my 
script to flash both TF-A and UEFI areas at once.
>
>> aspeed-bmc-asrock-altrad8.dtb: gpio@1c (nxp,pca9557): '#address-cells', '#size-cells', 'gpio@0', 'gpio@1', 'gpio@2', 'gpio@3', 'gpio@4', 'gpio@5', 'gpio@6', 'gpio@7' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', '^pinctrl-[0-9]+$'
>> 	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#
> This one needs fixing.

I'm confused, because in the existing device tree files I'm only seeing 
'hog' used in the &gpio node, while 'pca[0-9]+' is commonly used as the 
node names for pca95xx devices.

Does the gpio-pca95xx.yaml file need to be updated?


-- 

Rebecca Cran


