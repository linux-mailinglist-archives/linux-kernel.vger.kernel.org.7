Return-Path: <linux-kernel+bounces-725173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E07EAFFB99
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA101C84FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE55628B4FC;
	Thu, 10 Jul 2025 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wkZPnnmi"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68609285C89
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134549; cv=none; b=Jr7OaG6hoqKh8aWGvv1Y4uocil+i4+8M+ylmky4nJIMgf7/xvnEo58OKp6krIkCW4SfexHMLMqgYee1qkon3LjYxESIr6NxEQMZPBPUz9/otPllenOtNXqehjiNCfaLYxnLpSHmzAasP3kkfP9lvquNLOvYhK5b0e8b50n6WbHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134549; c=relaxed/simple;
	bh=GI1VtsjhXtrT2WJCXUGzz8y+u1YIjjmIvhsqRtpRE5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMY6vX9iXqLXBYRRjM8GVfqTcmlIRaZ9G0C7kemrvnxr5ibEMWS3eVtfNGcEcppDTrpigZHZ3mCS+tbn/hD7wzbIwFMhTmVnMicYLi9u1L7unF73PWRq2kLOvY+46E1HzG3r/rJdKD8cJ4DAHIMfWyJjCfuSP+YuIatDpqDsoQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wkZPnnmi; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-611b246727cso356221eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752134546; x=1752739346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fK8V0E4Xdcf1fTBLfVQvRq2RbYuBxS2NIoLWeiVRMmk=;
        b=wkZPnnmidyJSCaLNWtyJhGh9e0+16A29vkVSz8bkZKgdtNVyBUkmiqZbxdbg5WQINy
         xodsGCuA5b6dM2hysgikYh/bnVvgKwgU6SdcY4urPjaU6IW+QwKA3d6UEksSFKbjuLM7
         Sis63Zn+sbeLvxr0znbSNrbUWnsLSi2HYH2jgTnMS2xFaQ+rijuR94bV7KXyDuSjA3y/
         J8HIkBiFh+BA0dAhl8DMm5cD52faHyi25VbCqdlvnforhWcNGLU2PyhBnJSGEMwgdCxp
         c7EvgGd0t6lF4Ca4f/QY2a+Xb+cl/hsdHjougPVqXZ2yUOExfY8qKGhDRvrd7FITNMKP
         aYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752134546; x=1752739346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fK8V0E4Xdcf1fTBLfVQvRq2RbYuBxS2NIoLWeiVRMmk=;
        b=eJTGYXKG7zmQyW3A3ZVawDYb+mKeJ/CRCitDB7rTaESODhWt6Tp1C49GkwF4Roz5Rf
         PRlihEASU5to5Tjk5Mfbz9qe43vj4Pv1QlbEW9710HExAcpO7zfRDTK/IEtVc9lsOR6W
         nlpZgfFkwJwGEdqwA+qnTDlKRZmBu1EH01DNXFCJ2nc7J35tX1bMDsez2nQHom7PkAVT
         BI6p/1hYnDUXDK8v7mJX7RCMDncdZ8j0WYBftVaILkD17IUpPcWom2KZ8gUMBGEU+9YP
         N3tLDsmP+pMU3UQ/4dtOwypDHUANRQwHLOcTaSvKQHX1NJtbE65vlrdtfEzUn45LSJmP
         WfkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeUpOQ2vOrYYnekffNjGbfCO7UIUn9oY2wiJg/l5UTelQ0LvwDp4WtOksA0Qq3h3e984bXgx5debumLxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0vxvJhu+Mkfv+m+FktBpavfsZJtC7nPPEBUYA2CVCY7EqfFL3
	6KPgF/lbJl1beVfP0gsYzgg7pxAcu41suEj1qNjTwGJl1RhJastOjpKw+tbB6Rcxha1o7bkONw/
	PucHCZpYD4n07huib6XUExdCd14oeiDjiZvGzCu0vOg==
X-Gm-Gg: ASbGncsSB4zEjMYQ6Xx/UE/rEoHwfOsIoMFxTvobqoGvl6ItluCRjaI68j4/CjNYmvr
	RysEA0genDCdU2NDBUlewtH9mVkjLhngeqobszplVCo+eGYT4jrisKdYbyjcQbTA9BapvVsOxEl
	2R6s8yLqMO7UR1Ele1fYAkgQXSIV2yrcD4fRMyIKXEEL0nBYZtVARFug==
X-Google-Smtp-Source: AGHT+IHrFLYymR6F7UKamK/gjTFOEV/FWv98kovyNcG7HeAzZOtkYSEipfwxdZEaT2lEQ5TAU9vcD7JJ0ogSkLcbVfA=
X-Received: by 2002:a05:6820:260e:b0:613:8176:8a00 with SMTP id
 006d021491bc7-613d9db2e43mr1002071eaf.2.1752134546426; Thu, 10 Jul 2025
 01:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-ufs-exynos-shift-v1-1-1418e161ae40@linaro.org>
In-Reply-To: <20250707-ufs-exynos-shift-v1-1-1418e161ae40@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 10 Jul 2025 09:02:15 +0100
X-Gm-Features: Ac12FXw14Fnv-NHIV6I5KCDE4Qv3eilf3MCfG465JBU1_Jo35wVeJqk-I6YsdjU
Message-ID: <CADrjBPr_7NL4jFY=0B=VN7+WtxHrFxGvvqg0AnnPY_P45dtngQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: exynos: fix programming of HCI_UTRL_NEXUS_TYPE
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Seungwon Jeon <essuuj@gmail.com>, Avri Altman <avri.altman@wdc.com>, 
	Kiwoong Kim <kwmad.kim@samsung.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-scsi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Jul 2025 at 18:05, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> On Google gs101, the number of UTP transfer request slots (nutrs) is
> 32, and in this case the driver ends up programming the UTRL_NEXUS_TYPE
> incorrectly as 0.
>
> This is because the left hand side of the shift is 1, which is of type
> int, i.e. 31 bits wide. Shifting by more than that width results in
> undefined behaviour.
>
> Fix this by switching to the BIT() macro, which applies correct type
> casting as required. This ensures the correct value is written to
> UTRL_NEXUS_TYPE (0xffffffff on gs101), and it also fixes a UBSAN shift
> warning:
>     UBSAN: shift-out-of-bounds in drivers/ufs/host/ufs-exynos.c:1113:21
>     shift exponent 32 is too large for 32-bit type 'int'
>
> For consistency, apply the same change to the nutmrs / UTMRL_NEXUS_TYPE
> write.
>
> Fixes: 55f4b1f73631 ("scsi: ufs: ufs-exynos: Add UFS host support for Exy=
nos SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

