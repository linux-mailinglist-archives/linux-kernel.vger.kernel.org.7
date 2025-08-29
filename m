Return-Path: <linux-kernel+bounces-791252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13552B3B3F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7515B16EAC6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A494625F973;
	Fri, 29 Aug 2025 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DMo9Mzpm"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FF22253EE
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451520; cv=none; b=TjRMH/4PwBfSfEoTlIoFedAo1ORbXmctfojFZfYajQHycPPPlu5f6JU89D+BgjUkbsOUxwCN+xcenM3h7SoTdDdD3iz8i3x/2iYdiDB+v505SK7aczG3F6x9RYbA3R+tzCtrAgiwZglJkGBQFAvUaf0fOkT0ixCM1EoLtuhOeMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451520; c=relaxed/simple;
	bh=8HGIYZcechzSZLK4Ayj2jzIz62BYWhO6INifB1yjvU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMVkVEPgnPy2K/mzTYJ4kkf1wOqiceRf6fwLS2YnZ6mlslcfqiOarEdwjyU7BN3F5lqX8GmuTynFk5hm4k9OympUZchSKbaM8hIdyegluDCw0FfV929Gb2II6T8jNKs4bM0e/qz3tXiaQc3+Puj/8sRy3B7rnjfESnqUi2S0aSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DMo9Mzpm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b7c56a987so4473495e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756451516; x=1757056316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xsaYnSPbY7KFZC8TOsZf1kc7VBPPfZSiAGAh0sCoa1U=;
        b=DMo9MzpmgVlvtk5GXxy9JXMntl4oh7P7Mr4epyJ83gOvGd2jCAwZAu5J+udJw1T4eF
         4T/xv9akABVQFtfdTPsLQc4+YnjQcH5NMiE/P3nzTydSC6rP+mJTeai7TOMsvQ1LdO+U
         AkrSkbvXaTEiZ/BgoJJI7BFAzsfvIW02SM8wKht4qGtIp/s3M7KLzuWBGo2ddLtdrZ7C
         VQl1owhvEtXJLAbBVTTq8AH20pWYnnHQUSqPpaLtxxJgiNBiJaGh12JZJOfA6OCiJOln
         L8f0ux9CyhoM/we3JHbS1UZq711hVm4UtaSOkE4QoADEg2Qned2lbvJMVXqO0DDh7q7g
         BOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756451516; x=1757056316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsaYnSPbY7KFZC8TOsZf1kc7VBPPfZSiAGAh0sCoa1U=;
        b=mLDfFLB5EVUcv1nT4X7CQqu7HGmGKScKeVFAMkOJxzZ2lGQ0sk+PZtGQ3GVkDsfLqc
         yciN14kuJ+YtprqSV+jqANvVG4VLmwmK7b67Xxn2WVtGK3kcOw95kP5kQ1lICE4/9Cqs
         s8ctQWQU+pXgHpXWxf8P/RWNvRLAb5nsrBPRH1D4gfArwI1xROJ8Pi5uDa8UgucsPDVx
         AUNym7z29dMcadeRGsZ14gH7LD4HfULcIKhnjGB9eniLTycMgwo2MpPlCNdTtTd3ja/I
         uY+X52zqLCRZYsL3gc7DQSjD8qWVuPr5ZZ6yrqdqv2t7wQheXmUOtJ3jXAVN1j4D44mY
         ZBKA==
X-Forwarded-Encrypted: i=1; AJvYcCUmSp0HwO8n60+4YCvEkTUwM8GfnLCR5KJcHoqCYmBAE5b0LP56dx1YrNMM/PjEP7bSD3Nm1G0ewiNXMus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYQ2K4yTAPgY3qCZDaOpCzqgH3RwPib8hbK7g7U5o6DjLLLjSs
	TCaPbBHUCHTIuzRrK/RlhCP6Cv5Cfrz8On2MtH9lXTYJVpsW6+43OUHyvuyJjbl6xfQ=
