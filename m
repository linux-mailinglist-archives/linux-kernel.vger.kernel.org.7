Return-Path: <linux-kernel+bounces-764794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3D6B2276C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D261B653EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CA125B1CE;
	Tue, 12 Aug 2025 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZL7wmTm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4E2571D7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003035; cv=none; b=BO6+rcbJdReKR5beyLKTGeGhwlb51I56Dv2ib6LdmKFsI/7pKp0zM/0ueXbDte66wADYULDfUvALHYEdCuiMYxwzSvkZHAHsMCiXWcD9NuTDFZccMy61p4FU1b/5GQ5eMro0jqQSIDdPUBvlUUTXHH1djgYpn+ZCHYZPEe4Tvzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003035; c=relaxed/simple;
	bh=EKoLFKfDE4OVlIlS/bSiogHROByBDPfoUsBfUqFD6c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=SxVplZL5T1a4H2t/ri+PpCOAI2C7xu73lM3gTZ3S/nrxclaMkufxZ+cGminXMFsHRBHd29wpdnw/1oHdLCOqm1JuYE/pOJqAScz9exwMnTuumuVwSHOqFXmn2nzrI+bWZTAK2TyJ3uofe6svkcCRJ9oXXXDoMTG6HbOjfPFweqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZL7wmTm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755003032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xr/w2mK6l802lCxz4VjyI0YPeCChzTlSQ7qvXcEbkU8=;
	b=OZL7wmTmUr7wQuqiUeKcCzwZwBYPrUZFzc3j25JlXW1FqvCAQbLgT7+1euKFFXENjpDNaI
	u429XRhd5CUIzwoSYT261FoKbj1AFmKyOG1/JIvyrX2LyETYrhMY7UooXiUArRIFfjzxpy
	Mb0Htrl0pVmt4tvu5ZaOg0ZChFSRiqc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-XufWQzS-Paee81uzo9E_Ew-1; Tue,
 12 Aug 2025 08:50:24 -0400
X-MC-Unique: XufWQzS-Paee81uzo9E_Ew-1
X-Mimecast-MFC-AGG-ID: XufWQzS-Paee81uzo9E_Ew_1755003022
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24E73195608D;
	Tue, 12 Aug 2025 12:50:22 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.156])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BD173001458;
	Tue, 12 Aug 2025 12:50:15 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
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
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 04/12] arch/arm: don't initialize kasan if it's disabled
Date: Tue, 12 Aug 2025 20:49:33 +0800
Message-ID: <20250812124941.69508-5-bhe@redhat.com>
In-Reply-To: <20250812124941.69508-1-bhe@redhat.com>
References: <20250812124941.69508-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

And also add code to enable kasan_flag_enabled, this is for later
usage.

Here call jump_label_init() early in setup_arch() so that later
kasan_init() can enable static key kasan_flag_enabled. Put
jump_label_init() beofre parse_early_param() as other architectures
do.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm/kernel/setup.c  | 6 ++++++
 arch/arm/mm/kasan_init.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 0bfd66c7ada0..453a47a4c715 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1135,6 +1135,12 @@ void __init setup_arch(char **cmdline_p)
 	early_fixmap_init();
 	early_ioremap_init();
 
+	/*
+	 * Initialise the static keys early as they may be enabled by the
+	 * kasan_init() or early parameters.
+	 */
+	jump_label_init();
+
 	parse_early_param();
 
 #ifdef CONFIG_MMU
diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 111d4f703136..c764e1b9c9c5 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -212,6 +212,8 @@ void __init kasan_init(void)
 	phys_addr_t pa_start, pa_end;
 	u64 i;
 
+	if (kasan_arg_disabled)
+		return;
 	/*
 	 * We are going to perform proper setup of shadow memory.
 	 *
@@ -300,6 +302,10 @@ void __init kasan_init(void)
 	local_flush_tlb_all();
 
 	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
+
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	pr_info("Kernel address sanitizer initialized\n");
 	init_task.kasan_depth = 0;
 }
-- 
2.41.0


