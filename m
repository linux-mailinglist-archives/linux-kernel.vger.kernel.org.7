Return-Path: <linux-kernel+bounces-878549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574C6C20FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2256C189FAAD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8535B3644B2;
	Thu, 30 Oct 2025 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gy+77v1p"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6A2274FDB
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838507; cv=none; b=S571TiNQu2S10dRQoic/GEaNDXrah46GpBi/sGqc0hwobm84vbduhmptzp+NTcyG8wf9GsSTMARboe0gFLED8AbAerDLKcLZ1mNaDfloDacqNXs+o37uMSWdv+5714CZnoSc+duBXmIM4gCAMi2iWaEsGFHZ/ntP2+/WS2FW/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838507; c=relaxed/simple;
	bh=ACjwdk8FrhEdulai0ptYpIj2Vc0V/QYCTmXFcLn6jp0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IouWqBXMS3BC2AoXgc0f1sN713tOxfHVJLk2D+moy/7pl7nwshdjQ+jACHu9ygIqZ1xrOIbJexNxOUyTdb2P9ep0tNWuw6bLDYXKEOvKdrwZM0QyUMv54XfeoL2SQbBUeeZUQgU8KBFPq8+adWHvoLlTjE9RsXJLNqyTW09Mv+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gy+77v1p; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso15940845e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761838504; x=1762443304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMjHugVum7QNRx23N0Xydg5pEWW7JC7mvFaBCaZk2OI=;
        b=Gy+77v1pGDeLaMD9SKAtgH+F1xq1VuVufnnHwSVUi2tF16KeAo8xwkmfNg9/xKHFLE
         DFRRPKPapq06XS+9GD+9nkYAprWjT4baZ9qUDKwY80zk2xhlPp0qjwFHxhtujMFOhdBv
         nEnjVfIjCbZQ2UGYPVzxB0mYsI18fhtN4KdZ01S0w9lOENNlbLZOioGAUbYQntrGdDAP
         s5jw6ZMpA2mexFGV7va6e0ysWZNJWaUgPyzQNCZEkyAp37LuiF5RmFtJyRAdgXNc53Bm
         BQebyHU03YBdJ0GHXXls/YyybCszDQbl9gWliyFAY6H4iH2zgZHMPsUfAWEeUrIQ3D4P
         b7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761838504; x=1762443304;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMjHugVum7QNRx23N0Xydg5pEWW7JC7mvFaBCaZk2OI=;
        b=r99Qc5Jy//tz4Nidq6xtZ+3lxLoKETKvyarw3sX8MTapnGoKIGwoReOwx6eiA9vFNI
         ML2vL+1nSLAomJNTUp2ZJy+nWHFryDFX7wAVUU2DtgKLg7Y//dfzSKKj6AHFRI9jZgeR
         AQJdxdpzrM2vVNfwTKIJDohQoqgE2ES8QmYjbzej3LMH02f+S6zzRnAXbkyON3d4SKeB
         uDLDHW0MBF1X5LFlC2M+tqlvhCNM7rl6cASx5X6IXViH5L828Pn40urzxv7dlU5gybpM
         41zVo5uPFoRiwli8gboXMpctm+NFXhcmE0ZM/fwZ030QrLJl2CK+KjeVw24d4442uGrs
         kJPA==
X-Forwarded-Encrypted: i=1; AJvYcCUJuI5OqkBv8s1SEvTOD3PfjqPdzYUpMshkQSPX6a64nEooomdvieGJAo7RMYdTAdTN80a2g4JDqaUdzs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY6WcTV6xUjcvZIgCN3vQD7RBgB11ZOmGhfcuoJ29/8/R3F/xP
	4XFUcICAPsM6I6O0a2K871qtS5CjhEU2VxU/h5yup8cLcSQJsxwwVCk9GIX0Ze7sKzU=
X-Gm-Gg: ASbGncv9dLff4srtG+98xl86MYAZd0pWQrkTrl6+MPVbH21uUy/6tZl3W6BLYqzhqyJ
	kZZLawHsqfkkc9P1NvC4waLZ3DaAjx8FCQ7I2o4iD6o6phZTHsjVomm2+pmZ8RuSI2d2OpzSDlh
	4IW5b6g3FAEdbI+TUBIsvOA93Q7QubuuSOWWLOow6WP1UZqyeT3TuXUnDnKI5iNp5jH0gSt9XjJ
	Vi+/Fdw3Xcg9UJVTT5xYd2Z8v0JEs+f5Tgjl+vf1A9/VXKhwE5+977Ws/SlzWa0mnHPrVJ2H7OM
	YtOT7l6Qyx6ryV0IHuX1dK+cMtRKoDJkylkKBrFQd9jY8dMdFsR5ftqsUAeTbhXn4i2BQCKZbfU
	LYEjDVhC8cYAT3jCGo8am2WpjD5rvc3sqzuvt6Ip3BTphnH5VwhgBAXz6hgSoRJf2w0/G0T/Ssf
	iBfiOpwIzf+loBWW8jySJmMw/e0Cz0p5o=
X-Google-Smtp-Source: AGHT+IHZeYrq8+mRtX1lTeY4B5rTgJhAiC8nhVTLREWZuzfET2A3NjWN8gRpSGrW1jSySlURYEGMqA==
X-Received: by 2002:a05:600c:a08:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-477308c9355mr946125e9.27.1761838504411;
        Thu, 30 Oct 2025 08:35:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a7csm32976206f8f.8.2025.10.30.08.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:35:04 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20251030-topic-drm-fix-panel-synaptics-tddi-v1-1-206519d246e8@linaro.org>
References: <20251030-topic-drm-fix-panel-synaptics-tddi-v1-1-206519d246e8@linaro.org>
Subject: Re: [PATCH] drm/panel: synaptics-tddi: fix build error by missing
 regulator/consumer.h include
Message-Id: <176183850374.52027.4493661188023999045.b4-ty@linaro.org>
Date: Thu, 30 Oct 2025 16:35:03 +0100
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

On Thu, 30 Oct 2025 09:28:28 +0100, Neil Armstrong wrote:
> Fix up for "backlight: Do not include <linux/fb.h> in header file"
> interacting with [1] from the drm-misc tree.
> 
> [1] commit 3eae82503f4f ("drm: panel: add support for Synaptics TDDI series DSI panels")
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: synaptics-tddi: fix build error by missing regulator/consumer.h include
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/66610c08e954e6a995c2504934e54f8945f9ee49

-- 
Neil


