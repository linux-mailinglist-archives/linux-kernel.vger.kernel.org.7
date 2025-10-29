Return-Path: <linux-kernel+bounces-877155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 831C5C1D537
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 331154E20DC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C34312829;
	Wed, 29 Oct 2025 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABo2cpzI"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E036825DB12
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771538; cv=none; b=aSQBDOiaPsp+ypG7H63Ytw1s86tIg9jmRoUL4aFHIPgssxlrTGBLCpdWY7BJNRziXcftOxkkXPlQPTDJ32f1hJ+8vQFsgnoWuLexTEcPGjygXas5rCECCOg08SaJ6WTBobMBJtiAUB+5WvzLPWS8XiyS1FuT12F45ggHKeEKwz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771538; c=relaxed/simple;
	bh=PqLqvTA1emrmRvMWyI9Yf1f9/hnkJQpw47ULOK4ZQ04=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Fv89Md25FxjFd9Bvohc33aW0O1msHqR8it1mFTv11QRwwMD9M+gQ53Pk1qJz+3rv/xPWx0EwOT1N29VdamrWifvfZ/lP/rG5Ef+MlXHAOQlyavNBTJCWxPEY6f03BicCnqwb8QLEtHG0rEawDCDqZW5hdZNBxUxZE0ZsVyMS2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ABo2cpzI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-471b80b994bso3593165e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761771535; x=1762376335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PZYROl59B0+8VWAIvP+emTQAflEt9bueWJDy1TlQwU=;
        b=ABo2cpzINSJS4Nlz37n5FexyJq+a8jN8UpjDlWS0fW7iQSlOqVRHw5/xq72uNFnb+p
         VN8fHsY5YHmallygc9evRtHdp0yxo4FL4sL2FDAgw4otLK9uqUg83bV300uB/FH+sU7A
         HqDKZoBWL/PoqQ4FO/uNBc2pPJan08li3G23w2s9zq8z8rxddrWgMu+hCs/tY+jn4Y27
         /raVTdIOJcb+lf7mpuihCgivN0n07Xwekz3SsNiOxl8k8fu7/6GmwdihI9AWnfEsjjFh
         1xgomt9yKT9bvMB1FeHUBmbw5py9lbDY40yaoRNcEjS1Y+bn78ot+RdUX1GPoyeV3hpe
         hWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761771535; x=1762376335;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PZYROl59B0+8VWAIvP+emTQAflEt9bueWJDy1TlQwU=;
        b=QeJSUz/PoPwx+qe13owvaalqLRr4WAmbVmtb3m4ZYqkqYNvG2chuB3nziovp3hfLGN
         brOhRZxE5LXLtLlCGYOOr6O7/k598yzBgbeZpoZet90NTDA8lcgUf44HYsrrgyEI/jvO
         P2xGJlaq2UmBubz22Yr2voUNh+2FIBMEP34/T5EE7U7szIY8CdUMyeJ9KmCN1WrE2Pp4
         c3+vcWyma1ClSsb/gVDj9viIP0fYjJOAqagt/l+BkFXJqvNFhKfSRZpjJHWHUaa1DI5R
         a9PUbev+h57uDELKFOgG4Of5/RGLP9fJ+ZfNLC9v/DfcU3+crKYZjd9OySqSoGG59gyB
         h2EA==
X-Forwarded-Encrypted: i=1; AJvYcCUycrdHt9k4SCRmTkoIaWaex2s67ojmvnqlfG4Rlxodzr2CGL1njwbuvv+HfbMOWeoYyG67gfO/0AwQbkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPs14u9C5PnDNCcpSB5LvXRxZzMijjty2V6mqgRFGWWIYofdOH
	dIjtfTiIUXuN2j1zpUySXPcy8Ks0JFPerF22QmsGA5Tw2XY4+McRlmvk05K/cliA2rEitQbADvr
	35nbf
X-Gm-Gg: ASbGncsJa5FuTxnoOdxaLEmOUWoR3bI89zwX4oB7U1Buo2ZyWnL493xwto066Ty39tF
	pjILZlNQ96AyfB1mi3qs2GYNKJfRIgPdiuAw6TcwOrKPPrFMx005ISw4cYBfJ7a9wZdzHyCwAX9
	m7Aqlvluyd9FLYrmE5vH1FF8DFB3deTl9VDb6xbNPs3WVbB4Cn6MugQe2Fe1HYceqTN/ivsIkO1
	wyVzbVOmXYTTSsQwypmkTFsrYjar5/u/sdWyKnTTL+cgyWk+2eBbswQ0hHnH2ZIYjZptj01y6tn
	XFvWMpL2eekJJBD4lLVNBMbdXhKEag9RTH7+R4EqomclATYzq0iI9dY+rYZLrcbXbHE1s2kvNHy
	V94nwwhJGzmMWm6mW/QDEm5UdBTajCF7N8Fl0Je8oDu67QPuopWB7Qpd8VOF9QTNC+DFhhZHTNG
	QuB1XkQXu8w0q41WalpIzr
X-Google-Smtp-Source: AGHT+IEnayHPbaY6SjxO0Lnzit9Wm5g29qzB2gGaxhiaHjbnjOsf9eFfiEs5FI9Ij3D8BfOJxLc4FQ==
X-Received: by 2002:a05:6000:2484:b0:428:3c4f:2c40 with SMTP id ffacd0b85a97d-429b4ca3df5mr820876f8f.56.1761771534983;
        Wed, 29 Oct 2025 13:58:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952ca569sm27596082f8f.12.2025.10.29.13.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 13:58:54 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Michael Riesch <michael.riesch@collabora.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251001-t28cp45tn89-fix-v2-1-67fe8e3046ca@collabora.com>
References: <20251001-t28cp45tn89-fix-v2-1-67fe8e3046ca@collabora.com>
Subject: Re: [PATCH v2] drm/panel: sitronix-st7789v: fix sync flags for
 t28cp45tn89
Message-Id: <176177153417.2036161.16223414447101207716.b4-ty@linaro.org>
Date: Wed, 29 Oct 2025 21:58:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

Hi,

On Wed, 01 Oct 2025 01:59:42 +0200, Sebastian Reichel wrote:
> I planned to set the polarity of horizontal and vertical sync, but
> accidentally described vertical sync twice with different polarity
> instead.
> 
> Note, that there is no functional change, because the driver only
> makes use of DRM_MODE_FLAG_P[HV]SYNC to divert from the default
> active-low polarity.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/panel: sitronix-st7789v: fix sync flags for t28cp45tn89
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/056d76f7cb9fa68c8bbf85b4055aeb84af6139d5

-- 
Neil


