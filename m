Return-Path: <linux-kernel+bounces-753408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A93BB1827B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156AE6279F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920BE26AEC;
	Fri,  1 Aug 2025 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8Odl5Sa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7E22110E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754055025; cv=none; b=G7CxHmbcxJqeyWrIppT1x28eUGC71a3AFnkLxIpmsd63PUMfr2rsAMX6qrrbZyzvOD1OFWr27VsHBbg/XBhpXfTWsVuWqfk7j/6J3mCPCLYgmUySsR+NShFOq8BzF+rIKVQt+GHkA6U2Ln3qGZbrhzt23+WPcAfU42NRwQMVP2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754055025; c=relaxed/simple;
	bh=jCuaoEZs90yPpATTnkRMnrpR+Lll95t5g6dAhnezWao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbtm+2dKCdp/PyfB8bwnCt88AYv8+iVjbcM+OQcmhBvVpmAOyh+FZwlsqgy2jrAM+1f3RWMjQ7zpJzcI8PurvFoZkoQvZU4+X/wdysVbQkyVKy+Axl3tmietuHLlIE3xtb71wBgqZwWbeF679VWJMk0/8dMphGcavauKPdajEsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8Odl5Sa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754055023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6frlSQg5zQszZbkmny4P99kcJ9ZbOwLt0IQeS+loxw=;
	b=N8Odl5SaaUPdaB6eSLJ7lhe9Qrz4yc8bZQbuXq9SLHkPVpZ/Yskrx/0AqzDyw2yF3EMGKG
	oOEP7qCGZFLoRGGi2uN7FSIYEG9pNLe5Z6oqV4f5joMl8ts7YRKYu9hXtYl1UhSU7Pwg6N
	9y9cBOkPu3lBP02DFSCL9DCV2lDQwsc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-a_bHHyOjNSiti8Tph2W8ow-1; Fri, 01 Aug 2025 09:30:21 -0400
X-MC-Unique: a_bHHyOjNSiti8Tph2W8ow-1
X-Mimecast-MFC-AGG-ID: a_bHHyOjNSiti8Tph2W8ow_1754055020
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-55b92814f00so200935e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 06:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754055020; x=1754659820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6frlSQg5zQszZbkmny4P99kcJ9ZbOwLt0IQeS+loxw=;
        b=F+hr7xWHJa9SWhSAlw8opXkhTaKoi30fnRPSCbmX/rnc9MgKlfacSLgratYR9mxlOu
         M18N+a6ZL714Cb3gk7iHuw0zMiPwth4yQ+U9WmrhnFCXxbzxEmBnL9yd6sigSjNpSobr
         s/kv93i5dQj0VdItyagn3MNEYG+DwYLP/j8kZoFPYRvJhAZOowIzMFpGCbvSuyAwyOyd
         fHWi9NXn5i0KAl0EiHq47mHuKEGXvO5563aq/nvxlv/TudrxDsaRVLmaQFqTAB2GdgO8
         PiqyN7/4cnBE6AQ86z0Gt2zP6EJzma/OKyKkvj+Pp5ICIwrj8SWlj9Mlk+SJduOFZgJy
         tQVg==
X-Forwarded-Encrypted: i=1; AJvYcCXaINJTuBwx8mN1Aj6L9cbTdOdC7SfkIA6Gzci3UHdZHI7RXaF5VXJbxLYlnby003w3oks3L5Nzqpy/Sk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpnHEG3arnBiqOZDlbJDKvD2k2tH+TIXJTj3QHCRyUIWQkZ5f5
	ifPzTEf7D1WTieF8pY2EsmtX1+Gtc6VonuoWMZcwzwP+O0i2c3cmjA1uTbWVkVI5egUTw2o2o1f
	bLOCb68esr0/5b4cqvQeBusEqUS0fGhag6Y82O/Xl/OCu5ztOK1m3ngQiUQR7SlNfl0irw/KlwV
	28sMyIB9A7UX7C6tL2YgL/93IEqO+bwlgWQiXOocYs
