Return-Path: <linux-kernel+bounces-780492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E79B3029F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563951752BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90355345752;
	Thu, 21 Aug 2025 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRCy5NcM"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16676345741
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803392; cv=none; b=QSrMv+4cDWdr5hxBAWB0flCvQOhkNPPALVWR87eoFr4GoR1AkFL2luwxIElfa14KxwvXg50gfxLTIjyjgz8y4oMYzfM81SRw7erfnxbm+7yXZNwoiuXenUTVJDdmfild7nTERf/7fHkEueP+RHvtRLH4Qv3JXv5FaZ+1k1adk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803392; c=relaxed/simple;
	bh=A0rJJQ0psye2AE9FItqw6Nhq8v9s5jczfsn5959EUFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oV3/C4yCXlRj08r15suBGR4Ve4vgNlgtjH17yf1oJhDiQ/XvOjzCSEnB5sNsUmKJBBFnxSSB0URtLNacR9weaY6TvvphvhHB/yoH80UGucilIZZNQJJilMzY3sMifrSc5q8d3UVKXkP/eBWWGhWusI6TWErJyIGEQDfiXS5+0WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRCy5NcM; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9d41c1964so636498f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755803389; x=1756408189; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eBKwML399L5lBZbUoL8fRkzIp4IsNuZpwsbwG4R5O98=;
        b=eRCy5NcM7nrofmDJ3rSjDgW0iD5yS5l08Ml8rtIoMJuA1T3u93TSC7zSiSeP4x5J0n
         lAAIzEbqiQ+iuqn8Bq6+ilHe9Z9Zau4QP0rKZzzf95f5IfTcstvw+BiuMBINrJrvhVQW
         jcGJcr7dkcS3Ia7SZn+ZwlSmakLGz8M509URAh453YRT1/Zq8SQweNqzAGoALWhy480N
         6jIypHmC4W93UN7e9G3kdiiyQL148CVMDJAeI2O2CKhCOuPiY8vpDwHjQ5po71Pt+mKY
         93RTcQzc8ZdadPk0YLE4MOJq++Xlz+O70Gzb78/IqXRxryHBjtxxC1+fLnXShVjDTKkR
         cSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755803389; x=1756408189;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBKwML399L5lBZbUoL8fRkzIp4IsNuZpwsbwG4R5O98=;
        b=TN/RZUO8+YIAPmEX9jT8G9Dxuz4X1U/kJaQqTFQxZhD0N62QGqnZuuKDx84LSzFr2s
         IuPFmVujhedK+i1sBLCoc2AHniI69K3RMMfEJp38mYbkS0Ugy+29XYOrb1xzmQjxT9uR
         xnCbE1b2e4JtvzI8MY1YnRLuinqlkvMm5cy2KG7R0luljR9nCUdSdg6bIQT/98KZTnQW
         Z+yCJH2H760tGRscIwpwgUu9Tn7ZZgblodpPfRj73yVsTrkqbY9nMNWxT0aG7IRkcDAP
         UFeTNdkmOb7Ukn+v2zRI5pa+AXftWMpI5Q5/HySnLCw9Ki5ttEAIwvfxiBEM5iBYG+ii
         B6ew==
X-Forwarded-Encrypted: i=1; AJvYcCVK9utP/dBWJsEqRlzCGB6IR4u179veVH6QzNCnD9SK+v2sTtRYCcKntZaS1m/OO8hhBLSkrtM7WTjL6EY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh5tCq+g7y8eR6HOiDtVy38mLKX4thGSafA70ax2zVMojoy025
	G8qebGsdzA+Mc0+Sqh8JfD6k7mU2MhPTYJ/akV0rDuRlrTkSLAgng7uv
X-Gm-Gg: ASbGncvPcT30j+7KpjktH98hvALMiu7Jukd6i+tRQPlMtV+gHgVrG8iUlXzuVXSHNLn
	ef4tCfYDtb5EH32ePaudndfXbwFxrFyXQgYYPTolZbTLNZGmhmLPnfqbxywAWFl8ty00LLzmYAb
	yi8Dfg26PkxDZe2P605Bi6jvzWSFsfQJ/Dwdo4v6zWdiUnQA4qEkQv5cCqhAVnPRx7VZpiuPdVH
	a4plpgDZkeIsyATQ0mVjDYOCQEZKkh+3vV8zVb/ebS1XPN5bSnB+dgrv1zq+LhC2JRaV+HlSj74
	vbVDlfxP4AOBlaK3JmEP7Epo+8nviGK6C5TN7WGZoFtODUMMNDT12ZqleRc6Pq3rEgY899nAyIG
	nZBiIc3eI8a+UUokhY1QjUK0Gt/oDKVi0AFThfo6Bhu5lxQ==
