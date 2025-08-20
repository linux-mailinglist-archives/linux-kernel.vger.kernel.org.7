Return-Path: <linux-kernel+bounces-778401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D9AB2E510
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9900C1CC25D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8262773DC;
	Wed, 20 Aug 2025 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRYusP2g"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612532F4A;
	Wed, 20 Aug 2025 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755714833; cv=none; b=cI8S9AX+H3Va1Mx94tVEEoC6Skq2RuvK80mwwzWpgIJbpTvR3zFxuhumTxVjZguPviVb0+H12G/xTH0ErNSBuK12Pkq2y84KwY3r2oQV6174BipYU6ZiOLdti6OEkI6IkQeuQgmabNfoz5Ps2F4RNZXZ3EMq2MCUk8+z0zxaSA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755714833; c=relaxed/simple;
	bh=4VhT8FfHLfe56J3qPPhQ2cW+yREx7dbjirhN5ZOr9iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyNxVaabB7jP3vuoMod6X6qZLFWI8TfbyqOifzd3c1bBBCByUgrc1gWrItF+R2FDjSCF6ahROAyObRL3szooijesFpyDQ6DG+NiX8Po+ab9IduIZ7fDQqxvnR4xKBGP4iFK8GpGUkL3d8NxQpYvRDnPAQXXdqI9+wQR+ECbZS0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRYusP2g; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2e5d54bbso30546b3a.0;
        Wed, 20 Aug 2025 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755714831; x=1756319631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8aRl9t5V6Q7AnpZxPp/thjhXQZ7yIoJiGvCzobrjvA=;
        b=WRYusP2gzXwDL3UbpbKwSBmlNscVbmXX3cUWMLnKuaZynq0xNMZ6/uZO3MbZlamAAm
         Z418lq9zDCmKjLIwSt5U6wekzy/+WG1l3otDmx3UIK+OlSbhAMSUeT2+J7bFgagHXHg9
         KFEgiXkY3lqUKJUhU/J96NSyN64d5gM3YeoebDqkwZgtWddlo2fMo+IKR6X/Qrvj3KIM
         lzQLylP1ChbHXD/fcTOkjaoLbPa1QkxVcFg12Se8SR/AlKiSN3iEgMt9ww+vhLj91c4a
         JVWkPLrJXyONDyaR+a9OxmMQpTSaRrbmwydkcYqYFkBb1i8qq6XJq68Rkx7A/sVGLQVl
         wZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755714831; x=1756319631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8aRl9t5V6Q7AnpZxPp/thjhXQZ7yIoJiGvCzobrjvA=;
        b=Vi1qif1d7daTLnTddNgXm6ejGx6vhkeaXtTU6awNojOwh9k5SZkQpBLn53TsRNX7d0
         RXMwxFtLyK/rULl4hxpT1dpSFK3IsskeVEaGAHUDCk5dAlWG58zy5Uj3EsycwJTjH0od
         BvLf0+DlGqnlEqZzymmWmSxb6L7+a0E2wxJmkY/77B0pXZwErjJ9NEM3fXHtMccmXzeJ
         PueSebVjTCIYAHcZTgb0BQ0yrKNEDDQLtiTOMsn/yHpvbnPS6itxZ9iZMkW9FVW/SE1I
         nVt9Iipvmjyo0mw0sDW/TRe5tqGRGZTWmO4MD0CC7oUujHCmpPGwuIEeD+wbepODwxnf
         zXXg==
X-Forwarded-Encrypted: i=1; AJvYcCV1u4Qv7RkXb4n2b2f25bsPsZ6qBwwQMH+0euy2xiwpKqnsOKWfkN2eb7dfOkAqlN/DxlY/8gcd6B1dStQF@vger.kernel.org, AJvYcCX2t/Mc3q0UgkB7buP7VUlKsBVKu4JyuRKQyMOcFkbtXWhWbDN0HTFpd+JUxMuZgA9yq+z78j1abc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8uKYJyr+vH/e/yxnh44RTyYN7aBlqbbS81dlTUvbrpnGuP+7D
	t1cCVo4ZyWzYViHKgnWkv7J6hYO0CYHUf5s0yNJdpQwpF0Ch0tT/cDD7vA0ZWpGVdn/vc1t7wsb
	u7U+iyI6L67cUgq1aHoJlWXBykK03JghzOg==
X-Gm-Gg: ASbGncsqHp/MECGMJJBAvKa0tGSAu/EQQaXVWFSKl4CjInk6QB4/8WuUKwvvrlLkXRY
	4FDa1hMv+48Wjp0F5R3eyNX+Eo9ebljhv2HXPqOT8CPZlL8Uyv9XkWVSRyJWxRozu93z3ej0ZY+
	gXVEpg88UtMhLPNZ52KB/MPiPawOKcmowLhzeH4XP3OrGd2ygXrX/OPZoOZPkIuuI2a00CfiZj7
	LUkSkk=
X-Google-Smtp-Source: AGHT+IHkAy3ca8+jtID/FoWqYaW09/zltQ/aw0SuoLJmcmEe6soi3YAyE7iSaLKvBR0EQAXgHSLAxz7i4pKA8GtkmY4=
X-Received: by 2002:a17:902:c410:b0:240:3c1d:cbe3 with SMTP id
 d9443c01a7336-245ef1117cfmr27184545ad.4.1755714831408; Wed, 20 Aug 2025
 11:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819211957.17871-2-katharasasikumar007@gmail.com>
In-Reply-To: <20250819211957.17871-2-katharasasikumar007@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Aug 2025 14:33:39 -0400
X-Gm-Features: Ac12FXzaT8tBvm_ZbhXzy1ligYMWZLBJ-gPMSwG1SDqreVmeqsoG3xwj0dX_b9Q
Message-ID: <CADnq5_NJdEtMqMfwW8ZN-nNyJD0dDnB3sYYGHeSb5JnwsUyPTQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/gpu/amdgpu: Fix duplicate word in driver-core.rst
To: Kathara Sasikumar <katharasasikumar007@gmail.com>
Cc: skhan@linuxfoundation.org, corbet@lwn.net, alexander.deucher@amd.com, 
	christian.koenig@amd.com, linux-doc@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Wed, Aug 20, 2025 at 8:32=E2=80=AFAM Kathara Sasikumar
<katharasasikumar007@gmail.com> wrote:
>
> Remove duplicate word 'and' in driver-core.rst.
>
> Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
> ---
> Hi,
>
> This patch is part of my work for the LFX Linux Kernel Mentorship
> Program (LKMP).
> I would appreciate any feedback.
>
> Thanks,
> Kathara
>
>  Documentation/gpu/amdgpu/driver-core.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu=
/amdgpu/driver-core.rst
> index 81256318e93c..bd4be32f2725 100644
> --- a/Documentation/gpu/amdgpu/driver-core.rst
> +++ b/Documentation/gpu/amdgpu/driver-core.rst
> @@ -65,7 +65,7 @@ SDMA (System DMA)
>
>  GC (Graphics and Compute)
>      This is the graphics and compute engine, i.e., the block that
> -    encompasses the 3D pipeline and and shader blocks.  This is by far t=
he
> +    encompasses the 3D pipeline and shader blocks.  This is by far the
>      largest block on the GPU.  The 3D pipeline has tons of sub-blocks.  =
In
>      addition to that, it also contains the CP microcontrollers (ME, PFP,=
 CE,
>      MEC) and the RLC microcontroller.  It's exposed to userspace for use=
r mode
> --
> 2.47.2
>

