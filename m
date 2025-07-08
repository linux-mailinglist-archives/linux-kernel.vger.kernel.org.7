Return-Path: <linux-kernel+bounces-722170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C946AFD63B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1AB1C25E40
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A862E7179;
	Tue,  8 Jul 2025 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAVGlusK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFBA2E11A9;
	Tue,  8 Jul 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998451; cv=none; b=BC/IL+a9XkchIteXUW+UQ5BCnpcqkXbY0qelVsu5yxXrBaaQ5+I7J9Zs4XyK/Y9srICd5eHriM3D4e4pckWNJGA6Q4yco9eEPPV87S55CpOsDYw/W/CHAzWgU6eJP083nF9YCyDzWPxt28UzFwdQ8bm9/chtmn3ySYgAtTl+S3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998451; c=relaxed/simple;
	bh=jwvCr39ei9e4T62AdmL6k/AJgFVg8w32kPVPIHnkACA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/7IgfhsF9lOxBVJhBcs77K16SHXGLmHHzVf9aTcULSvGD1+pjxKDHuhARnSujs+KXlBEFi7itqku8qdP+PVXf5k2Z66NcKVO9Uw2qAAy5zWZO7fCNjZHrXxwvGgf6W/cAgK+VSVoKzkAaHWmeFYThVHqR0I993SPoJHj+va/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAVGlusK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7D6C4CEF6;
	Tue,  8 Jul 2025 18:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751998450;
	bh=jwvCr39ei9e4T62AdmL6k/AJgFVg8w32kPVPIHnkACA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tAVGlusKeRerzgt3ofwTe+AGkg7iV00jmGwMV4lG4iRAEM91OtTwFnzPwjlBAsZ0O
	 C/IVZ/SofYDTzDYGtSnFJgTT4jEXU4m5toq4Dc1CbIbeZoMaJPWI2pN5FBrMVPAq8H
	 BsWt+5Pw3nJufwyX3jzTfdlOjnfjJGWAGdu5LnKo6c48g0dyMt78udu4HfZEhmSzI9
	 lQiNtlwyXx3il8HdNfOJOxuUWrkqdGG70yUU6wL+6IiNB4uQ2osyBuUCKhThsbxqpe
	 h8l7IeJFSfC32yuI9jstWJg3Fdl/hClPQfGY50pvfgtJqzsYOkMkm6XOBPN8+gDym6
	 CZwe04KFno9hA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Cc: Yuwen Chen <ywen.chen@foxmail.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 1/3] fscrypt: Don't use asynchronous CryptoAPI algorithms
Date: Tue,  8 Jul 2025 11:13:11 -0700
Message-ID: <20250708181313.66961-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708181313.66961-1-ebiggers@kernel.org>
References: <20250708181313.66961-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that fscrypt has disabled support for non-inline crypto engines, and
none of the CPU-based algorithms have the CRYPTO_ALG_ASYNC flag set
anymore, there is no need to "support" asynchronous algorithms.
Therefore, remove the code that handled asynchronous returns, and
allocate only algorithms without CRYPTO_ALG_ASYNC set.

