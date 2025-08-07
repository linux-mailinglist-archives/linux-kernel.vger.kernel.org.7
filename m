Return-Path: <linux-kernel+bounces-758792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5C0B1D3DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD94817061A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A9E248880;
	Thu,  7 Aug 2025 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7InA4b5"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8C24C06A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553504; cv=none; b=LqjJUfJPiUUxTgSJ/bGvzcJ4mzMJLpBunV51bsdt+mdXNTCO2Sk/mbzAH2X6MLgnK1iWRKgwvnfcpsNK1Zjx35ZhTCL+1mibSyMnM0YC7x/jVrYVEtH1xvp4k+Z/hv3r3mmSac6L0YH5R8dP1c1mWinJWefPKJfsWb6o3HHMgvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553504; c=relaxed/simple;
	bh=TvQr2RyUocSFiKxvTqKWoN2lucqADlstvP8cqkf6nBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=snSEt33vFFQCnv9ovbhqYEJQobgOw1hkEf+m2WZqANxAemvx5ZSwOVDNQp7A2HsdRYhm+LrhRHAbalkf+7xoIFus3hqeXglGV1fndlg/TljLDA4Mjo/cmE6cHMweGtvMos+HfH8GVowVUfsf8yAIop89xpyWnQsZasYvoe/t7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7InA4b5; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55b8bf653dfso846234e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 00:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754553500; x=1755158300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVukRiidJtnbsHfjBQsGQf+AgMjYijGPFu00oV3qGko=;
        b=E7InA4b5K0/mFEqQSXRuH71TysAGHjMEtBBtecJ/hBDVmFIc/SV6o6JpYBDtofbxxh
         Hzon6oYMGhRbCjjAGUuzaSjNfrgN0bRR4gau/r+oalJTqw38oWhllRnDeRH0hfjV9UCL
         gxizqO/R8hx+s3+XwXPMflziezHbQQ7idmGaVKTaXzyVW9jjC+pxwG2WvPsx9X8s8h4b
         g4l+wfnwmLax9WOufUjq+V42ALrtFJ/T6DsImJRCF92vVlr/dr6xSyB8siMQIAXGaRnv
         N+MVzN06t0SiE04yrf72ecPY/ZnbmeOstOn/HZ/y46FB1th4BBKRfGo8GdcGaibee6WR
         zIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754553500; x=1755158300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVukRiidJtnbsHfjBQsGQf+AgMjYijGPFu00oV3qGko=;
        b=WViRJabm+05wdqEWFIoauHiTx9yDhOMVYgh2dFjSis7IZ06R9HX7q9+x3wYeI4KgVO
         pJbDPmVTsjvf9yK1o1pN3S/hrPORD2pMbhT6O3EkYo+zj5ZTWBt3qSLJYF1blsldJPZ4
         hnWsxZDSyQnA3UpqYPZYA+PpiBaWSPsD3cmjyCyQr6nWGfZdx2kj9Cx+t6kb4pbSSAuN
         ickURjtbgDw76jzkcMMRsADTUyVK86KbQiTwsxpIdhT/8JLc84f7nd+f//B1ZGKw4yIF
         yG1uGrTBJjwdUppIe9rhsTa3QX7LAF3e/PqjQXGHTrjKGWa6doGOVC5zjhLLMRfz0K8Q
         Kf3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWKLsepurmIgwAQu2oQYCyLdauqBZxWGn3+eFVVa1L6Ymlx59E7lPenW2b45gWjdAGe4V575vYzT4Y6jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWDd2zIog9bVKcaxP30P44aP97ORibCegIZoFAkWVqFQ4KVmB3
	SonJxTp6AfgNieFrInS8HjjGTHKPFQgj154Q1cpXXbbsrYFJR/OZXalS
X-Gm-Gg: ASbGnctwwHSH76z+q2ACPPaKKTo1f4T9st4KOAwRfkCS4PgyqW005Iqgwe/lULH8X18
	ZxI6HW7n1bxGSUWj+wIza69SFvQpzPG22llyTkqC+KmYppfCMdhfX9g0sgiS4OpBy672gTJBetZ
	9O4Fe83t6G638XGbRPSJmaL8wGudy3aTIRDPa8w73yqEF6FX3BMmoJwf1mB1dOP3SMkNsoelK+D
	Sh14jQQk1TkNOQ9O5F+Vz7paE2i/bxaOlIr20ukRRtH21hXP3zXjRIxMcKGwe4eZ6r/HaI4ktQS
	f6KJQotpI/tp5u9iWCD17A9Pgp5RzTC3qQ9BiQHdABKEQUcEU/GtptZgooCZ/vglO1tlVzZRMDB
	z7y5jMH0USIwJh51pqA==
X-Google-Smtp-Source: AGHT+IHOkzVtTGSJTwNmbg3z+KP8NHPcTU/o7KzFNOnpCVXQwOy0R5xTlB2QHMbSZDCe++0b21e2tg==
X-Received: by 2002:a05:6512:3b07:b0:55a:4c3a:b11e with SMTP id 2adb3069b0e04-55caf5d7b8amr1802321e87.30.1754553499405;
        Thu, 07 Aug 2025 00:58:19 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9b1fesm2501995e87.96.2025.08.07.00.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:58:18 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 8/8] mm: Drop __GFP_DIRECT_RECLAIM flag if PF_MEMALLOC is set
Date: Thu,  7 Aug 2025 09:58:10 +0200
Message-Id: <20250807075810.358714-9-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807075810.358714-1-urezki@gmail.com>
References: <20250807075810.358714-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocator already avoids reclaim when PF_MEMALLOC is set.
Clear __GFP_DIRECT_RECLAIM explicitly to suppress might_alloc() warnings
to make more correct behavior.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/sched/mm.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2201da0afecc..8332fc09f8ac 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -246,12 +246,14 @@ static inline bool in_vfork(struct task_struct *tsk)
  * PF_MEMALLOC_NOIO implies GFP_NOIO
  * PF_MEMALLOC_NOFS implies GFP_NOFS
  * PF_MEMALLOC_PIN  implies !GFP_MOVABLE
+ * PF_MEMALLOC      implies !__GFP_DIRECT_RECLAIM
  */
 static inline gfp_t current_gfp_context(gfp_t flags)
 {
 	unsigned int pflags = READ_ONCE(current->flags);
 
-	if (unlikely(pflags & (PF_MEMALLOC_NOIO | PF_MEMALLOC_NOFS | PF_MEMALLOC_PIN))) {
+	if (unlikely(pflags & (PF_MEMALLOC_NOIO | PF_MEMALLOC_NOFS |
+			PF_MEMALLOC_PIN | PF_MEMALLOC))) {
 		/*
 		 * NOIO implies both NOIO and NOFS and it is a weaker context
 		 * so always make sure it makes precedence
@@ -263,6 +265,9 @@ static inline gfp_t current_gfp_context(gfp_t flags)
 
 		if (pflags & PF_MEMALLOC_PIN)
 			flags &= ~__GFP_MOVABLE;
+
+		if (pflags & PF_MEMALLOC)
+			flags &= ~__GFP_DIRECT_RECLAIM;
 	}
 	return flags;
 }
-- 
2.39.5


