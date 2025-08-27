Return-Path: <linux-kernel+bounces-788818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81604B38AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3923BA81F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0573C2E3AFE;
	Wed, 27 Aug 2025 20:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ73yQam"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B528314A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756325403; cv=none; b=X51/ZVd41rzHyQ07yme1DOl/Nq7e5uOVx9NXVE0K4sfRuixmh4zy2o4jlEJ02OU00v1U7vP6GxsnO+67y7uoPeEBj5yXMef+/FbsV68XukegLe30ibCmV/7cwQvA8vUJTWLUpPT9YvHbdMs3vLO87ybuP1diI8zzD6wwfdRrhTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756325403; c=relaxed/simple;
	bh=v/STLq+29JFL5w/5DSvNy9ZBQTYTpJRQaOTDltU5C1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Udv94gwhWBG5p7jKUMy/jiy2o0CgJEI40cVQX7bmiejaQ1KUCEyNDi1qjwKC7SbufttIW6Blx/CJtbhSH5SOjtT371YjAER5gcUaw6P6Z4ADO07hA6JVgg5SSQSbaOv3+SEFJs/bjf7lNhETsDN8gX+8e1k2HWKn0fkCHGmnFrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZ73yQam; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4c46d9dd07so46347a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756325401; x=1756930201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYBM2f9U9GiBgSYToiFj9L4h5b6Q18XZmcp2l28ZRas=;
        b=iZ73yQamnZZI/xssAM3SFvrWVDCDneieINEhaSw/XrxPOwxXqApLwn7PUwHosaDMzl
         8dfKgqc1dD9puBLaMalmm33n0nHWUlBc2cCInpoxSXNWIas6Uoli/lW6QZWoqUwja0XV
         +wYA53kWidXWHg98BXLwKM1Fp/Wqyuvapn9jUEV/gYYSx67StytgNJvMJRsv+OOQRIhE
         ojioiBaU8h155foCkvhTGpss1W2iWQ1Z/loQZiaxpwQedgqcGdkJR+A9leWC5Z472pKg
         272x99fyZgkdeAiRHMPapx08KKHFsSe5i2q0ktHQpifcThyMXfaHUCymWk3fkl5Mxfrf
         DLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756325401; x=1756930201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYBM2f9U9GiBgSYToiFj9L4h5b6Q18XZmcp2l28ZRas=;
        b=DLHuh3l6o7srDXGkbfVwEiOTAFc3zif357U/VxvW7dymKnUakyt9aDEkIT6ZCwL/Lk
         QnQ+rjdzECLhSEXHZS+RDdzXa400YqD20rrObv6Pf2Ufgj0YfjaBBT3Oi7O7fPOHtvuh
         BEOCcukb57quke8Q9zWC99VimJ/6HSxI/pC8svCYp5w88RpoSoDQgUaXZ5pnCF+OsRUR
         51khPnzJyYe3eqgihF4U1sUdmu7UqlF30/ZG+FIA39B3K1wX3J/UKR05FApUIr6GEUy7
         E7GGzU12WtKaRui1V9LSB271neqOpqtnacroGAWOIyrciEQVsBRz2rEgW521b+mOKE+N
         6zpw==
X-Forwarded-Encrypted: i=1; AJvYcCVF9R5D2ZA7aAQykKCrhl3WCEyxAg8Ecz2wGxcPVcU+W6FVpHULBBn+dn83l6yvy/uu462/F/wLW5Cgz4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGmksBt6Vgsz3g8y0B4S9cwVw11+5vZG03e1ZhrxMTWOHsT7t4
	aD+7QSJvHVhkQ2GirG+ufb/rGoXayV6MgnsELcPYboKdZka0dhOCEx+fgbfDoMUyJzmv5O/9Don
	zpqJXqcN6z8aESe9njWfMmy5is7CKutg=
X-Gm-Gg: ASbGnculyufeqcqV+9quiiw/nqEUGzoN/yEQ2ncR6ddCvhD0tw1hq0QKjcDmJzE7KyV
	iKxP1oxZYXj0u9WCA/QcEEf0xRw1BRLI5uZ7D11tITW5Ps1wfY1kha2ekJ2SYyd0DjT0ZXltPPX
	ldq57SZuJXmQc9O6SsMIfwQLU06fgNwe0DLhwiau8y+jev4dM+72H0gVOaBB+G1AAoTq+/1Phrg
	VQT2uyu7aM26jlAuoJrNpHs3HQP
X-Google-Smtp-Source: AGHT+IEbq+6lkDTjWK76f7In5xwzdV49QDHRr25J+ov8rWTj6aOsscw+ZBST+cRz6IeuVdfxSzqD1Xggs25YE32c8QU=
X-Received: by 2002:a17:90b:3885:b0:327:76b9:3c74 with SMTP id
 98e67ed59e1d1-32776b93dc0mr2078732a91.4.1756325400952; Wed, 27 Aug 2025
 13:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816142312.393795-1-rongqianfeng@vivo.com>
