Return-Path: <linux-kernel+bounces-843028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5A9BBE3DA
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839A61898F58
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6462D47EE;
	Mon,  6 Oct 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZBK7iUM"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3BF29993A
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758917; cv=none; b=isXuApqxLqAPHE6suzKe+EN/dAXoRs28pnGPsX4GvcIvddLaQKALrr17F5tXdQx0jOy18/KTt/aw/62XTzztF4eBm6c+xQxwu5VbPEIgjSIaoLRUYcUDM9y8UQTsRcBI6qfIEwNQkJkx+fMTnBmdt4SvW6BejXoZHsUFwsoZwgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758917; c=relaxed/simple;
	bh=zYYq+pLwq2yRy1ZkKoqQVUuyGLG9KFjljXH2Rjj3TVI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QvXEAvJcgUzzdueYkEkd2AqfJ84dgfRseNH6ubhj9H5ufrEAj0p4X5FI9fsVt4PjEj3BXgkmRUX1324RtV/goOAburH/RvT93pYl9SlU7MO7bBaa6H5226HEG46I7QbvgTiLJwUBe1SpBQRJp24zhnK5HiDfFpdgj9cqfou2FnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RZBK7iUM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso44411505e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759758912; x=1760363712; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OX9GmiJl6oGheMa9HlL/JG69y+jLP1fe5JRe7yUKpyU=;
        b=RZBK7iUMuKIw9QM/dZYxGlHrsK1taOgWtTPXjowtCmHqN5q9Hvh3fhE3DKNng40qFV
         K5AqTInBzaATkLqm9sPv5qquVhWmNytPh8IEinuhk0gySY4Y7uOXX8xqnFb8o8FOVn73
         GcVmxCmWDKpwrW8Whd8QSpncReg1LLLM6/4VRipS4YWJD0zz58v+5Z6qYdhbk7e3FvVx
         SJMJViKt/JSV3oZnV93xa7bjoIRIzwgEWnETSOSDahxAluoET8VanaEQJbZolmUP9lS0
         m8hTAGqMXBd0f0dNsqVOFHP+3kgK716qb0qkaz2obYIeiNqPe4gEA+JQYrglTAq+2PIP
         UPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759758912; x=1760363712;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OX9GmiJl6oGheMa9HlL/JG69y+jLP1fe5JRe7yUKpyU=;
        b=Tw1kBu4YkMSadaBjKNcrjl39OroZuEOoA5oX3dXaGRfBIZn45z00FDq4RVeNkj6hUu
         WYikoJrjvytMwRWdJ9XBvyUrSGpJG/kCXDu47gvaCDF0BltsllqyTit1nUG6EBuqReJQ
         1DSxDK9Dp+An2tXubPinyVXju8o1NEPOqSwLWv4TZJBW2Caopq7AYu4aXM4cygF82/GB
         H6gfepLOQXu4i8czf2f1C1MwY6Jhs3mBPUz2aPBgmPtErlVfaTsYX7qdd6qp3ym3xWMT
         j+S0lHOwBvq3z1O5uPBMYWBsLEMageTFiagRbreULM3IXERqyUd+/Nsn2fs1G/xA38Gn
         xVlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCVhpVaefFfQZViUnjAVQdVluHImSZGURuN2qaN5T7iQE+JiaQ1Z7K/6BONDCkN9z0yuHo6ZIZ9T0iycU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaVW29wm0AhaXT39FCE3tEBZD2wYBnZjcx5FEe6vUhPQVM0Z4j
	SJ2y6gzUkJTuytzpYHeSanmnNu9s58E8U9jMaPSB1tIzAWQx+Q+6iLfGrJNLBC0d347i0UN4wEZ
	qDfmKLK4=
X-Gm-Gg: ASbGncv/n5Mr/M8hPUs2Ewp0vr4Lzq4r2ZmBuMTxgtxIAO1j91uj5m9ekvSv2StjvgN
	p/sCwabv5cqhtmPzXrhWfANwkwzPiD+NV9ukO9k0SyGSOxCJkGwQHNM+O5/IoIzO+eO1nEKts48
	J8+2iQ/jvDYAAgxQjroXSbZ2Dlije3JM3O7rjURk13U6lverxXBRbtdSombOoIYSPspJWsovAfH
	YrXDWFLka1Cwl2bTxCgieyJ9PikMHH8U6/s++WlECF8v1n78gWRJ18JYQEl2B1Pafjr9jlEN1k8
	ZbopvIxdjSIHdQaxumrM3Iju/HPRAOc/xZrujK+GIh7fKrLFn/NHWibYPxQk3lAPdGN7vnDKVF3
	zKDia2eR67wMuaOBW2r7CWMzGdF4riRvWWSjEgcmtoQUyIY/pBViav0KBIlYEQbHyAEwblEE=
