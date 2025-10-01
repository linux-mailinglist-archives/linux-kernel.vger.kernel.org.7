Return-Path: <linux-kernel+bounces-839282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FB7BB13E7
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2752E189169E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67242283FEB;
	Wed,  1 Oct 2025 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="MPk5QQp7"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485D32749CF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759335836; cv=none; b=dCRhC6IoW+DIyeLbZPoRy+QoQ47B0ZcvRuZG5SCQKE/KRCLNkn5UjLVBhQ/QYMVs8vCl0NU2e37W642dejxEcKH4mKqX/gpmuA8LW8DmyWx6loIFdyqDWMoj/1Z+WYaswxnptXfxE4Hx/9wYMsqvn0fAu1MhN2EoTAbnYtrv0VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759335836; c=relaxed/simple;
	bh=SAqVm/WJEyyiltmfB4qy82jD1skdlpusFrEa8LZK6HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qI3NEI80WonlM5BYlPJdMWzh52Jxqhu4FpNtwBstjkgulHKfhFcj8mukUuQT86b+oAWUq8bWR64PSQdusHxObeiA94xgsHe4nwZFFGLgnsnqZ/woqG0GIOQ9bpF/ac6unqyQJo1koh+LqlZYyqOAQiatO3ZLZ/nIFa0SdKZwasw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=MPk5QQp7; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-799572d92b0so878886d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1759335832; x=1759940632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtSz92xfp0z5FAFfCkpEorqCZtizHpWeCxJ+OLFh6+I=;
        b=MPk5QQp7sqfrs3hidfV6UkWQj/NBKRJ6MnW+9DF2sq0YqHOYEWw1ADGJLxRN3cvMr9
         AvXP17V+xxIFMNh9YbryOkXlg03jVoCH3ibQItlCdxgZfzuW2q6wGILDCkOA6yoSRtyN
         XbvEW/Oa6PFiY5vm6wWqqT/B++PUcfVR3rTSAr1ipebSt7Oe3I5x7TbRCapaevw5942X
         b72ywm4iojXx2siXbIXjorzKb3pe4oTreHsxmEDPlZ2ivDtJvMTFaVOHzF/RZEbfQPbq
         KhdOy/ZmI/Qk9AoxK4+be4iEU4GO+rY8RJ5OaYby4VqgihQkVgkxiNrxnRn35cTNSfeK
         KVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759335832; x=1759940632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtSz92xfp0z5FAFfCkpEorqCZtizHpWeCxJ+OLFh6+I=;
        b=Q147D7teSiy38nRpA2hm1tJUhp2SM5gQP7ypoorMmK4778pZRx+UL0lglQD1Plh3QH
         kYL/50vpg0rNuwmqjxLctWz7JpZJnLzNaQHXf42ZhZNkq+TCsJVNkmldURNubD4TsXIM
         IbUu5dxVi1QTNPTHXd9JxXtWodDehlCpkl/E9FDuTbp8boM4AYzIXzQAMqs7yB82Waj9
         2R0njUJoqjBYNwcYNzR9Az4Tym1+AwVYFMeaj0lNuoy7FhhgshnvNaSDcpR/HfagUKeW
         NLvD/ajE2+EBkYNEi//orNNUp/ghoTrFEb3s1lX5VbXJSVpiWyGoclQqdn1HBE6m7IUC
         ZOVw==
X-Forwarded-Encrypted: i=1; AJvYcCXYa5pHbM9aoz+7Mwpt2251ha3XcQRwa1bKGm8WX7qANFyiTaQPcyMM/FO7Q1YHnlDD3HpJlFW0qA95dl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQfQDi6PFFwaqnP915amItj5t5cCW0dseamyu1X15Tkq7TrFzo
	tipfKI3ZSZoLRssBlYxWWkZe3tr7V4CcSDOJzZka/MYfOsMkKJacJLK9i+DQF82wEVI=
X-Gm-Gg: ASbGncv46eP3h64CX1/60D36heBXCVcA85vXFQzxTcH5o/Gm+gNFHEYEdRycK3y4jeD
	Oc3vyS9DrSjY1kIAvzns8RObD0I67m7B/TSVd1929gFFIAbTr+9Q5nFTGG65kpCNOotOTPMMeRp
	JKOrRvBHAvapwU/xWRUWjs3EXmpz4lzrLfXa0P1zOHOt5ldQP1iWYavA+AJdAhUyHxm9TvvNTYm
	7S7SF91aCKgC4gcVJxdtiDpkf0QmJ21zCnBFhN2PMv3nA2LtFecVoK5QuvOxf0ioBgl64ds8DEL
	fuDNvveo6QT7iwyLEeyGtwIZ6V1S+uwzHaU3HYOSIey6QYR6KT/1cvXOWwBL+ft67eWhuSjLuIq
	WcdcddDnC0FmH2/Q/zixFu80SISjpS7cQaTAyKnsCI68DtA==
