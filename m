Return-Path: <linux-kernel+bounces-817244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0674B57FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5FD3A6119
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0154C32ED5F;
	Mon, 15 Sep 2025 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n38Mmx8g"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD53C2D7DCE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948255; cv=none; b=HtcatliiiIqEdtekU+ur5tiUXMQGqqkZK+NWortCoLyJHcWe+H4f0ef1co0vi1GAceYTP+96b/xH1wKydfSEab6+nBJ7E4+aHSAJjUhWeVasSCiXSfRJLPe4g5UFRMG89cI0NaSiCzaLCFbAn+Y6UMdZr5mrDMz75YdTaMz6dec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948255; c=relaxed/simple;
	bh=tc8JvvszcBi19AwbTPMbHpEL9V5Y5jqwVwTZNdcLsUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npxs2g9lKMAZMk291LtAc2j5gwwSuJk+Ozl40Sol9sEmYaZf6Z0e3RKEAkEujCs+PNGjJCxu9HZyC8+HClzW8wwYztiLo+N2i2onNspDOvKr2n3S75sbk39qV1lmdsr2s8nf3O5SUaAPdvRkRLvupryi70oamRovHXVxI/eJ1rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n38Mmx8g; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so5838025a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757948250; x=1758553050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSuuPi0RBraKWGef/U6swz7Geuge5FseMwxYOTQoMUI=;
        b=n38Mmx8gP/RV0WNy/GpeaEBNPmO6ySONHe+dOTOD2THwuUnkdu94dLNBCv+iG+8JJE
         4r8pgIGz8nb6syVRA8JbWGvI+A1trZgDl3Ipb3dQ5Ms5Bmfaro+2iQlebLUApBGTTl5H
         Eq7n1fp75BLoAhS8KFFh8XwXVvgnn6QPBG1Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757948250; x=1758553050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSuuPi0RBraKWGef/U6swz7Geuge5FseMwxYOTQoMUI=;
        b=al8ElQcZ/zHKnEKacWEDVvK3GmNwSNsE7jkvELFtAcnTTI20Mw3ZKJzhbPKRAgXyg3
         90EJ9CkA+fHNGodasnp/xx3GBkT8hY8633Hg+AFYFdFhOy/DxwjU3sAy70kPz4BvYyYm
         IT41QVxMK4c5Xba+ZNVQSfjWLi9yCCN9gvvylwh9/AOS4PxBrMD973P89EkNKLKoMBrb
         4nDjy6cRMIxV6bFtsOh4aLWIya3/NNoXiBfRM2NCIaXPNE6wR1idvbixzdhJS7Yw7xPL
         ELPio0OHYizp8F83I378AwdAm1+Ya4DDTN2dDPG9yc781MI1/J7o4T0j0uu9lLEGFP27
         xDoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF1s2EfVPKVRC96Jqq/inM94Urv0I/ChsduEQ1jDQig8ltWCAiHgN+z2uET+/nZQhk0oUSWv+HYFmj0q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKgmPuLR3Hh79vn9YdjRbAoBiNgYk3S6TDpb1wCl2Q815ZYsN+
	ioxdcafqJIDT3nT16aEumadAd/Z5N23UpqVPkC6R2qLIxZ0vgT+/kF8+rzDXr7SkQ9qU1XA85pd
	cIq8=
X-Gm-Gg: ASbGncs1i+ngdffCrzBvtSD2mYFSyagtdXC9t5JvRDsuWp9agZCH3Vw2xMy3p9YZQLe
	A1D1NUvgNJ09JO1JVyMfxJc00qXm9MdsH4GES+7OTJav/RUbXU66Ndwt4SkYZRWDHf0mIVlrEvl
	m8lTrs96KV9UmaVVeVTqiuQybLNSpksh3kJ4urjLbcyM90Dw183rkkJYAYVPbSUJiv9jL8iX4UN
	KiYKDiHwBk1KhtYyZmibxJfT8kzWLHpIc2PQKZJ+w5LgHVo/g0LfFgnWJVExenCXOIRAxx8t9RT
	p+XfDZVStP3etLuwBXoSqzdstict5ICa0RqFKE1C7mwci/0MJVwTupEXP1xzDYIcLOa7FGRVCn4
	4OrVO97O8c2pxtLMsZdGzRtOHp8VsJZoojKiMETnKqoSypO5LGpAh0Ge69O1A7RHQIg==
X-Google-Smtp-Source: AGHT+IGDwwwlTvHVKvIuAOHP/KqP4ha00VA0JDp6t3XO6pZe8ANyo7hpwiWZDfaVjsgYL+5jKmdCCg==
X-Received: by 2002:a17:90b:38c4:b0:32e:3f93:69da with SMTP id 98e67ed59e1d1-32e3f936cd3mr5719864a91.6.1757948249772;
        Mon, 15 Sep 2025 07:57:29 -0700 (PDT)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com. [209.85.214.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32e37bf1c19sm4838678a91.22.2025.09.15.07.57.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 07:57:27 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2445806e03cso47852645ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:57:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3ie/3ffsK+iSutIRmTevRRaV0H2kNvHRw0SOyLetI17V4qcT7zsLcR2gBjt9Mt2KFWYJ7wbEZidQCdlQ=@vger.kernel.org
X-Received: by 2002:a17:902:ecc7:b0:25c:7434:1c03 with SMTP id
 d9443c01a7336-25d24101631mr160114095ad.10.1757948246579; Mon, 15 Sep 2025
 07:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915113437.665345-1-wuzhongtian@huaqin.corp-partner.google.com>
In-Reply-To: <20250915113437.665345-1-wuzhongtian@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 15 Sep 2025 07:57:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xan-C9hUzv8UfNOom6dkrHFxH1f5ke1KNGwdxFmEK9JQ@mail.gmail.com>
X-Gm-Features: Ac12FXwTTBHdoxEkLghyvQJZND2VLlss32KjtpSsfoG9ZAk_xu4tjzACy3J_x4g
Message-ID: <CAD=FV=Xan-C9hUzv8UfNOom6dkrHFxH1f5ke1KNGwdxFmEK9JQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add several panel configurations for
 mt8189 Chromebook
To: Zhongtian Wu <wuzhongtian@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 15, 2025 at 4:34=E2=80=AFAM Zhongtian Wu
<wuzhongtian@huaqin.corp-partner.google.com> wrote:
>
> @@ -2006,11 +2008,13 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x142e, &delay_200_500_e80_d50, "N=
140BGA-EA4"),
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x1441, &delay_200_500_e80_d50, "N=
140JCA-ELK"),
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x144f, &delay_200_500_e80_d50, "N=
140HGA-EA1"),
> +       EDP_PANEL_ENTRY('C', 'M', 'N', 0x148f, &delay_200_500_e80, "N140H=
CA-EAC"),
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x1468, &delay_200_500_e80, "N140H=
GA-EA1"),

The one above is mis-sorted...

...I've fixed it for you while applying.

Reviewed-by: Douglas Anderson <dianders@chromium.org>


Pushed to drm-misc-next:

[1/1] drm/panel-edp: Add several panel configurations for mt8189 Chromebook
      commit: e3e4110610671027e3b56bda1ad9f6c51d5ac477

