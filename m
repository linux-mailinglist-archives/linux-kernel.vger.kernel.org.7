Return-Path: <linux-kernel+bounces-775966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF6BB2C6EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1FD16F6AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D635F25C816;
	Tue, 19 Aug 2025 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+t9ciUt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC492EB85C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613310; cv=none; b=bwKBF/SpOqp4T82GlUhq/OVaNS0olP5H2oh25iSKk2F+xvThUHX55w5qmiHh/UuQj9GXWACAJxkLimEz4k1Z+9Bl1XjL81KlCoR00mZdw5sRFLGdtu6SOfHirQhwj/pUXcnuKjJg/+xs5oNyy7GaqPdu+3+r1rvY6+v0XbfzV78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613310; c=relaxed/simple;
	bh=XOUKbL9c1fsQJmNZIOS3EBrEfFuM4WEkCov/XwREjKY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RZTSp5MpVItq4mRLODpOw0ecFxujzy1Uy6OnWpGLWZYqtRdzpp324Gse1jk8c8MkeL+foEk+BE99gQ5xlCf8XqtTEu4pKWgprfq4ZRWM0B/5KhC+4QpWjm5XwjQe6hxFiMu8bxO4m8k3uXvjtnhj59s/W0DLoG+R0fJ5qCfDTyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+t9ciUt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755613306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nUhU9DSGZU/yy6AwTkkcshkjl3NkUwBzRiY8kqTbW4U=;
	b=a+t9ciUtscluYRwQqPfTXIc8RtF8AMiqzaDQ/kU17pE5aO2GWTangQ02cfrrMaemHklkkS
	W3dI3ghaBTzj4Evn2qy3WdW8QX7VMTpsptu4kNEdatOYlJ4v6Ifli7AsPTnBXntJZh6eDJ
	Q0yDGl+oA73Q92dfHSvHB2gf4j2taMM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-qsu1Bdd6Pi-sxfC1NCozOA-1; Tue, 19 Aug 2025 10:21:45 -0400
X-MC-Unique: qsu1Bdd6Pi-sxfC1NCozOA-1
X-Mimecast-MFC-AGG-ID: qsu1Bdd6Pi-sxfC1NCozOA_1755613304
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b0faa8d615so173074401cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755613304; x=1756218104;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nUhU9DSGZU/yy6AwTkkcshkjl3NkUwBzRiY8kqTbW4U=;
        b=seSKEhelLyMRYta9CT1DBHFR534fU964rm/kRvVN1f2NlapBx9rIAh5X7bg7qNWBwu
         HlYgfjJz/YOND9VEoFlOubjomxCgjIQALCVLBuSiwRLDbsXOM/onmtXmTZ3ve+GZgU9h
         WFOVUQEUqSm5dlNnznYDNhvEfbZdQx8axe30dzMJfHeBMlSuEulDRJAM4paagAb5nJS5
         Xy9K7Q/CyySFYRl1K8XTRLMGM2Eax+HmZ6xE0P+r2QrVJt4YX5imQsm7Kg7EC1x5e14M
         h57N4lHqC/SdFQM5ityafF+4c8FYzx/gZYF+rJpsty1YZZeAqYgXhgbe+XMQggGuRZuY
         IJgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrEQN73Q2J2xk9BRF7jyIcXK0cmmDkK+glDFhqGf2wqpAljsdqwbhrQ6qNfGeW4fBWucLekGeOKnDVoro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQzytHhPRF83o5dABwSPnW2lBoFZEo1cD2DgYzJIgNP1bYw35c
	l844fIW8ErVuegpOc14TS9iEyBFhpN1K8Jq6nuQE6/7FYDCDTjbZ/RVMevc48c8UmOfGlCuOtmD
	cSkUbLc0q+AJJ/9Sa/Dbl1PkgtybNJSiR/OQFbSfFCXLpw0GVIjbJdh/VoRoEiJ79fA==
X-Gm-Gg: ASbGnct5O7eWdo6ZUGGK9v0Si9Lz2MGou9nj4Pw8MNaAQ4UH5UfRodrGP3Ie9OFYhrL
	xxyPYl3zqWjhLvQCnlctCFOn8giTnig5xhN5U6Slyrd5F7fdfxrQxGKXAH1xMk7ARHPbnziBK+n
	roG4mHBhmGmkDXKd19O9FQR6RaH2b/AcHBQN8GcBzWLKnFidrtxkSO4+GsHYO9x9EaoTAFR1TXQ
	RRUFTYI083t3219tscn90k/cUQ7RjWbNlqZPd16rFGnDlmuKzbpmr0oKMCB69xvNKQnAURMtyaQ
	CZZDhiIgR+K/XYRvZSkYW4VrjPMoMRZf/o8/2TJ/vjrcdvJ9EamOPDjN77lqPH1kqw==
X-Received: by 2002:ac8:7e88:0:b0:4a7:7c8e:1d5 with SMTP id d75a77b69052e-4b28793dcdcmr25795971cf.17.1755613304198;
        Tue, 19 Aug 2025 07:21:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlEWKYvb8vXDaitNWomcBrcNyj5PURND2boadDXwEIYAViuSM0VK/J4vWJ6OG5xTccm3ZTLw==
