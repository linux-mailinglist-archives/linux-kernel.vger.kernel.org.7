Return-Path: <linux-kernel+bounces-760236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F8AB1E856
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003203BC79F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D29B278E77;
	Fri,  8 Aug 2025 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="eC92WRsg"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D05B277CB1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656072; cv=none; b=GpXPnjnEDRUVa/l+M11FW/4kqNz7IgIKGjSIJSW6hD5zHl5XcfLnLEbKmFLLqksekjAUqg01qemIliuMIdOzrgi09AepWcfSsDZQkB69ngg/sgdF2+JpsjcbIVaLDJdOH6gVQpPHu17I2QD6mkYraeRyr/oZX5W62uqm31J6qR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656072; c=relaxed/simple;
	bh=sGsk+rMnoheZBlhEMhGQNdvPiaUYcaua/547nU9z2ro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EprN2uo8nCmo8mtAw8jw4zhoVkZTDUJ05It0zEg3Cv4FS32z1Nc6JPms9Ejl2Y0gq++/iZ170sdzFiUHb+xwIb/KDdZkxrTOGCBDLEshEtOYsIfgN/c+2sVmZYzn0lqcv0+Cm+moTi996LWy+0DYTNXq0bAkF16JGlqHAGKHfXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=eC92WRsg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2402774851fso18610895ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1754656070; x=1755260870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLz1Avm4xXBIcsVEEB0yl9D5RLjbTagy7Y45+YI6ut4=;
        b=eC92WRsg3PuVhnFdMXsUHjNcG5TWnkn3WzJ+J3vifkxZ5vI2ImcBxEzhLWgKPLT3u2
         cF9HK0OTsIUlX08v1x8RRHTVt+0uMYF08eVYh3O2Q1ZU120Tl/GoqkHloZXBTun18nxm
         /lhZ35V8UmA3QZ3YtzB4PbQNU7vF4rZTrMY8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754656070; x=1755260870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLz1Avm4xXBIcsVEEB0yl9D5RLjbTagy7Y45+YI6ut4=;
        b=egjHxMNuYT8PQ+2LIFJA3i6LwRodgYviDf3AULy1Jluh7FqN0o5qf9cPje0VYgBS0O
         QVfqvqIhZhQgyGmLPCKrEuqwadeZOr1QRtH9nlT+d8MRy6IC9PkRBBB41hBni613u+Sg
         BvfDjQG3lEnYcJBHpvS9J3jzINEUqnshWGHHsZHVHdCPVCG8g0SpPyIpq5byw77ojSJM
         T3YXaYTI1Ce71bNvcEkjzvfOOS1k1IDM4qriWmayGr38M3+CeSimEZY+u+xYZ1v1TWxY
         5FGdWC1aS3R3ib1HFLhYDksetZZiuLfWtW7dcPHoOInRs1FiCq7XN0vA296Ddd2eHwHF
         lRnw==
X-Forwarded-Encrypted: i=1; AJvYcCUkizzpwOnrp3iq/6EhBdcnYVLmKOhUL3OzDamay77bwOlZXxbXbHbDUkXDuUU7BycqzUar3vwUdU6mf2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQrTX9TDufT4J0LKwDML01xbnwoZ4BXFeqjjiUu/tN0RmlRAua
	wzdl55sKqVLbaVYSYH7OXggL/keK7eh9Iadg819mlSfrKKOskwoy4V10BClXEGtaY0g=
X-Gm-Gg: ASbGncvb8qhRf6SXsRWsWraNti1BNeVGhkdfaNj8IsSjy9xsZUA/edzvvbdGj/BWOxe
	h0m6yWq7JJg79PHmd0K+xnmDumRaW16dQTisrHV7sFOzXHAZQ2T3UEQIPGdjQcM1MVDcg3G3CLY
	yKIylrbBhBpKtjhrjHKQ7UyQkwk7bIOH8mVhy9ReytY6NyewaHJdNQUUMHUUy44Oqz+icOD2njF
	pjdPS9FDlS8Y7SdkgVRST5ecXTeAkdRIUqnVvqi+hkjru2Zt+ANcXksrMvvpEwaa/MuLnRsmLab
	YsSjjCnMdvKWYEBgXLXgHs/2k1ox2nkqVed039xriyKx6lEqrrhwKz4E8VYaKjC6Ha0jKfyWnt6
	vy2d9m0YWLaExlr1yKv6n+8NE3plpB8e9COr7Ipq/hGFaYg==
X-Google-Smtp-Source: AGHT+IHd+ivLGFpmwdGOgMhGwBaprUUkN0tF36UhYcsEESxHnCOkrhtDfiU0cYKzxgcbQyR8tU9tsw==
X-Received: by 2002:a17:903:4b47:b0:240:8704:fb9 with SMTP id d9443c01a7336-242c22fb175mr36596685ad.53.1754656069513;
        Fri, 08 Aug 2025 05:27:49 -0700 (PDT)
