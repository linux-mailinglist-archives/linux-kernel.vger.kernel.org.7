Return-Path: <linux-kernel+bounces-753754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EA6B18763
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2941A86EB8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F0428CF64;
	Fri,  1 Aug 2025 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HkOjFqde"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8D11D5CE5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754073281; cv=none; b=bxDI014m5stEsC3Kz/j+cr9mDDKSCygE6uJBpxs8YR2CCfA9PJs60+Rq7vTyPH3QyVjpb/r3qYN6eblZEzZcZDg997RX5x1gOiWagw5W0c4bvBdYoPM14BqTWJEA6Gv9kAfzSS+5aFZCN2FBXSqlnIrrQNpGW5vFcwg6Y9XP94c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754073281; c=relaxed/simple;
	bh=J9Uezt1KrvKt0VBMAu93Dhjj2nVy4+h2IC0utohZLA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ck6vFlO4boD24938iN45ZiXHFtpDSP2xQmJL1qt1nGcOJeKsgw6C8/yJpuXCEbRF85W423S+z5WJrGQcVbfpwIs829tWRUdBW8B8WQ7n7ER4H4GOrFhez6B/O0Xj+vxy4qGDDS4R6L9ICIodZo7M9fSgl9Nxn/y6RuTIxXD0AA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HkOjFqde; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-33243562752so8389021fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 11:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754073278; x=1754678078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfmmilxacBNB3HQuUVitVRIgdZJYz2bsJ5WOyUMIET8=;
        b=HkOjFqde3omlKJNrpmTKuXZbHAUhmGeVFYuxAw/FNUq/uo/a+ZalMREgwevRasWk/1
         HOBLkT0KPx9sSQX/JnZe8YP1RJrvwf/m+sgzAWOJ9C+nwexfH3E2yoViwCNqpkBKEnnq
         OeHEQ5Pc19NiKMONGXhYYuo3Z1XgF2wBlR92Lh5jWAFxEsacoRngKhU3io3vtr3Ehgwp
         lfd/P1AINLIgZBEcLZWWl9V/Au4e2c12/l3voTlcQfKvc0+YUZSg00VV9FYh9b6WMNl6
         MNtXicaIqUJzwuTHjrr1HR2IKhIAwOYGzUkBRi3IyEMjH0lcJ1XP7esLeCS7cSA1uglu
         PEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754073278; x=1754678078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfmmilxacBNB3HQuUVitVRIgdZJYz2bsJ5WOyUMIET8=;
        b=c2QtIPm9aw0rhl+/kAZVSDjfic8i2woQzFubM3wheYTOcs0arJf9+veVbuUwqM1v0h
         liZbW9uJqZMEHRQFOb7lIiRKFDzq9j3EiHJOPexZParAY6zYhICT+aCHUxMe2vkx1+xz
         p+HSLA+mfTqVXD/4KsC+AKdjetaZ1cxFPXqax0t6yxDdvsnt4PUME6/flE3RZCDItl47
         Onco/vHCPQGUIajaBpn1+S7kbPp4+Z5EDWXs7xrVOySqQ15/t9KxLC60TSn+XzZOGyqb
         BvA7nhmxmtYLlwa6ZVzEAhrWrK6LBmqI5cG7KifFluUNBPsLA0cNrWihoKgd7s7bqPHC
         W1sg==
X-Gm-Message-State: AOJu0YzNeGonTnjEAs2ARNo4omMqIh2gM+/KSH07d74puGiyZtpyAuQz
	IJgT3CP1VOzzzXHQAfv0SopJR+Hzxqc2BIMGTq+6iPOjrEUFrxIxX6oexLC/qKAU9zQ5Y2kEtEa
	Cv5aoc1xfasmBY3gFRqxGrJPllK1PIbGyL2WRv1M=
