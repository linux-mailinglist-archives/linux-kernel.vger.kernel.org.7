Return-Path: <linux-kernel+bounces-627874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1DFAA5621
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 22:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A411B67F18
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 20:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88F52C0338;
	Wed, 30 Apr 2025 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXD3V6xT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B65299529;
	Wed, 30 Apr 2025 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046391; cv=none; b=GcTPTCS5Q9FBGq390V5Gkt4oKZfMpbEHe9AWfMeB+OEkZMjBrJOq1/vMBc+IGkgSCUbcwHi4PImxyxplS8lz6y9HrNodlpastmAH7MCzCfiYqAsy4QogvWrYxIzJVakVeiOH532/Kqo3gBx9aOnAitWsHL8KARpCacVFcCAOjG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046391; c=relaxed/simple;
	bh=xDsbv3ls5X3YM0JiXefAsh4WsqCsb4fO+p9sSZmG6EM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hgUtrP55Y5MBbUbDKLgZHNEFz8qCPcJulzsRt77xST5mZcupnM+/bVE/A4logGFJOSkQ4LlKHItiglRIBHtRX4K6MR6FAHWFFsqgXBUcNIZaVYvQoJWSkEoqC2r5Ctl1pbzVDgYW+c9RjFzy4pUyoeSykY3+cK2NOXWZumgT4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXD3V6xT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746046389; x=1777582389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xDsbv3ls5X3YM0JiXefAsh4WsqCsb4fO+p9sSZmG6EM=;
  b=UXD3V6xTrl9Ravg9xG3fU3VT4drqohgVqP8VtUDmDSRu2pPJU5GS33hO
   yBDgrRMrbCgN4b+R0eXDvOZ+5eGd9QStPv0+reMqUamNeQQEaMU1nv2yM
   ema2w7BbQGQ6BnC4eZe+C2Hp3NuCjpzYyZXAduKpIr3STv5KZkUcom+qF
   9za2A+fG/VBaL0mG6wx2XY5oMNhvToYUPbrA6Xu5QQBIghU+0K/OEQJBS
   SclQtboLYV18O5vdEFhSS1nXk81yUu3ln9uOnD5WlA1l++EN5fdF5JlgY
   Fj08yu2w3aG+VgqBXaLaIH2z0Ey3cKftBr+5rORpfRZEDaF/TCOaV8RFe
   A==;
X-CSE-ConnectionGUID: 4MQQ1n/qQZ+jIcouyGej4w==
X-CSE-MsgGUID: 5TpzEuu4RreCuqNnyFi33g==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51388472"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="51388472"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 13:53:08 -0700
X-CSE-ConnectionGUID: +4H+II2cSBeqdhBHgUoxww==
X-CSE-MsgGUID: 64YfAg3RStmUm35BzUBlBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="138248870"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by fmviesa003.fm.intel.com with ESMTP; 30 Apr 2025 13:53:06 -0700
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
Subject: [PATCH v9 01/19] crypto: acomp - Remove request chaining
Date: Wed, 30 Apr 2025 13:52:47 -0700
Message-Id: <20250430205305.22844-2-kanchana.p.sridhar@intel.com>
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

Request chaining requires the user to do too much book keeping.
Remove it from acomp.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/acompress.c                  | 117 ++++++++--------------------
 crypto/scompress.c                  |  18 +----
 include/crypto/acompress.h          |  14 ----
 include/crypto/internal/acompress.h |   5 --
 4 files changed, 35 insertions(+), 119 deletions(-)

diff --git a/crypto/acompress.c b/crypto/acompress.c
index f7a3fbe5447e..82fb3c04e68f 100644
--- a/crypto/acompress.c
+++ b/crypto/acompress.c
@@ -161,7 +161,6 @@ static void acomp_save_req(struct acomp_req *req, crypto_completion_t cplt)
 	state->data = req->base.data;
 	req->base.complete = cplt;
 	req->base.data = state;
-	state->req0 = req;
 }
 
 static void acomp_restore_req(struct acomp_req *req)
@@ -172,23 +171,20 @@ static void acomp_restore_req(struct acomp_req *req)
 	req->base.data = state->data;
 }
 
-static void acomp_reqchain_virt(struct acomp_req_chain *state, int err)
+static void acomp_reqchain_virt(struct acomp_req *req)
 {
-	struct acomp_req *req = state->cur;
+	struct acomp_req_chain *state = &req->chain;
 	unsigned int slen = req->slen;
 	unsigned int dlen = req->dlen;
 
-	req->base.err = err;
-	state = &req->chain;
-
 	if (state->flags & CRYPTO_ACOMP_REQ_SRC_VIRT)
 		acomp_request_set_src_dma(req, state->src, slen);
 	else if (state->flags & CRYPTO_ACOMP_REQ_SRC_FOLIO)
-		acomp_request_set_src_folio(req, state->sfolio, state->soff, slen);
+		acomp_request_set_src_folio(req, state->sfolio, req->soff, slen);
 	if (state->flags & CRYPTO_ACOMP_REQ_DST_VIRT)
 		acomp_request_set_dst_dma(req, state->dst, dlen);
 	else if (state->flags & CRYPTO_ACOMP_REQ_DST_FOLIO)
-		acomp_request_set_dst_folio(req, state->dfolio, state->doff, dlen);
+		acomp_request_set_dst_folio(req, state->dfolio, req->doff, dlen);
 }
 
 static void acomp_virt_to_sg(struct acomp_req *req)
