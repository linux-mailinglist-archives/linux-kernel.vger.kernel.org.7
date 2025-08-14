Return-Path: <linux-kernel+bounces-769540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFF9B27010
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E90C5A4C49
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12D624BD1A;
	Thu, 14 Aug 2025 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="DqwGo50X"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D924729D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202340; cv=none; b=qVTRZ1hyGkfzz0OVkE872f8ELuZ0iTryuQmFrWT1IHdH2Dzt9XmLyGRe1C6gX95m4VPglwD/Jtu1ndYhlvZzO5h5ur9akXYPSHx/DN66B+RmGaumdvtk+YpuRnohdjI0CxA/GZFYyolOEqdoJ/VbVBUsZdrgpaNCgdvFZHE/WFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202340; c=relaxed/simple;
	bh=TTSpjuvnk1jXcWH+lZGc1qcYnMaoH+/zqB++fnB2mU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lobGFYaZsoFfLrdBH5Mj5VE7t+idgfiDa2sVAaTdT1oKFH0ZAYl84LZ3tz4CeD04t41Hj8D3MvLZ17ldF0LSGD05X6z5Mmsa5GRSZ+wRa5IKPOlLi8vl6kLJ5YHBIvC7/vp5INDwo0K9O3I45x+bG1FQttEZjQRJtogEl0optvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=DqwGo50X; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b0faa6601cso24970991cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1755202336; x=1755807136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vxzbcrq7nK91VwgR31UC0slmrQGlL/0X3fwR0ytXvYk=;
        b=DqwGo50X+MOUqSiDSUA/QaDBNcxwEhqOEMQ96yDA8bKj7+IkTuyO/rpqj3r6w8exKx
         OR0uCk2kquM3E9ElqhVqaco3DXyE1ecfIXk9z3wFgGPSz5tlxWh5I00CUqxYouDicPW4
         PlGcWbtomtdmWTE4EHrzyVMVM+PHeHgRm35BIjRTI93wuqw8nZ3IXu/CG7LI85DJHJgH
         1jypIaAobOTrYt7f3EWP84MjWxJUXqXaUmIuu+nVZ4xMkrxeykHWY1SIlmAEt1OLrIU7
         m3O1g89pKBEMDK8nJp6iT0rCcznyhBaqMUfLyEwfhyRa9oiNHggQRdX/6kDD1Wd5SyTD
         5OLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202336; x=1755807136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxzbcrq7nK91VwgR31UC0slmrQGlL/0X3fwR0ytXvYk=;
        b=HRzPzkdKoTourwA0rlSKXY/aQbhc9iPS1MLF51GmtZbglnFgEaCoAt0KVdQ7wz5nZQ
         HNE4M2DbmLAg1A00AkgMqgglXnQzpEZV684bptYbb8Ivv3mQtJCvwc+tnBc022ARSgEy
         BgBQeW9Y0yTgb7snkB2gvoviaj85klXsi7oCWwC01tcVw34NEj2A7q4n/34Fgpw8OKOV
         I7E9KP7r1ilWMAMfYRhH01lEAdrYfAhdr5v6D/B+NVDr1OGL38jAHsU8WbWeStknW38s
         7vNKZcjrJbzcahcdjOfgnNLbqvqL5Pm3CBRyJHpCYslJvByGcj+c5Ohdx+p89Kzkej6I
         87dw==
X-Gm-Message-State: AOJu0YwQBw0RyPwtM+DP4fXVvsIwBYuboVLN/fbj7weyuCTnxm3W+oI5
	klb4ZQU+2+BC3eWLppT2bLyUHwHyMlkZT0SdXrhSdfVtVY5p49CT/OzcNfFpccdCTII=
X-Gm-Gg: ASbGnctR4vOj/Ym72vgpYR8F49Eokzhuc8zodaPIkhA5vW6XGYAEz2ja9nY3JF527qD
	xk8vuc5vetnrsxJVaImMZpaihNnPT5k9Tz3qOniQfpDuMtEj+KfMyUqZTDdu/P8SQ58GlJPqQnj
	5enl3hmMvbdGQroUcFmNsPJkW1dJCufBg+1UMO8YxoOHug5+X94HrMfySgzPzZ++Km64OoX328L
	0MUDiHcubcHxSYjb0BGDbo2d4K2VRsPPmADebSaR4Xtw7ripbQZGxVCbAFHezU2uGaHDWn3qu8R
	g9VPGjIklf/Im5rZ4i/qXJMfPNC2ckYzf0F+oPlWq/Fsr8PviI/GPdwU+jbv9FxOtH20WPLwj3q
	LzhKcz3T7Ov9ffcc3BN1L+ggG+fyFFU4P
X-Google-Smtp-Source: AGHT+IHGbf38wjASlzpdG8s8MvlkeKwc6OkOeZzYzGmyvaBvUc5P6M+am5GJahVd5Ex2+2MRB/ryEA==
X-Received: by 2002:a05:622a:248c:b0:4b0:8a29:b5c with SMTP id d75a77b69052e-4b10fbf3e00mr47146221cf.2.1755202335629;
        Thu, 14 Aug 2025 13:12:15 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b11a87ab86sm1040601cf.5.2025.08.14.13.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 13:12:15 -0700 (PDT)
Date: Thu, 14 Aug 2025 16:12:11 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	Mel Gorman <mgorman@techsingularity.net>, kernel-dev@igalia.com,
	Helen Koike <koike@igalia.com>,
	Matthew Wilcox <willy@infradead.org>, NeilBrown <neilb@suse.de>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] mm/page_alloc: only set ALLOC_HIGHATOMIC for __GPF_HIGH
 allocations
Message-ID: <20250814201211.GI115258@cmpxchg.org>
References: <20250814172245.1259625-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814172245.1259625-1-cascardo@igalia.com>

Hello Thadeu,

On Thu, Aug 14, 2025 at 02:22:45PM -0300, Thadeu Lima de Souza Cascardo wrote:
> Commit 524c48072e56 ("mm/page_alloc: rename ALLOC_HIGH to
> ALLOC_MIN_RESERVE") is the start of a series that explains how __GFP_HIGH,
> which implies ALLOC_MIN_RESERVE, is going to be used instead of
> __GFP_ATOMIC for high atomic reserves.
> 
> Commit eb2e2b425c69 ("mm/page_alloc: explicitly record high-order atomic
> allocations in alloc_flags") introduced ALLOC_HIGHATOMIC for such
> allocations of order higher than 0. It still used __GFP_ATOMIC, though.
> 
> Then, commit 1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH
> non-blocking allocations accesses reserves") just turned that check for
> !__GFP_DIRECT_RECLAIM, ignoring that high atomic reserves were expected to
> test for __GFP_HIGH.

It indeed looks accidental. From the cover letter,

    High-order atomic allocations are explicitly handled with the caveat that
    no __GFP_ATOMIC flag means that any high-order allocation that specifies
    GFP_HIGH and cannot enter direct reclaim will be treated as if it was
    GFP_ATOMIC.

it sounds like the intent was what your patch does, and not to extend
those privileges to anybody who is !gfp_direct_reclaim.

> This leads to high atomic reserves being added for high-order GFP_NOWAIT
> allocations and others that clear __GFP_DIRECT_RECLAIM, which is
> unexpected. Later, those reserves lead to 0-order allocations going to the
> slow path and starting reclaim.

Can you please provide more background on the workload and the
environment in which you observed this?

Which GFP_NOWAIT requests you saw participating in the reserves etc.

I would feel better with Mel or Vlastimil chiming in as well, but your
fix looks correct to me.

