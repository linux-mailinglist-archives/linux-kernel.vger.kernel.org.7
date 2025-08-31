Return-Path: <linux-kernel+bounces-793459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09787B3D3BC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 15:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532AA189A4A5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 13:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FD9242D7B;
	Sun, 31 Aug 2025 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="SxQv0gk+"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F22512F5
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756647999; cv=none; b=UCWIb0bWAgh25eBYVZuzxslB8M/86n/OuY8k5JVIMAvb3uPrslXa0Pep5eMs6VIKl+LSy+8ZIEQRi5AwXJE+tYYiQWbkcMyypuU+ng2v3DXPAD2LwjZkLNPf0yTOYQOZGTz0IzvHmcBzPa6TvvQ98Q/HiAbu5Vgx5d2XT7+p5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756647999; c=relaxed/simple;
	bh=0d5wm8C4Q5yjpa9NOEPusF9Ma+0IGpCMou/z5myvIx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOpTn5TdHZJlNJPj0yQC34+hEJ8poGJUxSQRdL6PXjEjrz689cIjZeByrV1JOf+mESQoVm75zhZODZIowqdi+yHNmwkwVBDci70IOyWfDqV+PRT8bzTpXfBgyZSr5xwF8JdRjB1ndrLViIc3mqZ7oNziNKsI09xM1fJFq9WzXF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=SxQv0gk+; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e8704e9687so344628285a.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 06:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1756647996; x=1757252796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jwybc7U/Gu47otp5cNNeYZoMPwQff+yr/8w72U7737w=;
        b=SxQv0gk+gVRSkfvPkkfLfl7PHO+1eabhvWdBzNey1YHeu1Ir3/twY5tWUG/jAlCmDH
         ZOELCk5K7wkvThoACMveqwcYZVjN1uKmZcVXozZZrt7VMx8gNUy/cFkBFPu9TW+IN+r2
         R5g4kGTKS6d4YFsB6AVlcUKdjK/x6YtN+7/mxo6ciNGqbIhTaGi6neGZab9CBBMB/M83
         8o3ED/hiBlzXmL7A19TMoy0QBHXLl9DsApb80+1pn9+yoU3V/DUG+WIsXXzYpTLbAe1K
         rX9Ry2gfUAy3Nc+h6PJ0U4a+iap+AmxaQAWvNB1aa1ibgQ5eD+62V/VXGCrHmX+Sn9me
         Depw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756647996; x=1757252796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwybc7U/Gu47otp5cNNeYZoMPwQff+yr/8w72U7737w=;
        b=hDdMfw6Tp3xa5OMWWpLl8am47EbfSXRKtKB/IZ/8ku9MsrvfTo0xC9JAdShgAkoA7J
         14oKD0eE9E2s3ihlhictYITgO0Yxhz/5vKs4tz5dad/QsDUkYd1cnWH3NR2CeOXUTfTO
         pYwKD9h2fvenxFAfOGL/eg1IbhlGX+2TDrEgjjRwoClYk6BwThHQWPXOIpZBp5mEIPpN
         ASfNAYGZ17Uyiaxr8lCTb+8EJ/NA6Gm3mX4WZcB0h2ezv0QzG5CnE/4Y1O15bIJ232ii
         30L4pH5fuR/b4FtbQ3Ft51ND1sozTF8lXLAHjpfdfPWH4eNCRn5qEkmA4x5GdbCH4H5W
         i4sA==
X-Forwarded-Encrypted: i=1; AJvYcCWu0w5Uz4MMMGlE0shmIutVBwF9v6dJWSOqSD8O8VmuZ+u8sNWqiLsS7HIvb6/5aVCzjZTGQUTCkRAZMII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhKuR6V6CvgbaiwlrzLqQ6aUBB5iH8Jq2IZaG9VgTXvHvYcm9Y
	pURnF89PeG2BYXNaZYyzL1OjhPkjcpA1om1DZU4Y8VpUILdhyPhQdIokyYh2ZffJH4pmp8tDm8H
	tGqvHFetNmBIw/HiklyA4+w6oUTIT4adUoPaLo8NHew==
