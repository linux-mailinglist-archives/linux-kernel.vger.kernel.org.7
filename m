Return-Path: <linux-kernel+bounces-883701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5B7C2E250
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9085A189A2FF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57A72D0606;
	Mon,  3 Nov 2025 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd5nzyaD"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E090827FD49
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762205052; cv=none; b=byf4lQhOeKlC4eEG2nui8BhUqFA38BSlPd3NfTWOVUHEonxWW5b8938aoo8cKXGK9bExCrt46642PP7O2grkP74b6UcvwFnz2rxq9xLL7JfJZM0ke7rP6xF2OMxaq15+bw1jezTKl7J4HqC2Samj88dNz4xROZWCjZuG5bg22HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762205052; c=relaxed/simple;
	bh=VbOJNq35wZZMKpn6zF3s2XM6+SMZiEab61NKw7H/8CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhTy7KxVaWbVR/3hBXGJT3jFa3TYWKKwrJkg65jh+XxYJQu9zSB4MUoIshx0+P7BBddhNhhxz8dp/XQ1PZIjDInuk732tO+x2heOtqFJQuAnx7agqgTlcsBJPy7sfXH0Ie53m4d8bzbAIvJ6+DIf60RGrM9+osXMVB4jBgfpNJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd5nzyaD; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a2687cb882so794313b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762205050; x=1762809850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Nht7Ga7UbT7S0pgUmdGlaMkNSqWf/hA/x/jfjEhJNY=;
        b=Qd5nzyaDiDJFIzUViuYfwAzjpoG2K85RD1efZRk8IK1YBUhqkdOzr8Nqgz5o3yjxu3
         zwo/NNtLqOw9fykUo44FCkJ78BA2jlpll12SfrlgQFbjgNbZ0oTcOwsntp8EMQarPOnX
         YRRCFlQLnJYy3iTjSDD8RuZ+q7zHSIyhtfeLDzQzjy5aJYHZX0znd2mz99BEOp9BKbHx
         Axt/xvN8yFjGtLvOHxXJ8nHw2dlMQnqnboYsvevE09Kuq3skxSlNdkp5mD9D4SSDhuom
         Xn1re5NttbsXHDc1kMgJX3xr0ofere15C6VxkqtAl3hQclhz0y7+BjicJ44buDPzHDuQ
         I4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762205050; x=1762809850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Nht7Ga7UbT7S0pgUmdGlaMkNSqWf/hA/x/jfjEhJNY=;
        b=Ail8PVXDLFG6OmKbVOpjCCdBP861k5zchjdTMtuci1Uww+l74dKw8OlSeNap3DFHwW
         IMx5HVbut508w/ugDr/OodWaAF5EkR7TdW4mI8I5Lsz0VyvkYdJxtz0iRG4lAgmw6jZu
         NK91Z4ddl32oCSscLO1RQriKtKtXjmUDiXeSCiRhT0P2ncyTv/XY8ffwzFCKTvcQap0Z
         ml1IvidRfme2EpkqQWK7YNebzA4LSnBLe0ZOwrTiUOcMilCMtYlFUTbLaX493paU3FRs
         hQI4vmsAqVfXqoQv8rdzFF1d6mEctnCa5biE/l9jXBGmTp2GT/ldR43qTjtk30c7qlb9
         9t6g==
X-Forwarded-Encrypted: i=1; AJvYcCVKWPLiza1dWr9fMlkd2WCr18SHAQ9MskuMaM8I/VYbj6i5dWUalerKpvY1aRU4n+NtDewJqcbvtgIAjd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyanp6AmyRRj/qSdoEGYzIG4qtRmIX59hzkh/y2DbumLV5uBN9e
	oh678aukC3J28n6+1HuQDq3Rv11qUSZF1Ya5oRQzLjFkcCbHlhX0oKbqyezShHH6BO+C2lu2Rrv
	soMdFepYUW9ILn5+P48OFIusNFDIPgdg=
X-Gm-Gg: ASbGncu//f8P8WOAOxel5Rfi11I312TlTcsT/AaJJ69kpoc2s96R6Wj46p+QNncceAJ
	t3+04FMVtWc4nRyFPGOhtlYvjSccgEOAIuJwstJL//FBuXIHZ7y+Ays+KshxNnoPiSbiBT/eWpf
	7DUu2ss8hOTLxpDO5Dk+Ho2qOdetF3quA7Ylvt2OALciL21FAYp83oSuo3EkCDmvPH2NAkTxtRd
	8LJKEYGc44j20alkXRuj3rbeLCfPvOHczoZZ9A8BV6Zjo8wyl3hlLJk+iqN
