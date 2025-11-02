Return-Path: <linux-kernel+bounces-881765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E179C28E0A
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 12:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D77394E42D7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 11:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094DD2BF015;
	Sun,  2 Nov 2025 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M4mtYi6G"
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0742BE658
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762082424; cv=none; b=BW+tStJ6Rsu1rZIFysHUpYkf/c7T3tmRuh3kDAUONax5HsSyI4JPUnGGlYcRxP1cAgiQMmR4i++CdXO7fH0KS3aC0zks/xeyFIpY/KLl3BlWwoHPH7sqXQ5gHOC6IMyvc8c3nqhIZXg1RMiB3aR+JH3SvL+ezGQ7S0RBUSZf1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762082424; c=relaxed/simple;
	bh=EFafSP3HIrxQTM7cLUtbO4phMNjZKXUmKRZYEqMGerg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=L2X92PoLImJx1DcvIQBV2HT4iHPVjiNBen7t5BGnGCD7exSm3nrPthvPbbyNLAZ7Pg30quCkI10Xfw8kqo988YqJbwBYkrQ6x8WKc7eBXQ5GYyer4deTBDQ0j+/SizwgDSxjFFcTyidMsgllsmmTvj//HnSr0A4sF+8pIHR3DZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M4mtYi6G; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 95FBE7A012A;
	Sun,  2 Nov 2025 06:20:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 02 Nov 2025 06:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762082420; x=1762168820; bh=6m3o1ByUcKnQCCidqvOiypzSMNc/FU4EBRX
	ilWZnF/0=; b=M4mtYi6GOiUwEVnU1+rp8S1+RWIJN7w9+1BjzGQdMoyziBKJGgD
	2ptYd+fCMVtnc5kj5IVMIkfTzcnpce3FEGPicmp6MdCYamhMEYYAg6QGzqBifnNx
	P2PJ+UT+B9pvCdK4oyZohHB52qbq6hlt3Q3rvWq26Qx/zzVuN15NIvoqDcDqqcYh
	tdcnXZP9nzJf6vTa/KQSfjeQUSJonM9XzNLRJbk+hebpV0duTWj+ytPdPUysh6FY
	xdiZabPXizWF1xdMGYxw+mnCZS4wpmILMf150HZmUWlGpzBylO6RvWIsPu36ZO0E
	s031OQYw0LUezL4HgeJQ0DzO/6G6K0QgVIA==
X-ME-Sender: <xms:cD4Had3xlIZ7JJVEZAgthSzOTzG5aRZwet_IKoQJTTkt0Lh8qux75Q>
    <xme:cD4HaYfCxIQjW-rBRFcvcy4LiXxOhK6P4DVyJsHI4zsFdIfoZuGrKjtXjE8JQDmx-
    eiBvm3HzbioIVc_GjGL8ZQyEXzyR9f7xZD97KPB4a8Q3ijnGfU_Zx2M>
X-ME-Received: <xmr:cD4HabxarueTcmYJSXQp7nVaC2tYA678m8CmEtLIHfi6W26TjUpDKyLzkd4sOXFjBtrps4ojTFw-IwYwAV_3b0flP4Rchox1HHs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeehudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeevtddtudfgvddtteeuvdffheegffefhffgjeefueevkeeutdeuleffheevffeh
    ueenucffohhmrghinhepohiilhgrsghsrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdr
    ohhrghdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehushgvrhhmheejseihrghhohhordgtohhmpdhrtghpthhtoheplhhinhhugiesthhr
    vggslhhighdrohhrghdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruh
    dprhgtphhtthhopehnphhighhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghh
    rhhishhtohhphhgvrdhlvghrohihsegtshhgrhhouhhprdgvuhdprhgtphhtthhopehsrg
    hmsehrrghvnhgsohhrghdrohhrghdprhgtphhtthhopegsvghnhheskhgvrhhnvghlrdgt
    rhgrshhhihhnghdrohhrghdprhgtphhtthhopehlihhnuhigphhptgdquggvvheslhhish
    htshdrohiilhgrsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cD4HaYwgnD4En5T6PukYGLYuHvhmlS4V4xGeBrg1H-OefOcz2iYG1w>
    <xmx:cD4HaUZ1xoEon8SCoRYTLcm3mYv8kkfOXWTN_VTplSyxSjRUt05uXQ>
    <xmx:cD4HaZ3g_ShkIhJBpRCAUBfIGl9qdN6HefMepaqX3visPr7_BJofXA>
    <xmx:cD4HaWcvDBVMPJGqSlnVhvfU3Sbw-T3YSM0zrT22ITL3TeNGF1lQ3Q>
    <xmx:dD4HadRWn_csD9ONZJatBy_oC7DaG66d3enfO9Lm-3K-4kBm9nbh2o0F>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 06:20:14 -0500 (EST)
Date: Sun, 2 Nov 2025 22:20:22 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Stan Johnson <userm57@yahoo.com>
cc: linux@treblig.org, mpe@ellerman.id.au, npiggin@gmail.com, 
    christophe.leroy@csgroup.eu, sam@ravnborg.org, benh@kernel.crashing.org, 
    linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
    rdunlap@infradead.org, Cedar Maxwell <cedarmaxwell@mac.com>
Subject: Re: [PATCH v4] powerpc: Use shared font data
In-Reply-To: <d81ddca8-c5ee-d583-d579-02b19ed95301@yahoo.com>
Message-ID: <b657eaa6-e027-4ec4-d6c4-e053cdeb1631@linux-m68k.org>
References: <20230825142754.1487900-1-linux@treblig.org> <d81ddca8-c5ee-d583-d579-02b19ed95301@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Sat, 1 Nov 2025, Stan Johnson wrote:

> 
> The problem also occurs on a PowerBook 3400c.
> 

Not quite. On the 3400, it's not a regression, because CONFIG_BOOTX_TEXT=y 
never worked, AFAIK, as far back as 2.6.8. So I think that's unrelated to 
the regression at hand.
https://lists.ozlabs.org/pipermail/linuxppc-dev/2008-August/061792.html

