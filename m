Return-Path: <linux-kernel+bounces-843370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC148BBF0A2
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7064034B019
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01D22DCBEB;
	Mon,  6 Oct 2025 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKTROUYf"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D9186284
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777028; cv=none; b=JSmA8yGL3nCfooSil+mf9EuGW3c2a6oTQFifp0knMz5XbF/UpXcWsLxDAhLb6X25Gf2qnH3kNQjhVS2MCkiPqgsegASYse2H6iZPPg8PhznWV1jZxX14jt9GKbV/u+s/jzYYJqnw5hHYY0z+DKOmtrVxINJRC7WMeqIu9TL7j4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777028; c=relaxed/simple;
	bh=EQPuiaG4S0ykpA9wuPBbZPcIaSeljhdRUkTALih5AfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5HnP/0wCO754NYls8eC5xfY539S3Tis/+Y+soLh0kqltSyu0aPgNFjg5G/lQPBm73OW0QVgc/4KHnHYj3CjjzVccJkhFfwChqNHVvTT7n0ykURXh5MSYt9HDQ7wPcc0XwMureGoNd2uTgq6x3i1lduBHLNWTX2YXFAbF9tl73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKTROUYf; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-74f6974175dso62166567b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 11:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759777025; x=1760381825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OcLivXiTrUYp9+AjADWgBClrEl5ra49lH5R16p1feLA=;
        b=NKTROUYfT5uO+695RirkPVKyJPNKw/Rwt9YmKK96h0dw2n0Vv+wCI6BtBI1V6Lx5TC
         cO26APMGA/F6JXmPcQlX4cVymMDbtf/d+Le5b1KOs2dk5Q6QMUTXk5n5ZSqweOY3EpE0
         7J/wUgKq9eDJSLjIzTNShD4RFD/UpCb7WhwRW1LTOImDPpGk7SXKD9Ey6jnPrwdknUwl
         +Dl1uUoL9Qv2oSI2jB03a6YYxCi1mghmG2gkI89wmZ2Zkr0LNidrCGvRLnkcU6EShnYd
         9zwQbZ3Jeqk3h4EUeOy1A6ipOIRu87VcqhMojxvLILSE9/FGiWh/VBWAmK05VJyFC326
         sm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759777025; x=1760381825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OcLivXiTrUYp9+AjADWgBClrEl5ra49lH5R16p1feLA=;
        b=jAtgnOGpP5eN+fZtZZiav9UXs8lsqRJ1uUzmLPPaT4fBfS4rnT/fNm+/rq8BsrwWQd
         TGANAVIJ7jeDyldNv4qMQltlGvgCokdgWLiF3mBMvi6RuU4SlKc9X4q4VjPWahujPgEA
         9wrfslUt+dHEcXEo2SM048v4dop+DTdv3CI9+27yKTEdi4D/iVFmlj1mOYJiQzTwFot6
         YZXVVEiftgViiLG9Zmk7vb4Y/xfYJGJSWE/3AybPmijZpO7nthgMfiDN2Vc8nbtD5cp8
         ExcL5Vho1RUeF9jPJErCFDUfEpbOiyd1VjvaNKwgzRtXtZY/a+mhiybC++rNvmqceeMK
         tUCg==
X-Forwarded-Encrypted: i=1; AJvYcCXcEOOLoifdUSAz/HnermJqG6AUPpP4ZK9Eq4qYsaSF0cPHRBJkw8psBRjOwa+4UGhTub6ZIgO/Worox0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDClRcFS9G6yEnxIfoHw/M54a/mdmcyHo+nnlTcR4pHtNEX1IG
	QDN4KtgTE/HIytRCDQTu3qL1Od2gm3IeMBzGfE0QAIpt1SzsNM8ZclvO
