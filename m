Return-Path: <linux-kernel+bounces-885791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADA8C33EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 05:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCC44247EB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 04:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F28324466B;
	Wed,  5 Nov 2025 04:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="me5sjNZ3"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA247260F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 04:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762315986; cv=none; b=lpVSMQ8YpnWb3ZOH2BPjR+1TyfgplJ7XdN8JubJc2nA6FVj+AOoHe8elO82L7u4OqCbBBZTrheWviZoru6MBgjWt72/APwxBkxzZcBxo8nFQQMYn1tzOKlxOJB+6DqRBhVHIU0psjaX1eaBbgMLXoQzeKoK3fdazMnPm8eqqIa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762315986; c=relaxed/simple;
	bh=Eeg8JaMqf0IVm+msPAuMZVAemXY1r9F8Xrpn+cUTUbk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Wj43DaYfXg7N9xe2QDvwolGtujyBifhpkyGltD3rFC6QECck+yJSoex2JHaC8kf7sfgbo+1aYWN1pGIlulzVocIuuY5ZjvUIvzZjmMfR+5gfeIMnaIlyxbOL5r7zoKDIVzjVHZWSVvrjU/YaqwzKucs7paVsK7xoHiy8nSWUUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=me5sjNZ3; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 55858EC0213;
	Tue,  4 Nov 2025 23:13:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 04 Nov 2025 23:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762315982; x=1762402382; bh=J8MSnqb9oJ8hOyo/Cuc0Lahe+ACYy1X7u4c
	6Cmkf0Ec=; b=me5sjNZ3cOuy9BjgUmaJtcG4W0KHRF35S9yNi0PjDrGQkc7il31
	F5G2V/B2YbkIzvxej1bhcMOUcWGrf40Plw1YRsHGepdF6Z2pJUUObLfRoai1m/dv
	/ypUwxuYfrI2CWkVpGKspS1uvrt+k6eUJgrq3889dC8czyCWgMeMQFNjA2ulgW/z
	Fnv1DTZ3PoJ1NsjYB/+qiHfRQYQzEcaJS7By1ocwQ96AuK7zLau1efeG4EXgcjTt
	VcafHWSYUU3xZ26LGu18uvzJf+Y6aDZpHWcFWY3MjjFZPhbeuB0FSUyfFj6wJ9HL
	bjBYau+rWv8dFVY2nBctC8hNlBKVaGZYR2w==
X-ME-Sender: <xms:zM4KaR0l1OxErxWXaygApfF_9BONM9C2pMz07CzuU3Teevzpux5yww>
    <xme:zM4KaT5GmYkH6L3Hc_d_O-twnq6TDZQVj2sviQ1d8XNEE5V7sxMdiQWeaEkuM7fg5
    nhh1SJYkHiRNs_7XXSaIb2SpEzMN4hRq7OI9IFkVJPV-X03a6IAwbo>
X-ME-Received: <xmr:zM4KadTV15gR_oE47J17283eElwFXqEAHdAhnnDeImIib6dLrRyPhK-Wb_T2vXS6kXYmEPaBi9kt_6XHuPi0KhhFzqzib9yu1GE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvleduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:zM4KaYXAICgnitXLRix7RN-xOnsznBzZtbi6Oqh2k_pBrDpMkSzeOw>
    <xmx:zM4KaSENEJpWEIxaOlbbiV9NSjRqK1DurtvOrl66jqRPyoMUAkOS8A>
    <xmx:zM4KabcODOifgDuXFQVlqpGVTuhMs0g6SaXjf5HKiTk68eW4_vxOpA>
    <xmx:zM4Kabq7p643LGzplcMHhsBzAlsyP2aWZicZVnJ0IAOHnnQEMjKu9Q>
    <xmx:zs4KacX86euGDMYc27_IarFDd8axj6mdTHAG8SuD5NUBok2K_O5qdOP1>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 23:12:57 -0500 (EST)
Date: Wed, 5 Nov 2025 15:13:09 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
cc: Stan Johnson <userm57@yahoo.com>, mpe@ellerman.id.au, npiggin@gmail.com, 
    christophe.leroy@csgroup.eu, sam@ravnborg.org, benh@kernel.crashing.org, 
    linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
    rdunlap@infradead.org, Cedar Maxwell <cedarmaxwell@mac.com>
Subject: QEMU limitations, was Re: [PATCH v4] powerpc: Use shared font data
In-Reply-To: <797f0a13-350f-e26d-f1ef-876419e1c013@linux-m68k.org>
Message-ID: <492c13c9-666c-9578-6c66-0eb8fefc93dc@linux-m68k.org>
References: <20230825142754.1487900-1-linux@treblig.org> <d81ddca8-c5ee-d583-d579-02b19ed95301@yahoo.com> <aQeQYNANzlTqJZdR@gallifrey> <20108eef-b7cf-3f23-264a-5d97021f9ffa@linux-m68k.org> <aQgJ95Y3pA-8GdbP@gallifrey>
 <797f0a13-350f-e26d-f1ef-876419e1c013@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Mon, 3 Nov 2025, Finn Thain wrote:

> > OK, remember I don't think I've ever tried PPC via MacOS booting, so 
> > not familiar with it.
> > 
> 
> I will try to set up a MacOS guest in QEMU, to see if the hang can be 
> reproduced that way.
> 

QEMU appears to be incompatible with the Old World ROM from the Beige G3. 
'qemu-system-ppc -M g3beige -bios 78F57389.ROM -serial stdio' drops into a 
ROM diagnostic menu and won't boot.

I did get 'qemu-system-ppc -M mac99 ...' to boot into MacOS 9, by using 
OpenBIOS instead of Apple firmware. Unforunately, BootX is not compatible 
with this configuration, so it won't help.

BootX is compatible with beige powermacs, but 'qemu-system-ppc -M g3beige' 
with OpenBIOS fails to boot MacOS 9 ("MacOS: unable to find an interrupt 
controller node").

OpenBIOS wouldn't boot a MacOS 8.1 CD-ROM either, but for different 
reasons: both mac99 and g3beige failed with "No valid state has been set 
by load or init-program".

