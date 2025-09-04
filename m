Return-Path: <linux-kernel+bounces-801137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AC8B44048
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA851A45A45
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B693720DD51;
	Thu,  4 Sep 2025 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YopC/f+f"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB0214801
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998960; cv=none; b=bRLLJ7B01ieTe2oTQnRWJLAqu26Rm5ZIjZBDvfG+Ebjed+M6hmUoWDKEX7+axA8zEKfq3XdfHwLt1wZTOslvk1FH0pUaoqRSWx7F5PD9HdgGKnVxu7PtMnbo0bpsWzdzTxJNp1TSE4txqv+D5fd/9/Uv67/4ZY4ae1l07sz2PEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998960; c=relaxed/simple;
	bh=TDLPSgBG6CDBzR+vutxdND3Sby+Hbw6ZUDBzV09JVio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuFfqvyAz8Z8MR3lMbTuIaEVz/pKHyI2Q5eYdinTta9ms3ySfUzTn2BEY0qewrooH8vgqDVVyDjkEwXAxUI3hzUfuSgKbIJ+5Apq2i3SxjMTwrTl36tnAPJ9PVJ3OVYkcILKulsOkTEBCzOSUogFYppKrxtI98pdySpjtdL/0SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YopC/f+f; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24498e93b8fso2073605ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 08:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756998958; x=1757603758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9Jq0Qss5RqOroarhNVXi84lrn3E/aL/e2HhwPAXgdE=;
        b=YopC/f+fjnZHgM6mNE5HbrVBFyMQhhRTb/7XVdyIcko9LtN1cvHQPRCqdgw3d6CA6l
         R6OVwCzPJFWSbKJPnIP6Xx0m7GRkQXIVz6F7lwyxR6mC2FRxrzY9Y/Bfq2aHzIbqWZNd
         1COR/6/4vbi6RMhhPMqGtJ3ZLRaPLn5BHFZjqorufiisx65bSb2asiQP+lnm3AFVJomt
         37OrrXB/8mVBZ+Fs1Z+vHpC2xbTI2rMZxpac8g0Uq/I8+/lyYZ07kqiJeq4ZZ5k84H63
         HLkbMaCkb4af8a2te9OCB/KUbq5d2TGT0YUvzfdo5VAmdw7xyNWwYcpS6+pBuztCtJq2
         BpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756998958; x=1757603758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9Jq0Qss5RqOroarhNVXi84lrn3E/aL/e2HhwPAXgdE=;
        b=rLiCt1Ei9gvBYZ+AmpDFKcdQjtAO7UAMcl0C9wt5AILOPPI+IKzw2KAnWCddRYGUcD
         XZtQNT022VpMLswpHoq06eW5g9d0Zm0vx8aNsYxh7GqB0JE9ZkZTk5TG2j8XuDtaBZJ8
         LwPdXh7RrgdluCzuH+XfDQNLTuOwDTgSNFrgYxs9F5AtPSrOvLWwx8bI3Pow8M7jzceN
         RkHPWRVqy23vDOhN8Ae+IfhZ+ci18cw3DVxjkAxrfL/Zk58jLa1CqC2etZkHM9p/Wjh6
         fCe2Lg+kpShH9p3fZ2hyf+Leik9y+GeeU37fy234cILN3N3OXT+n3jmYvPUHSc3Zf+fj
         xQzA==
X-Forwarded-Encrypted: i=1; AJvYcCUa7AxeKuLrfBzLOP3zgtqVlUGx7VPaIUIdt2JK7t/1dpT40ypxHMiOPUc1u+OOaTzKi6J1oRg/XWnyHRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOZuWsvc89bZuwMRv5+qRY61f6e3oVnrf3xnfWeL2IOxZG1TbY
	6NTitiKk8Xs78rz0/qv0vwfpmwpLI8CDmsHtwJwlXtV9A/TIML+nqhs186A1h5rUnED5vFH5flQ
	GNUFDlGjqC/WQFb5XETAeXwTw1pDnHwM=
