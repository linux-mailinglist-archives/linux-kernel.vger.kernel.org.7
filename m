Return-Path: <linux-kernel+bounces-796102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6661CB3FBF3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95632480040
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E162F0699;
	Tue,  2 Sep 2025 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGkPP53Y"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0072B2F068B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807944; cv=none; b=qMbw+cOyF0ycXv0wXzlW+7T61lLc1UHsx8XuTAUCLkxFGNpfTjlVMT9NuDHUXkHAaEad/t3qpPTF4eGBe2flMylfPyTN9K7LHfYVLH1IBsksvU2yYEq2nK+kg3jdNLxsZ8Zh8mNst4MQLAueRHo8z45smIE+WP6SChK6AVbh3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807944; c=relaxed/simple;
	bh=leXB5mHyEcG586IzWuBWfTUM4regLFxyXevDN7z6VV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRHPmIlWFHhd/8AB86+sPuacusX5zEh/OF/05PD88UPG9aW+thBUEDpjxcyrI5qig/DAk5oGyGqwl6zRcVPl7qmUDbHzb8j3CF47Iqw0Lu1MM1qSpMELIz1SfmUCCrFpBuPoCsOhYftL16r9Rmz9z0Mh+v1qHGIiAydSJwntNI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGkPP53Y; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8080a88a32aso9547485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756807942; x=1757412742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGHsOt8ECn0wnw6q+d1jg+PuZZM4BobcldkVyU4WYFM=;
        b=HGkPP53YQtKNLRGZZBmjON/4inC6inBaJYHqc4DD0ogNuqFPU5qso76HQytk8KRgti
         pQO3qdimmj80wbr2JiKccb40LJkEfmD7iZHaQMQRc72JHHs8FxmjZoFSLW1eaMhIheyU
         4CBPXPnVsVq8l1H+ZEeUaDzFCqMlTMuEAw/A7Ic3w29I+JPJQVoJR+JFF2rlmbmn7W4q
         8zaq7Yv1UOKa4K8ycIFJzIQHlApThwvZs4vTpIPOCb1JrYS9h2WXNDWI6hSw/D+FNi9R
         tSG7yjmdGZS52cxA+FHsxBtjbKTqL/lRvQ2gB8Yn2IQmB8+WRLWX5EAhQRazVYNn7dAC
         1Ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756807942; x=1757412742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGHsOt8ECn0wnw6q+d1jg+PuZZM4BobcldkVyU4WYFM=;
        b=C7kYXTz51AG5a1vlcojN1xET4NUmD/T+9xJbZmLVwVDjedFli6kCRlxXiUzk5H9B6U
         0+pCSB8Z3lhpa7B84Hi1I1dC1ccCbQOBm+xAwnSgK9ihyiRLzYEe3wn3Z4AJ2smKaleV
         7vQBUY3u6T2ZRH0DHGcm8XO3PmYzbIzt1XUFoxGFHCJlo9TszuaGwCgvaWQCGmqNHMnT
         veGXrzgINuWPPtMlsSM3+2N5MvJB6bgWo5R/blozuYoGAY6rlgHnsj9X/5mBKFF3T93i
         jcj6S7E4JDZtsBS/IpNIozMPba/qlGKj22bjWginF0k3H2TpP8SLTuFYsWhRZGAY1sNm
         Geuw==
X-Forwarded-Encrypted: i=1; AJvYcCXpeOgh//IV6FByXtyyntL725HX/N7cTHF/mBSEUfDQyl/+R0+Q3zvU+wtW7QYsK0UKvNsBANCjnLTl1Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyokRMjHNNglaZrM0n5jyLdf5TmCIB8PJbGQuX10c8JeFRBLXrX
	Z9aD0DgFKqh0jg3xIdqx+iGr7+D+Mu05QEly9CNuOb/7WS/RCZ2D43SvlSI54uKYI6h3avtG5pH
	60vlN4/OhnB50gXZX8gjFEUJ89ZLdgQs=
