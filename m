Return-Path: <linux-kernel+bounces-722794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C70EAFDEE5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879E3568184
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605ED267732;
	Wed,  9 Jul 2025 04:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ToYUp0XM"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F233D81ACA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 04:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752036644; cv=none; b=WxPl8OXNGub0Gf2vPYSAVQ1M1LtAL6doQkl6GF5slFtqfqi/vlEY2AVV9wofm7CprC8Thpplrvy/sRpGd6nmsiJa/vSKNoDQJ9Scumnc+/hZDVloQ/hy3II2kLtE6CT6f+TdNT6UQ3tEs43GLV4dOtIH9k4bYA6anufCUMy0VA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752036644; c=relaxed/simple;
	bh=lqaRMEXbVBF+CLbIv3pPI0poM3ycjX9wGYE27NuXjXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePZJuCUur2sPJUm1zPJkxQWSpJEzQXAdi5F3OKeCAwsB38YbxqvyzMcLXEFjMKHmCDouGtaeCALYU2X5rA9P6i3/baMvShZfy8dTNyKLqYNkShHkouo9m8ZE0l0Xm/n8PJyB5cn2hFC5cHFeLWiW2SMlurGeydErjCzDiXrYDXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ToYUp0XM; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-553d52cb80dso534590e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 21:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752036640; x=1752641440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaKAzFcRKeUdfNmlqluJdj1h6D509eypTRTaQO+D1S8=;
        b=ToYUp0XMHwBbowNKJt+T0GII1BW5sHdo6Vw7TUS7O4saWa/ghUJ2H3Ni0GWQ5OIPdH
         50vAgH681SXgrkhwUqI85IOCQpLwmpa/l8KGymHrtTXXEiLIu5dPGz+PwDobbcZIT7vy
         ooMSi3KClL1scMRJgPSCwslTDrQN7fzE/uzR1GcqbKgdQVrPi7iHHd7EHr6eWeyDZRcd
         gTRiUS2h7Wycgoa3s7Wu0ADZasMDjM1iiLg96W5+n0VpoTXrCEFkhzaBPc4mtqzA+0YF
         Oo4J31EtsFpU+/avKfiMmwUooBf17wgmrdDnN1kLpOVtKvB/ebiRYIa7CepMO8wyw2Ex
         wuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752036640; x=1752641440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaKAzFcRKeUdfNmlqluJdj1h6D509eypTRTaQO+D1S8=;
        b=AdjQasq8HAik/fDijd+zzO+xidi+Bcb/mUvxZOwtw7gf1dbbHl7CCbPC6mM6jJxcFe
         TE3oGigKy0FskCLIworzit1KpiHpwBCVWBe0rU/+RNAZtpjKkerfc69zzActB9JjIiTC
         1GLPSaoZRmLmN90wi7quxCSSqM7evWiBMaGKNmoza9/XbBx01pru8GsWuoVZUIqjz89M
         Hy8/tByGLdg1AC3LKx++DSZvBXD33t6WZYHx13viTYnIMtTHP5MNKtock1NN7wADJ2s9
         q1YE6Vnd0nqaM60mFd4r9ve/vAubKJ+6cL5xVhfMYNPtg80eVo4Xpwn9/tR0Ss7cS3u5
         MN2A==
X-Gm-Message-State: AOJu0YzcJyAFo3E59Bcn5PLsF5DjVaUeF+jWzrcnVTYJQwZse8bwAm3g
	PogHyDjHO+uZkEemjsWWmSe01IrRKeL4b8URxpKGcGKJsj85hNx6DXJUB6zWllC3nQe3Mz7VQV8
	ubm9TMF4rFGMPssfas7/hjpGv9r+5FFTHqEhMGVawKC5iuEcsG+Tm
