Return-Path: <linux-kernel+bounces-828924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE29BB95DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57860486429
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A7027F011;
	Tue, 23 Sep 2025 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jruc0i+w"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60004323F57
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758631493; cv=none; b=ZoGI61urW85nw5echFSYrPZ9uv9G9mt/uHaTeuejTLUoPM+hJjFY1p/UMxA2lq3g6ArHCVXkbhzLMjW5P/4N6YcV2I42AHAKSGwIcD+zNzgmTimuAPGVHS6xRMfIFqjlZOpEAXxX6IVF3hB8fGth1VPWoAAjUwFIB9D8v9LY46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758631493; c=relaxed/simple;
	bh=X5SCAiSiPiJEcYEiOxRFI7I4FHTBz2CQgSgz4A8sfdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qsZNi1n79NSXmCFiShTncVum5ulYGJ+GHWz0Ri5zc5aK0QrK0zjB6UZ86UkmDW74eQfKyCwX15+Am7eLKV2qEbVKxrS3mxp1Dt/E/yQ/9ByyFqkBMLj14cem6ETe8f6vTnHFnoj3wDQp81yYfxDcbBozeEzCiJvmAL86AK0Y130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jruc0i+w; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77c1814ca1dso4237944b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758631491; x=1759236291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cgc0zGHjqKsb6Mzy0/R8YmRgjX+eUzNJLvWfwmfdlbw=;
        b=Jruc0i+wYSxjrQk6RIxskeS0j1RaZjlSXUnI5B9f7yoZ2k/KnOs2OGTIHy3Rht9kAt
         4g9he9H2+3sfbxI1yTldJgVU2a73bO/f0wUu1/NpxjCpXd6v8ujvRyEK0dFdCS5l77Q5
         cKUlBVoPEtUeo+8BHKKVsA8lBCjgcHs9IZPkHRWfX/4yEO37UyJjMD0bzljphwaVjJxb
         AijAVsv74PJgREEzt3LCdq+EmhXVnkb5OhQZ60i3MGzaiaj/VUUq3JXXI5KfvpCGZaSW
         x7VX5newM/msOWP67OX2rsB+nM1vAyT9EtlGUuos7Iu+a7B+B+yBNXI89C1kKdckUuQU
         eMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758631491; x=1759236291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgc0zGHjqKsb6Mzy0/R8YmRgjX+eUzNJLvWfwmfdlbw=;
        b=N3/PNgoSaIAM6MB9aCAC+yQn3tYqBmO+ijdn/BHph8/5KgB5/RI75yg4PkNzMER8ai
         6OigMO5P+/+/AGtd7RITLK8JJgFZY7rG5P6HhttLTfOrZrkuL4+kIRg0iwdyJs0Gwy2N
         GGSdpFC9snDo/ycrwK0313MyHUtnJPOFQ3RMxcdMy5CYXmNZoWn7aiP6cP/Z8vfeVvAl
         QHA8NgjHrwfBNUs3894QLYvIHa9/g6YaZRR9EsfqDjojsujEOcGP+F+NVJfTkM8ETJ/Q
         IK7dem9IJO3atgSZ99S1QMiU9Rw1BNqbz4UTnzyy8fxyXlMhoYup/9j0FH/UaiHaWAGo
         Z1QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxwTSKR5IYJEHrDR8umYmtHKBwB26o63zYc1PhCTC5YfnYKSZmc2XcOIv7mCLGRBcsr+Y9lWFVRut1Bms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXufkd2kBXF5F81lanxHSYEkiEiUZxE2wmQVe7uN45V0QvY8oQ
	r2fQRLDtH4kq7sCQDCfUiM7KL4ERmu4BtSArs0n6WjcRhkz0ERLfBX77
X-Gm-Gg: ASbGncsddc6cOpjGB87TyWxioPhVGnfNIRsYnrBo5UlYoh59+KIF+6FeDXv2RDKth5q
	au8UVFT0FV3/RDyBOIi244fKMOUCdcT8mknJlswFo/+mLW2wrQck7LtGMGI6yj6PucS9dPU2wA/
	HSVEUmFBby+yN70TXbLSDs3AeHEs9+kVGCrIkxWG18RFglT3jWsz7HTTDKSyiNzkCOKuKJgBdS2
	7AIxnKmRGuV9Eoov4PzOhUDVi1GxUuthRvQuztjDU/G6H9KWRwrDmszbvPq0Hh9Vkmky3RYWulA
	P/mXpgY8nFxgCx0blMmTQ5lnJ5ZBE1I2svd2Q295dCeP9L/uM1xOEBwlM3Ul+ww2UwD1NCVY5z5
	mtKGc+9pbYlWwZXRp9328T4A=
X-Google-Smtp-Source: AGHT+IF+Z+DXFn3bgpMwnAWPeSbLtcvFzn5fzKbQO8Hcx6cZEpx6vf9Jd5Y5Z7nnPoPYPWpaRcohgQ==
X-Received: by 2002:a05:6a21:3398:b0:24d:38c:26bd with SMTP id adf61e73a8af0-2cffb042180mr4007968637.43.1758631491539;
        Tue, 23 Sep 2025 05:44:51 -0700 (PDT)
Received: from lgs.. ([2408:8418:1100:9530:4f2e:20bc:b03d:e78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b553a0a8270sm8354998a12.17.2025.09.23.05.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 05:44:51 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	"Victoria Milhoan (b42089)" <vicki.milhoan@freescale.com>,
	Dan Douglass <dan.douglass@nxp.com>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] crypto: caam: Add check for kcalloc() in test_len()
Date: Tue, 23 Sep 2025 20:44:18 +0800
Message-ID: <20250923124418.1857922-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As kcalloc() may fail, check its return value to avoid a NULL pointer
dereference when passing the buffer to rng->read(). On allocation
failure, log the error and return since test_len() returns void.

Fixes: 2be0d806e25e ("crypto: caam - add a test for the RNG")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
changelog:
v3:
- Fix build error: test_len() returns void; return without a value.
- No functional changes beyond the allocation failure path.

v2:
- Return on allocation failure to avoid possible NULL dereference.
---
 drivers/crypto/caam/caamrng.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index b3d14a7f4dd1..0eb43c862516 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -181,7 +181,9 @@ static inline void test_len(struct hwrng *rng, size_t len, bool wait)
 	struct device *dev = ctx->ctrldev;
 
 	buf = kcalloc(CAAM_RNG_MAX_FIFO_STORE_SIZE, sizeof(u8), GFP_KERNEL);
-
+	if (!buf) {
+		return;
+	}
 	while (len > 0) {
 		read_len = rng->read(rng, buf, len, wait);
 
-- 
2.43.0


