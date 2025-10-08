Return-Path: <linux-kernel+bounces-845996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A857BC6AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 23:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557583C2F10
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 21:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC4D2C0F81;
	Wed,  8 Oct 2025 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UVViV6dF"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6A62BFC60
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759958789; cv=none; b=npvihH1KdK8zqm70BKLFAxWvIFYBwi8vMGgoTwk0J5A2EU/Dm3472E+vjv6BDh2RpTX1p/pd5U+S1UwI8HSgi2XuBmMZUVdNjK5OQClE5c0jkSEksYv9eJdCF/p8LtGgbomzyBbjCnFJvXuUL4PDPMRdWytm7/SCu9gcIl9mil0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759958789; c=relaxed/simple;
	bh=6ScPfmRqEpk/K7G+RSKuCsUbG1efzQIt8njG/faTtOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p34s9spZZN58XOxgqLbIfFhlSzV9IgYC5vE/mF4kZKlAyKFxbXpfnKmX4YqZwGuol48Z+eiBVGZMjfxMNbd9UQbqLT35iEIHLs8yU3q42+iq+0IHc5fZw7JUrfnGhuJ4dE71k5RQeWX+yiBU8b+jWXOQXjIcjtnMPe5QlfXJT5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UVViV6dF; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-795773ac2a2so2712936d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759958786; x=1760563586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KS5HhFl7ylMIsKJS2hlhpESnHdT7YO5JDgRsm4JXdvs=;
        b=UVViV6dFdRxenH1Z3SNVrtjin9IPNv6RGnMG8rW3tpAMZO1xkEh8xYtE0+dvfYcuFn
         bLzhxin+yWnKPK084khYWxSxgEmTTSfMu9cFM/2d5g8kxnnFvJ7qmknnlUn0g+XwFHlm
         c/oSXAbb8imSGjLLI34bmTiHNgTnTWHt700eptWkY6VEn6iKave/cKqdTPfUWIaT392n
         pSLWwtcW5p4LgK/70Y196kMEo2IF1/+vDKxLdG0dtAqpvsyMZSwgpPcmkDAWOklleDO1
         1xvGv6kY43Rp9OMhF8v3WbaC/c0N0+cZ24vzcLFqfsxNdOXuelaPhUCOV6dzV0IGXP9g
         8IAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759958786; x=1760563586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KS5HhFl7ylMIsKJS2hlhpESnHdT7YO5JDgRsm4JXdvs=;
        b=IUs40DuxV+lgKid7yP5XubvEUOqEpR6GFnRr2pekzYxmbJI0WVNw6Rj83u62GYboEh
         u7v9RFMdLTnGHtVwaev/HjBQ0MsX21gyz8EXzhplBYARfb2qDx6ywq8GjMwTdM6Sc/lg
         ovOhbcAr7HayRc5i8UR5U6rzyFcn9YKrtXi5EZjC4H3rBttAoC+NiKI++q4d7F2XvdXW
         8Ord4+D2kz0ZQECIfUVHJIzmlKpcyYJSRXnopayAWFeIVvCTL1VJ+E6vy/Yf0PO4/Q5i
         bRdB79RH5ktLp8oIykh18gIEIk/VVmWIp1/+S436+bTiduE46fj9pwPaXej2ZMZ5A/Ab
         jxZw==
X-Forwarded-Encrypted: i=1; AJvYcCXCneldY78yujdcyGAlw8oHTrTTg06qFHEyRWQ/X2wBoXzAVmEpYqADYewq9yv+I4WyWW8ZUpm0vrMFHVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUmjo1RbTTNHpJDfRXp8Oq3dTyv0mUPyN+D5CwKPqlRGQ8hxy4
	sVrN1aSRtqu65RRtHr6C15htfUpT+jiA71QRV+JPGct1Nhm3B5bNIDBZkQKm9tnOoAxI4D+5AA5
	mxgUH
X-Gm-Gg: ASbGncvgLiWcahi8OouNNr3d6xkDYX6BgyuL1yci/k0Yzou/L3qJDms1dpzXGpDwzXc
	jttDaCrzAQUEd/kybn/ZaWxSm7FCPsJ89lfWKw7SUKFixmYxwH02KA+0D7uvKr3/PIeF7c3aFtr
	TPI2RJmWhV5WRGeVDyfGwD8kpb44P6Vi/ipG1jp7OWsede7LB4xq6SEBcrNQHiNezzFtYX2sGQY
	zJs8+6iO2VyUfEfXMYrteDyuyCyNej79OcJxGw7gTRC8sMLUOt0SOMIU/zIymBpf1Qu8O4skNg6
	MagXMwDREF5YoS1EHfNaMKs1rhX82CnscKV+mCTcgXgFR1LUwAg+Y6L5apxRyZcD/x3ygsyEhw7
	jVA/02+d9G9mcib0vT0tXg518LhPzk+cO4t+yP7J9PHJGW/fvKT8J/esr3F8HXdezNIA8htWQcP
	LcHPwxfupq12HG3m53PKIF8MXJqEw5oJ1hpt9gqFOUy52sRg==
X-Google-Smtp-Source: AGHT+IEv5J/8gxaNlPdAvSepjkXlsfuNzq/QXluXLDpnkk35yrK777gVOAb0vMYXxebIUGxPVCbFUQ==
X-Received: by 2002:ad4:5f45:0:b0:82d:f77f:28c3 with SMTP id 6a1803df08f44-87b21092a00mr77097716d6.30.1759958786556;
        Wed, 08 Oct 2025 14:26:26 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878b5dcaef2sm174415006d6.0.2025.10.08.14.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 14:26:26 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hugetlb: add __read_mostly to sysctl_hugetlb_shm_group
Date: Wed,  8 Oct 2025 17:26:14 -0400
Message-ID: <20251008212614.86495-2-gourry@gourry.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008212614.86495-1-gourry@gourry.net>
References: <20251008212614.86495-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysctl bits are mostly-read values.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/hugetlb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b030850975ef..7ea667d4ad5e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -172,7 +172,7 @@ bool hugetlbfs_pagecache_present(struct hstate *h,
 
 struct address_space *hugetlb_folio_mapping_lock_write(struct folio *folio);
 
-extern int sysctl_hugetlb_shm_group;
+extern int sysctl_hugetlb_shm_group __read_mostly;
 extern struct list_head huge_boot_pages[MAX_NUMNODES];
 
 void hugetlb_bootmem_alloc(void);
-- 
2.51.0


