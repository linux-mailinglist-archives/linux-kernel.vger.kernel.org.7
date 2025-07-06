Return-Path: <linux-kernel+bounces-716436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E1CAF868E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 06:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1EA41C81A4B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 04:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5341F428C;
	Fri,  4 Jul 2025 04:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0pw6UQK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC719CC3D;
	Fri,  4 Jul 2025 04:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751603012; cv=none; b=rCAFFgIxIgc2yxfSO2o1vUwnyZZf2Pej9YHUUmAXLefte1FpYFJqKu2GKFoN1Lg9paQlAD9ebU6RZRp2AkRaavLTpNDcXkG5mA/y/MDn4hCe018lURGNsiqLtQMz7IOlzkCGG7Om9I8UXiGbjhSSO0kafgCciTN38Y/b2QSRNjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751603012; c=relaxed/simple;
	bh=4B6Iun1YxhB47spBZZIKa1Bilapfd2krW1w6aiR4t1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DLEBGjDHlh6gGRkXJK3+gLwto07C8r7jPiSbP5taHKQZKjWHV3q+Vc0tUOE6GrtM01Hv/VgV4Rr40yXM+O+O0HFDqa+3hrxeb3GRJEsC3JUQIbFMxLHUfpPHVpdUnp/gC0qQlor414c2C1NG/HcYUHgHrLSrn8O2caisKcpmlq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0pw6UQK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751603010; x=1783139010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4B6Iun1YxhB47spBZZIKa1Bilapfd2krW1w6aiR4t1Y=;
  b=V0pw6UQKRLyCZp7fuJN/joguGwYpwmQ8+ofllEGFaS6kHbyeoxAGM5fN
   Cqzy9wblWFJfhWsKEtz8idOOajptirceMIFORdizFFbY+APi+Fe7Px1p2
   /XbtKEn4V6QsimPoBFlGmzsxNt0AfjdKGo2Mrk6zcCwbbLbiOAfbCtKhY
   JuQyRFfpLzN7kA/JMsAuBEBLtJtDGMRKG9YvIfm2i5U3jiqW2N/M/gnBd
   IIHkK9E8/OYVcnUUrQ8z6Wbe4jTA96DO4HwXfwF+sxHw9tIn8NxpF0NAn
   05VkG7VOQmcHKiXEjjn2tprUaywW7AZ9NPF+gqvA59/wfb8hr+Fl7tVC+
   A==;
X-CSE-ConnectionGUID: 7JyE8apoQ2+wb9+JKnhJZw==
X-CSE-MsgGUID: Pr+qudZUQE6R4+d+vddZAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53908997"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="53908997"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 21:23:25 -0700
X-CSE-ConnectionGUID: 9NVdnrEERnuioBpNTo/zsA==
X-CSE-MsgGUID: gl8auCpuQsGcweyUKS1pVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="153968670"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by orviesa006.jf.intel.com with ESMTP; 03 Jul 2025 21:23:24 -0700
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
Subject: [PATCH v10 04/25] crypto: iaa - Descriptor allocation timeouts with mitigations.
Date: Thu,  3 Jul 2025 21:23:02 -0700
Message-Id: <20250704042323.10318-5-kanchana.p.sridhar@intel.com>
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

This patch modifies the descriptor allocation from blocking to
non-blocking with bounded retries or "timeouts".

This is necessary to prevent task blocked errors in high contention
scenarios, for instance, when the platform has only 1 IAA device
enabled. With 1 IAA device enabled per package on a dual-package
Sapphire Rapids with 56 cores/package, there are 112 logical cores
mapped to this single IAA device. In this scenario, the task blocked
errors can occur because idxd_alloc_desc() is called with
IDXD_OP_BLOCK. With batching, multiple descriptors will need to be
allocated per batch. Any process that is able to do so, can cause
contention for allocating descriptors for all other processes that share
the use of the same sbitmap_queue. Under IDXD_OP_BLOCK, this causes
compress/decompress jobs to stall in stress test scenarios
(e.g. zswap_store() of 2M folios).

