Return-Path: <linux-kernel+bounces-889426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E72C6C3D865
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03EF44E174E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA55B2DAFA4;
	Thu,  6 Nov 2025 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU8tLoHA"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ACF8F54
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762465626; cv=none; b=XPoi+hwlAXFavggljROJ3KtAWBFpdO+kef8P0xyYMhKRW0h3ejQWPV8C4WNzusBfi5Zne1uyaI7suVUly0PPtz98cPhvvSG/IXgXLTLRcz3g5rgUiFWEoOLx/T4gEC7ae5A1u80T3bbDulzngJDsXlL6oUKjndty4flb6WxLH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762465626; c=relaxed/simple;
	bh=m1TOJ6ksBDDbMlMk0ihxKpNSfOol+cSPbD3A9MSynjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZieCmYOphPhiphRGU3j55l0+kudyUKu608TPOk2Ssqml0Wt1tBOkWelkixLhkFhOT+c8BPAUAwvKBH8gwV9bDjwICFyzJOTEezs6wLSxljFeLqOx+AWaPeCEyVQCFfGw8YB4q5t2yOEzfJLjYXGc+M1oUEQrquYxQqGlzQkEgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EU8tLoHA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-295395ceda3so69695ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762465624; x=1763070424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWPFs84U37BlV4HR4UfJZaWnurNpPXzSHUa9OWSU1Mk=;
        b=EU8tLoHAj3hzyQS0OrH/foevIDPsw4Y/BjtvYsAhQKmPTtpputKkO3hATFsZD+/ZE+
         nVTTYwGS0Z6SALSxQ6WTCDJ6IN6Fl8tNcezuV+GmOHsGQmt6o09rGnBx6Lw1fvZxR0SI
         N5yVzay1qLI1lsEKzRGYsIp7QBiUXHGu4LYZsyE2NrxRfvp2hLuaYl1eA1D9Tq6we58m
         gTaUbUYfNndcgzrUJjSVQIBcwalHC9dS6jPO+P7n3uHt37dpHbAgoj5z8jK/bt8pUFBN
         c7qrkWfDBRpZsx5HDx5KrVUIaILISm9nXD7T/HNStgNLr9qD+wWSEIBMl9hfVVtNUo0H
         jOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762465624; x=1763070424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uWPFs84U37BlV4HR4UfJZaWnurNpPXzSHUa9OWSU1Mk=;
        b=IiHq3TTsqSsA6eGaAiX4C0lq/YFipGJNhsOHDA+0fbCpsbSF2fBgOytmI4/fbJuQFn
         jTYAHHGZJIKr215rkv4rpVMOOS59v7AOeZMkFG/rkkPGKggCureUKVi3aXGTckmdePwd
         1w3+N2AZgEdUeC1KC/I70bSdX5LY68GCtQ6+zjD355U325vV4yBWOSGLqwKPnR2HulOk
         UkgGHbdO8rSp9D5exbQWWgeeTkqSvchDekisORV2bTnSVQUogAlqcI8TGH0rRbEP9TBG
         xP2XdfZdJwxjRuTkTBtuHhbIszSu6w828fTuM2UGABilmjX1m+m427t2hAvBmgc72Iws
         P/Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVgogJDEOwQhMfzCbsT7zWUpPJw3V50o7YRwJE59VHoo6KNjJY3PoWJTxXBZpM5v5rHKjVkTCdcPP7iWOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOTdZMFxVk+Xbg6R2MVo46bhkpnkkWX19lKZkqwWDSyrQ71CL+
	IiOqd1+Kbbt1eFm7O9PAje8HfEV07atQGUSkHRljRCidghquiDrtFcZPi1vIFcr9hzxI4+Bmmzx
	8hcjsIUFEsaTa13IPvXhkyEIP1MN9ZQs=
X-Gm-Gg: ASbGncv43b+Kf7e1jQ9htNwGb/5x88jCHciIbfAaNknHhvAcyw4fGvOblOeARH4YEmt
	fz7JZ/stq3w2IuVw9zs2fGAgtFizfv8DFMf6LNptmWNpF+KcHCMe2KTRnF9qKda1wSK/LcnlhJd
	a7mJn2ZX8L7MWF3j18iTLutVoQWtm9IDzQL3iFa6v8XoTiRFYxmj4GjZdnJqVEOaFszmq+Z9fQ9
	12s8ZsHHJgsPymmFDEaeIaqOCWyxib/CoGBnxin64L/xUpz7HetBqG3WuZh
X-Google-Smtp-Source: AGHT+IGwLxGeQwObIqsiRu60FgdR14mXv74V9sIBJquRbETpjgO/u71xJ576vnpk0XVXFQIkzHnAysyK3vaO7ZiVXAg=
X-Received: by 2002:a17:902:e552:b0:295:2cab:dbc2 with SMTP id
 d9443c01a7336-297c045708bmr8072615ad.6.1762465624074; Thu, 06 Nov 2025
 13:47:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106014747.46768-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20251106014747.46768-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Nov 2025 16:46:51 -0500
X-Gm-Features: AWmQ_bnzUjJ6HcFWpYUZnTLKwOZeb_N2f4pDuMRdliAyH8rVEieFGHJCx9d4LU4
Message-ID: <CADnq5_N5bZ20A4gwfKevVgzTrTRw=pGPmXEB+1wTMNMqfOHy2Q@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu/userqueue: Remove duplicate
 amdgpu_reset.h header
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Thu, Nov 6, 2025 at 3:56=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> ./drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c: amdgpu_reset.h is included m=
ore than once.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D26930
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 836a14ef0052..9a969175900e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -32,7 +32,6 @@
>  #include "amdgpu_vm.h"
>  #include "amdgpu_userq.h"
>  #include "amdgpu_hmm.h"
> -#include "amdgpu_reset.h"
>  #include "amdgpu_userq_fence.h"
>
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
> --
> 2.43.5
>