X-Gm-Gg: ASbGncsrix7Yngs4BcruJDwiCstIugSJRp2zQbpJZvkw4Tj3nGyhGNQ3aYFuZ5l0uxr
	cbyrArQafTzsoRtvbVV8OcmXWNcQ+qVKpgQTdz1ysoThT8+ebEiDjGY6f9rYPDAq+q91lXOL/+x
	VeuW41sZUfeDnnH+rcnt9W
X-Received: by 2002:a05:6512:220d:b0:54f:bdfe:ece5 with SMTP id 2adb3069b0e04-55b7c01d1bfmr3378589e87.14.1754055020152;
        Fri, 01 Aug 2025 06:30:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc+GPH4oAIuK00NsBMEtlQ02fsL6dq3jyC+S9NoRK1IZTcb9xvf8H24EU2jfCnWIExOjWoJRzP/RlBmLAzqqs=
X-Received: by 2002:a05:6512:220d:b0:54f:bdfe:ece5 with SMTP id
 2adb3069b0e04-55b7c01d1bfmr3378581e87.14.1754055019674; Fri, 01 Aug 2025
 06:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704170748.97632-1-wander@redhat.com> <20250704170748.97632-3-wander@redhat.com>
 <20250707112003.GY1613376@noisy.programming.kicks-ass.net>
 <33jax5mmu7mdt6ph5t5bb7fvprbypxhefrvgrc2ru4p2dpqldg@d6af6oc6442r> <20250708185412.GC477119@noisy.programming.kicks-ass.net>
In-Reply-To: <20250708185412.GC477119@noisy.programming.kicks-ass.net>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 1 Aug 2025 10:30:08 -0300
X-Gm-Features: Ac12FXylgF4APtgLekMnS8zcNROTrZDJjGcjSpiCyJ_XYIVzGNz-dgyu076HKi4
Message-ID: <CAAq0SUkYr=aHTaDxm0KJek+JTUQ6gBN1PB24yfrVCNryA8jE_w@mail.gmail.com>
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

On Tue, Jul 8, 2025 at 3:54=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Tue, Jul 08, 2025 at 09:54:06AM -0300, Wander Lairson Costa wrote:
> > O Mon, Jul 07, 2025 at 01:20:03PM +0200, Peter Zijlstra wrote:
> > > On Fri, Jul 04, 2025 at 02:07:43PM -0300, Wander Lairson Costa wrote:
> > > > Similar to the IRQ tracepoint, the preempt tracepoints are typicall=
y
> > > > disabled in production systems due to the significant overhead they
> > > > introduce even when not in use.
> > > >
> > > > The overhead primarily comes from two sources: First, when tracepoi=
nts
> > > > are compiled into the kernel, preempt_count_add() and preempt_count=
_sub()
> > > > become external function calls rather than inlined operations. Seco=
nd,
> > > > these functions perform unnecessary preempt_count() checks even whe=
n the
> > > > tracepoint itself is disabled.
> > > >
> > > > This optimization introduces an early check of the tracepoint stati=
c key,
> > > > which allows us to skip both the function call overhead and the red=
undant
> > > > preempt_count() checks when tracing is disabled. The change maintai=
ns all
> > > > existing functionality when tracing is active while significantly
> > > > reducing overhead for the common case where tracing is inactive.
> > > >
> > >
> > > This one in particular I worry about the code gen impact. There are a
> > > *LOT* of preempt_{dis,en}able() sites in the kernel and now they all =
get
> > > this static branch and call crud on.
> > >
> > > We spend significant effort to make preempt_{dis,en}able() as small a=
s
> > > possible.
> > >
> >
> > Thank you for the feedback, it's much appreciated. I just want to make =
sure
> > I'm on the right track. If I understand your concern correctly, it revo=
lves
> > around the overhead this patch might introduce???specifically to the bi=
nary
> > size and its effect on the iCache???when the kernel is built with preem=
pt
> > tracepoints enabled. Is that an accurate summary?
>
> Yes, specifically:
>
> preempt_disable()
>         incl    %gs:__preempt_count
>
>
>
> preempt_enable()
>         decl    %gs:__preempt_count
>         jz      do_schedule
> 1:      ...
>
> do_schedule:
>         call    __SCT__preemptible_schedule
>         jmp     1
>
>
> your proposal adds significantly to this.
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


