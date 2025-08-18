Return-Path: <linux-kernel+bounces-773833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0245CB2AB58
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818CE725705
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC4035A29A;
	Mon, 18 Aug 2025 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QurLzVBF"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CA235A29D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527062; cv=none; b=R4OXt3k4wd3+bJYOr9ZPnBljUKkhb1BgS1QLqYk2EralYffp1HtHj/ysYTEuzV+X5N4krlFKNTw22ss0TcqgOPQ67KEIP26oSE4ReIFvpADz4jj5WAyS0OoC/O71kY9MNiGcoYsXxn6LHPOxWK8OrYL4w6al0Z5g7eAIqcT3P9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527062; c=relaxed/simple;
	bh=5GhEYsH+1305FL+zk1y3EJ5rNo3RjdWVbNDq2bcdtx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pq5jayHeuoBt3J+61bMq8FXcHncSCn6vs6urLaRsnWB/Br+FiZwPRlIGPSXKVXyfkUsXguAZJB3DOX6Q8N5yYfHtvWiP4Tc5OJRje8juJxD+AulaDdsctMBfv0DQ8y+Rm1xeIE7f2w7r6LTQStPlRTGzpQNGF9EqZw1dmNY3kcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QurLzVBF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9e41101d4so2243508f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755527059; x=1756131859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nkI9YOv4r07AZaOuAgohpCftqKz/9ZS5s+LWNoe/iJ0=;
        b=QurLzVBF4HPEUJCOXZ1gJkwdQjEtAPMotfNCYw5eC7lwLaEK7WU9sulv8DbGOeAmU0
         8gEwlUH6Pe8WnZ2GDKDdeVSXgNBAVG+uch3JBRAtKIXFfGHvM31nf8Hho1tMsrwghMnb
         vxYNuKjJmzapQF91rtwo2t//dno5pXxfDpesUDf58lGlT1VbplUnCU1y/4bNEuRhhCvH
         LXslnsdq5ruXZUPIIZERA51HPIH7LMzICOK24j+QofLPHm8rh+x4+GPxBKF6m3WYmNGP
         /57JASE8ong5fC55OyiGT66y0c7GIE/DXmppCfOvGnqaa+xM8bj+3rhXROLxtrohrjzL
         MPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527059; x=1756131859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkI9YOv4r07AZaOuAgohpCftqKz/9ZS5s+LWNoe/iJ0=;
        b=V/XB9u3JcRYXGDgaW7DCj3Zt7RMJxamPnAz8gmDZkjifqTgAVI/pysCoQ7UwykIgD+
         Huj1l54qZdnfH5Zclq9OThx0PYB7WvNPbMLG1NnIBuVogEWoTmyyMQEUSqGbPQ0ZDFXv
         k7ZHupvtHDfXpiEuYETKeis7NYjCK+NE6d0hvrRwy0pCHkG/VCtr02aR9RmuLyz/msxT
         8UbGTzy8Yk6s46Jau+46hXUQ8lCl3CXsf0VPMFBPSiyFmrOelqFoC9sGzyYcGfOLXzMi
         cX/0/YJ0qovc8k0S67hRXP1soJBL2ePuhHThccNn3P0huaZHq75keFKM+xGKpIUCp+O1
         GYew==
X-Forwarded-Encrypted: i=1; AJvYcCWkqRFtTcTuzfI7JybtAZ0I8H9cfo+0l5pG27keLgjXEUTqp+dShOeDCKJ3Y8QcTlk8g98fLt/vRCxJ/zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkpPbxi+REmQfIjO9PAtQquD5QTSyrjYsPzn3f0H5MPHVIiDDm
	HIYfu57tQ16IhJNeTmFh19+rFgHWDpRwNB0q55nSZ8vZkDmV7wgAPYT3
