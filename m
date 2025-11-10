Return-Path: <linux-kernel+bounces-894212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7B8C497BD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A86188A36A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C052F5A3C;
	Mon, 10 Nov 2025 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="qQZPj31e"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819E28980A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812400; cv=none; b=FKrWKssZQEQSFuBJv2j/F+HKg6eTHZ9IvHvcB9hKogk93lW4BUSejxoI0r5lOxKL0EH4bREkS8sby8tyRUfUt5fn0syaRHwUDaWxtD1iRXvIKIcHsAt2UhKENHxfRYpfIR5ydHRLXXaiJGPVuF3WDSKhdl1oo/yloeh1SxOvNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812400; c=relaxed/simple;
	bh=rYhUBnvwT+ub027fXUx5R6wsKiOlOm+VBlO4fl6AhFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4RMgyk1P5S3HGgBd6KF2l34lr+3edj3Br0oPag8ixfmZKDbqSYmjLDz3AV0TP9OgiZodzyjG1SxXw3nRgKNi5pmvWei653aB0SUqx33aIFm5BMrOklMqZ07VTyfHVbg8y608eNgWjB4NDcTXNO3hFntwvf5bH2yOvYRFtRnYb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=qQZPj31e; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-786943affbaso26775017b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1762812395; x=1763417195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4f9Zy+Xxr8e4Nr+RON0+4DZk9ZxxU3ItskZZmBVohc=;
        b=qQZPj31eNP9l/okgyltIVFWSQC7i1dKDsYslXbsAwC/8x45ar5FCQQo8E+UVs8868L
         xOnQGozp7w8f4uBcvN+hd81jNsbQwirPYtc8EVV5DMCjU1fOxj5nkaa8YWDTQOFEdquO
         FN6WwXw4sW2fAPKJaM/Bt+zpSAWDOIabGbbXR4+2fyfH+Xa3kRTWh7fNtXCNIg0n0Dve
         dpP9Fn/q3ler80nv5zRYtI5EKqUkAp6XB+IvT5btxQpgekr2UPDWEGEr4/Ypuct7Fr3+
         xpy5XnOyPtr9EUDcKJ15Lsyr6K5VK8QXpS1GuLepzyEhwZGqz61Wn+gomxgmNlZQ1MdV
         2Jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762812395; x=1763417195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V4f9Zy+Xxr8e4Nr+RON0+4DZk9ZxxU3ItskZZmBVohc=;
        b=Zdi2YHv59O10IVEYfpbJK/LTOAp+OjgJ6t3y9uukLcBjbrZs1uRkPsKoyNVNw26jrx
         QsgSqW9j4Z5nW7mpGo/JNbzzNjebunOYtCM8GN46F0HZcVk+aiuZ4PEiQ90mi1qapwRa
         RBnPyAI6rDrdKCT28KNlSOKbyeczX+RVGtIYiJI56/yxl/ixvHHLZ421FjId+GY8zWh9
         AAu9enUKZEDC+BnCDrNtan/79hhiT1gJ9Po1lU5iQPqGRLhFHPkRqe42e7k39MURFbLY
         YbBmB+S/wJC03sYgytXsFxmZOCrjWrjXJ0q5apDSvDIJg1PXK++9sntpaTSrUVQV4D2t
         D8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCV1dh6LILApuWGSkfAgGIEwtYVBis4rIstDbROo416DPcreDuZ+wdND21+zI+yZeVQI8G46p/sS0yAfH5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEIvmuIeoN9EcnDHJABNZYbAzPnjoSYVie5YvotJ6YDrv5PmS3
	Jho3jZfjhg/yrm2MDmpwVKDfXr1BtbhZTg+d5mEfhEDh2YLtrygU9gEccevmkYho8xwXQZqPJLM
	vr8pA4VYpEHqCaD6yKTMxMpcjyRua6PpLwkRt6fYaCw==
