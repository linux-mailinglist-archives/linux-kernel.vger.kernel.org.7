Return-Path: <linux-kernel+bounces-835397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58982BA6FBA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 13:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B2DC7AD80E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76702D8793;
	Sun, 28 Sep 2025 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="huLBu34I"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD64935950
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759058258; cv=none; b=RPY9B7dxK2G43Oy0urWDs6ObqpXTQbUy/9wDhwIkKQ8hJYEVEpsmo+2Su3Sdc1p4KLK1dVMbpPsRVX7aHGP5mD+5D5QRS1w3mOo4xFlzK9PPmipdh+zgpwsvM3Day1etHIbe3kQ4B1KmU7B37LOQLacTMqVbqswz2kASiwG79NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759058258; c=relaxed/simple;
	bh=7xtZd7Yd8EegYDFC5RFSYuo7Ki9HOkuue2yjH/U0y5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owRNl8vsMS6sve3EWYVaOdwbbxlRvqD86edVoxlz413F6Nm2nJY0CXtxdiUfEEIPdSAJtkapjcvXN3QKzYewp8XtnkGhJ95SFNeqGgY5dZQw2D3aRyTvdnd3bpzJ5IoX3aT4gAIBOi77PLQOVlZRI/V3y3gJSE/L1AGcXk2dwWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=huLBu34I; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78100be28easo2661824b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 04:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759058256; x=1759663056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1ekZIO3b9Ttpe972UQJNalil++E0ZqVPkWGV+cChaI=;
        b=huLBu34IMCAeO1FRXhGke5OvTBCjcfYlX8ZtAQEmYTMv0IlVeD0zDYLQRWIauyvJwP
         UNxWuXF3Xixt4kyUMfbXluxOIH13Dz6BPIoOUtnm5273wAo0hhF3VTNsZSG3Hhele6fY
         CLBv+ppfaFSNR1suYZ+6L0q7G9LA62Ko9Iy+FlQ2KicxLITfYmHUv3gZ4xwrbw4igSbo
         6MsiyWBVAaGYgtN2MUettURfLtFIGNeENXR0BydKTmyRqPqOxfSBHc9nVfM9CT4TR5aA
         AkJmY3mMp7oxK5jADEKMaq6jxEK1kfgdKoqcQ66cbwIry1Hc1mjPFfBv6hlHHDuvy0t8
         522Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759058256; x=1759663056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1ekZIO3b9Ttpe972UQJNalil++E0ZqVPkWGV+cChaI=;
        b=mhZXtJsRsPN9lWVkhZ+pZIZwXTN/fux3J6cTFoa2YQJx8xCqlFTt1dBVIM9W5ah1Wh
         w2FUK8KQwRK+BDbj9Duq7DfJ1oQQ6xzEW0foyXusX/+PvjiVc0Dn8JJlW2MKHzkTX0np
         0kTczH0V0JW/1sMM+iwWantmQYQj/sQsgxRSh65jJs+CBLPzT2awrUxtCIGdQej+Z00H
         VGtwo5Wi95zPMyM671Tc0kTaLY4zMNqj6k9RG545mHSmx9G6qYoSdGRUs1+uX3tQGkTR
         jEm/tCJ2w8rKnVaWdj4vToBxEYBg89+54b4yBX/+4MbbU8wSIXFQZ+7+YEzMp7kHDpwE
         njUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEsrNa9g/5LMdCkSJv6b/6iLwz/auoME81hqxrGMDTGT3re3ntM4ltazWSbOqNDAkZDdBaCflIP4GlWgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM+nWF5MBBPee3Nmd8Bt6iEbGCdq7ooispgvu1vNKjIIlx7H9p
	MXXeLBIRVyQTBpM8wVzBwgWuSH3FkiV30h0rJ7LILYCeeJ+hU4KEf+WeBHQ5lsHEGPM=
X-Gm-Gg: ASbGncu8MI1CUpj1wXbir8iSr4V8vM1WCqDp6Upq5b5qqEmg4T9RGAutEkGUc9TJuaN
	hYIg1Knnlaaq0DcA+0Qxpn6hcKyaz/hBHZ+KxCtmh4NW+u4TVHrQvZrbObJ2RRkz2HTgqWzhUPw
	D6kmKhvBE0aGYJp7loCFUXD3goVg+QpPwe6fXiIYG6vptPpXiGX16pAt/HP0M+tuTeZgNrwbfdo
	1XX0RGWHIjfFVUT9C3ew9ZCC9irk89h8CUmaRX03neNp/RHhEIuQoSU5j3PQZbnx3ndOSyzhLVP
	yxNnnJRyyL06qzkoCBoyLiZZQQ5D0qY/8TzQQ5fs2q8bzReJBB6rSqtZmDxvumKAP86am/7638c
	DwRskXi/0zVjwLaPi60Z4zrKh5g6UQbzDmD56IPf5rbV0HyZJ5XELDICvrfdXDcD2ZU6qPQw6m5
	Gb
X-Google-Smtp-Source: AGHT+IHqrAqU+jC+qNEzoF4LOIdPO8yTHXE2d2ywkwGRffVmCfyJBJS1CU2Vm8Q37E39F0I3wqfN2Q==
X-Received: by 2002:a05:6a20:734e:b0:2c6:cdcc:5dd2 with SMTP id adf61e73a8af0-2e7be80995fmr15796544637.11.1759058255924;
        Sun, 28 Sep 2025 04:17:35 -0700 (PDT)
Received: from G7HT0H2MK4.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a2c45sm8687451a12.45.2025.09.28.04.17.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Sep 2025 04:17:35 -0700 (PDT)
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
Subject: [PATCH v3 1/4] mm: thp: replace folio_memcg() with folio_memcg_charged()
Date: Sun, 28 Sep 2025 19:16:59 +0800
Message-ID: <488cc8d44ba9ef1ec8ed2b32e7267d83cfd5736d.1759056506.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1759056506.git.zhengqi.arch@bytedance.com>
References: <cover.1759056506.git.zhengqi.arch@bytedance.com>
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
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1b81680b4225f..6db24b3a57005 100644
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