X-Gm-Gg: ASbGncuo8R43r6yFZo5AL6fiUvUiwCwunrcElRNboOCGudcM66ub6y0CVpGaopKp74I
	NhpHpMTT/3Q2BfNnCfffadI0cRJ00bjTlxd7hVHy9TzZncBzbeKRkkXdbVCQhtOwZ4p/1IF+9ID
	CZe9PL0AmwsuG25JLdEZOwhimlE/Mp8DtAXvekxkAf/zEeCC8gP7GasR6VIWqanFGueE4VwIHsC
	WaGxUHbxY88wE6omnSD+5c5aUUdZxJxowiODWTjU84V3h4R5kr5vPBlRv+rxeiYAU1c87j9BdU1
	Or+rEfBMzWKF3v54Ho98sdyzl0CeqNmDA3bwp6u07EdkHBJbDrqdI/9c3/Ny5JkMgyElOzLp5XB
	ztPGuWoYgN+2BiefBlLb7+seSyQRxv1fXGVaLfx0=
X-Google-Smtp-Source: AGHT+IGdTLWM4u44zpOwtBDpQ2Dp43kHDYOCOmgNgAx+WJjoOXFpU3DOTXSDTQF0R6/1ZBdaFGtTJg==
X-Received: by 2002:a05:6000:40db:b0:3b7:8154:aa36 with SMTP id ffacd0b85a97d-3bb6665cf99mr10003559f8f.7.1755527058385;
        Mon, 18 Aug 2025 07:24:18 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:44::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c971bsm12838159f8f.32.2025.08.18.07.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:24:17 -0700 (PDT)
Date: Mon, 18 Aug 2025 07:24:15 -0700
From: Yueyang Pan <pyyjason@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>, Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC 1/1] Add memory allocation info for cgroup oom
Message-ID: <aKM3j3geY7JiPGQ8@devbig569.cln6.facebook.com>
References: <790da5ffebf18a5a1211ad8dbe4e5b4a19871408.1755190013.git.pyyjason@gmail.com>
 <20250814201114.1921580-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814201114.1921580-1-joshua.hahnjy@gmail.com>

On Thu, Aug 14, 2025 at 01:11:08PM -0700, Joshua Hahn wrote:
> On Thu, 14 Aug 2025 10:11:57 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:
> 
> > Enable show_mem for the cgroup oom case. We will have memory allocation 
> > information in such case for the machine.
> 
> Hi Pan,
> 
> Thank you for your patch! This makes sense to me. As for your concerns from the
> cover letter on whether this is too much information: personally I don't think
> so, but perhaps other developers will have different opinions?
> 
> I just have a few comments / nits.

Thanks for your comment, Joshua.

> 
> > Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
> > ---
> >  mm/oom_kill.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 17650f0b516e..3ca224028396 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -465,8 +465,10 @@ static void dump_header(struct oom_control *oc)
> >  		pr_warn("COMPACTION is disabled!!!\n");
> >  
> >  	dump_stack();
> > -	if (is_memcg_oom(oc))
> > +	if (is_memcg_oom(oc)) {
> >  		mem_cgroup_print_oom_meminfo(oc->memcg);
> > +		show_mem();
> 
> Below, there is a direct call to __show_mem, which limits node and zone
> filtering. I am wondering whether it would make sense to also call __show_mem
> with the same arguments? show_mem() is just a wrapper around __show_mem with
> default parameters (i.e. not filtering out nodes, not filtering out
> zones).

The reason why I call show_mem here directly is because cgroup is not bound to 
a specific zone or node (correctly me if I am wrong). Thus I simply invoke 
show_mem to show system-wide memory info.

> 
> If you think this makes sense, we can even take it out of the if-else statement
> and call it unconditionally. But this is just my opinion, please feel free to
> keep the unfiltered call if you believe that fits better in here.
> 
> > +	}
> 
> NIT: Should this closing brace be on the same line as the following else
> statement, as per the kernel style guide [1]

Sorry for this. I will run checkpatch for my formal patch definitely

> 
> >  	else {
> >  		__show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask, gfp_zone(oc->gfp_mask));
> >  		if (should_dump_unreclaim_slab())
> > -- 
> > 2.47.3
> 
> Thanks again Pan, I hope you have a great day!
> Joshua
> 
> [1] https://docs.kernel.org/process/coding-style.html
> 
> Sent using hkml (https://github.com/sjp38/hackermail)

Sorry that I forgot to cc some maintainers so I added them in this reply.
Pan

