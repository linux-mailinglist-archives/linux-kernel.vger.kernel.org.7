Return-Path: <linux-kernel+bounces-845913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3D8BC67B0
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CF2404C24
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EA72638B2;
	Wed,  8 Oct 2025 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA97Um01"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E372259C80
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759952206; cv=none; b=B5S/sD4UJnfma1guyEzQjOyt4XOSsSThNTydi3z46XHEBNC+SFEqNuF5vU7hriC67rHDF1gj9jxOUwXkaEC8TB3QHRPoK0IlT6whP3jTD+qby+MpOR3JpqUzOcE0amXzGyb+u+JppNGwAPqGGCw6XwNUHKJULMr5qhNRLCsvz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759952206; c=relaxed/simple;
	bh=Ll7E79Gg4d1JPkSdUd3Vazrtozyg144vEKsT+UQDLNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyUM05Y3iOri0Bi0g1jPNE5O48ZBrcHlKslMetaL1SaygvKf8Seh3u8R/DO4RRrgaHQ4RoOAlwzNu1QqcGhoqbwpzD9Ywo+3SeVRKHbyulK9UKuEiOMo+6yq4GiHJHUN2V0CfQsPpK3f6yxxEemhI5zWIHoV2haiCTISH6db5qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aA97Um01; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d71bcac45so2717777b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759952204; x=1760557004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moKwOhdpUyJ4bZcyz0xhC/UoJ3xCwW2GSEFAUi/lwOw=;
        b=aA97Um01LxoOqoyCbeXulN8kTxFvb3cexUYmThsfBmijl4UCGV23O/peJBGgcDi4Wq
         MlAxO4FcjBhe67+sJ5mf+nt5qeD+HLzLkKZsfboJq1qY7UrAOfHQOtL8UTKDcGXh2kEI
         hRYIMxTn1ekgZCeqAyuIu9mnjgUxk6oplaiMj2gBon4nlwakVf0lxpl5GwHGgKHuYkI2
         Rg+ZaH0jhtDKaKNtv5dhR0IIb1lNG0CEmihNokj5laSf55ih2toqvl9jX8cxu9U1hkLJ
         JxFLGBCc4bh9LGIvrl6oUEMBeNLTHJWPanSAy6JYCxedLm4OwcG/+W+UDlXYnccJRSrY
         /YuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759952204; x=1760557004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moKwOhdpUyJ4bZcyz0xhC/UoJ3xCwW2GSEFAUi/lwOw=;
        b=rO8VoDcYU8vEkKAaRzho1cDZV+vB5rP1McMSsEex0fZoE+w7Ij0AGtu0sp45oHccGr
         /3x7jYLaFFNLDefwLowiuy1MEA8mQiuKFJKSlsd6K3zqFgU/FW7SafB1LoutYoCXKiv+
         2MpYEXxKJ66yL2/uyEMR20RygJU9Yg8qsfgNWIFk0bxGki5myAeM8Pgbwx2JYarbWXd/
         WrVRkYejdUUB3cc7rT1OKnNMxgS3DuW/2Ud08DLgzFbPXWD4KmK1c9aV7KWaesnTOR7e
         qmHyklwSFdmdJRWv3OjunIP54RXrKFKNbuBWZc9cm7e/o0rhXxUYf22btg2HnWYig41v
         TVDg==
X-Forwarded-Encrypted: i=1; AJvYcCXG782AVeTF/RfXUKhhsaMkMJ2Fe50cqaP9pLFkJdmUdFd2lqXEx6CVGSNY7syTbSdwbMyPr1Z36XRbjVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyftansIHQ6SU/UX1f+kpUfg88w+mk5bEwc17M8h25S4/7QHiqm
	9Ft8+VhLTtqp/xp/h2ncys54muNlPrFPTeFSR48ZPrQfUL9Do16P6jsh/w+Ufw==
X-Gm-Gg: ASbGncuk9Ruhd7la4Z/j8G52Hk/sS2bNbhDlHfmM18QKz39iFo4TqzEmPd2gnhYfQap
	AScrUKU32pceKrrvzUFrKrRIWPFtd4Et+tlx788dPxv3yQIdTcbr5BjKuy4Wx6JB5jQt57Uph0W
	7PZ/tDHACx8REAR0mGNnjVjH6/PznOxAzMA4FmC4AtRYi8jE/ydSqs6W/26/TbUg3B6OkE2z0fK
	hkwjbvLUF0smumHoNrYz4nqwPo0MMUWCXqO9vPZhUOFTEUPnye6++vXcxNlasdkCHySQl51w7vg
	Xz7et6EKfKXQtKPmJGk1bXaNzDYQW5yYKhLpwFPiyiy7olHG4PfLJ3i/HtrhT53V9+P9ojWpxaB
	RbJPL/eJR7TGmmb/Bn7luJHOnesj0FS3jEsSJBoPGcBxkBIdGIU7HiXJM+9XBusV+LankKSQPrq
	caHNHArMfnLViv0g==
