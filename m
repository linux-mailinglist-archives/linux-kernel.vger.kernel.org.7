Return-Path: <linux-kernel+bounces-628930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A06A3AA64CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 22:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EA14C5A19
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 20:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29232528E9;
	Thu,  1 May 2025 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="suVW45fC"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977C11F582F
	for <linux-kernel@vger.kernel.org>; Thu,  1 May 2025 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746131681; cv=none; b=H2HAD1YWZ8ldy4dmyjqMDqBB/hL9e5I0FinnkJHu6LCLxeS8/l24RpTzIDFSGeZ0FZECLrQWWqAeFHcT/eTgp80B5pXXv3Nil/Jn5zY8YETOWU24u88mWY072o4MauNytNlB41qJFTBhsdNQRqAsfyE6UJp1kr5/oNI8FkPHzZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746131681; c=relaxed/simple;
	bh=8pF1wWpVwTMd7z0FTKQe8nYgw+2TdAxHhQ+Tcw3TpA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbHEkikwxMtjTuWPRg/etB91dRoYtfsMRKm7uMYFYJAWBR5+y4lxBWNH1LeyA34OvFjfEpyPeQ+MjI0pNliEqiCJ+pHUtXIR/EyTdVrFn/YzmcubEAUdHpgFao+s3vIKHNMNpVZxn0z/MuDiCIwGgryfcD1NRtQkm0wtdCzdcns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=suVW45fC; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-60402c94319so927486eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 May 2025 13:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746131678; x=1746736478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s2/TuQL3kQKm2Ps4XEUaXLRCzG1Av6dinL8AdUC/eeo=;
        b=suVW45fC2QAOMX2j/ERCAKJ4AkCkIlmTD19KOe9xxQduwjhLEWOOrSmugompilQfyL
         mYToKXYBINzSUwB7suMoA9wwgAzCTejNCKdtbnHdJ7kbOVCDmugy6FxMD2uQmhYpz+dI
         yk6u+MUYxZ5WRc4svO+JX91J92X9c6NZw6bEpCNrfpgU6B6oi7mARNe83mbg1mehSiuz
         ydoU9mzIV0JCRtUud89C51cN5zEajESLmRUi1ZDqwJJZxczWjvZ26h1kl9N5VRK25X4P
         pWtSeIo8Wk+V+CT7q1acuD4fl/30T7Urtbq+qkMLcCkj4yNA/hgbrXUIqf873o26/puG
         UGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746131678; x=1746736478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2/TuQL3kQKm2Ps4XEUaXLRCzG1Av6dinL8AdUC/eeo=;
        b=ZbxlW0PebnwDu+kxiVRwe8/fzBT8nuPJCoY1Wv9IPLtMsme7GHCgJGAALL1vFmULls
         7wkRDM1O1jxHhAfsc/jjP5zML1qMtEhgeaJ0ilnnHTyKq7C9Yfsd2wCNG8L2bN9WaTl2
         jl8BvoLYkRmVsrL608Ls4GUkZ45iiFdJpapJoH7bMWl1ktu2Kuf9C6BPUr2M0k0vBupO
         itmkPoq6wn4kq0RgxCdw0qc29N0E5IGIaU0RO/FWGw6qn/wYUZuihjCmJjJrn3Cuaiig
         ywriegxpBide8huFJzw1T6g0+UDteeVXmM3ofd2N9RS271uVLDKO/omqthiCwl8mGvUN
         pI8g==
X-Forwarded-Encrypted: i=1; AJvYcCU8cuj1FSKRLh24zWX4vFFdDLbgZB+losqp2POsusIp1GtHXrixM9sGqSenSGkrfjuSDGWvRvn/iyIN9CA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/EuQs0lWyuiLxlQRvt4M9wKRYZlYJNA2gJ9zVHCZA7GnfW9m
	HuEO/7Y0C19updMPdr573nOoH9fnoLrxk51zO2jnqB7rphryLP+aP07izrvoDDRL5eWDJ1E/CP3
	oe/IcfJRuZcMAhfUP7hvwV3QIM2SOqP5d1HMn0A==
X-Gm-Gg: ASbGncuWukAg1aNlY8YVxCqbMZ+aw3ETufaE169e6nAq3bVwj46pasZVgG1MENQe7oC
	fZ0yPk4Nrz4dC6H5x1vV/KeV0mcLTTI2q1eaBDrJqANw8UP7TYFZGtae9XAsR5Gr+QgSTGRtCeZ
	jUCv6BTq/hhRENiR4AjbXprA==
X-Google-Smtp-Source: AGHT+IF6bq7NXLJi5546fpk08Q9+VHouk/Ivf8VOZeleLm+nJv5PjsAxN/cnoxBRn6+mutu/ZCv+/Az9E+zhUFk9998=
X-Received: by 2002:a05:6871:7419:b0:2d4:d820:6d82 with SMTP id
 586e51a60fabf-2dab3313467mr143467fac.26.1746131678613; Thu, 01 May 2025
 13:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v3-0-1bcc44fb1d55@linaro.org>
 <20250429-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v3-5-1bcc44fb1d55@linaro.org>
In-Reply-To: <20250429-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v3-5-1bcc44fb1d55@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 1 May 2025 21:34:27 +0100
X-Gm-Features: ATxdqUG_Q1uY69qq7IbymtjMCwucexqjDWrXAetFETrm0a0bcDxzCmS7-g07qNE
Message-ID: <CADrjBPrRmQKvuTMZXAF+gVgMzkDs1=9LkwrW7CHGVEYG8c8bsg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] soc: samsung: exynos-pmu: enable CPU hotplug
 support for gs101
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hi folks,

[..]

> +
> +       regmap_read(pmu_context->pmuintrgen, GS101_GRP1_INTR_BID_UPEND, &reg);
> +       regmap_write(pmu_context->pmuintrgen, GS101_GRP2_INTR_BID_CLEAR,
> +                    reg & mask);

I just spotted a typo here in this patch, it should be
GS101_GRP1_INTR_BID_CLEAR. I'll send an updated version.

Peter.

