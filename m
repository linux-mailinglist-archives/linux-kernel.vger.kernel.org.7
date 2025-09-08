Return-Path: <linux-kernel+bounces-805867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FA2B48E97
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E5A3B5BAE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4DF30B500;
	Mon,  8 Sep 2025 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fk+IPlEA"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35FA3081B5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336670; cv=none; b=ustpLtqyhdv3oJEHfuLlbb6PJ9bL66zS6HQHbqL5uJvG+0+rdb+dH7B243I+11VZBCm0IFPZrvg9yW8B1aoYBK7SsoiRb4/ZYkYsCa/54p9gb/DRhrabFFMRWtox3AAnk7ZsEiMGct8NCJpArdUqk5BiT1puv687V7Y7X+BDegg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336670; c=relaxed/simple;
	bh=GJhPHTORzQeMZdAUCocINlbQeRuM3KT1od1O9w0/Xmo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=szWy29614B9IATAdOes+5HpO9vh6UH8Jf7fYDGSauR96p6JOltcjvjTHuc4BdhQ8Iw2KDiHGZIk+1cBhBB/9kW0aGj+oskmTFaCKl+LI5SGBC15ySEPyb3lBrPgqKj6GV9w0B/JC7kWWh26EFGSsS2LM3Exg/5dIiXDXm1LiBkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fk+IPlEA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45cb5492350so28091265e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757336665; x=1757941465; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F+BmpLQdceYRG7RY6FfRDG60NShGiPldYqA/h5za8sM=;
        b=Fk+IPlEATsY0Hu1YlVRA9GsS7BBAkVWexpkvGxHP40I6lv4825TkAshKKVkd2i8bLb
         fnZMa2esbGmMXnV2XtFZ04yzTa7Kb0NioZl/7Cb5RJeRoxeUil6M7JubPAnK9p/tB4u3
         trfw4YEQqI2J1YVC6nHLIf0nV7MnYbjNL3CsaGudzU9Qo2kYJBEcpNRuKdx33NSzVC/b
         ScSukhs8t8yNRi9+gBOlaBhPILVLT+AF/+BqLfUl3oOcKgMMIFBLHALhGjeClVatHsVw
         p4c7efKskYni6gcvsus71t5xr7wZL50wpCmr2E5g8XV2iZAJeNgeOBy1ZEkdTlLk/UAU
         VkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757336665; x=1757941465;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+BmpLQdceYRG7RY6FfRDG60NShGiPldYqA/h5za8sM=;
        b=SJZ/6d/LiV7Li0pypOMTMemJiQftx1WUcN4UXwH54cs6qj7OVTlcg4rYXaXkNS+X2s
         y45rjpHv2qKtxVB6W/znsWruXCiDeXPjvpEzPRa7lSV51oHmk7jvAph9JdrILPreSNbW
         I9Ud5b3F1V8gR/b9MyCvpmXvnokUsuEJxSNvzRtRdst/n6Xv9UllpJRjvgu5LvWPicuq
         G70htiWJ/5r3CmfHD4o+KXFCGWxd0HUy9UOFmJwKBZiwsSRkGXh85NPhDfORRo2r/lKF
         vsF5rIUJKOm3tej09B7et5Emx9Cbc+Jrnd0LTcSs2i83vTZVD6ziU1IEaeTpt1J9KV09
         +aeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoxVstIlyJOh/kOA+KUS94aE0epw4o34afI4uNegJGcsnK4x8/TBKkogwr+7S7MNM2FhqliO8Lmr9zGZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfg9tjIGZTw0OO4PDzQI3RCRnetRjFuY2GJO9UzPWyVeQ1dFZO
	hpFlfaAoSdroEZVIUnZ3F1N+trF+bPr27hGnJUe47CxUKq8v8iTtsqxD6GBC0cO7zD8=
X-Gm-Gg: ASbGnctPTjUwE60O+uNfI7Y1Ytwq6fmX5UschkHsHBoq6hqNeUow84lJmdnTn0YSYgq
	vYguh7bdNXgWgAuk9TD0pGcqQvbLumg1/YxA/25uDpSxW8tqDTbM7dtKoKLZYsRstWCx9ZlfLKw
	KnrOsDD6BSF7hONNiy9j7yf+k+B16kYiswLIHPMPej7eHtojgIKcWVQIg67+kDTzLHjI0hvKk+a
	31shPZRjYQGi+GtK0x0qaJyKmi+QRAJD6CABQT2KuEH5ZCf/7PS7KzKMnjXccq0BEhS9xwDnUGU
	2iqSrVKbrzIiLBjaZ6fuQDmYiy45yps1+szEsmleVyY2EaIbHhav5+zMI7/DIofF1X+VHJrFUQw
	D2EnObFYEX8qh7l2UjzJNTZf/cwTr5o/JPG3ce1bVSm0FUbkWkjZXDg==
X-Google-Smtp-Source: AGHT+IGTXRp8nBogkgIlcEf9RUlMXZE1MYZ7qwfcb5uuGBnjJTSjf3Iluna5GLbfmKKFomw1sOdvFQ==
X-Received: by 2002:a05:600c:3b25:b0:45b:9a41:5d58 with SMTP id 5b1f17b1804b1-45dddea60cbmr64611275e9.4.1757336665015;
        Mon, 08 Sep 2025 06:04:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd6891d23sm145632475e9.4.2025.09.08.06.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 06:04:24 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/5] arm64: qcom: x1e78100-lenovo-thinkpad-t14s: add
 support for HDMI output
