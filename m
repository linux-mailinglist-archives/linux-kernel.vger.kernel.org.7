Return-Path: <linux-kernel+bounces-837280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28617BABDA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5B919254FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB8D1F91C8;
	Tue, 30 Sep 2025 07:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVK6vLpK"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8E8219303
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217995; cv=none; b=gVrwERdORi15JZo5ca9BJ187oAOtGy7m1I0ISgsxTPKVn5+7oVjteYMXQAueCa+5rhRi6a+Yx+GKDC9PmlHpcl3BkCE+vYVacn3CkAhuQd/2DvhmNrfdsD95KUOLep9hESiIeLRamq/20/j3C++FsljtbBwzaBRAozrClO7XRP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217995; c=relaxed/simple;
	bh=nCuzzICNiMfPq7GXzu2/94MKHl2UoBxCWeAEP7gaTvQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mDczAAEQmgDIpx5vC5SYByy6S9oG0QsUsSy32YTTxuPgOVogxQ+XsZwZChKuLKuNXRPiJjFzgZhGz0j5OHB5GI8l3hSNrJlA+JKSxdrpxStLxANkI5SKoEm3WuYnFT+frEEAxJ7sXbupPLKlPghtIZLeq8mhovDXd/r/lruPNoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HVK6vLpK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so57466525e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759217992; x=1759822792; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Eb5Y0PnbeJI8BI1fdW2DHCUoV9OexE8PXQQVWxZpXg=;
        b=HVK6vLpKts1z8I14+HAFwBlSOVCGufh91kE1otFIjhdYTmabUNxl3AD/jGuLC9AzTe
         PBV6iMKd4qFLjOJ11nzSrffo5O5DYdE5MgzJJV5S2K6xYsZJTxcz4o5U87JN3XNh/tK9
         7f2Fo2XRnM+G+PqzKHuMq47DrL8C4m+Yz8inv40ayGsg+NktU6wgFlOJbxwtGyiLDoHE
         6cQrWBQKw2y7maY9fgZWiVkaxEglNImqiw49WYJzn34O5EBXNo94rFvPag1LnwCQZkVF
         9lzb5BUdVI0FwI1lFrLaZzV/GOi/UsBMDP8tIhfdDvZpbdi6RsEAxcS6642mvoDgAH7i
         V+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759217992; x=1759822792;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Eb5Y0PnbeJI8BI1fdW2DHCUoV9OexE8PXQQVWxZpXg=;
        b=FSjyk89nWvUJUGjBir3OdVMNJxffFG76I8W0cPoOU+pJ2Vm6QwbGPczeWe1FNVHBsw
         DhzhAzDHGczTisENNaWIec4flM3MdW7S/Ntnw4cxq5FHZNN3bqvwNfWD6TDIRi6AKUEX
         1XEKcw7GbDDE9D/nYz3hH6q9QOfqR8rr8YJ+y6jouPMuk2XO9LWwrN2Mz5J2c65o0u6O
         LvgKgSn1PFFuhxhy+tu1NF5vf1xawrAXgqfo1Rw7c7/v/U+WxWVzP9nnHuFkJF4aV2zW
         7ZT2yVW5vBTcgXjEbEww1OPbJyqa73YevMt/cWFTCnzbe5PY+1pYCHbAlyhcu4DonqJN
         bb7w==
X-Forwarded-Encrypted: i=1; AJvYcCV1i5mdaDyolyHdX6KaVww1TWYPYD/i94zxf+tDIPPK0qrFq/1H7KeXIqhEluO10Bk8BX2fAyTA3AJUhtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZq8aIJrtekwB6/ZMqCNE6xoXhKaYSxbLFqDA8MWeCCFslYnOj
	edsU38TXolSqITLFIccZYqIDPOOzDicamFqRmkkm5TpSjJlBeIIpryoTo1IR13MtChw=
X-Gm-Gg: ASbGnctLyLUnHj/8HJdtiQ3vbD7TcLttUsEIYtR/JtLYOVe3DfA/O6uvLxLE/uwzcs4
	wPLJ5X+ssJBNumMkn+K7qoldOTZPW2jBNOMpNB50I8ZdXj5iZd4x2O1Y1S9oDTbpG+bPqxOOkuU
	t8KP3iwBLDTM/ikH0DzBMB3HvC0f9tmmzbo0fj4/1V20EY6Z4Bi8Q+SLF1BtTT/6MQVahK+NUcz
	PU8CuHCkx5on7rFsQI4qbtUsDMM1UH6sPPfMBFKn+ojyC6RSoJXE9dot8OHYr8juyxonv4zLpdb
	qCwcBky7MTD/dy7kXGgpFLtRoBsD5gpV/UyQc+AqMFUfday7JjUcvUxEIPi+iFg7BV6GEyxkwfk
	/GZ6nmiYMtbmdXbE3qvD6Vs9uLSGQ3LczHd1bIPMjXx6EVwrzcxoq3tw7Yk4cr0B0nxs=
