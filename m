Return-Path: <linux-kernel+bounces-887780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27786C390FF
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 05:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3DAD18C3E16
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 04:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DC72BE7A0;
	Thu,  6 Nov 2025 04:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kuviunJD"
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC792586E8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 04:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762402262; cv=none; b=WBNQzPfu89Okv7C4ZdTy/SKDNF0wIMk1SncXXiU65veFqvbb6xqAhNntZ2Enxoi1sNScbU7MDDN47/U8jHk8K33pt23qXvkAytoQIEbNBvJSgbs3X4qb5TwczyAP0NAPbUG0BTGiLUWRIgzHcVyJfL7KDt6apdSilSw/K8LmuXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762402262; c=relaxed/simple;
	bh=qAie94O2NF7ZXj9gzmrVJjDJa9+jsf8pfweonODnjwE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gOx732fXvObyUkMCmjPKNO4NWA6XTewcM7rwVCnIByMRhdL5IGTxVZBOwtydgN2Z4jQ8w/Ct5wSz9Q7Qvuk52MThJa1foYfgcE1fGTD0eS5mp4PwYRYEDdt2Ku6lSNyOpnCV5czx6p0gtNf94nK9Xy/9P1GY6dD/SxzVAwFeC/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kuviunJD; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6D9EB7A0207;
	Wed,  5 Nov 2025 23:10:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 05 Nov 2025 23:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762402257; x=1762488657; bh=LtvDTjPP3JwYvEGnmbYFBlPCbslew90zymx
	8tUWNBRw=; b=kuviunJDLBHDtNDEuNo3DdJBAGE8fry6OdAruBHzhhQxvDftnUs
	JmgBgy45u59QNd8EtWv0t9//xWPCLoRYaHybd5bTZZDDqnt5LFFVTz/a36VboSIC
	cDkDsIh2d9MZbePek0NMAs7gSKwT7Qvz2lYhYgLdhR5naBWtMYszvpfEdCIGBJjs
	NcFeq6VHo7ilIaNwtaItHLxg0vjSyCMjbZrVszNNfZLQHOrePc1ZnHMp3mFGXeLY
	BHGhPg2S4rp7YN9HCMut11Hw/f6Kb+RGf/b8lo5gzA6O5Uy3wsP529i/8YzosiNl
	qeiUAUKEO+1G/9sjwpijetmUCCQKj8DBKiw==
X-ME-Sender: <xms:zx8MaXV-OSn5cc_7Fsa1FDjDreNO4ySGdDAYum6qCDqYYtkNjEvZjw>
    <xme:zx8MabZgJfz8rqEXyQeJMTZxe0V8Ec6XZrnK743QEMgAtf_ToWJnhR20FZbOXyH4D
    O_-lgvdM5zAFqc66cUX-fE7m__BoHLN2lCHKlLZCG9jZUi6Xsy0mw>
X-ME-Received: <xmr:zx8Maezq5rRvi0UbVHoh1DLPYbqTjuMzyNri2Mp0nkWprK5bLX2K9cvM4Q3kgOEW41PMekdYDTUBETLXvMQa6PVG37vYe_lmWak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeduuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtohhphhgvrdhlvghrohihse
    gtshhgrhhouhhprdgvuhdprhgtphhtthhopehushgvrhhmheejseihrghhohhordgtohhm
    pdhrtghpthhtoheplhhinhhugiesthhrvggslhhighdrohhrghdprhgtphhtthhopehmph
    gvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehnphhighhgihhnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepshgrmhesrhgrvhhnsghorhhgrdhorhhgpdhrtghpth
    htohepsggvnhhhsehkvghrnhgvlhdrtghrrghshhhinhhgrdhorhhgpdhrtghpthhtohep
    lhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zx8Mab1LoOmyNFde_jppzQ_-jWPc30J27E-avqBmXxfr1FKEXd4EyA>
    <xmx:zx8MafmjEnxJTghUfk5PQVn2LigmaITwZ3LVGaX2fc_qFk89nIlJUQ>
    <xmx:zx8Maa9YzNVgqOJbY-s0JEyTX_txeF3XPcaGagmfItsi5jEKwnv8MA>
    <xmx:zx8MaVIKnOwZ2W1TRJZwCgBPz34hsoqWuvyyLOuq5v458LC2aDtDuQ>
    <xmx:0R8MaZ2nEL4yTA_jBJbD5KaAbjjJ-YeE1QNlYE-gj69bjPw2I8EcZ4Ie>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 23:10:52 -0500 (EST)
Date: Thu, 6 Nov 2025 15:11:04 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, 
    Stan Johnson <userm57@yahoo.com>
cc: "Dr. David Alan Gilbert" <linux@treblig.org>, mpe@ellerman.id.au, 
    npiggin@gmail.com, sam@ravnborg.org, benh@kernel.crashing.org, 
    linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
    rdunlap@infradead.org, Cedar Maxwell <cedarmaxwell@mac.com>
Subject: Re: [PATCH v4] powerpc: Use shared font data
In-Reply-To: <3cc3d311-35b0-42f1-b20f-ed59391bb8e0@csgroup.eu>
Message-ID: <ead4ef3f-9f8c-a98e-b48d-f052bc9492d0@linux-m68k.org>
References: <20230825142754.1487900-1-linux@treblig.org> <d81ddca8-c5ee-d583-d579-02b19ed95301@yahoo.com> <aQeQYNANzlTqJZdR@gallifrey> <20108eef-b7cf-3f23-264a-5d97021f9ffa@linux-m68k.org> <aQgJ95Y3pA-8GdbP@gallifrey>
 <3cc3d311-35b0-42f1-b20f-ed59391bb8e0@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Wed, 5 Nov 2025, Christophe Leroy wrote:

> 1/ Either build font_sun8x16.o with -fPIC
> ...
> 
> 2/ Or add a PTRRELOC:
> ...

Thanks for your help with this, Christophe.

I fixed up the whitespace problems and forwarded those patches to Stan, 
along with instructions for applying them. He tells me that patch 2 fixed 
the hang. Patch 1 did not.

