Return-Path: <linux-kernel+bounces-775456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 948E7B2BF57
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C642E5A09A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B296322DA6;
	Tue, 19 Aug 2025 10:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LTOjgayG"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61679322C87
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600571; cv=none; b=E2qs5yhBgKW7vuu03J5h4EWNsPyl0WtHaBj1MbYVD7DLmIvsSnm/VquEzDjdbU7iwklXZnAJnCe3hOxFi+dsTXecPiBtT2os6ah4lCCYkYfscvmy2HvYuG+16wD603e2wTXm3UIqY9t0hirMpJwon44220AiDeM7h3xpXS1uS1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600571; c=relaxed/simple;
	bh=v0yElsoHD0Y7Bd/7dhKJzqFILsKr0dJ9UIQB+Asr9i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PS9GlT1k6mipXPVIq1bzF9RYxqvJBJeDpb9oyIVNQSGx5orCURjkYvtuTeRz0aL+Q37/TOVv7Ds4SFkd/4KtWgi76GIMjE5vH9PayeOWCnjItoe2PFe/ZyCUNXH1PNZef7r0CarVeVXyUI/U+JA85vg4IPTFUeUadJ12UZAAoGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LTOjgayG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso42363765e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755600568; x=1756205368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kw0AigTamlrq/x9wS+Jeg8FeZZrKAMN0R69vqKKk/+0=;
        b=LTOjgayG+Mor6219u7+udzJmvR8qJmsX94bb2yxbl51LrdDAB2rLpNUqdCLnFvNi9Y
         hQOG+DPsXdJH3pnVWQRnmUek27utmJvamDCwKZ1zRRLlZQWYId2+HlyvDIcXYFLKn7mI
         sWC+7ub3F8GtL1JPeQXdmvRqlq+t0VkiB+KX3I5yvGv5EA3GvUZtR9l5+uR2OajcUyma
         OQ6J5dZsiMSGNKjnohz51VjRqJs97zCg2UsS8NnjfwckbXszInLgV5u8ZN588BsHTxVH
         w6i4zOf54gJhrX4Oy5hkm6GBMl0utwFyJBmpqC+O4fJ18+a9OzMwGjCYU0KMaI77TRzV
         nqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600568; x=1756205368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kw0AigTamlrq/x9wS+Jeg8FeZZrKAMN0R69vqKKk/+0=;
        b=tZbQIT8w9+MQO1tIqro00e9g5lArSqjzAesxT46OYGuEIlNrLsKMQXLaJyNUJFVYFE
         HRXGwpg6uqOIz7epwFuaV0YpSA2hjWTSTy4dXczbsHNJ28I7WfmvB0LzX27bBnVp8Jed
         26MkpJM3h18G634wDqIZaJEmID6EJ9tub8R2XsSD9wofEIsSinhdrTgtcN/mibCWL7Lb
         vuPJqYHvwU9kMgqi1bnwGEwVKGS4yuk5RbbmiUDpnW6Fixrs6n170K02+prFd/eheRpX
         HzK4NytL5YI65s3PaQhO+ZldoDLpjG3SDGU4EvEnpsedXVxlJ8shUPN0vDOEWT6RkNHg
         +fVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEY+2WBbsHsoxYiMI4CqksFQBLkg/irbYFYzkroT08iWXTBms3h8udYfkAAnCqggqodPaPsZKKOgBFJJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLJCw/+BLIq0790oT6sjy7NQO/Nk4zXOc0Po/Hw/zqJHMMSvyH
	uNd0rux4lha33JFTtPphcm5JLIfP4grulih2ChuxImVZxegpECorlDKltK396fiobdI=
X-Gm-Gg: ASbGncsnS2hZiufbSTfBbmJptxiYqMzNH0In/UOvLGiMQNs6MaGoUnq5Jz3n06n/gWh
	XflCAhs4xEr2tlA1uL77VdVgjGAb/6JvtcTRqdwVl3F4vcRIxblH2NhvR6amFPeOeclYXbeTj+3
	PaFewzG/4stxV66R/qJMWa1qRJRGS/z1vlC/CWbdo91mtm2na/qbHw41Umm5ZI8i8bTE5SozWID
	S0SaX3IU3Ld6iR7ePCa+FGA80ezap/4X7siZOjpNf2WgT8bhPxGS3vOAPdRrJmzmuolgjd3m6pi
	aUxuwBJ/EDnHpKfI5tjz5hVLhDUWyqoypnLSuBeqifkG+PX3DOEGZfbWwLoRzudSD8RoSYYtyye
	RqIy4F5k3RE22q40CfO5pqs2Pkx5CTMknoEIsgdgMnQkI8w==
