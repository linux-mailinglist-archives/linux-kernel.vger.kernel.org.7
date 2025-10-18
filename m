Return-Path: <linux-kernel+bounces-859455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D11DCBEDB3E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 22:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FB2C4E5057
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 20:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FE6286D63;
	Sat, 18 Oct 2025 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Y8VDkfBz"
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF21E51EA
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760818063; cv=none; b=lDxSnkp9o78v8ovHvzV+eTDP0agF+epmsNfXnQ62Gz52LtAgEpoaIUHyZtfWjGRaOZj1F2fc4yJ2qHqR4wJCqQvOEEjhop2xRL+8ZS21eHfVDIcWTjIhbcNPcoVaFtJ9y8HZp7ouF21g/89ZsbKEpiRuOyFwgqLmiNbT2T5nbzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760818063; c=relaxed/simple;
	bh=tpkmTrj9yvJP77GUvZDq7eaApIWSV6MeSWRkmJu8+5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NN5VYRFGtXQpqyyC/sTQK/apuVLcQ//vKxOw5Y/ELYGLJ6JzqUNN6hYqsAwLBL9k+RUgNUh7U0WExv4B8My3ghJ9kc5U8Ufz6Mytvy2qcVuCLb9L4wVxhgx5dqRC6cvEVY3wlW5vvcqRN7oYYoGwogyACP0nfqFfYYtDU1imtyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Y8VDkfBz; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63605f6f64eso2695325d50.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1760818060; x=1761422860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucpvAeUqe9rF0WcERnFwmxp6mxNyXUwA/gyiOAOR/Lg=;
        b=Y8VDkfBznsBGm3b+UNBas5gCu0yaOY2PiaqFMVKRFBJ4LfHqxMIFhQk4Q9dbmMqaXS
         ClUrLmzR4YY108w+7IX48XzblVCM9T8/Xe58wxmv5exlVM/7x/1nttkBqecwswcrUrL3
         z5EF0JkBfIbivrtDdBi0vvIkxPJSW887ZrrvFoF5HP8nPb+/L0wkTO52W/7eUsXzW6K5
         2QuRfa/uTSeolKMQZmivHOH0hdHgAfjoUkkcEHojJighobWVskvXX0JtsKpsdL1vw83a
         ZlqQamsAJwzhfwU3yKaATly88OkGy6FA3RDxjK098m2oFmumivG1Ha8WfAJYbEh6ZrXG
         RLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760818060; x=1761422860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucpvAeUqe9rF0WcERnFwmxp6mxNyXUwA/gyiOAOR/Lg=;
        b=cjl3RF8IFVSyYO4wuh3L+fj1RJUQpbCNb3luG6VzshQPKwLbWzvL62uekhf+cg751u
         2F2NbxPt+4fy3Susfvl/X/MUuCHQOttXTw6A/+6vaPPsOhAafnaOxUd74e4KyN+71UER
         SL7+FGZWy3FBxrw1RLylu0uXNLjJ7wdbvS54RIKGt/5he118htppF1EJ/L14ZohetV2A
         Jzi+KhnW21jM16ft/Zz8bn6H4Msk9mBUJtseohLsxjBChxZQVagUirZ+bP1b7DDRZSyw
         E3q4NBRozXU7GdrLYiq/BZ5Ke2t+k0G3uWUpTogP5e6GA7LVMoAjXR7Pm+14VD0uk6TB
         JoAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEsjzoYhgntDzI1OWdfMZv+qBTOG1SnVR/1X39vudrilTQMY8+C53PrapMPn1C/+ObDF703upaRUjuCB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvgChZ/LayK2JJBjaXrdOgeYJXcKia0/eEY57IVNrQZo0pgja0
	nXuA0zLLCIUVUTVLKKgYh7+Rbq3Qfv5IfiTcJqKNQhMeAVofakyNJam/LUbKNn2+KetvuxDUDTO
	d8qP+/967RYee0nRzaONVuc4Nhg+WGjJOhIRni7okEc3tk4CdjTcJkwA=
