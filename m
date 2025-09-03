Return-Path: <linux-kernel+bounces-799265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE08B42923
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65AF31BC3B8D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4680369347;
	Wed,  3 Sep 2025 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="HFdRjX2m"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2053680A8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925625; cv=none; b=DUzZCQLv9SlwCmMZ5DRCofJZYvPtXOKN7X69NY7d7mYqR5c0NQlo6+Vng1HJ+PhXf69X2hXyHBmpxzhkC2BIMeI7/11wWCXDOdn8HHWlm9zZgusIMkG6mlTo+A6rp4F393AtRxBSgqNUo6r8HwKBpWd+woFUwIBz8FpV7ynES4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925625; c=relaxed/simple;
	bh=WwDwWn8PUMqzNmPRX5AJQr10TNESZyHkO/C2KBJ6k40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nAHC1lNDpQAWqMByF9okbZXgKHSHJEyyP2AlA2OeKS5V5nwm9eUrHHK6z0ndwnCy74eDQbhG5nlk1xsDnDcP1M5CskDIWz208u7R1eXh6EjUlwK5EFX28I+sk36Ep/tm5Zrp4IiIP0yspW4hwvv1owM/YKnANgNWsa0hI/OXaWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=HFdRjX2m; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3df3be0e098so150380f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1756925621; x=1757530421; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jw9BHN0FeRhOuxnLyFuwgicmhR7Ua+FygQwocs16V4c=;
        b=HFdRjX2m+hw1pG9m2pDERobYQRW3I0p1KwV4T/VWdoK++FP5/8fWHgCcnxpjV6qROd
         vk5bgaBw0PCDyubHlmypfN7tuAOsfseNg8FwHeVzUItsOBJRUvC1/j2eMGBOx93n96s4
         dtJW8LA2ZuRa/9q2SxidIwifv/O0H3xCERQ02XWDsc+6UUOOplsNo3E8uD91wx3JDdqh
         UgQY/Fjz2K69d5cpaYzJWiplnXS+vlTIKNjW74LLNj1PkJkNvLZTHCbfv5qSqTc3Rah7
         Db8wR6xLW7ZsquaGi21r0njmbuRflTkQxfCe8+HHvfNaxG23hBfAiVeC6OP6jWqPt1r5
         F6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925621; x=1757530421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jw9BHN0FeRhOuxnLyFuwgicmhR7Ua+FygQwocs16V4c=;
        b=CcDJ/5GtBuqps4tKu5tWht/AjMiGutCJWTkCT1o6flBGIGXR3cCPixM+Vm06buPn+P
         WuiyIYDCX0hlJWQhSfxhX1ezezcqiWpddO970AIS2GoEZYqjUvOPTv1z6bJtQYyhK+dg
         R0xwO4GH6JEaAoxGONR4hG2MxO7NwKVDGJv1e0MbJxo0JHOUGZPuz8SmeeCP+SCCM1V6
         1hKkardQ9hU9mgFX9Tb2d9dofJZu/6X9ZNbzczs6ZFg/nwUTyr0pcCN2lKIzMGvn3HXx
         zqWMoiJe4mOW0H0at9Z81f9UGyonYkN/hQM2Z4bHHVKdtEp0lWtUpHYbhS4JJeiWKjDE
         Fi4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbI+U9XSYrdQqtZILyucfVdEegGDK7kZARhnGXlekmckOCqbskwM5diPRGfwcyG3EuL9atCSBbuDCdoeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBLyDKFeJl7/dd6fZPmET/ZpiHVShXgGQ/S92N/RoxvlE7ScIS
	pYNqfPGlSSdCK/tq38Jnzky+LNILwrpvTLwC0Ay6XDic9xKeHLQIb3mFBR+htvo0PeM=
