Return-Path: <linux-kernel+bounces-789202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7400B39232
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5DD1C238B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D29C24729A;
	Thu, 28 Aug 2025 03:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yK2BkNFp"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A5913957E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756351620; cv=none; b=LjJ0zjzacnYIj+E2uavdhtBfrkvXzxaqswwLkCbeoighsuRXvD5aygMjWm3TvQetelsS6lD04ObHJvzMobEF5iRBzBEBGO3PyouMB8LeTcMMxcnL5AFab3iPn7ZnvDgaoqEMIPCFm8AdorpVJjYJ8xJC6fMqG6tOB2fCbm7iVH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756351620; c=relaxed/simple;
	bh=ftdmSlNt09FgQY4pEvWWw7yJUxA83F1tEXsoFtLyi3s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ffB1iHG+2vgGqIqX8e95e4FmEICXOf3teyfaSOcSDXZzrC39cA8Ww/FV+hWYKpL4uJqa/ozANjw6GnqB+y0mOKhDL4UiiksIE8Iq6AtC0vnM68YgeQhXaTetzokXKQJWKP1j6Yuwo7r+hII9eCPHyhHpDfYBUm6IL90o9tNFyRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yK2BkNFp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-248d9301475so4271945ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756351618; x=1756956418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/WwDqhBFvfX8vGdZlaGfr2aX/pAs2877vUWTmC3CYPY=;
        b=yK2BkNFpJoBiQ1H5/AwQpYZr+rxDxxQtS1L2sgzky0AlXJ0PMNNKlSEJ8DYhf3E6GA
         X6M5q38TEIifI6cg/VDwjUeKWQyODHz2FaUYZILXUYaWG5OnSrhm+85XciX+fcVTwhyY
         +iZb662jSQU59ia7gzbhKLIpKCws8s5KCyzHXzg51rBv5cJX+Uh5vh49Vcs2If+D3WWh
         yNYvgPAXF7nfZeigKuM0VVqYIL5djxSKJ6NuICRTlrw5KErc+Rhl7p1mF5X5S76CDy66
         g5irpUVLeqGhla1PobI2eonzoYwsnFM5i5qsiIxRiCQZQIIqv9Xh0GSMwGrpcOkciNxf
         pCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756351619; x=1756956419;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/WwDqhBFvfX8vGdZlaGfr2aX/pAs2877vUWTmC3CYPY=;
        b=XYhOkALRuGGE1JnxU6SCIv6lWET5xvN99GfG5q8tbS/ra8xSNVbHg9lhdPomoYLrqf
         wlO9kJC2S0RBSAjK+0y6kgLaJV3UECgoBRtclb8anKYEHLksU1+Gb2oVR6pts/tRBd/y
         MEfbL+nQeoFcL6vya0+aNYgEjoCu6I6tpzxXYaxGUIfOV7zTgudRClM24yNnL5dz7kGc
         o2od3Yxe0G7dHaOiHEpfBTURnOWQ+SMedZK5ZfHm7lO+pvLmd8ps4eURRi1BaQJTM2ta
         1RbCgzlEDxqO6zl92SC4eMaIrd6FCUBbymYxs752MgbjI2UCTF/D+TMmwE1C5wd0ajdJ
         8h+g==
X-Forwarded-Encrypted: i=1; AJvYcCWI6B6LoI8vFaefurTrtadZKAPzWN3qeDU3zPU1jP9pYc0xnyEWlyJ3PKfpL1T99VXOJnjAZQDjnR4t5/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvd1udbpblwwmOLtlOa7Mx/DwUldsUTattfDRLr55mcpwsZT7p
	/MKUwLHZ24hOkzEE/Odutf08ot3MX60OYrpYgUOVDhnffbyykGa7f7Q1azNjPI4NFUhyxjdztey
	tFqofPJRJxNffXQ==
X-Google-Smtp-Source: AGHT+IFxSA9GIyNl3LjYDLq/9j+Nr4FbBkqdslTMspmmUmyNwznrDCKsEp0DmZ+NS6CY1yHpDOzTMPRVndE+uA==
X-Received: from plfz1.prod.google.com ([2002:a17:902:d541:b0:248:beac:b4f1])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f707:b0:235:f459:69c7 with SMTP id d9443c01a7336-2462efa8c13mr281904895ad.52.1756351618636;
 Wed, 27 Aug 2025 20:26:58 -0700 (PDT)
Date: Thu, 28 Aug 2025 03:26:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828032653.521314-1-cmllamas@google.com>
Subject: [PATCH] mm/mremap: fix regression in vrm->new_addr check
From: Carlos Llamas <cmllamas@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, "open list:MEMORY MAPPING" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

Commit 3215eaceca87 ("mm/mremap: refactor initial parameter sanity
checks") moved the sanity check for vrm->new_addr from mremap_to() to
check_mremap_params().

However, this caused a regression as vrm->new_addr is now checked even
when MREMAP_FIXED and MREMAP_DONTUNMAP flags are not specified. In this
case, vrm->new_addr can be garbage and create unexpected failures.

Fix this by moving the new_addr check after the vrm_implies_new_addr()
guard. This ensures that the new_addr is only checked when the user has
specified one explicitly.

Fixes: 3215eaceca87 ("mm/mremap: refactor initial parameter sanity checks")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 mm/mremap.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e618a706aff5..692acb0f9ea2 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1771,18 +1771,17 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	 * for DOS-emu "duplicate shm area" thing. But
 	 * a zero new-len is nonsensical.
 	 */
-	if (!vrm->new_len)
-		return -EINVAL;
-
-	/* Is the new length or address silly? */
-	if (vrm->new_len > TASK_SIZE ||
-	    vrm->new_addr > TASK_SIZE - vrm->new_len)
+	if (!vrm->new_len || vrm->new_len > TASK_SIZE)
 		return -EINVAL;
 
 	/* Remainder of checks are for cases with specific new_addr. */
 	if (!vrm_implies_new_addr(vrm))
 		return 0;
 
+	/* Is the new address silly? */
+	if (vrm->new_addr > TASK_SIZE - vrm->new_len)
+		return -EINVAL;
+
 	/* The new address must be page-aligned. */
 	if (offset_in_page(vrm->new_addr))
 		return -EINVAL;
-- 
2.51.0.268.g9569e192d0-goog


