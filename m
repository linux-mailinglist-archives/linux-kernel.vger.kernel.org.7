Return-Path: <linux-kernel+bounces-787181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90943B37298
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF99E7AFC05
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8858E2EA170;
	Tue, 26 Aug 2025 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6mGL8Os"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF812980A8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234267; cv=none; b=lOFOovEkdIU9XArnQyjxbJgsJllqgsVCdZjxcIwMe2HqEZQdEwypJDddJOJi9QKzgSDNry6p1Ozm+yGTvOMc+UUpmv0EsKILJhCRvWjIMIeCiq+FU1QWP9Jfn7VHOpKedv4wvMO9awzovJyy+omui6jbizZfw2XipQwVZxDDSXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234267; c=relaxed/simple;
	bh=upz0pd6szGQzGRVufnsEbipy8MIi/tceHxoxzgEA4K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZBBb/L4f9Nci5R1vH7SBWV96xL/GWOPFeIgnmQ+anH6Ifpkj9AB8ZDaUr8l25lJ4cxNSTlMX6L7JcIGjxBWx2WoHNuW9ySGvYW3sR/swxOtBY11vFf2mg2WsCAzCzbmv/FU1yZFl9EbWNVCseLaKNSYFZj6a3k9zfwy5CeE5vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p6mGL8Os; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b12b123e48so56801cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756234263; x=1756839063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIkarbrRfLiSViNIpNSM7i2VpGQ/AquOsjFkrP5j+HM=;
        b=p6mGL8OsZkhGy/cjXbG4iKPimyffRC33Uuek6JJ8rKTIFL1yPi0G63N+EKYp7LsN+O
         FXeTHPAvBStxzbsIW0nJswGvSwU1M6hUXbRDKMn52KEpez5ST4ftA6O4owFuAEWedhZc
         qAlzX5Zg6glwmoubco2c2ry0yMk3WIzJztkiuUZIX+1KWHptxZdtjJof9bU9927X64g0
         J3ZOVvzr98mZ75I0SZUuNfjp2agNJDUFaTniNf3ePcErSwZ3/Y2ppGlc4UjL1nj+g+gE
         rkFZRQ4xcJhq2QBLHxPbJJsLbACdeSYGH+tJH3iZC2mfvJfKuYCgRwq877VWJTcnwRzy
         FeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756234263; x=1756839063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIkarbrRfLiSViNIpNSM7i2VpGQ/AquOsjFkrP5j+HM=;
        b=taAkVYH6+H6wmU4Wp8s2o4gTnEyh8WsZWrnCJHjemwDRi7OwCgDq2IlZkmTqzTssl3
         gFtOWoqYOV7aU2ylalEQKET59r4M+qrGQxFPE/RAWh7hD9oWNuHOfPGkD082I2pLkoog
         7bq0BQ1zhW+QtHlcma2y1NM1jFZkBdFMJavuIAhBWgiog8O9ZHzX9ZLuakmzi+8Ch9gD
         wo+6M/NFq+Ek1DFgYTj55/uIBpFCaQuEdbyQeJGpjonTOnevOq5pzqMqgU6iPCm4hn6V
         WqJoyyayrQczRhnqhmqFHFy+G+dbwD/abO3w3lrij8RFhF1UvC+EFbZ7kaV3gCZSRNRw
         +mjg==
X-Forwarded-Encrypted: i=1; AJvYcCWwY1wgIxpNkhT9KUwX+ftQLmzBPACa8b+pN5W5fOp3AZzJ5LMWiAnWXB5+SyOA9LScbFN7b0ru/RZ11II=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeumQUBrGWEqNF+IN803RTPsY3fD6aCocw8I1l1Kj80UGWx2sw
	dEPe39QRMJfSXTf2ezuj6U3ZeJO26h4C2nXjG2w2dL4LWA5JqcUzp7qHmv9KnzB2Ck9Efw6I4Pc
	8ehg/09F2HEnGm1bAdIUxFoOiz8eQdYptEEpLV7LF
X-Gm-Gg: ASbGncvtqCNB4RxFzqX68UuKji1pI8cnrb9GetE0JLmIeUXL+Pg/rnR5dAizz8iZnem
	EyJtXzUJE+GgirTSGIMCbUOeYN0GBAMlXcuV19/ulgv1iaOwLXL/TqPteSlYBXXzFFrLu1MHNip
	6ajCXTKdfcMdm0Ab1RK7g4SBgzdpjQ3zG2nJd6K45VJEOEex/epz4slPIXHxH8YQ3uKWt79Pa2m
	thkJRCQRwu9zn5Vk3WUHJ02FaDBenASJTz0dy4gN1n04fHwvZKA3v4=
