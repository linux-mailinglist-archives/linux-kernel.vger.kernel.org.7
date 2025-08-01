Return-Path: <linux-kernel+bounces-753382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9614B18223
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429EF18842FA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288CC24887E;
	Fri,  1 Aug 2025 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eorKkjYN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EAA19F13F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053569; cv=none; b=McOGK2oQnSQY6qPMn1rjoVAxfBOQOV86dU+WUcJyz5bqjlCexsVn5v4DUNVgnicBSTI5LIBrGDNge/bdDZNlRkGENMvDnTHWhdpdPcq4f62OaKOyIbr+S1TLjFEMyW/Hy2emQPabefaLCt1h29NbSoUvSKmRkBp6ClZ/gF5khkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053569; c=relaxed/simple;
	bh=X+6e/IdlOphMsOvvEV8Ay2A0t6/Mh3wGQRWB5DbzH7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjqHepktCLhqSyYzZfmYa28WtJoWMiOCGm85o1hRbKKqOoZRimA8qWZdSTeGb38yyzYNpEUdoNUWbM++aW6tdObMGwEmxqIrCxdhlUTy+My45sJm4mX2S6l9InNcXVfHoVcY8r3EK8jGfkU2pt2UdbbTgzL+LtHdKAmz0INkQLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eorKkjYN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754053566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+6e/IdlOphMsOvvEV8Ay2A0t6/Mh3wGQRWB5DbzH7Y=;
	b=eorKkjYN0NG2ULJSJpW0ABX25FyfbHBbpkhbI/Ig12BjtN/i8BAB4abbHylIxTsalugJI1
	R50QI/sKNBA+Nd844k8fURXJBjCvWcwRbDHxF5Sged+fENA/efZjbVc/DLm+PlzLeKMUN0
	YWDTcsONhdVH7+6vAY8L1SWNj/Da2EY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-WNKumXJZPE673-eTjhXveA-1; Fri, 01 Aug 2025 09:06:04 -0400
X-MC-Unique: WNKumXJZPE673-eTjhXveA-1
X-Mimecast-MFC-AGG-ID: WNKumXJZPE673-eTjhXveA_1754053562
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3322b98b1a6so7991391fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 06:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754053562; x=1754658362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+6e/IdlOphMsOvvEV8Ay2A0t6/Mh3wGQRWB5DbzH7Y=;
        b=gqn4icxfgrvfpwddnGO7gNYubXZ/zZEKhU3ymZDNtQ0YtkMGD4/hrbvJNUBVGM6dQb
         HrZujo3oocOKjAXGktwjcNO4Jq2G9v4Ug8Sh9VuB1UP9mjVNcLRpYNQYX2Mvm3sMi3ub
         qVdezZwObrc7FSdZgd43xEKlSdOPSCJlpu+uJdQ9q2mntFcRczKNJerL+S/M6PCLTH4w
         3RFLBIDk0GGq4qh7D/+eN+MS/S3KaCFoUpAwhXpVIKD2fWv7J1Cpyn5BLPgKN3PHNbNr
         clkLhMOEw+CaTwSzr8h1hb5u/HWplZVioIHcQfTmG37V17iO5jGIR5YeGtZPTu9s5dom
         Lggg==
X-Forwarded-Encrypted: i=1; AJvYcCWFbbpKolrpTvkEtVs7tCOhH6QDkSoLgkExFkWkw/7keQtYCDJGK/OoBHLUuduX0XoX5irKeX30LfYngGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/t0xYHoOrcQyxrU8NZ+nokUbPCZkUEsAvoYR3elDuWvsEiQOz
	IUUbdYxQhIID30IAfVk/FLMxgC7hJOZMa5z4EsacAnWrGbOkYwsgsqBvSJogIaVtS75p3UtFUok
	QD456fA/4ZwcMSgjlVic3PGsFODnrMnjjT8+Mt4+lqvcodRvVVmqMaLI6OukmCAvRXv+/2REZnj
	lL5VjCKQb57CoFXzJ1CitQPn2jgPYRp6qatl43wANY
X-Gm-Gg: ASbGncvdg67gRpaD8g6I6oq4KZvb/r3YJECv7rkBZO+g2ESemruJcLxenkBnNOFv2rE
	m9aNmlXqUDOs97MPHNUhLULQhLUSn4bLUo15oTL+f1ApuS1Srv3MgLV5EW9eCRvSoIeSRvbd4/q
	pG83/LPNhgnvNLQre5yPnE
X-Received: by 2002:a05:651c:54c:b0:332:32cd:3030 with SMTP id 38308e7fff4ca-33232cd322fmr23013731fa.30.1754053562016;
        Fri, 01 Aug 2025 06:06:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwPekJyaRBrU4XHAaPoLUYuXzoYjPAsppCTKKhF9uqbOBME0quueqtHalfWUF3r20fmIamlMzDLhps4jDkaZQ=
X-Received: by 2002:a05:651c:54c:b0:332:32cd:3030 with SMTP id
 38308e7fff4ca-33232cd322fmr23013331fa.30.1754053561509; Fri, 01 Aug 2025
 06:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704170748.97632-1-wander@redhat.com> <20250704170748.97632-3-wander@redhat.com>
 <20250707112622.GZ1613376@noisy.programming.kicks-ass.net>
 <ppdduzdqnd3kwourcmocfi35i7wcbuagmzqgtgmyr55aps774t@37wucnoii7o3> <20250708184656.GB477119@noisy.programming.kicks-ass.net>
In-Reply-To: <20250708184656.GB477119@noisy.programming.kicks-ass.net>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 1 Aug 2025 10:05:50 -0300
X-Gm-Features: Ac12FXyz6W_OFFg15W09K4lkzCr3Pdj1iLkCY-v9uSyvK6uNsriEI0u894aKnQk
Message-ID: <CAAq0SUkdvA7SKsM_a5z+_Dx8wAEdyw2KKgE=VnyQ7Q-ocZHq4g@mail.gmail.com>
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

On Tue, Jul 8, 2025 at 3:47=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
Sorry for the late reply. A mix of PTO + higher priority backlog items.

> On Tue, Jul 08, 2025 at 10:09:45AM -0300, Wander Lairson Costa wrote:
> > On Mon, Jul 07, 2025 at 01:26:22PM +0200, Peter Zijlstra wrote:
> > > On Fri, Jul 04, 2025 at 02:07:43PM -0300, Wander Lairson Costa wrote:
> > > > +#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_=
TOGGLE)
> > > > +#define preempt_count_dec_and_test() \
> > > > + ({ preempt_count_sub(1); should_resched(0); })
> > > > +#endif
> > >
> > > Also this is terrible. Surely you can do better.
> > >
> >
> > Thank you for pointing this out. I'm not sure I've fully understood the
> > concern here. My understanding was that this logic was pre-existing and
> > my patch only reorganized it.
> >
> > I'm clearly missing something. Could you please elaborate a bit on the
> > issue you've spotted?
>
> The normal (!DEBUG) case uses __preempt_count_dec_and_test(), which is
> significantly better.
>
Maybe I am missing something, but my understanding is that this behavior di=
dn't
change. When DEBUG_PREEMPT and TRACE_PREEMPT_TOGGLE are not defined,
__preempt_count_dec_and_test() is used.


