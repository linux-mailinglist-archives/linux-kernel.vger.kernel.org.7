Return-Path: <linux-kernel+bounces-898469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B4BC55583
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F3E3B74B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7349E2F12D1;
	Thu, 13 Nov 2025 01:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AGcW9K25"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E649F2EDD53
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998445; cv=none; b=R6rsDtgKIdbImONkXHs39TvIlQl8o6cN5+3NONJrgjNd3fuYVQucHUzPVPd7Q5s14kiqX6fGpoKx/P0dGea+nVM7lUTRkjZy+H2fs0NxjPaeP9oDJMmmVGyuI/ap1If4BEPRRZGdDOjDy+CnmEX4Wo86E7H2pwft8CJlRfmV41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998445; c=relaxed/simple;
	bh=j2BJ9jr3qIUwMRtdlyMGrTsEOHKt3SRkyCv8EtD9ZFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ur+Qd753bCeuKW+5aSsrWEvummBlBuzN2PgmqnS4PccSKOc+0IARSNrLY3AObLpRv9qJqSeXt5a4mpFDmu5yyuCadnTyvkE+4S75ezPZGS4IbZIOYCwH1HSDZEjqh5Digp2w+zWGpkvfesB4zmYpFOP7uS20Ni/sPz1RPsIMCv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=AGcW9K25; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2958db8ae4fso2531245ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1762998443; x=1763603243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tvwsP9vvABxxjFo83LMGwuoc9gJFKDbkPSolQxDxUQ=;
        b=AGcW9K25p81VD0iyTlU6hxyJKK2N6fkXXBta+RUtyWRb0NUUsuSxHJS9AcZqBJBCXJ
         xQUXrwkIN4nbkPCwGYzAOBes8Flz29a18+doreBELPdOy9LCab4vc99GKW4LLalZTz3A
         9c71PlNd4w1aDbh/DC/+Cdbw7l3FFuJpMrPV4fnIkm4nmsuNZOZoN7oPbiw8pRhcaVK3
         k7o984G76ceF4mQtDjJDq4v+3CVZKSlG5fJ3xZZ5if9E3j64J4gPybVBMGxWM4WIHc9d
         9FhRQIdXg/EymsUPQRwYia9Ahy0+5IZJ8R70C3hpWhoyqA6hD50wX8hUAQcgU9u15hID
         AJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998443; x=1763603243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3tvwsP9vvABxxjFo83LMGwuoc9gJFKDbkPSolQxDxUQ=;
        b=KHYRXKnu1pyjZLXolzqArw2bsbQj9iGw3rX9Jq506LbUq+qlIz9xaAoFsBW7lHiUkX
         5BA2L1hON1yJzbOAWeIDk7ym8P6atqLlB9M7zM3cxwz3SS/LKMlUA/bXnPv0YpKRl6mM
         5Sikl94k9WLUTQpogpaDYoArMUw20SueecBtAhk6PlUKpcDklzGJBTBi6CmlLlthOV+n
         xldVbYhrtiLs0KXWxn1GlGT40Q1gwhypqF0dtN63lzkgRv6hxHLARrwd0ge9UWVa52P9
         c6pxtc3/Lu07SCznh6rb5k/Ms2TDrIMQeH3CUWrbg/Is1X2wHKL6PEHVTn6kUYG5xuHJ
         bAng==
X-Forwarded-Encrypted: i=1; AJvYcCXk7MgnVRb7F6PpdoV0gPz3I2td93+Q2JAxtadNVonYYvBHn4Alf/S4p/F2XQE1KBdXUU8WQmocdwOiQ+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBlDFoDfpk2KOZn4X2tUVivTaqCFYMv0IxFASPLsarDI/51Bss
	HksIRQb1serqNVfAr8xgSSXFY/EfB7FEID1+Ue8JP7j2hAer30KzMBOLWDGPg+cMEn0=
