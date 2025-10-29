Return-Path: <linux-kernel+bounces-877164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65AFC1D58A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA044021AF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60D330B533;
	Wed, 29 Oct 2025 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqAVBoGV"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572B3241695
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771940; cv=none; b=IiyuWPJuXUO+sIKR7Iqgn7vHgSp4IbCx5Peoa1LGqcgMeiTDWK5hFiVora4Pj5RI40WkrTYdzv9nVNQzet/BneaJCRN4HUdcvjZcM0Jt7NNQFdWfkH0Pgeu+YJNo97z5wIMejBlGXtr7IGGidhcW8cakqJHKqXvDZ4uV4aCIat8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771940; c=relaxed/simple;
	bh=X6U8kRlyjpLNRZeQP9J4+18mRH00xkUK0qKbzi+MMH0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Yvi8iEYTTqJhTKEg0ZSbWoGbZ2/E1Ixsy87wQAilIaVPf6BBKaQQnwINQu1T1xohVR0Q6vis2CFN8ngn1Fri+O8CusxNHH+C+EwUSN0InQyS1xDlFwFEC306EXbioqI8VPzDOTkyqx7eYTkCf9IFbQ8c2MIi2MXWJb5zEeSUtfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lqAVBoGV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-471b80b994bso3664085e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761771937; x=1762376737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvrkZyUCxhzdMhpU1pq4SxDgqcy11RL1R709gVECqkM=;
        b=lqAVBoGVVZLMgZfSczVg0shIhibel/vw4kgDX7mL/5dhdewoPK6XA6dH/nCh7PfbhW
         XxgLlAwFNZAltnhKr0LYit4iMexzYRCWlfE5+AYIsyBfCV5ECIMveDP/scjBxRjfMBrZ
         nsZoJVMsgFY00TY6xELp0a0+uKREOsWEEJdA+c5PhqAIzL2t146nGrxPImCrwHsNJpbi
         aMFtiItiqSHYGvRqo6t2U0VlkgyRu1UrhRnCIhcS7r/RSgY7yvFj8HMJtO6MUC2ZgA6s
         u+sQAn/S68acFGNIAhW6JNRyIf4T9rkGh8Kd227Eyn5B0TBHyhY8bj5EveL6g3sN7A3n
         SLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761771937; x=1762376737;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvrkZyUCxhzdMhpU1pq4SxDgqcy11RL1R709gVECqkM=;
        b=QFHt/+lx87CAwwsM16KjhS1FAbwSj6qxPQjj3NYZPuo19RlrmhWqNAkDeV0TWBkEBO
         09INErtxCHoaNi6yeasFVL8iUpBaZVBADGtUQuRuaie6JBCu/4c5NJRWetcJsVSZiBiC
         TB2MfUJb+O5RI9VQEUlNq4nG9nfd1O3tlc2c3KwUQbIQOKV2rsHdKQFvN/lTmz7ZynjG
         6GMWg/Tk8D6I9k63BV6xWLcfxRFGFEZyaHLGNGCKKtFjq2aXaDJ6JlIviqv9k+jF/f93
         yxisbNMOtLKbdcEVzh1udR58FbsGBHrqXYB78f/DDADwkhtfdgV5Rh5BrSoo3pa/CySf
         Po2g==
X-Forwarded-Encrypted: i=1; AJvYcCXERJjiakQRQkU/4D8TMxEo/SQA1Tnzs6TmPEChz4nS5j+/x1Y4tJDX4j13Eb3QDblbSBFcpHWU6G5Oi1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhfQbhiFlQ5OmFjaJOVtFKzwUgaVqWgu+2pg/mWFhjmt0Yk8cy
	5A9L5t858wtXPI4WEkRiJgf0/9U7DfEwHdaIpvCSvPBWWMDg21tKEYfimy/uiWioDOgdxB9JHmz
	gClpO
X-Gm-Gg: ASbGnctSI3mODvu4cAnIuzvXE+iIx3l0H0L03cyhyjW1sKvB28qvt34gL47nr9Hcx8K
	dgoBc/R3xJ44ikCbLNPhmaok4zHu7m3hqL7dgq6CHev3kK1zO3m/s87qSjYgkByQ040upAoLYt2
	IuaB515siKjbGyAXIm1kF4TI/4qHLZHpDKGex8B57Du1mvC5vAdtBb7OiA8j46/cB1r2W9QleuT
	5z5Ujry+Yh7wmYe3CKz9VsOPeXK54gUR7KHbC/h7G0PxCwQbJYLmfAMFN7QtVSBRphyBYyLwki/
	HiyfXUkX2U4GWOaRYUYLx0IlK3+xi+9pul0p5hYbWLUPQaJM0/dS4lXUN2uigAIIdDtfsJmXbua
	EMJuiB4+NqhMs8ufaoWLVxWucTElyMai5YRE5LSCL4UlsIavgeTU78NymjlhI4cW+1eigow8EGq
	IBU4hRco9cXPUG0F7+Jdj9
X-Google-Smtp-Source: AGHT+IGZGXznQ8RiSklRjePtJn+PM8frBta7d71//k3kxFwN4+bLmQC5h4Kb94oQTvwtd4aBrmRTVQ==
X-Received: by 2002:a05:6000:144f:b0:427:cca6:5f4e with SMTP id ffacd0b85a97d-429b4ca57f9mr865236f8f.62.1761771936508;
        Wed, 29 Oct 2025 14:05:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de971sm27815109f8f.39.2025.10.29.14.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:05:36 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250820-panel-synaptics-tddi-v5-0-d4e3fd4987c6@disroot.org>
References: <20250820-panel-synaptics-tddi-v5-0-d4e3fd4987c6@disroot.org>
Subject: Re: [PATCH v5 0/2] Support for Synaptics TDDI series panels
Message-Id: <176177193567.2073083.15243278794379289189.b4-ty@linaro.org>
Date: Wed, 29 Oct 2025 22:05:35 +0100
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

On Wed, 20 Aug 2025 19:54:25 +0530, Kaustabh Chakraborty wrote:
> Synaptics' Touch and Display Driver Integration (TDDI) technology [1]
> employs a single chip for both touchscreen and display capabilities.
> Such designs reportedly help reducing costs and power consumption.
> 
> Although the touchscreens, which are powered by Synaptics'
> Register-Mapped Interface 4 (RMI4) touch protocol via I2C or SPI have
> driver support in the kernel, the MIPI DSI display panels don't.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: document Synaptics TDDI panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/5c42579b0705ea372ed7e6f158c880618850b409
[2/2] drm: panel: add support for Synaptics TDDI series DSI panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3eae82503f4fb24e36fc06f6827b8360678c2555

-- 
Neil