X-Gm-Gg: ASbGncvVPsdsQjG1cs62tkVZlwcLCQ2F8COV3qgiHgVn2OvLiHIyBSEc78GV+QCKSLV
	6jQemRzlx5u/OcQtAro2tldFbeZjtsWq86qTBTK9V7U03G/jIrP06woxJ/IgQ8sNXfmD+ZDaiNB
	ngfKYAJkh+lGabumoQy9K7ZoOnQVRTIHvOaU/ECwCY150CIEJD4hKfcFiCadvK5Z6wCETsrKgh7
	qHFa0MlATLMtHLvLEVlRV2yu1z54uwTPiEet7j4LI6YnYEnwr+KBCQPMlfzUE/ZYj7iWMNX+oXe
	7NUTxlzQk/GhxK++8A60VN4ywV19RDw5IB750XOhKpo7PEo=
X-Google-Smtp-Source: AGHT+IFURzNV0ZRA2CEmzn4C4F5wx2AglECKri7SC4LbVMFSGvyYHHeEFu77ztNpX9Y8kvIPhBjBOyID6J4vYd3FIlo=
X-Received: by 2002:a05:620a:400a:b0:7ef:38e6:5a3c with SMTP id
 af79cd13be357-7ff26eaabc5mr1250719785a.6.1756807941715; Tue, 02 Sep 2025
 03:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901163811.963326-1-bigeasy@linutronix.de> <20250901163811.963326-2-bigeasy@linutronix.de>
In-Reply-To: <20250901163811.963326-2-bigeasy@linutronix.de>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 2 Sep 2025 18:12:10 +0800
X-Gm-Features: Ac12FXwFEtKBWDDwozhX-PpQ1R9Twfd2v-7LcyNEG9PxtZQZ5ptbapJ5erNEG_M
Message-ID: <CAJhGHyBaqn_HOoHX+YinKW5YSy1rncfbvYXktkEtmFgK44E9wg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] workqueue: Provide a handshake for canceling BH workers
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Clark Williams <clrkwllms@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello

On Tue, Sep 2, 2025 at 12:38=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> While a BH work item is canceled, the core code spins until it
> determines that the item completed. On PREEMPT_RT the spinning relies on
> a lock in local_bh_disable() to avoid a live lock if the canceling
> thread has higher priority than the BH-worker and preempts it. This lock
> ensures that the BH-worker makes progress by PI-boosting it.
>
> This lock in local_bh_disable() is a central per-CPU BKL and about to be
> removed.
>
> To provide the required synchronisation add a per pool lock. The lock is
> acquired by the bh_worker at the begin while the individual callbacks
> are invoked. To enforce progress in case of interruption, __flush_work()
> needs to acquire the lock.
> This will flush all BH-work items assigned to that pool.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/workqueue.c | 51 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index c6b79b3675c31..94e226f637992 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -222,7 +222,9 @@ struct worker_pool {
>         struct workqueue_attrs  *attrs;         /* I: worker attributes *=
/
>         struct hlist_node       hash_node;      /* PL: unbound_pool_hash =
node */
>         int                     refcnt;         /* PL: refcnt for unbound=
 pools */
> -
> +#ifdef CONFIG_PREEMPT_RT
> +       spinlock_t              cb_lock;        /* BH worker cancel lock =
*/
> +#endif
>         /*

Is it possible to use rt_mutex_init_proxy_locked(), rt_mutex_proxy_unlock()
and rt_mutex_wait_proxy_lock()?

Or is it possible to add something like rt_spinlock_init_proxy_locked(),
rt_spinlock_proxy_unlock() and rt_spinlock_wait_proxy_lock() which work
the same as the rt_mutex's proxy lock primitives but for non-sleep context?

I think they will work as an rt variant of struct completion and
they can be used for __flush_work() for BH work for preempt_rt
as the same way as wait_for_completion() is used for normal work.

Thanks
Lai

