Return-Path: <linux-kernel+bounces-794563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A57B3E360
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C9516CD60
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38987327782;
	Mon,  1 Sep 2025 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p2Dn6AZV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f6wmqjIh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5EA26CE21
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730079; cv=none; b=EF8rd+eqqSXbO6kteQDj8Ym8+qW+1PkiCV88HLCMEk6OBwF2qctICheJ+Ke1GJO4fLUSdH5tqn5pjGOMWIfr8N8TAJ2NElZxv5MkB0Tx7P9A4nEFTQQJhDi2xW2Ps4Eq7oTKFqjpceAd27IY5VBpUynMOESfO0uy0aKjGNvNpH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730079; c=relaxed/simple;
	bh=2Z2Yf2jDLYoL0s7wWG7QZHD1EkbeUblgxlFw9/asD14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=clTvlKEWJcajQ0jYu+dSBDgbwEECv5MiMlDYSnwiEfclIlcrDpZ3q9c9np6Z9DD9hh+XEAqDouo23V1ln81VYf3FdFe3ONFAQ19PO6vtFdE6Fl1BlgA3/f+k8o0syrw4kkl4PqvdWudqcKuj3RAgGEQWGWGh+MMUdUOQAUGmUJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p2Dn6AZV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f6wmqjIh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756730076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvnBFUYJVcZhyzM1/4HJ06q2UGLo2W1V/cNJfNZMj1A=;
	b=p2Dn6AZV60rxrMSrLO0RRHHMoRZONaaRuJvv4ivlSZz1FADREzFYlwjvnSbwpXml2bjs0p
	veADOOORfNIkyvl/8e+9yqHE4X2n11Gihj2e0efLYaV5Y1/zi0sVYn34GewIW5C3HbbF/1
	Zr6z6Y91FxGdeSEMlJ8ZnCrCriDc37xlDefip/S4luR1VwjjDU1rPOcodO1qHbJc5Zk2oh
	rKnMsVf2yiOCdb4CmQEQUkWeWnzsT7h/KgeWh1CY4bOsDnVREmjKSfRE7wYyHjpYXqlnZY
	OGLv3GivA654utie9rz8U8dChzWT6k49QnToUq3wfui4GPYlmG00oIcggflnkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756730076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvnBFUYJVcZhyzM1/4HJ06q2UGLo2W1V/cNJfNZMj1A=;
	b=f6wmqjIhGy98adGOvFfTCJnRt4YLGyXAZa4zGGlt6WUGuzWGHGrHpupQ9CirE4gQn4ct/n
	5Y0S/f09hdrFpDCg==
Date: Mon, 01 Sep 2025 14:34:23 +0200
Subject: [PATCH v2 2/3] vdso/datastore: Allow prefaulting by mlockall()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250901-vdso-mlockall-v2-2-68f5a6f03345@linutronix.de>
References: <20250901-vdso-mlockall-v2-0-68f5a6f03345@linutronix.de>
In-Reply-To: <20250901-vdso-mlockall-v2-0-68f5a6f03345@linutronix.de>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756730069; l=4112;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=2Z2Yf2jDLYoL0s7wWG7QZHD1EkbeUblgxlFw9/asD14=;
 b=gX/BDPsYpmhqdLCoF4/B8x+IbRsqmpIKwvKEsT0SBsMCwe3+Oi2W0Tnsy+QSIfb66b5Cg9sXl
 bkjcsjC9+SbDpk7JB/08o/UgJA7obSZ/2NB5L+lVFb+2yaVWwk7QXYk
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Latency-sensitive applications expect not to experience any pagefaults
after calling mlockall(). However mlockall() ignores VM_PFNMAP and VM_IO
mappings, both of which are used by the generic vDSO datastore.
While the fault handler itself is very fast, going through the full
pagefault exception handling is much slower, on the order of 20us in a
test machine.

Since the memory behind the datastore mappings is always present and
accessible it is not necessary to use VM_IO for them.
VM_PFNMAP can be removed by mapping the pages through 'struct page' instead
of PFNs. VM_MIXEDMAP is necessary to call vmf_insert_page() in the timens
optimization path.

