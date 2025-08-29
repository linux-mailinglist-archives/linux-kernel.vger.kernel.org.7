Return-Path: <linux-kernel+bounces-792299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0844B3C27B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E43585021
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54372346A0A;
	Fri, 29 Aug 2025 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="aanOCqFq"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4F23451DA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492334; cv=none; b=N14U4+SWp9bqTU+SnHusIapnnXwH7nCc+IlQLK9qUehUImqdki52Vg+4bvCv0jG4fTitg9AvfBUZ9DEpPe+TmZEsKNMa6B7G6tLv4esmd4iN/gC+CU9cBCmTGz1W3LDuI5G4cRMzxCM/e9vkKUbTz4LLdGwS7gUTPcyXOFlHaXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492334; c=relaxed/simple;
	bh=636LqQUuPfJPXn7kEnF94VjwKJfaKyx3OD1eA0voqXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyOPXcegTisurwGFdZQBF44z+FJJsS5VjRqW/SNzPcRozzsBLpmPcSXc2ediyqNsjlKqM2XmTztsh/h2ssLiayvB1bJpxIPnmCbEKMXIWuDyF5As3RnDe7FL4TiCXNbVpt+dlEd4dw5E9Czou2tD2qcFo6akFtyLmJQtguUMQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=aanOCqFq; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afedbb49c26so374450766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756492331; x=1757097131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpTsIMZMAvGu+0Cv94tirrHwkbCcjUoCoe0E1cezNnQ=;
        b=aanOCqFqH+ivDktM7HuN09ni7g9cWU7BDGd4jyQGCMzGCVJRuk+uoHJiu2GX0WTLK+
         Hc8YrSrfUQK4rX5FehNPkMAJo1LPQlSHv/yTAqXUZ9mW1IOMshwkizirI1R/T27E9Jz8
         Nzj16y9QzWySRxddUroNjQf2UyNaRXoqSs3t7o9WR6VnGrojeHm3vC7xxdRGF6NKytBX
         rDKIHitk2e4p3HeV24LPvGO7COOYQVW0vhzLbo3tqh0+O9lXCPJh3uDBoi2e/X7ynOzO
         1kCqrhLpDwrSnvEkNBn+/O0IouzaUuyifGfoxjKChYGcFdQeqOtqhdHZve24ACRxFx5V
         C0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756492331; x=1757097131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpTsIMZMAvGu+0Cv94tirrHwkbCcjUoCoe0E1cezNnQ=;
        b=ezrb25SdwNgscGHJCY8W8uNT1H24PWOx0TbCk72u14iu+Vw/frgE5kwfDxEYQysD0q
         aPfrkfcLYNZqvZr0dSdGzDnTxBav044W3B58bGjTzYqj6510DDA0AEDMqqLQ7bj7TCnH
         MPWFAsFpta/C97jCNOvHwUpnUYu3srhMLQHZui3yi/jRD1TeAcPwiiJvzJZhrr6tkk4U
         /XXNErIbnJvrKxO8dAs+SES/C4/cBKmxNlsE11Ck1PDn04LDfFPBujQXZn0m9SI8UDZX
         z2d/1fliRKiJAqXAfe4B7IgBl1NbQR0VokFwSIBBW7GVvKo6YtIAVZHVlaw9ozJQGmgU
         UhtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsn+E9mInG1eXRGfXp9BvTYpNoIO9OlE/CwG6bBfgIn6CcZS08d2aU0BNBLA0llmYL1Mcktrsk4SI5C48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ4DhvsQlFjO2ODL12x0Ipu2jt9Yz+m7eF2s7S4znLpGFNkoly
	C0K9JrY46DDASUNAlwXI4SDCqSbyRewS+bcfQunjtEZ0ihQPvUT5SJE6Yj2on2Wh2Pw=
X-Gm-Gg: ASbGncs8G1y+8rXNk8I4AOSLCGJREXLRscVwsspxVIpaK+HWjHgz0GZ3eEHY7TCOjWn
	KMInRPfpTv/fadkAsnjQiDfh0L47aOpWv5q9pfpjJgyhV7QyPSgvKwblCSnqi9SHx0leoiDmKsp
	B6qBzLDNMkgSNBDuKHpNwRY0RqRF1WSUKhb1Ed2Hl/o3E2bSPRp+4FQrsSlfyPgXxE6rgDWlxNL
	WlvAlrsERFh9nrEBNkk2qcsKqlJ7Zyo6neCXrMOubpQ/l57gd10U5P6qr012jmrAIiSTPyVJerQ
	YsgBUI9CXeCPkTE8HXdQnr4HoTui6V+A/x0juMfmWuV9a70mdjdC+3E787i7IOnn+79P5xcDE89
	876W1K/z35qtWhhfNaR8J1eYsfbJE2BeQBjOHxTWcXW+FLAwgiRZ9QgSsCT1h9rZf5rLwiK5rRf
	1mkOhLoUmQn+PNPkbCld7K/gVSGOuoKCNA
X-Google-Smtp-Source: AGHT+IGY8RZG7UM9cRbB/qMS7odXqSdwqfd3yzWdCRIEIpzTBfe1cib0eGa/n8oqQzAkKhR9Vr5KxA==
X-Received: by 2002:a17:907:78d:b0:adb:428f:f748 with SMTP id a640c23a62f3a-afe294b483emr2613549166b.21.1756492331404;
        Fri, 29 Aug 2025 11:32:11 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7f1174sm257964466b.9.2025.08.29.11.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 11:32:11 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 05/12] mm/oom_kill: add `const` to pointer parameter
Date: Fri, 29 Aug 2025 20:31:52 +0200
Message-ID: <20250829183159.2223948-6-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250829183159.2223948-1-max.kellermann@ionos.com>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h | 2 +-
 mm/oom_kill.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a40a3c42c904..a795deef93eb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3840,7 +3840,7 @@ static inline int in_gate_area(struct mm_struct *mm, unsigned long addr)
 }
 #endif	/* __HAVE_ARCH_GATE_AREA */
 
-extern bool process_shares_mm(struct task_struct *p, struct mm_struct *mm);
+extern bool process_shares_mm(struct task_struct *p, const struct mm_struct *mm);
 
 void drop_slab(void);
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 17650f0b516e..69c4fc9d90e6 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -490,7 +490,7 @@ static bool oom_killer_disabled __read_mostly;
  * task's threads: if one of those is using this mm then this task was also
  * using it.
  */
-bool process_shares_mm(struct task_struct *p, struct mm_struct *mm)
+bool process_shares_mm(struct task_struct *p, const struct mm_struct *mm)
 {
 	struct task_struct *t;
 
-- 
2.47.2


