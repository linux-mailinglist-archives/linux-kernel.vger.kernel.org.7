Return-Path: <linux-kernel+bounces-640368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33766AB03F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 21:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B328CB22C5B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 19:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF8428D836;
	Thu,  8 May 2025 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxis3f6D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3CD28A720;
	Thu,  8 May 2025 19:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746733307; cv=none; b=p0SWAdWMX7eph0OPqoUsxrZxj48Jv7iQ96LteAfQfoayOUO3fzDjFECk1sOpqiejWcV2rvXCwH/1OnHfqgmmDVVkUDxDxci1T7Wn5ibLPy6kbkb4bc/hwIDNLuMEaVboDq/+VN4U+r3yKTM7ams5rx8uDeiyXUzt7B+4rT3N1W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746733307; c=relaxed/simple;
	bh=cw35xIKM3GQ7IYN44nqMVxUAoNpG2Du37jUAD6lMlcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=okJmoSHo8OgF6XsiwYxYaqafu/UJ4wgJ7JwEwreF3O9agDsOOTg/upuDdPKFe+HqC/CAXjQhPXfdoZIbCUyDn63cC/3QZbE60qlW/CGGG4wfxbkGBPSwNHii7OZkj1D2rrRQ2LkMMbCxkYLdyMDWSG4XAzCinRrX7LBWzXT1T7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxis3f6D; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746733306; x=1778269306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cw35xIKM3GQ7IYN44nqMVxUAoNpG2Du37jUAD6lMlcs=;
  b=bxis3f6Dr4pj0BZzEdLSMDtJ2GLtUXvn9xvgUbW+P02ntkgECa1dpM/W
   M2aYKJ9cjPS1DwjRNzJxoN0TbEeg16OmZWtron+dmdBbL8QPdoF0/8IZ3
   QVuYK7Wtd8s2l+t89aDDsdZ7Pbi6OT6Oe2EWxtZ3t45snvT6ds2tdOWYI
   hI+DZoSJrZcj+gOJ7gOdB8tKtepkkDYk8/Yy4iTOm96ucqwK6aXU27Xly
   fi5ehlrRepB3y4+JLzonPXxT6XJ2JFszyI1GanYCStWhWakjf4wR9uJiJ
   r6BIK5eOB03F0Mo78A0jH/8dXg6M5r3XuMEt0DZRpReysCU7qL4ATQYRr
   g==;
X-CSE-ConnectionGUID: B+56qbRfSBmt9GK58i/Msg==
X-CSE-MsgGUID: BaB6jL3vTHmu/5W+Hrs32A==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48454700"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="48454700"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 12:41:42 -0700
X-CSE-ConnectionGUID: YpFzO/86RtSHtUCgGnfk6g==
X-CSE-MsgGUID: 050zpBjPSv2w1g071KVj/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="136880863"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by fmviesa010.fm.intel.com with ESMTP; 08 May 2025 12:41:41 -0700
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
Subject: [PATCH v9 10/19] crypto: acomp - New interfaces to facilitate batching support in acomp & drivers.
Date: Thu,  8 May 2025 12:41:25 -0700
Message-Id: <20250508194134.28392-11-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250508194134.28392-1-kanchana.p.sridhar@intel.com>
References: <20250508194134.28392-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds get_batch_size(), batch_compress() and batch_decompress()
interfaces to:

  struct acomp_alg
  struct crypto_acomp

A crypto_acomp compression algorithm that supports batching of compressions
and decompressions must provide implementations for these API, so that a
higher level module based on crypto_acomp, such as zswap, can allocate
resources for submitting multiple compress/decompress jobs that can be
batched, and invoke batching of [de]compressions.

A new helper function acomp_has_async_batching() can be invoked to query if
a crypto_acomp has registered these batching interfaces.

Further, zswap can invoke the newly added "crypto_acomp_batch_size()"
API to query the maximum number of requests that can be batch
[de]compressed. crypto_acomp_batch_size() returns 1 if the acomp has not
provided an implementation for get_batch_size(). Based on this, zswap
can use the minimum of any zswap-specific upper limits for batch-size
and the compressor's max batch-size, to allocate batching resources.

