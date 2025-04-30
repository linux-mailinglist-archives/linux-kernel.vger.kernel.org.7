Return-Path: <linux-kernel+bounces-627887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D81AA563A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 22:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2D1502804
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 20:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C052C032D;
	Wed, 30 Apr 2025 20:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGrg7xaD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0D72D111F;
	Wed, 30 Apr 2025 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046401; cv=none; b=m9V0PLSnI1xa3OJEQ+10aqPiCXatRWHokJtgsENRpQ6NmlqtID7sQNJUMEvH0ZAD+8uKZ3Ci1ef6FIbm8VslW/ojdJ+/LLRSqu3pvN0GqfN7053fRbXVRti6j6DOqLnXiycqZVz3swX1f2lpvMJYvE4y/Zm2Q3mr+ciDcTUR38w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046401; c=relaxed/simple;
	bh=UyA9sOUzeFWM/IfsI80doZFP3YbMuXrREZWQXOgHADM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6P0AmQs6NKkdxLKWV4QNvkQkm2wpMjtDhFKw7Qhvxd+gMR93sOaao6b+4IyexOCOoNc6tnUOHKejwPaWmRLGqTguSSRD4HtI00ZcJg+TQZCVwtMynr0+2+7REm8v0m8+p0UBdUz3miEmpy0uLYyZ++eyUQovQSiBReeSKLYZZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGrg7xaD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746046398; x=1777582398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UyA9sOUzeFWM/IfsI80doZFP3YbMuXrREZWQXOgHADM=;
  b=kGrg7xaDJBodwcXj/svSPBJsRQHwPa4o3N8k7d1aSafOd2pFQmNqqVHQ
   uHz3jEioZIsOMaL5qkTOOj2UANdaGKgvsSToZWNc4eNK6JmvthrnN0sbk
   KKkNCZfB0YVaXHjdxLSzCfeRnhYPQqFXriEHr64gpGJELPH5fLqf2IhXI
   js8KH/qufuh33mi6KwKsizxug/tvcTu4Tf1jGjYt5B45XYG1QZGV5nqpA
   tR3/x9C8mZ6rNZ7AX4y2jdGBtl7Kj+t377ZcLlGpcFUP76CQYIByTebZO
   g3kCJQ727QVkSC2cs6n0u+E8Mv2y40L5oWzMwAg65SH6cZmRdORS47pj/
   w==;
X-CSE-ConnectionGUID: NHiRKsroTv6S8sppHVJx9A==
X-CSE-MsgGUID: 4IXlaN9RThSwSVj9Xr1Ofw==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51388631"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="51388631"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 13:53:17 -0700
X-CSE-ConnectionGUID: znWercD3TMKvHWRAkFah0g==
X-CSE-MsgGUID: M4wTsymcSvGKGkDGi8d6nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="138248922"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by fmviesa003.fm.intel.com with ESMTP; 30 Apr 2025 13:53:15 -0700
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
Subject: [PATCH v9 11/19] crypto: iaa - Implement crypto_acomp batching interfaces for Intel IAA.
Date: Wed, 30 Apr 2025 13:52:57 -0700
Message-Id: <20250430205305.22844-12-kanchana.p.sridhar@intel.com>
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

iaa_crypto implements the new crypto_acomp get_batch_size() interface
that returns an iaa_driver specific constant, IAA_CRYPTO_MAX_BATCH_SIZE
(set to 8U currently).

This patch also provides the iaa_crypto driver implementations for the
newly added crypto_acomp batch_compress() and batch_decompress()
interfaces.

This allows swap modules such as zswap to allocate required batching
resources and then invoke fully asynchronous batch parallel
compression/decompression of pages on systems with Intel IAA, by
invoking these crypto API, respectively:

   crypto_acomp_batch_size(...);
   crypto_acomp_batch_compress(...);
   crypto_acomp_batch_decompress(...);

This enables zswap compress batching code to be developed in
a manner similar to the current single-page synchronous calls to:

   crypto_acomp_compress(...);