X-Google-Smtp-Source: AGHT+IHlOMkC0M8psBPdDuSpQ+kT3dNmziZ8yN50JboqopJfKrfkopq2o/316mn0W3yUBD6atqpWKA==
X-Received: by 2002:a5d:5d03:0:b0:3ea:80ec:855d with SMTP id ffacd0b85a97d-4256714afccmr7149351f8f.19.1759758912209;
        Mon, 06 Oct 2025 06:55:12 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6daasm21291921f8f.7.2025.10.06.06.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:55:11 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 0/3] arm64: qcom: x1e78100-lenovo-thinkpad-t14s: add
 support for HDMI output
Date: Mon, 06 Oct 2025 15:55:02 +0200
Message-Id: <20251006-topic-x1e80100-hdmi-v5-0-c006311d59d7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADbK42gC/33NTW7CMBCG4asgr+tqPLapw4p7VCz8MyYjtTFyU
 ESFcnccNgURsXw/aZ65ipEq0yh2m6uoNPHIZWhhPzYi9n44kuTUWiCgBYdKnsuJo7wocqAAZJ9
 +WeqQbLAhYeq2ol2eKmW+3NXvQ+uex3Opf/cnk1rW996kJMisjE+d0UDO7X948LV8lnoUCzjhP
 9IBriO4ICbGDJS/Oh9eEP2IuHVENyRaHSBjiJhfEfOAaFhHTEPc1itDzmvj4xMyz/MNHR+NmYY
 BAAA=
X-Change-ID: 20250821-topic-x1e80100-hdmi-3bd5b5bd2d96
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3075;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=zYYq+pLwq2yRy1ZkKoqQVUuyGLG9KFjljXH2Rjj3TVI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo48o9+YgUPzV7MVXoMe0H08kdYuE04tIwF5U3BTaF
 Pe/ZjkOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOPKPQAKCRB33NvayMhJ0e2yEA
 DKgrSFw49oWGkvZYpvAGSOaGcWDGpr9uueX1cUVB8eFV/LKEORMxevTYW8+VnH3szTnkODZdXoiETa
 x6/1Ss16ZbYfQq2q5WXYLpJIvwMCjZ3iKFgXb0wO13tM4nlPyuHa91qGqE5DQLQO9JszT07Ue1kIKL
 imLDrPCZTtDJ/SMmmBCLGYIfrQUgqalnIpRC3I6MQ278qbpVHWB8iWabFm/zME5ViNRfxcGSqBGk62
 4Y7dlC8NaTCkE8wNspyHNyKAYOm0Ob9Ep72brY16Ul4CCNL5ormw/xV8Rq6PcLKtBTu8Q4/8g9Ktr3
 pyREsnYk7Ce8CxU6CCgItzpi38/J20gDrGSd+NCzeyhyuKMgX8Fl1dujPKbn3ukoqU513rFyMktjin
 fIw0X+TuHtpsj8GmJM0FXKBJb56eJX+ClZOOv2ksyIKJ9eryG8G4VwCOBSvqjVkeEG4ub+9BFPP1Dy
 MzBhi4ZWLSndiXNxWP1TFzk1iwclcjMNdqBp8yhI+f323kLD/P+NRAA9n+8J78A0jVw1s4SlbQSciQ
 UUUT8r3H4jF4xx5rbvNpsSp1/ssoeQ/56esiKsJfJM0mBQm9AobFm4C3oU66TZNAppyn6v9B5ic0z1
 6G67iOWcJTPQnCcK17OHQ92PZeNprL/jw1WtFU1OA7CSB5TnmAnSsJHoxxag==
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
- [1] https://lore.kernel.org/all/20251006-topic-sm8x50-fix-qmp-usb43dp-usb-switch-v2-1-3249e511013b@linaro.org/
- [2] https://lore.kernel.org/all/20251006-topic-sm8x50-qmp-combo-allow-mode-switch-v1-1-3d79e7ea6824@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v5:
- Fixed bindings tab
- Add comment about exlusivity of the static lanes mapping
- Fixed the single lane phy entries
- Switched to of_property_present()
- Moved the ss2 nodes after ss1 in DT
- Link to v4: https://lore.kernel.org/r/20250930-topic-x1e80100-hdmi-v4-0-86a14e8a34ac@linaro.org

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

 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         |  69 +++++++++-
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    |  81 ++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 145 +++++++++++++++++++--
 3 files changed, 286 insertions(+), 9 deletions(-)
---
base-commit: 51c986f3be9de5451e172eb5f7efa53fbe9870fc
change-id: 20250821-topic-x1e80100-hdmi-3bd5b5bd2d96

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


