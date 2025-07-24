Return-Path: <linux-kernel+bounces-744587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FB9B10ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AB41C2851D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C062E92BA;
	Thu, 24 Jul 2025 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="V4UyRgcc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nh4G/HQ/"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C5421D584
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371458; cv=none; b=lP2Xb5mgZwUJBEo9PTmxKW1v+/rqVgU++eBmXdSMj+TsoApoi556G4cTSTRSp1VT1Bs6A3WLxsZi5UHPRc8IuTxBDQBLIP4M5efOfEVEA1tH3rZra8yDAvX4yZ5Ka0B9nmz0kX5XYpbogGREZtZFz6xnXlSUblKNhwNLuXK33NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371458; c=relaxed/simple;
	bh=0A55vp8FBIOTV/COTxx0ZU8cYtI097lePCD4V0XQ9iQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lBjkAx3K2YhFneAjpTlKEnWdlA8JQESen41jIcQmxycdWPMjrzjqhnVrtOQQsUsGT0hlk3neDWSuHgo9HI0eLfHyhs2Edsprm03Z4Ptn9b/oyyQpHJdN47Tjitij43o37MBHIPx4HBk2oijkxBMk/pdozdowgswERnijlL36rD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=V4UyRgcc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nh4G/HQ/; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 789CA1D0012F;
	Thu, 24 Jul 2025 11:37:34 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 24 Jul 2025 11:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753371454;
	 x=1753457854; bh=AP/PoBMEh1e13vTPgegIzgrccE6w45FBbhjFPa5ONZU=; b=
	V4UyRgcct+5rI31Ztz80wNpzG2IlSpaBgBwCnEq01GXgkLn0ooCStWUFfRU6T61W
	sMIUEOYscnyFpnmAndmXz1qGpp9o6AKn6OkGuyIaryrIaDM9+/XxhLiYDgwDB+D5
	bTVp7fsMO01WfCc/KxOmOzPFrB7XQJZQJfGWi1TGn5OIkqGVZkjafapgOWB64ph3
	A85Y/MhqxnPVfGN0GoHo6SLaX6srLiQzZOWk/74g4QSg4KJxiJRtNT1bM2arnRe4
	bzPQjYSvh5mTY0udxncgMS3nvOpQf/FBj8X0j7+BU1SferBoAU1BYWmduwhH7NI0
	8HXdoVj9PB2YDbBsmceo1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753371454; x=
	1753457854; bh=AP/PoBMEh1e13vTPgegIzgrccE6w45FBbhjFPa5ONZU=; b=N
	h4G/HQ/czkA9cxHBgVXKX5/18oUYy0ITI+oJCBgQ8AOnqZQFqBotNcTLVmlkpstA
	8K/cpxGcTb3yYpancSFAvYNTxOjr74zoLvbX96ee9KVMZr8Yj/Zxf3vy1jzkv+uu
	xxfUcjSRoSltmSNtM9eK+pUlx8QRxYpQASDiQ7IRJMy/bhjAiLZ9iNB3d2u3mDKD
	573EYDwdmgtmqqCWWqfzWdx+CCVEMoAleeXLjiJDIVqReoL/crI3uoUXGGh4af4a
	yjceEF6IRUgs9hWiouC4j7gAfT0EqpwSk/eKhDc+zcTz7MALE3vjZl+4YskCU52/
	tKDgLCJvqNrTOmEvBzxPQ==
X-ME-Sender: <xms:PVOCaIwWTL6vxovo52p4yAfrLCosqCkxHb5-pVLCplYJZ1Ha1gk8Dg>
    <xme:PVOCaMR9rdvAtWzI_x6dflkDLccazSmyOj-v6ooSpHite0aU6tCbzg26SU5zaQb2N
    JScfO_B5Y9kcssib8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekuddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhope
    hpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehjphhoihhmsgho
    vgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvfhhfrdhjohhhnhhsohhnsehosh
    hsrdhquhgrlhgtohhmmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PVOCaFUgLCseWjORu8Lt9Zro7x1h6gHbNcUCSL2C2-WKFWVwMMIy7Q>
    <xmx:PVOCaDhqa-GeVkzlL-JvyUX1D865kVkFvHbloHPkkavKa46t3hLEbw>
    <xmx:PVOCaDvLO-8VZAbvMIY1oaBSOi3uqpsGJaAMDrl4kzMkNMekvP6uIQ>
    <xmx:PVOCaM7kM2IY3DjBRu-H82uwqI01KEC2KCqPI1h2WihaDfVpNu5TsQ>
    <xmx:PlOCaJ0yLSi02u0ySxnJxuw0hp1f-5H1x-XVUpqGhccIc5_lfD44V8NQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CE6F9700065; Thu, 24 Jul 2025 11:37:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T64ccb58220bb6c4f
