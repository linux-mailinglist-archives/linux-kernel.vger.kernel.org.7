Return-Path: <linux-kernel+bounces-752900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFA3B17C29
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 06:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99111888057
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1554D433B3;
	Fri,  1 Aug 2025 04:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQD1xHRO"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FADB26ACB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 04:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754023427; cv=none; b=aKAxgzu+DxmB5Hx4MBmrUPUr9/A3EMBf0IjYEzDhrzxL/izjaIfJ+mLZ4RTWzyuC16RtXrQAIKACIeWSc8noF32In5HqD9pt/xaJ7dVKlXeJDmDDzbs2MF1esgNy99DoLwzrqKAikGjicMnIXkJzWQJ0WcFqu2ZahO276l7kasI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754023427; c=relaxed/simple;
	bh=x4xrAZi9DV72hy3uEXv6HfE7wskOE4NrkV2UapFsKgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPnuL0/Vv8wxE3xulubhL2BljA7Q6FbpMCCLYdiyLU7GRCNyVcvud8ahoFvUCZ4h8+K6lFj20qMmVRKJFkbMWsqJC9bTJDgJZtkCNmkSTLXNxNF45fZIb+hC5OZVUpCAAGhGf75IZi4FTlnIrhWXL7IS+cqhT7AN3mTaaDG51Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TQD1xHRO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-240763b322fso11958525ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 21:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754023425; x=1754628225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sl+4qIf3VCeXg1U9yhGdOAryWgWsMQ3QOS9OYjY4gi8=;
        b=TQD1xHROGkkEC83UVYPX1Im4HeGpnHPVkYpYOqFKbeclggCBQmn00CKyCnXYCYpcnE
         6AIbFSulYaEmJp7Rd241V3N7FigSqWTc+YpWwVF3X3nNGdUmBOt5q7H/RGpFVAYVqeby
         Q9ymsM9moddN6/V91hh30J4IB+EXwiSw6sZ3b5yVZvzkFF9RZeIj/iHDv0h85cDKnu3G
         E+pQhCEaQQHChghMNVhvwz2JbPFPI9tuqWn6sIJ6oa8d28tByua96LxVtdSRdsh2CLrD
         HAU95NdAMtcexlI0GTqWOh+ZKrOnnSYoSFYua3TuIJ/5bPyYQeXSPW4ZjzHonkWOCR/P
         tTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754023425; x=1754628225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sl+4qIf3VCeXg1U9yhGdOAryWgWsMQ3QOS9OYjY4gi8=;
        b=OnSWi8HPNcuSEBK12bzsAhXifhkP932/EMwftQUp5W0cqQ1j8Dmfs35U2o2+KcyrND
         H+Cav2HXqrgPdyPqqnNwOENoTesf0VvS7bHzJ3lxcq57lBkr4fybQw8YgN5LcrFdNS7S
         tHp2Szo2sf3pVDojzulg71XviEZOtzMoAZzVod5afaApgvutbK7CQ6OnAPIN3eje3+GV
         BCC6QF4c5+eWf646tnjJ3l83LLfuzkY4zx3tA3lBTJNExw54KggmaOpNr86N4HUs9DEv
         lzjdSD9Rxws5kFGhRALKgT/JN4mhpyW2OPRBLZEkHqkOcjtc2ZWHhVZht4EXZ0UJvvja
         uEew==
X-Forwarded-Encrypted: i=1; AJvYcCWczY9fyIuK9DXovRtcLoCDzkplDVpZ0k3N0NE/FpyDrzMkmU6z+lyapbsTwq44Il9MVo4TAl/Qrr42r/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQubFD/psmVx3C+Q4V6I8h1JarghOfb7feAY4E/NzEnq5jYquA
	lUHSLOOd/tGBHESj+97ktdnYDGGA1NiARsD+rjW4pfJKvK+uNyKa89lfeaaChMwlSOs=
X-Gm-Gg: ASbGncvrbCwoFoG23tABK4lF8rvB4qBZ9RmO0PbgVGTRcPjsMaRONDJXJN408AxEhgP
	KlodA+xMvIrSF0Gx49RTQzP0vNEwVyzOGzCW71jCQ/CcbZVbUcQnoh7s3FGoM8XhgfZ9ShXZoPq
	uybaOCc72ZmH5Gwtfo9S9goA6JL8rG7rthfBP9DmyTaq0Qs5x7rn5eFE+RZMefgmOfu9+pDWuAL
	ipjipBG529ZxmJifwB93GX6NTtEF8pgQzMB8YYrZE69WQ5sIHL4mF/dJzouEIrIeP7wU4tKHDRL
	X/R/GQreeWZIpkC9vm6DvyNU92k/p3IRfNhLTlyycgIyEXdWo7Zyc83HYF8P3fvt0UY+9Ck8LWz
	TFs8rCHLOF6CUaRE2yuTkC6s=
X-Google-Smtp-Source: AGHT+IHh0NQjQXgu/NABbk1MMkudf0ISHIflblBn5cv5f3bj7pvk76Fugngfe7B8q3wIxDrd+KoGpQ==
X-Received: by 2002:a17:903:2290:b0:240:e9d:6c43 with SMTP id d9443c01a7336-24096b771ffmr143978085ad.51.1754023425316;
        Thu, 31 Jul 2025 21:43:45 -0700 (PDT)
Received: from localhost ([122.172.83.75])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c94sm31563565ad.93.2025.07.31.21.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 21:43:44 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:13:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: Prashant Malani <pmalani@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
Message-ID: <20250801044340.6ycskhhkzenkzt7a@vireshk-i7>
References: <aHTOSyhwIAaW_1m1@arm.com>
 <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
 <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7>
 <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com>
 <20250731111324.vv6vsh35enk3gg4h@vireshk-i7>
 <aIvQvLL34br6haQi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIvQvLL34br6haQi@arm.com>

On 31-07-25, 22:23, Beata Michalska wrote:
> The reason why I mentioned that is that getting current frequency
> for an idle CPU seems like smth we could potentially optimise away and save some
> cycles (fixing other problems on the way, like this one).

I agree with that idea, just that the cpufreq core may not be the right place
for that. Doing that in the driver should be fine.

> But if that's undesired for any reason, it's perfectly fine to stay with

-- 
viresh

