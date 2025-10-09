Return-Path: <linux-kernel+bounces-847256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B223BCA5E1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3786C3540A5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C6B24166C;
	Thu,  9 Oct 2025 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcxP/xvG"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317A9A31
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030703; cv=none; b=Q9n/WOtinQ7TqQHy6LjxjiSOB6ODxFNaQxZNEdwd7reJpZhrS2BsNCus3r5dTNLv/QaFv/ntI9YeXkYa+Bz8cfYRB9RGjxx3DCGf2RipnnKueWwQ/8tgc8GsUYUNgS7s4JVdm9eXOzZObicvkBMQKPgHAUPVDg79Mz7xl6w4xS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030703; c=relaxed/simple;
	bh=TAyjqc5oZRgyYUu7lNgQ/g+2C24FlERWRjKZ/Z/VxnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZwZDvpirR2DGAkx2id7kGpiPUC+PObWWJ6UYCLYcXHp+9kU7eBTFI68CLzO0xOtrcN5xWqGnp82PyyX20mixjDaojAmTlzoVQNKA6MyCGxHpm0wxmeKknZetvZ4bOAPQv+HmvhqSaVAsSNApJ6qcjnNx3vlrcna+YuhcUL008Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcxP/xvG; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d6014810fso12304097b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760030701; x=1760635501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHs3vTEzsqX/lrSosRYA6lDBYTRtFs3F8Lz2Rdvx8rc=;
        b=OcxP/xvGmaHY1CToxDiQELi6qAIitCqDFTEtXwuTsPI8W9/NkTswPSWs7yJtneQtzt
         23vhpWALNshvBT2nJxgnmj+Q7K0Fy68thqLjHpO8PXOVJ3/3LqOFzC+EmJ4BO/BPr2m3
         t1aAoZixqO0i3XstDVl6MZkRUD/VJ4z1UnEnI/O8sANACPSpAi3WozFa1nysfx0uz/Kh
         m2FRadIxoGqECVUGtzAszCjAC/ned7FXZ0pGIeGxH+VYozdoumZuW1OsnvjSVgYCnCgt
         bHecoRlTTAK526T4Gl4Dm18U5Rr9VDFgzh9Ue4F9EDiDc+f7QnSIvUIe0+0H7AKWp/Ek
         VSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760030701; x=1760635501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHs3vTEzsqX/lrSosRYA6lDBYTRtFs3F8Lz2Rdvx8rc=;
        b=HM2kgmW5xh3sWhv36StK+I5Wk/iNzZ9Z9llRumM87/5y+ir4EOctQX1zm+2Mw8gVdu
         NvJ7Og5mzXHbRd07dwOI42jbyfOaWoxRFeXtmN4UvwF5hAeXlQrJOrYOPkiXKPP5IWvK
         kjJsd628Bh9ZRIHg0y+ApHJWw3lM5Qf3cACkm5goFPxyY8hSzHWU1OkmQ5JSeRJRYUTK
         TjO/J1MiAd1EjrbqNlNFbzULv2LO9O3oJ8WUG7rn7CAFhdDlKUscZ9zGCHvM88RuWKEy
         E5Pi/42qS+4Y5Np7ursEK51rknCyYEjLk21BDHXdxUVQM0i5nfvWC0dbZngIlhuc7vB5
         k+cA==
X-Forwarded-Encrypted: i=1; AJvYcCXOmH3bajn+X1sWtIiq8z10Rk0lqdxAx9rhEBkXPpEAbdCLEEa6F/X8550RB+CGpHzlYnoOAUWtb87Esog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG3stK0cTeYbNQ75EuHE95w/ms0IvKxEeI8WTvjCEim5PGpkfl
	e2z+C2VPXjrLFvujxxshfr92/6j8Lj1h4tYzXvzMP9JKiHgrG+j+pZXP
X-Gm-Gg: ASbGnctyNDKWOnuMPJjblWZ8RuiOzqjnxJ5+CQttlGY7HpBaXu6BvxNS4kOl9N8XUTF
	I4SCh3hS8j7kDk91hP3npKazU/nqfJNBv5tGVbKH5RJnD/IXrJw3S6/spQuWegRFAWYd2qqSRR+
	ptPNnmHUJ6bmtD0yrgVNSFVi1qr3DQhA0Hlsx1LuT4tb7UgkOYYiyPpaQaPmc6hpAv/1X8UFlXE
	33G701N6Z/MKFPoQqhE7oBVELtwSuS+On7vckVBpLYkvo3jYiR7KpdunIL6GhC56D7dd2+TSHvD
	MLdX7a/YOc+0ccj2nJ/P1jgeAktpgzybelgJMZe9JhRY2/BvsYRh+tJ9enbLTkZhmygpLEWz569
	wYiQY9WoKKLoL9T0dSAT9g7FpeUnx45twgZpCgnP87kjGf7xHamZ1Fv+3KwcfZ9ZLuyc=
X-Google-Smtp-Source: AGHT+IFbZgedcNYqQke+1OXZPO57fV833IqHejgnCHT1x/Sq25k96WuYViPRYem6oJhVnlQqCgXoAg==
X-Received: by 2002:a53:de52:0:b0:62f:c634:4b3f with SMTP id 956f58d0204a3-63ccb7ea499mr5757999d50.7.1760030700990;
        Thu, 09 Oct 2025 10:25:00 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63cd952e09bsm1029933d50.11.2025.10.09.10.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:25:00 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>
Cc: shakeel.butt@linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	kas@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v2 2/2] mm/hugetlb: allow overcommitting gigantic hugepages
Date: Thu,  9 Oct 2025 18:24:31 +0100
Message-ID: <20251009172433.4158118-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251009172433.4158118-1-usamaarif642@gmail.com>
References: <20251009172433.4158118-1-usamaarif642@gmail.com>
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

The restriction was added in 2011 [1], which was before there was support
for reserving 1G hugepages at runtime.
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

[1] https://git.zx2c4.com/linux-rng/commit/mm/hugetlb.c?id=adbe8726dc2a3805630d517270db17e3af86e526

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/hugetlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e74e41386b100..c0036c0775d75 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2243,7 +2243,7 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
 {
 	struct folio *folio = NULL;
 
-	if (hstate_is_gigantic(h))
+	if (hstate_is_gigantic_no_runtime(h))
 		return NULL;
 
 	spin_lock_irq(&hugetlb_lock);
@@ -4305,7 +4305,7 @@ static ssize_t nr_overcommit_hugepages_store(struct kobject *kobj,
 	unsigned long input;
 	struct hstate *h = kobj_to_hstate(kobj, NULL);
 
-	if (hstate_is_gigantic(h))
+	if (hstate_is_gigantic_no_runtime(h))
 		return -EINVAL;
 
 	err = kstrtoul(buf, 10, &input);
@@ -5192,7 +5192,7 @@ static int hugetlb_overcommit_handler(const struct ctl_table *table, int write,
 
 	tmp = h->nr_overcommit_huge_pages;
 
-	if (write && hstate_is_gigantic(h))
+	if (write && hstate_is_gigantic_no_runtime(h))
 		return -EINVAL;
 
 	ret = proc_hugetlb_doulongvec_minmax(table, write, buffer, length, ppos,
-- 
2.47.3


