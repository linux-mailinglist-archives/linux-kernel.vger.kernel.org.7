Return-Path: <linux-kernel+bounces-846687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4042BC8BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11C714E3E43
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03A62E03F2;
	Thu,  9 Oct 2025 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fLOMUqv8"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7E52E1F04;
	Thu,  9 Oct 2025 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008716; cv=none; b=EdrFVvNo47OZLnVjw4YlYGZCdFXgHYKNNfzJhfNhwbKP4J7I7JvBl2AtBW+WF4K4wNpYLNSrAowvxGh5E9y+hIe/dMqCtA9ofKzqEZosOQCZXJhyKQmMORgGOzUgyvE41gYjjX0BZVwmJR1ABlws7akIKGsuRukoBH1+cAUT7W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008716; c=relaxed/simple;
	bh=q2oMz3SRh0n9q41sANI8M6Fc5nX4rwImmkjPlB1jTqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tY6bGpmgCa/H6MxJzmLk8/KCOnGnrQAir/+VuPa98teKBP81POtMLtumv15qLNRL1LCGaA0J5ZzQ6YyrD8V/lArIqzsZ12wm9CfAo7O6HKjLFmqoQyKZXJRH0zhU9c15J9r2lgxaOUs5KtO8MszG/m6Gv7Z4HQwirwzV3F6UzoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fLOMUqv8; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 599BIKR2071161;
	Thu, 9 Oct 2025 06:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760008700;
	bh=tCvGBB+tCiNDgHP1AnE+3A1QuXYXqzQFHFmoAxKpdPY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fLOMUqv8m4jR4Di9yeXF1JnJJ35s7I63xbdzLsh9R7PxS1jKggNqrUA2qdJNPRUBQ
	 jZKUHoolL6d4Fc4vad7+Mkp7ZEnp5Nr858BMZ/nErAiPmWtdDwganDL6KenOo3iK9P
	 vtW4jZrbNoI8AbYI3xtN4AZ44/YPkub87WP/M4B0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 599BIKJA263670
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 9 Oct 2025 06:18:20 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 9
 Oct 2025 06:18:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Oct 2025 06:18:20 -0500
Received: from pratham-Workstation-PC (pratham-workstation-pc.dhcp.ti.com [10.24.69.191])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 599BIIdJ4130478;
	Thu, 9 Oct 2025 06:18:19 -0500
From: T Pratham <t-pratham@ti.com>
To: T Pratham <t-pratham@ti.com>, Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC: Manorit Chawdhry <m-chawdhry@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
        Shiva Tripathi <s-tripathi1@ti.com>,
        Kavitha Malarvizhi
	<k-malarvizhi@ti.com>,
        Vishal Mahaveer <vishalm@ti.com>, Praneeth Bajjuri
	<praneeth@ti.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/4] crypto: ti - Add support for AES-GCM in DTHEv2 driver
Date: Thu, 9 Oct 2025 16:11:33 +0530
Message-ID: <20251009111727.911738-4-t-pratham@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009111727.911738-1-t-pratham@ti.com>
References: <20251009111727.911738-1-t-pratham@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

AES-GCM is an AEAD algorithm supporting both encryption and
authentication of data. This patch introduces support for AES-GCM as the
first AEAD algorithm supported by the DTHEv2 driver.

Signed-off-by: T Pratham <t-pratham@ti.com>
---
 drivers/crypto/ti/Kconfig         |   2 +
 drivers/crypto/ti/dthev2-aes.c    | 587 +++++++++++++++++++++++++++++-
 drivers/crypto/ti/dthev2-common.h |  15 +-
 3 files changed, 601 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ti/Kconfig b/drivers/crypto/ti/Kconfig
index 6027e12de279d..221e483737439 100644
--- a/drivers/crypto/ti/Kconfig
+++ b/drivers/crypto/ti/Kconfig
@@ -8,6 +8,8 @@ config CRYPTO_DEV_TI_DTHEV2
 	select CRYPTO_CBC
 	select CRYPTO_CTR
 	select CRYPTO_XTS
+	select CRYPTO_GCM
+	select SG_SPLIT
 	help
 	  This enables support for the TI DTHE V2 hw cryptography engine
 	  which can be found on TI K3 SOCs. Selecting this enables use
