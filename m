Return-Path: <linux-kernel+bounces-817815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1D9B586E5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469B11B2063F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A6614A4F9;
	Mon, 15 Sep 2025 21:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9Os9++9"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF314502A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757972732; cv=none; b=o+FejmmS/U0PywuCDx5T6JOqVWtjE+51ikMfRHrcOGB7PlzHrKsoceB/aN73KPHxk9lOO2vBu1HQb1RoBOHDULzien7L9m0noPdjqZBoOka8B8498cd358exgAzUEWv3Cc34DJxDFRPN7Oco192kOCdokLSq7cQtch1T+UEjZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757972732; c=relaxed/simple;
	bh=3S+/CIj2dTjZzfVmKIc9+YYV8Tg/YeaidG5GPR9wTBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+IuK5VyIEwqRaBZMrQGhkpME6XagyvzkCS01NAXbCfN+dM9WagjGfW4Zqqzd4xNGPDK2Y1rbsqUeypQbTuqyyDt+F3YZoaFJ23uJXScwDNPXZA8x0EJO1XqdTtCTsf9RZq5P5wmxkqv6wFWFIywq50vfF5wawDtoz1+QJjrLRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9Os9++9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-264e0729c4aso3526955ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757972730; x=1758577530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgjQuP4Me3guJDVcSDtwLqdLj9Ad4VyHioffhsnvnuU=;
        b=J9Os9++9pKPQfwvU1UA6IE3kiMcUaHLvfTWfa4V2eK2RG9iUset5hsip4UPhFgmkxF
         Chjh9IHHXHJ/WFG4WZ3Sd7CJWRDRVl+/0LbEtZOpQZEIF3ouHtUnjDDrrL9scUs9kt72
         LM2BC3vExsLsFJQXHEvPrhzOq07dtCsTauGJ7d2uzUEizmtoJqQP0R7hNOcpLsNUbgHL
         t6wtgnOTulJ2vgEOYck5HDBYjZ+FY0UHFhmmLTU8e1T77JM5W1WHubG1g+8y/UA8vooy
         SkBXl9Bc2wmJg5bz+tZXBHeNStR/jyyw+SVuCFI7or2wC7Dxr53W6A5Y6h1OiSQTFbsc
         Nitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757972730; x=1758577530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgjQuP4Me3guJDVcSDtwLqdLj9Ad4VyHioffhsnvnuU=;
        b=hW3zZa6p245L2hCh2UFu8F2DPQFsEyZI+DMRFdSAdwnDK9JOMd57XNgMyUPLbgDvcW
         XaHT1rXxN/Uw6VLpTyJLMCwdLyZ1ECxcJBuOkoSf1bCGLMAb+tOwvUt+f7qTIDl2AewM
         7HnTvU/a7QV0WvZqOue1BpHrGwFVoirt1dbAvB3x/tUwpOe24jdBm+IVikf5JvWdz6BZ
         eLZKwut6zoCBW6gsYHnQAJWpJQA1yHfR/cd5ZyKU7NL3ZdmbRQcHoZJHtcAFLct5aq4j
         Abqm9Vjz39fSPTPjNAApaPjCv3rReV4/rG3kyx8Hzx02DN3zqQXbmvAIjsh/iVpX++pO
         prPw==
X-Forwarded-Encrypted: i=1; AJvYcCUjD989xZobb8NcTX2cMZDTY4wUFFDDWPbFm6ySL0AZYTX5pJ82n/QNov83klxkptTIkO/KxhChlokoI2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Il8ePhv+99wreRsSiVWX6fO/ufxhMeMSfi27IQrAFaD4qiZi
	xZrRMq3/pClFtiWaszH2QhTkY2U6I9vIm7pppk6jA5TQIIAFXuvPTWH80tz03tKrgmwg/FMfxGt
	JlDQN5VuzdAZFIyw/Q+VbBltuaAO99Js=
