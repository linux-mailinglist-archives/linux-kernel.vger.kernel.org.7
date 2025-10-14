Return-Path: <linux-kernel+bounces-852207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B77BD8700
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AB8D4FA636
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D3C27FD62;
	Tue, 14 Oct 2025 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaX/JHV8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2DF258CDF
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434218; cv=none; b=JlFLuCEwvGQutEeTVACSOZbLUu/OpZfkoqj4oVYQodG7g1Fli3cpikesrQafZLw3KB9LRXXfFET48rzOfLC43wr6sCIJYHFFW/ZZ054VZnYKgBrclemcuU9LFNM8P1ohpH8s689nWv/gNGLJ/bnlEZKt/r7RJ8/CkFkXfGee5LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434218; c=relaxed/simple;
	bh=eItn7A8q7B7vxvWEMsrtbyNjDzX1NpxCnWIDWwoscXA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qqFYdyLQ2OrJDUmlhBt1bvrewwteGi7E8X9PguibjVkA3ldN/o/28T+bKa38PHlYwL108AiZmzVMDbCYoWsEcFjWVU96plYe8lkt+iq6wo3XbcHoLhJVIWRmwzXJPV05OmucMT0EsTGcr4UuTOWuWRLO/c8MAdkJ/9M4fzDCpd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BaX/JHV8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760434215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eItn7A8q7B7vxvWEMsrtbyNjDzX1NpxCnWIDWwoscXA=;
	b=BaX/JHV8j18KqmjGYXkuQOfhMajTwATICjgV05HbWXqtn5CzSMFLpNkp66Sl/2b3OYzMPe
	Df0hyprWfyHr/ECC+xOSewVpp/cJuhKCjL1I1V3TsmxG5+dG53R+5fA7DgL5DWMWX/ECx6
	y4lAuz67Z8rXwVzh7dc8h1oGH+3pWsM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-pJj2mcFcMFGI-JCrVwhxDg-1; Tue, 14 Oct 2025 05:30:12 -0400
X-MC-Unique: pJj2mcFcMFGI-JCrVwhxDg-1
X-Mimecast-MFC-AGG-ID: pJj2mcFcMFGI-JCrVwhxDg_1760434211
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b5b37ccbeccso74329066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434211; x=1761039011;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eItn7A8q7B7vxvWEMsrtbyNjDzX1NpxCnWIDWwoscXA=;
        b=lj4ojlvrznp8owkvTAFW3Wf9Z9eoAVeqZzmJx9wZQc2fR+gzr9y/oXvHgLDXLUMVAa
         Kv1RyBKP/SqlmRwLJ7g6thICW9UsI1g94XnS3ASWl/SpaWJy0jSKt7BHC/hQ6GewPzTZ
         tVW5NasEfzI5gZIYs7KNHAHNSS8kh/HRlJ6IupVX+joPxmz74PMvqt0mVEFR2V/iEXWM
         jJSF9GQxsbtwKIZplmTxcoHQpU/NettP3qTjS04ByNxHphgRDcip6K6YgdPEVkGPEvoY
         i4UYbO5Ym5ZEkKLNzy1qfUqfaQ8y4Y7OysqrGyiJvNs9jHBhOeTXlu8cWrM4meK4lKjD
         suXw==
X-Gm-Message-State: AOJu0YxJx1vx/7AncYWAGCvaATNkUxqJRVAmMAZWldu+zfo2tBTMrI7s
	MYecVWein3Bo6zl1eW7ztmp+Tmu9ld+jpd31icxOhXSQpuUdDLZZCXBA/P6/p+EdfyxdGqeGjG9
	ry7ikjpTQElSJqaCSJ7abqawypbUq+Rk3TbWYUWp+zZe/uSfrZwIDT0eninr52mDhmGVdeS+CJS
	kvjSYbBsYQdgsDrPcBqbtY07r4gwcHR+dqVctBQFPnI//DejWWifI=
