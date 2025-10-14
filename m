Return-Path: <linux-kernel+bounces-853208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D8FBDAEBB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A2F4266AA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828382367CE;
	Tue, 14 Oct 2025 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHKw5lxB"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCC3213E9C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465889; cv=none; b=Cmv26MDvLsNx+VP+7ZynGN3zvfzk/V+dEKJJrVMa19TLQs/4qMSqSQJWB44kbldbKx11cng2lJlQGXCfXcrQnO6ZD9+/khc2pMk4xEVa4kimXxNj+nSc3h/dsn31Jme+8PvVew9w+Hrg6DX71HU8MWoZqhL93FvZT8fSyJIKjoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465889; c=relaxed/simple;
	bh=fl9dxu0ycvvXitt44bCuyJPyoAQrj/yoDZITVlKXsjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q9wywHUQNByz7+FE5Ouk6qYLrcGt/phLcCRPFfbzvydbb3j1QoMD9/pCIXjzgx9polaN7FF4vogqHi7YoDD5843n5gbriQCQZab/Vi0rixA0qkRoROHOfA7VrScQBSqfSQbR2jou94O/JsplR2n3a9cb76sufRnFyKR73mTb9rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHKw5lxB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7833765433cso7467645b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760465888; x=1761070688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FJYX0oFaOu5LIwnoU6nce/6u02Dn7Xqdn6lu9Olcq4Q=;
        b=HHKw5lxB0EG9CZZ+3/GRHCPV8DV2fGy7rrk8G0+Bngm/fPV7n1FjtlPare1Pgz5lht
         /nsvrDm65AEVy1qhHm5Tp7vFahN64INsDxzATW0Gn/bTVy11Agf9r4NK2h6RrezR6JFb
         1dqJk6QQZCc44IER2kryFXj1VEC9AfBwCMsVB4t9P60JLKXTU0oYR0rH0sVV1rckrVy1
         XfyUzTOUiq/3HkRQRVeYMHUTF3pioe5u7C53FJoLFRZHtQb61XJXcqKnLmX/ALNgbxob
         +Cer9LBWJiXeRMNHBd49lr3QacJH3drSPUrLyHBddVf6LkW5F2gI7NGWyemICp15Z9fT
         fuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760465888; x=1761070688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJYX0oFaOu5LIwnoU6nce/6u02Dn7Xqdn6lu9Olcq4Q=;
        b=A5H5mP5Mi3hXpXxnIrRIUksdOsywe24s41RqP3snJpyyVRVmkqF4YG6Vd7X60L5CQG
         7J+n3qQEqnFyRU+nDyPYMob1GK1rxITlpVS7/pUKj7pAYkvXJSVr4NLm9zODNIfSuMFv
         ZzPBrmZ6Q1p7K2vUPPpIpT2RkokssUDWxaYxQo1bscBCcK4E7PViUiKc7olCbOo3w/yw
         UCBXmHzC7d+w6sWEdyXi4pSoRZ0pvqu9EznCGTMBUpbxdDlcoFkI0Z1xF9l+LbQ++W7R
         DWAYkpXZCHPsiHSH5Z5uhsIWnuQo97cly3ZyVlnMJGdlvlif7MzJK0Z6aKQ5AnVGU7z5
         vWjA==
X-Forwarded-Encrypted: i=1; AJvYcCUP2zs5bWlXxBodfCQuBtMd4QS183Lg+Fp3ptCJaeNt594ElGFKutEhTk8ivCWxDthDh7iG6W3/SvO5/Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YywjAc0Q1b3Khs4xgt8y5OqYNvfxxTYqlKsPKxPx2V83kGB0tzB
	PgYSkX/eyWvutURj6HiPcWf/hXvcX7yTia5Lbuni6KKuy2zXHIJBRr7v
