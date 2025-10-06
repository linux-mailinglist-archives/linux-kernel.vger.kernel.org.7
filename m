Return-Path: <linux-kernel+bounces-842905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01A5BBDF06
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 13:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFD43B95EB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 11:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20545276049;
	Mon,  6 Oct 2025 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0yJgATz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7139417E4
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751890; cv=none; b=L6wLRiTmQNMHks90qsTkVhTw6UKzUJGgnvywwxJixbcVpV6mR4quOL121PcC0yajJI+royoI8yZFEr3le7gimfOC8zXbcR1IY/VlhozuxI9K5o1U6qPTJmtQsH3SvSHbfIWmTLv6jqTX95bgPakrQ9jltk2T5PXecJ+W1XgURws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751890; c=relaxed/simple;
	bh=Xl6Dk0F9cqmTPkAPYBTUJDVqz/Gd9sza/v9bQBlL0J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAXxD+n0lfl/1icKLGjCtr5BfJgzw9xJnaMov0Y6epMsXdNrv1MAjJIsIAXuTvF7V/y0UgtvbjR0sADCJS+yFJe6wTyM7N0I0QP5bEIS5PimxjipvFoJ9WU9FdL+GFLOMZkpo1q0y9BQGZIjfCsvepWkA4XMWDJHVNYJsw4fdDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0yJgATz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFEFC4CEF9;
	Mon,  6 Oct 2025 11:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759751888;
	bh=Xl6Dk0F9cqmTPkAPYBTUJDVqz/Gd9sza/v9bQBlL0J0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0yJgATz9PllvUIJso5s5IbaAcplLZklUvno7iXKoj2ZZmQ+9ijov3+T9osQWrCIC
	 259b9lmea+8JPD7uSfNPTpGSNm1tA7srVZvIK9OpsTaE/LvdOVzQ0ufXNcyN1vwE34
	 zSiIbZDDvTOhjfJ0e2ajE+t+pMC43PgmEYCID1R01EwbIiIW6glC8MNAz44DP1lBpw
	 IASog3NHGcVN+T7BlGm/gMqMPGg+ckoLs8PTBr9604SKiZBgSeJdHgoiTY90xVpqiJ
	 B/ds601LJLTyMD302XzK1qQDttu1eOaTK7ACvispJTTZrCossqykXsYBcPGLaP20DL
	 rwpZcgSV8bXJQ==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4EF6CF40068;
	Mon,  6 Oct 2025 07:58:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 06 Oct 2025 07:58:07 -0400
X-ME-Sender: <xms:z67jaB6QZ4mWWrYCnBEKqgtsn5d6vk3i083pRju-M8hxDC1JlKnu9w>
    <xme:z67jaBP1NAl2lZtrmkls-s86ApNin95zFPJSBKMCOy26ttNQ0YMIwMmyAzG6REEvJ
    BNMelcoGlYkzFeyKu1rBDItiwBkhCjCliBcaddiZhweoFEPhfX4L3Y>
X-ME-Received: <xmr:z67jaHLIEgTeDkTEspcJ6Bjd9dXtS-0EdDQHHYn9cOywsC3xhrv5sToHooJ39Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeljeegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehieekueevudehvedtvdffkefhueefhfevtdduheehkedthfdtheejveelueffgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrih
    hllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedq
    vdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnh
    grmhgvpdhnsggprhgtphhtthhopeefvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprhhivghlsehsuhhrrhhivghlrdgtohhmpdhrtghpthhtohepshihiigsohhtodgrfh
    gvtgeiheehhegvvghfheeifegtieeitgeljeesshihiihkrghllhgvrhdrrghpphhsphho
    thhmrghilhdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtth
    hopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthht
    ohephhhprgesiiihthhorhdrtghomhdprhgtphhtthhopehkvghvihhnrdgsrhhoughskh
    ihsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhuthhosehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:z67jaHHaWrrSyxj1cZed5xwq90nevUBaRpQICSPhiEmCMEiNs0Ao3A>
    <xmx:z67jaCylrfQpUdd75u49HZyPZdQdAHGK6ajax34YYFiXTsV1IGfGjw>
    <xmx:z67jaLyLtMznP7_zfyKPtEb8dpqk_CEVqn7CeJaLHM8aKesm49OMCw>
    <xmx:z67jaAZ9L0IHdcwnNAK5MzhEdxWHezojYj7sJuFjG2iqmgdR7jumBg>
    <xmx:z67jaFyHhOysIObh8pvAXxHn-Pq2XMu0S4a8JZeGESmeeqb37h3fPfcf>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 07:58:06 -0400 (EDT)
Date: Mon, 6 Oct 2025 12:58:04 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: syzbot <syzbot+afec6555eef563c66c97@syzkaller.appspotmail.com>, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kevin.brodsky@arm.com, linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, rppt@kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, wei.liu@kernel.org, x86@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [PATCH] x86/mm: fix overflow in __cpa_addr
Message-ID: <hhay4mkthnyyvgvhu3bzohtuyxiwny7i2ewq5gftmluidhioju@kwmnvkee4yha>
References: <68e2ff90.050a0220.2c17c1.0038.GAE@google.com>
 <20251005234805.6fedaccb@fangorn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005234805.6fedaccb@fangorn>

On Sun, Oct 05, 2025 at 11:48:05PM -0400, Rik van Riel wrote:
> On Sun, 05 Oct 2025 16:30:24 -0700
> syzbot <syzbot+afec6555eef563c66c97@syzkaller.appspotmail.com> wrote:
> 
> 
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in __cpa_addr arch/x86/mm/pat/set_memory.c:309 [inline]
> > BUG: KASAN: slab-out-of-bounds in __cpa_addr+0x1d3/0x220 arch/x86/mm/pat/set_memory.c:306
> > Read of size 8 at addr ffff88801f75e8f8 by task syz.0.17/5978
> 
> This should fix it, unless syzbot finds an unexpected new way to
> torture things.
> 
> ---8<---
> From e32cd734444d9a95bb2d1067d934f33ab66f050b Mon Sep 17 00:00:00 2001
> From: Rik van Riel <riel@surriel.com>
> Date: Sun, 5 Oct 2025 23:32:48 -0400
> Subject: [PATCH] x86/mm: fix overflow in __cpa_addr
> 
> The change to have cpa_flush() call flush_kernel_pages() introduced
> a bug where __cpa_addr() can access an address one larger than the
> largest one in the cpa->pages array.
> 
> KASAN reports the issue like this:
> 
> BUG: KASAN: slab-out-of-bounds in __cpa_addr arch/x86/mm/pat/set_memory.c:309 [inline]
> BUG: KASAN: slab-out-of-bounds in __cpa_addr+0x1d3/0x220 arch/x86/mm/pat/set_memory.c:306
> Read of size 8 at addr ffff88801f75e8f8 by task syz.0.17/5978
> 
> This bug could cause cpa_flush() to not properly flush memory,
> which somehow never showed any symptoms in my tests, possibly
> because cpa_flush() is called so rarely, but could potentially
> cause issues for other people.
> 
> Fix the issue by directly calculating the flush end address
> from the start address.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Cc: stable@kernel.org
> Reported-by: syzbot+afec6555eef563c66c97@syzkaller.appspotmail.com
> Fixes: 86e6815b316e ("x86/mm: Change cpa_flush() to call flush_kernel_range() directly")

Reviewed-by: Kiryl Shutsemau <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

