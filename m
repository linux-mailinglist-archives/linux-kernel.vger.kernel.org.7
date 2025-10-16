Return-Path: <linux-kernel+bounces-856437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E08DBE42A6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9262558299E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473903451C4;
	Thu, 16 Oct 2025 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YobIyyda"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF672343D9B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627674; cv=none; b=ivYS9nsPsrOYugM6ZzaqedE1xIfNR3eaoXsJfQda0OpA7ksC9SY7mheguVJcPmRfhPV9cctuXw1z4r630gmYAtxQESd9gseIox7eauhPY/fOTj0Fm7JLPq63L3x92XP+OaPoLfg9rkTJChiKBpQz59nzIJ969DSSSWGTpXEKGng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627674; c=relaxed/simple;
	bh=6hHia5uF7gbB1esI+0yL/UWMJBXM3sZNfu0D8TRyM5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ToZhJ9j1Kxrz9DGZ9onTqo2VqLtEfpWijoiuKsyH2FtW5c+r2SChricsoTdUQ0L/TNFFwUSDakcl8f7WET5UP+a13scvquLzeMxoQqxZrQnKAXBHZphtYq8fCGQmTKku5cdcG2CPhmk1kJs0BayQtEOqg8AYeexIpXI23xzhNIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YobIyyda; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-339d7c401d8so180397a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760627672; x=1761232472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVvQpF3KUkgQgqgHgCcfJ87d8hinP61HM/9iAbZQFqY=;
        b=YobIyydaezmtBuPHdojUKmQqYlns+J97CeTeX+/XGl716N1ONQZj5nlzW4X1VAEZiV
         zVBgNGmtltXkAY9GaGvQ+NNN2HBfrYiQZpLgN5Ovi/5SUq9nH09iEFGrwR0hGnJSVHFF
         +lYnYdv+uK0hpLRhXt0bJB3pIEMj8x3WIznswrfNdunNtl2/Py7bH33sNaRq9r0tsG4j
         vWqlrT9qqrnju7JdPmyvMsFAP2h2n/2Jyqv20iSnMdy5W+UVsCkuEbYmRV9pXLpP+sA1
         OBINeUy+aL/mCzDzW5Aks9jmWZQZSov8/Ep2LyC1SrUr1lO+Dho72ed9Gzaze8I4L5TE
         trTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760627672; x=1761232472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVvQpF3KUkgQgqgHgCcfJ87d8hinP61HM/9iAbZQFqY=;
        b=ZHorzFjTtqHHVlvbVFW2A0xVBZt5muhMXeWlGoNv0MWNXr8kQNh/PZ2p8r80mYJTBj
         saWRUF9VQWTVSKE84RI9pXR6zryfbFPjdabi903W17B40OnOlz2ClQRDZlh5dx9a1YPC
         tAhKwOez0vr8KW5q2XzP2x+wHpM1v7PjQ61uTU+wqv6fwyFDM62KA+MEDwdFdBa1erB/
         kMU4OffYALXWauPtv3J2zjnOkg5I23iFD/SI+ZB0URfEn8rH3Rdqbc93uSTGVXwZ16FO
         9UDwgKYUDPRGiO5wuO+3GFYVRRAl17v1BtCsaYL2GRXvowJLS/2k6NAM10LU8qlu+FXr
         T5zw==
X-Forwarded-Encrypted: i=1; AJvYcCVg6fGcIGzrewa1jxGgaVxn2JifZOQQx52tbNgSXwexY50msLcpas3R56xRe3Zg+IQgZxliASKGH2HtevA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUntAYygW7HO+kBe1+MaMdIKX2/h37GWOR+5GPxixKUzVJUV7y
	qqSrUmPzNCxmFznkSSo1uS1tyGABG3mM6EfUmUs7BoKZk6vEkTu680bIhbox3y5gXYQ/vEuU8xO
	rVcTIm6mh9JOOF3x5kxhogbncTLbBE5U=
