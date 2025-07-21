Return-Path: <linux-kernel+bounces-739798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAECB0CB18
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49B43B5007
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEAF1885A5;
	Mon, 21 Jul 2025 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFh+gNk4"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A222B8B6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753126830; cv=none; b=Cfz7+Fr4nQ+0h8rAycbhA4hL/Nc1dmndDEncRGGcuSQodIpLa1V5zoB74mgxOqfTwOw4GLo5dpaaEEgYfaDhG8EjlLsWYhlrnpKt6LLsHTl3v9H5CGrbRC7gxbSmKHv0AyD6YWRmGA1TjIG15DnQHsXtOQXc08mrD6GeURzytpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753126830; c=relaxed/simple;
	bh=4JDrjRE8BtET/6fP62CkDSrTxe/3NB36kF3Yrdz4k8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7HmF9eZ5kRVvZchz5tozooe0AQ+7JpU8KVzVEALHYlF6Pzv8KbMrQTQ0tpgBT6iy2s7guDZyAwjj1mnpdq0BQPmUu2mwaLN1QS/bSq3ciM769Fs1Uvq3e7Z6DDSsHqWUej4BCEnzI8l+KGpAYZ4y7smQnURoIrO/d+fdLxSx5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CFh+gNk4; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab3855fca3so11151cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753126827; x=1753731627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JDrjRE8BtET/6fP62CkDSrTxe/3NB36kF3Yrdz4k8Q=;
        b=CFh+gNk4rKumczZSECQQJ26vZn2w39NE+s/DzJb+XYohOAz31gfVSJdvnENDesgp/Y
         Stei3icfyEv/hrif5xOFzYFIXC6QFbLv5OS5CVwirNwQ/nizCslIZY9bEohmj5d75mRo
         k2C+r1aj4MfGrwM+yGcYDNZ74t8m5iinb/LU04cmbVmTsGFXhqgV/5i/8j70xzZWgAYC
         wAsuSGXFzNBnyIr6+vjFKzd8O2Bknampq8P6+hgsWwCBtL3WcOeHnKmNoKdTXezHfCIg
         D8os5NAJhP+pmGistnctkP5zZw3ZAQ/bcti4Bq5z5k50EygDSIu4uvyXJeDHyzp7QMq7
         q75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753126827; x=1753731627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JDrjRE8BtET/6fP62CkDSrTxe/3NB36kF3Yrdz4k8Q=;
        b=CQ6ZlCFXLD0b2fnoxx4iOV0Sqt1a3UQnGklT09MwFmqBuBWQ7PRrd6fnoa+zFFzOBY
         cVDA8PLaP/MQBYVD+N9zFVaL3XCAWrzl0Nm0q0hZCk4G7fEQczzqny+Lodoc2Mnwq3vT
         3JhtNYyBhC1V5Z6cltYWo6lo82K0GkNxDhPc5Rp7wDw6By+ZzoANtOAj08LDtzxNMblY
         ltW453mfpnmUgtjeRP24BEgU5tc1j4HmGfbrXPRPYH3kd9aPpupgzM9R6SO2VH/Syboe
         GVVXtgWlV1hU5YteogRhxbqJwwVCiXiN8wwR16BdNQz5O5TffW8B6QpE5kFkZ7WeO2qY
         BRFg==
X-Forwarded-Encrypted: i=1; AJvYcCUnvRYoNGLFnQfHLgpFU8F9755UiuJqtuhj+Nat39hZXZlXbXEXGGvdhpVgU6iUELoMm4pkkVcaWwTXhW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY9s/RKPTliqZe2FudV+YmfELGOL/zGtmD+Ci6mv9xRiNld+3A
	P6Zmxht4UkTmLmDImgP349WkhKIpcau1mrtJHxhhfFTCbyvAvpdzNuI2ouZb+h6kP0pd1ACXSan
	uWrPVpSS5tI7jLPwxEbLxvMRXf8GVX9hTwMaAThdo
X-Gm-Gg: ASbGncu2dWaFKNuKhYsWKMsU+MeX0OLzs6TvsxDpvNNHYsMSA5IocO1AwQZTpV8YS2R
	sRj9Evnu30tKSovtduWSOfYD06glv/A35XK31Uwyl/X3830wugwyfbVk57Shxo4CXTF1oQxrHng
	SHneUiyySiS8vqvAFvO1VFNqclhQrpzE5h1mALV8plbMEA6gKSIijWDBz2NWRk9hJ5x2hW2FnMs
	hA1v6xtOAb95WYytNwnDZjGlzJ3ZPou9GM=
X-Google-Smtp-Source: AGHT+IHhZ/Q9odse8iEE+ykVnyEQGh7tF9pu6B0NkjK6jx9xjQyVNMbjjtLkFvKfUSQY3BgLRw+OXQDQ+gklP/k+dr8=
X-Received: by 2002:a05:622a:2585:b0:49d:88d0:145 with SMTP id
 d75a77b69052e-4ae5d11f8camr595191cf.23.1753126827233; Mon, 21 Jul 2025
 12:40:27 -0700 (PDT)
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
 <CAFivqmKBgYVa6JUh82TS2pO915PUDYZMH+k-5=-0u1-K9-gMMw@mail.gmail.com>
 <aHTOSyhwIAaW_1m1@arm.com> <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
 <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
In-Reply-To: <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
From: Prashant Malani <pmalani@google.com>
Date: Mon, 21 Jul 2025 12:40:15 -0700
X-Gm-Features: Ac12FXxsBuY6hwTVlvh4OhhgMvI7LSFxm292B9-q2fh8UkreETnAl34lqPhMKgY
Message-ID: <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Beata Michalska <beata.michalska@arm.com>, Jie Zhan <zhanjie9@hisilicon.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, Ben Segall <bsegall@google.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

Thanks for looking into this.

On Mon, 21 Jul 2025 at 10:00, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jul 15, 2025 at 8:28=E2=80=AFAM Prashant Malani <pmalani@google.c=
om> wrote:
> >
> > +Sudeep.
> >
> > On Mon, 14 Jul 2025 at 02:31, Beata Michalska <beata.michalska@arm.com>=
 wrote:
> > > So I believe this should be handled in CPUFreq core, if at all.
> > > Would be good to get an input/opinion from the maintainers: Viresh an=
d Rafael.
> >
> > Viresh, Rafael, Sudeep, could you kindly chime in? The unreliability
> > of this frequency
> > measurement method in CPPC is affecting the cached frequency saved by C=
PUFreq,
> > which in turn affects future frequency set calls.
>
> I gather that "the cached frequency saved by CPUFreq" means policy->cur.

Yes, that's right.


>
> > It would be great if we could solve this in CPUFreq core (maybe not
> > rely on the cached frequency while setting the new one [3]?)
>
> I see what you mean now.
>
> Why don't you flag the driver as CPUFREQ_NEED_UPDATE_LIMITS?
>
> That would kind of make sense given how the driver works overall, or
> am I missing anything?

Sounds fine to me (it doesn't fix the lingering accuracy issue, but at
least frequency
setting will get unblocked). I can put together a patch if there are
no objections.

Thanks,

