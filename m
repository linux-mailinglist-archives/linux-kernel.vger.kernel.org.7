Return-Path: <linux-kernel+bounces-853478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF085BDBC25
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB5A19A2BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632242F6168;
	Tue, 14 Oct 2025 23:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8DCFoSm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA92F0C69
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483719; cv=none; b=PM4JJ1l1LhGZE/RTJ7orKo848E4nebIHfK3C92GSC5GwC/9heDNMXOh0mAWlLsePXz0OcICCL9gRLb7+v/FmhS4p13eeabE1d1PuCABxLZdFtpWqlEPeuKlunAWRmGtg57iM2Jxz4cgzCh0DD5RwRKaUYHcxUmgCbwH5YXrKMKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483719; c=relaxed/simple;
	bh=aZx33/5rqlNp9UDxGBQwfK/fi9KyyV0EdZ+yD5Lvs5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8HzusXL+tAk0Ly51TYxbFA+NuJH5R3igD9V2M+KSZobEszHswvUZXC6eIOYdGehw3ftmRPe8v+Qng3QcghqJ/tsXgWwRa8ygdRDKEcJYpRFcMDCD5QXdyOZwsMtCcwIbngNVmOXZJQfwEsFEmj1BwABeNEEYog5JAnb6IqipIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8DCFoSm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760483716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2xV6N0kbS5NJE59pH+kAWJTSreK8cgXqd31Kd7F88k=;
	b=H8DCFoSmbYD6vUcp7dDMascBc9sPfeBjwy5xtc9H7t3fzteSrjgkItFkzm5FNrgp30f6/f
	VKAhycl2dVaxbVJgXzkNtBvFcueXruxB3s8NodqMuEE8aK6EirXAaN7pbiNvW+UwZFCBMe
	glHAk6M0KUv5AW9ePFpB6D3z+5pc5Y4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-VD4X9SLWOdCfSS5CwCPGfw-1; Tue, 14 Oct 2025 19:15:15 -0400
X-MC-Unique: VD4X9SLWOdCfSS5CwCPGfw-1
X-Mimecast-MFC-AGG-ID: VD4X9SLWOdCfSS5CwCPGfw_1760483715
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87bfeecc483so30831026d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483715; x=1761088515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2xV6N0kbS5NJE59pH+kAWJTSreK8cgXqd31Kd7F88k=;
        b=xPeonJpSmz1z+jcyvheVGu2asjGmrfXkZ4glZK5QNG4D6zjIrUKf7mq7UGozybeU3r
         ifLvGPIZBdUiRRUkf+PH5yIBWO9yQDYieatOBE6nsw5kKIrl+z6hy5taArjmnRcRK2cR
         rpye+2skgJ1ANicwjZmwnN5laufJMDHmKQgOYPWxFNbQ69J1wpD4XO3w2gMgkznLvwhc
         Pxnnkp717Fs4y9ZWh4IaT1wfbHV505hfXhqRtb/Z7DtnexnNP91qlRcKT0URmRQ3hOPy
         WDDiGXMuq8fzVa2oCEmZ/f0okozDdvo9y2+YL6qhqvHz5Hc4GtpQeox5AXaTobYT+F4O
         Dlsw==
X-Gm-Message-State: AOJu0Yy0S3ql7yLHq/1Re2nG2nayteqkv4xVFxIWl0boEh5/4KP3+JmY
	uezSUqCHXB7xlFYMeDLbmV4hxJn9jwTRvUeimwOJ1x7PiSxhgFrwCf6foj37poSQskoT9MORL/7
	klpa9JB2hUyLOGOd7HMQRpQHi45skdsepkbcFeAOUljN0LvaSv46ol9jHi8JY7fTbOzBrLxdA+Q
	ieuCECe8gNuXXWqRWmp+GVjyy44DAWt+kYMVvZPVN6AF2mGao=
X-Gm-Gg: ASbGncsMqv22kMGTh51qYWK49FirKajfiZyUurFbpNZU/pWk/KLRyCuPC6kHGWvOJQ/
	QM83zL85AWtX7cWRL0eZU68ArNSFz1LFWEEFeesTZVuWDHlOyKfVQEj1dIsYjb832DyVx58h7/R
	haEzopJW+U/zf5RBrUTzWuNpmp+z0S2c4knN/tzTTXMzqeT2Ozf6zn/0OT6NCJOkN1jjXeqrTyp
	JUGJn8o1PgusOG59zFyzMhOouuT+E74stFQiQiadc3tHRZezBsAFN5BROyIYePPA/i+IjVv9+eO
	U5sw7ZWvGikZYQW23SWEay+8bCOPzg==
X-Received: by 2002:a05:622a:4c6:b0:4b5:eb7b:2789 with SMTP id d75a77b69052e-4e6ead4825emr386564861cf.49.1760483714692;
        Tue, 14 Oct 2025 16:15:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOGy2mNK8H0gignpUFn21rppQSZq/KNciOWvEawmjMMdx22cgdQyf1hWTUzQTj+5o8RND3kA==
X-Received: by 2002:a05:622a:4c6:b0:4b5:eb7b:2789 with SMTP id d75a77b69052e-4e6ead4825emr386564001cf.49.1760483714028;
        Tue, 14 Oct 2025 16:15:14 -0700 (PDT)
Received: from x1.com ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a23693a0sm1280258685a.53.2025.10.14.16.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:15:13 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v4 3/4] mm/hugetlb: Support vm_uffd_ops API
Date: Tue, 14 Oct 2025 19:15:00 -0400
Message-ID: <20251014231501.2301398-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251014231501.2301398-1-peterx@redhat.com>
References: <20251014231501.2301398-1-peterx@redhat.com>
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
the API.  But it will still use supported_ioctls properly on the API with
all the implementations still hard coded in mm/.

Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Acked-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 657b9facba280..ad98876d338e5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5503,6 +5503,21 @@ static vm_fault_t hugetlb_vm_op_fault(struct vm_fault *vmf)
 	return 0;
 }
 
+#ifdef CONFIG_USERFAULTFD
+static const struct vm_uffd_ops hugetlb_uffd_ops = {
+	/* _UFFDIO_ZEROPAGE not supported */
+	.supported_ioctls	=	BIT(_UFFDIO_COPY) |
+					BIT(_UFFDIO_WRITEPROTECT) |
+					BIT(_UFFDIO_CONTINUE) |
+					BIT(_UFFDIO_POISON),
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
@@ -5516,6 +5531,9 @@ const struct vm_operations_struct hugetlb_vm_ops = {
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


