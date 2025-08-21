Return-Path: <linux-kernel+bounces-780556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744B0B30401
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1C2A7BE152
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F902C0275;
	Thu, 21 Aug 2025 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSkau4t7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C4A3DABE3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806849; cv=none; b=pqTO5pT9qpe8fO31sXsaJr+5O2kxBAhCtusQ/HAwwSUNJ5jtWCoPvnCAIHeZ7OJZ8G84c0+rtDtdwsZ7lh9fer2wfiYAkU9Zmjk2U/DkD/FLHBIG5CctqwDnTER5/C3REboiQL+uaDlKxM9BjkPKuvBsBtTCQ3UkpjDiuS4agxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806849; c=relaxed/simple;
	bh=Cw7Tggvlta2Xmlg9ZVygUv1C92bk8NKTD0n9SH6aeIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRf/Qrv6elxW1FwPiUC7OXdB9DsbvDPd9ZFZdHlS/bX9e7iKUmQtXJLPutXUxFETaIGuxnkmTBti3jKXhbITctUUoDEqsG4QtUBUoxH+JDXmSQW7v5axd/rOsTQsTHTHvLnZvdmGD2xkxq9JUfZA4pgFu4KKPw1h/GAjTC4fZ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSkau4t7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iU84NUWejaBSUFBs/T0/O04YrYLlq1RcxZMywEFGjU0=;
	b=aSkau4t7gl41BThKEJ5GfrLlPH0vOD6I290zx6Xt00rjOUMB6kw4cIGo/ewGOF62/4cZio
	lrLfuicnQFJrlDZtozJLfRqDyRf4omcCNNuuDrx/xTwJWCxAgif5lNagJ5Ec+Z8+oSiva6
	AJyCsYpLnbXo/TD62n/gopd7ZgbKZGo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-yjuVMIiUPqW6ldaolHXhyA-1; Thu, 21 Aug 2025 16:07:20 -0400
X-MC-Unique: yjuVMIiUPqW6ldaolHXhyA-1
X-Mimecast-MFC-AGG-ID: yjuVMIiUPqW6ldaolHXhyA_1755806839
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b05b15eso10515455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806839; x=1756411639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU84NUWejaBSUFBs/T0/O04YrYLlq1RcxZMywEFGjU0=;
        b=DQjnGtQQASKLHFjyXmDo+jAEZ4eSf0aZf0QG57KsoF0lWv2JIMDou/e2FAy/8bKAIK
         312AbljMtvQv1d4ShDNt8tzr0t+d3u3bR/WCXonQJ2JLSjhlMuKkLlAsJcG1CozUairN
         Ipfi+zfvqglVGvhJWZiFdg5HXHEUWI9c9xT5Lc/YiQ0SW7lWsPLp7yH4oY9EtSztNEa1
         zeZpBEB/dkSxrVi8h64rBd9cZJu51V3vTgem5Zhisviqc4U8JT+BDfC0VYbmo3DmzdCo
         +OaLY06UtkkOOf+bGJItzKFu8G3HhWiYz8Jx3o+a0BWrMA5TpUgGePDS2Y+/iw+Kz3Fm
         FStw==
X-Gm-Message-State: AOJu0YxIEJ8NBntzBIFX0ZczRqhlfqR5eUHpNFBeho2IEVENX3HEm7/n
	QzpX5312SkCHw3nXc4J14gNEstOEhC23Ceuhfcxg2Op08w2o/LlxqPVwxVB5OaWHEmBIsoqYMbq
	OPqwy3lmGWaFR6Pq4KBsVN1Me1SVlZSs5NB3WG2dHBn89TwrsttnCiIQP5B385947l4S2TMWieL
	eYDBnUBm1FtLa758kFil+cFSvdzAKnO6NUQaWzzOy5pqTytLiQ
X-Gm-Gg: ASbGncsDV0a+/1XCba2Xv2/Jx+bUdzKoG7PTFfiARW0ibJPR5o9TyQGUE+96u3APMtS
	KegEQWR8puFzojQg08HwjBSehHm+RB/LcYvU+jRbP3VF4PvpamV7RIWG387jbr9oU3D7YxX3Ibn
	0WZY1j2+JccYbn+EyaL5AqQFow1sK4moBUtkWeN8OfOQMFvNZRjya/eqHqizECoIz60qG69UuQy
	AZH9rZFj1cuvSXh4SWjpkF9lyNQnm0PukDgpMxMo5D8IuRAJpf3gaOSWft5eVAAjehSrB34dvEy
	LRjMJ7ZX/SzKYKlzxkAbsk2riUNr2MAIsoclB0dxk4I2jM2Pzvd2GzEW4AMhSSthqlPhlOTMH9I
	O5hfEqr0mAM0nI5D1kX697Q==
X-Received: by 2002:a05:600c:1f95:b0:459:db80:c2ce with SMTP id 5b1f17b1804b1-45b51799428mr2845895e9.7.1755806839135;
        Thu, 21 Aug 2025 13:07:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMhnqxttMNkrL8PAxIX9Mfq64uKkvY2MjzJ39LtAH2Yg7PxwVl8kOZ6CXLaaMF5rYTxrWwyA==
X-Received: by 2002:a05:600c:1f95:b0:459:db80:c2ce with SMTP id 5b1f17b1804b1-45b51799428mr2845125e9.7.1755806838506;
        Thu, 21 Aug 2025 13:07:18 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dea2b9sm8988005e9.15.2025.08.21.13.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:18 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 04/35] x86/Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
Date: Thu, 21 Aug 2025 22:06:30 +0200
Message-ID: <20250821200701.1329277-5-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now handled by the core automatically once SPARSEMEM_VMEMMAP_ENABLE
is selected.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100e..e431d1c06fecd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1552,7 +1552,6 @@ config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_STATIC if X86_32
 	select SPARSEMEM_VMEMMAP_ENABLE if X86_64
-	select SPARSEMEM_VMEMMAP if X86_64
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool X86_64 || (NUMA && X86_32)
-- 
2.50.1


