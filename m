Return-Path: <linux-kernel+bounces-823546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D3FB86CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A1D16D149
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B603074BE;
	Thu, 18 Sep 2025 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cNWNJfrI"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C6C28467B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225557; cv=none; b=QpbZUBd19PNoQkEkf6WrOSAa0gZr1Z0fjnujbw/yllg/oKCL0wV3PDBiLhxrNc4nvbgdB+kn6qYsjBcw2rCEC6eaZy5ETMarggGQaQJC3bfcIf5oeOHYh3woHKUkdvlUuVFSmUlCtTSlFiK2GM2YQZA+Qz6kR0q1vtgtow4vrlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225557; c=relaxed/simple;
	bh=EvA+JOB1Sc/EJSfgF95z/K4aIP9qgcCGP7pXxQSU3Dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngPMgo2Qps9kT70bMo4WedEg1vWe5xHHoKMD9K9mU67oCuWCZjnbF5fl6A3kfzbjnMg1acInisAPoquOSVUimz1DTrTFtYPODRfdfJJcEl+Gdy3AVZdFDCJp3O/vukZjvlA+2BA5cAPMnZ05PLQzfXMvOn2x5edXPxUdbOpSatU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cNWNJfrI; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-576d8b85ed1so1636221e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758225553; x=1758830353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtNoL77tzU0Gg0o+h1+Y23ap7ycvDPX7rTVkf7YbgDw=;
        b=cNWNJfrIx5USz26tZ76L5h+v4eOsSbthm+IQ8Tix+ABS96hYIt3VbJmvlu80DS21UI
         z34qL1KE+lJtqKgYovULXlGmlO0MCSaQQggtVmx1SO1ZHHOrNvCHMujCQIsm002b8/AE
         qIZydjtv4F7wgP8qESzkLA5cKhUJ3y+pHhgvYNa+bDM0VK0uAdmsvJh8zm6RBTeVU8Va
         iV0n00bbS6NRoXNspfEZjFPjjgTVECmWcvoXE/djOWMokg3HL2KF7N8i5hF3KdYDUoux
         zh9CvDyecmuZxTCBvhqFwTRIbYGNJm1fhRtpe5868P7JHUoH+q6nGki3NvQm9Qtb1roS
         OKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758225553; x=1758830353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtNoL77tzU0Gg0o+h1+Y23ap7ycvDPX7rTVkf7YbgDw=;
        b=QjXHf9q14gvnlGBttE3a/PedxtTbi9nXe1w8qXVrGAARLC3J5sjC+2dnEr5juMppJi
         Jqk33jcZbD5rcA92wvqPrWL5Ks///5yku3AJmZbUMqnN0NTDt0i1iLsvis0FlozbVNVk
         YA/TOyV+u3yDa4gmWchIIJfahyAHkiiT2QxCLpkN4cD/6tcuu+9z6IqMSoSWBO57h9jH
         7+lmFdpeS2kA3aDA2gDLL7xPQkCo7U+dnFfSdaVQbVX5gMfQ6HQbolYbQCgZVl0cs0BB
         Iwd6zEvZedq5jY+yZbD4B5Ar9Kem9gYs9NS+3cYXTROjutnV22XWCS0UNh7DzISlei/Z
         gVKw==
X-Gm-Message-State: AOJu0YwzNVBsPfRLUua08KVxoKpN/Q/K90IU27+0G+6DZEqGH5Glm9Ng
	9OzO/EUvQoOdCoUEMHlg2FRh/mhp7v6BXPb4B9W2Tfo2CZWigp47xQauw+yQPoHeM7knKaedKt+
	un7yeu7wSOE76glmZW9xmjJqmQTgxsEW+4rWV6YE=
X-Gm-Gg: ASbGncvuhnYwwqEM8wBJ/VGGXN13HWRykwPHdOx508P19wamIzH4gsbjW0SK4WV8RAL
	eLuSAa4du0xIoz04JqJ5n0eKqlJaRE0UbGJQ8EP2cwxZyoovMsWUzhGCs+fj5RjgSjcPD/6COvG
	T25cKGt/3mRHqVWb3Nl9cXWrDxYob77jcF264La1jcXBSC8xSwcWa60hbmvORrTM9P4WGJmIBbH
	0PsSgBjoFiwoye2BnBGigOtSGRl34FEuCaXsQrx9B6EpmEyn6x4UCv7TLCj/Q==
