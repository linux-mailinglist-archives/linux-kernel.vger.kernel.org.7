Return-Path: <linux-kernel+bounces-829983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 436FAB985EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCA53AB24A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23297188715;
	Wed, 24 Sep 2025 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PkYXkjMN"
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BCF1F9F73
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758694655; cv=none; b=fj+/kOUzAnAO2Jp4RVHkYIEBhovyANZz4rcNx6AH8ai5GlRJ71qk07rVWX1ljIM902fUz0hTU+/b0QTvDrwP6O1H95ThJ65YayKSC5gvclzCYx7VdOcdhn749uuR01oKQgKmCkz9VNXXYM96zvTIDY5xkfXf1mm2VWAwMquGwiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758694655; c=relaxed/simple;
	bh=PckVkjVIHmHqtDvxZzcDiEQw5wOKZpgKyeDyTLIwb9o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p+Uct2DYlNMt05VYLuHtdaY47er1rGThlcwYV6sWi7OVbotKygxMoxUOaOIE+3GPIi6RKW9RPOgk72vsqfvn01/XU0HiW6+0hydqny1BsAe5pF9SHdSfq1NxZW4HFr+9TmiGEVVDA/bHOPvN3yso03RqqmNZGYwfGH2kkenoszw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PkYXkjMN; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-b55115148b4so4226598a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 23:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758694653; x=1759299453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymWB1hrEQwy+qhGGeeTAshnrOMJoU7hn+WhGD+V50Sw=;
        b=iyfttd/D38yrnNEMtZ5FKz8oTFKPgbi5K3v9IaXGMzOJ1B91YQcicScXUYApKQRvFQ
         Db7Nvq/KFOIR6yJkTxi3Wf6aC8e/HjBscIfVqr5NKJ9T+8aZqAzGIg3crb6I9krHCqXE
         p9dwypleTxkXPfCUg6J4pdqyA2MDdO3WE87u49U/2C2Z91ODIsj6XcudqAPEI4319Qit
         GB1LmqUI3JyPARqy4aBelWPoeyK4je1mlSJgGUDzmDBcMjn6GyAHTnhdpw6RGBRtC0Q+
         7lMU3MMTTTau11fjcuHSuAcgnN86DEfR5M5gUVaQAYy+V5Pm5uwQWSEKBAuuITpvkDDp
         LxXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZbbSb+ohIJBZvpYMeTg/fXTO/9/A66So/JkNSnoHVaIXHrwbUhZ2qqpN6i13N9EPgFp3WAGvHz7DU9lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycKHuIOyCuQQagkRFsjLVL8d6gOLkChDiI04L8hYtCcX6n9TAa
	Qfng1LD8VjdYwRf27ZEcFgwQUWf6cPDnUbBWkldIk8D282na9BI7KjAkkA6ahWMkWAoGyealuAw
	N17Z9pNAyKKflEpOosdXOB3VV2V6Ml87hQ7d1TSKI5zr5bA5OEyF6DkU//oJ/oRswitfSKG7Ngr
	vU7Vks+/hbu0Qs2BceT94EJyLjJ7f8Zm9NWldTrnof9ztTA9f6wf5K1e4uJlAFw1hgBnXBLkjeu
	N9B+3fN7KrQZpJi7gMWxFaOjQ==
X-Gm-Gg: ASbGncvcAYdCnOewicXuJ9Ko4C0Kf7CPQs0gs5oWGumornSdYEmKUehWsa2pPXS2/EJ
	Iylf5/94gQ6vVnzu8QpgR6I3LwXbX+KgvBQdnk2dRFngXd3Oqvocj5N820MA1EX+H5bKGlbvtI2
	UV7izQ2ln/hS/8GySKXAOzcC3DJVWr2lOyfmxF8Bd6U6g5FD8c8iz9AS4oU3yICz1hsFcvY0PPU
	5hN/8eEsgaj1Eq7eYFsYeQRnPU85vB/pa+xSqdAy178TCHCraT0C9K1fqQNIa52CwlwIUy8Gxkw
	6imlCqm57igjTsu3qshXDVW3cdVCH17+AN///wMaqcLu3YndK73SYFPKBhEsnTO6WTi9+NgE64b
	w4+a2tVLJwUt84fwgbzfOuoEZr7J7d3SHBBLs6/MNU5uLKZZB9N1YbJ6hY8O5YA6Xvc1mdblcXY
	GTJ0a77Q==
X-Google-Smtp-Source: AGHT+IGCBcEG3aARG70B6/KK65ADrFBycRkGd5ra4EUcFONCpNZsHzdJz/epYzlsJ8VLKZZg+KpgMhBfvGwe
X-Received: by 2002:a17:902:e891:b0:250:643e:c947 with SMTP id d9443c01a7336-27cc5bf289amr60892605ad.28.1758694652972;
        Tue, 23 Sep 2025 23:17:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-26980276bb8sm11736445ad.34.2025.09.23.23.17.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Sep 2025 23:17:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32edda89a37so6221603a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 23:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758694651; x=1759299451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ymWB1hrEQwy+qhGGeeTAshnrOMJoU7hn+WhGD+V50Sw=;
        b=PkYXkjMNesfU/mxfWVIa/hbHW4oLg7kyyYzpmI0J9nfPQykIxCj/lZYBpugmTGy+f/
         UYgIMKZin9obQnHTGQHtNUAIPz6JATT4qKt2ID0b5c8Vq3Tp8q8FpCUCnBFWLqcJ/E7r
         ZqxTz98W7aBMVibvTMNZGjglH/4/UDwNz1SAQ=
