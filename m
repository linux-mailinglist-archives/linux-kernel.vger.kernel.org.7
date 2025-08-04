Return-Path: <linux-kernel+bounces-754705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0FDB19B2D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3904C176A69
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 05:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FCF1FF7D7;
	Mon,  4 Aug 2025 05:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cUoKeXAx"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B9454774
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754286737; cv=none; b=mbzzRxkcc5MjYjrAp/PYW3WjbC3HIr6RLai8h7xbiIahrE1hUTZwEZwywCCQjGptI4QMcHwh/TmBDinahDcLQyszBHfz2SVlQ/iz1Vl1Cgks6teYDOSycGhId/8ayaWJfu2NFRkGlnjKep2f4F+D1iNJObFu8ntBlBSskwxgqeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754286737; c=relaxed/simple;
	bh=sXfHe9A9RM8H1aiDjeLsF+MIrHFzjkmFqI/fJPuwM+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmMFX8fXJsMtiOslO9rQQjCFlRrinm6sl7FzrNAzEbriinRfTgZrlfd/Ep76p5Ttr/qrWLhCKt64NoHRIPBETQ7Bd8wWgh8ZfVFlFylPyhyvuc45vyiY2727F/L42EtMFshHjefpDz1HIssRmRy+yUWtBkvYs/ih/CZqFSm98e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cUoKeXAx; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4561607166aso27903655e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 22:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754286733; x=1754891533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=idg3NNQd7Aifs0NYERU3OcyOP33KhlyKv3C8P2yZD1A=;
        b=cUoKeXAxOotjb5bIK0/yW6LtMC4R2Nf5LUMt3g5RZhB9k3z0VQUh4hAVo40mfHqef/
         FAq4v/4jsZ0CsaSTba740AsNRC3jUEvYbpcdX9YGv4KuW2Hwv0TsJ7Q1wIgCbH1+rfzm
         QQp/iLOgPcOf6E1g3TmvBg8yA/Wz9slDEZAy2uEJ3mgboOsuD9IMcZJGIfxqrHfIxiTI
         iFl7lo+p89yhqBmWniS0k1V+0VDKBYy1Fz2k877r+2tjlFSBWtwc2nsspI9mdgfx3kN0
         6hDrSG2XImZl1O5VIdG5DGjFnjA1jt7SCSIHx5OKhMXLcUxtEJQiRDxgmN9POiEglXpF
         cBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754286733; x=1754891533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idg3NNQd7Aifs0NYERU3OcyOP33KhlyKv3C8P2yZD1A=;
        b=ZkW0Gz/grJw6SC7b4W1YuHIYttUqhuUqGRzXIOU83jww4JfqLuA94rNsl3EzNFWc/A
         FjCSWvqhrFoB7sqeHRugALKJmonxAg0u0Q4GoSo/1nZrBMTvn05twe8KuRlQzYO/tEe8
         9EQHE8LjmJcE9b6Pqgou4TaUg4swU8W+2EJtzLZ+G7jGceHMTYF7O5Dg5LCRwTWDPuc/
         aptEhJ5dq9jz2+azJBvqzVMWaDb9AqWAfSEahFMWy8fZjvhEte5qmITW1paidOI5ocOT
         bf4aJ5S/153oMw+pTsFUZSY7MAkCLVTjxQOZyD0zdR/KKLcsJVJLVe28i+g5/u9uC89E
         tG0A==
X-Forwarded-Encrypted: i=1; AJvYcCVAcbg6HBJXJ9y8GIraS4lml4KWBenXWMMU/by1yjwaQGcxrkXmQp4u1l+ysFPYht9ObLTJGY1n72tOYUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3uY7+5dhUcGRyjEQ4ikAX/QBeh6AC85r/JVyrGZVTmIRZ+bDF
	5efSN7mzcb7Ed2tbUtr12q3WeeXKxJaj2hIca1o5x1aKPpEZg7fecyMRHEmzrMsBcCQ=
X-Gm-Gg: ASbGncutCZlr0WdaqQ0bBpGEox0+TkXIjQFnL7oPE01/qhghKWv+5XrFaquxNJQCpQk
	puqq53E1JCMjpZLIT6bsISlCJNiMqMMuKeBvqwQrBH+jyAWe5gzMoIsEkE9rLJ27lTRe9jwIjPz
	2lGBkYa78r03DHzNYgR9d87nxgjTtyCedm3oYxdx3lBO375dIMicOrkwA1JbUAdWqQZHrZyoUxm
	pb9zwxI8zOGsNntsJWg7kJ3XbbdBoPB7biKRBo+SvCacCGKyzmuoivPRb7mxiRcsY1DbizBYA3p
	S0GY2chrTJDXTf7Vdk1VQCPtV8p3WcJkeDUh2UN3W9/oMbEHCWMjvpM4lcC89b3lCsiyfEE8FfQ
	dEBT+2vo5xg1i4EGy9EaaM6r85lmAmM/N
X-Google-Smtp-Source: AGHT+IEb/gs7A5IisLAar+pvZRhJ0O+ov/gL2LSqq2vTlFreLuE94t0ionTmHOTEOhZ2ozfUiGkRlg==
X-Received: by 2002:a05:600c:1d08:b0:459:db5a:b0b9 with SMTP id 5b1f17b1804b1-459db5ab3a2mr11465575e9.28.1754286732845;
        Sun, 03 Aug 2025 22:52:12 -0700 (PDT)
Received: from localhost (109-81-86-79.rct.o2.cz. [109.81.86.79])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c4a2f03sm14103393f8f.72.2025.08.03.22.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 22:52:12 -0700 (PDT)
Date: Mon, 4 Aug 2025 07:52:10 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji@honor.com
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
	shakeel.butt@linux.dev, npache@redhat.com,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
	andrealmeid@igalia.com, liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [[PATCH v2] 2/2] futex: Only delay OOM reaper for processes
 using robust futex
Message-ID: <aJBKijr1nR1CleBL@tiehlicka>
References: <20250801153649.23244-1-zhongjinji@honor.com>
 <20250801153649.23244-2-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801153649.23244-2-zhongjinji@honor.com>

On Fri 01-08-25 23:36:49, zhongjinji@honor.com wrote:
> From: zhongjinji <zhongjinji@honor.com>
> 
> After merging the patch
> https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u,
> the OOM reaper runs less frequently because many processes exit within 2 seconds.
> 
> However, when a process is killed, timely handling by the OOM reaper allows
> its memory to be freed faster.
> 
> Since relatively few processes use robust futex, delaying the OOM reaper for
> all processes is undesirable, as many killed processes cannot release memory
> more quickly.

Could you elaborate more about why this is really needed? OOM should be
a very slow path. Why do you care about this potential improvement in
that situation? In other words what is the usecase?

-- 
Michal Hocko
SUSE Labs