Date: Mon, 08 Sep 2025 15:04:17 +0200
Message-Id: <20250908-topic-x1e80100-hdmi-v3-0-c53b0f2bc2fb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFHUvmgC/33NTQrCMBCG4auUrI1M0lYTV95DXOS3HdCmJCVUS
 u9u2o0I4vL9YJ5ZSHIRXSKXaiHRZUwYhhL1oSKmV0PnKNrShANvQXBGpzCioTNzAhgA7e0Taa1
 tq1ttuZUnUi7H6DzOu3q7l+4xTSG+9ieZbet/LzMK1LNGWdnU4IS4PnBQMRxD7MgGZv5BJPDfC
 N+QxhgPzp+l0l/Iuq5vVuxBq/wAAAA=
X-Change-ID: 20250821-topic-x1e80100-hdmi-3bd5b5bd2d96
To: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2716;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=GJhPHTORzQeMZdAUCocINlbQeRuM3KT1od1O9w0/Xmo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBovtRVDMVGgxHzLejb7eBbyoFwp6E4YEQMRKPg72/U
 Rwjh/ruJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaL7UVQAKCRB33NvayMhJ0VxID/
 4wFkdgfYu9J7loTdKrRz5TqNDd63WB1xnl/W4hVSu2QdX9wb2jyH6rUY37phQY9rtVycGyJTzy4cnd
 bi2OjtCN2t5VD8MJF2QB6RTWRYeGqRu4Rturr3w/3WcTHwlJ854MSYrHL2hppI1f8bZyB6wqswekus
 xYvmd2waH5jU0iXp1rLwrCdBphUPyvJylV8oSUb3kyIcZjNbgmjUpIuBSZIkBekeYsesIh8s3Il5zg
 oRiIcBFWFJA8XLfk4Q+Rva2EWkGskG1obCzljpnJDspCLDirzii4iD19ShH59aTy7dJu36GdP7/Qsa
 ISdwycHc7lETEQ7dzSF14MzvjAzSB5fDCqhA7eny3MpxBperELbkHibfuDBClM4cT7u7wT4H0jwh0U
 EHwpwuOgpCH7CM4z4nqMmOKlwUy8hZursraRsi2sFYghdAKSJKOK95FakAnAYIcTDPRNDcNNdACV4j
 mMhQ4hD3ZW0YNJbhQ+PVu+9XT7Qw+eBcueBCBbTZJVj5Za25jgprIzt8y85t6nv6yz3nAkUAM8dNC0
 ACpUhXWFsEKTVcFO+3wmtS5pPNqWOww0dSqma3wv4kx1s0LeU/ZKSbdWR9fPnVjnLXQno4onht+nvJ
 f9JXE2dW/js9wgGCRf5Z3Ca4GV19HstrNjpQYFXQ7mQtwZDhH+hhVM9dOVCg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Thinkpad T14s embeds a transparent 4lanes DP->HDMI transceiver
connected to the third QMP Combo PHY 4 lanes.

The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
of a combo glue to route either lanes to the 4 shared physical lanes.

The routing of the lanes can be:
- 2 DP + 2 USB3
- 4 DP
- 2 USB3

We need be able to specify the lanes mapping to DisplayPort
and/or USB3 peripherals when not connected to a Type-C complex.

Add the documentation for data-lanes in the out endpoints amd
use those in the driver to setup the right PHY mode and
orientation.

Finally Add all the data routing in DT, disable mode switching and specify
the QMP Combo PHY should be in DP-Only mode to route the 4 lanes to
the underlying DP phy.

Depends on:
- [1] https://lore.kernel.org/all/20250902-topic-sm8x50-fix-qmp-usb43dp-usb-switch-v1-1-5b4a51c8c5a8@linaro.org/
- [2] https://lore.kernel.org/all/20250807-topic-4ln_dp_respin-v4-0-43272d6eca92@oss.qualcomm.com/
- [3] https://lore.kernel.org/all/20250822-topic-x1e80100-4lanes-v3-0-5363acad9e32@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Move the static lanes mapping in data-lanes in the out endpoints
	- new bindings
	- new drivewr implementation
	- new DT layout
- rebased on next, fixed simple bridge rebase
- added link frequencies for dp2
- Link to v2: https://lore.kernel.org/r/20250902-topic-x1e80100-hdmi-v2-0-f4ccf0ef79ab@linaro.org

Changes in v2:
- Model the HDMI transceiver as a simple bridge
- Switch to a static lanes mapping property
- Link to v1: https://lore.kernel.org/r/20250821-topic-x1e80100-hdmi-v1-0-f14ad9430e88@linaro.org

---
Neil Armstrong (5):
      dt-bindings: display: bridge: simple: document the Realtek RTD2171 DP-to-HDMI bridge
      drm/bridge: simple: add Realtek RTD2171 DP-to-HDMI bridge
      dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: Document lanes mapping when not using in USB-C complex
      phy: qcom: qmp-combo: get the USB3 & DisplayPort lanes mapping from DT
      arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: add HDMI nodes

 .../bindings/display/bridge/simple-bridge.yaml     |   1 +
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         |  59 ++++++++-
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    |  82 +++++++++++++
 drivers/gpu/drm/bridge/simple-bridge.c             |   5 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 132 +++++++++++++++++++--
 5 files changed, 270 insertions(+), 9 deletions(-)
---
base-commit: 947efd54a86984b5f7dee9cf18c1ee82ec0361a2
change-id: 20250821-topic-x1e80100-hdmi-3bd5b5bd2d96

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