X-Google-Smtp-Source: AGHT+IHHgrArk5PTYFnIHGt3jrE7rzNyJHhcfbdAeHNCvYAA3SG1TAo9N3iwjA1TcZzZYm12BlWQne5T4JEtfxZiiCQ=
X-Received: by 2002:a05:6512:3096:b0:571:8c5d:1761 with SMTP id
 2adb3069b0e04-579dfccaddcmr297685e87.1.1758225552480; Thu, 18 Sep 2025
 12:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904002201.971268-1-jstultz@google.com> <20250904002201.971268-2-jstultz@google.com>
 <a6c0b576-393d-4283-86ab-5c88c22ebdc3@amd.com>
In-Reply-To: <a6c0b576-393d-4283-86ab-5c88c22ebdc3@amd.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 18 Sep 2025 12:58:59 -0700
X-Gm-Features: AS18NWBy9-9rE0WiT97WQr3USz8DO8PcxfLtQQqZuq8y7loP3_XQcSMedI59H1k
Message-ID: <CANDhNCpJaE4Y=SvvMFFM90uLkabBygGnfqAfL1YH=JDXTSEVmg@mail.gmail.com>
Subject: Re: [RESEND][PATCH v21 1/6] locking: Add task::blocked_lock to
 serialize blocked_on state
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
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

On Thu, Sep 11, 2025 at 10:50=E2=80=AFPM 'K Prateek Nayak' via kernel-team
<kernel-team@android.com> wrote:
> On 9/4/2025 5:51 AM, John Stultz wrote:
> > @@ -693,25 +697,30 @@ __mutex_lock_common(struct mutex *lock, unsigned =
int state, unsigned int subclas
> >                       break;
> >
> >               if (first) {
> > -                     trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_=
SPIN);
> > +                     bool opt_acquired;
> > +
> >                       /*
> >                        * mutex_optimistic_spin() can call schedule(), s=
o
> > -                      * clear blocked on so we don't become unselectab=
le
> > +                      * we need to release these locks before calling =
it,
> > +                      * and clear blocked on so we don't become unsele=
ctable
> >                        * to run.
> >                        */
> > -                     clear_task_blocked_on(current, lock);
> > -                     if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
> > +                     __clear_task_blocked_on(current, lock);
> > +                     raw_spin_unlock(&current->blocked_lock);
> > +                     raw_spin_unlock_irqrestore(&lock->wait_lock, flag=
s);
> > +                     trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_=
SPIN);
> > +                     opt_acquired =3D mutex_optimistic_spin(lock, ww_c=
tx, &waiter);
> > +                     raw_spin_lock_irqsave(&lock->wait_lock, flags);
> > +                     raw_spin_lock(&current->blocked_lock);
> > +                     __set_task_blocked_on(current, lock);
> > +                     if (opt_acquired)
> >                               break;
>
> nit. Is there any reason for setting the blocked state before the break
> other than for symmetry? The blocked_lock is held and we'll soon clear
> it after the break anyways so does it have any other subtle purpose?

So, basically yes, it's for symmetry, and trying to avoid subtlety
where I've found it's easy to confuse myself.

At this point in the patch series, as we don't prevent double-clears,
I guess it could be moved below the break, without much impact.
However, after the "Add blocked_on_state" patch, we do enforce that we
we don't clear cleared values, and we manage the blocked_on_state
separately here, so at that point we'd have to put it back or loosen
the constraint checking. So I think leaving it here seems the most
sensible.

> Also super silly but that above block is too dense. Can we add some
> spaces in between, groping the relevant ops, to make it easier on the
> eyes :)

Sure! Done!

> Apart from those nit picks, I don't see anything out of the place.
> Feel free to include:
>
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
>

Thanks so much again for your review and feedback!
-john

