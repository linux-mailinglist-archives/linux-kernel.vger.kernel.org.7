Return-Path: <linux-kernel+bounces-882160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3860C29C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A95B4E889A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 01:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9174D275AE8;
	Mon,  3 Nov 2025 01:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DHkSK+8N"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCDE19F127
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762133598; cv=none; b=SGCOlo+RefQCi/We+AVq5psfiXuZia+5ChSxK9PvOjriIXl6IVLBEeIY/aBD4sAiPL8VrMswAowIrwgqE+Skf3axpVXihVNYXI6d7n+T+puvyME4Ocr+jOwaAeUvilM1mScgkL7vFYiht8pmRh+fJcLEJocqnJr+IDZgiySxEwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762133598; c=relaxed/simple;
	bh=srFLzSQUhm+1KYU24MeXzYCCGeLQtQFTIteI8ITLGxs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=trYtL3c/tY/MIg4Uayz0dBymSDMuXcj9yxMtqM7lx7jsYbZz7uHydrQWvcNb4R+zYYek7VWguJsVMpzOO3kUZ7REcwNKFUBCwCPsH8w39WUbbhWKJ1zMpTkTDrvOZFWsD+DMJre1g93S43aY43luEshtlwgRzEmbz4ULa8ChmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DHkSK+8N; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C029AEC0188;
	Sun,  2 Nov 2025 20:33:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 02 Nov 2025 20:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762133593; x=1762219993; bh=3VygVh8ojnHZK6FC71RvbSxh7Er0TIana3l
	DR4kRD/E=; b=DHkSK+8N1Ccmb1vOpA9xnwBD2uvM67fxDbua4lqY7tr5MMqC8tn
	D7VIjFLZ7M1N+3cMHqaFYaJznO3kaBoEZXbZj/ofFQ/B2NI0fSJr1tyUczBHtoQ9
	/gkVN7O8Gf7QSCwdzczVNV7ng9McQdeV+mkn13avLKFmfSnLVErE+4C4EvL08x+L
	SewHUYn+juid2nxlZJT9RfpO/t+E5IghW5WOU+g3W0N/SdO9Ov9tx3qroJZL9j36
	qNR+J+xYmbbxKcWIGeKwcPDTGB0DcKatEFT6iB5kL7BMLuf6VyL2xH9pg+TSWg3N
	hfu9PkujdLWLL1bk5VvYa6OvMRkp4OgYJdw==
X-ME-Sender: <xms:VwYIaUD42uoBLLy3ZodfzjcH3tolU_GIRZSpv84Mx9VwgEH6njHKFg>
    <xme:VwYIaSWedtKwTBcsmsAV8FQQFGsy83O6TQ83O1xa6iFjfrn3oOwYQceOO2lULoOp4
    EVMJZvP4AknMElxzPYt_TxY3B3ebjx9kkB6E94mzU1s94ZjiTit3b8>
X-ME-Received: <xmr:VwYIaS_NA9d5Qj8hMggJvosAsk_snx2ATkQb2EW0JIWyK4Jq45SMEPikkydlqSXO73PIzu1aQxa9oIQTO037o0MluHEnNYV6ndE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeikedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeduuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugiesthhrvggslhhighdrohhrgh
    dprhgtphhtthhopehushgvrhhmheejseihrghhohhordgtohhmpdhrtghpthhtohepmhhp
    vgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtohepnhhpihhgghhinhesghhmrg
    hilhdrtghomhdprhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhr
    ohhuphdrvghupdhrtghpthhtohepshgrmhesrhgrvhhnsghorhhgrdhorhhgpdhrtghpth
    htohepsggvnhhhsehkvghrnhgvlhdrtghrrghshhhinhhgrdhorhhgpdhrtghpthhtohep
    lhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VwYIaUTU-BK8uSSVx3SZODS2Ahtsx-YeSDowDEVUpsPCJTxS7d6AeQ>
    <xmx:VwYIaXQP4o8ikIxT9SvV9pi2FH0Cg47DxBUC5DT3UdjIVezfBEG_WQ>
    <xmx:VwYIaQ6eEV-h7m5Zk1y3SdhLVIQinwn7PXxOTZa1eDlXZQS761KIFQ>
    <xmx:VwYIacXtAfEMH2ORcsi_GkuT3F-oxRK7I6v1DDh5HFclSWso5l12oQ>
    <xmx:WQYIaZybGOq_gvBumGA8zbKaoCkhD1OMeVgVO7aflcI9T0hm_UZ5BfH2>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 20:33:09 -0500 (EST)
Date: Mon, 3 Nov 2025 12:33:22 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
cc: Stan Johnson <userm57@yahoo.com>, mpe@ellerman.id.au, npiggin@gmail.com, 
    christophe.leroy@csgroup.eu, sam@ravnborg.org, benh@kernel.crashing.org, 
    linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
    rdunlap@infradead.org, Cedar Maxwell <cedarmaxwell@mac.com>
Subject: Re: [PATCH v4] powerpc: Use shared font data
In-Reply-To: <aQeQYNANzlTqJZdR@gallifrey>
Message-ID: <20108eef-b7cf-3f23-264a-5d97021f9ffa@linux-m68k.org>
References: <20230825142754.1487900-1-linux@treblig.org> <d81ddca8-c5ee-d583-d579-02b19ed95301@yahoo.com> <aQeQYNANzlTqJZdR@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Sun, 2 Nov 2025, Dr. David Alan Gilbert wrote:

> 
> So I'm not a PPC person specifically; so lets see if the PPC people have 
> any suggestions, but:
> 
>    a) Do you know if there's any way to recreate the same hang/works 
> combination in qemu; I know it has a g3beige model but I don't know how 
> to get something similar to your failing combo.
> 

I guess we could probably reproduce this in QEMU if the BootX bootloader 
could be made to work there. In theory, 'qemu-system-ppc -M g3beige' might 
work.

>    b) Can you get any diagnostics out of the prom on the mac?  Like a PC 
> or anything to have some idea where it hung?
> 

Well, that's the problem: if you enable the CONFIG_BOOTX_TEXT diagnostics, 
the system hangs instead of printing stuff. If you disable the 
CONFIG_BOOTX_TEXT diagnostics (in favour of serial diagnostics) the hang 
goes away.

Anyway, I imagine that the problem with your patch was that it relies on 
font data from a different (read only) section, which is unavailable for 
some reason (MMU not fully configured yet?)

So I've asked Stan to test a patch that simply removes the relevant 
'const' keywords. It's not a solution, but might narrow-down the search.

>    c) Is this only the Powerbooks that are unhappy - are other Macs OK 
> with this - if so, wth is the difference with a powerbook?  Is it a 
> different debian config or something?
> 

The BootX bootloader doesn't work on New World systems, which is probably 
why we don't see this regression on anything newer than a Wallstreet. 

It's likely that other Old World systems are also affected, if they are 
using BootX. We don't yet know whether the regression also affects Old 
World systems using the iQUIK bootloader instead of BootX.

