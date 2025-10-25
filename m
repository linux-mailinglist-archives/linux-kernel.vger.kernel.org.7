Return-Path: <linux-kernel+bounces-870063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDCDC09C34
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1624188FE70
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522D33164A8;
	Sat, 25 Oct 2025 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgS7FhGV"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3675A318135
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410480; cv=none; b=W/khAsiL34cW0Yt/qxTNuz1UpPVMLEHbSux3AOEXjGjn4lJuI3Hk2CtMsE/8MRvl1hpc4MKFk0YDs3G20NZjVM9iirr0wi1Pf5Bki0T1lVmJs00KVLagYno3AmaF766gltPZG7S6VrSMbX9m/NHAEh8pcW19+FjQOZYg4xJjWM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410480; c=relaxed/simple;
	bh=/qN13PxTPUF7Pj/bbigcTnyf8UWTFD28fitKT4TB900=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMT4Y9JcT65KUt8z1R/ExOcnF43+LffGMRXjkzhgPBr/eUuMIPPENMNbTQ1JfUK4cj9WWsqz2vG0ikAyknXYaiYzSYKOtbhzONEwoOG4kMVia1J75pGl7B1rktGk2zUjqhAf0EH21nQL6JkwHkcd5kTJYo/0KlMNsB73VWqAxK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgS7FhGV; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4eb75e8e47eso39409941cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410478; x=1762015278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgpdQly6UAXSTR5MLgLdCsEnF7u6zwKVu6ylG76tjIg=;
        b=CgS7FhGVg8fFqEhBJbb0kDUmXQ2pmzjMaG8/WeYHyxGL/QlfuYZjCRof6QXqY+WBPG
         QAcUcFWvoSmJ5/6YRoGpBO180ia6S94cNbVo/dm4q+P7F7nF/+Utkjsgd/GiDMIxfxkA
         eZLdu9t0W6ELmPSChAAM2B6n/UmYA5PKVi5JfQLexSjQPBDrFQwKEiKHcPaVaURJt5BO
         DYlFMCI3+uK79vyknH/4jbYNUjIC1JdUcYa5Ijc8Bmsc5LVRAbnoLMTXyAOUTY4IY9Yn
         yHhE0L+KbPykcjz5ewqreNySG8mjDlR6WYCVOf5coTMl20OBcE/MFf5QT76pTx62+yyK
         wjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410478; x=1762015278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgpdQly6UAXSTR5MLgLdCsEnF7u6zwKVu6ylG76tjIg=;
        b=mcFTyi6cjCXX2xTZ6CCKIys4lpCeEOKidKdlF6yY/LPOVkFm5Pq57uEHpj+v4TjEka
         CsDY3rJRTCcG+HLkWTx/cN6VMPjqHTlarbJ1EyMcxePROcj4UQdQCGms431q8SA2kwHD
         BGa+zEeYolgNp6l59aY4hTmCLi8Xi5Kxxvxr3k3IXjAsM/Hux0bEhlM1V0mH/Phoyeqj
         mI3NfU+M0tFBfCHNP/0Av7N/4zJU5KhK3TPHnkyuk2sIQ9//OAOFu33fnW59Z610zc/e
         KRqo/MqznS/rZMG4tytFn08LPXkrPPVfMyH0wyDEV5nKsB2L4JjV08bnQAc23XT2fWuw
         0gkw==
X-Forwarded-Encrypted: i=1; AJvYcCVpe5MTFC+C0TWYvNJwwqnpvXSyh+TuEe8GTFndjVXaHGkR8bhXth1kPrViE0PCGnjX45rvZXnUUafkHB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxkAEqjhZK/8NsfAb7OTGfMlvW/JARlOSUbTxpj5+xHo4x+m66
	rETFIP+EDNooGmX1CtVl4BO5QfOJqX70BbGHw75HWDdQ6VqbhhvH7N2K
X-Gm-Gg: ASbGncuk7fk8+8weWDrJPNHeL/w9XVQbyWZT7Ygajbz/eIRsjzWZhoJdSDvMZDKbJ9I
	wgC7/4UCtYHaVm4NcNIm0ZFhuUbYc54RxU8/dtAeWCCqBh7GbmFr35v5bm3JA+3r5iGEBz9m7Hz
	UA42ZWa4gK2+Ci2aD9aKt5LWxzH8QNxToIlWYnOIENtda94UVUBN2PWwPZXhoGQEH/JyLWkh832
	0o5qK00weCR636qEIN+2T5KK1MIU/o+/1sOholh0CnS6KcM7fiUxmt3FmcfqUzhURAtTsDBU7aU
	jH3FEF4nWv7lmlp519Kl5jKfRan1iaZWhI0EYcVYp5riQuXFuGVf30mAh8cUJxx+ToVJ94vM5PU
	lu4uyfVCPRk3AAC/TWWJ0rtlpRXG/L0k/2qDnQaA4OzHda2ByCWGscnBggK13neDaFuM27vMm6S
	vWGVUqo3hnsPYEUjJlZg==
X-Google-Smtp-Source: AGHT+IFkd2wHzM2bhvAxcegsRzuQmKhnwqeGyXDU7KQiqF7VzEOSt8dgBNcFI9XF+zOOfS1sMpRDCw==
X-Received: by 2002:a05:622a:101:b0:4eb:a668:f80a with SMTP id d75a77b69052e-4eba668fd4bmr28177301cf.32.1761410478191;
        Sat, 25 Oct 2025 09:41:18 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f2421fba6sm175785685a.4.2025.10.25.09.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:41:17 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 18/21] fprobe: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:40:17 -0400
Message-ID: <20251025164023.308884-19-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(high, low) notation is confusing. FIRST/LAST_BITS() are
more appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/asm-generic/fprobe.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/fprobe.h b/include/asm-generic/fprobe.h
index 8659a4dc6eb6..bf2523078661 100644
--- a/include/asm-generic/fprobe.h
+++ b/include/asm-generic/fprobe.h
@@ -16,17 +16,14 @@
 #define ARCH_DEFINE_ENCODE_FPROBE_HEADER
 
 #define FPROBE_HEADER_MSB_SIZE_SHIFT (BITS_PER_LONG - FPROBE_DATA_SIZE_BITS)
-#define FPROBE_HEADER_MSB_MASK					\
-	GENMASK(FPROBE_HEADER_MSB_SIZE_SHIFT - 1, 0)
+#define FPROBE_HEADER_MSB_MASK	FIRST_BITS(FPROBE_HEADER_MSB_SIZE_SHIFT)
 
 /*
  * By default, this expects the MSBs in the address of kprobe is 0xf.
  * If any arch needs another fixed pattern (e.g. s390 is zero filled),
  * override this.
  */
-#define FPROBE_HEADER_MSB_PATTERN				\
-	GENMASK(BITS_PER_LONG - 1, FPROBE_HEADER_MSB_SIZE_SHIFT)
-
+#define FPROBE_HEADER_MSB_PATTERN	LAST_BITS(FPROBE_HEADER_MSB_SIZE_SHIFT)
 #define arch_fprobe_header_encodable(fp)			\
 	(((unsigned long)(fp) & ~FPROBE_HEADER_MSB_MASK) ==	\
 	 FPROBE_HEADER_MSB_PATTERN)
-- 
2.43.0


