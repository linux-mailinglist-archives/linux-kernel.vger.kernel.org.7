Return-Path: <linux-kernel+bounces-739883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA149B0CCA6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A341C1AA63DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE862327A3;
	Mon, 21 Jul 2025 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TFkr+OEj"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2845619C54E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133532; cv=none; b=QFX6uumwneljr0XEm2C915AtPBM7Dic9w5JJqi6O+RHzXOGYiqVuAx0II0MVLmu/4mJG2GcsypDMKtcyireu3HINia5l1OqPf6QoHpucHySmn9T0CMnEYFLcHwpVWciZi0a9ZesGVrwoxXUPa3fsLgXmSItYlGhgSUp1/Irm1Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133532; c=relaxed/simple;
	bh=pZcUIr1FL4PCPszdUrgAxcwlfz5NiiVmDLj6rkPF1XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWhqC4LEChcowKxXy1rb+tBbJNU/WaCrhbLVGb8Uy5nbzhbFhHPCJX2KdD8Gdxz+2nkSXC6T3OIVHkvpJicoe7GOtRX12q2qm7xl+UVrMWvTWILpGQ19LhqxsWV+4xSoqoAaXdsnnczdYGaAxGHQgur5wQpst1C07VEkfMqxeCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TFkr+OEj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234c5b57557so43268865ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753133529; x=1753738329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTuqv5W1Us8MwatktgHES96DPtPaN3TVJ69w/425bso=;
        b=TFkr+OEjTM6bEi50FzqwC3q/ZpasIw0wVOTYLHgI75W9O7+SLryw7cGOYedOf2Iz4m
         qAmbwFCXlM4b+AsMR1FaiPbo5wBs9wjpXHp5OSGK4C2y1Duw+9aDln0g5iLdaKj+zQ91
         XIzbwCa5uq/DpBsnduf84Tj+mMwyXq1cRMizw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753133529; x=1753738329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTuqv5W1Us8MwatktgHES96DPtPaN3TVJ69w/425bso=;
        b=h0dKuocMkHW36WEDlPXQTOpBc/sSYDNevbBpPmnf9RKo/Pv6ri63NMCGvuA3D7PhyO
         Yy7WuSGI33AtcFE/a81JD+X4elE0Xl8mbajsI/qLn+NkFIKwfXTEhX3b++MPis2QD0nR
         dtHGLFONdyxJR2PoJunF+rgGNT0kmegpJIm1RRXYG/62wJrDSYg28dI97L015Sqzu7y7
         ePCIrLLjJRbKxFsTx+K6kwvxQfffhNFKXt8AImwgZkNaryL9IsWqXEaP0dQd3sZ8WiJh
         VhniPrIm6BLPvVcjChW1AljTPpEr76FKnmNK9O+a5741V7ByH/m+X0v5+4Z6g67Ttp5v
         t68A==
X-Forwarded-Encrypted: i=1; AJvYcCWEBxcok06DlHZXvJMGb3CCN8vFyeG83gkVA20knFUjjmPT6WCBuelIcQdbi/oy9lUqcBDm1ZhM8xra+sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuQccQbDhLxQ5bIMehLHlv+ZVkZ/OlppIQOeuquaszP62P6hzS
	KYYiPT2R3fnXAPnt0vlxlMPMa4NOLRbxBd8feoMJVYs9wBAQDbPWxWKsH+tDifbPPnNZQuOWE2z
	PKgs=
X-Gm-Gg: ASbGncv3UsmnqMkd7M7m5XdOm/VwNY8I/LbBD5Fxfi7GXTJo5NJs2pfla0hgTB0iMOp
	iMhyWMG4aglaRQcC/YHekZgnyve2FBdaGKdptxW4UiWIgkBOArtDOinAwPIfJEt7XYdpKo4IjpW
	IkVHuTUztenKZAe7TSMBtg8bYDLaulxG9S48NOx7mUUVLsestthDXq8Bh31QIthc0YhnyvjJNXx
	XPsthJwST2OeXxnYrJQSwHOWWmulzDbWmgcauZl84yIrX0nbvdXVeQTl6xf2IQAanhZydCOpyMj
	EtAr0CoAG1zvn2sfpmhbsSIZZo7rvHc3KhpR5B5voSHIN6f244YXXc1FHeM4hQg0tucQOtuT0ti
	VmcWqSQfWippe1/HUoGGItzJ1iXVA4UXJuuPyVePZtHrFe4OZNN3R/3YMFT9Vfw==
