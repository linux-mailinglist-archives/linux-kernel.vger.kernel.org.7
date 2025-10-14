Return-Path: <linux-kernel+bounces-852353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64310BD8BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A96B44FDC9B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787EA2F548A;
	Tue, 14 Oct 2025 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o/9cubEa"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024842F657E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437434; cv=none; b=iR0TZuQsGmXWkr+8gEkvRR8TukhusSnjK7SuPXDXqqSfgscRLJZEx0km+przd2IO/uJxM7plmpRe8tQf3x6uY38wYP2FYvFaXenuuqfA/tBesH9Br4QfC9n/uVTmoa1ViWE8UH6pit7yqRa1L9fQsoYcfZ6ZT+zAZEAbPIaCWo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437434; c=relaxed/simple;
	bh=cxhqHIQTA6pAJ7DN6/EBnCCQrmVl2z5O6fweFPFKgy0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=btrOq7uGhprejVTCoPHbNYPaRdVH3zAVnHADvUIUJB9+hsD6zJvjl2Z0RDoF02kzoUs/Za4ApPUKgBBHm3HLFKPDGdlYqOV1PItrRM+C/7Dsk+N67inACthdRnfeMkbn6baSfTDYuKWgpZXB22Orjoh33KDqTCbiB9zq04VIylE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o/9cubEa; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760437428; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=J9JOaJlvD/7q8qVNfsfW+49TDQ791v2pZOsg2KuuwpY=;
	b=o/9cubEaxUaZYl6aA4L9zQ1dwpUyWwOCTSwKmAaHmhMxztvWiobGgUc0GBaayfc+25cqUazqUa2DTDDYdRV2LMZSM6Se4+QhIuGc+10mGI2i4kuovz1SzYKbHqnD5gH7Aa1w+bat//NSu8XO2IAhy1cSbkMA75lk9uN4ivz1NpM=
Received: from L-G4162440-1116.localdomain(mailfrom:yadong.qi@linux.alibaba.com fp:SMTPD_---0WqBnE89_1760437427 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Oct 2025 18:23:48 +0800
From: Yadong Qi <yadong.qi@linux.alibaba.com>
To: akpm@linux-foundation.org,
	urezki@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ying.huang@linux.alibaba.com,
	dan.carpenter@linaro.org
Cc: Yadong Qi <yadong.qi@linux.alibaba.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] mm: vmalloc: fix uninitialized value issue
Date: Tue, 14 Oct 2025 18:23:37 +0800
Message-Id: <20251014102337.5453-1-yadong.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Issues reported by LKP:
  mm/vmalloc.c:191 vmap_pmd_range() error: uninitialized symbol 'err'.
  mm/vmalloc.c:243 vmap_pud_range() error: uninitialized symbol 'err'.
  mm/vmalloc.c:295 vmap_p4d_range() error: uninitialized symbol 'err'.

Fix by initailizing err with 0.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202510110050.VG9YKMRK-lkp@intel.com/
Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>
---
 mm/vmalloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c0213118a75e..6d6d4cf3e176 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -170,7 +170,7 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 {
 	pmd_t *pmd;
 	unsigned long next;
-	int err;
+	int err = 0;
 
 	pmd = pmd_alloc_track(&init_mm, pud, addr, mask);
 	if (!pmd)
@@ -222,7 +222,7 @@ static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 {
 	pud_t *pud;
 	unsigned long next;
-	int err;
+	int err = 0;
 
 	pud = pud_alloc_track(&init_mm, p4d, addr, mask);
 	if (!pud)
@@ -274,7 +274,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 {
 	p4d_t *p4d;
 	unsigned long next;
-	int err;
+	int err = 0;
 
 	p4d = p4d_alloc_track(&init_mm, pgd, addr, mask);
 	if (!p4d)
-- 
2.43.5


