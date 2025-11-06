Return-Path: <linux-kernel+bounces-889421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3A0C3D81D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462F13AB329
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B632B344024;
	Thu,  6 Nov 2025 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aa+VQPSG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9132633556F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464575; cv=none; b=TrGBiV357tzhNX0qoA0vDKoJxjG+VemRRUj/fRmvNcePHUjxXvkMRYklzSXj3aycZG2F8rWQXtRT8D+hvoe7X9G62b6s1EKADJQ0K4sAG40iB/5QNi2bJjIa8b1vQt6+Jo96NgdE62ZC0DqVxGog62S3ovmJIn1caH/cbfU19ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464575; c=relaxed/simple;
	bh=t+C1/W4eMUuxtuOqHeiLxENPjKXRT7ASZ83M/f+4/UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gR+H+CiofUkvSStQUQ3h++8q+No24Zdh2B9Bktz46z8x1DOwyvkVvmo9JH32cY7VJIGD0W3dQA1o8XDBa34Jr7lpnEpKCoT1mWqQtNLHayGbQif5+4/hJJDW6zgtCipzFD0BFF7F9+1GOhBd6AAv56iUsz03venE6uT6/ipj/OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aa+VQPSG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762464572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXoXvGh7icUa4ulh0/ArAKzgINifhHLmj8YOfBJ+Zu0=;
	b=Aa+VQPSGfVxqE5UQiDUNjAgQgsXN+PYID4xaocx1aEljev5WEjv2leS79yA46dErPOJ4r0
	p5vq9bPBMtD3mI2TeUKYzQQI1lY3zXs8QzXiuWb+heDUoWB8tKNLUwQR8v8awfu38FIryK
	1PyLzTR4fzqG2G9/0AlVg9SnM/iWgNA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-DMJVGKR3MuiElvV9x0B0jQ-1; Thu,
 06 Nov 2025 16:29:29 -0500
X-MC-Unique: DMJVGKR3MuiElvV9x0B0jQ-1
X-Mimecast-MFC-AGG-ID: DMJVGKR3MuiElvV9x0B0jQ_1762464568
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32FA1195609F;
	Thu,  6 Nov 2025 21:29:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3657B19560A7;
	Thu,  6 Nov 2025 21:29:27 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: david@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com
Subject: [RFC 10/10] mm: thp: x86: cleanup PSE feature bit usage
Date: Thu,  6 Nov 2025 16:28:57 -0500
Message-ID: <8dc0695aa1c1073ec475be18e300ec1046344e84.1762464515.git.luizcap@redhat.com>
In-Reply-To: <cover.1762464515.git.luizcap@redhat.com>
References: <cover.1762464515.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Historically, THP support on x86 checked the PSE feature bit to enable
THP. On 64-bit, this check is redundant since PSE is always enabled by
default for compatibility. On 32-bit, PSE enables 4MB page support and
must be checked. To clean this up, this commit:

1. Drops arch_has_pmd_leaves() from common x86 code. For 64-bit,
   we assume PMD-sized pages are always supported

2. Checks for PSE only on 32-bit, using arch_has_pmd_leaves()

Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 arch/x86/include/asm/pgtable.h    | 6 ------
 arch/x86/include/asm/pgtable_32.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 08d109280e36..55b88de5178f 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -313,12 +313,6 @@ static inline int pud_trans_huge(pud_t pud)
 }
 #endif
 
-#define arch_has_pmd_leaves arch_has_pmd_leaves
-static inline int arch_has_pmd_leaves(void)
-{
-	return boot_cpu_has(X86_FEATURE_PSE);
-}
-
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 static inline bool pmd_special(pmd_t pmd)
 {
diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index b612cc57a4d3..3bd51cfa431e 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -45,6 +45,12 @@ do {						\
 	flush_tlb_one_kernel((vaddr));		\
 } while (0)
 
+#define arch_has_pmd_leaves arch_has_pmd_leaves
+static inline int arch_has_pmd_leaves(void)
+{
+	return boot_cpu_has(X86_FEATURE_PSE);
+}
+
 #endif /* !__ASSEMBLER__ */
 
 /*
-- 
2.51.1


