Return-Path: <linux-kernel+bounces-863176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54584BF72D9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0191885256
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA37033FE2D;
	Tue, 21 Oct 2025 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpF58KJa"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4614333FE11
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058472; cv=none; b=OJVbriG/v8FKEvqjpPXxNAmLb6DQt0e146jLO2HJbzF9Mtj8tSyiw3y6yPggikr37m0bVrWvVcGE+axrB1tmRGU13uth/IcKnf7PIRFpj0v+f5OIGriFRvFzrylumk7jQRW/+9aCfLW7Rz7oJjPR0wBfB0cU411zqMtHmoGx/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058472; c=relaxed/simple;
	bh=702PiU3r/kYopEgHLFAnL552xteE1/5s+d2SVginB7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKgfKbr2u9STsGPF7U7CCHcsDinth8h7h1T4kW5gZfPtY+5GS9wcq8fuT8eSTRcTY4CZy7Zq9VuXKNEsWSFHGRp+o949eDUMoga9OvYVw8U5xgBselaHhmkDvsNaooI+1TUJkwWS7AQH/++i9Na8/6AZLbVm5StLcBrO85QzwoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpF58KJa; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-783fa3aa122so46374597b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761058469; x=1761663269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Qi5vS8iEF7QtyXh07bja2k/V4HvOygxjGkF4YKo9MQ=;
        b=KpF58KJapCymCasCWKPWXdQdmXZioZUDRRNT/9V3ZQmyIc2jwCpOjNWqQCeb3VLtY6
         /oX0n549Y0pp3NCuPkjfekWbAYmK7jwWICXIMuVnhDcmMngnKFwwSlwKQsgGhkSNboh5
         ZHpZ2l8XEDF5CfKji8HWWURB8GU0AEchaZpXhwN+n2zFJteDP4OgyaeIztDRtGEqHoY+
         qig928o0f9uY9XWs4sjrMb+QCSo/VnXvp3/o+b6pXx7vd0yu2exi8OIHYy3WxYnnazPI
         hUsksNdS51mYg0+1kvOVFVujVBFCosQytiX8kvGfBIDmIj/dkbOlpTIjjRfwQhi13jfW
         Cshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058469; x=1761663269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Qi5vS8iEF7QtyXh07bja2k/V4HvOygxjGkF4YKo9MQ=;
        b=sRSfVr6I1kqqWrF6Woh7bI1UrT5EIxHxw8Oyka9qza+m+ARRtiTBD/intzioxXsd3D
         U8r+gDfogCbhyRPbcMKA1zyOG+JyJiBYeAWCoq4DJAi0FX3ExED1o7mwPfymdiTJXhG3
         gPUHEYbzx5ipx62cUHkCxJFlmB2pxB/q8XWQbcW7Q6H0BzJr+sny+a5WJUyl0c5qy8qC
         oFsUfjoxpbUNhiFn3+PunRJtGNT2+EQsWaNt502957ioCZ8T9KdQ3XZHcIKrT0BVstjK
         zxDH8I0ydDPcwWjUlFEQZ392NMSsPkB5IJpNNf5VVkTLltxwQ9YKNtteKXVlVdRwV8B8
         HXMw==
X-Forwarded-Encrypted: i=1; AJvYcCWc4I4oADcY99zS9SJn/Sqkr+88JylSQfqlDaiQSNO3D2mweE5SXa42aGfCFFoU4TIAHF7lOpDCift7Xq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDiI0kF97PYfpSeDv/iSO1Cj8FQai9EkN7cXZDB8C8V5xfHYHa
	UysCKlSJa/EyctqhG3/WU9V6qHVeBMVg/O1L/Oi0D8jyWjtr+uNXVqjO
