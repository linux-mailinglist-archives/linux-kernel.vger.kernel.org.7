Return-Path: <linux-kernel+bounces-754388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6345EB193C6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 13:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D389F3B8D8F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 11:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1380B244662;
	Sun,  3 Aug 2025 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b="bX0Ss5qy"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7055464E
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 11:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219392; cv=none; b=KB7fn9Pu3YTtY4KeP20r5ZAykr6eWPYvELQzGzf/gDkA9bdtpkPB38LyWbBfxhmDJP3g43bKfRBqzonZsFkrYD6hcHnxitlfIay3yOHEU+oXcaZiPXugqfoskQTyB4R9osHYonTPSHbOFZPBpnsQVr55aD2Yos0RPm+IPhxMmNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219392; c=relaxed/simple;
	bh=umnoQPA6LtY/ct25HhtQ/YqOQKI2kbNOJBw5+65dlx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=f1PONeqdJ6YvV3Wt47B2ytkviAYQNw+04DDFIe8Sc8x1fk+kUqTCZhVhSkKqnlKyKoO3ZIZfGM5+vkY3rhcN3eM0tMu6+La1aJzSB4HBTw8acwXPLGPRn/NvIw61XxzMj+WtMKpmb9tt8MUaNshkEt5fZn39K7Sagcw6Z7r+EB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com; spf=pass smtp.mailfrom=infinidat.com; dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b=bX0Ss5qy; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinidat.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70749d4c5b5so31518076d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 04:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat.com; s=google; t=1754219389; x=1754824189; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kpZ0Pw1nPQOd+/0U6IoZuKEq0WcxQdvHRhbbA6toWQ4=;
        b=bX0Ss5qy1zHjCyq9w3GXqWB+oMU5FIQuEN3Ct2+nTw5uW7oSqC2KmJ/DJE+BS3yk1O
         fyM+9gpCCodul1x1U6rwYCsEhNq+dnwzjWeO+mg96pObfrSM2KQ6HspHYAvUKIiEwNnB
         +uTmonL45DF8yp4OLIP462/R6AXf6Qf5y38d97lOI5CSmTzo3PHNAbAX+hMZJIDc5P+3
         0A9g+On6L32Sedmj3ze/yIQV2Pnu6mtCAAgicce6PzSRDAK2dO98a6izwRzsz1uZJE0g
         R63jHa7gh9L2f1nAOdQT+l/mKmzSM64XsU73IdRFYgL9r50xoUMeEeoYjYnzL+jACX2C
         sJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754219389; x=1754824189;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpZ0Pw1nPQOd+/0U6IoZuKEq0WcxQdvHRhbbA6toWQ4=;
        b=S+oJ3YkLGKHtaE9MoESCplJxCo3XhhGneqCDUWFU84sGrQ4qtFcaNUZIaozpt9MfTB
         EZwNPVPq1/clImss2av6mlWFs37FhkblNc6KcghwH0Qvj/W6R4v126yZjHC95LswciVe
         rOzb8Ok1zq7c0FCKOEqXLZtRa/bbE/wjR6vM02Inz+W3Sq5S6KHkQ+3tf5o/vj3Fhbek
         HzUDnuuBhaSPUFzCjn/G3S83hPs26p0JvmLy1AT4lpNQLW2Q6OXx4M88quGDe974+xEq
         hwvTEszpuom8/XHFU+6yBT0JzaR8FJwt1iXEomvGdCtRygOjUBZS8ukRBzr9EtjhDKm4
         cxRw==
X-Gm-Message-State: AOJu0YxgnRbtCjrE0WioH1UcWzu3OOHiDuNM7Vry3ulge3eKEPTpnU77
	I8TfKEV2zcIQDl30JeCWCJWcDaIzHIRngGBRJbN7k/tFJxU2Z2fb8xLOLfcFwnKMTMNfGmte/p/
	HjQ4n46CpMj4l7DyHZAbnUU406eIC0CSK458iO6mzlFMHmN9VaTej4+A=
X-Gm-Gg: ASbGnctKqpS9FflL5tdChBqx1TqnpaTYBstgxFdNevwWFwSBrEF0zrU2QDLxnqp2NJM
	IEXgQ9QPl4ccUmoaJBilbibyLQIpf7OLekFY2vr0GwbtLY+czTSb8bJSEaO4LHFjviebxEoFdWx
	zYdM06ImWrbQL5+d+f3JOmih7C4/vk/JxUaxb7ZCgBzgDKSoRtb6+wzLql8IMKGvR1GSvWPFPrF
	Lcesh0Uuw==
