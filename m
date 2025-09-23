Return-Path: <linux-kernel+bounces-828563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BFDB94E55
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D56442B34
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B8F2F1FE3;
	Tue, 23 Sep 2025 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ReoZYFy2"
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE95E2F1FDD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614452; cv=none; b=MTi5ZY54Xiy2ETeo5SxeE/fWLqvUvuvT6J3+/U+lx5bkTVvBexTkN1ndUKv6sCQgRwzK9eNhLoNPyiaYt3vnqN/HeORWZ7cSyr56xfByByCZdXp8foIm6AzDGYwiQFIrGu/AmWWcr3RHg32ozQ1kRXdC0UoJXlYbct2r5UCakBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614452; c=relaxed/simple;
	bh=2Nmv4rZNUfTXcZw7YzLDJ5L6s3/QDtMNlHCYycuCRfM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DELnSDNosh/VquobZlPxUX5wCt8IwHTkx4YxvUwnwPiz+kuGEb/psCicY/4UKMiaYH8Q7RvaaoS17olbVKuZE/vfi/OkYqGrstqXswZMpE6ydJb7j0d13ohxYQXGjYmgtxmKhqlnlOHacEy02kC6JLB/WgA8/CMDxN9czgrCPn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ReoZYFy2; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-4b38d4de6d9so33207561cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758614450; x=1759219250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FeQF6j+JjXOV0QRTrdt9GGdX4jZQxW0sWiD25FD7sA=;
        b=L5UbLQ/WrVlGv+PH/9pHG3Vw7EXDTIy9Hlx1Sd7tgAU5aU2qyOfcwDyGX/GuMLrP19
         DwSmAK0Ew2FKF4Xe6cFP+ys42oQmIYJQMFUc1icKoUcmLUmUA8gifoYrInUwPdTjqKsP
         NDp65YTY6SUUVhgwfi18Gd364KbC1dGYob1YLwAkYl1tCTx7ewdD+5HsA5y/qenwmxRj
         AY9ytEjKcoO0AQuNlXT1+Ag6m0fO/V0al6pM4zloOwPZbpdvlMCRjuc5A+6jcWFfytD9
         qDRhO56wu61YSTh3CtXGnQ2woSjQqyp8/9ngwxvkrFDbTCJ7Vgha5eB9GPUch457OeG0
         2jUA==
X-Forwarded-Encrypted: i=1; AJvYcCXNB+FOGaGG1ACs0eeO4CH7WtyBuX4JE5HapQ3d+rhHFFxsNSmuqulA3MoMrOwrn1SN+/LjseZuNMb7oo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5F+qTD0PnZbzJOxAirtOfMvOEj8W6/6Cxu+sj0HwKlSp5T/pO
	XEtYNXt9dHyVrkuT4AaM49cxTp+EPkZK96M2+NJKU/7GFnku7k/l33ZvqJivn9OTo81EYAuvTo2
	vujOQf+cA1fZV+Oq0M5xbozPibCAUGpmjYCi4oZPebesTSN12CDw/lEmz5Ht+v99dwRsZlfJBHX
	/NlPxyPIv/920iJsW/VvxLQKwlxCclkHhGMHYOm4zDwjp4mET388+iZysxXDa6Eqgc+acyRDLDi
	QL4cGEos5v/jKTY0W6wIaNEnw==
