Return-Path: <linux-kernel+bounces-859117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F13FBECD05
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E0B42074D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DCA28935A;
	Sat, 18 Oct 2025 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct+f/T++"
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBAE1A316E
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760782028; cv=none; b=j3J0HxKLW9lgXHHJ81GFmGronPFDHfGREFQCjlhJmQuTqACdnjLz3XkklYiIGCCPhlFFF3z7hoJW7+KvnlvKngvjBOjitK7pc9xOubQpzeJMYjtFxKtPwZ5ATVIbw9ZfFEmbIIMO/yMcvgk/1JPlucufxJ1uI9DGdOlN2vMZVS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760782028; c=relaxed/simple;
	bh=StMtoQKqnTAn/VlpQqpHFb1tATeG5mv9KfOCi8F+X50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNcepewF/DEKT5oTLVa/dJYPr46l2AFkWQUFRhsJSa4APH5XcJR2lkWZOzZV190SYD+tIMGk/F37Q3oTS0SHZDczCM3L/ptRUtbJDTw4DYuxxo2gxpfcO35S1amr3AXt1kDSyPYG4O20D+V1XFD+3WE9mhBSJGEPLip6Q7dVVQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ct+f/T++; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-36a6a39752bso25949341fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 03:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760782023; x=1761386823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkJVC9CNMdTa5Ykb5ei44ed8gNrJ3sy5T6W8MBNGp2U=;
        b=ct+f/T++QotVFi563fAbmpgAgJ2OMDY4cbI9WnZ3T5CqHEJsudD2Le6t1/L+1qnHQR
         /POmXSW50RZ1fhlog+16f/vhGyMfcMfV6JMrp9H9FEwHz+q2+2C2mfSHpS8f8RY56xw4
         q0qo3sAlxu/cXj+116q7b3BIXG3574ATu+EaRqvvCu+smaSmdSO4n3uyH0aRPj6aYnXh
         IsqUiLL0xtDy/nhipXLPV+D5Po6VeyfVWiBPgZfeqa52J4lUbG2A7dTl8/Kxp+sNzQ9c
         5vH1AxjPjmQ4lzZBriAOn8OevwKJfC2hsKNZiNAISOoeBpvyDm+UH5893TIyVv3s/I9r
         BC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760782023; x=1761386823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkJVC9CNMdTa5Ykb5ei44ed8gNrJ3sy5T6W8MBNGp2U=;
        b=stPJp5CxEaPixrTdyaON+Bw0iiLpexU6OLogUA6QjjpTdBDPjQoFiTxM0L+rxNGZI3
         I4ClGymJpo1ddfLzB8MZCAWsNwnjLjkoEs+M45oQIivKFNluwSWi06qxC/wv+fDOcVtd
         5GSiVOqbnTkXoC2YHEXDuAT5sOYR7zAbQzNCgVUNvbgEZMOg2MW+OvXzetAAoSfNqKKQ
         6B7aRL+Te9E0GbpyizferKmOV0ujMpfmjJlXBxd37PFqYlyA1aexK83JbrPRv2OxkEGr
         MKvw63OMhIMPTCYi4S15m160bcfFXRS0IDQkFLnZPH924O3BAyFTmttHvhnb+yJMLEhj
         0MuA==
X-Forwarded-Encrypted: i=1; AJvYcCXobhlfmcOuZiZfCgY0P5q2K3fXq0k71axHxhs44ieuRsDRrwB1FEJKa1kDCJu45M1ajMxsao6v08CZXVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3x8/FuvgmRy4RHA5/3Xyw7h1yQ0j+qBLNzyK9pHAz40YJsPMI
	rWw5hiyrJotaTm7+hyusWCP48M2V4hmXzw6F/qNm6awOm10fAk7zA/zwJ6Lc6K3wT5OxD3BRhKZ
	Y3XiHw0OXXLgumj01f31EEqH7M5bfm1A=
X-Gm-Gg: ASbGncvOka/8eRN9yF+5Za+aqcvRcVpoXP3wKjJAOlag1rYMn8jNZ4reuWPZdqzoQos
	ctqK0Jype6zpC0IufmaSLFf3ZJF6gNC+Sio8YSbiJ9NwWJwRFx2YKGqdOZUQD2IikXZN84FQFCC
	AeqPIqsZLzxV9UERmFxEO5cYCw0IG1u+TOI1+Y6lSClNAKgiJPueXuYBgp8J/Hngo1pdbeoZm5P
	JoY/23dAw8U5/L4lJlgQdmmt0mGyze4n5SbE7tzyN3BukXXDg8KG4XcSGyT
