Return-Path: <linux-kernel+bounces-800972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B180B43E59
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A423A2695
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2373304BDA;
	Thu,  4 Sep 2025 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4Vx1b4p"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC22F60A6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995296; cv=none; b=GAFG9EKQPYWanwgVBk1KcmTF7p+kbl17u99hLQc1G5d9AJr9NKn9HqSN0FBSs39OcpKPQWtc0JXvOF7b1olZ2aGPWRHKd4StJovvDntObLaRoBBwRt+IsdW/Wp/KWeXPilR+MQA8C6rEw3NOVynFKMyZEokwI0bJP+S9hvRRcKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995296; c=relaxed/simple;
	bh=0kMI8AUGUiGWWUzzugT1/q92Z00smhdTytjYWKEa+Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nc/GICNtsK6LYNC42SMrjzTtIes6S+/qKQjDWU+FY/FashYzolI/WZUHIWshalR5gGGlw0m+u2fVT8kBC34egiO4+o80mogyXdJNNFpqL1SUlkWE8hwNCA1l8pj5ydrYxh3EEuorhh8Iea0norbNKc3ps4oznZ78HsiB7TsKfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4Vx1b4p; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2edso63978a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756995294; x=1757600094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0xCHn0bUk3RHmh2GHFzu+yYoz5Jb1g0VJrR9c2n01c=;
        b=b4Vx1b4phfmAEgYfTWHh9D7B4GAR9HJS32QvgVZFkVu+jHvY0jYuU/Bp0jrB0sANmK
         dSEk59TaVfoygsOCGi0rkpGV5y6BVJKTDCR8th58sPtD54bMJ6Gi49Zg+THjbJ7Bo33Q
         3C8i92VE4n+dh54rOiR1bTD40d90tU362gswSWPO4vL/67ChtEy+v8dEFp0cSDMfwHb/
         5b2W5WyIrJWOlZuOWl1RAdrYjRZZXiHrK1/lR3zSponMNSB0B4OWxzqdQ6jjGjL+SFXO
         Le5BDoiJkfNwO0nW9EFWNHImaEzwgiAOJwTyCu/+vc8qIzWl+5i26v2/8YXJamL3rRBm
         sXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756995294; x=1757600094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0xCHn0bUk3RHmh2GHFzu+yYoz5Jb1g0VJrR9c2n01c=;
        b=AllD5JAEW2serXwakOOZxQ6IYvApUwxSTzswOOTzXdyASRWJOqMYeGqs7sLyW/0+2j
         VmF8i7jBfN3fmhG5mpInC1PPoZdFa5lq+WROJsd/4tSClaNuz3DQ2uqGwyuMXO8t9KcL
         HempcgaOCRCYBAf64eZl8Hw2plGomqsfye06qMEZ3Vg3A97gOaRyteBJnPWLbgNIkA/W
         rARl+pdhRp2XwionD+gFgh8O+F4q9kRidceRy8qtSYY3avcohnzXBTr2v8ODgxmlOJ7W
         Ecra56A3UYvILYCuD+4wVnK5NMMtIWJMqY32vg4/nGDyqb0coFLp5Cj5MxIOYcKKo5Nr
         Qtkg==
X-Forwarded-Encrypted: i=1; AJvYcCVUn8CTIbrXt0PeT1NBelveQptsqEWj8KopE7T+mdSZMf0SLMROPxDjTFFb2nzCpwQ5jGvv6snwNvywh/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YypEtomv1hPkZ53z7PkflrKqdU90lbZSbbOCMYJsJMDDMLdcHyb
	jmwG96JknvUxQX0QoSeAfd1Rsln+2Tz+oZRDB7zT+Gy04kEFXDLf85/2Ev30vTgXpIHNED69uB1
	Fs0WrHZmgtQ++CTTMbUWBZod6ylQmnFM=
X-Gm-Gg: ASbGnctxNDz0WPZYUtF2079vobnm86UuRYYDipUicvxT3VLPK3Udq3tFmdYwz1l2gzD
	su8rpPEJq44wuPzb1gOfDiREUm7uIBSwzwDbP/zHBij/8BxvS7fTydp49T0ybIkK3kc+7zJchfd
	8OcPwK0a49pGmq6n9uCk5N5JDY/GPILwwsWvlP+R4E8QiSLoW81A6IjHXTmRv+6L1jXA5Q5ztpn
	c9uTf9c+kla+4y1DzJQ/de8M0ld
X-Google-Smtp-Source: AGHT+IHY3FHcpQI3y/30onEh0FHloQof42J1vxR31s3RTApweweMvjqY9ReAEMFZe796M1YtxA4JTJC1ZLJLiBFF0Vc=
X-Received: by 2002:a17:90b:2dcc:b0:329:d47f:c25b with SMTP id
 98e67ed59e1d1-329d47fe8f4mr7703925a91.7.1756995293683; Thu, 04 Sep 2025
 07:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904113201.352187-1-liaoyuanhong@vivo.com> <20250904113201.352187-5-liaoyuanhong@vivo.com>
In-Reply-To: <20250904113201.352187-5-liaoyuanhong@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Sep 2025 10:14:41 -0400
X-Gm-Features: Ac12FXw5h-JVKiihSXykGZz4Ep2zEIjYnJMnvtC57T25AA1hrZypdJYTR6p1els
Message-ID: <CADnq5_Mf7xsK3v2r4EKR8crOQ=1WxhvTGNEmQAKLkY3XJuBXpg@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/radeon/pm: Remove redundant ternary operators
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied the series.  Thanks!

Alex

On Thu, Sep 4, 2025 at 7:49=E2=80=AFAM Liao Yuanhong <liaoyuanhong@vivo.com=
> wrote:
>
> For ternary operators in the form of "a ? true : false", if 'a' itself
> returns a boolean result, the ternary operator can be omitted. Remove
> redundant ternary operators to clean up the code.
>
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/gpu/drm/radeon/radeon_pm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/=
radeon_pm.c
> index b4fb7e70320b..a855a96dd2ea 100644
> --- a/drivers/gpu/drm/radeon/radeon_pm.c
> +++ b/drivers/gpu/drm/radeon/radeon_pm.c
> @@ -907,8 +907,7 @@ static void radeon_dpm_thermal_work_handler(struct wo=
rk_struct *work)
>
>  static bool radeon_dpm_single_display(struct radeon_device *rdev)
>  {
> -       bool single_display =3D (rdev->pm.dpm.new_active_crtc_count < 2) =
?
> -               true : false;
> +       bool single_display =3D rdev->pm.dpm.new_active_crtc_count < 2;
>
>         /* check if the vblank period is too short to adjust the mclk */
>         if (single_display && rdev->asic->dpm.vblank_too_short) {
> --
> 2.34.1
>

