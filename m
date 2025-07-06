Return-Path: <linux-kernel+bounces-714103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2AEAF632E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 22:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97294E37F0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 20:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540762D641F;
	Wed,  2 Jul 2025 20:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3YanFEJ"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44302D63FE;
	Wed,  2 Jul 2025 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487311; cv=none; b=ScWCoZweUPCO0XYZhd/JLcNpHGUPlpfmlfpUGerT+chvTubSHPe5aicMwJVBJA5WEuEQ9mu5IwvoDggUY3SuNb7mRVLZzhL8j05qe/IGXR46U2f64IzAKzjwAQJjfpuOnDPRkww8vtO1vD8BpkY2bzn1CIJcD0rExOBDvaEiH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487311; c=relaxed/simple;
	bh=G1+nrJSlCuTm5ni6kCD8sus2FYIDGsIfqepvM+zEZ2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6QIIe52GwMVX3vvSTKqrY/PIsP+7X7c7QG7BEWTFvlc9DAMlXXSpd2nkyUiXSzpT1vUIrk+QhFAJGQgYWypapXKC782MAyPDlfj+BzELykoh5mGwPyKrXiG3PM4/Kvj64NqqUZbH6MHT767m5kMLenUTAjXIPwlxkJf9CyB0XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3YanFEJ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e81826d5b72so5982151276.3;
        Wed, 02 Jul 2025 13:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751487309; x=1752092109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMg5BL0bm2K3XwrpoVYC/9dFOzEmi6T120k7I9qtnC4=;
        b=F3YanFEJSgwKjCgVxfNsFxXX4qqG/mYAff/YEVBpRb0b7aYyAIXYgiu0+CObsgxtg5
         2uCdbd3eIJaYFjRg2fXYWrgpELTNUBV4D/S2oWp/OjO3m6S+LdSptJyPI6DGhHMWGZXO
         H4tmf+dLkyK4Zala08oWMj2JFp0LePzrPacMm/elGaSEOP+J2jo1ecTkDcA8wkTYyNVW
         zXF5mrifl4C8ogaoCtBefEC2WpA7azRpmgj6PX94sTwN0V1+HkqUwWVSM7Ulsld0fzd6
         YE67Ex6xe97Ou8wMchO6mx9Tc8YRxcDypH2iXqbOnugN1jPY6z4HhmQdDhK18aNu3sUV
         z9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751487309; x=1752092109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMg5BL0bm2K3XwrpoVYC/9dFOzEmi6T120k7I9qtnC4=;
        b=e/z1Ufr2161pLwAv/6xq9fc7eC4obR6FFL0ibvcqVm0/OLhgN52Hx7J4LFcLt7IcLc
         vJncyCivGYiwZ5Z/s2cMkOz62h7zyOmy8NRp4YtZDgXPy4fAlARyVff7zbp8gL140rdU
         IXZMKJQPjlo1viUQ0hUoUcekB+I4jkoaHRqUhFFPLmGsElCjHl1aDaBJvtV4qrqnzkeG
         rE7y0GEsahM9Nht0EiLtJu/PMiLYY1c9mjMTWI/wVbBHWzzb280XuE9zOv8fuuAJUJTf
         6ZjbyCEnGM3TP/+OBkfYhpfXraxWnJk09wFBCh5XMXn/jCsBUvDlEvHe2if9DTjS54AP
         /pag==
X-Forwarded-Encrypted: i=1; AJvYcCUxqYSXDdv9qnOCEdfJgR1em68IOs/Ixql+qQ7OD/SyS1aEqTqDMjgr1Ff8bcMP13G5k8j+h59DR+4=@vger.kernel.org, AJvYcCXDByMCc243ADGY/JAT8E0EQYLxGrV8Lxzhdyq+pmbe43WiN+VTvO6BiV2BtPBkBUc8/Mf0mzU85enNZ0Es@vger.kernel.org
X-Gm-Message-State: AOJu0YzAJ6IEW2c6LAziX2C/11PtSkRdf8zJWJmafrev4TkCQUg03C/K
	Hao079BxdSIDjADPKo3wEmb933Y7Z5TfW57dD11dau4TZOKyt85jcfij
