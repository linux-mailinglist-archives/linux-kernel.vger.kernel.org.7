Return-Path: <linux-kernel+bounces-712543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5FEAF0B13
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 08:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D77C77B00DD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 05:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F381F5820;
	Wed,  2 Jul 2025 06:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJ4bxkv1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACE61A2C04
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 06:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751436059; cv=none; b=WvGntwh38smK6T716BPFWIdrcj+7ROPxczEYAUIPeCt73qiBH+hX+eW9+eLFQ4+xoMUpEsgqDRXJdpB+I7oAE6n3wDH8V668gefBvjiKQrtD+oe1jfrCI6Q27Qm3aR5W0ato8iNW0vCYhnlB7rTuD2HfD45y2y9MQFlaDMjKWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751436059; c=relaxed/simple;
	bh=4gUo5mhAQoIRF3zDizyxmkFzfYyi85yyGqjfCEGTlIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ag83A58VWFNmrr5g9bYW4+cI+SP/XvAiwhH4E0QwaRG+dYp9fG1KFXbT7p/pPuKur3DWdZCtFKWTEz/ZnEWUnCP0gKDAwv+bd7zZH3c+E0dBVOXjOuZFJVjIY//y1YPGZCTPEmtoAd0xetXFpbbhkDTUN7QofTQFeiMUCYjpWM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJ4bxkv1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751436055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlMD3t7ycJKRomUVuQAiuk5BAoj5s4ukulb+cMLGP2s=;
	b=UJ4bxkv1mq7BB2B0GuTSK+8j5/A3NhlupAtbUetnBtscJVxW/YRJGAnWDmwW6LkPfAm0bt
	NEz43u+6YftnbMqfUp0lrXOSdAhqqy5fZvYgmEM77tKaHcsxQupxagIugYkZCP3LejKm6/
	B0wWGoIgOcSxO0JUvnVGIsDWp+24x94=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-cY2WhJ9yNnWCB4gRyLU_-g-1; Wed,
 02 Jul 2025 02:00:53 -0400
X-MC-Unique: cY2WhJ9yNnWCB4gRyLU_-g-1
X-Mimecast-MFC-AGG-ID: cY2WhJ9yNnWCB4gRyLU_-g_1751436048
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E0671955EC3;
	Wed,  2 Jul 2025 06:00:48 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.112])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9E7A180045B;
	Wed,  2 Jul 2025 06:00:32 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	corbet@lwn.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org,
	baohua@kernel.org,
	willy@infradead.org,
	peterx@redhat.com,
	wangkefeng.wang@huawei.com,
	usamaarif642@gmail.com,
	sunnanyong@huawei.com,
	vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com,
	yang@os.amperecomputing.com,
	kirill.shutemov@linux.intel.com,
	aarcange@redhat.com,
	raquini@redhat.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	tiwai@suse.de,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	jack@suse.cz,
	cl@gentwo.org,
	jglisse@google.com,
	surenb@google.com,
	zokeefe@google.com,
	hannes@cmpxchg.org,
	rientjes@google.com,
	mhocko@suse.com,
	rdunlap@infradead.org
Subject: [PATCH v8 09/15] khugepaged: avoid unnecessary mTHP collapse attempts
Date: Tue,  1 Jul 2025 23:57:36 -0600
Message-ID: <20250702055742.102808-10-npache@redhat.com>
In-Reply-To: <20250702055742.102808-1-npache@redhat.com>
References: <20250702055742.102808-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

There are cases where, if an attempted collapse fails, all subsequent
orders are guaranteed to also fail. Avoid these collapse attempts by
bailing out early.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 61d2b3ebc7ac..50e1d7ef7e6d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1358,6 +1358,23 @@ static int khugepaged_scan_bitmap(struct mm_struct *mm, unsigned long address,
 				collapsed += (1 << order);
 				continue;
 			}
+			/*
+			 * Some ret values indicate all lower order will also
+			 * fail, dont trying to collapse smaller orders
+			 */
+			if (ret == SCAN_EXCEED_NONE_PTE ||
+				ret == SCAN_EXCEED_SWAP_PTE ||
+				ret == SCAN_EXCEED_SHARED_PTE ||
+				ret == SCAN_PTE_NON_PRESENT ||
+				ret == SCAN_PTE_UFFD_WP ||
+				ret == SCAN_ALLOC_HUGE_PAGE_FAIL ||
+				ret == SCAN_CGROUP_CHARGE_FAIL ||
+				ret == SCAN_COPY_MC ||
+				ret == SCAN_PAGE_LOCK ||
+				ret == SCAN_PAGE_COUNT)
+				goto next;
+			else
+				break;
 		}
 
 next:
-- 
2.49.0


