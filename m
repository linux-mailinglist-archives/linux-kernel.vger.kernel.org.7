Return-Path: <linux-kernel+bounces-837806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B7DBAD3A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809751C6B58
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDBB2253FC;
	Tue, 30 Sep 2025 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLd1SxZq"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0328672617
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243368; cv=none; b=FeH4XKBy4aRQUtSz6jHBOL0iq+yfUXqIhYfm7msVSAo/CeM4eno0T2QC/SSYbonNYEd1dksPDhI8HBW6c4u+wUbOgIi8C10ljwqkItRcRny9prMTEVYm0spRnYT4mjRIWEkfLIkkv9MBTt1p+oO2T5N6J+unPsniVVmztBgjVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243368; c=relaxed/simple;
	bh=93Q2UHviESFqxWbAZoQ/bfgwlRtinDCURqnpF+hQRc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B84zjGl0F+Te/4blV95Tu3GVKIIVvDmRow/VHxmV04qjWGomlFzBPAs9830E5a+0czs09jRVTEeqNF0rFnSjSmA3dTOjGku+t3xf2R99A3DdxdVpT2IVv4BLxBbs+TzvTPsfuNGrGF3BPanaXzASK1EbTHtCCSuBexgM5W0zqYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLd1SxZq; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d60150590so61599247b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759243364; x=1759848164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4vkOfyVNOASDZ8RN89wGjL7/WcW/6y/QurTWddB4i8=;
        b=jLd1SxZqM/cWFPP5Ohny/4GeINPfTpwEEuLPGwN6GtKrC0ompiQedxkLM9P76i71Si
         OFxk8etDzrwqv3UrrNYYAz9Rah3u5PciCARQgrWPAcR18X+TkaATi5yAlzj8T5lK+kAh
         bI1oiDFDFRUthWjCoPEiv8xM9LpVDXKYRLp+5SD/H9Ecqg60yCEo3RZJ/RpGAxKTv2ba
         RRJlOFPZojkNaASx2C440SSbK2RVLudqKov3wLQdienm5sywrSa9wA4qlfZ+obYjCKIW
         1ysMtSEADg5ETf8kEKTa1bEymMxB/6YTl/YQ5NHrd+h5JacvNyHQkUHatVKIc0oyAOj4
         aCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759243364; x=1759848164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4vkOfyVNOASDZ8RN89wGjL7/WcW/6y/QurTWddB4i8=;
        b=GkZsDGcBFKtfX388jCiPGrHh233UksgEAbX82wF3/2UAau9LhilER6MXoKF6273KOr
         6TbjeoKBAgXffBg6By5tB8/PnaV3Yr7sKHK4iQycCCd8NTpnSJ5zKcnTMNuFL4CT50WY
         eN7YR8aG7n7leMnQFd+PpdpKps9kYcBUB8wGa5NZjoPymtSL7F+gsYrX+uL9BrbVNL/6
         2tLPUvHM+BJV60AzEiuSkGOULVyiWtiXaSm6sptLMAxwqx8P19uZ+P4RXDkhbgD/fjSW
         BBiAnxV5XwEe/0FlugOAr45tFfe48IEEu2ar1rEORUBYTstNVlBpLfFxXIW9ITYNhK4t
         YZIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaRiuqCnGVHg6XqDWYPShg7ZbFk77vIJXfYIQXmsSeC8NKZkMBdWhEKdCAGy+G1lJk4QsuZOOOquNuaCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSTsX8xasIjG8ap10zxVCync37Cpt3PSweKyj1pFEqdhKP768b
	wwY3ZtIWJvGikCw7I6em0NAR6Im4vykjpY6o+5Kzlo8BFvr3f5WK5vGM
X-Gm-Gg: ASbGnctkOWuJkYRw/8AuNyrJ7ez6kvSraWJqXj+yTwBGrOPidKwTepOrvfMiKrqeE9y
	55lQVXviey2KBjRJCmWgHjCl1fAQBNIZz3Th0CCUBOixq9LPDqegd9+xU+vpAr3lgUjpRy3lFpR
	Ee9wuVDS7rn67sT0/iHegKU74BKG6pJ1QdnvaSLWMHlJcVJJQqDR3U3YK+C+NJiPhWg3iMn7MYh
	OHLtJk2Ye2MZeNNN+0s/R7ItqtWGt7wyy0jk6kpiPsQPfVdEkDvzA7vUuT25cffiZT44Opjw4VJ
	p6u9e/LJoPHmp23H67dtzbhL5xEaP5See7B/KaperJJitPa0RNPipNtUAAY9khTQBiN/aT2mYP6
	dG3wbTX2GxSLUbBKtTp5XJ2CjIgHsmzDoAT4Z/efw1dcYwWTu2A1w+SEb+vHNt9D4pTgATrR4s0
	evxeqPsDIRJln1
