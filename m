Return-Path: <linux-kernel+bounces-586693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72271A7A2A6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 14:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050087A6605
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFE61C861F;
	Thu,  3 Apr 2025 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gaTcrXEU"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE31519A7
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743682629; cv=none; b=iYatfP+DYiTtBexQQBAnFb9by7w3JfeIEv4vw2tjcRItTz5jf0MllTK7fAfExm92gMdi1RKqNTLlq0GcqZY/IpA/45wvvFADBEn1TlLYptIscAapjwLMAIeV7HhU9a4rIHclfRQqWQwlwNg0RmKVrN5GD2q59q/uOyHWJm96f5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743682629; c=relaxed/simple;
	bh=wFIIa1FHRVFXLxxXeQ1gqaA1krM7d8OpZjMKjJyzLb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPM4hte1yqvSAVyVgzCstJlnZiv/nn0bTELlcJDwhdWsDz6DNaxUxFuxeZHY5uisPjfS0zIvS/f+vMyVJjQ5CiP59vblmoQlmShE9FPS6Xf+K977rPCR401RSaS447seDtVAwvOBCj7FLL6IAsanck2yfrPocFB3MxO4nppfp+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gaTcrXEU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf848528aso5958885e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Apr 2025 05:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743682625; x=1744287425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IHtjp6fV8bfAv06r0KHl+YilzLbX3SHLECV51Mil514=;
        b=gaTcrXEUrEoVWnlLm3uoozXxVPXXHFW7T79+2pmlRs9LQYACFK/rPoaxuPt37UX4xO
         k2wKwZIpmaumTdqvoFSw2NXVyHm9+MpQiKz06aL6/f1VI8Nmcq+6NprGapRr+pYTxc3U
         S1Hpfo3VY/qotkoCcQB0AhYwlU/yTG6TYrr4l9UIyxl2zINdNXqv90IDzs1LagChIluE
         /DjsacDW/fgKlnN1/cGhoYe+5aeh+rn1tZA7e9DhsK1qSkAzQjGnLt3/tJ82d7XeADwN
         h8PXm2T86rHH7v2u0CxM93ikNVNlmKftXgts4yRo8PGujF/el9ovuEF+AwnMbvJ9o/Qj
         7Csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743682625; x=1744287425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHtjp6fV8bfAv06r0KHl+YilzLbX3SHLECV51Mil514=;
        b=nmYrgx4plJQHa4XRTP89XK7VfnIsyzRu74xMpaDvb/cH+JAIHhDwHtVSY3yulCHHyk
         nimgdgVo9yl/9CaMNd9BWftUoDus0Cv5HrLWbM3ulU8YJer6i27lXEfTNgA1ZiRfy9M2
         uLyNFDNC6NtkV6nsfAIg1lT4ogdUg4+88mk2ixxHJzA51A5h8NoGXI23jQ+eGOCWG4Jt
         AEJhc2CWMfWS+9U23tqdwrcRr6Gm+oz8GUx3nftfzOM5R5KlBUUrJ/qLPo77jSgz8QqR
         Z8HrLyymphkqqx+RIWTgdupSYjpT1/9+HYDUF2AuZMbkTxZl7k3rOMYpuTbbaKaPfYGS
         QgbA==
X-Forwarded-Encrypted: i=1; AJvYcCVq4PsYZkNsOtCXFEbAtLFgXYKHOEabomInUSJ4HlK/2Hip2GNn1CeiB7g792ktgMy+i2Fo57cq0ha5HUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpnB8HAhwOC0tyULM/1A8ULsi0dblBOHVd0XtbSakKriyuqV2V
	TGnWNJ4qUJ4FsnT+FZaIGD/fzRS+3CfXD/j2mofp0+J1vi2YI0KXkjI6wWCTM2A=
X-Gm-Gg: ASbGnct0WI0ph66zKXkYr/xpfpMa92jGo4+5vaLq8O+AXWUbOtZQMsbkmotEuw2rSOW
	tngCR7wt7ju06TBfDfO152TDKUNauMccvU49gXu+2smAPCiXoS1l3aBKfL2kcPmiYJH2XQYx7iZ
	W0bryh9ecKhe1vbRYFJS9bS6S1H33gn4KVDjLBcjipeseXpNU3Vwd8AGHS28qzXOf7+m8HSr9qv
	UgCQGFdg6g9bIyCvQhw2iuGChowBmZQ+e8QKtT+U+xRqgyXDq1+5FnWqZ95uEFONah4uhcQODvJ
	2jd9T911+87J8dFNX2bI8EaxXadeeLhOJAOp/1msvUbkWUY=
X-Google-Smtp-Source: AGHT+IHHZ6MLKNY6Dc5eXJkq9LfhDUgkdKNpEmRRRyJxO3Y9fBBgNgTXRDCTRWZppELhIa1Exeu9lA==
X-Received: by 2002:a05:6000:40d9:b0:399:6d53:68d9 with SMTP id ffacd0b85a97d-39c297e42a2mr5819410f8f.38.1743682625285;
        Thu, 03 Apr 2025 05:17:05 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a7045sm1678962f8f.39.2025.04.03.05.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 05:17:04 -0700 (PDT)
Date: Thu, 3 Apr 2025 14:17:02 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Frederic Weisbecker <fweisbecker@suse.com>
Subject: Re: [PATCH v2 00/10] Add kernel cmdline option for rt_group_sched
Message-ID: <s2omlhmorntg4bwjkmtbxhadeqfo667pbowzskdzbk3yxqdbfw@nvvw5bff6imc>
References: <20250310170442.504716-1-mkoutny@suse.com>
 <20250401110508.GH25239@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401110508.GH25239@noisy.programming.kicks-ass.net>

On Tue, Apr 01, 2025 at 01:05:08PM +0200, Peter Zijlstra <peterz@infradead.org> wrote:
> > By default RT groups are available as originally but the user can
> > pass rt_group_sched=0 kernel cmdline parameter that disables the
> > grouping and behavior is like with !CONFIG_RT_GROUP_SCHED (with certain
> > runtime overhead).
> > 
> ...
> 
> Right, so at OSPM we had a proposal for a cgroup-v2 variant of all this
> that's based on deadline servers.

Interesting, are there any slides or recording available?

> And I am hoping we can eventually either fully deprecate the v1 thing
> or re-implement it sufficiently close without breaking the interface.

I converged to discourate rt_groups for these reasons:
1) They aren't RT guarantee for workloads
  - especially when it's possible to configure different periods
2) They aren't containment of RT tasks
  - RT task throttled in a group may hold a shared resource and thus its
    issues propagate to RT tasks in different groups
3) The allocation model [2] is difficult to configure
  - to honor delegation and reasonable default
  - illustration of another allocation model resource are cpuset cpus,
    whose abstraction in cgroup v2 is quite sophisticated

Based on that, I'm not proponent of any RT groups support in cgroup v2
(I'd need to see a use case where it could be justified). IIUC, the
deadline servers could help with 1).

> But this is purely about enabling cgroup-v1 usage, right?

Yes, users need to explicitly be on cgroup v1 (IOW they're stuck on v1
because of reliance on RT groups).

> You meantion some overhead of having this on, is that measured and in
> the patches?

I expect most would be affected RT task users who go from
!CONFIG_RT_GROUP_SCHED to CONFIG_RT_GROUP_SCHED and
CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED. That's my perception from code
that I touched but I haven't measured anything. Would this be
an interesting datum?

Thanks,
Michal

[1] https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html#allocations

