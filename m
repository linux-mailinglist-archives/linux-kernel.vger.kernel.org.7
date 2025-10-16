Return-Path: <linux-kernel+bounces-856178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7FABE353B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C326319C7640
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B62C326D50;
	Thu, 16 Oct 2025 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSjqHOtp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3A92E36F2
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760617268; cv=none; b=WSu0N2mzvqJej8Wrom6RCH/uLg4qWDmYl1pj2Zt+vFcfXx7Ahi0jL36v3+ijtTovfHcPzFrVwj6iU1E/dG1ghs4UTnHX4dePZZ91GM+kdLvSAzD2fsRckerEUkDCkl+P66WhLh+jga3gjooV58xNpvKA8+05tqWuRywAXoAJExI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760617268; c=relaxed/simple;
	bh=g5UquA23OKmcKbEW2QaGu/uTlfPHyhWAQiJyGpVDX2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6Lrrj8bBVPpLfJEOoTjEfGLhFcFaO8aDcdsGwjHmDTMX2bEBEEmqG0EBdAxui8pq82gXtOCuUol4DpdyhFsQOK0EtVq2MNogyTBEo+wyBRFrHbTGeBjfHOaxy0ktX5yzDJc6M601jO7wYz75m63yMw8Ho0rjhYn0YtcXwbnFuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSjqHOtp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760617263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8l30wqveikHO5cuaOXfKQ7iEQ9pMSdsaYyYQX3OIlvg=;
	b=NSjqHOtpOs1/bww+jVbp5Pzd/MC/DbMT4Yv9o5uphe/7/ae9Uw3YDPbGockggPakB0BNLy
	zAgZWFMn3Z0X58AQybQdo3+22/NCzbB7La7JIr72H7xsEKJm4cx4UuZs6PT510CExBnE3y
	tOhAlOCsmg7KEgeZUREHkR8sqjoXbgY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-kvahNC1mMsehe03aDw8ZRw-1; Thu, 16 Oct 2025 08:21:02 -0400
X-MC-Unique: kvahNC1mMsehe03aDw8ZRw-1
X-Mimecast-MFC-AGG-ID: kvahNC1mMsehe03aDw8ZRw_1760617261
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-332560b7171so1738305a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760617261; x=1761222061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8l30wqveikHO5cuaOXfKQ7iEQ9pMSdsaYyYQX3OIlvg=;
        b=dGT5UfuGn0SEz4JLwdlhq/K+1vabBDpFQ6FboDTafQUw430SmyYpZmGI+X5g6aX4lG
         h9euuEQpU1WnPyno8/XWA/xE3AcggSX8zy3HHKKJy23evSaxeYCScj9B/z6gKsT13qxu
         f0FFBPkILjjXY8FcF9DlO07N8exdMy8NSP0E9qlAO4oK80UYV3nU4CyTA2noAUTqJA05
         9qtlIEL4Lg3GZKQItJEgBpLRooBzInbDK5jjKo4ggqc79dQNRWz+KjQnCzKkOoKBG6VN
         rIKKgSHNI0NVBXk8mokaJC1ZyHr5LO9U5rYUvsn0OtcA1Qacal5zfZmjFYQAxbb9sz22
         IeFw==
X-Forwarded-Encrypted: i=1; AJvYcCWOZDoPm89QECCQ4itcI0PhMdl8UZ0uVw5QliidWmjG76h4LfCfV1iCgxj6sHaoZw2iN4F469NsNOerbKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvU3OFe9DOZJut6Eg7wbQI+c6xkfco44pP/on6VY2srM/3UQsL
	jlGMWjbKnLtO+2dkNHFiaZ3iqGcGpBgga2/Ccypk0moAhGb4ZwmLxCPBjk+cvNG2yoZSTTa3Kz0
	W0llLs1b3MVi5NgZtzn1qKMjAcTnHQaUZJITl/q/th75K+zjjwDNad6rBsvGNe2T1/B0syRM7vR
	mmW0AKiNlwAOBkDWUALjNMSdBrUgSEJG99TncVZ564
X-Gm-Gg: ASbGncu3oFsigoqimiJftiVUYSesfkXzOs0dtGkYS7E8pgtYsYiN7cKVj7XBt3F74cd
	YWY73HdkV9B+8V/Y79jZZS9brRbZBVb+YwyVaro5LnhlMLHdJPtNi/wKLgvzYb/AYSGjSfNixYI
	ULR13l/mKxtPBO4c8oY2RxoUQoc7NV1653zobkaTrL/wWamz9fkyz3tL54
