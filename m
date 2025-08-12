Return-Path: <linux-kernel+bounces-764092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D912BB21DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99E967A8682
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABCC2E4248;
	Tue, 12 Aug 2025 06:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ozkuieXa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BEdvmHZO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2942E2DC0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754978659; cv=none; b=q+LwtGqIXgKRgLKu6gaxy2JZo1G7UKWYw69/rgibp/oBH2XM4z30TjYrwQmUYqZT7gfR72rQd9xbtXdZIxizkBFmPRVwpo3PWIamFiELYyTU7KCjYRt7a5XHqnrTYV8yQSO6pKFE/lao5KS+vUos8lM6kK1N5X4H0zLDF9HUsG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754978659; c=relaxed/simple;
	bh=YhAVmLob2r3m/TDgX7akXdJLfhPN9FU8OJsenYX+ClQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IPz4HHJjvGJlrCC/xSbIEzjd7bijrOt4qVzxcviDH91kLpTPf80YJkli9w/A4SyZYE4XsgaRQjkdo+VuWSLk1wWeUrG8b2fGnYkeWYpXxCnAtq37zG8FLORep+bvYboAnpjK+1y6vNuD9SjGAd6YroePqCcNImUEa0dulvkgfyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ozkuieXa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BEdvmHZO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754978655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISIgftNVyNNITbUXGBMLzJvMM4NMCZDrcphSDhcrtiE=;
	b=ozkuieXaFtkLvkgCWcvwRbeMQV3oupsNJpWAl7NV+A5BccvhvHMjUyrldR2VhD1tui12yF
	XTaYLCgiaQJzHREODw7577nOMlyOiOnWc9CU59Ra0pB9f/Gf89aCBKu3Mf5uCFdL5tMeQY
	4EG6uNurXo+ovlBWLPrIuOUbkhqOdAssbHArZwIW7+Cw7y0E1/bZDIO6TPkBI8MF83zSHe
	mj3Tsa8KAQ29BWwgb2IPLphPNS8VErucWzDk8jqWyapWSDFDZ4yg/eTAJkartLeNKvM9dB
	jZHER3UwYO5oeDjblFcat/3OOmFUOzXM9blPdH+a7E2gy6tcqRAWgyI/X5nYMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754978655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISIgftNVyNNITbUXGBMLzJvMM4NMCZDrcphSDhcrtiE=;
	b=BEdvmHZODcLauUH+kPEH5DjjMAsdVAW1wibdiUegBCDDW7NZWIinCy59bF9QQT9XlqDgbz
	G0xdKQk3quLrcFCQ==
Date: Tue, 12 Aug 2025 08:04:05 +0200
Subject: [PATCH 3/3] vdso/datastore: Map zero page for unavailable data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-mlockall-v1-3-2f49ba7cf819@linutronix.de>
References: <20250812-vdso-mlockall-v1-0-2f49ba7cf819@linutronix.de>
In-Reply-To: <20250812-vdso-mlockall-v1-0-2f49ba7cf819@linutronix.de>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754978653; l=2181;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=YhAVmLob2r3m/TDgX7akXdJLfhPN9FU8OJsenYX+ClQ=;
 b=rYdb7of0OTPKDWQlwKW5dp17mN0QwqK5uqg+82l0W+jrGor5s5s806iigihsokQYmRdFXPJEG
 PqzQxyqWouRCXa0yPmQOwRHdA38xDUXa0+lIevIDQAoioC1aAw7Dhdl
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
index 9a1af01f1c4db95255dd67b59129791cc39d37c0..32b65b407b985d98b40374d8af6ebd3cbe2ef4fa 100644
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
 		page = nth_page(virt_to_page(vdso_k_arch_data), vmf->pgoff - VDSO_ARCH_PAGES_START);
 		break;
 	default:

-- 
2.50.1