diff --git a/drivers/crypto/ti/dthev2-aes.c b/drivers/crypto/ti/dthev2-aes.c
index ba2cd49c4b5e3..67536024c1e8e 100644
--- a/drivers/crypto/ti/dthev2-aes.c
+++ b/drivers/crypto/ti/dthev2-aes.c
@@ -10,6 +10,7 @@
 #include <crypto/aes.h>
 #include <crypto/algapi.h>
 #include <crypto/engine.h>
+#include <crypto/gcm.h>
 #include <crypto/internal/aead.h>
 #include <crypto/internal/skcipher.h>
 
@@ -19,6 +20,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/scatterlist.h>
 
 /* Registers */
@@ -53,6 +55,7 @@
 #define DTHE_P_AES_C_LENGTH_1	0x0058
 #define DTHE_P_AES_AUTH_LENGTH	0x005C
 #define DTHE_P_AES_DATA_IN_OUT	0x0060
+#define DTHE_P_AES_TAG_OUT	0x0070
 
 #define DTHE_P_AES_SYSCONFIG	0x0084
 #define DTHE_P_AES_IRQSTATUS	0x008C
@@ -65,6 +68,7 @@ enum aes_ctrl_mode_masks {
 	AES_CTRL_CBC_MASK = BIT(5),
 	AES_CTRL_CTR_MASK = BIT(6),
 	AES_CTRL_XTS_MASK = BIT(12) | BIT(11),
+	AES_CTRL_GCM_MASK = BIT(17) | BIT(16) | BIT(6),
 };
 
 #define DTHE_AES_CTRL_MODE_CLEAR_MASK		~GENMASK(28, 5)