@@ -213,7 +209,6 @@ static void acomp_virt_to_sg(struct acomp_req *req)
 		size_t off = req->soff;
 
 		state->sfolio = folio;
-		state->soff = off;
 		sg_init_table(&state->ssg, 1);
 		sg_set_page(&state->ssg, folio_page(folio, off / PAGE_SIZE),
 			    slen, off % PAGE_SIZE);
@@ -233,7 +228,6 @@ static void acomp_virt_to_sg(struct acomp_req *req)
 		size_t off = req->doff;
 
 		state->dfolio = folio;
-		state->doff = off;
 		sg_init_table(&state->dsg, 1);
 		sg_set_page(&state->dsg, folio_page(folio, off / PAGE_SIZE),
 			    dlen, off % PAGE_SIZE);
@@ -241,8 +235,7 @@ static void acomp_virt_to_sg(struct acomp_req *req)
 	}
 }
 
-static int acomp_do_nondma(struct acomp_req_chain *state,
-			   struct acomp_req *req)
+static int acomp_do_nondma(struct acomp_req *req, bool comp)
 {
 	u32 keep = CRYPTO_ACOMP_REQ_SRC_VIRT |
 		   CRYPTO_ACOMP_REQ_SRC_NONDMA |
@@ -259,7 +252,7 @@ static int acomp_do_nondma(struct acomp_req_chain *state,
 	fbreq->slen = req->slen;
 	fbreq->dlen = req->dlen;
 
-	if (state->op == crypto_acomp_reqtfm(req)->compress)
+	if (comp)
 		err = crypto_acomp_compress(fbreq);
 	else
 		err = crypto_acomp_decompress(fbreq);
@@ -268,114 +261,70 @@ static int acomp_do_nondma(struct acomp_req_chain *state,
 	return err;
 }
 
-static int acomp_do_one_req(struct acomp_req_chain *state,
-			    struct acomp_req *req)
+static int acomp_do_one_req(struct acomp_req *req, bool comp)
 {
-	state->cur = req;
-
 	if (acomp_request_isnondma(req))
-		return acomp_do_nondma(state, req);
+		return acomp_do_nondma(req, comp);
 
 	acomp_virt_to_sg(req);
-	return state->op(req);
+	return comp ? crypto_acomp_reqtfm(req)->compress(req) :
+		      crypto_acomp_reqtfm(req)->decompress(req);
 }
 
-static int acomp_reqchain_finish(struct acomp_req *req0, int err, u32 mask)
+static int acomp_reqchain_finish(struct acomp_req *req, int err)
 {
-	struct acomp_req_chain *state = req0->base.data;
-	struct acomp_req *req = state->cur;
-	struct acomp_req *n;
-
-	acomp_reqchain_virt(state, err);
-
-	if (req != req0)
-		list_add_tail(&req->base.list, &req0->base.list);
-
-	list_for_each_entry_safe(req, n, &state->head, base.list) {
-		list_del_init(&req->base.list);
-
-		req->base.flags &= mask;
-		req->base.complete = acomp_reqchain_done;
-		req->base.data = state;
-
-		err = acomp_do_one_req(state, req);
-
-		if (err == -EINPROGRESS) {
-			if (!list_empty(&state->head))
-				err = -EBUSY;
-			goto out;
-		}
-
-		if (err == -EBUSY)
-			goto out;
-
-		acomp_reqchain_virt(state, err);
-		list_add_tail(&req->base.list, &req0->base.list);
-	}
-
-	acomp_restore_req(req0);
-
-out:
+	acomp_reqchain_virt(req);
+	acomp_restore_req(req);
 	return err;
 }
 
 static void acomp_reqchain_done(void *data, int err)
 {
-	struct acomp_req_chain *state = data;
-	crypto_completion_t compl = state->compl;
+	struct acomp_req *req = data;
+	crypto_completion_t compl;
 
-	data = state->data;
+	compl = req->chain.compl;
+	data = req->chain.data;
 
-	if (err == -EINPROGRESS) {
-		if (!list_empty(&state->head))
-			return;
+	if (err == -EINPROGRESS)
 		goto notify;
-	}
 
-	err = acomp_reqchain_finish(state->req0, err,
-				    CRYPTO_TFM_REQ_MAY_BACKLOG);
-	if (err == -EBUSY)
-		return;
+	err = acomp_reqchain_finish(req, err);
 
 notify:
 	compl(data, err);
 }
 
-static int acomp_do_req_chain(struct acomp_req *req,
-			      int (*op)(struct acomp_req *req))
+static int acomp_do_req_chain(struct acomp_req *req, bool comp)
 {
-	struct crypto_acomp *tfm = crypto_acomp_reqtfm(req);
-	struct acomp_req_chain *state;
 	int err;
 
-	if (crypto_acomp_req_chain(tfm) ||
-	    (!acomp_request_chained(req) && acomp_request_issg(req)))
-		return op(req);
-
 	acomp_save_req(req, acomp_reqchain_done);
-	state = req->base.data;
 
-	state->op = op;
-	state->src = NULL;
-	INIT_LIST_HEAD(&state->head);
-	list_splice_init(&req->base.list, &state->head);
-
-	err = acomp_do_one_req(state, req);
+	err = acomp_do_one_req(req, comp);
 	if (err == -EBUSY || err == -EINPROGRESS)
-		return -EBUSY;
+		return err;
 
-	return acomp_reqchain_finish(req, err, ~0);
+	return acomp_reqchain_finish(req, err);
 }
 
 int crypto_acomp_compress(struct acomp_req *req)
 {
-	return acomp_do_req_chain(req, crypto_acomp_reqtfm(req)->compress);
+	struct crypto_acomp *tfm = crypto_acomp_reqtfm(req);
+
+	if (crypto_acomp_req_chain(tfm) || acomp_request_issg(req))
+		crypto_acomp_reqtfm(req)->compress(req);
+	return acomp_do_req_chain(req, true);
 }
 EXPORT_SYMBOL_GPL(crypto_acomp_compress);
 
 int crypto_acomp_decompress(struct acomp_req *req)
 {
-	return acomp_do_req_chain(req, crypto_acomp_reqtfm(req)->decompress);
+	struct crypto_acomp *tfm = crypto_acomp_reqtfm(req);
+
+	if (crypto_acomp_req_chain(tfm) || acomp_request_issg(req))
+		crypto_acomp_reqtfm(req)->decompress(req);
+	return acomp_do_req_chain(req, false);
 }
 EXPORT_SYMBOL_GPL(crypto_acomp_decompress);
 
diff --git a/crypto/scompress.c b/crypto/scompress.c
index 5762fcc63b51..c1ce12564299 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -293,28 +293,14 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	return ret;
 }
 
-static int scomp_acomp_chain(struct acomp_req *req, int dir)
-{
-	struct acomp_req *r2;
-	int err;
-
-	err = scomp_acomp_comp_decomp(req, dir);
-	req->base.err = err;
-
-	list_for_each_entry(r2, &req->base.list, base.list)
-		r2->base.err = scomp_acomp_comp_decomp(r2, dir);
-
-	return err;
-}
-
 static int scomp_acomp_compress(struct acomp_req *req)
 {
-	return scomp_acomp_chain(req, 1);
+	return scomp_acomp_comp_decomp(req, 1);
 }
 
 static int scomp_acomp_decompress(struct acomp_req *req)
 {
-	return scomp_acomp_chain(req, 0);
+	return scomp_acomp_comp_decomp(req, 0);
 }
 
 static void crypto_exit_scomp_ops_async(struct crypto_tfm *tfm)
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index c497c73baf13..267d557daeb1 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -52,10 +52,6 @@ struct acomp_req;
 struct folio;
 
 struct acomp_req_chain {
-	struct list_head head;
-	struct acomp_req *req0;
-	struct acomp_req *cur;
-	int (*op)(struct acomp_req *req);
 	crypto_completion_t compl;
 	void *data;
 	struct scatterlist ssg;
@@ -68,8 +64,6 @@ struct acomp_req_chain {
 		u8 *dst;
 		struct folio *dfolio;
 	};
-	size_t soff;
-	size_t doff;
 	u32 flags;
 };
 
@@ -349,8 +343,6 @@ static inline void acomp_request_set_callback(struct acomp_req *req,
 	req->base.data = data;
 	req->base.flags &= keep;
 	req->base.flags |= flgs & ~keep;
-
-	crypto_reqchain_init(&req->base);
 }
 
 /**
@@ -558,12 +550,6 @@ static inline void acomp_request_set_dst_folio(struct acomp_req *req,
 	req->base.flags |= CRYPTO_ACOMP_REQ_DST_FOLIO;
 }
 
-static inline void acomp_request_chain(struct acomp_req *req,
-				       struct acomp_req *head)
-{
-	crypto_request_chain(&req->base, &head->base);
-}
-
 /**
  * crypto_acomp_compress() -- Invoke asynchronous compress operation
  *
diff --git a/include/crypto/internal/acompress.h b/include/crypto/internal/acompress.h
index aaf59f3236fa..b69d818d7e68 100644
--- a/include/crypto/internal/acompress.h
+++ b/include/crypto/internal/acompress.h
@@ -98,11 +98,6 @@ void crypto_unregister_acomp(struct acomp_alg *alg);
 int crypto_register_acomps(struct acomp_alg *algs, int count);
 void crypto_unregister_acomps(struct acomp_alg *algs, int count);
 
-static inline bool acomp_request_chained(struct acomp_req *req)
-{
-	return crypto_request_chained(&req->base);
-}
-
 static inline bool acomp_request_issg(struct acomp_req *req)
 {
 	return !(req->base.flags & (CRYPTO_ACOMP_REQ_SRC_VIRT |
-- 
2.27.0