This commit should *not* be backported to kernels that lack commit
0ba6ec5b2972 ("crypto: x86/aes - stop using the SIMD helper"), as then
it would disable the use of the optimized AES code on x86.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/crypto/crypto.c          |  7 +++----
 fs/crypto/fname.c           | 18 ++++++++----------
 fs/crypto/fscrypt_private.h |  5 +++--
 fs/crypto/keysetup_v1.c     |  9 ++++-----
 4 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index ddf6991d46da2..43d1658e07cec 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -113,11 +113,10 @@ int fscrypt_crypt_data_unit(const struct fscrypt_inode_info *ci,
 			    unsigned int len, unsigned int offs,
 			    gfp_t gfp_flags)
 {
 	union fscrypt_iv iv;
 	struct skcipher_request *req = NULL;
-	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist dst, src;
 	struct crypto_skcipher *tfm = ci->ci_enc_key.tfm;
 	int res = 0;
 
 	if (WARN_ON_ONCE(len <= 0))
@@ -131,21 +130,21 @@ int fscrypt_crypt_data_unit(const struct fscrypt_inode_info *ci,
 	if (!req)
 		return -ENOMEM;
 
 	skcipher_request_set_callback(
 		req, CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
-		crypto_req_done, &wait);
+		NULL, NULL);
 
 	sg_init_table(&dst, 1);
 	sg_set_page(&dst, dest_page, len, offs);
 	sg_init_table(&src, 1);
 	sg_set_page(&src, src_page, len, offs);
 	skcipher_request_set_crypt(req, &src, &dst, len, &iv);
 	if (rw == FS_DECRYPT)
-		res = crypto_wait_req(crypto_skcipher_decrypt(req), &wait);
+		res = crypto_skcipher_decrypt(req);
 	else
-		res = crypto_wait_req(crypto_skcipher_encrypt(req), &wait);
+		res = crypto_skcipher_encrypt(req);
 	skcipher_request_free(req);
 	if (res) {
 		fscrypt_err(ci->ci_inode,
 			    "%scryption failed for data unit %llu: %d",
 			    (rw == FS_DECRYPT ? "De" : "En"), index, res);
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index fb01dde0f2e55..17edc24ccd42f 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -93,11 +93,10 @@ static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
  */
 int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
 			  u8 *out, unsigned int olen)
 {
 	struct skcipher_request *req = NULL;
-	DECLARE_CRYPTO_WAIT(wait);
 	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
 	struct crypto_skcipher *tfm = ci->ci_enc_key.tfm;
 	union fscrypt_iv iv;
 	struct scatterlist sg;
 	int res;
@@ -116,18 +115,18 @@ int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
 
 	/* Set up the encryption request */
 	req = skcipher_request_alloc(tfm, GFP_NOFS);
 	if (!req)
 		return -ENOMEM;
-	skcipher_request_set_callback(req,
-			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
-			crypto_req_done, &wait);
+	skcipher_request_set_callback(
+		req, CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
+		NULL, NULL);
 	sg_init_one(&sg, out, olen);
 	skcipher_request_set_crypt(req, &sg, &sg, olen, &iv);
 
 	/* Do the encryption */
-	res = crypto_wait_req(crypto_skcipher_encrypt(req), &wait);
+	res = crypto_skcipher_encrypt(req);
 	skcipher_request_free(req);
 	if (res < 0) {
 		fscrypt_err(inode, "Filename encryption failed: %d", res);
 		return res;
 	}
@@ -149,33 +148,32 @@ EXPORT_SYMBOL_GPL(fscrypt_fname_encrypt);
 static int fname_decrypt(const struct inode *inode,
 			 const struct fscrypt_str *iname,
 			 struct fscrypt_str *oname)
 {
 	struct skcipher_request *req = NULL;
-	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist src_sg, dst_sg;
 	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
 	struct crypto_skcipher *tfm = ci->ci_enc_key.tfm;
 	union fscrypt_iv iv;
 	int res;
 
 	/* Allocate request */
 	req = skcipher_request_alloc(tfm, GFP_NOFS);
 	if (!req)
 		return -ENOMEM;
-	skcipher_request_set_callback(req,
-		CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
-		crypto_req_done, &wait);
+	skcipher_request_set_callback(
+		req, CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
+		NULL, NULL);
 
 	/* Initialize IV */
 	fscrypt_generate_iv(&iv, 0, ci);
 
 	/* Create decryption request */
 	sg_init_one(&src_sg, iname->name, iname->len);
 	sg_init_one(&dst_sg, oname->name, oname->len);
 	skcipher_request_set_crypt(req, &src_sg, &dst_sg, iname->len, &iv);
-	res = crypto_wait_req(crypto_skcipher_decrypt(req), &wait);
+	res = crypto_skcipher_decrypt(req);
 	skcipher_request_free(req);
 	if (res < 0) {
 		fscrypt_err(inode, "Filename decryption failed: %d", res);
 		return res;
 	}
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 6e7164530a1e2..06fa8f2b2d081 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -57,12 +57,13 @@
  * Adiantum is faster still, and is the recommended option on such platforms...)
  *
  * Note that fscrypt also supports inline crypto engines.  Those don't use the
  * Crypto API and work much better than the old-style (non-inline) engines.
  */
-#define FSCRYPT_CRYPTOAPI_MASK \
-	(CRYPTO_ALG_ALLOCATES_MEMORY | CRYPTO_ALG_KERN_DRIVER_ONLY)
+#define FSCRYPT_CRYPTOAPI_MASK                            \
+	(CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY | \
+	 CRYPTO_ALG_KERN_DRIVER_ONLY)
 
 #define FSCRYPT_CONTEXT_V1	1
 #define FSCRYPT_CONTEXT_V2	2
 
 /* Keep this in sync with include/uapi/linux/fscrypt.h */
diff --git a/fs/crypto/keysetup_v1.c b/fs/crypto/keysetup_v1.c
index 158ceae8a5bce..3fdf174384f3d 100644
--- a/fs/crypto/keysetup_v1.c
+++ b/fs/crypto/keysetup_v1.c
@@ -48,11 +48,10 @@ static int derive_key_aes(const u8 *master_key,
 			  const u8 nonce[FSCRYPT_FILE_NONCE_SIZE],
 			  u8 *derived_key, unsigned int derived_keysize)
 {
 	int res = 0;
 	struct skcipher_request *req = NULL;
-	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist src_sg, dst_sg;
 	struct crypto_skcipher *tfm =
 		crypto_alloc_skcipher("ecb(aes)", 0, FSCRYPT_CRYPTOAPI_MASK);
 
 	if (IS_ERR(tfm)) {
@@ -64,22 +63,22 @@ static int derive_key_aes(const u8 *master_key,
 	req = skcipher_request_alloc(tfm, GFP_KERNEL);
 	if (!req) {
 		res = -ENOMEM;
 		goto out;
 	}
-	skcipher_request_set_callback(req,
-			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
-			crypto_req_done, &wait);
+	skcipher_request_set_callback(
+		req, CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
+		NULL, NULL);
 	res = crypto_skcipher_setkey(tfm, nonce, FSCRYPT_FILE_NONCE_SIZE);
 	if (res < 0)
 		goto out;
 
 	sg_init_one(&src_sg, master_key, derived_keysize);
 	sg_init_one(&dst_sg, derived_key, derived_keysize);
 	skcipher_request_set_crypt(req, &src_sg, &dst_sg, derived_keysize,
 				   NULL);
-	res = crypto_wait_req(crypto_skcipher_encrypt(req), &wait);
+	res = crypto_skcipher_encrypt(req);
 out:
 	skcipher_request_free(req);
 	crypto_free_skcipher(tfm);
 	return res;
 }
-- 
2.50.0


