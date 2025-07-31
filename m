Return-Path: <linux-kernel+bounces-752325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB96EB17416
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C51A80B10
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B486E1DE3B5;
	Thu, 31 Jul 2025 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="elLu8CEu"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF8219ABAC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976687; cv=none; b=tmsj8n6g6xMlkC3+vUX6sjrhncTaI7bTjPnnnv8wo1ECp44QmyxC5w59XgzbBzemt2qMOiX0Lv6FWHxTZK7RzxBqGbMn5heYDTs/UcPPNoqfezmOzGR178AEcy0E821UHIP3ndpFpinNWueCWlKA/TBdOfix9NSaAujNNn5JRH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976687; c=relaxed/simple;
	bh=OTA2x4bKnGUx3VAQlS2BrqHpdMgIv8m6sktHVnnjfbY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bdUhi5DW8uzr1ojFyvhCqOmkNkd9gHrBtpSi2QJazQdVfgJRj6UBFYQe9cYnst2NUND0fJ/7Nmxvkgti/5Fd6N9cCr1nd/kQwAHwjubWXyG+rcCwoN+LBddoGASZhTbZC3gpxvMu51zB4obQxaeL0v2iEwYnvM4AtWXQWA7Fpd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=elLu8CEu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138e65efe2so698230a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753976685; x=1754581485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8D6H3TovcRUpDHrrv443Wy2kKrliHPbwf72lIkroPTg=;
        b=elLu8CEuxWIkjFWmb6U2eUeRTAVWvwFtNbf204tcWhPfNHxvOu3cj/67UsAD68naVh
         80EvcDN0CTyh2tpNpOlcTk0AvxV2l58Lf/9yyPFN8+E7zCHzVaObjx0GQdZGdu5DCWIl
         RjTTsM2DGpYwkJf9J3oCTq+vOsjPS4cZgz1xi81YrWkwj6tAnNtxa5rLOLCreZpGKVFl
         UqJWIouJ4EfDIOqO6giMxZtskNjqKjiwoUUCj6x09x5wBau34IzgAyDIE8zRAzqgQMax
         qeaoCfEBYqSgTHH9xeu/5i+7ul1Rmp8tp7scEEcWkYWN3zH6D+dXEVi1EyXxqXoVaNmb
         R/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753976685; x=1754581485;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8D6H3TovcRUpDHrrv443Wy2kKrliHPbwf72lIkroPTg=;
        b=cv4JxmFd5MOYe2A0nJKnFMa6Neo2SRQsQQ7O+zqKyRc77IV2K+6gIYGATjXI2xOaPy
         DvQE6lkbmRlJD65IRmobFc81K2CUhR5yC/CsNh428OgzH1l4M8vhHHycuDux/8VgfQFF
         bu46tC4rBUhORKQ9zcZY2hi+2zylH4urfxJDxLAIQhu3o8Qt/Mq6ywzQz8Aml5/b7rvz
         Lq8b9//0xZvqb2yypA7KgWY6r6ujVutVV4GYVWJc0ANisdvtmnFCb9mVqBM3LtjrjSEr
         izCjf2HVUJ+Q4Ya/URUaxBUiDxlNHUbUrade+UWNHcS13fCyAIXTdlRCAKyqPcnFsM/d
         djog==
X-Forwarded-Encrypted: i=1; AJvYcCUAvQIrkS5haHQHhzbW4gIOgd7BwG+b92/JNTf2LGSz4lE6fzRID2mrI79mkCW2TmssrDWDUIbiFMxLMUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuZWcByDLEI1cOqhoHzmd94BgW3L2PvU8rkWnmMsq0Jl87UU0B
	Ks/ik7yA3QIOyDh7Qj18e1pMQJBDEy/fDKfLf5IfyAs2D60eUdnIYETBTvUADXWSjVTptHxZ9FF
	gdsauwA==
X-Google-Smtp-Source: AGHT+IG5srnDugZwbzwxdO5CMVzSLz47ALstUwtxD0ry/hJIfF+IqAvaHkQ39SziNPkrw/OnSv1Kvb0DGBw=
X-Received: from pjbqd15.prod.google.com ([2002:a17:90b:3ccf:b0:314:d44:4108])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:562b:b0:312:959:dc4f
 with SMTP id 98e67ed59e1d1-31f5dd6b53amr9841464a91.5.1753976684978; Thu, 31
 Jul 2025 08:44:44 -0700 (PDT)
Date: Thu, 31 Jul 2025 08:44:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250731154442.319568-1-surenb@google.com>
Subject: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles a
 THP hole
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
Changes since v1 [1]
- Fixed step size calculation, per Lokesh Gidra
- Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, per Lokesh Gidra

[1] https://lore.kernel.org/all/20250730170733.3829267-1-surenb@google.com/

 mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index cbed91b09640..b5af31c22731 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 
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
+				step_size = HPAGE_PMD_SIZE;
+			} else {
 				spin_unlock(ptl);
-				split_huge_pmd(src_vma, src_pmd, src_addr);
-				/* The folio will be split by move_pages_pte() */
-				continue;
+				if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES)) {
+					err = -ENOENT;
+					break;
+				}
+				/* nothing to do to move a hole */
+				err = 0;
+				step_size = min(HPAGE_PMD_SIZE, src_start + len - src_addr);
 			}
-
-			err = move_pages_huge_pmd(mm, dst_pmd, src_pmd,
-						  dst_pmdval, dst_vma, src_vma,
-						  dst_addr, src_addr);
-			step_size = HPAGE_PMD_SIZE;
 		} else {
 			if (pmd_none(*src_pmd)) {
 				if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES)) {

base-commit: 01da54f10fddf3b01c5a3b80f6b16bbad390c302
-- 
2.50.1.552.g942d659e1b-goog