X-Google-Smtp-Source: AGHT+IG9jbjxUv6s6YxStwE4nlCMl/sfCUMcULcdAevriOYejwyssXLKYKKWH5XxVYZJbcSb9Ng5vA==
X-Received: by 2002:a17:902:c944:b0:234:c8f6:1b05 with SMTP id d9443c01a7336-23e25791aa0mr321089715ad.52.1753133529294;
        Mon, 21 Jul 2025 14:32:09 -0700 (PDT)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com. [209.85.216.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b61241asm63162955ad.76.2025.07.21.14.32.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 14:32:08 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31c38e75dafso3929101a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:32:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/O/U4Gkjb1lnU/5JdQgvRTaTk9FeudVE8PWjc5EpqOKfIMznkNt1SSOXOq9yDVcQGHVrVjfK1es/qWOw=@vger.kernel.org
X-Received: by 2002:a17:90b:4985:b0:313:2e69:8002 with SMTP id
 98e67ed59e1d1-31c9f42eb2dmr31809815a91.20.1753133527556; Mon, 21 Jul 2025
 14:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721061627.3816612-1-yelangyan@huaqin.corp-partner.google.com>
In-Reply-To: <20250721061627.3816612-1-yelangyan@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 21 Jul 2025 14:31:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W6+QDHUsddpqu0CRkZx9nKrDJJDLpW3=yYg5dNB9v_Eg@mail.gmail.com>
X-Gm-Features: Ac12FXwwI3u6culzX5cwj_QNkl2DfHMaC1fyguJBg3p2p64B2i9L5-xwj2ZevQ0
Message-ID: <CAD=FV=W6+QDHUsddpqu0CRkZx9nKrDJJDLpW3=yYg5dNB9v_Eg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add disable to 100ms for MNB601LS1-4
To: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 20, 2025 at 11:16=E2=80=AFPM Langyan Ye
<yelangyan@huaqin.corp-partner.google.com> wrote:
>
> For the MNB601LS1-4 panel, the T9+T10 timing does not meet the
> requirements of the specification, so disable is set to 100ms.
>
> Fixes: 9d8e91439fc3 ("drm/panel-edp: Add CSW MNB601LS1-4")
> Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 9a56e208cbdd..09170470b3ef 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1828,6 +1828,13 @@ static const struct panel_delay delay_50_500_e200_=
d200_po2e335 =3D {
>         .powered_on_to_enable =3D 335,
>  };
>
> +static const struct panel_delay delay_200_500_e50_d100 =3D {
> +       .hpd_absent =3D 200,
> +       .unprepare =3D 500,
> +       .enable =3D 50,
> +       .disable =3D 100,
> +};
> +

Bleh, we really need to find a better way to sort these structures
instead of just jamming them onto the end. ...or find some C
compiler/preprocessor magic to define them automatically without
wasting tons of space. In any case, not new to your patch...


>  #define EDP_PANEL_ENTRY(vend_chr_0, vend_chr_1, vend_chr_2, product_id, =
_delay, _name) \
>  { \
>         .ident =3D { \
> @@ -1984,7 +1991,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1100, &delay_200_500_e80_d50, "M=
NB601LS1-1"),
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1103, &delay_200_500_e80_d50, "M=
NB601LS1-3"),
> -       EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50, "MNB60=
1LS1-4"),
> +       EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50_d100, "=
MNB601LS1-4"),

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...and pushed to drm-misc-next:

[1/1] drm/panel-edp: Add disable to 100ms for MNB601LS1-4
      commit: 9b3700b15cb581d748c3d46e7eb30ffced1642e8

