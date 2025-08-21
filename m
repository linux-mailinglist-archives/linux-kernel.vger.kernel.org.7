Return-Path: <linux-kernel+bounces-780429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4645B301C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97748601B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D90534321D;
	Thu, 21 Aug 2025 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0ppBwfc"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC3C4C6E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800042; cv=none; b=uGYX0wcdhvp5klebdtSXo7lG07DlunfCAUnoYFKAZ3gTX1A2NZrFTfavVj593Vlrz5g5KdXT6l9DMtvW/jKnFA8iDyGM1gWM8Lnb0EF1ntFpRs+/CbxbdwvH6s5Kw8jyPvm3dYJArnuiluNyhtVvbW2cxvfT2gnKNoNU/wMVzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800042; c=relaxed/simple;
	bh=4xTVXUWSIzn+rtKMAeukR3OcjqFNohJBqmi7bD+UDZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etq8XmquUlhPxAPVRDv1Zic79uPg0cb7ao5jDQKap5bhx4LhvGdx0xM2uLGSkDWAqXIfkE+8ZXtvpgo3mnrUCXPyxFzVAwKHJ8n7In4yfvtt92GOKgli6vm4lEXSwN8sDByfJQxFltAqLFSui43S55oFtxsD7g1Tuk7M0E7BAdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0ppBwfc; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b0bd88ab8fso45801cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755800040; x=1756404840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utl3N9YKq8x8TBx+dD4CWGkLvWEUtqpvy/VDBLVsC5c=;
        b=Z0ppBwfcS6XLAGocSvxqOhFIY8xX4aiBGdjzBYTmnhpWRJwF5I48gcset29BGWKUAr
         yn2Hg3bHfCWoaiiFuE8Bxk9IzOUrNJSLfvII8svGQFrryVuwGBQK0JFVlFYB9xLrvvrs
         j11QRx1IqZGgsCDxPWRll8ZF1BdcPZf1AtCrg9dM0aMS4irVd6QFk+poFlramRhLiIFC
         nO8ImL2BsR5JITeWD8PLkoSGbnvZ6up/3nkSNhY+u7T92EmUebOvfTZFngUDRWerHCec
         udir4+7+3QOep59aPvDeIpNenykea1nJ3/C5iiHpWdVyABkJEmXTcYoHH0M2YOR1CO4m
         7Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755800040; x=1756404840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utl3N9YKq8x8TBx+dD4CWGkLvWEUtqpvy/VDBLVsC5c=;
        b=a+GQOBv4xTa2JBKq0eV4grzrne5Ddczutxonv1HSpgG3+tF2icKLaoFHgoprtdOR2e
         YJ1IVBiOSp2BvSe3psghol1bndNFhsBEppebkOP99lzbGtEz72hLCbXVLcVyEHH5Whaf
         bZrypWFo089y8ogWoUBXl7s0idUunc+YqkxcYlHn7BUDy8Tmv72OaN+mR8KrrX5WZckE
         5VOshf3cM4nzYAK5UE1ZCujwhAf3bV9xqKzkaFR3QAfWsx56mnyA0cRbuLvBhH5UmR3i
         uEWaA8bazcOJNEb5x7dPuHGLvqIy0HZBHHMlgf5RGc4uQERX1b+dzx83/8/UBJ+kBK6K
         fO7A==
X-Forwarded-Encrypted: i=1; AJvYcCWxoFppjbco5puyjYKQ0I50TZiP5gXV8oJ38E8vGj/2lvgKaY8oGMwmytskM1IQIHCr+vUrSDjAz1pc6ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrC3Q4c07iJbGE+Q8C/NBEX/zSg2ay1Hif3fQh9UzOEiXemU/v
	XRKMsjdoijxekVbMcgXn1HsL0IQyGTzpVfrBUSW0mDWuxBUO5QfAjVdC5IILegjJf112lMDbgHc
	57YseIIHCv4TDWJhbuj3fLsbMAI2l1P5HFt2nfrJQ
