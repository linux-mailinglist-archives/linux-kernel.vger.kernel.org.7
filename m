Return-Path: <linux-kernel+bounces-757045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CA3B1BCEC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3B2189931F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8592BD598;
	Tue,  5 Aug 2025 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g61rqUeg"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3CA285069
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754435086; cv=none; b=pxuNNLsUriIbQ/TQxJCLjItXXBLZPh1X+JkbRaQvuqsIT6X2gg0K4bzfBE/4VYrEOaGCmlQHyTPLFFNnbnYRGcxHEMAewIlKKbfnP8/h41WfZkqqL95JKqFdS9COOsxCzg+VbBQpGm7tIvq+vxgxszyWxa+jXNegSGvhnDhyTOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754435086; c=relaxed/simple;
	bh=1fpF+OCOBLV1JITGv7/49hYzMNHxTYiRgPsygagG+bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK+LAR9m2DIx881Pcte+uK0hFR5xyg8+zkX6+hLG7VPRgj4JB+13bRzOeCmtlKG8IdpjmESLLLMreqno9WE7NQA8LOehXWLRhaQCM9o494vhzg1ge1DXKZJBJtuJpaEkM0fRvFEwyEFmExD2l9sDAECTR++PH3IsfNDsjBxgnLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g61rqUeg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45896cf24ebso48117715e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 16:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754435083; x=1755039883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1fpF+OCOBLV1JITGv7/49hYzMNHxTYiRgPsygagG+bc=;
        b=g61rqUegT425HYuOgB3O7iUk6MwUeJaaJEr0t/sfkqpVsdTkoVE3gN5Vgpa20Hhck0
         JWIl3cTTyjsJNOSUcQuOQgZspRJLsgAPuO3UcCzKpupIMuSeNT02iwH7g5vA6e1+Q4E0
         Mlj2IyfhBcmynwu+hSLrGqzam6f8xd0mvXUOb1UuMttBlGPsbVlGFdDa9kQ8PjUaj0Dn
         UluO6lmprfQipLJX3JQm8Jz5XuL9ARh1w3v1HysKzphcO/mCGFURrq9KNdPvwhWUdo9K
         OZOSU9toZdxYBQuMeLS+nNprIuWmt9mZFtCq0B3QXxaRS6Nnlz5NLWpMomaMvwBTokrR
         YHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754435083; x=1755039883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fpF+OCOBLV1JITGv7/49hYzMNHxTYiRgPsygagG+bc=;
        b=upbAPMNtYJhxavhfoTdDjhYOnX422fedFA8a4aQOjakm46xkoCmU7Vugxwy8VTutqT
         Di+SPVL3L7cuBXTJentRcSd3nHVQVHbXj7yjiOt4Tv2NiQSl6hkrAIKlYCaMRb6k+LR2
         1xOLIY5P0lpTcqJHkNDrbT5XOHaOjZPBzCety+ZaGM7WYDHB3Bp5PGOb8zHRlM0K+x5a
         0RlY6BdSewZx+ytMzfNtn9mi0zG9rRQT6ksUkHQrDEwiyo09O8QA/ohjLyFdoKQuBG2H
         KmZuwMY1x20jtzcMtc1u9jwHXvKp8qcGAAPxA6FT4PwfaTZCh6H6J8QmsWzBU1IEM97Y
         TvXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV7Di77jNx5bS25NN+sEp6gCSM7osomG3baK4mpTU5h5stK8/EqntWSnlQlonFIYQGaUXSaKQrKiITwQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtfem0ywbLpdC+EAA4RgXftMKHynq3+uvSM+t1bdVcjT4OVqCU
	rptdsz5rZyCauanh5sBx0TE3WGsXT2tuM944TS+a5ftVkSOdbAzjWR12
X-Gm-Gg: ASbGncvprFNlybp/glvRjXefmxHD09W4kCmIjAngZMN5ADgRmIU87qEIdEaVWT5NJvd
	a/FQrX/W9fJYBu4ft1ZVn8V7mqFn0H4HIdVoymULfZIdb3z3OL0KI3JWARKGEpj7btGAkSGdOGD
	w3wxM2AH0m2OLLxZeLFOQsHQpUiZf9IGIMbmvKBsYnsMb5hf3xhToZ8DR40ovDuSrUlrWrUhTW4
	q1xhIDOV2hKhg1l72jGC0SFAE2v8QNzwXnfPrk96lqachMzBvTXneCqWE1unQYmbFrcbHxq2ewN
	iMKaVRzQ6v+/FaPU48grLqRhhYQ5gxhdKtFwnqNEp4y/X6b70+3Z2WW1robodHDrO3E77h3RvTX
	ehUdHjrjOEsV8lcx7x5FbcdgoVLIPip0G7bP86Gs/2/f3
X-Google-Smtp-Source: AGHT+IEoPqo+7uMdKL+EUtu+MBlBhI6oPIaT7V8sBmZJs4qbHKnKAPKZiO/sDlFi+DABuVYaTNDQ6A==
X-Received: by 2002:a05:600c:4706:b0:459:dc35:dc05 with SMTP id 5b1f17b1804b1-459e741bc5emr3610995e9.9.1754435082704;
        Tue, 05 Aug 2025 16:04:42 -0700 (PDT)
Received: from debian.local ([90.252.123.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9386sm20737902f8f.18.2025.08.05.16.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 16:04:42 -0700 (PDT)
Date: Wed, 6 Aug 2025 00:04:40 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, clm@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/12] sched/deadline: Less agressive dl_server
 handling
Message-ID: <CAP-bSRaso3rcYJi9XT9oxDHPYKcmnD2S_5jF4iyaWYcZRadyXQ@mail.gmail.com>
References: <20250702114924.091581796@infradead.org>
 <20250702121158.465086194@infradead.org>
 <aJJ_yaD7R2oLsyKv@debian.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJJ_yaD7R2oLsyKv@debian.local>

On Tue, 5 Aug 2025 at 23:03, Chris Bainbridge <chris.bainbridge@gmail.com> wrote:
>
> On Wed, Jul 02, 2025 at 01:49:26PM +0200, Peter Zijlstra wrote:
> > Chris reported that commit 5f6bd380c7bd ("sched/rt: Remove default
> > bandwidth control") caused a significant dip in his favourite
> > benchmark of the day. Simply disabling dl_server cured things.
> >
> > His workload hammers the 0->1, 1->0 transitions, and the
> > dl_server_{start,stop}() overhead kills it -- fairly obviously a bad
> > idea in hind sight and all that.
> >
> > Change things around to only disable the dl_server when there has not
> > been a fair task around for a whole period. Since the default period
> > is 1 second, this ensures the benchmark never trips this, overhead
> > gone.
> >
> > Fixes: 557a6bfc662c ("sched/fair: Add trivial fair server")
> > Reported-by: Chris Mason <clm@meta.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://lkml.kernel.org/r/20250520101727.507378961@infradead.org
>
> This commit causes almost every boot of my laptop (which is booted from
> USB flash/SSD drive) to log "sched: DL replenish lagged too much" around
> 7 seconds in to the boot. Is this expected? Just asking as this is a
> change in behaviour - I haven't seen this warning before in several
> years of using this laptop.

Nevermind, I see this has already been reported:

https://lore.kernel.org/lkml/CAMuHMdXn4z1pioTtBGMfQM0jsLviqS2jwysaWXpoLxWYoGa82w@mail.gmail.com/

Fix:

https://lore.kernel.org/lkml/20250615131129.954975-1-kuyo.chang@mediatek.com/

Works for me.

