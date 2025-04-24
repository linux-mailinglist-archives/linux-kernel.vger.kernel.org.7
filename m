Return-Path: <linux-kernel+bounces-618731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85088A9B2BB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 17:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C6016BA59
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 15:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E527CB0D;
	Thu, 24 Apr 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="t+p7faQV"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F8B223DF9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509440; cv=none; b=q5ZjfDg/RN6JdUPfGUTzDhvO7SFKAaOn2L/rxNXzhqE39g97b4G4dyWrsrN3z5MnfM0Kh0NVWqgBhp8ZX3zbWpQJ2Oewz1msGKdpzOje6ggi7DpqGEOSXHuKuQGACQa4M891HKxjUXB+jz8tz91piT491+/CmVxV5DS2Dnvtj58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509440; c=relaxed/simple;
	bh=PrIt9cti1YTt57yyhwhu+yoL+H0Pauq0wEpWZElruNg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PLp9Y7dZPrut6Y0uTTCpsUEpZEpzDr5PGtAEmxlpOW7+1TTfR3cbjhNjBhbmc72xx/O7X4fhtwiVKObs8VLS63dgLRD7nzQBF13gSUspWRBAnAefFoQxzkgsOI4h8fOCly9d6BpynrstBPYHF0iGKLhnXsM1o47ByGpZfW+E22M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=t+p7faQV; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4774d68c670so19781141cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 08:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1745509438; x=1746114238; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PxG91MvO3mEZmIhtAaDJXqnva49Kcev69TBhblsIWrY=;
        b=t+p7faQVjB+XtCOkcmZXBFDP3t3+pPIiPbFUCVPjTnTU8FQA8gTcLxKVD0nrwQGSp4
         oVgM865DLG7XB4fV0U3+82gwY9p5fHIw6si6KftvrZyH2psdwC3u1a0veYN8PjobmaH1
         BCDuJmaYrG2g8XoQ2WzyUErbJQ0aefE/Mr5xrfuKs4Kx3zcemNlYHJUglxmqrO0ZfKWY
         lsLyyzopjF6esf5XfXLJBcwSHemXrLlXqCnciNpBivIWO770U+0sL9+9mkudfs9MdIYV
         SQtmci8SZwjUf9rBHWPpt8voxqbhrT6//UIa5FGc4Y+i0dkGNXQZ5rfIMEaLvz0lbAgZ
         sBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745509438; x=1746114238;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PxG91MvO3mEZmIhtAaDJXqnva49Kcev69TBhblsIWrY=;
        b=P633NJ4Pp2xOGPwcngtd14uWgKgcx5YYj47g1K46Raw+XoLWL6p0bk8C43jzUoHeLL
         KBWYVFyOv4Jjt4Cc7oF/g/P4gDOGOrJLtCpqj493bkg18Dx8ga9pn2yGcdOLbGDUPHTt
         xDLI6uK/8GE9HneaQtBuAhIph9wQMWMx2RVo5dTA7gfHRzxvPGAwQD8AHse2ygY4HuUZ
         NEhN3TAnmCMwLpGVFW5RonB0DHnXTSr/vQqVOsBsqT605tRontT0DDQm8HsG3zkhR53s
         doWYZwNjoaQeb0HML1LSC7OZZf8t8yeId8f0H+v0xBt89GjyIwpTcsP4DD9CHMAjfX8k
         A5jA==
X-Forwarded-Encrypted: i=1; AJvYcCVETKwYPpgrlWKBB7Wb+THNzoGDROMT69wlh9vXo5TRlvUuGLnUlhj7yhhtQJqFthR5dK8jFBWOwKp6XaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJckR1qtE4RJQL6CIGdIdPaCIDgnj9jFpt+f0nvIW6lk/pMopc
	WXwmwN932enpiUqBRCZXPOyUIQGZx90nX52DLLvRb9a61AUrj3KKWP2fYWf4tQ0=
X-Gm-Gg: ASbGncsNnBKDdiLI8EuNbU/lvDaNxHJDT3HjuFfO/fVmq+YnLFM5H0fS133XidfrSfX
	slvg6U+hOpwSdEUxw1v80pnI/NegfkzspCu8BPbI5IdEjpzctJO9wLXVlUuyHrPkV6YZ2R7YO2m
	02izRIoKeAjjw4UY8VEjW2C6kAmAnNXrzf9vOKhESNiwX6l6qrqW/DCSNbqqt2x9Slc2kdixfwY
	XhtJCVOluSgYx8G4tQveZxP8r37xtq4BCEoXO6mnvVDJzUguybYufzw7vCMlukfqXYFvsjUzVM8
	SmX9Fwq8LTflefwF4gBah+snB9/0AoMlXzN40fnKIQyZmw==