This allows the iaa_crypto Intel IAA driver to register implementations for
the get_batch_size(), batch_compress() and batch_decompress() acomp_alg
interfaces, that can subsequently be invoked from zswap to
compress/decompress pages in parallel in the IAA hardware accelerator to
improve swapout/swapin performance, through these newly added
corresponding crypto_acomp API:

  crypto_acomp_batch_size()
  crypto_acomp_batch_compress()
  crypto_acomp_batch_decompress()

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 crypto/acompress.c                  |   3 +
 include/crypto/acompress.h          | 107 ++++++++++++++++++++++++++++
 include/crypto/internal/acompress.h |  20 ++++++
 3 files changed, 130 insertions(+)

diff --git a/crypto/acompress.c b/crypto/acompress.c
index d08e0fe8cd9e..c7cca5596acf 100644
--- a/crypto/acompress.c
+++ b/crypto/acompress.c
@@ -95,6 +95,9 @@ static int crypto_acomp_init_tfm(struct crypto_tfm *tfm)
 
 	acomp->compress = alg->compress;
 	acomp->decompress = alg->decompress;
+	acomp->get_batch_size = alg->get_batch_size;
+	acomp->batch_compress = alg->batch_compress;
+	acomp->batch_decompress = alg->batch_decompress;
 	acomp->reqsize = alg->reqsize;
 
 	acomp->base.exit = crypto_acomp_exit_tfm;
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index 939e51d122b0..e50f3e71ba58 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -120,6 +120,10 @@ struct acomp_req {
  *
  * @compress:		Function performs a compress operation
  * @decompress:		Function performs a de-compress operation
+ * @get_batch_size:	Maximum batch-size for batching compress/decompress
+ *			operations.
+ * @batch_compress:	Function performs a batch compress operation.
+ * @batch_decompress:	Function performs a batch decompress operation.
  * @reqsize:		Context size for (de)compression requests
  * @fb:			Synchronous fallback tfm
  * @base:		Common crypto API algorithm data structure
@@ -127,6 +131,22 @@ struct acomp_req {
 struct crypto_acomp {
 	int (*compress)(struct acomp_req *req);
 	int (*decompress)(struct acomp_req *req);
+	unsigned int (*get_batch_size)(void);
+	bool (*batch_compress)(
+		struct acomp_req *reqs[],
+		struct page *pages[],
+		u8 *dsts[],
+		unsigned int dlens[],
+		int errors[],
+		int nr_reqs);
+	bool (*batch_decompress)(
+		struct acomp_req *reqs[],
+		u8 *srcs[],
+		struct page *pages[],
+		unsigned int slens[],
+		unsigned int dlens[],
+		int errors[],
+		int nr_reqs);
 	unsigned int reqsize;
 	struct crypto_acomp *fb;
 	struct crypto_tfm base;
@@ -224,6 +244,13 @@ static inline bool acomp_is_async(struct crypto_acomp *tfm)
 	       CRYPTO_ALG_ASYNC;
 }
 
+static inline bool acomp_has_async_batching(struct crypto_acomp *tfm)
+{
+	return (acomp_is_async(tfm) &&
+		(crypto_comp_alg_common(tfm)->base.cra_flags & CRYPTO_ALG_TYPE_ACOMPRESS) &&
+		tfm->get_batch_size && tfm->batch_compress && tfm->batch_decompress);
+}
+
 static inline struct crypto_acomp *crypto_acomp_reqtfm(struct acomp_req *req)
 {
 	return __crypto_acomp_tfm(req->base.tfm);
@@ -595,4 +622,84 @@ static inline struct acomp_req *acomp_request_on_stack_init(
 	return req;
 }
 
+/**
+ * crypto_acomp_batch_size() -- Get the algorithm's batch size
+ *
+ * Function returns the algorithm's batch size for batching operations
+ *
+ * @tfm:	ACOMPRESS tfm handle allocated with crypto_alloc_acomp()
+ *
+ * Return:	crypto_acomp's batch size.
+ */
+static inline unsigned int crypto_acomp_batch_size(struct crypto_acomp *tfm)
+{
+	if (acomp_has_async_batching(tfm))
+		return tfm->get_batch_size();
+
+	return 1;
+}
+
+/**
+ * crypto_acomp_batch_compress() -- Invoke asynchronous compress of a batch
+ * of requests.
+ *
+ * @reqs: @nr_reqs asynchronous compress requests.
+ * @pages: Pages to be compressed by IAA.
+ * @dsts: Pre-allocated destination buffers to store results of compression.
+ *        Each element of @dsts must be of size "PAGE_SIZE * 2".
+ * @dlens: Will contain the compressed lengths for @pages.
+ * @errors: zero on successful compression of the corresponding
+ *          req, or error code in case of error.
+ * @nr_reqs: The number of requests in @reqs, up to IAA_CRYPTO_MAX_BATCH_SIZE,
+ *           to be compressed.
+ *
+ * Returns true if all compress requests in the batch complete successfully,
+ * false otherwise.
+ */
+static inline bool crypto_acomp_batch_compress(
+	struct acomp_req *reqs[],
+	struct page *pages[],
+	u8 *dsts[],
+	unsigned int dlens[],
+	int errors[],
+	int nr_reqs)
+{
+	struct crypto_acomp *tfm = crypto_acomp_reqtfm(reqs[0]);
+
+	return tfm->batch_compress(reqs, pages, dsts, dlens, errors, nr_reqs);
+}
+
+/**
+ * crypto_acomp_batch_decompress() -- Invoke asynchronous decompress of a batch
+ * of requests.
+ *
+ * @reqs: @nr_reqs asynchronous decompress requests.
+ * @srcs: Source buffers to to be decompressed.
+ * @pages: Destination pages corresponding to @srcs.
+ * @slens: Buffer lengths for @srcs.
+ * @dlens: Will contain the decompressed lengths for @srcs.
+ *	   For batch decompressions, the caller must enforce additional
+ *	   semantics such as, BUG_ON(dlens[i] != PAGE_SIZE) assertions.
+ * @errors: zero on successful decompression of the corresponding
+ *          req, or error code in case of error.
+ * @nr_reqs: The number of requests in @reqs, up to IAA_CRYPTO_MAX_BATCH_SIZE,
+ *           to be decompressed.
+ *
+ * Returns true if all decompress requests in the batch complete successfully,
+ * false otherwise.
+ */
+static inline bool crypto_acomp_batch_decompress(
+	struct acomp_req *reqs[],
+	u8 *srcs[],
+	struct page *pages[],
+	unsigned int slens[],
+	unsigned int dlens[],
+	int errors[],
+	int nr_reqs)
+{
+	struct crypto_acomp *tfm = crypto_acomp_reqtfm(reqs[0]);
+
+	return tfm->batch_decompress(reqs, srcs, pages, slens, dlens, errors, nr_reqs);
+}
+
 #endif
diff --git a/include/crypto/internal/acompress.h b/include/crypto/internal/acompress.h
index b69d818d7e68..891e40831af8 100644
--- a/include/crypto/internal/acompress.h
+++ b/include/crypto/internal/acompress.h
@@ -23,6 +23,10 @@
  *
  * @compress:	Function performs a compress operation
  * @decompress:	Function performs a de-compress operation
+ * @get_batch_size:	Maximum batch-size for batching compress/decompress
+ *			operations.
+ * @batch_compress:	Function performs a batch compress operation.
+ * @batch_decompress:	Function performs a batch decompress operation.
  * @init:	Initialize the cryptographic transformation object.
  *		This function is used to initialize the cryptographic
  *		transformation object. This function is called only once at
@@ -43,6 +47,22 @@
 struct acomp_alg {
 	int (*compress)(struct acomp_req *req);
 	int (*decompress)(struct acomp_req *req);
+	unsigned int (*get_batch_size)(void);
+	bool (*batch_compress)(
+		struct acomp_req *reqs[],
+		struct page *pages[],
+		u8 *dsts[],
+		unsigned int dlens[],
+		int errors[],
+		int nr_reqs);
+	bool (*batch_decompress)(
+		struct acomp_req *reqs[],
+		u8 *srcs[],
+		struct page *pages[],
+		unsigned int slens[],
+		unsigned int dlens[],
+		int errors[],
+		int nr_reqs);
 	int (*init)(struct crypto_acomp *tfm);
 	void (*exit)(struct crypto_acomp *tfm);
 
-- 
2.27.0


