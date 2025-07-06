Return-Path: <linux-kernel+bounces-716449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2451AF86AC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 06:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CB56E3826
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 04:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70162571B2;
	Fri,  4 Jul 2025 04:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UiGcpK5l"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9252221739;
	Fri,  4 Jul 2025 04:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751603022; cv=none; b=KRjgArLpdVsu1Uxm4Fo9RM070xZxDL7g4gF68+ANL9EEZ86vs9hWJTguOjxhyccJosKJXSGBUPWDhqWtXv5R5X/ZEGribf3Jk8X+8VncB3c0x7H1JoNu0mnD3o/Ls2pvP5G1Qp4HufSX3BFWFNrKaNsMASTGiy+hRh5L1le7ZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751603022; c=relaxed/simple;
	bh=jBYqtIdn2g/qmc5lPRJuQdSpcp+B6gPWEJvQ/KJK+XM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aB66ikAcDnpRn3AQAlA2/r6qbXMXmc7tTRG0rBBQ+6ZHWtTikspMxr29CHx/3NCPtcDRlRENkBNmq818e1AVUXOE+VtrQG70zUjuKL2DiUistnBOuFCuQLOJve5RceGk06StyzN4g1/XytYKpAfZ3cp5cgx/deaY6OAFgXcv1F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UiGcpK5l; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751603021; x=1783139021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jBYqtIdn2g/qmc5lPRJuQdSpcp+B6gPWEJvQ/KJK+XM=;
  b=UiGcpK5lLI9t03hja0kvHTaWrtG5Rqrk8tAGvkTLzaR2P29ym37S3gmV
   zY4flL2D34UHrbO4EDkr+w39I4/DGj0zay37tM6tvIPTmezcmjWo6xqP8
   ZtHNAPLkdDjG7/NRx8GKFxuKWbG2+i2lrRxPqOnR5wfFn4+jbr5YnKoYJ
   o72VArdOo9QG0YYbPXNAxz5Ywyqa4WCO7YXzg9CfK31F83qox9nRuTvHG
   7Kb7W+jtTshL/ca/O9uR2CoPMr2rLFY2EcTdYfm0U8RFNL40IXZTUWma2
   2gjSKby8ZiuKJfjP3m/XCVN30oWhAxVhfnH/AGJUMmWNr7e6Dx/x/arTK
   Q==;
X-CSE-ConnectionGUID: y6BM6nPiQr+PYcGglM1ivQ==
X-CSE-MsgGUID: LfRWKphxRd2ALySenswyoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53909182"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="53909182"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 21:23:27 -0700
X-CSE-ConnectionGUID: BvfS0WFSRYe9LZaCzY9dhw==
X-CSE-MsgGUID: VuRQ9QxVS76JynlnivYE6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="153968714"
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
Subject: [PATCH v10 18/25] crypto: acomp - Add crypto_acomp_batch_size() to get an algorithm's batch-size.
Date: Thu,  3 Jul 2025 21:23:16 -0700
Message-Id: <20250704042323.10318-19-kanchana.p.sridhar@intel.com>
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

This commit adds a get_batch_size() interface to:

  struct acomp_alg
  struct crypto_acomp

A crypto_acomp compression algorithm that supports batching of compressions
and decompressions must provide an implementation for this API to return
the maximum batch-size that the compressor supports, so that kernel
users of crypto_acomp, such as zswap, can allocate resources for
submitting multiple compress/decompress jobs that can be batched, and
invoke batching of [de]compressions.

A new helper function acomp_has_async_batching() can be invoked to query
if a crypto_acomp implements get_batch_size().

The new crypto_acomp_batch_size() API uses this helper function to return
the batch-size for compressors that implement get_batch_size(). If no
implementation is provided by the crypto_acomp, a default of "1" is
returned for the batch-size.

zswap can invoke crypto_acomp_batch_size() to query the maximum number
of requests that can be batch [de]compressed. Based on this, zswap
can use the minimum of any zswap-specific upper limits for batch-size
and the compressor's max batch-size, to allocate batching resources.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 crypto/acompress.c                  |  1 +
 include/crypto/acompress.h          | 27 +++++++++++++++++++++++++++
 include/crypto/internal/acompress.h |  3 +++
 3 files changed, 31 insertions(+)

diff --git a/crypto/acompress.c b/crypto/acompress.c
index be28cbfd22e32..f440724719655 100644
--- a/crypto/acompress.c
+++ b/crypto/acompress.c
@@ -105,6 +105,7 @@ static int crypto_acomp_init_tfm(struct crypto_tfm *tfm)
 
 	acomp->compress = alg->compress;
 	acomp->decompress = alg->decompress;
+	acomp->get_batch_size = alg->get_batch_size;
 	acomp->reqsize = alg->base.cra_reqsize;
 
 	acomp->base.exit = crypto_acomp_exit_tfm;
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index 0312322d2ca03..898104745cd24 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -108,6 +108,8 @@ struct acomp_req {
  *
  * @compress:		Function performs a compress operation
  * @decompress:		Function performs a de-compress operation
+ * @get_batch_size:	Maximum batch-size for batching compress/decompress
+ *			operations.
  * @reqsize:		Context size for (de)compression requests
  * @fb:			Synchronous fallback tfm
  * @base:		Common crypto API algorithm data structure
@@ -115,6 +117,7 @@ struct acomp_req {
 struct crypto_acomp {
 	int (*compress)(struct acomp_req *req);
 	int (*decompress)(struct acomp_req *req);
+	unsigned int (*get_batch_size)(void);
 	unsigned int reqsize;
 	struct crypto_tfm base;
 };
@@ -205,6 +208,13 @@ static inline bool acomp_is_async(struct crypto_acomp *tfm)
 	       CRYPTO_ALG_ASYNC;
 }
 
+static inline bool acomp_has_async_batching(struct crypto_acomp *tfm)
+{
+	return (acomp_is_async(tfm) &&
+		(crypto_comp_alg_common(tfm)->base.cra_flags & CRYPTO_ALG_TYPE_ACOMPRESS) &&
+		tfm->get_batch_size);
+}
+
 static inline struct crypto_acomp *crypto_acomp_reqtfm(struct acomp_req *req)
 {
 	return __crypto_acomp_tfm(req->base.tfm);
@@ -545,6 +555,23 @@ int crypto_acomp_compress(struct acomp_req *req);
  */
 int crypto_acomp_decompress(struct acomp_req *req);
 
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
 static inline struct acomp_req *acomp_request_on_stack_init(
 	char *buf, struct crypto_acomp *tfm)
 {
diff --git a/include/crypto/internal/acompress.h b/include/crypto/internal/acompress.h
index ffffd88bbbad3..2325ee18e7a10 100644
--- a/include/crypto/internal/acompress.h
+++ b/include/crypto/internal/acompress.h
@@ -28,6 +28,8 @@
  *
  * @compress:	Function performs a compress operation
  * @decompress:	Function performs a de-compress operation
+ * @get_batch_size:	Maximum batch-size for batching compress/decompress
+ *			operations.
  * @init:	Initialize the cryptographic transformation object.
  *		This function is used to initialize the cryptographic
  *		transformation object. This function is called only once at
@@ -46,6 +48,7 @@
 struct acomp_alg {
 	int (*compress)(struct acomp_req *req);
 	int (*decompress)(struct acomp_req *req);
+	unsigned int (*get_batch_size)(void);
 	int (*init)(struct crypto_acomp *tfm);
 	void (*exit)(struct crypto_acomp *tfm);
 
-- 
2.27.0


