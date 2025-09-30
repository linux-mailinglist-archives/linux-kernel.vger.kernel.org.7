Return-Path: <linux-kernel+bounces-837095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E93BAB5F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F763B91DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471E22248B9;
	Tue, 30 Sep 2025 04:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIDX1NFq"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6701DE8AD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759206664; cv=none; b=n5Ef7QGj1KyCxQB1JRylvH27sG2P+JdmSGiZhCy8GHFio1ou7JDT25GSpyO6gRwWYNmHS7hKJ1kTtMLrBwN3NqobF4AUnYHmozea2jNJKzwrbBREPGaXhmImAJ0W+o90Y73qNSKPTTPbrUX4yb7UOj2XweUi/ONUsSKNoeEwWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759206664; c=relaxed/simple;
	bh=dARnSwt0XVwRo5+Q883SPN8NokxwzfDXKO1ORn4QXDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Iew84jmyQqXeXvn16N1VYB3LBCLCmNasSQRI8YgOQYBmoZJvvarNYpbM+gpVVS1bEsMPQPJ9cm+EXCy+g1AUzD5H60xnWV8bul+KTu+QjNR/A7aUHLSsKTKeq0P3t7II0S7WPf6rU1pFxR3emSwPaU5MHLqXtV51Cp3H6L/Zr8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIDX1NFq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f67ba775aso6532518b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 21:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759206662; x=1759811462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5lGVXcyQV5BtOyUivumPmKx+deQGZIbM17hP/BykRMM=;
        b=hIDX1NFqZYZDPZ+DHgD9EqOzKKKZlbqrcMyPreeKvXy54SGCrrHcM4Ftrh4iayWoJi
         1F7JtvAMPZSWBUVMoBcMwtkM2xl2C3MVSrC7Wxe9aP8dtBZdSKhu//ucVGU7aoGDw9WR
         6sA31TA6mrXyhZQbEGVh84Am1S/BOR2KKayfqPzC28r2b8Uf+ccDcPqNciFcU47PyV0K
         Sp5TPHdQhGCPT9Eciyl3pWmwLmjmTNBC7TUTs4rsTKV/SdGydMetRE8PcrGLpmG2bWUK
         xM7bur5O9aFeL9OHfV6HzjHNdlALtyrbXnVnHoo2soQqnZOmlZt0iSVnoxBLGDsb5Get
         K3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759206662; x=1759811462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5lGVXcyQV5BtOyUivumPmKx+deQGZIbM17hP/BykRMM=;
        b=hOgny7C5J6npfg78HPv/vaVpLk2iRU7YkiAFl2gFkEbPYkcT3UtxVhfbkUG1393SeZ
         ewC+R+to0oUf8NGBl/K+gbG/6qW/xDorCU37djA/8Jb2RG1n3EJY5j3VsEB08deEKjHE
         Qn9e9pEI+oSGhe6v3jsBKHDF0e+i6+9hznGTawY4CY1mbupqZY3NVJ/u+329lFkBBm8o
         V57V8vfNXicA7o8khgjBEKwO5GwZ+ka71Uyo8nUycHqP5zdhqfXL7Q8X9S6OWFZ6cH3E
         MfNjEtzX9nXlTzBTFDzLCqQTgbSI7XVvWXxzOPEIabhBVXNxbKV0ae9ZLm3N28vES8FJ
         O4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUT63IaiCgPu1D6RDt5/M90Q7O4tS8GhcmetgHvnmZD/Yd0L+bUAJHk7N7jeNEcGGIcT9OhF9XYG7D69oA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbStc6DMUK5DILLLOS+EFzWu4TTbpxgD/y79le+G1IjxtdqK2s
	rst3acdhSg4gc2zLh9eeQdMgwnpttoD0OkHPrneu3JlYxNDT1hLiaVyd
X-Gm-Gg: ASbGncsTniBZyLCjk9+N/E7sBxXPwgG9vgg6bTQsbE8tAnaYDUohTARLZ6svkC9S8Mz
	P8W39lHXZm9IeKj3Zj0R5LyVqY24/kzTZZKfjF3cJsoedUALxZQXv1HZ+9dHPzF+eQdC6bsl+nQ
	oSAzbSv9Z8cSSzPWhqxJpNIyWUD9bk5GMtpbQI9vDP1MRrOf9eqZRi0Bwn7++I9ltVDgJq7muJK
	hkgvf8KPkdjKCHz5tGDbeGlIih2UC+zFrrX0zvSjd1ORiFG+zPJhQczcrm+aTy9ztHxRKNF5Lue
	rfXIRsaTn2mwy5zcPPqEDFrDSp3aLz6sH3rw5M3fGmanjC+stZiFotben0HMYZB5HakTu1RKWKG
	vA5ZiL3pgknhOHYgymLwmXz+Xi5MvSWgOtvVyJtyYo/rU4dMAbIuXgRXrzh/WlLGDXR9Z/MXFw9
	358fQ2PJzz3MokTPTxlen7qg==
X-Google-Smtp-Source: AGHT+IHrAsv11dCGi5NHeEuPeDktvvkUaPsjolFBKT6ZPXUbsv//I2rWb31yK7FrjCAlZVXaw8G2cQ==
X-Received: by 2002:a05:6a20:3d20:b0:2da:f4be:c8cd with SMTP id adf61e73a8af0-2e7d707af08mr20206077637.51.1759206662414;
        Mon, 29 Sep 2025 21:31:02 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c5574e99sm12615030a12.35.2025.09.29.21.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 21:31:02 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: djakov@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	marscheng@google.com,
	wllee@google.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] interconnect: Optimize kbps_to_icc() macro
Date: Tue, 30 Sep 2025 12:30:55 +0800
Message-Id: <20250930043055.2200322-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current expansion of kbps_to_icc() introduces unnecessary logic
when compiled from a general expression. Rewriting it allows compilers
to emit shorter and more efficient code across architectures.

For example, with gcc -O2:

arm64:

old:
        tst     x0, 7
        add     w1, w0, 7
        cset    w2, ne
        cmp     w0, 0
        csel    w0, w1, w0, lt
        add     w0, w2, w0, asr 3

new:
        add     w1, w0, 14
        adds    w0, w0, 7
        csel    w0, w1, w0, mi
        asr     w0, w0, 3

x86-64:

old:
        xor     eax, eax
        test    dil, 7
        lea     edx, [rdi+7]
        setne   al
        test    edi, edi
        cmovns  edx, edi
        sar     edx, 3
        add     eax, edx

new:
        lea     eax, [rdi+14]
        add     edi, 7
        cmovns  eax, edi
        sar     eax, 3

In both cases the old form relies on extra test and compare
instructions (tst, test, cmp) combined with conditional moves or sets,
while the new form uses fewer instructions by folding the addition and
flag update together (adds on arm64, add on x86).

This reduces the instruction sequence, prevents multiple evaluations of
x when it is an expression or a function call, and keeps the macro
simpler.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/linux/interconnect.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index e4b8808823ad..4b12821528a6 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -16,7 +16,7 @@
 #define MBps_to_icc(x)	((x) * 1000)
 #define GBps_to_icc(x)	((x) * 1000 * 1000)
 #define bps_to_icc(x)	(1)
-#define kbps_to_icc(x)	((x) / 8 + ((x) % 8 ? 1 : 0))
+#define kbps_to_icc(x)	(((x) + 7) / 8)
 #define Mbps_to_icc(x)	((x) * 1000 / 8)
 #define Gbps_to_icc(x)	((x) * 1000 * 1000 / 8)
 
-- 
2.34.1


