Return-Path: <linux-kernel+bounces-792771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE722B3C8BA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7045E1D3B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 07:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DE221FF3F;
	Sat, 30 Aug 2025 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="L0h1himm"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30FB1DE8AE
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756539047; cv=none; b=DMnnlzLlv05aNjm7GYFClMUNiUZIWKBh42Q8hJHvdu84iA8hQeJr7IBQEgVOXg/ws5D8FcJ3ZRe3prZY96Lu67BE8xJBqRxD6BHMW8ifrllzk4mLzEhRZSIdTEs8eN+eSD7OH4FExy6EIkNAjSHEtpiaJou3IhIM9XLG9dKh/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756539047; c=relaxed/simple;
	bh=3vk4uw/k5t/ngjT55OkWyZFL8hHut4oedMZiTZnhFuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBvbRK6fprtj1j4Y6q+MhjaO13krbCF+Kf9nwiuixiH0FUBjm4rVrk+a0U91eOJ9lPa74AIflVIIzR28x0aV/7B2wgqb/+X9NgUz4Rg3JXBOz63J6Pc0dVK3aoy7ALR7FWKA0lUHctn87FJ6VpRR1Aco2UILIE51w+kHKHzuG6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=L0h1himm; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b30d09da9dso15440621cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1756539044; x=1757143844; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3vk4uw/k5t/ngjT55OkWyZFL8hHut4oedMZiTZnhFuY=;
        b=L0h1himmD7qmCHCr3OY9F/cKeLGrCafLNsg/4CuhWVVaSTkboR5MkSxXEdrNvrIIah
         R7X4Ep3A/PkBhR/nIULkJptstsm+2ARKj7r3xDjeoR7s571MSdm8oNlb7kQOmEvww0//
         d6uQaRHE3/osmHcucktClk7h/Wp6zvCdmTpKlIs+pMeRlPGpLF86Po+45dmUjqN84wN4
         jDw58sc5VAMnNP8hjLx0nSjZr93Yp6zzr6EbIfbQu+FXXPJgp/6FFqSthXPjq2EYnzm/
         MYbHP2+nVJDDE7jU6Fd2+ylqqT3dS9QJJFnyLqn/GTHjMIxgfnk+ym8Fbgmman31rsJH
         m2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756539045; x=1757143845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vk4uw/k5t/ngjT55OkWyZFL8hHut4oedMZiTZnhFuY=;
        b=dpyDxUbwD991LKDSK8EcUrOw9F80SMsp7Itlr/mBgz9UV3l4TXK0aVWOMUj6GQcGD9
         zBGbUHHWObZJOJEOt5VPxOQXUfZQFEoHnnSSOnvcxSyen43KkN60iHiXVp4RyJ/207oA
         rCZTawC9Vgm71iXeg2UFOxHvfWJfPkLiMUzNT2LxFOuj1s6IAMYJdHX+uJj3PRwBjimR
         aAF1hy3lH9R9NpxdajVZHdYxTFX07fsfc7V8peqDNSqAtzf3Ft2TWzKZYPRj0b34FkdL
         We/Fhz69v7oL6xeBSyYiq1ksGzET710wyhPFFTkin9hymRWHqwrojZggwKzsgW63eVHh
         V1gA==
X-Forwarded-Encrypted: i=1; AJvYcCWqNHTNNdisqLBgZSQKxIHsST/tbCdWVAESEAufrxAWJmQHKaj+e9vLKzqIz6xc9himwtbNT0jvrhTftwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDWEWLhuSkCp3slWzs0qvlFZP6dIl11VvsO2/z48hJUPiENFp+
	MTfk+a7gGG05sa8AbeaRtzPfBYuPPzsPQmgCcTYWX+Su0QDr78X0YEYJXA6VuSZU9Eh//NnAScH
	ZMgHrZaNyLLlJjaQ+LMpc1m5qvQhSd+M9RvK7I+3xRQ==
X-Gm-Gg: ASbGncsBlojHYAPOOfMYPRtcEnzHGMGdihQVHZQ/9nuPz2g1RpwMqug7TYhuxL++Mlr
	05Z4XuHgLxgAyM2ZYwJQBZ08wPTx9mdm01VBNzTZrUUthxbYsl9/gj0JIA3WY9EuT4ODNG18Hi7
	4w9w/nazJAeG8IRlVskXt5PRvgfpp2qNPwo77lgS7VtI91q7qa8aTQuvG2xcyBlXewovJwXbjl+
	dGnRw==
X-Google-Smtp-Source: AGHT+IGOnM65THr0nrJ2LPLTiMMlk+HvsXaVUyczPlRtZjJ7WLdbodWtVaS7JfPnD9Na2PcQiHxYrYNu+VnO9BqbaFo=
X-Received: by 2002:a05:622a:1448:b0:4b1:103b:b67a with SMTP id
 d75a77b69052e-4b31b9c3777mr22814681cf.32.1756539044617; Sat, 30 Aug 2025
 00:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830-drm-limit-infoframes-v3-0-32fcbec4634e@oss.qualcomm.com> <20250830-drm-limit-infoframes-v3-5-32fcbec4634e@oss.qualcomm.com>
In-Reply-To: <20250830-drm-limit-infoframes-v3-5-32fcbec4634e@oss.qualcomm.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Sat, 30 Aug 2025 09:30:33 +0200
X-Gm-Features: Ac12FXzpE91ILUTwZS_ZwZMq6UoPhvxeYv_akLo7dKmrA-yDSe19rsUZejc4hcM
Message-ID: <CAPj87rPSqJoJnUoP11qzWXuqvYPb_=vP-5-p7SEVA6JCfcYCuA@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] drm/bridge: synopsys/dw-hdmi-qp: declare
 supported infoframes
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

On Sat, 30 Aug 2025 at 02:23, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
> Declare which infoframes are supported via the .hdmi_write_infoframe()
> interface.

Reviewed-by: Daniel Stone <daniels@collabora.com>

