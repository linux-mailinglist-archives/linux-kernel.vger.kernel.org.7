Return-Path: <linux-kernel+bounces-844301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 857AABC17DC
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDAC3C67FB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DA22E0B58;
	Tue,  7 Oct 2025 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2FdpkMK"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16634242D9F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843509; cv=none; b=RvezvrrcbPjWWENhR+EPrs1QcL4mOlVg8C5C6bTxyO6WuzqJmxgFwAqGRou+JAMy5BR9GwdFLJwVArmGb8gAWEuIkBAvUTgOKJda71i9IAS7/9EgeDAYoz5uxx1PB1dNID2/vYRStRwoPToRFDecUVOnR9UeRyUAJSUZbInQQDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843509; c=relaxed/simple;
	bh=ng/p5D85fQbLWgCo/VzPcztWqRtbLIIRQ31vWWSLO5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oHyb66Ryxm5yNTfHLvG0qt6ANHiXD+qmDjjwEeLIx2C7xOYveihEEFQGt8if1fSwVZUCSdT0KWm89BJJf2vdGuG3D+YVTSISOnBHeXH5f+iKlcguhG6BgfGxgcsEB7rJAtY3SZPrlV8uqf3mR8yx9Xhmj84zC7ziKMHSEFzJpTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2FdpkMK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-267facf9b58so39288865ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759843507; x=1760448307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fG/8r6Zh74ocis4PYV5dxG4SwOJqWmE0/JuYdwpI5Bw=;
        b=b2FdpkMKNaBEhLP4xowUQOkKoIzfkYfbUH6PnaVpJ6lcOEfafByaHdHnN4YtL1PICM
         LdHq2LlnCegWiAJRZvwA4vdUXfn2RwpPaXUbnkmQs13haZUlMMgcyYVZLycdoV5O7PoA
         SJK9g0Taf8GFdNX9H5k9bBpMm8X7zEXeCWU9TxO8BJVq70Pj/D8QrRybfdQeNoyTus5Y
         GhaKx+imVhyu9UZ2HjhHmSXqeCxNm39eh6x0cLWevzM3TzHbh10ve7zd/sgZNPrIAsxG
         2AefDGlU96pBQMbCAJatc//hoXMMBWBbmfvaFAGRINRP8E2pzqFKJzYEh207SzEHBoVa
         c7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759843507; x=1760448307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fG/8r6Zh74ocis4PYV5dxG4SwOJqWmE0/JuYdwpI5Bw=;
        b=m+s0cAJarp+UCatbsxnwdovsU4MUdKs+vS+B69LBnqygvtmLkHujYamCVqlrjzXsSz
         Z7DLsio+j0JS/z84hcytsrfu1ARWKOapv63PgfYyQvUPaa5AEMc2M+09iqCWOAEBTSta
         TW/MKDNRKWMwpI1JgK+GxQORYY0yCkXuDjQBisl0o/w8PHvSxpWzABHk56Z8kjtPwKsi
         ASxzayOntbcGn+jtlyj+Qi0OwJ7VkfDs8U0RhE6u6F8VmwU9CEIwUHFOAZlQ13JuGnni
         rObqyxpGCHCvIcsLJc0lfAS8D/3gN/LH/Ihhb1si7HdhPYvOxqiS3mYVe/5vjwWWfQ4s
         qEQw==
X-Forwarded-Encrypted: i=1; AJvYcCXhxj80E9Hob4JlRJ7RoKcEFKOVuIDN1apa7UUH4ytdvLTJCh2kQmBTOOFD6L/ZVEMaNhE0EFxG2Bw33QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxomWkXDW/cF5ODB20AjcV5S7SHWYWMeI1GpML+psD8dZZYwP9h
	8aUrUFbSU7ErbASH4fgeIQTHgSF1WeLuXQt9j4RKqKJM+m1iqQDtx7Y=
X-Gm-Gg: ASbGncsYSy1xgZ5uFV0++vEK01tfWQXthDc+hiwXHEeg1tnMBXHRUMOa+Q1GWwfex0L
	2Ot+m0mSc/TBVa9FzAeCFZpBRZvmncSr6Mmvn41AfxZQlmxT7oe+mJPx7/KKl9yIdmuq7xtuU4V
	NDFEy4gm0h5icKLJwwiVaCjSO1pK7tGLw4rTtgIhZRMlONfi+kBYDdphl9tnp2+lgFQlSt2fUNb
	ubN6/x7dNptQo0z9U5uExcCCD4TiiiJwq4oCKbLvCbbvTT7PxK6nXaQvlQXI/WzfZWIUCcJDII3
	r56H/dqpqrHq6NE6rN2NTxv4nbCu0QbTSOzd3ARli4M9hNdKI+lHFTdQUwNtePidBLqzcJ+GjHV
	kaV8ZVqoG4aFlstHwGxrTO8aG3YevL/679yzRwCVG2Yhq25oqKcAuuKAr0jk9aJdAdkz3THMKc7
	8z4EK71HigFWoFkguPaAg=