X-Gm-Gg: ASbGncuNeCUgOT+UgDSj5v7Sq8gnY0rqD6w6dr7bpXnA3LSwkrGpJhhPxDlh14QP4j0
	Br3pwXnsUhjg3EqYAzopensCAZeL1T27tbHbkdN/l/iDS+5HYW83Gt2RVsej3+IIfIVzO/0BDm+
	08XST3IHz8+UqJB75SJQJP6xTk3CzC6eN53Tx9Fq4l1gtsSIrkfunKGVqPrFNHKht+O1gQ+IZXB
	WGXpkcZiSQKnmj6YLLQ8/urcK6O4knRsCsIXam5ue3gi+fnDaVCnF6kAsQBydtG5keo5BTLCT6X
	+MQ1iNFrwhlu+RB7ee0BiLQTWSWvObV+rCXrfW+IslmAHQyxNoyFaawhay97Kg5D2vBzL678vAA
	TSWpZaTYkoBpM4nOFgz8fugbRN1Y4g0/BM+l/GQM3yHkqqYF4mdK7gjMlw2dN3eIeQK5X9QOugV
	OS8Ez2/w==
X-Google-Smtp-Source: AGHT+IFr44PMKAOKj3z6ZLKKLV2t4R2LsTH2eRW8vuOUmtPnIXcoJlCjU36igFRTCcBl3D03tm2Wmo+KXpfX
X-Received: by 2002:a05:622a:1a97:b0:4b5:781c:8831 with SMTP id d75a77b69052e-4d3717f2a5dmr19334101cf.71.1758614449361;
        Tue, 23 Sep 2025 01:00:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4bda533b035sm3734911cf.10.2025.09.23.01.00.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Sep 2025 01:00:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2697410e7f9so99511775ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758614448; x=1759219248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6FeQF6j+JjXOV0QRTrdt9GGdX4jZQxW0sWiD25FD7sA=;
        b=ReoZYFy2ZLsMXQXwlcA4zdb0MJseA0BsoCWJBVAUcQ3fHZIwm2/J4Gpna3RbGJHcud
         PwmuCGoW6BGxauHCyUXAwz6lSLQO6uX4rVb4MPvcU+sJRLHCbnsPuhg7TbOHavKqcG0P
         FGtI6DDns/rCSUpO24la12nOBzEOPpmWTNa34=
X-Forwarded-Encrypted: i=1; AJvYcCWKS3XenIvTVhRsPfoLhxg3H566Nk7jkAt4CgvE0oGMV15s8SMPv0OwGUsmNtZ621RzgkqubbErP4AbT4A=@vger.kernel.org
X-Received: by 2002:a17:902:ce03:b0:278:9051:8e9c with SMTP id d9443c01a7336-27cc61b8c8dmr20437145ad.42.1758614448160;
        Tue, 23 Sep 2025 01:00:48 -0700 (PDT)
X-Received: by 2002:a17:902:ce03:b0:278:9051:8e9c with SMTP id d9443c01a7336-27cc61b8c8dmr20436885ad.42.1758614447798;
        Tue, 23 Sep 2025 01:00:47 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033d788sm154912015ad.127.2025.09.23.01.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:00:47 -0700 (PDT)
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
Subject: [PATCH] crypto: zero initialize memory allocated via sock_kmalloc
Date: Tue, 23 Sep 2025 00:45:15 -0700
Message-Id: <20250923074515.295899-1-shivani.agarwal@broadcom.com>
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
Fixes: 99bd99d3e3a7 ("crypto: algif_skcipher - Fix stream cipher chaining")
Fixes: 67b164a871af ("crypto: af_alg - Disallow multiple in-flight AIO requests")
Cc: stable@vger.kernel.org
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 crypto/af_alg.c         | 5 ++---
 crypto/algif_hash.c     | 3 +--
 crypto/algif_rng.c      | 3 +--
 crypto/algif_skcipher.c | 1 +
 4 files changed, 5 insertions(+), 7 deletions(-)

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
diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index 125d395c5e00..f4ce5473324f 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -70,6 +70,7 @@ static int algif_skcipher_export(struct sock *sk, struct skcipher_request *req)
 	if (!ctx->state)
 		return -ENOMEM;
 
+	memset(ctx->state, 0, statesize);
 	err = crypto_skcipher_export(req, ctx->state);
 	if (err) {
 		sock_kzfree_s(sk, ctx->state, statesize);
-- 
2.40.4