X-Google-Smtp-Source: AGHT+IHeUhcGNwmxU8KQ4UMn+oU0vFSF2dwjsM3hcbX8xOl6yc4VRwbW9q4Go0ZMD7Z9wgeXyxMH2VDt5AjqrKAlx4g=
X-Received: by 2002:a05:651c:2209:b0:35e:8756:ecee with SMTP id
 38308e7fff4ca-377979401b8mr20694351fa.21.1760782023240; Sat, 18 Oct 2025
 03:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910084316.356169-1-hupu.gm@gmail.com> <1081f8ca-3c1b-46fe-a7d4-31303e5e2298@arm.com>
 <CADHxFxQTGRHuu82YK25UCcF2NCxyU_HrFik-jKY23eUMTfft7Q@mail.gmail.com>
 <CADHxFxT_x-GanuxSrWP+tvEC87bf=z+ZkwSBnwomU282MJx0sg@mail.gmail.com> <CADHxFxTUvx4VvOizfhg7jeyenN7m+YX9Oro+ndPQ1sr_Y3d1Ag@mail.gmail.com>
In-Reply-To: <CADHxFxTUvx4VvOizfhg7jeyenN7m+YX9Oro+ndPQ1sr_Y3d1Ag@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Sat, 18 Oct 2025 18:06:51 +0800
X-Gm-Features: AS18NWAo7pU82kENimkWc_7IJ9bT0t3VlmSE1HtxPLDA1cua8DSdnb5756opuuA
Message-ID: <CADHxFxS6nmF1wzuEDyoFgj7XppkheW=SN4ygnMUYwf_qnoUCAg@mail.gmail.com>
Subject: Re: [RESEND][RFC] sched: Introduce removed.load_sum for precise load propagation
To: Pierre Gondois <pierre.gondois@arm.com>, vincent.guittot@linaro.org
Cc: peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com, 
	rostedt@goodmis.org, dietmar.eggemann@arm.com, vschneid@redhat.com, 
	bsegall@google.com, linux-kernel@vger.kernel.org, mgorman@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

RESEND AGAIN !

On Wed, Oct 15, 2025 at 3:20=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
>
> Hi Vincent Guittot, Pierre Gondois, and fellow maintainers,
>
> This PATCH has been pending for several days without any feedback.
> Please allow me to RESEND this as a gentle reminder.
>
> Thanks,
> hupu
>
>
> On Sat, Oct 11, 2025 at 10:27=E2=80=AFAM hupu <hupu.gm@gmail.com> wrote:
> >
> > Hi Pierre Gondois,
> > Just wanted to mention a small detail that=E2=80=99s easy to miss.
> >
> > On Fri, Oct 10, 2025 at 7:37=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
> > > > It is possible to compute load_sum value without the runnable_signa=
l, cf.
> > > > 40f5aa4c5eae ("sched/pelt: Fix attach_entity_load_avg() corner case=
")
> > > > https://lore.kernel.org/all/20220414090229.342-1-kuyo.chang@mediate=
k.com/T/#u
> > > >
> > > > I.e.:
> > > > +       se->avg.load_sum =3D se->avg.load_avg * divider;
> > > > +       if (se_weight(se) < se->avg.load_sum)
> > > > +               se->avg.load_sum =3D div_u64(se->avg.load_sum, se_w=
eight(se));
> > > > +       else
> > > > +               se->avg.load_sum =3D 1;
> > > >
> > > > As a side note, as a counterpart of the above patch, the lower the =
niceness,
> > > > the lower the weight (in sched_prio_to_weight[]) and the lower the =
task
> > > > load signal.
> > > > This means that the unweighted load_sum value looses granularity.
> > > > E.g.:
> > > > A task with weight=3D15 can have load_avg values in [0:15]. So all =
the values
> > > > for load_sum in the range [X * (47742/15) : (X + 1) * (47742/15)]
> > > > are floored to load_avg=3DX, but load_sum is not reset when computi=
ng
> > > > load_avg.
> > > > attach_entity_load_avg() however resets load_sum to X * (47742/15).
> > > >
> > >
> > > From a mathematical perspective, deriving load_sum from load_avg is
> > > indeed feasible.
> > >
> > > However, as you pointed out, integer arithmetic may introduce
> > > significant quantization errors, particularly for tasks with low
> > > weights.
> > >
> > > For instance, if a task=E2=80=99s weight is 15 and its load_sum value=
s are
> > > 3183 and 6364 respectively, both would result in the same load_avg =
=3D 1
> > > under this method =E2=80=94 resulting in an error of 6364 - 3183 =3D =
3181. This
> > > error increases as the task=E2=80=99s weight decreases.
> > >
> > > Therefore, I believe that recomputing the propagated load_sum from
> > > load_avg within update_cfs_rq_load_avg() is not an ideal approach.
> > > Instead, my proposal is to record the load_sum of dequeued tasks
> > > directly in cfs_rq->removed, rather than inferring it indirectly from
> > > other signals such as runnable_sum or load_avg.
> > >
> >
> > In addition, weight is a historical variable that may change over time
> > due to dynamic priority adjustments. Therefore, reconstructing
> > load_sum from load_avg using the current se_weight(se) in
> > update_cfs_rq_load_avg() may be wrong, as it mixes values computed
> > under different weight conditions.
> >
> > So, I believe directly recording each entity=E2=80=99s load_sum at dequ=
eue
> > time offers a more accurate and consistent approach.
> >
> > Thanks,
> > hupu