thereby, facilitating encapsulated and modular hand-off between the
kernel mm/zswap code and the crypto_acomp layer.

Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto.h      |   9 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 288 +++++++++++++++++++++
 2 files changed, 297 insertions(+)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
index b4a94da2c315..90ce336879f1 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -42,6 +42,15 @@
 					 IAA_DECOMP_CHECK_FOR_EOB | \
 					 IAA_DECOMP_STOP_ON_EOB)
 
+/*
+ * The maximum compress/decompress batch size for IAA's implementation of
+ * the crypto_acomp batch_compress() and batch_decompress() interfaces.
+ * The IAA compression algorithms should provide the crypto_acomp
+ * get_batch_size() interface through a function that returns this
+ * constant.
+ */
+#define IAA_CRYPTO_MAX_BATCH_SIZE 8U
+
 /* Representation of IAA workqueue */
 struct iaa_wq {
 	struct list_head	list;
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 52fe68606f4d..d577f555d6ab 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -2149,6 +2149,291 @@ static void compression_ctx_init(struct iaa_compression_ctx *ctx)
 	ctx->use_irq = use_irq;
 }
 
+static __always_inline unsigned int iaa_comp_get_batch_size(void)
+{
+	return IAA_CRYPTO_MAX_BATCH_SIZE;
+}
+
+static int iaa_comp_poll(struct acomp_req *req)
+{
+	struct idxd_desc *idxd_desc;
+	struct idxd_device *idxd;
+	struct iaa_wq *iaa_wq;
+	struct pci_dev *pdev;
+	struct device *dev;
+	struct idxd_wq *wq;
+	bool compress_op;
+	int ret;
+
+	idxd_desc = req->data;
+	if (!idxd_desc)
+		return -EAGAIN;
+
+	compress_op = (idxd_desc->iax_hw->opcode == IAX_OPCODE_COMPRESS);
+	wq = idxd_desc->wq;
+	iaa_wq = idxd_wq_get_private(wq);
+	idxd = iaa_wq->iaa_device->idxd;
+	pdev = idxd->pdev;
+	dev = &pdev->dev;
+
+	ret = check_completion(dev, idxd_desc->iax_completion, compress_op, true);
+	if (ret == -EAGAIN)
+		return ret;
+	if (ret)
+		goto out;
+
+	req->dlen = idxd_desc->iax_completion->output_size;
+
+	/* Update stats */
+	if (compress_op) {
+		update_total_comp_bytes_out(req->dlen);
+		update_wq_comp_bytes(wq, req->dlen);
+	} else {
+		update_total_decomp_bytes_in(req->slen);
+		update_wq_decomp_bytes(wq, req->slen);
+	}
+
+	if (iaa_verify_compress && (idxd_desc->iax_hw->opcode == IAX_OPCODE_COMPRESS)) {
+		struct crypto_tfm *tfm = req->base.tfm;
+		dma_addr_t src_addr, dst_addr;
+		u32 compression_crc;
+
+		compression_crc = idxd_desc->iax_completion->crc;
+
+		dma_sync_sg_for_device(dev, req->dst, 1, DMA_FROM_DEVICE);
+		dma_sync_sg_for_device(dev, req->src, 1, DMA_TO_DEVICE);
+
+		src_addr = sg_dma_address(req->src);
+		dst_addr = sg_dma_address(req->dst);
+
+		ret = iaa_compress_verify(tfm, req, wq, src_addr, req->slen,
+					  dst_addr, &req->dlen, compression_crc);
+	}
+out:
+	/* caller doesn't call crypto_wait_req, so no acomp_request_complete() */
+
+	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+
+	idxd_free_desc(idxd_desc->wq, idxd_desc);
+
+	dev_dbg(dev, "%s: returning ret=%d\n", __func__, ret);
+
+	return ret;
+}
+
+static __always_inline void iaa_set_req_poll(
+	struct acomp_req *reqs[],
+	int nr_reqs,
+	bool set_flag)
+{
+	int i;
+
+	for (i = 0; i < nr_reqs; ++i) {
+		set_flag ? (reqs[i]->base.flags |= CRYPTO_ACOMP_REQ_POLL) :
+			   (reqs[i]->base.flags &= ~CRYPTO_ACOMP_REQ_POLL);
+	}
+}
+
+/**
+ * This API provides IAA compress batching functionality for use by swap
+ * modules.
+ *
+ * @reqs: @nr_reqs asynchronous compress requests.
+ * @pages: Pages to be compressed by IAA.
+ * @dsts: Pre-allocated destination buffers to store results of IAA
+ *        compression. Each element of @dsts must be of size "PAGE_SIZE * 2".
+ * @dlens: Will contain the compressed lengths.
+ * @errors: zero on successful compression of the corresponding
+ *          req, or error code in case of error.
+ * @nr_reqs: The number of requests, up to IAA_CRYPTO_MAX_BATCH_SIZE,
+ *           to be compressed.
+ *
+ * Returns true if all compress requests in the batch complete successfully,
+ * false otherwise.
+ */
+static bool iaa_comp_acompress_batch(
+	struct acomp_req *reqs[],
+	struct page *pages[],
+	u8 *dsts[],
+	unsigned int dlens[],
+	int errors[],
+	int nr_reqs)
+{
+	struct scatterlist inputs[IAA_CRYPTO_MAX_BATCH_SIZE];
+	struct scatterlist outputs[IAA_CRYPTO_MAX_BATCH_SIZE];
+	bool compressions_done = false;
+	int i, err = 0;
+
+	BUG_ON(nr_reqs > IAA_CRYPTO_MAX_BATCH_SIZE);
+
+	iaa_set_req_poll(reqs, nr_reqs, true);
+
+	/*
+	 * Prepare and submit the batch of acomp_reqs to IAA. IAA will process
+	 * these compress jobs in parallel.
+	 */
+	for (i = 0; i < nr_reqs; ++i) {
+		sg_init_table(&inputs[i], 1);
+		sg_set_page(&inputs[i], pages[i], PAGE_SIZE, 0);
+
+		/*
+		 * We need PAGE_SIZE * 2 here since there maybe over-compression case,
+		 * and hardware-accelerators may won't check the dst buffer size, so
+		 * giving the dst buffer with enough length to avoid buffer overflow.
+		 */
+		sg_init_one(&outputs[i], dsts[i], PAGE_SIZE * 2);
+		acomp_request_set_params(reqs[i], &inputs[i],
+					 &outputs[i], PAGE_SIZE, PAGE_SIZE);
+
+		errors[i] = iaa_comp_acompress(reqs[i]);
+
+		if (errors[i] != -EINPROGRESS) {
+			errors[i] = -EINVAL;
+			err = -EINVAL;
+		} else {
+			errors[i] = -EAGAIN;
+		}
+	}
+
+	/*
+	 * Asynchronously poll for and process IAA compress job completions.
+	 */
+	while (!compressions_done) {
+		compressions_done = true;
+
+		for (i = 0; i < nr_reqs; ++i) {
+			/*
+			 * Skip, if the compression has already completed
+			 * successfully or with an error.
+			 */
+			if (errors[i] != -EAGAIN)
+				continue;
+
+			errors[i] = iaa_comp_poll(reqs[i]);
+
+			if (errors[i]) {
+				if (errors[i] == -EAGAIN)
+					compressions_done = false;
+				else
+					err = -EINVAL;
+			} else {
+				dlens[i] = reqs[i]->dlen;
+			}
+		}
+	}
+
+	/*
+	 * For the same 'reqs[]' to be usable by
+	 * iaa_comp_acompress()/iaa_comp_adecompress(),
+	 * clear the CRYPTO_ACOMP_REQ_POLL bit on all acomp_reqs.
+	 */
+	iaa_set_req_poll(reqs, nr_reqs, false);
+
+	return !err;
+}
+
+/**
+ * This API provides IAA decompress batching functionality for use by swap
+ * modules.
+ *
+ * @reqs: @nr_reqs asynchronous decompress requests.
+ * @srcs: The src buffers to be decompressed by IAA.
+ * @pages: The pages to store the decompressed buffers.
+ * @slens: Compressed lengths of @srcs.
+ * @dlens: Will contain the decompressed lengths.
+ * @errors: zero on successful compression of the corresponding
+ *          req, or error code in case of error.
+ * @nr_reqs: The number of pages, up to IAA_CRYPTO_MAX_BATCH_SIZE,
+ *            to be decompressed.
+ *
+ * Returns true if all decompress requests complete successfully,
+ * false otherwise.
+ */
+static bool iaa_comp_adecompress_batch(
+	struct acomp_req *reqs[],
+	u8 *srcs[],
+	struct page *pages[],
+	unsigned int slens[],
+	unsigned int dlens[],
+	int errors[],
+	int nr_reqs)
+{
+	struct scatterlist inputs[IAA_CRYPTO_MAX_BATCH_SIZE];
+	struct scatterlist outputs[IAA_CRYPTO_MAX_BATCH_SIZE];
+	bool decompressions_done = false;
+	int i, err = 0;
+
+	BUG_ON(nr_reqs > IAA_CRYPTO_MAX_BATCH_SIZE);
+
+	iaa_set_req_poll(reqs, nr_reqs, true);
+
+	/*
+	 * Prepare and submit the batch of acomp_reqs to IAA. IAA will process
+	 * these decompress jobs in parallel.
+	 */
+	for (i = 0; i < nr_reqs; ++i) {
+		sg_init_one(&inputs[i], srcs[i], slens[i]);
+		sg_init_table(&outputs[i], 1);
+		sg_set_page(&outputs[i], pages[i], PAGE_SIZE, 0);
+		acomp_request_set_params(reqs[i], &inputs[i],
+					&outputs[i], slens[i], PAGE_SIZE);
+
+		errors[i] = iaa_comp_adecompress(reqs[i]);
+
+		/*
+		 * If it failed desc allocation/submission, errors[i] can
+		 * be 0 or error value from software decompress.
+		 */
+		if (errors[i] != -EINPROGRESS) {
+			errors[i] = -EINVAL;
+			err = -EINVAL;
+		} else {
+			errors[i] = -EAGAIN;
+		}
+	}
+
+	/*
+	 * Asynchronously poll for and process IAA decompress job completions.
+	 */
+	while (!decompressions_done) {
+		decompressions_done = true;
+
+		for (i = 0; i < nr_reqs; ++i) {
+			/*
+			 * Skip, if the decompression has already completed
+			 * successfully or with an error.
+			 */
+			if (errors[i] != -EAGAIN)
+				continue;
+
+			errors[i] = iaa_comp_poll(reqs[i]);
+
+			if (errors[i]) {
+				if (errors[i] == -EAGAIN)
+					decompressions_done = false;
+				else
+					err = -EINVAL;
+			} else {
+				/*
+				 * For batch decompressions, the caller should
+				 * check @errors and handle dlens[i] != PAGE_SIZE.
+				 */
+				dlens[i] = reqs[i]->dlen;
+			}
+		}
+	}
+
+	/*
+	 * For the same 'reqs[]' to be usable by
+	 * iaa_comp_acompress()/iaa_comp_adecompress(),
+	 * clear the CRYPTO_ACOMP_REQ_POLL bit on all acomp_reqs.
+	 */
+	iaa_set_req_poll(reqs, nr_reqs, false);
+
+	return !err;
+}
+
 /*********************************************
  * Interfaces to crypto_alg and crypto_acomp.
  *********************************************/
@@ -2169,6 +2454,9 @@ static struct acomp_alg iaa_acomp_fixed_deflate = {
 	.init			= iaa_comp_init_fixed,
 	.compress		= iaa_comp_acompress,
 	.decompress		= iaa_comp_adecompress,
+	.get_batch_size		= iaa_comp_get_batch_size,
+	.batch_compress		= iaa_comp_acompress_batch,
+	.batch_decompress	= iaa_comp_adecompress_batch,
 	.base			= {
 		.cra_name		= "deflate",
 		.cra_driver_name	= "deflate-iaa",
-- 
2.27.0


