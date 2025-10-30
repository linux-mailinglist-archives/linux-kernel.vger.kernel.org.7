Return-Path: <linux-kernel+bounces-879280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55391C22BBE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FB41893A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5101A33E374;
	Thu, 30 Oct 2025 23:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKncfpuG"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017E733E353
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761867771; cv=none; b=d4+S5tJ1W5+Oa1mRjXSV2wBq4iPEp89Er2E1D4RntUkmwgacL5Z/5s8EwcqbbXbGGrAuezSerDVUjIwlw5OpzNyOSmCiusbghYBI05WAJpja76Nd9oo3Rd3Ll9KvuTvvIolbsqiyWDaeEOLmyX/C2UScKIQm4Gs1pBH/zaWthWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761867771; c=relaxed/simple;
	bh=DE4GqBuV22TruGHl8amYHLxxmTXP99iA093bN/VEK1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiNN1ajw/Xvio1yNIPjzHLuwh5FtPh62E/J5C2E+s3cVFHxwdmZtcRdARFF0/n9LS3gK7HmTeW0IOPPZK+ahWt9MhsIPc+xx8CUdZjoCY6qeM4qWr8TgJCNRNLSbFXVjJJqbm8dFQ2fryBuF5CE/iOCAcvgT6kETTfOPRbeNb5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aKncfpuG; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b50206773adso525306066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761867768; x=1762472568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3CZRZY4J4yS1ZyrgmpV6YjQg7tsbEO1A3A5njHalyg=;
        b=aKncfpuGM/foVpT069aO9Zgbp1PSjVBELO7Lz6tIoQar+5igBPGeKufy6GK89jDcQa
         Jd+8n7zJFS6VLDLUPcLCDjl6YqP6m/tGNTb13nUmGgMiYTVWkBrwoiAP2uHDUaqgd58V
         VDq4hEmQ1R+Tg9smz9eZ66G4X378UKs7Y5cpRHUzIuKJsF+AWTKSOWnOF5UJW/bonU4q
         JL4M3izPHw+DpxJmVHBNjmMAMvWTbqkl7WdkYg8QEb6l3vr5RHj8JLIniV0quRqnaY6C
         k3WbT6U0uSgWmDE4gKGPWAV6CDtLPgldqDlUF/nja/5jD8lc7lGW3Fq5qffnNdd6KS8t
         t5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761867768; x=1762472568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3CZRZY4J4yS1ZyrgmpV6YjQg7tsbEO1A3A5njHalyg=;
        b=IufIB1JUXMOaLsWI4LW5RJCTxn1eid1KA6whKCwaVbu0w4cBGGHMdsddTEz85jYM/r
         cYkKWdMXWGwtMmM/ve+CoXvzDD2aMrU6FJjFE3/lkMJtdmj8NwYzMv8jXEOXlpinecaW
         QiHQpqCNBOKVtOQR9cer902cPPCB9QqfSdnnvymKRfvJNRPq9xobA6S2KuGbR1ItXyvF
         SqAfY1tVs1BtEusE50Ijssx5H/gGTgh71aI0EWIJdIzWc5AXVgtgGJrQIxriBrj8OJwT
         i86ykqO1zO1CA+qbjukwFtyAy38gS+PFXSBbP+wYTVShDSyyY0FEcawkSF61SRVtzgaQ
         Cs8g==
X-Gm-Message-State: AOJu0YxAIcGscYzB2lxMBxWry5MeLd+TRfaEyVMzz2dCe5IBtwP59Hmy
	t+vg4pzorJtgraltWkyyKPP/40PSTLpDL1NGbXx6GXJx0Nr8uuO8O6B++fn50taqT2sqmWFm5Ol
	NmhbLgygi6ekcY/FJGQ1oeSXyBekRCYcnsOEra5U=
X-Gm-Gg: ASbGncvZmZfsnuQiQXLHlrh3+8k9phCiL2cQOLkcgaBrndh/zfVkL/m6tH3c6li/O52
	SNTSNu/kotcGCKUHzO9FeX+yU48+CfFxw5OMn+/WGZLl4LopinLmPVhSJCjTSyEU1Hf+B66g64T
	iDIE8yt0hgcb2LN2UqFLpU3yFvFuIdZqHlfESYEm1GHtyACeNzIDkGl8weuB0R5ELGD/GY0r4zG
	APNzW9DhTprB0ObKXLGHD2myNXRO2J/ePyyZu2NEi6xvC6LppVuSl5ZDwJOGbJI5CmM/4mHdmmJ
	RQ6SmbWGv+n4Yw==
X-Google-Smtp-Source: AGHT+IHXJyABwy+YlpHtWHFVZ9scJu1XN6C/NhPGdB38J8lEYF3J9TpuRK4stAjtt5Nw478VYGku63Ewg7zGh8cdzxE=
X-Received: by 2002:a17:907:3f89:b0:b6d:671d:8814 with SMTP id
 a640c23a62f3a-b706e5823f5mr176167266b.27.1761867767913; Thu, 30 Oct 2025
 16:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030001857.681432-1-jstultz@google.com> <20251030001857.681432-3-jstultz@google.com>
 <84c4aa9d-9094-4b12-8912-63a338a43351@amd.com>
In-Reply-To: <84c4aa9d-9094-4b12-8912-63a338a43351@amd.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 30 Oct 2025 16:42:35 -0700
X-Gm-Features: AWmQ_bksMgjup1xlf2cptdec-fRrAfEHXuVbuQz6w9ObfjuDmB3nMcLHtKT2UqY
Message-ID: <CANDhNCqHd5tHC_N2unYyhH3nuiq_b23WKEwHzpOWizWzCfT9JA@mail.gmail.com>
Subject: Re: [PATCH v23 2/9] sched: Fix modifying donor->blocked on without
 proper locking
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

On Wed, Oct 29, 2025 at 9:51=E2=80=AFPM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
> On 10/30/2025 5:48 AM, John Stultz wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 517b26c515bc5..0533a14ce5935 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6591,7 +6591,7 @@ static struct task_struct *proxy_deactivate(struc=
t rq *rq, struct task_struct *d
> >                * as unblocked, as we aren't doing proxy-migrations
> >                * yet (more logic will be needed then).
> >                */
> > -             donor->blocked_on =3D NULL;
> > +             clear_task_blocked_on(donor, NULL);
>
> nit. You can probably switch this to use __clear_task_blocked_on() in
> the previous patch and then to the clear_task_blocked_on() variant here.
> It makes it more clear that proxy_deactivate() is now out of the
> "donor->blocked_lock" critical section.

The gotcha there is the __clear_task_blocked_on() will assert if we
don't hold the right lock. So this patch is sort of fixing it up to
allow for proper locking without cheating here.


> Either way, no strong feelings.
>
> >       }
> >       return NULL;
> >  }
> > @@ -6619,6 +6619,7 @@ find_proxy_task(struct rq *rq, struct task_struct=
 *donor, struct rq_flags *rf)
> >       int this_cpu =3D cpu_of(rq);
> >       struct task_struct *p;
> >       struct mutex *mutex;
> > +     enum { FOUND, DEACTIVATE_DONOR } action =3D FOUND;
>
> nit. If you move that declaration to the top, you can preserve the nice
> reverse xmas arrangement ;)

Yeah, I meant to do that, but just overlooked it. Thanks for pointing it ou=
t.


> Apart from those couple of nits, feel free to include:
>
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

As always, greatly appreciate your time for the review and feedback here!
Thank you!
-john

