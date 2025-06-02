Return-Path: <linux-kernel+bounces-670101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD8EACA8FD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 07:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AF33BA5B0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 05:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B780019ADA4;
	Mon,  2 Jun 2025 05:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="JY2CW7sy"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B4C194A44
	for <linux-kernel@vger.kernel.org>; Mon,  2 Jun 2025 05:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748842538; cv=none; b=uWD4SpoVVTenu0ulr5oAmhqbWB8M7qUCs87zgWcgKxhKrLO9vybQOB3JhDm+rBwPjsaIZvMPcq0ItRasd5fnlI7OEeQB0eztiokUfyLkUNX/jnKXzaVSdAJqmIaYsyv9IefAaPTwrC1TYtmd+YQ+vFehvM9rPjhZ22sCwxyGPRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748842538; c=relaxed/simple;
	bh=4bqiffmMDk5RQlngIw4RQZc5+25Mc8YJcYlB7qGlzBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=khAkKdPVj/yrwEHVMDUY8hLhQzJf17AH+Q2BwwRBzeR7XQZcVUn1mMN6259arlyZ5ZdL8TILlkL+Hwj/ykuyksuEoDVbMSmH6vKdJqedzo529vg2YreWy2Ujxuvs3QW9SwpinZshLN4SNwVx9UYJWgPHqI5LkrphZqNUhDcbioM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=JY2CW7sy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23539a1a421so16231515ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jun 2025 22:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1748842535; x=1749447335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzbAJPlGDJ1NUTP7XIpeMYEjrKEvxRjPsY+3EHbDtdQ=;
        b=JY2CW7syRHpBP7nMT7ClX1P9VPYAyFoESevSLcaCo49aUHDAvxb66sW+t2J2YfIxZ9
         QUtZUeBgg9ondKp8HPel5lJDdH17uWb7XTXHAeMXZzPmf8oG9kIlIMHsFAunUQLYXm1c
         4fIS0CzqjLFRotOQ3K0/+8Rl49awFAIhbF084=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748842535; x=1749447335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzbAJPlGDJ1NUTP7XIpeMYEjrKEvxRjPsY+3EHbDtdQ=;
        b=wx1/x82NG6RgxEXu2/NNMfQtAgvyg7rSDLYs6tnFTZh3sIapgY7jD1r0WnMFK3EjD6
         IvcMM94sEpgFnWw4V7cBeG8mbQuxx2GRKSdrLeVjq3KzM45HNCZEp5wnHdsqd07xMqjM
         xb4N3dKFuA+gQ/xFP5ywpWvX3bVVAYE7sqbS47GtPB9MqYr3h1dMaHIN74rI8t3W2E6C
         fVX3NH+pNcJrNQlaeDDdOW4/3giVoKjTpvSFDQNjc8/0h8qzCmD32dv2ZyL8BdTTHvo5
         Q9KM2RRvV4BrfvbPX42J4YcQt+M/1s7p9ZZcrMZ/9+fZv6IX4vY0s7iI5cQw/deQLxN4
         4w3A==
X-Forwarded-Encrypted: i=1; AJvYcCW1up6iZhTsmjkyARNUgXq/zl9Qsp404uahjiVSjtyzEwM+bXgJPw9PaESYcIYF2tN6P0DCV6uKxvh7Fdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxniTVOt+HppyPeoxsdlknxK16xlOw4KIsvnCvOdMH4HW5eKA42
	j6oHub3XCf1rmKCPYNXbcefpolFmH6F6AEjmnLcZnFYse71uBd4S3weVxdPcCydavR8=
X-Gm-Gg: ASbGncspdMHVQpqWoNaxyMTiZ7iE5/exxdnsqRtNfhbm5fY/WFiB7X4h+ULG3SR4bV/
	I7U1jF/tloBh7jxnzHRz7RhdWZDbMqhQU/MEPOimOCUezm75blM0C27zFPmIlLgH92aOULsTxbZ
	aLczldZfHtiA82tNrdK6bnVNjG+81wHDam6jty2/ZacfwttPm+0jhJ29S5UVgCdOnYZJGNryBhi
	hgtaJm9zODu9FOYioR0S/AW2oaYC1g2tjvnKpw1vjPcyTQ2AJKn81mPCPQW+lA8ukPFeffj+Yne
	W5WwL/kau9GABrhA6rN2EzGQaRo9DCg/N39OxaN7yCip55Ra5a+P80lofJl6jzM67kio0Ym32RU
	WSkSfuGwQ0NeLgQ==
X-Google-Smtp-Source: AGHT+IEQXoBXCeTtt3cL+5s6oREqz08i/ck934oXA/+A4mkcAzpApMlWORPfk8fEqZJmy/jOTUj9jA==
X-Received: by 2002:a17:90b:48c2:b0:311:9c9a:58c7 with SMTP id 98e67ed59e1d1-3127c6a0481mr11592508a91.7.1748842535245;
        Sun, 01 Jun 2025 22:35:35 -0700 (PDT)
