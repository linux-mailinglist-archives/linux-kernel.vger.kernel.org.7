Return-Path: <linux-kernel+bounces-614952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8223A9744B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 20:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1489189C24D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 18:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A4C29617B;
	Tue, 22 Apr 2025 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="UHjNv6vB"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77C128F951
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745345546; cv=none; b=Kjf3UCRmdhUXpirPLufD4znqldQyke/lba02gmhP9UxapryPbHmrZnVNRDvltQYW1EltjNj06hsG6NakXSXU9mAOz2wGj01tZ3EmUv/S4lhI/eXHjUjEcwYPcXaLCgwwIHEmHGgJrGkKsDbKujVdJau1mVILeSQ9LQD+x9jgSBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745345546; c=relaxed/simple;
	bh=clj/7NiCGcVOiMu1ySLcl7Hi0OIoaRSBMSxeFaLMzIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ioa5bwYN6aQaD8id1EaxjmnUSrK5AUEXEpyErO82wf+shB2Qmue5ftOpTH2A7z8M5KKFFCA5RwBgtgkN4PVdcSAPYu1mwD5eQZc8GKSeHKJfI10nXOVO5E/jWwePrgPutSAPcSTPD2B9NBjiqPEG9iAhGI4Rr5oE2bWyAUuKkFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=UHjNv6vB; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47688ae873fso56998321cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1745345542; x=1745950342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s2MxjZUGMrKR2DMGYAmofr4Hh7XRlldZp9rSBjUPMDM=;
        b=UHjNv6vBL1vwgTJDTKRqlmWZoaG/KudTlWwAW+vjAA13e1ntvBv4AL5E1DmgtaerOk
         5S04BvfHmaB0RsOcMsZpsNbFXhLtEY7MBbfXtsDFvaxyPCP52iIahL0SC2FKGlLMoAGA
         Kc9TUancnyx32eoRsBckLN+zWIIMZ9nwoaPLwUJBMwLFE/Qmj/Yc9cYLBF3V2ssgKPhg
         xvyEBmOcuPWfZIPADVu3iFATWmOVNxcSFnQDtL9R86/4MCH8ZnzSbvma/1cf5uihIIkS
         9KjLC+TIjQ4ZNfU0f8xL0sR5dovE3C5638ZxN4RJz0TO7Rj/EIJcawFsQdO2WZQcjYdk
         8cOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745345542; x=1745950342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2MxjZUGMrKR2DMGYAmofr4Hh7XRlldZp9rSBjUPMDM=;
        b=KvAVY3KbZHF8WycKbHlcQD0RoUEK7iDlM+95eZjfYOoNh8oX2yJDyHkgGjqKvKZ3Zg
         RKu9eeYY+RH+/LFsuyC3+4O8+LxUERqvnouqKVTyLZd+Yvxpsi0tLeXT1as07mlPWayQ
         5G9ct45dj6sMe1BX/NidUFr9Q6js/menKVtHM09sTw9xIgvtEnJl0Fo4gPbNH0lJMqvo
         CLJaMNl9KJnwFj+2j7oukbTZh+ngCi9qSwck5oqnxcaXgmsNc2De9RMXzjBosX8Ua9eK
         WIHARIKvOFUkTiJrDxOMYHwsGedG79FiVeJkzMihCgB01JiCBWsnc87ytYs7qldTz+18
         8LjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbmSicEduoWhDJo+D2q9MhJegClGlNbLp6ArrAMpKGxXaFebQGRocSfhEBqrgW0WmM8rOwEB53BkSvMvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCs0447My/bKrLSUev4OLsV5q29z9vC5aSCx7TBjJdtmc3spxI
	d/P1vxJHxSEJsgtxDRr8aQW4gPP3q7rpQAhAZxNTOjQz/Ux+LN8/lnwXolirvCxFMYN0eTZFuJt
	I10U=
