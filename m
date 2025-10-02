Return-Path: <linux-kernel+bounces-840473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD511BB4817
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9483A8E54
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289542571BC;
	Thu,  2 Oct 2025 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3aLBYkA"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80BD2571DE
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421975; cv=none; b=JKDBchWYTgn8MTEs48FLCy6Quiqpg6P6aerz9AfZRN4P4z39mRLikVpzG6UQbci92VymyGbsuhbPuRm0XRVbJf5t6QGEIsQ2HV306sFogV4zbK2N/JNmfNblNMDOEx2Xwx+7QqKZ/doAy2Ni3D8JY6Pa8ldLNqU2FQKkHc2gRPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421975; c=relaxed/simple;
	bh=ZPXQRlKy7DvAJhDcXg8qKmtjel7BNxVUTlsy1xTSXFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeoY9B380gcTmocuG1pO1+U2vnM5I4VQhgy2BrIFMuBnFC7ElZ5eS8s8ggOE2x2FXCCbfdbRjhiHXe4GWOljFVoWYOEyVq4zDcYaGrmC+JVk+Y32MEmsCxYUdaC5abdgDV0+sJD8egWItzaMN6VHC05pQqEKj/XqEBjpiI2DymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3aLBYkA; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so1521358a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759421973; x=1760026773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpMkSTIODIVz672XTAf9Z0sXNTeFcRKxvrLWbh3ZoNs=;
        b=N3aLBYkAz9mugjRR1uGQaN2dMbX4RePSCaTR0QTFeRojs9qxbBmXcSkjcQtBQ8zzvQ
         //8dTcOoSdWVDHNj9nxjDEprF15p6jNoDjFCRwzGlX4HSkWc4njYt/FNXb1MclxEbnuP
         OHsfWBVeluS12s2lHW7QuTvib1Lug9FWUsC3+tMAgnNPoe5GopuuKMul7IbjT+QsDv5U
         X03fYVbQG7+9Vevi4E2i+bLATdiz6LJINbGqi0Y02C0rhmM1inueYqc11kLHoNMgWJOt
         qP5Kgon13sxJdzT/05T2ydCtKJeN6kgxO6kxy5ZssWt5ZlBjtw4ikGQKye7/OynkWjBR
         TIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759421973; x=1760026773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpMkSTIODIVz672XTAf9Z0sXNTeFcRKxvrLWbh3ZoNs=;
        b=BaP3D8Qt1MeZZjqH/Uk+dIZi3l29lrCiUqkXBpoZka/T0AWP8h5hbrnjiRPUv2F1Ef
         rn3ijhDoiTz5TTCB3dVmiwgBuBBArlMe6fjc2KQvU0o02iddn9V0slusOAPNMHnvrOCu
         IT4BiTI6GTW3qkAK/bf8IhT20/zoDKkwFEE945eB4kTW1tTogI7qT7iQFEOGmAgrG9Tt
         xDABHtKMxk4zDlCyBLm3seSBJ6YUKRFBEqp6I6ed6qArK6kaMGsm7WpepDYbxYO1INhV
         S3SYWtbQgVZlr15LgWL2wOI70yKsWktTqOZ8YCRFbIPdzZxMBgaoccIJvM92Z+suPRWV
         gfoA==
X-Forwarded-Encrypted: i=1; AJvYcCVCwj4L28iMJ+nrUdX9n6zePp3C0f5xBj1mj29R1Jc0yi6uMlqOWUaTayaaWEjOEEuWPDEyTcFschCfmb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDn26R8vI9ERjeo17nMJG5ND77TcuFEfTBtS7EyHgvFIfKz7XK
	LoBeLkylnJvaqvDyEQZhV1dddUgHzScN/UQ4QP/sr4ns79BjIKTRjCOywwtNRM4R0D3uVTiTTTH
	89XFL95DflrDwhpbV19XOKL1fn7yxTZtpQ6/V
X-Gm-Gg: ASbGncsLtE9eJ8CSUHAlEE9WRjsx7fyXl9ywKgTmI9S9EJFD73eUyOOePjRb7C3/JC4
	3l/PgHacyhhrS27WYVLx8S5CiHshIvE1utEHm06X9xr348pwMlbDIrpllkiiOOmBDt1mB2XGOAp
	eDLdUn7W73kikdBn21VvETTFLsYtY1SnMi+9HoZhBjCoNB7gn88blAeoM6vdSpqEV3ce4drv5ah
	3ZpmClxDikchwPDzHA96vKjEvWlIJI=
X-Google-Smtp-Source: AGHT+IHbkL/WNKmVnMSE57YLwWSgNCdRkBP77UN+85Q2tFn3u/n4pmtcGxs9O49PsDeqTKEuH4GQQXmg2wweCS632Js=
X-Received: by 2002:a17:90b:3902:b0:327:734a:ae7a with SMTP id
 98e67ed59e1d1-339a6e9d34amr8340975a91.11.1759421973209; Thu, 02 Oct 2025
 09:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822030651.28099-1-chentaotao@didiglobal.com> <20250822030651.28099-2-chentaotao@didiglobal.com>
In-Reply-To: <20250822030651.28099-2-chentaotao@didiglobal.com>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:24:30 -0400
X-Gm-Features: AS18NWDNM2mM7xaDu1Gqhxbq-umcw1yDXJVRf57g_FAqg_8SWK8_Fb2uRjWOCZ0
Message-ID: <CALC8CXcSywKnQop1Xipcq1Lbtmpu94tc9Eq=ORjCzNCjkSTPVQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/i915: Fix incorrect error handling in shmem_pwrite()
To: =?UTF-8?B?6ZmI5rab5rabIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
Cc: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, 
	"joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, 
	"rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, "tursulin@ursulin.net" <tursulin@ursulin.net>, 
	"andi.shyti@linux.intel.com" <andi.shyti@linux.intel.com>, "airlied@gmail.com" <airlied@gmail.com>, 
	"daniel@ffwll.ch" <daniel@ffwll.ch>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "chentao325@qq.com" <chentao325@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Going to hit us with a katana, Taotao?

On Thu, Aug 21, 2025 at 11:11=E2=80=AFPM =E9=99=88=E6=B6=9B=E6=B6=9B Taotao=
 Chen
<chentaotao@didiglobal.com> wrote:
>
> From: Taotao Chen <chentaotao@didiglobal.com>
>
> shmem_pwrite() currently checks for short writes before negative error
> codes, which can overwrite real errors (e.g., -EFBIG) with -EIO.
> Reorder the checks to return negative errors first, then handle short
> writes.
>
> Signed-off-by: Taotao Chen <chentaotao@didiglobal.com>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> ---
> v2:
>  - Drop Fixes tag
>  - Add Reviewed-by from Andi
>  - Add code comments (suggested by Rodrigo)
>
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index b9dae15c1d16..26dda55a07ff 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -441,11 +441,20 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
>         written =3D file->f_op->write_iter(&kiocb, &iter);
>         BUG_ON(written =3D=3D -EIOCBQUEUED);
>
> -       if (written !=3D size)
> -               return -EIO;
> -
> +       /*
> +        * First, check if write_iter returned a negative error.
> +        * If the write failed, return the real error code immediately.
> +        * This prevents it from being overwritten by the short write che=
ck below.
> +        */
>         if (written < 0)
>                 return written;
> +       /*
> +        * Check for a short write (written bytes !=3D requested size).
> +        * Even if some data was written, return -EIO to indicate that th=
e
> +        * write was not fully completed.
> +        */
> +       if (written !=3D size)
> +               return -EIO;
>
>         return 0;
>  }
> --
> 2.34.1

