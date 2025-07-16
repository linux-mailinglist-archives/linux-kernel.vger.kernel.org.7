Return-Path: <linux-kernel+bounces-733939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE118B07ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B011C41C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E562F5333;
	Wed, 16 Jul 2025 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WY0+v93P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA020274B30
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682489; cv=none; b=Rle4cIp/zPg6BJs9jD4niVGAd8RY5j3xf8YVBMANiEkfQAnuA6u3eYIDUdWeHSF58va4ROUVZD2qc0uegjX03RnrkvdoxgOPONY9JWIS5DOPdxshvoBIbPAgumoi/zAQRiCNDFpw2/ln7+30TBJM+TMjfH8uDy/chS9x0CtwP9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682489; c=relaxed/simple;
	bh=caPQsxMaBKfuAJUhMxcZI02W5/m/8IxsrRwhRieczQY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W8Q0MSNn5vhv+MI15keBhUDp9ICGtDTmTYRMtWZDG4/mu1eJRz6elWP/59hL6SRohRi6+tvVvPaEE5CNZAkNuytWxJWeptkDGwuIksFCqhwuKFdsw9aIUpV8/eQ3z/uqW83miQQgkJIDauy+PR/vDr+aWP3+nHPUBrGtRGJ3AUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WY0+v93P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752682486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=caPQsxMaBKfuAJUhMxcZI02W5/m/8IxsrRwhRieczQY=;
	b=WY0+v93P+kmRBfxUAWvs2/8XAzl4eMPURulPZ5MqUDFVvs6DY4kNLqRssPgPdVrqUnYk04
	n8++fGu/meD6PEjf3fHEz57msD0MP90O4a4PDJpW/L9Q0l0S3jb9IB69s+acYX7XyPbz0L
	6t6iTA+BjBLJFkz/7u4ZjKZaWO9Qxfs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-2pb09oE-PZ64TPlltumASQ-1; Wed, 16 Jul 2025 12:14:45 -0400
X-MC-Unique: 2pb09oE-PZ64TPlltumASQ-1
X-Mimecast-MFC-AGG-ID: 2pb09oE-PZ64TPlltumASQ_1752682484
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a5780e8137so526506f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682484; x=1753287284;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=caPQsxMaBKfuAJUhMxcZI02W5/m/8IxsrRwhRieczQY=;
        b=nelKWGltElVLj56hEtR0nhMMBRie7zFffkW8yeCEsmN6yaLHldpYzNmfBVfht4b01T
         C2d/2I56UGHITB/y8oXYkuWg5OsakzpBTBY0Vo2zql5VaYEhZTIzJSZq5b4II7XiaS1G
         MtWz05vJNS9XDRt15FhdWUkonbmjVCG010DLsBphh01AQAZibifB4mHqR1RfDXl1zO4H
         whpoF/ft1vkl6oHduuceGVQj4mpo2IMDj8oaQ88sMdFBMKMtYvo4mmrgF20W1fkql7pu
         uaqd40rfC/DWpYZGn/K01dnaoy8b1tVQD5HRfb5PVy6j4vv6NDezvc72sd5WpZP09yQN
         OnFQ==
X-Gm-Message-State: AOJu0YwRm+Df3QlE9IrUljR1y6xlAOBNE3dllnAgRDhR7GTeub3VZzo7
	q6eHEJB+6lq5BgLO2pSkMGSCGYQODIPcfMmqdFvIg0/9HXg+xL3UKgvsAp5Zmlqme89Exs2urX1
	ltkBAKi7HBB5FaJ+ToQPimTzLSxcUCd8AIYRtB/4PWSAiioRWSvbC8e99BvVHS2nxYw==
X-Gm-Gg: ASbGncvkmUJ/k9njXiPbQ+FvBe23D8NjjWWNhAnp7KZ162jNsJgWGhrR1zenR/uLT+c
	7ssKzjkqWPTRgDd0kxlFUfTBu+QjrCP5Reqac2SRBypD75o+gux6f1M8IxziyYhca3swGhZBVfz
	nxfYmQRP6OkjkUJum8dB8UglVnEgIZaMDjabGZYPG5JSYSVSPuuyJO/vVfIZD7rv+irgHVKvxTq
	3q3T8ZR5ttgYgHne3x27REUQRlcOI1uz4p2zgQoiVyUEa4powuHNrM1OWSwnt9ZKdPv1NKeWube
	C2xtHRJ0Tmbjo8Ys32HZYIk49mb0BlHnQprRkNxwQnxQONuEdiwBhXimmWP9SldI8A==
