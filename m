Return-Path: <linux-kernel+bounces-788824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96507B38ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482B5460B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5E52E03EC;
	Wed, 27 Aug 2025 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3URCBi5"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267B02609FC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756325653; cv=none; b=H04ig6RjAe/xlo9HMuhMuOWO+izSozK+1EdVF0l0Dutq25vonABywU6E0AIqBOahhm3h4RN2ebF8fbfyyTP2etZOo8GEJ0esIKwKw9lnL6zUbGifRXTlD6+CVEQhRrwAW5gRCTi6DpDTx1EW4Md+MAKyw/EvzU+IdkzDYXJMh40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756325653; c=relaxed/simple;
	bh=aAzcAfgG8Ih2yZLm11hf0ilVbfeD6WSzVq65EPsjs8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsDrLAV3ol+8V3yTyuLXwlpgJJhNriCfeCaCc+Nk6PESzZAkgCEXy4cqjuCI0dwU1wbEP1XKMSMhq+o2QBFf2Qhe7RYcnqFbWHKqENSRwb6/ntrj6XmUxZb958RQuqtSGtlzyG5/gZKUts+pgQ2dpLtsDiWstg7Nkc76qRDMXd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3URCBi5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2488be81066so389085ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756325651; x=1756930451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlufRgie91QgTam9xSC34zQrGY0Nj6hkzf3Xl64IrEI=;
        b=b3URCBi5zj3ObjwtKhFBnxZ/gV6HOQg7MgTRN3ydivmSOWXUtNuWAvJfUE6B9705X6
         O7tEPMqLuIXnjzdrBFtiWIygL7JVuNJ6ilXmTd6mWMkS5PTwXJ0S6k5Qpc2Ec7DJcRHR
         0DLF7J9NdGLyTkfA86ps14W3FtT7lWWvFmeL0xWVMNHgS+jia7bLhcmmPIHjALAl4gxb
         lx7dZIHmQB+REib55Zx6pHCJCxo4lsNDu++bZalFAkwE3KrUCz0D8hBT1GUQbe/n+TAy
         HHaVMQB++tRZwCf98qnFFV4H8T0inIXiGV9D9WFRHEMmC4q7Ri5c29NV72aVanJpVcRN
         K5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756325651; x=1756930451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlufRgie91QgTam9xSC34zQrGY0Nj6hkzf3Xl64IrEI=;
        b=WUt+/J9l4VCSiVztzZHz+T09nRbT9+/jC/GdF3MeuHZ6LHT5248XqbbEdwGgqK9p7z
         Mx5ANt/9HCo/7L4w/icslRqMgHOYpe+4foBtR93L4js0ZQHx6k3IsnktQRxKcb9vidQz
         9F2T+r1eIe1HQDTNpY6ai3ZXzb87F1PSrYUHH+ct7aVFTfojr0OUejQz/n5UYWgDitWd
         U5sjuFCJfWDotSqa5sIe64NaynaM2gDE+CFS0cWKrzF3PRV5xokbC8524X7WXf7WklBn
         /BdTUY4eMMpelDxNV6QBVABrEMI3xLgpsWzedv8ImKQPhixoEEwvh55RV/epnyKZrPv/
         34Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUU1zrX6A/D45zLakuVt3041nqkap7mwe2kKLD6xJFaI5gWgtMzK4CWtZB9dHpvpx4bbuHGBiv96aaQN7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx42V605FNlwZ5Hqwld/s7BbTUi/gODxXqlS+t7EkDgoXHfWmfZ
	r+UdhxsUkJeBoYzR+Jci80gBoN8tQrVdnODPRJPxk5TyqBVrPjoyzMm82QzTkOwAAMI0Hq49xwI
	jboWccHq8U7hpUGiwlZgUHr2T9vIesh8=
X-Gm-Gg: ASbGnctebYNy0FmMARMDqNj+kyKNROTCZ4+FHxV7Ab0xHobmauoOu1BSKx3raD/9K6S
	vYU6xflRCPqM1fECkUwU551tgWFt5nCHqOIAOvYufZyNLT/sa1AFoA4ypv+g/ponJgdOlRdpAOk
	MY2wZtFbywLDmnMwfHioGoBXwpOt9vEKD0vzzEml/da5qA79ldC1iAX3xFSRIcFqHn1VSrdd/y+
	tvw8vmF53sJCATobg==
X-Google-Smtp-Source: AGHT+IFrr5jFKjpnE8DrRgdjnkjAjrqoK6JTUZFNF2hiIHZxWtLqdu/5EvB4/E0d9H3HhNfbu22mum1R1mgd/ZnN1U0=
X-Received: by 2002:a17:902:f689:b0:246:b3cc:f854 with SMTP id
 d9443c01a7336-246b3cd0030mr95147505ad.2.1756325651320; Wed, 27 Aug 2025
 13:14:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823202540.487616-1-kavitheshnitt@gmail.com>
 <CADnq5_Onr6rR12NVagwMHURPfuQxBoVq8Qhui6heH_m-5eHsXA@mail.gmail.com> <5e065f3a-9237-4798-9380-11c43b477882@igalia.com>
In-Reply-To: <5e065f3a-9237-4798-9380-11c43b477882@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Aug 2025 16:13:59 -0400
X-Gm-Features: Ac12FXyaAs-5dxZif0zb7XyNWucHk08jDJxEwJTUXNmK5agirepWHrhYt6lUYII
Message-ID: <CADnq5_MwNuSLWePB-GvkAbTv-kf=uxy8y7nd8ZSpPbB7NUVjhA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Document num_rmcm_3dluts in mpc_color_caps
To: Melissa Wen <mwen@igalia.com>
Cc: "Kavithesh A.S" <kavitheshnitt@gmail.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
	siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
	airlied@gmail.com, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 4:10=E2=80=AFPM Melissa Wen <mwen@igalia.com> wrote=
:
>
>
>
> On 27/08/2025 17:02, Alex Deucher wrote:
> > Applied.  Thanks!
> >
> > Alex
> >
> > On Sat, Aug 23, 2025 at 4:25=E2=80=AFPM Kavithesh A.S <kavitheshnitt@gm=
ail.com> wrote:
> >> Fix a kernel-doc warning by documenting the num_rmcm_3dluts member of =
struct mpc_color_caps.
> >>
> >> This is my first patch submission to the kernel, feedback is welcome
> >>
> >> Signed-off-by: Kavithesh A.S <kavitheshnitt@gmail.com>
> >> ---
> >>   drivers/gpu/drm/amd/display/dc/dc.h | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd=
/display/dc/dc.h
> >> index 59c077561..06f05979b 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> >> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> >> @@ -234,6 +234,7 @@ struct lut3d_caps {
> >>    * @ogam_ram: programmable out gamma LUT
> >>    * @ocsc: output color space conversion matrix
> >>    * @num_3dluts: MPC 3D LUT; always assumes a preceding shaper LUT
> >> + * @num_rmcm_3dluts: number of RMCM 3D LUTS supported
> A bit late to comment, but I think you should keep the "always assumes a
> preceding shaper LUT" part.
> This info is still very useful and links shaper LUT caps to this attribut=
e.

I'll add that before I push it.

Alex

>
> Melissa
>
> >>    * @shared_3d_lut: shared 3D LUT flag. Can be either DPP or MPC, but=
 single
> >>    * instance
> >>    * @ogam_rom_caps: pre-definied curve caps for regamma 1D LUT
> >> --
> >> 2.43.0
>