X-Google-Smtp-Source: AGHT+IFY8+2qFA1oiKosDS/rAbxdW43gmN+fJej+sar+4puyVhhm5/G83MSiXSxR/0mkFd6qHx0UbRoOd1MS3ZSWVwo=
X-Received: by 2002:a17:902:d481:b0:295:558d:a464 with SMTP id
 d9443c01a7336-295558da62emr77743435ad.7.1762205050142; Mon, 03 Nov 2025
 13:24:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-vram-carveout-tuning-for-upstream-v1-0-17e2a72639c5@amd.com>
 <20251103-vram-carveout-tuning-for-upstream-v1-1-17e2a72639c5@amd.com>
In-Reply-To: <20251103-vram-carveout-tuning-for-upstream-v1-1-17e2a72639c5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Nov 2025 16:23:58 -0500
X-Gm-Features: AWmQ_blvBwcjDFk_MBDYqriTXRTTpOTzumlZhYcWa0hA4X0Y7q8ncHOD5PHapVI
Message-ID: <CADnq5_P66LndOd5aJs=BN8btde1XNumCRZL2TZ1yfFfUwyGJOA@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu: parse UMA size-getting/setting bits in
 ATCS mask
To: "Yo-Jung Leo Lin (AMD)" <Leo.Lin@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, anson.tsao@amd.com, superm1@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 3:01=E2=80=AFAM Yo-Jung Leo Lin (AMD) <Leo.Lin@amd.c=
om> wrote:
>
> The capabilities of getting and setting VRAM carveout size are exposed
> in the ATCS mask. Parse and store these capabilities for future use.
>
> Co-developed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Yo-Jung Leo Lin (AMD) <Leo.Lin@amd.com>

This patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 ++++
>  drivers/gpu/drm/amd/include/amd_acpi.h   | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index 6c62e27b9800..0743fd8620e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -116,7 +116,9 @@ struct amdgpu_atcs_functions {
>         bool pcie_perf_req;
>         bool pcie_dev_rdy;
>         bool pcie_bus_width;
> +       bool get_uma_size;
>         bool power_shift_control;
> +       bool set_uma_allocation_size;
>  };
>
>  struct amdgpu_atcs {
> @@ -588,7 +590,9 @@ static void amdgpu_atcs_parse_functions(struct amdgpu=
_atcs_functions *f, u32 mas
>         f->pcie_perf_req =3D mask & ATCS_PCIE_PERFORMANCE_REQUEST_SUPPORT=
ED;
>         f->pcie_dev_rdy =3D mask & ATCS_PCIE_DEVICE_READY_NOTIFICATION_SU=
PPORTED;
>         f->pcie_bus_width =3D mask & ATCS_SET_PCIE_BUS_WIDTH_SUPPORTED;
> +       f->get_uma_size =3D mask & ACPI_ATCS_GET_UMA_SIZE_SUPPORTED;
>         f->power_shift_control =3D mask & ATCS_SET_POWER_SHIFT_CONTROL_SU=
PPORTED;
> +       f->set_uma_allocation_size =3D mask & ACPI_ATCS_SET_UMA_ALLOCATIO=
N_SIZE_SUPPORTED;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/include/amd_acpi.h b/drivers/gpu/drm/amd=
/include/amd_acpi.h
> index 06badbf0c5b9..e582339e8e8e 100644
> --- a/drivers/gpu/drm/amd/include/amd_acpi.h
> +++ b/drivers/gpu/drm/amd/include/amd_acpi.h
> @@ -427,7 +427,9 @@ struct atcs_pwr_shift_input {
>  #       define ATCS_PCIE_PERFORMANCE_REQUEST_SUPPORTED             (1 <<=
 1)
>  #       define ATCS_PCIE_DEVICE_READY_NOTIFICATION_SUPPORTED       (1 <<=
 2)
>  #       define ATCS_SET_PCIE_BUS_WIDTH_SUPPORTED                   (1 <<=
 3)
> -#       define ATCS_SET_POWER_SHIFT_CONTROL_SUPPORTED             (1 << =
7)
> +#       define ACPI_ATCS_GET_UMA_SIZE_SUPPORTED                    (1 <<=
 5)
> +#       define ATCS_SET_POWER_SHIFT_CONTROL_SUPPORTED              (1 <<=
 7)
> +#       define ACPI_ATCS_SET_UMA_ALLOCATION_SIZE_SUPPORTED         (1 <<=
 9)
>  #define ATCS_FUNCTION_GET_EXTERNAL_STATE                           0x1
>  /* ARG0: ATCS_FUNCTION_GET_EXTERNAL_STATE
>   * ARG1: none
>
> --
> 2.43.0
>

