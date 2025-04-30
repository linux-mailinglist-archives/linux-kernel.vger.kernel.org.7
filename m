Return-Path: <linux-kernel+bounces-627883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FD4AA5630
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 22:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C373A8D60
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 20:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614322D113B;
	Wed, 30 Apr 2025 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfZhTKfR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AF82D0AB3;
	Wed, 30 Apr 2025 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046397; cv=none; b=rAEMJFEOgsH400HO0b87vzKFEE38bdNxgqFvufmDbFVwJugzP+yizkeB58bsKuZpogAcpdCfJWGiTFDz0xUKJzN0QukGJTeS4QitEikuVZx/48PdbgCH/V4k0CcfJ9XrAEqh057ijJFiVpi+gO/Wpev1ZXOBbqlckViO0sRSeqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046397; c=relaxed/simple;
	bh=+XwXzM2JtnnapecA98UfJihsUQ5zhZpmnmCn8je5v3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=caFuIt+BUrT16MOU9naiwMt204yZntlZizMVlM14IxYdfHD1yutoLjefhOFIrG0BmMKHTwlzK+KNJEiguIzzzB0QYUSpVLsckGfJrvRyBdBi+ae/JnvzvbL/g5MwzwAR7v5ND5Uh/xeSCfIImwWubg+nxVqdx/hUl3yUNHXsxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfZhTKfR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746046396; x=1777582396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+XwXzM2JtnnapecA98UfJihsUQ5zhZpmnmCn8je5v3o=;
  b=BfZhTKfROAVv6rV18O/mFZ76O2nWxLlbbWlV80BV90JyRi6QWFP7qlHk
   9fiuLq3kRhaF5F/FrlLpejxv08uTsI8k/8uWKRUoBIhSAqWEWAXnoTFdW
   7/fC5g4FzBq3g/7m8Ml2Mu8X+w3vtEfEKWZQ+/NTxT1KxdM43eBb6Mr2+
   YW2HuYb1l+Ll1R2quUHc0YC4iLPp3RlbyMyErWVwG2IrN+CzWeogQvmg7
   VfYTUQRMRliJAh6sYGZxn1y+qL3foXlqG+BokiG/We0A+ht4NJ8Ifyq2n
   N/WGB2PTXkg9rAJrWS+OdqT0ak2iNIev8M30lxYJKZHTz8wDa8w0e+0bW
   w==;
X-CSE-ConnectionGUID: ppg8/AVDS0eEEDaNKBNy2Q==
X-CSE-MsgGUID: 60rrxhygSl68oA/y2W5Mjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51388588"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="51388588"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 13:53:14 -0700
X-CSE-ConnectionGUID: 870q6KrASIK9pvCl5N4/vQ==
X-CSE-MsgGUID: 29LiYuNiSZWPJLUImXw8+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="138248909"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by fmviesa003.fm.intel.com with ESMTP; 30 Apr 2025 13:53:13 -0700
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
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v9 08/19] crypto: iaa - Descriptor allocation timeouts with mitigations in iaa_crypto.
Date: Wed, 30 Apr 2025 13:52:54 -0700
Message-Id: <20250430205305.22844-9-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250430205305.22844-1-kanchana.p.sridhar@intel.com>
References: <20250430205305.22844-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch modifies the descriptor allocation from blocking to non-blocking
with bounded retries or "timeouts".

This is necessary to prevent task blocked errors in high contention
scenarios, for instance, when the platform has only 1 IAA device
enabled. With 1 IAA device enabled per package on a dual-package
Sapphire Rapids with 56 cores/package, there are 112 logical cores
mapped to this single IAA device. In this scenario, the task blocked
errors can occur because idxd_alloc_desc() is called with
IDXD_OP_BLOCK. With batching, multiple descriptors will need to be
allocated per batch. Any process that is able to do so, can cause
contention for allocating descriptors for all other processes that share
the use of the same sbitmap_queue. Under IDXD_OP_BLOCK, this can cause
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

This patch also simplifies the success/error return paths in
iaa_[de]compress() and iaa_compress_verify().

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto.h      |  3 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 84 ++++++++++++----------
 2 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
index 549ac98a9366..b4a94da2c315 100644
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
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 0b821b8b4264..7dab340c4a34 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1416,6 +1416,7 @@ static int deflate_generic_decompress(struct acomp_req *req)
 	ACOMP_REQUEST_ON_STACK(fbreq, crypto_acomp_reqtfm(req));
 	int ret;
 
+	req->dlen = PAGE_SIZE;
 	acomp_request_set_callback(fbreq, 0, NULL, NULL);
 	acomp_request_set_params(fbreq, req->src, req->dst, req->slen,
 				 req->dlen);
