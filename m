Return-Path: <linux-kernel+bounces-863506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9303BF8024
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2FD52343353
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D5534F241;
	Tue, 21 Oct 2025 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbB68hLe"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CF5246798
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761069885; cv=none; b=aG2IgjxN/JdJgy9crh4zu0SXPDhr5HbJCK8sKExO0Uo5bArRywXwpldHpv2GFAq4HdmQfGoF5O8Ttt2P8dbk6cHsi2Jasfsal97BkqB1xqn3wERFdI79GmatnxXrmXxKXBS6gvtrDEPmaDwgkTmhiyPos+zlmEc7j2HdBLZXOWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761069885; c=relaxed/simple;
	bh=np7tVhYEGy+oYVadx3C8u7TbzxNr9+KS+hG5SAI5vGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7MKuLBzS1fQ1+1Ei+F0wxW5Pdoj/40JDdF0zJ1+SqLHdfsjVfodN7cfSrgUW3bgLm6J5sYrvTCCa9yG5ETmNREN/RzZNJzkZRFAVH8yiHezCaC6BAq3xx3Fd6q5ULMPArD6YrdTfl9ssTCtRbGAD2r19GIDrmrU+jHY3ugSlCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbB68hLe; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so5498250b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761069883; x=1761674683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4iCI3a+n92vgiAmJChfOmOa2AiYR85oxFU1VLd511A=;
        b=AbB68hLeyYdln5Vh352wVR2XKt4K1iP4lIqMju6LyOnpKv85K/yoo8e66G53pVa2FD
         BQnhwBeV/SL6J1xULfz4RRJgbXVCNLm0B08Pa+VtI3ssK2VwLBQipNTAqMGV7zYfO7Es
         Wcg0WikgVXBpw/eYlPHUaZuJuZxfDy3PfGZmYj5MaoGDFp6djiusuIy7ZQSFzrdlSmYY
         L0xWSg5mxGMxsrmawNzQA7wHp8WUuSgvcRAAyI1wOsqfWppBd9DiAzvE0MRFE1/ue2pB
         1LMVaapbcwl5ei9DOFOTGT7uM2MbWw0HjmhbcQsv2psRll9cyXY3ONh/tvBIaRoxcllp
         JtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761069883; x=1761674683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4iCI3a+n92vgiAmJChfOmOa2AiYR85oxFU1VLd511A=;
        b=tqx5jQqG/QZmacz7jUCPk7QFLDEN8ftfcqlFEzSGDmVbDjKxLvRobm2GNDqcWAcdGn
         ga4/Go5J64RxkiJbfL+kXET6t73GJzo37hMKHchUKU70uSkEq8R+0LKmYCFTVnkCzhB1
         eR7rEhlnhvs5XTpbSFzqMJNXq4cWsgg6G+dknH+FyYgGmzJDIKy24/Wk5u80G41TXz7u
         tWINZfvAsecVG5xH9RmpnSQ03rNZp6maWZTjYaDleEPi3t5Y6luIRQvJ9PA640toid0F
         K2KJl8jNQfmOiXn8tlMMhJ+a3NUjZcLikt3YCO1qIlk3VmoD1TaDo8By5gtu6KZoaOou
         9PVw==
X-Forwarded-Encrypted: i=1; AJvYcCUym9sA2Qc6DCAe/yRk3Z+DhWTBuJRctyoXya/gDOAwqBts/St5B9AKJ1Ufsh0QjrBVQOMU97mDY8ei4Js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpn17VdU5Z99fezBZNCdgmvFK+n8ukGWAzJ/QsoREPXaNGTteC
	yYAVpdSAXMaPsL1w9fMzdKagQ8f/ACrNaO4iUSVDXBkFfIFI7yU6OHY3
X-Gm-Gg: ASbGnctoPOXWrcqCtiWmS9MZ5nM1wkUqFXXMDLyu068EWWUbcQxg5ic9gmT7f0eH0Eq
	H6MbY5VOlw2LD5AQ668PQPyK76iz1O1qeGww8HAUwunwIwXVDYxkbyvAW81RLqdiuc6QzDDgdqJ
	3uXqI8RS9oiaq3MYpV0ylBF/0uAilRlq29eVIB6WDnyZ7Lgafee92/D8hDGnm/gtpUzzainTWTW
	UQ5E/97nA5THpiQ/LZS6sDe2yTp1Ecipw4LirUNd6fGpnrzO2OzDLUpCzBqqUSZ8fxLiVkWS1am
	Xo9mUkfClm/8XT/Hx1FTxSFQkxNtQf9vN0XrO7//wJJdP+a418IlVKJKEBB3NlAV3qbu0jswMa8
	0JJ2hfgE2zbpUCfaamDZoRPJewmpKzkF/I+U2dQp0rVF74vGPGnjOTJXm6uJkoe/c3pZVISWchS
	RtTF0=
