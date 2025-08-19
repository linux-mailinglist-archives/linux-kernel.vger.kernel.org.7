Return-Path: <linux-kernel+bounces-775964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD5FB2C6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1AD6527066
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B6B258EFC;
	Tue, 19 Aug 2025 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgFjKqMd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7560724BD03
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613106; cv=none; b=HZ0KEpS8+3Q6E8W5G+k1ZQO2kC3XO+cZFBw0eNdWsowVnG2z7rBwOssMhsz3EBCU8XOQ0ISEzs12xL1PVpe50u2EWkOis3vlgc72dUmi4cLBx+H7PcrP+NSaiE1OdkTJKr1aYzml8lBuC/JrPeKSIRlpsbCHKLfr54LsF6hKQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613106; c=relaxed/simple;
	bh=4MB8zoNyUP9PNYSZUbYxzZb9F2jIAlPMVEyNAZh5fE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTxFuBjgeS+Coi5AKiZLdPltZg7R1GSeJrzAudhYowqI51qIfuiAS/pbrxT61GVKfXzGCmHpR6o1gE9YYMaO4AvsyZTp+IP5t4Np2EsBDTeMRNMD3709MK9OYSkQVsj20thzjFn5vMvjNQhJaMwGV+R6HeAnfZEj7vrMBT16fxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PgFjKqMd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755613103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KQ5SyoE/MYPNZDWioj0kryq2voWpDfBzmzGzBWhm6as=;
	b=PgFjKqMdmuH82lmSahnqaGalKTh786HJihW+//jf6oo/QaBQCWfFe+Y52HfCseoH2Yp1bz
	lfNmH4mGNl087BKIyhIxqVEIfsFUa6Khx/tMV6LGIqxCeNlajGj6UlmeoxDVboXdLBfvG/
	eE17oGWFOTbym3LIXPLeM61UieufsEI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-Tt6NCjBUM0KnyyV-_L6s1A-1; Tue,
 19 Aug 2025 10:18:18 -0400
X-MC-Unique: Tt6NCjBUM0KnyyV-_L6s1A-1
X-Mimecast-MFC-AGG-ID: Tt6NCjBUM0KnyyV-_L6s1A_1755613094
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E835F19775AD;
	Tue, 19 Aug 2025 14:18:12 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.137])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D8AD180028A;
	Tue, 19 Aug 2025 14:17:53 +0000 (UTC)
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
	rdunlap@infradead.org,
	hughd@google.com,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v10 13/13] Documentation: mm: update the admin guide for mTHP collapse
Date: Tue, 19 Aug 2025 08:17:42 -0600
Message-ID: <20250819141742.626517-1-npache@redhat.com>
In-Reply-To: <20250819134205.622806-1-npache@redhat.com>
References: <20250819134205.622806-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Now that we can collapse to mTHPs lets update the admin guide to
reflect these changes and provide proper guidence on how to utilize it.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index b85547ac4fe9..1f9e6a32052c 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -63,7 +63,7 @@ often.
 THP can be enabled system wide or restricted to certain tasks or even
 memory ranges inside task's address space. Unless THP is completely
 disabled, there is ``khugepaged`` daemon that scans memory and
-collapses sequences of basic pages into PMD-sized huge pages.
+collapses sequences of basic pages into huge pages.
 
 The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
 interface and using madvise(2) and prctl(2) system calls.
@@ -149,6 +149,18 @@ hugepage sizes have enabled="never". If enabling multiple hugepage
 sizes, the kernel will select the most appropriate enabled size for a
 given allocation.
 
+khugepaged uses max_ptes_none scaled to the order of the enabled mTHP size
+to determine collapses. When using mTHPs it's recommended to set
+max_ptes_none low-- ideally less than HPAGE_PMD_NR / 2 (255 on 4k page
+size). This will prevent undesired "creep" behavior that leads to
+continuously collapsing to the largest mTHP size; when we collapse, we are
+bringing in new non-zero pages that will, on a subsequent scan, cause the
+max_ptes_none check of the +1 order to always be satisfied. By limiting
+this to less than half the current order, we make sure we don't cause this
+feedback loop. max_ptes_shared and max_ptes_swap have no effect when
+collapsing to a mTHP, and mTHP collapse will fail on shared or swapped out
+pages.
+
 It's also possible to limit defrag efforts in the VM to generate
 anonymous hugepages in case they're not immediately free to madvise
 regions or to never try to defrag memory and simply fallback to regular
@@ -264,11 +276,6 @@ support the following arguments::
 Khugepaged controls
 -------------------
 
-.. note::
-   khugepaged currently only searches for opportunities to collapse to
-   PMD-sized THP and no attempt is made to collapse to other THP
-   sizes.
-
 khugepaged runs usually at low frequency so while one may not want to
 invoke defrag algorithms synchronously during the page faults, it
 should be worth invoking defrag at least in khugepaged. However it's
-- 
2.50.1


