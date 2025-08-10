Return-Path: <linux-kernel+bounces-761557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F31AB1FBC5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 20:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685C3189530D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 18:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0B51FA272;
	Sun, 10 Aug 2025 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oA3TPUAz"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D77E1F1537
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754851973; cv=none; b=GqvPRvp2Q1KICS48NPfGMpczBpSnOAFpoK3JjKJ8kxQ9DBhWEHrDT6nExD6D2E+Q19dzwcvZ2z7kwYQ10Fh3HPNRw0dd15j9Z7a6qHEKiobMpbKyt8b/vi1mLZ1Sj7GidOy21pb1RY/Z33pBJYusD6cEK0B9U6wibUUgDsJNawc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754851973; c=relaxed/simple;
	bh=dRZXfj9LhZMEywUBc7ebwIDMm4+bg+qctwAOluXIk/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jzN4jJvVr10DlszKOXHD591kS5JLhpc/x3ujZ9SwWSZ5Yv4KEnzggGpna1a85Cn78LzppGdjs9WwgfbzuN+nBQdHWRkBGbjLeYucRTmiStGjt9Ic9eCtcK41qM5xGCDiW2LqLyvP8PgFkx1qZvY1VGcszZyzbTyErNBflUQxrJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oA3TPUAz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d3f72391so29134905e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 11:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754851970; x=1755456770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=usyaukZJ8v2Y8S8vh0sfNK3CloCXi6WSzcXm4cRl3cI=;
        b=oA3TPUAzBw/EqnTQx97GTVhy3K4ewX+jy2Q9LHGzSaVmn4/T+FXSIyZIqTexb4YYSO
         5jSsbur6y4vjOvW42EZtVTM0PisqF3/d6d3Fy0tam/87tkalXaVYlJnbtEFByV1pyTxt
         8Qv/7HtUSHB0+ios0K3ywk2403OXUxBRXe/1IMzONHs4L6SxqUt4X7+v5B2oYa7ZhpWE
         32YZoGCtBZGgC8Y2HX9iifGWRygSC3st9FP2JdrXHqC6KHsDHoNaSID28TH8z3+6IK/D
         o3ASKCbcLJ0QSrH8DDRjXczanyudlBV5bvWxmnpgKg17nlCjbr23o8c+jPBJZYBlccju
         dtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754851970; x=1755456770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usyaukZJ8v2Y8S8vh0sfNK3CloCXi6WSzcXm4cRl3cI=;
        b=Zu+hA6rwGVVThDOw8hVKwOeO+9NWleE1LZwBasJRWgCD45rqbQ3TNaWZypYByodcZ7
         VoMscNnePd/QR61MnXHfwmTSNUpAD1SrNxa5WChRyqbYJOGYr/XV/QvnWBY0hxiZsXm4
         nHXnfEw1gnBKPoW6tm/rajkdklkmJY5Pla1iQk63Jqj7xWC659/8+0hLBDu95lpv6Qln
         PywbwAKdNRdLrkWqfkKc7ZbavXDF9hddGL5xt6lN1qfEW1FIlmC0F61JLKnEnxq/hISK
         HT8PPfk0g4kJ3FCIyEXEM1KtMARtbGpD9Z2VkMX1Uxw9GLVO2bVn7kU3gRrvwhtGOcBX
         M+DA==
X-Forwarded-Encrypted: i=1; AJvYcCUSHe/A/cTvJL4jX5ZMmMvjAfsNS8E4hs6lzqqLYyvuj8cGujCF4MvQWZ0+PwOW6HqxhKx0gq3iUdg3qdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAdxnkKiBodHh8nwVkpW48oIK+RatHrokw8z3m0Wn00cM5ArW5
	S5TjA9qSCBUwwUjEN4AF+vNWNEqtg7WtqxaRVqrJrIsMAxqBr+G7GxPeuiEsiUlJiwg=
X-Gm-Gg: ASbGncuzuJ9RxEUdvzhCJKjlMT/AXvnwgXnKuk1Mxm2TdxrW7/hT89Qdg7lJBWdNbSe
	bOihynC7j3ZetIVH1v1j4G45ipiWSbpmx/PoIMbqyGGNSGW5+ju/wwEBbyA7CenEOfgIf+QxdEJ
	0LY7AWxCHayodKAV0kDU6y/fhKHbcgdN1XpbOa+hdDuijBISZvdLq92jPhpwH5nq7P1J+1mfxQG
	CzbhSxR0+JUYhSL5A//SMY0Ma5cHwx7N2A9yJlF0EaaiDRziWAEFfWPw+v43Vv7wJGIx5pYyuwE
	8Wt0riw3Bp8ykKf+0SMXoq7DX/Bb3PiOIuggBuDoZO7TH8xJMAZ/dy5fmTJLzsfqqAyVzCKognv
	BMDeG+SdaV1HnUsU4XXpD+bNaB0zJjTnz5cgFRJewDQ6W/rgGZG35S79Tzio=
X-Google-Smtp-Source: AGHT+IFeTAPP7suUMfpcy6xs18xcCXvs6tFgkRdUdcK+N3WIVE5vhGpvbw+GdxaOl6/QKV6UOXPNGg==
X-Received: by 2002:a05:600c:a03:b0:458:a7b5:9f6c with SMTP id 5b1f17b1804b1-459f4eb4d05mr88238015e9.11.1754851970069;
        Sun, 10 Aug 2025 11:52:50 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed07fsm319461145e9.22.2025.08.10.11.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 11:52:49 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi.Procopciuc@nxp.com,
	s32@nxp.com
Subject: [PATCH v1 0/2] Add the s32g2 and s32g3 FTM PWM support
Date: Sun, 10 Aug 2025 20:52:16 +0200
Message-ID: <20250810185221.2767567-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NXP Automotive platform s32g2 and s32g3 have on their board a
FlexTimer (FTM) dedicated for the PWM. The same IP is found on the
Freescale Vybrid Family and the i.MX8 SoCs. However, there is a small
difference with some registers not available on the s32g2/3 and 6
channels instead of 8.

These two patches provide the DT bindings for the s32g2/3 compatible
strings and the code to deal with the FTM difference.

Daniel Lezcano (1):
  dt: bindings: fsl,vf610-ftm-pwm: Add compatible for s32g2 and s32g3

Ghennadi Procopciuc (1):
  pwm: Add the S32G support in the Freescale FTM driver

 .../bindings/pwm/fsl,vf610-ftm-pwm.yaml       | 11 +++--
 drivers/pwm/pwm-fsl-ftm.c                     | 42 ++++++++++++++++++-
 2 files changed, 48 insertions(+), 5 deletions(-)

-- 
2.43.0


