Return-Path: <linux-kernel+bounces-853933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBA4BDD145
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E12B50711A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1147C320CA7;
	Wed, 15 Oct 2025 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifNoOFJl"
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4177D313546
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512841; cv=none; b=PcDk47VSkptw0Hf5VJEDUEWVt/eMLgYys15bxC4Wj4T71jQylmCLQBc1YTAjVe7QYnIkaTj6UZDcoKoAXgOPgIgCEGFHJNVXzFWzThu9Dp5yfrpb7bB/QCJY7HXdu8hySTwjzffOWLV5GTserQum2X8fqpbeeypYrvzcziB6gmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512841; c=relaxed/simple;
	bh=6lqluqH+z/VyjPwuW8kFcg9G/dys9mylX9ORh/yFg4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rw3AxtLbHybbuuL3AroA9ZWTsM1bJu0aFNbLhnkrMQMTosIpJDA1xuluyUISqznhksjJ7KeNk8brAa7n+KR5VpSfe3j7QME4AsO4IaUi86sngSkls+olCNhid/1EgHPmPRnI6mVfGPtM32ln/xdrX7rBK4QtnoKeyPaJuJ7BRcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifNoOFJl; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-591c74fd958so1205649e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760512837; x=1761117637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fa+MAfHD21e+fVopGVhPH7h+1E/h7JpYddBoy63nok8=;
        b=ifNoOFJlStKLvJ11vYG4TutHLBPeVimDqc/pFBrONSZRXUDnPgXwRsmK7NMmKjQn62
         7TdmDO4JdvRuRGx/ckM2dI0EvIUs9R1kppNFJIJtVSk/4jjYdXf+Foum0CyvWG4y3dAl
         3V4LshcmPqMI3e7DwH+WFOmbMf4BGuSK8EZ1nrMebwFMZWjdfMURMkz1FUhqg2xoHpbj
         P5HaBDwZDXOtgFaSw6dzjZPwqmaXeQiR4OXZjPmxX90ZLoYZmdVZI11fjHxPbhqCrEsQ
         BVazegx0Q7g+icVQMlGSiiZSv3MJFQAnaIFYErZ1DLoZiJ7cJgeGpzmL/in+X+Yr/z4R
         +fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760512837; x=1761117637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa+MAfHD21e+fVopGVhPH7h+1E/h7JpYddBoy63nok8=;
        b=hDSxC3OlmLHlgi+fNJ5oJmpgYge8djHorJ2YYMxulWcAy+O1br+TLocIoSh/2tH0R8
         vGEDX4j2SWBku5pUJcKXQb81oEZVFC+9I0ajZEaJI0h82IOFxLAFKHdq4AYs2KbF9GV1
         UGFSOjQyDzraQqbQQ6mnHYbdluOoOid4WkPbvkXIm9wPmuYabNMOFw5ltZ2Ux8UHER7l
         YCQUOIl+OHwiLmogjXpas6aGJl7E4gYOmV5XvJtVwSFtFGnbMX5mbcy12Xos/2VkGp1F
         oA6cIHC0WU1lVWIIbSh+fYqciXwCY+cjnGAMItDGP69Drlbu1KYbo6sxSNvrFKBG64zI
         xGyg==
X-Forwarded-Encrypted: i=1; AJvYcCUx24Qpd9gI7PqnjIpKIxejfsdColInUP/iTl5Ba4GadWNrIKXuTdjJ7V3p9BnlhPqGhAcIQf2Mh7tKrKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyZhD8DnTQHQyIyAxpjuIZwGc9wfv8wj+8LIh6YW1lg16Z9Ju6
	GQI4vCrP0+xpmLP9nIj7DBw0TsA2UBejQSHFhlEHXp/rzhJLgK3rzTHnRSxhU0r++eSCvhvT6dH
	3CQ3VZqcsw8NE/M+tZ7lX2kuxdKO9sL0=
X-Gm-Gg: ASbGncvBgHWeIWERhLWU+WTRvmrk5L8NY3fE51+aXoMgvTWrzgyA4LuYCid8TdHJWn2
	hxv1g0ojaZ6gsKl5tiBMQFgvwV1esDI8OpRmrHLpgrbAL9KjhQf5nW0VmK2Wm5k7O6ze0a8UnQ0
	skw41/GSCRFPk66yOBQ+SpLcemF+04+uVEW0DqQbEAz8Wl/rwM3zxTYGVXeCSguzqSh5kobVpPc
	uCfIw4HUfVDLcDPfFgxLn1tLAhIN+fWJ6hw+g==
