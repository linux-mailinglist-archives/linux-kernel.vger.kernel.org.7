Return-Path: <linux-kernel+bounces-845700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C61DBC5F88
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA89424D5D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB89221DB1;
	Wed,  8 Oct 2025 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jkr9eYNL"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E52FCBED
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938428; cv=none; b=VCYsK26nQ3KlSHWYJ+BUmaWZEfCxb22Wqesd99WVdNBrx4+ek3SPm81E9J/4oZt/mSHxuDePkER8Kx/65jzzzAYWRIKTazohebPQ7lZYn++c+E36fhLVWxZx8ZCZ+jrgPXyMzU/VlGc71qVdulbfr/MkfnTg7O3G0YyyY8i1UeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938428; c=relaxed/simple;
	bh=e1uCNgvDUPL6Q8IGrP4fE1tjT9jxmUxE+KdCoB9JZM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZZB2ALfb1f3zrFSoGgPZu22NklCWQcM4UpTTXY1fvT3HbSViwlNoU0oXBevbmFsk4gHGJ8xdVQWQMVZor9A30er8mM6xnY1NWb5ENCFPtLuvJGTCqpb4/dTSjrTwct+4aSJQ5BA2CZYSItJpdS4DskcilFiW3NVycABVnOA4BOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jkr9eYNL; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e36686ca1so71992295e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759938425; x=1760543225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pCqfiDMNXwNp3eFCLlUtfPhbgD3LgIedHtp2uSYpz9o=;
        b=jkr9eYNLbk7wVyDI6UHYi+5oKhLyYsw+OAeiiWWIFWyV5yvpSWfSZBSDHo+RKdGlP+
         /NyCCmyoxiZt/jGygIUbRKurDRf2frvj5PfpuhjgnMlTmcOE18dPlVwhP8e5LDC1YRhS
         xfoCcUbbOchJIBv7Qkcv3PbllSQNnhdUvD/qBbAnKv1T9pZKvyNuCL2LxFf3+ZLGpWNH
         BwPmlJg74Rvp+SYSaoL9VyyHBCi0F4lIf8wdHTLPtShc1Wy2+QTepdbmc8ExbYFM5AyU
         t5wgrgOQhvDOO+pPNkonT55FBjrvuWVIc2fibVTRZfQCVY3pvbVlmlTIKUGfeLJ1pfkx
         8mBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938425; x=1760543225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCqfiDMNXwNp3eFCLlUtfPhbgD3LgIedHtp2uSYpz9o=;
        b=At5ilA6Z+o2jDeaT+O14FEpojR1BHctZVoUzsX8esR4Qd0iZnuRC6RqTdfXDXeo9+i
         zhaTQNeMNJo3eSkyI3seJnndDm/YBBY1mztSwhn2OAA4uGtJxTczI0Q6Pu03kBLChtjl
         tOr8MkyjSKCmLwLv68OAQl3wPhMfrNKhCjBgFoFwvPsypAkqJHwexjXDkqM/VjGAuw9c
         bqDAdJenYp3cVhO6wFu3QDxPK9xiu/wTJ0OcGgCQFHRJzY13cFDzOe1seaj/YnYJZ4br
         OaxffCYdaNVZiNpUF8pQFEALeqIiTgbtoeequdz1zLeeQdbKZEwixjY5i0/gQEATCTia
         a/gg==
X-Gm-Message-State: AOJu0YxXJbUewxrSY7rJqKslcGRQUJtT+TvKI07Ypt8sb124FZhGEEkZ
	Hd9VzSGWy/+R5t/EGx4zT1PU6HWHdIhWum9Y6jdiYA4lAEDmpao4fQdmIjY9dRZR39FRDIN5NQ=
	=
