Return-Path: <linux-kernel+bounces-833955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDC3BA368F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E383B0B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B8F2F4A19;
	Fri, 26 Sep 2025 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W55qngWd"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5512F39B4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758884116; cv=none; b=oyt7mapwp6uReYBlmJI92AR6wbnFLa95Hz78o9BWlwAOcLvu1OtE5p5nVwiEqiMY/6Uq/n4gKvwOT/ZRmqUPLvNjC6MC/XyyEooZm75tsSQGfSxy3BA6sMrysabSSR+I9zbeg3979/1zvNdzwQkvdcSNnKtDfDcQOb4e8oRnhW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758884116; c=relaxed/simple;
	bh=ng/p5D85fQbLWgCo/VzPcztWqRtbLIIRQ31vWWSLO5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E4Q3+j+tCaczkKCx0zTFAgs57Vjrn68h38L2+Smr3OtCnN+Ri3fJb8YiS6DewxIA56amc/gNPS1Z4S6TRuCk+3JcqxaU+dD3HCD8ecZD4huFYlrO5RzFaK4hlJ6wLVw5Tir/yGfzJzcS1Kk7yv6kysSFJpci2D1g8XI9Mru9H5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W55qngWd; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781206cce18so77412b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758884114; x=1759488914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fG/8r6Zh74ocis4PYV5dxG4SwOJqWmE0/JuYdwpI5Bw=;
        b=W55qngWdLbZIGUo1BfSCuEUP8JgC1Uo0o14aSuvK0yhQYlLyd8e6GhHfmnX0cchNh9
         OSI7a7nKMYjFEmDwyrBEBtjkiDxh7VfyLR0E7iq9HIOJ9tb55z3gYC2t+W8f0Ji6pBb4
         WNmquWo7INTn0cqctNtVOR7ZfVxiSTHCEixhy8cF7nNPa8pwtB+pbvruGGlCf4jR9Adk
         Y7rhOe3Rco9KJ4/2KGRrr/bPntNKyWRyvkQa4xDE2j1Xa/QGbNEpUyYp1GOY31360R1e
         G0El5ExidQh4ZcpfC7PKqr03B3KqzeN2Vc/c9ROiGdrb82A3hpd7TsPXRbs5+czaAWoi
         A7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758884114; x=1759488914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fG/8r6Zh74ocis4PYV5dxG4SwOJqWmE0/JuYdwpI5Bw=;
        b=vCX0KHNifAy1TvOc594v42d2DW7ohhGf3VqzPt81NswdBSML6MNQYIxJar/a798Sxm
         JdCdLjlhiwiytt7FaobHbAn2eWoJo5xnfiOsPHINZpBkurDgyAPskXPFmoUqb9RhL35g
         nU9w4o9Y9Z+Fv5lbEMiSx2uuTdItBHpJ4GzBEI+ypm5EYL4kGXGbit0AO9EpDug6zu0K
         78vJCK8tsbsurmQym9OMLXQZyVw7bBCcGIqnjjKlAUR+je0TyxJ6L0dsh7ac164qfoNw
         +bICkV48zz7xgAEYOm95eH90VSLDD2o4nlffP/hEdNjyZPNjjE6Z2ycezZZQmgeiLGjX
         drHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYGw6RcVjo/z0lvhgkCoPknqEZT+vF2opulx/S5FaRDZaZxgwm3wKHXPL6+RHawzgohH0mFBBZcqKohL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa6EbcpKfy2L5xxK2UJ1Shx9X2Eb1uQccR24MscHLkqXtc3for
	eeOwDMCvtHF4cSN7XofxfMKA7Z0B/cZleVQcuXjCHx996YMoqFTRAfGuEcFf
X-Gm-Gg: ASbGncsZ4LKXQUXf/lnayyq6ZVKJK2kt+33mTdum5UK6Pfgfj+xTJuo27BN1idQ/hwh
	olLJ7lvJgvo1RWI0UikVU3eJ4RQiJvw9OMem33ywy8YyEs+IlBKTjYCini51UTwjNVPqWriHLHq
	acZa2vaTEEfQ1YiaXkznf5/E61T45W+kZb1r0i59YehXly7yqg0Wofv0ilQQt+AxZIo3m1W6WJ3
	0B9jGeI5gG8Ci3FsEIEIrVRFaSlH6HVvHBbo7vqikLiwfWmLBlm2PpdLa86skx8eNTszj+hJGCT
	+9uxEtgcQ8DwM7lowKqDdfd4Suz10I3wzPUqUZaz1ERHeBk9gMmLTRoWJlNPn4bO7ieO+c2B9pf
	waT/1kQNxXwwi0oaei5N/mECV48ok/1CgcJUpRVzTk5WOHwCGSoSJyCUiPl8Vgux97oPeEhDh1w
	==
X-Google-Smtp-Source: AGHT+IHoR6X2imZeXiOqh27AKoNYEtTfZrOufz/4X8jbeOqzZcdMNwoD0bok6WOIEC6F/UDhsBRR6g==
X-Received: by 2002:a05:6a00:8d0:b0:776:19f6:5d2f with SMTP id d2e1a72fcca58-78100fd3661mr6495280b3a.11.1758884113839;
        Fri, 26 Sep 2025 03:55:13 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([122.167.144.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c06b0dsm4062536b3a.82.2025.09.26.03.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 03:55:13 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: atharvatiwarilinuxdev@gmail.com,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Lee Jones <lee@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mfd/macsmc: make SMC write buffers const
Date: Fri, 26 Sep 2025 16:24:59 +0530
Message-ID: <20250926105505.33499-1-atharvatiwarilinuxdev@gmail.com>
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


