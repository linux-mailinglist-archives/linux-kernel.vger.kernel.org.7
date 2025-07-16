Return-Path: <linux-kernel+bounces-733803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DDCB07924
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F414E60A8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4290F270EAA;
	Wed, 16 Jul 2025 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPvoZhqY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B2523B634
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678592; cv=none; b=grT8RlDKYEzgjs+C0sMx3dgZAjrW2rLLNd8GdbW9XLn5COH3sILPcfnHs+j9L/EfZrrvFU2U5j9DzOK5fbdmwxsDhzvaxHOhD8g2IqwwTqemqWLjfQWpT9274IgmAag2NQNGdI/yUjFU6cQxj6/U2He1xUE4qZFyqb1ksmyWsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678592; c=relaxed/simple;
	bh=XySbjKSxbMI4UnXP0UvzyT+Z0Pv8xivpaESVVvOfiEY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LUVnAeIPZW3LiTi/u3fYVe/RXIpeGk+UXMsiVMmAGXTLQ/eTfNcfSC3hjT3p0quitG+nmQLiOfSypopojYsFBFoeQDnNAJmlUjuK1151EAQgMiI0hvpbb0HDIc51xPuS8aB8agG1D2gUEW1DhGV4v8ONnpMPq1X2qMYNVTH4/YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPvoZhqY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752678589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s60Sp6skjO7MztEg1NVdWh+PMYIugCHc0j0VBqr0PaY=;
	b=JPvoZhqYG/6ItBG/ByIc0nmGhU8LUrWy2Nj4Mjf6OpshBknTHhqgztw2MgIeSBRjRCnRBw
	iUVzuYwiDY61W4AqdCWBBBVSsB1Z/G8sUVf9Q/Al2zJ1j03W9tfnm82rMKSD02q2/dd3IC
	XYLmcSd8odoInB2u35xwNga09dyyrc0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-66NcDS6cM8WjNEbHnainlw-1; Wed, 16 Jul 2025 11:09:47 -0400
X-MC-Unique: 66NcDS6cM8WjNEbHnainlw-1
X-Mimecast-MFC-AGG-ID: 66NcDS6cM8WjNEbHnainlw_1752678586
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b604541741so2260208f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678586; x=1753283386;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s60Sp6skjO7MztEg1NVdWh+PMYIugCHc0j0VBqr0PaY=;
        b=YTHQLrdQCeSOgflD1zRVk+GFuDqjxnSBXm5ErmXli+3K2spNRmoisH8NjghZmIeRiu
         g/PMEhaHtSNRFEi68yC5rC4BJqwPzoHilvnMoE9VI4MuYiN2TFYVHGZ3yZOFdZGDffPr
         eoFp3yGzm+WXTmfFRuIb9fG4tdFTpoxEDGZt1pjumGE7l4lb3DQHvijuRN9zvjHRSvQ5
         4b/KC9cKwTWcpL9kEipni0xukhEwlUxSg7gEVC9mb+2/Br7JPJ5hx+RpWA3sqJGaNCEV
         FovCTobrfsOwqMj5ssYKw4N+JO+35i1envd0wHwhIaGVKZsUIMLMXNE+B5dPz3hXEMcr
         EiGw==
X-Gm-Message-State: AOJu0YwFDbixz3uAG5zRgpD+LxD0rJAou+LwfG5mYRsGzl4pwdAd66i7
	a4ZI2WzjCfaIi9OC7zBXSYLNeEwPnM7jy/LOksOmBlV9v9JbOkW5MtmhHLlpklc9qY1s4zbROc9
	wSUuybKCdz+x7SNMp+F4VZxs2rY9pFFPHjj5m9qNlLirpG8NShGyZJhqhc37x12yETjakkPuMsK
	2T
