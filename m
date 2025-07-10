Return-Path: <linux-kernel+bounces-724862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAF1AFF7A5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1CE5A5B6F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6D8283FE5;
	Thu, 10 Jul 2025 03:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW03OG36"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE93286433
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118685; cv=none; b=uOZSjisxytxy+9NOKqZW/M/fl73RH/RZ5nTCXiW3XFTk0he3ExRHssyx1khNt1UIOfkUWAGIsuzdXLW/Kzuxw+XlnAMS+lCRWs3H+dchs3ggSk3AXE/6XpeKb2gL5Eze82CBrRi588kOkgJ9kGHwGQ63I6t1I8ZXr3SWyz6gUe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118685; c=relaxed/simple;
	bh=zilMHR8Bho0+q+ksWPS9L5yJ97dNYy09T21lNk7aBso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTakPLeAEsHPRji/yowRrB3HYN3Q6FD0CqslLREeXdSv+3xvMSBjFdNZKgR0G4DyUTnSkTSkS+Go2cYEKsTCNf+sH2mWXq6JKwpHRrfRp0KCM9gRQ2Aquwt5b2cjtK45QYWwHNANujFVgd16cMViXByj3YFtjhGaOx7bZ6YjrAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WW03OG36; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2352400344aso5203035ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 20:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752118683; x=1752723483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PG6G7XY0O+9uIkct7WB8iHIg0l6kV6jMS3CA4vYZotw=;
        b=WW03OG36YpPyTBcPGKg+XFrskZLI/VNB6rk3N1VxppruaM794SjJ9zffvSB7+d4oit
         eyNlQCq5m8AoIiTwvIIIRNlrDztkxxqpzO9argsfVbWt+SCHIVWSKx0932MXBzirCXfR
         0ihfR6DqJHdqYiaEmOmKalmzXlidjckeoXjs3RPj/dmyTR9VLfWGDAPNOzOBNW3pPb3F
         2JVx3GH8a2vgYkinwhaWdnn7hPFQwhgAvvdx6X4plBCG+OoleGv751r14PIFNzWFOffm
         l6G3ctKNJsDGp8sdyz+5QG2frAn397mI+FILk1E7yibwM0TbbTlVg9RZSi24LqfbZ6bt
         y4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752118683; x=1752723483;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PG6G7XY0O+9uIkct7WB8iHIg0l6kV6jMS3CA4vYZotw=;
        b=J3KA4r/s38XINH2YqYpz3fXZKDeRJqLIPFIhS9wAuvSQ26uLzA1mLQ0dtqcY+tVvES
         W2BDuba8tGy0jljijYjKhr34yd4fLAregCjS5oVjVYXQDWGmU7s7iJSrpvW5CbKlXtkM
         bS0UgDy2M349j/Fl5XUTM+CDxRprFP/PMZ+IrolaMPgZQ+IQKUNd4QfC5tKbBfYoycYd
         +ABxGVEj70L0yz55sp5B7tlYMU7+73PYl7l7EnNhnD66klwtvWq3WrNpJhk4pwNTElfd
         qvmgIXvWt9HcZsVwmPUWTgFyA7ig5wRht/fObXumT0Yd4Rl8WUwGjzE9OjT4qcb0dDbR
         4pNA==
X-Forwarded-Encrypted: i=1; AJvYcCWoTUf+CNhy/6X9rBvSbLYqRpa+f4NvaNAvff/SV1Uv4CMpVFS5sE/q6yuoduIYsxhkgEcGk7c7KtS2PpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj63FXQMmy+sjbwkl/6SA+P9bGEW0iN4hk2jqYddMwt1RJ5rIG
	Xgj5JcAOoacJQBJCImX3IRLWy9ii+fXz5ZYnBloWo6KJfIJSRHUa0qWV
X-Gm-Gg: ASbGncvqkokbkb/FgmYCFbBsW8SoJGmjufgdaA98g6xjEoooWwtpWsYYTCaHdymz5+Q
	sFI32KppQ3dDfHRm1/Urc74Fa+yYPc/mvOgq3w+1OHyOWV4H5SxAOhl6z/7zg7wiwCMvbeTva0t
	Ss0bV+RhloRJ2xVM40+yOQdGrjS217K2JKFluXm0smbla/LmVZ7RUkCJ0uraeqAokVTKPtTQ0yM
	p0fiy9w+hmtD3yq0pLAEnX1x4f/ksbiVuXBENgLKmYkilTjgEiZgHKwkN1f1lRuNUDoNcdE4K+W
	pmv6fh3MNjHENg/pY2p6Wf7RrOTkX6ezgekyEpaWSuntdQlkL7hkJVXLoFL2/qWG8A6D6ZFfRDq
	S
X-Google-Smtp-Source: AGHT+IHozr62v9ePpXEaXv6sB9HPchLtnTfJld5jCJZniq/y3YK5++iP1p4EdsFnAZw3QPWZfbZC+w==
X-Received: by 2002:a17:903:3b83:b0:236:9726:7264 with SMTP id d9443c01a7336-23ddb191fecmr91457465ad.5.1752118683220;
        Wed, 09 Jul 2025 20:38:03 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300689aasm3716320a91.13.2025.07.09.20.37.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Jul 2025 20:38:02 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v5 8/8] mm/shmem, swap: fix major fault counting
Date: Thu, 10 Jul 2025 11:37:06 +0800
Message-ID: <20250710033706.71042-9-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710033706.71042-1-ryncsn@gmail.com>
References: <20250710033706.71042-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

If the swapin failed, don't update the major fault count. There is a
long existing comment for doing it this way, now with previous cleanups,
we can finally fix it.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 9c50607ac455..f97c4e9f821d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2319,13 +2319,6 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	/* Look it up and read it in.. */
 	folio = swap_cache_get_folio(swap, NULL, 0);
 	if (!folio) {
-		/* Or update major stats only when swapin succeeds?? */
-		if (fault_type) {
-			*fault_type |= VM_FAULT_MAJOR;
-			count_vm_event(PGMAJFAULT);
-			count_memcg_event_mm(fault_mm, PGMAJFAULT);
-		}
-
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
 			/* Direct mTHP swapin skipping swap cache & readhaed */
 			folio = shmem_swap_alloc_folio(inode, vma, index,
@@ -2344,6 +2337,11 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 				goto failed;
 			}
 		}
+		if (fault_type) {
+			*fault_type |= VM_FAULT_MAJOR;
+			count_vm_event(PGMAJFAULT);
+			count_memcg_event_mm(fault_mm, PGMAJFAULT);
+		}
 	}
 	if (order > folio_order(folio)) {
 		/*
-- 
2.50.0