X-Received: by 2002:ac8:7e88:0:b0:4a7:7c8e:1d5 with SMTP id d75a77b69052e-4b28793dcdcmr25795521cf.17.1755613303665;
        Tue, 19 Aug 2025 07:21:43 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc18fdcsm67982781cf.3.2025.08.19.07.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 07:21:43 -0700 (PDT)
Message-ID: <5ede208965844bdb69c76702ace5dfab5f8f731d.camel@redhat.com>
Subject: Re: [RFC PATCH 14/17] sched: Add deadline tracepoints
From: Gabriele Monaco <gmonaco@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Tue, 19 Aug 2025 16:21:39 +0200
In-Reply-To: <aKSD3Pm_9qqmEaNv@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-15-gmonaco@redhat.com>
	 <aKRKaTJBxD3kdt_G@jlelli-thinkpadt14gen4.remote.csb>
	 <20250819101244.GF4067720@noisy.programming.kicks-ass.net>
	 <711ff45f008bb4943418c40eba604e83858767ff.camel@redhat.com>
	 <aKSD3Pm_9qqmEaNv@jlelli-thinkpadt14gen4.remote.csb>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-19 at 16:02 +0200, Juri Lelli wrote:
> On 19/08/25 12:34, Gabriele Monaco wrote:
> >=20
> >=20
> > On Tue, 2025-08-19 at 12:12 +0200, Peter Zijlstra wrote:
> > > On Tue, Aug 19, 2025 at 11:56:57AM +0200, Juri Lelli wrote:
> > > > Hi!
> > > >=20
> > > > On 14/08/25 17:08, Gabriele Monaco wrote:
>=20
> ...
>=20
> > > > > @@ -1482,6 +1486,7 @@ static void update_curr_dl_se(struct rq
> > > > > *rq, struct sched_dl_entity *dl_se, s64
> > > > > =C2=A0
> > > > > =C2=A0throttle:
> > > > > =C2=A0	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded)
> > > > > {
> > > > > +		trace_sched_dl_throttle_tp(dl_se);
> > > > > =C2=A0		dl_se->dl_throttled =3D 1;
> > > >=20
> > > > I believe we also need to trace the dl_check_constrained_dl()
> > > > throttle, please take a look.
> >=20
> > Probably yes, strangely I couldn't see failures without it, but it
> > may
> > be down to my test setup. I'm going to have a look.
>=20
> Not sure if you tested with constrained (deadline !=3D period) tasks.

Not much actually.. I should start.

> > > > Also - we discussed this point a little already offline - but I
> > > > still wonder if we have to do anything special for dl-server
> > > > defer.
> > > > Those entities are started as throttled until 0-lag, so maybe
> > > > we
> > > > should still trace them explicitly as so?
> >=20
> > The naming might need a bit of a consistency check here, but for
> > the
> > monitor, the server is running, armed or preempted. Before the 0-
> > lag,
> > it will never be running, so it will stay as armed (fair tasks
> > running)
> > or preempted (rt tasks running).
> >=20
> > armed and preempted have the _throttled version just to indicate an
> > explicit throttle event occurred.
> >=20
> > We might want to start it in the armed_throttled if we are really
> > guaranteed not to see a throttle event, but I think that would
> > complicate the model considerably.
> >=20
> > We could instead validate the 0-lag concept in a separate, server-
> > specific model.
> >=20
> > Does this initial model feel particularly wrong for the server
> > case?
>=20
> No it doesn't atm. :-) Thanks for the additional information.

Perfect, I guess I need to write this a bit more clearly in the model
description.

>=20
> > > > In addition, since it's related, maybe we should do something
> > > > about
> > > > sched_switch event, that is currently not aware of deadlines,
> > > > runtimes, etc.
> >=20
> > I'm not sure I follow you here, what relation with switch and
> > runtime/deadline should we enforce?
> >=20
> > We don't really force the switch to occur timely after throttling,
> > is
> > that what you mean?
> > Or a switch must occur again timely after replenishing?
>=20
> Hummm, yeah I was wondering if we need something along these lines,
> but we can also maybe leave it for the future.

I'll have a thought about this, perhaps it's as simple as adding a few
more constraints on the edges.

>=20
> > > As per the whole _tp() thing, you can attach to the actual
> > > sched_switch tracepoint with a module and read whatever you want.
> >=20
> > Yeah I believe Juri referred to model constraints on the already
> > existing events rather than new tracepoints here.
>=20
> Separately from this series, maybe we should put such a module/bpf
> thing somewhere shared, so it's easier to use it when needed.

You mean some module/bpf to print those tracepoints to the ftrace
buffer? Yeah that might help, but it might be ugly and tracepoint-
specific.

Also perf probe doesn't support (yet) this type of tracepoints, but
once it does, I guess it would do the job quite nicely.

Thanks,
Gabriele


