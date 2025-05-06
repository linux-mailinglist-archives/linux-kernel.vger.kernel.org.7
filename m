Return-Path: <linux-kernel+bounces-633829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB62BAAAA2E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 03:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750A6188DC96
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 01:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6889376448;
	Mon,  5 May 2025 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVInQ4E1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9739376455;
	Mon,  5 May 2025 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485334; cv=none; b=eKDQaS0xO8xQT1O5AgRIkyTK0Z+MlNcbniIR0To7THVn7FS62qPrvaBP3vKR7VvUuHtv7j3s6NwHqb0TvZ6w2ViAru4tvG6wrEXnnsTrGrduLZLnA9psZpbQhKNhQMqxIxf9iuKkjB5TsVMsBl/r9mYUsK/Io1Eu6f7Nc8Uv7VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485334; c=relaxed/simple;
	bh=Cj9pz82UZuBAlcuouMBtIXCTLWVIoxB9T79RQmp21IU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MK6uxk3zzp+mmKaqf8F6LS4Lja5S1U+LPJkC2p7YA8dcGNfxVla486WHl9w2xpcDG3J1tuXjw5ynX3nRt9PWprFgprT5d/xDnuRBX1ijuYgBt8Y28wU80tuv5BH9i09cV9cZe6nHyISiPFshEfrP57ZFeRWhZEj8zvMqgNJ5SAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVInQ4E1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0250C4CEEE;
	Mon,  5 May 2025 22:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485333;
	bh=Cj9pz82UZuBAlcuouMBtIXCTLWVIoxB9T79RQmp21IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YVInQ4E1jUjIjDkbNLQaKB79+JBXnKapoGDrQntK7DQMjb/gklCb7DezrqW7X/aL0
	 akzwEztXgCSW++JLzamG1AqoPCYSCoeNHzB+2dqwA+Jw5jgZtIqrHWTccGGjb+kqhy
	 a0WlW3ILG5Zm2njrBQ4+f6j1jjFZL065+AF20TM0HE8Ky6ifb8JmbUS6+aLcvF0De7
	 iPfcrRdd/ROkj452mK7ZbylyqSRvnvt3CnwvVdKtp4ALzA9MJ3/wYNzNxxc9eyyF0g
	 D37CkhsVEeqZltFERXrujYNSEwqG7s7sFOjfZTCVXM92J4Or8ngCe1F8mJPXAsewg4
	 huwS0T5eSyb+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 272/486] crypto: ahash - Set default reqsize from ahash_alg
Date: Mon,  5 May 2025 18:35:48 -0400
Message-Id: <20250505223922.2682012-272-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 9e01aaa1033d6e40f8d7cf4f20931a61ce9e3f04 ]

Add a reqsize field to struct ahash_alg and use it to set the
default reqsize so that algorithms with a static reqsize are
not forced to create an init_tfm function.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/ahash.c        | 4 ++++
 include/crypto/hash.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/crypto/ahash.c b/crypto/ahash.c
index bcd9de009a91b..fe19bf7f15eb9 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -473,6 +473,7 @@ static int crypto_ahash_init_tfm(struct crypto_tfm *tfm)
 	struct ahash_alg *alg = crypto_ahash_alg(hash);
 
 	crypto_ahash_set_statesize(hash, alg->halg.statesize);
+	crypto_ahash_set_reqsize(hash, alg->reqsize);
 
 	if (tfm->__crt_alg->cra_type == &crypto_shash_type)
 		return crypto_init_ahash_using_shash(tfm);
@@ -638,6 +639,9 @@ static int ahash_prepare_alg(struct ahash_alg *alg)
 	if (alg->halg.statesize == 0)
 		return -EINVAL;
 
+	if (alg->reqsize && alg->reqsize < alg->halg.statesize)
+		return -EINVAL;
+
 	err = hash_prepare_alg(&alg->halg);
 	if (err)
 		return err;
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 2d5ea9f9ff43e..6692253f0b5be 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -132,6 +132,7 @@ struct ahash_request {
  *	      This is a counterpart to @init_tfm, used to remove
  *	      various changes set in @init_tfm.
  * @clone_tfm: Copy transform into new object, may allocate memory.
+ * @reqsize: Size of the request context.
  * @halg: see struct hash_alg_common
  */
 struct ahash_alg {
@@ -148,6 +149,8 @@ struct ahash_alg {
 	void (*exit_tfm)(struct crypto_ahash *tfm);
 	int (*clone_tfm)(struct crypto_ahash *dst, struct crypto_ahash *src);
 
+	unsigned int reqsize;
+
 	struct hash_alg_common halg;
 };
 
-- 
2.39.5