X-Google-Smtp-Source: AGHT+IGE4v11vfh/p98G0AG/vF2vC9cU6z5JShu0YvJhCEikzGPxtEmcHa0xRmO4KkK939iTeptMMaQHPY4nddfiyU4=
X-Received: by 2002:a05:6214:262b:b0:707:4539:5183 with SMTP id
 6a1803df08f44-70935ea93cfmr80164306d6.5.1754219389258; Sun, 03 Aug 2025
 04:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEHaoC2BWe+0Ps2oU-0xPDLFYYKG-o9+_ynFgh7u3qqyRDtrTg@mail.gmail.com>
 <CAEHaoC22NDpHUWovJChCx_XqchkEvUPYrFFe_L1PH9Mw2e386A@mail.gmail.com>
 <CAEHaoC2bi3VUEuoWKgHbgUFfdxmACrhkjaQ9Jni-4-ByP5tYJg@mail.gmail.com> <CAEHaoC3ZMvHe7D-JX9bfM9hfSPs0QV-og=om5eKFFqSL=tpjcw@mail.gmail.com>
In-Reply-To: <CAEHaoC3ZMvHe7D-JX9bfM9hfSPs0QV-og=om5eKFFqSL=tpjcw@mail.gmail.com>
From: Constantine Gavrilov <cgavrilov@infinidat.com>
Date: Sun, 3 Aug 2025 14:09:38 +0300
X-Gm-Features: Ac12FXw6TPdY1mrvZH4xW6Is3NOum7wEeYjPg6bpbuTEJ7S6z3Br-xeYsxW2C_0
Message-ID: <CAEHaoC0Au_0yLRKSnDg=_qjnmDMmbJ=Nff+W1feEBTib0Jb_gA@mail.gmail.com>
Subject: [PATCH 3/8] Large DMA alloc/add busy_regions sysfs attribute
To: linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

  This is the fourth patch from the set of patches that enable large IOMMU
DMA registrations. Entire work is available at the master branch of the
master branch of git@github.com:cgavrilov/linux.git repo.

Add busy_regions SYSFS attribute to IOMMU group. This allows to see used
addresses and debug failed allocations.

commit b01feb650dc080f268adb5ff26bda1b9bf2193a1
Author: Constantine Gavrilov <cgavrilov@infinidat.com>
Date:   Wed Jun 25 19:49:16 2025 +0300

    Add busy_regions sysfs attribute to IOMMU group.

    This attribute shows allocated DMA regions for the group.

    Add exported function iovad_show_busy_regions() to allow other
implementations.

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0b7537e9812f..6ba9be4fb64d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -761,6 +761,14 @@ static iova_align_t
dma_info_to_alignment(unsigned long attrs)
     return align;
 }

