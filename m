Return-Path: <linux-kernel+bounces-846146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D69EBC7267
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 03:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF57F4F2AEE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF701E9B1A;
	Thu,  9 Oct 2025 01:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Nlm8f60g"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8131819C566
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975136; cv=none; b=eUujaqq+iq4OF3Cm8qFfbDBuUFknK8SQTigGKoka9cd0i+Gj+18l9YRH3NI8p56N0jKFDQ5+zvwqCxsK7L0hLahKN7NA2XSvzzt3S43wTjQoHm3G5gjQ3NTRHnZSBz0urCefsgz6azNEhZYHjTLb8iDlY/tMbNDbYs6/rRPYe2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975136; c=relaxed/simple;
	bh=B+hlWYQ373hjO9SpfVlMPTai5uiOn1pNvN2tfFFSltQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdhPargPNbanydPuflSABxXnUkx2pn97vkyDW1A1TTtq9lRLORQnGnXXwMicWCgNf2/tUHnx+sM7EF/LjXagRvkRI88fl7mi4juFMavJxzElgUoIAsNUBGQ3SnmfGH+7LPIuam8fMbVdPJd+Qk31LwA24OMArOX6u+62FbAXH/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Nlm8f60g; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-78af9ebe337so324507b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759975131; x=1760579931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MxHL3qUwy+t0aO6eARfxrO+qA5Rm8YXQr0n5njGXfs=;
        b=Nlm8f60g8LL8fbLO95zt25t+WGp92eH3rU4f+UnVgZILIic/PZ5GOoBZfpStVHm5l0
         UStlxdtJ7r11NqHxN7kk2Sj3LVpxUO7pBrpdEDXkiaem9lhi+cdUmga1y0RuDnOMSX13
         HK19IuNpzeal6eTsFNJNvHYVt8d59Kph1tElz8m8zbkReDFeFjMu5mpD4lscM068aCPl
         eQhkJwlWVju2WAQYHZdrkaNMZgpoC576m1gNKRZezJUGxSQNzibLmNkmPvp4QS/9PWEL
         HSq5d3URS/choGNMABaDrcEvOVZY1UwuHVWDWtrzTewA8bxryuXflgiduM5xaWGal2yH
         AzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975131; x=1760579931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MxHL3qUwy+t0aO6eARfxrO+qA5Rm8YXQr0n5njGXfs=;
        b=IVxXQfcUNHaVSyHIKw3mh6GpvSa8pe4JKcsYdei0LFYpFkelWdvO51TrZ34e46C3lT
         8bgXGuoAaa9ExvbUzkvVL2hl49gpc5I28x0zHqxAbPHnT+vqoGZNJmk8uEB2L+nIQyK7
         oGNYYyTGlLbaKideXQghiudRdx9PR6Ndydh4XHLNQxNMEZuUI2Yl8U4av6UPicnvkQRK
         U1N9mq3OnQWVoFijh7NjQ4mYDEUz5mALKvnMn7UtT8G14CGw8d9rlyPg+O4W/qgzkCyg
         awrWFGIQBqsbQg/Dmx/8E5u9sKsc2TnhphB6rQMiAFRC3KDw4jig9+NHI3RYxOkd9G3e
         v+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGC3IxQRJV2BrEtoMsm+FWDksdr3zsIIMUH+c0MwAKgXI7kT0u2fPVoT8dGETuvD3Cy5ZYEiYMe9N27mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAiMknYfT46LAnnRPt6Eg6IJ87Ib8pHhF+dQBKFcfDbn9s6WYh
	CVy2b9A7eM+l6zqgbkA5ixqAnH1GQifMdaJAdGAKgN4FPWrx21pwhTZu+uRpbmrKChQ=
X-Gm-Gg: ASbGncuS4OdxtUXw/bhZ+5qeqkiDPEv+3WKJ6BJ7H6+E9A5yH1uuSjowbhZGweQJLY+
	hez01l6WkR6CAW2zZWyVh4eJVNnB9UKT8KEtt3C2w1uN7tJ/MbSBSz9R+wIQhE3YuYVuxYQvLSI
	nVDolT9grsMc9mQad5WGEgpIbG5DZ3iy+JxaHNWfGbHu1c2IDjDXMQD+vutpfnyZi4yChYWuU9t
	OijSC8ghmeCzxsyunuyA3FQkLiJH71UqAGxNSyXJu1lv4TzSU0mn4IYUk12MIlVBE89OtW1FHen
	7vXnRDkWo9taUGmZzCAi6RCzWE64RmZb/n2SR1zwAAt9Gr6HPpXuylrED8wE8RhLhmAYJwuJQ9m
	I/S+61J+dNkgtk3FU9C/sKXfvrHBLsyxOw9SQ+gs7V8e0tL/tPy89mbwozYHWvwdpWzeO
X-Google-Smtp-Source: AGHT+IFWANPjuzJhuuxubYaVO2GJhHx+Uq0HfBlhgHOgbCi5OPe5NLGhSbpBSxbnLiNpsX7PUf8iug==
X-Received: by 2002:a17:902:d592:b0:240:48f4:40f7 with SMTP id d9443c01a7336-290273edf23mr67433045ad.39.1759975130859;
        Wed, 08 Oct 2025 18:58:50 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de53f9sm11033585ad.14.2025.10.08.18.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:58:50 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Conor Dooley <conor@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 08/18] riscv: mm: Simplify set_p4d() and set_pgd()
Date: Wed,  8 Oct 2025 18:57:44 -0700
Message-ID: <20251009015839.3460231-9-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251009015839.3460231-1-samuel.holland@sifive.com>
References: <20251009015839.3460231-1-samuel.holland@sifive.com>
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

Changes in v2:
 - New patch for v2

 arch/riscv/include/asm/pgtable-64.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 1018d22169013..7eb23c24310f9 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -273,10 +273,7 @@ static inline unsigned long _pmd_pfn(pmd_t pmd)
 
 static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
-	if (pgtable_l4_enabled)
-		WRITE_ONCE(*p4dp, p4d);
-	else
-		set_pud((pud_t *)p4dp, (pud_t){ p4d_val(p4d) });
+	WRITE_ONCE(*p4dp, p4d);
 }
 
 static inline int p4d_none(p4d_t p4d)
@@ -340,10 +337,7 @@ pud_t *pud_offset(p4d_t *p4d, unsigned long address);
 
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


