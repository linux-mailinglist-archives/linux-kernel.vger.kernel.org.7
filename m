Return-Path: <linux-kernel+bounces-836522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FBDBA9EC2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8303D7A49F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2FC2FAC12;
	Mon, 29 Sep 2025 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="SNuUDXQa"
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86B430BBAB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161750; cv=none; b=Ikd7Oa0GNXInYarX5cmmD+dmkGdrboD7NVkii3rIfqpjOIguvlAUumkF18iaI9wyjoKKf7otYS6I2EDNXuaZUx7Cmujmbziwthu7ahOca9tl3MyqqMfz9BGonW10N4ArDXRm/VIAfw42lRJBLnlYdFoUHYBUxe4qyjKKEuBm4ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161750; c=relaxed/simple;
	bh=XvEt6Ubz2SfrZFWCUbgqDrN11uzP1Rb3/SaadQIypF4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kgVMb43EW4zPPiLD4/V9T0YKLr3JzY0Si2nSTdsizYrPcqGlFBTPKSpDqHVGtkAcmq4ziwXRED/x5Z44I7k0C+QOWTB93DrfBMCcdwuP877o3EMtqHBnc2O5D5q3mrb0dbGJQG8j/uRoAIqd17zXqiX+wAmxHeV/yZjPsCMbcdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=SNuUDXQa; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759161748; x=1790697748;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+HGVWrxAkg8mWbnk47FbeDyfZnbZtnHncdoKf7Bqyo8=;
  b=SNuUDXQaVwuXW89Pw0JZAZesXDqNUoLYxCRnnQimKDwuuNAipW2A8os6
   4hxodHLcJSRURNwnj5JKt0Ij799WrQSH8ocGVJeSzaxIizAnV2CBoiLRu
   SPBgoX0HxxlRO0RT4eSBlQTCz8YI9iRmOwbBdB8Ukx6zuOKghRSFFgS1u
   XUUZIWLmNCXiIhVhZJioRGmzoo7PhpmhTaIyv8dzfwLCTmzkOeiiC1EnY
   ZwCsZ2tFFIZNyDAIpU+lSN4iQ2oHtRyPFsNwk4+pM8tMDLHuIpNKwf6Ls
   cvTrCZKBmQWorD+vYhPrKY9359pCCDHbfZ5OFG8C4hMtTz7KATXqCWnB0
   A==;
X-CSE-ConnectionGUID: wht2y+cZTZ6YFWGEG+eDNg==
X-CSE-MsgGUID: ZdV6+l7yTYCL+RXgXoKoxw==
X-IronPort-AV: E=Sophos;i="6.18,301,1751241600"; 
   d="scan'208";a="3752301"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 16:02:28 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:32049]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.1:2525] with esmtp (Farcaster)
 id de35df7c-9f59-4666-a8ad-e44850f84128; Mon, 29 Sep 2025 16:02:28 +0000 (UTC)
X-Farcaster-Flow-ID: de35df7c-9f59-4666-a8ad-e44850f84128
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 29 Sep 2025 16:02:27 +0000
Received: from 80a9970eed1e.amazon.com (10.187.171.30) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 29 Sep 2025 16:02:26 +0000
From: Justinien Bouron <jbouron@amazon.com>
To: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek
	<pmladek@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, "Marcos
 Paulo de Souza" <mpdesouza@suse.com>, Yan Zhao <yan.y.zhao@intel.com>,
	Justinien Bouron <jbouron@amazon.com>, Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: [PATCH v2] kexec_core: Remove superfluous page offset handling in segment loading
Date: Mon, 29 Sep 2025 09:02:20 -0700
Message-ID: <20250929160220.47616-1-jbouron@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

During kexec_segment loading, when copying the content of the segment
(i.e. kexec_segment::kbuf or kexec_segment::buf) to its associated
pages, kimage_load_{cma,normal,crash}_segment handle the case where the
physical address of the segment is not page aligned, e.g. in
kimage_load_normal_segment:
```
	page = kimage_alloc_page(image, GFP_HIGHUSER, maddr);
	// ...
	ptr = kmap_local_page(page);
	// ...
	ptr += maddr & ~PAGE_MASK;
	mchunk = min_t(size_t, mbytes,
		PAGE_SIZE - (maddr & ~PAGE_MASK));
	// ^^^^ Non page-aligned segments handled here ^^^
	// ...
	if (image->file_mode)
		memcpy(ptr, kbuf, uchunk);
	else
		result = copy_from_user(ptr, buf, uchunk);
```
(similar logic is present in kimage_load_{cma,crash}_segment).

This is actually not needed because, prior to their loading, all
kexec_segments first go through a vetting step in
`sanity_check_segment_list`, which rejects any segment that is not
page-aligned:
```
	for (i = 0; i < nr_segments; i++) {
		unsigned long mstart, mend;
		mstart = image->segment[i].mem;
		mend   = mstart + image->segment[i].memsz;
		// ...
		if ((mstart & ~PAGE_MASK) || (mend & ~PAGE_MASK))
			return -EADDRNOTAVAIL;
		// ...
	}
```
In case `sanity_check_segment_list` finds a non-page aligned the whole
kexec load is aborted and no segment is loaded.

This means that `kimage_load_{cma,normal,crash}_segment` never actually
have to handle non page-aligned segments and `(maddr & ~PAGE_MASK) == 0`
is always true no matter if the segment is coming from a file (i.e.
`kexec_file_load` syscall), from a user-space buffer (i.e. `kexec_load`
syscall) or created by the kernel through `kexec_add_buffer`. In the
latter case, `kexec_add_buffer` actually enforces the page alignment:
```
	/* Ensure minimum alignment needed for segments. */
	kbuf->memsz = ALIGN(kbuf->memsz, PAGE_SIZE);
	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
```

Signed-off-by: Justinien Bouron <jbouron@amazon.com>
Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
---
Changes since v1:
	- Reworked commit message as requested by Baoquan He
	  <bhe@redhat.com>
	- Removed accidental whitespace change
	- v1 Link: https://lore.kernel.org/lkml/20250910163116.49148-1-jbouron@amazon.com/
---
 kernel/kexec_core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 31203f0bacaf..3b279d9e0d01 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -761,9 +761,7 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
 	while (mbytes) {
 		size_t uchunk, mchunk;
 
-		ptr += maddr & ~PAGE_MASK;
-		mchunk = min_t(size_t, mbytes,
-				PAGE_SIZE - (maddr & ~PAGE_MASK));
+		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
 		uchunk = min(ubytes, mchunk);
 
 		if (uchunk) {
@@ -840,9 +838,7 @@ static int kimage_load_normal_segment(struct kimage *image, int idx)
 		ptr = kmap_local_page(page);
 		/* Start with a clear page */
 		clear_page(ptr);
-		ptr += maddr & ~PAGE_MASK;
-		mchunk = min_t(size_t, mbytes,
-				PAGE_SIZE - (maddr & ~PAGE_MASK));
+		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
 		uchunk = min(ubytes, mchunk);
 
 		if (uchunk) {
@@ -905,9 +901,7 @@ static int kimage_load_crash_segment(struct kimage *image, int idx)
 		}
 		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
 		ptr = kmap_local_page(page);
-		ptr += maddr & ~PAGE_MASK;
-		mchunk = min_t(size_t, mbytes,
-				PAGE_SIZE - (maddr & ~PAGE_MASK));
+		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
 		uchunk = min(ubytes, mchunk);
 		if (mchunk > uchunk) {
 			/* Zero the trailing part of the page */
-- 
2.43.0


