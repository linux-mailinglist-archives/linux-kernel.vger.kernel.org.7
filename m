Return-Path: <linux-kernel+bounces-792808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D6FB3C937
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E7458505D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 08:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FC72376FD;
	Sat, 30 Aug 2025 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="Sb01R5bO"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3797F285CA3
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756541567; cv=none; b=uAbtrG/9c7NTrxNl2qZvaYWVyaaloOXJv4shyA9emFC7MWoDnPohNDq/99SmSOQ+YeshsOkKe9i+cCd7ww7JByd/TL2bZ4QkGj0Pj5GKS7VZamfRmR7qRYSXynVb8fiQoWDHoAIi31ECbS2J5wfd8y+FCMkvJpQYuzIvG/yfREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756541567; c=relaxed/simple;
	bh=V8KY9soX6dixy5+2r3kKZDbK8+IXIt0WM3HTeSX5f20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnogEXsICvqt7KVNKubQPY0stacCUaOJTbEXJerDRbEvYfDSULlkDEKkdiLzBKSaKd2j6U9lDpu7urFI4X8zRC5JmkO2R+7E9eH9bqX5Jl7boI38XokpBxc20L6SJQrV2mzjDxH8z9sB8RlQgtC4TaSwtp9HmV1z7FlKAbi7z+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=Sb01R5bO; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b297962b24so30854381cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 01:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1756541565; x=1757146365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfWv4prrdowDTBmUkPtfk9uVwo5ON7JamPmwAZU/yVc=;
        b=Sb01R5bO7hH/OrqnrZ3kFilPFZzcGvAgMAyi6DQPIz5AetiiwNysEBSrbrgMh/Es1/
         VnSN74+7ES3DQJKS1frHilfJpt9SRqK4/8eZHTSnSPHCjjEq7xwQMn2LvBnD7YfZRBC2
         +qYmUaR0FPN9R3PPNX00RaWzkIXc43dq6x2x9TrVC4Z3118H7NWf16UnldDqeNw07W43
         V3+pknYkRA4WdbXJ0Kx61hRu+k7TYKC4IJUiDBKLrDKJVcSLbmV9yc9rEOp6LmHjDHzi
         PDp+e8mabuwvaCN4e9g/tKRN1SErB/id+qRiOXT9LcF6boxAytgpOOg+UMe3l4kJGPIA
         COog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756541565; x=1757146365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfWv4prrdowDTBmUkPtfk9uVwo5ON7JamPmwAZU/yVc=;
        b=e7F5YBlRQemULfjcoC2uBmjoyKm14WNcjRZHPxfhIA0IeBJ2CfpSDajHOdd1tOAXVf
         35JkMihKYJ6GLJThd07jKqN0OLWV+1TZW5gYTAoGBS5/45pyf/33eikpURhvIVDSXt0f
         e8xuulJRHEogCQk11aqOaq7C8BCd+ZkIlOksX3VorQKsHKdTm4aYMMhH09BpeQ5+gFGu
         hZRIIqNr9fqsu0aYhNT7rqHOJpvTn7vQ5w8ouy/YA7N0biKphieMclX2RD+Y258FzdAa
         1+kz6YIZNEkMGPfCgq1IOo946Xzk7Q/aUm6Nc0X/kEEKj7uzlBSQ2HQOz6Dam7ixATJY
         AWgQ==
X-Gm-Message-State: AOJu0YzOSjG+Ns8QNtbl2QEiHTVEiE9CIsMNC5/Kbr7c8OS4jz36QgKz
	U9CXQn13KW9+IqjH+wTb8uaIo7IRIkPXKbnEbFx2ozIpEcTy0wNldrEyJk7tAt1dCe691AHmfQm
	xo3NMvQQ4dolBY8VJIO7fXJj63ERL6tu2e0Q5i66RVg==
X-Gm-Gg: ASbGncsDJfPxBhYSFUd5HXa78E0uqZt1ssN1onWM3trMbJKGU4E6/ySv6dVNqr2yleG
	l5N/g37LhI1Ub2LzR3Zot4g0xrLw2riRTn8ozZKhv4mxH+Eueb88NaWGmAF2QUhOGkp4ASHMOsk
	Orsu0MS+9QuJ4WD1rIrmgvC5TAnd1wbeL/m6i9fq/HB2oZttlMBf91Wsl9uyV9Io31NbcMk3Jq5
	f2/wqqCC0NoQQMK