@@ -91,6 +95,8 @@ enum aes_ctrl_mode_masks {
 #define AES_IV_SIZE				AES_BLOCK_SIZE
 #define AES_BLOCK_WORDS				(AES_BLOCK_SIZE / sizeof(u32))
 #define AES_IV_WORDS				AES_BLOCK_WORDS
+#define DTHE_AES_GCM_AAD_MAXLEN			(BIT_ULL(32) - 1)
+#define POLL_TIMEOUT_INTERVAL			HZ
 
 static int dthe_cipher_init_tfm(struct crypto_skcipher *tfm)
 {
@@ -258,6 +264,9 @@ static void dthe_aes_set_ctrl_key(struct dthe_tfm_ctx *ctx,
 	case DTHE_AES_XTS:
 		ctrl_val |= AES_CTRL_XTS_MASK;
 		break;
+	case DTHE_AES_GCM:
+		ctrl_val |= AES_CTRL_GCM_MASK;
+		break;
 	}
 
 	if (iv_in) {
@@ -520,6 +529,548 @@ static int dthe_aes_decrypt(struct skcipher_request *req)
 	return dthe_aes_crypt(req);
 }
 
+static int dthe_aead_init_tfm(struct crypto_aead *tfm)
+{
+	struct dthe_tfm_ctx *ctx = crypto_aead_ctx(tfm);
+	struct dthe_data *dev_data = dthe_get_dev(ctx);
+
+	ctx->dev_data = dev_data;
+
+	const char *alg_name = crypto_tfm_alg_name(crypto_aead_tfm(tfm));
+
+	ctx->aead_fb = crypto_alloc_aead(alg_name, 0,
+					 CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->aead_fb)) {
+		dev_err(dev_data->dev, "fallback driver %s couldn't be loaded\n",
+			alg_name);
+		return PTR_ERR(ctx->aead_fb);
+	}
+
+	return 0;
+}
+
+static void dthe_aead_exit_tfm(struct crypto_aead *tfm)
+{
+	struct dthe_tfm_ctx *ctx = crypto_aead_ctx(tfm);
+
+	crypto_free_aead(ctx->aead_fb);
+}
+
+/**
+ * dthe_aead_prep_src - Prepare source scatterlist for AEAD from input req->src
+ * @sg: Input req->src scatterlist
+ * @assoclen: Input req->assoclen
+ * @cryptlen: Input req->cryptlen (minus the size of TAG in decryption)
+ * @assoc_pad_buf: Buffer to hold AAD padding if needed
+ * @crypt_pad_buf: Buffer to hold ciphertext/plaintext padding if needed
+ *
+ * Description:
+ *   For modes with authentication, DTHEv2 hardware requires the input AAD and
+ *   plaintext/ciphertext to be individually aligned to AES_BLOCK_SIZE. If either is not
+ *   aligned, it needs to be padded with zeros by the software before passing the data to
+ *   the hardware. However, linux crypto's aead_request provides the input with AAD and
+ *   plaintext/ciphertext contiguously appended together in a single scatterlist.
+ *
+ *   This helper function takes the input scatterlist and splits it into separate
+ *   scatterlists for AAD and plaintext/ciphertext, ensuring each is aligned to
+ *   AES_BLOCK_SIZE by adding necessary padding, and then merges the aligned scatterlists
+ *   back into a single scatterlist for processing.
+ *
+ * Return:
+ *   Pointer to the merged scatterlist, or ERR_PTR(error) on failure.
+ *   The calling function needs to free the returned scatterlist when done.
+ **/
+static struct scatterlist *dthe_aead_prep_src(struct scatterlist *sg,
+					      unsigned int assoclen,
+					      unsigned int cryptlen,
+					      u8 *assoc_pad_buf,
+					      u8 *crypt_pad_buf)
+{
+	struct scatterlist *in_sg[2];
+	struct scatterlist *to_sg;
+	struct scatterlist *src;
+	size_t split_sizes[2] = {assoclen, cryptlen};
+	int out_mapped_nents[2];
+	int crypt_nents = 0, assoc_nents = 0, src_nents = 0;
+	int err = 0;
+
+	/* sg_split does not work properly if one of the split_sizes is 0 */
+	if (cryptlen == 0 || assoclen == 0) {
+		/*
+		 * Assigning both to sg does not matter as assoclen = 0 or cryptlen = 0
+		 * being passed to dthe_copy_sg will take care to copy the sg correctly
+		 */
+		in_sg[0] = sg;
+		in_sg[1] = sg;
+
+		src_nents = sg_nents_for_len(sg, assoclen + cryptlen);
+	} else {
+		err = sg_split(sg, 0, 0, 2, split_sizes, in_sg, out_mapped_nents, GFP_KERNEL);
+		if (err)
+			goto dthe_aead_prep_src_split_err;
+		assoc_nents = sg_nents_for_len(in_sg[0], assoclen);
+		crypt_nents = sg_nents_for_len(in_sg[1], cryptlen);
+
+		src_nents = assoc_nents + crypt_nents;
+	}
+
+	if (assoclen % AES_BLOCK_SIZE)
+		src_nents++;
+	if (cryptlen % AES_BLOCK_SIZE)
+		src_nents++;
+
+	src = kmalloc_array(src_nents, sizeof(struct scatterlist), GFP_KERNEL);
+	if (!src) {
+		err = -ENOMEM;
+		goto dthe_aead_prep_src_mem_err;
+	}
+
+	sg_init_table(src, src_nents);
+	to_sg = src;
+
+	to_sg = dthe_copy_sg(to_sg, in_sg[0], assoclen);
+	if (assoclen % AES_BLOCK_SIZE) {
+		unsigned int pad_len = AES_BLOCK_SIZE - (assoclen % AES_BLOCK_SIZE);
+
+		sg_set_buf(to_sg, assoc_pad_buf, pad_len);
+		to_sg = sg_next(to_sg);
+	}
+
+	to_sg = dthe_copy_sg(to_sg, in_sg[1], cryptlen);
+	if (cryptlen % AES_BLOCK_SIZE) {
+		unsigned int pad_len = AES_BLOCK_SIZE - (cryptlen % AES_BLOCK_SIZE);
+
+		sg_set_buf(to_sg, crypt_pad_buf, pad_len);
+		to_sg = sg_next(to_sg);
+	}
+
+dthe_aead_prep_src_mem_err:
+	if (cryptlen != 0 && assoclen != 0) {
+		kfree(in_sg[0]);
+		kfree(in_sg[1]);
+	}
+
+dthe_aead_prep_src_split_err:
+	if (err)
+		return ERR_PTR(err);
+	return src;
+}
+
+/**
+ * dthe_aead_prep_dst - Prepare destination scatterlist for AEAD from input req->dst
+ * @sg: Input req->dst scatterlist
+ * @assoclen: Input req->assoclen
+ * @cryptlen: Input req->cryptlen (minus the size of TAG in decryption)
+ * @pad_buf: Buffer to hold ciphertext/plaintext padding if needed
+ *
+ * Description:
+ *   For modes with authentication, DTHEv2 hardware returns encrypted ciphertext/decrypted
+ *   plaintext through DMA and TAG through MMRs. However, the dst scatterlist in linux
+ *   crypto's aead_request is allocated same as input req->src scatterlist. That is, it
+ *   contains space for AAD in the beginning and ciphertext/plaintext at the end, with no
+ *   alignment padding. This causes issues with DMA engine and DTHEv2 hardware.
+ *
+ *   This helper function takes the output scatterlist and maps the part of the buffer
+ *   which holds only the ciphertext/plaintext to a new scatterlist. It also adds a padding
+ *   to align it with AES_BLOCK_SIZE.
+ *
+ * Return:
+ *   Pointer to the trimmed scatterlist, or ERR_PTR(error) on failure.
+ *   The calling function needs to free the returned scatterlist when done.
+ **/
+static struct scatterlist *dthe_aead_prep_dst(struct scatterlist *sg,
+					      unsigned int assoclen,
+					      unsigned int cryptlen,
+					      u8 *pad_buf)
+{
+	struct scatterlist *out_sg[1];
+	struct scatterlist *dst;
+	struct scatterlist *to_sg;
+	size_t split_sizes[1] = {cryptlen};
+	int out_mapped_nents[1];
+	int dst_nents = 0;
+	int err = 0;
+
+	err = sg_split(sg, 0, assoclen, 1, split_sizes, out_sg, out_mapped_nents, GFP_KERNEL);
+	if (err)
+		goto dthe_aead_prep_dst_split_err;
+
+	dst_nents = sg_nents_for_len(out_sg[0], cryptlen);
+	if (cryptlen % AES_BLOCK_SIZE)
+		dst_nents++;
+
+	dst = kmalloc_array(dst_nents, sizeof(struct scatterlist), GFP_KERNEL);
+	if (!dst) {
+		err = -ENOMEM;
+		goto dthe_aead_prep_dst_mem_err;
+	}
+	sg_init_table(dst, dst_nents);
+
+	to_sg = dthe_copy_sg(dst, out_sg[0], cryptlen);
+	if (cryptlen % AES_BLOCK_SIZE) {
+		unsigned int pad_len = AES_BLOCK_SIZE - (cryptlen % AES_BLOCK_SIZE);
+
+		sg_set_buf(to_sg, pad_buf, pad_len);
+		to_sg = sg_next(to_sg);
+	}
+
+dthe_aead_prep_dst_mem_err:
+	kfree(out_sg[0]);
+
+dthe_aead_prep_dst_split_err:
+	if (err)
+		return ERR_PTR(err);
+	return dst;
+}
+
+static int dthe_aead_read_tag(struct dthe_tfm_ctx *ctx, u32 *tag)
+{
+	struct dthe_data *dev_data = dthe_get_dev(ctx);
+	void __iomem *aes_base_reg = dev_data->regs + DTHE_P_AES_BASE;
+	u32 val;
+	int ret;
+
+	ret = readl_relaxed_poll_timeout(aes_base_reg + DTHE_P_AES_CTRL, val,
+					 (val & DTHE_AES_CTRL_SAVED_CTX_READY),
+					 0, POLL_TIMEOUT_INTERVAL);
+	if (ret)
+		return ret;
+
+	for (int i = 0; i < AES_BLOCK_WORDS; ++i)
+		tag[i] = readl_relaxed(aes_base_reg +
+				       DTHE_P_AES_TAG_OUT +
+				       DTHE_REG_SIZE * i);
+	return 0;
+}
+
+static int dthe_aead_enc_get_tag(struct aead_request *req)
+{
+	struct dthe_tfm_ctx *ctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
+	u32 tag[AES_BLOCK_WORDS];
+	int nents;
+	int ret;
+
+	ret = dthe_aead_read_tag(ctx, tag);
+	if (ret)
+		return ret;
+
+	nents = sg_nents_for_len(req->dst, req->cryptlen + req->assoclen + ctx->authsize);
+
+	sg_pcopy_from_buffer(req->dst, nents, tag, ctx->authsize,
+			     req->assoclen + req->cryptlen);
+
+	return 0;
+}
+
+static int dthe_aead_dec_verify_tag(struct aead_request *req)
+{
+	struct dthe_tfm_ctx *ctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
+	u32 tag_out[AES_BLOCK_WORDS];
+	u32 tag_in[AES_BLOCK_WORDS];
+	int nents;
+	int ret;
+
+	ret = dthe_aead_read_tag(ctx, tag_out);
+	if (ret)
+		return ret;
+
+	nents = sg_nents_for_len(req->src, req->assoclen + req->cryptlen);
+
+	sg_pcopy_to_buffer(req->src, nents, tag_in, ctx->authsize,
+			   req->assoclen + req->cryptlen - ctx->authsize);
+
+	if (memcmp(tag_in, tag_out, ctx->authsize))
+		return -EBADMSG;
+	else
+		return 0;
+}
+
+static int dthe_aead_setkey(struct crypto_aead *tfm, const u8 *key, unsigned int keylen)
+{
+	struct dthe_tfm_ctx *ctx = crypto_aead_ctx(tfm);
+
+	if (keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_192 && keylen != AES_KEYSIZE_256)
+		return -EINVAL;
+
+	ctx->aes_mode = DTHE_AES_GCM;
+	ctx->keylen = keylen;
+	memcpy(ctx->key, key, keylen);
+
+	crypto_aead_clear_flags(ctx->aead_fb, CRYPTO_TFM_REQ_MASK);
+	crypto_aead_set_flags(ctx->aead_fb,
+			      crypto_aead_get_flags(tfm) &
+			      CRYPTO_TFM_REQ_MASK);
+
+	return crypto_aead_setkey(ctx->aead_fb, key, keylen);
+}
+
+static int dthe_aead_setauthsize(struct crypto_aead *tfm, unsigned int authsize)
+{
+	struct dthe_tfm_ctx *ctx = crypto_aead_ctx(tfm);
+
+	/* Invalid auth size will be handled by crypto_aead_setauthsize() */
+	ctx->authsize = authsize;
+
+	return crypto_aead_setauthsize(ctx->aead_fb, authsize);
+}
+
+static void dthe_aead_dma_in_callback(void *data)
+{
+	struct aead_request *req = (struct aead_request *)data;
+	struct dthe_aes_req_ctx *rctx = aead_request_ctx(req);
+
+	complete(&rctx->aes_compl);
+}
+
+static int dthe_aead_run(struct crypto_engine *engine, void *areq)
+{
+	struct aead_request *req = container_of(areq, struct aead_request, base);
+	struct dthe_tfm_ctx *ctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
+	struct dthe_aes_req_ctx *rctx = aead_request_ctx(req);
+	struct dthe_data *dev_data = dthe_get_dev(ctx);
+
+	unsigned int cryptlen = req->cryptlen;
+	unsigned int assoclen = req->assoclen;
+	unsigned int authsize = ctx->authsize;
+	unsigned int unpadded_cryptlen;
+	struct scatterlist *src = req->src;
+	struct scatterlist *dst = req->dst;
+	u32 iv_in[AES_IV_WORDS];
+
+	int src_nents;
+	int dst_nents;
+	int src_mapped_nents, dst_mapped_nents;
+
+	u8 src_assoc_padbuf[AES_BLOCK_SIZE] = {0};
+	u8 src_crypt_padbuf[AES_BLOCK_SIZE] = {0};
+	u8 dst_crypt_padbuf[AES_BLOCK_SIZE] = {0};
+
+	enum dma_data_direction src_dir, dst_dir;
+
+	struct device *tx_dev, *rx_dev;
+	struct dma_async_tx_descriptor *desc_in, *desc_out;
+
+	int ret;
+
+	void __iomem *aes_base_reg = dev_data->regs + DTHE_P_AES_BASE;
+
+	u32 aes_irqenable_val = readl_relaxed(aes_base_reg + DTHE_P_AES_IRQENABLE);
+	u32 aes_sysconfig_val = readl_relaxed(aes_base_reg + DTHE_P_AES_SYSCONFIG);
+
+	aes_sysconfig_val |= DTHE_AES_SYSCONFIG_DMA_DATA_IN_OUT_EN;
+	writel_relaxed(aes_sysconfig_val, aes_base_reg + DTHE_P_AES_SYSCONFIG);
+
+	aes_irqenable_val |= DTHE_AES_IRQENABLE_EN_ALL;
+	writel_relaxed(aes_irqenable_val, aes_base_reg + DTHE_P_AES_IRQENABLE);
+
+	/* In decryption, the last authsize bytes are the TAG */
+	if (!rctx->enc)
+		cryptlen -= authsize;
+	unpadded_cryptlen = cryptlen;
+
+	/* Prep src and dst scatterlists */
+	src = dthe_aead_prep_src(req->src, req->assoclen, cryptlen,
+				 src_assoc_padbuf, src_crypt_padbuf);
+	if (IS_ERR(src)) {
+		ret = PTR_ERR(src);
+		goto aead_prep_src_err;
+	}
+
+	if (req->assoclen % AES_BLOCK_SIZE)
+		assoclen += AES_BLOCK_SIZE - (req->assoclen % AES_BLOCK_SIZE);
+	if (cryptlen % AES_BLOCK_SIZE)
+		cryptlen += AES_BLOCK_SIZE - (cryptlen % AES_BLOCK_SIZE);
+
+	src_nents = sg_nents_for_len(src, assoclen + cryptlen);
+
+	if (cryptlen != 0) {
+		dst = dthe_aead_prep_dst(req->dst, req->assoclen, unpadded_cryptlen,
+					 dst_crypt_padbuf);
+		if (IS_ERR(dst)) {
+			ret = PTR_ERR(dst);
+			goto aead_prep_dst_err;
+		}
+
+		dst_nents = sg_nents_for_len(dst, cryptlen);
+	}
+	/* Prep finished */
+
+	src_dir = DMA_TO_DEVICE;
+	dst_dir = DMA_FROM_DEVICE;
+
+	tx_dev = dmaengine_get_dma_device(dev_data->dma_aes_tx);
+	rx_dev = dmaengine_get_dma_device(dev_data->dma_aes_rx);
+
+	src_mapped_nents = dma_map_sg(tx_dev, src, src_nents, src_dir);
+	if (src_mapped_nents == 0) {
+		ret = -EINVAL;
+		goto aead_dma_map_src_err;
+	}
+
+	desc_out = dmaengine_prep_slave_sg(dev_data->dma_aes_tx, src, src_mapped_nents,
+					   DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc_out) {
+		ret = -EINVAL;
+		goto aead_dma_prep_src_err;
+	}
+
+	desc_out->callback = dthe_aead_dma_in_callback;
+	desc_out->callback_param = req;
+
+	if (cryptlen != 0) {
+		dst_mapped_nents = dma_map_sg(rx_dev, dst, dst_nents, dst_dir);
+		if (dst_mapped_nents == 0) {
+			ret = -EINVAL;
+			goto aead_dma_prep_src_err;
+		}
+
+		desc_in = dmaengine_prep_slave_sg(dev_data->dma_aes_rx, dst,
+						  dst_mapped_nents, DMA_DEV_TO_MEM,
+						  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (!desc_in) {
+			ret = -EINVAL;
+			goto aead_dma_prep_dst_err;
+		}
+	}
+
+	init_completion(&rctx->aes_compl);
+
+	/*
+	 * HACK: There is an unknown hw issue where if the previous operation had alen = 0 and
+	 * plen != 0, the current operation's tag calculation is incorrect in the case where
+	 * plen = 0 and alen != 0 currently. This is a workaround for now which somehow works;
+	 * by resetting the context by writing a 1 to the C_LENGTH_0 and AUTH_LENGTH registers.
+	 */
+	if (cryptlen == 0) {
+		writel_relaxed(1, aes_base_reg + DTHE_P_AES_C_LENGTH_0);
+		writel_relaxed(1, aes_base_reg + DTHE_P_AES_AUTH_LENGTH);
+	}
+
+	if (req->iv) {
+		memcpy(iv_in, req->iv, GCM_AES_IV_SIZE);
+	} else {
+		iv_in[0] = 0;
+		iv_in[1] = 0;
+		iv_in[2] = 0;
+	}
+	iv_in[3] = 0x01000000;
+
+	/* Clear key2 to reset previous GHASH intermediate data */
+	for (int i = 0; i < AES_KEYSIZE_256 / sizeof(u32); ++i)
+		writel_relaxed(0, aes_base_reg + DTHE_P_AES_KEY2_6 + DTHE_REG_SIZE * i);
+
+	dthe_aes_set_ctrl_key(ctx, rctx, iv_in);
+
+	writel_relaxed(lower_32_bits(unpadded_cryptlen), aes_base_reg + DTHE_P_AES_C_LENGTH_0);
+	writel_relaxed(upper_32_bits(unpadded_cryptlen), aes_base_reg + DTHE_P_AES_C_LENGTH_1);
+	writel_relaxed(req->assoclen, aes_base_reg + DTHE_P_AES_AUTH_LENGTH);
+
+	if (cryptlen != 0)
+		dmaengine_submit(desc_in);
+	dmaengine_submit(desc_out);
+
+	if (cryptlen != 0)
+		dma_async_issue_pending(dev_data->dma_aes_rx);
+	dma_async_issue_pending(dev_data->dma_aes_tx);
+
+	/* Need to do timeout to ensure finalise gets called if DMA callback fails for any reason */
+	ret = wait_for_completion_timeout(&rctx->aes_compl, msecs_to_jiffies(DTHE_DMA_TIMEOUT_MS));
+	if (!ret) {
+		ret = -ETIMEDOUT;
+		if (cryptlen != 0)
+			dmaengine_terminate_sync(dev_data->dma_aes_rx);
+		dmaengine_terminate_sync(dev_data->dma_aes_tx);
+
+		for (int i = 0; i < AES_BLOCK_WORDS; ++i)
+			readl_relaxed(aes_base_reg + DTHE_P_AES_DATA_IN_OUT + DTHE_REG_SIZE * i);
+	} else {
+		ret = 0;
+	}
+
+	if (cryptlen != 0)
+		dma_sync_sg_for_cpu(rx_dev, dst, dst_nents, dst_dir);
+	if (rctx->enc)
+		ret = dthe_aead_enc_get_tag(req);
+	else
+		ret = dthe_aead_dec_verify_tag(req);
+
+aead_dma_prep_dst_err:
+	if (cryptlen != 0)
+		dma_unmap_sg(rx_dev, dst, dst_nents, dst_dir);
+aead_dma_prep_src_err:
+	dma_unmap_sg(tx_dev, src, src_nents, src_dir);
+
+aead_dma_map_src_err:
+	if (cryptlen != 0)
+		kfree(dst);
+
+aead_prep_dst_err:
+	kfree(src);
+
+aead_prep_src_err:
+	local_bh_disable();
+	crypto_finalize_aead_request(engine, req, ret);
+	local_bh_enable();
+	return 0;
+}
+
+static int dthe_aead_crypt(struct aead_request *req)
+{
+	struct dthe_tfm_ctx *ctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
+	struct dthe_aes_req_ctx *rctx = aead_request_ctx(req);
+	struct dthe_data *dev_data = dthe_get_dev(ctx);
+	struct crypto_engine *engine;
+	unsigned int cryptlen = req->cryptlen;
+
+	/* In decryption, last authsize bytes are the TAG */
+	if (!rctx->enc)
+		cryptlen -= ctx->authsize;
+
+	/*
+	 * Need to fallback to software in the following cases due to HW restrictions:
+	 * - Both AAD and plaintext/ciphertext are zero length
+	 * - AAD length is more than 2^32 - 1 bytes
+	 * PS: req->cryptlen is currently unsigned int type, which causes the above condition
+	 * tautologically false. If req->cryptlen were to be changed to a 64-bit type,
+	 * the check for this would need to be added below.
+	 */
+	if (req->assoclen == 0 && cryptlen == 0) {
+		struct aead_request *subreq = &rctx->aead_fb_req;
+		int ret;
+
+		aead_request_set_tfm(subreq, ctx->aead_fb);
+		aead_request_set_callback(subreq, aead_request_flags(req),
+					  req->base.complete, req->base.data);
+		aead_request_set_crypt(subreq, req->src, req->dst,
+				       req->cryptlen, req->iv);
+		aead_request_set_ad(subreq, req->assoclen);
+
+		ret = rctx->enc ? crypto_aead_encrypt(subreq) :
+			crypto_aead_decrypt(subreq);
+
+		return ret;
+	}
+
+	engine = dev_data->engine;
+	return crypto_transfer_aead_request_to_engine(engine, req);
+}
+
+static int dthe_aead_encrypt(struct aead_request *req)
+{
+	struct dthe_aes_req_ctx *rctx = aead_request_ctx(req);
+
+	rctx->enc = 1;
+	return dthe_aead_crypt(req);
+}
+
+static int dthe_aead_decrypt(struct aead_request *req)
+{
+	struct dthe_aes_req_ctx *rctx = aead_request_ctx(req);
+
+	rctx->enc = 0;
+	return dthe_aead_crypt(req);
+}
+
 static struct skcipher_engine_alg cipher_algs[] = {
 	{
 		.base.init			= dthe_cipher_init_tfm,
@@ -617,12 +1168,46 @@ static struct skcipher_engine_alg cipher_algs[] = {
 	}, /* XTS AES */
 };
 
+static struct aead_engine_alg aead_algs[] = {
+	{
+		.base.init			= dthe_aead_init_tfm,
+		.base.exit			= dthe_aead_exit_tfm,
+		.base.setkey			= dthe_aead_setkey,
+		.base.setauthsize		= dthe_aead_setauthsize,
+		.base.maxauthsize		= AES_BLOCK_SIZE,
+		.base.encrypt			= dthe_aead_encrypt,
+		.base.decrypt			= dthe_aead_decrypt,
+		.base.chunksize			= AES_BLOCK_SIZE,
+		.base.ivsize			= GCM_AES_IV_SIZE,
+		.base.base = {
+			.cra_name		= "gcm(aes)",
+			.cra_driver_name	= "gcm-aes-dthev2",
+			.cra_priority		= 299,
+			.cra_flags		= CRYPTO_ALG_TYPE_AEAD |
+						  CRYPTO_ALG_KERN_DRIVER_ONLY |
+						  CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= 1,
+			.cra_ctxsize		= sizeof(struct dthe_tfm_ctx),
+			.cra_reqsize		= sizeof(struct dthe_aes_req_ctx),
+			.cra_module		= THIS_MODULE,
+		},
+		.op.do_one_request = dthe_aead_run,
+	}, /* GCM AES */
+};
+
 int dthe_register_aes_algs(void)
 {
-	return crypto_engine_register_skciphers(cipher_algs, ARRAY_SIZE(cipher_algs));
+	int ret = 0;
+
+	ret |= crypto_engine_register_skciphers(cipher_algs, ARRAY_SIZE(cipher_algs));
+	ret |= crypto_engine_register_aeads(aead_algs, ARRAY_SIZE(aead_algs));
+
+	return ret;
 }
 
 void dthe_unregister_aes_algs(void)
 {
 	crypto_engine_unregister_skciphers(cipher_algs, ARRAY_SIZE(cipher_algs));
+	crypto_engine_unregister_aeads(aead_algs, ARRAY_SIZE(aead_algs));
 }
diff --git a/drivers/crypto/ti/dthev2-common.h b/drivers/crypto/ti/dthev2-common.h
index 5c2fc1fb4793f..00197121f26d2 100644
--- a/drivers/crypto/ti/dthev2-common.h
+++ b/drivers/crypto/ti/dthev2-common.h
@@ -38,6 +38,7 @@ enum dthe_aes_mode {
 	DTHE_AES_CBC,
 	DTHE_AES_CTR,
 	DTHE_AES_XTS,
+	DTHE_AES_GCM,
 };
 
 /* Driver specific struct definitions */
@@ -78,28 +79,38 @@ struct dthe_list {
  * struct dthe_tfm_ctx - Transform ctx struct containing ctx for all sub-components of DTHE V2
  * @dev_data: Device data struct pointer
  * @keylen: AES key length
+ * @authsize: Authentication size for modes with authentication
  * @key: AES key
  * @aes_mode: AES mode
+ * @aead_fb: Fallback crypto aead handle
  * @skcipher_fb: Fallback crypto skcipher handle for AES-XTS mode
  */
 struct dthe_tfm_ctx {
 	struct dthe_data *dev_data;
 	unsigned int keylen;
+	unsigned int authsize;
 	u32 key[DTHE_MAX_KEYSIZE / sizeof(u32)];
 	enum dthe_aes_mode aes_mode;
-	struct crypto_skcipher *skcipher_fb;
+	union {
+		struct crypto_aead *aead_fb;
+		struct crypto_skcipher *skcipher_fb;
+	};
 };
 
 /**
  * struct dthe_aes_req_ctx - AES engine req ctx struct
  * @enc: flag indicating encryption or decryption operation
  * @aes_compl: Completion variable for use in manual completion in case of DMA callback failure
+ * @aead_fb_req: aead request for fallback operation
  * @skcipher_fb_req: skcipher request for fallback operation in case of AES-XTS mode
  */
 struct dthe_aes_req_ctx {
 	int enc;
 	struct completion aes_compl;
-	struct skcipher_request skcipher_fb_req;
+	union {
+		struct aead_request aead_fb_req;
+		struct skcipher_request skcipher_fb_req;
+	};
 };
 
 /* Struct definitions end */
-- 
2.43.0


