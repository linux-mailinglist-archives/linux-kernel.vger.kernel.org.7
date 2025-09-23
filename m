Return-Path: <linux-kernel+bounces-828687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB4BB9532A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A582E52E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536E231D373;
	Tue, 23 Sep 2025 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZY+DlXSo"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9E2318151
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619017; cv=none; b=bZdsL2eHA7DnaZA0cRqhjLBHf7GYtSK/rV04GSwmURPPmYnyRBU6klplswJy/OO0c0mWnCKBr/6+bIfHmyOg7Lh7xj8lgw6fYrda251/dgBWRrr+6MwUitBXv++c5u/79WwSeOsLXDkQIcJJBUYxt2/LM30rQ7m0I8VG3zQDFfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619017; c=relaxed/simple;
	bh=AU412Bpf49FFmisY/etBQ+7iirkt/xVlj8aREaYYDAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yr1iM9A21RrfaDgEdD/jun1TVCwHFU6sTzwDc7V7YQr8k+Nbh3kmU5CVgQvsBA2Chq2iVeRJwlS6XbGGST1RhYc93R6oWlG4IMjmLVX8ebjPLcnVcg8AyH+pLVfIU/axB8a+lyEN3YVLLSau5jmaAmzF9XfJvQAco5vwK5y7RXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZY+DlXSo; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-330a4d4359bso3122563a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758619015; x=1759223815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vRIzRAWis1O+Krw5uc9gzQHxpU0thSXw3zEc2VjfIw=;
        b=ZY+DlXSoTf12nqaS1o9IaGl26ZPlx49zXWo6COAlzsvh7Y22Vz1SUJi0x24dqQuAeK
         2CuFcBArQUSLCCUg4yJ1/OWCfLmflcuPgIrWALl1B/JnSFr+q6CUpD8PxEMlylB97tHu
         D8HIK5JzcA170JIF/ssynAQvLDG4k2DQvJJG6oDaaPXEtHA7v+2PG147JbNonDtIs0yD
         xJeNNU/HFdoJPvZuxHFh+B0hY5YsvkK2YcPs8iTk22hwjw6oAVcHRjFMgd5TuNF4Gg4V
         zIoewie3rfgJx6s3wtaHf3iyH+BA6FpxRKnTl/21BIxpOzv/YX96bCVAoeVk4nJhMUkR
         D4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619015; x=1759223815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vRIzRAWis1O+Krw5uc9gzQHxpU0thSXw3zEc2VjfIw=;
        b=OWywl25XvJ+SuRaQ2JfKe7sLWMNqMVTBAx1Z5A1njTuootoIFwp14pqCMP2OcdSi9e
         z5YR8EODOvAEkEJGWjQfkYJAGGwJo2k/ryTuK9o4Vr1f0nYQTI0t5ryrl2swLk/gSveh
         Abv094vU4cX/Gyrn7sm+ZrXdTbBThcmHSuiVSCqZ3LshidV8CGZZfbIRGoklrlr40FQn
         LuN+ehWezaa1lfW78KqjSLksW9bO9b0IWnfOYkC6JLvZyZKgOqW47x1hpETjHCTbaz8C
         36T0oTY0LGuDGrfh3ZzciSX39KMcvP57xEzdwcW5WIP1IZnQ/+y/7J08lXEs0UNhNBWm
         4sAg==
X-Forwarded-Encrypted: i=1; AJvYcCXotgBMIctCISUXe/ohqTj10hp8CUzRT+abRKSYyRxe5gfJKl7Kg+YC//C4qlNvyTsMRsbhkWzStvsxaFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5snylD9xMvXqFEMH2m0ed3fKdjboC6yg0hjaP7XcessIk2eO
	r4VILikny+9XbSlDJ9KhArFdEkXmDZE/suNXyq207uujHpzuXD0SxjIUI12TzuEtCcI=
X-Gm-Gg: ASbGncvISz4Zkbr9m2r0gAZ+0IgbXo/aWwlW9zsF4UW7qFiRIdQdKcmojbSwy1DZsQL
	ZgJ5w5OVKG6wFuq4fApgzZZ4UgbBGelD32033AUwm62uxJiaw1eLGVgxLXKkVuS2Jx+nyrT89P4
	4dkOmXkMB2OZkQrcO1QoF7KXHiTQpfUMlz39N6QrtR4hFXuEuqb90EvLLPEB+pMlCNbb5MYsIZS
	ngvVyTJB13dmWgs/k8yFgrr0gAK2b2EhvmV+cNr7gOMpK5BWaH/cqMRCqi+Twndic6wV8UzYMbH
	TKoc4X3HxLkHDO6NPXuCWCqUtWSZoNFSKCFqo2WtTYaYhTrb/0HBHZQ3LP60HT7E9Y8VKFyhfGO
	8MuX2Ft4ccRcdnW2Wf7DXch1xzgL+Wex41hnC/vQBPJ9xdOSN+5GYYfhMSKBbKLdoAeXziL0=
X-Google-Smtp-Source: AGHT+IHwALepKfuy3l2UtqVt0g85ATZ63XzujHyf6JpHaHemjaQ8df2V5+fXQ28C3kJ2VnPBxstLCQ==
X-Received: by 2002:a17:90b:1b4b:b0:330:4a1d:223c with SMTP id 98e67ed59e1d1-332a9515d33mr2709085a91.15.1758619015333;
        Tue, 23 Sep 2025 02:16:55 -0700 (PDT)
Received: from G7HT0H2MK4.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed26a9993sm18724713a91.11.2025.09.23.02.16.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Sep 2025 02:16:54 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 1/4] mm: thp: replace folio_memcg() with folio_memcg_charged()
Date: Tue, 23 Sep 2025 17:16:22 +0800
Message-ID: <0ac716fb7fea89ada92ad544f88ca546e43d1f29.1758618527.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1758618527.git.zhengqi.arch@bytedance.com>
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muchun Song <songmuchun@bytedance.com>

folio_memcg_charged() is intended for use when the user is unconcerned
about the returned memcg pointer. It is more efficient than folio_memcg().
Therefore, replace folio_memcg() with folio_memcg_charged().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5acca24bbabbe..582628ddf3f33 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4014,7 +4014,7 @@ bool __folio_unqueue_deferred_split(struct folio *folio)
 	bool unqueued = false;
 
 	WARN_ON_ONCE(folio_ref_count(folio));
-	WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg(folio));
+	WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg_charged(folio));
 
 	ds_queue = get_deferred_split_queue(folio);
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
-- 
2.20.1