X-Gm-Gg: ASbGncsCCT6X3egIe9v6uHCjUkFosZ41bsunJvBMLCJ7MdS9BpUFD1yAb2I4OaPhGgG
	wD8TMshYoWHR7qFStOlLxP6bCmtHif8JfbGlRjzaFci+MhWxPJCvB8I7/kLakTXavBDMSD5q60b
	rm6NC+5kV13oSLGUOwdpVRgi6tS8loP08xaCY0Ug5ztcTN1fA8PFwJRbq2voXUy/HG4KgB09TAh
	01mrQ==
X-Google-Smtp-Source: AGHT+IF0dh6mtaD+ci0SXGWWOl3LWwfmYnKKOgfGlK7FZ7iXiuG8d9Mqq2iCDHrHKRWGSRl6Gppx/kRr2i15hBvQ/kA=
X-Received: by 2002:a05:620a:c43:b0:7f7:c2a3:eaa5 with SMTP id
 af79cd13be357-7ff2b9817c6mr503403385a.68.1756647996439; Sun, 31 Aug 2025
 06:46:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830-drm-limit-infoframes-v3-0-32fcbec4634e@oss.qualcomm.com>
 <CAPj87rNDtfEYV88Ue0bFXJwQop-zy++Ty7uQ9XfrQ2TbAijeRg@mail.gmail.com> <57ekub6uba7iee34sviadareqxv234zbmkr7avqofxes4mqnru@vgkppexnj6cb>
In-Reply-To: <57ekub6uba7iee34sviadareqxv234zbmkr7avqofxes4mqnru@vgkppexnj6cb>
From: Daniel Stone <daniel@fooishbar.org>
Date: Sun, 31 Aug 2025 15:46:25 +0200
X-Gm-Features: Ac12FXyJd7t7ZABF85TqQwXSEhwFfQP0deD84tmrq8IHkkpEGuVOeuzNQcUs-Sw
Message-ID: <CAPj87rOSb90S_TeA8Cu5kd-M8bbfiE0fvPzgr9Gr4e9_rfZeFQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] drm/connector: hdmi: limit infoframes per driver capabilities
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>, 
	Samuel Holland <samuel@sholland.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Liu Ying <victor.liu@nxp.com>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,

On Sun, 31 Aug 2025 at 00:29, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
> On Sat, Aug 30, 2025 at 09:30:01AM +0200, Daniel Stone wrote:
> > I know that dw-hdmi-qp can support _any_ infoframe, by manually
> > packing it into the two GHDMI banks. So the supported set there is
> > 'all of the currently well-known ones, plus any two others, but only
> > two and not more'. I wonder if that has any effect on the interface
> > you were thinking about for userspace?
>
> I was mostly concerned with the existing debugfs interface (as it is
> also used e.g. for edid-decode, etc).
>
> It seems "everything + 2 spare" is more or less common (ADV7511, MSM
> HDMI also have those. I don't have at hand the proper datasheet for
> LT9611 (non-UXC one), but I think its InfoFrames are also more or less
> generic).  Maybe we should change debugfs integration to register the
> file when the frame is being enabled and removing it when it gets unset.

Oh right, that's really interesting.

> Then in the long run we can add 'slots' and allocate some of the frames
> to the slots. E.g. ADV7511 would get 'software AVI', 'software SPD',
> 'auto AUDIO' + 2 generic slots (and MPEG InfoFrame which can probably be
> salvaged as another generic one)). MSM HDMI would get 'software AVI',
> 'software AUDIO' + 2 generic slots (+MPEG + obsucre HDMI which I don't
> want to use). Then the framework might be able to prioritize whether to
> use generic slots for important data (as DRM HDR, HDMI) or less important
> (SPD).

Yeah, that sounds good! I wonder if we want to surface that from the
debugfs interface: maybe just files named 0..$numslots with the
content of the infoframes, one named 'slots' with the integer index,
which infoframe type it's currently carrying, and which types it's
capable of carrying. Then to preserve the current interface, symlinks
from the infoframe type name to the slot index.

Cheers,
Daniel

