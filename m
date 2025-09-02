Return-Path: <linux-kernel+bounces-795916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE7CB3F960
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB8C3BF351
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E044B2EA174;
	Tue,  2 Sep 2025 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h9O44Lkc"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5732580CF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803638; cv=none; b=DagxCft94x8J+QnvrIcZ3AbLiK1ymbPK91i+mw84cQNrDaZFEp3Ykpr27YHsFZznHJLN1L2I3avb6dOu2joTuLyWBg1qIFBYXPGdXmSUyca6sb1ikHy9f/kjs7MerYMOnj9jF/NCKdVzqkzjvhZYkRxP5M3AetTqHBSDcULC33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803638; c=relaxed/simple;
	bh=/AvEkFL8ZPL0QX5wT+kkkwMlzldfAIudlswK22svjfo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dz/gM3mMuvz18NKERee1jJSu+zq8WoLhA0+ykP2MPwyLycMCj2lDYapnVCYkSHs5pjrAnbz4zaTt4SEG41WSE55Lxq16CVxsXS1Td/19pv76tElr5ezAQOuTZpJ7z0E5ZkVCEQYOkD5c6meDdS5VhDeg5oVpOvIaEHbfWvKfiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h9O44Lkc; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3d17731ac0fso2850421f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756803633; x=1757408433; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wqoSTMfnInHzXncCAvecG0yOfvdXdS/1fhZi2BozDIA=;
        b=h9O44LkcmxJyup1xooizPEZ6nx6u++LtbFfqWns+Gc3NqH4Sp2sGS20cAZx/giCfUT
         kSAmB0GFp8qLbItOnG69JdgS/fvGxgcA+UaRe1xcOT+ueqWK53LT6sul6U+rB13iSPaY
         AIg0Tb7Vcaq/RLXeTqny8x0lQFaiK/NbFMOhDohl1geFRHHDVTo0tgllcvR2G9s1tWw4
         IT75QUnoEkh1aY3RB12yzYCHjbJ1nQuYHndkmsFqe2q4IkAB+2vPCcbN8BW+9wEbFg4h
         LPcN25DBS4xkO4ewJfrUH5j8ASYWQTQUFeKoig8y6cpDYWxdQjxP6Sz+ubrmRMLP8rY2
         3I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756803633; x=1757408433;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqoSTMfnInHzXncCAvecG0yOfvdXdS/1fhZi2BozDIA=;
        b=lPDQJ4i4jQC3Dk4fPM1NWnLvknNt1gpN0Amy8zp3uPLic25fQo/xgy0+cxMkOcADwE
         Axcw/6e+oFee1hhsUS33CsCZxSCH6NB0vMUKX96SrLTutXeFPOmQcgdJrKw9e6v9z5Kb
         S9iKWwVO8pYcWX7eCk5DeAF5mu44R7+mTRaletPwex2LcSErxSk7hI0/vGWVAYS7YKcn
         c8317snR9zKTRY7LcZ5GutikxHL57Y0FJpfPBO4cEPlYejwotrd7Afbj8q9voLb1ofUw
         Ua0mATNE9pGO7XDywSP+akCIy0lH6y9tOZTmnRSbGUJQv39RIkeWl7YjlafWfjWQKl59
         fOxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUel3EvwzzL/tl2/1YqUhSwfBATeYcRnsOxQqoGv2aA7W43BXtgw3k1/dKfVTVTFChE9mXtNFLnnSOPcr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIO6xMQq1PCQQ3DN+XWq2WqmR2larVNogf02tQg98/HRvERcRP
	LcBC3+DVNcdNBu6GQV5MXWD/Z7/tg0wUlPjJGxyWHju6uHWHlqaZRLJP/DjimcdNfhA=
X-Gm-Gg: ASbGncs0+dJF0PZRs5u1VXLsmHrt6D4VR6jzOWpr1iqs5sPcvsuwiaMlspKKGD9XwZP
	BApwttA0sg2zu+GiIsEfxoJ+5ogjpf2GoT31n2v2Y4Z1IcxzA82kfJALwt1pM2Q+78ATkYtbyyS
	m/C0e9ST3I1QGUKH4enCJ014T9QmUI4gMU/jcMqXxP1dsqGk7tlcuujS5QSbJAxe2X8TfFcc9/7
	15/AniRymE3WVYMT9Va9ojR9XPYiHxsxU/pZ72WCc5BBhfTWteTdf8HyilU5loSQBLhdyaUIWRP
	9d4or9rQavbSK07T75S3vIoJ/MT0cIFbzV76UqJEnaRGs81JLqrxuRPCmXN9E/BOleRjwrsyZH5
	e0ITHtIGz4ag1WNFDXUAcQhBWT2qgkby8B2hFSS8L6blro/0CD1EIoA==
