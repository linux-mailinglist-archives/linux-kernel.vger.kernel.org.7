Return-Path: <linux-kernel+bounces-813022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7406B53FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E98A01A12
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119BE126C03;
	Fri, 12 Sep 2025 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dCLCoZ0C"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5C2F4A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757640084; cv=none; b=pPKD90SoLt2OM1IiCwF2vwWke3fpll9vAeAklAwrlU7aXxtClbLO1oiAW3OKLX0+2Qwoj+7gFMu7XhD2IKSstUmQJEbZOe+a6iit5nEQbT+gfMEksA/XNIBHH216WTq4IzDPcdbacqWcbHKkmDRpr6xUnFOo/qeqYLolSeU/g4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757640084; c=relaxed/simple;
	bh=Xa0YEpz+3VPo1Hi6V+S19t8JxtGYU5nJ3wnyT2oaneo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPckvLsF42U1HoPwg1BhmbIoa74EWWVjWClhsmqWADM8Plou15ef/uuZ1zLlsTa3bFE+dD2nhjBk09dN49cVfbIAICFJ094SDVvdmhJuzOdJ2lhwf8QFKLFIeBHJHfGogDSk+GopuZHiSIU5FN3iTl+BxBAP1oNuyPE+71hPQzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dCLCoZ0C; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61e6ee53d2dso315442eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757640082; x=1758244882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNvn8dwm9/jQPmmYOQXAYSn+9iI7uf/gD/WC7z1WFd0=;
        b=dCLCoZ0CHYFlRTIp1Tp8FynzOhdJE5IL5HB4omBIzrOfMxy8nycuRlSMGoCAcgK0Js
         EHnXc0mkWhDfdHDaDqc8DJHlJ/AumuElk7qaVpk6sgM8tqGGZTIAtKKHEWGb82sZbwTQ
         eB/8kgNQ3CsLtMgfrQ+Tg5xjYiPJxufSYDSQr7W7Z5RInDQNxc8ecoMppPzvHcXYrGr+
         AZ8o5JkyoL04kvVY0avUKk2XRNRDlNtAMaNaCO+0UlvtMkrTaI5B3RZ9+Bf3WXZ/gmlZ
         PzRDzPYb66BRJ6l3NVj6q8UTCrnPoudoUUxjL5zFhYUy/0ZSz4oKN5Ch/qImYDwTComD
         CHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757640082; x=1758244882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNvn8dwm9/jQPmmYOQXAYSn+9iI7uf/gD/WC7z1WFd0=;
        b=rj/4ZNRv9mDVks937Xt27EO8lTF5ijIwtIauM80uFwz0Vv9Gdh8ZjqO5Ec5qwVk11M
         hsPR4TBCo6RIjb+KYX6aTsbFaGrXk2Pu8IfTs4jCr1GcU3TceyjYkCfec6Cuf++lEDwR
         WDF6/cOViFRFiKqlPK0Lmlo19pXG9/2W4MVhZBMUsULobftE2d6tAc4zyFxtzC/L55FX
         f9a+FOlN1BrrAYU+MJhw6zqhrOL87AgYrL6gx+ers4fuU4ayw4/+MYI52RnKYf7wT5Ir
         cvHsRxZRIyZ74SWr/3cqPV5WOsW+GhSmpoiyQi7vcjlX9cHpdy+Y4v7pHnhVCM7sroOZ
         7ILA==
X-Forwarded-Encrypted: i=1; AJvYcCXXrHu6J3Ph2zlnQtcmMFt3Ook6dpkmYOPuyJrtjeccTxQ4R6Mu1PMJMtkx8HSyq/KMMDs8MuTYXolySm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrxfDsb6AzrM9U4rIQs6UidUnZUkp/G45vQvQBzfR1FGS17PnS
	axzF01eBw5jEiEO/+aQYaqaDThRaLHay9WFmgmaWExoiQZ0VWa5Ap/1kFIrax5Lry+Uhgk3wCHQ
	ZdYllW6WApbBTwNAllTYO641G6FyKC1HyKKvqcuxkzw==
