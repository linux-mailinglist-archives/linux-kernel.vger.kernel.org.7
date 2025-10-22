Return-Path: <linux-kernel+bounces-865181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2EDBFC801
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F72625EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A9834B412;
	Wed, 22 Oct 2025 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5jn9DZK"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3B52F0696
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142090; cv=none; b=Syb5IQgNF0Z1hAr7OHwMzexND3dWJOT+Z0Q9rHSyLMozurdbqfUuYB5DPI583clzySrEwMoFGbnFc8ilGOW901AwIwn+wlXlLQq82OJuRoC/2exxjLHSF1/cjkgmNafMRkB3ULuwP0RRCJGG4DZjklnjWx7VadpRGlzDNSCXNHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142090; c=relaxed/simple;
	bh=n6MZQWS9UxRif9lNNulxaU6i8BsuZ5VcpBJFujfN/yI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+rS84jnYbF9nlgWe2fdlV4mX8ZTJYLkAs+y46HKS7YvGp/6QEG/AC+YDzhypot+V0JsQEHqvV4biN7tpagJt7fRN8cOrSolZ8cj+Uanlk2qOpnU1Ded11AefKEyBJVXKd4HYsP0/eMhpiKcDC7M9fWZ1S5rDqO4aAhuyKK4/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5jn9DZK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2699ef1b4e3so11650855ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761142088; x=1761746888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxWecD44n8F7A68MtB2Gk3SGRDfmDIC8qrgGGOx9IvQ=;
        b=L5jn9DZK1yikZIa4fYdhTzlJ63nQ2IGV0pgyS0h6MHui7Dy3NnAliASW7jNf1YeKCx
         JUVyvP06V+4uGjBfOKA1hTOUBpN4oPi2vYGVvdLkBTO46LxH7WSj9twZBKg3i+DAQjt7
         QMQADk1l621dlM+rX4FZ90FicW6zpacAKxAbcxPAgimQgKo1G+exHITZAM1E+TAUV29N
         dLL44o0F6C04kA9v8Vr1gQnLMP/YbRQerRa9qGKL79ddJ47SY3rydvTqlCPKcS5Tag9U
         q3gkMnwnW88RRLsW1wqrBhZLsEUkM5NtHUaP+zmCm7rZAUaYLEl3BH5BjowFz8Dh+SUF
         2BSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761142088; x=1761746888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxWecD44n8F7A68MtB2Gk3SGRDfmDIC8qrgGGOx9IvQ=;
        b=bEDXWlK/5f34LiDTJ/zrktEw5Y2Uc0bktKDCg6equ/LOOPEqxbOTAGjXOhMyjNI6Y9
         EOX7U3G5RhId6suoJncnyKQbMZlMCqzF2o7n7IJ686+gV4Ju3R4M3bqD2ZNekXYisGiV
         yN0u+28376k9UQ8tgGMqWayHPm7WH24dRtLpP31hT14iI7fEoHwnSenO49YE5IZmNPOI
         KEMQfRN9KgbbG52wjKDyFCc2nUOFssDezZ8H1TebqM5jsFlmsYZ52wzfdG3/Zgru/zWB
         GLylt7b873pd/f+h48nbS4nv0EUAMIgArxl0CpnL2gzk2v69csEdx4XzwSx054kcSLMI
         xnIA==
X-Forwarded-Encrypted: i=1; AJvYcCXGBzu/QBcUv/L4xOJr4QeVZypELKKxyZZ1QLWL3ZKKO+muopZp+UZs1NGTfECxIZpQ8fqDZHkwdkRVCKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjNGQmAa8l2jf1QgcC/Tq9B/JF82/HqCC7jD1TUYLrklYRorIh
	bQGuLmxiJ3uLiAne+lIbeR83BICA0K+LsdBig7YvyzIy5Q7N/zkyzpxbaEXwFNNCEEa6bSy4IxM
	C1ah7lLW78ZHkhr5YLq7TXpEuKYXfdhM=
X-Gm-Gg: ASbGncsynpSbgTun1PdNJYr1T3jx3hbJ4agFvIunaxPD+fXiOFT3pM5pB7gwdfeNbEW
	O3OGahP7eQIS9CZJUFdf5chnnWxHP+qn69JmBJinGO5+UrhkIsZM/slWYA8k+dbWtLtCnp2LFnt
	bVRecG14wBCCMAhtSO+kiaBCOk9H7VJQKvRDh0nvRDaJa8dIpRljqru3/8rrV8tR3Rcax5RhfOy
	4WufJN5FYVpCacmUGO1MlmWi1upW9C1xvZWsZQ4Qa9Jb2QS5ZY99IJpg0rX
X-Google-Smtp-Source: AGHT+IGM3mvFgkHnTG7QRIj/Gmy3p+LRuhhPAH5vukdmhYx7TsNqfkR+YhVrgCxY2EWb4hIpzDcGres9mluYuxqKhfc=
X-Received: by 2002:a17:903:120b:b0:28d:1904:6e77 with SMTP id
 d9443c01a7336-290c9d26917mr126853125ad.3.1761142087899; Wed, 22 Oct 2025
 07:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aPi5_CILMKn3ZrVd@stanley.mountain>
In-Reply-To: <aPi5_CILMKn3ZrVd@stanley.mountain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Oct 2025 10:07:56 -0400
X-Gm-Features: AS18NWBdUcj9BuAc7F-BssClfHNNkfo9ryZDxZvVPhEuoCs-u5I60K5betUL5-0
Message-ID: <CADnq5_MoG0s7K5wCaf8-32SWCnOeaPkYvDCyixem_w_jVBbgag@mail.gmail.com>
Subject: Re: [PATCH next] drm/amdgpu/userqueue: Fix use after free in amdgpu_userq_buffer_vas_list_cleanup()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Prike Liang <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sunil Khatri <sunil.khatri@amd.com>, 
	Shashank Sharma <shashank.sharma@amd.com>, 
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Wed, Oct 22, 2025 at 9:31=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The amdgpu_userq_buffer_va_list_del() function frees "va_cursor" but it
> is dereferenced on the next line when we print the debug message.  Print
> the debug message first and then free it.
>
> Fixes: 2a28f9665dca ("drm/amdgpu: track the userq bo va for its obj manag=
ement")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 9d4751a39c20..2200e0bbf040 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -159,9 +159,9 @@ static int amdgpu_userq_buffer_vas_list_cleanup(struc=
t amdgpu_device *adev,
>                         r =3D -EINVAL;
>                         goto err;
>                 }
> -               amdgpu_userq_buffer_va_list_del(mapping, va_cursor);
>                 dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
>                         queue, va_cursor->gpu_addr);
> +               amdgpu_userq_buffer_va_list_del(mapping, va_cursor);
>         }
>  err:
>         amdgpu_bo_unreserve(queue->vm->root.bo);
> --
> 2.51.0
>

