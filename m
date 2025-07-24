Return-Path: <linux-kernel+bounces-745084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46392B114AF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237C41CE3D82
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206B4242D90;
	Thu, 24 Jul 2025 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Q5LVhvBs"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED18C23FC66
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400229; cv=none; b=c2BQq5AgfMVDL3GGWzS1/wakjdFFc9wAWqjEHk/mZ5LCbgLYJl2QBgIWMYSDeECQjoQjXMeBo7bCU00jfxD3ta2kzKmXj+F3x/ZrPd2LcMGLN2VNk0QSd7rKhFAk5WpbC7eKdja660aLjw0uT70YasMkZt5eFwzKRa0AogDSQNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400229; c=relaxed/simple;
	bh=5N5m8xOH14VHtqk63znJyJZdTgix/MtEnLNiozKJxiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dV0Lt9dXpxwPS3WcD4IxTwjggZacqL29TQtZ+sYBIvqY9laR12XlviRDFqhcpumCNxvYsmfashNJLCABO7/72Bx3kRL7EZWkH5rnCl2Q9GZrh906gvReVzm2wC3asJTEGsvb6ENoE1umX0+FZSPc1SCDWaGHw1u4bs38Xmzty7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Q5LVhvBs; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23c703c471dso27066565ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753400227; x=1754005027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krQk4P3pfTRPUT5p9FwZ7J0ulZx2x20Cletpatu8lvU=;
        b=Q5LVhvBs+qhnFZIgtPZOEMT9JgA/GdDYxvtnf4K147iIQ/3nXcSWYP0d9gkIvqh5h3
         m/sVeDX/t6VY+1eakbS6748ybp3Bg1KBBTEsvc4mb4sUGo6bSJ8syJok2naxmSCiA4MO
         JEkYyTz2sWibFhlGOEbKRWjJdnSEK/Lo5klHjAVvdq5ZjhXwyv4jQB+/KgtEQAOskM6C
         kbVJ1PkGRBZxW+eL/8pB91isTQI4FMt+2rKSqfvtCnEefjTurqR6JM/844FP9tz5lH9I
         VWoUBCJwHH02J1MHh5KYnxK/FSoeK7C2nXEnOxyjx7V7avO74ka84pB+NT7ETylAoMQl
         b3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753400227; x=1754005027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krQk4P3pfTRPUT5p9FwZ7J0ulZx2x20Cletpatu8lvU=;
        b=V1TR6FX0i0qbjsISMSM9Ut1fxPJQkN9BHUk2jjcwrHzgyo7haA4fcz1NS3hR4pqcYt
         JCo7ipaFg4LbLbf1dUFjFU8Yj8Fn4yJ/NrG73qpY0E3v/6xx7U0udYdkJVHpPn7X2YNT
         Bzy8zsdW5KXSGXwFcXRNyXNOwXWBba/9hNy8hMkOSw3k81omqZ2rjrKYr5/Hurua5jH2
         o+dWxTRjlxpUl0neG7JgYcCETDLEFEzzBR868YzdQTvFMA1KASOOgMnVw/+vyQpxIgeZ
         EpR6cP3CO0DYaCbayDcET9TUG7wiOyeKfZrs6lEp3M/2Y4Nmtb8es83SoSv0YHTz/D3q
         qNIg==
X-Forwarded-Encrypted: i=1; AJvYcCXxYXNEbKbIxnCQ13u1HNEYgIYLi8ZQSBa5goxgLuQ0pw3uDn+25G2paw9MTDDsTe2wALDd2sqmt9lkYM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXG9VC99IkHG6YWpp2KUuNvYQRJfeCSkSMchKtEb5DK9uiS20q
	vVI9UEPpddr9p+sRbmS/boMIoTpxNxjoS3Q5aEtFiMByExs8ZlQzhRPRPz23cxDFGXg=
