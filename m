Return-Path: <linux-kernel+bounces-875808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E60C6C19DC0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A812567249
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A12E2FA0ED;
	Wed, 29 Oct 2025 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="R2PZTCn8"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4172FDC56
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734524; cv=none; b=XCCAKUN01lENjCTrGGE+z1uBWpPXlcin2gjSoTFMLyQzTyCTdLAr+W1Cj9CQxWegKPYXF88ylTr1BVK9CNRt2yvqliAO4Wuan138f8yrp25SN55hYoZwLrGwzsk5OnyI9fCCfC3xEfGCSM2TjWPv2FU4ni+wTBbCkpiZM9hiJqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734524; c=relaxed/simple;
	bh=AUDqFfVw/6OEV65Z6YZ8rdLCW3TA1z/nedV4oyotdPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tImAZ7guGcUdIOxhK0Tpa79fareGH8lXF31E9071KryN41B516zCoIlQFdIztc26Y3Rkn4QMxzLYQrxvT47fRjpQxe9UiB3D/Jk7FG4+YqZMbRoN/bjt/DxNTxT+WrheflZTptMkV40MiQKMvV7t0eGYf9iU4JcunqnahLMbnyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=R2PZTCn8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47109187c32so38816375e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761734520; x=1762339320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3X4E3hHQ4vm0fEjCZ5UPCa76r6tX7WxRSfwf39l4Uw=;
        b=R2PZTCn8Vxye1cwzPwcvsrc+w83i+sfM+Ny3gEMZoKT6XhJB9jY48Dkpb/LSg/QUvJ
         D6fpevYhbnAjX431AnxdDnZqyrq7XaDKwQTSRGdzzf7jsa83oGDJd42mQBvDcgHuX0nM
         IQPBqE5nju71NUNhZo+4kseVQTh0qsT58h5WlCUT7YF2OkR5x6F4olpRCQOvA38rw0Dl
         pqISNDaaE1oR7j4ji3PnAICgqdv0cckNx8n96Qa1jvM/FjYGb1f96RWaGPeeecO+0/Qt
         BV17vFTHxIQr0H4VQDeDTMZmaro4UVMmeWkIGG5aaq71LH4i1DBSWX7wMxI0GKqB01il
         Hq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761734520; x=1762339320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3X4E3hHQ4vm0fEjCZ5UPCa76r6tX7WxRSfwf39l4Uw=;
        b=MUJivhbYqpvddeCsf0wJLTw/+ouQ4DYKGtCu7+VHAq8miXukSzVQsiZmVDEAsxYusp
         ik79XJMxAkk5M+XqugnvLle9E7A8vpX5HtdnfBaTgt3F54UgqS/3N2XGjvB6AEyDWy1R
         y/9QJHbFEeg9R2CmGBvHnHlXZ89lEER/nSapLMEAm0mVZXc2fbTai+g14lvw2BGBNYsZ
         UAL89kM7HLZJvxXJ/R80FzcuNioHLMhbiPtoj+G6T0HGXYdfjJFoM7b/szPcgYSQ1B5g
         ZDAF/9URFqcgAMleutZ14St8//GGZEQRL9MnhkRlD4zCYH58aS5LBrVe+1lUI4a2Wkb1
         JeQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD1dVHkGJbRqSTEcTJWk4s4CIDoYnRWm2hhjBZt9JRhpb9iVnx2z+yJOFxr0JBoLbgHVnkrpu8Dftwn5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAIf8OLm3XXb6gDBHwGn4f8/qhbqahkWSHW1N+ARQcDep2kdNA
	A/MTAqgg0m3hYLhhy/tFEr2/I9JruwQk0IA+WxYx7Dggqfwzm+ImQZQn/Is7J0cm+I0=
X-Gm-Gg: ASbGncvOul98DlIJ84+xUJKpmwDmGK3ZTdOvAWXjmi6LFR6Sukpot/f/eyEDSAE6C8W
	q2SJOpKM7yx6FAt4draNA6xpl5srGxvlR0JmW0Y5qMZLhQ4VAvtDPOb91YDo4km5KOWSUXYiQPU
	dJQc1mI8j71RL0jfuurKCyBuPtE0+QCv3cJ+nctIQcxYxGok90g12ThsbIX5j0VN7GETtvxOKM4
	+WeG+iAxfFbRfU6D6VtMMO6LLor5v0vCh4aXWvXSAzW5JxaQa/Ln405mGqYAyb2X+LkLsPedJsg
	FywhIg41g9myE4WGBhz2ut5yISULmZItVifp5Dh8NLxDZcw68t3xKmXuLwy4ygcVblXFpiwjhGF
	EiCpYpkeaeRHPnhfibr6rl2NyDsuNNUeiht/OC9XGqhstla6/GdfDH+wvkPLEE7HlHiulrWuXp0
	Zc0VPb+hngCzrR
X-Google-Smtp-Source: AGHT+IEr0/AZFy2/29X+tk87HEM/p5Fa5fWpVSnd5/YgcWtERKefh8/xi2PyHwwU7M4yWjRk//ZiAA==
X-Received: by 2002:a05:600c:3e07:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4771e3fbdcemr21558395e9.33.1761734520102;
        Wed, 29 Oct 2025 03:42:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7ce1sm25165417f8f.0.2025.10.29.03.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:41:59 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Luca Weiss <luca@lucaweiss.eu>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/7] Camera I2C (CCI) enablement on MSM8953 and Fairphone 3
Date: Wed, 29 Oct 2025 11:41:58 +0100
Message-ID: <176173451403.17889.9951642355826230455.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028-msm8953-cci-v2-0-b5f9f7135326@lucaweiss.eu>
References: <20251028-msm8953-cci-v2-0-b5f9f7135326@lucaweiss.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 28 Oct 2025 17:40:45 +0100, Luca Weiss wrote:
> Add the compatibles and config for CCI on MSM8953, then enable these I2C
> busses on Fairphone 3 and configure the EEPROM found with one of the
> camera modules.
> 
> 

Applied, thanks!

[3/7] dt-bindings: eeprom: at24: Add compatible for Belling BL24S64
      https://git.kernel.org/brgl/linux/c/aef72ebe9c86b516c6e126d4b453c96496547f0b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

