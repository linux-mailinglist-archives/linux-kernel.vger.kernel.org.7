Return-Path: <linux-kernel+bounces-776972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B62ACB2D3A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA02179EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9249B2C11D1;
	Wed, 20 Aug 2025 05:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZRQ1GFv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE6B2BE64B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668192; cv=none; b=W5aH/Yw566W4LwX6nuqr5ZrgAhGjMI6KQwhbmT9RBbbj6VZxOu4U9BdXOn6NDzkP/VNuXVYgknX8omc7QkZW002E4X7/4PFDF29piXoPzyXIJaAF/XVEnnwd/N5fbx0lmggHDwATauFDVPGKgM6EZbF6lgntmNd7rxpFQQ40Qfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668192; c=relaxed/simple;
	bh=gYiU5A/v6zbeCWs7ZpFf9UtZ6dZnOyxtmXOSFCiTKCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=mr5ubOeH3QAaQViRXDpZgNqKq9wqXchkkBRiyQCDYCxmCWfzBEPkPrIMPhCVxD+T5YniPyM9urpOSXNL6pqKne7FT05Rg28+mRACQ15egSi0hBIFmDElZiZavLTN6JYnr/Yc+uK6baN5DbLRlvvBTO7jRhcxsqeyjX4KnEdufj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZRQ1GFv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755668189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSX6B0M/ECg+25VESJMFTz+rvOMGoiNHgeaxc9XIWxk=;
	b=iZRQ1GFvSFaxsS6L7RJsee2/sO+AdhyB0xjWdzDT07+BWOuzplNqDKTfiLOVIuGbL1728u
	N/BPwsvvVZNNq/P7j/AZmWUNCBSolClFYsfk/nFMxy/GweBVbfq/TaHSSjLiFwZR8OZE2d
	48yNOmIP056PJLhyRES8Mr5RQlHoox8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-GaD0GWmKPR2v39dZ-bWOUA-1; Wed,
 20 Aug 2025 01:36:27 -0400
X-MC-Unique: GaD0GWmKPR2v39dZ-bWOUA-1
X-Mimecast-MFC-AGG-ID: GaD0GWmKPR2v39dZ-bWOUA_1755668184
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6107180047F;
	Wed, 20 Aug 2025 05:36:24 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.99])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF69119560B0;
	Wed, 20 Aug 2025 05:36:16 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com,
	andreyknvl@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	sj@kernel.org,
	lorenzo.stoakes@oracle.com,
	elver@google.com,
	snovitoll@gmail.com,
	christophe.leroy@csgroup.eu,
	Baoquan He <bhe@redhat.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v3 08/12] arch/riscv: don't initialize kasan if it's disabled
Date: Wed, 20 Aug 2025 13:34:55 +0800
Message-ID: <20250820053459.164825-9-bhe@redhat.com>
In-Reply-To: <20250820053459.164825-1-bhe@redhat.com>
References: <20250820053459.164825-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

And also add code to enable kasan_flag_enabled, this is for later
usage.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/mm/kasan_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 41c635d6aca4..ac3ac227c765 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -485,6 +485,9 @@ void __init kasan_init(void)
 	phys_addr_t p_start, p_end;
 	u64 i;
 
+	if (kasan_arg_disabled)
+		return;
+
 	create_tmp_mapping();
 	csr_write(CSR_SATP, PFN_DOWN(__pa(tmp_pg_dir)) | satp_mode);
 
@@ -531,6 +534,9 @@ void __init kasan_init(void)
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	init_task.kasan_depth = 0;
 
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
 	local_flush_tlb_all();
 }
-- 
2.41.0