X-Gm-Gg: ASbGncs4L+lMtutCvUJ9Wet1KM/WH5Vkky051kTJh2XafIVNNrV/dS18OSQqFWlxLxd
	x+bb99WQ8p/Hh4T+gseXuHn1JTEe7S3ti37tWhGuGSLzTHCT++HyzWbRJ8+XHD5L+4FNkaCndXl
	BluieAK8h07/7TS2R0LhRGQonz0ekmj3URLdl2jTuli/bHSbLjagwslsl4Puz41nhMZ1GA4Uoj4
	t7AHEmFucSFzy/Ot/wf0Y9xSE+IxUaEmG/BuDsTckENyEvSWCRA/SwqLKlLDD5w3sTrT1NuApge
	2dFUI9poVbf+Ysp1W99pezmt2r061PhOBgOyNnuI2jdVbYPnZaeU6BYLeBd/ShAzOQ==
X-Received: by 2002:a5d:5f4e:0:b0:3b5:e6c0:1678 with SMTP id ffacd0b85a97d-3b60e52451dmr2476741f8f.45.1752678586315;
        Wed, 16 Jul 2025 08:09:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8tq87kRXSdlB+5Kbof387zmqH3pRO5qbk4swo5Gnn+EKJzZUxNtFjV0EHj+7pRXCTD5Wz/A==
X-Received: by 2002:a5d:5f4e:0:b0:3b5:e6c0:1678 with SMTP id ffacd0b85a97d-3b60e52451dmr2476719f8f.45.1752678585835;
        Wed, 16 Jul 2025 08:09:45 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2147sm18242526f8f.32.2025.07.16.08.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:09:45 -0700 (PDT)
Message-ID: <cbb840b204f7de7e6304bc811e9c629eb0f77486.camel@redhat.com>
Subject: Re: [PATCH v3 12/17] sched: Adapt sched tracepoints for RV task
 model
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 17:09:43 +0200
In-Reply-To: <20250716123832.GW1613200@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-13-gmonaco@redhat.com>
	 <20250716123832.GW1613200@noisy.programming.kicks-ass.net>
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

On Wed, 2025-07-16 at 14:38 +0200, Peter Zijlstra wrote:
> On Tue, Jul 15, 2025 at 09:14:29AM +0200, Gabriele Monaco wrote:
> > Add the following tracepoints:
> > * sched_set_need_resched(tsk, cpu, tif)
> > =C2=A0=C2=A0=C2=A0 Called when a task is set the need resched [lazy] fl=
ag
> > * sched_switch_vain(preempt, tsk, tsk_state)
> > =C2=A0=C2=A0=C2=A0 Called when a task is selected again during __schedu=
le
> > =C2=A0=C2=A0=C2=A0 i.e. prev =3D=3D next =3D=3D tsk : no real context s=
witch
>=20
> > @@ -6592,6 +6598,7 @@ static bool try_to_block_task(struct rq *rq,
> > struct task_struct *p,
> > =C2=A0	int flags =3D DEQUEUE_NOCLOCK;
> > =C2=A0
> > =C2=A0	if (signal_pending_state(task_state, p)) {
> > +		trace_sched_set_state_tp(p, TASK_RUNNING, true);
> > =C2=A0		WRITE_ONCE(p->__state, TASK_RUNNING);
> > =C2=A0		*task_state_p =3D TASK_RUNNING;
> > =C2=A0		return false;
>=20
> I'm confused on the purpose of this. How does this relate to say the
> wakeup in signal_wake_up_state() ?

Also this adds more context: models like sssw (in this series) expect
that, after a task is set to sleepable, it either goes to sleep or is
woken up/set to runnable.

In this specific case, the task is set to runnable without tracing it,
so the model doesn't know what happened, since it may not see a wakeup
after that (the task is already runnable).

Now I'm not sure if there are other events that we are guaranteed to
see to reconstruct this specific case (at some point we should see the
signal, I assume).
This just simplified things as that is the only state change that was
not traced.

Am I missing anything obvious here?

Thanks,
Gabriele


