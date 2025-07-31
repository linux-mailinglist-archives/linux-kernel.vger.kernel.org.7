Return-Path: <linux-kernel+bounces-752531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF77B176B8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4F5543080
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436AA245019;
	Thu, 31 Jul 2025 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOTgpwaQ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569111632DF
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753990706; cv=none; b=PR0YiA8YcBMzBpbCZyAoOSGXR7tG6Wbhf1Q5dlNf825lawPsR1VvEBpvqCPYrcCi0hnsJyF43m5VXb9gkl4G29qmUMUg3PDp+trnydzn/tcCysHuo5NQ+qbVp6rkgTQ5foJsGtWR1thx6KjgX5A8VTok2nyFEKCdVAOws3rQkh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753990706; c=relaxed/simple;
	bh=YY3fSF5Z7pcaXneL6gC3VBg4tHQlvjDhTNzjCh8/IbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyHuFbrn1K+7viGDtfW3HQ3hWZh0XjNYpj/x7J3NICrxwNOX1E9oLCI908RjHZ0OMxjkQ7MeyKHXsIEePMZoqAv6L1fhadTg4tak7HyItVK9bJAO4eGe4+poqWRZ7JMjTFdvy9M4RFgc4KIqIlxnxm95qAAMZ3mlwxPf3J2s7iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOTgpwaQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23ffd0ec2afso1753035ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753990704; x=1754595504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nJQHYUhisfV5M90eMTD+0GiV2DAMpDGvtFOZlc232Y=;
        b=QOTgpwaQpvg6KyOh7w+IUhjj6lQ8eVYNw0JL1ZtSgiK5lzF13XUDdtZJcE1uz9Fs9T
         2bgUY9Ef6Zwmni2LpN/LtoulYy3Tj+umBUrjxj2WLtavLH443lcTaXscjIMa2c3OSinY
         HDggRNiBSDl4pbrph4YQo8C1V8uU7xXeyppJxccbMD2uvwvx0YeNjzXuv0xXzhbFpr01
         KoRzjuolRXUJLMLRI66CRlj0BM/1WyPI/ykM4QnQJFn/4ODlD36ErIp8dKp/Ve5f9O6G
         k+M3oVaYIEgJXn8awFxeZtSKjQZYqftc+gfEispfB0vNyoNfpxKqnd0zkZYRHBXEbyZm
         HHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753990704; x=1754595504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nJQHYUhisfV5M90eMTD+0GiV2DAMpDGvtFOZlc232Y=;
        b=q7FDmcXw9VVzGfOSUqt2h3j3rIu8QtLSZlek4n6BlBXKQfqMFxENpePixyXJaLTK47
         IolNSKJSl8gPk84Q2brhNM/JwfuakGGVWOKv0APYGMh8CzNISB3gEGVIkDZg4CTtoW9v
         ZBOqqRmleQEqAppPj0bt1lDVFjDQIWsxJFVy39iVgx++GJj7CbbpCHS+L7r09S1p65Dm
         +N16lYQr9gGwF4LtDghgrDd3LnJxhjIm1nyCB0gk1z84ub45YGLk8ebzu9+yu+n/+XM1
         qOJEFntsINggFLH2OnXTeJJ1Yu+66ulKt40AMi05BpcFVyh7yiGbsXiO76ZVm0bKLkA/
         Q+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5+PFE2QY5Rc/nFNuTMl2o5Sv7WLyc5DTh+HRPuD9AHNzDqgkB1xAkP1gBT0b7c17syvfuJ514a+vFLFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YybTULU8Yuxyz0oxl/kvBAgVUk+t3H87+GWnKvUsVPfOWZNWyTA
	JA775MfDJqSQpVYvtwuu5SFHwKPNdhQHNZ8THRNgCN8kPKVlEEqLauitRkR1lAccuhxjjaHkPmR
	46uvhsTaEbx8rTIQV00hTi4FRPJNwabs=
X-Gm-Gg: ASbGncvR/yoaL9FaGpwl8E48EMMdI+trEbuZDs3Sr7UFCcIkCVvhQxHjR2q9M8XYgx5
	OprPu832tuW9cral4VeSmaIScLAJnSWQaVpP9N10Ebz9GKA6/v2USr2u825/CUH8A6F7d4f/GoL
	4cGSDqOTcNHKzhQpvjq75JRpAWWhpj668xWOX1m3pzhBjOVXUztz4WlPM7339XE0BEchqm6c4kF
	KFb01jY
X-Google-Smtp-Source: AGHT+IHKraBiPAHAtmlxuZVn9jWMYVcl9dhr5+Dedao236F5TgJPt1RO39w04aZoFh8q/WQ0FU/W2AyRP7EdmZD4wuw=
X-Received: by 2002:a17:902:8a97:b0:234:8f5d:e3a0 with SMTP id
 d9443c01a7336-24096a45d8cmr40459695ad.2.1753990704517; Thu, 31 Jul 2025
 12:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731-b4-dont-wake-next-v1-0-e51bdc347fa3@gmail.com> <20250731-b4-dont-wake-next-v1-5-e51bdc347fa3@gmail.com>
In-Reply-To: <20250731-b4-dont-wake-next-v1-5-e51bdc347fa3@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 31 Jul 2025 15:38:13 -0400
X-Gm-Features: Ac12FXyBjD3ItO0dcnGXh1AljGbawzz44WIJXOmQ_0Y5C-recG2hknJWWCHTF8M
Message-ID: <CADnq5_PG1Am4OGkfKo9o9cfnvSdzwRFeYudbvw220+P1AHO4xA@mail.gmail.com>
Subject: Re: [PATCH RFC 5/6] drm/amdgpu: don't wake up the GPU for
 mmGB_ADDR_CONFIG register read
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 3:33=E2=80=AFAM Philipp Zabel <philipp.zabel@gmail.=
com> wrote:
>
> Don't wake the GPU if libdrm queries the mmGB_ADDR_CONFIG register
> value during amdgpu_query_gpu_info_init(). Instead, return the already
> cached value adev->gfx.config.gb_addr_config.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2295
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index fe1347a4075c4..ed4d7d72f2065 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -883,6 +883,16 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp)
>
>                 alloc_size =3D info->read_mmr_reg.count * sizeof(*regs);
>
> +               if (info->read_mmr_reg.dword_offset =3D=3D 0x263e &&

I think the offset of this register varies across chip families.
You'll need some way to determine what the offset is for each family.

Alex

> +                   info->read_mmr_reg.count =3D=3D 1) {
> +                       /* Return cached value of mmGB_ADDR_CONFIG */
> +                       regs[0] =3D adev->gfx.config.gb_addr_config;
> +
> +                       n =3D copy_to_user(out, regs, min(size, alloc_siz=
e));
> +                       kfree(regs);
> +                       return n ? -EFAULT : 0;
> +               }
> +
>                 ret =3D pm_runtime_get_sync(dev->dev);
>                 if (ret < 0) {
>                         pm_runtime_put_autosuspend(dev->dev);
>
> --
> 2.50.1
>

