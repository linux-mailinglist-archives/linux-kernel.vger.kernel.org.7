Return-Path: <linux-kernel+bounces-834653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8808FBA530E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CBE1BC6276
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED811280338;
	Fri, 26 Sep 2025 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWeRzyO7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E1C2A1CA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758921425; cv=none; b=qjvHx0y6aUyUFLHhTvtAd9mbqne0ZkE/+qFdIXrKCZrN3EgH90rgoabWb3g/v1So7dUvyHMAs4DwWFF2G/Fi/IRixG/oBgmsUpFvA6FrUlEJjRPNdWR+vUCeFVHZjxhIagDntCQjUFbJJGDAs3PWk/Zu/ZgNHUcxt1JPFUjv93U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758921425; c=relaxed/simple;
	bh=9sCwgzh6y2cb9lH0e/ECaYhP8HV6Rg1rlFoqbazSuaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBlTmzRGo7XnZuQ+yGXKFA3tuYp5HkrysPkL2ALNp8bZL/Ty+uD+haB1AIO81WrSna8bpz8GqCVdJ2gavYuw0vto35DZOUPpvaQUNU4BEXupWoUvJZdQP4WmYw10Q5LVfTO9WegVAbjBN6fFeoaxWA8LlWDUb9nZSiBVl61QIU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CWeRzyO7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758921422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FqvR9YQdn+VFm/f2VVsLMnfIc9MZ41bG1PMJxJgeG0M=;
	b=CWeRzyO7IAAymeDWtqArCSAZvEzFTaHF/huwj74UjW7ZSM7WPrNbNgw2/vrnUb/xwnyLSY
	VcQ9iAL3yn3hf40tajA1VQi/YZTS9Yn4n1ZKqdQMvIgCLlwK1/0BMm1b2r+q7xGcRNfgBq
	vdHxPL9c9UxPXn9mgATzEuIcAla5W+4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-IHvQ6caUMA2RI4axFAFt3w-1; Fri, 26 Sep 2025 17:17:01 -0400
X-MC-Unique: IHvQ6caUMA2RI4axFAFt3w-1
X-Mimecast-MFC-AGG-ID: IHvQ6caUMA2RI4axFAFt3w_1758921421
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-856c1aa079bso564843985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758921421; x=1759526221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqvR9YQdn+VFm/f2VVsLMnfIc9MZ41bG1PMJxJgeG0M=;
        b=e14RVCRZxZLmikstfFCxVWh1jjGYQyX/xWurAd0j+dGkUN/s/jNpMsrAchE4iXuBMR
         ID776NRxScbM33TkbgbUAmPR7q+A1S6z93zV6wrNc47IalBfZQmi5SN676CFd2FDoFQb
         YMcO5DL2w+kGNPFVEvEEWl5wZrXEbU+3BWeW9Q4QR+Mf60upVBl1Pr1w/exV7Wu15aGw
         8GPcn1lmqOmew1+J3yQLOmxbEsdlp7jYT3SCvuCR4Np8uHWbChCqoNqlcv3n+MQNpOYh
         5r0oQwCE4WxcuPpWrT1KMvewEuACevEurMNgOtuLXP0x1ClgwEwa3b+d4/5dy7nwaUnp
         6p3w==
X-Forwarded-Encrypted: i=1; AJvYcCW761w/i5h84FQ3IYYbg6rPy/bV1R3t5itgknrXtsTpwVt5pR8dJFmSoRKi3lOujJU9PrO9atdWMrYlSSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUK9I+dBQW+wwapOHRELbwSSdh0bUbMA1Qo+/+hSfEPnws/Efc
	Fgqa4kzoFVAQ/mENct8iQtD3fagNt35nfcHlqnXDBN4GL/J6WM6/NYm7eGWYiEYrh4ObSbgWBwl
	i2Qo4GyhNoGeCCdkcnTaJn3hUACYCg4L94a9KSAmX9bo5MNEN7yzOyTt3I8uVFpIH/A==