X-Google-Smtp-Source: AGHT+IGE2BpXydZW6akGdRW1q0tr75JXjen4TsuJND3ge4yGDsChAE3eCrNZzkuQVJg2heu1ygWlzQ==
X-Received: by 2002:a05:600c:46cf:b0:46e:35eb:43a with SMTP id 5b1f17b1804b1-46e35eb07b0mr176404365e9.15.1759217992244;
        Tue, 30 Sep 2025 00:39:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5707c1e7sm44021125e9.21.2025.09.30.00.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:39:51 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/3] arm64: qcom: x1e78100-lenovo-thinkpad-t14s: add
 support for HDMI output
Date: Tue, 30 Sep 2025 09:39:46 +0200
Message-Id: <20250930-topic-x1e80100-hdmi-v4-0-86a14e8a34ac@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEKJ22gC/33NTQ6CMBCG4auYrq2ZTkGLK+9hXNA/mEQpKYRgC
 He3sFEjcfl+yTwzsc5Fch077yYW3UAdhSZFtt8xU5dN5TjZ1AwBc1AoeB9aMnwUToEA4LV9EJf
 a5jrXFm1xZOmyjc7TuKrXW+qauj7E5/pkEMv63xsEB+5FVtoik+CUutypKWM4hFixBRzwjRSA2
 wguSGaMB+dPRal/EPmJqG1EJsTkUoNHbdB/I/M8vwC17mg0QQEAAA==
X-Change-ID: 20250821-topic-x1e80100-hdmi-3bd5b5bd2d96
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2648;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=nCuzzICNiMfPq7GXzu2/94MKHl2UoBxCWeAEP7gaTvQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo24lFQK9d+D3VFC4zzO7XUKS10yyyEANY6HGInOa5
 ChlZx+GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaNuJRQAKCRB33NvayMhJ0VKEEA
 DE2gHgFogFgo0IOcGJjLxBtdAg3OgEijLrPXbHUhD8EO7k6rOIOXLch9KQgsVUfV6flmNgdU26yXlO
 E8QqBHiTTFBuOcl8VqVXWmLidh9mv/sKbolhdThEq4eNw8CqF1klwpA8VBn3fcfSLGZrCfC78kwdP/
 GWGgMA2phVqHO+8x1E6uvK0nSVP8FypdNUFw4vgvDV5asaEV8ILiZ0GKshgsUb+NwNWsI72yur9DgM
 Ps0kbZDw+jY8a+wTpJqoPpKrlIRMXjEjo6+Sz3yuXc9s8HSYBPJsYatJYdTkoNpP3SoJstCl1LGD0y
 4bbIpDe9Sk1gNJQt8tnt2s5yYsNxdz/b+75GvLDqJbBGzSZfwBiPaxuJrXe6h+V3uYP9ErqXXSuJcc
 BMZS4L/1aWwDE6h0d494UrqZ0r9whQ/R3aERa2I2qqEd6Vrwnpp9VMzoDXTEG3MvdEXLcKO+WssYD4
 879rll/VKGTVOgLmkHQh20wJobYlFwDN/tZvstr8nFTxfJWkMZvDTLSYn4vPUVA7yJqtIZ+D0tfuny
 m0exCKGSxExhPk7CGJWsTh3maHb8r9UjtGMYZP5/ltLdRkZhShl+B/RC/OGX8FRDgWK9nbKH6wytIh
 L+FdnTgh94/X3aR0F4jKDC2wpq7/6zac1hpfj+Bl6mlBJOloz531bvt8grzA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Thinkpad T14s embeds a transparent 4lanes DP->HDMI transceiver
connected to the third QMP Combo PHY 4 lanes.

The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
of a combo glue to route either lanes to the 4 shared physical lanes.

The routing of the lanes can be:
- 1/2 DP + 2 USB3
- 1/2/4 DP
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

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v4:
- Add definition for single lane DP
- Fix lanes mapping for DP in bindings and driver
- Add documentation on how to interpret the data-lanes numbers
- Rewrite driver support for be simpler and split into helpers
- Rebase DT on next and drop phy.h include, and use proper mapping
- Link to v3: https://lore.kernel.org/r/20250908-topic-x1e80100-hdmi-v3-0-c53b0f2bc2fb@linaro.org

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
Neil Armstrong (3):
      dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: Document lanes mapping when not using in USB-C complex
      phy: qcom: qmp-combo: get the USB3 & DisplayPort lanes mapping from DT
      arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: add HDMI nodes

 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         |  67 +++++++++-
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    |  81 ++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 145 +++++++++++++++++++--
 3 files changed, 284 insertions(+), 9 deletions(-)
---
base-commit: 4513b3b1a91546d0dd02c5c0eb507933b328021c
change-id: 20250821-topic-x1e80100-hdmi-3bd5b5bd2d96

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