X-Gm-Gg: ASbGnct80UMPED565BrWJ7OnupLsoqklpAnTEVZAjqDZINHGZFa9HXTdeIbJFDrmIuY
	/0/1HbuNLeny8s7gE5uUpOEFyte8t4T8TYGf21ApaLkRRU7BU8MdctWl4AZmNTj8tepeI2zqtNe
	iyWFXxoBAFy5lHrxynpqzNNBuTv/5Y8LvX7Ee/kt+qrT0kfxsFx1diD/3witCody5m3ZYO+dW8g
	taUc5sOcCfsg9/ORytfGDrnUWc=
X-Google-Smtp-Source: AGHT+IENe4W9BbK++7qiIojSfDqtbC6lEInbLpk22z8JE7+q3Y0xd1PU0fHFZPk4jPzlcQVIVGB2YJM40b6QZIBc6fw=
X-Received: by 2002:a05:6870:c69a:b0:316:9864:8d0b with SMTP id
 586e51a60fabf-32e54575db6mr492849fac.12.1757640081657; Thu, 11 Sep 2025
 18:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912000609.1429966-1-max.kellermann@ionos.com>
In-Reply-To: <20250912000609.1429966-1-max.kellermann@ionos.com>
From: Fengnan Chang <changfengnan@bytedance.com>
Date: Fri, 12 Sep 2025 09:21:10 +0800
X-Gm-Features: Ac12FXzZE38Za4CCeCuscUYLW8mPPYr98VRNgPC9wOUJh37TNzG7c12rb6_jwOA
Message-ID: <CAPFOzZujMZg14Ljp-YsgPqqcJhMFnU68e7XOf09pc=jwoTPytA@mail.gmail.com>
Subject: Re: [External] [PATCH] io_uring/io-wq: fix `max_workers` breakage and
 `nr_workers` underflow
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>, 
	Diangang Li <lidiangang@bytedance.com>, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Max Kellermann <max.kellermann@ionos.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=881=
2=E6=97=A5=E5=91=A8=E4=BA=94 08:06=E5=86=99=E9=81=93=EF=BC=9A
>
> Commit 88e6c42e40de ("io_uring/io-wq: add check free worker before
> create new worker") reused the variable `do_create` for something
> else, abusing it for the free worker check.
>
> This caused the value to effectively always be `true` at the time
> `nr_workers < max_workers` was checked, but it should really be
> `false`.  This means the `max_workers` setting was ignored, and worse:
> if the limit had already been reached, incrementing `nr_workers` was
> skipped even though another worker would be created.
>
> When later lots of workers exit, the `nr_workers` field could easily
> underflow, making the problem worse because more and more workers
> would be created without incrementing `nr_workers`.

Thanks, my mistake.
Reviewed-by: Fengnan Chang <changfengnan@bytedance.com>

>
> The simple solution is to use a different variable for the free worker
> check instead of using one variable for two different things.
>
> Cc: stable@vger.kernel.org
> Fixes: 88e6c42e40de ("io_uring/io-wq: add check free worker before create=
 new worker")
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  io_uring/io-wq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
> index 17dfaa0395c4..1d03b2fc4b25 100644
> --- a/io_uring/io-wq.c
> +++ b/io_uring/io-wq.c
> @@ -352,16 +352,16 @@ static void create_worker_cb(struct callback_head *=
cb)
>         struct io_wq *wq;
>
>         struct io_wq_acct *acct;
> -       bool do_create =3D false;
> +       bool activated_free_worker, do_create =3D false;
>
>         worker =3D container_of(cb, struct io_worker, create_work);
>         wq =3D worker->wq;
>         acct =3D worker->acct;
>
>         rcu_read_lock();
> -       do_create =3D !io_acct_activate_free_worker(acct);
> +       activated_free_worker =3D io_acct_activate_free_worker(acct);
>         rcu_read_unlock();
> -       if (!do_create)
> +       if (activated_free_worker)
>                 goto no_need_create;
>
>         raw_spin_lock(&acct->workers_lock);
> --
> 2.47.3
>