@@ -1536,7 +1537,8 @@ static int iaa_compress_verify(struct crypto_tfm *tfm, struct acomp_req *req,
 	struct iaa_device_compression_mode *active_compression_mode;
 	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct iaa_device *iaa_device;
-	struct idxd_desc *idxd_desc;
+	struct idxd_desc *idxd_desc = ERR_PTR(-EAGAIN);
+	u16 alloc_desc_retries = 0;
 	struct iax_hw_desc *desc;
 	struct idxd_device *idxd;
 	struct iaa_wq *iaa_wq;
@@ -1552,7 +1554,11 @@ static int iaa_compress_verify(struct crypto_tfm *tfm, struct acomp_req *req,
 
 	active_compression_mode = get_iaa_device_compression_mode(iaa_device, ctx->mode);
 
-	idxd_desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
+	while ((idxd_desc == ERR_PTR(-EAGAIN)) && (alloc_desc_retries++ < IAA_ALLOC_DESC_DECOMP_TIMEOUT)) {
+		idxd_desc = idxd_alloc_desc(wq, IDXD_OP_NONBLOCK);
+		cpu_relax();
+	}
+
 	if (IS_ERR(idxd_desc)) {
 		dev_dbg(dev, "idxd descriptor allocation failed\n");
 		dev_dbg(dev, "iaa compress failed: ret=%ld\n",
@@ -1604,14 +1610,10 @@ static int iaa_compress_verify(struct crypto_tfm *tfm, struct acomp_req *req,
 		goto err;
 	}
 
-	idxd_free_desc(wq, idxd_desc);
-out:
-	return ret;
 err:
 	idxd_free_desc(wq, idxd_desc);
-	dev_dbg(dev, "iaa compress failed: ret=%d\n", ret);
 
-	goto out;
+	return ret;
 }
 
 static void iaa_desc_complete(struct idxd_desc *idxd_desc,
@@ -1727,7 +1729,8 @@ static int iaa_compress(struct crypto_tfm *tfm, struct acomp_req *req,
 	struct iaa_device_compression_mode *active_compression_mode;
 	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct iaa_device *iaa_device;
-	struct idxd_desc *idxd_desc;
+	struct idxd_desc *idxd_desc = ERR_PTR(-EAGAIN);
+	u16 alloc_desc_retries = 0;
 	struct iax_hw_desc *desc;
 	struct idxd_device *idxd;
 	struct iaa_wq *iaa_wq;
@@ -1743,7 +1746,11 @@ static int iaa_compress(struct crypto_tfm *tfm, struct acomp_req *req,
 
 	active_compression_mode = get_iaa_device_compression_mode(iaa_device, ctx->mode);
 
-	idxd_desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
+	while ((idxd_desc == ERR_PTR(-EAGAIN)) && (alloc_desc_retries++ < IAA_ALLOC_DESC_COMP_TIMEOUT)) {
+		idxd_desc = idxd_alloc_desc(wq, IDXD_OP_NONBLOCK);
+		cpu_relax();
+	}
+
 	if (IS_ERR(idxd_desc)) {
 		dev_dbg(dev, "idxd descriptor allocation failed\n");
 		dev_dbg(dev, "iaa compress failed: ret=%ld\n", PTR_ERR(idxd_desc));
@@ -1820,15 +1827,10 @@ static int iaa_compress(struct crypto_tfm *tfm, struct acomp_req *req,
 
 	*compression_crc = idxd_desc->iax_completion->crc;
 
-	if (!ctx->async_mode)
-		idxd_free_desc(wq, idxd_desc);
-out:
-	return ret;
 err:
 	idxd_free_desc(wq, idxd_desc);
-	dev_dbg(dev, "iaa compress failed: ret=%d\n", ret);
-
-	goto out;
+out:
+	return ret;
 }
 
 static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
@@ -1840,7 +1842,8 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	struct iaa_device_compression_mode *active_compression_mode;
 	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct iaa_device *iaa_device;
-	struct idxd_desc *idxd_desc;
+	struct idxd_desc *idxd_desc = ERR_PTR(-EAGAIN);
+	u16 alloc_desc_retries = 0;
 	struct iax_hw_desc *desc;
 	struct idxd_device *idxd;
 	struct iaa_wq *iaa_wq;
@@ -1856,12 +1859,18 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 
 	active_compression_mode = get_iaa_device_compression_mode(iaa_device, ctx->mode);
 
-	idxd_desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
+	while ((idxd_desc == ERR_PTR(-EAGAIN)) && (alloc_desc_retries++ < IAA_ALLOC_DESC_DECOMP_TIMEOUT)) {
+		idxd_desc = idxd_alloc_desc(wq, IDXD_OP_NONBLOCK);
+		cpu_relax();
+	}
+
 	if (IS_ERR(idxd_desc)) {
 		dev_dbg(dev, "idxd descriptor allocation failed\n");
 		dev_dbg(dev, "iaa decompress failed: ret=%ld\n",
 			PTR_ERR(idxd_desc));
-		return PTR_ERR(idxd_desc);
+		ret = PTR_ERR(idxd_desc);
+		idxd_desc = NULL;
+		goto fallback_software_decomp;
 	}
 	desc = idxd_desc->iax_hw;
 
@@ -1905,7 +1914,7 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	ret = idxd_submit_desc(wq, idxd_desc);
 	if (ret) {
 		dev_dbg(dev, "submit_desc failed ret=%d\n", ret);
-		goto err;
+		goto fallback_software_decomp;
 	}
 
 	/* Update stats */
@@ -1919,40 +1928,37 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
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
+			pr_err("%s: iaa decompress failed: deflate-generic fallback to software decompress error ret=%d\n", __func__, ret);
 			goto err;
 		}
 	} else {
 		req->dlen = idxd_desc->iax_completion->output_size;
+
+		/* Update stats */
+		update_total_decomp_bytes_in(slen);
+		update_wq_decomp_bytes(wq, slen);
 	}
 
 	*dlen = req->dlen;
 
-	if (!ctx->async_mode || disable_async)
+err:
+	if (idxd_desc)
 		idxd_free_desc(wq, idxd_desc);
-
-	/* Update stats */
-	update_total_decomp_bytes_in(slen);
-	update_wq_decomp_bytes(wq, slen);
 out:
 	return ret;
-err:
-	idxd_free_desc(wq, idxd_desc);
-	dev_dbg(dev, "iaa decompress failed: ret=%d\n", ret);
-
-	goto out;
 }
 
 static int iaa_comp_acompress(struct acomp_req *req)
-- 
2.27.0