The data page mapping is now also aligned with the architecture-specific
code pages. Some architecture-specific data pages, like the x86 VCLOCK
pages, continue to use VM_IO as they are not always mappable.

Regular mlock() would also work, but userspace does not know the boundaries
of the vDSO.

Reported-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Nam Cao <namcao@linutronix.de>
---
 lib/vdso/datastore.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index ed1aa3e27b13f8b48d18dad9488e0798f49cb338..00714c0cf0b24b813bf5b28ff8a19e5f246fce45 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -40,8 +40,8 @@ struct vdso_arch_data *vdso_k_arch_data = &vdso_arch_data_store.data;
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf)
 {
-	struct page *timens_page;
-	unsigned long addr, pfn;
+	struct page *page, *timens_page;
+	unsigned long addr;
 	vm_fault_t err;
 
 	if (unlikely(vmf->flags & FAULT_FLAG_REMOTE))
@@ -53,17 +53,17 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 	case VDSO_TIME_PAGE_OFFSET:
 		if (!IS_ENABLED(CONFIG_HAVE_GENERIC_VDSO))
 			return VM_FAULT_SIGBUS;
-		pfn = __phys_to_pfn(__pa_symbol(vdso_k_time_data));
+		page = virt_to_page(vdso_k_time_data);
 		if (timens_page) {
 			/*
 			 * Fault in VVAR page too, since it will be accessed
 			 * to get clock data anyway.
 			 */
 			addr = vmf->address + VDSO_TIMENS_PAGE_OFFSET * PAGE_SIZE;
-			err = vmf_insert_pfn(vma, addr, pfn);
+			err = vmf_insert_page(vma, addr, page);
 			if (unlikely(err & VM_FAULT_ERROR))
 				return err;
-			pfn = page_to_pfn(timens_page);
+			page = timens_page;
 		}
 		break;
 	case VDSO_TIMENS_PAGE_OFFSET:
@@ -76,24 +76,25 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		 */
 		if (!IS_ENABLED(CONFIG_TIME_NS) || !timens_page)
 			return VM_FAULT_SIGBUS;
-		pfn = __phys_to_pfn(__pa_symbol(vdso_k_time_data));
+		page = virt_to_page(vdso_k_time_data);
 		break;
 	case VDSO_RNG_PAGE_OFFSET:
 		if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
 			return VM_FAULT_SIGBUS;
-		pfn = __phys_to_pfn(__pa_symbol(vdso_k_rng_data));
+		page = virt_to_page(vdso_k_rng_data);
 		break;
 	case VDSO_ARCH_PAGES_START ... VDSO_ARCH_PAGES_END:
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_VDSO_ARCH_DATA))
 			return VM_FAULT_SIGBUS;
-		pfn = __phys_to_pfn(__pa_symbol(vdso_k_arch_data)) +
-			vmf->pgoff - VDSO_ARCH_PAGES_START;
+		page = virt_to_page(vdso_k_arch_data) + vmf->pgoff - VDSO_ARCH_PAGES_START;
 		break;
 	default:
 		return VM_FAULT_SIGBUS;
 	}
 
-	return vmf_insert_pfn(vma, vmf->address, pfn);
+	get_page(page);
+	vmf->page = page;
+	return 0;
 }
 
 const struct vm_special_mapping vdso_vvar_mapping = {
@@ -104,8 +105,8 @@ const struct vm_special_mapping vdso_vvar_mapping = {
 struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, unsigned long addr)
 {
 	return _install_special_mapping(mm, addr, VDSO_NR_PAGES * PAGE_SIZE,
-					VM_READ | VM_MAYREAD | VM_IO | VM_DONTDUMP |
-					VM_PFNMAP | VM_SEALED_SYSMAP,
+					VM_READ | VM_MAYREAD | VM_DONTDUMP |
+					VM_MIXEDMAP | VM_SEALED_SYSMAP,
 					&vdso_vvar_mapping);
 }
 

-- 
2.51.0