X-Gm-Gg: ASbGncth19HfhvVvdavndyEIMVswXCNeOcdMESetJHBpjsWEfgEjshg0ROvY9gCLE7L
	735q/+ljeuTNPbGiygxVoPIzAtfiu9bhDqbVHB+gAAvRkzDfhlecQyu4cNKBm0TAANDic3Ed4sB
	ZcyzRgln2+HdIPZpBffbu4eu5n+vdzkQ5+fpbedvftcMW80vecobF8qxNHX1WC0TIkBNykZZCm3
	N984jbjjmoOz/3dZ4yV6UecxSO1mHOoN7BITfAJHNeAk/CGqxMqR59+UH+Sy60Xw+EiZDN/wRQY
	A70gbjckBc/qHWAvQE91tPiedFH+x5zH7h2DmQ0GG/lBoO67QdYpY77RG9qYJaCPwI9MudCtMPz
	OQMwegI4=
X-Google-Smtp-Source: AGHT+IGKvPDCimyFCg/hqso7aOb/BUUZpqnaqOXEPoQpEeHLKPtOWIiEclbT23ZwcvqRjO6m/wd+RQ==
X-Received: by 2002:a05:690c:6701:b0:70e:a1e:d9c7 with SMTP id 00721157ae682-71658fe3499mr15332597b3.10.1751487308762;
        Wed, 02 Jul 2025 13:15:08 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:873e:8f35:7cd8:3fe3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb4347sm26124157b3.83.2025.07.02.13.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:15:08 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	joshua.hahnjy@gmail.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com,
	Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Subject: [RFC PATCH v3 13/13] mm/damon/vaddr: Apply filters in migrate_{hot/cold}
Date: Wed,  2 Jul 2025 15:13:36 -0500
Message-ID: <20250702201337.5780-14-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702201337.5780-1-bijan311@gmail.com>
References: <20250702201337.5780-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

The paddr versions of migrate_{hot/cold} filter out folios from
migration based on the scheme's filters. This patch does the same for
the vaddr versions of those schemes.

The filtering code is mostly the same for the paddr and vaddr versions.
The exception is the young filter. paddr determines if a page is young
by doing a folio rmap walk to find the page table entries corresponding
to the folio. However, vaddr schemes have easier access to the page
tables, so we add some logic to avoid the extra work.

Co-developed-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 mm/damon/vaddr.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 5f230a427fdc..2a485bf19101 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -611,6 +611,62 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
+static bool damos_va_filter_young(struct damos_filter *filter,
+		struct folio *folio, struct vm_area_struct *vma,
+		unsigned long addr, pte_t *ptep, pmd_t *pmdp)
+{
+	bool young;
+
+	if (ptep) {
+		young = pte_young(*ptep);
+	} else if (pmdp) {
+		young = pmd_young(*pmdp);
+	} else {
+		WARN_ONCE(1, "Neither ptep nor pmdp provided");
+		return false;
+	}
+
+	young = young || !folio_test_idle(folio) ||
+		mmu_notifier_test_young(vma->vm_mm, addr);
+
+	if (young && ptep)
+		damon_ptep_mkold(ptep, vma, addr);
+	else if (young && pmdp)
+		damon_pmdp_mkold(pmdp, vma, addr);
+
+	return young == filter->matching;
+}
+
+static bool damos_va_filter_out(struct damos *scheme, struct folio *folio,
+		struct vm_area_struct *vma, unsigned long addr,
+		pte_t *ptep, pmd_t *pmdp)
+{
+	struct damos_filter *filter;
+	bool matched;
+
+	if (scheme->core_filters_allowed)
+		return false;
+
+	damos_for_each_ops_filter(filter, scheme) {
+		/*
+		 * damos_folio_filter_match checks the young filter by doing an
+		 * rmap on the folio to find its page table. However, being the
+		 * vaddr scheme, we have direct access to the page tables, so
+		 * use that instead.
+		 */
+		if (filter->type == DAMOS_FILTER_TYPE_YOUNG) {
+			matched = damos_va_filter_young(filter, folio, vma,
+				addr, ptep, pmdp);
+		} else {
+			matched = damos_folio_filter_match(filter, folio);
+		}
+
+		if (matched)
+			return !filter->allow;
+	}
+	return scheme->ops_filters_default_reject;
+}
+
 struct damos_va_migrate_private {
 	struct list_head *migration_lists;
 	struct damos *scheme;
@@ -695,8 +751,12 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 	if (!folio)
 		goto unlock;
 
+	if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
+		goto put_folio;
+
 	damos_va_migrate_folio(folio, walk->vma, addr, dests, migration_lists);
 
+put_folio:
 	folio_put(folio);
 unlock:
 	spin_unlock(ptl);
@@ -724,8 +784,12 @@ static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
 	if (!folio)
 		return 0;
 
+	if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
+		goto put_folio;
+
 	damos_va_migrate_folio(folio, walk->vma, addr, dests, migration_lists);
 
+put_folio:
 	folio_put(folio);
 	return 0;
 }
-- 
2.43.5