X-Gm-Gg: ASbGncvQIJWPIj08jSL5ZlRx0S/SARXVbJNNLJNbwEXxKjFgHNcbVh2VkpL8Kk7HCdb
	ODTKEBMXV8SRbK6KWjPgaRLzrt2x92BEqkxSTQlrRgB9h0llIZakKfH2iuJ6z2r3GhHvg8/t7Ge
	LyBZRzCFKr6H34SwxHd5+Ow7dZhhGTAWw1ZqVKukBtRc0ZgbEEMmaPHzR3n1cNrgPrdtsmm1ncG
	VuWsiYntA4K3+HqOp2nv+3rvxhdAQou5e5/mOCms6UOS4xzVKgV7RYIBxwOJmKHW70tiqE2T1wK
	e0LZUmMxIa/xglk+5uQUXnaX+cgHR5Sx6wNf6lnT/uTMPrwmWqLEknRArN0YqVnMCF55h4KIdmv
	/ieGkaJ3tBmgKO7tmcYrzIQBw3RQ57hq8I/E=
X-Google-Smtp-Source: AGHT+IGrad3h+79iMHJNzOjhklTvtjDTUtj2Edb2Rh/iq/Nv1ZRT/p5CqZ37Zsd8+CeKMbmOvEWoCw==
X-Received: by 2002:a05:600c:1d87:b0:45b:5ff4:2f8f with SMTP id 5b1f17b1804b1-45b5ff43124mr143219305e9.4.1756451516100;
        Fri, 29 Aug 2025 00:11:56 -0700 (PDT)
Received: from localhost (109-81-86-254.rct.o2.cz. [109.81.86.254])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b7e7d23b7sm25444935e9.1.2025.08.29.00.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:11:55 -0700 (PDT)
Date: Fri, 29 Aug 2025 09:11:51 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	zhongjinji <zhongjinji@honor.com>, rientjes@google.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH v5 2/2] mm/oom_kill: Have the OOM reaper and exit_mmap()
 traverse the maple tree in opposite order
Message-ID: <aLFSt1uId1B-AUk_@tiehlicka>
References: <20250825133855.30229-1-zhongjinji@honor.com>
 <20250825133855.30229-3-zhongjinji@honor.com>
 <002da86b-4be7-41a1-bb14-0853297c2828@lucifer.local>
 <nwh7gegmvoisbxlsfwslobpbqku376uxdj2z32owkbftvozt3x@4dfet73fh2yy>
 <bcabe7cb-d09c-4789-ae39-407b2e0653da@lucifer.local>
 <ip7al6pv3nm54raaptrxq3v4t7cpilqgppkezowzn2sfbjax65@qt72zuotrwnw>
 <oogiwonpxtqurkad7rt2zxc3ffgeujtilivno3ibcybzucsliw@ym7jm6r5kdil>
 <6cqsibtttohay7ucs4ncmq6nf7xndtyvc4635i2e5ygjsppua6@7iwkgpp245jf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cqsibtttohay7ucs4ncmq6nf7xndtyvc4635i2e5ygjsppua6@7iwkgpp245jf>

On Wed 27-08-25 00:12:34, Liam R. Howlett wrote:
[...]
> > > I'd think using MMF_ to reduce the race
> > > would achieve the same goal with less risk - which is why I bring it up.
> > > 
> > 
> > With MMF_ flag, are you suggesting oom reaper to skip the unmapping of
> > the oom-killed process?
> 
> Yes, specifically move the MMF_OOM_SKIP flag to earlier in the exit
> path to reduce the possibility of the race/contention.

MMF_OOM_SKIP is a "hide from oom killer" flag and that means that as
soon as you set it up the next oom killer invocation would kill another
task while the current one hasn't freed up the memory yet and therefore
you have a potentially pointless kill.

-- 
Michal Hocko
SUSE Labs