X-Gm-Gg: ASbGncswdS/oXz+0d7nsySL8zFnOK3JoZfi9x36Au739gTgN7anxTz1CUOHS4davuE7
	8RgXI1xQ1GOTYztRv8eQEjzYCL/5RrGh+nUUSubE+DVY0znzcUcT1XnLno+Lk7OgxP8+v4ZhwcQ
	e9gLKFL2Ne5MyfBQbA2vtYiovNuVby4tVJOsztg3Ir+rJ/qcqfQgUAHCrtItwfQxp24SMiF18D8
	O75kY4jIXVMN8p1MjMPeJ/8d4LUAZf9IYHvzETb6AnW533/XADqhk87loue3A0z4FZANT8eTIdI
	P2mect9FOtjkDfX5aJBgcI3PciIqasKO5rq1L2ExnMzGSsF5lyX43qAEjTQGCV6NDA==
X-Received: by 2002:a17:907:1c89:b0:b3e:aef0:8e36 with SMTP id a640c23a62f3a-b50ac8e52c2mr2627774366b.51.1760434210438;
        Tue, 14 Oct 2025 02:30:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhZA7thkk4N+xPz1SNS3PboN1B/AAyRj/FjscKjWF7kaXlY/kcKoCzd+KnDjdcvoBfiIyyug==
X-Received: by 2002:a17:907:1c89:b0:b3e:aef0:8e36 with SMTP id a640c23a62f3a-b50ac8e52c2mr2627769866b.51.1760434209710;
        Tue, 14 Oct 2025 02:30:09 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cad86csm1085343266b.17.2025.10.14.02.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:30:09 -0700 (PDT)
Message-ID: <aabc00bf64c30f8310b383e5a4f0484510b10bf3.camel@redhat.com>
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Clark Williams <williams@redhat.com>
Date: Tue, 14 Oct 2025 11:30:07 +0200
In-Reply-To: <20251007122904.31611-1-gmonaco@redhat.com>
References: <20251007122904.31611-1-gmonaco@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-07 at 14:29 +0200, Gabriele Monaco wrote:
> Recent changes to the deadline server leave it running when the system
> is idle. If the system is idle for longer than the dl_server period and
> the first scheduling occurs after a fair task wakes up, the algorithm
> picks the server as the earliest deadline (in the past) and that boosts
> the fair task that just woke up while:
> =C2=A0* the deadline is in the past
> =C2=A0* the server consumed all its runtime (in background)
> =C2=A0* there is no starvation (idle for about a period)
>=20
> Prevent the server from boosting a task when the deadline is in the
> past. Instead, replenish a new period and start the server as deferred.

Peter, Juri, what do you think about this change and "issue" with the serve=
r
boosting after idle?

Thanks,
Gabriele

>=20
> Fixes: 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
> To: Juri Lelli <juri.lelli@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>=20
> This behaviour was observed using the RV monitors in [1] and the patch
> was validated on an adapted version of the models. The models are not
> exhaustively validating the dl_server behaviour.
>=20
> [1] - https://lore.kernel.org/lkml/20250919140954.104920-21-gmonaco@redha=
t.com
>=20
> =C2=A0kernel/sched/deadline.c | 11 +++++++++++
> =C2=A01 file changed, 11 insertions(+)
>=20
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 72c1f72463c7..b3e3d506a18d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2371,6 +2371,17 @@ static struct task_struct *__pick_task_dl(struct r=
q
> *rq)
> =C2=A0 dl_server_stop(dl_se);
> =C2=A0 goto again;
> =C2=A0 }
> + /*
> + * If the CPU was idle for long enough time and wakes up
> + * because of a fair task, the dl_server may run after its
> + * period elapsed. Replenish a new period as deferred, since we
> + * are clearly not handling starvation here.
> + */
> + if (dl_time_before(dl_se->deadline, rq_clock(rq))) {
> + dl_se->dl_defer_running =3D 0;
> + replenish_dl_new_period(dl_se, rq);
> + goto again;
> + }
> =C2=A0 rq->dl_server =3D dl_se;
> =C2=A0 } else {
> =C2=A0 p =3D dl_task_of(dl_se);
>=20
> base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a


