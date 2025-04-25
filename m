Return-Path: <linux-kernel+bounces-619737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E3FA9C0BC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 10:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C376446218A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 08:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0CB2356B9;
	Fri, 25 Apr 2025 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWUSD4fV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90B233707
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569051; cv=none; b=mYwLMflvL7WY2+coGDMcCK1DiY6BwfLJyMYJUYro4rtd4C0f0yyr1pq+5IsbORMqwyHz2TzWMPOr56wTtHtIzQRqRCBLPFqTgXrY6liVPxi1gngGMPBUtyT8QPXnNX9f/Pdw1pFYbB1ODps2yluvqQo3yGAp/JVX8M2PX52CBoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569051; c=relaxed/simple;
	bh=eykL+iUZBmhrQjrl63IlsUE+hE0bFmZCe3pannV5u/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANN0+jVV2z1IcEMgZbihG4gcGdM1F5gudxGzlVgZ6Sc+MsWe6dqm7/6gD9xjH5Fm3kyu0vBu/ngFvdWxq0IpKbZupmEyMdRFn8Q5WqZAr6/X/v1x71oN/MUovp5G2N6tKFtndmhudqLZIe5yTqhiGa8ywUnn+3YJ2FEVgvKlimc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWUSD4fV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745569048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KCYBdpwfjCOhXvT2DzVINMJSRWNfDi2B6w/Q4Y3NEy8=;
	b=PWUSD4fVw4QjiDqPdZZ1adq5uxDAfuPl7J0nVJwAGORQfODY13u+KvOIWckgv0PpwCJdNB
	YGzDp75tH/CpP6KNIRrCImzt6h15OBv2wYkD6M5374kNmzJza2pz5+uj1CslHDaUjgQO1z
	djlgzICTo6KIXzFA0yVqyvKDnXtDyhY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-UqtBvTnNMR-csDG0NGyKxw-1; Fri, 25 Apr 2025 04:17:27 -0400
X-MC-Unique: UqtBvTnNMR-csDG0NGyKxw-1
X-Mimecast-MFC-AGG-ID: UqtBvTnNMR-csDG0NGyKxw_1745569046
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39c2da64df9so989379f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 01:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745569046; x=1746173846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCYBdpwfjCOhXvT2DzVINMJSRWNfDi2B6w/Q4Y3NEy8=;
        b=fH0eDDSnSUbzaqbXGik1oT7RJqNSbQSlvgPREIuvgdA9H5RtHlTc8DDA/Lu81pcdGu
         2ZZZo1EqQ6H1lonI9dRlOwG7M993btd9iBS25hS2mGapvzEmw00nQhxw+ad1FnxzjoPu
         1qwXVt0YcIVCbGMaEJSFCeVlk5g+LPeKVrMqUYzq/Np7mzlFEjz/rHbP5U0xXlcSsnG2
         1tO8Amy/Q8wM69ATljnoeLJCm30Db7RNq7M7PPMv7EKOEEsPqDW36H5vg2hgKaVM/Z5z
         twCbQlsRh7XImPjSquBfCOjPrF4MaBgzuYSXF8v3x0lVhyN5cTYWon7UHXPB4HXymYhv
         Nffw==
X-Gm-Message-State: AOJu0YxRDZrIKYJj0mCv4ZoKQ2s2rIzOID7L4ZKuA1j5ArDn1PlVS/BB
	P92lqtFyWtD7krs+KqUHDGFEWd9NST+BwQtQ1qJdDS4SBx4EtMWQI256FZBzg9hrSXYNI4gluxv
	hnZeareasBXSOQlzCvh8g9mLmZBJNCPEOKLiZaFSWOk9PCZO/Q1sPR5OedTQ90xNaDMQaocBBQC
	KRfrJQNU7Ff1GywNr0FgqlQ373ZBngt4aZvoeGfILjNQ==
X-Gm-Gg: ASbGncvBqdFnPFK1PS0cvZaqf+QI0IMPmzrISaEemUV9sv+jqUl0Satb3ivFev3nEGx
	4W1B8YvgaSkai+QjvtkwtF6op7T9+f/AfXyqZeh+xVVrHj6FQ7vWgbh9LYX6NSH/RAjDEi/R4Np
	ZcpL2Fy/KFI4bq+6cXiYsSOQ2JrZgBzDupPB4dI1lGdzO5evhu1tv8aWqL3LwVFoewj5LItJYTN
	KMj3Sk2S0MKkSW0B8TJ+wWYM2H37OAiHUjzFExAz3/BbFC72p1nsVAmK7xKoUXConuGujsSKF0J
	TJOc+f3ukiH5NNjh4v9JR8gYyXuYP7KFatT7yw38808DdM+0cetaXeoal9QDCFK2p3e3KUo=
