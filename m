Return-Path: <linux-kernel+bounces-846985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91080BC996E
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58C5D4FB493
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75AC2EAB85;
	Thu,  9 Oct 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+kt14Bi"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F892EAB79
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020997; cv=none; b=jzm4RKZf8q7aloAk0GBkzm1Xp0Mhm5pI9KgWz3Nv+YfGaR5H8JSmAxC0NiPZcs0by0pbrq3JWLXdlKIUvM4u2jIWcVYBv4OB4i8b6isDiUx49JWBi2PqOQKlB0zKDaV16kaU9VdMahwGlToupWbtqfc0BFs7MDbCYCMY7r6ER78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020997; c=relaxed/simple;
	bh=xuePTw23nhDK1u3ZeQlWw0pTVGGtZTfAt7eVSo3gjbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ibris4+fTU1lvk7Q4Swm741ceTc5HgcEbmirpLHBOgbea5n6fiXNP4lp6XHuuVDzFwcYRBQUhdmb6+bWP1xQxaH+Jg5/zqaZza/SnH++dm/KXLXPvi0R++dZSOyVcRKsvOqn1rbu5c4y6iXvyZRFsuTv9tjOcHI6Mx9o+hqi7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F+kt14Bi; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-78118e163e5so1637075b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760020993; x=1760625793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aBuYWmN845KzXqm8EouS+GqPS0z0pBmk0fzQy4dI/Ds=;
        b=F+kt14BixztRxbBP9iG12pj4sHR+SbjUho4lWQANp7OpnhJwbXkdC08S8LboxzfyAM
         EMmCmPCUM/WZEcQ92MIt3Ar+pAKQmtD+Def3dYTn8avFR6kfJ8UekiFNVSnyZzbX2V97
         DieQczSlf8CZawu9AOg9blNu64VWO1coSstRWaytHegh/mPBRASkGQr6d3PeASb0dktg
         8g80aUidy3QXIEAQgK/n6rvqj/t192kWljG23CN3eOI521qI8OeUVHAsua+/k38JC75S
         oZ2YATJ9mXzFfHTbS73ZyelqvYmW5fwPE1he2Ncwhk+XsvwqZXJMd6nKF9BEAehIBYiE
         oeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760020993; x=1760625793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBuYWmN845KzXqm8EouS+GqPS0z0pBmk0fzQy4dI/Ds=;
        b=fgjb/qLpJCivfNakuCcmX7h4M/e0iRDpR/Sxni0g+P2/127Enbg1VjRpecCaGB9ewc
         NCmUEtlijJcjikY04RkG+ICP1kiBZyR4cbvPUv9FZU2g3My8MHSaFIC6hireM5HZOxM1
         KZORzJVFrMHz7BFsbuR58e93mdzhlDbw6NX/kPhmT92H5I0kvvWS3feLunlLKtD2VPnY
         LYwbFJQJpBPkdtvFU01vtO8lPsoPjxULL3RscyaHoxKIQSQoKL5TzxhX9yDRClBEWPLq
         zXaQuLhoIq2pHQxMcME9EepCaFItT32yq7YY+xlx2Zrkpcj6VoYxdamqc8Dl1DoirYIV
         6sbg==
X-Forwarded-Encrypted: i=1; AJvYcCXuzGadbKf9U3sHGLDFWgh4mvCOAkD0ufgcm/hANapA6covzLM4zGm+WC1nLsUbYcazb9qrKpVoKGz+EeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnTlV4tK73D5ySrnu9/UZnx+SL7bQ4kHPzN1HUr6s1zU20dl+r
	psdGfW5eF1aUAqRA1RAYfHgGw3ewANiDVfBdfYsUAQLmu1/i8VcjpPZE9GAjNqhKb5kBfT7CaNy
	jJBcQcSMc2fGmu15nHVlbE9dsoRj/0aK69wtrJ77qVg==
X-Gm-Gg: ASbGncumsl9tskR6GBXGY9YXDD1qBArev2teAh/K7K3S3nLF5xSRAWzy4pGpzmS5ufT
	TInsLcyOF0By7iLzoOSDoOIJj0UY0hCXrD7At7LgjWB5V/kUVYgbbeWVr4nA1nGNnIZO3bTBRqu
	Pv5OMYQ986ZWFIy36VGfM7GysYxGt3vtHbUIyS+ela7TMd5UIASY1Me/UauVXSj6QFiI90rrRAn
	Xfb7iU0vqHPYbH8KXuu9DHFULB7DM0hBmG0
X-Google-Smtp-Source: AGHT+IEunQlJX63RRYRtSnbcqvA/nThaxmg3LM/Wg/qUN5XoyVXwmlx1x6HIDkeVcb27jelR7RW1NG5t3y+7VCGwa9A=
X-Received: by 2002:a05:6a21:33a8:b0:327:957:f915 with SMTP id
 adf61e73a8af0-32da8fcd0a3mr9718293637.24.1760020992691; Thu, 09 Oct 2025
 07:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002-james-cs-syncfreq-v3-0-fe5df2bf91d1@linaro.org> <20251002-james-cs-syncfreq-v3-1-fe5df2bf91d1@linaro.org>
In-Reply-To: <20251002-james-cs-syncfreq-v3-1-fe5df2bf91d1@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 9 Oct 2025 15:43:00 +0100
X-Gm-Features: AS18NWCyJUsxXav1BCEdra0zmZObN1mWhTpmYCiev-5sNXSTBfqKeCdcvl0rmhM
Message-ID: <CAJ9a7Vjw_4ZwEBriS5836YdnxMH47e9b_6LOUWEaTxX3RkNtXQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] coresight: Change syncfreq to be a u8
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Leo Yan <leo.yan@arm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Oct 2025 at 11:09, James Clark <james.clark@linaro.org> wrote:
>
> TRCSYNCPR.PERIOD is the only functional part of TRCSYNCPR and it only
> has 5 valid bits so it can be stored in a u8.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 13ec9ecef46f..eda3a6d2e8e2 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -825,7 +825,6 @@ struct etmv4_config {
>         u32                             eventctrl1;
>         u32                             stall_ctrl;
>         u32                             ts_ctrl;
> -       u32                             syncfreq;
>         u32                             ccctlr;
>         u32                             bb_ctrl;
>         u32                             vinst_ctrl;
> @@ -833,6 +832,7 @@ struct etmv4_config {
>         u32                             vissctlr;
>         u32                             vipcssctlr;
>         u8                              seq_idx;
> +       u8                              syncfreq;
>         u32                             seq_ctrl[ETM_MAX_SEQ_STATES];
>         u32                             seq_rst;
>         u32                             seq_state;
>
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

