Return-Path: <linux-kernel+bounces-875034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDB1C18104
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB9F1A63BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2D62EBB8A;
	Wed, 29 Oct 2025 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTmDkIZb"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9C21411DE
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761705120; cv=none; b=tLOh0Z8zX0wJAJjg1Zif6TdSD6lB+N1se+qF44LIHH6XNTvkeKFTU7w23YebuUg2W+mxf38LbWy4OWKgHvJOmR3N6/H27iVXISPuljNqw5Itelo5ut94gnj46olEw3XrDcCgbh/ePsdld6McCOSRaCLwqSUchvMS+1LM/mkiSWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761705120; c=relaxed/simple;
	bh=xAcUDyR46r3eyTpxz6DzBXXtrvoA66g03wdR/Ic7OY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sd/waB1v0er2DK/ARiheS+P6Lzjs6Dhx6K3iBFBHySmE+t8xsuvZkK7LfVnRxzW702uNPWQ8Mdgnjm7hXulMabtt7adOLW4g71tjicKxY/SY9c1UCDxbm69YfJickuWOZ3LMS0JY7VeGVJryy6G5DZ+1gMIZfl5B61NVvSJS6ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTmDkIZb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so5201984b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761705118; x=1762309918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8IHS5hbKcNzc4xX1pj2JUqHqgY0jEt1+7hP5OgmCMs=;
        b=HTmDkIZbIqs6VxB/n4OkC7hqT/7I5LA2JJoyjDlOyIxGNZgVz8gDqSyB5HKECv2bQl
         4Q2HJCIjBsJuxJ8i7Od6Y/Vdf4ChV4pBj8eYRgF/sO2QXGuQIHPanJuWOh1IPz9hGJTs
         wtafVjHVex22gUOLcty43+4Y7Xo2Rv7o4iKvLQAUscO6AFc8wBeVUDpCmsUakw6M2pN8
         n65h3ndc/5YPfvFZIcCKT1aU9COsjggoxXLD4048KVCtt/z/oaz/dwFC5guosF1kqeAu
         /iUqT2HLV10ZGZox6LRgWBWE/+SW9rsUgfxsbNurdtR8iOngVZovSWAgIfp1hBQTlhs9
         Ymfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761705118; x=1762309918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8IHS5hbKcNzc4xX1pj2JUqHqgY0jEt1+7hP5OgmCMs=;
        b=UEuUbGy4NSgbEbEwvqaEeOuKtOXynsk/bZ1fGccBaQuCxcvycMzUyZB+csepJ/rQdZ
         4oJCz3YclEIoqf5EYyb5ppwdrBArz2qIGnZRkyBT51TM7Dvxm/fZKMhyifmRzHsvVv8J
         eLa2IbOkLWRIOGJ2dArc0yu/upUtP3rveYa/R8GqyZN3hnpzwtszbLnGIhtPWNsLGBla
         XT+smlZDGRKctkiNwgSiL02nTlck598aKKibFVNMLpfdohsWrc932SxtJLZ1LjIJ/otD
         c46zfJMpu2bc5dB134+0iHJ48HbnZaAwyPwZ5SHp5zHBtv1kKGkylTeEoIXVvM8E63NH
         IhpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4MzpTBTf9YFNDY8TXnJttkQUfF6FsBvez8k362M1bJpPh3+9sEY9mhOkHsbs4DiiHqMv9c7S6N8dryUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5rSgEnZn3UJCGV08KI7rUkZssCsQKdnkVqViQN7p0pBfbneAp
	sLwAq3pI5PZaTfTFnoZFq/2wWXfNYKv0kNejviwVnOEvvRmhZsF/ghy5
X-Gm-Gg: ASbGncuHvrVLuOf1BnHlwfdOiwTj8IfeeVFaN4PIgZuDtIgvkpojALPX4B2XALVg5hy
	V4Bw7xgRw1c72W09NhgerziHlfXPp9u2D8W/ZvfFG4LJvtCTsY9XUtx2VYLrHOwlE4qUtq5qUeh
	DuiG8G4OjsbIUGmHaxo5Rk0yRpa1PJexa0Utws/VNuXizlx4Hkn9R5cutDuITB+J/QlwIESz6Vh
	mEIVNoyHXbXGBESUYS5FfCEIyCqUFjAyta3Yeni7Vt/szNmshk5uJTb2S8p5k+7JbKJIpUsEMJW
	UUdme+v/imgrjcn7x7keIbTDVXoQFmUQrwhCL00W2q6KlIxf2/hxm9a2QhzU6WwRGoFo091SVQg
	tiNxEic5ZConL0Jl4IIxbInyr7Lx1oauWXjLPz0ltST5VfQRQ9Dz/S5eBXfcL4QuGpud4TxTvvS
	souTIba/0NnXN03Fn2IXM4IQHTvdoi+TQd/jiesk9c0QWosjNLzftLjx02og==