X-Gm-Gg: ASbGncvA9rIuayJX3yOcorrTXvfCnqgc0xJ7HK838XBCARUcj9xJ2YP5MpnqfosLZ62
	XjyA7RIn0XqahlUWIOwffxc2YxF/S8Vsz8q9I4syV0KMsKQOcwpoB5tv/23KUIB4fCvRLQv5jS0
	woT3X6m0VoGJ0jLvL/cjWnmImgubUwCFnPre8r+Udt0BtPwOJLvON680iQSwNHyxRMmYWYA7cNj
	vgHCRcF1d/Yy69I4YlSWLuD/ZHIB6CJU8Dpni/J+WdQHB27IsyY/03dyObvqkkYPm/uRVjAYZBE
	8XOu1sqaln05o3p69ZV+WPVvEj+3Hu0C6K6d5Rc=
X-Google-Smtp-Source: AGHT+IFSl5Z1DP+LoH0/jj1kUp0S4uovmAA5DbtTz8uDb7qyAwSb2oRgO+qtT/+KNaCsFK0ZjmtCfw==
X-Received: by 2002:ac8:5811:0:b0:477:1e85:1e1b with SMTP id d75a77b69052e-47aec35503amr265505431cf.8.1745345542401;
        Tue, 22 Apr 2025 11:12:22 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47ae9ce293bsm58048581cf.56.2025.04.22.11.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 11:12:21 -0700 (PDT)
Date: Tue, 22 Apr 2025 14:12:17 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Greg Thelen <gthelen@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2] memcg: introduce non-blocking limit setting option
Message-ID: <20250422181217.GE1853@cmpxchg.org>
References: <20250419183545.1982187-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419183545.1982187-1-shakeel.butt@linux.dev>

On Sat, Apr 19, 2025 at 11:35:45AM -0700, Shakeel Butt wrote:
> Setting the max and high limits can trigger synchronous reclaim and/or
> oom-kill if the usage is higher than the given limit. This behavior is
> fine for newly created cgroups but it can cause issues for the node
> controller while setting limits for existing cgroups.
> 
> In our production multi-tenant and overcommitted environment, we are
> seeing priority inversion when the node controller dynamically adjusts
> the limits of running jobs of different priorities. Based on the system
> situation, the node controller may reduce the limits of lower priority
> jobs and increase the limits of higher priority jobs. However we are
> seeing node controller getting stuck for long period of time while
> reclaiming from lower priority jobs while setting their limits and also
> spends a lot of its own CPU.
> 
> One of the workaround we are trying is to fork a new process which sets
> the limit of the lower priority job along with setting an alarm to get
> itself killed if it get stuck in the reclaim for lower priority job.
> However we are finding it very unreliable and costly. Either we need a
> good enough time buffer for the alarm to be delivered after setting
> limit and potentialy spend a lot of CPU in the reclaim or be unreliable
> in setting the limit for much shorter but cheaper (less reclaim) alarms.
> 
> Let's introduce new limit setting option which does not trigger
> reclaim and/or oom-kill and let the processes in the target cgroup to
> trigger reclaim and/or throttling and/or oom-kill in their next charge
> request. This will make the node controller on multi-tenant
> overcommitted environment much more reliable.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

It's usually the allocating tasks inside the group bearing the cost of
limit enforcement and reclaim. This allows a (privileged) updater from
outside the group to keep that cost in there - instead of having to
help, from a context that doesn't necessarily make sense.

I suppose the tradeoff with that - and the reason why this was doing
sync reclaim in the first place - is that, if the group is idle and
not trying to allocate more, it can take indefinitely for the new
limit to actually be met.

It should be okay in most scenarios in practice. As the capacity is
reallocated from group A to B, B will exert pressure on A once it
tries to claim it and thereby shrink it down. If A is idle, that
shouldn't be hard. If A is running, it's likely to fault/allocate
soon-ish and then join the effort.

It does leave a (malicious) corner case where A is just busy-hitting
its memory to interfere with the clawback. This is comparable to
reclaiming memory.low overage from the outside, though, which is an
acceptable risk. Users of O_NONBLOCK just need to be aware.

Maybe this and what Christian brought up deserves a mention in the
changelog / docs though?

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