+ssize_t iommu_domain_show_busy_regions(struct iommu_domain *domain, char *buf)
+{
+    struct iommu_dma_cookie *cookie = domain->iova_cookie;
+    struct iova_domain *iovad = &cookie->iovad;
+
+    return iovad_show_busy_regions(iovad, buf);
+}
+
 static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
         size_t size, u64 dma_limit, struct device *dev, iova_align_t align)
 {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a4b606c591da..5daeb86a4aef 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -34,7 +34,9 @@
 #include <linux/sched/mm.h>
 #include <linux/msi.h>
 #include <uapi/linux/iommufd.h>
-
+#ifdef CONFIG_IOMMU_DMA
+#include <linux/iommu-dma.h>
+#endif
 #include "dma-iommu.h"
 #include "iommu-priv.h"

@@ -927,6 +929,19 @@ static ssize_t
iommu_group_show_resv_regions(struct iommu_group *group,
     return offset;
 }

+#ifdef CONFIG_IOMMU_DMA
+static ssize_t iommu_group_show_busy_regions(struct iommu_group *group,
+                         char *buf)
+{
+    if (!group->domain)
+        return 0;
+
+    return iommu_domain_show_busy_regions(group->domain, buf);
+}    int off = 0;
+
+
+#endif
+
 static ssize_t iommu_group_show_type(struct iommu_group *group,
                      char *buf)
 {
@@ -962,6 +977,11 @@ static IOMMU_GROUP_ATTR(name, S_IRUGO,
iommu_group_show_name, NULL);
 static IOMMU_GROUP_ATTR(reserved_regions, 0444,
             iommu_group_show_resv_regions, NULL);

+#ifdef CONFIG_IOMMU_DMA
+static IOMMU_GROUP_ATTR(busy_regions, 0444,
+            iommu_group_show_busy_regions, NULL);
+#endif
+
 static IOMMU_GROUP_ATTR(type, 0644, iommu_group_show_type,
             iommu_group_store_type);

@@ -1049,6 +1069,15 @@ struct iommu_group *iommu_group_alloc(void)
         return ERR_PTR(ret);
     }

+#ifdef CONFIG_IOMMU_DMA
+    ret = iommu_group_create_file(group,
+                      &iommu_group_attr_busy_regions);
+    if (ret) {
+        kobject_put(group->devices_kobj);
+        return ERR_PTR(ret);
+    }
+#endif
+
     ret = iommu_group_create_file(group, &iommu_group_attr_type);
     if (ret) {
         kobject_put(group->devices_kobj);
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 41d5d34fcc33..96144c58b386 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -280,6 +280,37 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
 }
 EXPORT_SYMBOL_GPL(alloc_iova);

+/*
+ * Helper function to output allocated regions to a buffer.
+ * Can be used as a show function for a sysfs attribute.
+ * buf is page aigned buffer of PAGE_SIZE.
+*/
+ssize_t iovad_show_busy_regions(struct iova_domain *iovad, char *buf)
+{
+    int off = 0;
+    struct rb_node *curr;
+    struct iova *curr_iova;
+    unsigned long flags;
+    unsigned long shift = iova_shift(iovad);
+
+    spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+    curr = &iovad->anchor.node;
+    /* skip ancor node, it has pfn_hi = pfn_lo = IOVA_ANCHOR = -1LU */
+    curr = rb_prev(curr);
+    while(curr) {
+        curr_iova = rb_entry(curr, struct iova, node);
+        off += sysfs_emit_at(buf, off, "0x%016lx-0x%016lx\n",
curr_iova->pfn_lo << shift,
+            ((curr_iova->pfn_hi + 1) << shift) - 1);
+        curr = rb_prev(curr);
+        /* do not iterate further if the page is full */
+        if (off >= (PAGE_SIZE - 38))
+            break;
+    }
+    spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+    return off;
+}
+EXPORT_SYMBOL_GPL(iovad_show_busy_regions);
+
 static struct iova *
 private_find_iova(struct iova_domain *iovad, unsigned long pfn)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 156732807994..5fe92c00221d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1511,6 +1511,7 @@ static inline void iommu_debugfs_setup(void) {}

 #ifdef CONFIG_IOMMU_DMA
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
+ssize_t iommu_domain_show_busy_regions(struct iommu_domain *domain, char *buf);
 #else /* CONFIG_IOMMU_DMA */
 static inline int iommu_get_msi_cookie(struct iommu_domain *domain,
dma_addr_t base)
 {
diff --git a/include/linux/iova.h b/include/linux/iova.h
index e35762c0acdb..c09d224cce2b 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -91,8 +91,12 @@ void __free_iova(struct iova_domain *iovad, struct
iova *iova);
 struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
     unsigned long limit_pfn,
     iova_align_t align);
+
 void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,
             unsigned long size);
+
+ssize_t iovad_show_busy_regions(struct iova_domain *iovad, char *buf);
+
 unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
                   unsigned long limit_pfn, bool flush_rcache,
iova_align_t align);
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
@@ -120,6 +124,11 @@ static inline void __free_iova(struct iova_domain
*iovad, struct iova *iova)
 {
 }

+ssize_t iovad_show_busy_regions(struct iova_domain *iovad, char *buf)
+{
+    return -ENOTSUPP;
+}
+
 static inline struct iova *alloc_iova(struct iova_domain *iovad,
                       unsigned long size,
                       unsigned long limit_pfn,

-- 
----------------------------------------
Constantine Gavrilov
System Architect and Platform Engineer
Infinidat
----------------------------------------

