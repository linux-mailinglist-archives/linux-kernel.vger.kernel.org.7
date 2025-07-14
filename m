Return-Path: <linux-kernel+bounces-729343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939C1B03539
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED70A173530
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378DE1F3FDC;
	Mon, 14 Jul 2025 04:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVivIINL"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465C31CD0C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468292; cv=none; b=JUkwtSy1KO5tZejN0wZkGDsOnZT6R3ebjdXRRClvhK0wpQsi3M9Se16pUCBo0WEKdErLdnvo2yojBfT4qp1fTS7d5drhuvWjGQ5iPlxmB08QUUZQdta1t0v8/byVsM3jR96mdOmLqWdK4hGlzOeEXzSBvOqDMvR6Pz9CnOREKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468292; c=relaxed/simple;
	bh=5vNg5iLm5fQUUSPoWLFmK0LPoRl1f1jq9DvfznsWj1k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dVgtLE/JiM1ACEZEs99kU34ovTlpiFSvExyzJBX7N5+bwfDuzNjxwRWgH+NriHoqYFIWV5YvOZ6E17fq6/JlRJTQcRz36YSQj7U0AZCxO8LYG9vTelCZuxX4XDnJ73/iL1VZxLwWqPPCi7/kl8e7TOnnOriMN8f+BrL4Y8KYDrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QVivIINL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74ea83a6c1bso1724670b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 21:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752468290; x=1753073090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vz4nZeT2Phnj2r45yuIHWOY+oW8/KY+q0YqmSchxW00=;
        b=QVivIINLKE0CEJZ/0Rs8RcPTHlPb50OyFBt0X7jS835PVSEYzQaAh1Tzd5Frh7SPbE
         MuBjE9Ju3oJIeGOWaRXDbVXIX3tGcjxQStNYpaaxeCkm+xAAWepvwRxYb/IwgpzLG+Wc
         8CJM5L/4+i1PQaSgPHbO0rMgBZLuSTj94jrZJcM/L4FknHvHhSLB+7Vut3L9hWs6CgLW
         PizwcmxOmH9mOZznkuMO1zYZNHRQgDuJLTaAflSNMqzOUi6s2+PEph983XGrckB0ABxD
         E2Q6aY36Wo6oePbTHu2ThaePuB7PUinJONAouQispQzlJm8OtIGyWAKIvnOPsFXH/gEU
         t84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752468290; x=1753073090;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vz4nZeT2Phnj2r45yuIHWOY+oW8/KY+q0YqmSchxW00=;
        b=HFZms1nFBIGGEJbNIEQAp8EUlReUM0Ddv9INIEIwOA5qjHiE13RYWM4IPJsadbEVp/
         9jpGqu8trBwvDKFy+jS2MA1hm3u8AVeVTucqV5OepewbtiXnL1Tg/NK8uDGeYtST2eYE
         CDx7yQZ2+eBjwxK5pANvEGpqr96gKaLyuWfhN6To/Rh0glZQSWDI47IhCxEXYEV1Tzv+
         aijM8Zy02A0X4mky1KpTGQ+Jx0exingwtgzU/0OR55DjgZHk5mf77pbyYSd70biBUAIL
         gOu06uWUjfBnqilqFSbMU4VBeSQYxMx5qnre+X8o95OtovPVxDGpPZ0/Arc2dP7jQrY7
         aDhA==
X-Gm-Message-State: AOJu0YzVkFh0e0Z15gZzXc0OEIKWeDxJsVhBAvLTwtCYwmCjprf+j8ZR
	GmK2a/rElMFGrTnKGGrOcKIReZ/Zs9d63yWxGXIh9QUqQPk8zsNpyKbhuwhxLprTB7LJPDR9qRX
	cRZI0b6Wq+g==
X-Google-Smtp-Source: AGHT+IHS8Q/px8WH9ZbMmObz8rlW7f6xuLYox5HUzwM+jzX5Ungse5eiCulnCr9QVrut7RAYQNYZbnb9n6yx
X-Received: from pfble3.prod.google.com ([2002:a05:6a00:4fc3:b0:748:f4a1:ae2e])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:23c6:b0:742:aecc:c47c
 with SMTP id d2e1a72fcca58-74ee0ab59d6mr13933650b3a.7.1752468290477; Sun, 13
 Jul 2025 21:44:50 -0700 (PDT)
Date: Sun, 13 Jul 2025 21:44:48 -0700
In-Reply-To: <aF7qjAkwXhjTVmT-@slm.duckdns.org> (Tejun Heo's message of "Fri,
 27 Jun 2025 09:01:32 -1000")
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250603224304.3198729-3-ynaffit@google.com> <aD9_V1rSqqESFekK@slm.duckdns.org>
 <dbx8y0u7i9e6.fsf@ynaffit-andsys.c.googlers.com> <aEDM_s7y8xMKJHph@slm.duckdns.org>
 <dbx8y0tej595.fsf@ynaffit-andsys.c.googlers.com> <aF7qjAkwXhjTVmT-@slm.duckdns.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx8wm8b8jpb.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [RFC PATCH] cgroup: Track time in cgroup v2 freezer
From: Tiffany Yang <ynaffit@google.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	kernel-team@android.com, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hello!

> ...
> Glad that worked out, but I'm curious what are the involved time scales.
> Let's say you get things off by some tens of msecs, or maybe even  
> hundreds,
> does that matter for your purpose?


Our wotchdog timers are on the order of a few seconds. Tens of msecs
would be acceptable, but I think variances of hundreds of msecs would be
large enough to cause issues. I mainly wanted to include the rough
numbers in case anybody was curious about the actual magnitude of the
offsets (if they wanted this accounting for a different use case, for
example).


> While it's not my call, I'm not necessarily against. However, as you noted
> in another reply, the challenge is that there are multiple states and it's
> not clear what combinations would be useful for whom. When/if we encounter
> more real world use cases tha twould require these numbers, they may shed
> light on what the right combination / interface is. IOW, I'm not sure this
> is a case where adding something preemptively is a good idea.

Ack. The per-cgroup accounting gets us most of the way there, so I'll be
sending out that updated version shortly! I agree that another relevant
use case would be immensely helpful for figuring out a way to describe
the broader problem we are trying to solve and what shape a solution
should take.

Thank you for your feedback and for helping me to arrive at (what I hope
is) a reasonable approach.

-- 
Tiffany Y. Yang