X-Google-Smtp-Source: AGHT+IGA+IIOug/obYsp2byfQYiQAcdnJn27C+FPUJJIN+Z+DBmj+uagyzwdTCFBqechz7yf+kP/FA==
X-Received: by 2002:a05:622a:153:b0:476:b7cf:4d42 with SMTP id d75a77b69052e-47fba39b562mr2788641cf.27.1745509437827;
        Thu, 24 Apr 2025 08:43:57 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:9913::5ac? ([2606:6d00:15:9913::5ac])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9eaf2086sm12964521cf.8.2025.04.24.08.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 08:43:57 -0700 (PDT)
Message-ID: <6148110c513d2177d886469c2276c6810eb93c34.camel@ndufresne.ca>
Subject: Re: [PATCH v2 1/8] media: v4l2-common: Add YUV24 format info
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Nas Chung <nas.chung@chipsnmedia.com>, mchehab@kernel.org, 
	hverkuil@xs4all.nl, sebastian.fricke@collabora.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-imx@nxp.com, marex@denx.de, 
	jackson.lee@chipsnmedia.com, lafley.kim@chipsnmedia.com
Date: Thu, 24 Apr 2025 11:43:56 -0400
In-Reply-To: <20250422093119.595-2-nas.chung@chipsnmedia.com>
References: <20250422093119.595-1-nas.chung@chipsnmedia.com>
	 <20250422093119.595-2-nas.chung@chipsnmedia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le mardi 22 avril 2025 =C3=A0 18:31 +0900, Nas Chung a =C3=A9crit=C2=A0:
> The YUV24 format is missing an entry in the v4l2_format_info().
> The YUV24 format is the packed YUV 4:4:4 formats with 8 bits
> per component.
>=20
> Fixes: 0376a51fbe5e ("media: v4l: Add packed YUV444 24bpp pixel format")
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> =C2=A0drivers/media/v4l2-core/v4l2-common.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-c=
ore/v4l2-common.c
> index 0a2f4f0d0a07..de3636f1cdf1 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -269,6 +269,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 f=
ormat)
> =C2=A0		{ .format =3D V4L2_PIX_FMT_Y212,=C2=A0=C2=A0=C2=A0 .pixel_enc =3D=
 V4L2_PIXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 4, 0=
, 0, 0 }, .bpp_div =3D { 1, 1, 1, 1 }, .hdiv =3D 2, .vdiv =3D 1 },
> =C2=A0		{ .format =3D V4L2_PIX_FMT_Y216,=C2=A0=C2=A0=C2=A0 .pixel_enc =3D=
 V4L2_PIXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 4, 0=
, 0, 0 }, .bpp_div =3D { 1, 1, 1, 1 }, .hdiv =3D 2, .vdiv =3D 1 },
> =C2=A0		{ .format =3D V4L2_PIX_FMT_YUV48_12, .pixel_enc =3D V4L2_PIXEL_EN=
C_YUV, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 6, 0, 0, 0 }, .bpp=
_div =3D { 1, 1, 1, 1 }, .hdiv =3D 1, .vdiv =3D 1 },
> +		{ .format =3D V4L2_PIX_FMT_YUV24,=C2=A0=C2=A0 .pixel_enc =3D V4L2_PIXE=
L_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 3, 0, 0, 0 }, =
.bpp_div =3D { 1, 1, 1, 1 }, .hdiv =3D 1, .vdiv =3D 1 },
> =C2=A0		{ .format =3D V4L2_PIX_FMT_MT2110T, .pixel_enc =3D V4L2_PIXEL_ENC=
_YUV, .mem_planes =3D 2, .comp_planes =3D 2, .bpp =3D { 5, 10, 0, 0 }, .bpp=
_div =3D { 4, 4, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2,
> =C2=A0		=C2=A0 .block_w =3D { 16, 8, 0, 0 }, .block_h =3D { 32, 16, 0, 0 =
}},
> =C2=A0		{ .format =3D V4L2_PIX_FMT_MT2110R, .pixel_enc =3D V4L2_PIXEL_ENC=
_YUV, .mem_planes =3D 2, .comp_planes =3D 2, .bpp =3D { 5, 10, 0, 0 }, .bpp=
_div =3D { 4, 4, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2,

