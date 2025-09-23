Return-Path: <linux-kernel+bounces-829777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6861B97CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4812E5115
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B4D3101DF;
	Tue, 23 Sep 2025 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h6nCSaMO"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC139302162
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 23:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758670469; cv=none; b=u51iz/6LYTC79NvwMICeZZER7qJxL+3PsiYVoQyU6CEKx3CdUcqJhCPWCxKxG8x+9WjtRKxCgJ1VzHZYwlo7MklVmsGVgTLmqyplcGqv8Mdu571qKRKNqqBOoH3nV/SKRPRghq144GdzTgVg4ker7ykenwDp7rEvAOCSRmFzX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758670469; c=relaxed/simple;
	bh=8FWgTx5+BEMEgi+Q3Sb4O9xjeopCYpByXxsap7GYt0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcm8MjP8v6a+jSIQk6KKY5++VcZRTQutwFVbQmJiH2VxiPRjl37jH0EZzZXttJe3sAtTZN+kaqFyGSdZp9VzcLagOwogC23K4QDCSnYFz2VGXaG/lQa7y2OwVDlLYZX2HgR+g6aVwarm02KYeR1Lm7UqhOvd0aMbKrWG/kKCae0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h6nCSaMO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso43744805e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758670466; x=1759275266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48kEwgQB4wWkI/XsNWVulCwz+LDSwRqAOLQwx1Koqjg=;
        b=h6nCSaMOoYHqP0fUAeGTzFUDBkHGPRZA4GLvwEBz9dmA6eEPq/5EyJTmDf5wT0URNa
         Dfi1MrGCIbuFxfQvP3JjmaGsPHcu3w/XKDZXja/KqXMvrxPX+i1k1BChPtEeQLp2VEiI
         5clotj9ECNeiUwv6Fl89KrZoWifbyqESeUU1Cdacvsz1f/Tq+58f1Ty9Jx20aINb5zP+
         oeZ8mTWjif+1Uc55FnehKKwtjYIEgIlU+WyR+uYw/cok1RFJb7Hd9LyyatR/aF3iBASQ
         eswd3AWz/TtRRq3DlUMHea4VHTms92wswNbzzQw9m5HVw/Tu30UVj10RJ0XOx2a01svF
         dbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758670466; x=1759275266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48kEwgQB4wWkI/XsNWVulCwz+LDSwRqAOLQwx1Koqjg=;
        b=YZgnpaQ6KsJoOa3NSeOHvU/MBLLmuwG/uvWabp4G26NNRW7L/dO194V9TzhOK0p2SF
         GpoXva5nJDSif/IR4gx0o1IuY0zeGj5YzfLoeHVwNRViNgp4kbeqoRIKNKjxLp3EKnqY
         r9nGhom2xtvqSfuxUURVDxhTbhEMD8bWEzf4251LIKjvOj2vQccjlPeKwd5HmKk654YP
         0NdVudhfSc/HF/qHaQwnbTj3aST4pG1/NwtHjUFWah/bjr8kE/737ECneTJwiArEbUqt
         7EaZSJHrdzbhT/xZJnKe4uy9AJmFgXsnMIJCgJmvzsLBPXDFPePuCRhdID25XGxTVC/5
         8v4Q==
X-Gm-Message-State: AOJu0YxuXFnG9ag3obpmJ4mRjBYw5MJZQVYrBMzJuUY3+i1SQTsTf4Jy
	gjW56U8VuYbx7wnxmb0lZD026K8rpsxAfWchMbqk0OzYJgUFgM/lrs9HTqK1Y/fubLL4FnWov9x
	ujQhdQulMwoOxKgg/nbabrz7G95dJztWZgmJzaN0=
X-Gm-Gg: ASbGnctFyZexq6tbvE3YMyOzwK/TNEuua9CPB8WJHEDFj+Dju+dY9KeIOPZ9ZFbsrxG
	laghnQs5RLOiHJnd5hHnPTG90ciq9TZRoDtQmKfGJM90zUKc6hR0ZMZpSIVSirgOmwjldiuRvKg
	7anMwfvIK6gkzzli3Cz5CNHV5FtwY1FQ4m6Sd7xLEqOwgCisfhAMyGZo+D/kP9upmKyBWd/9DE/
	fRQ2xf3Dv17gH/6cYx2RUCIPLI+T/gxjR/yBD0M2h1N/nQaGBvsFA==
X-Google-Smtp-Source: AGHT+IHjYD2K/t0UHtRrupmKcR5o+CUOO0hQJJK1vGvlOg65qLL6tj5sV9HxMXJ6eNn0eu2MvPDyI8HyezK3pP9fjEo=
X-Received: by 2002:a05:600c:198f:b0:45d:d9ab:b86d with SMTP id
 5b1f17b1804b1-46e1dac6457mr44630825e9.31.1758670465734; Tue, 23 Sep 2025
 16:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904002201.971268-1-jstultz@google.com> <20250904002201.971268-3-jstultz@google.com>
 <337322ea-6efe-4814-a813-e55d4c80fda7@amd.com> <CANDhNCpmQLF_03t3PMEtjBU_tpL10FJ_iL=x3zMG+Bs0PEFESw@mail.gmail.com>
 <d70e7e50-d5c3-4689-b91f-9dce0f1a0424@amd.com>
In-Reply-To: <d70e7e50-d5c3-4689-b91f-9dce0f1a0424@amd.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 23 Sep 2025 16:34:13 -0700
X-Gm-Features: AS18NWD2-fnRjkF0LZG1rzixQhRVviz6IbB-TDJCK0HIwcIbpI7itXPc1EzB7k4
Message-ID: <CANDhNCrPeJpNYtHEZY46etXb_c4H4dALELf2LbC1R8PnWJW97w@mail.gmail.com>
Subject: Re: [RESEND][PATCH v21 2/6] sched/locking: Add blocked_on_state to
 provide necessary tri-state for proxy return-migration
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

On Thu, Sep 18, 2025 at 8:28=E2=80=AFPM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
> On 9/19/2025 4:27 AM, John Stultz wrote:
> >> I didn't know that was possible! Neat. Since cleanup.h has a note
> >> reading:
> >>
> >>     ... the expectation is that usage of "goto" and cleanup helpers is
> >>     never mixed in the same function.
> >>
> >> are there any concerns w.r.t. compiler versions etc. or am I just bein=
g
> >> paranoid?
> >
> > Hrrrrmmmm.  I hadn't seen that detail. :/   I guess I was just lucky
> > it worked with my toolchain.
>
> I have been too. Maybe it is okay to use a goto if folks know what
> they are doing =C2=AF\_(=E3=83=84)_/=C2=AF
>
> Another idea is to have:
>
>     bool deactivate_donor =3D false;
>
>     for (p =3D donor; task_is_blocked(p); p =3D owner) {
>         guard(raw_spinlock)(...);
>         ...
>         if (<condition> {
>             deactivate_donor =3D true;
>             break;
>         }
>         ...
>     }
>     if (deactivate_donor)
>         return proxy_deactivate(rq, donor);
>
> Can that work?

Yeah, I've reworked the logic to switch() on an action enum, which
will let us do something similar without gotos.

thanks
-john