X-Received: by 2002:a5d:61c9:0:b0:3b5:e077:af52 with SMTP id ffacd0b85a97d-3b613a23674mr20537f8f.25.1752682483834;
        Wed, 16 Jul 2025 09:14:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBt7nrUXuBFgPX3anXe0tcehLEJl16049ahtmmdy0QKOqK7pYfXdmuoS7eEKIXQnFLYIFwag==
X-Received: by 2002:a5d:61c9:0:b0:3b5:e077:af52 with SMTP id ffacd0b85a97d-3b613a23674mr20511f8f.25.1752682483409;
        Wed, 16 Jul 2025 09:14:43 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2464sm18650429f8f.38.2025.07.16.09.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:14:43 -0700 (PDT)
Message-ID: <1da3336a234fddcea9dc91f5ef9943e7ccecc07e.camel@redhat.com>
Subject: Re: [PATCH v3 12/17] sched: Adapt sched tracepoints for RV task
 model
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 18:14:40 +0200
In-Reply-To: <20250716153144.GY1613200@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-13-gmonaco@redhat.com>
	 <20250716123832.GW1613200@noisy.programming.kicks-ass.net>
	 <122cfd4ba6b0805e91ff09526d5d159ff3871964.camel@redhat.com>
	 <20250716134513.GB905792@noisy.programming.kicks-ass.net>
	 <fe38ba0b9da0209bcc97c2f348f5a6b266991073.camel@redhat.com>
	 <20250716141958.GC905792@noisy.programming.kicks-ass.net>
	 <be966ed3d4a7ace6aa430bbc5c16ecbff3118426.camel@redhat.com>
	 <20250716153144.GY1613200@noisy.programming.kicks-ass.net>
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

On Wed, 2025-07-16 at 17:31 +0200, Peter Zijlstra wrote:
> On Wed, Jul 16, 2025 at 04:38:36PM +0200, Gabriele Monaco wrote:
>=20
> > So as you said, we can still reconstruct what happened from the
> > trace, but the model suddenly needs more states and more events.
>=20
> So given a sequence like:
>=20
> =C2=A0 trace_sched_enter_tp();
> =C2=A0 { trace_irq_disable();
> =C2=A0=C2=A0=C2=A0 **irq_entry();**
> =C2=A0=C2=A0=C2=A0 **irq_exit();**
> =C2=A0=C2=A0=C2=A0 trace_irq_enable(); } * Ni
> =C2=A0 trace_irq_disable();
> =C2=A0 { trace_sched_switch(); } * Nj
> =C2=A0 trace_irq_enable();
> =C2=A0 { trace_irq_disable();
> =C2=A0=C2=A0=C2=A0 **irq_entry();**
> =C2=A0=C2=A0=C2=A0 **irq_exit();**
> =C2=A0=C2=A0=C2=A0 trace_irq_enable(); } * Nk
> =C2=A0 trace_sched_exit_tp();
>=20
> It becomes somewhat hard to figure out which exact IRQ disabled
> section
> the switch did not happen in (Nj =3D=3D 0).
>=20
> > If we could directly tell whether interrupts were disabled manually
> > or from an actual interrupt, that wouldn't be necessary, for
> > instance (as in the original model by Daniel).
>=20
> Hmm.. we do indeed appear to trace the IRQ state before adding
> HARDIRQ_OFFSET to preempt_count(). Yes, that complicates things a
> little.
>=20
> So... it *might* be possible to lift lockdep_hardirq_enter() to
> before we start tracing. But then you're stuck to running with
> lockdep enabled -- I'm thinking that's not ideal, given those other
> patches you sent.
>=20
> I'm going to go on holidays soon, but I've made a note to see if we
> can lift setting HARDIRQ_OFFSET before we start tracing. IIRC the
> current order is because setting HARDIRQ_OFFSET is using
> preempt_count_add() which can be instrumented itself.
>=20

Yeah I wondered if that was something perhaps required by RCU or
something else (some calls are in the way). NMIs have it set during the
tracepoints, for instance.

Thanks again and enjoy your holiday!

Gabriele

> But we could use __preempt_count_add() instead, then we loose the
> tracing from setting HARDIRQ_OFFSET, but I don't think that is a
> problem. We already get the latency from the IRQ tracepoints after
> all.
>=20
> > I get your point why we don't really need the additional
> > tracepoint, but some
> > arguments giving more context come almost for free.
>=20
> Right. So please always try and justify adding tracepoints.