X-Gm-Gg: ASbGncs0RwKgkMxXZnchKH/5zjlcHtXcOKoXg4bJ/DheWexIPXvJR4kpEAks6p/8+lw
	ifH/6PY4zSpCEUtLEwm6yePYqDbyGz2Vj8j2LSZ9kSWvVZYKpL/kPYm3fZCd2CKvoXrlcBTKYH3
	7jxq2fmTtQRnEgSCECYlnaTpVc0kFRxe60qdWEq9lBqDOGJSiDB7up84cQdpbxN0lq1KjcsIYf1
	HNg0YAkWwqQAow57JTBEn1ntXlk56y1sEYm2a/9CquNNZ/CSCyZUIab2tq2EgFwUWo8jftT0Sbr
	hipSB2uzlwjBPSxmR2qmLEURkTfaHA0xMr9eBQBPjEF3ppIP1uq0QcN4AdwH35OtVOzq1/fQpHK
	Sg7tRE7RKzdy0BiXzw6aF0sAk1WT0bRUFC8UD+FDS1Fqk
X-Google-Smtp-Source: AGHT+IHpaIm1FVkV0NO5/LLLKAO5EveRWhKWjYPnl0QVM+/Ty5AmqP+fDzEXx8yVvAGcjrWDilVc2g==
X-Received: by 2002:a05:6a00:39aa:b0:793:11fc:783f with SMTP id d2e1a72fcca58-79387a21bd2mr33487063b3a.29.1760465887560;
        Tue, 14 Oct 2025 11:18:07 -0700 (PDT)
Received: from archlinux ([2a09:bac5:3e67:a82::10c:4a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060b66sm15991997b3a.8.2025.10.14.11.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 11:18:07 -0700 (PDT)
From: fokaz-c <fokazmchakma4427@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	fokaz-c <fokazmchakma4427@gmail.com>
Subject: [PATCH] staging: gpib: pc2: convert // comments to /* */ style
Date: Tue, 14 Oct 2025 23:47:45 +0530
Message-ID: <20251014181745.171714-1-fokazmchakma4427@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: fokaz-c <fokazmchakma4427@gmail.com>
---
 drivers/staging/gpib/pc2/pc2_gpib.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/gpib/pc2/pc2_gpib.c b/drivers/staging/gpib/pc2/pc2_gpib.c
index 9f3943d1d..a9715b3e3 100644
--- a/drivers/staging/gpib/pc2/pc2_gpib.c
+++ b/drivers/staging/gpib/pc2/pc2_gpib.c
@@ -19,30 +19,30 @@
 #include "nec7210.h"
 #include "gpibP.h"
 
-// struct which defines private_data for pc2 driver
+/* struct which defines private_data for pc2 driver */
 struct pc2_priv {
 	struct nec7210_priv nec7210_priv;
 	unsigned int irq;
-	// io address that clears interrupt for pc2a (0x2f0 + irq)
+	/* io address that clears interrupt for pc2a (0x2f0 + irq) */
 	unsigned int clear_intr_addr;
 };
 
-// pc2 uses 8 consecutive io addresses
+/* pc2 uses 8 consecutive io addresses */
 static const int pc2_iosize = 8;
 static const int pc2a_iosize = 8;
 static const int pc2_2a_iosize = 16;
 
-// offset between io addresses of successive nec7210 registers
+/* offset between io addresses of successive nec7210 registers */
 static const int pc2a_reg_offset = 0x400;
 static const int pc2_reg_offset = 1;
 
-// interrupt service routine
+/* interrupt service routine */
 static irqreturn_t pc2_interrupt(int irq, void *arg);
 static irqreturn_t pc2a_interrupt(int irq, void *arg);
 
-// pc2 specific registers and bits
+/* pc2 specific registers and bits */
 
-// interrupt clear register address
+/* interrupt clear register address*/
 static const int pc2a_clear_intr_iobase = 0x2f0;
 static inline unsigned int CLEAR_INTR_REG(unsigned int irq)
 {
-- 
2.51.0


