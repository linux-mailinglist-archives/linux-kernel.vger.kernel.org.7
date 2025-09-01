Return-Path: <linux-kernel+bounces-794564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F84DB3E352
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C161A83789
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F0A33473F;
	Mon,  1 Sep 2025 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L4820MGb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jwtr5WD/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805BE2EE60A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730080; cv=none; b=tFUTanxIMl1LwgK7jkBXoOWDakrYz5DADldNJduiM2w3dx6b7V9MspmdwIc9yqm/r4GFk8Zsh1/souI67m/GmcFPOywhdMl9k7hN+Z+ndM41Dufpa0FXVEwLE8birGsH2xS0dKU52f0ymis13+A+wlCOcbCJucl2eeWFLVzI1+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730080; c=relaxed/simple;
	bh=KgmRXr8eTNBbNSGItv2vwvS8zIsxpkPNuXrWN6GBfPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J8IcV1NTzYb/3RfHFzBUSbdTW7+iR/WAN6Eejor1pz8iafqg6TjvgOC+1sg3GqnStMm1YDn6L0G8ht1jAUIJ7aFEnIJno9gwbN62hIpIYOCNZxXc6RjSdTNj62hSJXTXJjgn7Lf6hLKutfessXy4+0qHSGyONVxBUAkBdhAkKDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L4820MGb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jwtr5WD/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756730076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLXN0Ug7/Fbpvs+OH36pHZYk1tM/rWA4HaY8KaBRXA8=;
	b=L4820MGbboZjRU7p5VYVDVF0M3YNMBEmjlHtLCd33rAnEgEtIfQNzeAEDV9XlEjUPSkUo4
	hnKY4lcXU5Xz6vyYPW3RupltKJ/HwOMft58youefOWuozV4UyNfciKjisgvgUQj4F8cR8B
	+Fv4+5GMpRCWCIwzexKRym5sbBhJ7MBI857Mlt7giy1/SaqDzqkq+A36eSn31JmYIeEzwL
	Su3mhuJyBmdH+O3j3eNGFGFGWXlHIWAmkeI+uimmoTdxJ7sekG4FA34IOdwV5zyL4rQbW5
	7oapP9PjQ53N+ZZbmBjgL+dGVVHW8/c7Lzd34vr3TS64xNyR1nqEI93ieBR5fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756730076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLXN0Ug7/Fbpvs+OH36pHZYk1tM/rWA4HaY8KaBRXA8=;
	b=Jwtr5WD/oeLTg+IBGHvZZZgHKjU/aUeOoZcdRpF+bYyTkPNCDmHzK2YapEm2nnLNFDy6ds
	Ic+idPRkW9V4Q8Ag==
Date: Mon, 01 Sep 2025 14:34:24 +0200
Subject: [PATCH v2 3/3] vdso/datastore: Map zero page for unavailable data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250901-vdso-mlockall-v2-3-68f5a6f03345@linutronix.de>
References: <20250901-vdso-mlockall-v2-0-68f5a6f03345@linutronix.de>
In-Reply-To: <20250901-vdso-mlockall-v2-0-68f5a6f03345@linutronix.de>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756730069; l=2172;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=KgmRXr8eTNBbNSGItv2vwvS8zIsxpkPNuXrWN6GBfPg=;
 b=ChEMS7suOrbGHjxdsNd1FrdITfrSRcpc6sQTgufN1Pd/3HiYd7dlaLzUcQBraq4yah+Z8Vf6R
 sX56GXwwlu6C8PTDlwMt7TONJ0xsDoHo1kL8+iyB5LQ9tsoU2EevJKW
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

mlockall() stops if a page in a VMA is unmappable. As the datastore VMA can
contain holes, mlockall() does not process all data pages correctly.

Replace the mapping error VM_FAULT_SIGBUS with a mapping of the zero page.
The vDSO will not access these pages in any case and for other userspace
these pages have undefined contents.
This will allow mlockall() to process all pages within the VMA.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/datastore.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 00714c0cf0b24b813bf5b28ff8a19e5f246fce45..f9e37195c2af43c7b2c4b02d01be492d84223ecd 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -40,7 +40,7 @@ struct vdso_arch_data *vdso_k_arch_data = &vdso_arch_data_store.data;
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf)
 {
-	struct page *page, *timens_page;
+	struct page *page = ZERO_PAGE(0), *timens_page;
 	unsigned long addr;
 	vm_fault_t err;
 
@@ -52,7 +52,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 	switch (vmf->pgoff) {
 	case VDSO_TIME_PAGE_OFFSET:
 		if (!IS_ENABLED(CONFIG_HAVE_GENERIC_VDSO))
-			return VM_FAULT_SIGBUS;
+			break;
 		page = virt_to_page(vdso_k_time_data);
 		if (timens_page) {
 			/*
@@ -75,17 +75,17 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		 * See also the comment near timens_setup_vdso_data().
 		 */
 		if (!IS_ENABLED(CONFIG_TIME_NS) || !timens_page)
-			return VM_FAULT_SIGBUS;
+			break;
 		page = virt_to_page(vdso_k_time_data);
 		break;
 	case VDSO_RNG_PAGE_OFFSET:
 		if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
-			return VM_FAULT_SIGBUS;
+			break;
 		page = virt_to_page(vdso_k_rng_data);
 		break;
 	case VDSO_ARCH_PAGES_START ... VDSO_ARCH_PAGES_END:
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_VDSO_ARCH_DATA))
-			return VM_FAULT_SIGBUS;
+			break;
 		page = virt_to_page(vdso_k_arch_data) + vmf->pgoff - VDSO_ARCH_PAGES_START;
 		break;
 	default:

-- 
2.51.0


