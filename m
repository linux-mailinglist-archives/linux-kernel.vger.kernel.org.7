Return-Path: <linux-kernel+bounces-750507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7D8B15CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF2A3A4B64
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF40293C6F;
	Wed, 30 Jul 2025 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzL5KCjx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE86C293C45
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868794; cv=none; b=JsxU1fa8tZK49K2ud/Q7w9kYTPsDsa5w+nA3r2Tbww92YeH17Ct+C0uh65KFW42ysmSqDS2YheMnA+hmf7v3E29pcWlgoMPe3i8+soESgXSS8kPm5b1oL5L1N3IRjnn0PZ7xZMBU+crzDKVlBLwrKIIUIQm7XFFts3GvzP1NvLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868794; c=relaxed/simple;
	bh=AUDj59rYnczPCMf9wlp6ZingVWh2KbRausWbvPoRJ1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdrScaGkFniEktVouzo19WYxDrBPC9h3bD/Od+p3RtpK6cJvsV4x64XdI+XN8wMrx/ztlhvvDI83e4m62ymOTATAaZkFjzGae19HmzdlSLO9TgJWduesDi3DnkeJlWzoC7hJ9HF9j9sboOXt4PEr28E+LeJgc9iWVwiQYjg8rx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzL5KCjx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753868791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w8YLhjpZYCS4lKUs2U55ivx7YPJBp2KB/Xof2yC5kTA=;
	b=fzL5KCjx+RNSgSGOkZuWX7KV9ji/TtcmuqZCQmkAbfDJaBXzPaZ02Q2rLNhksGMs33ya3H
	Aya7uf1fR3IY/QGvVsEVVJDc7F2biGOlvtU6g5xg61U6KLpWrTzneIOeizOFfIrEtIMYd2
	X9dgPjZAydqj7ivSS2WJslW3Hj30uM4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-ggWpYXpzOdGEL5eWbbYL8A-1; Wed, 30 Jul 2025 05:46:29 -0400
X-MC-Unique: ggWpYXpzOdGEL5eWbbYL8A-1
X-Mimecast-MFC-AGG-ID: ggWpYXpzOdGEL5eWbbYL8A_1753868788
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4e713e05bso2310174f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753868788; x=1754473588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8YLhjpZYCS4lKUs2U55ivx7YPJBp2KB/Xof2yC5kTA=;
        b=vOpCCgxb7Ydl2RE/nrVkLVkc/Fgd9HUXB579waNFyAiiQIM78LokJ32cj90zNbL4jZ
         jkn2Qcf8yG9N2rMZVSjDPBYyChYVgSCRw0/qleadLy9vA6ALRh4HTUffYsAipDoGbm9j
         +geb+6FsMBF0PICV4B2mjoG+zMxq5hdV5OEwCHtNFT+Pzn+aEAJJc9Ia8DD1E9ynd+TJ
         zbYbBfB7vty5APFj++HiXIiC8msLatar0/53oyLaqsEV4IH7LApFPpp6EzHZRtYXQp9D
         GVWkVY531oMeKunIFpprd/oNyeJBZ6cZ7/+QQIHJFsQDN0L+oj+SSCJfbsy6gikQFB2E
         JRIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG6NRTCXZFxitDSj5krpd/Xi1DfM11+nxL7IaDTgdXXH4KNZzLEHTQgqWoPKqSqm7c7O/NkuUijkTrJ48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBoOjZh4HyJUCMfX1KulfTn51tG5UFJghAjNwGN4+THH4ecjT7
	ByxbvsZTiaRrx2xigoHFCMnZCHX+6klnRhoJ6EwKZtVYR/xgh66IpgSV1wZfTHad9k5LtlphgXQ
	4Rk7TVC+U5vpVBoOOx729J0CgEuemkz6EQ1hErZ8jju/rCVFWJpNNyh+hGvAveNkH/A==
X-Gm-Gg: ASbGncvoAXm7rCuW/juCuVRFBDw7Kq1jVpWrvD2+XG5NSByR00Q1g1sL4s7NKnXDxA8
	I7CBF+oroG6/t7LTfCOBxZ/WWn/AGHSwyjKamBI6bFSHzmDoB/NM5rC3fQHg5mwt/m9fJl2spTM
	6S2YtbaBmZav6wVOijAJk+V7gRAryfjJ56pKXNkQhr6gv343H9Q5DzFq89PVe2d74Qcc2wQG9jW
	gJ+XULMBFObozN2BxkGRanJVGX+sPoLQif9zWOHshW21MLcyRnNHVP0c/O0VMOgKBjDE+bNcl4J
	iyaVZEb//xtLQRdfF08h/yie1swmCAP2WUxDGYnn13dHZ8Ap6nP1VsGv+eW4WHVHbJNDWA==
X-Received: by 2002:a05:6000:41d3:b0:3b7:974d:5359 with SMTP id ffacd0b85a97d-3b7974d597dmr873875f8f.32.1753868788363;
        Wed, 30 Jul 2025 02:46:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKkBPIcxvn3I2VLjanO8enRfr0E8zNPS46Uf7PRzUN7RGEKOsEdB7MUQb6QgWZ0jBstua6bA==
X-Received: by 2002:a05:6000:41d3:b0:3b7:974d:5359 with SMTP id ffacd0b85a97d-3b7974d597dmr873853f8f.32.1753868787970;
        Wed, 30 Jul 2025 02:46:27 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.43.90.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b785258135sm11317502f8f.42.2025.07.30.02.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:46:27 -0700 (PDT)
Date: Wed, 30 Jul 2025 11:46:23 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, clm@meta.com, linux-kernel@vger.kernel.org,
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH v2 02/12] sched/deadline: Less agressive dl_server
 handling
Message-ID: <aInp78zC_WwVW6yd@jlelli-thinkpadt14gen4.remote.csb>
References: <20250702114924.091581796@infradead.org>
 <20250702121158.465086194@infradead.org>
 <CAMuHMdXn4z1pioTtBGMfQM0jsLviqS2jwysaWXpoLxWYoGa82w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXn4z1pioTtBGMfQM0jsLviqS2jwysaWXpoLxWYoGa82w@mail.gmail.com>

Hello,

On 30/07/25 11:34, Geert Uytterhoeven wrote:
> Hi Peter,

Apologies for interjecting.

> On Wed, 2 Jul 2025 at 14:19, Peter Zijlstra <peterz@infradead.org> wrote:
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
> Thanks for your patch, which is now commit cccb45d7c4295bbf
> ("sched/deadline: Less agressive dl_server handling") upstream.
> 
> This commit causes
> 
>     sched: DL replenish lagged too much
> 
> to be printed after full user-space (Debian) start-up on m68k
> (atari_defconfig running on ARAnyM).  Reverting this commit and fixing
> the small conflict gets rid of the message.

Does
https://lore.kernel.org/lkml/20250615131129.954975-1-kuyo.chang@mediatek.com/
help already (w/o the revert)?

Best,
Juri