X-Gm-Gg: ASbGncsl0JBPAPtPvmNzI9F4y2Um2c7tW5qdT+IdzR3m3tdw9Kmqr8lLGXLDspJqOLc
	N7KmKYJGZzEOzIkokq5UEdz7aG1hzjUIOB2O3x9zoxJ/JN6NmsjC547GNlaflslptXh/DgBeymq
	RvtapZF3097Cjaro73W1bAOfAA+r1cliROfLuX5gpQqTdZx/ekRjcs/6wLsAsIhnCuor/Vkv1H+
	T5t/3UpB3QfEkVYIQ==
X-Google-Smtp-Source: AGHT+IHw3Z18XHstUu2o5MDyyGsJMQUZc09lyWpgCR+3iBlFcxOGkW7iUUBCOCFrQn0WS7ZaeI8Iju8q0S+OmEonvrg=
X-Received: by 2002:a17:903:1a8b:b0:25a:4437:dbb7 with SMTP id
 d9443c01a7336-25d25e85badmr85747195ad.4.1757972730212; Mon, 15 Sep 2025
 14:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913052109.2638-1-bold.zone2373@fastmail.com>
In-Reply-To: <20250913052109.2638-1-bold.zone2373@fastmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Sep 2025 17:45:18 -0400
X-Gm-Features: Ac12FXyeEWmkZqa6wbMn8t2Wun6mfw4KJJSTBJD8vx8rr6MmHrmXg4LFyNCd8yc
Message-ID: <CADnq5_N9r+hyu6ARUGeYnsSPNNBM-bq0YV5mQoH6vp2yXdXZhg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use kmalloc_array() instead of kmalloc()
To: James Flowers <bold.zone2373@fastmail.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, roman.li@amd.com, alvin.lee2@amd.com, 
	skhan@linuxfoundation.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Sat, Sep 13, 2025 at 1:31=E2=80=AFAM James Flowers
<bold.zone2373@fastmail.com> wrote:
>
> Documentation/process/deprecated.rst recommends against the use of kmallo=
c
> with dynamic size calculations due to the risk of overflow and smaller
> allocation being made than the caller was expecting. This could lead to
> buffer overflow in code similar to the memcpy in
> amdgpu_dm_plane_add_modifier().
>
> Signed-off-by: James Flowers <bold.zone2373@fastmail.com>
> ---
> I see that in amdgpu_dm_plane_get_plane_modifiers, capacity is initialize=
d to
> only 128, but it is probably preferable to refactor.
>
> Tested on a Steam Deck OLED with no apparent regressions using these test=
 suites from
> igt-gpu-tools:
> 1) kms_plane
> 2) amd_plane
> 3) amd_fuzzing
> 4) testdisplay
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index b7c6e8d13435..b587d2033f0b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -146,7 +146,7 @@ static void amdgpu_dm_plane_add_modifier(uint64_t **m=
ods, uint64_t *size, uint64
>
>         if (*cap - *size < 1) {
>                 uint64_t new_cap =3D *cap * 2;
> -               uint64_t *new_mods =3D kmalloc(new_cap * sizeof(uint64_t)=
, GFP_KERNEL);
> +               uint64_t *new_mods =3D kmalloc_array(new_cap, sizeof(uint=
64_t), GFP_KERNEL);
>
>                 if (!new_mods) {
>                         kfree(*mods);
> @@ -732,7 +732,7 @@ static int amdgpu_dm_plane_get_plane_modifiers(struct=
 amdgpu_device *adev, unsig
>         if (adev->family < AMDGPU_FAMILY_AI)
>                 return 0;
>
> -       *mods =3D kmalloc(capacity * sizeof(uint64_t), GFP_KERNEL);
> +       *mods =3D kmalloc_array(capacity, sizeof(uint64_t), GFP_KERNEL);
>
>         if (plane_type =3D=3D DRM_PLANE_TYPE_CURSOR) {
>                 amdgpu_dm_plane_add_modifier(mods, &size, &capacity, DRM_=
FORMAT_MOD_LINEAR);
> --
> 2.51.0
>