X-Received: by 2002:a05:6000:2903:b0:39e:cbc7:ad33 with SMTP id ffacd0b85a97d-3a074e1eb67mr881039f8f.21.1745569045989;
        Fri, 25 Apr 2025 01:17:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrgRXf9wKgkj7MYbnIuzIHmMlVWh7AZlbAu3PZR/ooKrImfXiUSMtbZSGOay0ZI4PJDGOvtg==
X-Received: by 2002:a05:6000:2903:b0:39e:cbc7:ad33 with SMTP id ffacd0b85a97d-3a074e1eb67mr880983f8f.21.1745569045483;
        Fri, 25 Apr 2025 01:17:25 -0700 (PDT)
Received: from localhost (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de. [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073c8ca72sm1597057f8f.4.2025.04.25.01.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 01:17:25 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	x86@kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v1 03/11] x86/mm/pat: introduce pfnmap_track() and pfnmap_untrack()
Date: Fri, 25 Apr 2025 10:17:07 +0200
Message-ID: <20250425081715.1341199-4-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425081715.1341199-1-david@redhat.com>
References: <20250425081715.1341199-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's provide variants of track_pfn_remap() and untrack_pfn() that won't
mess with VMAs, to replace the existing interface step-by-step.

Add some documentation.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/pat/memtype.c | 14 ++++++++++++++
 include/linux/pgtable.h   | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 193e33251b18f..c011d8dd8f441 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -1068,6 +1068,20 @@ int pfnmap_sanitize_pgprot(unsigned long pfn, unsigned long size, pgprot_t *prot
 	return 0;
 }
 
+int pfnmap_track(unsigned long pfn, unsigned long size, pgprot_t *prot)
+{
+	const resource_size_t paddr = (resource_size_t)pfn << PAGE_SHIFT;
+
+	return reserve_pfn_range(paddr, size, prot, 0);
+}
+
+void pfnmap_untrack(unsigned long pfn, unsigned long size)
+{
+	const resource_size_t paddr = (resource_size_t)pfn << PAGE_SHIFT;
+
+	free_pfn_range(paddr, size);
+}
+
 /*
  * untrack_pfn is called while unmapping a pfnmap for a region.
  * untrack can be called for a specific region indicated by pfn and size or
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 91aadfe2515a5..898a3ab195578 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1506,6 +1506,16 @@ static inline int pfnmap_sanitize_pgprot(unsigned long pfn, unsigned long size,
 	return 0;
 }
 
+static inline int pfnmap_track(unsigned long pfn, unsigned long size,
+		pgprot_t *prot)
+{
+	return 0;
+}
+
+static inline void pfnmap_untrack(unsigned long pfn, unsigned long size)
+{
+}
+
 /*
  * track_pfn_copy is called when a VM_PFNMAP VMA is about to get the page
  * tables copied during copy_page_range(). Will store the pfn to be
@@ -1570,6 +1580,29 @@ extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
  */
 int pfnmap_sanitize_pgprot(unsigned long pfn, unsigned long size,
 		pgprot_t *prot);
+
+/**
+ * pfnmap_track - track a pfn range
+ * @pfn: the start of the pfn range
+ * @size: the size of the pfn range
+ * @prot: the pgprot to track
+ *
+ * Tracking a pfnmap range involves conditionally reserving a pfn range and
+ * sanitizing the pgprot -- see pfnmap_sanitize_pgprot().
+ *
+ * Returns 0 on success and -EINVAL on error.
+ */
+int pfnmap_track(unsigned long pfn, unsigned long size, pgprot_t *prot);
+
+/**
+ * pfnmap_untrack - untrack a pfn range
+ * @pfn: the start of the pfn range
+ * @size: the size of the pfn range
+ *
+ * Untrack a pfn range previously tracked through pfnmap_track(), for example,
+ * un-doing any reservation.
+ */
+void pfnmap_untrack(unsigned long pfn, unsigned long size);
 extern int track_pfn_copy(struct vm_area_struct *dst_vma,
 		struct vm_area_struct *src_vma, unsigned long *pfn);
 extern void untrack_pfn_copy(struct vm_area_struct *dst_vma,
-- 
2.49.0