X-Google-Smtp-Source: AGHT+IHchy/28th+xU0fzEQUhWURMN5gK9cGjR/X/RP803Si12JCXg77wbS/BLHAWVSPPSGpdz0iUg==
X-Received: by 2002:a05:6000:2007:b0:3d1:abf7:e1d9 with SMTP id ffacd0b85a97d-3d1dfcfb948mr8671065f8f.35.1756803633392;
        Tue, 02 Sep 2025 02:00:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7271cd01sm261112045e9.23.2025.09.02.02.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:00:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/5] arm64: qcom: x1e78100-lenovo-thinkpad-t14s: add
 support for HDMI output
Date: Tue, 02 Sep 2025 11:00:27 +0200
Message-Id: <20250902-topic-x1e80100-hdmi-v2-0-f4ccf0ef79ab@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACuytmgC/32NQQqDMBBFryKz7pRJ1BK76j2KC2NGHWiNJBIs4
 t2beoAu34P//g6Rg3CEe7FD4CRR/JxBXwrop24eGcVlBk26JqMVrn6RHjfFhhQRTu4tWFpX29o
 67Zob5OUSeJDtrD7bzJPE1YfPeZLUz/7vJYWEg6o611QlsTGPl8xd8FcfRmiP4/gCwVV0gbcAA
 AA=
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
 linux-phy@lists.infradead.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=/AvEkFL8ZPL0QX5wT+kkkwMlzldfAIudlswK22svjfo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBotrItc0wBzFb+X3fEn+n3Klrj6iXvjRNIAzCMweDN
 97yr+i6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaLayLQAKCRB33NvayMhJ0dyLEA
 CApfG/eA7wleGCfq+kgzplNW95NCgw/c1jiZUk7LzJpgIIhaPA+iZ7lDhGD6SFQRD3/jhLVwl5BOVj
 E1GjnmzBI2tguTepGzydl369M+EbnzI64QUq2b3KiaM8K0aKXM3+HvUVuaqWjbm0rQU0r1KvCNN9YF
 yhdxMTLthirxY2ffP2yAjRvKPUAQco4t18XUGOaV6LttkAt7qWXayvYongE7r2kNJKxPemctif77ry
 SAA3WK9G8HtOFtSmUg+N4sQXgkj3u1FRelH1AHkPLAPYdGurTFd8rTTToLDyAdSpQOOQbnfgCPpELO
 5txIHesHPB1fN2hBPRvjkj6nA0zp6J48hNIuDpH8wULfG+VfaA4vI49Vz69TTzUxKQTuiuY/2n1zm0
 wkahQWU5Ta3ZmerGV+u+kbkTBOOlX92fuRzJ/FO5Seub53eQgn1fcHoKKgAxC0tySQd0jaP8bIDyuO
 iI2+TNaVJv/VAA+4sYzdgDja7T9639qw4cuCDPNUmzR/wGKM2wTwHT0iL9KakxrXSnx7t8G6rjQ6r+
 QvpBAa5lItszFDL8n39IXkUoJ0RH65ob9oSNonK/h3hjvbwQhSQ+8eLascE5fo1njFhJ+EdvMmoh86
 CNgKvbR8K9HOBYXbnGSxucBckKWbI41HqZAaTRzMKvFT8IOo1UKSCP4mXQhQ==
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

Add the needed property to specify the lanes mapping and
use those in the driver to setup the right PHY mode and
orientation.

Finally Add all the data routing in DT, disable mode switching and specify
the QMP Combo PHY should be in DP-Only mode to route the 4 lanes to
the underlying DP phy.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Model the HDMI transceiver as a simple bridge
- Switch to a static lanes mapping property
- Link to v1: https://lore.kernel.org/r/20250821-topic-x1e80100-hdmi-v1-0-f14ad9430e88@linaro.org

---
Neil Armstrong (5):
      dt-bindings: display: bridge: simple: document the Realtek RTD2171 DP-to-HDMI bridge
      drm/bridge: simple: add Realtek RTD2171 DP-to-HDMI bridge
      dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: Document static lanes mapping
      phy: qcom: qmp-combo: get the static lanes mapping from DT
      arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: add HDMI nodes

 .../bindings/display/bridge/simple-bridge.yaml     |   1 +
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         |  29 +++++
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    |  70 ++++++++++++
 drivers/gpu/drm/bridge/simple-bridge.c             |   5 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 118 +++++++++++++++++++--
 5 files changed, 214 insertions(+), 9 deletions(-)
---
base-commit: 7fa4d8dc380fbd81a9d702a855c50690c9c6442c
change-id: 20250821-topic-x1e80100-hdmi-3bd5b5bd2d96

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