X-Gm-Gg: ASbGnctF9xAW+SnoNhwX4/IvV1DAWnud6EjbcyuLuktMSRboZRWHO0LhUoZ706YMAXo
	6jiF3iCJ1iCzjvIFu9KPFkJgUvBUhvbhdKrrWHt+XMj/mOkCKll1J9xNUtdCjG+gdX5sccQIW6s
	9JtTHuhdDna7lTMv1asNpoa4LhAV/qsInTRB2UbGSegYRVgps6zjkP45+VsqHwoBr0toeH0HUDv
	DgUZPzMTAHZXmADBOd9CNWDfxnRarTeXkKBlhliQZqKR28sFJzia59AcIynZIQ=
X-Google-Smtp-Source: AGHT+IGOl8H82Sx/wGP3Lk4LzvH69LpdZ72JdsN8VVV+1bEc2glqYTC2G/fZkSILyr+uLFJgb3nxX3nvD/2iHwRIYZk=
X-Received: by 2002:a05:690e:12c7:b0:633:a96a:fdd3 with SMTP id
 956f58d0204a3-63e1617af6fmr7232645d50.16.1760818060518; Sat, 18 Oct 2025
 13:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018141014.212571-1-arighi@nvidia.com>
In-Reply-To: <20251018141014.212571-1-arighi@nvidia.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Sat, 18 Oct 2025 16:07:29 -0400
X-Gm-Features: AS18NWC4Bp-6A72bzOw_BYBQDAYmAgQUippkjZIGTYkjtfhqPFshTDYgUD4ccyg
Message-ID: <CABFh=a55MGEVxuBg9mtZob5GbacPk_2EjXLDdjKMJmVhF6d7Sw@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.19] sched_ext: Allow forcibly picking an
 scx task
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 10:10=E2=80=AFAM Andrea Righi <arighi@nvidia.com> w=
rote:
>
> Refactor pick_task_scx() adding a new argument to forcibly pick a
> SCHED_EXT task, ignoring any higher-priority sched class activity.
>
> This refactoring prepares the code for future scenarios, e.g., allowing
> the ext dl_server to force a SCHED_EXT task selection.
>
> No functional changes.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---


Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  kernel/sched/ext.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index adff739b396ce..35bc37c7ee199 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2351,7 +2351,8 @@ static struct task_struct *first_local_task(struct =
rq *rq)
>                                         struct task_struct, scx.dsq_list.=
node);
>  }
>
> -static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags =
*rf)
> +static struct task_struct *
> +do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
>  {
>         struct task_struct *prev =3D rq->curr;
>         bool keep_prev, kick_idle =3D false;
> @@ -2365,7 +2366,15 @@ static struct task_struct *pick_task_scx(struct rq=
 *rq, struct rq_flags *rf)
>
>         maybe_queue_balance_callback(rq);
>
> -       if (rq_modified_above(rq, &ext_sched_class))
> +       /*
> +        * If any higher-priority sched class enqueued a runnable task on
> +        * this rq during balance_one(), abort and return RETRY_TASK, so
> +        * that the scheduler loop can restart.
> +        *
> +        * If @force_scx is true, always try to pick a SCHED_EXT task,
> +        * regardless of any higher-priority sched classes activity.
> +        */
> +       if (!force_scx && rq_modified_above(rq, &ext_sched_class))
>                 return RETRY_TASK;
>
>         keep_prev =3D rq->scx.flags & SCX_RQ_BAL_KEEP;
> @@ -2408,6 +2417,11 @@ static struct task_struct *pick_task_scx(struct rq=
 *rq, struct rq_flags *rf)
>         return p;
>  }
>
> +static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags =
*rf)
> +{
> +       return do_pick_task_scx(rq, rf, false);
> +}
> +
>  #ifdef CONFIG_SCHED_CORE
>  /**
>   * scx_prio_less - Task ordering for core-sched
> --
> 2.51.1.dirty
>
>

