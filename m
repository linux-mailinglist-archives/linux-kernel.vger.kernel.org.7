Return-Path: <linux-kernel+bounces-868070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1341EC0447C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC8E3AB469
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B26274FD0;
	Fri, 24 Oct 2025 03:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyrt/D0z"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCB226E158
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761277631; cv=none; b=HcN3W1yvg7hVkFp9ZxVmK6JreeagRYQwZazroRL9d5wC7ZQUxiDcGHP75az/nuATxB2Kt3YfyvBaTYc9enMCnUTvH9MavCULOdP86pdqXJzef5CvXBouFf3sINUb9SrUPDMQ6VW04CNZpkLq+JQ9G4lwMnEhqXoNpE/zb92U7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761277631; c=relaxed/simple;
	bh=9cWnLkrLXqaPsJRM99oxt4vPCd7XWVuiMbIdFRMWzT8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iKIwu+gflt/Qf7gLVeZ2dUPO6xe30g6Q2OgZaPftwq1uuV/HvoB+99pge+PExtcMNlyBpaHnX3qtvmQKuCOH4q1jZ8l7ImfnsL0lIsrx5dqKAKHU2fIaf/F9m1sF0JD8OcM4+0G1we0wIMEMIHrX2Ue0CP1bndW3ZDkYLLo4w3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyrt/D0z; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-430bf3b7608so16248845ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761277625; x=1761882425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BTRPcVehq1ZOZm7xL/IWpW023usBfc4VwA4QLz9tUds=;
        b=fyrt/D0zKKYB9AptfigPT9jUudDFhTxLRm/s44slHYhf48evjWiZG/hsyH1pWiUeBB
         XrXer/sh/2uVAoUhVBD6B+Qb1DeoB9NEU1mkQg2h9EtGb/CzTJelN809Wb13SXOXy068
         LO+LmrXtvALpqff3aYIrVoxGYup2/MSqlWwokwqyRiJjfhsslCRt/yu1FtP02ujhVzTP
         0PKceafYEoSIxfI6BRp/5sioUMfyI48g/ReCOPYDduTf9kZ4j8xC66do3M6GW5WFuCpe
         v6cVIJiA8SPdozJLbr9RJottJFQBahM5zlSzRJQdZoq5IhtQUAycWpPlxaCaGFWKd9MS
         Avqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761277625; x=1761882425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTRPcVehq1ZOZm7xL/IWpW023usBfc4VwA4QLz9tUds=;
        b=NMW4czN/hqa7pFRl74sQ6pqFqpvtUGCatgBFpQcv9eB7hRruqsmGL06XBB3rV73uPo
         L7hXEpqveNi+Gc9NrmHpSHpjkN+q1nXcdOS7gx0rlsBeJyC243JlUgg4GKfbVyKZXTm5
         ZJblm0kjocNcRpARXAQIExCMrbfq+KqnoRktIzr/1QRcqvKnsIwfUL30rxNsTbf//XoF
         1t+Z1PYVwtXxBipbKK0reYHlOMa+EEMoAgXvzwM3ONPBHzXmP2t4lVelce5wgWL8kDZ7
         Da1ImB3g2SOTq3WJ0OV/wspmd3ahE8fhO0N5LBoBA+uEWTHRE7xZw4N73Txqb7aVMAnt
         BLqg==
X-Forwarded-Encrypted: i=1; AJvYcCXBRaiEpKFqqyo/S78kV81JyksnPwg4szexsMJsyRfgAjWlzv7LNxvE1H9dbz5vIEJSFR0v2ZBHEq+mH+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsHkAKFw+U1shK9Xe9FhEiT7+hCl5Fv7YZJVxfbibyiFpKcMQH
	mKt9R3tJWINzwEzgG4Xjj8edDuNUiVUoTZEKh8XZhRrwJER6jknD11NX
X-Gm-Gg: ASbGncsm3Oc6kuOkvGH/9Y53kRWZ5gpywjMOHD5jc/Q4Wc0uTf/QfdFCv2btI9oJSWB
	x49PmLUnkZvWaZwPumB0VEzBFA3t25RgQXm0gUgv3y7h3Bo57u2OMaILUVN8nA4TwMLgrvrZI2x
	CID+6yWna4LTkFXC4uP0qM7ypqr6tI82g9dZPo66UKgtleLbHkh6fZtAtpl35+N88VmcjjH3Qms
	jtgkQH+uG82sp5dayNePpFIYDs54KKYv52XaPwqOgZfMMJ50Y4q9Rp8SeX7QiYaM89BzU+pJDaY
	dh35lLkpPJbOFbQIOcinnBbmcwHIjuO/B9KAJ0FBzTQHhpY8COa6hPQLFrNKWH/sRkNpWu2TFBz
	ucZdhmpmEuz9htaCICUK8uOblW6ey/E1/9CIYGMnFDp2auReJPf8BGGprwI8mtUXdHElaqygsoh
	OaQFeEQrf+a01TgdGpnzo96lLopmmRnv/EofNhi5IJvYTBGtR0hJKb7wTkMoInTrvvHCwqFpwLB
	uh7/16PepW8hE8=
