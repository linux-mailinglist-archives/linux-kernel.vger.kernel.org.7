Return-Path: <linux-kernel+bounces-845995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F083BC6ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 23:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 013F14E421C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 21:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72052C08B2;
	Wed,  8 Oct 2025 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Tt2NEtnK"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528602BE7D6
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759958788; cv=none; b=KPpVqNdj0252lws/syf/10wYKGfO53gjfj2OT7A2VVD/qC4tBWXgH62iB1NJN4ke30L9DDMeCWt1+e+22Grvd5SjtIp8JUldO6w8bTHdEFvZrxVIjnBh5NMtYb+WrPhg/W3iNDL1O8NMKcR+YnKxNNagDAzANPXjsgnxcVqsQXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759958788; c=relaxed/simple;
	bh=fCcj07/gexMXi6ikCvaTMDFsr1yBLf6fS3U+g8RUPLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUrCvjIn7Tn53WCxYVtsaNa1RH9Q3XeqCkMOejYz2T5LlfYZDjKhMiux7KRWG4vY85setB6RdRTx6S24KErFwKea/uHDsdwCb1gOUqp7SpXJJxiXXzfe5zm8IJ4lrOClE4e0no4GGGiSGWIeliqKOVoCHWdeY/+1OThzgbV/4o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Tt2NEtnK; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-791fd6bffbaso4317396d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759958785; x=1760563585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=02WGp1DxFUiByHpXLeMo76f1SdNmrFn5JyqrYXqca1I=;
        b=Tt2NEtnK1hDYCGB+tSgvciUsh7vw2rYbEh3GO5JZicaqJAO7BM+Skpu7c3zLRLEyrC
         QYiVFaYSu0Pk4gA2iFnzVo5OMa8LO/CYf7X3KhwFURfnzpfrCpTMmP5auxKJLs1apLAO
         J/L6uiQbvotXDy/kOfxgW9yvWtM5VE23WRDlyJlSOL0/ur1V1JGns9ROHVM/qZjutzhT
         D6s6Nmqkw9MHt2I08MsOiWSuq//gyCsNGMEGY/NxOL05+fv2knKXkV7IyalLVTXuZAf8
         ZREWwLdjcebu3xEOKoGB0xLOASlgPnpc87uelUZjRKB69aL/BZ1Cs6vPdObXbl70BeFe
         uPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759958785; x=1760563585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02WGp1DxFUiByHpXLeMo76f1SdNmrFn5JyqrYXqca1I=;
        b=RhsexXVTza6PAN97q+YK0vRgwPa5VosBfGBNCBeCjF5TEKCCtxll/Stq0CKWWhj/cR
         xfYA9YCHW+/HZ8tHBX3YC+qFARMdSaXKfqlObcgj8eyt2qCYQI9SHS0yw7hs9JGFoHhV
         jhS7bY3CcVG1bIL48fxE1dX2G320VuTlkHMHT882Yj8PBVN4KyPKgdn3ej6pez6x+V29
         UWGQ0+0DikP+ktnjoFYjfyfPFKyw8vfpIb5G51u4ut9aboVJ3xtpncEr/FMTbe0tIMt8
         aPdvLp9K16D07WelduxExZVzHnnJ/c6D4aIwQo209D3/JNJvzaWtv63i50SfCcqreIKw
         Wpzg==
X-Forwarded-Encrypted: i=1; AJvYcCWuMOqCDoQeC/dgAe1VlXk62YfWvl5inVI4DemxxnVLSHz2faK3cSe3VnyaiRtoAriVrKq18tcX4uHMqFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhKWVcyEwgu3eIfq7baGg4wikuFPAoMNDIZ4GDuphcVY9JCnfz
	7YntjC27t12Z4FvsKduzvi2rnqc5uZnXizUzO3MEZ5M9V+s4HQovPLRj7WWQ3wOvg6BO9YrQuan
	bHT7e
X-Gm-Gg: ASbGncvIP7KwWQ5dPyPI4djcTTsJzixsHEBt4+h/LqHmn5L3s15FN0PS8HKWf44SJ6E
	CaW/r4BBCAQ5mbTGfOzjK4f8dj3wp/noiPyB0zKJq6CfzjyZ+an65pETGg+kJGXMzMG8MGh2VWs
	oVcSxm2jNzJDsdiePeOU4yIsXLjT1Q6sfrOYLfL5HiKBeF2zlzTUvOUDkwyeAz/7jC1VfPZfk+H
	8AlxWYuDC5SwQzhDJXCwXQW81uWvwMoS6UB6xDSPRumViJfB2TNCZ34czQgO009nH5chOl7o3rl
	cUezu8G+hqJZJInhl0gdR8c2WTcjl07Ex8w4Lb+NYJ3EnvqpA6XOobHTZyRIndhGdc7FDv10r42
	Eqer4XauCiQ3NZIk15m5lyM2Xrg6a3EoiwmOZJO711sfE1g/gTQuELeOVvtun7VfZf4YyNJOGaW
	OK53uJKwOqJdNALTFBoXsN3R93pR+7EHI+X7+QWO/2EWNU2T/PvpJH9U8Z
X-Google-Smtp-Source: AGHT+IHhEwy/BGJsgagFs+NryYihU/HyuisdDCE+tDOMPz9gSDnX04RD+Z/cfYEUKcFC/FsUVDNIjQ==
X-Received: by 2002:a05:6214:528f:b0:877:81d2:4c27 with SMTP id 6a1803df08f44-87b2ef38450mr71340646d6.57.1759958785149;
        Wed, 08 Oct 2025 14:26:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878b5dcaef2sm174415006d6.0.2025.10.08.14.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 14:26:24 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hugetlb.h: flatten logic in arch_hugetlb_migration_supported
Date: Wed,  8 Oct 2025 17:26:13 -0400
Message-ID: <20251008212614.86495-1-gourry@gourry.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify if-true-return-true-else-false logic.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/hugetlb.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 526d27e88b3b..b030850975ef 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -876,12 +876,9 @@ static inline void folio_clear_hugetlb_hwpoison(struct folio *folio)
 #ifndef arch_hugetlb_migration_supported
 static inline bool arch_hugetlb_migration_supported(struct hstate *h)
 {
-	if ((huge_page_shift(h) == PMD_SHIFT) ||
+	return ((huge_page_shift(h) == PMD_SHIFT) ||
 		(huge_page_shift(h) == PUD_SHIFT) ||
-			(huge_page_shift(h) == PGDIR_SHIFT))
-		return true;
-	else
-		return false;
+		(huge_page_shift(h) == PGDIR_SHIFT));
 }
 #endif
 #else
-- 
2.51.0


