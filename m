Return-Path: <linux-kernel+bounces-793170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D864EB3CF8D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 23:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856F55E6A28
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 21:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B08225783D;
	Sat, 30 Aug 2025 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JgmI7K6j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8iAksP9M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C02566F7
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756589897; cv=none; b=ZV1vhzdlUkfaKaIixU0PZfjPhM80RHYkT7MuzGWH2LnHlwdypVuTnHn+e1s1CHkpzkgeBMolrbLhEv2eOzITTEBRZMLUHt/VHSVsaJb9ujR+AAh0CNcFh7tRrM6STipHBNtaQYjoZVasJMxyppNK2rFk2I0ggLhJGLEDuy0RaqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756589897; c=relaxed/simple;
	bh=7kzqK7PmyjxG5yzBZw0mF+Kmt0/f+mV6b8DzkYEAIT4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=shhGcze+TURIvNI4bt0pA/j5T4m7MsCRhyRpkPFBmaxrmNf5Kn1KJ5uqzINgjLuI+v82NZsPOWp6d63GNiUlgceKLBEGmL1kFooRc8XwLRhQo0o+1tD+xXsKf724gU/zqhxwcpAbeBH+Y/Ok43iJ3js0Lhj8+9lCLTRer9RA6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JgmI7K6j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8iAksP9M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 30 Aug 2025 23:38:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756589887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=LXkSXqF4PO5z0LWGF0KtrHN7htl9nCB6Mg4k4eq2xEU=;
	b=JgmI7K6jfg1iJ/0wcMVi+cfec6WY2YeAj4VyPQ7NTd68lP+4Zr7ZzAGsB2nARLjFiUSUO+
	fgXahUKfAuZUzNzU2oU0tF6+7J0520rwka54O/izJjGtHLchV8t3Tt0p/WMjEEhy/o0DjQ
	jslUK2y3l7Qpg46Bl1Egncvjen9OIWkglJ5b+T7yVkb41PDGcudzRP49MW/eC+30FcbzcY
	2pPWGCqShuh7EFXzQcq1GJyZbvV8pHdghRgqPQkQLd5zXq+esrWiJ3iZ3bgiFIdvWiINT0
	XgxAOoUdDJf6Ct4jZy66AhRQ/QMgTh7BiKZcXSPPpL6KdgsgfqTxtrBTBxFR9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756589887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=LXkSXqF4PO5z0LWGF0KtrHN7htl9nCB6Mg4k4eq2xEU=;
	b=8iAksP9M9USxIP/DCjRXfaC/SbxPIC/xxPuxDbpeSjBzr8/0h7kvFwmaloVw+2fsmKmOSn
	OQ5vNDK78WIYhvBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] futex: Initialize mm_struct::futex_ref on mm_init()
Message-ID: <20250830213806.sEKuuGSm@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

mm_struct::futex_ref needs to be set to NULL during mm_init() to ensure
that it is not copied during fork(). Reusing the previous pointer can
lead to use-after-free which can trigger

| WARNING: kernel/futex/core.c:1604 at futex_ref_rcu+0xe1/0xf0, CPU#2: swapper/2/0

Initialize mm_struct::futex_ref on mm_init().

Fixes: 1b708b38414d3 ("futex: Move futex_hash_free() back to __mmput()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index fb63c13aa66fc..125804fbb5cb1 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1722,6 +1722,7 @@ int futex_mm_init(struct mm_struct *mm)
 	RCU_INIT_POINTER(mm->futex_phash, NULL);
 	mm->futex_phash_new = NULL;
 	/* futex-ref */
+	mm->futex_ref = NULL;
 	atomic_long_set(&mm->futex_atomic, 0);
 	mm->futex_batches = get_state_synchronize_rcu();
 	return 0;
-- 
2.51.0


