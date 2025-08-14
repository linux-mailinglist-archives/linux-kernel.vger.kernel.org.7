Return-Path: <linux-kernel+bounces-767913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61689B25A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F02D722E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20961ADFE4;
	Thu, 14 Aug 2025 04:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCdGpfLI"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA269163;
	Thu, 14 Aug 2025 04:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755144979; cv=none; b=TXb2NwA1v3BGp6gPJyB1c8Uca2TUimAkPhZXt798STek/zlqhMRDa/lVPOp0Q9YoGrw5zNzxCFoMKrhnq9R4BjEtlPmtB02bp0C0C6tcR2xKDQ4PPoXY/cMWiXRQOZCYfoQ+ga5frirq32ImJUmMUnyhpHQX56wmJ/Y3usQSk/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755144979; c=relaxed/simple;
	bh=HcspPniQ+/a9UgjFb44d/Qy83pFsOwoD+mG4yuju6Fo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ROoNKoovRgDudBbMnTZkej3Cgqqqb6f9t2Ph7qU2vUCkdESmpdZCWNLT/Z98VGlWELwp+HxYfFOFGuEomTuQem9hjvIjHOn036ZS5F8VpNhidtkGxxzM53VMS7nLUCfBwrhNAx3OkIkL5yCog82+CbNnyKq7eHs7HEvfoayYzJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCdGpfLI; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b47173749dbso271806a12.1;
        Wed, 13 Aug 2025 21:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755144977; x=1755749777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+vKmcBx4tFOUtnevR3o1xCot+6PtJYfeGLB/iWk5Rc=;
        b=DCdGpfLINfp3Djtb5AKZ12kHf6Kvv4eJYNzZAr4JvkQ/bM1OqQ2JEQ8Q3w8A/fb68I
         7g0ntMArLx7MSyoq3EiBhLooa6ArGd1wM2LzDF+t9EZoKIoEGyprwxouT2yxx87e34FS
         l/a8xB79ffloo4O88IiNNLtwFXk4KKUzbfVFm1gIoP454hkGvCV6zJ/kU82ok3TSpIEP
         yPnIRS2yZo5iax8HA5qL9+aYQRpUBK2rMLcjD/awBjT7w71HlmPRYd+tc8saYr6ucmHA
         E0UfW4fWrwkTP7WLrLqmT583gNSP2i4NtU62KH3DVxayqxRUueG65nmDoDvZO31fdHvA
         Kgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755144977; x=1755749777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+vKmcBx4tFOUtnevR3o1xCot+6PtJYfeGLB/iWk5Rc=;
        b=VwBzJzTAFYAcFM2AJotCjJ8G09Dg8VjYzqcW1wrIwvqO+wFG4AOjPg5U5FBvWqPCpd
         GnJETJe4tWBs5PS2sBPTb7RPNE46bcgTk6KVHm47xsH7IjE+TBn8VvdzWUa5B9gdgcjk
         5EdE+ZUK5LhqqEqN2g4vvtTpi9pVVhPJRdKcFT5UJ/98MZpAlSAXaUGvuAr8MNF/H72p
         Yapyn+tc8MMLajCqL+EUlg0N6UGBdkZTLMZztUq0Km8uBj3BTRHs/+2zwju34Bu04qtt
         ubEuZFDDDCr29ji94Infh5940DgbpVB1GKs6CjBncRKKqdhVA85pJicAYuAqkLqsheKt
         HzAw==
X-Forwarded-Encrypted: i=1; AJvYcCU8GZXVb8dgL2yhNLDD/NRtV7PutxguG3G5n2h3EwLlVUKY2YeQ8Hojl/13/JDKW9PVfbMePpFrMMTLR4uY@vger.kernel.org, AJvYcCWKwuwh4YfkpRXToF8ZqndetjbuAnCGtByJyK/CdywIG+3dbERUa58hj6fvhGLUDWpw8BFwFguVzgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0WAlecrFJ9hhPoU4/xXljeRjkPeA/gvFAFOG1+zD6Jf9niR57
	Wz1oGOqFSZjpVit3MzkrnsTNc2FhoozXDo6x8bD3FOU1yzKdZh4kFL1T
X-Gm-Gg: ASbGncvO1WYUVg6+UML18Z9rHNG9EVrq2+7wY2NBOa6nraqNnh2T6GXn9aNynBBqiO6
	9K/5QSBExFLuD0kCB2nnvhfKlrpWw4RzVW4g8WCtc5aQiXgwlAW7QmkWnzQIbD54/YNIvnRP2Jl
	7rjpkRS3dNgnzEx9IQxG3pUbJ12s7FIWGTPEfEPP6+bvW64thYADWEBgWeggHbXdUAsrP8FBx1J
	xWu4M8MoplR5vCC/b6x8NZuJEpA1tXOe5OT4ZTcNOdAqpeamHgvie5aafTb/eevUrwvtxasHlGB
	aYIWNaBl5P3BbnWFS3ts3najphk+byXbtVp2XqXanMuCE5hnkUNAoTHeIrBrGJoYqc4FiqNI5le
	xwXKkNiBkhMp4cveu7GQTJZCOZrQD1lyOfFNDQRldQzCeYn6VTOVl
X-Google-Smtp-Source: AGHT+IGJeiWTZ6F9tpbjwIVdobq2AZBl0UzxA0HfAXRIiDkxn+DQdTqB0CPfuTDOv2fPgCX+MYNXaQ==
X-Received: by 2002:a17:902:dac1:b0:240:3db8:9adc with SMTP id d9443c01a7336-244584a3000mr21493165ad.4.1755144976783;
        Wed, 13 Aug 2025 21:16:16 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d003:7033:db86:dda3:2130:836e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-243031afd94sm54908245ad.113.2025.08.13.21.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 21:16:16 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rdunlap@infradead.org
Cc: Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH v3] kernel-parameters: fix kernel-doc warning
Date: Wed, 13 Aug 2025 21:16:10 -0700
Message-Id: <20250814041610.28171-1-vivekyadav1207731111@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vivek Yadav <vivekyadav1207731111@gmail.com>

Fix kernel-doc warning in kernel-parameters.txt

WARNING: Possible repeated word: 'is'

```
[command]
./scripts/checkpatch.pl --strict -f Documentation/admin-guide/kernel-parameters.txt

[output]
WARNING: Possible repeated word: 'is'
+            The format is is "trace_trigger=<event>.<trigger>[ if <filter>],..."

total: 0 errors, 1 warnings, 0 checks, 8339 lines checked
```

Signed-off-by: Vivek Yadav <vivekyadav1207731111@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf..302145870 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7506,7 +7506,7 @@
 			Set a trigger on top of a specific event, with an optional
 			filter.
 
-			The format is is "trace_trigger=<event>.<trigger>[ if <filter>],..."
+			The format is "trace_trigger=<event>.<trigger>[ if <filter>],..."
 			Where more than one trigger may be specified that are comma deliminated.
 
 			For example:
-- 
2.25.1


