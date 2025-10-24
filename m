Return-Path: <linux-kernel+bounces-868332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D51A7C04EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D271A6290D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FBD2FC88C;
	Fri, 24 Oct 2025 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="knReVKjG"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272A92F99A8
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292958; cv=none; b=bvY+sxkD69wCk+hIxeGY5VeEThyK3NCQCeyBEG1DySNR5BJrfKPjlp0ZOE5sEcv+1Sv0l/nnOHFcQl7WBtVMeRXfiwFBzj3l+9kIUCGqeq6dU/YqHMnaUNONcfW8e+Pxf01fhOE0g1pk6OD2BUS8WbIcJB2+fll5g4VLfCa6eKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292958; c=relaxed/simple;
	bh=WyWdMElonDGVN0iFKYKqXrLPkR+tQfERlo9IF3HeJD0=;
	h=From:Mime-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=Si+arAhn6Zw4VDamAyhqTlQqJDNJPznKO0Lsz4M3qnbc+OC91bxjepcrFMS+HmNaPXjFHYmmwKWzhut91t+9S9jxl18Kw9zgWoJGxaldSRMd7a/UoI6LmEVzLhA/AoZpu30o4WTkETkhzr8iIvVsG8ZB8GaTVJceP0hBl7Lj3ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=knReVKjG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso1518753f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761292955; x=1761897755; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QVkfvNOE05bgFyjQFvQ8jxU+LxgCYyMiozDi6BCH2IE=;
        b=knReVKjGigcpE6/iMQYJWiDnXoUFGW/sHA0x2DnUz7iipQ+yi63Q2M6/LxRWnNUvGQ
         S0JltOF0yM4RyvxMbnD8nU8lxg2t68UK6vY9+LqW98vwBd9zFmoliLj/ETJ78HaWl7S4
         /qWMs9FASgeXX/30cyX3wEdStmLFMKxTvfWG7jrzrhnXYeRbtGHpdLuJkzNP3n5ZJ5qd
         NQjQTfnLxpCSeVKOx3h4rBHOAwENO6liLQVgLPUUv8iEPVKZPzmAGyObOzU2ALp4Mz1J
         upddLZyYmo6cnhH+Lu37oiyfHVGtkU7ysKCHQwGTHhngdCkk1k++2YPWO0CchvzSgUpL
         0r9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292955; x=1761897755;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QVkfvNOE05bgFyjQFvQ8jxU+LxgCYyMiozDi6BCH2IE=;
        b=mEPVKQf3u01O3nNnu1m+iPrrDXdfgwQlEVXs9rPGxe42fnNw2hK2DaVKegTeu9hmZl
         Zx8SKce9P22okdaDVq+7CG6XESBgXiX06ACZ2i8E3tF2YtWq+G632GV+31s9x5uEUueO
         YVHjaIIQqk+/Th/iREGUGRVCODuPbKCOc2mtXHu0n+49lVLd/rts6yWTo3z7aO6o/Wxx
         or3rjZBOaI0lXUGRbdB6FXep51+18a9Yo8zkgc+ahbYpzIIkuE0U/h7MtCXAF5yWGT7Z
         asllPEKD3W2w0faJZGEktIQAzKjVzl05ULa3XxUojU0UA2qmnsvR9WPfF/tLOgHML+Np
         3P6w==
X-Forwarded-Encrypted: i=1; AJvYcCURE8FZvm7KZb579GrOHhjf1GGKspY5lQ/xy2LkpvHQ+pgZkadK7K6dfo/FCvMnpUSa5w6l/u+RMptYG/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXu1LquOKeQOeuAzNAb+RVs4OF58wSJieOjzjQV9Mgtwc4ulHV
	4K60sS6rRtLUaGPKku4zv0IDDZZFkKxbdQVUSskfxO27Q9sPeeT0Xodmm3jjkAtIOLKZVDSavjC
	V4aDDcBK1ghHxmOUNxdrzWV1bYhUex3yvlhSWrYpNCg==
X-Gm-Gg: ASbGncukTXKTf6ecuKQNi5qbWBEQdVHKmN3b4/SrXXzT7IEjMF3YyQyLhS9/MuIYthH
	mf+APMAciciBto9vGBEbz7kLKw5RKm1sqejFfwQPs9Twn5oRkZisNr3BYVUQSdUPyG67U1JbUMX
	DZZuvy+6yFOa312CB5b0tkQPNqc29c4zS1mtv+WxScq0QQf4MFE+McQtIj5Q9bTg2NVUwBrr2t4
	+hPWv23GB5qfks7jiKzS5angWbLjw+wB2IcidOSp+/0vPSkma8FVlihjDtVzCgc/bTQbZUfVune
	kZUmkITB
X-Google-Smtp-Source: AGHT+IEDMvcKtfBgWfrP3ZyctUGsfciyGaBJ5AzyE+b5gOTpk78Wf06aMuH8uJW94/vjXjqIP3j/1lisp+qXxvTWYy0=
X-Received: by 2002:a05:6000:2c06:b0:429:92bf:3a3 with SMTP id
 ffacd0b85a97d-42992bf0644mr98922f8f.11.1761292955312; Fri, 24 Oct 2025
 01:02:35 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 24 Oct 2025 01:02:34 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 24 Oct 2025 01:02:34 -0700
From: Songtang Liu <liusongtang@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Songtang Liu <liusongtang@bytedance.com>
Date: Fri, 24 Oct 2025 01:02:34 -0700
X-Gm-Features: AWmQ_bmgfhEOQj2FZh2LiWfKD8MoIdgjL5VT1xU_C_QJQWPA7IczJX34PTJBxTc
Message-ID: <CAA=HWd3_nKzKguK4JAs3aX7MhyX3mxFPLNLzEqwRPiSPTwvm6Q@mail.gmail.com>
Subject: [PATCH] iommu/amd: Fix potential out-of-bounds read in iommu_mmio_show
To: joro@8bytes.org, will@kernel.org
Cc: suravee.suthikulpanit@amd.com, robin.murphy@arm.com, vasant.hegde@amd.com, 
	dheerajkumar.srivastava@amd.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, liusongtang@bytedance.com
Content-Type: text/plain; charset="UTF-8"

In iommu_mmio_write(), it validates the user-provided offset with the
check: `iommu->dbg_mmio_offset > iommu->mmio_phys_end - 4`.
This assumes a 4-byte access. However, the corresponding
show handler, iommu_mmio_show(), uses readq() to perform an 8-byte
(64-bit) read.

If a user provides an offset equal to `mmio_phys_end - 4`, the check
passes, and will lead to a 4-byte out-of-bounds read.

Fix this by adjusting the boundary check to use sizeof(u64), which
corresponds to the size of the readq() operation.

Fixes: 7a4ee419e8c1 ("iommu/amd: Add debugfs support to dump IOMMU
MMIO registers")
Signed-off-by: Songtang Liu <liusongtang@bytedance.com>
---
 drivers/iommu/amd/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 8b4d7db7869a4..5d85c47478a57 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -37,7 +37,7 @@ static ssize_t iommu_mmio_write(struct file *filp,
const char __user *ubuf,
 	if (ret)
 		return ret;

-	if (iommu->dbg_mmio_offset > iommu->mmio_phys_end - 4) {
+	if (iommu->dbg_mmio_offset > iommu->mmio_phys_end - sizeof(u64)) {
 		iommu->dbg_mmio_offset = -1;
 		return  -EINVAL;
 	}
-- 
2.39.5

