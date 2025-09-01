Return-Path: <linux-kernel+bounces-794562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0197B3E35F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051AE16BCE7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA1A326D63;
	Mon,  1 Sep 2025 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v3e2qEXa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aqkk8AIM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA57820C47C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730079; cv=none; b=Ji1plFQS8oSt9zJ7aOpMbvTQ6cZdcnxP83hRFWgDX+ehtaonTH8aZnnlsvwxy337pa6RWpraS9IodesEOWcpp9FmVhSaLhX+j/lEA4f8AE6zr8bvjjY3ZwfEVQPaukZu9Tlylf9NueuYLzwGZKVgJP5M8SG2PLAzoDQupwUkg5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730079; c=relaxed/simple;
	bh=AktEwtLHe7dXjD3OqHqS0kggLfllnUbsXxMSxqdxwFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SJdRzw91r6j/pGEFhZ4O8GBENPxmgdYqZYEX67ymwAFIWR1yBPSTxs0Qg7TeplDcBB/Ugd2sQyb9xnyrDECcK/pOaWgTlX0nZKKY7DRMAx8wajPIELZeFe4Koy5xBDGy4xzfMviLYdnvAiAsG5Bl1zswESSGAHK+E2Ey6AQc0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v3e2qEXa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aqkk8AIM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756730075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=664gQerhLd5Hk2QfN13Hl9ZRcHstMZHAtXpxYIYNCU8=;
	b=v3e2qEXa1lHGp1FVvJ7lzZSRfX40e9VZ19xmBdk8pNuDcAWMX4JzQI1Tx0xhTahI3fyw6X
	IJ3Vrw6uPojNB03b0tqf0ibnwhOEkQ/Ydn2j9z/Xi0VXvlFo0yUSPiPvsq9jm1O7tjZLDD
	7Kfhc4ivmywuPDqgJu/VEQa5UkRk6eCwztwBDsMb07nAUjDx/CuspcgwhPC11drtpjcQEB
	6XrXWNzJbFSsgR0kIyLbNyQoh35VoBVDZDGNWO99QqBY98hBd/1TEDH62bDqoznqWfCGJZ
	1NmPVMlinsN3fRYP9Dxc7K6BO52gx/MShKDb2cQeEGPBlOqOTf6SEvZ/ph9PQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756730075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=664gQerhLd5Hk2QfN13Hl9ZRcHstMZHAtXpxYIYNCU8=;
	b=aqkk8AIMjnLgGD8S2enri1xYtoNWzdmXV8J0RCEcvL+fJAyk3bBW2KXvhgC83n9o894jz6
	3wjBuBX/SnYxUWCQ==
Date: Mon, 01 Sep 2025 14:34:22 +0200
Subject: [PATCH v2 1/3] vdso/datastore: Explicitly prevent remote access to
 timens vvar page
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250901-vdso-mlockall-v2-1-68f5a6f03345@linutronix.de>
References: <20250901-vdso-mlockall-v2-0-68f5a6f03345@linutronix.de>
In-Reply-To: <20250901-vdso-mlockall-v2-0-68f5a6f03345@linutronix.de>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756730069; l=2367;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=AktEwtLHe7dXjD3OqHqS0kggLfllnUbsXxMSxqdxwFQ=;
 b=x2y56gEUObDsxYu00BLgFnfxcvV59AXLBIQ6P/kQPvBvH0fGjlWlsO6BWho/GgW6usS0QiXQV
 ouU8IVldediB1K75JFmpnd/7lcoOW1//gWLCHIVaPZ4IHfxRCLc5QrP
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The fault handler for the timens page does not have access to the target
task and therefore can not be invoked remotely.
Currently the handler relies on the fact that the vvar mapping is marked as
VM_IO and VM_PFNMAP for which the mm core always prevents remote access.
However the VM_IO and VM_PFNMAP flags are going to be removed.

Add an explicit check to prevent remote access to the mapping.

Move the call to find_timens_vvar_page() after the check to avoid hitting
the WARN() in that function.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/time/namespace.c | 7 ++-----
 lib/vdso/datastore.c    | 7 ++++++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 667452768ed3b50e48e3cfb70f8ef68e4bed9e0b..e225547021b73230e3c820cd91635e0483821c49 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -198,11 +198,8 @@ struct page *find_timens_vvar_page(struct vm_area_struct *vma)
 		return current->nsproxy->time_ns->vvar_page;
 
 	/*
-	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
-	 * through interfaces like /proc/$pid/mem or
-	 * process_vm_{readv,writev}() as long as there's no .access()
-	 * in special_mapping_vmops().
-	 * For more details check_vma_flags() and __access_remote_vm()
+	 * vvar_fault() protects this from being called through remote interfaces like
+	 * /proc/$pid/mem or process_vm_{readv,writev}().
 	 */
 
 	WARN(1, "vvar_page accessed remotely");
diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 3693c6caf2c4d41a526613d5fb746cb3a981ea2e..ed1aa3e27b13f8b48d18dad9488e0798f49cb338 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -40,10 +40,15 @@ struct vdso_arch_data *vdso_k_arch_data = &vdso_arch_data_store.data;
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf)
 {
-	struct page *timens_page = find_timens_vvar_page(vma);
+	struct page *timens_page;
 	unsigned long addr, pfn;
 	vm_fault_t err;
 
+	if (unlikely(vmf->flags & FAULT_FLAG_REMOTE))
+		return VM_FAULT_SIGBUS;
+
+	timens_page = find_timens_vvar_page(vma);
+
 	switch (vmf->pgoff) {
 	case VDSO_TIME_PAGE_OFFSET:
 		if (!IS_ENABLED(CONFIG_HAVE_GENERIC_VDSO))

-- 
2.51.0


