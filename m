Return-Path: <linux-kernel+bounces-785189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28303B34750
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FE01B2428A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1823009C1;
	Mon, 25 Aug 2025 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZX9fQxo8"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1082EDD64
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139308; cv=none; b=t6EICiIi3Two1EbD1bO7QBybeH2NIRJl/jQ3X2nOVrYEmqRJCEU28gMfLk7fo0jhID+XRIM173nisqDuVeFLVKg0XRTmSz6csaXrZuwU/s7fWAVRhw7fR9RntUZWrLpOSmvgrd/MIOX1/Y3f79E04J10BKe5n1qhsFDIM2j8KUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139308; c=relaxed/simple;
	bh=iUSMTZqyvv2oeAYuslbIKG+9UMyIb029ZYxFj2J2p+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieg2h4t7QJE2yYawzD9mh5ELOaKWEsGWrr4pMcNjFtOT4xCBQIk7kUrhqL+FPqT/RMHUN7dBEwurdY9BbhbMaB0/p/H0oE4oskeG5zQeG6COY9D3Y+iOHGQJY78aPhg0rUQysam8MsJRUozTXWxD3jYZyscWJnLDF4dw6BD9BUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZX9fQxo8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4027442b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756139302; x=1756744102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woAfhn5HDSfsOd/+1jhyZYr6YehlXkPj2oA1ClHW5m0=;
        b=ZX9fQxo88T5u3WY4jd2bTG6BaLeMMDsNb89a0oEWf6egPnbiE5Yz0aXn0hEEDBIsjo
         dHMlOWf9TuC/4h5PDnv359G6uXlb6k4EUjzb2kxUiZ7kzVKhS1+wGFz0cDCGikSs8Vqo
         B6x8nSVbXxsbT9q2xTKb+C8Z8tLjRnD6c1IOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756139302; x=1756744102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woAfhn5HDSfsOd/+1jhyZYr6YehlXkPj2oA1ClHW5m0=;
        b=gU3olY7LLDiixCqKo/j6Qbj5OwbVc69nNuue0lLBd9zPdx3GFiEyfXls3XwXfmgjO9
         m3kLi/aF9PFxtls/k4T9wFrVDWysPRLmYFol7l9VPDP2myxbDpyEUWpCsrHJ8Cg+ODMN
         X6sC08saYSAfccHm8QS4Ga+qZRn9FD+h2ATjLFUCNyPq7wgA97LDABJoecKf/y1jrIM9
         IhD7jt9jD8W06wU2bSekteLhZL6g48Rv9Pwy6SB9peketGGh3Dbvp3yIbTY1k2N2/gam
         4+JThXD0AlqPRcs2riyWrjHPbJQZcZ3eUMBAclO/HOlO0D6UdW6cJ7sVbvLb7Po53XBy
         d1pw==
X-Forwarded-Encrypted: i=1; AJvYcCVlOpjZUAAMKrjrqMyLZt3aHURAIZGrw4gYK+ckPj+gzaX30ZnKVXh1ZLTEG5UamC0b0oVgavwzeyjNUFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVuyO/ihMTZNrWjep2hNrNSsHGdJlHz1x6mP27JJQHZRjILj9I
	z3I9scX83G1ZXI5zQdoCDoyNu3CwHusquQR1p9MrXhQTfWeyU/4qr29ZAQLQ9xSkPq7gPcnY+o0
	PXx0=
X-Gm-Gg: ASbGnctj6Wshhxap4nFsUqyvlQiGcbJvBGiDak2qsMymUaAk0EEjCmLCV4a4hQlqF8G
	EvRTpKcJ94TuZPmt7Lht883hpx2iRYwdnv+GcPxivLFVvH1yBzyolO52nB9sW8LlsWEUHt7atV/
	beBmYoQmGr7aKSIbWvAekSp7F5qqC2a5D3ONoDf2fu8p2NiyXXKb/o2Z9gcjEw6VlEjJuUq7umZ
	XGftqnRWZeM3wRO0kPbzpwmc6omMyrJ7RLD3ELEgodJ5f+2HVh804I+XjAOrVnaXhoDrUYSehCi
	3vOoTKA4y84fEUlypBubjHl4SGxz8L4VmxAjy3u5EcZ/p6dobyZu1HuiLXQ2B+gusMRWA0oaCC0
	2vCdhwejRD+J6+L6RxZ0YQIjxTFBDBjxRzzCeTLcSRN2/Jo4ZWx3u6D8ODc0Dx6OzqXwTvVyIBA
	RA