In order to make the iaa_crypto driver be more fail-safe, this commit
implements the following:

1) Change compress/decompress descriptor allocations to be non-blocking
   with retries ("timeouts").
2) Return compress error to zswap if descriptor allocation with timeouts
   fails during compress ops. zswap_store() will return an error and the
   folio gets stored in the backing swap device.
3) Fallback to software decompress if descriptor allocation with timeouts
   fails during decompress ops.

With these fixes, there are no task blocked errors seen under stress
testing conditions, and no performance degradation observed.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto.h      |  5 ++
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 58 +++++++++++++++-------
 2 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
index 549ac98a9366e..cc76a047b54ad 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -21,6 +21,9 @@
 
 #define IAA_COMPLETION_TIMEOUT		1000000
 
+#define IAA_ALLOC_DESC_COMP_TIMEOUT	   1000
+#define IAA_ALLOC_DESC_DECOMP_TIMEOUT	    500
+
 #define IAA_ANALYTICS_ERROR		0x0a
 #define IAA_ERROR_DECOMP_BUF_OVERFLOW	0x0b
 #define IAA_ERROR_COMP_BUF_OVERFLOW	0x19
@@ -141,6 +144,8 @@ enum iaa_mode {
 
 struct iaa_compression_ctx {
 	enum iaa_mode	mode;
+	u16		alloc_comp_desc_timeout;
+	u16		alloc_decomp_desc_timeout;
 	bool		verify_compress;
 	bool		async_mode;
 	bool		use_irq;
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index da8059de6ad61..1de8b93185ca4 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1596,7 +1596,8 @@ static int iaa_compress_verify(struct crypto_tfm *tfm, struct acomp_req *req,
 	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
 	u32 *compression_crc = acomp_request_ctx(req);
 	struct iaa_device *iaa_device;
-	struct idxd_desc *idxd_desc;
+	struct idxd_desc *idxd_desc = ERR_PTR(-EAGAIN);
+	u16 alloc_desc_retries = 0;
 	struct iax_hw_desc *desc;
 	struct idxd_device *idxd;
 	struct iaa_wq *iaa_wq;
@@ -1612,7 +1613,11 @@ static int iaa_compress_verify(struct crypto_tfm *tfm, struct acomp_req *req,
 
 	active_compression_mode = get_iaa_device_compression_mode(iaa_device, ctx->mode);
 
-	idxd_desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
+	while ((idxd_desc == ERR_PTR(-EAGAIN)) && (alloc_desc_retries++ < ctx->alloc_decomp_desc_timeout)) {
+		idxd_desc = idxd_alloc_desc(wq, IDXD_OP_NONBLOCK);
+		cpu_relax();
+	}
+
 	if (IS_ERR(idxd_desc)) {
 		dev_dbg(dev, "iaa compress_verify failed: idxd descriptor allocation failure: ret=%ld\n", PTR_ERR(idxd_desc));
 		return -ENODEV;
@@ -1772,7 +1777,8 @@ static int iaa_compress(struct crypto_tfm *tfm, struct acomp_req *req,
 	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
 	u32 *compression_crc = acomp_request_ctx(req);
 	struct iaa_device *iaa_device;
-	struct idxd_desc *idxd_desc;
+	struct idxd_desc *idxd_desc = ERR_PTR(-EAGAIN);
+	u16 alloc_desc_retries = 0;
 	struct iax_hw_desc *desc;
 	struct idxd_device *idxd;
 	struct iaa_wq *iaa_wq;
@@ -1788,7 +1794,11 @@ static int iaa_compress(struct crypto_tfm *tfm, struct acomp_req *req,
 
 	active_compression_mode = get_iaa_device_compression_mode(iaa_device, ctx->mode);
 
-	idxd_desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
+	while ((idxd_desc == ERR_PTR(-EAGAIN)) && (alloc_desc_retries++ < ctx->alloc_comp_desc_timeout)) {
+		idxd_desc = idxd_alloc_desc(wq, IDXD_OP_NONBLOCK);
+		cpu_relax();
+	}
+
 	if (IS_ERR(idxd_desc)) {
 		dev_dbg(dev, "iaa compress failed: idxd descriptor allocation failure: ret=%ld\n",
 			PTR_ERR(idxd_desc));
@@ -1863,7 +1873,8 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	struct iaa_device_compression_mode *active_compression_mode;
 	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct iaa_device *iaa_device;
-	struct idxd_desc *idxd_desc;
+	struct idxd_desc *idxd_desc = ERR_PTR(-EAGAIN);
+	u16 alloc_desc_retries = 0;
 	struct iax_hw_desc *desc;
 	struct idxd_device *idxd;
 	struct iaa_wq *iaa_wq;
@@ -1879,12 +1890,17 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 
 	active_compression_mode = get_iaa_device_compression_mode(iaa_device, ctx->mode);
 
-	idxd_desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
+	while ((idxd_desc == ERR_PTR(-EAGAIN)) && (alloc_desc_retries++ < ctx->alloc_decomp_desc_timeout)) {
+		idxd_desc = idxd_alloc_desc(wq, IDXD_OP_NONBLOCK);
+		cpu_relax();
+	}
+
 	if (IS_ERR(idxd_desc)) {
 		ret = -ENODEV;
 		dev_dbg(dev, "%s: idxd descriptor allocation failed: ret=%ld\n", __func__,
 			PTR_ERR(idxd_desc));
-		return ret;
+		idxd_desc = NULL;
+		goto fallback_software_decomp;
 	}
 	desc = idxd_desc->iax_hw;
 
@@ -1913,7 +1929,7 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	ret = idxd_submit_desc(wq, idxd_desc);
 	if (ret) {
 		dev_dbg(dev, "submit_desc failed ret=%d\n", ret);
-		goto err;
+		goto fallback_software_decomp;
 	}
 
 	/* Update stats */
@@ -1926,19 +1942,21 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	}
 
 	ret = check_completion(dev, idxd_desc->iax_completion, false, false);
+
+fallback_software_decomp:
 	if (ret) {
-		dev_dbg(dev, "%s: check_completion failed ret=%d\n", __func__, ret);
-		if (idxd_desc->iax_completion->status == IAA_ANALYTICS_ERROR) {
+		dev_dbg(dev, "%s: desc allocation/submission/check_completion failed ret=%d\n", __func__, ret);
+		if (idxd_desc && idxd_desc->iax_completion->status == IAA_ANALYTICS_ERROR) {
 			pr_warn("%s: falling back to deflate-generic decompress, "
 				"analytics error code %x\n", __func__,
 				idxd_desc->iax_completion->error_code);
-			ret = deflate_generic_decompress(req);
-			if (ret) {
-				dev_dbg(dev, "%s: deflate-generic failed ret=%d\n",
-					__func__, ret);
-				goto err;
-			}
-		} else {
+		}
+
+		ret = deflate_generic_decompress(req);
+
+		if (ret) {
+			pr_err("%s: iaa decompress failed: deflate-generic fallback error ret=%d\n",
+			       __func__, ret);
 			goto err;
 		}
 	} else {
@@ -2119,6 +2137,8 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 
 static void compression_ctx_init(struct iaa_compression_ctx *ctx)
 {
+	ctx->alloc_comp_desc_timeout = IAA_ALLOC_DESC_COMP_TIMEOUT;
+	ctx->alloc_decomp_desc_timeout = IAA_ALLOC_DESC_DECOMP_TIMEOUT;
 	ctx->verify_compress = iaa_verify_compress;
 	ctx->async_mode = async_mode;
 	ctx->use_irq = use_irq;
@@ -2133,10 +2153,10 @@ static int iaa_comp_init_fixed(struct crypto_acomp *acomp_tfm)
 	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
 	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
 
-	compression_ctx_init(ctx);
-
 	ctx->mode = IAA_MODE_FIXED;
 
+	compression_ctx_init(ctx);
+
 	return 0;
 }
 
-- 
2.27.0