X-Received: by 2002:a17:902:dac6:b0:28e:873d:8a with SMTP id d9443c01a7336-29091b062efmr52340765ad.15.1760617261282;
        Thu, 16 Oct 2025 05:21:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfRlQS9EzYg9s9bQgWqrn112aSvFuxMCv0HikwbAGQC1CVN68NjIUBB2QSbIqslynJpSnAMTbvjpqJn4N0VEc=
X-Received: by 2002:a17:902:dac6:b0:28e:873d:8a with SMTP id
 d9443c01a7336-29091b062efmr52340415ad.15.1760617260888; Thu, 16 Oct 2025
 05:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929133602.32462-1-piliu@redhat.com> <20250929135347.GH3289052@noisy.programming.kicks-ass.net>
 <CAF+s44Q4SDXPRfYc4Ms5TcJgRU07QJB5H5VOHvyrZ31x9z49nw@mail.gmail.com>
 <aNuEpt8IkvtkH9na@jlelli-thinkpadt14gen4.remote.csb> <20250930090441.GJ4067720@noisy.programming.kicks-ass.net>
 <45e40d5e-f0b9-4c77-af1e-6ac915518acc@arm.com> <aOOyF3EvIG5HKEel@jlelli-thinkpadt14gen4.remote.csb>
 <3408aca5-e6c9-434a-9950-82e9147fcbba@arm.com> <CAF+s44Tv1n0b1GSghSPP3xDPK4qzbzc629XMB9btzXuKgfKvcA@mail.gmail.com>
 <aO9q9EJbUw0QqbXv@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <aO9q9EJbUw0QqbXv@jlelli-thinkpadt14gen4.remote.csb>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 16 Oct 2025 20:20:49 +0800
X-Gm-Features: AS18NWB3JuGXZko5JNuk_5JmgYEtkHbTkHvk3uElUFgzVVDw0lTt7p6XPRhaeTQ
Message-ID: <CAF+s44Q_zOErWe11GydBnNKfntPV9LDWtAyvJbL533o7US3_aw@mail.gmail.com>
Subject: Re: [PATCH] sched/deadline: Derive root domain from active cpu in
 task's cpus_ptr
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 5:35=E2=80=AFPM Juri Lelli <juri.lelli@redhat.com> =
wrote:
>
[...]
> > > Then kexec to another kernel. The available bandwidth of the root dom=
ain
> > > gradually decreases with the number of CPUs unplugged.
> > > At some point, there is not enough bandwidth and an overflow is detec=
ted.
> > > (Same call stack as in the original message).
>
> I seem to agree with Pingfan below, kexec (kernel crash?) is a case

It is kexec-rebooting, not crashing. The crash just leaves the other
cpus in loop instead of offlining them.

> where all guarantees are out of the window anyway, so really no point in
> keeping track of bandwidth and failing hotplug. Guess we should be
> adding an ad-hoc check/bail for this case.
>

I have finished patches for this issue, but have some trouble getting
a machine to verify it.  I will send it out later.


Thanks,

Pingfan

> > > So I'm not sure this is really related to the cppc_fie thread.
> > > I think it's more related to checking the available bandwidth in a co=
ntext
> > > which is not appropriate. The deadline bandwidth might lack when the
> > > platform
> > > is reset, but this should not be that important.
> > >
> >
> > I think there are two independent issues.
> >
> > In your experiment, as CPUs are hot-removed one by one, at some point
> > the hot-removal will fail due to insufficient DL bandwidth. There
> > should be a warning message to inform users about what's happening,
> > and users can then remove some DL tasks to continue the CPU
> > hot-removal.
> >
> > Meanwhile, in the kexec case, this checking can be skipped since the
> > system cannot roll back to a working state anyway
> >
> >
> > Thanks,
> >
> > Pingfan
> > > ---
> > >
> > > Question:
> > > Since the cppc_fie worker doesn't have the SCHED_FLAG_SUGOV flag,
> > > is this comment actually correct ?
> > > /*
> > >   * Fake (unused) bandwidth; workaround to "fix"
> > >   * priority inheritance.
> > >   */
> > >
> > > ---
> > >
> > > On a non-deadline related topic, the CPPC drivers creates a cppc_fie
> > > worker in
> > > case the CPPC counters to estimate the current frequency are in PCC
> > > channels.
> > > Accessing these channels requires to go through sleeping sections,
> > > that's why a worker is used.
> > >
> > > However, CPPC counters might be accessed through FFH, which doesn't g=
o
> > > through
> > > sleeping sections. In such case, the cppc_fie worker is never used an=
d never
> > > removed, so it would be nice to remote it.
> > >
> >
>