X-Google-Smtp-Source: AGHT+IGFLbOdlIoJsKWFhzJr3Zr9Wq5OWyduoEy3LIKVzEZc048bz/UdbN0acRubA6Gf2aLu+Uui6Q==
X-Received: by 2002:a05:690c:e18:b0:774:2bc1:4aa with SMTP id 00721157ae682-7742bc1130cmr147112937b3.36.1759243363384;
        Tue, 30 Sep 2025 07:42:43 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765c60b7a4esm37971407b3.40.2025.09.30.07.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 07:42:42 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/4] mm/page_alloc: Perform appropriate batching in drain_pages_zone
Date: Tue, 30 Sep 2025 07:42:40 -0700
Message-ID: <20250930144240.2326093-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250927004617.7667-1-hdanton@sina.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Sep 2025 08:46:15 +0800 Hillf Danton <hdanton@sina.com> wrote:

> On Wed, 24 Sep 2025 13:44:06 -0700 Joshua Hahn wrote:
> > drain_pages_zone completely drains a zone of its pcp free pages by
> > repeatedly calling free_pcppages_bulk until pcp->count reaches 0.
> > In this loop, it already performs batched calls to ensure that
> > free_pcppages_bulk isn't called to free too many pages at once, and
> > relinquishes & reacquires the lock between each call to prevent
> > lock starvation from other processes.
> > 
> > However, the current batching does not prevent lock starvation. The
> > current implementation creates batches of
> > pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX, which has been seen in
> > Meta workloads to be up to 64 << 5 == 2048 pages.
> > 
> > While it is true that CONFIG_PCP_BATCH_SCALE_MAX is a config and
> > indeed can be adjusted by the system admin to be any number from
> > 0 to 6, it's default value of 5 is still too high to be reasonable for
> > any system.
> > 
> > Instead, let's create batches of pcp->batch pages, which gives a more
> > reasonable 64 pages per call to free_pcppages_bulk. This gives other
> > processes a chance to grab the lock and prevents starvation. Each

Hello Hillf,

Thank you for your feedback!

> Feel free to make it clear, which lock is contended, pcp->lock or
> zone->lock, or both, to help understand the starvation.

Sorry for the late reply. I took some time to run some more tests and
gather numbers so that I could give an accurate representation of what
I was seeing in these systems.

So running perf lock con -abl on my system and compiling the kernel,
I see that the biggest lock contentions come from free_pcppages_bulk
and __rmqueue_pcplist on the upstream kernel (ignoring lock contentions
on lruvec, which is actually the biggest offender on these systems.
This will hopefully be addressed some time in the future as well).

Looking deeper into where they are waiting on the lock, I found that they
are both waiting for the zone->lock (not the pcp lock, even for
__rmqueue_pcplist). I'll add this detail into v3, so that it is more
clear for the user. I'll also emphasize why we still need to break the
pcp lock, since this was something that wasn't immediately obvious to me.

> If the zone lock is hot, why did numa node fail to mitigate the contension,
> given workloads tested with high sustained memory pressure on large machines
> in the Meta fleet (1Tb memory, 316 CPUs)?

This is a good question. On this system, I've configured the machine to only
use 1 node/zone, so there is no ability to migrate the contention. Perhaps
another approach to this problem would be to encourage the user to
configure the system such that each NUMA node does not exceed N GB of memory?

But if so -- how many GB/node is too much? It seems like there would be
some sweet spot where the overhead required to maintain many nodes
cancels out with the benefits one would get from splitting the system into
multiple nodes. What do you think? Personally, I think that this patchset
(not this patch, since it will be dropped in v3) still provides value in
the form of preventing lock monopolies in the zone lock even in a system
where memory is spread out across more nodes.

> Can the contension be observed with tight memory pressure but not highly tight? 
> If not, it is due to misconfigure in the user space, no?

I'm not sure I entirely follow what you mean here, but are you asking
whether this is a userspace issue for running a workload that isn't
properly sized for the system? Perhaps that could be the case, but I think
that it would not be bad for the system to protect against these workloads
which can cause the system to stall, especially since the numbers show
that there is neutral to positive gains from this patch. But of course
I am very biased in this opinion : -) so happy to take other opinions on
this matter.

Thanks for your questions. I hope you have a great day!
Joshua

