Return-Path: <linux-kernel+bounces-776048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8BDB2C7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64F518885AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CCF27EFF1;
	Tue, 19 Aug 2025 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/ZB3UA5"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AE527E1A1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615524; cv=none; b=F+DRpFpQ828EQd13wAgSHff4X3HAy8BVrwbshQDyH9wKxH3rl704ITuHW/JexXGmrEzpqrqNV9RD/XxybWrMwkLFOHbe0lCwkyP5Y2WN4jGYDsvCxC1a0HCEEZfIc9eRtmcqbKDxCOFWytLq1mvaQH72eSpAIKYUQ/lVhZJC2SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615524; c=relaxed/simple;
	bh=v2b3dElqg+18ycElwp5EbkPw0NXtYwnXQot/2vJxe4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2xEAh4qLiqTR3JKy6hPJPYZvsNa0du3X9ZS44pvRdeJBqwCHjeePARvmsc3aXsuzdJWh2s9/e+Lk7TWgcTTfIp4SPpQrzT12okIHMZUOAmuWTlSIq/qLYbAm5uEMl3+GYeBEzkH/wrA8olXu3tdev0UJyETQLbodArcxZ23Jyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/ZB3UA5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2447d607b70so3291505ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755615522; x=1756220322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfPFYHO8LgjsfMvxfw+sgzT7X98jNtWXiuJDEFaajRw=;
        b=T/ZB3UA57/rGGMARdaNTn7gZpgO/u5Kn0m9XZmoDqRiwO2adlKQam3aDssgTyKUAap
         l1O68jwIymGg1d0tNLHiIB8+nLlsZJtBzH4FxRlQ/l8dwostX4mu4m/3g7D0mgNNWwlX
         KpLUlD6+8sOo2dU5CBAM9AtCwlU9gEqa7GP1Yhw3hm1xLOSPlHa6NKI6kmd/Zb8HVIEn
         XhlMclrxhdKoYjUZlNGfbZVS/69Vrxb4ZUuXZ6DL5B5BRjeBuB/sB7prNHcU2WiAPrKN
         Xlbz+mcK+a5HIDWK3wMPYN9ml04EtkgWDaWpomIC7RNUetslJxrbNSSemMw6nuqTxZVr
         Z3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615522; x=1756220322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfPFYHO8LgjsfMvxfw+sgzT7X98jNtWXiuJDEFaajRw=;
        b=VqpJH1SU028XqFbd5gY7vy6N679Up/8MuFeeKcWcoXvkb8uW7/PQtql6stN9b17vvn
         wlmoRoCvkxRhi1HXBEImNJqKSwJEQfki+Q+xd3FoZA2OnzFi9jwlCT0nWOvT2JrgejHu
         2iRy26BukpEczxkL/lShZS8tG1NOvp9MsmzMNzEc8U8bUJc5txCZLyuKos5fgcFyCHv0
         HaCgorhj3oVYcDbpIkVrdRq8PJH2s8ICiKjS9I+79romco5iGLluSuBJTi7cT0Duga11
         518dzYwp82aEpETUSeyjCAudsXFtqd+HWnECGUBeVQ0Sfx07jegrlRhMuSWLOuF9KY9z
         ek+w==
X-Forwarded-Encrypted: i=1; AJvYcCUfO7wM/ZdvshkEZZs4ovs3j59IT7s2XR2vv3BuPT+wy54Kv5LY1XqIfmfb+vCAhOhuFSoyR/6bLIv+mfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxknciIsCdQMwgVbP9V4yTJKZVOeGSvtSdUKpFIEHY9gO10xj+K
	Ov1sLBkqbvIEbez90ubhWEO30OXB1vDBm0BPSQMRxpx0Xi9SjDFnzO1o3J1JjOcMXTTpKSdy7UX
	EBv32SFXItk+c/FLVDw5VlnPYpoZPB8c=
X-Gm-Gg: ASbGnctCUoGBLKpUHKNo8H05Rvhsxzi7R5653uJUdS+Hi1dQp4fcMdjx1IJ6UowVzud
	/t1zktCiGKDTrQ941cYFnMbdU6pj4MAzScONzUy3BMQp7L5QUuUoM8XP3IPnCRzdHz/6qd6kat1
	0e/mLo965G5Si2avbMiq2WZK4CfrTd7OSyktCveSOx9HUewMvYjGeajChFjPBSEr9n1RE16Mxoh
	N2lqZ8=
X-Google-Smtp-Source: AGHT+IEu+kTxRqCVTWGmKUUlh48Cz4IPdwyniv5y9FLrM2n3DQL6QBcqHwkIXa9ftDeM/WMl7B6pNWoTOs6Fqp/KoZg=
X-Received: by 2002:a17:902:e5c9:b0:234:8f5d:e3a0 with SMTP id
 d9443c01a7336-245e04410d7mr22304635ad.2.1755615522059; Tue, 19 Aug 2025
 07:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819142453.368440-1-liaoyuanhong@vivo.com>
In-Reply-To: <20250819142453.368440-1-liaoyuanhong@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Aug 2025 10:58:29 -0400
X-Gm-Features: Ac12FXyT9JMEDwUxumFLGLORwKYFJb99cw71NnptTHv-DsTYVW8iN-K8zH3TdQc
Message-ID: <CADnq5_P78iHtM=kQQhiY2nf9j_PKnQKSqLNYchG1bcY56jWYvg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove redundant header files
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alex Hung <alex.hung@amd.com>, 
	Aric Cyr <aric.cyr@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Dillon Varone <dillon.varone@amd.com>, 
	Yihan Zhu <Yihan.Zhu@amd.com>, Muhammad Ahmed <Muhammad.Ahmed@amd.com>, 
	George Shen <george.shen@amd.com>, Reza Amini <reza.amini@amd.com>, 
	Cruise Hung <Cruise.Hung@amd.com>, 
	"open list:AMD DISPLAY CORE" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Tue, Aug 19, 2025 at 10:33=E2=80=AFAM Liao Yuanhong <liaoyuanhong@vivo.c=
om> wrote:
>
> The header file "dc_stream.h" is already included on line 1507. Remove th=
e
> redundant include.
>
> This is because the header file was initially included towards the latter
> part of the code. Subsequent commits had to include the header file again
> earlier in the code. In my opinion, this doesn't count as a fix; it just
> requires removing the redundant header inclusion.
>
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dc.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/di=
splay/dc/dc.h
> index 1ab05eabbddb..2ceaf861edb9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -1854,8 +1854,6 @@ void dc_3dlut_func_retain(struct dc_3dlut *lut);
>  void dc_post_update_surfaces_to_stream(
>                 struct dc *dc);
>
> -#include "dc_stream.h"
> -
>  /**
>   * struct dc_validation_set - Struct to store surface/stream association=
s for validation
>   */
> --
> 2.34.1
>