X-Gm-Gg: ASbGncterpCrnobmGILBmIcF4OpL2Aa9Lg1oPQ5BzWWyAzKB7xAqjNvECKbwycfm1BK
	30AR52yHhEp+3xRFDXhKnNE+HO8zZbUGTq0y7WQn6q0jFcMvvUi+qxTEYNBm7zO8op6UUBKtYn1
	yNTDHWtkktayBPiy5T1m0gp/fokAa4laCl8n39otW6q5HMU2BQKaxckoMH78sv2BacvhopDVyrX
	7S+4xwG2DEqoSpceCbXW5fwnbSZYIsUaQBZHqrJ87WNbkRVDAnxFHhQo95ruo33Ra5HVuNyfZUS
	1mvmuPW5mAN1AOokYLlORcvctuD8Qo5s47BzOZfYc9BipCpUCW25GCBrtGPNN3B1RM7TIhFa5NU
	5rA7UDYImU8qu2fBzukVks3W1qjDWiy/DjcFGOEbXtiv0nIszuIoOUyQLNvBV2yIoui9Bh3mg1O
	nqu1Sq0Mr2i740necNaUw/eQ==
X-Google-Smtp-Source: AGHT+IEzjGNl3Wyy3hzWqL7on4A+1Kg8RojXA788MVa4vlvrwXnh7VKjWrR3/ZaKHRkhd2fy7O+m8w==
X-Received: by 2002:a17:902:d4c8:b0:297:f8d9:aae9 with SMTP id d9443c01a7336-2984edde647mr68226655ad.51.1762998443331;
        Wed, 12 Nov 2025 17:47:23 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccae8sm4986485ad.98.2025.11.12.17.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:47:23 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: devicetree@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Conor Dooley <conor@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v3 16/22] riscv: alternative: Add an ALTERNATIVE_3 macro
Date: Wed, 12 Nov 2025 17:45:29 -0800
Message-ID: <20251113014656.2605447-17-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251113014656.2605447-1-samuel.holland@sifive.com>
References: <20251113014656.2605447-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ALT_FIXUP_MT() is already using ALTERNATIVE_2(), but it needs to be
extended to handle a fourth case. Add ALTERNATIVE_3(), which extends
ALTERNATIVE_2() with another block of new content.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - Fix erroneously-escaped newline in assembly ALTERNATIVE_CFG_3 macro

 arch/riscv/include/asm/alternative-macros.h | 45 ++++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
index 9619bd5c8eba..e8bf384da5c2 100644
--- a/arch/riscv/include/asm/alternative-macros.h
+++ b/arch/riscv/include/asm/alternative-macros.h
@@ -50,8 +50,17 @@
 	ALT_NEW_CONTENT \vendor_id_2, \patch_id_2, \enable_2, "\new_c_2"
 .endm
 
+.macro ALTERNATIVE_CFG_3 old_c, new_c_1, vendor_id_1, patch_id_1, enable_1,	\
+				new_c_2, vendor_id_2, patch_id_2, enable_2,	\
+				new_c_3, vendor_id_3, patch_id_3, enable_3
+	ALTERNATIVE_CFG_2 "\old_c", "\new_c_1", \vendor_id_1, \patch_id_1, \enable_1 \
+				    "\new_c_2", \vendor_id_2, \patch_id_2, \enable_2
+	ALT_NEW_CONTENT \vendor_id_3, \patch_id_3, \enable_3, "\new_c_3"
+.endm
+
 #define __ALTERNATIVE_CFG(...)		ALTERNATIVE_CFG __VA_ARGS__
 #define __ALTERNATIVE_CFG_2(...)	ALTERNATIVE_CFG_2 __VA_ARGS__
+#define __ALTERNATIVE_CFG_3(...)	ALTERNATIVE_CFG_3 __VA_ARGS__
 
 #else /* !__ASSEMBLER__ */
 
@@ -98,6 +107,13 @@
 	__ALTERNATIVE_CFG(old_c, new_c_1, vendor_id_1, patch_id_1, enable_1)	\
 	ALT_NEW_CONTENT(vendor_id_2, patch_id_2, enable_2, new_c_2)
 
