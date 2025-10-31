Return-Path: <linux-kernel+bounces-879448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5B7C2322F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440311A62844
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895C019E7D1;
	Fri, 31 Oct 2025 03:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PWJu3fy0"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB5C34D392
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761880546; cv=none; b=hZUt54+Jj88+U73TkRf0W7Lv2mbL3LMzJJsyIO6EsnfXrxktA3q5vMjy+dJ0BZ2whUjENg+IliCML6fD1n01lHwEGPL/TAh/n7IONZpihLM/U74LVvNZtwlT0NHja255hejyoXC0KNZ4SXuiHKwd8j44/RyTPbgjG+3w7h/eBY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761880546; c=relaxed/simple;
	bh=hTF8I4m79xiczqO6fuhQSNorZvDRiywTBfa7LPULZy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thBsn4QIIdqn2ivffxpmSznQNwjn+kk+o3uGknKuEEm9MpRat+infFJ4WkhcdQr8pTestFD32cHebJrnmuiVKUYfG5lfnHQ3hfYZ2JMsc3buJO07U2pUuVZmJ6xDUOvuu+WsKPSKlPxlFRVBLvnO9bu1bfpPRuFJv0METE1AOIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PWJu3fy0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b704db3686cso390341566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761880543; x=1762485343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUMsbJjw2LYm+K9mdQ7PoZCRcsUfduyYj0fklKyk9B8=;
        b=PWJu3fy09Gxo48kq0bYaeSB3fAoYnLIVGx8/r0uZK9KH0wI1C9bkwGPsc8PIFc38rt
         FbDOmVqUDdpDEzP0pl5LrqjdbVZvNaGHELNhzOOD8aCJadnQKNEs7KSpJAF7BwGsWCsT
         vlgIrsD3C6u44seJGvDbDAU9Yr5Y15Fkr+64i1MBWvYxz/7YfQsY/nwiNjq1terU8xNj
         3k3SnW3uokxM/mMmGQiXcr38k9beuY+IoKFZ81qSJA3SbAJ49yzmtjRpedn0J+BBZy2z
         R/r1BifHfBjlRYXXZReUuarxIgtVXet6qY2kZF3WQycYGAkvagYKITE4ZBYIcWJLLldK
         sq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761880543; x=1762485343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUMsbJjw2LYm+K9mdQ7PoZCRcsUfduyYj0fklKyk9B8=;
        b=FJeCALb/IFs+OQUmoTQnm3IZUUN7XS1LTQBpSEdPm0rIAPKndne9SsqWE+jFUqH8at
         eeDkLlhoKT2sT9TTz05FRhw1oxDhbKbn0hqhnCqJxMa9XatWmg5eO6zI+PRBIjYFTiMK
         HkBLES0uAiNILSlIhvFWkNXMmG7/S4By/+PKZ5ffPxCwbsb/dlziq70/xTGnCDx4MrNz
         TqfrDSQi4Vld7+Q7qKYnd2CMmrzSMdyYiLp3krbR9maSA0w5MR+5BHuxKSqcJ9IOkutI
         MYoAPWsH0biMneDVlph+jCoKvCsLtjyGoMfJDr7ztuv250X9i57xOnR8vh7NYrbcfX47
         rirQ==
X-Gm-Message-State: AOJu0YwSnjcrz/KIUHf5Q2oGe82i97/6wOhfNALOK+a6ZYz8wNncYOBr
	QtZ7il6fRtbLenqUwE92jmfmFlSasC+rPWOLYPIAgE0ItcG3AnM4yuUiUzeOl5Xnb/V/Obc6NuV
	bmbO9frC0sGmzu3bUBaqXbL9YvsxPO0Jo0GSHkpA=
X-Gm-Gg: ASbGnctoFnwhfgbcWKo2RR9zF28EmBkomW4jg7eBTxRXUOqdnQHeC32+OZoQGXICTn0
	ARxWJwCv63r/+aTLB6tinbmlvGn7yEBvB8eNMbGdjH5LsKa2qi1mA8c+b23npPLG+BD0LIzwV3k
	sy9HIQ/w1GuTfqFzmZr15lrKAMIIDjTR4YBlnHQuK+rFfrsETOaFMKHducAh0VHKKFJEC7O9+ch
	fjisoWdQZ4qbFdeb65GJUF1091w9HUqdUuFThlNjEjXuott3IM9+nub+X/pGPI85wBeCkpjmHBd
	BK9AChkekWQLlw==
