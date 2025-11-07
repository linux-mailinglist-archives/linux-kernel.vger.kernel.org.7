Return-Path: <linux-kernel+bounces-890570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D65C405D5
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2C304F36DD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC09329369;
	Fri,  7 Nov 2025 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWMSQuwV"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36512283FC8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525685; cv=none; b=hgr8pXx88F0gnZtnoIkUVNh5XwRseE/YrocX3n6Cnbk0AIawKa+St0nh1wmyeUgQ4oOdHehHb646QX4oHKzFNMYwzlV6a7FB/hzxABe5MbaqSH0sMCLyY2aKQAomEeNJUpg/ueG/l7F66LsgkyGtZ6XObT7s6Gb8am1JlsjjOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525685; c=relaxed/simple;
	bh=c+a6fPEtLMuOmlT4Kig9zRhF7kBqXmve9JJNWy5lrU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTUOP2YkBlSboZ1Yq2lPNK+A0eu3+Nehyqa7LBIGqT3PGFdt0gb2iHVlWAfffNo/Cw1hdqDnbXhLAkKMQXaYYZi0Plj8y4b9imVf+8NQrRhKdP2fWURc0J5tl5JzYvBd7EsfS1sqaMaZkqdcACcP5+k5PI1mZqu3Pis2Dl9DFAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWMSQuwV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a271fc7e6bso128508b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762525683; x=1763130483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kcr2kLbrccmHXR0DwVI5+Z3TJTG76QtAID5voxoGTP0=;
        b=OWMSQuwVnPL1YiflKuxCyyt24sxFurBqqPtzalKv+SZmQmO5Zaqbnbi+W4LLlFZbkb
         7VarpyO/y0n7T7ufr5Wp/2djGTCzxIeJ08W/2oXF0eLM2Lom9Vs1Tqopn/PrC5ZURS03
         JjdLk0QM1LgpMJO0B/7J18KE/TVsg6d9ytDrb3GWB1iuAIcAvQc9D9IPCPD/O7rYRPLp
         SVgkiaO9ATL0p1tnyMl+XJLBdc6Gna4fTMVJKNbCPLATWN0KGcgWdRWga18TZO4qH7CU
         jwzMljQtC08s8Sgl74Lqa7EaFFEfeXeJwuZaOVhECmOCp6eXxfMooseR8a+J0eA2Raiv
         BHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525683; x=1763130483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kcr2kLbrccmHXR0DwVI5+Z3TJTG76QtAID5voxoGTP0=;
        b=Nc7/62LikYQwNAY3yfM3zbDAJ7MOrcqxQp24VVw7cXVKli+xWt7Y4KFLUinaIKvAp7
         yI4DMUbYKJaATfklqOfuhVuffcqCR6PnSbHpbPI9+2phA9CrinEErpHJhwC+RD2whcLG
         gFoXEea+93ekfu+O4L08fHwp55fFUiSV82GcEkB/Lyw7hR/AXAMwquimNSC7y2rAOY+z
         0CUnJZeIuVp0jUgxYugTvHUmHDtOiss8tZPxej4704igDOzHaB9NPnHZXuChuLf12ikV
         X/fGT6kzgHfozhCCznnKPQSO54yxGDLGO1fH1q3PU/XkMQhOg2bQcZ1K8qOGZoD+6YMr
         R7fw==
X-Forwarded-Encrypted: i=1; AJvYcCVHeqVV5LSFU429xMsR3Ir+WTYfUu442a0LzDl/QEtmZPv7/uGo1NycHiNWpoHfF2lI3ut+1q+ZyT0kDdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7jvBol1hPirK+oWiZgaihXJUnM5mvlafVOsB8YzyZ4dWKzxj4
	9TmWeqbLCxZ9rlhNrTFBTvYGWlE4M35ETfUgfsySirueomM3w903ShEyGuiSZlffeFSX1fvx7Ja
	MmqKoP2eJ03hXkTPXXMvJXhJTKjj34X4=
X-Gm-Gg: ASbGnctwlMFSQq9IRCb6IB5+3MYD0r3PpqDzf+DuEIzYSjXE019JnsDbvNkQESdel6C
	lw4NZmK+y4tVmhU6CVGiklAfWJYAIKvAuJXGmym6WgDU3egHtBap2+GXDKlyTUy1S+0LQ1fZq2J
	CMS8L4YUdJYXpHD2KPNBPBIbVEQUx4oM5RIW9YUN89+AbQ5TORAqEC+DBJp8uUw4YQkvN77svhI
	66QIJQQaoqnZQ2VMiY2ArU9kUs9To7ckasXKzq3/qUtOR1rokbZexz/WQ0+
X-Google-Smtp-Source: AGHT+IHJ5X/g1j6lP0qjmOU4fOvCAdiC/VauUcbEb9ArOxo0iWsIHd4S90gC3AXBySoCa7I9XEUlm2stEllCzQdtg9A=
X-Received: by 2002:a17:902:f547:b0:297:d825:bf22 with SMTP id
 d9443c01a7336-297d825c0a6mr5657375ad.5.1762525683404; Fri, 07 Nov 2025
 06:28:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107125508.235449-2-phasta@kernel.org>
In-Reply-To: <20251107125508.235449-2-phasta@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Nov 2025 09:27:52 -0500
X-Gm-Features: AWmQ_bnq3Wjs0A3GFqnWs08XLNXM4-zvBTMXOBrzQDPdNRTyq7GOqJeUCRwyZMQ
Message-ID: <CADnq5_OU_bxHctMD5KjMfzsW4gaq8kC7fsO8TdgJr9kzLOCh5A@mail.gmail.com>
Subject: Re: [PATCH] drm/sched: Don't crash kernel on wrong params
To: Philipp Stanner <phasta@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 8:01=E2=80=AFAM Philipp Stanner <phasta@kernel.org> =
wrote:
>
> drm_sched_job_arm() just panics the kernel with BUG_ON() in case of an
> entity being NULL. While drm_sched_job_arm() crashing or not effectively
> arming jobs is certainly a huge issue that needs to be noticed,
> completely shooting down the kernel reduces the probability of reaching
> and debugging a system to 0.
>
> Moreover, the checkpatch script by now strongly discourages all new uses
> of BUG_ON() for this reason.
>
> Replace the BUG_ON() in drm_sched_job_arm() with a WARN_ON().
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 1d4f1b822e7b..3bf4ae0ca4bc 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -857,7 +857,7 @@ void drm_sched_job_arm(struct drm_sched_job *job)
>         struct drm_gpu_scheduler *sched;
>         struct drm_sched_entity *entity =3D job->entity;
>
> -       BUG_ON(!entity);
> +       WARN_ON(!entity);
>         drm_sched_entity_select_rq(entity);
>         sched =3D entity->rq->sched;
>
> --
> 2.49.0
>