X-Gm-Gg: ASbGnct4usypI8y1usPc1kfzdzRhlFDGOcZk4zEVk6FtD0HG4w0S2jbQhmuKGhHTCT7
	3h6/r27DRI6T0+gOLedg9wMwYpXnmgrjJ6BCKJNSvGp3GpLy4/1gOWW+bvUZ3iCxabDseoepTci
	2rU1TmD2LKYHjROWFlc/3gkq82yiE85/ipEK3QUW0vt57cFIN6ml/FLvlsh+HJaHlvLawp9ik8b
	g3uEo0sI4BgrBvQRn4ZUjEqpA06A81l5ceLgb+yO3DP/X9KRHxfFKtHC1sxq16RD+NbPpNdZMhn
	fkmub9xXMMfZUtujlhs7bAAPTADhVJ+vVwsLKASv1/KFatF4FnOXhPvAs/noM424zFxbZbICkzC
	5CHL/ol2sC99GWXjIT2EcZPY1cLl+QQe2c4WtQj3UciWrtCr6hv2bOT67+VS/e7tY/gBlSXC2qu
	kM0b3e8AoNIiNySkss5Un59T7ZAEhmmbdLWZQmwKYBmP9vlfzBeA==
X-Google-Smtp-Source: AGHT+IGxPdsEqlA6SzXzoXcdF+PZJOGhAIN4Wj/cO37w5ASLEJUIVOHCB/yQlrssEQq6UGl9fxNsCQ==
X-Received: by 2002:a05:690e:4195:b0:63e:2286:e6e9 with SMTP id 956f58d0204a3-63f27e387d3mr48108d50.15.1761058469224;
        Tue, 21 Oct 2025 07:54:29 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-784674d6361sm29679307b3.38.2025.10.21.07.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:54:28 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	liulu.liu@honor.com,
	feng.han@honor.com
Subject: Re: [PATCH] mm/page_alloc: Consider PCP pages as part of pfmemalloc_reserve
Date: Tue, 21 Oct 2025 07:54:26 -0700
Message-ID: <20251021145427.3580609-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021095004.12157-1-zhongjinji@honor.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Oct 2025 17:50:04 +0800 zhongjinji <zhongjinji@honor.com> wrote:

Hello Zhongjinji, thank you for your patch!

> When free_pages becomes critically low, the kernel prevents other tasks
> from entering the slow path to ensure that reclaiming tasks can
> successfully allocate memory.
> 
> This blocking is important to avoid memory contention with reclaiming
> tasks. However, in some cases it is unnecessary because the PCP list may
> already contain sufficient pages, as freed pages are first placed there
> and are not immediately visible to the buddy system.

Based on my limiting understanding of pcp free pages, I had a concern here
on whether this would really provide the desired effect. That is, the pages
in the pcp are not available to the buddy allocator unless we drain the pcp
lists (and this operation is not free), I was unsure if there was a clear
benefit to allowing the system to go unblocked.

If we are already at the point where we need the pcp pages to have enough
free pages to go over the watermark, perhaps it makes sense to just block
tasks for now, and enter direct reclaim? Allowing more allocations might
lead the system to be in a worse state than before, and will have to
go through direct reclaim anyways.

Please let me know if this makes sense! 
 
> By accounting PCP pages as part of pfmemalloc_reserve, we can reduce
> unnecessary blocking and improve system responsiveness under low-memory
> conditions.
> 
> Signed-off-by: zhongjinji <zhongjinji@honor.com>

[...snip...]

> +int zone_pcp_pages_count(struct zone *zone)
> +{
> +	struct per_cpu_pages *pcp;
> +	int total_pcp_pages = 0;
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
> +		total_pcp_pages += pcp->count;

Could this be racy? What is stopping the pcp count from decreasing while we
are iterating over each online cpu, over each managed zone? Under the
memory pressure conditions that this patch is aiming to fix, I think that
there is a good chance the numer we get here will be very outdated by the time
we try to take action based on it, and we may require the system to be
further stalled since we don't take action to reclaim memory.

[...snip...]

Please feel free to let me know if I am missing something obvious. Again,
I am not very familiar with the pcp code, so there is a good chance that
you are seeing something that I am not : -)

Thank you for the patch, I hope you have a great day!
Joshua

