Return-Path: <linux-kernel+bounces-733728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7D0B07847
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3331B166727
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1FD262FCD;
	Wed, 16 Jul 2025 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCeu2huI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E241C5D44
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676724; cv=none; b=V1QdN/QP8XQX/83cpAK+jbAyJrT0TrFQP2qQBv0Y+TE9xPuIvMfCrmJTSTtIVoRpatP2DZ20yKP6rQMvbcCRnm4Dj1wm1IaEyMq9eT7yuN1s6bh7JEdtcToSfVhewdahtf6w+LV3mjck2XbrniUOAqksZPgUep847qC1l8Fwoog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676724; c=relaxed/simple;
	bh=pootL239b8vihYx7ghu2E071YuSYjSAykBGJJk4PkvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LE+9djbIJl1ndCCtIMwDsnaqXYkiYesnrxr9fupRigM9ztPQl5vI8QzE521IVIgsKm6MnfBdZThlMYhpnz0PPBvZgVaMO5njHjvwvuEciUeVp/PZPehz6PjzYiJBfo9sXix6hcFD1udqbbZLomTs3cfmgjiG3fmp4p95+sU7pg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CCeu2huI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752676721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pootL239b8vihYx7ghu2E071YuSYjSAykBGJJk4PkvM=;
	b=CCeu2huIkdnX9tegEbzp68sLMbeJ8Fn+ONhJSWNaK4RrmRA1z/Twourz+elKhBQn3/HTPR
	KYR9vJghJdvmeZ60GE2uTU9//o6Ruh2Qb2kmA821IfZV4E/dMp/RPTWZUNU2BSOBo6uF3J
	BnDdBCkcRg3gWhAxBhv/XCWxHCxBkmg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-L_TkA5MYOiO33p_Ous5R0A-1; Wed, 16 Jul 2025 10:38:40 -0400
X-MC-Unique: L_TkA5MYOiO33p_Ous5R0A-1
X-Mimecast-MFC-AGG-ID: L_TkA5MYOiO33p_Ous5R0A_1752676719
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so3059429f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676719; x=1753281519;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pootL239b8vihYx7ghu2E071YuSYjSAykBGJJk4PkvM=;
        b=dFarkwC30Tej+2TB4oWhD/gUpF6Dm2FiDBE+RgJiP2U0iaHxvrGOKkjxFuh6FGVXou
         AkgNMhe31ekfdeRNzbv3ZtP/l2Oaxe6/4QhJpTU+PEfIIgGnZcEH3/Ub3BRkQekom2IP
         LM7KkXBsb2scO9fj0F1T4myN4gNS8SqyBN5g2BMcbk02bpbrY4XcpSk5tFfAuVVoxFHr
         uTNnOHYmnKPrefz18G4b813h4RR5RX3gE8Usjn7bVJNrwUz+R6DWBnyebR4XIP12yNue
         LppctUpiZiVkvnE7Z77dSF9mCmxaxoZp7S6/0TqWq6a5fKnxG7G4iAYPSjHRp7/ftQmU
         e/iw==
X-Gm-Message-State: AOJu0YznatxADf8pRYR6qwtJvaNPgakl1aS7/HbZVjoPTz2svLLEXzlt
	5KidQ+r9yihNMjIxsCSubbkLcB64JhqNE55BsEcr3CmZp41L0fMOZ9xcgwyRUG/tcuGY/b3znok
	+DRXXTWJkwFO6rZpIPV3IAuSiIkP4BDTO6y3FAkA7AlVDvhCsI+KrTU8TMtrcDe/N5A==
