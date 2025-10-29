Return-Path: <linux-kernel+bounces-876485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65A9C1BC03
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0090F568492
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031F52E03FE;
	Wed, 29 Oct 2025 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajVPy/mi"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A425E2E7167
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750591; cv=none; b=KL4fxIpUE3G9qcS6NJyZpwuTXoxRy9X2FnENRBLVEdpzkpskoRQboa8RTkhopzQCeiyhrPAspC9n7tqYH7CRgCT13iG8WTq6d7k1UQ+864M73rPmCsznxbZ1sv2X948ZsS9gwFxiJja71Puqh4ganWGJkXr3IDMDMfV3o+TulHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750591; c=relaxed/simple;
	bh=YBhgAHGodR8EuFBvP8khTpZ+VNH91RtX+JHBou6tB+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/tEILYZjMCXY7xCCNL4Eimw4wnSNsOfJbFqu56FlK0/X9T7SlnFS31hiDPfbp/fzTUHgSWinn2dbBXZvXm15ayqUDoVCoGEe/BsO2Wgu/zgNu6d8J46KY6gnp89AX3DLzGHbGBo3wQJrhLuuTh1Nvt3GEqYceDO3JPjCtrtSbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajVPy/mi; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b4736e043f9so1302431466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761750588; x=1762355388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJ45qfcg/AiWri4WRgxlSUGeApHftRNlJg58Vjygo7Q=;
        b=ajVPy/miGko4rGC6NuX7xxLXhhcF36T3tAWgGw46uxjJMUZvA4UgHBF40BHV1O5IKo
         w8btbox2In3dZCBpPsoi/julv2n+9f8vy2Ljj8rwx9wqNtMjJKDR+03OAPULmMEkaARH
         FQT0virGAqSiE7sYQmGD2YZPHyOSOjlxDrjRMcs+RXHhjBtnQI1c9vB7Xwolw50mJDZU
         NiLuQzu95mJ5cMV2S4kTnKAOQaq2X+pkB7ktlsriyd3UMJ3StmiNb6qLVH5JBBGo2d73
         X1BRcNjZq+bYo4NYjQc1CvmTEiYVfb8phJQLaDZ/9IeNvyNS/MgjeSGIFzx7kjjCgdYe
         /IhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761750588; x=1762355388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJ45qfcg/AiWri4WRgxlSUGeApHftRNlJg58Vjygo7Q=;
        b=CH9EuTy8/K8OOWfGiRj26OulnYXsg2BopH6tQC+tQZLuN4zswVE7QPxRXpAeWHYUoN
         7L1Y3QRKbZ4DkoSbRIqNEY4w62SN7TDtbtu2QeBVSmN/v8C0r6Ye7PuL5k1vMFIFS5jB
         Qthc6kRUEw4t92mJ1OUL5qzhzqCYeeK8OjAby3zPASzbTB1uNhpUTYlOlDZixH4lhBSP
         Xcpyr0o60cZh9QV3Q7PGkaN5ymNEK/8ziAmYucHTxSzKxy4l5w37gY2/AADy69eVGZ5p
         ZkB4UyiCTGmvKfkAYLTqc2kbgSEzNtXvaYfp71yquCtaFjkgP5O+/0mDPXuLFS9cSyjW
         C4hA==
X-Forwarded-Encrypted: i=1; AJvYcCVY9J8GWr+IRgabmam0e5Q67BB35RwL+pOyNwiw/FUu67e2SRdPt9DBYCCW42RcrpF1o7+mYLiGj0Y6kEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNd7e4aDZGTqy9WYxyukz1rASQDABA4OAtns1o/0J6c80J4sjb
	2I5rudYGFeEn4+2avVu/7yHUI4mAfJ1F9xedDtwjwspwJEc4lqM9DocQ
X-Gm-Gg: ASbGnct1YsFdhffOftBTu2EaNNF9ytASgSFAo0soUoRWlhgvJnKZHMxkMgSIu4gLrn4
	pe9zTI6a11h3j4OkSUv2+mUG7bxQVe/ob9Ody4Bos6zkLsaxdymlNovLWMO+hELwJdqMU+woe5I
	WWjWyIsMW0XzYTiNlEZEpDvb1mYs/LK2t5tHqVJGZAZ0EpMrfcPGGzOBMqzBpqySBvoEJUnrqWE
	Be8xrgqrcNryGJrO9XU/1Aich9IXNpqgVhu9PdoICG3Rm9dE+MpfgyJx80ZxVzc025Vh+BV2MDQ
	PwXtgB7QyjYmuaojc0Vyo5DdDgIB9Tp0QzHWKsagdDO4J7eelasLQFn1ZbrBd9RAjPhWft69zGF
	EXG5HpkHZdnDJwXHy34db4Dpw59+EukiueE+r+Lk9lmpiGH1d3HE3iMuetfcQ0S+SDWzmCldC3k
	1X+oBF6gEOi79wFQe1WlI002LWPuzgNKcSQLZ4iy8zpW9w9M3b4l70WKWN3EBYZRvg8YG6
X-Google-Smtp-Source: AGHT+IHDlTb5X7VV5e2XjFqocJOsF7vLRX65oGQx9zCAKTcQ+9IOyOUoUo5S/+LU/FJ3oKPg1ypHaw==
X-Received: by 2002:a17:907:7b85:b0:b46:6718:3f1d with SMTP id a640c23a62f3a-b703d4571f5mr331200366b.38.1761750587895;
        Wed, 29 Oct 2025 08:09:47 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6d8530905dsm1451781666b.6.2025.10.29.08.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:09:46 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] macintosh/via-pmu-backlight: Include uapi/linux/fb.h
Date: Wed, 29 Oct 2025 16:09:40 +0100
Message-ID: <20251029150940.2523328-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029150940.2523328-1-thierry.reding@gmail.com>
References: <20251029150940.2523328-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

This makes available several of the constants used in this driver.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/macintosh/via-pmu-backlight.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/macintosh/via-pmu-backlight.c b/drivers/macintosh/via-pmu-backlight.c
index 26bd9ed5e664..aef8930a505b 100644
--- a/drivers/macintosh/via-pmu-backlight.c
+++ b/drivers/macintosh/via-pmu-backlight.c
@@ -13,6 +13,7 @@
 #include <linux/backlight.h>
 #include <linux/pmu.h>
 #include <asm/backlight.h>
+#include <uapi/linux/fb.h>
 
 #define MAX_PMU_LEVEL 0xFF
 
-- 
2.51.0


