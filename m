Return-Path: <linux-kernel+bounces-733629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B89B07725
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23533B57A3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689F31CAA92;
	Wed, 16 Jul 2025 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNh2XQXC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEB81A239A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673224; cv=none; b=vEFGbV5PPvRTZhW9yP65ZoHm0/TRgOLbQn5zrdwB4lfoU6Q569uwKwcemCUZzutCkLbGAZ4oJw3e/soTrRNMFMfB2RordTw3VOWWwhDbujCWPP1iNvcJ8ytROza6jVeCDL2LD6ace+DBBdUxOpcnUSzU/dfm4lsjWrI5DktgL7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673224; c=relaxed/simple;
	bh=mci04I/2tYiHrifCVAsUGK8dxnsaRuyRPcW4Mq/pc2Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PntzZuVKXpIzrt/JMoTn+xQkOFVsUXSYqBcNiBCVKc82Is2OoZyDh3a1vJLv56+BhvBmTfmvsdovJ9kVlGDAPo4eqtL28qUJl12/8QNwBe4GGnx00h8aybBlUnUho8X77+HkF/YHxAICVv1Z2qpYQ5LbQhEavbRAIwp/fnEGANM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNh2XQXC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752673221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6xcsjq/dO2PUW1+oxW2qeKYxLQBhQLnckvL4DMbD0J8=;
	b=VNh2XQXC9budNsEQgVIqURZwP10pzYlSzKxhStXQmrQsZma5Wc6Dc/nenwCwdJJro2RhHz
	zNLo3egv/WaXS94izi1ESefXrT8HPD3zIQHzGhEYfNjm6dfE5paIeYub+L3loIP5ohcAmK
	kCAjgmU1Awl9Osg1qWXVa821/Ot2JsE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-Nmak_ka4NWqupw8umLBUIQ-1; Wed, 16 Jul 2025 09:40:18 -0400
X-MC-Unique: Nmak_ka4NWqupw8umLBUIQ-1
X-Mimecast-MFC-AGG-ID: Nmak_ka4NWqupw8umLBUIQ_1752673216
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4560b81ff9eso27120505e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752673216; x=1753278016;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xcsjq/dO2PUW1+oxW2qeKYxLQBhQLnckvL4DMbD0J8=;
        b=d554M2KoxtOnCt8lhjgkszkC3nWqXQig1499/N18h/5hKnPJj2edspG4aeGQC67LHw
         F8Eiw6q2XfXZf8HVvVT48KgjIt+BByO2NeJN2UpGhVJ8/6YN4PpBLnBuuwXdA+E/Wq+U
         sUjmaI/43wW6xev5YKNIJy+Lc37yDsDxwpdCde7tLBme2VIzevFySvJ3Gqrr+tKn63Fa
         x2MfnQPD9/J1vMnhO46P8un8s9AbE+UJGvY6K3RSK6z2h84tnIfZLr/h+TXwFuftNobn
         78rhsKHOeZQbUU+Ar8DD2Y9cOeQ5s9yEey9l+TOwBXBkzfJCDEzSS0niruKKkqKob3Hd
         Gkig==
X-Gm-Message-State: AOJu0YyKtjsKDHybqI6dAy5nHiaULvdjJMCnKi25xSJNf0xlSuARujhA
	1zbROVl/4S8NFyJhWVoXP/Xk+VUMNuSek7UEO7855A58HONKoMjO3Q1mgrgyz3npIMbWYQN7pi8
	ITN4T7hBl2tMaALl1LvPGDxi//YUzI5Yo6f8xvem4c92BZdp9Cy+03SKMpos5Vs87QQ==
X-Gm-Gg: ASbGncvTLLifPfQVSOfNIvaNZHA3kf5YJHWNa6LlVcZGysfDsWnZ5NF8y/GhgbOeu4j
	BS8Ue+TXFSlEF66EVRfl+aP4fBmBrV1KjD2CkBfJn27dLZala2UrshApLV1Zet6neM+2UUrTaAA
	k8iMkuwVE1a9Duvyql7no1MRf20qcZ5bk48tX4Hwz1b+hgD3/zHAaNYg8ggncwIittwLN3nJzns
	QGPkHost5aQpcMx/THJw/t0KyA7Feoa6XR9p0mvdrIqm/3pBbmaqpHZ937741E1BSO5I8gh8ZEx
	2d8sphYiu9FbgK0jOczfRFnis+80UvwkTZEaFwHo2qZ+QhBSTxhlYhCYEyLfdZeEyA==
X-Received: by 2002:a05:600c:4590:b0:442:c993:6f94 with SMTP id 5b1f17b1804b1-4562dfe7998mr35600115e9.12.1752673216018;
        Wed, 16 Jul 2025 06:40:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmL4ysrFH4w0DELpct967Iu0YF4NtKCmmoy2wzP/5le1HZ4rifdgWb0k5u+DI9u9En6Wo/hg==
X-Received: by 2002:a05:600c:4590:b0:442:c993:6f94 with SMTP id 5b1f17b1804b1-4562dfe7998mr35599565e9.12.1752673215500;
        Wed, 16 Jul 2025 06:40:15 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14e82sm18042152f8f.71.2025.07.16.06.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:40:15 -0700 (PDT)
Message-ID: <122cfd4ba6b0805e91ff09526d5d159ff3871964.camel@redhat.com>
Subject: Re: [PATCH v3 12/17] sched: Adapt sched tracepoints for RV task
 model
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 15:40:13 +0200
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
>=20
> > @@ -6786,6 +6793,7 @@ static void __sched notrace __schedule(int
> > sched_mode)
> > =C2=A0		rq =3D context_switch(rq, prev, next, &rf);
> > =C2=A0	} else {
> > =C2=A0		rq_unpin_lock(rq, &rf);
> > +		trace_sched_switch_vain_tp(preempt, prev,
> > prev_state);
> > =C2=A0		__balance_callbacks(rq);
> > =C2=A0		raw_spin_rq_unlock_irq(rq);
> > =C2=A0	}
>=20
> Hurmph... don't you already have this covered by:
> trace_sched_exit_tp() ?
>=20
> Specifically, the only case where is_switch :=3D false, is this case.

Mostly, it may work in some cases, but sched_exit happens with
interrupt enabled while all types of switches (including the vain ones)
must occur with interrupt disabled.

Some assumptions don't stand without this tracepoint, but I guess I
could adapt monitors to live without this if you believe it's not worth
adding a new tracepoint there.

Thanks,
Gabriele


