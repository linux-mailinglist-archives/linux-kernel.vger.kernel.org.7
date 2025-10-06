Return-Path: <linux-kernel+bounces-843464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F6FBBF891
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5061B1885BC2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A632F261574;
	Mon,  6 Oct 2025 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="TVpaynSK"
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A469A932
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759784535; cv=none; b=pYahx+IilI5+CQ+b94EVa12ptBw2VkGwnIPhE/nDAXbRaoanxvJzXg72rrpRZDOBvCqm/qiB10i2GPREgl7Mik0TEZXTs2VBMGbqHtZbcK4gK3e8FuyE79SfjLiVGUWfZbxQVysv0kyKr8xi12Yr91F7z8T/gtQdpQlRCNMgOyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759784535; c=relaxed/simple;
	bh=XvEt6Ubz2SfrZFWCUbgqDrN11uzP1Rb3/SaadQIypF4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oq8oyX9wgVN0rHrxNiZQa0iKOAGS6m03+IYT8fx9uFWgWiFosYYGGEFFaD1gJSRIKO4Bz2dbuLwKDPFQt5+CgQhOhgWRCLCvMfndinFSu6QIDXO1FJNNArdyl6oma5t3fCB4sJjREW2gDNEEPmDmPsOnc5MNkrx8O0sl7DoYu5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=TVpaynSK; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759784533; x=1791320533;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+HGVWrxAkg8mWbnk47FbeDyfZnbZtnHncdoKf7Bqyo8=;
  b=TVpaynSK+F+Ek8TOqLggor3fA7OQpSe7PvUI3kXpaI2rCyY0laIEzsmB
   u+2UL3bXiFS0M/eNaSm3A2K9ChUvLL0BGycH32e/1rMra9TKSJIobB4Vc
   1ayhxx6eKQUjH2eHdwRb/g5tyeg2jhB496FeImxhyWMi1PVkwvc8WC/X9
   /JWyHtS/QRPUCPjvpHYCek72i69UjvDIM4Ny5cc5u5jn/DF8aIcTtTZ1G
   sTmYTPn3eA7rz5l4tE994ItfpBY0uNcctxsP0u2ru3AaHl9Zz1CuYt5nb
   gOezSjD5Xm32Ewx7prKrax32+fgq7kvuUHc5x3SRVf69MupucWtam9/CR
   Q==;
X-CSE-ConnectionGUID: aGfvPIMmT0C9oeSHdw+dWA==
X-CSE-MsgGUID: QwLFr7KzRROBNwjrgm9I+A==
X-IronPort-AV: E=Sophos;i="6.18,320,1751241600"; 
   d="scan'208";a="4213438"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 21:02:12 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:54205]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.71:2525] with esmtp (Farcaster)
 id 6d952f63-38db-4a53-b686-451eb39197c1; Mon, 6 Oct 2025 21:02:12 +0000 (UTC)
X-Farcaster-Flow-ID: 6d952f63-38db-4a53-b686-451eb39197c1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 6 Oct 2025 21:02:12 +0000
Received: from 80a9970eed1e.amazon.com (10.106.101.23) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 6 Oct 2025 21:02:11 +0000
From: Justinien Bouron <jbouron@amazon.com>
To: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek
	<pmladek@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, "John
 Ogness" <john.ogness@linutronix.de>, Marcos Paulo de Souza
	<mpdesouza@suse.com>, Alexander Graf <graf@amazon.com>, Yan Zhao
	<yan.y.zhao@intel.com>, Joel Granados <joel.granados@kernel.org>, Steven Chen
	<chenste@linux.microsoft.com>, Justinien Bouron <jbouron@amazon.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: [PATCH v2 RESEND] kexec_core: Remove superfluous page offset handling in segment loading
Date: Mon, 6 Oct 2025 14:02:05 -0700
Message-ID: <20251006210205.72059-1-jbouron@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
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


