Return-Path: <linux-kernel+bounces-762509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A51DB207C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DC23A2C52
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3072D46D9;
	Mon, 11 Aug 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUjMLlNS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812142D321F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911615; cv=none; b=qqSspqG0vXskI10cebh2KIPTxbdJ7H8X1dXWT9lmT/JUiJlgL51hEyMkC4YKOB1mylWW00ujNKYmlwVPOJVfkpmDJRUCuPlUm0vjvBDXgWvAkMhVQNjYZ6cQhaNdIa+rq5dZPJZ+xWaGqDoBv2HKBiaAv9qo2Rh8yk2De3FNNKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911615; c=relaxed/simple;
	bh=5bTAXo4Wnbsgm2C4LriAvbtI/44w1uQqyTmK51I8pv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEuQcmES1xmw6zNoH+iFxk8+BkSj+rw1H29CEc5EJx2zFaYye6chNJpEmToCgot4rag2xVCHzafr6PsaHVFbgJB+g0WmqNIVQA6IfXvqzHP1IuQozprnTTs87/P3mEuXvrD6LRTdbBBqsfjcazWzR1zHH8MITPEWT8ZHwY0tEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUjMLlNS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754911612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJDg4sW92zbLWKqBjb1tVZssT9gBBixv5gdvUlii8Zs=;
	b=XUjMLlNSncT0cLxCT9SU/uEGpJOcBdJB0j8Mv5cQTzi9e9vbJTPA3q1oCPvxqwW2QC2SZY
	K9Jsbad+gPXa3wsz+YLFyNaal53KDL6k4E8YaZ99UodAi6VX7BxDe/U/IQLDGyDuqizb25
	GjTV9SQ07rGN6rxPnJ6CDXCkMG2BCkw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-f-XtAeLXMB2awysJbAYQ7g-1; Mon, 11 Aug 2025 07:26:51 -0400
X-MC-Unique: f-XtAeLXMB2awysJbAYQ7g-1
X-Mimecast-MFC-AGG-ID: f-XtAeLXMB2awysJbAYQ7g_1754911610
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b604541741so2205126f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911610; x=1755516410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJDg4sW92zbLWKqBjb1tVZssT9gBBixv5gdvUlii8Zs=;
        b=hQ6F54AXSIXkcSr1f44807XONxnGKQL1jCzj09sFnupBK1Z3pufP+90qWDeFq8N2uk
         cQ4QyqXu+YVHfwEGpmF/V6QWaHNpeXCGmbVugCKpyl1GxBAQaa187kDdge9iZJ0ELYJH
         oTUgLDFggYjy1h5A2RH8kHHIMhbKCGwLLB1RJzLjIeKx84F1K74GjVuqCYn96YKOVBkd
         f7wRXwTOpjoZD01O+BxEYbCZ+SLa/VXi2B1kbAg/U7WMcBr1Vd2owM1Mb9DzLH8FTA0d
         589tPQZWMHXHuFectS+Zm2P5LzYbX9o/+6jh1oqIy4vB61/9gM/yJg5/nyMqpnTlsb+o
         Isjw==
X-Gm-Message-State: AOJu0YzKlVtMwU+y7JSDailgfBVIhXGuWUHBpbgnQclUDq33mIRftaby
	pWv+MhzgZlD4MnJlElBHPTkhNZVVfZhXD0/3sE2KIVxMd55woDhAmXnMe3XiapZjwVhtoZ1BCBQ
	MfikJgeypbt9xQq/V6GQ6H7feLIGSniQ5cn3TfQL0edR620L0h7LcHDkTB1AeraAM1WXrUqkwbp
	2Ss6qMD0fibv5RCVpBiYjA7qnuBngH/efI7+aGcbJ6m/3FKw==
X-Gm-Gg: ASbGncuTQmP8mQ78LGu2utPmEtdTuVveTZ04qugEdZu5eO5+LGZV36UNZTA7o/mcHmz
	9FSDQpEIvp3YtBMO32mt5YbUZapvWnxHEC53Q8vmRGHhgaf/NU0n2MzeGGdZam03LAPr8cJ0R40
	iLqHKBv9rw1xHQfgEg2uL988P5DvH2ckQAmhMJZawqMUW79lPyjD8Q7tbQNbEcAOvWIZ+uASl+0
	sjQFgSwVI/JLYwlBA8SJ3Joiuz3i90hw5hwPeHwH6EIWQt7G0dWq1i1UUMB7IVgT6iyX/xSTtbw
	7zeCwuA65L3A8XE64naE0uqIRp4zlQRhpieITnAG88uCSwLuOQTaWPoy80qfsz8OHVxBBeVpWI+
	MgaCG8JI+Wo3/w7FenoS7e3pB
