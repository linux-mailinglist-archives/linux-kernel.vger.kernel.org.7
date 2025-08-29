Return-Path: <linux-kernel+bounces-791981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C606B3BF09
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C1A04E1057
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D20322A25;
	Fri, 29 Aug 2025 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="QDWrN8IP"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB9E3218B4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480719; cv=none; b=UNEHs4YlYhYqFj+kEF+lwEGq1VYye8gNrPYaOxbWGo9Yy8rTBLukOeP0oebyPyNkcsypJx4Ayc4eak1y6iA+hPiqJ4NEpKPnd9lOgjxkPM5hSOoRW8rPeTUIWVpsl8N2Y4vEyTZhdm2ganuO32/7GXd/lY7r/2enyVHueacxwgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480719; c=relaxed/simple;
	bh=ghrhxwoqKMCN5VgWcIThzYZeVniKtHuv8o+iU1wCEl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXx1sIdjBN4jukSDRexZDgBPYlegxZU1kX2cmNOiEmw25jsZ4TnT3WDLprpgnk30vHV9ItU6uFmgzAPzPY3zCbyRiK5EcRK5sJxV8uMnG/ZAXmLNxeA9KG0ma9D6WkITY7LZOFwfeTnkM0goIXa02JOpQ0tbJr2f9283dcY1XnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=QDWrN8IP; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e8704cdc76so223058685a.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1756480716; x=1757085516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ghrhxwoqKMCN5VgWcIThzYZeVniKtHuv8o+iU1wCEl0=;
        b=QDWrN8IPI+PRTsZH2O5F6koRJMquNoiCO+9FSpU07YIxZjGCdIrpd0accexbZNKPJl
         XrdJ5Xf67bNnuYcH5PaR3nOpBDZVaRAaIqwSLFq5nlf0Ki3f0qsMkA/OfxFMfzF15eFL
         mAYPspJQZ7XLrq5e8XBjQ+TNMbzIPUjCLV9uWm0FgCRQwIFBxZsUqJyVqucnc+2FaUI9
         ALl213vbx+CsZBO1osxS+2f1tC2N10q3019wCdPFOg94OyaKj/e3T3veFQB8Dn2ZmSkc
         UDcbKSWmOWJXt2YAQtBiVL77YgrjJ+2JBoAczm/4yfVVdb/7vOPJQKs+O4lWspc0IDFt
         kUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756480716; x=1757085516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghrhxwoqKMCN5VgWcIThzYZeVniKtHuv8o+iU1wCEl0=;
        b=PuIDj/LeF4fh30PiAhLpXv2C+B7Ev8I2cgFHhmB4oWnhaxevL1UfccVCf1gW5iX2SQ
         1xHREA4q52PDfygLsuMruaKP0pifF7Ze7cvbUlFrNy36VBrcgTuzLWmt1l7AwAXen6MD
         C1MOOtkldy3ACGpcXAIUK+pdxuguhG9pLgaNELvdT4hb5fJbJUGVHnqDhbKfL1Yf6dpW
         M+u3H/WDOXl8yAA0EeGHbup+MzQeet+P1gGWI+6TdqBGP2PMCb2aS9cLqHcbXVNLGP34
         ihXdhoHib3fMCGUDA9fPshu/uJx4GTBEK1NfWtL7YDrS2yU7oUmPzXXpiwNRLaeVsXrv
         kkUw==
X-Forwarded-Encrypted: i=1; AJvYcCXaAam9jZ2zd61HX0JF3BSNt7gDB9rpqbT2CoVdfH+FcetQiWl2xKMp16VCnYSQDfBe9uHhr/kEaUFx7nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1oFq9wkPpOj29yx0mfeEl38WWA3oXbR9AaZrixU9yU4qvnSDb
	ECK8PaoKSBCqydH2WoaBiMxJkMy77zIO9Q0v0x+FRP+f6pFD8TBLY4fP6lCsv4IgEvI0BzsYciL
	IA99Z5Q78xheeLPIPIJTrkUMS+bIFnIQlU+6Mi/s6KA==
X-Gm-Gg: ASbGncuuR1+OeM4Uf4jAVoek1q6nUdfkJFP1PbeMUKAfq6rvUgYvyVki5wtDnXfNlpJ
	T+31gn65DGvTm5HmDjZcJMGpJ1mKQieqBmkr7AW+kj4oBhYhSp5dd6TZXY23vVm7qba+eZCb9jJ
	bxwCTQx6EWQkxLNhiNwrewFlU0Cn0u4h8A/wqZBKIGWRbHRxI9RgasqGoz353EPBGAZCXQymZX1
	qvwKigEulGtf5p5
X-Google-Smtp-Source: AGHT+IGmPttzEK19ZD3UTDCY1FnzsKcijNSUsN6pQPrVL+2gsomLPlupJ17X2EjGDAqx5GLvtjHyN5i9KgoNezf9kFI=
X-Received: by 2002:a05:620a:2888:b0:7e8:1d4b:b00e with SMTP id
 af79cd13be357-7ea10f73af4mr2964339785a.30.1756480716220; Fri, 29 Aug 2025
 08:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-rk3588-hdmi-cec-v3-0-95324fb22592@collabora.com> <20250825-rk3588-hdmi-cec-v3-5-95324fb22592@collabora.com>
In-Reply-To: <20250825-rk3588-hdmi-cec-v3-5-95324fb22592@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 29 Aug 2025 17:18:23 +0200
X-Gm-Features: Ac12FXxmGn_rShnoeRaqJ2HPo1b9mmmJuCbdWBYqIMqhSsoU1twbnPqkg976p5g
Message-ID: <CAPj87rO1NKnApMkw75CmAXS6_ARpFDiofgwiqH_uwfrB6BFcUA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] drm/rockchip: dw_hdmi_qp: Provide ref clock rate
 in dw_hdmi_qp_plat_data
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Aug 2025 at 10:57, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> In order to support correct initialization of the timer base in the HDMI
> QP IP block, setup platform data to include the required reference clock
> rate.
>
> While at it, ensure plat_data is zero-initialized in
> dw_hdmi_qp_rockchip_bind().

Reviewed-by: Daniel Stone <daniels@collabora.com>

