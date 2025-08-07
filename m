Return-Path: <linux-kernel+bounces-758471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57505B1CF98
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 02:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DEF2562370
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7DB4C6E;
	Thu,  7 Aug 2025 00:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGAdm5yc"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B4A3208
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 00:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754524925; cv=none; b=N50EvcUgiUkKY+IUyjJWlZ7oJ7Mr56IxAq0/xN+a+d/F21cIWSQQqljdXxpCLdQiYSeaeWvMJIQUtAmF2OIqlVz888V2SSHbbzZ0fm8xPe9RdTokRlWUJ/6TUWwdLEHd9P1hc8ORWO124PfHnT+yW57yovj8UjdmE5iRvQ1slnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754524925; c=relaxed/simple;
	bh=/HrV78szyJC/26YwUwTLBwcVGTJ2HBbTObkSJMIbXBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugSeoc9A1eheFz88fBW9sRAjhD3ivxpaLk0WM6Pq1eRHfuSzBBHo0j5zbYaP4Weh+WAW5aritIzgK9OS4KOchDYM2WkJBNTYm1snpV/QfuOjDPKVAATixEXgzOrf2ap6olzd2uD6kM6gNp56HqdmL7cIAP7HMoVhTb1z/ldD1Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vGAdm5yc; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b07a5e9f9fso172451cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 17:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754524921; x=1755129721; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/HrV78szyJC/26YwUwTLBwcVGTJ2HBbTObkSJMIbXBI=;
        b=vGAdm5ycsHoJIGNfJzXC9i9jSXEQbtG3AoPP8j1M5ufWr3TG5MliKXKCCNAvDaSMYH
         NCitO2C8VdKaSgWZwfRRlYptmgdMHFStOuPGQXaKh4ePdID8jTQSCgKaeZm9difBQ8ZV
         dqRl0QItGojrP3ge7HEedlFx/YQP6j+xiUl3jYSAJAaAdWU7jx/e0FM/pkeSTJNj3vMI
         o61DzHzJpjf+PPeTCZv7g/XDRiyopEB7ofeyl4T18GNuIDzPi5j/pjZ/gRj/aHWwFjsk
         yGvWcDxxc9DEmmAKimYNFNjnIOnAvTHUVP0osH91Ym0CpGXGXwIWDD1vBaTagYV76Jz7
         ZVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754524921; x=1755129721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HrV78szyJC/26YwUwTLBwcVGTJ2HBbTObkSJMIbXBI=;
        b=NyHtjvBaPPYmi2ufuHS5He/RIjJ0Vc0peCr9k8oiA2h437os/RQs1yVMHiHRDQkpA7
         hr4D/xyxH6s+/nxfUS91t7VEq2SPx4MLsNijkUeJwris4tY6b9NKtaiXsa4zRom+CUeG
         WB4T8IEzHxAeLah115v7gT2fNQB/2fMd4bn4uzvnNd/iLOfZh7kL5qnot15fZHEjBvo5
         yJreQUPUcRbEsYnV56PevawhS8EfDO4kusGK4ujIZ67GFpLgnnLCvmC+lWJpqVzxfZ0F
         G//Y/o6hFwJfSgPKPJzcceTENI0E8gPLaX6F+LZoXuFV6XuxssvjCYzHnUER4L28LkJg
         2y3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXY0NLiXaPyFVEN4WjByfqIVHj3+zVAnKD0tCT8tFgLprhSCotm/C6BHdQotiKvJpM4sNFuRIRNv6w5KrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YycfLK63j6PeM/07jSpyaSfd3Y4b7xXNF81ln0BueYwQiMvjGV+
	gdfdWnN+8vlZQ7O+Rr5SoPpWfv9zYp3CBXkOEOJCIDFnUpr//7V9mtwPo8/mcdX4HksD2tgqLKL
	J8sdDAhDR+deu2DDV2/8d0qiIk0ga5SPjvb4gXu5c
X-Gm-Gg: ASbGncuAiNiCC4vugPq+kpZSxMcK83v6xaaxXRvhbibhp6XtDWXF0AaHCXnvIsbaUm1
	mB/WHLDMINdachhLQr8xdwp/XMarstDcNqzShPwv7ISHapaF8o3crrhbNHFduv09hemT1niRa92
	XDhYDefkq/8rizA3cGRelwedm9ZHxIXvDuqrCNuLCa/yL4mFwu0fMBMQhQR476cEjBbjCriBgXo
	G89u21JPUXjrE9c
X-Google-Smtp-Source: AGHT+IHcUR3vA9pdpN9/X6yrIqMGJ68GXiy2tA+ThWcjXUi4yzjZQeHsRHgmfD2xclt8bjqt/sTnCjR0kdgqy69KW2g=
X-Received: by 2002:a05:622a:607:b0:4ae:d28f:b259 with SMTP id
 d75a77b69052e-4b0a35ea991mr1115451cf.1.1754524920629; Wed, 06 Aug 2025
 17:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7> <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com> <CAFivqm+kbRbJsJ_Obb4bV6fgxbqAwOndLUCDwHvWWnpMYoNoNw@mail.gmail.com>
 <aIvSe9VtZ-zlYfbQ@arm.com> <CAFivqmKR1dqVqTsoznH2-n8cyAM1=5zEGcEvmESU8RNGac-0sA@mail.gmail.com>
 <CAFivqmKgiVEWMQ90Lh6T+Y44E6m4jmdF5sUFfVNTmgVHOMtZsw@mail.gmail.com> <aJMCgGt5zu5Dhrd5@arm.com>
In-Reply-To: <aJMCgGt5zu5Dhrd5@arm.com>
From: Prashant Malani <pmalani@google.com>
Date: Wed, 6 Aug 2025 17:01:48 -0700
X-Gm-Features: Ac12FXzzj2kdgdXaFQbFtMvgX-wUHAziXBQqeV-STmRzK7yIWcA71NU6wzyXn_o
Message-ID: <CAFivqmLSp6RwfsPBK0d=zvRd6M_5GoeU4jHb-0OM9BpaDeSrzA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Beata Michalska <beata.michalska@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Content-Type: text/plain; charset="UTF-8"

Hi Beata,

On Wed, 6 Aug 2025 at 00:22, Beata Michalska <beata.michalska@arm.com> wrote:
> Would you mind giving it a go and see whether that improves things on your end ?
> Note that this is a quick and semi-dirty hack though.
>

Sure.
The provided patch doesn't appear to work as expected.
With all cores loaded (stress_ng --cpu N), it's returning the same
counter values
across samples. Here are readings from multiple CPUs:

t0: del:18446603338626579088, ref:192
t1: del:18446603338626579088, ref:192
ref_perf:10
delivered_perf:0


t0: del:18446603338627594896, ref:192
t1: del:18446603338627594896, ref:192
ref_perf:10
delivered_perf:0

t0: del:18446603338627627664, ref:192
t1: del:18446603338627627664, ref:192
ref_perf:10
delivered_perf:0

I verified separately that the "burst_read" path is being used by the platform
I am testing on.

BR,

-Prashant