In-Reply-To: <20250816142312.393795-1-rongqianfeng@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Aug 2025 16:09:48 -0400
X-Gm-Features: Ac12FXx-crJiXTcyPkTkIAvouGV7PEEydKhDClAWENY5AgHKQR8NdfQzNNvxSH4
Message-ID: <CADnq5_OCNrW8jtbfchsZcZAbVt5AOZaLuBOPCHGePxvpU_T0aA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: use max() to improve code
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Austin Zheng <austin.zheng@amd.com>, 
	Jun Lei <jun.lei@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, 
	Ivan Lipski <ivan.lipski@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, 
	Clayton King <clayton.king@amd.com>, Sung Lee <Sung.Lee@amd.com>, Alex Hung <alex.hung@amd.com>, 
	Samson Tam <Samson.Tam@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, 
	Karthi Kandasamy <karthi.kandasamy@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, 
	Rafal Ostrowski <rostrows@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Sat, Aug 16, 2025 at 10:49=E2=80=AFAM Qianfeng Rong <rongqianfeng@vivo.c=
om> wrote:
>
> Use max() to reduce the code and improve readability.
>
> No functional changes.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   | 7 ++-----
>  .../gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c | 6 +-----
>  .../amd/display/dc/dml2/dml21/dml21_translation_helper.c   | 6 +-----
>  3 files changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c=
 b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
> index 084994c650c4..8376e2b0e73d 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
> @@ -1047,11 +1047,8 @@ static void dcn32_get_memclk_states_from_smu(struc=
t clk_mgr *clk_mgr_base)
>                         &num_entries_per_clk->num_fclk_levels);
>         clk_mgr_base->bw_params->dc_mode_limit.fclk_mhz =3D dcn30_smu_get=
_dc_mode_max_dpm_freq(clk_mgr, PPCLK_FCLK);
>
> -       if (num_entries_per_clk->num_memclk_levels >=3D num_entries_per_c=
lk->num_fclk_levels) {
> -               num_levels =3D num_entries_per_clk->num_memclk_levels;
> -       } else {
> -               num_levels =3D num_entries_per_clk->num_fclk_levels;
> -       }
> +       num_levels =3D max(num_entries_per_clk->num_memclk_levels, num_en=
tries_per_clk->num_fclk_levels);
> +
>         clk_mgr_base->bw_params->max_memclk_mhz =3D
>                         clk_mgr_base->bw_params->clk_table.entries[num_en=
tries_per_clk->num_memclk_levels - 1].memclk_mhz;
>         clk_mgr_base->bw_params->clk_table.num_entries =3D num_levels ? n=
um_levels : 1;
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr=
.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
> index b59703467128..47ff4c965d76 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
> @@ -1404,11 +1404,7 @@ static void dcn401_get_memclk_states_from_smu(stru=
ct clk_mgr *clk_mgr_base)
>                         clk_mgr_base->bw_params->clk_table.entries[num_en=
tries_per_clk->num_fclk_levels - 1].fclk_mhz)
>                 clk_mgr_base->bw_params->dc_mode_limit.fclk_mhz =3D 0;
>
> -       if (num_entries_per_clk->num_memclk_levels >=3D num_entries_per_c=
lk->num_fclk_levels) {
> -               num_levels =3D num_entries_per_clk->num_memclk_levels;
> -       } else {
> -               num_levels =3D num_entries_per_clk->num_fclk_levels;
> -       }
> +       num_levels =3D max(num_entries_per_clk->num_memclk_levels, num_en=
tries_per_clk->num_fclk_levels);
>
>         clk_mgr_base->bw_params->clk_table.num_entries =3D num_levels ? n=
um_levels : 1;
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_=
helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_help=
er.c
> index a06217a9eef6..21cc30f9b8a8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.=
c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.=
c
> @@ -463,11 +463,7 @@ static void populate_dml21_timing_config_from_stream=
_state(struct dml2_timing_cf
>                                 (stream->timing.h_total * (long long)calc=
_max_hardware_v_total(stream)));
>         }
>
> -       if (stream->timing.min_refresh_in_uhz > min_hardware_refresh_in_u=
hz) {
> -               timing->drr_config.min_refresh_uhz =3D stream->timing.min=
_refresh_in_uhz;
> -       } else {
> -               timing->drr_config.min_refresh_uhz =3D min_hardware_refre=
sh_in_uhz;
> -       }
> +       timing->drr_config.min_refresh_uhz =3D max(stream->timing.min_ref=
resh_in_uhz, min_hardware_refresh_in_uhz);
>
>         if (dml_ctx->config.callbacks.get_max_flickerless_instant_vtotal_=
increase &&
>                         stream->ctx->dc->config.enable_fpo_flicker_detect=
ion =3D=3D 1)
> --
> 2.34.1
>

