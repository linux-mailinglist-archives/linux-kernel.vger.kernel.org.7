Return-Path: <linux-kernel+bounces-737134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CC6B0A82A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA851C81960
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0453A2E613C;
	Fri, 18 Jul 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QJccNh4p"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ED22E612C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855098; cv=none; b=Px8YTDazHYtK0+Mtby+Sc8dxiiMizshElC0hRk5tQx/DTpIl2QZUhpdGl7gOa/QrTXgskQeVi9FmTc6W6GbNeaW2TfrOKp08lp9BZcQQVeah1K3fXMCAryWnV/otMvshG2xOK+ykB42ChBcLEpBPWxY4UYSijOCvyHj2xz8z6Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855098; c=relaxed/simple;
	bh=FyRfBnxU/OGyyizvx31WzrOI+l2j9rU6IuwyuQVHu2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYysnW+1CrFkDJczeUupMAxSoLsSNRCCiklB1YzUzepDGz3KIDwUhZV4Hwixe34twy/0GzWLcPmtO45Yad8JOVrhSzlFgnsOijYGQ39p/hr0iiUJJwbJBC5kSQ6NcDDKAryJD9hKKnXOqw5owMZYdLpJsS2lEgHLVDTxiJGs+I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QJccNh4p; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7494999de5cso1663632b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752855094; x=1753459894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4sbOB8EUknRai1AuJ9cdNWA6bF4sUdUbr8Aph2l+CY=;
        b=QJccNh4pGGJkLWW/uqk6o1CFbPzG2Cpwd8Ju0x/H6KvvAMwVtDhubkwqHPkiIDTQpt
         GiUdEL2+4sDqSMYho0tQJQmonKSJLSlNY4S1IBhvMemziEAPmfrNkBgBV4FMYpfkfB5H
         ML1SdQESgAFVoj7SS8gFqbKJPNruz/9Bq5LiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752855094; x=1753459894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4sbOB8EUknRai1AuJ9cdNWA6bF4sUdUbr8Aph2l+CY=;
        b=g9DcI0YrWT6kww2NPHQ5zGnol8sGAj0t92cY8QW9ka7ex17hHzgmDuSFRU64NmXbsL
         lml01gUFhVA8bgLYdvGvE9tKi44Wp0oY4EDJU9zc0WuBFE68PkPguZuj59ZZBtzc1flV
         za13l6En73+EKNZYhIGogqYDiPt3R0XFG7LV9ozgMvUbG4pmFZQy1gLVm7w5aHquvmw1
         weXjKYWuid7x0ATNGiozdpWE4OqWwYqCpxPmJ045VoPorEAYq4HCIlKLntl0XgjADSiX
         CphnClxV/OXc576zGZoIJlPsO+6MjYuGMjSnFMrpQlv/jnLgZ5LCU+i4YDX3IRtYLfHy
         1IRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgCiyoVzCx93HOmp18xYDz8Y9ROSa4hHw3EQNmcaVVvOWb5BcoRChDh0003V425eOWLqZV/hmXVirzg48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB1iyW3/UlJ16oSElZxk3ICLaSSga/A0pvn1xcT6qZl0I33BSB
	U1kJHdASuGErO3plAO7BY5LHnfqRqyspwKVyNQwUcdtsOGdoeM0hgn5MRCf7PwBdn3OCQHBATNb
	e6i8=
X-Gm-Gg: ASbGnctlK8Z0NHCFCXoJWq1v1AV56TmcXW1ewU/MWKOIMwnHSVh8/4DqbGF0Web4Pw/
	G1Ff3Bgx5VCLmV2gD/T2N2iWpQzOyfisFN/lDcxsKpZrbkSG/r1Ll5DfTAb6IEFnBW1iQGr8hv8
	v0wlGeAy+klKfYFR+yzBomyzmSrwFVfjX5+yh0yfhfHOPap2+novbPGR3RO0WhbX80G1A1Xybw/
	4WlTwWpUyhV/6awQc/eUi6ScydZTEmGclv68El38PXDIjVrol8Q4a/+GV4nL4LdT3khRF1riUIr
	BhF8NEFtYiOlJg9yIM0OT7Mvx2BgdkeIzSETQgE1FqTQhcVKk1IBUPJPFyHA6dxTOFQRg2Ul6LH
	FqwcQF1F4GM1AaNxCjl/QAwI4R251eT5dncLAjz4OkjlWy5pPryVmyEhQ94tU/zslfA==
X-Google-Smtp-Source: AGHT+IHQElcWtHeKqUSytSONCKtYm31yklZN9j7uFG/dyIxXE/sTBvl5HTXmspUNOVLpauIsWhuCZA==
X-Received: by 2002:a05:6a21:4ccb:b0:232:ef85:34ec with SMTP id adf61e73a8af0-237d7d59f69mr18682366637.20.1752855094065;
        Fri, 18 Jul 2025 09:11:34 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com. [209.85.214.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb155e01sm1499377b3a.88.2025.07.18.09.11.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 09:11:32 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23694cec0feso22058295ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:11:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFe0UHQwPwSSupeLspc94ecKbfSMXcikimV1sycEXwnreQyEsJB0I6JVfjmKZH4aX5oR/t9+c6fZ1hYw8=@vger.kernel.org
X-Received: by 2002:a17:903:2d1:b0:234:d2fb:2d28 with SMTP id
 d9443c01a7336-23e24ec73b2mr186837285ad.2.1752855091825; Fri, 18 Jul 2025
 09:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717164053.284969-1-me@brighamcampbell.com> <20250717164053.284969-3-me@brighamcampbell.com>
In-Reply-To: <20250717164053.284969-3-me@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 18 Jul 2025 09:11:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vrp9MM_5de10sV-TC_mp-D7en9gjU8DBoD6mBrRvF2eg@mail.gmail.com>
X-Gm-Features: Ac12FXz3KKf6EYjEda0vjUCQyFQVXEd84VY4Ny25pnbUOfssxeUq4v1dFeHX4UU
Message-ID: <CAD=FV=Vrp9MM_5de10sV-TC_mp-D7en9gjU8DBoD6mBrRvF2eg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] drm/panel: jdi-lpm102a188a: Fix bug and clean up driver
To: Brigham Campbell <me@brighamcampbell.com>
Cc: tejasvipin76@gmail.com, diogo.ivo@tecnico.ulisboa.pt, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 17, 2025 at 9:41=E2=80=AFAM Brigham Campbell <me@brighamcampbel=
l.com> wrote:
>
>  static int jdi_panel_prepare(struct drm_panel *panel)
>  {
>         struct jdi_panel *jdi =3D to_panel_jdi(panel);
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .accum_err =3D 0 };

nit: can just be this:

struct mipi_dsi_multi_context dsi_ctx =3D {};

This looks so nice and clean now! :-) I'd bet that the compiled size
of the code is also quite a bit smaller as well...

Reviewed-by: Douglas Anderson <dianders@chromium.org>