X-Google-Smtp-Source: AGHT+IEstc5WbaKR984lcE73yhlUqY4mnQpun5Em/Dltp0yYfhzejBDQJd+oDTcw6HoRIbI7W/BkGtQg
X-Received: from wmjf4.prod.google.com ([2002:a7b:cd04:0:b0:46e:38c2:1a34])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:468e:b0:46e:4b79:551
 with SMTP id 5b1f17b1804b1-46fa9b092femr34512895e9.31.1759938425183; Wed, 08
 Oct 2025 08:47:05 -0700 (PDT)
Date: Wed,  8 Oct 2025 17:45:52 +0200
In-Reply-To: <20251008154533.3089255-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251008154533.3089255-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2401; i=ardb@kernel.org;
 h=from:subject; bh=5nhtgxb3dS2zVbgouam5e+M4Gmu5K56lN9xZqYXBI3s=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeNZe6DOTtbCqP/MvEdnNO/+dDayK/WX4sFtL+4vEJj/I
 +l81yPtjlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRyBUM/6z/Z+Z7rrJVsj3o
 NKFtdgfTrePKpyWn38q/ubvk6uoTq6UZGebIWslEbD0dYrpZ+BV3WHF94Ya0X7/LTFfJp3Rny69 v4AMA
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008154533.3089255-41-ardb+git@google.com>
Subject: [PATCH v3 18/21] arm64/xorblocks:  Switch to 'ksimd' scoped guard API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Switch to the more abstract 'scoped_ksimd()' API, which will be modified
in a future patch to transparently allocate a kernel mode FP/SIMD state
buffer on the stack, so that kernel mode FP/SIMD code remains
preemptible in principe, but without the memory overhead that adds 528
bytes to the size of struct task_struct.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/xor.h | 22 ++++++++------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
index befcd8a7abc9..c38e3d017a79 100644
--- a/arch/arm64/include/asm/xor.h
+++ b/arch/arm64/include/asm/xor.h
@@ -9,7 +9,7 @@
 #include <linux/hardirq.h>
 #include <asm-generic/xor.h>
 #include <asm/hwcap.h>
-#include <asm/neon.h>
+#include <asm/simd.h>
 
 #ifdef CONFIG_KERNEL_MODE_NEON
 
@@ -19,9 +19,8 @@ static void
 xor_neon_2(unsigned long bytes, unsigned long * __restrict p1,
 	   const unsigned long * __restrict p2)
 {
-	kernel_neon_begin();
-	xor_block_inner_neon.do_2(bytes, p1, p2);
-	kernel_neon_end();
+	scoped_ksimd()
+		xor_block_inner_neon.do_2(bytes, p1, p2);
 }
 
 static void
@@ -29,9 +28,8 @@ xor_neon_3(unsigned long bytes, unsigned long * __restrict p1,
 	   const unsigned long * __restrict p2,
 	   const unsigned long * __restrict p3)
 {
-	kernel_neon_begin();
-	xor_block_inner_neon.do_3(bytes, p1, p2, p3);
-	kernel_neon_end();
+	scoped_ksimd()
+		xor_block_inner_neon.do_3(bytes, p1, p2, p3);
 }
 
 static void
@@ -40,9 +38,8 @@ xor_neon_4(unsigned long bytes, unsigned long * __restrict p1,
 	   const unsigned long * __restrict p3,
 	   const unsigned long * __restrict p4)
 {
-	kernel_neon_begin();
-	xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
-	kernel_neon_end();
+	scoped_ksimd()
+		xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
 }
 
 static void
@@ -52,9 +49,8 @@ xor_neon_5(unsigned long bytes, unsigned long * __restrict p1,
 	   const unsigned long * __restrict p4,
 	   const unsigned long * __restrict p5)
 {
-	kernel_neon_begin();
-	xor_block_inner_neon.do_5(bytes, p1, p2, p3, p4, p5);
-	kernel_neon_end();
+	scoped_ksimd()
+		xor_block_inner_neon.do_5(bytes, p1, p2, p3, p4, p5);
 }
 
 static struct xor_block_template xor_block_arm64 = {
-- 
2.51.0.710.ga91ca5db03-goog


