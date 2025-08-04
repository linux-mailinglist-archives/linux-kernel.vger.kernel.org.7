Return-Path: <linux-kernel+bounces-755421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C978B1A61A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D486318A2CC0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D18271471;
	Mon,  4 Aug 2025 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RhZu4bH9"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359EF2594B4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321585; cv=none; b=anF3NB3ULQBNeWmMNsOE9B81xVfX9VeBP/eO1RGxz/OnGFPopMl/XLiTPMeuiRGffB2mFhkNleuNXN/LvBJBIfBeivje6WSdVF+tdDRZ2J7g+XGv2xYzATkUwxKhPHPRaUAMMj8xG8dBufE+OkCdLNkVCxlmJ23pDu050iaO/vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321585; c=relaxed/simple;
	bh=amYazT4b5t241oA/W727PFwpd4GaNDhMrPwSDc78/Lo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r7v5zWuCQN+VZpOY1vGj/pauuWmEZOjV/uCioZ6i+zGB86UxA8xMeOgNmjRQKQs/wJ98U7PNqfV+SgA4AgC0dHYvNau5NiC3swQ+m+sxndBdZarasNflliN097hp3bPkIO0zEtSf1GKOdqFbbnXwdvgaXr8r9wkJSjRFzdUtB7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RhZu4bH9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-458b885d6eeso12936885e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321582; x=1754926382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NF0bABbFtUOCdENunGBm+800fnNuZ9jGoGcS2XTVZ08=;
        b=RhZu4bH9ihemhtYGcdrW3+cFuWQ47GrbPNcQtMG5rtpEHrhXp4a1YlvpWZ8rh9crYt
         sh9dfU79iTGuADcw7UKStyaMNoi/1Q0A3C7CVRIn/C+n/m7NCOM8OR3rFfIXo6AMiDlc
         IJgrL2r5bP7zWJ5fNIM6bGdwM0jH2WApJpr/Ny25bT8A9yZ6Jm4+7B/Ph0nlsLG7oOvC
         Ja320JfmzpcHqyGsAZ10tjFWT9Xvdo6UQr8cME4YSOntAg3x03sKf6N828fRCd9ugIiW
         l2s0MJcSsfCwyJgg/GCPMtAu163VkA+ZOcUnrBW4MXTKrmJq9QZxjQUxiI9Vr2Pqr468
         p4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321582; x=1754926382;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NF0bABbFtUOCdENunGBm+800fnNuZ9jGoGcS2XTVZ08=;
        b=wCr5uRqONARRgAikspNIH7Ol51NFif1eyOvXgwP5CmDSKJO2uQ9dQfq7WsYyRV7NMU
         SHALy1C+gmNKc2XDUqkwqAoXbBs5ejizmu73EWfgxVezPRyw6HQ53qG7J/6BIaHogmO3
         e9G6IaryLUtyF4pQ8Rq5DoezDLwo25yt8bXcwoZmC/QGujmePSfrnbTnr0HhgWY/rhRr
         Lyagd0XY6DmGco/9zh33a7RmlyXm5OrsBzXFLcN07wM5FUAWlRZTRK90RpHoYf99O3R8
         zZHAmgYhe2zCHciiPkxtW3EXnI22l3wqTfrflXl8FJMj23kFaL0od5azXd38PxzIDeJ9
         6itA==
X-Forwarded-Encrypted: i=1; AJvYcCU0DUeUk5biGQmKySA9BReLlpIaNSsDvCLlVVolVbodwRAvwsInSgyTNSNxCpA3fQXHHZfzNSjWlBtRFow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0iGsIrHar5Hbob3Klk8VGkxlPA0JBGtFHoVChL896Vr71MGCj
	VQSqjzcbvAKU5U4P7RZ4gZZEmONgMyk5j8dblAG6xSL1yb4/IZUeLd0LCWO1c3j5ipo=
X-Gm-Gg: ASbGnct7mR81gyHpZtzwmZJrDmZ7ssw9FvZ9WFNWtc/Sx0eFtXniOiAgVUeVLw1lIBd
	y/BvXHVjOZSzaNls5RicCqV1cDUHGzzCETmgGKnYzOrAgSuAPCc8IAQaBAeLbuRXGVbuMEJfnMJ
	kUvLlGzJ/GyIrW/atpIbgNYuX0EJu2mEIAcDl2JV4+jWGkZM4xpFcCcNKkKFjpmqOJsXpIe2DhJ
	D05FSzCdJtEC+jP1rE8iNk1MSvQg1mCtF3o9xOxcpsxlN57twxHi6xwJMsri29PUMfGUYmiUfsw
	a+Kp3czKMDcDNDJN7/Iby612XLoh3di5Lf4Zscp5NNbbkGnJQ7kxTTnsU4NffV0UvA/8+QMHAkl
	NaEp7vrcUVBkONcfEjJHOy//qWXK+God7bDoIoO+YehE=
X-Google-Smtp-Source: AGHT+IFbfMK/bmmvR2bxmeaaYPGg3/jjzcbguCAvI/0THADshNsYjUr+ODiBlJg/RDp44aRIYORCwg==
X-Received: by 2002:a05:6000:1884:b0:3a5:1cc5:aa6f with SMTP id ffacd0b85a97d-3b8d94b9b2bmr6339040f8f.34.1754321582515;
        Mon, 04 Aug 2025 08:33:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47ca5fsm15664010f8f.63.2025.08.04.08.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:33:01 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250717135752.55958-1-clamor95@gmail.com>
References: <20250717135752.55958-1-clamor95@gmail.com>
Subject: Re: [PATCH v1 0/2] drm: panel: add support for panel used in ASUS
 VivoTab RT TF600T
Message-Id: <175432158144.3671011.146928832203319467.b4-ty@linaro.org>
Date: Mon, 04 Aug 2025 17:33:01 +0200
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

On Thu, 17 Jul 2025 16:57:50 +0300, Svyatoslav Ryhel wrote:
> Add support for Hydis HV101HD1 MIPI DSI panel used in ASUS VivoTab RT TF600T.
> 
> Svyatoslav Ryhel (2):
>   dt-bindings: display: panel: Document Hydis HV101HD1 DSI panel
>   drm: panel: Add support for Hydis HV101HD1 MIPI DSI panel
> 
> .../display/panel/hydis,hv101hd1.yaml         |  60 ++++++
>  drivers/gpu/drm/panel/Kconfig                 |  13 ++
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  drivers/gpu/drm/panel/panel-hydis-hv101hd1.c  | 188 ++++++++++++++++++
>  4 files changed, 262 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/hydis,hv101hd1.yaml
>  create mode 100644 drivers/gpu/drm/panel/panel-hydis-hv101hd1.c
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: Document Hydis HV101HD1 DSI panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/bd068333ef090d63a7cf952d70040e768b0aa4cf
[2/2] drm: panel: Add support for Hydis HV101HD1 MIPI DSI panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/fdb4e289d2d6fd172591d802db71cef3134c1cf8

-- 
Neil