X-Forwarded-Encrypted: i=1; AJvYcCVHkJ8p+qrHonavcNupohVrwvxsyP3wOQfDKtJ/wnwf82hzXpzGiBE/q5eu72dI6DncnZ3STrC5x6zT0CM=@vger.kernel.org
X-Received: by 2002:a17:90a:d2cf:b0:32b:d8bf:c785 with SMTP id 98e67ed59e1d1-332a95bc6eemr6454709a91.20.1758694651125;
        Tue, 23 Sep 2025 23:17:31 -0700 (PDT)
X-Received: by 2002:a17:90a:d2cf:b0:32b:d8bf:c785 with SMTP id 98e67ed59e1d1-332a95bc6eemr6454689a91.20.1758694650630;
        Tue, 23 Sep 2025 23:17:30 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5576e90efesm1180580a12.3.2025.09.23.23.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 23:17:29 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	smueller@chronox.de,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	srinidhi.rao@broadcom.com,
	Shivani Agarwal <shivani.agarwal@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] crypto: zero initialize memory allocated via sock_kmalloc
Date: Tue, 23 Sep 2025 23:01:48 -0700
Message-Id: <20250924060148.299749-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Several crypto user API contexts and requests allocated with
sock_kmalloc() were left uninitialized, relying on callers to
set fields explicitly. This resulted in the use of uninitialized
data in certain error paths or when new fields are added in the
future.

The ACVP patches also contain two user-space interface files:
algif_kpp.c and algif_akcipher.c. These too rely on proper
initialization of their context structures.

A particular issue has been observed with the newly added
'inflight' variable introduced in af_alg_ctx by commit:

  67b164a871af ("crypto: af_alg - Disallow multiple in-flight AIO requests")

Because the context is not memset to zero after allocation,
the inflight variable has contained garbage values. As a result,
af_alg_alloc_areq() has incorrectly returned -EBUSY randomly when
the garbage value was interpreted as true:

  https://github.com/gregkh/linux/blame/master/crypto/af_alg.c#L1209

The check directly tests ctx->inflight without explicitly
comparing against true/false. Since inflight is only ever set to
true or false later, an uninitialized value has triggered
-EBUSY failures. Zero-initializing memory allocated with
sock_kmalloc() ensures inflight and other fields start in a known
state, removing random issues caused by uninitialized data.

Fixes: fe869cdb89c9 ("crypto: algif_hash - User-space interface for hash operations")
Fixes: 5afdfd22e6ba ("crypto: algif_rng - add random number generator support")
Fixes: 2d97591ef43d ("crypto: af_alg - consolidation of duplicate code")
Fixes: 67b164a871af ("crypto: af_alg - Disallow multiple in-flight AIO requests")
Cc: stable@vger.kernel.org
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
Changes in v2:
- Dropped algif_skcipher_export changes, The ctx->state will immediately
be overwritten by crypto_skcipher_export.
- No other changes.
---
 crypto/af_alg.c     | 5 ++---
 crypto/algif_hash.c | 3 +--
 crypto/algif_rng.c  | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index ca6fdcc6c54a..6c271e55f44d 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1212,15 +1212,14 @@ struct af_alg_async_req *af_alg_alloc_areq(struct sock *sk,
 	if (unlikely(!areq))
 		return ERR_PTR(-ENOMEM);
 
+	memset(areq, 0, areqlen);
+
 	ctx->inflight = true;
 
 	areq->areqlen = areqlen;
 	areq->sk = sk;
 	areq->first_rsgl.sgl.sgt.sgl = areq->first_rsgl.sgl.sgl;
-	areq->last_rsgl = NULL;
 	INIT_LIST_HEAD(&areq->rsgl_list);
-	areq->tsgl = NULL;
-	areq->tsgl_entries = 0;
 
 	return areq;
 }
diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index e3f1a4852737..4d3dfc60a16a 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -416,9 +416,8 @@ static int hash_accept_parent_nokey(void *private, struct sock *sk)
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->result = NULL;
+	memset(ctx, 0, len);
 	ctx->len = len;
-	ctx->more = false;
 	crypto_init_wait(&ctx->wait);
 
 	ask->private = ctx;
diff --git a/crypto/algif_rng.c b/crypto/algif_rng.c
index 10c41adac3b1..1a86e40c8372 100644
--- a/crypto/algif_rng.c
+++ b/crypto/algif_rng.c
@@ -248,9 +248,8 @@ static int rng_accept_parent(void *private, struct sock *sk)
 	if (!ctx)
 		return -ENOMEM;
 
+	memset(ctx, 0, len);
 	ctx->len = len;
-	ctx->addtl = NULL;
-	ctx->addtl_len = 0;
 
 	/*
 	 * No seeding done at that point -- if multiple accepts are
-- 
2.40.4