X-Google-Smtp-Source: AGHT+IFEJAOMpK3HNFJFB1w6V8jRKSHtdv/ffV+gbTyLvIoryN2RHZyfIsrWRIVB58VwFaamjUbVjQ==
X-Received: by 2002:a05:600c:3b91:b0:459:d709:e5d4 with SMTP id 5b1f17b1804b1-45b4425ed17mr18178075e9.0.1755600567490;
        Tue, 19 Aug 2025 03:49:27 -0700 (PDT)
Received: from localhost (109-81-28-101.rct.o2.cz. [109.81.28.101])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c07496f432sm3197891f8f.6.2025.08.19.03.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:49:27 -0700 (PDT)
Date: Tue, 19 Aug 2025 12:49:26 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: akpm@linux-foundation.org, andrealmeid@igalia.com, dave@stgolabs.net,
	dvhart@infradead.org, feng.han@honor.com, liam.howlett@oracle.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	liulu.liu@honor.com, mingo@redhat.com, npache@redhat.com,
	peterz@infradead.org, rientjes@google.com, shakeel.butt@linux.dev,
	tglx@linutronix.de
Subject: Re: [PATCH v4 2/3] mm/oom_kill: Only delay OOM reaper for processes
 using robust futexes
Message-ID: <aKRWtjRhE_HgFlp2@tiehlicka>
References: <aKIvd4ZCdWUEpBT_@tiehlicka>
 <20250818120819.26709-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818120819.26709-1-zhongjinji@honor.com>

On Mon 18-08-25 20:08:19, zhongjinji wrote:
> > On Thu 14-08-25 21:55:54, zhongjinji@honor.com wrote:
> > > From: zhongjinji <zhongjinji@honor.com>
> > > 
> > > The OOM reaper can quickly reap a process's memory when the system encounters
> > > OOM, helping the system recover. Without the OOM reaper, if a process frozen
> > > by cgroup v1 is OOM killed, the victims' memory cannot be freed, and the
> > > system stays in a poor state. Even if the process is not frozen by cgroup v1,
> > > reaping victims' memory is still meaningful, because having one more process
> > > working speeds up memory release.
> > > 
> > > When processes holding robust futexes are OOM killed but waiters on those
> > > futexes remain alive, the robust futexes might be reaped before
> > > futex_cleanup() runs. It would cause the waiters to block indefinitely.
> > > To prevent this issue, the OOM reaper's work is delayed by 2 seconds [1].
> > > The OOM reaper now rarely runs since many killed processes exit within 2
> > > seconds.
> > > 
> > > Because robust futex users are few, it is unreasonable to delay OOM reap for
> > > all victims. For processes that do not hold robust futexes, the OOM reaper
> > > should not be delayed and for processes holding robust futexes, the OOM
> > > reaper must still be delayed to prevent the waiters to block indefinitely [1].
> > > 
> > > Link: https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u [1]
> > 
> > What has happened to
> > https://lore.kernel.org/all/aJGiHyTXS_BqxoK2@tiehlicka/T/#u ?
> 
> If a process holding robust futexes gets frozen, robust futexes might be reaped before
> futex_cleanup() runs when an OOM occurs. I am not sure if this will actually happen.

Yes, and 2s delay will never rule that out. Especially for frozen tasks
which could be frozen undefinitely. That is not the point I have tried
to make. I was suggesting not treating futex specially because no matter
what we do this will always be racy and a hack to reduce the risk. We
simply cannot deal with that case more gracefully without a major
surgery to the futex implementation which is not desirable for this
specific reason.

So instead to checking for futex which Thomas was not happy about too
let's just reap _frozen_/_freezing_ tasks right away as that makes at
least some sense and it also handles your primary problem AFAIU.

> > Generally speaking it would be great to provide a link to previous
> > versions of the patchset. I do not see v3 in my inbox (which is quite
> > messy ATM so I might have easily missed it).
> 
> This is version v3, where I mainly fixed the error in the Subject prefix,
> changing it from futex to mm/oom_kill.
> 
> https://lore.kernel.org/all/20250804030341.18619-1-zhongjinji@honor.com/
> https://lore.kernel.org/all/20250804030341.18619-2-zhongjinji@honor.com/

please always mention that in the cover letter.

Thanks.
-- 
Michal Hocko
SUSE Labs

