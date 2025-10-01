Return-Path: <linux-kernel+bounces-838524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59835BAF62A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B084519218C6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A802264CD;
	Wed,  1 Oct 2025 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jc5UkhwI"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBF1266B6F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303411; cv=none; b=EcX3t4QeButR8BlOSGV/YF2iPjyT46eWUMIBrRQDjDTUt0VjI7/cdpUQsE7iPLUaKHZy09DeFJKIiiL0cldoSmjPyv7HH5i97wGB4K7iE1jUUSxjoxqNlri1v6yIebdbxOrialMFHtsVmdArDjTP4PMhnfPbnRA2cMezIHtrQmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303411; c=relaxed/simple;
	bh=ODbG9WzeoLx/6ugRts/m/SSUBmtDfSaE4U9IGSKKjf0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UF7pawBvPODqYDyvwU6Z/aSVWzgJnXar8gTvKxXlAsS4gL+X8rx6uNA04yX1uCI2h/b4FwjYO0YcpccY1X6pnhy1c7TE7Vo6Q+7FU3/UsP+L8/KxQsHZPcyBfuCBy5+b6OsgVNSw11PBAHLeUn7s4fatSvZJgb873nx6Lywkgmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jc5UkhwI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e430494ccso31680145e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 00:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759303408; x=1759908208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9KnLYLMgAo6iCMaJHkFXrrPXMlbYFJ8tsuzyv/2Xns=;
        b=Jc5UkhwIbB5wTUf+BPaCTOaYk8MUqwvYdz7j36zIDPNVOpEbAIogc8Z8kCC88lJuxY
         qRR/hmGo6VAJKFGy98AqvlVWzunYj2MqRu2d4oyx8VR6Sxr4bZtegrwE1CnHcVvFJmJI
         oYuEUej1ID33apTybNUSKT60mxV6Cwo6maNBjAWSYmTHQHsK7kn13kaEkLMoDyWKFmPj
         HlrslSb3lwUQxFdvTrqgDwyhRIxkcoVyNyCn+cx8iVCn8IoTG9TlX5V/N/yZNuziLcMt
         Gj7Oi+yXnGGuOVYCMNefEnXAlYIf3wzS6+1CL1yv+6XZzIhSka92K6EZi0839UhyeXPk
         9oaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759303408; x=1759908208;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9KnLYLMgAo6iCMaJHkFXrrPXMlbYFJ8tsuzyv/2Xns=;
        b=sObn5+9ko8XLMv/fBV/Wy3WDHo7T6s3POmLQSAEJdGmMSbdwxjh+rlthAOXhrHRIii
         m7kb0cPNgGpn2R5d6knh1QoHNGsbnMZ9SEWDKAXRnnHte/P3aEK+kJo3ZcFnhd6NuUok
         6JOkUS8/GO9X1mvz0oy/A831vNOR8a9A0Na6D7oHbxYa5+3djFs5hDSA6N1f5xmI12+N
         nT2Q/0+UXLXjXqyttQzVcM9u91nPcH4cEGGIh1w5R5cLRdGoI3Az1bbBXJpLPS9yIZLp
         4puRNScq6lKHfEpmZvC3BEKEDOL1vPA+MzcXb23GTrhtI0lU18J3KAuEVpUX05NFZcqi
         SVaw==
X-Forwarded-Encrypted: i=1; AJvYcCVaGBj745peSRl3LbhUGwab5NhSujwZz0CMnS3IscHh+l0sO+A60iuw81wEUcyiYWy/by4XtwBtY1UPdUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIaJk5ttUtw+t4XvTLPfgg/OsudoNrTiZ7w2r5+a8J70FIKNxG
	FMQmjUz5mKdlsdJ2fJ7fT5XXiW/9rIlwj+YdzrtyBVqWZlhPrlT3DLcAjN1IXd2vXmo=
X-Gm-Gg: ASbGnct3YZ0N0ZWAbUV2v+g/F70BSg7L3RNLtMyXwJy8kLMOHQlpnlIYawuYQPd2FVD
	chKO/0zNIF5wHQXw08xP/NobmoCcSHx/HTrGTnWvLSCsdTk1e4XFFMvv7zoSUIl1lMoaLqCm9w7
	4Ej4s6lTClXvG3yAaoR8LTlttVRlh9wmm/GRY0iXSPkUDScIhrSW70zQVBOzn+HLr+9Pm1sLciG
	QORHrwHI5R1NOON7K8kyOz/RrM5FUzMv5nNyhi11aaCTlHH/EL41oQiq/tQv29+u/yRDZQ/yjvy
	Y76KiqjMeVLaHNv6NGuuujY25qhtC6YeA8+Lk42nJCdaYtvKPnWXRNHsX+YP+wrY4v7mUCMK/iU
	Z+PpWbEyCfwQpWYFwrU23uFmLpuRfc1IOrSlW/Px89EwqwvxwZad0zat/78rOBbuwuPg=
X-Google-Smtp-Source: AGHT+IEzWn4BmhnfZrcJBF3Mp5fHWEl4zVgZAe/Sje2YTE+1fAM2pKPiZRQH0Ot9w4yf2UYbaMO79Q==
X-Received: by 2002:a05:600d:61cb:b0:46e:4b8b:75f2 with SMTP id 5b1f17b1804b1-46e61228692mr23727735e9.16.1759303407552;
        Wed, 01 Oct 2025 00:23:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b8507sm25805335e9.3.2025.10.01.00.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 00:23:27 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 johan@kernel.org, dmitry.baryshkov@oss.qualcomm.com, 
 linux-arm-msm@vger.kernel.org, 
 Christopher Obbard <christopher.obbard@linaro.org>, 
 Rui Miguel Silva <rui.silva@linaro.org>
In-Reply-To: <20250814-topic-x1e80100-t14s-oled-dp-brightness-v7-1-b3d7b4dfe8c5@linaro.org>
References: <20250814-topic-x1e80100-t14s-oled-dp-brightness-v7-1-b3d7b4dfe8c5@linaro.org>
Subject: Re: [PATCH v7] drm/dp: clamp PWM bit count to advertised MIN and
 MAX capabilities
Message-Id: <175930340683.467410.13115461140906052706.b4-ty@linaro.org>
Date: Wed, 01 Oct 2025 09:23:26 +0200
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

On Thu, 14 Aug 2025 16:16:09 +0200, Neil Armstrong wrote:
> According to the eDP specification (VESA Embedded DisplayPort Standard
> v1.4b, Section 3.3.10.2), if the value of DP_EDP_PWMGEN_BIT_COUNT is
> less than DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, the sink is required to use
> the MIN value as the effective PWM bit count.
> 
> This commit updates the logic to clamp the reported
> DP_EDP_PWMGEN_BIT_COUNT to the range defined by _CAP_MIN and _CAP_MAX.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/dp: clamp PWM bit count to advertised MIN and MAX capabilities
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/68a7c52fa9e778bda45ed0b2e83a0bf2ea41b88c

-- 
Neil


