Return-Path: <linux-kernel+bounces-782438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5001CB32061
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCA81B6008D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542222749D2;
	Fri, 22 Aug 2025 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gfxstrand-net.20230601.gappssmtp.com header.i=@gfxstrand-net.20230601.gappssmtp.com header.b="aEVO7K2p"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F043B57C9F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755879406; cv=none; b=oCWBkxL4KL2ycObifluMYpfbxwH+XgGUwCDfFq7SoqkQlfrmt1562KLOXWBNY/y0n9RI7ADOeIshtuUiQ54yFnaMEkpBXgMT+6Xv8Eo8vKUsCeZ/0o6ZQGmwpuGi+GKLowpTJ3aA8cbEaktK6MklPcH+vRubpDxWHQBKI+sLZO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755879406; c=relaxed/simple;
	bh=2dZ9JJ8UenH6LqQCycoKh08x4cEaQB9y/VnbIzsbLT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLoknMX2FxslIiqFS7frVoNTzbkEbUq638ad/OcPPG3UnxKK0+YqKogYfvCQjwwHxoW10a0teoQfyU4RPXTh/m+1AURUXmBxP0ZncwyW61bUzGk9BtZQ4T1wmrIfDE37vc946P66ZNjWfbflh//Cui5GuBlfSibyPOPvNpX5pr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gfxstrand.net; spf=fail smtp.mailfrom=gfxstrand.net; dkim=pass (2048-bit key) header.d=gfxstrand-net.20230601.gappssmtp.com header.i=@gfxstrand-net.20230601.gappssmtp.com header.b=aEVO7K2p; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gfxstrand.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gfxstrand.net
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2eb09041so2192229b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gfxstrand-net.20230601.gappssmtp.com; s=20230601; t=1755879403; x=1756484203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VORULNLKIsgd6AK0smNyc9txjd/WXm3+lJ8Yhl3Q7uA=;
        b=aEVO7K2pCWwB2LQk8li4wKc88TS6rsv6hgcJDCxCQlHeP+LG5kPLWBgJXOpSehNq0E
         t1NavaHTai/fnnYLB9tqUX7FJNbMWw7pJ1nN2t6qPuK17rosyh3AgpdKtz4QHVDE5Ei3
         IILFe9xolBUGUHV4MbcHe5ifNdr2WP8tFccisna1iESjI30BaAaC9oAFOrAlfbe5vMdZ
         crPD+ewVat6SXXap7IawchofxcM/KxRwSF6lEPLs70miTehpObyAcf1hgQS8S9Abka7/
         m8RhcKksHAfK/QhpLBe10fySC7TlY4Winsq49AY0T6XHuBo3Epx2K4hSMRCyaxzu5MEE
         C5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755879403; x=1756484203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VORULNLKIsgd6AK0smNyc9txjd/WXm3+lJ8Yhl3Q7uA=;
        b=FRp9IDOrvQ5ACO6uGH3GMSKHkZjRCiI10YrdG7KvWaIDg0SvGMOuEw/bjUT1NwXG0B
         MxMqcaQL7DxnULnjZRrOqR1pg8GDlboeEQtfvWpJTjfvSxQwoSjwtU9icLkLXqvyMjpB
         8GNGsfO1zd5vFMJxhCFHs5TxH8AEFeul+hx/AYb46p8D750Ohwjmr2pj5FUs2aPUk2he
         5CbljmAecCip3S1fEWeJv8G+iYnhAnQt5oWNFM5VEHxb4cy/slq2TVRwuLOwP2s2wigf
         UgCsjy5S9+/aJTMtD25EsLhTaIbo5+Ch0dTu/gf6eCQvt2ZOUKl5tPUr2Co1QdCTvVXA
         VaUg==
X-Forwarded-Encrypted: i=1; AJvYcCXM/Vbb/c7Mhq37VmZrLZDovoOj3M1uMFGm9pzTIOMSH4ssZKT/GfG4TOt6ZVWykTzFits9iFIXXZrSwUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+eLTLRFNZsuUTYJG2cLsEv65EfIdpTWYbGcUsacPlnnbKa6Z
	bGVJNWd2ABz0QcJBjc4i3OYidCLBc2WYqXUc4srt10wRcT90kdus8XSPJq9WHQq3Rgvo4RbpWfd
	PnB02EeHf0wtmHM/K5yr/urD+MlZKN3xoPqrzj+p7Nw==
X-Gm-Gg: ASbGncuFQUz6H2n5JX+g69pStu+hXCkgdwR6MvJgYPNG25CCxCNZay0qbeorWqyELON
	ABSykuy9UwWDnuxhM+0McdzdNapzspiN8bd2Yec5K9DakFk7fhvS6Sun2QLCNHb7A2+55BYWUYI
	EHBlsPYINXkl4FG/5KK7YtesbZQD6ZBdZD/HQEFWxLKcWU/UZEcYuDyJ1N7+ysFbOxdQYPNu7q1
	+VzcRA=
