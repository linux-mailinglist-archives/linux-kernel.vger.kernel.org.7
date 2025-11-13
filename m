Return-Path: <linux-kernel+bounces-898464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FD7C55550
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6CDC4E1817
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21722BE026;
	Thu, 13 Nov 2025 01:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UYKTvH1a"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B23A2E4266
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998438; cv=none; b=sF8oEzFTFMjIwX+5vI6TqTDl5qMrGYhTXQkK6JTPvBW1jLjrdWWj/x4fOPlXKySAjO5sLlAuVlcnirRY8RBN8FMU3zVisIlG9jf9+RXpPCM3Ewf1uKpBjNIWnentgNL2i0VVBLaaUTiMJ2TRhvxbx/k0qzqih+l/CuaUGct8krM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998438; c=relaxed/simple;
	bh=kgf9Y1avYCG16k+2jIsQME77PnvA1E0FdJ9r57gO51w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0/FESDqOjz3U4fDAzJTCUEAwHHT97BNMmADy+VtwWbLHj58molZVklGvXTRTvzWlm2tSlF0OIx6arNd7Ir+qiLrEiFIwhdeVXw5CPKvpchCropkS9y3J+LISwwWETRbBwEu3lVHDHgUcyMZE9IJOWes1Cv6euduGk5hdZg+iOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UYKTvH1a; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2964d616df7so3358495ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1762998436; x=1763603236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhqbfzFBgO5voylyQ1oE0qebaNihNkFkz8eAAFF/X6s=;
        b=UYKTvH1aC/3YI6iSGCF72suUdlUaPVRoOachIMj8luGune8VFUNw8//CFLViMVnThO
         E/eV6zt0BjWK3b1oRFndk4heO+6KSn+7422rhowdwKvhlzk/yxZlOHqzoeFlQHOnzcKl
         ViBCz+18XDGZpJjiXRXTFBwmxcre17jHfEn2e66bZl7IUWkpZ0KY5Yk5xpMt8/2Qi8VV
         SuFJHuiinfE5NCNNqcbXbMEtSXkzrlfAD7cAhsscbUzTbv7R7m2YElK31ZV8BXteaZ5w
         3I9L/iHmeQDRZANNz8FVtCv2lj/OOz7aYwzKMrsVKZdmpcGMAcFmhG/nCrnlHc8zHyDS
         s9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998436; x=1763603236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FhqbfzFBgO5voylyQ1oE0qebaNihNkFkz8eAAFF/X6s=;
        b=jeIC87FVf0X8wLGOAHpY7O0mU9PkWOJvrI9N4jQG3wr6mrGbYEx9OcXNvzwZG0fWgs
         VzqoyzCWJt9v+eGK0W7fRx77E/WuzVZBRv33vOstWu0+mhWv0stdQ3xG9/GcC8wZgGVb
         Ph+tLsqN/RkHr6EjagwySJpWFlqsTlNxapxl10YpyJVNIqKi7ebPQTD1265JG4EJai75
         zyWEfNxMhncEJS6C5Gqx79Bc9FMjlhYmeqofq8wB7yBPpt3KISLncGQ4s+Xp7MalCO6K
         3ANipf/Gr6N5TJKcppy4zJ91N1kyrhJX5uquLLS0KMhCbcYcae0BTIGGIKOCD1tQfd0u
         bbZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGehjSHRT8SrEQWVjrsoxcHMZ0iEM9muOyUzG3t3KBu+Y8tTR+WrMg8O8eJSYM/3d4rLKYKkWfJQ85Y/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2por4PnAn+1yHJIM0mnJfEDnSwXRVfXQoJOnSja4123MjjmAn
	hYcDrURdlA8s3h7P6RHg+VArnwC9xqa4B182uqcjN4HRwT++WsxT3y+eXre03kruiSc=
X-Gm-Gg: ASbGncvMymwxFy4gNcNbluqw/iADVHkTZ0LbmlwbNwwid81WyhgjL8VB/6oK6teosFI
	bIM8vZSHkIpsDt0YEYpo+6UzwCWx2/3rn342+r96F2zKMdQUVakOqrS/9KfRSPL34vi/EY09rQK
	DD/kZFTd8eLrZ8iJttfm+fOMUs4/GDKxxOFiMgn9XDkPsfTiQLFdMmCljncOqYwescIrtAzxMpX
	KZHThPxCWU9Uc+bilVWsx907wYgfzeTPijdkk2n2geQAeaItOQYQWR//GeOIpxQbvDKRoChy2BC
	qy/jbw2kR0EtBYo63Xlr7EUsr28yKHGKQ1H7rSgeLJLG3YGzg6+Geh/xMNpBK6Wg0rMSMd84O5T
	uPVWW5yDKpbt056CwLKE2j2q7ncGuGa3gM+TGqHW3Ym52T98TBBYEBRnTSrEof6cdYtOx9i5ThC
	2mO3TVxfzuTvdW00Dqr0QMrER47BpuSDr1
X-Google-Smtp-Source: AGHT+IFU3ZD0WgCFLGesvoHcSqmefP/DlaLr5QtMhOO16RVbV2tzjU8K9lCg5h0K2mU/+/PVAIgbRA==
X-Received: by 2002:a17:902:fc86:b0:298:1156:acd5 with SMTP id d9443c01a7336-2984edcaeccmr67224805ad.39.1762998435872;
        Wed, 12 Nov 2025 17:47:15 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccae8sm4986485ad.98.2025.11.12.17.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:47:15 -0800 (PST)
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
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 11/22] riscv: mm: Simplify set_p4d() and set_pgd()
Date: Wed, 12 Nov 2025 17:45:24 -0800
Message-ID: <20251113014656.2605447-12-samuel.holland@sifive.com>
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

RISC-V uses the same page table entry format and has the same atomicity
requirements at all page table levels, so these setter functions use the
same underlying implementation at all levels. Checking the translation
mode to pick between two identical branches only serves to make these
functions less efficient.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - New patch for v2

 arch/riscv/include/asm/pgtable-64.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 6e789fa58514..5532f8515450 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -275,10 +275,7 @@ static inline unsigned long _pmd_pfn(pmd_t pmd)
 
 static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
-	if (pgtable_l4_enabled)
-		WRITE_ONCE(*p4dp, p4d);
-	else
-		set_pud((pud_t *)p4dp, (pud_t){ p4d_val(p4d) });
+	WRITE_ONCE(*p4dp, p4d);
 }
 
 static inline int p4d_none(p4d_t p4d)
@@ -342,10 +339,7 @@ pud_t *pud_offset(p4d_t *p4d, unsigned long address);
 
 static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
-	if (pgtable_l5_enabled)
-		WRITE_ONCE(*pgdp, pgd);
-	else
-		set_p4d((p4d_t *)pgdp, (p4d_t){ pgd_val(pgd) });
+	WRITE_ONCE(*pgdp, pgd);
 }
 
 static inline int pgd_none(pgd_t pgd)
-- 
2.47.2