X-Gm-Gg: ASbGncuBLwViMP3QzPEI8tlJm/zVN4etOkQ1eAs+J7mOW94Akzo+hLcDFdeGvapRx6c
	swY7AQJSYrTFLih6DmRbj6Iyt8+1jpDUFDM9dVtOu7aD/wfSZvy/WPbtP85o73aWsj/RerV2bWa
	wq1X0sRAhKkDRGK8JHR9z/OyRe9dIwAjhNAz1IWvmsP8yNFNVdhiGPcNQJ0q9my7v40UvTAFsO
X-Google-Smtp-Source: AGHT+IHmgi8/3nW5F4sD7pgHARX/kPCN5DpgTjIIPVkSJIFNwmV3Oh3V7gAQGdHD/ebasqNRr8urrVNBeQbwDosRCOI=
X-Received: by 2002:a05:6512:401f:b0:553:2c01:ff4a with SMTP id
 2adb3069b0e04-557f899b164mr1860665e87.3.1752036639678; Tue, 08 Jul 2025
 21:50:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707204409.1028494-1-jstultz@google.com> <20250707204409.1028494-4-jstultz@google.com>
 <c4b23568-8513-4bb8-b278-e4bbb8e4424e@amd.com>
In-Reply-To: <c4b23568-8513-4bb8-b278-e4bbb8e4424e@amd.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 8 Jul 2025 21:50:27 -0700
X-Gm-Features: Ac12FXz0XeOj5kxuMtZHSDle-6Ptbhj8d_VnwyoVvex7SfSlPw0_reWxppX73wY
Message-ID: <CANDhNCqRx7tpJXobHTP1uv=zf_8zarZpusA_1K9--LXm_2DXOg@mail.gmail.com>
Subject: Re: [RESEND][PATCH v18 3/8] locking/mutex: Add p->blocked_on wrappers
 for correctness checks
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Valentin Schneider <valentin.schneider@arm.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>, 
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 11:44=E2=80=AFPM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
> On 7/8/2025 2:13 AM, John Stultz wrote:
> > @@ -2177,6 +2178,57 @@ extern int __cond_resched_rwlock_write(rwlock_t =
*lock);
> >       __cond_resched_rwlock_write(lock);                               =
       \
> >  })
> >
> > +static inline void __set_task_blocked_on(struct task_struct *p, struct=
 mutex *m)
> > +{
> > +     WARN_ON_ONCE(!m);
> > +     /* The task should only be setting itself as blocked */
> > +     WARN_ON_ONCE(p !=3D current);
> > +     /* Currently we serialize blocked_on under the mutex::wait_lock *=
/
> > +     lockdep_assert_held_once(&m->wait_lock);
>
> Sorry I didn't catch this earlier but building this with PREEMPT_RT fails
> with the following error:
...
> @@ -338,12 +339,14 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
>                  * wakeup pending to re-read the wounded state.
>                  */
>                 if (owner !=3D current) {
> +#ifndef WW_RT
>                         /*
>                          * When waking up the task to wound, be sure to c=
lear the
>                          * blocked_on pointer. Otherwise we can see circu=
lar
>                          * blocked_on relationships that can't resolve.
>                          */
>                         __clear_task_blocked_on(owner, lock);
> +#endif
>                         wake_q_add(wake_q, owner);
>                 }
>                 return true;
> ---
>
> I'll make sure to give the PREEMPT_RT build a spin next time around.
> Sorry for the oversight.

No no, thank you for letting me know! Very much appreciate the detailed tes=
ting!

Between PROXY_EXEC, SMP and PREEMPT_RT, there's a fair number of
relevant combinations to test, and I've only done so in an ad-hoc
fashion (and I'm sure I'm still missing some).
So I've added a few defconfigs along with a build script to my full
tree so I can better automate build testing across all the patches in
the series, so this hopefully doesn't bite me again.
(Though let me know if you find something else, as I probably will
need to add another defconfig to test).

I've also tried to rework your suggestion above a little more deeply
into the helper logic so we don't have as many ifdefs in the
functions.  It unfortunately touches a lot of the patch series so its
been slow going in getting all the changes in the most sensible spots.

I'll continue testing and refining the changes locally and if there's
no other feedback on the series I'll send out a v19 near the end of
the week.

thanks
-john

