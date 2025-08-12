Return-Path: <linux-kernel+bounces-764091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DD3B21DED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C963B4422
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FC52E2DDF;
	Tue, 12 Aug 2025 06:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tU0Y4+Md";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3be0Ykmb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8B82E172D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754978658; cv=none; b=ZZhm9elWqk8b6rShU6xAYqgjlBUpJ3ImJVIK2EczHp78KfYuayippJpVe/+y8+AF+yiRfJDI37IIdrtwGdC3JNno/Kn7XgnbGFNjUhFGQl7D6hgmBDB+R7+QVVOjGDecp8+NGDGy3hhEevbLA1tfTGNhBsGuCUFeALm8VQdsgqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754978658; c=relaxed/simple;
	bh=D0IzAfqgShPNK81hQ1qUaUOduUDu0f9dl2cjMrjUGg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lzInQH3fONH+tfugDiE7IIDdlmiKQUcPDqGDJQ3vq5z+SvqujRo1UV27samztIW5KXY9Ex6hHYalaWcW45GhEfh88bQRO8UGzktEXBTTQ1RNbnl0rjFCQblE6lHJhG7UPyQdmFJ8RtYCppoNEAtL8hJn2m4jLuUI/3ApUTpt7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tU0Y4+Md; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3be0Ykmb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754978654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALJaNJ8540HEYWlpNQvd+ayXDrF9e8M8cKhQ2Rmv6S4=;
	b=tU0Y4+MdjHGZWtBJArfZUlD7hg3pXwl+sC5Cf9d2ar+llmpzQQYLwpd3HVj4FY/gWiJVOC
	gRjSo6sPvrPFFu2lz+V8U6+xzwrzw5hRrt+6Nk/7db1oNbIn3EtAnUOImSCYyGRbBFKFuc
	PbBMXbqkvnFmR1k8bmKERLW7fyFckmbc92WFzEsrxjmXj9CaAJVb0Dn3MFiLwiOaJMq2Aw
	UkTvTvlypLKB0jrw+7zfEI8Y/X6dLz0a2HOnkq9XlMxJHVcdo3Ejdz77L7SXbzdqHeJ5++
	qiogfjoFmHaJeCAGjUYuERW+OG29ue6FsN2ByL9Ya9bgxPdzna8KuMM+d3SvHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754978654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALJaNJ8540HEYWlpNQvd+ayXDrF9e8M8cKhQ2Rmv6S4=;
	b=3be0YkmbbqT9gNyF5AEvkulG5jybVz21JBx0lvcowrAT9BfHYTu2ty3hmNt9lQabStfE/6
	XzIm9SOHnRa6k8Aw==
Date: Tue, 12 Aug 2025 08:04:03 +0200
Subject: [PATCH 1/3] vdso/datastore: Explicitly prevent remote access to
 timens vvar page
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-mlockall-v1-1-2f49ba7cf819@linutronix.de>
References: <20250812-vdso-mlockall-v1-0-2f49ba7cf819@linutronix.de>
In-Reply-To: <20250812-vdso-mlockall-v1-0-2f49ba7cf819@linutronix.de>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754978653; l=2367;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=D0IzAfqgShPNK81hQ1qUaUOduUDu0f9dl2cjMrjUGg8=;
 b=u5/9pw939fgynkuKPF9SWlMTiIy5+Rhf7YuluSIgzyyLF1LPFbvbumERddIMfiHrjvUNVFMXt
 wNLB/B9Nh3IDktiGc7AZHXciZ5RgRojDpHTBzDQuVRjhp6yepUXa46g
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
2.50.1


