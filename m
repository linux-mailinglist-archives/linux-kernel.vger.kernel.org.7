Return-Path: <linux-kernel+bounces-742308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4281B0EFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C3D58369A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C3328DB56;
	Wed, 23 Jul 2025 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hx5tFD3C"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD38828DB47
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266370; cv=none; b=gmHQOJnD+m0iHsfyPrW8aqSNCmuon+i4KJOLm9i/DJd/QutN5E2HRKMGjE2Ov/4XPDq7+hwYeYE21+vxBNQYQlOZW+ANEn7MJxFRjnIIAsZ59fhn3RVUjNP6U6NmPyFl3GP54KrJLnhJKSEfNraUl12dKztqoNmmoUAMVLw0GsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266370; c=relaxed/simple;
	bh=89wYcJ16h/vBsYqaJ40twaimJn/xvhA0SCY527VaqkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEuw0unN4RSFaPjIo8girIgTQ/0CsqAv+oVP8H9cLWRZo9FLUgq4SoCBzgKiZSBMd3e3dXrJ81u0RylDlUvC1Xyw/1lON9eTTFC5Q7y0SD6WWVOmaAAiQoYoih4tdIMQnTBQNlnrOoOPLffJfZl56D7wUUkIYnaKmJi2n9FC1mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hx5tFD3C; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-719a4206caeso17756187b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753266367; x=1753871167; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=41nGtfIS+0AAlnYT3zsrXsXWjzXIGVgKsqDTuC+Cygk=;
        b=hx5tFD3CqFNBYbrZaUAIR4S+3fQ32OBPEKhp8dNvYySMVsWKtoSNoXFcBwYocU1jd1
         5rmOmk5lwVWvLbltCP7maqF0h1BSjJ5XR/cpVGacZ3LC+hpUriF6m9Ozo0dRNhVmOJV0
         Ae3RmDbxdkEcUx8DZPWnIZiSD+tDC2jTVhIC/ub6chJ1+c+x1HnJ/Ox1ehQmtAKfKg10
         iZ5FmgeC2p63Dr5gAhcTJY7AoTvBq9YddGd5QjJGUJS71NF+USRNaeaFZFimBW9fu74o
         33PKUBywZPPEzZ9qJ6bbiIaHkoUFDH+KuEuucd2DZgNbckzaNnyPCx5KcpsFHiVq8F8a
         xdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753266367; x=1753871167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41nGtfIS+0AAlnYT3zsrXsXWjzXIGVgKsqDTuC+Cygk=;
        b=EeT4tt1V3nhiinaNVRnXwRJmXeMXMjyKnbIkC/pMtXzoA3cHlRdlIEmquZvZcFCgwi
         iDu2kSHUF66Y9MrsmyMeuylNVhhHA5IOBYAhMoNciSYhdA8RR7FzaXmOzB+0z12BJzUy
         k1XZ8LU/mbZrg0qwqwtUqyJwRGzeyDzKprDCSst52v26pR0JjhsPjPjlxMgVSdKkPEqY
         5ER80PfjPV0IzvI9XVF3EqspYJrOWNBeHwsY23AxJU06F0fZF55RWwd6dT7ufkBE2vQ4
         vdrWU6MfIxbsaXUKP6szZWjml6lsM7k1UsO+WMqVCso3UETIi25NvP55Kt7HWQqYlp7E
         5ZHg==
X-Forwarded-Encrypted: i=1; AJvYcCWWXp+uQT13jQhIfPaQXt2KSdVrzl1kuuVDs97lUaaVLYVKIXJfI8DrUFQGncb2jnlWhTodoO49ysyzb/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOswBAf1uwRU70gpRMnLOmkx2+Yte0iz2r921sQNk1M6ENvtMB
	+VICxhKb97EMarKtxlNpfIzUm//qppZWR2yxytod9wEqZNjQlz0vYsn5//M86eXySiCFHwUeUNF
	e9xZl25m9vsdv0afJ5DvUv2XG3cy7tNwHz+/7ZB3n9g==
X-Gm-Gg: ASbGncvKmgyYF0Gpt0NNgrbstzGk08TlSac8upW0N1zUwBRu1HJ2qb2GdYlFoOVR5qY
	1eVb+kyL2DxpB7q6ZvuABn6Ffk0r1+jlT2JQ8TuNgeuO+NRjhZhXLCM1Rn6gsV7zYztTdBSEiv/
	Rb8gbVbCkZSsma6I76MbxCXOa3cchap3eBHmZlh+6C+370FUZcNFsF3OQKPC/EloZIJPK32zKRe
	IfeNvlGih1RJ3TdXNETlyUNEQOd5KLwpY1tpEEKbA==
X-Google-Smtp-Source: AGHT+IG6B6yrfLJOT0qbrE/bqWHii4PWByxkzfFfz63PKVDO/33ZG/QA9czSlFnn0T62zfPa4elBf5y125sdMA/uqoU=
X-Received: by 2002:a05:690c:7:b0:714:3e:f424 with SMTP id 00721157ae682-719b4236b7cmr32887317b3.35.1753266366506;
 Wed, 23 Jul 2025 03:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721094328.6556-1-quic_sayalil@quicinc.com>
In-Reply-To: <20250721094328.6556-1-quic_sayalil@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 23 Jul 2025 12:25:29 +0200
X-Gm-Features: Ac12FXxL_k4CqcJQuBJ2hNtSKMJ4XE8sFEx6XTYV90O9wlUWmP5N9jedMU35YWY
Message-ID: <CAPDyKFrarv7AebbcfrJ6hWTX0B=iAxLOomQ+7VfAeKZU6eewAw@mail.gmail.com>
Subject: Re: [PATCH V1 0/1] Export an API to reinit SDIO card
To: Sayali Lokhande <quic_sayalil@quicinc.com>
Cc: wsa+renesas@sang-engineering.com, avri.altman@wdc.com, 
	adrian.hunter@intel.com, shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Jul 2025 at 11:43, Sayali Lokhande <quic_sayalil@quicinc.com> wrote:
>
> Some SDIO client drivers, manage external power to the SDIO card.
> In such cases, the card may be power-cycled independently of the
> MMC core's runtime PM state.
> Currently, reinitialization of the SDIO card is tied to the runtime
> PM resume path. However, if the card is powered off and on again before
> the autosuspend delay expires, the runtime suspend/resume callbacks are
> not triggered, leaving the card in an uninitialized state.
>
> To address this, export sdio_reinit_card() so that client drivers can
> explicitly trigger reinitialization after powering the card back on,
> ensuring proper device state regardless of runtime PM behavior.
>
> This change enables more robust handling of power-managed SDIO devices
> in scenarios where runtime PM is disabled or insufficient.

Please use mmc_hw|sw_reset() instead.

Kind regards
Uffe

>
> Sayali Lokhande (1):
>   mmc: sdio: Export an API to reinit the SDIO card
>
>  drivers/mmc/core/core.h       | 1 +
>  drivers/mmc/core/sdio.c       | 2 +-
>  drivers/mmc/core/sdio_io.c    | 6 ++++++
>  include/linux/mmc/sdio_func.h | 2 ++
>  4 files changed, 10 insertions(+), 1 deletion(-)
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>

