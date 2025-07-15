Return-Path: <linux-kernel+bounces-731253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D7CB051C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35B4560428
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDAB2D63EF;
	Tue, 15 Jul 2025 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KIFPa5v1"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52392D3EDC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752560918; cv=none; b=sCJGeIoyzpcOcep6k4bonb9QYR6WSlnS4YWU5iPTfOjfgI9jZHrHOw0RNFpJiEQx3QdhG8MU1D6UjrJ1dsNx3VR+TddCN+8cncDgyRZ6dNhDPWPzFkzchdOVrcFKYxghJh/RpiiOea5L73j/8RocIgUtC+N+DZLke4wIHlPHpJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752560918; c=relaxed/simple;
	bh=hzBhaj0bPfBfH8WKXsSODcE4YTYKjXAXkYFweZnaSTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ks4IModBMfk1FXLGiasBqskOFm4BFnfg6buUX+wob0N9/+K6LHKf8PVFlzy7djV613UNXHcFEbIwCkQggNbwIrwkbkSDnCTa3I+W6MlO3kpIfSeyNMsdesahJPvKnd21hOa8I/8quy8BjZlrhIrl74nqwi1DMN8OM1Lmui1Fflk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KIFPa5v1; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso259951cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752560913; x=1753165713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IIFY6igA7ItbPWoIp1wqanVGqlzkgUCSQp6wKLEinNo=;
        b=KIFPa5v1yzEOMUWc2oN3k4lDin08bHuedvs0R+MBycdm+X3PxNHHkj/3pfKcan15ie
         ozuO1URQu7Qez3uJxidG4ZbSlrOaYacxdHk1XaBHVtQFxr3NGsI6KwsY/KJKoqmIKKgZ
         lTWCxWd5nrPTRBp69m5XUbsByJ3KSSqno9weyJo0voZKCEXte4qwyXFhyF4cGml5q2V5
         z431YKXtSnZoe5Gwt47JM6HCu7gqDfvFi3FMj8ZNy02wjkkGXaG1MlA0zzYWNDILRuzD
         AmMH8H0PL3DBJHzDRUiemWdUxNXJZo3vnvQL8ggBUqD0CHSMRVdxswHK9DiVcUNF5fli
         CFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752560913; x=1753165713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIFY6igA7ItbPWoIp1wqanVGqlzkgUCSQp6wKLEinNo=;
        b=Pj4IjViDgXxxa7qAbCIdtmnRik1VQnFx4j/6CXHTIz9NzNUXaDdVsicem9KEPUnyl1
         8U8D6aVXqKiuZp4EiboVYL0k26NIOtifLRIlFu0yQQBkABjoyX6JU5MTSrgDUD+WCmoZ
         EyHlvdOK5LQg0H+BZwUS51GowOVD2HhzuyIv0Oth+DIs+qy2FmVBKIt9VUYStj7B2g5g
         uhJP71F/xfTTu/f5dTGIa/A7pbCKLJvW0uZdvJriL3Uv2rXk+0IhBrmNFBwX9YIZpMl1
         9nyMjYENFITo5GnoTzWAZreZvEv/aYwhGb+t+XJ21zpJ392yZjk5EUlklIStxcDJCfs2
         hO5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMNuY77IBRmwz+SnVdhWEWqhoNMCPrJz7L6Fbwb57JNxcCbGd4gyFwmQC9lUYg2xHRLrE/uQH0BwsftKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuq+pAl/+FwJJsqNTE0Tu+XtgpRe7daUSVJogVvu8NoVwvTFqf
	EuUdQqkIjR1U6Wxn1d/68uXdXmu1ZZn6liDa8N5jL5tJx4/KeEbrE6CUq2+3jXf2S5EfqCjbQUa
	nb6BuRtFn7xu1tMHbKWdf3UQS2tMPPWGfUcaGODxS
X-Gm-Gg: ASbGncszptm4itRLYEazVUxyXVyxbQrVw3aS/63wl7gGzdoaNBSFCjILC4CpBz2POom
	ug9PAbLUlAz8wgoCzi5NA+g6D3tGKHJIe5YP3uMJAv4vsjIUTm+WO/ELRQLihNGr0WVJ8doM6NV
	VKb4bm8+TfJQZ7w5ljtQf8SWZc5UVjbxV/fliYYfpQ68asTWve0HKz7Drm/eDzZXWMHCSIYVJX1
	jujJlkfsUwymZ/+
