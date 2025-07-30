Return-Path: <linux-kernel+bounces-750292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CED7B1599A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0E73A3E08
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9758F20E6;
	Wed, 30 Jul 2025 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6BEKRg6"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804481F5423
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753860708; cv=none; b=dMV1zgpXoDJ+B6VGhDk/HwKgg1z6oNJF2O6BUd/aQBezUJdpjRgBH+e5dPDrfmCXWebRXQFBV2urxBWms2k2bCwvNwPflV2cgJitVbfKuhctrmEFkW3PALKllUdEhP2/c5kRyaTpHcTisWMdSuhsZpikzDdF9P/3u4Ro2K6U9O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753860708; c=relaxed/simple;
	bh=RCtMMM6XgxNvf3yX1V7jUGQ4cWFLiZXdFPs6kpBK5k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kh9Y9mW4mKfTimWHzQl5IALYWExwiGsC0oCnbSWviq5YJSMa47iNpff7ofW6OPyfyoS5UHbRTaKhQrlADugP8+AwyKqyhXvdCl7vOzHeHjbkeseLBkR6hZ/0WxaTZO2Ozxx8+CqFaNzdXZ0SRHmWvAKb3+VRTSK3h7C1yDycbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6BEKRg6; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso320051cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753860705; x=1754465505; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=taGUVZn54Sb7/8YVAVSPAtR/Xh7nS0Q82m+kPwJckSI=;
        b=L6BEKRg6jE4NxOBQPe1i7AJOUrJB9K0DYIGKBL3yFgUyFEHreRAI5wNQZ647qzB2ha
         nnMiuCjJg8ahtR9mKPpmRNFuKWT1s8U4UsYPCTbsj+voPl4xzOmle3lzSahMCdsvCopt
         ToGeTcrRPb5BFaG3qFpypiVIrwiVxE9tKOM8wI6zjxxzcGEeREUViBJT1nVG8lBHIW2y
         94sLfF58guvmS6gyuiP4aCGkcWEHsndesxqzw8KIhgKNjucAAtERnXtvK/GwTkWX39WQ
         jT+Dv7jdtXAPzw0Y2m3RtAWGpdVyBp2YKxtiHY6rflVQ3wcWVfSHrG4qE4M+/8fsN98W
         /q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753860705; x=1754465505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=taGUVZn54Sb7/8YVAVSPAtR/Xh7nS0Q82m+kPwJckSI=;
        b=lh5QBYqPH44EEO43PLy5iD2b0V9NZsN0wsy/Q0nAPCrOEc64COYvLY2K0peMeuytkA
         eL0FC0+6iRSohdBJTnsP2xjegGaEK0HBkmhy0VPvWrIVbFV4HbL1ZGT9Ql/89Ws7nJkJ
         v02jCDjsPRN+qoqQ0yqlfqFzXMIqG+aPav9qHDOJc7m5UR7KTQRL+EcrZKaDVwAEVksG
         dOovgL0ONTnyVfSVELanIld7xOMfbJfSs55qPJyjRqLvT0YE8/nj8b4ILkw0O7QGLPDV
         XRrY65WUb/wVyLOKULn8NqjVSGD/7u3WGG3il5FqtulAzxO5UKnuvQgi1uBEWglTQ1/H
         2I2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkW4jZlll2icnu8zLMc4d1Go9yw1BKgA+tELhAjxaDc9ucOmxSUkFkOYndOBNrE81jReCxB64SEesgUuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7NNDjJ+icrLnW8lbDipua+bJLGBWGom9zktf/uyFgBFED5wb6
	kCOM9xfjDeDsQs5Y+Oo32IjG3+/+hn4w2HcZ8n0K4c7hPEMutDTULTP3vXji6nWrCzgWeCFfHXX
	A0Li1QqgS10EoRmj1eEeLRYQS6s9PpoVsTkoRKI6a
X-Gm-Gg: ASbGncufF51aXprqHNkH9KYVbSQHDF8g2vXRR2zkgYx6zXFrkCWbgd4yzTHcWnsEW5V
	Lsa7DfDHWm0GyNHtOHFafNp++rcDeCK1NR+ySoMjLEB4m25gPdHDKpp9xIi0LRAk1BCSh6TvqS2
	imjJRY0oV+8uaBv5dBKVWOuDAOPxBbXUnaf+YyJu/QIqi8mCu0zyLerCoiwPrZ6XLUE1KCsGNiA
	dJcLQ==
X-Google-Smtp-Source: AGHT+IFOAox761YmBm/0UsdXxtW5XXgTXWBlNQe6dcfPOkIEexhAq6o1NxjcDMrSZPMPFCRG7X33gALeaQgNNM5Lcmc=
X-Received: by 2002:ac8:7d47:0:b0:4ae:d2d4:21cc with SMTP id
 d75a77b69052e-4aedf53fd05mr2185641cf.3.1753860704933; Wed, 30 Jul 2025
 00:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ef3f933a-742c-9e8e-9da4-762b33f2de94@hisilicon.com>
 <CAFivqmLCW2waDnJ0nGbjBd5gs+w+DeszPKe0be3VRLVu06-Ytg@mail.gmail.com>
 <CAFivqm+D9mbGku-nZKSUEMcQV5XK_ayarxL9gpV5JyfmhirsPw@mail.gmail.com>
 <aGuGLu2u7iKxR3ul@arm.com> <CAFivqmJL90xsELhz4tPtkYA9vMzS9C=V__nwo=kWJKjKS=mE_Q@mail.gmail.com>
 <CAFivqmKBgYVa6JUh82TS2pO915PUDYZMH+k-5=-0u1-K9-gMMw@mail.gmail.com>
 <aHTOSyhwIAaW_1m1@arm.com> <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
 <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7> <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
In-Reply-To: <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
From: Prashant Malani <pmalani@google.com>
Date: Wed, 30 Jul 2025 00:31:33 -0700
X-Gm-Features: Ac12FXxQZiodhWI_bOWM2KSmw00jzvlZ6_RTTuF3j9DWwSAaillUswPC4ftFKyE
Message-ID: <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Beata Michalska <beata.michalska@arm.com>, 
	Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Content-Type: text/plain; charset="UTF-8"

Sorry for restarting this thread, but I think the solution submitted
solves the write path. The read path still needs addressing.

As such, given the limitations and scheduler uncertainties
around the reads of the FFH registers, I think the patch in this
thread is still a good optimization to include; namely, if we know
the CPU is idle, don't bother trying to wake up that CPU just to
calculate frequency.


On Mon, 21 Jul 2025 at 23:02, Prashant Malani <pmalani@google.com> wrote:
>
> Hi Viresh and Rafael,
>
> Thank you for taking the time to look at this series.
>
> On Mon, 21 Jul 2025 at 20:27, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 21-07-25, 12:40, Prashant Malani wrote:
> > > On Mon, 21 Jul 2025 at 10:00, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > Why don't you flag the driver as CPUFREQ_NEED_UPDATE_LIMITS?
> > > >
> > > > That would kind of make sense given how the driver works overall, or
> > > > am I missing anything?
> >
> > +1
>
> Thanks, I posted [1] which implements what's suggested by Rafael. PTAL
>
> Best regards,
>
> [1] https://lore.kernel.org/linux-pm/20250722055611.130574-2-pmalani@google.com/
>
> --
> -Prashant



-- 
-Prashant

