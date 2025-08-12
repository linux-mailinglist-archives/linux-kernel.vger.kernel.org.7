Return-Path: <linux-kernel+bounces-765262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE69B22DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B2B172811
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902F42F8BCC;
	Tue, 12 Aug 2025 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN8U9rI0"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D357240611
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016133; cv=none; b=u+WsePwsWaSw6XMIQS4RaQfORIxH3XLm7Tvi+kKdMRPOZ1MyBxw7ZUDzQKlpBcb47BsGfWaF9vshFR8DqBUagmSEkQfqij0IiznAJZC8cWu8AclgDe8IeV1iwDsJtPlHWaM3I2oTXXf5Ux23I4UrWva1njUSTJz7T8/Tf8kjjXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016133; c=relaxed/simple;
	bh=O7oSLEZmxnYVDCnDh5Ybw5wS7c5OPxhlxFHz3c4tKhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKqaBOU2RIJJou1SkcT6vP7MgwB4/G/ySaoEno43CBlwQpEMR0cUsfViYbuA+FHehxbKdhfM5Ywx49/5o6dPoENf7L2FqqusoCONO3q7LboTb6Vl03F4xvj+eRIwvUx2r3jtlL2B22h42Yle/mNvLyqDbn9q7t9ORc9maEQe5BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PN8U9rI0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bde8901f6so555761b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755016131; x=1755620931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8XXWc2SnRetJzdkycaLv1Sy6oktVrYdWqBPT/1g+j4=;
        b=PN8U9rI02fSnWTopof7vNqZ6jl8wp0bnUV4H2cl8meLDxW6X1zfgtJwvuzJghJ+vJV
         ybllaB4dFqPTXnJvUAzrTpLqg6v8gXzCPf+ueB0+0cBIDh/bfFfDCrHMMTOlHhQNxfWj
         FLYmePPgfpeA54m3kgaf68soUqZ8aeACk1js63/4FgUa5KHd5yuzzJmCkXubwzUQ0fl+
         ZjNXktOrIWRF8OxyR9mql7lMMiJDpzEeeIdup/V1kvBB7E2UczNo7Cs/4I+zj1pVccmq
         /VyZzXdgpdnhfmw/s7TeL9U4pQ+1fBniAUTdMJLhpulfC0BuGrj9rF7IsCpPi3CZgPho
         eGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755016131; x=1755620931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8XXWc2SnRetJzdkycaLv1Sy6oktVrYdWqBPT/1g+j4=;
        b=VNuXmSJU2i7oooYopr/oJECjoLrspj28Dl114oo33r2YOyfXJFHIkKrSrOIW03cZGl
         COIW+E8W/h56+AX2rL1QXfFJULLwtJMHV+ITAGbvGXMOG+d5795tvRwRzFjtXIEeeoN0
         FZzTx/X2Go+9JLAVN1p9eDK6T4H7WysolSaFa/ZOFThwZRmL0xqq6NA0XI3/ECFYni/j
         caAVS2sCA6Ub3sMdqFiiqkH6g0TmwaK6MhDPvITInPJt5+O7bLu2ncTbFQmnotwjArbK
         PLYCFw9Wuqe+7moIEKhoLbHUBd1vOBymqnX9jfI35AxX3xBMtsEqEDdehMBa7RnivBmp
         E5Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXzRVpGD7Jou5ZQoLgS/2RGTx5gRYMfBVtSp3+bELuBYGmyuVvBYMvGhIIxUaymmL2ERWUGa6SOzo+ZIm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqE8ML/qigWsEk6mV1Lb2babzdFnC5ULXRjPTjdDbZNFS71yyX
	bgIts+zyQGA4k+WNf8MWt32XFDXaeo0ViqpyiFW46/v17cmkD5DtFKh/YWN9SZogVzxcSqbxeXF
	LAg+y+I4cKpyM+SprW2ugTGQy2xeS/FI=
X-Gm-Gg: ASbGncsYq9hqEW/AKgtmRnjjEJ5AQUx7XEpqu1RAQ/Wwgq9WuY3BXTzEqlU47f2ZuZY
	LQVl+EF4ju+VtCTAXze0Dwq+HOgMTWTbibqmJbgivoOdbkBdFhOYNViTwSg9yYl4SnmK+O49DGA
	RtCTkpuH+IsxQQbI4j6OUOGbyu6lu1OMpAI0kr+Xtp0pw57OUJJgqAV1Em/GbXKzcg1uFC4p6gq
	jRr/w4=
X-Google-Smtp-Source: AGHT+IF7UGNoWHAY2HBfAfn8v6UyctnQGA9lFULx5VpBJUqJiWlcxTy5uqrxR2lo6+lp5MVHHbDGSUwHdQbO0yPEfQk=
X-Received: by 2002:a17:902:e841:b0:235:737:7a8 with SMTP id
 d9443c01a7336-2430c1033bfmr2211895ad.3.1755016130853; Tue, 12 Aug 2025
 09:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812075017.5370-1-liaoyuanhong@vivo.com>
In-Reply-To: <20250812075017.5370-1-liaoyuanhong@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Aug 2025 12:28:39 -0400
X-Gm-Features: Ac12FXxy3-M_wzEetsEfVe6DFeHMxdgLbCQg5APkZ-SqZKW-POTop_GS7uBXzuE
Message-ID: <CADnq5_OAdOx5s-76uyVFRZbsStpvRh=rngJ=uKcpjb4HYaJz1w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove redundant semicolons
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, 
	"open list:AMD DISPLAY CORE" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Tue, Aug 12, 2025 at 3:58=E2=80=AFAM Liao Yuanhong <liaoyuanhong@vivo.co=
m> wrote:
>
> Remove unnecessary semicolons.
>
> Fixes: dda4fb85e433f ("drm/amd/display: DML changes for DCN32/321")
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  .../gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c    | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc=
_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
> index 9ba6cb67655f..6c75aa82327a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
> @@ -139,7 +139,6 @@ void dml32_rq_dlg_get_rq_reg(display_rq_regs_st *rq_r=
egs,
>         if (dual_plane) {
>                 unsigned int p1_pte_row_height_linear =3D get_dpte_row_he=
ight_linear_c(mode_lib, e2e_pipe_param,
>                                 num_pipes, pipe_idx);
> -               ;
>                 if (src->sw_mode =3D=3D dm_sw_linear)
>                         ASSERT(p1_pte_row_height_linear >=3D 8);
>
> --
> 2.34.1
>