X-Gm-Gg: ASbGncvJ7SJr8CGePGiS0PQVmRcHFDDsqUarrJoWsT0NSIyPfDPJR3GOXiTQcJZsd6i
	Gpj6a7Hj+fifv5X4rBV0Zp5ONHxQGzk8ei8jC5Y+quqF9syReBLXG4Wz6QN6oa8uUC+WuLrSY7C
	Rd8SXV6QKvXPHYQQFkl+PXzRZvUdlIpdd68qW8o7vF1GLsx/096ag3a/I8kntzHmJjN8L0+9pTq
	0YuUjuI8XLt5wPmTLPzcrZvFENSySqHB2ZlrvZxYQjs3mxPgYp01eq9blp0YjNZNHHoYY3VRg==
X-Google-Smtp-Source: AGHT+IEqKxEQusQc/mEf1PmchCpojHyKOU/NUBIfL+zGYTHhwKG7RuZt2UrTDFinoTIQeRfak7YI8kK8uxQLm3HA6bg=
X-Received: by 2002:a05:690c:dc1:b0:786:4f0d:46be with SMTP id
 00721157ae682-787d534d0c5mr106568497b3.3.1762812394823; Mon, 10 Nov 2025
 14:06:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110205636.405592-1-tj@kernel.org> <20251110205636.405592-4-tj@kernel.org>
In-Reply-To: <20251110205636.405592-4-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 10 Nov 2025 17:06:24 -0500
X-Gm-Features: AWmQ_bmy4aLQoNCiZ7KPQEb20_Z93-ZWMhtAodbv3pzouiv5G_qhwQFn1xmSKp4
Message-ID: <CABFh=a5e0jAfLV7m8VBsDwUEOziMpeHDvyAf-9oTPYqsk3N6_g@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] sched_ext: Refactor do_enqueue_task() local and
 global DSQ paths
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrea Righi <arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:57=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> The local and global DSQ enqueue paths in do_enqueue_task() share the sam=
e
> slice refill logic. Factor out the common code into a shared enqueue labe=
l.
> This makes adding new enqueue cases easier. No functional changes.
>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  kernel/sched/ext.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index abf2075f174f..b18864655d3a 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1279,6 +1279,7 @@ static void do_enqueue_task(struct rq *rq, struct t=
ask_struct *p, u64 enq_flags,
>  {
>         struct scx_sched *sch =3D scx_root;
>         struct task_struct **ddsp_taskp;
> +       struct scx_dispatch_q *dsq;
>         unsigned long qseq;
>
>         WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
> @@ -1346,8 +1347,17 @@ static void do_enqueue_task(struct rq *rq, struct =
task_struct *p, u64 enq_flags,
>  direct:
>         direct_dispatch(sch, p, enq_flags);
>         return;
> -

Nit: Similar to the note for the next patch, we could inline the
dispatch_enqueue where the goto local_norefill statement is (though
the current code is pretty easy to follow - all the dispatch
statements are organized into what is basically a big switch
statement, with the goto labels doubling as documentation).

> +local_norefill:
> +       dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
> +       return;
>  local:
> +       dsq =3D &rq->scx.local_dsq;
> +       goto enqueue;
> +global:
> +       dsq =3D find_global_dsq(sch, p);
> +       goto enqueue;
> +
> +enqueue:
>         /*
>          * For task-ordering, slice refill must be treated as implying th=
e end
>          * of the current slice. Otherwise, the longer @p stays on the CP=
U, the
> @@ -1355,14 +1365,7 @@ static void do_enqueue_task(struct rq *rq, struct =
task_struct *p, u64 enq_flags,
>          */
>         touch_core_sched(rq, p);
>         refill_task_slice_dfl(sch, p);
> -local_norefill:
> -       dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
> -       return;
> -
> -global:
> -       touch_core_sched(rq, p);        /* see the comment in local: */
> -       refill_task_slice_dfl(sch, p);
> -       dispatch_enqueue(sch, find_global_dsq(sch, p), p, enq_flags);
> +       dispatch_enqueue(sch, dsq, p, enq_flags);
>  }
>
>  static bool task_runnable(const struct task_struct *p)
> --
> 2.51.2
>
>