X-Gm-Gg: ASbGnctsWuqk9vDrEQit+TQslj0tZQJbb4yiikC4vUgsNNVJvjVvqwVjnonMCbJsIor
	nSFd4Ny3zIQLbVjtwuJpFpmNhGf0NsFejDi0YfYpM6iyUEXnEm2siQf7JDyag6fRaEJnSkUdENS
	1IvBUqU4kWkiTu44IlgsS+5ppXuaEiqhGEio9ERx7AVAFdfcdicInKLqGy3McRqCOYHy/45tRqv
	qsA/jKRCLFGVYRaCAL1r3KR9A==
X-Google-Smtp-Source: AGHT+IHL5amjxVC4uxO+1YyfwrtKPPvqey/4YVH5vLA6XOwg5VwNhpvqvtxfkLgIALoUHH+6fjKS8TtqQfaIr2S4RWc=
X-Received: by 2002:ac8:7e93:0:b0:4b1:1ba4:208 with SMTP id
 d75a77b69052e-4b2aadb3e3dmr274641cf.12.1755800039583; Thu, 21 Aug 2025
 11:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818124702.163271-1-chengming.zhou@linux.dev>
 <87212818-1f59-45e4-9a51-dca62ddb9633@arm.com> <e13c922f-2b51-4b4e-bcf8-617e4799522a@intel.com>
 <c0174dd7-86f5-4f4d-b0eb-dd60515e21c5@arm.com> <f3757eff-5ffd-4155-8cc5-a70231b4cd49@linux.dev>
In-Reply-To: <f3757eff-5ffd-4155-8cc5-a70231b4cd49@linux.dev>
From: Josh Don <joshdon@google.com>
Date: Thu, 21 Aug 2025 11:13:48 -0700
X-Gm-Features: Ac12FXwcMcoLleRa_FehKmPe_yuLDUv5mWf3tVuyCYM53qgBCxpXJUctvr_Fa2w
Message-ID: <CABk29NsqoF3U9nECBxh2cDWoPn=7cX+0sDfnpysNRb9HUcRyHg@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: Remove sched_idle_cpu() usages in select_task_rq_fair()
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Christian Loehle <christian.loehle@arm.com>, "Chen, Yu C" <yu.c.chen@intel.com>, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, bsegall@google.com, 
	vschneid@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org, 
	mgorman@suse.de, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, 
	peterz@infradead.org, viresh.kumar@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 6:53=E2=80=AFPM Chengming Zhou <chengming.zhou@linu=
x.dev> wrote:
>
> +cc Josh and Viresh, I forgot to cc you, sorry!

Thanks, missed this previously :)

>
> On 2025/8/20 21:53, Christian Loehle wrote:
> > On 8/19/25 16:32, Chen, Yu C wrote:
> >> On 8/18/2025 9:24 PM, Christian Loehle wrote:
> >>> On 8/18/25 13:47, Chengming Zhou wrote:
> >>>> These sched_idle_cpu() considerations in select_task_rq_fair() is ba=
sed
> >>>> on an assumption that the wakee task can pick a cpu running sched_id=
le
> >>>> task and preempt it to run, faster than picking an idle cpu to preem=
pt
> >>>> the idle task.
> >>>>
> >>>> This assumption is correct, but it also brings some problems:
> >>>>
> >>>> 1. work conservation: Often sched_idle tasks are also picking the cp=
u
> >>>> which is already running sched_idle task, instead of utilizing a rea=
l
> >>>> idle cpu, so work conservation is somewhat broken.
> >>>>
> >>>> 2. sched_idle group: This sched_idle_cpu() is just not correct with
> >>>> sched_idle group running. Look a simple example below.
> >>>>
> >>>>          root
> >>>>      /        \
> >>>>      kubepods    system
> >>>>      /    \
> >>>> burstable    besteffort
> >>>>          (cpu.idle =3D=3D 1)

Thanks for bringing attention to this scenario, it's been a case I've
worried about but haven't had a good idea about fixing. Ideally we
could find_matching_se(), but we want to do these checks locklessly
and quickly, so that's out of the question. Agree on it being a hard
problem.

One idea is that we at least handle the (what I think is fairly
typical) scenario of a root-level sched_idle group well (a root level
sched_idle group is trivially idle with respect to anything else in
the system that is not also nested under a root-level sched_idle
group). It would be fairly easy to track a nr_idle_queued cfs_rq
field, as well as cache on task enqueue whether it nests under a
sched_idle group.

Best,
Josh