X-Gm-Gg: ASbGncusqOPD2adgdhgLSQwTe/XIkrVqbs6qgKSIODdYqb+R+N3Gq8l7YxSx5n2Mdp4
	z2UefSohyJmDtQvyx4N9Q7g7Mp7kki49VYN3Dwf4o8s1fwZbP9UiCluqIWM5Liu6hD8+xtDMHYD
	if7OZn3V0Mc+9D9N30IdjelM6MG6hq//MFW2CWi2Qh2ZDnWa4odvx116tZ333szsKYOwevcCKvw
	fb8qoY5A0XpVvevC6ZSdG1WKVnUr+ZgmnwE
X-Google-Smtp-Source: AGHT+IFPrpz3YlLTmy9cZZYTjMyKs1oACsMLtHEmi8MsbB6UmvWxU3JCLYrnFV2pZYPjyaD5Q0TTQdIqF+07Z6GOzQQ=
X-Received: by 2002:a05:651c:4003:b0:32c:a006:2a36 with SMTP id
 38308e7fff4ca-332567a28fbmr658461fa.20.1754073277439; Fri, 01 Aug 2025
 11:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68894443.a00a0220.26d0e1.0015.GAE@google.com> <20250731201337.274382-1-jstultz@google.com>
 <2812bdc6-8d7e-48a3-8f5b-a26cd5d18c32@amd.com>
In-Reply-To: <2812bdc6-8d7e-48a3-8f5b-a26cd5d18c32@amd.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 1 Aug 2025 11:34:26 -0700
X-Gm-Features: Ac12FXyDY8rQ-T1hgnVdu7ufq1UAYgfIRJxqNSHSNJPV0SOE_5MSe4NCClZEdvM
Message-ID: <CANDhNCrgxP+Ujvgpvd_0e5TM5Q-UTGfNmv=Lu3kn2MZ6wdS4Kw@mail.gmail.com>
Subject: Re: [RFC][PATCH] locking: Fix __clear_task_blocked_on() warning from
 __ww_mutex_wound() path
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	syzbot+602c4720aed62576cd79@syzkaller.appspotmail.com, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <valentin.schneider@arm.com>, Suleiman Souhlal <suleiman@google.com>, airlied@gmail.com, 
	mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de, 
	dri-devel@lists.freedesktop.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 10:09=E2=80=AFPM K Prateek Nayak <kprateek.nayak@am=
d.com> wrote:
> At the very least I think we should make a local copy of "p->blocked_on"
> to see a consistent view throughout __clear_task_blocked_on() - task eith=
er
> sees it is blocked on the mutex and clear "p->blocked_on", or it sees it =
is
> blocked on nothing and still clears "p->blocked_on".
>
> (Tested lightly with syzbot's C reproducer)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 02c340450469..f35d93cca64f 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2165,6 +2165,8 @@ static inline void set_task_blocked_on(struct task_=
struct *p, struct mutex *m)
>  static inline void __clear_task_blocked_on(struct task_struct *p, struct=
 mutex *m)
>  {
>         if (m) {
> +               struct mutex *blocked_on =3D p->blocked_on;
> +
>                 /* Currently we serialize blocked_on under the mutex::wai=
t_lock */
>                 lockdep_assert_held_once(&m->wait_lock);
>                 /*
> @@ -2172,7 +2174,7 @@ static inline void __clear_task_blocked_on(struct t=
ask_struct *p, struct mutex *
>                  * blocked_on relationships, but make sure we are not
>                  * clearing the relationship with a different lock.
>                  */
> -               WARN_ON_ONCE(m && p->blocked_on && p->blocked_on !=3D m);
> +               WARN_ON_ONCE(m && blocked_on && blocked_on !=3D m);
>         }
>         p->blocked_on =3D NULL;
>  }
> ---
>
> End result is the same, only that we avoid an unnecessary splat in this
> very unlikely case and save ourselves some head scratching later :)

Good point. Thanks for suggesting this! I'll rework to include both
this and Maarten's suggestions.

Thank you for the feedback!
-john

