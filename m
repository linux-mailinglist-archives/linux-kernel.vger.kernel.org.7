Return-Path: <linux-kernel+bounces-716447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E361CAF86A9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 06:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128B55686E6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 04:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA22023C507;
	Fri,  4 Jul 2025 04:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6wEFHco"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581891E1C36;
	Fri,  4 Jul 2025 04:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751603020; cv=none; b=Th8ocsYaNYE3/6c/5NCDYeu9ULsBowUjN6Tss8tDPSkUeTx5CIn/Z9Jy4Uzjh2M1aRdteTmdypKrjdDBx6xD6faUphUWOCJD882zbDn5NP3/SiGe/mCfOSu3mHYuPOG7C4jdgmX9Cp/DYleXUcr6tCL+N/4KrYoS04X9U0WAx5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751603020; c=relaxed/simple;
	bh=3t6iTobRxokQydJ0Ne0ch0GKbIW5E3yGqcv6NajRAko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S3LE1N5R0t0cdEjNkLtYF2mHQpOaKOrVjenU3ebSdriyPO4exiQpONzzD804LIBdJpcDHK9Rt0Yh4fLdeWAz4SWkS3koPWEUYpPxLLfUi4/q3O+MAa/UKW93YiIlDsQrspl/cMcrgh8FoUIIWGYWoYideYqIb21TCk6SQ9NanR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6wEFHco; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751603018; x=1783139018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3t6iTobRxokQydJ0Ne0ch0GKbIW5E3yGqcv6NajRAko=;
  b=A6wEFHcoRgfLg/lxYwfQcJGY6f+lN8+Mv3mGGmNScCy41st6vJJbruHP
   sI0zibLkc15WMiELZqlar5t/XAxEX2e2Zk1R4e49kAeVeZMM8DGfVVtGx
   d8DTxoMlmN+4TKZ+hHEQiLybmVd5XuQ0DZ2SBvFVrXuFH/hRUEh23tqLN
   RR7MXx5sGSvMZjXykLeuRYy4y4DGH8z/GKK3qBKKtx+vHg2tSU/ocE+sK
   Z4DUyn8JOPTyuNmWnkQFoc2Qp+7HaiQrHLryAh/t45VFS0xbWz8Gv4Xed
   Z2Zsz1Dhp/jlj0a18/beawsIUdlR4jQ5F8uFUFQ9Dj7O0RV4AFBASibgV
   A==;
X-CSE-ConnectionGUID: oSFOoTMDTnK7736ejYtHIg==
X-CSE-MsgGUID: BvqjjiggQES3BDyXOD5a8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53909111"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="53909111"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 21:23:26 -0700
X-CSE-ConnectionGUID: dpq4gRsXQNOQP48YP/39gg==
X-CSE-MsgGUID: ECzlC+uyQya+Osf6Xk8PMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="153968699"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by orviesa006.jf.intel.com with ESMTP; 03 Jul 2025 21:23:26 -0700
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
Subject: [PATCH v10 13/25] crypto: iaa - IAA Batching for parallel compressions/decompressions.
Date: Thu,  3 Jul 2025 21:23:11 -0700
Message-Id: <20250704042323.10318-14-kanchana.p.sridhar@intel.com>
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

This patch introduces batch compressions/decompressions in
iaa_crypto. Two new interfaces are provided for use in the kernel,
either directly, in the zram/zcomp backend, or through the
acomp_req->kernel_data pointer when calling crypto_acomp_[de]compress()
in the case of zswap.

IAA Batching allows the kernel swap modules to compress/decompress
multiple pages/buffers in parallel in hardware, significantly improving
swapout/swapin latency and throughput.

The patch defines an iaa_crypto constant, IAA_CRYPTO_MAX_BATCH_SIZE
(set to 8U currently). This is the maximum batch-size for IAA, and
represents the maximum number of pages/buffers that can be
compressed/decompressed in parallel, respectively.

In order to support IAA batching, the iaa_crypto driver allocates
IAA_CRYPTO_MAX_BATCH_SIZE "struct iaa_req *reqs[]" per-CPU, upon
initialization. Notably, the task of allocating multiple requests to
submit to the hardware for parallel [de]compressions is taken over by
iaa_crypto, so that zswap/zram don't need to allocate the reqs.