X-Google-Smtp-Source: AGHT+IHH+kxmi3FfEYagLCdzudpTHawV2V4VcCDpFjJSRXn+MPIpyP4hSVDlIK49vUsC+4dhyImS7w==
X-Received: by 2002:a05:6a00:3c93:b0:742:aed4:3e1 with SMTP id d2e1a72fcca58-771f56a7006mr204093b3a.2.1756139302395;
        Mon, 25 Aug 2025 09:28:22 -0700 (PDT)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com. [209.85.214.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7704fb69542sm5939947b3a.94.2025.08.25.09.28.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 09:28:19 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24639fbdd87so23227045ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:28:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlNz88+UgfRQqRrBpuMMa+CM9kGaUH9InZs0wQqa+TpHLG+fD7NSQU8I7iwFiauE8s6MoVeCX/4GxLSsM=@vger.kernel.org
X-Received: by 2002:a17:902:e548:b0:242:c66f:9f62 with SMTP id
 d9443c01a7336-2485712e9a3mr1483215ad.26.1756139298616; Mon, 25 Aug 2025
 09:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818115015.2909525-1-treapking@chromium.org> <CAD=FV=XZK3HO8iC3VyMH+fP_XG2ogSNvUWuUcPFUxn1jU6-JZA@mail.gmail.com>
In-Reply-To: <CAD=FV=XZK3HO8iC3VyMH+fP_XG2ogSNvUWuUcPFUxn1jU6-JZA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Aug 2025 09:28:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xk+yTnizTh3FUJ8oBU=4q4t3VUO4bnHrSpJLZ1WL9O7w@mail.gmail.com>
X-Gm-Features: Ac12FXyUA1lsxksgKvSrs7zzRrWLTMGW6RoEiEQyPacS_X8GbWBGn9vOIWW-01U
Message-ID: <CAD=FV=Xk+yTnizTh3FUJ8oBU=4q4t3VUO4bnHrSpJLZ1WL9O7w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/panel: Allow powering on panel follower after
 panel is enabled
To: Pin-yen Lin <treapking@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 18, 2025 at 1:11=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Aug 18, 2025 at 4:50=E2=80=AFAM Pin-yen Lin <treapking@chromium.o=
rg> wrote:
> >
> > Some touch controllers have to be powered on after the panel's backligh=
t
> > is enabled. To support these controllers, introduce .panel_enabled() an=
d
> > .panel_disabling() to panel_follower_funcs and use them to power on the
> > device after the panel and its backlight are enabled.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >
> > ---
> >
> > Changes in v3:
> > - Update kernel-docs of drm_panel_add_follower() and drm_panel_remove_f=
ollower()
> > - Fix the order of calling .panel_disabling() and .panel_unpreparing()
> > - Add a blank line before the goto label
> >
> > Changes in v2:
> > - Replace after_panel_enabled flag with enabled/disabling callbacks
> >
> >  drivers/gpu/drm/drm_panel.c | 73 +++++++++++++++++++++++++++++++------
> >  include/drm/drm_panel.h     | 14 +++++++
> >  2 files changed, 76 insertions(+), 11 deletions(-)
>
> Looks good to me now.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> If there are no objections, I'll plan to apply patch #1 next week to
> give people a little time to speak up. As per discussion in v2 [1],
> unless we hear back an "Ack" from HID maintainers then patch #2 will
> just need to wait a while before it can land in the HID tree.
>
> Question for Jessica / Neil: what do you think about landing
> ${SUBJECT} patch in drm-misc-fixes instead of drm-misc-next? This is a
> dependency for the next patch which is marked as a "Fix". It'll mean
> that the patch can make it into mainline faster so the HID patch could
> land faster. The patch is also pretty low risk...
>
> [1] https://lore.kernel.org/r/CAD=3DFV=3DUV8_XGmxC=3D7Z18PEnj6wKz+yZQuV_4=
h+LJh_MNCqszvg@mail.gmail.com/

I didn't hear anything and it didn't seem urgent enough to put in
Fixes. Pushed to drm-misc-next.

[1/2] drm/panel: Allow powering on panel follower after panel is enabled
      commit: 2eb22214c132374e11e681c44d7879c91f67f614

