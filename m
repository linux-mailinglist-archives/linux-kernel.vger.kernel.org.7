Return-Path: <linux-kernel+bounces-898457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D1EC55523
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59AB83A4710
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E012D7DE9;
	Thu, 13 Nov 2025 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KG7OcXl7"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA62D323F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998427; cv=none; b=Lhs0WcMxZoNs2ewZTyvMtAGw0CqaUZRTC8SCql5bviYQNGCjXacdX0zj0Xgv0AhpRQvRBgs0OeKwDwo79K2YIZmWG0P9nFMXKbM4a26AOc9N2xBS0M55cRMZcCkKJIn9poxceWwk1mXzBk9XSebS1JcHAKkl/L+qK1jsNOqLeLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998427; c=relaxed/simple;
	bh=eKBqONdiSsBUuobmEdY1mAtYTYL7O9m2hVGhf0V16mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3RdltlpdSCuhkL+2fm49I9o1OXclXyRN1l9QLoKRLHSaDGJ5QpMx2+qq8XlaWN6qOU5RJSjMhWrwZUW+3djDqgmJUwg+Oa9lNj348+PfEJx4CrmxI/dSTiVk63CclwzClzjVErk46i03EiaQE9l7OIECxDoRT9at7d3vElO58g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KG7OcXl7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297dc3e299bso2684385ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1762998425; x=1763603225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sKtwP//OgsTzC5xxNl/Xd6UYX/1wT9VConzzoLFoks=;
        b=KG7OcXl7nxmT2EksNPHe/AKIJuk5Vy9O35FpuQ2rjXW5WqrT3/YWNFJ6h/1s6Tws8P
         KFQ5IzmnR0fKvxLQLB9y31oIJLHsdKqLRbM9ixCzRIx5rZSlidMXLFPZu06zUzf9lnU8
         HNxkrzksKrwM9iIddJ3vSGeqaUXPoeWnHbcLFRBho8/jVB4PFqZXiDY48UWX+w4dUe6s
         KnQm6JsaoEmdBWrw268jdp05SZhLPEKLyGyBXula8iLNwedZK8GXQ1moW8snzTgx2yje
         OH/PxclioA4yXk5wUhRmI9m+9nbPLjlvfZClqjPUuMIQGMigZ0FyWEQTStKYBSYq/zoB
         0nbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998425; x=1763603225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7sKtwP//OgsTzC5xxNl/Xd6UYX/1wT9VConzzoLFoks=;
        b=hgzmc6zZOaxm/zLaeRcjBnji0o5x7Edzz6dx4wGYUHCpU0yY+Zpcrn8TMYN6Sdk28A
         +XCmKekUa50/6wjuvhVoPsjUnwu5erCn3qVfUcD/UdhxCibjzyGfGM0TKrPtpc66QSFk
         sxNT2ojQqB3jkL7zzLcOKHsBrsJybLJmW4zW0cSbrOc9SwD1W59ZB8pakgPRkHpeQzZz
         YVQtrC0/Y643t+5ooMDM1WYkoJA2l7jpVW1FMOBMiokGEHY+1nwKXccwx7U2bp/HONYV
         dTVxgAwn/0/SdU+skIoiV7LfsM9cYUj579tG9B/sgWxiDs4EHRfrFZMJ0x8ZFKvdDb6U
         USeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVusB9YCwZcvydX1GvpFORmkUx7Xe9PTUsLDtfL+EMXosYGvMIpVbpvteo3cvHZBtOWbmuyZpUZgv8ACvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRXT/xUyMSPDM7uipaNBnKHw/F5gyY/4ed6kLIeSwsEsoOdQn
	dVmKSpoXT7ISHYjXvU+JfCRHvgwvblMqlLG7pqDou6h9mw1IDt810PdZ9vSxUV3Odx4=
X-Gm-Gg: ASbGncs24vVjJes5L3CW9viFKj/t4Sf9Pi7fqpiR/TgXhzIAXXWkly9auAR6f+4W44b
	FIrSt1WQOQ9L/pwZyu19XtjK2icYtguyQnM0xhtmKFJxPWE6n6X42jp2XtXB4xlhOB9F+GgyHxB
	sVNnrBRik2EBpEpAGjsZHlZoJYMYFzxBQrBY2t2OUH0UFtELBKE3w99zMiiUfdv7W0MdWp45Z3c
	H0yU1WG25lG/b+NrtmQa0ooW5QgSDt6p4jvZ2zpSKD0LJEij9ADut7MsRemAmPA4+3LY6jTyxQk
	rXlmonVy/1JbG7U2inVnINzPdTiNfzGdMV/L7kOhsS1WwdKbLg1zcZrKOtCP2NU0gRgzmvJIrzF
	9ajjJ068teDVteNmzJ4AwIR++Xb2AHLg2E5D+WqLzh85NztrwOosP6+2VHnCh2UtTXoCG9oEcfB
	kd4EofkhQmQBYoIvD0ryV7RQ==
X-Google-Smtp-Source: AGHT+IFyAjw4zT369i2V/HQmfngUMRA4j/oLD3IR8XNvQ6Htb0EplxsCGv5RKISA4ePCqfHnQtITTg==
X-Received: by 2002:a17:902:e788:b0:297:d4c4:4d99 with SMTP id d9443c01a7336-2984ed30d02mr63149505ad.6.1762998425114;
        Wed, 12 Nov 2025 17:47:05 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccae8sm4986485ad.98.2025.11.12.17.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:47:04 -0800 (PST)
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
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 04/22] perf/events: replace READ_ONCE() with standard page table accessors
Date: Wed, 12 Nov 2025 17:45:17 -0800
Message-ID: <20251113014656.2605447-5-samuel.holland@sifive.com>
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

From: Anshuman Khandual <anshuman.khandual@arm.com>

Replace READ_ONCE() with standard page table accessors i.e pxdp_get() which
anyways default into READ_ONCE() in cases where platform does not override.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20251006042622.1743675-1-anshuman.khandual@arm.com/
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v3:
 - Replace my patch with Anshuman Khandual's patch from LKML

Changes in v2:
 - New patch for v2

 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1fd347da9026..fa4f9165bd94 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8122,7 +8122,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 	pte_t *ptep, pte;
 
 	pgdp = pgd_offset(mm, addr);
-	pgd = READ_ONCE(*pgdp);
+	pgd = pgdp_get(pgdp);
 	if (pgd_none(pgd))
 		return 0;
 
@@ -8130,7 +8130,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return pgd_leaf_size(pgd);
 
 	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
-	p4d = READ_ONCE(*p4dp);
+	p4d = p4dp_get(p4dp);
 	if (!p4d_present(p4d))
 		return 0;
 
@@ -8138,7 +8138,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return p4d_leaf_size(p4d);
 
 	pudp = pud_offset_lockless(p4dp, p4d, addr);
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get(pudp);
 	if (!pud_present(pud))
 		return 0;
 
-- 
2.47.2