X-Google-Smtp-Source: AGHT+IG+neopqqpPz8pE4OPY5Yo0pVr1dn6PvUKKBu7rSRz5cLkoZ3c+NU5U1HLhCN7SM0Z/zmD0cg==
X-Received: by 2002:a05:6a20:3ca7:b0:344:97a7:8c60 with SMTP id adf61e73a8af0-34651b39327mr1494729637.17.1761705117917;
        Tue, 28 Oct 2025 19:31:57 -0700 (PDT)
Received: from localhost.localdomain ([47.72.128.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81a4afsm13649518a91.19.2025.10.28.19.31.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Oct 2025 19:31:57 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Barry Song <v-songbaohua@oppo.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [RFC PATCH 1/5] arm64: Provide dcache_by_myline_op_nosync helper
Date: Wed, 29 Oct 2025 10:31:11 +0800
Message-Id: <20251029023115.22809-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251029023115.22809-1-21cnbao@gmail.com>
References: <20251029023115.22809-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

dcache_by_myline_op ensures completion of the data cache operations for a
region, while dcache_by_myline_op_nosync only issues them without waiting.
This enables deferred synchronization so completion for multiple regions
can be handled together later.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 arch/arm64/include/asm/assembler.h | 79 ++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 23be85d93348..115196ce4800 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -366,22 +366,7 @@ alternative_else
 alternative_endif
 	.endm
 
-/*
- * Macro to perform a data cache maintenance for the interval
- * [start, end) with dcache line size explicitly provided.
- *
- * 	op:		operation passed to dc instruction
- * 	domain:		domain used in dsb instruciton
- * 	start:          starting virtual address of the region
- * 	end:            end virtual address of the region
- *	linesz:		dcache line size
- * 	fixup:		optional label to branch to on user fault
- * 	Corrupts:       start, end, tmp
- */
-	.macro dcache_by_myline_op op, domain, start, end, linesz, tmp, fixup
-	sub	\tmp, \linesz, #1
-	bic	\start, \start, \tmp
-.Ldcache_op\@:
+	.macro __dcache_op_line op, start
 	.ifc	\op, cvau
 	__dcache_op_workaround_clean_cache \op, \start
 	.else
@@ -399,14 +384,54 @@ alternative_endif
 	.endif
 	.endif
 	.endif
-	add	\start, \start, \linesz
-	cmp	\start, \end
-	b.lo	.Ldcache_op\@
-	dsb	\domain
+	.endm
+
+/*
+ * Macro to perform a data cache maintenance for the interval
+ * [start, end) with dcache line size explicitly provided.
+ *
+ * 	op:		operation passed to dc instruction
+ * 	domain:		domain used in dsb instruciton
+ * 	start:          starting virtual address of the region
+ * 	end:            end virtual address of the region
+ *	linesz:		dcache line size
+ * 	fixup:		optional label to branch to on user fault
+ * 	Corrupts:       start, end, tmp
+ */
+	.macro dcache_by_myline_op op, domain, start, end, linesz, tmp, fixup
+	sub	\tmp, \linesz, #1
+	bic	\start, \start, \tmp
+.Ldcache_op\@:
+	__dcache_op_line \op, \start
+	add     \start, \start, \linesz
+	cmp     \start, \end
+	b.lo    .Ldcache_op\@
 
+	dsb	\domain
 	_cond_uaccess_extable .Ldcache_op\@, \fixup
 	.endm
 
+/*
+ * Macro to perform a data cache maintenance for the interval
+ * [start, end) with dcache line size explicitly provided.
+ * It won't wait for the completion of the dc operation.
+ *
+ * 	op:		operation passed to dc instruction
+ * 	start:          starting virtual address of the region
+ * 	end:            end virtual address of the region
+ *	linesz:		dcache line size
+ * 	Corrupts:       start, end, tmp
+ */
+	.macro dcache_by_myline_op_nosync op, start, end, linesz, tmp
+	sub	\tmp, \linesz, #1
+	bic	\start, \start, \tmp
+.Ldcache_op\@:
+	__dcache_op_line \op, \start
+	add     \start, \start, \linesz
+	cmp     \start, \end
+	b.lo    .Ldcache_op\@
+	.endm
+
 /*
  * Macro to perform a data cache maintenance for the interval
  * [start, end)
@@ -423,6 +448,20 @@ alternative_endif
 	dcache_by_myline_op \op, \domain, \start, \end, \tmp1, \tmp2, \fixup
 	.endm
 
+/*
+ * Macro to perform a data cache maintenance for the interval
+ * [start, end). It won’t wait for the dc operation to complete.
+ *
+ * 	op:		operation passed to dc instruction
+ * 	start:          starting virtual address of the region
+ * 	end:            end virtual address of the region
+ * 	Corrupts:       start, end, tmp1, tmp2
+ */
+	.macro dcache_by_line_op_nosync op, start, end, tmp1, tmp2
+	dcache_line_size \tmp1, \tmp2
+	dcache_by_myline_op_nosync \op, \start, \end, \tmp1, \tmp2
+	.endm
+
 /*
  * Macro to perform an instruction cache maintenance for the interval
  * [start, end)
-- 
2.39.3 (Apple Git-146)


