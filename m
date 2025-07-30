Return-Path: <linux-kernel+bounces-751089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10694B16529
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408BD1AA05C0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D1A15A8;
	Wed, 30 Jul 2025 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBsuf+cs"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464994409
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895258; cv=none; b=OA2dxNJ1z6HMWfvDJoZfJ6M2IJWvRH0p2xS6TpJDdQ9MCLV7hjKF8lvENjeUYlYTCT8AbNLQcuCrR7oPBvrDYwNaYvF5FYDovawgWtD/p9I8tru2xqKD8kHnFARLG3atsf+CCd3IaeIK+37zkpYMYHid2LKqTY/gkBdWD2avmjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895258; c=relaxed/simple;
	bh=DX1GHJEw+yV3RRzbL6bG3xAge8rpg3j/1QwDNAVuivQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MHQnJUyAGtL5lAbnpqjfjYDcUIBX/sh+OAizpzVKC0g88G/rm7q6ZOJ5QyhunKrVrXdkcHvdJWcUFs1ZqByGlY9xD2QxJOjJCmEpVaYvSu6IG4t3C65qMVB+qlUCPLM6OglXFJgGP5E77JuguDtpOKtuVQcphRiaCdrKZ8rHtOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZBsuf+cs; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b42249503c4so367303a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753895256; x=1754500056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iwvX/+FCFrBIkeHTGaFzh+izLhsSIPbGbCbxZr6W88I=;
        b=ZBsuf+csfQxlgG2dSBYTLs1gPALrU6SoJDDl9czF8f/3d8IZ9IsaGKAhNBhVxN+V/N
         FnSSSzzQ1jCuWK+GoYb8h/bBNpNv7RXpgoaYtOovvmPHfZaStEhPocDnEyxW1OhJPafi
         LgcxVUvx+1Uz5J3D07ZAG5Oc+YYyjE9Um2Q/ZrzCfL0TyIILLAAWmEaQxqM2Dg8O7deE
         yKIhPMDHf9AEOVMiDcNuDp8cnPnu7h8QSW+tasDYTVGWvoYtptTByYdIkP4wN1IZgORk
         XZ3Nvk3Ae8HGPeOnXKnUpt4IqW2w9x0qlJ2ZQto1xx5AZZjD7mi1yWv55LkHj5sU/HLh
         QDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753895256; x=1754500056;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iwvX/+FCFrBIkeHTGaFzh+izLhsSIPbGbCbxZr6W88I=;
        b=OXaNC7whZuVHhl3FPuhSOwulr8eg5eYn56eOQMhkzVPUfLxjAqfZijKNlIUOtN4lCC
         WIbklmlk2aRT2g/b7weKU/VMtozZka1W/gseg0Wu0WHTwS0qi0dyXXz9NjZR1YSuplLs
         ySmliafctZquzxVPBKHrZa495mi4XLBqAU5QWbxCJBEJr/kWukjPyeT6R55xr+iC6bzE
         KiNKE6KwEX4HKh3ue7orswiiR/sEkaggrbN9ZSH4MyM0SRxoEOjsUHj5lbSg1V49MYYD
         UEpg8jLgI4Qh63pkhnNdc9NwzgSzgvCgN2Tv8T/ArSybu/uFktOuLwCTJgyvTVk7gNF6
         jl+w==
X-Forwarded-Encrypted: i=1; AJvYcCUW6v515BrqouW+RZT56GThDrGYf4I6VxdYdJGazN/wO52xHVNZTPh9CPv8CO65q5xs0ETtMFyPgjLB5uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHkMwYu9+szhDZlIPUXMq/jsnTLLipeernffZRZZLuk1QfL4CN
	Sf2DmiBp3BlfrgMYeRD1fdzBc9rszlSPJ2lillnkOq4OuRw8Vi9l4mR+4o5aMYdIboL1A61ZNtD
	b1Fu0/g==
X-Google-Smtp-Source: AGHT+IFRpqzleLfhY584F3gS5nWpI1NhhfzwuIDnKy5qdpfvKqCIZN9aFroMt2PQhlQ+ZIOuvhwlGyX2lGc=
X-Received: from pjee12.prod.google.com ([2002:a17:90b:578c:b0:313:246f:8d54])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54c:b0:240:b884:2fa0
 with SMTP id d9443c01a7336-240b8843050mr21999235ad.26.1753895256448; Wed, 30
 Jul 2025 10:07:36 -0700 (PDT)
Date: Wed, 30 Jul 2025 10:07:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730170733.3829267-1-surenb@google.com>
Subject: [PATCH 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles a THP hole
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterx@redhat.com, david@redhat.com, aarcange@redhat.com, 
	lokeshgidra@google.com, surenb@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
encounters a non-present THP, it fails to properly recognize an unmapped
hole and tries to access a non-existent folio, resulting in
a crash. Add a check to skip non-present THPs.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
---
 mm/userfaultfd.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index cbed91b09640..60be8080ddd0 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1818,27 +1818,35 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 
 		ptl = pmd_trans_huge_lock(src_pmd, src_vma);
 		if (ptl) {
-			/* Check if we can move the pmd without splitting it. */
-			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
-			    !pmd_none(dst_pmdval)) {
-				struct folio *folio = pmd_folio(*src_pmd);
+			if (pmd_present(*src_pmd) || is_pmd_migration_entry(*src_pmd)) {
+				/* Check if we can move the pmd without splitting it. */
+				if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
+				    !pmd_none(dst_pmdval)) {
+					if (pmd_present(*src_pmd)) {
+						struct folio *folio = pmd_folio(*src_pmd);
+
+						if (!folio || (!is_huge_zero_folio(folio) &&
+							       !PageAnonExclusive(&folio->page))) {
+							spin_unlock(ptl);
+							err = -EBUSY;
+							break;
+						}
+					}
 
-				if (!folio || (!is_huge_zero_folio(folio) &&
-					       !PageAnonExclusive(&folio->page))) {
 					spin_unlock(ptl);
-					err = -EBUSY;
-					break;
+					split_huge_pmd(src_vma, src_pmd, src_addr);
+					/* The folio will be split by move_pages_pte() */
+					continue;
 				}
 
+				err = move_pages_huge_pmd(mm, dst_pmd, src_pmd,
+							  dst_pmdval, dst_vma, src_vma,
+							  dst_addr, src_addr);
+			} else {
+				/* nothing to do to move a hole */
 				spin_unlock(ptl);
-				split_huge_pmd(src_vma, src_pmd, src_addr);
-				/* The folio will be split by move_pages_pte() */
-				continue;
+				err = 0;
 			}
-
-			err = move_pages_huge_pmd(mm, dst_pmd, src_pmd,
-						  dst_pmdval, dst_vma, src_vma,
-						  dst_addr, src_addr);
 			step_size = HPAGE_PMD_SIZE;
 		} else {
 			if (pmd_none(*src_pmd)) {

base-commit: 01da54f10fddf3b01c5a3b80f6b16bbad390c302
-- 
2.50.1.552.g942d659e1b-goog