Date: Thu, 24 Jul 2025 17:37:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Rutland" <mark.rutland@arm.com>
Cc: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, "Peter Zijlstra" <peterz@infradead.org>,
 "Josh Poimboeuf" <jpoimboe@kernel.org>
Message-Id: <b2feb2ec-9e69-4ab4-b75a-6c7f287c763d@app.fastmail.com>
In-Reply-To: <aIIOn-5Zndlb2tDG@J2N7QTR9R3>
References: <8362b484-ea77-4825-8ccb-d5acad660102@oss.qualcomm.com>
 <617201f8-1ad7-4403-b195-8c80d35ea30f@app.fastmail.com>
 <aIIOn-5Zndlb2tDG@J2N7QTR9R3>
Subject: Re: build failure with crosstools gcc 15.1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 24, 2025, at 12:44, Mark Rutland wrote:
> On Fri, Jul 04, 2025 at 03:25:49PM +0200, Arnd Bergmann wrote:
>> On Mon, Jun 23, 2025, at 21:52, Jeff Johnson wrote:
>> > vmlinux.o: warning: objtool: ncsi_process_next_channel() falls through 
>> > to next function ncsi_channel_monitor.cold()
>> > vmlinux.o: error: objtool [elf.c:1360]: elf_write: elf_update failed: 
>> 
>> Sorry for the late reply, have you figured it out in the meantime?
>> 
>> I couldn't immediately reproduce it, so it may already be fixed
>> in linux-next.
>
> $ git clean -fdx
> $ usekorg 15.1.0 make ARCH=x86_64 CROSS_COMPILE=x86_64-linux- defconfig
> $ usekorg 15.1.0 make ARCH=x86_64 CROSS_COMPILE=x86_64-linux- -j56

This is very close to what I use. I assume you are also on an arm64
host here?

> Doing the same with the 14.2.0 binaries, e.g.
>
> $ git clean -fdx
> $ usekorg 14.2.0 make ARCH=x86_64 CROSS_COMPILE=x86_64-linux- defconfig
> $ usekorg 14.2.0 make ARCH=x86_64 CROSS_COMPILE=x86_64-linux- -j56
>
> ... builds successfully, but there are some objtool warnings:
>
> |   LD      vmlinux.o
> | vmlinux.o: warning: objtool: x86_init_dev_msi_info+0x58: relocation 
> to !ENDBR: irq_chip_retrigger_hierarchy+0x0
> | vmlinux.o: warning: objtool: .export_symbol+0x3e78: data relocation 
> to !ENDBR: irq_chip_retrigger_hierarchy+0x0
> | vmlinux.o: warning: objtool: .export_symbol+0x31140: data relocation 
> to !ENDBR: stpcpy+0x0
> | vmlinux.o: warning: objtool: dmar_msi_controller+0x58: data 
> relocation to !ENDBR: irq_chip_retrigger_hierarchy+0x0
> | vmlinux.o: warning: objtool: intcapxt_controller+0x58: data 
> relocation to !ENDBR: irq_chip_retrigger_hierarchy+0x0
> | vmlinux.o: warning: objtool: hpet_msi_controller+0x58: data 
> relocation to !ENDBR: irq_chip_retrigger_hierarchy+0x0
> | vmlinux.o: warning: objtool: ioapic_ir_chip+0x58: data relocation to 
> !ENDBR: irq_chip_retrigger_hierarchy+0x0
> | vmlinux.o: warning: objtool: ioapic_chip+0x58: data relocation to 
> !ENDBR: irq_chip_retrigger_hierarchy+0x0

My build output is empty with either of those toolchains. However
I've seen a couple of other warnings on randconfig builds recently,
all of these are with gcc-15.1:

drivers/gpu/drm/msm/msm.o: warning: objtool: submit_lock_objects+0x10c: sibling call from callable instruction with modified stack frame
drivers/gpu/drm/msm/msm_gem_submit.o: warning: objtool: submit_lock_objects+0x147: sibling call from callable instruction with modified stack frame
drivers/media/cec/core/cec-adap.o: warning: objtool: cec_receive_notify.isra.0+0x6c5: ignoring unreachables due to jump table quirk
kernel/trace/rv/reactor_panic.o: warning: objtool: rv_panic_reaction(): unexpected end of section .text.unlikely
vmlinux.o: warning: objtool: hdmi_display_enable+0x145: hdmi_pll_compute() missing __noreturn in .c/.h or NORETURN() in noreturns.h

      Arnd