X-Google-Smtp-Source: AGHT+IHXCe3+isolSowvj52vPfZFAqc+RvEUdglTXP7OQ69Qhl6T6sywHroI7ZM8kmbDsLRCBAYAnPdmB2rOENhB2BU=
X-Received: by 2002:ac8:5d49:0:b0:4b2:8ac4:ef72 with SMTP id
 d75a77b69052e-4b31dcd0d89mr14606561cf.65.1756541564953; Sat, 30 Aug 2025
 01:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828023422.2404784-1-adrian.larumbe@collabora.com> <20250828023422.2404784-4-adrian.larumbe@collabora.com>
In-Reply-To: <20250828023422.2404784-4-adrian.larumbe@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Sat, 30 Aug 2025 10:12:32 +0200
X-Gm-Features: Ac12FXxaaZz1i24uI1HHJ8SGYKOXczq00VFZTcqupeELMswfWEFcq2TpaHOaYmQ
Message-ID: <CAPj87rMRkmkG2MJVnh-zMiNXJ-=fW2jzS_mX7WWWQi3hZmHUyg@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/panfrost: Introduce JM context for manging job resources
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com, 
	Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Thu, 28 Aug 2025 at 04:35, Adri=C3=A1n Larumbe
<adrian.larumbe@collabora.com> wrote:
> -void panfrost_job_close(struct panfrost_file_priv *panfrost_priv)
> +int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle)
>  {
> -       struct panfrost_device *pfdev =3D panfrost_priv->pfdev;
> -       int i;
> +       struct panfrost_file_priv *priv =3D file->driver_priv;
> +       struct panfrost_device *pfdev =3D priv->pfdev;
> +       struct panfrost_jm_ctx *jm_ctx;
>
> -       for (i =3D 0; i < NUM_JOB_SLOTS; i++)
> -               drm_sched_entity_destroy(&panfrost_priv->sched_entity[i])=
;
> +       jm_ctx =3D xa_erase(&priv->jm_ctxs, handle);
> +       if (!jm_ctx)
> +               return -EINVAL;
> +
> +       for (u32 i =3D 0; i < ARRAY_SIZE(jm_ctx->slots); i++) {
> +               if (jm_ctx->slots[i].enabled)
> +                       drm_sched_entity_destroy(&jm_ctx->slots[i].sched_=
entity);
> +       }
>
>         /* Kill in-flight jobs */
>         spin_lock(&pfdev->js->job_lock);
> -       for (i =3D 0; i < NUM_JOB_SLOTS; i++) {
> -               struct drm_sched_entity *entity =3D &panfrost_priv->sched=
_entity[i];
> -               int j;
> +       for (u32 i =3D 0; i < ARRAY_SIZE(jm_ctx->slots); i++) {
> +               struct drm_sched_entity *entity =3D &jm_ctx->slots[i].sch=
ed_entity;
> +
> +               if (!jm_ctx->slots[i].enabled)
> +                       continue;
>
> -               for (j =3D ARRAY_SIZE(pfdev->jobs[0]) - 1; j >=3D 0; j--)=
 {
> +               for (int j =3D ARRAY_SIZE(pfdev->jobs[0]) - 1; j >=3D 0; =
j--) {
>                         struct panfrost_job *job =3D pfdev->jobs[i][j];
>                         u32 cmd;
>
> @@ -980,18 +1161,7 @@ void panfrost_job_close(struct panfrost_file_priv *=
panfrost_priv)
>                 }
>         }
>         spin_unlock(&pfdev->js->job_lock);
> -}
> -
> -int panfrost_job_is_idle(struct panfrost_device *pfdev)
> -{
> -       struct panfrost_job_slot *js =3D pfdev->js;
> -       int i;
> -
> -       for (i =3D 0; i < NUM_JOB_SLOTS; i++) {
> -               /* If there are any jobs in the HW queue, we're not idle =
*/
> -               if (atomic_read(&js->queue[i].sched.credit_count))
> -                       return false;
> -       }
>
> -       return true;
> +       panfrost_jm_ctx_put(jm_ctx);
> +       return 0;
>  }

It seems odd that both panfrost_jm_ctx_destroy() and
panfrost_jm_ctx_release() share lifetime responsibilities. I'd expect
calling panfrost_jm_ctx_destroy() to just release the xarray handle
and drop the refcount.

I can see why calling panfrost_jm_ctx_destroy() is the one to go try
to cancel the jobs - because the jobs keep a refcount on the context,
so we need to break that cycle somehow. But having both the
handle-release and object-release function drop a ref on the sched
entity seems odd?

It doesn't help much that panfrost_job is used both for actual jobs
(as the type) and the capability for a device to have multiple
job-manager contexts (as a function prefix). Would be great to clean
that up, so you don't have to think about whether e.g.
panfrost_job_close() is actually operating on a panfrost_job, or
operating on multiple panfrost_jm_ctx which operate on multiple
panfrost_job.

Cheers,
Daniel