X-Gm-Gg: ASbGnct3GM9Uh0aGlNJUTfZtgy5t4jgs+ZOF7D9HEV6HbpITWcn/pZ4zmEJMPurnZGw
	ytEhm9OBxgZk75+CtrS2wsoIzId1Vl5GOyImz9X0ZYrXFnHGCfrVvLsSrpMQb0c/L3bONkPU8s7
	3M9aghrZDiLALcTBDG80qi+BShKBlPyGrexWrRZIScMfnDtyNlkTqmekJk/4nNjk2eZRk3Uujvr
	81M2HhvgDJxHKCRkGkMO27JmeLhbvMrA0JXg2FDy9sTykY+m/+g6aFpxjUkHoiDnPm2a2NW5H8q
	xIpTkyULJ0XjPzJOp4ME+W0ZFkPXPI5XJyDz4Is7bPKGwLLnJYxIAu7DmTawvESObQLJ4jOv59g
	CYCBuFd+pAQKuk4ZA8iZ3BepVRuJK36YwsDDlVE+IQjucaSm463LJ3tO9VJUoU7woTxVlqZ0jy5
	p7ID4MgD8i4YQbVmg=
X-Google-Smtp-Source: AGHT+IHOk7OXAl6oV2267O8szo6YMPylYzzI4Dr46hL2gWcdyGl5LwYgLiSHECqfj11Wp5eTPIQCDQ==
X-Received: by 2002:a05:6000:2381:b0:3d7:cd09:ae1e with SMTP id ffacd0b85a97d-3d7cd09b425mr7585878f8f.17.1756925621431;
        Wed, 03 Sep 2025 11:53:41 -0700 (PDT)
Received: from alexghiti.eu.rivosinc.com (alexghiti.eu.rivosinc.com. [141.95.202.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d690f2edf1sm13920647f8f.16.2025.09.03.11.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:53:40 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 03 Sep 2025 18:53:09 +0000
Subject: [PATCH 2/2] riscv: Fix sparse warning about different address
 spaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-dev-alex-sparse_warnings_v1-v1-2-7e6350beb700@rivosinc.com>
References: <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com>
In-Reply-To: <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com>
To: kernel test robot <lkp@intel.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Cyril Bur <cyrilbur@tenstorrent.com>, 
 Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1897;
 i=alexghiti@rivosinc.com; h=from:subject:message-id;
 bh=WwDwWn8PUMqzNmPRX5AJQr10TNESZyHkO/C2KBJ6k40=;
 b=owGbwMvMwCGWYr9pz6TW912Mp9WSGDJ29G2qCX+T9j37/c+fnfq7dTqqNA5eXy6TvlXmVMS7P
 PGnVtNsOkpZGMQ4GGTFFFkUzBO6WuzP1s/+c+k9zBxWJpAhDFycAjARwV0M/xQO+NxrPcCz4seK
 jYcYj+6IT7lUv6Ak6sOCQHb/cyx8fr8Y/hc0d90o7N7GUtb3nifIusPw69mPluJuU+yUKnK7Jl9
 p5gUA
X-Developer-Key: i=alexghiti@rivosinc.com; a=openpgp;
 fpr=DC049C97114ED82152FE79A783E4BA75438E93E3

We did not propagate the __user attribute of the pointers in
__get_kernel_nofault() and __put_kernel_nofault(), which results in
sparse complaining:

>> mm/maccess.c:41:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long long [usertype] * @@
   mm/maccess.c:41:17: sparse:     expected void const [noderef] __user *from
   mm/maccess.c:41:17: sparse:     got unsigned long long [usertype] *

So fix this by correctly casting those pointers.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508161713.RWu30Lv1-lkp@intel.com/
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Fixes: f6bff7827a48 ("riscv: uaccess: use 'asm_goto_output' for get_user()")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 551e7490737effb2c238e6a4db50293ece7c9df9..f5f4f7f85543f2a635b18e4bd1c6202b20e3b239 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -438,10 +438,10 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
 }
 
 #define __get_kernel_nofault(dst, src, type, err_label)			\
-	__get_user_nocheck(*((type *)(dst)), (type *)(src), err_label)
+	__get_user_nocheck(*((type *)(dst)), (__force __user type *)(src), err_label)
 
 #define __put_kernel_nofault(dst, src, type, err_label)			\
-	__put_user_nocheck(*((type *)(src)), (type *)(dst), err_label)
+	__put_user_nocheck(*((type *)(src)), (__force __user type *)(dst), err_label)
 
 static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
 {

-- 
2.34.1


