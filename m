Return-Path: <linux-kernel+bounces-838515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A173BAF5CE
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E52B7AFF21
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B71C26FA67;
	Wed,  1 Oct 2025 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhAH5Zc/"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7559126B2CE
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759302788; cv=none; b=UCXJ1GxA4CxmOkM3lM/r5aMAG8Ba17l4B2QBNPXeOoyGJFo01NMP1xq7fqnCvEKZyvUvHoCh38f1jbmETNLDVFARkK/jXMqiPAAvxYPiepxC8skDH34bVZAxZfmM3Qz4C5tJ1OsPi2F4xZR5qfFL8drR+B1fNC7KSrVCf8mX0sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759302788; c=relaxed/simple;
	bh=gn606qEqm2hshhJbXSi61+2qare/jJSVfuZCykBiNeQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DCDO8LpHbCh1b4OCdSPFIVKES++KRHyzt36V2byInlqDVWH7jFwsz1OtSZkRUtJynC6HHLGuzukBqKJ6MsbPd+5CKSBbGXkpsSVohdjaVN1B+3SACs0ByAnKsz+Q/Q1ZIrBhJDhHYVm18yr0EOmeEc/bhMjNyOQLTScJJEOCxkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OhAH5Zc/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso44985275e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 00:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759302785; x=1759907585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFPDhYu4aFFhwsNO2KIFrINwTJBQ61Ce1m0mUZPP1Mc=;
        b=OhAH5Zc/lfBx/Op0utLg2RpHqw+rWxAsNal1JeHmzXKfzyMQhXtiolQY0q3p2j+MOP
         Dprs/RtNlcvnd7PbOOMtc4aZ3hZrPzumHxlSXHS0xjp9bCnxgmn+HU0W4Nh/AjsWZhWy
         +1u2J+MHQJiRR7hAsO9KRJ32zPWfk+Jofygf8acy10l9x82HN5617MNsfcXrNYu61HEc
         8XnteFB/2Sa3pRatb8WueI8O72aChEuW7rljAYnQr24zpkl2yFAEBPemcJNSH+mpqo6i
         gEKfe1Z9rjNQpXucX5zBkxi5hRaSdtSzqATw3L9uMTER3obx5HI3hVlsYmKilz875DwP
         rY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759302785; x=1759907585;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFPDhYu4aFFhwsNO2KIFrINwTJBQ61Ce1m0mUZPP1Mc=;
        b=epmqheXXcbV3bq9bnJgDKsfpqPEIgvdDsJYMIRcOKMEtk7a8jCInSXOMZSGzRwqS55
         IqdNzFjszQTXKGdDESEWqEQDeGAcJWMBaqmHfSVtCQwn/VJrpkZqNw8h5uj7BSL6jT+8
         LENpwqCmqTnyEmKzov+NFFLR8OSmIxdy+p59asn1ViwAH+Aecldd6cPpZZwxicWaawon
         bAHqlcPHUz9DGTYRvCBrDOEf0cygRS/LLdia5t1w4K9ciw5vID7qRPRWVMj0asNoizHd
         lAdx2JAPZQ+TIHmk3GT4F1gLZ/p1yjjwucggN7XonnafHvZHJl9Q0E5B6J3FSav18IBf
         bQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo2sYSBRo4QgqsfL9G0Rij/ptTWuQU+GCUhVJNQKkD5cpkQw4+4U/QRyuqzVP35s9ObKQNGEJzQS3ly08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOpI1SH6rAzvYRSsVjgWw9F5A7bB7UHCfT4QevtVVXkIhkdD1k
	A2DcF8hIOG9Q72EnPKfY+Ly2GOtj1J1nX9VjgXEqXXd/9XWhemqcLjUwlLgW+Jg82/4=
X-Gm-Gg: ASbGncvLzm+wEBelVkqrbDjOUwNOcr9cl0Kf7xllF/4OR3cp0YzFX5unbFDJDIsN9LR
	FmTVi99YCYzBWA9TFoBPchsM0HQkFGM5Xm3t5q421wif/kwQvzb/03WtpoGajeSxoOIL+L+PnOm
	RfwU6K5nopiCjFrXGo8XFw4CNUPqFL+gWSwf0uPWKS2bfNMmwak+6KTZJ0zapjaKnpubaJq8cZX
	nExoWQcIy7ZkGoxOjvTp5Ar5p3vOeBaVkXp1Eq+t0QGVPX0IFW/bUXd4Bb1l1rb+K50+APRFZzn
	gp0tHLPkZyQLI9LBbhUGCOeDo2mmp6iCvHjj5bp3NG2PZvvZKQBgFMnst4e0xC2HJMUNsqfnP8P
	F8Aq+SRYsWz5oxorsdSc0EQUfKOm7EGXmCgnrn0razt09qHm9FokiG+kzVfg542wb5nY=
X-Google-Smtp-Source: AGHT+IEJybYivB1tDKi+V+W73mq1doiRwwO2NMKjXDaYOQiM4qmPaqdgd0jKteaSLsSgV9Peoc95Ww==
X-Received: by 2002:a05:600c:c162:b0:46e:37a4:d003 with SMTP id 5b1f17b1804b1-46e61202096mr20188025e9.8.1759302784682;
        Wed, 01 Oct 2025 00:13:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b36f9sm25077355e9.19.2025.10.01.00.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 00:13:04 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v1-0-b492ef807d12@pengutronix.de>
References: <20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v1-0-b492ef807d12@pengutronix.de>
Subject: Re: (subset) [PATCH 0/5] arm64: dts: imx8mp-skov: add new 10"
 variant
Message-Id: <175930278378.421667.15230947171150357707.b4-ty@linaro.org>
Date: Wed, 01 Oct 2025 09:13:03 +0200
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

On Thu, 21 Aug 2025 09:55:27 +0200, Steffen Trumtrar wrote:
> Add a new board variant for the Skov i.MX8MP based family of boards.
> 
> This variant uses a different 10" panel than the existing ones.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/5] dt-bindings: vendor-prefixes: Add JuTouch Technology Co, Ltd
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e3579cd78ed9945606d281be16708037eaa12c49
[2/5] dt-bindings: display: simple: Add JuTouch JT101TM023 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/510aeefc7c362c1dca57d0d3892fca07d4455141
[3/5] drm/panel: simple: add JuTouch JT101TM023
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/73bd4835f84b5f78d65f37bc97c764cb90501299

-- 
Neil


