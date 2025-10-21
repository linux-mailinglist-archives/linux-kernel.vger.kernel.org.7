Return-Path: <linux-kernel+bounces-863477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E54ABF7ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74424358548
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182C34C15D;
	Tue, 21 Oct 2025 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="cfLFDSU6"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DEF34C157
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068184; cv=none; b=qTODzAhdf6tthU3WivRk1We99RKdhs717LecKejmmy9nt5HqdEC82DpsEmazH/K7vvihKXd4xWfGVnAya5O5vlJx7WCajknEwIYDtC6cnbxd9B2PG+sydGAln0yD9oSx9aq0M9wv3mNSvKAuU2Gvgt5chJhZrdXCx/LwqMxdcnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068184; c=relaxed/simple;
	bh=iiAqG+YCuMLtLf//pCa38SOlcJv6UE98I6wWNeDJNGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tgYtRkTbTpt8IUDqYHeolieSDK+r+tpim9eh2iaz3TpYYSXeaTPasGiwY639pwkwFuuZzVm75E8Nf9xhGS/TCR5t4hy4OjroICdUtHdritGpIF9OcsNUaxIKijzHB1vgDH+1z/ixK6wNZDjpCRsha55YcS+22OQdMYAMzFhGJAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=cfLFDSU6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290deb0e643so44469105ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761068180; x=1761672980; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DU6RPi02iTlcMn00mu9B1UAh4vOC7Kwr4GZq2qgegyU=;
        b=cfLFDSU6adR6isIHrCKVG5dNe88EQdgjFoSfhS2djbXq7oK3cbAp4imG3kHIhaAnpI
         tlKU6BhFGVxLsSLSsZfxkl1mlMzGOGNzRvOI1Ger1o8wUGnssAWmvoAiEu7PcyNdBOSw
         /5hCf6vS3Su1nKJ60UKLnBTMK2d5p6a4/m/OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761068180; x=1761672980;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DU6RPi02iTlcMn00mu9B1UAh4vOC7Kwr4GZq2qgegyU=;
        b=auti98XZbJC9+dqhCcp+LgOeo0gFwfcUHPpkYjgx0j3sTSksK9TlZV8Gvx4+a5Tz/L
         z5fRF7w0gplJx+Hrt0tqMLDjx6YOY9dxI3CcwrhFhzn8ZCnflVGGtkqQcXQBJ6inh5kn
         Ex7pin6QhFhQ+X+FpYYDxydpDAPo9p7URXIcQvvqwV1f5Pddf9No423q5g0LUlyy+Q0k
         cwlkpxoOpu0iq7XHvV7uSgDn4vz1kzZITsTrfUyY+MrWED2J0ANC54QPzkhWzVLRuPCV
         ZASBIkuztmxPMEUCMnynO8TQ1Vu7CTVxHY/MI8sDVXmnx7s3CZsZuUdVI7Mv1ccFla9H
         TLEQ==
X-Gm-Message-State: AOJu0Yz8PFutJ1sSVTG3YFwxYKP3pw/279RYmb73qKbyLQWsNgZqVhu/
	Rvws4YwYGiBdl+bJKZh/ylW3UAAQwi9t6bJY13bvvAl2Js4kNqtzk53kfitSMolG4zyKLEwoI03
	51ZBpy2SoFEeC8Svm3jwsMOaJUyntK5JnDA9QSmpN9rUvPiWV1d63sz3yWHYeYeC1sPNYlbi216
	w=
X-Gm-Gg: ASbGncsLVW0x26I1Q0WoHYb6vtDn9EAmE0wYtcgY/UUeLNuOS5w+CumTMlBLdwZjIf6
	ugH9eL8B33Q2NaIHjYDThTky7MAkUILlLt+/euxw9G5LV5EaaLujKTZRKMNjziRdc4CKgXw2jxc
	QC3S0eAdkXR9sYdLoODFJ2zDduaSH3SOmoRkPnRR6XgdNcdmYssdz12qAJd7i30hEyF4WtPKjZx
	I8hsvS5DqNONh+ot6qHMbA/O77Xk2ybXa9/6frkgvovbO+sWiZnmWbimH9/6zRkdV0kk61+JG/u
	58RhHco6cQL+u5j3OC3QJjBcGjoE63Ww/h4WLk+uiYE41jgRTUdGGovVZcNdhcJ4cJ3j/Lkml8A
	zPYhHfHlaNmQdSbojxg9oR2beav6jFUPZaJ8VZ4xmgx1jUFr/StZvyCH+894f4X8hIvvg0pPsfL
	9UfvbUXiW9HC0eIua6aIYHSYC5lHJAPeI6mQ1wfinwVjZPAq1zO9GB8zU6T7EN2m7eS5iaaM2HH
	ha8pyfLQ/45Xxc=