X-Google-Smtp-Source: AGHT+IHTSGMmQ9ox02sZlz59fzYLCVtspAv1IbbNtcttWrN1lXKi1VnhvttXHw0YcoD/pgDV9DsT3A==
X-Received: by 2002:a05:6000:2f86:b0:3a4:eda1:6c39 with SMTP id ffacd0b85a97d-3c5da931b49mr93942f8f.13.1755803389021;
        Thu, 21 Aug 2025 12:09:49 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0748797a1sm12013437f8f.5.2025.08.21.12.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 12:09:48 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:09:46 -0700
From: Yueyang Pan <pyyjason@gmail.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>, Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC 1/1] Add memory allocation info for cgroup oom
Message-ID: <aKdu+o4JrxujCwt3@devbig569.cln6.facebook.com>
References: <790da5ffebf18a5a1211ad8dbe4e5b4a19871408.1755190013.git.pyyjason@gmail.com>
 <20250814201114.1921580-1-joshua.hahnjy@gmail.com>
 <aKM3j3geY7JiPGQ8@devbig569.cln6.facebook.com>
 <CAJuCfpF11tbq7eEhzJ-7cneGKXDg5cxQrdWNVo1whyLuFQGzmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpF11tbq7eEhzJ-7cneGKXDg5cxQrdWNVo1whyLuFQGzmg@mail.gmail.com>

On Wed, Aug 20, 2025 at 06:25:56PM -0700, Suren Baghdasaryan wrote:
> On Mon, Aug 18, 2025 at 7:24 AM Yueyang Pan <pyyjason@gmail.com> wrote:
> >
> > On Thu, Aug 14, 2025 at 01:11:08PM -0700, Joshua Hahn wrote:
> > > On Thu, 14 Aug 2025 10:11:57 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:
> > >
> > > > Enable show_mem for the cgroup oom case. We will have memory allocation
> > > > information in such case for the machine.
> 
> Memory allocations are only a part of show_mem(), so I would not call
> this change memory allocation profiling specific. The title and the
> changelog should be corrected to reflect exactly what is being done
> here - logging system in addition to cgroup memory state during cgroup
> oom-kill.

Thanks for your feedback Suren! I will change the title to be precise in 
the next version.

> As for whether it makes sense to report system memory during cgroup
> oom-kill... I'm not too sure. Maybe people who use memcgs more
> extensively than what I've seen (in Android) can chime in?
> 

In my opinion, the show_free_areas and memory allocation profiling data 
can provide an entrypoint to understand what happens with cgroup oom. We 
can also compare them with historical data to see if some memory usage 
has a spike.

Feel free to critize me if I am not making sense.

> 
> > >
> > > Hi Pan,
> > >
> > > Thank you for your patch! This makes sense to me. As for your concerns from the
> > > cover letter on whether this is too much information: personally I don't think
> > > so, but perhaps other developers will have different opinions?
> > >
> > > I just have a few comments / nits.
> >
> > Thanks for your comment, Joshua.
> >
> > >
> > > > Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
> > > > ---
> > > >  mm/oom_kill.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > > > index 17650f0b516e..3ca224028396 100644
> > > > --- a/mm/oom_kill.c
> > > > +++ b/mm/oom_kill.c
> > > > @@ -465,8 +465,10 @@ static void dump_header(struct oom_control *oc)
> > > >             pr_warn("COMPACTION is disabled!!!\n");
> > > >
> > > >     dump_stack();
> > > > -   if (is_memcg_oom(oc))
> > > > +   if (is_memcg_oom(oc)) {
> > > >             mem_cgroup_print_oom_meminfo(oc->memcg);
> > > > +           show_mem();
> > >
> > > Below, there is a direct call to __show_mem, which limits node and zone
> > > filtering. I am wondering whether it would make sense to also call __show_mem
> > > with the same arguments? show_mem() is just a wrapper around __show_mem with
> > > default parameters (i.e. not filtering out nodes, not filtering out
> > > zones).
> >
> > The reason why I call show_mem here directly is because cgroup is not bound to
> > a specific zone or node (correctly me if I am wrong). Thus I simply invoke
> > show_mem to show system-wide memory info.
> >
> > >
> > > If you think this makes sense, we can even take it out of the if-else statement
> > > and call it unconditionally. But this is just my opinion, please feel free to
> > > keep the unfiltered call if you believe that fits better in here.
> > >
> > > > +   }
> > >
> > > NIT: Should this closing brace be on the same line as the following else
> > > statement, as per the kernel style guide [1]
> >
> > Sorry for this. I will run checkpatch for my formal patch definitely
> >
> > >
> > > >     else {
> > > >             __show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask, gfp_zone(oc->gfp_mask));
> > > >             if (should_dump_unreclaim_slab())
> > > > --
> > > > 2.47.3
> > >
> > > Thanks again Pan, I hope you have a great day!
> > > Joshua
> > >
> > > [1] https://docs.kernel.org/process/coding-style.html
> > >
> > > Sent using hkml (https://github.com/sjp38/hackermail)
> >
> > Sorry that I forgot to cc some maintainers so I added them in this reply.
> > Pan

Thanks,
Pan