X-Received: by 2002:a05:6000:2010:b0:3b7:9d83:5104 with SMTP id ffacd0b85a97d-3b900b83ce4mr10356654f8f.51.1754911610221;
        Mon, 11 Aug 2025 04:26:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH28XXBuV6P4eMmACbygagN9E2w90dcNlvtCQwFebmNkdYsSnJof6QrfGHsOh8VfCIdvok2gg==
X-Received: by 2002:a05:6000:2010:b0:3b7:9d83:5104 with SMTP id ffacd0b85a97d-3b900b83ce4mr10356583f8f.51.1754911609552;
        Mon, 11 Aug 2025 04:26:49 -0700 (PDT)
Received: from localhost (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3bf93dsm40408983f8f.27.2025.08.11.04.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:26:48 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v3 06/11] powerpc/ptdump: rename "struct pgtable_level" to "struct ptdump_pglevel"
Date: Mon, 11 Aug 2025 13:26:26 +0200
Message-ID: <20250811112631.759341-7-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811112631.759341-1-david@redhat.com>
References: <20250811112631.759341-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to make use of "pgtable_level" for an enum in core-mm. Other
architectures seem to call "struct pgtable_level" either:
* "struct pg_level" when not exposed in a header (riscv, arm)
* "struct ptdump_pg_level" when expose in a header (arm64)

So let's follow what arm64 does.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/mm/ptdump/8xx.c      | 2 +-
 arch/powerpc/mm/ptdump/book3s64.c | 2 +-
 arch/powerpc/mm/ptdump/ptdump.h   | 4 ++--
 arch/powerpc/mm/ptdump/shared.c   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/8xx.c b/arch/powerpc/mm/ptdump/8xx.c
index b5c79b11ea3c2..4ca9cf7a90c9e 100644
--- a/arch/powerpc/mm/ptdump/8xx.c
+++ b/arch/powerpc/mm/ptdump/8xx.c
@@ -69,7 +69,7 @@ static const struct flag_info flag_array[] = {
 	}
 };
 
-struct pgtable_level pg_level[5] = {
+struct ptdump_pg_level pg_level[5] = {
 	{ /* pgd */
 		.flag	= flag_array,
 		.num	= ARRAY_SIZE(flag_array),
diff --git a/arch/powerpc/mm/ptdump/book3s64.c b/arch/powerpc/mm/ptdump/book3s64.c
index 5ad92d9dc5d10..6b2da9241d4c4 100644
--- a/arch/powerpc/mm/ptdump/book3s64.c
+++ b/arch/powerpc/mm/ptdump/book3s64.c
@@ -102,7 +102,7 @@ static const struct flag_info flag_array[] = {
 	}
 };
 
-struct pgtable_level pg_level[5] = {
+struct ptdump_pg_level pg_level[5] = {
 	{ /* pgd */
 		.flag	= flag_array,
 		.num	= ARRAY_SIZE(flag_array),
diff --git a/arch/powerpc/mm/ptdump/ptdump.h b/arch/powerpc/mm/ptdump/ptdump.h
index 154efae96ae09..4232aa4b57eae 100644
--- a/arch/powerpc/mm/ptdump/ptdump.h
+++ b/arch/powerpc/mm/ptdump/ptdump.h
@@ -11,12 +11,12 @@ struct flag_info {
 	int		shift;
 };
 
-struct pgtable_level {
+struct ptdump_pg_level {
 	const struct flag_info *flag;
 	size_t num;
 	u64 mask;
 };
 
-extern struct pgtable_level pg_level[5];
+extern struct ptdump_pg_level pg_level[5];
 
 void pt_dump_size(struct seq_file *m, unsigned long delta);
diff --git a/arch/powerpc/mm/ptdump/shared.c b/arch/powerpc/mm/ptdump/shared.c
index 39c30c62b7ea7..58998960eb9a4 100644
--- a/arch/powerpc/mm/ptdump/shared.c
+++ b/arch/powerpc/mm/ptdump/shared.c
@@ -67,7 +67,7 @@ static const struct flag_info flag_array[] = {
 	}
 };
 
-struct pgtable_level pg_level[5] = {
+struct ptdump_pg_level pg_level[5] = {
 	{ /* pgd */
 		.flag	= flag_array,
 		.num	= ARRAY_SIZE(flag_array),
-- 
2.50.1