X-Google-Smtp-Source: AGHT+IGbMIrszzxiU6KwxjeVl8dXHdRHJ+aTFTtAE8A5hcOifW7wZve3PV5GRWnbvGMzyczeFNNWqNJ4uzW79JPmRIs=
X-Received: by 2002:ac8:6909:0:b0:4a9:d263:d983 with SMTP id
 d75a77b69052e-4ab80cc6f95mr2983331cf.22.1752560913237; Mon, 14 Jul 2025
 23:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619000925.415528-1-pmalani@google.com> <20250619000925.415528-3-pmalani@google.com>
 <ff65b997-eb14-798f-1d2f-c375bf763e71@hisilicon.com> <CAFivqm+hjfDwPJCiHavnZSg2D+OaP5xbQnidmwxQ3HD32ic6EA@mail.gmail.com>
 <ef3f933a-742c-9e8e-9da4-762b33f2de94@hisilicon.com> <CAFivqmLCW2waDnJ0nGbjBd5gs+w+DeszPKe0be3VRLVu06-Ytg@mail.gmail.com>
 <CAFivqm+D9mbGku-nZKSUEMcQV5XK_ayarxL9gpV5JyfmhirsPw@mail.gmail.com>
 <aGuGLu2u7iKxR3ul@arm.com> <CAFivqmJL90xsELhz4tPtkYA9vMzS9C=V__nwo=kWJKjKS=mE_Q@mail.gmail.com>
 <CAFivqmKBgYVa6JUh82TS2pO915PUDYZMH+k-5=-0u1-K9-gMMw@mail.gmail.com> <aHTOSyhwIAaW_1m1@arm.com>
In-Reply-To: <aHTOSyhwIAaW_1m1@arm.com>
From: Prashant Malani <pmalani@google.com>
Date: Mon, 14 Jul 2025 23:28:22 -0700
X-Gm-Features: Ac12FXz0toYZ_F0QSp7PcKhcRht-0rDhzIAHVwCuSAtnjh8CuP5L2iqWPl5spU8
Message-ID: <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Beata Michalska <beata.michalska@arm.com>
Cc: Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Content-Type: text/plain; charset="UTF-8"

+Sudeep.

On Mon, 14 Jul 2025 at 02:31, Beata Michalska <beata.michalska@arm.com> wrote:
> So I believe this should be handled in CPUFreq core, if at all.
> Would be good to get an input/opinion from the maintainers: Viresh and Rafael.

Viresh, Rafael, Sudeep, could you kindly chime in? The unreliability
of this frequency
measurement method in CPPC is affecting the cached frequency saved by CPUFreq,
which in turn affects future frequency set calls.

It would be great if we could solve this in CPUFreq core (maybe not
rely on the cached
frequency while setting the new one [3]?)

>
> In the meantime ....
> It seems that the issue of getting counters on a CPU that is idle is not
> in the counters themselves, but in the way how they are being read - at least
> from what I can observe.
> The first read experience longer delay between reading core and const counters,
> and as const one is read as a second one, it misses some increments (within
> calculated delta). So, what we could do within the driver is either:
> - Add a way to request reading both counters in a single cpc_read (preferable
>   I guess, though I would have to have a closer look at that)

I already tried something like this; I used [1] which basically puts the
2 (constcnt, corecnt) register reads in a single CPC call;
This did not help. The values are still highly variable. I never got
merged FWIW.

> - Add some logic that would make sure the reads are not far apart

As Jie pointed out earlier, a lot of this has been discussed (see the references
within the patch link [2]), so I'm not really sure what else can done
to reduce this on
Linux; there are two registers (SYS_AMEVCNTR0_CORE_EL0 &
SYS_AMEVCNTR0_CORE_EL0), so there will always be some scheduler induced
variability between the two reads.

Best regards,

[1] https://patchew.org/linux/20240229162520.970986-1-vanshikonda@os.amperecomputing.com/20240229162520.970986-4-vanshikonda@os.amperecomputing.com/
[2] https://lore.kernel.org/linux-pm/20250131162439.3843071-1-beata.michalska@arm.com/
[3] https://elixir.bootlin.com/linux/v6.15.6/source/drivers/cpufreq/cpufreq.c#L2415

-- 
-Prashant

