Return-Path: <linux-kernel+bounces-835031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB68BA6163
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 18:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 295647A7F92
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 16:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ED02E62A1;
	Sat, 27 Sep 2025 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX2pRive"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3411620010C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758989525; cv=none; b=PsRIKU/LQsfQydDyobxKFZB82LmXz6j11Zf/8ODuFvpF7n/7R/49+RnjwucJMeyJYQKvUsLuHW1UaBLdSrd7LlVF/1NDSbSdaqQz3nzhvVj4RCux4qvs2f9tiyUA49kqcychp8+MtbzZwzDD1crMoVCshzgZMT8HqAIWLxsoHCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758989525; c=relaxed/simple;
	bh=FlXf6A6U1TCoVupOp52iYngSL0vU7uTOEMTo0EWklfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXWEpWic6Pd2t/6re7zaKqsg5H7IVddxtGdLE8CL5LNmr2sb6f9b1kS0ubNi6afj2hZQivYBdDSIjH1eI1395GZpIQcAPf3AIyCgEGOpWR2qhAIF9bVwpklyHYi6YjLfvLLOo0E4A/D8775cjuGoKUU6edN3oGzCHfpKDvmcO7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX2pRive; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b54a74f9150so2828640a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758989523; x=1759594323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05pKpEscySAPey8grE3bZC2pVMoFVZAK0WHxujOjSYo=;
        b=YX2pRive8RdANpuf1yJX/LTUJ696kiObKLl9uwo0ue4V0zyBCBsb38V4wJlhI+oLIr
         CuPLEssH+2yTD7LSMYyKfJuaQBEyZdp5wnwEycAj1WU31JApsPTtYcsMaxjBW7zcjFAV
         gJneuGSJXAjg9adZuT7yYFU+4ly7/OHu42HjVstTMl+XPuBeTJ7PGi/CEznc3LiUyxW1
         V6dcXNBNrh2s0OJwyok+vxh0Qesq+ybe6vmiTl0Y4CUxEwqJyiLz9yk3KZmopZzCuKJh
         wl+dAOVO/9tLBAarhpJ9yHVCDBs9SqGA1EjD+cXdHG3VLXpOZgeURiQuOCSc1f7XCC+D
         /ZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758989523; x=1759594323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05pKpEscySAPey8grE3bZC2pVMoFVZAK0WHxujOjSYo=;
        b=Qzuyp2+SvNA5KayLeq4hOFtIwzzrB7t4B3Vr4vewQjtMesDi6Hal3SpvaY0zxcgP3A
         F0i82Tg0AGFNLOVMi4LFfMJIoOHqA+rrDojyWigYUap8S2zx9HezHI4nOC8T9m49QG6R
         fDfY6/dIUQm5AfMT21dlfxwBr1kjH/EKVbjM6Rp2gQgek7KAU5f5Y4BHwGPhDznictbH
         bI8fNPsohZqoRJKwz6NpE+STN8vJPupb8q9FP3XoCJzkAizTjvelCNn6IJ3F+whmAU99
         KbS/lfvnRpMx4lkPbyjQ9es6oF+b2NlVm405iZRMc+2G78nCj+JWVhAUYHe4qu1bHW+I
         GOGg==
X-Gm-Message-State: AOJu0YyQSw0pRCqGI7jnEQLR2L5/1JBkNjvNRepd1/5CzIHLOlJAjRGM
	ctkf/5i8NwPnMv3/KA8SuEWDZs9cDnitlRhtpLX+ucsopnVopMhlVg8A
X-Gm-Gg: ASbGncvOWQ2I1doCluYlXO4LeCUKIMG5RsYnPA8r2foU0fcePWbs64VKo6MBTKsW023
	Mp2Qb/L4PLi6L8l6eh10n9Ns4ig/PA6SEzRtrI0oHzv49UReabw8HhTtLfjcmnN6wRoZyoT8xzK
	pG2CfktuKksY4qaLxWekLoKXUTwxPqL57Ejwgf4Oa/FwHi26OpcacO2PetyP1DF6uKiht4tiqfY
	2paR4lV+qCAqncP7YrRrlqPuWjbiU6MMO9Ebq6pVqkq+LPK4zYiOOIom8trWA4bsKw5lSUdIN2o
	88C3Fkvkmxv9CUXfJyX6iNAPa8f7DtOZFFWkHySUnsvP26vot6basF30V+syIA/9HKtTLqegMJf
	S5IoyFs6AepNy4SAI2r/GlJgIwcQGNeQT+pSX/qK0JlTPkQ==
X-Google-Smtp-Source: AGHT+IER9UtAbZFy+Mmh5AHdXm0Wzu9fDKzm4dGEnBECZaMbz55UHuRFnI6Dg21XQP7946L7Wqo8bA==
X-Received: by 2002:a17:903:1b28:b0:269:ba8b:8476 with SMTP id d9443c01a7336-27ed4aea2abmr123050575ad.56.1758989523418;
        Sat, 27 Sep 2025 09:12:03 -0700 (PDT)
Received: from archlinux ([36.255.84.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69959e1sm84420365ad.103.2025.09.27.09.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 09:12:03 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH v2 2/2] selftests/cachestat: add cleanup for leftover tmpshmcstat file
Date: Sat, 27 Sep 2025 21:41:41 +0530
Message-ID: <20250927161141.778631-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922091042.149117-1-madhurkumar004@gmail.com>
References: <20250922091042.149117-1-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cachestat test generates a temporary file named
"tmpshmcstat" when it runs, but this file is not removed by
'make kselftest-clean'. Add an EXTRA_CLEAN entry to ensure
the file gets cleaned up properly.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---

v2:
- Corrected subject line to describe "tmpshmcstat" as a file, not a binary.
- Refined commit log for clarity
---
 tools/testing/selftests/cachestat/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/cachestat/Makefile b/tools/testing/selftests/cachestat/Makefile
index 778b54ebb036..c48065d791a9 100644
--- a/tools/testing/selftests/cachestat/Makefile
+++ b/tools/testing/selftests/cachestat/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_GEN_PROGS := test_cachestat
+EXTRA_CLEAN := tmpshmcstat
 
 CFLAGS += $(KHDR_INCLUDES)
 CFLAGS += -Wall
-- 
2.51.0


