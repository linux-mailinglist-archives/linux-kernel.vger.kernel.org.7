Return-Path: <linux-kernel+bounces-772612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64780B294DF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 21:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A44D4E4E72
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 19:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5492220AF67;
	Sun, 17 Aug 2025 19:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CtHj/kn6"
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7309204583
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755459454; cv=none; b=r7LDu8Owi9ByOtXSuOZLXpO8dMGyDVvl6CFjynyu4iidwkuX+TW3XfweFcG3JKsxrGKqsBS5s0RqXJlRSW8MIhiHyYJVU1oIxgiC2L/emx2ahJUcXAahws21d8oMKRRqNzowFkHP2qELraW5o8eEMBs934A3Azo0Jxf8BzpR5KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755459454; c=relaxed/simple;
	bh=iiQWuJ1HgjqSKdYvsrnFvVkGq8qU8FQez6+2M0rvP5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WogAnDWa4tg2/9XFqxSdBqNdQILvK73PZKuNKPkQD2VN0QqWhx0dBQK7bitHOhDDcj79eXQXytlvGWjQbzJGD6spV+pfCvRJo73vhRXR2NluZDkkqd6FE7Cqth7dbSJINH2Az5kZ38QPDOpgz4X5FSqD/omUlJsOrVIraIAsyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CtHj/kn6; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3b9e415a68eso1829053f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 12:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755459449; x=1756064249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OOgGDsYpV57/W8Toy6B+hnOqdrJoqmubygLXKp6pFl4=;
        b=CtHj/kn68VRwiy5MhOjDuABnq0FGVH0rhm8nnvgM0SgIaYu4d3Dou8/RO9GQgw74tG
         Nppi7ggF/ZsKvyJoJd0SyQ9dQBFmHRiH2S7D2s4juipU3L6k7AhA+17YoPO76ZsL9LB3
         qI6kmFLeT5eiVx5Ttr6aE/EfUXUJRUfKcKcza52NZDbPzE1kpVbjBudmKqNbcPp+0vpP
         JjCs8q3HGMfb4EeisYlopnFUavzd3dxVkD//aNxnCvNPq5nuOSxGEi7LGk7SouIYR/1W
         TL24nwGpyCFGtctALui4Y1yPXgJ27K7M4AszXfS2VJDwd/XDBUs1GOPNLX0vn6oJNa00
         d0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755459449; x=1756064249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOgGDsYpV57/W8Toy6B+hnOqdrJoqmubygLXKp6pFl4=;
        b=WnFVc8P9wzfcdTDcYxEDA9hpF9I40HM89pBd0uGmIAl/2E0D5dxNMzpOHEfA1oSLKB
         pmlhNcQHG8FOc9UN1Oench64GuIjchaGB7HJpTXm0ujqm88vB2nyx5ksfM2mjj+tDd1+
         /qYBh1CP5NC5agPFV1R1+hhMtatdHDimePuRc+Y/aBRzOYD5afY63mplpkWYGFbhVz0I
         h70YRGgZnXrTeY1rPhq90AqbOKibujHP+gLM6Lqn36LLE+iQnRs++9nM8E9TChM6uASp
         lAmXfdoB+VHqRJFGcinrm6E4gOITZ8oN123Hf60mvlzGod102yyf1lXqRSuib0f4JDI1
         GrhA==
X-Forwarded-Encrypted: i=1; AJvYcCVoEovzaU1A8fPz8zX7JQ2f6njJE11IkX1UrSQ7DlrG+ljKpdEGUNBzkhU4sjgXTZyCIQIjOltdMmc9lJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEuwUO6FBjaEsQ3yHZ8ewo3SbZlSKMQDGlGo68ojXfa9vv9k7e
	Oz3rCdmffCXA5RcC766zGNh3ReEyg3uG4WRGc3GHuxnsQIrielQ7PvuUcMPdfK13gNI=
X-Gm-Gg: ASbGncu97SSei+Vk9FzDqgD8XV04lAoDodRLGfQ7uWhiBlJklt6AtdjsEK9hBJ+SbSw
	a7NTb8thgHq2dnkeiDnSHBZ2PG4xWbUC0bqaX8GRNW3w7m+f1UdxIg+1+CW11CKXOjyjHgHSMpn
	VpolhMMk3T29zROo3XYq6MXa6aQYai3XDyyPLxlkghLiaiRvbY5/wFkslU6wYo6Uu824/YgJbXw
	iIHjc27IuccrxcA+BOMQgiD9d1D6H2OBlt+6XTJR6vjJTgRQeIpEAmcdCqjdoJUZmENYYfcv/WJ
	J1eb57KxNPtPwsJ4sm9tYkZ4udkpG051n8SC9AwgHzU+WSrrVR67Tmdk3yovmKJlfK6WL0PKFGG
	uz3Ztu+8nuiVz9Are4qvf/bink87ldbYw+fwdPZXojeALkg==
X-Google-Smtp-Source: AGHT+IEsOhkfxrKr9sjeVX+iZz5YxDYnWDjwo7hxMirg6nhYueecpLlVylhw4FLWKnSFN/b3qszYZg==
X-Received: by 2002:a05:600c:444f:b0:459:dde3:1a37 with SMTP id 5b1f17b1804b1-45a21857639mr69799095e9.25.1755459448909;
        Sun, 17 Aug 2025 12:37:28 -0700 (PDT)
Received: from localhost (109-81-28-101.rct.o2.cz. [109.81.28.101])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3bb7f02578dsm10423195f8f.62.2025.08.17.12.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 12:37:28 -0700 (PDT)
Date: Sun, 17 Aug 2025 21:37:27 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji@honor.com
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
	shakeel.butt@linux.dev, npache@redhat.com,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
	andrealmeid@igalia.com, liam.howlett@oracle.com,
	liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH v4 2/3] mm/oom_kill: Only delay OOM reaper for processes
 using robust futexes
Message-ID: <aKIvd4ZCdWUEpBT_@tiehlicka>
References: <20250814135555.17493-1-zhongjinji@honor.com>
 <20250814135555.17493-3-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814135555.17493-3-zhongjinji@honor.com>

On Thu 14-08-25 21:55:54, zhongjinji@honor.com wrote:
> From: zhongjinji <zhongjinji@honor.com>
> 
> The OOM reaper can quickly reap a process's memory when the system encounters
> OOM, helping the system recover. Without the OOM reaper, if a process frozen
> by cgroup v1 is OOM killed, the victims' memory cannot be freed, and the
> system stays in a poor state. Even if the process is not frozen by cgroup v1,
> reaping victims' memory is still meaningful, because having one more process
> working speeds up memory release.
> 
> When processes holding robust futexes are OOM killed but waiters on those
> futexes remain alive, the robust futexes might be reaped before
> futex_cleanup() runs. It would cause the waiters to block indefinitely.
> To prevent this issue, the OOM reaper's work is delayed by 2 seconds [1].
> The OOM reaper now rarely runs since many killed processes exit within 2
> seconds.
> 
> Because robust futex users are few, it is unreasonable to delay OOM reap for
> all victims. For processes that do not hold robust futexes, the OOM reaper
> should not be delayed and for processes holding robust futexes, the OOM
> reaper must still be delayed to prevent the waiters to block indefinitely [1].
> 
> Link: https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u [1]

What has happened to
https://lore.kernel.org/all/aJGiHyTXS_BqxoK2@tiehlicka/T/#u ?

Generally speaking it would be great to provide a link to previous
versions of the patchset. I do not see v3 in my inbox (which is quite
messy ATM so I might have easily missed it).
-- 
Michal Hocko
SUSE Labs