X-Google-Smtp-Source: AGHT+IEDlezhHpkPskTIsHzwAr859mmB74LsMVq5z6xxtgaD/8BKWJWN6SZPB/twLGKMgS0NYyLKkzWty6QgQD/Fcaw=
X-Received: by 2002:a05:622a:2d4:b0:4b0:9c14:2fec with SMTP id
 d75a77b69052e-4b2e1d26784mr7759141cf.8.1756234262791; Tue, 26 Aug 2025
 11:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818124702.163271-1-chengming.zhou@linux.dev>
 <87212818-1f59-45e4-9a51-dca62ddb9633@arm.com> <e13c922f-2b51-4b4e-bcf8-617e4799522a@intel.com>
 <c0174dd7-86f5-4f4d-b0eb-dd60515e21c5@arm.com> <f3757eff-5ffd-4155-8cc5-a70231b4cd49@linux.dev>
 <CABk29NsqoF3U9nECBxh2cDWoPn=7cX+0sDfnpysNRb9HUcRyHg@mail.gmail.com> <68e34465-ecb6-409e-800c-3dd354156bb0@linux.dev>
In-Reply-To: <68e34465-ecb6-409e-800c-3dd354156bb0@linux.dev>
From: Josh Don <joshdon@google.com>
Date: Tue, 26 Aug 2025 11:50:51 -0700
X-Gm-Features: Ac12FXzCfMmI1yHwPlfoST6iK05YuGhJjp0PrfMhdh8r6Ov2btT7vN494vjrDO0
Message-ID: <CABk29Ntu5ywHeoJqkP0t85V9zWr2wtoy4ijf6wTFDkBdp4pAHw@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: Remove sched_idle_cpu() usages in select_task_rq_fair()
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Christian Loehle <christian.loehle@arm.com>, "Chen, Yu C" <yu.c.chen@intel.com>, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, bsegall@google.com, 
	vschneid@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org, 
	mgorman@suse.de, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, 
	peterz@infradead.org, viresh.kumar@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 11:58=E2=80=AFPM Chengming Zhou
<chengming.zhou@linux.dev> wrote:
>
> On 2025/8/22 02:13, Josh Don wrote:
> > On Wed, Aug 20, 2025 at 6:53=E2=80=AFPM Chengming Zhou <chengming.zhou@=
linux.dev> wrote:
> >>
> >> +cc Josh and Viresh, I forgot to cc you, sorry!
> >
> > Thanks, missed this previously :)
> >
> >>
> >> On 2025/8/20 21:53, Christian Loehle wrote:
> >>> On 8/19/25 16:32, Chen, Yu C wrote:
> >>>> On 8/18/2025 9:24 PM, Christian Loehle wrote:
> >>>>> On 8/18/25 13:47, Chengming Zhou wrote:
> >>>>>> These sched_idle_cpu() considerations in select_task_rq_fair() is =
based
> >>>>>> on an assumption that the wakee task can pick a cpu running sched_=
idle
> >>>>>> task and preempt it to run, faster than picking an idle cpu to pre=
empt
> >>>>>> the idle task.
> >>>>>>
> >>>>>> This assumption is correct, but it also brings some problems:
> >>>>>>
> >>>>>> 1. work conservation: Often sched_idle tasks are also picking the =
cpu
> >>>>>> which is already running sched_idle task, instead of utilizing a r=
eal
> >>>>>> idle cpu, so work conservation is somewhat broken.
> >>>>>>
> >>>>>> 2. sched_idle group: This sched_idle_cpu() is just not correct wit=
h
> >>>>>> sched_idle group running. Look a simple example below.
> >>>>>>
> >>>>>>           root
> >>>>>>       /        \
> >>>>>>       kubepods    system
> >>>>>>       /    \
> >>>>>> burstable    besteffort
> >>>>>>           (cpu.idle =3D=3D 1)
> >
> > Thanks for bringing attention to this scenario, it's been a case I've
> > worried about but haven't had a good idea about fixing. Ideally we
> > could find_matching_se(), but we want to do these checks locklessly
> > and quickly, so that's out of the question. Agree on it being a hard
> > problem.
>
> Yeah, right, we don't want to use find_matching_se() here.
>
> >
> > One idea is that we at least handle the (what I think is fairly
> > typical) scenario of a root-level sched_idle group well (a root level
>
> You mean /kubepods and /system group in this case, right? Both of
> them are not sched_idle here.

Correct

> > sched_idle group is trivially idle with respect to anything else in
> > the system that is not also nested under a root-level sched_idle
> > group). It would be fairly easy to track a nr_idle_queued cfs_rq
> > field, as well as cache on task enqueue whether it nests under a
> > sched_idle group.
>
> Ok, we can track if a task nests under a sched_idle group, like tasks
> from /system and /kubepods/burstable are not under any sched_idle group,
> there seems no way to distinguish them except using find_matching_se().

nr_idle_queued on the cfs_rq seems like the way to do it, but I agree
it is a tricky problem.

>
> Thanks!
>
> >
> > Best,
> > Josh