Received: from localhost.localdomain ([117.251.222.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e30cbe6sm4836986a91.39.2025.06.01.22.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 22:35:34 -0700 (PDT)
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
	Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
Subject: [PATCH v3 5/6] Add SPAcc AEAD support
Date: Mon,  2 Jun 2025 11:02:30 +0530
Message-Id: <20250602053231.403143-6-pavitrakumarm@vayavyalabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602053231.403143-1-pavitrakumarm@vayavyalabs.com>
References: <20250602053231.403143-1-pavitrakumarm@vayavyalabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add AEAD support to SPAcc driver.
Below are the supported AEAD algos:
- ccm(sm4)
- ccm(aes)
- gcm(sm4)
- gcm(aes)
- rfc7539(chacha20,poly1305)

Signed-off-by: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
Signed-off-by: Manjunath Hadli <manjunath.hadli@vayavyalabs.com>
Acked-by: Ruud Derwig <Ruud.Derwig@synopsys.com>
---
 drivers/crypto/dwc-spacc/spacc_aead.c | 1297 +++++++++++++++++++++++++
 1 file changed, 1297 insertions(+)
 create mode 100755 drivers/crypto/dwc-spacc/spacc_aead.c

diff --git a/drivers/crypto/dwc-spacc/spacc_aead.c b/drivers/crypto/dwc-spacc/spacc_aead.c
new file mode 100755
index 000000000000..9d7589239861
--- /dev/null
+++ b/drivers/crypto/dwc-spacc/spacc_aead.c
@@ -0,0 +1,1297 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <crypto/aes.h>
+#include <crypto/sm4.h>
+#include <crypto/gcm.h>
+#include <crypto/aead.h>
+#include <crypto/authenc.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/internal/aead.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/atomic.h>
+
+#include "spacc_device.h"
+#include "spacc_core.h"
+
+static LIST_HEAD(spacc_aead_alg_list);
+static DEFINE_MUTEX(spacc_aead_alg_mutex);
+
+#define ADATA_CCM_BUF		144
+#define SPACC_B0_SIZE		16
+#define SET_IV_IN_SRCBUF	0x80000000
+#define SET_IV_IN_CONTEXT	0x0
+#define AAD_BUF_SIZE		(4096 * 4)
+#define ADATA_BUF_SIZE		(AAD_BUF_SIZE + SPACC_B0_SIZE +\
+				 SPACC_MAX_IV_SIZE)
+
+struct spacc_iv_buf {
+	unsigned char iv[SPACC_MAX_IV_SIZE];
+	unsigned char spacc_adata[ADATA_BUF_SIZE];
+	struct scatterlist sg[2], spacc_adata_sg[2];
+	struct scatterlist *spacc_ptextsg, temp_aad[2];
+};
+
+static struct kmem_cache *spacc_iv_pool;
+
+static struct mode_tab possible_aeads[] = {
+	{ MODE_TAB_AEAD("rfc7539(chacha20,poly1305)",
+			CRYPTO_MODE_CHACHA20_POLY1305, CRYPTO_MODE_NULL,
+			16, 12, 1), .keylen = { 16, 24, 32 }
+	},
+	{ MODE_TAB_AEAD("gcm(aes)",
+			CRYPTO_MODE_AES_GCM, CRYPTO_MODE_NULL,
+			16, 12, 1), .keylen = { 16, 24, 32 }
+	},
+	{ MODE_TAB_AEAD("gcm(sm4)",
+			CRYPTO_MODE_SM4_GCM, CRYPTO_MODE_NULL,
+			16, 12, 1), .keylen = { 16 }
+	},
+	{ MODE_TAB_AEAD("ccm(aes)",
+			CRYPTO_MODE_AES_CCM, CRYPTO_MODE_NULL,
+			16, 16, 1), .keylen = { 16, 24, 32 }
+	},
+	{ MODE_TAB_AEAD("ccm(sm4)",
+			CRYPTO_MODE_SM4_CCM, CRYPTO_MODE_NULL,
+			16, 16, 1), .keylen = { 16, 24, 32 }
+	},
+};
+
+static void spacc_init_aead_alg(struct crypto_alg *calg,
+				const struct mode_tab *mode)
+{
+	strscpy(calg->cra_name, mode->name, sizeof(mode->name) - 1);
+	calg->cra_name[sizeof(mode->name) - 1] = '\0';
+
+	strscpy(calg->cra_driver_name, "spacc-");
+	strcat(calg->cra_driver_name, mode->name);
+	calg->cra_driver_name[sizeof(calg->cra_driver_name) - 1] = '\0';
+
+	calg->cra_blocksize = mode->blocklen;
+}
+
+static int ccm_16byte_aligned_len(int in_len)
+{
+	int len;
+	int computed_mod;
+
+	if (in_len > 0) {
+		computed_mod = in_len % 16;
+		if (computed_mod)
+			len = in_len - computed_mod + 16;
+		else
+			len = in_len;
+	} else {
+		len = in_len;
+	}
+
+	return len;
+}
+
+/* Taken from crypto/ccm.c */
+static int spacc_aead_format_adata(u8 *adata, unsigned int a)
+{
+	int len = 0;
+
+	/*
+	 * Add control info for associated data
+	 * RFC 3610 and NIST Special Publication 800-38C
+	 */
+	if (a < 65280) {
+		*(__be16 *)adata = cpu_to_be16(a);
+		len = 2;
+	} else  {
+		*(__be16 *)adata = cpu_to_be16(0xfffe);
+		*(__be32 *)&adata[2] = cpu_to_be32(a);
+		len = 6;
+	}
+
+	return len;
+}
+
+/* Taken from crypto/ccm.c */
+static int spacc_aead_set_msg_len(u8 *block, unsigned int msglen, int csize)
+{
+	__be32 data;
+
+	memset(block, 0, csize);
+	block += csize;
+
+	if (csize >= 4)
+		csize = 4;
+	else if (msglen > (unsigned int)(1 << (8 * csize)))
+		return -EOVERFLOW;
+
+	data = cpu_to_be32(msglen);
+	memcpy(block - csize, (u8 *)&data + 4 - csize, csize);
+
+	return 0;
+}
+
+static int spacc_aead_init_dma(struct device *dev, struct aead_request *req,
+			       u64 seq, uint32_t icvlen, int encrypt, int *alen)
+{
+	struct crypto_aead *reqtfm      = crypto_aead_reqtfm(req);
+	struct spacc_crypto_ctx *tctx   = crypto_aead_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = aead_request_ctx(req);
+
+	int B0len;
+	int rc = 0;
+	struct spacc_iv_buf *iv;
+	int ccm_aad_16b_len = 0;
+	int payload_len, spacc_adata_sg_buf_len;
+	unsigned int ivsize = crypto_aead_ivsize(reqtfm);
+	gfp_t mflags = GFP_ATOMIC;
+
+	/* always have 1 byte of IV */
+	if (!ivsize)
+		ivsize = 1;
+
+	if (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP)
+		mflags = GFP_KERNEL;
+
+	ctx->iv_buf = kmem_cache_alloc(spacc_iv_pool, mflags);
+	if (!ctx->iv_buf)
+		return -ENOMEM;
+	iv = ctx->iv_buf;
+
+	sg_init_table(iv->sg, ARRAY_SIZE(iv->sg));
+	sg_init_table(iv->spacc_adata_sg, ARRAY_SIZE(iv->spacc_adata_sg));
+
+	B0len = 0;
+	ctx->aead_nents = 0;
+
+	memset(iv->iv, 0, SPACC_MAX_IV_SIZE);
+	memset(iv->spacc_adata, 0, ADATA_BUF_SIZE);
+
+	/* copy the IV out for AAD */
+	memcpy(iv->iv, req->iv, ivsize);
+
+	/*
+	 * Now we need to figure out the cipher IV which may or
+	 * may not be "req->iv" depending on the mode we are in
+	 */
+	if (tctx->mode & SPACC_MANGLE_IV_FLAG) {
+		switch (tctx->mode & 0x7F00) {
+		case SPACC_MANGLE_IV_RFC3686:
+		case SPACC_MANGLE_IV_RFC4106:
+		case SPACC_MANGLE_IV_RFC4543:
+			{
+				unsigned char *odata = iv->spacc_adata;
+				/*
+				 * We're in RFC3686 mode so the last
+				 * 4 bytes of the key are the SALT
+				 */
+				memcpy(odata, tctx->csalt, 4);
+				memcpy(odata + 4, req->iv, ivsize);
+
+				odata[12] = 0;
+				odata[13] = 0;
+				odata[14] = 0;
+				odata[15] = 1;
+			}
+			break;
+		case SPACC_MANGLE_IV_RFC4309:
+			{
+				unsigned char *odata = iv->spacc_adata;
+				int L, M;
+				u32 lm = req->cryptlen;
+
+				/*
+				 * CCM mode
+				 * p[0..15] is the CTR IV
+				 * p[16..31] is the CBC-MAC B0 block
+				 */
+				B0len = SPACC_B0_SIZE;
+				/* IPsec requires L=4 */
+				L = 4;
+				M = tctx->auth_size;
+
+				/* CTR block */
+				odata[0] = L - 1;
+				memcpy(odata + 1, tctx->csalt, 3);
+				memcpy(odata + 4, req->iv, ivsize);
+				odata[12] = 0;
+				odata[13] = 0;
+				odata[14] = 0;
+				odata[15] = 1;
+
+				/* store B0 block at p[16..31] */
+				odata[16] = (1 << 6) | (((M - 2) >> 1) << 3)
+					| (L - 1);
+				memcpy(odata + 1 + 16, tctx->csalt, 3);
+				memcpy(odata + 4 + 16, req->iv, ivsize);
+
+				/* now store length */
+				odata[16 + 12 + 0] = (lm >> 24) & 0xFF;
+				odata[16 + 12 + 1] = (lm >> 16) & 0xFF;
+				odata[16 + 12 + 2] = (lm >> 8) & 0xFF;
+				odata[16 + 12 + 3] = (lm) & 0xFF;
+
+				/* now store the pre-formatted AAD */
+				odata[32] = (req->assoclen >> 8) & 0xFF;
+				odata[33] = (req->assoclen) & 0xFF;
+				/* we added 2 byte header to the AAD */
+				B0len += 2;
+			}
+			break;
+		}
+	} else if (tctx->mode == CRYPTO_MODE_AES_CCM ||
+		   tctx->mode == CRYPTO_MODE_SM4_CCM) {
+		unsigned char *odata = iv->spacc_adata;
+		u8 *orig_iv = req->iv;
+		int L, M;
+
+		u32 lm = (encrypt) ?
+			 req->cryptlen :
+			 req->cryptlen - tctx->auth_size;
+
+		/* to avoid the stale data from previous ccm operations.*/
+		memset(iv->spacc_adata, 0, ADATA_CCM_BUF);
+		iv->spacc_ptextsg = req->src;
+		/*
+		 * CCM mode
+		 * p[0..15] is the CTR IV
+		 * p[16..31] is the CBC-MAC B0 block
+		 */
+		B0len = SPACC_B0_SIZE;
+
+		/* IPsec requires L=4 */
+		L = req->iv[0] + 1;
+		M = tctx->auth_size;
+
+		/*
+		 * Note: rfc 3610 and NIST 800-38C require counter of
+		 * zero to encrypt auth tag.
+		 */
+		memset(orig_iv + 15 - orig_iv[0], 0, orig_iv[0] + 1);
+
+		/* CTR block */
+		memcpy(odata, req->iv, ivsize);
+		memcpy(odata + 16, req->iv, ivsize);
+
+		/*
+		 * Taken from ccm.c
+		 * Note: rfc 3610 and NIST 800-38C require counter of
+		 * zero to encrypt auth tag.
+		 */
+
+		/* store B0 block at p[16..31] */
+		odata[16] |= (8 * ((M - 2) / 2));
+
+		/* set adata if assoclen > 0 */
+		if (req->assoclen)
+			odata[16] |= 64;
+
+		/*
+		 * Now store length, this is L size starts from 16-L
+		 * to 16 of B0
+		 */
+		spacc_aead_set_msg_len(odata + 16 + 16 - L, lm, L);
+
+		if (req->assoclen) {
+			/* store pre-formatted AAD: AAD_LEN + AAD + PAD */
+			*alen = spacc_aead_format_adata(&odata[32],
+							req->assoclen);
+
+			ccm_aad_16b_len =
+				ccm_16byte_aligned_len(req->assoclen + *alen);
+
+			/* adding the rest of AAD from req->src */
+			scatterwalk_map_and_copy(odata + 32 + *alen,
+						 req->src, 0,
+						 req->assoclen, 0);
+
+			/* copy AAD to req->dst */
+			scatterwalk_map_and_copy(odata + 32 + *alen, req->dst,
+						 0, req->assoclen, 1);
+
+			iv->spacc_ptextsg = scatterwalk_ffwd(iv->temp_aad,
+							     req->src,
+							     req->assoclen);
+		}
+
+		/*
+		 * Default is to copy the iv over since the
+		 * cipher and protocol IV are the same
+		 */
+		memcpy(iv->spacc_adata, req->iv, ivsize);
+	}
+
+	/* this is part of the AAD */
+	sg_set_buf(iv->sg, iv->iv, ivsize);
+
+	/* GCM and CCM don't include the IV in the AAD */
+	switch (tctx->mode) {
+	case CRYPTO_MODE_AES_GCM_RFC4106:
+	case CRYPTO_MODE_AES_GCM:
+	case CRYPTO_MODE_SM4_GCM_RFC8998:
+	case CRYPTO_MODE_CHACHA20_POLY1305:
+	case CRYPTO_MODE_NULL:
+
+		payload_len    = req->cryptlen + icvlen + req->assoclen;
+		spacc_adata_sg_buf_len = SPACC_MAX_IV_SIZE + B0len;
+
+		/*
+		 * This is the actual IV getting fed to the core
+		 * (via IV IMPORT)
+		 */
+
+		sg_set_buf(iv->spacc_adata_sg, iv->spacc_adata,
+			   spacc_adata_sg_buf_len);
+
+		sg_chain(iv->spacc_adata_sg,
+			 sg_nents_for_len(iv->spacc_adata_sg,
+					  spacc_adata_sg_buf_len) + 1, req->src);
+
+		rc = spacc_sg_to_ddt(dev, iv->spacc_adata_sg,
+				     spacc_adata_sg_buf_len + payload_len,
+				     &ctx->src, DMA_TO_DEVICE);
+
+		if (rc < 0)
+			goto err_free_iv;
+		ctx->aead_nents = rc;
+		break;
+	case CRYPTO_MODE_AES_CCM:
+	case CRYPTO_MODE_AES_CCM_RFC4309:
+	case CRYPTO_MODE_SM4_CCM:
+
+		if (encrypt)
+			payload_len =
+				ccm_16byte_aligned_len(req->cryptlen + icvlen);
+		else
+			payload_len =
+				ccm_16byte_aligned_len(req->cryptlen);
+
+		spacc_adata_sg_buf_len = SPACC_MAX_IV_SIZE + B0len +
+							ccm_aad_16b_len;
+
+		/*
+		 * This is the actual IV getting fed to the core (via IV IMPORT)
+		 * This has CTR IV + B0 + AAD(B1, B2, ...)
+		 */
+		sg_set_buf(iv->spacc_adata_sg, iv->spacc_adata,
+			   spacc_adata_sg_buf_len);
+		sg_chain(iv->spacc_adata_sg,
+			 sg_nents_for_len(iv->spacc_adata_sg,
+					  spacc_adata_sg_buf_len) + 1,
+					  iv->spacc_ptextsg);
+
+		rc = spacc_sg_to_ddt(dev, iv->spacc_adata_sg,
+				     spacc_adata_sg_buf_len + payload_len,
+				     &ctx->src, DMA_TO_DEVICE);
+		if (rc < 0)
+			goto err_free_iv;
+		ctx->aead_nents = rc;
+		break;
+	default:
+
+		/*
+		 * This is the actual IV getting fed to the core (via IV IMPORT)
+		 * This has CTR IV + B0 + AAD(B1, B2, ...)
+		 */
+		payload_len = req->cryptlen + icvlen + req->assoclen;
+		spacc_adata_sg_buf_len = SPACC_MAX_IV_SIZE + B0len;
+		sg_set_buf(iv->spacc_adata_sg, iv->spacc_adata,
+			   spacc_adata_sg_buf_len);
+
+		sg_chain(iv->spacc_adata_sg,
+			 sg_nents_for_len(iv->spacc_adata_sg,
+					  spacc_adata_sg_buf_len) + 1,
+					  req->src);
+
+		rc = spacc_sg_to_ddt(dev, iv->spacc_adata_sg,
+				     spacc_adata_sg_buf_len + payload_len,
+				     &ctx->src, DMA_TO_DEVICE);
+
+		if (rc < 0)
+			goto err_free_iv;
+		ctx->aead_nents = rc;
+	}
+
+	/*
+	 * Putting in req->dst is good since it won't overwrite anything
+	 * even in case of CCM this is fine condition
+	 */
+	if (req->dst != req->src) {
+		switch (tctx->mode) {
+		case CRYPTO_MODE_AES_CCM:
+		case CRYPTO_MODE_AES_CCM_RFC4309:
+		case CRYPTO_MODE_SM4_CCM:
+			/*
+			 * If req->dst buffer len is not-positive,
+			 * then skip setting up of DMA
+			 */
+			if (req->dst->length <= 0) {
+				ctx->dst_nents = 0;
+				return 0;
+			}
+
+			if (encrypt)
+				payload_len = req->cryptlen + icvlen +
+						req->assoclen;
+			else
+				payload_len = req->cryptlen - tctx->auth_size +
+						req->assoclen;
+			/*
+			 * For corner cases where PTlen=AADlen=0, we set default
+			 * to 16
+			 */
+			rc = spacc_sg_to_ddt(dev, req->dst,
+					     payload_len > 0 ? payload_len : 16,
+					     &ctx->dst, DMA_FROM_DEVICE);
+			if (rc < 0)
+				goto err_free_src;
+			ctx->dst_nents = rc;
+			break;
+		default:
+
+			/*
+			 * If req->dst buffer len is not-positive,
+			 * then skip setting up of DMA
+			 */
+			if (req->dst->length <= 0) {
+				ctx->dst_nents = 0;
+				return 0;
+			}
+
+			if (encrypt) {
+				payload_len = SPACC_MAX_IV_SIZE + req->cryptlen
+						+ icvlen + req->assoclen;
+			} else {
+				payload_len = req->cryptlen - tctx->auth_size +
+						req->assoclen;
+				if (payload_len <= 0)
+					return -EBADMSG;
+			}
+
+			rc = spacc_sg_to_ddt(dev, req->dst,
+					     payload_len > 0 ? payload_len : 16,
+					     &ctx->dst, DMA_FROM_DEVICE);
+			if (rc < 0)
+				goto err_free_src;
+			ctx->dst_nents = rc;
+		}
+	}
+
+	return 0;
+
+err_free_src:
+	if (ctx->aead_nents) {
+		dma_unmap_sg(dev, iv->spacc_adata_sg, ctx->aead_nents,
+			     DMA_TO_DEVICE);
+
+		pdu_ddt_free(&ctx->src);
+	}
+
+err_free_iv:
+	kmem_cache_free(spacc_iv_pool, ctx->iv_buf);
+
+	return rc;
+}
+
+static void spacc_aead_cleanup_dma(struct device *dev, struct aead_request *req)
+{
+	struct spacc_crypto_reqctx *ctx = aead_request_ctx(req);
+	struct spacc_iv_buf *iv = ctx->iv_buf;
+
+	if (req->src != req->dst && ctx->dst_nents > 0) {
+		dma_unmap_sg(dev, req->dst, ctx->dst_nents,
+			     DMA_FROM_DEVICE);
+		pdu_ddt_free(&ctx->dst);
+	}
+
+	if (ctx->aead_nents) {
+		dma_unmap_sg(dev, iv->spacc_adata_sg, ctx->aead_nents,
+			     DMA_TO_DEVICE);
+
+		pdu_ddt_free(&ctx->src);
+	}
+
+	kmem_cache_free(spacc_iv_pool, ctx->iv_buf);
+}
+
+static bool spacc_check_keylen(const struct spacc_alg *salg,
+			       unsigned int keylen)
+{
+	unsigned int bit_position, mask = salg->keylen_mask;
+
+	if (mask > (1ul << ARRAY_SIZE(salg->mode->keylen)) - 1)
+		return false;
+
+	for (bit_position = 0; mask; bit_position++, mask >>= 1) {
+		if (mask & 1 && salg->mode->keylen[bit_position] == keylen)
+			return true;
+	}
+
+	return false;
+}
+
+static void spacc_aead_cb(void *spacc, void *tfm)
+{
+	int err = -1;
+	struct aead_cb_data *cb = tfm;
+	struct spacc_device *device = (struct spacc_device *)spacc;
+
+	u32 status_reg = readl(cb->spacc->regmap + SPACC_REG_STATUS);
+
+	/*
+	 * Extract RET_CODE field (bits 25:24) from STATUS register to check
+	 * result of the crypto operation.
+	 */
+	u32 status_ret = (status_reg >> 24) & 0x3;
+
+	dma_sync_sg_for_cpu(cb->tctx->dev, cb->req->dst,
+			    cb->ctx->dst_nents, DMA_FROM_DEVICE);
+
+	/* ICV mismatch send bad msg */
+	if (status_ret == 0x1) {
+		err = -EBADMSG;
+		goto REQ_DST_CP_SKIP;
+	}
+	err = cb->spacc->job[cb->new_handle].job_err;
+
+REQ_DST_CP_SKIP:
+	spacc_aead_cleanup_dma(cb->tctx->dev, cb->req);
+	spacc_close(cb->spacc, cb->new_handle);
+
+	/* call complete */
+	local_bh_disable();
+	aead_request_complete(cb->req, err);
+	local_bh_enable();
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
+				if (cur_pos && cur_pos->wait_done == 1) {
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
+static int spacc_aead_setkey(struct crypto_aead *tfm, const u8 *key,
+			     unsigned int keylen)
+{
+	int err = 0;
+	int ret = 0;
+	int singlekey = 0;
+	unsigned char xcbc[64];
+	unsigned int enckeylen;
+	unsigned int authkeylen;
+	const unsigned char *authkey, *enckey;
+	struct spacc_crypto_ctx *ctx  = crypto_aead_ctx(tfm);
+	const struct spacc_alg  *salg = spacc_tfm_aead(&tfm->base);
+	struct crypto_authenc_keys authenc_keys;
+	struct spacc_priv *priv;
+
+	/* are keylens valid? */
+	ctx->ctx_valid = false;
+
+	switch (ctx->mode & 0xFF) {
+	case CRYPTO_MODE_SM4_GCM:
+	case CRYPTO_MODE_SM4_CCM:
+	case CRYPTO_MODE_NULL:
+	case CRYPTO_MODE_AES_GCM:
+	case CRYPTO_MODE_AES_CCM:
+	case CRYPTO_MODE_CHACHA20_POLY1305:
+		authkey      = key;
+		authkeylen   = 0;
+		enckey       = key;
+		enckeylen    = keylen;
+		ctx->keylen  = keylen;
+		singlekey    = 1;
+		goto skipover;
+	}
+
+	err = crypto_authenc_extractkeys(&authenc_keys, key, keylen);
+	if (err)
+		return err;
+
+	authkeylen = authenc_keys.authkeylen;
+	authkey    = authenc_keys.authkey;
+	enckeylen  = authenc_keys.enckeylen;
+	enckey     = authenc_keys.enckey;
+
+skipover:
+	/* detect RFC3686/4106 and trim from enckeylen(and copy salt..) */
+	if (ctx->mode & SPACC_MANGLE_IV_FLAG) {
+		switch (ctx->mode & 0x7F00) {
+		case SPACC_MANGLE_IV_RFC3686:
+		case SPACC_MANGLE_IV_RFC4106:
+		case SPACC_MANGLE_IV_RFC4543:
+			memcpy(ctx->csalt, enckey + enckeylen - 4, 4);
+			enckeylen -= 4;
+			break;
+		case SPACC_MANGLE_IV_RFC4309:
+			memcpy(ctx->csalt, enckey + enckeylen - 3, 3);
+			enckeylen -= 3;
+			break;
+		}
+	}
+
+	if (!singlekey) {
+		if (authkeylen > salg->mode->hashlen) {
+			dev_warn(ctx->dev, "Auth key size of %u is not valid\n",
+				 authkeylen);
+			return -EINVAL;
+		}
+	}
+
+	if (!spacc_check_keylen(salg, enckeylen)) {
+		dev_dbg(ctx->dev, "Enc key size of %u is not valid\n",
+			enckeylen);
+		return -EINVAL;
+	}
+
+	/*
+	 * if we're already open close the handle since
+	 * the size may have changed
+	 */
+	if (ctx->handle != -1) {
+		priv = dev_get_drvdata(ctx->dev);
+		spacc_close(&priv->spacc, ctx->handle);
+		put_device(ctx->dev);
+		ctx->handle = -1;
+	}
+
+	/* reset priv */
+	priv = NULL;
+	priv = dev_get_drvdata(salg->dev);
+
+	/* increase reference */
+	ctx->dev = get_device(salg->dev);
+
+	/* check if its a valid mode */
+	ret = (spacc_is_mode_keysize_supported(&priv->spacc,
+					       salg->mode->aead.ciph & 0xFF,
+					       enckeylen, 0) &&
+					       spacc_is_mode_keysize_supported
+					       (&priv->spacc,
+						salg->mode->aead.hash & 0xFF,
+						authkeylen, 0));
+
+	if (ret) {
+		/* try to open spacc handle */
+		ctx->handle = spacc_open(&priv->spacc,
+					 salg->mode->aead.ciph & 0xFF,
+					 salg->mode->aead.hash & 0xFF,
+					 -1, 0, spacc_aead_cb, tfm);
+		if (ctx->handle < 0) {
+			put_device(salg->dev);
+			dev_dbg(salg->dev, "Failed to open SPAcc context\n");
+			return -EIO;
+		}
+	} else {
+		dev_err(salg->dev, "  Keylen: %d not enabled for algo: %d",
+			keylen, salg->mode->id);
+	}
+
+	/* setup XCBC key */
+	if (salg->mode->aead.hash == CRYPTO_MODE_MAC_XCBC) {
+		err = spacc_compute_xcbc_key(&priv->spacc,
+					     salg->mode->aead.hash,
+					     ctx->handle, authkey,
+					     authkeylen, xcbc);
+		if (err < 0) {
+			dev_warn(ctx->dev, "Failed to compute XCBC key: %d\n",
+				 err);
+			return -EIO;
+		}
+		authkey    = xcbc;
+		authkeylen = 48;
+	}
+
+	/* handle zero key/zero len DEC condition for SM4/AES GCM mode */
+	ctx->zero_key = 0;
+	if (!key[0]) {
+		int index, val = 0;
+
+		for (index = 0; index < keylen ; index++)
+			val += key[index];
+
+		if (val == 0)
+			ctx->zero_key = 1;
+	}
+
+	err = spacc_write_context(&priv->spacc, ctx->handle,
+				  SPACC_CRYPTO_OPERATION, enckey,
+				  enckeylen, NULL, 0);
+
+	if (err) {
+		dev_warn(ctx->dev,
+			 "Could not write cipher context: %d\n", err);
+		return -EIO;
+	}
+
+	if (!singlekey) {
+		err = spacc_write_context(&priv->spacc, ctx->handle,
+					  SPACC_HASH_OPERATION, authkey,
+					  authkeylen, NULL, 0);
+		if (err) {
+			dev_warn(ctx->dev,
+				 "Could not write hashing context: %d\n", err);
+			return -EIO;
+		}
+	}
+
+	/* set expand key */
+	spacc_set_key_exp(&priv->spacc, ctx->handle);
+	ctx->ctx_valid = true;
+
+	memset(xcbc, 0, sizeof(xcbc));
+
+	/* copy key to ctx for fallback */
+	memcpy(ctx->key, key, keylen);
+
+	return 0;
+}
+
+static int spacc_aead_setauthsize(struct crypto_aead *tfm,
+				  unsigned int authsize)
+{
+	struct spacc_crypto_ctx *ctx = crypto_aead_ctx(tfm);
+
+	ctx->auth_size = authsize;
+
+	/* Taken from crypto/ccm.c */
+	switch (ctx->mode) {
+	case CRYPTO_MODE_SM4_GCM:
+	case CRYPTO_MODE_AES_GCM:
+		switch (authsize) {
+		case 4:
+		case 8:
+		case 12:
+		case 13:
+		case 14:
+		case 15:
+		case 16:
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+
+	case CRYPTO_MODE_AES_CCM:
+	case CRYPTO_MODE_SM4_CCM:
+		switch (authsize) {
+		case 4:
+		case 6:
+		case 8:
+		case 10:
+		case 12:
+		case 14:
+		case 16:
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+
+	case CRYPTO_MODE_CHACHA20_POLY1305:
+		switch (authsize) {
+		case 16:
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	}
+
+	return 0;
+}
+
+static int spacc_aead_fallback(struct aead_request *req,
+			       struct spacc_crypto_ctx *ctx, int encrypt)
+{
+	int ret = 0;
+	struct aead_request *subreq = aead_request_ctx(req);
+	struct crypto_aead *reqtfm  = crypto_aead_reqtfm(req);
+	struct aead_alg *alg	    = crypto_aead_alg(reqtfm);
+	const char *aead_name	    = alg->base.cra_name;
+
+	ctx->fb.aead = crypto_alloc_aead(aead_name, 0,
+					 CRYPTO_ALG_NEED_FALLBACK |
+					 CRYPTO_ALG_ASYNC);
+	if (IS_ERR(ctx->fb.aead)) {
+		dev_err(ctx->dev, "Spacc aead fallback tfm is NULL!\n");
+		return PTR_ERR(ctx->fb.aead);
+	}
+
+	subreq = aead_request_alloc(ctx->fb.aead, GFP_KERNEL);
+	if (!subreq)
+		return -ENOMEM;
+
+	ret = crypto_aead_setkey(ctx->fb.aead, ctx->key, ctx->keylen);
+	if (ret)
+		dev_err(ctx->dev, "fallback aead setkey() returned:%d\n", ret);
+
+	crypto_aead_setauthsize(ctx->fb.aead, ctx->auth_size);
+
+	aead_request_set_tfm(subreq, ctx->fb.aead);
+	aead_request_set_callback(subreq, req->base.flags,
+				  req->base.complete, req->base.data);
+	aead_request_set_crypt(subreq, req->src, req->dst, req->cryptlen,
+			       req->iv);
+	aead_request_set_ad(subreq, req->assoclen);
+
+	if (encrypt)
+		ret = crypto_aead_encrypt(subreq);
+	else
+		ret = crypto_aead_decrypt(subreq);
+
+	aead_request_free(subreq);
+	crypto_free_aead(ctx->fb.aead);
+	ctx->fb.aead = NULL;
+
+	return ret;
+}
+
+static int spacc_aead_process(struct aead_request *req, u64 seq, int encrypt)
+{
+	int rc = 0;
+	int B0len;
+	int alen = 0;
+	u32 dstoff;
+	int icvremove;
+	int ivaadsize;
+	int ptaadsize = 0;
+	int iv_to_context;
+	int spacc_proc_len;
+	u32 spacc_icv_offset = 0;
+	int spacc_pre_aad_size;
+	int ccm_aad_16b_len = 0;
+	struct crypto_aead *reqtfm	= crypto_aead_reqtfm(req);
+	int ivsize			= crypto_aead_ivsize(reqtfm);
+	struct spacc_crypto_ctx *tctx   = crypto_aead_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = aead_request_ctx(req);
+	struct spacc_priv *priv		= dev_get_drvdata(tctx->dev);
+
+	ctx->encrypt_op = encrypt;
+
+	if (tctx->handle < 0 || !tctx->ctx_valid || (req->cryptlen +
+				req->assoclen) > priv->max_msg_len)
+		return -EINVAL;
+
+	/* IV is programmed to context by default */
+	iv_to_context = SET_IV_IN_CONTEXT;
+
+	if (encrypt) {
+		switch (tctx->mode & 0xFF) {
+		case CRYPTO_MODE_AES_GCM:
+		case CRYPTO_MODE_SM4_GCM:
+		case CRYPTO_MODE_CHACHA20_POLY1305:
+			/* For cryptlen = 0 */
+			if (req->cryptlen + req->assoclen == 0)
+				return spacc_aead_fallback(req, tctx, encrypt);
+			break;
+		case CRYPTO_MODE_AES_CCM:
+		case CRYPTO_MODE_SM4_CCM:
+
+			if (req->cryptlen + req->assoclen == 0)
+				return spacc_aead_fallback(req, tctx, encrypt);
+
+			/*
+			 * verify that msglen can in fact be represented
+			 * in L bytes
+			 *
+			 * 2 <= L <= 8, so 1 <= L' <= 7
+			 */
+			if (req->iv[0] < 1 || req->iv[0] > 7)
+				return -EINVAL;
+
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		/* handle decryption */
+		switch (tctx->mode & 0xFF) {
+		case CRYPTO_MODE_AES_GCM:
+		case CRYPTO_MODE_SM4_GCM:
+		case CRYPTO_MODE_CHACHA20_POLY1305:
+			/* for assoclen = 0 */
+			if (req->assoclen == 0 &&
+			    (req->cryptlen - tctx->auth_size == 0))
+				return spacc_aead_fallback(req, tctx, encrypt);
+			break;
+		case CRYPTO_MODE_AES_CCM:
+		case CRYPTO_MODE_SM4_CCM:
+			if (req->assoclen == 0 &&
+			    (req->cryptlen - tctx->auth_size == 0))
+				return spacc_aead_fallback(req, tctx, encrypt);
+			/* 2 <= L <= 8, so 1 <= L' <= 7 */
+			if (req->iv[0] < 1 || req->iv[0] > 7)
+				return -EINVAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	icvremove = (encrypt) ? 0 : tctx->auth_size;
+
+	rc = spacc_aead_init_dma(tctx->dev, req, seq, (encrypt) ?
+			tctx->auth_size : 0, encrypt, &alen);
+	if (rc < 0)
+		return -EINVAL;
+
+	if (req->assoclen)
+		ccm_aad_16b_len = ccm_16byte_aligned_len(req->assoclen + alen);
+
+	/* Note: This won't work if IV_IMPORT has been disabled */
+	ctx->cb.new_handle = spacc_clone_handle(&priv->spacc, tctx->handle,
+						&ctx->cb);
+	if (ctx->cb.new_handle < 0) {
+		spacc_aead_cleanup_dma(tctx->dev, req);
+		return -EINVAL;
+	}
+
+	ctx->cb.tctx  = tctx;
+	ctx->cb.ctx   = ctx;
+	ctx->cb.req   = req;
+	ctx->cb.spacc = &priv->spacc;
+
+	/*
+	 * Write IV to the spacc-context
+	 * IV can be written to context or as part of the input src buffer
+	 * IV in case of CCM is going in the input src buff.
+	 * IV for GCM is written to the context.
+	 */
+	if (tctx->mode == CRYPTO_MODE_AES_GCM_RFC4106	||
+	    tctx->mode == CRYPTO_MODE_AES_GCM		||
+	    tctx->mode == CRYPTO_MODE_SM4_GCM_RFC8998	||
+	    tctx->mode == CRYPTO_MODE_CHACHA20_POLY1305	||
+	    tctx->mode == CRYPTO_MODE_NULL) {
+		iv_to_context = SET_IV_IN_CONTEXT;
+		rc = spacc_write_context(&priv->spacc, ctx->cb.new_handle,
+					 SPACC_CRYPTO_OPERATION, NULL, 0,
+					 req->iv, ivsize);
+
+		if (rc < 0) {
+			spacc_aead_cleanup_dma(tctx->dev, req);
+			spacc_close(&priv->spacc, ctx->cb.new_handle);
+			return -EINVAL;
+		}
+	}
+
+	/* CCM and GCM don't include the IV in the AAD */
+	if (tctx->mode == CRYPTO_MODE_AES_GCM_RFC4106	||
+	    tctx->mode == CRYPTO_MODE_AES_CCM_RFC4309	||
+	    tctx->mode == CRYPTO_MODE_AES_GCM		||
+	    tctx->mode == CRYPTO_MODE_AES_CCM		||
+	    tctx->mode == CRYPTO_MODE_SM4_CCM		||
+	    tctx->mode == CRYPTO_MODE_SM4_GCM_RFC8998	||
+	    tctx->mode == CRYPTO_MODE_CHACHA20_POLY1305	||
+	    tctx->mode == CRYPTO_MODE_NULL) {
+		ivaadsize = 0;
+	} else {
+		ivaadsize = ivsize;
+	}
+	/* CCM requires an extra block of AAD */
+	if (tctx->mode == CRYPTO_MODE_AES_CCM_RFC4309 ||
+	    tctx->mode == CRYPTO_MODE_AES_CCM	      ||
+	    tctx->mode == CRYPTO_MODE_SM4_CCM)
+		B0len = SPACC_B0_SIZE;
+	else
+		B0len = 0;
+
+	/*
+	 * GMAC mode uses AAD for the entire message.
+	 * So does NULL cipher
+	 */
+	if (tctx->mode == CRYPTO_MODE_AES_GCM_RFC4543 ||
+	    tctx->mode == CRYPTO_MODE_NULL) {
+		if (req->cryptlen >= icvremove)
+			ptaadsize = req->cryptlen - icvremove;
+	}
+
+	/*
+	 * Calculate and set the below, important parameters
+	 * spacc icv offset   - spacc_icv_offset
+	 * destination offset - dstoff
+	 * IV to context      - This is set for CCM, not set for GCM
+	 */
+	if (req->dst == req->src) {
+		dstoff = ((uint32_t)(SPACC_MAX_IV_SIZE + B0len +
+				     req->assoclen + ivaadsize));
+
+		/* CCM case */
+		if (tctx->mode == CRYPTO_MODE_AES_CCM_RFC4309	||
+		    tctx->mode == CRYPTO_MODE_AES_CCM		||
+		    tctx->mode == CRYPTO_MODE_SM4_CCM) {
+			iv_to_context = SET_IV_IN_SRCBUF;
+			dstoff = ((uint32_t)(SPACC_MAX_IV_SIZE + B0len +
+				 ccm_aad_16b_len + ivaadsize));
+		}
+	} else {
+		dstoff = ((uint32_t)(req->assoclen + ivaadsize));
+
+		/* CCM case */
+		if (tctx->mode == CRYPTO_MODE_AES_CCM_RFC4309	||
+		    tctx->mode == CRYPTO_MODE_AES_CCM		||
+		    tctx->mode == CRYPTO_MODE_SM4_CCM) {
+			iv_to_context = SET_IV_IN_SRCBUF;
+			dstoff = ((uint32_t)(req->assoclen + ivaadsize));
+		}
+	}
+
+	/*
+	 * Calculate and set the below, important parameters
+	 * spacc proc_len - spacc_proc_len
+	 * pre-AAD size   - spacc_pre_aad_size
+	 */
+	if (tctx->mode == CRYPTO_MODE_AES_CCM		||
+	    tctx->mode == CRYPTO_MODE_SM4_CCM		||
+	    tctx->mode == CRYPTO_MODE_AES_CCM_RFC4309	||
+	    tctx->mode == CRYPTO_MODE_SM4_CCM_RFC8998) {
+		spacc_proc_len = B0len + ccm_aad_16b_len
+				+ req->cryptlen + ivaadsize
+				- icvremove;
+		spacc_pre_aad_size = B0len + ccm_aad_16b_len
+				+ ivaadsize + ptaadsize;
+	} else {
+		spacc_proc_len = B0len + req->assoclen
+				+ req->cryptlen - icvremove
+				+ ivaadsize;
+		spacc_pre_aad_size = B0len + req->assoclen
+				+ ivaadsize + ptaadsize;
+	}
+
+	rc = spacc_set_operation(&priv->spacc,
+				 ctx->cb.new_handle,
+				 encrypt ? OP_ENCRYPT : OP_DECRYPT,
+				 ICV_ENCRYPT_HASH, IP_ICV_APPEND,
+				 spacc_icv_offset,
+				 tctx->auth_size, 0);
+
+	rc = spacc_packet_enqueue_ddt(&priv->spacc, ctx->cb.new_handle,
+				      &ctx->src,
+				      (req->dst == req->src) ? &ctx->src :
+				      &ctx->dst, spacc_proc_len,
+				      (dstoff << SPACC_OFFSET_DST_O) |
+				      SPACC_MAX_IV_SIZE,
+				      spacc_pre_aad_size,
+				      0, iv_to_context, 0);
+
+	if (rc < 0) {
+		spacc_aead_cleanup_dma(tctx->dev, req);
+		spacc_close(&priv->spacc, ctx->cb.new_handle);
+
+		if (rc != -EBUSY) {
+			dev_err(tctx->dev, "  failed to enqueue job, ERR: %d\n",
+				rc);
+		}
+
+		if (!(req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG))
+			return -EBUSY;
+
+		return -EINVAL;
+	}
+
+	/*
+	 * At this point the job is in flight to the engine ... remove first use
+	 * so subsequent calls don't expand the key again... ideally we would
+	 * pump a dummy job through the engine to pre-expand the key so that by
+	 * the time setkey was done we wouldn't have to do this.
+	 */
+	priv->spacc.job[tctx->handle].first_use  = 0;
+	priv->spacc.job[tctx->handle].ctrl &= ~(1UL
+			<< priv->spacc.config.ctrl_map[SPACC_CTRL_KEY_EXP]);
+
+	return -EINPROGRESS;
+}
+
+static int spacc_aead_encrypt(struct aead_request *req)
+{
+	return spacc_aead_process(req, 0ULL, 1);
+}
+
+static int spacc_aead_decrypt(struct aead_request *req)
+{
+	return spacc_aead_process(req, 0ULL, 0);
+}
+
+static int spacc_aead_init(struct crypto_aead *tfm)
+{
+	struct spacc_crypto_ctx *ctx   = crypto_aead_ctx(tfm);
+	const struct spacc_alg  *salg = spacc_tfm_aead(&tfm->base);
+
+	ctx->zero_key = 0;
+	ctx->fb.aead  = NULL;
+	ctx->handle   = -1;
+	ctx->mode     = salg->mode->aead.ciph;
+	ctx->dev      = get_device(salg->dev);
+
+	crypto_aead_set_reqsize(tfm, sizeof(struct spacc_crypto_reqctx));
+
+	return 0;
+}
+
+static void spacc_aead_exit(struct crypto_aead *tfm)
+{
+	struct spacc_crypto_ctx *ctx = crypto_aead_ctx(tfm);
+	struct spacc_priv *priv = dev_get_drvdata(ctx->dev);
+
+	ctx->fb.aead = NULL;
+	/* close spacc handle */
+	if (ctx->handle >= 0) {
+		spacc_close(&priv->spacc, ctx->handle);
+		ctx->handle = -1;
+	}
+
+	put_device(ctx->dev);
+}
+
+static struct aead_alg spacc_aead_algs = {
+	.setkey      = spacc_aead_setkey,
+	.setauthsize = spacc_aead_setauthsize,
+	.encrypt     = spacc_aead_encrypt,
+	.decrypt     = spacc_aead_decrypt,
+	.init        = spacc_aead_init,
+	.exit        = spacc_aead_exit,
+
+	.base.cra_priority = 300,
+	.base.cra_module   = THIS_MODULE,
+	.base.cra_ctxsize  = sizeof(struct spacc_crypto_ctx),
+	.base.cra_flags    = CRYPTO_ALG_TYPE_AEAD	 |
+			     CRYPTO_ALG_ASYNC		 |
+			     CRYPTO_ALG_NEED_FALLBACK	 |
+			     CRYPTO_ALG_KERN_DRIVER_ONLY |
+			     CRYPTO_ALG_OPTIONAL_KEY
+};
+
+static int spacc_register_aead(unsigned int aead_mode,
+			       struct platform_device *spacc_pdev)
+{
+	int rc = 0;
+	struct spacc_alg *salg;
+
+	salg = kmalloc(sizeof(*salg), GFP_KERNEL);
+	if (!salg)
+		return -ENOMEM;
+
+	salg->mode	= &possible_aeads[aead_mode];
+	salg->dev	= &spacc_pdev->dev;
+	salg->calg	= &salg->alg.aead.base;
+	salg->alg.aead	= spacc_aead_algs;
+
+	spacc_init_aead_alg(salg->calg, salg->mode);
+
+	salg->alg.aead.ivsize		  = salg->mode->ivlen;
+	salg->alg.aead.maxauthsize	  = salg->mode->hashlen;
+	salg->alg.aead.base.cra_blocksize = salg->mode->blocklen;
+
+	salg->keylen_mask = possible_aeads[aead_mode].keylen_mask;
+
+	if (salg->mode->aead.ciph & SPACC_MANGLE_IV_FLAG) {
+		switch (salg->mode->aead.ciph & 0x7F00) {
+		case SPACC_MANGLE_IV_RFC3686: /* CTR */
+		case SPACC_MANGLE_IV_RFC4106: /* GCM */
+		case SPACC_MANGLE_IV_RFC4543: /* GMAC */
+		case SPACC_MANGLE_IV_RFC4309: /* CCM */
+		case SPACC_MANGLE_IV_RFC8998: /* GCM/CCM */
+			salg->alg.aead.ivsize  = 12;
+			break;
+		}
+	}
+
+	rc = crypto_register_aead(&salg->alg.aead);
+	if (rc < 0) {
+		kfree(salg);
+		return rc;
+	}
+
+	mutex_lock(&spacc_aead_alg_mutex);
+	list_add(&salg->list, &spacc_aead_alg_list);
+	mutex_unlock(&spacc_aead_alg_mutex);
+
+	return 0;
+}
+
+int spacc_probe_aeads(struct platform_device *spacc_pdev)
+{
+	int err = 0;
+	unsigned int x, y;
+	struct spacc_priv *priv = NULL;
+
+	size_t alloc_size = max_t(unsigned long,
+			roundup_pow_of_two(sizeof(struct spacc_iv_buf)),
+			dma_get_cache_alignment());
+
+	spacc_iv_pool = kmem_cache_create("spacc-aead-iv", alloc_size,
+					  alloc_size, 0, NULL);
+
+	if (!spacc_iv_pool)
+		return -ENOMEM;
+
+	for (x = 0; x < ARRAY_SIZE(possible_aeads); x++) {
+		possible_aeads[x].keylen_mask = 0;
+		possible_aeads[x].valid       = 0;
+	}
+
+	/* compute cipher key masks */
+	priv = dev_get_drvdata(&spacc_pdev->dev);
+
+	for (x = 0; x < ARRAY_SIZE(possible_aeads); x++) {
+		for (y = 0; y < ARRAY_SIZE(possible_aeads[x].keylen); y++) {
+			if (spacc_is_mode_keysize_supported(&priv->spacc,
+					    possible_aeads[x].aead.ciph & 0xFF,
+					    possible_aeads[x].keylen[y], 0))
+				possible_aeads[x].keylen_mask |= 1u << y;
+		}
+	}
+
+	/* scan for combined modes */
+	priv = dev_get_drvdata(&spacc_pdev->dev);
+
+	for (x = 0; x < ARRAY_SIZE(possible_aeads); x++) {
+		if (!possible_aeads[x].valid && possible_aeads[x].keylen_mask &&
+		    spacc_is_mode_keysize_supported(&priv->spacc,
+					possible_aeads[x].aead.hash & 0xFF,
+					possible_aeads[x].hashlen, 0)) {
+			possible_aeads[x].valid = 1;
+			err = spacc_register_aead(x, spacc_pdev);
+			if (err < 0)
+				goto error;
+		}
+	}
+
+	return 0;
+
+error:
+	return err;
+}
+
+int spacc_unregister_aead_algs(void)
+{
+	struct spacc_alg *salg, *tmp;
+
+	mutex_lock(&spacc_aead_alg_mutex);
+
+	list_for_each_entry_safe(salg, tmp, &spacc_aead_alg_list, list) {
+		crypto_unregister_alg(salg->calg);
+		list_del(&salg->list);
+		kfree(salg);
+	}
+
+	mutex_unlock(&spacc_aead_alg_mutex);
+
+	kmem_cache_destroy(spacc_iv_pool);
+
+	return 0;
+}
-- 
2.25.1