X-Google-Smtp-Source: AGHT+IGI1q8k75ScyYG7cIRpmQAl6lf9uLryXNotFLoLqzGoKAA3Fix8omwchETxqPBeGcSS29VAAA==
X-Received: by 2002:a17:902:ce8d:b0:290:52aa:7291 with SMTP id d9443c01a7336-290cba41df2mr255952305ad.53.1761068180344;
        Tue, 21 Oct 2025 10:36:20 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:d5f3:33d1:a1e0:46bc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29247219357sm114364125ad.111.2025.10.21.10.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 10:36:20 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-kernel@vger.kernel.org
Cc: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] spell check: Edited spelling errors
Date: Tue, 21 Oct 2025 23:06:13 +0530
Message-ID: <20251021173614.48249-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
---
 mm/hugetlb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 795ee393eac0..1760fa39a3af 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2934,7 +2934,7 @@ typedef enum {
 	 * NOTE: This is mostly identical to MAP_CHG_NEEDED, except
 	 * that currently vma_needs_reservation() has an unwanted side
 	 * effect to either use end() or commit() to complete the
-	 * transaction.	 Hence it needs to differenciate from NEEDED.
+	 * transaction.	 Hence it needs to differentiate from NEEDED.
 	 */
 	MAP_CHG_ENFORCED = 2,
 } map_chg_state;
@@ -5983,7 +5983,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			int rc = vma_needs_reservation(h, vma, address);
 
 			if (rc < 0)
-				/* Pressumably allocate_file_region_entries failed
+				/* Presumably allocate_file_region_entries failed
 				 * to allocate a file_region struct. Clear
 				 * hugetlb_restore_reserve so that global reserve
 				 * count will not be incremented by free_huge_folio.
@@ -6007,7 +6007,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	/*
 	 * If we unshared PMDs, the TLB flush was not recorded in mmu_gather. We
 	 * could defer the flush until now, since by holding i_mmap_rwsem we
-	 * guaranteed that the last refernece would not be dropped. But we must
+	 * guaranteed that the last reference would not be dropped. But we must
 	 * do the flushing before we return, as otherwise i_mmap_rwsem will be
 	 * dropped and the last reference to the shared PMDs page might be
 	 * dropped as well.
@@ -6211,7 +6211,7 @@ static vm_fault_t hugetlb_wp(struct vm_fault *vmf)
 	 * In order to determine where this is a COW on a MAP_PRIVATE mapping it
 	 * is enough to check whether the old_folio is anonymous. This means that
 	 * the reserve for this address was consumed. If reserves were used, a
-	 * partial faulted mapping at the fime of fork() could consume its reserves
+	 * partial faulted mapping at the time of fork() could consume its reserves
 	 * on COW instead of the full address range.
 	 */
 	if (is_vma_resv_set(vma, HPAGE_RESV_OWNER) &&
@@ -7193,7 +7193,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 		} else if (unlikely(is_pte_marker(pte))) {
 			/*
 			 * Do nothing on a poison marker; page is
-			 * corrupted, permissons do not apply.  Here
+			 * corrupted, permissions do not apply.  Here
 			 * pte_marker_uffd_wp()==true implies !poison
 			 * because they're mutual exclusive.
 			 */
-- 
2.43.0


-- 
::DISCLAIMER::

---------------------------------------------------------------------
The 
contents of this e-mail and any attachment(s) are confidential and
intended 
for the named recipient(s) only. Views or opinions, if any,
presented in 
this email are solely those of the author and may not
necessarily reflect 
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form 
of reproduction, dissemination, copying, disclosure,
modification, 
distribution and / or publication of this message without the
prior written 
consent of authorized representative of SSN is strictly
prohibited. If you 
have received this email in error please delete it and
notify the sender 
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain 
ssn.edu.in <http://www.ssn.edu.in/>

