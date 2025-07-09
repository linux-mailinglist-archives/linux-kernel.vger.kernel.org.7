Return-Path: <linux-kernel+bounces-724268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59FDAFF0A7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBAD487A81
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD4223C502;
	Wed,  9 Jul 2025 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDAdbCCG"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5FF226CFE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084665; cv=none; b=rCW+Tb5KzHm158tbsDIiR3TROmMkDruOFzgbvR+sjuimfh17bImn4/CtZiK17mSbBXBOaADCx+5i2j/goxBTJFGE3nhVy2GRPLoFBCvaktiJm36j5fJ4zePOM1FhdxAfLctCZR4oBUfEZqZdHBR/aVBqe2WKiHjaHadOU2vwos0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084665; c=relaxed/simple;
	bh=d/oWol0LgIUWwzOgbN7yFB3YhKmNOAYY2XKVEZUfdnU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sKzF3Z1rnDg1NjJJL0r/pzR1DoEyqf61j7Nhh7zjCSN8VuTkHyw+xkyOOpHij1ATOgqp2U0s7pEGqpIg62+u95eC73Lejh4IJvdrWJ9kikiLZCmswTr5uOZ2AaeIv6d5fCrIx7TcTacw3pIpzQ0h8lr/gzm0FYv/q7FyRkdsYFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDAdbCCG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so148382a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752084662; x=1752689462; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ecY2fLdFbED+54mDeblvrbXpU8PvP0LCjxPUJFq1bj8=;
        b=hDAdbCCG194qlg2y/tfEjAksinYsDZmJHNgV6qsVdXCzp/AyHdlx4+H6p/XWyss67/
         E53O+r65/0RrVt7KKXNzgZRBi8/tnmPG90aL7MIfw635dExoakylWXtabiHlsrQjVL/C
         M1nqcc6QCKH5stoRvkjfKVCATY9aV41xS5i2MhIHdxGFulOpqw+BHO2vIf3DDkSLRrR1
         GddDwwG2zOt5opvZVS0Tlwb25liME7kslWjA5tHBinQrsRI9yfCPg95NMQHapOfsrD15
         8H1Vel4emahf91kjoaBok33c7UWdn21pRZlTv3zOmjaHHq7ZzC6odgo4Yc7JwPtQdS4w
         o1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752084662; x=1752689462;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecY2fLdFbED+54mDeblvrbXpU8PvP0LCjxPUJFq1bj8=;
        b=e2DIfyLRqy1dPFQbBLCX6xFEw6EkRoG8GtMe6aeTgLWRDfABoLH2/gtBb5ABWsQJOL
         NgeQWPanNc9wqHHvQHNkDkQW7bznchgY/74smVqV5Bre16VPa6LPGleZmGSS2hKuxFc3
         1/r61EsFxUclzmfftsephJ/p5bGNvJ+MuZGDQ2mXO+drAf7dGcSwt8FKVQgpWgz1+M6t
         LFTxcFbCtSB0GCSTn5QwQRLxTsf0ZP/zfvq0h1IPzkdDGKI6pxcFWSQCmj9p3eDjEnuw
         QmOd0uDyvvTj/qoE6tlS5zhXKLE5ci0OAWkQavOfSGq+dYhX9RMtD1xzbsWW8zqw6Xtg
         cNJA==
X-Gm-Message-State: AOJu0YwI3t3PJ0zM6YVlT9VgV0dw/FuUkfduTwPkbc7y5jh7mWkA5sh6
	9BMqqOULbo5LD75qgwSrP4r/Fzd/dC1sbAYYGcsm4YG8Xv3FimEiogE=
X-Gm-Gg: ASbGncsrIeuck4NixcJwS0gsHeDWb3CQUSABRTe+/xK/CWEAlg7maApkSdkz587VRxb
	hVuc9WRKbLFh7rIsj0DsGzs1S9drohd/+qvGBw/H5TYVDYfDRTuUG2HW1HfFc7DUZ5uXru5Me1A
	vnuSIJ4SKmaJ5WPoJbkCuAZ6D0NjOir4ZWL5hAjQwbTRriCEifueY9udZZd/JqSoAPJG1dhkD/n
	6VUZFfXI18zRa+7xVxPd/7MePR4ifij4XrpApW9VY0HR4Nw8CnZSa2kciYs7NrqceVdetCUTo16
	+gu1fI9sKzyBkS3mJ2pCJyL6hrLseVOkseJOijeLp7X39q+o8Q==
X-Google-Smtp-Source: AGHT+IGHMG4NjofHbzi5qMzLNucF1LMq4d5PXYeTelG1BFDrADXv095cP4+i3C8xqtztoEL+46QGQw==
X-Received: by 2002:a05:6402:274e:b0:606:f836:c657 with SMTP id 4fb4d7f45d1cf-611a736ee52mr3276544a12.28.1752084661665;
        Wed, 09 Jul 2025 11:11:01 -0700 (PDT)
Received: from p183 ([46.53.253.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb1000c6sm9127465a12.60.2025.07.09.11.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 11:11:01 -0700 (PDT)
Date: Wed, 9 Jul 2025 21:10:59 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm: implement "memory.oops_if_bad_pte=1" boot option
Message-ID: <4e1b7d2d-ed54-4e0a-a0a4-906b14d9cd41@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Implement

	memory.oops_if_bad_pte=1

boot option which oopses the machine instead of dreadful

	BUG: Bad page map in process

message.

This is intended
for people who want to panic at the slightest provocation and
for people who ruled out hardware problems which in turn means that
delaying vmcore collection is counter-productive.

Linux doesn't (never?) panicked on PTE corruption and even implemented
ratelimited version of the message meaning it can go for minutes and
even hours without anyone noticing which is exactly the opposite of what
should be done to facilitate debugging.

Not enabled by default.

Not advertised.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 mm/memory.c                                 | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index b0cda5aab398..90b92b312802 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -42,6 +42,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
+#include <linux/moduleparam.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/sched/task.h>
@@ -480,6 +481,13 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
 			add_mm_counter(mm, i, rss[i]);
 }
 
+/*
+ * Oops instead of printing "Bad page map in process" message and
+ * trying to continue.
+ */
+static bool oops_if_bad_pte __ro_after_init = false;
+module_param(oops_if_bad_pte, bool, 0444);
+
 /*
  * This function is called to print an error when a bad pte
  * is found. For example, we might have a PFN-mapped pte in
@@ -490,6 +498,13 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
 static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 			  pte_t pte, struct page *page)
 {
+	/*
+	 * This line is a formality to collect vmcore ASAP. Real bug
+	 * (hardware or software) happened earlier, current registers and
+	 * backtrace aren't interesting.
+	 */
+	BUG_ON(oops_if_bad_pte);
+
 	pgd_t *pgd = pgd_offset(vma->vm_mm, addr);
 	p4d_t *p4d = p4d_offset(pgd, addr);
 	pud_t *pud = pud_offset(p4d, addr);
-- 
2.49.0