X-Gm-Gg: ASbGncu4YEuFjPk8kgv+tkxdritd1MKyfxp+fI2BDHT4YbF0bMeMSap74QBpX81riAL
	Bh0AirFV/oVn7dW9uwwXTthogJz32GaWFMoQ6kZl77szJrHSAj4PD5K1XDR0RSsisYDhhAit0Fi
	qOx/seS5sl+I4k0WRk9xuYypY1wzX/JEqAY1lVrnLoyI4t9Ym8VRuG0pVuH1ke8yZoWOXGNXFJT
	zLjxMdUDHAsJ6SXjhNVeqXQ2FS9CCYXrUCH6o9dHv2yCYb1FoaatoQ1ld0Ks6+WsljqrlGEbvqV
	CFu63wCITjWaZ42jHywOMtV6wMYrAQ==
X-Received: by 2002:a05:620a:3f97:b0:828:b2ab:a50e with SMTP id af79cd13be357-86462eacc0bmr141585885a.31.1758921420828;
        Fri, 26 Sep 2025 14:17:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgGSOUpzMqnLYfIUEw5sRaIdJx67JoUnQ561pUdKycpRK3QjpqhNcQ0PgHJkIkBHHGJBGvTw==
X-Received: by 2002:a05:620a:3f97:b0:828:b2ab:a50e with SMTP id af79cd13be357-86462eacc0bmr141581285a.31.1758921420264;
        Fri, 26 Sep 2025 14:17:00 -0700 (PDT)
Received: from x1.com ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-86042e32249sm210604785a.44.2025.09.26.14.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 14:16:59 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v3 3/4] mm/hugetlb: Support vm_uffd_ops API
Date: Fri, 26 Sep 2025 17:16:49 -0400
Message-ID: <20250926211650.525109-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250926211650.525109-1-peterx@redhat.com>
References: <20250926211650.525109-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the new vm_uffd_ops API for hugetlb.  Note that this only
introduces the support, the API is not yet used by core mm.

Due to legacy reasons, it's still not trivial to move hugetlb completely to
the API (like shmem).  But it will still use uffd_features and uffd_ioctls
properly on the API because that's pretty general.

Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Acked-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cb5c4e79e0b8f..b6eb92828ee15 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5492,6 +5492,22 @@ static vm_fault_t hugetlb_vm_op_fault(struct vm_fault *vmf)
 	return 0;
 }
 
+#ifdef CONFIG_USERFAULTFD
+static const struct vm_uffd_ops hugetlb_uffd_ops = {
+	.uffd_features	=	__VM_UFFD_FLAGS,
+	/* _UFFDIO_ZEROPAGE not supported */
+	.uffd_ioctls	=	BIT(_UFFDIO_COPY) |
+				BIT(_UFFDIO_WRITEPROTECT) |
+				BIT(_UFFDIO_CONTINUE) |
+				BIT(_UFFDIO_POISON),
+	/*
+	 * Hugetlbfs still has its own hard-coded handler in userfaultfd,
+	 * due to limitations similar to vm_operations_struct.fault().
+	 * TODO: generalize it to use the API functions.
+	 */
+};
+#endif
+
 /*
  * When a new function is introduced to vm_operations_struct and added
  * to hugetlb_vm_ops, please consider adding the function to shm_vm_ops.
@@ -5505,6 +5521,9 @@ const struct vm_operations_struct hugetlb_vm_ops = {
 	.close = hugetlb_vm_op_close,
 	.may_split = hugetlb_vm_op_split,
 	.pagesize = hugetlb_vm_op_pagesize,
+#ifdef CONFIG_USERFAULTFD
+	.userfaultfd_ops = &hugetlb_uffd_ops,
+#endif
 };
 
 static pte_t make_huge_pte(struct vm_area_struct *vma, struct folio *folio,
-- 
2.50.1