X-Google-Smtp-Source: AGHT+IGwTCGfbLafxynSYznPA0CGk4amjqXHZQVgtJA+UYnMDLlO9Ymxz0Kg9RgvOke6NkVhrOuhqKLTwkMRW8DPEJA=
X-Received: by 2002:a05:6512:3dac:b0:57a:f38a:39ad with SMTP id
 2adb3069b0e04-5906dc0f524mr8148099e87.14.1760512836967; Wed, 15 Oct 2025
 00:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910084316.356169-1-hupu.gm@gmail.com> <1081f8ca-3c1b-46fe-a7d4-31303e5e2298@arm.com>
 <CADHxFxQTGRHuu82YK25UCcF2NCxyU_HrFik-jKY23eUMTfft7Q@mail.gmail.com> <CADHxFxT_x-GanuxSrWP+tvEC87bf=z+ZkwSBnwomU282MJx0sg@mail.gmail.com>
In-Reply-To: <CADHxFxT_x-GanuxSrWP+tvEC87bf=z+ZkwSBnwomU282MJx0sg@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Wed, 15 Oct 2025 15:20:25 +0800
X-Gm-Features: AS18NWCSrf83zz84D0AT6NOxu_rXg3U40l8uEUMavNb0zPfrm_tzC75Um-IrzT8
Message-ID: <CADHxFxTUvx4VvOizfhg7jeyenN7m+YX9Oro+ndPQ1sr_Y3d1Ag@mail.gmail.com>
Subject: Re: [RESEND][RFC] sched: Introduce removed.load_sum for precise load propagation
To: Pierre Gondois <pierre.gondois@arm.com>, vincent.guittot@linaro.org
Cc: peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com, 
	rostedt@goodmis.org, dietmar.eggemann@arm.com, vschneid@redhat.com, 
	bsegall@google.com, linux-kernel@vger.kernel.org, mgorman@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vincent Guittot, Pierre Gondois, and fellow maintainers,

This PATCH has been pending for several days without any feedback.
Please allow me to RESEND this as a gentle reminder.

Thanks,
hupu


On Sat, Oct 11, 2025 at 10:27=E2=80=AFAM hupu <hupu.gm@gmail.com> wrote:
>
> Hi Pierre Gondois,
> Just wanted to mention a small detail that=E2=80=99s easy to miss.
>
> On Fri, Oct 10, 2025 at 7:37=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
> > > It is possible to compute load_sum value without the runnable_signal,=
 cf.
> > > 40f5aa4c5eae ("sched/pelt: Fix attach_entity_load_avg() corner case")
> > > https://lore.kernel.org/all/20220414090229.342-1-kuyo.chang@mediatek.=
com/T/#u
> > >
> > > I.e.:
> > > +       se->avg.load_sum =3D se->avg.load_avg * divider;
> > > +       if (se_weight(se) < se->avg.load_sum)
> > > +               se->avg.load_sum =3D div_u64(se->avg.load_sum, se_wei=
ght(se));
> > > +       else
> > > +               se->avg.load_sum =3D 1;
> > >
> > > As a side note, as a counterpart of the above patch, the lower the ni=
ceness,
> > > the lower the weight (in sched_prio_to_weight[]) and the lower the ta=
sk
> > > load signal.
> > > This means that the unweighted load_sum value looses granularity.
> > > E.g.:
> > > A task with weight=3D15 can have load_avg values in [0:15]. So all th=
e values
> > > for load_sum in the range [X * (47742/15) : (X + 1) * (47742/15)]
> > > are floored to load_avg=3DX, but load_sum is not reset when computing
> > > load_avg.
> > > attach_entity_load_avg() however resets load_sum to X * (47742/15).
> > >
> >
> > From a mathematical perspective, deriving load_sum from load_avg is
> > indeed feasible.
> >
> > However, as you pointed out, integer arithmetic may introduce
> > significant quantization errors, particularly for tasks with low
> > weights.
> >
> > For instance, if a task=E2=80=99s weight is 15 and its load_sum values =
are
> > 3183 and 6364 respectively, both would result in the same load_avg =3D =
1
> > under this method =E2=80=94 resulting in an error of 6364 - 3183 =3D 31=
81. This
> > error increases as the task=E2=80=99s weight decreases.
> >
> > Therefore, I believe that recomputing the propagated load_sum from
> > load_avg within update_cfs_rq_load_avg() is not an ideal approach.
> > Instead, my proposal is to record the load_sum of dequeued tasks
> > directly in cfs_rq->removed, rather than inferring it indirectly from
> > other signals such as runnable_sum or load_avg.
> >
>
> In addition, weight is a historical variable that may change over time
> due to dynamic priority adjustments. Therefore, reconstructing
> load_sum from load_avg using the current se_weight(se) in
> update_cfs_rq_load_avg() may be wrong, as it mixes values computed
> under different weight conditions.
>
> So, I believe directly recording each entity=E2=80=99s load_sum at dequeu=
e
> time offers a more accurate and consistent approach.
>
> Thanks,
> hupu