Batching is called with multiple iaa_reqs and pages, and works as
follows:

1) All input iaa_reqs are submitted to the hardware in async mode, using
   movdir64b. This enables hardware parallelism, because we don't wait
   for one compress/decompress job to finish before submitting the next
   one.

2) The iaa_reqs submitted are polled for completion statuses in a
   non-blocking manner in a while loop: each request that is still
   pending is polled once, and this repeats, until all requests have
   completed.

IAA's maximum batch-size can be queried with the following API:

  unsigned int iaa_comp_get_max_batch_size(void);

This allows swap modules such as zram to allocate required batching
dst buffers and then invoke fully asynchronous batch parallel
compression/decompression of pages/buffers on systems with Intel IAA, by
invoking these batching API, respectively:

  int iaa_comp_compress_batch(
        enum iaa_mode mode,
        struct iaa_req *reqs[],
        struct page *pages[],
        u8 *dsts[],
        unsigned int dlens[],
        int errors[],
        int nr_reqs);

  int iaa_comp_decompress_batch(
        enum iaa_mode mode,
        struct iaa_req *reqs[],
        u8 *srcs[],
        struct page *pages[],
        unsigned int slens[],
        unsigned int dlens[],
        int errors[],
        int nr_reqs);

A zram/zcomp backend_deflate_iaa.c will be submitted as a separate patch
series, and will enable single-page and batch IAA compress/decompress
ops.

The zswap interface to these batching API will be done setting the
acomp_req->kernel_data to a "struct swap_batch_comp_data *" or
"struct swap_batch_decomp_data *" for batch compression/decompression
respectively, using the existing
crypto_acomp_compress()/crypto_acomp_decompress() interfaces.

The new crypto_acomp-agnostic iaa_comp_[de]compress_batch() API result
in impressive latency improvements for zswap batch [de]compression, as
compared to a crypto_acomp based batching interface, most likely because
we avoid the overhead of crypto_acomp: we observe 17.78 micro-seconds
p99 latency savings for a decompress batch of 8 with the new
iaa_comp_decompress_batch() API.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto.h      |  14 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 348 ++++++++++++++++++++-
 include/linux/iaa_comp.h                   |  72 +++++
 3 files changed, 426 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
index 1cc383c94fb80..3086bf18126e5 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -47,6 +47,20 @@
  */
 #define IAA_REQ_POLL_FLAG		0x00000002
 
