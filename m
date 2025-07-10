Return-Path: <linux-kernel+bounces-726196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9FCB0093F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6230E567A67
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853382F0042;
	Thu, 10 Jul 2025 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zx4H2iSn"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B69F2F0C78
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166332; cv=none; b=j5N4pzh3Q7RPj9S8xnTFRl4/Bsft1t4+yx2qjYYBcJLpcEssQ8nTTxYGN1BYRx6k60+FuhyLLwAb5gnFERtJ0Q9HxXxn/+WQ2fH/e8LAq6gY/9OhepHGy/5QXjYtPflaQFmDOvt/dbV0rra2A8A83R9LOBLevizdv3EbkyfWYSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166332; c=relaxed/simple;
	bh=KSkJR6wQxG7mHXmQuG8xaONs/Aqz73xZaf9uQISZ6J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fv9NJqqIiPwtrWbr+lVdF4Yo5Ciw/Id7slHycXVa35fCEC4+cqK5lzGpQ1O1Fw2oVXHQdcjJPBdF1Bhqeae1Bpj7yXFwqvfpHYXFZGajyGCZd6NK5SMbuqGv8qryQ0NwY/wVu/UgzfkjWF3Jh8KLqKrHvqYZpJPozkvbiSgPQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zx4H2iSn; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so1634253a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752166328; x=1752771128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WCvjvE0XiiNVSwfiZ8RBm8naiVCCDzA/7p91qxexTt4=;
        b=zx4H2iSnzbpcnXpGO+28qm/DJhIDxzx0hznjc30y9TUENI/i8hD+BikPcZEqO05ur2
         cTmXAaPeJdnF7t2VfcNZxHs+Sdf47WXz9vJNwyjzx368ItWYhYftvI5o9TQodaCmu3wp
         JnLOgCHm9b8HLAx3nnqrTgP0SNmy23EzXG0+Dtfcrq2okgQnPlmI3t/7sL64s9fN0tDr
         YMzZrQQ9yfR9tuxv+9vLNyPF38iQ8Tw/dHN/IM9BO/m7m8QRAQax84O77AvxB2AUHcGe
         eagbGwNTfDp0r5rndhJ/F4inbK6NIasC1RrfoCcPS9dnoBE2h22rDdGQoMokL42m12Vh
         V4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752166328; x=1752771128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCvjvE0XiiNVSwfiZ8RBm8naiVCCDzA/7p91qxexTt4=;
        b=CUww0GwU+QTij74AWmVo8X37Ujn/FqHvM7JDPpidvGvgeh9Jn8XNxuMLGz5V8177FO
         fqWOhjIgmlak9hdbOBg0hCvx+O9TgOzw+nyiEkOmZQz9UV95kVgygfzovusAo3pkAO+Z
         0+QlbNeb8XWy0i0LWB1kdj7ThQp/pN/q8D56X+QiaXZ1pFfQM08kMMImT1EVTpUF9mY8
         tJf5PMqjQCaWg34bqwV9QkZ8qeGHwqQ34Osfyb8DZqwZOK917bPJLmYoYa50wrMOMOik
         Rn87D9gRMnYbCUt4xSnDBSm6VCBiCpLnhbPYWe5X4bcLsOLuk8Gbkmd7LYWHumOomOP0
         2NEg==
X-Forwarded-Encrypted: i=1; AJvYcCXg7f1w6hNmfNMiEuA6VKQybsaktgcTSCJgVrDFrl32Jl7LXnHYLsqDoQOV4lOO/njftrEvzrjU2ENA43U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuFippy7kCnmrvOboI2Q+HmXcPoHiYlSOJtT/9usUv+vuzSlQ8
	KiS2xl0bYPxFgO8MQJc/9kRc+SGL28eo/xzQMZA/AHdJTATT4qu3ZOHF9qvat0rB0MAa7RdRfay
	TDzku2QsYFkLF/hX7S0aEjjVUiG72Hwb2M/t9yOyM1Q==
X-Gm-Gg: ASbGnctW1ido3KVMMaqFTDJoPrTvKBI8Wn7UIQW/YH4TYUS8SwrOjOeNWGFrjH0rJV4
	XIT4Egmi9OFqO8izIeUlVF/WMNivS59Irg6ja8MvA3nQtVMcCKumeUwErrrhakYXTi9sQ7JIoPt
	Cy+gkeHDdZDs95DFmHfPbxtruGnU3UsV9R/K0y2OwPVb294IM+53EGaTjdH/decase5lu4t7LSG
	1I01lOFM2I=
X-Google-Smtp-Source: AGHT+IE66W6r4PPLa1rTZ5Mg2Ceg1fqOgTnavAGedIM5dv4NoqftrUX2ohEqV3UAA2CfnqXpH4MfQ1iWWZHnWmYMRxQ=
X-Received: by 2002:a17:907:3d45:b0:ae3:53b3:b67d with SMTP id
 a640c23a62f3a-ae6e104cbefmr483049966b.1.1752166328423; Thu, 10 Jul 2025
 09:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702114924.091581796@infradead.org> <20250702121159.418420130@infradead.org>
In-Reply-To: <20250702121159.418420130@infradead.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 10 Jul 2025 18:51:55 +0200
X-Gm-Features: Ac12FXzp5L_YJ96GXg9bxgq7KceFVtz0tTjWqGrQUUNcjrv-XZ20QuNVIfcDtjg
Message-ID: <CAKfTPtD-7kjB_0JHvo2CoEVPAcug2r3NxFga9F2ucD1UPH4iyg@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] sched: Use lock guard in sched_ttwu_pending()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	clm@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Jul 2025 at 14:12, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3827,22 +3827,26 @@ void sched_ttwu_pending(void *arg)
>         struct llist_node *llist = arg;
>         struct rq *rq = this_rq();
>         struct task_struct *p, *t;
> -       struct rq_flags rf;
>
>         if (!llist)
>                 return;
>
> -       rq_lock_irqsave(rq, &rf);
> +       CLASS(rq_lock_irqsave, guard)(rq);
>         update_rq_clock(rq);
>
>         llist_for_each_entry_safe(p, t, llist, wake_entry.llist) {
> +               int wake_flags = WF_TTWU;

Adding WF_TTWU is not part of using lock guard but for patch 12 with
ttwu_delayed -> select_task_rq()


> +
>                 if (WARN_ON_ONCE(p->on_cpu))
>                         smp_cond_load_acquire(&p->on_cpu, !VAL);
>
>                 if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
>                         set_task_cpu(p, cpu_of(rq));
>
> -               ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
> +               if (p->sched_remote_wakeup)
> +                       wake_flags |= WF_MIGRATED;
> +
> +               ttwu_do_activate(rq, p, wake_flags, &guard.rf);
>         }
>
>         /*
> @@ -3856,7 +3860,6 @@ void sched_ttwu_pending(void *arg)
>          * Since now nr_running > 0, idle_cpu() will always get correct result.
>          */
>         WRITE_ONCE(rq->ttwu_pending, 0);
> -       rq_unlock_irqrestore(rq, &rf);
>  }
>
>  /*
>
>

