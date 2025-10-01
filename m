Return-Path: <linux-kernel+bounces-838527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E3BBAF657
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276F319219F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A256826CE37;
	Wed,  1 Oct 2025 07:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FfaDakch"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F036238D42
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303469; cv=none; b=NfEv5U0jb5LiTpwEbleNHqJUNn3kuxqgMJPFwakeGkgcRgZ1hmnVKXmnt5LAr/MQ4S5fmzhBOmKx4ihbP0nLqJABEvRkbfTKs+DfiddJ/+MUtEo9+Jvls114H9BIELkPF4SaPINTlqM2JQXySXl5GkBvZlQSJ/XVURNgbXtCu6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303469; c=relaxed/simple;
	bh=kBDp6gp7cB+TVpa/upMsL1ZsdFKVPjo6pPGY0xAhR/Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UeNd7iDZKyq9pELF2lwTMyx73d4ihzzcTNciKuPVl3zUj3N1LdXgxq/2Q3t3zNjDC7Bqb1/N2yQC5UoKgaKAU3//joSkC/Ak99jqSfup1YaXxGL5dF5MmVZ2eWk5GMHPXg8+J6oT4kABfxhL/jmP9pUK2l6HmjiT3kfrG1Duy9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FfaDakch; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso41156045e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 00:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759303465; x=1759908265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JtxRzMZeL9v17nXRs0wb3R8qd1EOkfb8vMoEKaK0eQ=;
        b=FfaDakcht9hSFYCXNoMKBG+QPboW/B/Vc6F5DEOL0ddUuW9PsOFD2Qy/xErzHjv49V
         WOdKi5VX9fZXF1Euj8PVx5WDqJxvpXh+BpxcMtox/fwHGwnHnZ+2Hit1+sXwC0S9gA75
         jJY9RiHRzKkuXY/yAmmgqp+A7vQSZ2Fh8pD0Th2s2LyZRxb2euVgIUR00+t253uM3zdF
         Ughrgh4QocrzBSplbWQT3Hc1r7YGvPpi5r0Z5iWgzLEvr6Xcwl9GTfhpqkN1j6/xF+mY
         IkbYgwoGD7wyqnOb6fAtziN79+LoQ8MTjHVSaKUD+o/2ZEm0qzG/PV5WZhhJam7seLgx
         S3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759303465; x=1759908265;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JtxRzMZeL9v17nXRs0wb3R8qd1EOkfb8vMoEKaK0eQ=;
        b=IJ4H0lkkp5lO49MRn5Fgbw6wRuZviaBSvegrihAkVAyjq7jL9VjwlAVoy4O1R4569L
         Wl59o8KFwcDvmbtD1vSWZvJja7Cbf3FXORqYvF7w9ol6tqu4ACYANwpsitpDJCjS+fXl
         ZNy/Gr7vPoOdGY4TGXmK87E+Yf2SGYf4VRnlvopOgR2+F/Blf/cola2bpziF9hG7BVCv
         fA9M7E8lLOcpk7v4IEA4tmWFksatEl7eapvCtvEUGaKl8Wf8W5OAyG3MMxKIFf7gPJg3
         1TnE2+4nOAk/o/TmNQigZiglwOw/sR+vMFE1HyHbOsM1iCZFnIW53m9tSJYVLBuI/Wmc
         dSNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6/i+SBZ6W/jnoz5LmZIalwAEMMaPqkshI/usqTkbsWrn4qmS4iZ/kX/0i6aEqqCwkq4lpV8klz4w58rs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6KsmB7vPP6Ohwc8Q/pqGWuUrf3NXtFPMnIObmsUxpMjSql5S6
	P+tL0EUjL151E/gxd1Qa+NHkL+jzZW+wqOlsbyx8A0IshZPpBWH4bgsdmDMJifD6w4c=
X-Gm-Gg: ASbGncslzlsFPLn7sy0YjLXhDAtLWnvNpYhcet1hawlFXTl+8ybd/5ROuI8B90Ba7pr
	/ZUlNR4JgKYh9NF4h0XFnSJlGHskKt/6gSA4mlbZR7+aYnmalwERSCvbnuLRTJcEPbTjNsWbrBD
	yYP0Zr0ZBM6In0ij8AbAP90lKbziSC/tt4ZTxyK3xr0ieM/R22+s70//23R/Rgq8NJmDv34DS5W
	gqNtS98U5zysKuKvjAL7JMJVDDAj0a/2fY1j/fl67oH6MQLuzKRKu/FCnygeKu30fezKDCPrq05
	QQBVcTUXyz9djjmehZLMdI4frmyg6bvTMhbxRDRKFmIjXjxwZaRDKilaVmVPpf4oErotm7Q5okJ
	nS0IKkdU84yrdYr+9JqZnp0m6XpDS4CEfudn7hJk/aGyIOHnyRhin1ZyMa1MCkF5+GVE=
X-Google-Smtp-Source: AGHT+IE6yluUbRPj1Xf82URTt49n1XA+WrKyrXfFL4dmGKEG9ksoSO6w24jNnMA9btnzpoe9DeDppw==
X-Received: by 2002:a05:600c:3b08:b0:46e:4704:b01e with SMTP id 5b1f17b1804b1-46e612652d1mr22649105e9.8.1759303465411;
        Wed, 01 Oct 2025 00:24:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-410f2007372sm25047153f8f.16.2025.10.01.00.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 00:24:25 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250919153839.236241-1-clamor95@gmail.com>
References: <20250919153839.236241-1-clamor95@gmail.com>
Subject: Re: [PATCH v3 0/2] DRM: panel: add support for Sharp LQ079L1SX01
 panel
Message-Id: <175930346477.470940.4121513970812142140.b4-ty@linaro.org>
Date: Wed, 01 Oct 2025 09:24:24 +0200
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

On Fri, 19 Sep 2025 18:38:37 +0300, Svyatoslav Ryhel wrote:
> Sharp LQ079L1SX01 panel is a LCD panel working in dual video mode found in
> Xiaomi Mi Pad (A0101).
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: document Sharp LQ079L1SX01 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/16c5b1a63623da251ae842b45fe10263d33bf71c
[2/2] gpu/drm: panel: Add Sharp LQ079L1SX01 panel support
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/306e6407ed96ca3dcae5e3dbec8cf207ea33fbee

-- 
Neil


