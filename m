Return-Path: <linux-kernel+bounces-764090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E0AB21DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDAE1889480
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C8B2E2DE4;
	Tue, 12 Aug 2025 06:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aHvFf4Yl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6FzP3Bck"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8442E11BF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754978657; cv=none; b=p2dM6zWc1f/I2Tw8mrbsJxCslKuH2AF+0ND8S63sa0gYIBzpAtXFX8uCpmsaoSDT75rYpjOmXEQPLgZVtOVp6kgihVErsSa1ZtS7CXZavT3vqRfI2J/yPKWSPjzmtje1W730+l/1Uc/v+ZtRly8E9XngSR+kdwXU7+AB4JtoOAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754978657; c=relaxed/simple;
	bh=F4c2RtrLgfxY8WVt3OaY1o0yZJL+GJ7wPZPEm2SM7ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YyRBhlIEMfqQjdn75OVsRzmg5YLrijV7gd79hllxoeF39uOD4R5+xZYpNZb88pl6LYrYPfSN0ocJgEZ0NYghFMZyjEPY7mFf011JVot4wWTfDVlMT9oNNUvOQORQlhlEs5B8PRsa51X6EPISWcjsAMBYEKGRNZHGfYHpWvysiR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aHvFf4Yl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6FzP3Bck; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754978654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BoFYp3/nAMH+ixxD2t0VNLuyUFKS/Uzah6o0Jl1bck=;
	b=aHvFf4Ylm1RNilOxUVR6vG04ZVR2tc12wymkTjPgPQESodt32vnXjpGeDkzIEvqaQOnNGI
	Zb/HlxglYluJWdupCHJwhoDfucTLj0muhfwrDQpZU+Id0ZYTfIRqxK4qNpRNeUQvgz/ibp
	NhZXaQr49H2O6gcrD2Y3bqB+SCWdm/3RhrVwnSyRecaiLZ6adLl5GBO+IhNvKq47F2Toc5
	nlmujIINfmMfxRPBB/DQwo1q3ArcRVjk7yz64I9rXjPM0ucZ/YjdHW6rzHxVb7w52WYcY2
	0+uHMlpHVcajfHVtA7oG92GUQqtrF2d9MdeCV/Qk4VMG8AuVIg8EeyJvRXGSww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754978654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BoFYp3/nAMH+ixxD2t0VNLuyUFKS/Uzah6o0Jl1bck=;
	b=6FzP3BckI+GcO+EKU6ejSg9XooL5Q8QwUzw3N5MfAmwQLg3NN8qGSweUyJtJVHTCk01b/S
	0E76NLdgVFUk2rBQ==
Date: Tue, 12 Aug 2025 08:04:04 +0200
Subject: [PATCH 2/3] vdso/datastore: Allow prefaulting by mlockall()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-mlockall-v1-2-2f49ba7cf819@linutronix.de>
References: <20250812-vdso-mlockall-v1-0-2f49ba7cf819@linutronix.de>
In-Reply-To: <20250812-vdso-mlockall-v1-0-2f49ba7cf819@linutronix.de>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754978653; l=4076;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=F4c2RtrLgfxY8WVt3OaY1o0yZJL+GJ7wPZPEm2SM7ws=;
 b=VKuUFSsfBhEGjYbfGFRXla2fgYp6pnaviA1WyEgaAl9QqiKNOMI8JQSAf7UmSSMqCHCxML5C9
 NzABalqx3FyCYDh7iqQ21ifcpAC6Q1HSB9rDKwKLzhKJEVG7JnxIX0S
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

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Nam Cao <namcao@linutronix.de>
---
 lib/vdso/datastore.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index ed1aa3e27b13f8b48d18dad9488e0798f49cb338..9a1af01f1c4db95255dd67b59129791cc39d37c0 100644
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
+		page = nth_page(virt_to_page(vdso_k_arch_data), vmf->pgoff - VDSO_ARCH_PAGES_START);
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
2.50.1


