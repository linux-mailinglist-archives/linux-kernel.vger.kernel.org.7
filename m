Return-Path: <linux-kernel+bounces-892236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 753BBC44ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184633AC416
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89211A3166;
	Mon, 10 Nov 2025 00:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r6QWXFcr"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044F2AD1F;
	Mon, 10 Nov 2025 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762735612; cv=none; b=KgfFK3LMk8AywTrRt7U3ZzK8QC6u+PqzDy3mztlkHlC13T5mtV3HRaSuW+nJ6x2E0LXpYCgvbBHT68b0DCzybFqqUb3nJpS+v4CJQ4APkivbZCVjTTTA8Mj2v+VCJEJ3K7LbXcHkkE6ZqAEUKzoZ5zR71wJQKrrDNobeJ9gKJUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762735612; c=relaxed/simple;
	bh=i38oxbGfsF6lFAnaLeRiw3rKQxeoo0INCaKDi8Xdslc=;
	h=To:Cc:Message-ID:From:Subject:Date; b=ofbWSK49Wv/zAXeAwWsH6u+/EylFCkZgCZK6Q73oQKldBtVrVruxKU76pGdIe6Lf8ltVMttoziOK2b1ljP7f25PAAHU+cG6wCWrXJkrsMyNNepC4bcM/GagjX2J6uKQ11YqT1fgJwaQLgfVykOT3hkhukwPhaFPJ+kwZHwwk12k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r6QWXFcr; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DEDF2EC00A2;
	Sun,  9 Nov 2025 19:46:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 09 Nov 2025 19:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762735607; x=1762822007; bh=+4S2srMpw4Nz0ae7tBlmMmPBL40T
	jSThAwyp5sZYjec=; b=r6QWXFcrasJMFtE2WHkmQZxe54YRO4Zr1QCWLFhpdhz2
	WJlilot3wJ0zov2Q6ulrKEEr75qbtvU070aiPEW2xztUVAwjWr9p7lJMDbtnJhmx
	rQ9WzknbruWL0zS1qumZjWoXsaGcJj+VsS1apPrTs3kTp9ELgjbXusA2hkjcnjHb
	F7gja1bKFuHGUg+ySct9hQFh2UiFWjOxKvM5DkpnUmOSKrOFn2E/OF6G26/JcbrB
	sXzP9AZr8HpTi3bJXN58mbFi3+XMc8tPuOqSPU0QVmxdCxgnswAnZKc0G1AfZmuk
	ck49YWv7ijhpnzpqlPNSRxmbuU+b8PudMZ8IwW9gOg==
X-ME-Sender: <xms:9zURaR_NeUF4ducyEd95sW53Lo6uoxvgN5OXVE5CZwaoTmAqbHqszQ>
    <xme:9zURaTg-2iJ2-U4aACDwSUEebAS9gil4dEONHyoBtDT2AU7jSKsztQaENsOrPDFYK
    r7-B_jucVulqQoc6RTHijcbdUW7MvSlqilTWBsDvZ1E62awH2lYp-s>
X-ME-Received: <xmr:9zURaZcDtIMHNHKsJD-tHr0szFCPnIJ1lBubx6nQ2_fz8BAgbPuYukmJP4F4mRt_hS0dneyKMIugaTD5yKFBEdsvpDborKGZMBU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeiledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghinhcu
    oehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ehfffggeefveegvedtiefffeevuedtgefhueehieetffejfefggeevfeeuvdduleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinh
    eslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrghmvghsrdgsohhtthhomhhlvgihsehhrghnshgvnh
    hprghrthhnvghrshhhihhprdgtohhmpdhrtghpthhtohepuggvlhhlvghrsehgmhigrdgu
    vgdprhgtphhtthhopehlihhnuhigqdhprghrihhstgesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:9zURaSp_qV7OsYBgkhsv76eoLGouggunrtgkNjOuSAAcn8mq6jdpwQ>
    <xmx:9zURaWD0DcWYDUxPjLCr6ftlM4HDE8_UcOr7VQXRzrLzuk3vln0Y_Q>
    <xmx:9zURaXYzLBQYuXMneg1Q8q2PAIqLWOevlTGc2XOpKoDyTXV3Yb7erQ>
    <xmx:9zURaR6A6LRwztruRiHK7ZJqRGqUecr06gBNAJP7UkZlSCqxY7fuAQ>
    <xmx:9zURabw5G9-8usUVdxhyLkMgyuRvaKUj7goZJxwX1tjk1LTQTNy4y9tZ>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Nov 2025 19:46:45 -0500 (EST)
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
    Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org,
    linux-kernel@vger.kernel.org
Message-ID: <3d812c89ecbc6028e3c550c484201f33d763b885.1762735489.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] parisc: Drop linux/kernel.h include from asm/bug.h header
Date: Mon, 10 Nov 2025 11:44:49 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

While working on an unrelated patch series, I needed to include
linux/bug.h from linux/instrumented.h, in order to call WARN_ON_ONCE().

Doing so resulted in the following compiler error on parisc:

In file included from ./include/linux/atomic/atomic-instrumented.h:17,
                 from ./include/linux/atomic.h:82,
                 from ./arch/parisc/include/asm/bitops.h:13,
                 from ./include/linux/bitops.h:67,
                 from ./include/linux/kernel.h:23,
                 from ./arch/parisc/include/asm/bug.h:5,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/page-flags.h:10,
                 from kernel/bounds.c:10:
./include/linux/instrumented.h: In function 'instrument_atomic_alignment_check':
./include/linux/instrumented.h:69:9: error: implicit declaration of function 'WARN_ON_ONCE' [-Werror=implicit-function-declaration]
   69 |         WARN_ON_ONCE((unsigned long)v & (size - 1));
      |         ^~~~~~~~~~~~
cc1: some warnings being treated as errors
make[3]: *** [scripts/Makefile.build:182: kernel/bounds.s] Error 1

The problem is, asm/bug.h indirectly includes atomic-instrumented.h,
which means a new cycle appeared in the graph of #includes. And because
some headers in the cycle can't see all definitions, my new WARN_ON_ONCE()
call appears to be an undeclared function.

This only happens on parisc and it's easy to fix. In the error
message above, linux/kernel.h is included by asm/bug.h, but it's no
longer needed there, so just remove that include.

The comment about needing BUGFLAG_TAINT seems to be incorrect as of
commit 19d436268dde ("debug: Add _ONCE() logic to report_bug()"). Also,
there's a comment in linux/kernel.h which strongly discourages use of
that header.

Compile-tested only.

Acked-by: Helge Deller <deller@gmx.de> # parisc
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/parisc/include/asm/bug.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/parisc/include/asm/bug.h b/arch/parisc/include/asm/bug.h
index 833555f74ffa..dbf65623c513 100644
--- a/arch/parisc/include/asm/bug.h
+++ b/arch/parisc/include/asm/bug.h
@@ -2,8 +2,6 @@
 #ifndef _PARISC_BUG_H
 #define _PARISC_BUG_H
 
-#include <linux/kernel.h>	/* for BUGFLAG_TAINT */
-
 /*
  * Tell the user there is some problem.
  * The offending file and line are encoded in the __bug_table section.
-- 
2.49.1