Received: from localhost.localdomain ([103.108.57.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a8cdsm208296665ad.121.2025.08.08.05.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 05:27:49 -0700 (PDT)
From: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
To: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	herbert@gondor.apana.org.au,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ruud.Derwig@synopsys.com,
	manjunath.hadli@vayavyalabs.com,
	adityak@vayavyalabs.com,
	Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>,
	Bhoomika Kadabi <bhoomikak@vayavyalabs.com>
Subject: [PATCH v4 4/6] Add SPAcc ahash support
Date: Fri,  8 Aug 2025 17:56:29 +0530
Message-Id: <20250808122631.697421-5-pavitrakumarm@vayavyalabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250808122631.697421-1-pavitrakumarm@vayavyalabs.com>
References: <20250808122631.697421-1-pavitrakumarm@vayavyalabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ahash support to SPAcc driver.
Below are the hash algos supported:
- cmac(aes)
- xcbc(aes)
- cmac(sm4)
- xcbc(sm4)
- hmac(md5)
- md5
- hmac(sha1)
- sha1
- sha224
- sha256
- sha384
- sha512
- hmac(sha224)
- hmac(sha256)
- hmac(sha384)
- hmac(sha512)
- sha3-224
- sha3-256
- sha3-384
- sha3-512
- hmac(sm3)
- sm3
- michael_mic

Co-developed-by: Bhoomika Kadabi <bhoomikak@vayavyalabs.com>
Signed-off-by: Bhoomika Kadabi <bhoomikak@vayavyalabs.com>
Acked-by: Ruud Derwig <Ruud.Derwig@synopsys.com>
Signed-off-by: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
Signed-off-by: Manjunath Hadli <manjunath.hadli@vayavyalabs.com>
---
 drivers/crypto/dwc-spacc/spacc_ahash.c | 968 +++++++++++++++++++++++++
 1 file changed, 968 insertions(+)
 create mode 100644 drivers/crypto/dwc-spacc/spacc_ahash.c

diff --git a/drivers/crypto/dwc-spacc/spacc_ahash.c b/drivers/crypto/dwc-spacc/spacc_ahash.c
new file mode 100644
index 000000000000..c15db82ca87d
--- /dev/null
+++ b/drivers/crypto/dwc-spacc/spacc_ahash.c
@@ -0,0 +1,968 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/dmapool.h>
+#include <crypto/sm3.h>
+#include <crypto/sha1.h>
+#include <crypto/sm4.h>
+#include <crypto/sha2.h>
+#include <crypto/sha3.h>
+#include <crypto/md5.h>
+#include <crypto/aes.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/internal/hash.h>
+#include <linux/delay.h>
+#include <linux/atomic.h>
+
+#include "spacc_device.h"
+#include "spacc_core.h"
+
+#define PPP_BUF_SIZE 128
+
+struct sdesc {
+	struct shash_desc shash;
+	char ctx[];
+};
+
+static struct dma_pool *spacc_hash_pool;
+static LIST_HEAD(spacc_hash_alg_list);
+static DEFINE_MUTEX(spacc_hash_alg_mutex);
+
+static struct mode_tab possible_hashes[] = {
+	{ .keylen[0] = 16, MODE_TAB_HASH("cmac(aes)", MAC_CMAC, 16,  16) },
+	{ .keylen[0] = 48 | MODE_TAB_HASH_XCBC, MODE_TAB_HASH("xcbc(aes)",
+	MAC_XCBC, 16,  16) },
+
+	{ MODE_TAB_HASH("cmac(sm4)",	MAC_SM4_CMAC, 16, 16) },
+	{ .keylen[0] = 32 | MODE_TAB_HASH_XCBC, MODE_TAB_HASH("xcbc(sm4)",
+	MAC_SM4_XCBC, 16, 16) },
+
+	{ MODE_TAB_HASH("hmac(md5)",	HMAC_MD5, MD5_DIGEST_SIZE,
+	MD5_HMAC_BLOCK_SIZE) },
+	 { MODE_TAB_HASH("md5",		HASH_MD5, MD5_DIGEST_SIZE,
+	MD5_HMAC_BLOCK_SIZE) },
+
+	{ MODE_TAB_HASH("hmac(sha1)",	HMAC_SHA1, SHA1_DIGEST_SIZE,
+	SHA1_BLOCK_SIZE) },
+	{ MODE_TAB_HASH("sha1",		HASH_SHA1, SHA1_DIGEST_SIZE,
+	SHA1_BLOCK_SIZE) },
+
+	{ MODE_TAB_HASH("sha224",	HASH_SHA224, SHA224_DIGEST_SIZE,
+	SHA224_BLOCK_SIZE) },
+	{ MODE_TAB_HASH("sha256",	HASH_SHA256, SHA256_DIGEST_SIZE,
+	SHA256_BLOCK_SIZE) },
+	{ MODE_TAB_HASH("sha384",	HASH_SHA384, SHA384_DIGEST_SIZE,
+	SHA384_BLOCK_SIZE) },
+	{ MODE_TAB_HASH("sha512",	HASH_SHA512, SHA512_DIGEST_SIZE,
+	SHA512_BLOCK_SIZE) },
+
+	{ MODE_TAB_HASH("hmac(sha512)",	HMAC_SHA512, SHA512_DIGEST_SIZE,
+	SHA512_BLOCK_SIZE) },
+	{ MODE_TAB_HASH("hmac(sha224)",	HMAC_SHA224, SHA224_DIGEST_SIZE,
+	SHA224_BLOCK_SIZE) },
+	{ MODE_TAB_HASH("hmac(sha256)",	HMAC_SHA256, SHA256_DIGEST_SIZE,
+	SHA256_BLOCK_SIZE) },
+	{ MODE_TAB_HASH("hmac(sha384)",	HMAC_SHA384, SHA384_DIGEST_SIZE,
+	SHA384_BLOCK_SIZE) },
+
+	{ MODE_TAB_HASH("sha3-224", HASH_SHA3_224, SHA3_224_DIGEST_SIZE,
+	SHA3_224_BLOCK_SIZE) },
+	{ MODE_TAB_HASH("sha3-256", HASH_SHA3_256, SHA3_256_DIGEST_SIZE,
+	SHA3_256_BLOCK_SIZE) },
+	{ MODE_TAB_HASH("sha3-384", HASH_SHA3_384, SHA3_384_DIGEST_SIZE,
+	SHA3_384_BLOCK_SIZE) },
+	{ MODE_TAB_HASH("sha3-512", HASH_SHA3_512, SHA3_512_DIGEST_SIZE,
+	SHA3_512_BLOCK_SIZE) },
+
+	{ MODE_TAB_HASH("hmac(sm3)", HMAC_SM3, SM3_DIGEST_SIZE,
+	SM3_BLOCK_SIZE) },
+	{ MODE_TAB_HASH("sm3", HASH_SM3, SM3_DIGEST_SIZE,
+	SM3_BLOCK_SIZE) },
+	{ MODE_TAB_HASH("michael_mic", MAC_MICHAEL, 8, 8) },
+
+};
+
+static void spacc_hash_cleanup_dma_dst(struct spacc_crypto_ctx *tctx,
+				       struct ahash_request *req)
+{
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	pdu_ddt_free(&ctx->dst);
+}
+
+static void spacc_hash_cleanup_dma_src(struct spacc_crypto_ctx *tctx,
+				       struct ahash_request *req)
+{
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	if (tctx->tmp_sgl && tctx->tmp_sgl[0].length != 0) {
+		dma_unmap_sg(tctx->dev, tctx->tmp_sgl, ctx->src_nents,
+			     DMA_TO_DEVICE);
+		kfree(tctx->tmp_sgl_buff);
+		tctx->tmp_sgl_buff = NULL;
+		tctx->tmp_sgl[0].length = 0;
+	} else {
+		dma_unmap_sg(tctx->dev, req->src, ctx->src_nents,
+			     DMA_TO_DEVICE);
+	}
+
+	pdu_ddt_free(&ctx->src);
+}
+
+static void spacc_hash_cleanup_dma(struct device *dev,
+				   struct ahash_request *req)
+{
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	dma_unmap_sg(dev, req->src, ctx->src_nents, DMA_TO_DEVICE);
+	pdu_ddt_free(&ctx->src);
+
+	dma_pool_free(spacc_hash_pool, ctx->digest_buf, ctx->digest_dma);
+	pdu_ddt_free(&ctx->dst);
+}
+
+static void spacc_init_calg(struct crypto_alg *calg,
+			    const struct mode_tab *mode)
+{
+	strscpy(calg->cra_name, mode->name);
+	calg->cra_name[sizeof(mode->name) - 1] = '\0';
+
+	strscpy(calg->cra_driver_name, "spacc-");
+	strcat(calg->cra_driver_name, mode->name);
+	calg->cra_driver_name[sizeof(calg->cra_driver_name) - 1] = '\0';
+
+	calg->cra_blocksize = mode->blocklen;
+}
+
+static int spacc_ctx_clone_handle(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+	struct spacc_priv *priv = dev_get_drvdata(tctx->dev);
+
+	if (tctx->handle < 0)
+		return -EINVAL;
+
+	ctx->acb.new_handle = spacc_clone_handle(&priv->spacc, tctx->handle,
+						 &ctx->acb);
+
+	if (ctx->acb.new_handle < 0) {
+		spacc_hash_cleanup_dma(tctx->dev, req);
+		return -ENOMEM;
+	}
+
+	ctx->acb.tctx  = tctx;
+	ctx->acb.ctx   = ctx;
+	ctx->acb.req   = req;
+	ctx->acb.spacc = &priv->spacc;
+
+	return 0;
+}
+
+static int spacc_hash_init_dma(struct device *dev, struct ahash_request *req)
+{
+	int rc = -1;
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	gfp_t mflags = GFP_ATOMIC;
+
+	if (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP)
+		mflags = GFP_KERNEL;
+
+	ctx->digest_buf = dma_pool_alloc(spacc_hash_pool, mflags,
+					 &ctx->digest_dma);
+
+	if (!ctx->digest_buf)
+		return -ENOMEM;
+
+	rc = pdu_ddt_init(dev, &ctx->dst, 1 | 0x80000000);
+	if (rc < 0) {
+		dev_err(dev, "ERR: PDU DDT init error\n");
+		rc = -EIO;
+		goto err_free_digest;
+	}
+
+	pdu_ddt_add(dev, &ctx->dst, ctx->digest_dma, SPACC_MAX_DIGEST_SIZE);
+
+	if (ctx->total_nents > 0 && ctx->single_shot) {
+		/* single shot */
+		spacc_ctx_clone_handle(req);
+
+		if (req->nbytes) {
+			rc = spacc_sg_to_ddt(dev, req->src, req->nbytes,
+					     &ctx->src, DMA_TO_DEVICE);
+		} else {
+			memset(tctx->tmp_buffer, '\0', PPP_BUF_SIZE);
+			sg_set_buf(&tctx->tmp_sgl[0], tctx->tmp_buffer,
+				   PPP_BUF_SIZE);
+			rc = spacc_sg_to_ddt(dev, &tctx->tmp_sgl[0],
+					     tctx->tmp_sgl[0].length,
+					     &ctx->src, DMA_TO_DEVICE);
+		}
+	} else if (ctx->total_nents == 0 && req->nbytes == 0) {
+		spacc_ctx_clone_handle(req);
+
+		/* zero length case */
+		memset(tctx->tmp_buffer, '\0', PPP_BUF_SIZE);
+		sg_set_buf(&tctx->tmp_sgl[0], tctx->tmp_buffer, PPP_BUF_SIZE);
+		rc = spacc_sg_to_ddt(dev, &tctx->tmp_sgl[0],
+				     tctx->tmp_sgl[0].length,
+				     &ctx->src, DMA_TO_DEVICE);
+	}
+
+	if (rc < 0)
+		goto err_free_dst;
+
+	ctx->src_nents = rc;
+
+	return rc;
+
+err_free_dst:
+	pdu_ddt_free(&ctx->dst);
+err_free_digest:
+	dma_pool_free(spacc_hash_pool, ctx->digest_buf, ctx->digest_dma);
+
+	return rc;
+}
+
+static void spacc_free_mems(struct spacc_crypto_reqctx *ctx,
+			    struct spacc_crypto_ctx *tctx,
+			    struct ahash_request *req)
+{
+	spacc_hash_cleanup_dma_dst(tctx, req);
+	spacc_hash_cleanup_dma_src(tctx, req);
+
+	if (ctx->single_shot) {
+		kfree(tctx->tmp_sgl);
+		tctx->tmp_sgl = NULL;
+
+		ctx->single_shot = 0;
+		if (ctx->total_nents)
+			ctx->total_nents = 0;
+	}
+}
+
+static void spacc_digest_cb(void *spacc, void *tfm)
+{
+	int dig_sz;
+	int err = -1;
+	struct ahash_cb_data *cb = tfm;
+	struct spacc_device *device = (struct spacc_device *)spacc;
+
+	dig_sz = crypto_ahash_digestsize(crypto_ahash_reqtfm(cb->req));
+
+	if (cb->ctx->single_shot)
+		memcpy(cb->req->result, cb->ctx->digest_buf, dig_sz);
+	else
+		memcpy(cb->tctx->digest_ctx_buf, cb->ctx->digest_buf, dig_sz);
+
+	err = cb->spacc->job[cb->new_handle].job_err;
+
+	dma_pool_free(spacc_hash_pool, cb->ctx->digest_buf,
+		      cb->ctx->digest_dma);
+	spacc_free_mems(cb->ctx, cb->tctx, cb->req);
+	spacc_close(cb->spacc, cb->new_handle);
+
+	if (cb->req->base.complete) {
+		local_bh_disable();
+		ahash_request_complete(cb->req, err);
+		local_bh_enable();
+	}
+
+	if (atomic_read(&device->wait_counter) > 0) {
+		struct spacc_completion *cur_pos, *next_pos;
+
+		/* wake up waitqueue to obtain a context */
+		atomic_dec(&device->wait_counter);
+		if (atomic_read(&device->wait_counter) > 0) {
+			mutex_lock(&device->spacc_waitq_mutex);
+			list_for_each_entry_safe(cur_pos, next_pos,
+						 &device->spacc_wait_list,
+						 list) {
+				if (cur_pos->wait_done == 1) {
+					cur_pos->wait_done = 0;
+					complete(&cur_pos->spacc_wait_complete);
+					list_del(&cur_pos->list);
+					break;
+				}
+			}
+			mutex_unlock(&device->spacc_waitq_mutex);
+		}
+	}
+}
+
+static int do_shash(struct device *dev, unsigned char *name,
+		    unsigned char *result, const u8 *data1,
+		    unsigned int data1_len, const u8 *data2,
+		    unsigned int data2_len, const u8 *key,
+		    unsigned int key_len)
+{
+	int rc = 0;
+	unsigned int size;
+	struct sdesc *sdesc;
+	struct crypto_shash *hash;
+
+	hash = crypto_alloc_shash(name, 0, 0);
+	if (IS_ERR(hash)) {
+		rc = PTR_ERR(hash);
+		dev_err(dev, "ERR: Crypto %s allocation error %d\n", name, rc);
+		return rc;
+	}
+
+	size = sizeof(struct shash_desc) + crypto_shash_descsize(hash);
+	sdesc = kmalloc(size, GFP_KERNEL);
+	if (!sdesc) {
+		rc = -ENOMEM;
+		goto do_shash_err;
+	}
+	sdesc->shash.tfm = hash;
+
+	if (key_len > 0) {
+		rc = crypto_shash_setkey(hash, key, key_len);
+		if (rc) {
+			dev_err(dev, "ERR: Could not setkey %s shash\n", name);
+			goto do_shash_err;
+		}
+	}
+
+	rc = crypto_shash_init(&sdesc->shash);
+	if (rc) {
+		dev_err(dev, "ERR: Could not init %s shash\n", name);
+		goto do_shash_err;
+	}
+
+	rc = crypto_shash_update(&sdesc->shash, data1, data1_len);
+	if (rc) {
+		dev_err(dev, "ERR: Could not update1\n");
+		goto do_shash_err;
+	}
+
+	if (data2 && data2_len) {
+		rc = crypto_shash_update(&sdesc->shash, data2, data2_len);
+		if (rc) {
+			dev_err(dev, "ERR: Could not update2\n");
+			goto do_shash_err;
+		}
+	}
+
+	rc = crypto_shash_final(&sdesc->shash, result);
+	if (rc)
+		dev_err(dev, "ERR: Could not generate %s hash\n", name);
+
+do_shash_err:
+	crypto_free_shash(hash);
+	kfree(sdesc);
+
+	return rc;
+}
+
+static int spacc_hash_setkey(struct crypto_ahash *tfm, const u8 *key,
+			     unsigned int keylen)
+{
+	int rc = 0;
+	int ret = 0;
+	unsigned int block_size;
+	unsigned int digest_size;
+	char hash_alg[CRYPTO_MAX_ALG_NAME];
+	const struct spacc_alg *salg = spacc_tfm_ahash(&tfm->base);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct spacc_priv *priv = dev_get_drvdata(tctx->dev);
+
+	block_size = crypto_tfm_alg_blocksize(&tfm->base);
+	digest_size = crypto_ahash_digestsize(tfm);
+
+	/*
+	 * We will not use the hardware in case of HMACs
+	 * This was meant for hashes but it works for cmac/xcbc since we
+	 * only intend to support 128-bit keys...
+	 */
+	if (keylen > block_size && salg->mode->id != CRYPTO_MODE_MAC_CMAC) {
+		dev_dbg(salg->dev, "Exceeds keylen: %u\n", keylen);
+		dev_dbg(salg->dev, "Req. keylen hashing %s\n",
+			salg->calg->cra_name);
+
+		memset(hash_alg, 0x00, CRYPTO_MAX_ALG_NAME);
+		switch (salg->mode->id)	{
+		case CRYPTO_MODE_HMAC_SHA224:
+			rc = do_shash(salg->dev, "sha224", tctx->ipad, key,
+				      keylen, NULL, 0, NULL, 0);
+			break;
+
+		case CRYPTO_MODE_HMAC_SHA256:
+			rc = do_shash(salg->dev, "sha256", tctx->ipad, key,
+				      keylen, NULL, 0, NULL, 0);
+			break;
+
+		case CRYPTO_MODE_HMAC_SHA384:
+			rc = do_shash(salg->dev, "sha384", tctx->ipad, key,
+				      keylen, NULL, 0, NULL, 0);
+			break;
+
+		case CRYPTO_MODE_HMAC_SHA512:
+			rc = do_shash(salg->dev, "sha512", tctx->ipad, key,
+				      keylen, NULL, 0, NULL, 0);
+			break;
+
+		case CRYPTO_MODE_HMAC_MD5:
+			rc = do_shash(salg->dev, "md5", tctx->ipad, key,
+				      keylen, NULL, 0, NULL, 0);
+			break;
+
+		case CRYPTO_MODE_HMAC_SHA1:
+			rc = do_shash(salg->dev, "sha1", tctx->ipad, key,
+				      keylen, NULL, 0, NULL, 0);
+			break;
+		case CRYPTO_MODE_HMAC_SM3:
+			rc = do_shash(salg->dev, "sm3", tctx->ipad, key,
+				      keylen, NULL, 0, NULL, 0);
+			break;
+
+		default:
+			return -EINVAL;
+		}
+
+		if (rc < 0) {
+			dev_err(salg->dev, "ERR: %d computing shash for %s\n",
+				rc, hash_alg);
+			return -EIO;
+		}
+
+		keylen = digest_size;
+		dev_dbg(salg->dev, "updated keylen: %u\n", keylen);
+
+		tctx->ctx_valid = false;
+
+		rc = crypto_ahash_setkey(tctx->fb.hash,
+				tctx->ipad, keylen);
+		if (rc < 0)
+			return rc;
+	} else {
+		memcpy(tctx->ipad, key, keylen);
+		tctx->ctx_valid = false;
+
+		rc = crypto_ahash_setkey(tctx->fb.hash, key, keylen);
+		if (rc < 0)
+			return rc;
+	}
+
+	/* close handle since key size may have changed */
+	if (tctx->handle >= 0) {
+		spacc_close(&priv->spacc, tctx->handle);
+		put_device(tctx->dev);
+		tctx->handle = -1;
+		tctx->dev = NULL;
+	}
+
+	/* reset priv */
+	priv = NULL;
+	priv = dev_get_drvdata(salg->dev);
+	tctx->dev = get_device(salg->dev);
+	ret = spacc_is_mode_keysize_supported(&priv->spacc, salg->mode->id,
+					      keylen, 1);
+	if (ret) {
+		/* Grab the spacc context if no one is waiting */
+		tctx->handle = spacc_open(&priv->spacc,
+					  CRYPTO_MODE_NULL,
+					  salg->mode->id, -1,
+					  0, spacc_digest_cb, tfm);
+		if (tctx->handle < 0) {
+			dev_err(salg->dev, "ERR: Failed to open SPAcc context\n");
+			put_device(salg->dev);
+			return -EIO;
+		}
+
+	} else {
+		dev_err(salg->dev, "Keylen: %d not enabled for algo: %d",
+			keylen, salg->mode->id);
+	}
+
+	rc = spacc_set_operation(&priv->spacc, tctx->handle, OP_ENCRYPT,
+				 ICV_HASH, IP_ICV_OFFSET, 0, 0, 0);
+	if (rc < 0) {
+		spacc_close(&priv->spacc, tctx->handle);
+		tctx->handle = -1;
+		put_device(tctx->dev);
+		return -EIO;
+	}
+
+	if (salg->mode->id == CRYPTO_MODE_MAC_XCBC ||
+	    salg->mode->id == CRYPTO_MODE_MAC_SM4_XCBC) {
+		rc = spacc_compute_xcbc_key(&priv->spacc, salg->mode->id,
+					    tctx->handle, tctx->ipad,
+					    keylen, tctx->ipad);
+		if (rc < 0) {
+			dev_err(tctx->dev,
+				"Failed to compute XCBC key: %d\n", rc);
+			return -EIO;
+		}
+		rc = spacc_write_context(&priv->spacc, tctx->handle,
+					 SPACC_HASH_OPERATION, tctx->ipad,
+					 32 + keylen, NULL, 0);
+	} else {
+		rc = spacc_write_context(&priv->spacc, tctx->handle,
+					 SPACC_HASH_OPERATION, tctx->ipad,
+					 keylen, NULL, 0);
+	}
+
+	memset(tctx->ipad, 0, sizeof(tctx->ipad));
+	if (rc < 0) {
+		dev_err(tctx->dev, "ERR: Failed to write SPAcc context\n");
+		/* Non-fatal, we continue with the software fallback */
+		return 0;
+	}
+
+	tctx->ctx_valid = true;
+
+	return 0;
+}
+
+static int spacc_set_statesize(struct spacc_alg *salg)
+{
+	unsigned int statesize = 0;
+
+	switch (salg->mode->id) {
+	case CRYPTO_MODE_HMAC_SHA1:
+	case CRYPTO_MODE_HASH_SHA1:
+		statesize = sizeof(struct sha1_state);
+		break;
+	case CRYPTO_MODE_MAC_CMAC:
+	case CRYPTO_MODE_MAC_XCBC:
+		statesize = sizeof(struct crypto_aes_ctx);
+		break;
+	case CRYPTO_MODE_MAC_SM4_CMAC:
+	case CRYPTO_MODE_MAC_SM4_XCBC:
+		statesize = sizeof(struct sm4_ctx);
+		break;
+	case CRYPTO_MODE_HMAC_MD5:
+	case CRYPTO_MODE_HASH_MD5:
+		statesize = sizeof(struct md5_state);
+		break;
+	case CRYPTO_MODE_HASH_SHA224:
+	case CRYPTO_MODE_HASH_SHA256:
+	case CRYPTO_MODE_HMAC_SHA224:
+	case CRYPTO_MODE_HMAC_SHA256:
+		statesize = sizeof(struct sha256_state);
+		break;
+	case CRYPTO_MODE_HMAC_SHA512:
+	case CRYPTO_MODE_HASH_SHA512:
+		statesize = sizeof(struct sha512_state);
+		break;
+	case CRYPTO_MODE_HMAC_SHA384:
+	case CRYPTO_MODE_HASH_SHA384:
+		statesize = sizeof(struct spacc_crypto_reqctx);
+		break;
+	case CRYPTO_MODE_HASH_SHA3_224:
+	case CRYPTO_MODE_HASH_SHA3_256:
+	case CRYPTO_MODE_HASH_SHA3_384:
+	case CRYPTO_MODE_HASH_SHA3_512:
+		statesize = sizeof(struct sha3_state);
+		break;
+	case CRYPTO_MODE_HMAC_SM3:
+	case CRYPTO_MODE_MAC_MICHAEL:
+		statesize = sizeof(struct spacc_crypto_reqctx);
+		break;
+	default:
+		break;
+	}
+
+	return statesize;
+}
+
+static int spacc_hash_init_tfm(struct crypto_ahash *tfm)
+{
+	struct spacc_priv *priv = NULL;
+	const struct spacc_alg *salg = container_of(crypto_ahash_alg(tfm),
+						    struct spacc_alg, alg.hash);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(tfm);
+
+	tctx->handle    = -1;
+	tctx->ctx_valid = false;
+	tctx->dev       = get_device(salg->dev);
+	priv		= dev_get_drvdata(tctx->dev);
+
+	tctx->fb.hash = crypto_alloc_ahash(crypto_ahash_alg_name(tfm), 0,
+			CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(tctx->fb.hash)) {
+		dev_err(tctx->dev, "SPAcc ahash fallback tfm is NULL!\n");
+		spacc_close(&priv->spacc, tctx->handle);
+		put_device(tctx->dev);
+		return PTR_ERR(tctx->fb.hash);
+	}
+
+	crypto_ahash_set_statesize(tfm,
+			crypto_ahash_statesize(tctx->fb.hash));
+
+	crypto_ahash_set_reqsize(tfm,
+			sizeof(struct spacc_crypto_reqctx) +
+			crypto_ahash_reqsize(tctx->fb.hash));
+
+	return 0;
+}
+
+static void spacc_hash_exit_tfm(struct crypto_ahash *tfm)
+{
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct spacc_priv *priv = dev_get_drvdata(tctx->dev);
+
+	crypto_free_ahash(tctx->fb.hash);
+	tctx->fb.hash = NULL;
+	if (tctx->handle >= 0)
+		spacc_close(&priv->spacc, tctx->handle);
+
+	put_device(tctx->dev);
+}
+
+static int spacc_hash_init(struct ahash_request *req)
+{
+	int rc = 0;
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+
+	ahash_request_set_callback(&ctx->fb.hash_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete,
+				   req->base.data);
+
+	rc = crypto_ahash_init(&ctx->fb.hash_req);
+
+	return rc;
+}
+
+static int spacc_hash_update(struct ahash_request *req)
+{
+	int rc = 0;
+	int nbytes = req->nbytes;
+
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	if (!nbytes)
+		return 0;
+
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+
+	ahash_request_set_callback(&ctx->fb.hash_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete,
+				   req->base.data);
+
+	ahash_request_set_crypt(&ctx->fb.hash_req, req->src, NULL, nbytes);
+
+	rc = crypto_ahash_update(&ctx->fb.hash_req);
+
+	return rc;
+}
+
+static int spacc_hash_final(struct ahash_request *req)
+{
+	int rc = 0;
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+
+	ahash_request_set_callback(&ctx->fb.hash_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete,
+				   req->base.data);
+
+	ahash_request_set_crypt(&ctx->fb.hash_req, NULL, req->result, 0);
+
+	rc = crypto_ahash_final(&ctx->fb.hash_req);
+
+	return rc;
+}
+
+static int spacc_hash_digest(struct ahash_request *req)
+{
+	int rc = 0;
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+	struct spacc_priv *priv = dev_get_drvdata(tctx->dev);
+	const struct spacc_alg *salg = spacc_tfm_ahash(&reqtfm->base);
+
+	/* direct single shot digest call */
+	ctx->single_shot = 1;
+	ctx->total_nents = sg_nents(req->src);
+
+	/* alloc tmp_sgl */
+	tctx->tmp_sgl = kmalloc(sizeof(*tctx->tmp_sgl) * 2, GFP_KERNEL);
+
+	if (!tctx->tmp_sgl)
+		return -ENOMEM;
+
+	sg_init_table(tctx->tmp_sgl, 2);
+	tctx->tmp_sgl[0].length = 0;
+
+	if (tctx->handle < 0 || !tctx->ctx_valid) {
+		priv = NULL;
+		priv = dev_get_drvdata(salg->dev);
+		tctx->dev = get_device(salg->dev);
+
+		rc = spacc_is_mode_keysize_supported(&priv->spacc,
+						     salg->mode->id, 0, 1);
+		if (rc)
+			tctx->handle = spacc_open(&priv->spacc,
+						  CRYPTO_MODE_NULL,
+						  salg->mode->id, -1, 0,
+						  spacc_digest_cb,
+						  reqtfm);
+		if (tctx->handle < 0) {
+			put_device(salg->dev);
+			dev_dbg(salg->dev,
+				"Digest:failed to open spacc context\n");
+			goto fallback;
+		}
+
+		rc = spacc_set_operation(&priv->spacc, tctx->handle,
+					 OP_ENCRYPT, ICV_HASH, IP_ICV_OFFSET,
+					 0, 0, 0);
+		if (rc < 0) {
+			spacc_close(&priv->spacc, tctx->handle);
+			dev_dbg(salg->dev,
+				"ERR: Failed to set operation\n");
+			tctx->handle = -1;
+			put_device(tctx->dev);
+			goto fallback;
+		}
+		tctx->ctx_valid = true;
+	}
+
+	rc = spacc_hash_init_dma(tctx->dev, req);
+	if (rc < 0)
+		goto fallback;
+
+	if (rc == 0) {
+		kfree(tctx->tmp_sgl);
+		tctx->tmp_sgl = NULL;
+		return 0;
+	}
+
+	rc = spacc_packet_enqueue_ddt(&priv->spacc, ctx->acb.new_handle,
+				      &ctx->src, &ctx->dst, req->nbytes,
+				      0, req->nbytes, 0, 0, 0);
+
+	if (rc < 0) {
+		spacc_hash_cleanup_dma(tctx->dev, req);
+		spacc_close(&priv->spacc, ctx->acb.new_handle);
+
+		if (rc != -EBUSY) {
+			dev_err(salg->dev, "ERR: Failed to enqueue job: %d\n",
+				rc);
+			kfree(tctx->tmp_sgl);
+			tctx->tmp_sgl = NULL;
+			return rc;
+		}
+
+		if (!(req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG))
+			return -EBUSY;
+
+		goto fallback;
+	}
+
+	return -EINPROGRESS;
+
+fallback:
+	kfree(tctx->tmp_sgl);
+	tctx->tmp_sgl = NULL;
+
+	/* start from scratch as init is not called before digest */
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+
+	ahash_request_set_callback(&ctx->fb.hash_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete,
+				   req->base.data);
+
+	ahash_request_set_crypt(&ctx->fb.hash_req, req->src, req->result,
+				req->nbytes);
+
+	rc = crypto_ahash_digest(&ctx->fb.hash_req);
+
+	return rc;
+}
+
+static int spacc_hash_finup(struct ahash_request *req)
+{
+	int rc = 0;
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+
+	ahash_request_set_callback(&ctx->fb.hash_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete,
+				   req->base.data);
+
+	ahash_request_set_crypt(&ctx->fb.hash_req, req->src, req->result,
+				req->nbytes);
+
+	rc = crypto_ahash_finup(&ctx->fb.hash_req);
+
+	return rc;
+}
+
+static int spacc_hash_import(struct ahash_request *req, const void *in)
+{
+	int rc = 0;
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+
+	ahash_request_set_callback(&ctx->fb.hash_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete,
+				   req->base.data);
+
+	rc = crypto_ahash_import(&ctx->fb.hash_req, in);
+
+	return rc;
+}
+
+static int spacc_hash_export(struct ahash_request *req, void *out)
+{
+	int rc = 0;
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+
+	ahash_request_set_callback(&ctx->fb.hash_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete,
+				   req->base.data);
+
+	rc = crypto_ahash_export(&ctx->fb.hash_req, out);
+
+	return rc;
+}
+
+static const struct ahash_alg spacc_hash_template = {
+	.init   = spacc_hash_init,
+	.update = spacc_hash_update,
+	.final  = spacc_hash_final,
+	.finup  = spacc_hash_finup,
+	.digest = spacc_hash_digest,
+	.setkey = spacc_hash_setkey,
+	.export = spacc_hash_export,
+	.import = spacc_hash_import,
+	.init_tfm = spacc_hash_init_tfm,
+	.exit_tfm = spacc_hash_exit_tfm,
+
+	.halg.base = {
+		.cra_priority	= 300,
+		.cra_module	= THIS_MODULE,
+		.cra_ctxsize	= sizeof(struct spacc_crypto_ctx),
+		.cra_flags	= CRYPTO_ALG_TYPE_AHASH    |
+				  CRYPTO_ALG_ASYNC	   |
+				  CRYPTO_ALG_NEED_FALLBACK |
+				  CRYPTO_ALG_OPTIONAL_KEY
+	},
+};
+
+static int spacc_register_hash(struct spacc_alg *salg)
+{
+	int rc = 0;
+
+	salg->calg = &salg->alg.hash.halg.base;
+	salg->alg.hash = spacc_hash_template;
+
+	spacc_init_calg(salg->calg, salg->mode);
+	salg->alg.hash.halg.digestsize = salg->mode->hashlen;
+	salg->alg.hash.halg.statesize = spacc_set_statesize(salg);
+
+	rc = crypto_register_ahash(&salg->alg.hash);
+	if (rc < 0)
+		return rc;
+
+	mutex_lock(&spacc_hash_alg_mutex);
+	list_add(&salg->list, &spacc_hash_alg_list);
+	mutex_unlock(&spacc_hash_alg_mutex);
+
+	return 0;
+}
+
+int spacc_probe_hashes(struct platform_device *spacc_pdev)
+{
+	int rc = 0;
+	unsigned int index;
+	int registered = 0;
+	struct spacc_alg *salg;
+	struct spacc_priv *priv = dev_get_drvdata(&spacc_pdev->dev);
+	const char *name = NULL;
+
+	spacc_hash_pool = dma_pool_create("spacc-digest", &spacc_pdev->dev,
+					  SPACC_MAX_DIGEST_SIZE,
+					  SPACC_DMA_ALIGN, SPACC_DMA_BOUNDARY);
+
+	if (!spacc_hash_pool)
+		return -ENOMEM;
+
+	for (index = 0; index < ARRAY_SIZE(possible_hashes); index++)
+		possible_hashes[index].valid = 0;
+
+	for (index = 0; index < ARRAY_SIZE(possible_hashes); index++) {
+		name = possible_hashes[index].name;
+
+		if (!crypto_has_ahash(name, 0, 0))
+			continue;
+
+		if (possible_hashes[index].valid == 0 &&
+		    spacc_is_mode_keysize_supported(&priv->spacc,
+				    possible_hashes[index].id & 0xFF,
+				    possible_hashes[index].hashlen, 1)) {
+			salg = kmalloc(sizeof(*salg), GFP_KERNEL);
+			if (!salg)
+				return -ENOMEM;
+
+			salg->mode = &possible_hashes[index];
+
+			/* Copy all dev's over to the salg */
+			salg->dev = &spacc_pdev->dev;
+
+			rc = spacc_register_hash(salg);
+			if (rc < 0) {
+				kfree(salg);
+				continue;
+			}
+
+			registered++;
+			possible_hashes[index].valid = 1;
+		}
+	}
+
+	return registered;
+}
+
+int spacc_unregister_hash_algs(void)
+{
+	struct spacc_alg *salg, *tmp;
+
+	mutex_lock(&spacc_hash_alg_mutex);
+	list_for_each_entry_safe(salg, tmp, &spacc_hash_alg_list, list) {
+		crypto_unregister_alg(salg->calg);
+		list_del(&salg->list);
+		kfree(salg);
+	}
+	mutex_unlock(&spacc_hash_alg_mutex);
+
+	dma_pool_destroy(spacc_hash_pool);
+
+	return 0;
+}
-- 
2.25.1