+/*
+ * The maximum compress/decompress batch size for IAA's batch compression
+ * and batch decompression functionality.
+ */
+#define IAA_CRYPTO_MAX_BATCH_SIZE 8U
+
+/*
+ * Used to create per-CPU structure comprising of IAA_CRYPTO_MAX_BATCH_SIZE
+ * reqs for batch [de]compressions.
+ */
+struct iaa_batch_ctx {
+	struct iaa_req **reqs;
+};
+
 /* Representation of IAA workqueue */
 struct iaa_wq {
 	struct list_head	list;
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 4b25235d6636c..0ed3d6e8ad0ec 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -55,6 +55,9 @@ static struct wq_table_entry **pkg_global_comp_wqs;
 /* For software deflate fallback compress/decompress. */
 static struct crypto_acomp *deflate_crypto_acomp;
 
+/* Per-cpu iaa_reqs for batching. */
+static struct iaa_batch_ctx __percpu *iaa_batch_ctx;
+
 LIST_HEAD(iaa_devices);
 DEFINE_MUTEX(iaa_devices_lock);
 
@@ -2189,7 +2192,12 @@ static int iaa_comp_adecompress(struct iaa_compression_ctx *ctx, struct iaa_req
 	return ret;
 }
 
-static int __maybe_unused iaa_comp_poll(struct iaa_compression_ctx *ctx, struct iaa_req *req)
+static __always_inline unsigned int iaa_get_max_batch_size(void)
+{
+	return IAA_CRYPTO_MAX_BATCH_SIZE;
+}
+
+static int iaa_comp_poll(struct iaa_compression_ctx *ctx, struct iaa_req *req)
 {
 	struct idxd_desc *idxd_desc;
 	struct idxd_device *idxd;
@@ -2254,6 +2262,220 @@ static int __maybe_unused iaa_comp_poll(struct iaa_compression_ctx *ctx, struct
 	return ret;
 }
 
+static __always_inline void iaa_set_req_poll(
+	struct iaa_req *reqs[],
+	int nr_reqs,
+	bool set_flag)
+{
+	int i;
+
+	for (i = 0; i < nr_reqs; ++i) {
+		set_flag ? (reqs[i]->flags |= IAA_REQ_POLL_FLAG) :
+			   (reqs[i]->flags &= ~IAA_REQ_POLL_FLAG);
+	}
+}
+
+/**
+ * This API provides IAA compress batching functionality for use by swap
+ * modules.
+ *
+ * @ctx:  compression ctx for the requested IAA mode (fixed/dynamic).
+ * @reqs: @nr_reqs compress requests.
+ * @pages: Pages to be compressed by IAA.
+ * @dsts: Pre-allocated destination buffers to store results of IAA
+ *        compression. Each element of @dsts must be of size "PAGE_SIZE * 2".
+ * @dlens: Will contain the compressed lengths.
+ * @errors: zero on successful compression of the corresponding
+ *          req, or error code in case of error.
+ * @nr_reqs: The number of requests, up to IAA_CRYPTO_MAX_BATCH_SIZE,
+ *           to be compressed.
+ *
+ * Returns 0 if all compress requests in the batch complete successfully,
+ * -EINVAL otherwise.
+ */
+static int iaa_comp_acompress_batch(
+	struct iaa_compression_ctx *ctx,
+	struct iaa_req *reqs[],
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
+	 * Prepare and submit the batch of iaa_reqs to IAA. IAA will process
+	 * these compress jobs in parallel.
+	 */
+	for (i = 0; i < nr_reqs; ++i) {
+		reqs[i]->src = &inputs[i];
+		reqs[i]->dst = &outputs[i];
+		sg_init_table(reqs[i]->src, 1);
+		sg_set_page(reqs[i]->src, pages[i], PAGE_SIZE, 0);
+
+		/*
+		 * We need PAGE_SIZE * 2 here since there maybe over-compression case,
+		 * and hardware-accelerators may won't check the dst buffer size, so
+		 * giving the dst buffer with enough length to avoid buffer overflow.
+		 */
+		sg_init_one(reqs[i]->dst, dsts[i], PAGE_SIZE * 2);
+		reqs[i]->slen = PAGE_SIZE;
+		reqs[i]->dlen = PAGE_SIZE;
+
+		errors[i] = iaa_comp_acompress(ctx, reqs[i]);
+
+		if (likely(errors[i] == -EINPROGRESS))
+			errors[i] = -EAGAIN;
+		else if (errors[i])
+			err = -EINVAL;
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
+			errors[i] = iaa_comp_poll(ctx, reqs[i]);
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
+	 * clear the IAA_REQ_POLL_FLAG bit on all iaa_reqs.
+	 */
+	iaa_set_req_poll(reqs, nr_reqs, false);
+
+	return err;
+}
+
+/**
+ * This API provides IAA decompress batching functionality for use by swap
+ * modules.
+ *
+ * @ctx:  compression ctx for the requested IAA mode (fixed/dynamic).
+ * @reqs: @nr_reqs decompress requests.
+ * @srcs: The src buffers to be decompressed by IAA.
+ * @pages: The pages to store the decompressed buffers.
+ * @slens: Compressed lengths of @srcs.
+ * @dlens: Will contain the decompressed lengths.
+ * @errors: zero on successful compression of the corresponding
+ *          req, or error code in case of error.
+ * @nr_reqs: The number of pages, up to IAA_CRYPTO_MAX_BATCH_SIZE,
+ *            to be decompressed.
+ *
+ * The caller should check @errors and handle reqs[i]->dlen != PAGE_SIZE.
+ *
+ * Returns 0 if all decompress requests complete successfully,
+ * -EINVAL otherwise.
+ */
+static int iaa_comp_adecompress_batch(
+	struct iaa_compression_ctx *ctx,
+	struct iaa_req *reqs[],
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
+	 * Prepare and submit the batch of iaa_reqs to IAA. IAA will process
+	 * these decompress jobs in parallel.
+	 */
+	for (i = 0; i < nr_reqs; ++i) {
+		reqs[i]->src = &inputs[i];
+		reqs[i]->dst = &outputs[i];
+		sg_init_one(reqs[i]->src, srcs[i], slens[i]);
+		sg_init_table(reqs[i]->dst, 1);
+		sg_set_page(reqs[i]->dst, pages[i], PAGE_SIZE, 0);
+		reqs[i]->slen = slens[i];
+		reqs[i]->dlen = PAGE_SIZE;
+
+		errors[i] = iaa_comp_adecompress(ctx, reqs[i]);
+
+		/*
+		 * If it failed desc allocation/submission, errors[i] can
+		 * be 0 or error value from software decompress.
+		 */
+		if (likely(errors[i] == -EINPROGRESS))
+			errors[i] = -EAGAIN;
+		else if (errors[i])
+			err = -EINVAL;
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
+			errors[i] = iaa_comp_poll(ctx, reqs[i]);
+
+			if (errors[i]) {
+				if (errors[i] == -EAGAIN)
+					decompressions_done = false;
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
+	 * clear the IAA_REQ_POLL_FLAG bit on all iaa_reqs.
+	 */
+	iaa_set_req_poll(reqs, nr_reqs, false);
+
+	return err;
+}
+
 static void compression_ctx_init(struct iaa_compression_ctx *ctx, enum iaa_mode mode)
 {
 	ctx->mode = mode;
@@ -2356,6 +2578,12 @@ u8 iaa_comp_get_modes(char **iaa_mode_names, enum iaa_mode *iaa_modes)
 }
 EXPORT_SYMBOL_GPL(iaa_comp_get_modes);
 
+__always_inline unsigned int iaa_comp_get_max_batch_size(void)
+{
+	return iaa_get_max_batch_size();
+}
+EXPORT_SYMBOL_GPL(iaa_comp_get_max_batch_size);
+
 __always_inline int iaa_comp_compress(enum iaa_mode mode, struct iaa_req *req)
 {
 	return iaa_comp_acompress(iaa_ctx[mode], req);
@@ -2368,6 +2596,33 @@ __always_inline int iaa_comp_decompress(enum iaa_mode mode, struct iaa_req *req)
 }
 EXPORT_SYMBOL_GPL(iaa_comp_decompress);
 
+__always_inline int iaa_comp_compress_batch(
+	enum iaa_mode mode,
+	struct iaa_req *reqs[],
+	struct page *pages[],
+	u8 *dsts[],
+	unsigned int dlens[],
+	int errors[],
+	int nr_reqs)
+{
+	return iaa_comp_acompress_batch(iaa_ctx[mode], reqs, pages, dsts, dlens, errors, nr_reqs);
+}
+EXPORT_SYMBOL_GPL(iaa_comp_compress_batch);
+
+__always_inline int iaa_comp_decompress_batch(
+	enum iaa_mode mode,
+	struct iaa_req *reqs[],
+	u8 *srcs[],
+	struct page *pages[],
+	unsigned int slens[],
+	unsigned int dlens[],
+	int errors[],
+	int nr_reqs)
+{
+	return iaa_comp_adecompress_batch(iaa_ctx[mode], reqs, srcs, pages, slens, dlens, errors, nr_reqs);
+}
+EXPORT_SYMBOL_GPL(iaa_comp_decompress_batch);
+
 /*********************************************
  * Interfaces to crypto_alg and crypto_acomp.
  *********************************************/
@@ -2382,9 +2637,19 @@ static __always_inline int iaa_comp_acompress_main(struct acomp_req *areq)
 	if (iaa_alg_is_registered(crypto_tfm_alg_driver_name(tfm), &idx)) {
 		ctx = iaa_ctx[idx];
 
-		acomp_to_iaa(areq, &req, ctx);
-		ret = iaa_comp_acompress(ctx, &req);
-		iaa_to_acomp(&req, areq);
+		if (likely(!areq->kernel_data)) {
+			acomp_to_iaa(areq, &req, ctx);
+			ret = iaa_comp_acompress(ctx, &req);
+			iaa_to_acomp(&req, areq);
+			return ret;
+		} else {
+			struct iaa_batch_comp_data *bcdata = (struct iaa_batch_comp_data *)areq->kernel_data;
+			struct iaa_batch_ctx *cpu_ctx = raw_cpu_ptr(iaa_batch_ctx);
+
+			return iaa_comp_acompress_batch(ctx, cpu_ctx->reqs, bcdata->pages,
+							bcdata->dsts, bcdata->dlens,
+							bcdata->errors, bcdata->nr_comps);
+		}
 	}
 
 	return ret;
@@ -2400,9 +2665,19 @@ static __always_inline int iaa_comp_adecompress_main(struct acomp_req *areq)
 	if (iaa_alg_is_registered(crypto_tfm_alg_driver_name(tfm), &idx)) {
 		ctx = iaa_ctx[idx];
 
-		acomp_to_iaa(areq, &req, ctx);
-		ret = iaa_comp_adecompress(ctx, &req);
-		iaa_to_acomp(&req, areq);
+		if (likely(!areq->kernel_data)) {
+			acomp_to_iaa(areq, &req, ctx);
+			ret = iaa_comp_adecompress(ctx, &req);
+			iaa_to_acomp(&req, areq);
+			return ret;
+		} else {
+			struct iaa_batch_decomp_data *bddata = (struct iaa_batch_decomp_data *)areq->kernel_data;
+			struct iaa_batch_ctx *cpu_ctx = raw_cpu_ptr(iaa_batch_ctx);
+
+			return iaa_comp_adecompress_batch(ctx, cpu_ctx->reqs, bddata->srcs, bddata->pages,
+							  bddata->slens, bddata->dlens,
+							  bddata->errors, bddata->nr_decomps);
+		}
 	}
 
 	return ret;
@@ -2698,9 +2973,31 @@ static struct idxd_device_driver iaa_crypto_driver = {
  * Module init/exit.
  ********************/
 
+static void iaa_batch_ctx_dealloc(void)
+{
+	int cpu;
+	u8 i;
+
+	if (!iaa_batch_ctx)
+		return;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		struct iaa_batch_ctx *cpu_ctx = per_cpu_ptr(iaa_batch_ctx, cpu);
+
+		if (cpu_ctx && cpu_ctx->reqs) {
+			for (i = 0; i < IAA_CRYPTO_MAX_BATCH_SIZE; ++i)
+				kfree(cpu_ctx->reqs[i]);
+			kfree(cpu_ctx->reqs);
+		}
+	}
+
+	free_percpu(iaa_batch_ctx);
+}
+
 static int __init iaa_crypto_init_module(void)
 {
-	int ret = 0;
+	int cpu, ret = 0;
+	u8 i;
 
 	INIT_LIST_HEAD(&iaa_devices);
 
@@ -2755,6 +3052,35 @@ static int __init iaa_crypto_init_module(void)
 		goto err_sync_attr_create;
 	}
 
+	/* Allocate batching resources for iaa_crypto. */
+	iaa_batch_ctx = alloc_percpu_gfp(struct iaa_batch_ctx, GFP_KERNEL | __GFP_ZERO);
+	if (!iaa_batch_ctx) {
+		pr_err("Failed to allocate per-cpu iaa_batch_ctx\n");
+		goto batch_ctx_fail;
+	}
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		struct iaa_batch_ctx *cpu_ctx = per_cpu_ptr(iaa_batch_ctx, cpu);
+
+		cpu_ctx->reqs = kcalloc_node(IAA_CRYPTO_MAX_BATCH_SIZE,
+					     sizeof(struct iaa_req *),
+					     GFP_KERNEL,
+					     cpu_to_node(cpu));
+
+		if (!cpu_ctx->reqs)
+			goto reqs_fail;
+
+		for (i = 0; i < IAA_CRYPTO_MAX_BATCH_SIZE; ++i) {
+			cpu_ctx->reqs[i] = kzalloc_node(sizeof(struct iaa_req),
+							GFP_KERNEL,
+							cpu_to_node(cpu));
+			if (!cpu_ctx->reqs[i]) {
+				pr_err("could not alloc iaa_req reqs[%d]\n", i);
+				goto reqs_fail;
+			}
+		}
+	}
+
 	if (iaa_crypto_debugfs_init())
 		pr_warn("debugfs init failed, stats not available\n");
 
@@ -2762,6 +3088,11 @@ static int __init iaa_crypto_init_module(void)
 out:
 	return ret;
 
+reqs_fail:
+	iaa_batch_ctx_dealloc();
+batch_ctx_fail:
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_sync_mode);
 err_sync_attr_create:
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_verify_compress);
@@ -2788,6 +3119,7 @@ static void __exit iaa_crypto_cleanup_module(void)
 	iaa_unregister_acomp_compression_device();
 	iaa_unregister_compression_device();
 
+	iaa_batch_ctx_dealloc();
 	iaa_crypto_debugfs_cleanup();
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_sync_mode);
diff --git a/include/linux/iaa_comp.h b/include/linux/iaa_comp.h
index ec061315f4772..cbd78f83668d5 100644
--- a/include/linux/iaa_comp.h
+++ b/include/linux/iaa_comp.h
@@ -25,6 +25,27 @@ struct iaa_req {
 	void *drv_data; /* for driver internal use */
 };
 
+/*
+ * These next two data structures should exactly mirror the definitions of
+ * @struct swap_batch_comp_data and @struct swap_batch_decomp_data in mm/swap.h.
+ */
+struct iaa_batch_comp_data {
+	struct page **pages;
+	u8 **dsts;
+	unsigned int *dlens;
+	int *errors;
+	u8 nr_comps;
+};
+
+struct iaa_batch_decomp_data {
+	u8 **srcs;
+	struct page **pages;
+	unsigned int *slens;
+	unsigned int *dlens;
+	int *errors;
+	u8 nr_decomps;
+};
+
 extern bool iaa_comp_enabled(void);
 
 extern enum iaa_mode iaa_comp_get_compressor_mode(const char *compressor_name);
@@ -35,10 +56,31 @@ extern u8 iaa_comp_get_modes(char **iaa_mode_names, enum iaa_mode *iaa_modes);
 
 extern void iaa_comp_put_modes(char **iaa_mode_names, enum iaa_mode *iaa_modes, u8 nr_modes);
 
+extern unsigned int iaa_comp_get_max_batch_size(void);
+
 extern int iaa_comp_compress(enum iaa_mode mode, struct iaa_req *req);
 
 extern int iaa_comp_decompress(enum iaa_mode mode, struct iaa_req *req);
 
+extern int iaa_comp_compress_batch(
+	enum iaa_mode mode,
+	struct iaa_req *reqs[],
+	struct page *pages[],
+	u8 *dsts[],
+	unsigned int dlens[],
+	int errors[],
+	int nr_reqs);
+
+extern int iaa_comp_decompress_batch(
+	enum iaa_mode mode,
+	struct iaa_req *reqs[],
+	u8 *srcs[],
+	struct page *pages[],
+	unsigned int slens[],
+	unsigned int dlens[],
+	int errors[],
+	int nr_reqs);
+
 #else /* CONFIG_CRYPTO_DEV_IAA_CRYPTO */
 
 enum iaa_mode {
@@ -71,6 +113,11 @@ static inline void iaa_comp_put_modes(char **iaa_mode_names, enum iaa_mode *iaa_
 {
 }
 
+static inline unsigned int iaa_comp_get_max_batch_size(void)
+{
+	return 0;
+}
+
 static inline int iaa_comp_compress(enum iaa_mode mode, struct iaa_req *req)
 {
 	return -EINVAL;
@@ -81,6 +128,31 @@ static inline int iaa_comp_decompress(enum iaa_mode mode, struct iaa_req *req)
 	return -EINVAL;
 }
 
+static inline int iaa_comp_compress_batch(
+	enum iaa_mode mode,
+	struct iaa_req *reqs[],
+	struct page *pages[],
+	u8 *dsts[],
+	unsigned int dlens[],
+	int errors[],
+	int nr_reqs)
+{
+	return false;
+}
+
+static inline int iaa_comp_decompress_batch(
+	enum iaa_mode mode,
+	struct iaa_req *reqs[],
+	u8 *srcs[],
+	struct page *pages[],
+	unsigned int slens[],
+	unsigned int dlens[],
+	int errors[],
+	int nr_reqs)
+{
+	return false;
+}
+
 #endif /* CONFIG_CRYPTO_DEV_IAA_CRYPTO */
 
 #endif
-- 
2.27.0