X-Google-Smtp-Source: AGHT+IHtB8Z8ID/pyVnrYXDZZOQNzUqtOOHCwxuT0b7AWpclaN93NeUezX9digLJSKp1/ekVgKu9Tg==
X-Received: by 2002:a05:690c:9a8d:b0:772:72d1:15bd with SMTP id 00721157ae682-780e15bd334mr60790547b3.44.1759952204064;
        Wed, 08 Oct 2025 12:36:44 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77fa89e5b38sm46859517b3.44.2025.10.08.12.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:36:43 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ying.huang@linux.alibaba.com
Subject: Re: [RFC] [PATCH] mm/page_alloc: pcp->batch tuning
Date: Wed,  8 Oct 2025 12:36:41 -0700
Message-ID: <20251008193642.953032-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1b72c0b1-4615-4287-bac2-c8806e56f44a@intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 8 Oct 2025 08:34:21 -0700 Dave Hansen <dave.hansen@intel.com> wrote:

Hello Dave, thank you for your feedback!

> First of all, I do agree that the comment should go away or get fixed up.
> 
> But...
> 
> On 10/6/25 07:54, Joshua Hahn wrote:
> > This leaves us with a /= 4 with no corresponding *= 4 anywhere, which
> > leaves pcp->batch mistuned from the original intent when it was
> > introduced. This is made worse by the fact that pcp lists are generally
> > larger today than they were in 2013, meaning batch sizes should have
> > increased, not decreased.
> 
> pcp->batch and pcp->high do very different things. pcp->high is a limit
> on the amount of memory that can be tied up. pcp->batch balances
> throughput with latency. I'm not sure I buy the idea that a higher
> pcp->high means we should necessarily do larger batches.

I agree with your observation that a higher pcp->high doesn't mean we should
do larger batches. I think what I was trying to get at here was that if
pcp lists are bigger, some other values might want to scale.

For instance, in nr_pcp_free, pcp->batch is used to determine how many
pages should be left in the pcplist (and the rest be freed). Should this
value scale with a bigger pcp? (This is not a rhetorical question, I really
do want to understand what the implications are here).

Another thing that I would like to note is that pcp->high is actually at
least in part a function of pcp->batch. In decay_pcp_high, we set

pcp->high = max3(pcp->count - (batch << CONFIG_PCP_BATCH_SCALE_MAX), ...)

So here, it seems like a higher batch value would actually lead to a much
lower pcp->high instead. This actually seems actively harmful to the system.
So I'll do a take two of this patch and take your advice below and instead
of getting rid of the /= 4, just fold it in (or add a better explanation)
as to why we do this. Another candidate place to do this seems to be
where we do the rounddown_pow_of_two.

> So I dunno... f someone wanted to alter the initial batch size, they'd
> ideally repeat some of Ying's experiments from: 52166607ecc9 ("mm:
> restrict the pcp batch scale factor to avoid too long latency").

I ran a few very naive and quick tests on kernel builds, and it seems like
for larger machines (1TB memory, 316 processors), this leads to a very
significant speedup in system time during a kernel compilation (~10%).

But for smaller machines (250G memory, 176 processors) and (62G memory and 36
processors), this leads to quite a regression (~5%).

So maybe the answer is that this should actually be defined by the machine's
size. In zone_batchsize, we set the value of the batch to: 

min(zone_managed_pages(zone) >> 10, SZ_1M / PAGE_SIZE)

But maybe it makes sense to let this value grow bigger for larger machines? If
anything, I think that the experiment results above do show that batch size does
have an impact on the performance, and the effect can either be positive or
negative based on the machine's size. I can run some more experiments to 
see if there's an opportunity to better tune pcp->batch.

> Better yet, just absorb the /=4 into the two existing batch assignments.
> It will probably compile to exactly the same code and have no functional
> changes and get rid of the comment.
> 
> Wouldn't this compile to the same thing?
> 
>         batch = zone->managed_pages / 4096;
>         if (batch * PAGE_SIZE > 128 * 1024)
>                 batch = (128 * 1024) / PAGE_SIZE;

But for now, this seems good to me. I'll get rid of the confusing comment,
and try to fold in the batch value and leave a new comment leaving this
as an explanation. 

Thank you for your thoughtful review, Dave. I hope you have a great day!
Joshua

