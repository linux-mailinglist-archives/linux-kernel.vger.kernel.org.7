Return-Path: <linux-kernel+bounces-879974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE351C24895
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6365E4F1BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA613451D1;
	Fri, 31 Oct 2025 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bxorp0jE"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687EE3431F8
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907197; cv=none; b=qidt/hjMxMov/u0dWr2ygVJ26OyPD6m/iGCDQ+SSaMX59hA/cJ45ALjo665XVh6FdP2McJH4RtPSpdjtTooJ2RZ1nZDsRKWKn2fLzYUvzJbS0TbPU26PfeDh6GQAUUn0/JvfoR2VgVuic85REx0mN8DCit3KmSB1MvTwXyhTXzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907197; c=relaxed/simple;
	bh=WgYwOMvlr+zTqk1uI7p2SkyIbQb6yGgF7pl0TkawgU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yzp7EpZrA38beIYk/yhMCgIcQ5a1bdErcIUEHWnIXA6p5OKtHgR9ij9GyQsLZbDDOcR902p7n0eShBphEijrBgyJr40w+pJflZE/QoPxeqhljwr1zDjfdtOE9Ny2gfkKNRLIejR7RNdjWeUS4CksXsVBoXmbx8HwswgdeLKM7bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bxorp0jE; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-427027a2095so1243226f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761907193; x=1762511993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e4RjkuRbzhzq+DbHCUcTmZHT9d6t7fanSTph/M7FrwM=;
        b=bxorp0jEoyaSuqrX2Wt2htp89/+f/W5w5ZngpeHeTsh01pTANNzTMDogcf7B3yK00W
         JnvE94VuqTDnkWbSJeopKcKqISYlRhIBBBnwC3bmPHjeFn3ijc9/6vosWEMhE7ftllx1
         DoJaK7cpTSedS+e2J6M7WZo82mKHGZMQSF8W5boONC2FTyELoWylX3DgKCvbv5S31nUg
         YPxfvusQmS0O8F1d/3i6I1TMeDTT3zVQhEGzE5zifySO4tVYR415R/SR0D81kZi/l4/j
         hrCpi5Cjzr7hQx4c0jdt8iKze/SrQFEQCT0MavMWwRolBSvGNi4wv6p4Nz6LeYLS7c5s
         c6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907193; x=1762511993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4RjkuRbzhzq+DbHCUcTmZHT9d6t7fanSTph/M7FrwM=;
        b=EFvA/89SsAHipW1qgNZbos5iDffsWwVohK7FI3d1FDnkFxKdWHG8P+iXC4c4gRhFsx
         SwAvA1cbreG2f/IbX2HO/t7Rmg0P8a2OMBLu1NpblF8PhcAPdPCTOxh6e9dl4X//L1dX
         IpzOpmK1kBqpoG5vlspYoZLCzCiBh3trgchYR7ZKAoYQ56OcOZ5PX/Tr0m+DV1+wfSJd
         arUNTKLyjRUYuTYxymFQ6DpYwKye0tLg7AP7I0Ypk+VqNLIrhfeRkpOTXRA4lXqUndHW
         EawJfUJxIOPaRJ+KH1gclnLzavhyAsMvhHUKHiTlVC2zBvgTlqWNPvICi0Eg1EXAVfq2
         WZug==
X-Gm-Message-State: AOJu0YzRhHg1xj+4ajjEH4U8U1afJTnb5e5sxgLJANgHeC5hdC7Mmp32
	sreF85n6/Jf7WiNTMw67KtKdoF71JlyyQRZ0Bbk4BbSsHphOX3tvyDUl1xL8YskNMGo9/PrqXw=
	=
X-Google-Smtp-Source: AGHT+IHVOvUG0Xu/U72ITBOpdefU2DBxMkwXD2QsdxXRJMDjdqSoWxzPqoXGu/4sUXEGYRcoh2Hw1odT
X-Received: from wrbdz17.prod.google.com ([2002:a05:6000:e91:b0:429:8bd5:a979])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4813:b0:429:89c2:d933
 with SMTP id ffacd0b85a97d-429bd6a661bmr2703069f8f.36.1761907192812; Fri, 31
 Oct 2025 03:39:52 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:39:06 +0100