X-Gm-Gg: ASbGncu15NRkAbx4cRoK5ZZi5O0+xsZlM/r1QckLWMSpn+0aKhLdOUG8UodwOh6vaoz
	bAoRY1MaWoyXGDc5Akm8Fvyvwx4Y4qElAODOPv43/Qd31t57+rCG6Le01/3iLkyU5p39bYDi1Ib
	h0j40LlbqmVPYx6li2CF30IH7OX1qGjt83WqitXdxCxHc+j9Nko98UcqvKWDpODDXByp8v9SWv2
	i7ASC04yrlQUF5Ci4Vuj8eNWsu18f18u/RIoR3DNwjYkiQMcfChOU/N7Pv8
X-Google-Smtp-Source: AGHT+IHbp2NMgIs2iY73afZL6KYX7WtdwmjlN8sdUmtFh2t7Hhd5s+vvkiHWkURSRQRwetSIBQ8CpqX3+mNI5Ia4NfE=
X-Received: by 2002:a17:903:1a44:b0:261:500a:5742 with SMTP id
 d9443c01a7336-290ccbcfca4mr1465225ad.10.1760627671869; Thu, 16 Oct 2025
 08:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016065117.2797-1-yangtiezhu@loongson.cn>
In-Reply-To: <20251016065117.2797-1-yangtiezhu@loongson.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Oct 2025 11:14:20 -0400
X-Gm-Features: AS18NWDHTf0fchEiv7DyM7xymsV74cPNgZ3lvBAsNy5WIQInxOVbTb-EMiRSddk
Message-ID: <CADnq5_Mhxr87tT+zT4absJrygQtsUXzwkQAR__ffwCpGCLERBw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amd: Fix set but not used warnings
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Thu, Oct 16, 2025 at 3:06=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> There are many set but not used warnings under drivers/gpu/drm/amd when
> compiling with the latest upstream mainline GCC:
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:305:18: warning: variable =E2=
=80=98p=E2=80=99 set but not used [-Wunused-but-set-variable=3D]
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h:103:26: warning: variable =E2=
=80=98internal_reg_offset=E2=80=99 set but not used [-Wunused-but-set-varia=
ble=3D]
>   ...
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h:164:26: warning: variable =E2=
=80=98internal_reg_offset=E2=80=99 set but not used [-Wunused-but-set-varia=
ble=3D]
>   ...
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:445:13: warning:=
 variable =E2=80=98pipe_idx=E2=80=99 set but not used [-Wunused-but-set-var=
iable=3D]
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:875:21: warning:=
 variable =E2=80=98pipe_idx=E2=80=99 set but not used [-Wunused-but-set-var=
iable=3D]
>
> Remove the variables actually not used or add __maybe_unused attribute fo=
r
> the variables actually used to fix them, compile tested only.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c     | 4 +---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h      | 6 ++++--
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 9 +++------
>  3 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_gart.c
> index b2033f8352f5..83f3b94ed975 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -302,7 +302,6 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, u=
int64_t offset,
>                         int pages)
>  {
>         unsigned t;
> -       unsigned p;
>         int i, j;
>         u64 page_base;
>         /* Starting from VEGA10, system bit must be 0 to mean invalid. */
> @@ -316,8 +315,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, u=
int64_t offset,
>                 return;
>
>         t =3D offset / AMDGPU_GPU_PAGE_SIZE;
> -       p =3D t / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> -       for (i =3D 0; i < pages; i++, p++) {
> +       for (i =3D 0; i < pages; i++) {
>                 page_base =3D adev->dummy_page_addr;
>                 if (!adev->gart.ptr)
>                         continue;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index dc8a17bcc3c8..82624b44e661 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -100,7 +100,8 @@
>
>  #define SOC15_DPG_MODE_OFFSET(ip, inst_idx, reg)                        =
                       \
>         ({                                                               =
                       \
> -               uint32_t internal_reg_offset, addr;                      =
                       \
> +               /* To avoid a -Wunused-but-set-variable warning. */      =
                       \
> +               uint32_t internal_reg_offset __maybe_unused, addr;       =
                       \
>                 bool video_range, video1_range, aon_range, aon1_range;   =
                       \
>                                                                          =
                       \
>                 addr =3D (adev->reg_offset[ip##_HWIP][inst_idx][reg##_BAS=
E_IDX] + reg);           \
> @@ -161,7 +162,8 @@
>
>  #define SOC24_DPG_MODE_OFFSET(ip, inst_idx, reg)                        =
                       \
>         ({                                                               =
                       \
> -               uint32_t internal_reg_offset, addr;                      =
                       \
> +               /* To avoid a -Wunused-but-set-variable warning. */      =
                       \
> +               uint32_t internal_reg_offset __maybe_unused, addr;       =
                       \
>                 bool video_range, video1_range, aon_range, aon1_range;   =
                       \
>                                                                          =
                       \
>                 addr =3D (adev->reg_offset[ip##_HWIP][inst_idx][reg##_BAS=
E_IDX] + reg);           \
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/d=
rm/amd/display/dc/dc_dmub_srv.c
> index 53a088ebddef..6518d5639d66 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -442,7 +442,6 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool=
 should_manage_pstate, stru
>         int i =3D 0, k =3D 0;
>         int ramp_up_num_steps =3D 1; // TODO: Ramp is currently disabled.=
 Reenable it.
>         uint8_t visual_confirm_enabled;
> -       int pipe_idx =3D 0;
>         struct dc_stream_status *stream_status =3D NULL;
>
>         if (dc =3D=3D NULL)
> @@ -457,7 +456,7 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool=
 should_manage_pstate, stru
>         cmd.fw_assisted_mclk_switch.config_data.visual_confirm_enabled =
=3D visual_confirm_enabled;
>
>         if (should_manage_pstate) {
> -               for (i =3D 0, pipe_idx =3D 0; i < dc->res_pool->pipe_coun=
t; i++) {
> +               for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
>                         struct pipe_ctx *pipe =3D &context->res_ctx.pipe_=
ctx[i];
>
>                         if (!pipe->stream)
> @@ -472,7 +471,6 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool=
 should_manage_pstate, stru
>                                 cmd.fw_assisted_mclk_switch.config_data.v=
active_stretch_margin_us =3D dc->debug.fpo_vactive_margin_us;
>                                 break;
>                         }
> -                       pipe_idx++;
>                 }
>         }
>
> @@ -872,7 +870,7 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
>                 bool enable)
>  {
>         uint8_t cmd_pipe_index =3D 0;
> -       uint32_t i, pipe_idx;
> +       uint32_t i;
>         uint8_t subvp_count =3D 0;
>         union dmub_rb_cmd cmd;
>         struct pipe_ctx *subvp_pipes[2];
> @@ -899,7 +897,7 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
>
>         if (enable) {
>                 // For each pipe that is a "main" SUBVP pipe, fill in pip=
e data for DMUB SUBVP cmd
> -               for (i =3D 0, pipe_idx =3D 0; i < dc->res_pool->pipe_coun=
t; i++) {
> +               for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
>                         struct pipe_ctx *pipe =3D &context->res_ctx.pipe_=
ctx[i];
>                         pipe_mall_type =3D dc_state_get_pipe_subvp_type(c=
ontext, pipe);
>
> @@ -922,7 +920,6 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
>                                 populate_subvp_cmd_vblank_pipe_info(dc, c=
ontext, &cmd, pipe, cmd_pipe_index++);
>
>                         }
> -                       pipe_idx++;
>                 }
>                 if (subvp_count =3D=3D 2) {
>                         update_subvp_prefetch_end_to_mall_start(dc, conte=
xt, &cmd, subvp_pipes);
> --
> 2.42.0
>