X-Gm-Gg: ASbGnctFh2eNDxlee13bVXOdzXe22iBpXJFpmi40QaI/e7VRvT+j5/H5567+/L9ttgH
	7d42dnEpogX37ZtZMHXayxOxs7vNGrzacC9BKC8ZD30+6FL9LgoqB9ROFhj258/cbqzHGCudhB3
	SXh8s3qaVNOeDQFg4MNt21bnwED5QXNzWjgswAJM16zZoXn1CecavbWmXTi8R1C5IeYHQJv0SxM
	WOIGhqv51dwzRDu+Rd3a3AB2f7DVgEhl17OTTE1dfa1HKHQDlwDz5YmVcTfJcPnSxri+YtHBsR7
	GxXXqvyan3rLCCX/ZXOnBYieIDGSLe5saHBw1K9DZChmtwUtEIhjEx4JMv1JVhg+tQ==
X-Received: by 2002:a5d:5f50:0:b0:3a4:d53d:be20 with SMTP id ffacd0b85a97d-3b60dd54803mr2670864f8f.18.1752676719004;
        Wed, 16 Jul 2025 07:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFptKKgabK4YSBzr4A23TCNpKLWSztNfIHJhjjgHgXZXCD1z41s30Edp5+SqPDwLIWCpRXH1g==
X-Received: by 2002:a5d:5f50:0:b0:3a4:d53d:be20 with SMTP id ffacd0b85a97d-3b60dd54803mr2670833f8f.18.1752676718428;
        Wed, 16 Jul 2025 07:38:38 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5f16a6016sm16163068f8f.69.2025.07.16.07.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:38:38 -0700 (PDT)
Message-ID: <be966ed3d4a7ace6aa430bbc5c16ecbff3118426.camel@redhat.com>
Subject: Re: [PATCH v3 12/17] sched: Adapt sched tracepoints for RV task
 model
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 16:38:36 +0200
In-Reply-To: <20250716141958.GC905792@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-13-gmonaco@redhat.com>
	 <20250716123832.GW1613200@noisy.programming.kicks-ass.net>
	 <122cfd4ba6b0805e91ff09526d5d159ff3871964.camel@redhat.com>
	 <20250716134513.GB905792@noisy.programming.kicks-ass.net>
	 <fe38ba0b9da0209bcc97c2f348f5a6b266991073.camel@redhat.com>
	 <20250716141958.GC905792@noisy.programming.kicks-ass.net>
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

On Wed, 2025-07-16 at 16:19 +0200, Peter Zijlstra wrote:
> So in general I'm a minimalist; less is more etc.
>
> Even if you care about latencies, I don't see what that tracepoint adds. =
In
> fact, I don't even see the point of the .is_switch argument to
> trace_sched_exit_tp(). That state can be fully reconstructed from having =
seen
> trace_sched_switch() between trace_sched_{enter,exit}_tp().
>
> As for the IRQ state, if you see:
>
> =C2=A0trace_sched_enter_tp();
> =C2=A0trace_irq_disable();
> =C2=A0trace_irq_enable();
>
> You already know all you need to know; there was no switch, otherwise
> it would'be been:
>
> =C2=A0trace_sched_enter_tp();
> =C2=A0trace_irq_disable();
> =C2=A0trace_sched_switch();
> =C2=A0trace_irq_enable();
>

Or you could see:

 trace_sched_enter_tp();
 trace_irq_disable();
 trace_irq_enable();
 trace_irq_disable();
 trace_sched_switch();
 trace_irq_enable();

Where in fact there /was/ a switch, that trace was actually something
like:

 trace_sched_enter_tp();
 trace_irq_disable();
 **irq_entry();**
 **irq_exit();**
 trace_irq_enable();
 trace_irq_disable();
 trace_sched_switch();
 trace_irq_enable();

So as you said, we can still reconstruct what happened from the trace, but =
the
model suddenly needs more states and more events.
If we could directly tell whether interrupts were disabled manually or from=
 an
actual interrupt, that wouldn't be necessary, for instance (as in the origi=
nal
model by Daniel).

I get your point why we don't really need the additional tracepoint, but so=
me
arguments giving more context come almost for free.

> Also, can we get rid of that CALLER_ADDR0 argument as well?

Yeah good point, this might have been be useful to understand some things
(__schedule called from preempt_irq for instance) but it's a pain to make s=
ense
out of it.