X-Google-Smtp-Source: AGHT+IFCOPScJgiXAHt9W/tv6ALf4TUM39Sss5K8dM2/wG27Nb+NxH8e8xkTkiJIfR/5m2L8pcRVxCeex+IPFIQsFWE=
X-Received: by 2002:a17:903:2282:b0:225:abd2:5e4b with SMTP id
 d9443c01a7336-2462ee02ab9mr64132595ad.16.1755879403112; Fri, 22 Aug 2025
 09:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811220017.1337-1-jajones@nvidia.com> <20250811220017.1337-2-jajones@nvidia.com>
In-Reply-To: <20250811220017.1337-2-jajones@nvidia.com>
From: Faith Ekstrand <faith@gfxstrand.net>
Date: Fri, 22 Aug 2025 12:16:31 -0400
X-Gm-Features: Ac12FXwY5O8zJstYmF625_unjewCDuAA6BkINcquV_AfyWgB8UjYK28Ggger4zc
Message-ID: <CAOFGe94vHrKX6jSGCuesRNUJPXzYBASK4WvqYYFg=EHTFcs8MQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm: define NVIDIA DRM format modifiers for GB20x
To: James Jones <jajones@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Faith Ekstrand <faith.ekstrand@collabora.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:57=E2=80=AFPM James Jones <jajones@nvidia.com> wr=
ote:
>
> The layout of bits within the individual tiles
> (referred to as sectors in the
> DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D() macro)
> changed for 8 and 16-bit surfaces starting in
> Blackwell 2 GPUs (With the exception of GB10).
> To denote the difference, extend the sector field
> in the parametric format modifier definition used
> to generate modifier values for NVIDIA hardware.
>
> Without this change, it would be impossible to
> differentiate the two layouts based on modifiers,
> and as a result software could attempt to share
> surfaces directly between pre-GB20x and GB20x
> cards, resulting in corruption when the surface
> was accessed on one of the GPUs after being
> populated with content by the other.
>
> Of note: This change causes the
> DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D() macro to
> evaluate its "s" parameter twice, with the side
> effects that entails. I surveyed all usage of the
> modifier in the kernel and Mesa code, and that
> does not appear to be problematic in any current
> usage, but I thought it was worth calling out.
>
> Signed-off-by: James Jones <jajones@nvidia.com>

Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>

>
> ---
>  include/uapi/drm/drm_fourcc.h | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.=
h
> index ea91aa8afde9..e527b24bd824 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -979,14 +979,20 @@ extern "C" {
>   *               2 =3D Gob Height 8, Turing+ Page Kind mapping
>   *               3 =3D Reserved for future use.
>   *
> - * 22:22 s     Sector layout.  On Tegra GPUs prior to Xavier, there is a=
 further
> - *             bit remapping step that occurs at an even lower level tha=
n the
> - *             page kind and block linear swizzles.  This causes the lay=
out of
> - *             surfaces mapped in those SOC's GPUs to be incompatible wi=
th the
> - *             equivalent mapping on other GPUs in the same system.
> - *
> - *               0 =3D Tegra K1 - Tegra Parker/TX2 Layout.
> - *               1 =3D Desktop GPU and Tegra Xavier+ Layout
> + * 22:22 s     Sector layout.  There is a further bit remapping step tha=
t occurs
> + * 26:27       at an even lower level than the page kind and block linea=
r
> + *             swizzles.  This causes the bit arrangement of surfaces in=
 memory
> + *             to differ subtly, and prevents direct sharing of surfaces=
 between
> + *             GPUs with different layouts.
> + *
> + *               0 =3D Tegra K1 - Tegra Parker/TX2 Layout
> + *               1 =3D Pre-GB20x, GB20x 32+ bpp, GB10, Tegra Xavier-Orin=
 Layout
> + *               2 =3D GB20x(Blackwell 2)+ 8 bpp surface layout
> + *               3 =3D GB20x(Blackwell 2)+ 16 bpp surface layout
> + *               4 =3D Reserved for future use.
> + *               5 =3D Reserved for future use.
> + *               6 =3D Reserved for future use.
> + *               7 =3D Reserved for future use.
>   *
>   * 25:23 c     Lossless Framebuffer Compression type.
>   *
> @@ -1001,7 +1007,7 @@ extern "C" {
>   *               6 =3D Reserved for future use
>   *               7 =3D Reserved for future use
>   *
> - * 55:25 -     Reserved for future use.  Must be zero.
> + * 55:28 -     Reserved for future use.  Must be zero.
>   */
>  #define DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(c, s, g, k, h) \
>         fourcc_mod_code(NVIDIA, (0x10 | \
> @@ -1009,6 +1015,7 @@ extern "C" {
>                                  (((k) & 0xff) << 12) | \
>                                  (((g) & 0x3) << 20) | \
>                                  (((s) & 0x1) << 22) | \
> +                                (((s) & 0x6) << 25) | \
>                                  (((c) & 0x7) << 23)))
>
>  /* To grandfather in prior block linear format modifiers to the above la=
yout,
> --
> 2.50.1
>

