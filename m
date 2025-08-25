Return-Path: <linux-kernel+bounces-784617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F3EB33E86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00402164175
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029882E2DD8;
	Mon, 25 Aug 2025 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FH90YvN/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1562D543A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123028; cv=none; b=rX/neyBA1cScfleh9hK8puDI+gxT1Y8kfXJ8C7zbG7ha9Odbd+1ZtXEutZz4NHZyvWYcotTXXMvf67ZYpBMsJFcRZHYAxpHO1z/iGLmRsvlHplkFwi/W6uzo2KFQijgVi3ggqOoyCkzCf9iU9dCnMTy3dSdJoKzrOsuKMl8RTlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123028; c=relaxed/simple;
	bh=70glNQzfZQ9sUoc7Lv6/55HfDV+Zwa2VwpWFwEROWEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWBzHfiS4pFaiFWaMjf6apte3TusPeAlNmf7jgsoOtM1YCMJ0kiai/mCDPlSnvE2x61brMUb61qi3vC4SyAnUuhYMKllSnXlqCxM1dzHBOxXEIXwU6BnDHQT88lu5v7YdLM01f2V/ru9dMil3iDzc/Gg77xBtqlqkcJJWeH740A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FH90YvN/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756123022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7xciFnf3JU7UC+A3w6NhKnJ8AVh21NQDSF78Yj4PwU=;
	b=FH90YvN/C/lE/WUjQCZvCreAF6WX9tXHfLB41yWLlnnw5nDfVyxwwxnmVouvj8NTmEYDrC
	vSvOKrlOEe7+lyyBufhzvJcL/CZ7BSQpQWJcMfYBj+gUCmJqrbCq3U0O+gZ0d9GgeHLLNf
	ZKVvmfGolAlkZwoDqnvJI8RUqcDl450=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-txdtu701NQiToqvetNnMDQ-1; Mon, 25 Aug 2025 07:56:55 -0400
X-MC-Unique: txdtu701NQiToqvetNnMDQ-1
X-Mimecast-MFC-AGG-ID: txdtu701NQiToqvetNnMDQ_1756123014
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-55f3b0fb5d0so1143558e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 04:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756123014; x=1756727814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7xciFnf3JU7UC+A3w6NhKnJ8AVh21NQDSF78Yj4PwU=;
        b=kt+1LKKN+Hugat62+j8VNpx+LcPY1Da63NMFTTSAP8327pd83g0Y2P8J+izsqU/53I
         vjcjFlQWr/pwkgz7eJKDDKt2fcj6zOqVSigIvQCEsrsaRqzNMdhN05EJ8i93ZzmNoSF2
         cMh896EHczwBvINw3OghVkMOLN6WxzK3mCqXkYbHU5XzdJYQuOVsCR5UQ7qOvAzgaU38
         dSxekWtQ1BZLwkjdywj/3nOEjQINoFWNdsrSY8zeBawhagqNT6iO8SQ52/OSdkNqnkdp
         vWYilXcWQo0msHADdj0UEqL2x9PYdlPjMIyyKoVHzOQnOviCDKiiD0S3XX5qJVun9Yfi
         uNkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdMjjtNn+WaqO1/w6iwqQj846Fxa0GZV1TOWrKlww1uBcoKNMV8ZlOjCAuUzyhpaQ1/n4hMVb4KbZYR30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPhMIoWKWuC4j+AK1HoON150LR42FUgWAy7PQObLTQy1+CpIFM
	9GEQm96C5IIavk66zQS1UnzlvRpkMl+qK2syGPu119DZXdT17U12gO/FbOcWHciIseIqIHG/29p
	RIc5+T17wqjAgHdMToT6qCIa4FO4rRphryexnkd1HPlQbOiUYZejsj6BYu2CmzOiDbTcJcVeVah
	M/Vb45h2N6odEwdO5eMzFZiZ4TIAAywCkyr6uCP8A+
X-Gm-Gg: ASbGncsSs9D7+gv9ZxvndutQwJc1PsjanyVrPTuSLuSx3M/hpU4x21n5TEhedvKWbfL
	o2Jbk+IXhDOsii/IPvpITLCbqR43AwwbyJ+FCqZ1H9Qyq/wscMKryOsuWKDpFJ6S4LR1Yb3eHAX
	W7Z6D+VAaUlD5rGxjcgdAS
X-Received: by 2002:a05:6512:440e:b0:55f:4361:890e with SMTP id 2adb3069b0e04-55f43619020mr1248006e87.15.1756123013888;
        Mon, 25 Aug 2025 04:56:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfeIlx+X23sTdUFzeBXCz5uJqvYj6sRUTepfBg3dXJE7i7XGGv4QCwhZ9EITzLfumevSxN2UV92Dcs6XFfKuo=
