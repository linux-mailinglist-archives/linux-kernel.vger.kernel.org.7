Return-Path: <linux-kernel+bounces-810678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2086BB51DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 576D17B5AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF98242935;
	Wed, 10 Sep 2025 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Say0G9DA"
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFA31459F6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521886; cv=none; b=MicrEQaLxnw1m/KMaOovNBTXOxLlzc8pfnt+cPc4fHvGtGEWuRy/1oNVq43tKwHooJPYMt4Mzec9XlOg9ljapXoIBG9Msr4qA2TnnmKXwmf+GeALRxyzQtF2dNzyMLgt2pFAKNBsjxUMcL1wCjFyq2/Wf2JpYIIRzcTWje1xFaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521886; c=relaxed/simple;
	bh=l131YWzWK5bU+fUSajucDC6Cousg2qnil2n4OuWdDSs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rDLDV0HsYXGkoiKh5HQv3s38fC9sREI2Kc+NHEkg97DqjptW90upjNaIqKrTd3invur98drdq9lPW3KFXeJuOUn/D8wfdsgiIBgxS3CrTg0a+Dlp/8GLiK8hY1USsQuCqBN2nmwtdhKKsSP+h39pAEgnzj6fGumkUasLpHfRxxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Say0G9DA; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757521885; x=1789057885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KrTGWU5jgNL2Yex8GuGQCQTTzsuf4kgKWTk1ruEDz8Q=;
  b=Say0G9DAecqNSrfyGvEXhu3Cx746Rfnj+qcu9BkALlpYRrrqaB1ejPXF
   6dw5K9PTU09N/d9513WJi92F0qmrk4JSNlLDkSBy4UNNn/a5E1PJzKwa4
   KXuUY86/bu7qlDcX4C04ClfsKTmQqpmn5STOiF92IqcOWbOwaDqNiWMAS
   o+xd8Vb8lIlY6tq+UhEbjnPp3AqLp6sqcUu3xeuReSh51ItSJxUsCTt4X
   4yDrNMy13j1gTsRwy2Dn05jRmx8CMIONl/2HDIUze92lAzVTdxeVJRP9J
   wZNupfzIshXaAMwrqBTbscHNoYkmQ8Xt7ndhmqJDvSVPSz59NNEy6Ny98
   g==;
X-CSE-ConnectionGUID: h9F3vohiSnSI31kY0ffszA==
X-CSE-MsgGUID: BLs8tLXxSh+45GlVNn7aoA==
X-IronPort-AV: E=Sophos;i="6.18,254,1751241600"; 
   d="scan'208";a="2659304"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 16:31:24 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:32617]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.248:2525] with esmtp (Farcaster)
 id 03010344-ed65-4286-b33c-177a1cba4abf; Wed, 10 Sep 2025 16:31:24 +0000 (UTC)
X-Farcaster-Flow-ID: 03010344-ed65-4286-b33c-177a1cba4abf
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 10 Sep 2025 16:31:23 +0000
Received: from 80a9970eed1e.amazon.com (10.106.101.45) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 10 Sep 2025 16:31:23 +0000
From: Justinien Bouron <jbouron@amazon.com>
To: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek
	<pmladek@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, "Marcos
 Paulo de Souza" <mpdesouza@suse.com>, Alexander Graf <graf@amazon.com>,
	Justinien Bouron <jbouron@amazon.com>, Steven Chen
	<chenste@linux.microsoft.com>, Yan Zhao <yan.y.zhao@intel.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: [PATCH] kexec_core: Remove superfluous page offset handling in segment loading
Date: Wed, 10 Sep 2025 09:31:16 -0700
Message-ID: <20250910163116.49148-1-jbouron@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Kexec does not accept segments for which the destination address is not
page aligned. Therefore there is no need for page offset handling when
loading segments.

Signed-off-by: Justinien Bouron <jbouron@amazon.com>
Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
---
 kernel/kexec_core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 31203f0bacaf..7d4c9eebea79 100644
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
@@ -815,6 +813,7 @@ static int kimage_load_normal_segment(struct kimage *image, int idx)
 	mbytes = segment->memsz;
 	maddr = segment->mem;
 
+
 	if (image->segment_cma[idx])
 		return kimage_load_cma_segment(image, idx);
 
@@ -840,9 +839,7 @@ static int kimage_load_normal_segment(struct kimage *image, int idx)
 		ptr = kmap_local_page(page);
 		/* Start with a clear page */
 		clear_page(ptr);
-		ptr += maddr & ~PAGE_MASK;
-		mchunk = min_t(size_t, mbytes,
-				PAGE_SIZE - (maddr & ~PAGE_MASK));
+		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
 		uchunk = min(ubytes, mchunk);
 
 		if (uchunk) {
@@ -905,9 +902,7 @@ static int kimage_load_crash_segment(struct kimage *image, int idx)
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