X-Gm-Gg: ASbGncvDH7Kc837pyNlNx1PSPQnmis81fj2JPR3ccV7grLY7jNwPPH4z+ju7bHrMqeD
	O2N9ErSNss/EKxuBOdfG8Fec9hpL0WDn2A6LKgxER43OSDy5kRqX5XaOndyrKp9HZDqel1DnftI
	JyBm6KG+9HcH1WE5B+7nzUQH+cwIMgqispBQKD4672ikcUgDamrO4/aUbQjzEk7wqG5JVWglML2
	XmOOk6pVGhLYP1paQ==
X-Google-Smtp-Source: AGHT+IF65tvTv3v42r1JI9j62M5o5qPYw1oDc/yG7KI7ueINNwA7BlbdkkzA9BhPG147OhT975Nb20L/xrlEM5e+oLE=
X-Received: by 2002:a17:902:f54d:b0:24c:e213:ca4a with SMTP id
 d9443c01a7336-24ce213cdacmr9525015ad.2.1756998957514; Thu, 04 Sep 2025
 08:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904145807.556882-1-rongqianfeng@vivo.com>
In-Reply-To: <20250904145807.556882-1-rongqianfeng@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Sep 2025 11:15:46 -0400
X-Gm-Features: Ac12FXxv0FUvBauKct_Lpu4EMKY0aLOZVPk2DGipspAwts4gAS5Q2uAmVAt2310
Message-ID: <CADnq5_Mxryr36q_Sj1xPQEmBsnMmxoAo_hksrqewH0=Ae7_pvw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: use int type to store negative error codes
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Lijo Lazar <lijo.lazar@amd.com>, 
	Boyuan Zhang <boyuan.zhang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Thu, Sep 4, 2025 at 10:58=E2=80=AFAM Qianfeng Rong <rongqianfeng@vivo.co=
m> wrote:
>
> Use int instead of uint32_t for 'ret' variable to store negative error
> codes or zero returned by other functions.
>
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but can be confusing. Additionally, assigning negative error
> codes to unsigned type may trigger a GCC warning when the -Wsign-conversi=
on
> flag is enabled.
>
> No effect on runtime.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 2 +-
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drive=
rs/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 9a821563bc8e..14ccd743ca1d 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1032,7 +1032,7 @@ static int smu10_print_clock_levels(struct pp_hwmgr=
 *hwmgr,
>                         data->clock_vol_info.vdd_dep_on_fclk;
>         uint32_t i, now, size =3D 0;
>         uint32_t min_freq, max_freq =3D 0;
> -       uint32_t ret =3D 0;
> +       int ret =3D 0;
>
>         switch (type) {
>         case PP_SCLK:
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> index baf51cd82a35..0d4cbe4113a0 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> @@ -401,7 +401,7 @@ int smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr)
>  int smu7_check_fw_load_finish(struct pp_hwmgr *hwmgr, uint32_t fw_type)
>  {
>         struct smu7_smumgr *smu_data =3D (struct smu7_smumgr *)(hwmgr->sm=
u_backend);
> -       uint32_t ret;
> +       int ret;
>
>         ret =3D phm_wait_on_indirect_register(hwmgr, mmSMC_IND_INDEX_11,
>                                         smu_data->soft_regs_start + smum_=
get_offsetof(hwmgr,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index e97b0cf19197..3baf20f4c373 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -470,7 +470,7 @@ static int renoir_od_edit_dpm_table(struct smu_contex=
t *smu,
>  static int renoir_set_fine_grain_gfx_freq_parameters(struct smu_context =
*smu)
>  {
>         uint32_t min =3D 0, max =3D 0;
> -       uint32_t ret =3D 0;
> +       int ret =3D 0;
>
>         ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                                                 SMU_MSG_G=
etMinGfxclkFrequency,
> --
> 2.34.1
>

