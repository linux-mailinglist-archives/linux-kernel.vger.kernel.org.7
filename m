Return-Path: <linux-kernel+bounces-817938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6157CB5893C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9BA7521CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175C01DE89A;
	Tue, 16 Sep 2025 00:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b="h+6R8rQM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gJnc1JZR"
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447ED19EEC2;
	Tue, 16 Sep 2025 00:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982370; cv=none; b=VqySKpIMKRXeSabn4xMrLzVXPWi4hVWLtZngyUElCq9ifUiZKovcM0cXsD/b500TQa6+UCikUPIu0zRPbjfsnt64YaImcydaFU02VPSM3/RM3IaSB6u8IU49C3+2hL6Pxq8d6UOW49zHQRIJRs6zF+9UqLGJAwo7U4ya0ktzJ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982370; c=relaxed/simple;
	bh=95XoVCq2TLIKr5X7Da6otWjnj8bP4qDMJFA/p3ZVsCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tP5dE/hBMuCFiBDjE+NlVQIf8FWdsdLsiL/yhYaAaI5FY7YeYY9jHKeK/Eo0wvTouwugjSyIDO8VlLehn9vIVZawH8Y8/AIFBLIV0Zk0NoGusTBOaPmEY5a6mspz0hkJh1Hy/Emb0NrEh6UVuzJ7Q17bt6mpU6TUEVtnTSA5Iec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com; spf=fail smtp.mailfrom=bsdio.com; dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b=h+6R8rQM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gJnc1JZR; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bsdio.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5693E14000F9;
	Mon, 15 Sep 2025 20:26:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Sep 2025 20:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1757982367;
	 x=1758068767; bh=OMHUdaciQEUphG0YAP/vw1pJBdgfUfPJFNc+8L14fKw=; b=
	h+6R8rQMQZMbVkvm/8OpxCafDntSB5HiLMPjv0ycnPhwN/XAwfDBVUkrz0xt43LZ
	Cap4xH0Uz5G30lOf0prvtqtuCLpdbqE9vqIIcfpbkTt/N4MqpDjz2mNa9ECH3E5H
	NYUKoD4VpumGD1d+Sh0qXw/W1SlxW/OWe8XgK8IUdC9eX2ekBXElAflsoIryeHrR
	3eo1t2wWr7RamCdElyHbKH7u5DmgZAx4oNU7fr+IUicdcD78tJqOGNAowEv2AzJg
	3UVLeiqkStup83o0YZZFTqnT3HK9q9dn2hmIoSsgCUvJz78YkCIoRKpQVUkHbem7
	SMUJbMLZRjXl4M4uSSjtLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757982367; x=
	1758068767; bh=OMHUdaciQEUphG0YAP/vw1pJBdgfUfPJFNc+8L14fKw=; b=g
	Jnc1JZRxWDrJ/YxbKbUTXHzuXHnNO5Yst4vX2QRGSHGD1OSWjdmpFs63+e0Odi0I
	/IPprkPLQKUSelb6qnejzjwE9IsG/kZ6e8+zN6xz7NoVV9FeY82mOyVMuOG1V6oI
	XbN06nZFFjz3+Q2smFVTNqReeG6lH71C12yXp3XyUZAzM06PUd/mq51aihr8xFS8
	OcmTfmlQ+Jb2/JKuN6zFyTzXx/UW1WToJyrPPkFKPMJYfu5wafrDczNpjYPNdQij
	alClrGyMsU4R1Yav9JNJ+ix5pZLmnvLdESbzCNcooq03sTtXMKIV1Wm/MdqLl4Hk
	dcx5darB4s6TF50ZFcymA==
X-ME-Sender: <xms:nq7IaNC8LclF1Q39bRVq820D64NwFTSsMh9yGIhvRyzrKEuT9VgaAw>
    <xme:nq7IaKtfp_9tdRuXbQSIcuNnTb674NdvHWGB_yot10CrGqw-J9kEPLDuNVssGVNjy
    RPE5UXKxcfkZ7nuPqM>
X-ME-Received: <xmr:nq7IaLTIDHMBwS5kjupfqID2xlaCGoENQr_iNK29R6HIYs7I2dCxvyyha1fN9qq7A1jMJdnY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefledufecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:nq7IaBJmBF_j__0JuQ5MHQ-LYvwEytGwCYotXI2b9j_ksMMQ_egk6Q>
    <xmx:nq7IaOve2U-arkChzWhmTL7q5MiUHiNFTmBFdiC33dB6UyVEtaPaEA>
    <xmx:nq7IaI-iOU_nq89e4WIck3KrOlT1CYuxrI7QOLLGqxZ-LNXKTkYV8A>
    <xmx:nq7IaI2CaYyDTUeKRkO7g5Xj7PEG49K-HuXlRy3fABbX7ctCrJ5toA>
    <xmx:n67IaMD7FtHuDwd1vsvSnOTu6SLrJYS-MeUy0frF1-abbsf6-RuIAB5E>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 20:26:05 -0400 (EDT)
Message-ID: <5ccc4945-87f6-4325-b034-ca3f2f90257a@bsdio.com>
Date: Mon, 15 Sep 2025 18:26:04 -0600
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
Content-Language: en-US
From: Rebecca Cran <rebecca@bsdio.com>
In-Reply-To: <58a092c5-5dd0-4718-831a-e25ecb184087@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/25 08:09, Andrew Lunn wrote:
> There is no phy-handle here, and no mdio node in this file. What is
> the MAC connected to? Does it connect to the hosts Ethernet interface?

Yes, it's connected to one of the host's 10Gb Ethernet interfaces.

> RGMII pinctrl is referenced here. This opens up the question about
> RGMII delays. What is this MAC connected to?

It's the AST2500 MAC2, connected to the management LAN ethernet port.


-- 

Rebecca Cran


