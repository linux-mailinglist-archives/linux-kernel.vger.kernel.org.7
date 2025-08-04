Return-Path: <linux-kernel+bounces-755416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBECB1A60D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D540717FFCE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF73B214814;
	Mon,  4 Aug 2025 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbZvo176"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23592BB17
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321581; cv=none; b=dXlpDSYh7FgQpggfz1aIsBoqvq3Uv4sS4DlX/3i25PseQakmXVT27GLBqOH0LboA7S04zVcZ8Xp/0ytUMDd/a2OXIb29Q0DQ34lHmTCd53WSzEWrHMSylayox/ZhkIHqTRnWrQEh2Ftp22OnnOVlHMuu6/cb1hu/scHqsm+WvB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321581; c=relaxed/simple;
	bh=RFpbv95nwoE/OgfX00G2Z9nHDsrVsIc1VrUxA6CC7ZE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C+RbsO9ulMMjaUFSbODMyORhpSD8cBnwZgbaucmgWHoTPKFWQVu7Xe1ACbYiskFho6nGdw8FcLZSwhM9Lwr5VaGLJZyvTy/ORU9UvHaVw3IXh17ysJkxSWr+DsIhSjCxuB33FX9sC2Yk3Tve1xhiFBKivAdECJM4WIxT7A2b5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pbZvo176; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b79bd3b1f7so2465039f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321578; x=1754926378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wO1zoAKHaQSzcjVJ3GnxsXBacl0eggix/R4YBPDlPI=;
        b=pbZvo176y2q6W2mB+w869bVgYCbi3MbF82xd8FzharBZurx6YxVlZNm8NocQw9M9MA
         5Y/L0O+YA9t7/Drswd5tYwmZ8025hHKL2K2LeuMg6epEnJp6k0cwhBhKZPXPvAbMCn3o
         2mmGdzvu/sP4glZlvsqGehW2YZbK3zRoViGSneyf7zFiY3H3pIinPFOfK750qAzkco9j
         NrTRx+xLRntnM99lBCD4glx7BjWc2VexVzVClEZUwm0uZgX4+ZdUlxMDumt/EtzKoeuP
         ZGnvOjl8Y9spaPCL8HKgHx6cBrqtUKnO8HMtKINHZseH5f7qqiNLaUMmXHLpcBdJPlB+
         GkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321578; x=1754926378;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wO1zoAKHaQSzcjVJ3GnxsXBacl0eggix/R4YBPDlPI=;
        b=U/Db+5da4c1bZl+zh7oq2iL72yep9fjvC2R9Bc56YxRscsnFjcJpX99aGCnoeoxziO
         u5ZNJMwOnz4/2jrP3JT+ZUwLe1je7xxJL6VpyJWntHmvVx7Q1vptGtrUfEqcFsC3hEgL
         WAWg8R9vZVesG726eVLbfdCUhJP2/DpPXcpudtWHQojc/MXkss5dzRXIQqnK2xCEPq9h
         MDUqlcZ+tzgC4NNjXF1mUig3vvEhOiRS0nkhmSE0W09888YWacWwy9q+Lnd7tWD+b7BS
         wfkOVGc3cUJabOe6ySiWjg0mBEjNpxJpRmYlYisYSj13ZwmI4Mordi1KKKtpTaPreVJW
         tNcA==
X-Forwarded-Encrypted: i=1; AJvYcCWTMM/wEcvIwDYAxOk91hAfMbwXWTDPhTs+I9H80Y9PswflR1rqqSeWfkA8sdWUXUOKVu3JiG85tihhmF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsibg6hbGZQnG+929xFFSkY9vgT2ro76ODGKcMbg0Z9E25mSHB
	NiY6xZwu1gbCcWprbEgq0Qc2dIODdfxHX38i2PXxYKfVpTu9jYWAf4iaYsuL0WPA5Mw=
X-Gm-Gg: ASbGncsm+D4w6GGHeXLDedMZxbh1H1NEaX+rN35TAxeCjb4Xjut2Q4YU+BATwAmUGaN
	RVEca3xAzELpusbDUP/a+pvd7DEjArEOQ5lfCVEcDSNh8RpSObXwxzH9a2Qu0dn9wNWizyAbPtB
	C+IOeOHwbmL6UT0KM7fqjFnJLFtUOYfBQzEOD+H+6+AZ1Gx7+8Ueo6CZnQu3M175Xq6c46wOchl
	QA0wfc66v9E9JOpBAw1IG3U2T1fV4GNcMNnF3Bo6YfG3RKd19qtLf5NRNald32bm7Kwa7QdNriY
	bGk2zIxzQcZt7s+LosZovuPxHi52v9WutVt8IVQdaTc2JQycGFBnkWGpoIvB1IubZehbst2hInm
	WBNO+7RNHgkx9Airj8B2AvHYe5n/0pe+EeLFTjPnSUqA=
X-Google-Smtp-Source: AGHT+IGzYJXMN+QHfXX3SrTuT/OBzGP+W/AdGblgpQIkiy+BxQ+LG4rjRGI4C2pPJoNlunoLVYq/Aw==
X-Received: by 2002:a05:6000:2c11:b0:3b7:78c8:937f with SMTP id ffacd0b85a97d-3b8d94720d1mr7189113f8f.20.1754321577802;
        Mon, 04 Aug 2025 08:32:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47ca5fsm15664010f8f.63.2025.08.04.08.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:32:57 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Paul Kocialkowski <paulk@sys-base.io>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20250702082230.1291953-1-paulk@sys-base.io>
References: <20250702082230.1291953-1-paulk@sys-base.io>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: simple: Add Olimex
 LCD-OLinuXino-5CTS
Message-Id: <175432157672.3671011.14707033702603455664.b4-ty@linaro.org>
Date: Mon, 04 Aug 2025 17:32:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Wed, 02 Jul 2025 10:22:29 +0200, Paul Kocialkowski wrote:
> Add the Olimex LCD-OLinuXino-5CTS, a 5-inch TFT LCD panel.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: simple: Add Olimex LCD-OLinuXino-5CTS
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/1da71a08080bb5cf5601f237e94c3dd5cede446b
[2/2] drm/panel: simple: Add Olimex LCD-OLinuXino-5CTS support
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/26232780077b3e6147fabb6111afd0bd9a60f973

-- 
Neil


