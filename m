Return-Path: <linux-kernel+bounces-831581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B529B9D109
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE0A3B39ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213B82DECB0;
	Thu, 25 Sep 2025 01:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1NJ6lpC"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE625487A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758765081; cv=none; b=fQLbhg3hmTwfwfeMcMdZbRA5IXMyYnhGyzp41TfrRYvBfTTaCYar6kXgN/TfmGD6LPo00dKcjYJnSi5J+2jNYWvA1xwB9qnJ3cizuovV5gwLwtNnHJtN2ffWzYZugeCq4QeJ767oXyDcE0p6qL7KJKqj54MyqWMr/AgHTbjvr5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758765081; c=relaxed/simple;
	bh=VPvf+9My4UQ/FuCUg+veLFmw+9nyXEfen3vOShwm/QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krZNTq8bqru4VjaVb4BfaMAOpVrAYC2Abg2TXatILnBpyG8p5xXL0HuaZCpVy+pOWjux+GPaoewB50A1H08qSjmaE9IOmfnqMkkOZvdP59Pwa3JX7FA/lVIM5kj37nBW+H/E5hJCl9OGNDHaW8SYcJKerrOmc5cN+4RFL4rnZEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1NJ6lpC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24498e93b8fso875795ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758765079; x=1759369879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wylch9loNlrlm/gdqX++SpQPAdfvuaHRHNeZw5G58hI=;
        b=f1NJ6lpCgM5VZJ6ZsNdts4mZr89dVBEzZqr9YZwbrQ8srt9aGJ11L0wBeqXDgaJWsq
         GbxedGS9uOA9KvPTBIoGDdm7kCWpP4bDIyBSlyo4b0kUBIhC7Ug9TFrhNEAz3+tbrM+s
         zYpiXU5faGCXHt2URdt1OZgyqIbU/mP+UkETn8Xv5lmmH6uiEoqGAAFQm62PbIb6moeC
         ahgKNJq95aBQtYCJWw8gyMIJTAOAA9GYQkSwVZQ9uplBlsIOjsCf3HHZUcwKGnoL40Xj
         uLkplJ/WVup8j10JJoIGNydM4pUEYffh72dM9qVhJsbKDPksOelSyAwWMJ9JiEBs5HKz
         uCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758765079; x=1759369879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wylch9loNlrlm/gdqX++SpQPAdfvuaHRHNeZw5G58hI=;
        b=qbGhIDrskxFEjWLndHbjm0aOmebB4qhL12xJvNreJT1p1aK9vGCkiumNQv2m1FVjxM
         hFDf8POkN6s2mvwTFHjRoZuvLB8p3d8XeUbqzkbj7GcVlhkFkhHEo7ndc/f02VhG/JrB
         6K4mcfnTcjfB0MiLlLih1rzOzs/M4ITrrdKSGbaHRj83dMwSflS3kQjsYtVwpo6ae7M1
         1397p3P6wG54LAfYcyG+xyyWKK5eWNv6aSkuSjcPZXF+rd2G7IIk95LbvHn0YUcGv0Yz
         I0/DmADu20/mdIrixjsPBQaQVdUOerbZF9GPGVKCHx6MaDeaoYycXQ9UOvHZ+nxZxhxv
         WblQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuYcX06DUYFHOze/khwSVhm0odyN1ZuHVazGOOxMoVq47+iGeTXyJLA71pZcqcTaf1eHcxkmwyUJ6m0d4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4kUVR+Sl2DiKpFElatkjIDoHUpwA5iQcE6GTSGgY4PIRMR6pK
	4PG2zagAzoluNPdGMz/ZXjqELNkHNvpB7QgMClr83g9Sh0ODnxfh7P/M
X-Gm-Gg: ASbGncsljxnVJ7jPAOCcY3LCzuqyVgnVtVLpMs1e2W197l0YM5oEoYZsKkHyt+rLLj2
	rglBQNuzIyY51Kx1sIghhbb9svmXhXHcVa0tH0znGijeb8rMwRnIQrtNodI+mofxYId2IeeeZqg
	VUT1KxCVVm7jEfSbXnoBX/1iL2ML/Chx2pdTKUZTDqMPSh4PsyhZGnPC6GVlXRqleSVT193BOcD
	3FTde8MpWKc/4zbylfxQYAsuKfFFoGN70fIHLv2LfCZYOSXNnz0S7rllCk0rr6qFOy1Ne0yYgOo
	yyvKDn5gnE8LCTuCbFvU2tDsJf9LgmB/1ZUxSo0RDuoivG0+FEAH7WnIP69SrfetSt+W5EnKd/4
	CSZ2aP6cmbl6rndkDnXceYcItv6qw13r+o5dP
X-Google-Smtp-Source: AGHT+IHZMt3s05k7yF2B8bpN39GlF03OcYjt5vMVEDXyJVmJ8V3q7J99e2MFEqR2RprtgIinmW0n+w==
X-Received: by 2002:a17:902:dacb:b0:277:c230:bfb4 with SMTP id d9443c01a7336-27ed49d5fe1mr11369745ad.3.1758765079211;
        Wed, 24 Sep 2025 18:51:19 -0700 (PDT)
Received: from rock-5b.. ([27.17.240.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6adaf31sm6514825ad.145.2025.09.24.18.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 18:51:18 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: dmitry.baryshkov@oss.qualcomm.com
Cc: airlied@gmail.com,
	broonie@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujianfeng1994@gmail.com,
	lumag@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	quic_abhinavk@quicinc.com,
	simona@ffwll.ch,
	sophon@radxa.com,
	tzimmermann@suse.de
Subject: Re: [PATCH] drm/display: add hw_params callback function to drm_connector_hdmi_audio_ops
Date: Thu, 25 Sep 2025 09:51:12 +0800
Message-ID: <20250925015112.19499-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <zopgbudg67lygconkv3bl43xogzl6rncif7wdpclbyc4wblan2@n7v75dbnaqqd>
References: <zopgbudg67lygconkv3bl43xogzl6rncif7wdpclbyc4wblan2@n7v75dbnaqqd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On 2025-09-24 20:17 UTC, Dmitry Baryshkov wrote:
>> msm_dp_audio_prepare is not called because hdmi-codec driver only checks
>> and runs hw_params. This commit will add hw_params callback function
>> same as drm_connector_hdmi_audio_prepare, so that hdmi-codec driver can
>> work with userspace alsa.
>
>I think something is wrong here. The prepare callback also should be
>called. Is it that the prepare callback is called too late?

I have added debug log to hdmi_codec_hw_params() and hdmi_codec_prepare(),
but only logs from hdmi_codec_hw_params() are printed without this patch.
After applying this patch, hdmi_codec_prepare() is called after
hdmi_codec_hw_params():

[   14.218445] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
[   14.223004] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_prepare() started
[   14.534614] msm_dpu ae01000.display-controller: [drm:adreno_request_fw] loaded qcom/a660_gmu.bin from new location
[   14.535750] [drm] Loaded GMU firmware v3.1.10
[   15.727443] rfkill: input handler disabled
[   42.647157] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
[   42.656774] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_prepare() started

Best regards,
Jianfeng