In-Reply-To: <20251031103858.529530-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031103858.529530-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3233; i=ardb@kernel.org;
 h=from:subject; bh=iSbN4ekVGltGzQmP5pLZ+bG2pN1WnvqNrOwI0kB4C8o=;
 b=kA0DAAoWMG4JVi59LVwByyZiAGkEkc3IqxaPccg6BBv5hnkGx/1bCaULY/XwigMLrW1nDGA+l
 Yh1BAAWCgAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmkEkc0ACgkQMG4JVi59LVzG4QEAoaIi
 zu37MoBFQRoBZZ+yZD5/L9uJT55ZFas0kEqcoTgBANiP73S3Ww/wj+Epar2f+78g93ZAI/f4ta1 oEhX9xoUH
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031103858.529530-30-ardb+git@google.com>
Subject: [PATCH v4 07/21] raid6: Move to more abstract 'ksimd' guard API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Move away from calling kernel_neon_begin() and kernel_neon_end()
directly, and instead, use the newly introduced scoped_ksimd() API. This
permits arm64 to modify the kernel mode NEON API without affecting code
that is shared between ARM and arm64.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 lib/raid6/neon.c       | 17 +++++++----------
 lib/raid6/recov_neon.c | 15 ++++++---------
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/lib/raid6/neon.c b/lib/raid6/neon.c
index 0a2e76035ea9..6d9474ce6da9 100644
--- a/lib/raid6/neon.c
+++ b/lib/raid6/neon.c
@@ -8,10 +8,9 @@
 #include <linux/raid/pq.h>
 
 #ifdef __KERNEL__
-#include <asm/neon.h>
+#include <asm/simd.h>
 #else
-#define kernel_neon_begin()
-#define kernel_neon_end()
+#define scoped_ksimd()
 #define cpu_has_neon()		(1)
 #endif
 
@@ -32,10 +31,9 @@
 	{								\
 		void raid6_neon ## _n  ## _gen_syndrome_real(int,	\
 						unsigned long, void**);	\
-		kernel_neon_begin();					\
-		raid6_neon ## _n ## _gen_syndrome_real(disks,		\
+		scoped_ksimd()						\
+			raid6_neon ## _n ## _gen_syndrome_real(disks,	\
 					(unsigned long)bytes, ptrs);	\
-		kernel_neon_end();					\
 	}								\
 	static void raid6_neon ## _n ## _xor_syndrome(int disks,	\
 					int start, int stop, 		\
@@ -43,10 +41,9 @@
 	{								\
 		void raid6_neon ## _n  ## _xor_syndrome_real(int,	\
 				int, int, unsigned long, void**);	\
-		kernel_neon_begin();					\
-		raid6_neon ## _n ## _xor_syndrome_real(disks,		\
-			start, stop, (unsigned long)bytes, ptrs);	\
-		kernel_neon_end();					\
+		scoped_ksimd()						\
+			raid6_neon ## _n ## _xor_syndrome_real(disks,	\
+				start, stop, (unsigned long)bytes, ptrs);\
 	}								\
 	struct raid6_calls const raid6_neonx ## _n = {			\
 		raid6_neon ## _n ## _gen_syndrome,			\
diff --git a/lib/raid6/recov_neon.c b/lib/raid6/recov_neon.c
index 70e1404c1512..9d99aeabd31a 100644
--- a/lib/raid6/recov_neon.c
+++ b/lib/raid6/recov_neon.c
@@ -7,11 +7,10 @@
 #include <linux/raid/pq.h>
 
 #ifdef __KERNEL__
-#include <asm/neon.h>
+#include <asm/simd.h>
 #include "neon.h"
 #else
-#define kernel_neon_begin()
-#define kernel_neon_end()
+#define scoped_ksimd()
 #define cpu_has_neon()		(1)
 #endif
 
@@ -55,9 +54,8 @@ static void raid6_2data_recov_neon(int disks, size_t bytes, int faila,
 	qmul  = raid6_vgfmul[raid6_gfinv[raid6_gfexp[faila] ^
 					 raid6_gfexp[failb]]];
 
-	kernel_neon_begin();
-	__raid6_2data_recov_neon(bytes, p, q, dp, dq, pbmul, qmul);
-	kernel_neon_end();
+	scoped_ksimd()
+		__raid6_2data_recov_neon(bytes, p, q, dp, dq, pbmul, qmul);
 }
 
 static void raid6_datap_recov_neon(int disks, size_t bytes, int faila,
@@ -86,9 +84,8 @@ static void raid6_datap_recov_neon(int disks, size_t bytes, int faila,
 	/* Now, pick the proper data tables */
 	qmul = raid6_vgfmul[raid6_gfinv[raid6_gfexp[faila]]];
 
-	kernel_neon_begin();
-	__raid6_datap_recov_neon(bytes, p, q, dq, qmul);
-	kernel_neon_end();
+	scoped_ksimd()
+		__raid6_datap_recov_neon(bytes, p, q, dq, qmul);
 }
 
 const struct raid6_recov_calls raid6_recov_neon = {
-- 
2.51.1.930.gacf6e81ea2-goog


