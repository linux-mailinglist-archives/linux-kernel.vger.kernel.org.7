Return-Path: <linux-kernel+bounces-785337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD17EB34942
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38EB1B21B58
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357561D7E5B;
	Mon, 25 Aug 2025 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba323H+m"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2281302741
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144069; cv=none; b=Sqp7KmqKH5NDWzrZgn9c1KEH6jwqXHaB05muNUcX+6gH7C1DKQSTO7pQC3fysS14g/jM+xTRHehO/N8qSp8oww3H6sOjQxxqEuo0UPxgT01EBigXANSGGX/xfcO+rn5vDmFWfeDC5ibdTPQ+zaEC9yrU0pwG8aKUH1v2T9L1+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144069; c=relaxed/simple;
	bh=6XAbuerpneN4yZoilz4r+W1Sl5TB/K6pl9UokLXmzMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uAz+NhED8pIQqTDbEHNPA5dquibjsmee4X6vw1O4Cr6OKZbevhXo+c8xFnv0Q6xuDpgdK0bnYB22753WVHEdB1Q9FzcoIQb9VfZlzuevV+TlZ54CZ315Toj1xHuabTFzZCKFo6Y4Rr2eJYOIfNAadEjLai2a0Ozc6QezLjzHRQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ba323H+m; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ca013116a9so97720f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756144066; x=1756748866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GEbCXavjav0eBdbREmn7/PE7A48dTBvzVQM6LFJf3EY=;
        b=Ba323H+mw5yyZapBsDkTbU7/2wwxdoLhjmbKy9p13xn31/GGljz95vaoJZbadlIjRK
         LMF9JaU3/nVZmGDS0MnJM0nXvSKItjrP8xDI5N+V0IgayYWi+jqkj32WkHgtagd+alBJ
         lr8/F8xlk0L8O/EaTthE9eGRAO/1wDCkGVzxieFAXzleQhWhIlXQswIKnGcOk8ZyXjDe
         jHr2urFtvKQDj7oCWorJsETD6LfQU9Gne1WFVfX7FwocHoJuBqTM5gqBoOxrc02OUqKr
         VR07sVHUUnjiUBj8O41wkJJd90bv1dGeuz9IMnp0kuHEg0ilNNdDyg1I8dNsFzmqMPc7
         1xTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756144066; x=1756748866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEbCXavjav0eBdbREmn7/PE7A48dTBvzVQM6LFJf3EY=;
        b=VkmRsSCo1ciZyVLrp1KePF9ThMviouqUX0rNz42j8SabpOcM7OwMLDUXj6MGhe3Jkm
         MYSUvYIAW8h3VIegBHtHyYsiDKahTIKJPEs7dgIuMFnComI+SQQdoO06OefICFEW5f+D
         gUw8Uox9ELeyPwnfYrU5+LWUDd3100W6z8pp4BlXI/nmr2mTyjie8LtHXbwrFEsCM2CY
         IE13hE2M6mzEIU0udpm297vmUXjcCdnufNWsY2S+CHH1OCjlrEGutO+tGiK/cgLLXRE9
         C20CubLPY0b4prMrA9ISUJc49C6yR+DDnGQPIBFdCTDc6WrhFPpWCSZMrLPT2vX497gW
         kvgA==
X-Gm-Message-State: AOJu0Yxbc0Rbloew1XNDgniqi5h3btGy2RSgAhBYN4N8K14wVWEt8kRu
	rhxAYrkR1xbOMmjaVZ3Is6PhKtZ/Eui/OrpsN6yDYNeHckN+bgzIayIK
X-Gm-Gg: ASbGncsgAWbzrAcfq5QtVptzCMwFSCSqycrbJK5+BSNFe0jLD/jQFtOuOxKBEVAkTts
	BevMam4EFLQjWOr8sG65Uexp2cfzJ2OP2VZK0ItnSNBQOd/hfje1L1CoW3Zy+GjYpAPl36SlVSL
	fBpp4cxl0OGElM7HJNakZC/wpa/TEaQ5w8lH+RUbgRGUr3qNnYTvCz+TUGM/1dQvPnRid+CG3Y/
	8ilC2oRD/o/MDjZDtQqBPs+TpX8Z8ct1OLS6nePQNK1xJkJOCCQRssBMGDEpY1Q9fa2gX7c8guP
	sfp9/apBOfe4yURohf2tcf5P1TPCT7Fxwb61g6Omtpl5knLUwe2JCXOAtdolQkdHuRFpK5a/EDy
	gRzO2QRk0Uvvz2utTRS9qbWXv/uB5SGkLasc=
X-Google-Smtp-Source: AGHT+IHG5SwW/x+z9m+CPc7u1dmNXPI7K+/ROz2zYsZlSGvxqhItmSR7iZUbbY7EYSTBVT0I2uZkug==
X-Received: by 2002:a05:6000:26c1:b0:3ca:a190:c461 with SMTP id ffacd0b85a97d-3caa190c81cmr500334f8f.9.1756144065764;
        Mon, 25 Aug 2025 10:47:45 -0700 (PDT)
Received: from gnulinux.home ([2a00:23cc:ee22:4f01:7e07:36b4:64f2:8b5c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7113fdacfsm12482813f8f.35.2025.08.25.10.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:47:45 -0700 (PDT)
From: Harry Fellowes <harryfellowes1@gmail.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	Harry Fellowes <harryfellowes1@gmail.com>
Subject: [PATCH] x86/boot: clean up whitespace in a20.c
Date: Mon, 25 Aug 2025 18:46:41 +0100
Message-ID: <20250825174641.16030-1-harryfellowes1@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove trailing whitespace and fix blank lines in arch/x86/boot/a20.c
reported by checkpatch.pl.

No functional changes.

Signed-off-by: Harry Fellowes <harryfellowes1@gmail.com>
---
 arch/x86/boot/a20.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/boot/a20.c b/arch/x86/boot/a20.c
index a2b6b428922a..15bbd4ac55cc 100644
--- a/arch/x86/boot/a20.c
+++ b/arch/x86/boot/a20.c
@@ -135,29 +135,29 @@ int enable_a20(void)
 		  (legacy free, etc.) */
 	       if (a20_test_short())
 		       return 0;
-	       
+
 	       /* Next, try the BIOS (INT 0x15, AX=0x2401) */
 	       enable_a20_bios();
 	       if (a20_test_short())
 		       return 0;
-	       
-	       /* Try enabling A20 through the keyboard controller */
+
+/* Try enabling A20 through the keyboard controller */
 	       kbc_err = empty_8042();
 
 	       if (a20_test_short())
 		       return 0; /* BIOS worked, but with delayed reaction */
-	
-	       if (!kbc_err) {
+
+if (!kbc_err) {
 		       enable_a20_kbc();
 		       if (a20_test_long())
 			       return 0;
 	       }
-	       
-	       /* Finally, try enabling the "fast A20 gate" */
+
+/* Finally, try enabling the "fast A20 gate" */
 	       enable_a20_fast();
 	       if (a20_test_long())
 		       return 0;
        }
-       
-       return -1;
+
+return -1;
 }
-- 
2.51.0


