Return-Path: <linux-kernel+bounces-863198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BBDBF737E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F9E3A6D78
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE1C3370FC;
	Tue, 21 Oct 2025 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0AgYNj0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976B341ABC
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058854; cv=none; b=O9BO5cywofta7d02I7G2SgZ/PD2UgtKlw1XyoIGufYobAcuxGC5BrbIVve5dmunEn3ceYJxaA3LVKr7F7rrjJysXzrqd2+bFf86RMF5HG1ijgy0SS367vPCfp/pdXmEDybgGcMsVg49GaPARAOP6eGUlxcuqX21UOZGQOD1PS78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058854; c=relaxed/simple;
	bh=OUfDv1UVoayG4u3Qm8KhKCzfykxkZrQ4CprPvtCNsMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5XETVLHac1wkcVMa8WywRoWLk5+Ab7LEV+CqxAGHS0ejlR3T47iqgnjQA6ZNVpRVylSj1nsIG7KlViPu8ilXUY2+FDMR3zV+z39wEB0d+25EGt89YT4YLjSbJh1brb0QumeSCPCn9IsCf5uesTMTcSGtN5Jx4cV92rCcKg+HoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0AgYNj0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761058851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36pQ3u8jy0FN5dn5JcBHYlI7xvHgf6+mb8fY5UQyalU=;
	b=H0AgYNj0B+fyOGA3ZEmCNHmT/Yr6ODWCjQ8zLaH4dJRcYUTKWJeoCVs2Ngs09WoKMX4qk3
	bPuv18DPlTGrFBKnyt3fQH1ifAbEURl8Cjkw60S/swd5t4eVXCtVeo3XBLbT9dEuZ/xgVs
	UydO2Plmv5A3s/z30qIe638aecB/fro=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-oAdPpvMdPFaNBlEogAilgQ-1; Tue, 21 Oct 2025 11:00:44 -0400
X-MC-Unique: oAdPpvMdPFaNBlEogAilgQ-1
X-Mimecast-MFC-AGG-ID: oAdPpvMdPFaNBlEogAilgQ_1761058843
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso3227524f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058843; x=1761663643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36pQ3u8jy0FN5dn5JcBHYlI7xvHgf6+mb8fY5UQyalU=;
        b=EzVuRNDouLPVtr8KljKv6/LpcdOoVozo67QGScDDGXf+Jh+JnrBH/gp2O8mTFiFxaz
         5esDAawtCMfq8sVCXYB+zT7cdZVctrrAiyIrnv0NvTbQvWk/Fxf24BrzYBD6lePFG1Ac
         pg1Ps90FpMbHBfJEE1BPrVTr8p+YmDtvYGAotLKym/w0t/1PD4uq8NY9nrpfSvFjMTj3
         WoKMAVTf0KZiwCtw1bCu9BzpHzE1wpSgKnEyoZP+/aa7SXsOr8+YqEq9uUceRPZJt8cb
         3YN3Mw9BBSoRIavYxyXhycsWtu0k28EW+IFN2FG/ZpOwgDBFwkUeZGw2nNsQMHJ5f+PQ
         U8bw==
X-Gm-Message-State: AOJu0Yz72+g9FMwLlFHvcYyCaB61dZnZmQvW1K/an8EopDNDe6X0bEkA
	bdKgQycfb3uEmkPQE2Wy8ptbFnbvJnhyryGwEZIdUwEsINjIiXJnSqQeRlLb+d1PSrJnB+cXwS9
	vICWTaNwvSCjlwapaIV7O4ZQ+vUhnOa/jsOYYP+32A1Q3e4qskrHyapmnYpiqHFoSkUTtFhTfIo
	HruUW6j/gafIwcdBpJyJZUUo0uTGv601bwkAPOESWKx0ar1w==
X-Gm-Gg: ASbGnctTbkcXwp0g776TDLWnouVjCn2wX0X1GuoNBt6KGbFgRHtLFKGmHQhpSAwBsZ9
	kBC17GH/6sEJneqNlAocKivkmbj8AWMqXyJmzc9Jn9Ts4dhd+daDJVzmV/VAaKL5GFIXC7RilMm
	USf+8jXFj+5Yc6R5RgOrdmQ2B2YWpg84MEUCSv+bqV3O2cySRpe+hdXMDXrCiXHNch9uybhtHBG
	FniuRh5wuAuY16sVZucm/dlJM2R6NXr7UrY2T1UZ/vi8Pc3rOcd/XhTnghT96+/FBAJhcft8pQh
	Tp903JyKKnVLojcs7ePyMkJOxikMrDYA8riRXBYXCbLbD4k16rCGEA8ASCIyuHvB3k6USfsReNR
	+HAX1l69cnL+BSf6ibUrj1EqPwfRDBsWcjry2nffLnANbbjMtcce9BLvTS1+6
X-Received: by 2002:a05:6000:2312:b0:3e7:6424:1b47 with SMTP id ffacd0b85a97d-4285324c1ecmr15566f8f.6.1761058843423;
        Tue, 21 Oct 2025 08:00:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZSHalSV1qtXRSgl0VFWeqe9iy+sxBgka0ewlzc4+wG6jRvgfqUYrrl7qKB5xy+AtSOmms8A==
X-Received: by 2002:a05:6000:2312:b0:3e7:6424:1b47 with SMTP id ffacd0b85a97d-4285324c1ecmr15477f8f.6.1761058842857;
        Tue, 21 Oct 2025 08:00:42 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5b3f5esm20480663f8f.20.2025.10.21.08.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:00:42 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 17/23] mm/balloon_compaction: remove "extern" from functions
Date: Tue, 21 Oct 2025 17:00:34 +0200
Message-ID: <20251021150040.498160-1-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021125929.377194-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding "extern" to functions is frowned-upon. Let's just get rid of it
for all functions here.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index eec8994056a44..7757e0e314fdb 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -59,14 +59,14 @@ struct balloon_dev_info {
 	bool adjust_managed_page_count;
 };
 
-extern struct page *balloon_page_alloc(void);
-extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
-				 struct page *page);
-extern struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info);
-extern size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
-				      struct list_head *pages);
-extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
-				     struct list_head *pages, size_t n_req_pages);
+struct page *balloon_page_alloc(void);
+void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
+		struct page *page);
+struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info);
+size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
+		struct list_head *pages);
+size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
+		struct list_head *pages, size_t n_req_pages);
 
 static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 {
-- 
2.51.0