+#define __ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, patch_id_1, enable_1,	\
+				   new_c_2, vendor_id_2, patch_id_2, enable_2,	\
+				   new_c_3, vendor_id_3, patch_id_3, enable_3)	\
+	__ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, patch_id_1, enable_1,	\
+				   new_c_2, vendor_id_2, patch_id_2, enable_2)	\
+	ALT_NEW_CONTENT(vendor_id_3, patch_id_3, enable_3, new_c_3)
+
 #endif /* __ASSEMBLER__ */
 
 #define _ALTERNATIVE_CFG(old_c, new_c, vendor_id, patch_id, CONFIG_k)	\
@@ -108,6 +124,13 @@
 	__ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, patch_id_1, IS_ENABLED(CONFIG_k_1),	\
 				   new_c_2, vendor_id_2, patch_id_2, IS_ENABLED(CONFIG_k_2))
 
+#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, patch_id_1, CONFIG_k_1,		\
+				  new_c_2, vendor_id_2, patch_id_2, CONFIG_k_2,		\
+				  new_c_3, vendor_id_3, patch_id_3, CONFIG_k_3)		\
+	__ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, patch_id_1, IS_ENABLED(CONFIG_k_1),	\
+				   new_c_2, vendor_id_2, patch_id_2, IS_ENABLED(CONFIG_k_2),	\
+				   new_c_3, vendor_id_3, patch_id_3, IS_ENABLED(CONFIG_k_3))
+
 #else /* CONFIG_RISCV_ALTERNATIVE */
 #ifdef __ASSEMBLER__
 
@@ -118,11 +141,17 @@
 #define __ALTERNATIVE_CFG(old_c, ...)		ALTERNATIVE_CFG old_c
 #define __ALTERNATIVE_CFG_2(old_c, ...)		ALTERNATIVE_CFG old_c
 
+#define _ALTERNATIVE_CFG_3(old_c, ...)	\
+	ALTERNATIVE_CFG old_c
+
 #else /* !__ASSEMBLER__ */
 
 #define __ALTERNATIVE_CFG(old_c, ...)		old_c "\n"
 #define __ALTERNATIVE_CFG_2(old_c, ...)		old_c "\n"
 
+#define _ALTERNATIVE_CFG_3(old_c, ...)	\
+	__ALTERNATIVE_CFG(old_c)
+
 #endif /* __ASSEMBLER__ */
 
 #define _ALTERNATIVE_CFG(old_c, ...)		__ALTERNATIVE_CFG(old_c)
@@ -147,15 +176,21 @@
 	_ALTERNATIVE_CFG(old_content, new_content, vendor_id, patch_id, CONFIG_k)
 
 /*
- * A vendor wants to replace an old_content, but another vendor has used
- * ALTERNATIVE() to patch its customized content at the same location. In
- * this case, this vendor can create a new macro ALTERNATIVE_2() based
- * on the following sample code and then replace ALTERNATIVE() with
- * ALTERNATIVE_2() to append its customized content.
+ * Variant of ALTERNATIVE() that supports two sets of replacement content.
  */
 #define ALTERNATIVE_2(old_content, new_content_1, vendor_id_1, patch_id_1, CONFIG_k_1,		\
 				   new_content_2, vendor_id_2, patch_id_2, CONFIG_k_2)		\
 	_ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1, patch_id_1, CONFIG_k_1,	\
 					new_content_2, vendor_id_2, patch_id_2, CONFIG_k_2)
 
+/*
+ * Variant of ALTERNATIVE() that supports three sets of replacement content.
+ */
+#define ALTERNATIVE_3(old_content, new_content_1, vendor_id_1, patch_id_1, CONFIG_k_1,		\
+				   new_content_2, vendor_id_2, patch_id_2, CONFIG_k_2,		\
+				   new_content_3, vendor_id_3, patch_id_3, CONFIG_k_3)		\
+	_ALTERNATIVE_CFG_3(old_content, new_content_1, vendor_id_1, patch_id_1, CONFIG_k_1,	\
+					new_content_2, vendor_id_2, patch_id_2, CONFIG_k_2,	\
+					new_content_3, vendor_id_3, patch_id_3, CONFIG_k_3)
+
 #endif
-- 
2.47.2