X-Google-Smtp-Source: AGHT+IEzTWHDadnlhRp/S58ULeXoWMCkCiR+8Dg1mH5fcmjnNA/DLN1UQw7CdyUCQ1szY5TdffBgmg==
X-Received: by 2002:a17:903:f8b:b0:26b:5346:5857 with SMTP id d9443c01a7336-28e9a5a8788mr206165375ad.24.1759843507414;
        Tue, 07 Oct 2025 06:25:07 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([182.65.86.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d31bdsm166409045ad.94.2025.10.07.06.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:25:07 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Lee Jones <lee@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] mfd/macsmc: make SMC write buffers const
Date: Tue,  7 Oct 2025 18:35:10 +0530
Message-ID: <20251007130510.1653-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark the write buffer arguments in apple_smc_write(), apple_smc_rw(),
and apple_smc_write_atomic() as const. These functions do not modify
the data provided by the caller, so the parameters should be const
qualified.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/mfd/macsmc.c       | 6 +++---
 include/linux/mfd/macsmc.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/macsmc.c b/drivers/mfd/macsmc.c
index 870c8b2028a8..0f8ed400b986 100644
--- a/drivers/mfd/macsmc.c
+++ b/drivers/mfd/macsmc.c
@@ -173,7 +173,7 @@ int apple_smc_read(struct apple_smc *smc, smc_key key, void *buf, size_t size)
 }
 EXPORT_SYMBOL(apple_smc_read);
 
-int apple_smc_write(struct apple_smc *smc, smc_key key, void *buf, size_t size)
+int apple_smc_write(struct apple_smc *smc, smc_key key, const void *buf, size_t size)
 {
 	guard(mutex)(&smc->mutex);
 
@@ -181,7 +181,7 @@ int apple_smc_write(struct apple_smc *smc, smc_key key, void *buf, size_t size)
 }
 EXPORT_SYMBOL(apple_smc_write);
 
-int apple_smc_rw(struct apple_smc *smc, smc_key key, void *wbuf, size_t wsize,
+int apple_smc_rw(struct apple_smc *smc, smc_key key, const void *wbuf, size_t wsize,
 		 void *rbuf, size_t rsize)
 {
 	guard(mutex)(&smc->mutex);
@@ -239,7 +239,7 @@ int apple_smc_enter_atomic(struct apple_smc *smc)
 }
 EXPORT_SYMBOL(apple_smc_enter_atomic);
 
-int apple_smc_write_atomic(struct apple_smc *smc, smc_key key, void *buf, size_t size)
+int apple_smc_write_atomic(struct apple_smc *smc, smc_key key, const void *buf, size_t size)
 {
 	guard(spinlock_irqsave)(&smc->lock);
 	u8 result;
diff --git a/include/linux/mfd/macsmc.h b/include/linux/mfd/macsmc.h
index 6b13f01a8592..3c5467854e28 100644
--- a/include/linux/mfd/macsmc.h
+++ b/include/linux/mfd/macsmc.h
@@ -149,7 +149,7 @@ int apple_smc_read(struct apple_smc *smc, smc_key key, void *buf, size_t size);
  *
  * Return: Zero on success, negative errno on error
  */
-int apple_smc_write(struct apple_smc *smc, smc_key key, void *buf, size_t size);
+int apple_smc_write(struct apple_smc *smc, smc_key key, const void *buf, size_t size);
 
 /**
  * apple_smc_enter_atomic - Enter atomic mode to be able to use apple_smc_write_atomic
@@ -176,7 +176,7 @@ int apple_smc_enter_atomic(struct apple_smc *smc);
  *
  * Return: Zero on success, negative errno on error
  */
-int apple_smc_write_atomic(struct apple_smc *smc, smc_key key, void *buf, size_t size);
+int apple_smc_write_atomic(struct apple_smc *smc, smc_key key, const void *buf, size_t size);
 
 /**
  * apple_smc_rw - Write and then read using the given SMC key
@@ -189,7 +189,7 @@ int apple_smc_write_atomic(struct apple_smc *smc, smc_key key, void *buf, size_t
  *
  * Return: Zero on success, negative errno on error
  */
-int apple_smc_rw(struct apple_smc *smc, smc_key key, void *wbuf, size_t wsize,
+int apple_smc_rw(struct apple_smc *smc, smc_key key, const void *wbuf, size_t wsize,
 		 void *rbuf, size_t rsize);
 
 /**
-- 
2.43.0