X-Google-Smtp-Source: AGHT+IFfvvRkT1o2E+LzW6g4zp1WME2u+yySBZYFy4r0G2UY/dg1eygrIwDL+LUnDjEL11Se4Le+KQ==
X-Received: by 2002:a05:6a20:42a3:b0:32a:91c6:e085 with SMTP id adf61e73a8af0-334a8504812mr20539937637.11.1761069882926;
        Tue, 21 Oct 2025 11:04:42 -0700 (PDT)
Received: from daniel.. ([221.218.137.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34e72sm12016944b3a.24.2025.10.21.11.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:04:42 -0700 (PDT)
From: jinji zhong <jinji.z.zhong@gmail.com>
To: joshua.hahnjy@gmail.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	david@redhat.com,
	feng.han@honor.com,
	hannes@cmpxchg.org,
	jackmanb@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liulu.liu@honor.com,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	rppt@kernel.org,
	shakeel.butt@linux.dev,
	surenb@google.com,
	vbabka@suse.cz,
	weixugc@google.com,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com,
	zhongjinji@honor.com,
	ziy@nvidia.com
Subject: Re: [PATCH] mm/page_alloc: Consider PCP pages as part of
Date: Tue, 21 Oct 2025 18:04:35 +0000
Message-ID: <20251021180435.11789-1-jinji.z.zhong@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251021145427.3580609-1-joshua.hahnjy@gmail.com>
References: <20251021145427.3580609-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Zhongjinji, thank you for your patch!
>
>> When free_pages becomes critically low, the kernel prevents other tasks
>> from entering the slow path to ensure that reclaiming tasks can
>> successfully allocate memory.
>> 
>> This blocking is important to avoid memory contention with reclaiming
>> tasks. However, in some cases it is unnecessary because the PCP list may
>> already contain sufficient pages, as freed pages are first placed there
>> and are not immediately visible to the buddy system.
>
>Based on my limiting understanding of pcp free pages, I had a concern here
>on whether this would really provide the desired effect. That is, the pages
>in the pcp are not available to the buddy allocator unless we drain the pcp
>lists (and this operation is not free), I was unsure if there was a clear
>benefit to allowing the system to go unblocked.

The purpose of this patch is to account for the memory in the pcp list
within memalloc_reserve, which would allow more tasks to enter the slow
path. For critical tasks, entering the slow path represents a better
alternative than being throttled until kswapd wakes up.

>If we are already at the point where we need the pcp pages to have enough
>free pages to go over the watermark, perhaps it makes sense to just block
>tasks for now, and enter direct reclaim? Allowing more allocations might
>lead the system to be in a worse state than before, and will have to
>go through direct reclaim anyways.
>
>Please let me know if this makes sense!
> 
>> By accounting PCP pages as part of pfmemalloc_reserve, we can reduce
>> unnecessary blocking and improve system responsiveness under low-memory
>> conditions.
>> 
>> Signed-off-by: zhongjinji <zhongjinji@honor.com>
>
>[...snip...]
>
>> +int zone_pcp_pages_count(struct zone *zone)
>> +{
>> +	struct per_cpu_pages *pcp;
>> +	int total_pcp_pages = 0;
>> +	int cpu;
>> +
>> +	for_each_online_cpu(cpu) {
>> +		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
>> +		total_pcp_pages += pcp->count;
>
>Could this be racy? What is stopping the pcp count from decreasing while we
>are iterating over each online cpu, over each managed zone? Under the
>memory pressure conditions that this patch is aiming to fix, I think that
>there is a good chance the numer we get here will be very outdated by the time
>we try to take action based on it, and we may require the system to be
>further stalled since we don't take action to reclaim memory.

Thank you, Joshua. Indeed, the pcp->count might be outdated by the time. 
And kswapd will fail to allocate memory if the pages in the pcp lists are
on other CPUs. While drain_all_pages() may be triggered by direct reclaim
on other CPUs, some hard-to-predict scenarios might still exist.

Perhaps performing drain_all_pages() before actually calling
throttle_direct_reclaim() would be better.

Like the following code.

@@ -6535,6 +6535,7 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
 static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 					nodemask_t *nodemask)
 {
+	bool drained = false;
 	struct zoneref *z;
 	struct zone *zone;
 	pg_data_t *pgdat = NULL;
@@ -6570,6 +6571,7 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 	 * for remote pfmemalloc reserves and processes on different nodes
 	 * should make reasonable progress.
 	 */
+retry:
 	for_each_zone_zonelist_nodemask(zone, z, zonelist,
 					gfp_zone(gfp_mask), nodemask) {
 		if (zone_idx(zone) > ZONE_NORMAL)
@@ -6586,6 +6588,12 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 	if (!pgdat)
 		goto out;
 
+	if (!drained) {
+		drained = true;
+		drain_all_pages(NULL);
+		goto retry;
+	}
+
 	/* Account for the throttling */
 	count_vm_event(PGSCAN_DIRECT_THROTTLE);

>[...snip...]
>
>Please feel free to let me know if I am missing something obvious. Again,
>I am not very familiar with the pcp code, so there is a good chance that
>you are seeing something that I am not : -)
>
>Thank you for the patch, I hope you have a great day!
>Joshua
>

