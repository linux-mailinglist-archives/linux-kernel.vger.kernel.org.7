Return-Path: <linux-kernel+bounces-837044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68282BAB276
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41237A2E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9646D2309AA;
	Tue, 30 Sep 2025 03:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXfpVh85"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0AD13777E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759202940; cv=none; b=YW7KtwSt1XNaKdGN9k5WjwKQLpp4ZcI7xr1anb/MOcjD/BqjMnrnzzzD/KEa7FqpyLfr74ARC4zzAeXAlxif33hxnT2184yPYM428/FZUFevxlTEwhfKYL6nmBdlojtzLzy+a6i2v6+9Ba1AoowEZxCmWh+ZIY84ITZoEe1pXoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759202940; c=relaxed/simple;
	bh=7zYrZGktQSibeqiljwRaN88A5/xgn9ZA5DIxmLh9vBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tn7Gdh3OSXj+vuzE7bNq7WxK1tuI5d/E4Osvn2G9EpFmQW+zEpTeiMaQ0IltJtTxlxvwVMQDvuz1nRbz19rfKLguFv0KTv+Ez5z1DDFUh1PkOXJeWoF+Cf3Z7C8uK+SGVeLslmEnrUkLUwt3OgMWc18+biwaOJvCzn+LYBboiUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXfpVh85; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32ebcef552eso918396a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759202938; x=1759807738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TRFovpZkQdHmlzVVmXKLh8sBZCVYZYGw/tVsJurBJ/8=;
        b=WXfpVh85S78Mf3SvRJfiibAXDZaiEp8CFwwq0qxcU5kHe72GrH/uQZv2BO3ZtSbV9a
         WXZmyTSquC3AO7s/uQzDeDvPsCxCRHFHYZpROEGbX6e0KE6zwQsbYXSVezcNacC8Trh/
         /6ODd05DIoPtkgqEp0SC0qv3qnw0IHZApZQ6/odxl38hY4aURIjEuAtdGhWF/6d9lGuM
         d01vHssWZ6uYDBO6YZpdU0bePkHq+ExoVwbemBGKOkHNak5NLp7PFavgkK7X8r0Ppwr8
         SZeCvuoO7PqIMiHgY/1MWafZbd9z0VFaofgNHNBpId2kbG2HMuDET3F6einVLN0LVmjS
         Vwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759202938; x=1759807738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRFovpZkQdHmlzVVmXKLh8sBZCVYZYGw/tVsJurBJ/8=;
        b=IzGjZ+5NAq2giY4S3dgekLX7C9SM/EwYDef4TNtkCcjlYngy23X+5t3ypTRyvCKwJf
         eDBE8ReymdFAmkUmdmjXVAoEpTouVyBVo7IjTMW5UA/cwHFEogfcCueXKYXfaexJyJUM
         lenK5jRoaGiMLx8UQLeMXvQfoCn0CjRQcLSZxmOaJrUdz//+2wgsNRxbyxnSW40rCa/2
         ux/mo+2Et5PAUU8aGevJydF/D8JtPsnDEt7PEYVza9VF3EAF4MXY3+y9XKOH8yualvYC
         EICK0Wlw+pyZ5iU54Zx5Mnc+ehPoh4ONnUM77Y4zLdwBFZBaeScjFqQawnE/YCA0HFIl
         isQA==
X-Forwarded-Encrypted: i=1; AJvYcCVjFKZOUvuuNDx06Y7wJuk5f9i3WBfhvwzLiuDJUA/FVbA6g9T3Uudjn/AwlfCmuBqrEwUz/OIlIB9HQbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6jYh0jpz14tFlCdPontPHc3l2pEsK60MeG4i2u6ow+KTp75de
	mtdzjKBuCWmgl5vgrc6LbkC30ogsqGfgAS8H8efUVzRhVi8dNSeyP6I2
X-Gm-Gg: ASbGncvuZKt5iEOic4XtEZ4x4m9GEs8drfPBcIxlYVfwLztGbQ7AWWgHBO7jzO0LoMz
	rafI/520Ckx8PvkvCr0OJWSXhxMWkRVmsdeNQ4i6luh0BBhjdgSc97nDpWPl7P0997o3ydG2NY/
	EBdDptrU43S4U0RYbGxYABQ72qAjMRqTL7e0mchoM12/iyiRJS8QGgECR/XpxR8wklM0p/HWc9X
	SQjX8PJxJSk8meKfwsiP5C4FJGC/5/NGwCJOxjT+Ndv72E5XwRrLpUkqY5gPPUC56I6w2MmIFjO
	uICN0foDgLmgcZhtQD+zCOdm6YGwIcbj6XXJEfD2/tqrzS6xpG3i1fhtGr5DnFdxqsgB0gm+yqA
	oAp2T+6vPhe6rVWAXS+00DcB+vg27Hfnvx8NLW2F1FLToAUopfhZRs+dF
X-Google-Smtp-Source: AGHT+IHa/N2ohw99+ghxhjMZEHetlp4jEaJChxesBc5HG2FsPQSuQIS2elCMYeP0rJiGyOgxEHFHNg==
X-Received: by 2002:a17:90b:38c7:b0:32e:e18a:368d with SMTP id 98e67ed59e1d1-3342a332253mr11227633a91.8.1759202937489;
        Mon, 29 Sep 2025 20:28:57 -0700 (PDT)
Received: from localhost.localdomain ([101.44.65.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-338387351ccsm2841318a91.23.2025.09.29.20.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 20:28:57 -0700 (PDT)
From: Dave Sun <sunyiqixm@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Sun <sunyiqixm@gmail.com>
Subject: [PATCH] crypto: fix null-ptr-dereference in rng_setentropy
Date: Tue, 30 Sep 2025 11:28:24 +0800
Message-Id: <20250930032824.690214-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_CRYPTO_USER_API_RNG_CAVP is enable,
algif_type_rng->setentropy = rng_setentropy.
If we setsockopt on a af_alg socket binding a rng
algorithm with ALG_SET_DRBG_ENTROPY opt, kernel will
run to ->set_ent in rng_setentropy.

Since struct rng_alg like jent_alg dose not set set_ent
which default value is 0, null-ptr-dereference will happen.

Check ->set_ent before call it.

Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
---
 crypto/algif_rng.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/crypto/algif_rng.c b/crypto/algif_rng.c
index 10c41adac3b1..26a75c54192b 100644
--- a/crypto/algif_rng.c
+++ b/crypto/algif_rng.c
@@ -303,6 +303,9 @@ static int __maybe_unused rng_setentropy(void *private, sockptr_t entropy,
 			return PTR_ERR(kentropy);
 	}
 
+	if (!crypto_rng_alg(pctx->drng)->set_ent)
+		return -EOPNOTSUPP;
+
 	crypto_rng_alg(pctx->drng)->set_ent(pctx->drng, kentropy, len);
 	/*
 	 * Since rng doesn't perform any memory management for the entropy
-- 
2.34.1