X-Received: by 2002:a05:6512:440e:b0:55f:4361:890e with SMTP id
 2adb3069b0e04-55f43619020mr1247988e87.15.1756123013445; Mon, 25 Aug 2025
 04:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704170748.97632-1-wander@redhat.com> <20250704170748.97632-3-wander@redhat.com>
 <20250707112003.GY1613376@noisy.programming.kicks-ass.net>
 <33jax5mmu7mdt6ph5t5bb7fvprbypxhefrvgrc2ru4p2dpqldg@d6af6oc6442r>
 <20250708185412.GC477119@noisy.programming.kicks-ass.net> <CAAq0SUkYr=aHTaDxm0KJek+JTUQ6gBN1PB24yfrVCNryA8jE_w@mail.gmail.com>
In-Reply-To: <CAAq0SUkYr=aHTaDxm0KJek+JTUQ6gBN1PB24yfrVCNryA8jE_w@mail.gmail.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Mon, 25 Aug 2025 08:56:42 -0300
X-Gm-Features: Ac12FXxfV87YOE5tHwnZyz_2gpZXfYSy4LPcGKEHrAVPNMONGzjNSEXh3mmyVY0
Message-ID: <CAAq0SUmEL4W+Fb4Q3q0SYO8LHzoQH1O+eCU7tFH7p5YS_y_DdA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] tracing/preemptirq: Optimize preempt_disable/enable()
 tracepoint overhead
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Clark Williams <williams@redhat.com>, 
	Gabriele Monaco <gmonaco@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resending in case people missed the previous message.

On Fri, Aug 1, 2025 at 10:30=E2=80=AFAM Wander Lairson Costa <wander@redhat=
.com> wrote:
>
> On Tue, Jul 8, 2025 at 3:54=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
> >
> > On Tue, Jul 08, 2025 at 09:54:06AM -0300, Wander Lairson Costa wrote:
> > > O Mon, Jul 07, 2025 at 01:20:03PM +0200, Peter Zijlstra wrote:
> > > > On Fri, Jul 04, 2025 at 02:07:43PM -0300, Wander Lairson Costa wrot=
e:
> > > > > Similar to the IRQ tracepoint, the preempt tracepoints are typica=
lly
> > > > > disabled in production systems due to the significant overhead th=
ey
> > > > > introduce even when not in use.
> > > > >
> > > > > The overhead primarily comes from two sources: First, when tracep=
oints
> > > > > are compiled into the kernel, preempt_count_add() and preempt_cou=
nt_sub()
> > > > > become external function calls rather than inlined operations. Se=
cond,
> > > > > these functions perform unnecessary preempt_count() checks even w=
hen the
> > > > > tracepoint itself is disabled.
> > > > >
> > > > > This optimization introduces an early check of the tracepoint sta=
tic key,
> > > > > which allows us to skip both the function call overhead and the r=
edundant
> > > > > preempt_count() checks when tracing is disabled. The change maint=
ains all
> > > > > existing functionality when tracing is active while significantly
> > > > > reducing overhead for the common case where tracing is inactive.
> > > > >
> > > >
> > > > This one in particular I worry about the code gen impact. There are=
 a
> > > > *LOT* of preempt_{dis,en}able() sites in the kernel and now they al=
l get
> > > > this static branch and call crud on.
> > > >
> > > > We spend significant effort to make preempt_{dis,en}able() as small=
 as
> > > > possible.
> > > >
> > >
> > > Thank you for the feedback, it's much appreciated. I just want to mak=
e sure
> > > I'm on the right track. If I understand your concern correctly, it re=
volves
> > > around the overhead this patch might introduce???specifically to the =
binary
> > > size and its effect on the iCache???when the kernel is built with pre=
empt
> > > tracepoints enabled. Is that an accurate summary?
> >
> > Yes, specifically:
> >
> > preempt_disable()
> >         incl    %gs:__preempt_count
> >
> >
> >
> > preempt_enable()
> >         decl    %gs:__preempt_count
> >         jz      do_schedule
> > 1:      ...
> >
> > do_schedule:
> >         call    __SCT__preemptible_schedule
> >         jmp     1
> >
> >
> > your proposal adds significantly to this.
> >
>
Here is a breakdown of the patch's behavior under the different kernel
configurations:
* When DEBUG_PREEMPT is defined, the behavior is identical to the
current implementation, with calls to preempt_count_add/sub().
* When both DEBUG_PREEMPT and TRACE_PREEMPT_TOGGLE are disabled, the
generated code is also unchanged.
* The primary change occurs when only TRACE_PREEMPT_TOGGLE is defined.
In this case, the code uses a static key test instead of a function
call. As the benchmarks show, this approach is faster when the
tracepoints are disabled.
The main trade-off is that enabling or disabling these tracepoints
will require the kernel to patch more code locations due to the use of
static keys.