X-Google-Smtp-Source: AGHT+IFDH7ieVM2AheaHk8sAZnU7O28AmWII1fzXYLrDz43DEjvw/hV5xRCTCYfjLf+80FEaCh6AyA==
X-Received: by 2002:a05:6214:410a:b0:812:c072:db14 with SMTP id 6a1803df08f44-873a704d499mr67800036d6.50.1759335831817;
        Wed, 01 Oct 2025 09:23:51 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-878bdf52e64sm598746d6.52.2025.10.01.09.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 09:23:50 -0700 (PDT)
Date: Wed, 1 Oct 2025 12:23:47 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH] mm: page_alloc: avoid kswapd thrashing due to NUMA
 restrictions
Message-ID: <20251001162347.GA1597553@cmpxchg.org>
References: <20250919162134.1098208-1-hannes@cmpxchg.org>
 <6B65DE2D-3A40-4E48-9F5F-8E807066DD5A@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6B65DE2D-3A40-4E48-9F5F-8E807066DD5A@nvidia.com>

Sorry I missed your reply :(

On Fri, Sep 19, 2025 at 01:18:28PM -0400, Zi Yan wrote:
> On 19 Sep 2025, at 12:21, Johannes Weiner wrote:
> 
> > On NUMA systems without bindings, allocations check all nodes for free
> > space, then wake up the kswapds on all nodes and retry. This ensures
> > all available space is evenly used before reclaim begins. However,
> > when one process or certain allocations have node restrictions, they
> > can cause kswapds on only a subset of nodes to be woken up.
> >
> > Since kswapd hysteresis targets watermarks that are *higher* than
> > needed for allocation, even *unrestricted* allocations can now get
> > suckered onto such nodes that are already pressured. This ends up
> > concentrating all allocations on them, even when there are idle nodes
> > available for the unrestricted requests.
> 
> This is because we build the zonelist from node 0 to the last node
> and getting free pages always follows zonelist order, right?

Yes, exactly.

> > This was observed with two numa nodes, where node0 is normal and node1
> > is ZONE_MOVABLE to facilitate hotplugging: a kernel allocation wakes
> > kswapd on node0 only (since node1 is not eligible); once kswapd0 is
> > active, the watermarks hover between low and high, and then even the
> > movable allocations end up on node0, only to be kicked out again;
> > meanwhile node1 is empty and idle.
> >
> > Similar behavior is possible when a process with NUMA bindings is
> > causing selective kswapd wakeups.
> >
> > To fix this, on NUMA systems augment the (misleading) watermark test
> > with a check for whether kswapd is already active during the first
> > iteration through the zonelist. If this fails to place the request,
> > kswapd must be running everywhere already, and the watermark test is
> > good enough to decide placement.
> >
> > With this patch, unrestricted requests successfully make use of node1,
> > even while kswapd is reclaiming node0 for restricted allocations.
> 
> Thinking about this from memory tiering POV, when a fast node (e.g., node 0,
> and assume node 1 is a slow node) is evicting cold pages using kswapd,
> unrestricted programs will see performance degradation after your change.
> Since before the change, they start from a fast node, but now they start from
> a slow node.

I don't think that's quite right. The default local-first NUMA policy
absent any bindings or zone restrictions is that you first fill node0,
*then* you fill node1, *then* kswapd is woken up on both nodes - at
which point new allocations would go wherever there is room in order
of preference.

I'm just making it so that iff kswapd0 is woken prematurely due to
restrictions, we still fill node1.

In either case, node1 is only filled when node0 space is exhausted.

> Maybe kernel wants to shuffle zonelist based on the emptiness of each zone,
> trying to spread allocations across all zones. For memory tiering,
> spreading allocation should be done within a tier. Since even with this fix,
> in a case where there are 3 nodes, node 0 is heavily used by restricted
> allocations, node 2 will be unused until node 1 is full for unrestricted
> allocations and unnecessary kswapd wake on node 1 can happen.

Kswapd on node1 only wakes once node2 is watermark-full as well. This
is the intended behavior of the "local first" numa policy. I'm not
trying to implement interleaving, it's purely about the quirk that
watermarks alone are not reliable predictors for whether a node is
full or not if kswapd is running.

So we would expect to see

fill node0 -> fill node1 -> fill node2 -> wake all sleeping kswapds

- without restricted allocations in the vanilla kernel
- with restricted allocations after this patch.

