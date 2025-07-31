Return-Path: <linux-kernel+bounces-751490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E105DB16A42
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51FB62002B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C49188006;
	Thu, 31 Jul 2025 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="TrYWBsEH"
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FF6176AC8
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753926828; cv=none; b=ce8U+8UB3GwiY8A5rrzc72be3UtgrWqxSyvKILbIjWQAbq1ITqxSWZRjXwk7f3BIJcly24GMWa/4hJ28gKA59pl96WHf0nm2Zlx9YalimEHNuXdPm2SxySn3/+DcLggUCYsnzxHxDk7A/Vrw7hhOLbuFJfwHiHOMKvTE/miwFM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753926828; c=relaxed/simple;
	bh=o013fffBqmCmMLgo3PtHQdg7F8MxRApvjB+lgABcTJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsaXri4VM6JlvBUI2dZomHkEGsEYqN2DQg4mnv1xZR038JnR9CI/SuOQTzPPynTvZ5wEgqgaY76BWLC/N/0jiAEFnWXQTJu2bObRSF9lM0h1lx5tt/DDFgFfUGQpkVrIuFpDfC8/EMZZooUH0syN5UN+HjG3yShzoAkTHDok3IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=TrYWBsEH; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753926819;
	bh=ROXTcu3NC59udh5UXJspljhoslQrPWl0Sx4aF8K9Emw=;
	h=From:Subject:Date:Message-ID;
	b=TrYWBsEHCEiIlC3XYaDXOSbsnHFXbWeHZtPps82kboCPxLEXSqIiGwmTha4O8q8iV
	 Lt9IQTBYa1wEbNDe7B58rblY1f9+hxigiuZPbCyga+APyMj4rlTwRj4iOTnU1gcnI4
	 wkHccNLeTGZsQ2llyKHrYVd7ZQLQ9TADiLYTt1Ks=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 688ACC73000065B1; Thu, 31 Jul 2025 09:52:53 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9109934456634
X-SMAIL-UIID: E9F0BA989AA444DF88B0D3645AEDC517-20250731-095253-1
From: Hillf Danton <hdanton@sina.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org,
	peterx@redhat.com,
	lokeshgidra@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles a THP hole
Date: Thu, 31 Jul 2025 09:52:40 +0800
Message-ID: <20250731015241.3576-1-hdanton@sina.com>
In-Reply-To: <20250730170733.3829267-1-surenb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

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