X-Google-Smtp-Source: AGHT+IGYNAuQw+0KsOWtqzZ7R44bECymHrJQbz+QMy/xISXFjpz1ROKcIx6Jx+aQDs6g2afrua/BFKNlpraiqS3eNfg=
X-Received: by 2002:a17:907:3f0f:b0:b6d:7c03:e7a2 with SMTP id
 a640c23a62f3a-b70708b2251mr156091466b.65.1761880543234; Thu, 30 Oct 2025
 20:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030001857.681432-1-jstultz@google.com> <20251030001857.681432-6-jstultz@google.com>
 <90e556a4-59d3-4be4-b4a8-5e7ef4b523d1@amd.com>
In-Reply-To: <90e556a4-59d3-4be4-b4a8-5e7ef4b523d1@amd.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 30 Oct 2025 20:15:31 -0700
X-Gm-Features: AWmQ_bkoAPnOsdLGlkPhl4cpNTStUcYAbM0aDFISYdrgeKscLYpCEwjbB3IyiVQ
Message-ID: <CANDhNCo4bLw1sYqVVXUji4STdj68xV6OTu2tVosqUXmkN0r4ow@mail.gmail.com>
Subject: Re: [PATCH v23 5/9] sched: Add logic to zap balance callbacks if we
 pick again
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

On Thu, Oct 30, 2025 at 1:08=E2=80=AFAM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
> On 10/30/2025 5:48 AM, John Stultz wrote:
> > +#ifdef CONFIG_SCHED_PROXY_EXEC
> > +/*
> > + * Only called from __schedule context
> > + *
> > + * There are some cases where we are going to re-do the action
> > + * that added the balance callbacks. We may not be in a state
> > + * where we can run them, so just zap them so they can be
> > + * properly re-added on the next time around. This is similar
> > + * handling to running the callbacks, except we just don't call
> > + * them.
> > + */
> > +static void zap_balance_callbacks(struct rq *rq)
> > +{
> > +     struct balance_callback *next, *head;
> > +     bool found =3D false;
> > +
> > +     lockdep_assert_rq_held(rq);
> > +
> > +     head =3D rq->balance_callback;
> > +     while (head) {
> > +             if (head =3D=3D &balance_push_callback)
> > +                     found =3D true;
> > +             next =3D head->next;
> > +             head->next =3D NULL;
> > +             head =3D next;
> > +     }
> > +     rq->balance_callback =3D found ? &balance_push_callback : NULL;
> > +}
>
> There is nothing proxy-exec specific in this function. Do we need to
> keep it behind CONFIG_SCHED_PROXY_EXEC?
>
> I believe compiler will optimize out the dead code and having
> zap_balance_callbacks() unconditionally shouldn't have make any
> difference to the size of generated binary for
> !CONFIG_SCHED_PROXY_EXEC case.

Good point. I'll drop that.


> Apart from that nit. feel free to include:
>
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

Thank you!

> > @@ -6901,10 +6933,15 @@ static void __sched notrace __schedule(int sche=
d_mode)
> >       rq_set_donor(rq, next);
> >       if (unlikely(task_is_blocked(next))) {
> >               next =3D find_proxy_task(rq, next, &rf);
> > -             if (!next)
> > +             if (!next) {
> > +                     /* zap the balance_callbacks before picking again=
 */
> > +                     zap_balance_callbacks(rq);
> >                       goto pick_again;
> > -             if (next =3D=3D rq->idle)
> > +             }
> > +             if (next =3D=3D rq->idle) {
> > +                     zap_balance_callbacks(rq);
>
> Also I would have preferred to have that zap_balance_callbacks() in
> proxy_resched_idle() but this is okay too.

So my initial hesitation here is just we call proxy_resched_idle() in
other situations where we might return NULL from find_proxy_task() as
well. So this avoids calling zap_balance_callbacks() twice.

But thinking some more, later in the full series we often call
proxy_resched_idle() in those paths where we are briefly dropping the
rq lock and we often call zap_balance_callbacks as well there. I'll
take a closer look at the full patch series and see if that doesn't
make sense to consolidate then.  Not 100% sure it will work out, but
worth looking into.

Thanks for the suggestion!
-john