X-Gm-Gg: ASbGncuU1ly1KhQwUCmxNM5JCUnfaSiT1JPgBwUCb8ufsp1ki1KMIXz4L+N3aKcdfkl
	fFKOeFguZk63jW8R2DvkzV+oR04CpgOA902pR9LsvE9EqRrcSRd080pcGNfa0cusd49jwRUonAA
	D3QzGDnFy0dYJwm6BrU3DANZERs6MnQusE7PYlpNfk3o/ibrwW+bpfoMfz/bLqbcEnktVPsraTH
	idVjZG3B3m65NoAvTu69spOrEO8ND+UftnOG/f7pooBrv0S9bzQL/jXH+zV9WYPOnA13tqxzG3Y
	z0mGReasI9w5Yzcco5mz0HW+I0YLRdogBMa29ALhTRSBinqAuDpAjdl0uwmajpOK04ywwLl7/Yi
	KMrCkMNEDDAGuVXMgbwOunQNt0oLs562cZhUmLzR/Nosg5hVEqqPrj6iADHe46mVL138=
X-Google-Smtp-Source: AGHT+IG+sY5JofC0Ui9LDv+QJsiTCRyPBvfpZ8unr5Xkd/b4u7EaRyLhAZpr/ER4/vF15YDg589auw==
X-Received: by 2002:a53:ca41:0:b0:633:a7cf:bb4a with SMTP id 956f58d0204a3-63b9a089028mr10682175d50.23.1759777025398;
        Mon, 06 Oct 2025 11:57:05 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63b84690b4csm4663064d50.21.2025.10.06.11.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 11:57:04 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	kas@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH] mm/hugetlb: allow overcommitting gigantic hugepages
Date: Mon,  6 Oct 2025 19:56:07 +0100
Message-ID: <20251006185607.3257340-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, gigantic hugepages cannot use the overcommit mechanism
(nr_overcommit_hugepages), forcing users to permanently reserve memory via
nr_hugepages even when pages might not be actively used.

Remove this blanket restriction on gigantic hugepage overcommit.
This will bring the same benefits to gigantic pages as hugepages:

- Memory is only taken out of regular use when actually needed
- Unused surplus pages can be returned to the system
- Better memory utilization, especially with CMA backing which can
  significantly increase the changes of hugepage allocation

Without this patch:
echo 3 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_overcommit_hugepages
bash: echo: write error: Invalid argument

With this patch:
echo 3 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_overcommit_hugepages
./mmap_hugetlb_test
Successfully allocated huge pages at address: 0x7f9d40000000

cat mmap_hugetlb_test.c
...
    unsigned long ALLOC_SIZE = 3 * (unsigned long) HUGE_PAGE_SIZE;
    addr = mmap(NULL,
                ALLOC_SIZE, // 3GB
                PROT_READ | PROT_WRITE,
                MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB | MAP_HUGE_1GB,
                -1,
                0);

    if (addr == MAP_FAILED) {
        fprintf(stderr, "mmap failed: %s\n", strerror(errno));
        return 1;
    }
    printf("Successfully allocated huge pages at address: %p\n", addr);
...

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/hugetlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c07b7192aff26..93d0f8ae1fe84 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2232,7 +2232,7 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
 {
 	struct folio *folio = NULL;
 
-	if (hstate_is_gigantic(h))
+	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return NULL;
 
 	spin_lock_irq(&hugetlb_lock);
@@ -4294,7 +4294,7 @@ static ssize_t nr_overcommit_hugepages_store(struct kobject *kobj,
 	unsigned long input;
 	struct hstate *h = kobj_to_hstate(kobj, NULL);
 
-	if (hstate_is_gigantic(h))
+	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return -EINVAL;
 
 	err = kstrtoul(buf, 10, &input);
@@ -5181,7 +5181,7 @@ static int hugetlb_overcommit_handler(const struct ctl_table *table, int write,
 
 	tmp = h->nr_overcommit_huge_pages;
 
-	if (write && hstate_is_gigantic(h))
+	if (write && hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return -EINVAL;
 
 	ret = proc_hugetlb_doulongvec_minmax(table, write, buffer, length, ppos,
-- 
2.47.3