X-Gm-Gg: ASbGncvCw6W8Ix/9j8ZsXYA6mzny09XFTTFyUGp71RuedYkB++7dvfRSBGy7/Dn1p44
	XLpIEBY+U+cuX5z+VwkrZXe0Ej7gYU4AJ5kQ7S/DgfhkXW7hTC818Rl1O5KDx3O1W1mOmYeJCVN
	J5kfGvYOPvxUJbgQgmRI+CIOm/Tq/P+PH7jPQ+46F0JvvRIMDWBLgA5XETWOfPg6RjNN5fISqVY
	wcCnvxm6kB4+KwGgdLjgSSgCMPR4MGOweVab34Efkq2YOAn8+yIoOq/n/Mu2/PP4UskfFPnmrBW
	0VwNMY0/eU6mlDNfWl+c4vu6Hbhlv4Pn4kQ3SmLxu0B5t2gVT3hwTex87SOPXoJSN9bOoJMudpG
	JDUcZ+X3J6qDst5zbgjXKPkuMJbOIh7k6
X-Google-Smtp-Source: AGHT+IHqqHjkrV1Y0AgUE/7okEjKgN0Xu4SqOAlTzo93EMsg5xWeC1nRyl3GBDs9U3ql1blBgoSqFg==
X-Received: by 2002:a17:902:ebc5:b0:23f:a1b5:e537 with SMTP id d9443c01a7336-23fa5ce4bf8mr55592815ad.3.1753400227208;
        Thu, 24 Jul 2025 16:37:07 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc706sm23598685ad.106.2025.07.24.16.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 16:37:06 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Jul 2025 16:36:54 -0700
Subject: [PATCH 01/11] riscv: add landing pad for asm routines.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-riscv_kcfi-v1-1-04b8fa44c98c@rivosinc.com>
References: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
In-Reply-To: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Monk Chiang <monk.chiang@sifive.com>, 
 Kito Cheng <kito.cheng@sifive.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev, 
 rick.p.edgecombe@intel.com, broonie@kernel.org, cleger@rivosinc.com, 
 samitolvanen@google.com, apatel@ventanamicro.com, ajones@ventanamicro.com, 
 conor.dooley@microchip.com, charlie@rivosinc.com, samuel.holland@sifive.com, 
 bjorn@rivosinc.com, fweimer@redhat.com, jeffreyalaw@gmail.com, 
 heinrich.schuchardt@canonical.com, andrew@sifive.com, ved@rivosinc.com, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

SYM_* macros are used to define assembly routines. In this patch series,
re-define those macros in risc-v arch specific include file to include
a landing pad instruction at the beginning. This is done only when the
compiler flag for landing pad is enabled (i.e. __riscv_zicfilp).

TODO: Update `lpad 0` with `lpad %lpad_hash(name)` after toolchain
support.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/linkage.h | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/riscv/include/asm/linkage.h b/arch/riscv/include/asm/linkage.h
index 9e88ba23cd2b..162774b81158 100644
--- a/arch/riscv/include/asm/linkage.h
+++ b/arch/riscv/include/asm/linkage.h
@@ -6,7 +6,49 @@
 #ifndef _ASM_RISCV_LINKAGE_H
 #define _ASM_RISCV_LINKAGE_H
 
+#ifdef __ASSEMBLY__
+#include <asm/assembler.h>
+#endif
+
 #define __ALIGN		.balign 4
 #define __ALIGN_STR	".balign 4"
 
+#ifdef __riscv_zicfilp
+/*
+ * A landing pad instruction is needed at start of asm routines
+ * re-define macros for asm routines to have a landing pad at
+ * the beginning of function. Currently use label value of 0x1.
+ * Eventually, label should be calculated as a hash over function
+ * signature.
+ */
+#define SYM_FUNC_START(name)				\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
+	lpad 0;
+
+#define SYM_FUNC_START_NOALIGN(name)			\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
+	lpad 0;
+
+#define SYM_FUNC_START_LOCAL(name)			\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)	\
+	lpad 0;
+
+#define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
+	lpad 0;
+
+#define SYM_FUNC_START_WEAK(name)			\
+	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)	\
+	lpad 0;
+
+#define SYM_FUNC_START_WEAK_NOALIGN(name)		\
+	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
+	lpad 0;
+
+#define SYM_TYPED_FUNC_START(name)				\
+	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
+	lpad 0;
+
+#endif
+
 #endif /* _ASM_RISCV_LINKAGE_H */

-- 
2.43.0