X-Google-Smtp-Source: AGHT+IF4nK0dDcEQMxrByQtKSDL+Vtp/h2LVbn+x1BPoCFDYFALAcbNWnpX4PRVrQ+b7Q3SGYy2kzQ==
X-Received: by 2002:a05:6e02:3e04:b0:430:c394:15a3 with SMTP id e9e14a558f8ab-430c528d628mr363410005ab.22.1761277625271;
        Thu, 23 Oct 2025 20:47:05 -0700 (PDT)
Received: from abc-virtual-machine.localdomain (c-76-150-86-52.hsd1.il.comcast.net. [76.150.86.52])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb4e4bbefsm1712310173.5.2025.10.23.20.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 20:47:04 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	David Airlie <airlied@redhat.com>
Cc: linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: [PATCH] agp/alpha: fix out-of-bounds write with negative pg_start
Date: Thu, 23 Oct 2025 22:47:01 -0500
Message-Id: <20251024034701.1673459-1-danisjiang@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code contains an out-of-bounds write vulnerability due to insufficient
bounds validation. Negative pg_start values and integer overflow in
pg_start+pg_count can bypass the existing bounds check.

For example, pg_start=-1 with page_count=1 produces a sum of 0, passing
the check `(pg_start + page_count) > num_entries`, but later writes to
ptes[-1]. Similarly, pg_start=LONG_MAX-5 with pg_count=10 overflows,
bypassing the check.

Fix by explicitly rejecting negative pg_start and detecting overflow in
alpha_core_agp_insert_memory, alpha_core_agp_remove_memory, iommu_release,
iommu_bind, and iommu_unbind.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
---
 arch/alpha/kernel/pci_iommu.c | 17 ++++++++++++++++-
 drivers/char/agp/alpha-agp.c  | 13 ++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index dc91de50f906..b6293dc66d45 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -859,6 +859,11 @@ iommu_release(struct pci_iommu_arena *arena, long pg_start, long pg_count)
 
 	if (!arena) return -EINVAL;
 
+	if (pg_start < 0 || pg_start + pg_count > (arena->size >> PAGE_SHIFT))
+		return -EINVAL;
+	if (pg_start + pg_count < pg_start)
+		return -EINVAL;
+
 	ptes = arena->ptes;
 
 	/* Make sure they're all reserved first... */
@@ -879,7 +884,12 @@ iommu_bind(struct pci_iommu_arena *arena, long pg_start, long pg_count,
 	long i, j;
 
 	if (!arena) return -EINVAL;
-	
+
+	if (pg_start < 0 || pg_start + pg_count > (arena->size >> PAGE_SHIFT))
+		return -EINVAL;
+	if (pg_start + pg_count < pg_start)
+		return -EINVAL;
+
 	spin_lock_irqsave(&arena->lock, flags);
 
 	ptes = arena->ptes;
@@ -907,6 +917,11 @@ iommu_unbind(struct pci_iommu_arena *arena, long pg_start, long pg_count)
 
 	if (!arena) return -EINVAL;
 
+	if (pg_start < 0 || pg_start + pg_count > (arena->size >> PAGE_SHIFT))
+		return -EINVAL;
+	if (pg_start + pg_count < pg_start)
+		return -EINVAL;
+
 	p = arena->ptes + pg_start;
 	for(i = 0; i < pg_count; i++)
 		p[i] = IOMMU_RESERVED_PTE;
diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
index e1763ecb8111..e2ab959662f3 100644
--- a/drivers/char/agp/alpha-agp.c
+++ b/drivers/char/agp/alpha-agp.c
@@ -93,7 +93,9 @@ static int alpha_core_agp_insert_memory(struct agp_memory *mem, off_t pg_start,
 
 	temp = agp_bridge->current_size;
 	num_entries = A_SIZE_FIX(temp)->num_entries;
-	if ((pg_start + mem->page_count) > num_entries)
+	if (pg_start < 0 || (pg_start + mem->page_count) > num_entries)
+		return -EINVAL;
+	if ((pg_start + mem->page_count) < pg_start)
 		return -EINVAL;
 
 	status = agp->ops->bind(agp, pg_start, mem);
@@ -107,8 +109,17 @@ static int alpha_core_agp_remove_memory(struct agp_memory *mem, off_t pg_start,
 					int type)
 {
 	alpha_agp_info *agp = agp_bridge->dev_private_data;
+	int num_entries;
+	void *temp;
 	int status;
 
+	temp = agp_bridge->current_size;
+	num_entries = A_SIZE_FIX(temp)->num_entries;
+	if (pg_start < 0 || (pg_start + mem->page_count) > num_entries)
+		return -EINVAL;
+	if ((pg_start + mem->page_count) < pg_start)
+		return -EINVAL;
+
 	status = agp->ops->unbind(agp, pg_start, mem);
 	alpha_core_agp_tlbflush(mem);
 	return status;
-- 
2.34.1


