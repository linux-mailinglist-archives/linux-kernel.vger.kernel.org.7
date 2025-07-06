Return-Path: <linux-kernel+bounces-716440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84025AF869A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 06:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332994A8257
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 04:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEAB20A5F5;
	Fri,  4 Jul 2025 04:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A0rLTpfo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFC01F4161;
	Fri,  4 Jul 2025 04:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751603015; cv=none; b=FEwkoQXTMpc0msewQj0qJknkOwuSOT2ZjmdLTbor/VCea5ZDRxplApOwz6Oc3JvNprPI2mv3ppv1jI8POX1EOhAwQzqUv6UXouyuL4blmVxfxRYg6EzUeFG3rwzgouYqu5h0i0p1AP5eUBiP5HKQtxDQlxj/IOBBfHAm7Da9yiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751603015; c=relaxed/simple;
	bh=BH+2fulEg7N3rP+Cp0ptXHtd6vqePLyjcakelLEAKv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ES24lTBvmmA6eM8elSz/ZkqeJa8ZhkpcX/VxNBL0D0/O61e+tyC4ps6gAUnsLBu1Qc1BzwUPTv1VyxcsEMnsnRojpDSHumZWJrSdiWNYm9p6kDteIm6lcYCnyvn6lIfhATSIxznUr1mD+SSkrsANe2edESAM0rhW3nGBKO6h1rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A0rLTpfo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751603014; x=1783139014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BH+2fulEg7N3rP+Cp0ptXHtd6vqePLyjcakelLEAKv8=;
  b=A0rLTpfopInCeedebohk3PomNV6SuMa9H1kLJxCl6SQefxq//PR5nsfp
   2J6sauV1MSnrLIfSspMkOxSr6O/FJnj3bTI695BPaLeJ5MQ1D9ovyIMgq
   CLwwiM5LFtVLJbHRaIPomDGLbjHPuUG/l6aEAfZs2HFZL+R/OJcC/Uwx/
   h/mLp2U3AZk1wNCk44/xeJp32CkFp8XWgtNYhpu3xHHa0tZ7NBcVT3VQp
   DQm7cOXOpbQDp6O01A+qsDc7T0XsDaFLW8NocPkS3o6Es3P4cnwN2Phqx
   qrn1vzUBW3qzZgSOPkLhbeB/9fb1AZ6ZaSIxdxxD1kVU6XPK+fzmpk4aH
   g==;
X-CSE-ConnectionGUID: x9WTUhMZQSSsQb0qtlyuYg==
X-CSE-MsgGUID: 4yJg4qfrRwKiMrUTlsTjEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53909051"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="53909051"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 21:23:25 -0700
X-CSE-ConnectionGUID: R6/+Mv2TTD21crDu1xq2BQ==
X-CSE-MsgGUID: 0qwUO5zNRtq8v+k+hMHeKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="153968682"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by orviesa006.jf.intel.com with ESMTP; 03 Jul 2025 21:23:25 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	ying.huang@linux.alibaba.com,
	akpm@linux-foundation.org,
	senozhatsky@chromium.org,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com,
	vinicius.gomes@intel.com
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v10 08/25] crypto: iaa - Simplified, efficient job submissions for non-irq mode.
Date: Thu,  3 Jul 2025 21:23:06 -0700
Message-Id: <20250704042323.10318-9-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250704042323.10318-1-kanchana.p.sridhar@intel.com>
References: <20250704042323.10318-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a new procedure, iaa_submit_desc_movdir64b(), that
directly calls movdir64b. The core iaa_crypto routines that submit
compress and decompress jobs now invoke iaa_submit_desc_movdir64b() in
non-irq driver modes, instead of idxd_submit_desc().

idxd_submit_desc() is called only in irq mode.

This improves latency for the most commonly used iaa_crypto usage
(i.e., async non-irq) in zswap/zram by eliminating redundant computes
that would otherwise be incurred in idxd_submit_desc():

  p50: -32 ns
  p99: -1,048 ns

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 30 ++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index fa23f50a77969..735ad54de2f01 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1782,6 +1782,24 @@ iaa_setup_decompress_hw_desc(struct idxd_desc *idxd_desc,
 	return desc;
 }
 
+/*
+ * Call this for non-irq, non-enqcmds job submissions.
+ */
+static __always_inline void iaa_submit_desc_movdir64b(struct idxd_wq *wq,
+						     struct idxd_desc *desc)
+{
+	void __iomem *portal = idxd_wq_portal_addr(wq);
+
+	/*
+	 * The wmb() flushes writes to coherent DMA data before
+	 * possibly triggering a DMA read. The wmb() is necessary
+	 * even on UP because the recipient is a device.
+	 */
+	wmb();
+
+	iosubmit_cmds512(portal, desc->hw, 1);
+}
+
 static int iaa_compress(struct crypto_tfm *tfm, struct acomp_req *req,
 			struct idxd_wq *wq,
 			dma_addr_t src_addr, unsigned int slen,
@@ -1820,11 +1838,7 @@ static int iaa_compress(struct crypto_tfm *tfm, struct acomp_req *req,
 					  ctx->mode, iaa_device->compression_modes[ctx->mode]);
 
 	if (likely(!ctx->use_irq)) {
-		ret = idxd_submit_desc(wq, idxd_desc);
-		if (ret) {
-			dev_dbg(dev, "submit_desc failed ret=%d\n", ret);
-			goto out;
-		}
+		iaa_submit_desc_movdir64b(wq, idxd_desc);
 
 		/* Update stats */
 		update_total_comp_calls();
@@ -1912,11 +1926,7 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	desc = iaa_setup_decompress_hw_desc(idxd_desc, src_addr, slen, dst_addr, *dlen);
 
 	if (likely(!ctx->use_irq)) {
-		ret = idxd_submit_desc(wq, idxd_desc);
-		if (ret) {
-			dev_dbg(dev, "submit_desc failed ret=%d\n", ret);
-			goto fallback_software_decomp;
-		}
+		iaa_submit_desc_movdir64b(wq, idxd_desc);
 
 		/* Update stats */
 		update_total_decomp_calls();
-- 
2.27.0


