Return-Path: <linux-kernel+bounces-884782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 219CCC311F2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC12334BA03
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5EA2F1FF6;
	Tue,  4 Nov 2025 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fmchUivR"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92442ED175
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261749; cv=none; b=Rx5/mxkyH+Bc3zVtVqRPVTgN6DL99li/GX9StzVU9pXiMB/9opm7juIuTHpijkoulSruE7bQAzxx5HmbsZ0Mu6DSg2dIR5e7P2x80wtTei/3K1qcpJ63wkEpnK1InqUjlzOfY4L32PdvkdA0BKe1oaGGI3TeSgbmI0n6AKdD0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261749; c=relaxed/simple;
	bh=27kqkXSD5Dzki0U4bTNuaSeqDRFBWPYuP5DPJT8ZFZo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YFoP9xnhKtI8R7uXN6T4J7Y3F871DdqoLWUUgYY6BuRU+NuWgk5TWfGYCa8JFL2odP4zBZncHhMJ9lLnZIBRjjoNckuW/g3/LmXWwEBIE/gs2VmzCpw9WjdL8QGFsVYSxy5kP3dvsh055fJKkBbrdC5Al4ZbxgvVeo6hPynngqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fmchUivR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-427007b1fe5so4010702f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762261746; x=1762866546; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FxK9/M5N84FExLoRTW+PNKgn9H8+1HjlE5VylpeIsHQ=;
        b=fmchUivRg4R01rUSD6K4Gb3DLfNpd9zfe2Kqgvia8e854ak2pR9fxHWqwZOu5yrvzA
         ea9LisLMha7xDEu+h/55BDK0yHhLdjuztaAIrEvX8OI4q0XmaNjDrg9fShGhi+LSZ7xe
         aco6mzMCOKyHZFK5pCrAGnt8IT3PkxKwLOwMQhJSQI4jOnHQYAFhFQfjWdjyKzQpiXDR
         MUpbN4LHB3kNZ9Yyv/fKATYIwT6w6S9OpZeqhft/IWIdIG55LpvmMnR8madLtfA3Qd32
         BZ0IaMTRnT9QTipDin0tf9fbnmxmY+Dd6qj/fHzDltnZSpWQqcucAkwYaeLNeo87J3gY
         AQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762261746; x=1762866546;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxK9/M5N84FExLoRTW+PNKgn9H8+1HjlE5VylpeIsHQ=;
        b=FGiXp/wbbbj1Q6Iiu3+TStZpts7YLf3dBxIL8gwC/ew+rZB3gnG/G3r+Q2InQyaJlN
         H6d1MESxHmTC9a1tQilAMH3AEdWxI6P+2XruZtKqUBJbuLYEWiJN10WYjPDRYt+vO8ZI
         FQ7GfjlrEGoNpEktx1qQyc2Pjfi983GC3dXtVID3dROSqb+NcbL7sgB0hVHQqQnT/Dgv
         GUvaW2k3NM4yYOWY2vybMgVCgco+xM+vyNMmngJH0drx3/EfDmN7JOjnK+H6cwL32z8M
         rwQ/ehZklhpFnGTxN8Sf5OAwM+PrdLMI7zuVpmj6B0Vwdz2th6WxCdpMnxQSsF9SsDnN
         qTyg==
X-Forwarded-Encrypted: i=1; AJvYcCWGurhLE0Pvn4qZJzmKDwaMQ8MmLGLj5zqR9m2X6hqe7KIp9UMblYT/VO1oVJ9sWslSAzcu9MoQHkxe+O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaikGFp8oo3Db9GNsVwV2PB51z4QmpGk6e8bCrpcU0MDq0TBXs
	B469mtsOthJvxyjX6TgfuJYeIMYOa2+kTRTtH9IcM5ugppYGeXLeBOp7TFxCIZVRIh4=
X-Gm-Gg: ASbGncvl/3Twt7WlofprYHMKBT73UfI45AUh1r/LhaDI1auL64OnjKwK+MAifztP9fM
	K488b1ldpSRGMFlJDdNtshmOZd5+926o70Ynv5YcfGkh5lYQZtBkxuDKRoWMstGbDmw9zvX+RT6
	BijMe9sVbhRIFoKpFh/Y1NN8HNSPALdgrr8NlSXpywjzn3fIGZ6ZIISXyF99kfY7lLjQ2+S8Ze1
	6L69YTh76RMV10AqayWiX85Q9ehmpJbLxawtZdiZBc78onaI8q8aMVdfreHDjieQnpUhyDmBVA8
	zSykwhAM9UEBnw+xhoC1fL3k8dM41GYhz8OyTGNq1scqiSxD5/AXvqh3orm/xGZiE0N6tSGoVUS
	eqvIZeNTPkEV3siuQc3WU7/3CraPTWzmf6hadYJbG8G0UcLXGdm2Hc21YQv6zswoMc8F0dg==
X-Google-Smtp-Source: AGHT+IE51x9w7/hxMZ9PYtS8ESk4KgkwdjVyNKfliIp++ChjMUBtnNjUsSmL+9gueXbgY/eWMabzRA==
X-Received: by 2002:a05:6000:25c3:b0:429:c989:cec0 with SMTP id ffacd0b85a97d-429c989d7c1mr8999942f8f.48.1762261745752;
        Tue, 04 Nov 2025 05:09:05 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:9ea1:7ab7:4748:cae3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18efd3sm4554431f8f.5.2025.11.04.05.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:09:04 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v4 0/8] net: stmmac: qcom-ethqos: add support for SCMI
 power domains
Date: Tue, 04 Nov 2025 14:08:51 +0100
Message-Id: <20251104-qcom-sa8255p-emac-v4-0-f76660087cea@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOP6CWkC/23N0QqDIBTG8VcJr+c4HlNrV3uPsQtzVsLKpkM2o
 nefNRgMuvx/cH5nJtEGZyM5FTMJNrno/JijPBTE9HrsLHW33AQBBSgo6cP4gUZdoRATtYM2tCo
 lIBfaCIYk303Btu61mZdr7t7Fpw/v7UVi6/rVagY7WmIUKEetatMyK2V1vrtRB3/0oSMrl/iPY
 IBqj+CZUEJJ1dTIQTd/xLIsH6aIvcj2AAAA
X-Change-ID: 20250704-qcom-sa8255p-emac-8460235ac512
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Matthew Gerlach <matthew.gerlach@altera.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Keguang Zhang <keguang.zhang@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jan Petrous <jan.petrous@oss.nxp.com>, 
 s32@nxp.com, Romain Gantois <romain.gantois@bootlin.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Heiko Stuebner <heiko@sntech.de>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@gmail.com>, Emil Renner Berthing <kernel@esmil.dk>, 
 Minda Chen <minda.chen@starfivetech.com>, Drew Fustini <fustini@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
 Shuang Liang <liangshuang@eswincomputing.com>, 
 Zhi Li <lizhi2@eswincomputing.com>, 
 Shangjuan Wei <weishangjuan@eswincomputing.com>, 
 "G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Linux Team <linux-imx@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, David Wu <david.wu@rock-chips.com>, 
 Samin Guo <samin.guo@starfivetech.com>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Swathi K S <swathi.ks@samsung.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Drew Fustini <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev, 
 linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org, 
 imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev, 
 linux-riscv@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3930;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=27kqkXSD5Dzki0U4bTNuaSeqDRFBWPYuP5DPJT8ZFZo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCfroWcJdifPCL3DqXR4QlKAcd6tQEdpGbNgCW
 Q0tgy82H+GJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQn66AAKCRARpy6gFHHX
 cnpEEACoL9P7Ziw7NnZ7jlXuq7UvKyOILSTEZrw4bOjYVbB1okZWNYg8nELLmKc0SWoQh1v81zn
 8jPH/xO+q8aI6WJyCtcYYoYAEbDEbrtPkkbAC9JBR1mQDXuBzUwhYTv6yrR+rPN1VgKpBxsoFGU
 lsvwRztOiuowXcfATN6VcDvribhefA+yt3NcXIKQYnVGQMLUVpsHX65Y4Kuu/7b0+I+REk3PjdX
 ueeB9pGfgvbs8cWR0bkEGRMrOwxNddI+q51rRBf3e3Wbwo3zZ6B5Akb/epU/Bxm+vE9bRHNx+Vh
 bhKSRhAno4uTknAh/I5sXVGLUnS5eFTJSOkME2ySH+J/3mz7cg4rH6aXMborjd0F3BS+zwYJIk+
 Vy3/TIzzfowg6ZmoYhJwVMDNF/KJKIlHM4E7iVeL8BY5UA/EvMv8hSsebb/K+ZzGWFMWxdHMR+I
 qbzm2ZlOv1gA6l+Zlv3jqJia1kgKYBHqCif6ucHCZkvx4uu717BzMa73qdKGhxDDmNV/TYltteb
 g/frzBavk4BzSsb0fEbqf83E8rp02Ks3gYYTvdPdXNf38dNdYvljDIdcDPqgLU/qBfMD9mp3dTC
 5ggohhPVS5WZWsK2NORk/IjygwdLF8oiWlmjh1MzdcMjuQOAvJE4V4SwjKWQnqSCuGO58QdU+KD
 DP2eqomEec9/ZFQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Add support for the firmware-managed variant of the DesignWare MAC on
the sa8255p platform. This series contains new DT bindings and driver
changes required to support the MAC in the STMMAC driver.

It also reorganizes the ethqos code quite a bit to make the introduction
of power domains into the driver a bit easier on the eye.

The DTS changes will go in separately.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v4:
- Remove the phys property from the SCMI bindings
- Mark the power-domain-names property as required
- Set maxItems for power-domains to 1 for all existing bindings to
  maintain the current requirements after modifying the value in the
  top-level document
- Link to v3: https://lore.kernel.org/r/20251027-qcom-sa8255p-emac-v3-0-75767b9230ab@linaro.org

Changes in v3:
- Drop 'power' and 'perf' prefixes from power domain names
- Rebase on top of Russell's changes to dwmac
- Rebase on top of even more changes from Russell that are not yet
  in next (E1vB6ld-0000000BIPy-2Qi4@rmk-PC.armlinux.org.uk)
- Link to v2: https://lore.kernel.org/all/20251008-qcom-sa8255p-emac-v2-0-92bc29309fce@linaro.org/

Changes in v2:
- Fix the power-domains property in DT bindings
- Rework the DT bindings example
- Drop the DTS patch, it will go upstream separately
- Link to v1: https://lore.kernel.org/r/20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org

---
Bartosz Golaszewski (8):
      dt-bindings: net: qcom: document the ethqos device for SCMI-based systems
      net: stmmac: qcom-ethqos: use generic device properties
      net: stmmac: qcom-ethqos: improve typing in devres callback
      net: stmmac: qcom-ethqos: wrap emac driver data in additional structure
      net: stmmac: qcom-ethqos: split power management fields into a separate structure
      net: stmmac: qcom-ethqos: split power management context into a separate struct
      net: stmmac: qcom-ethqos: define a callback for setting the serdes speed
      net: stmmac: qcom-ethqos: add support for sa8255p

 .../bindings/net/allwinner,sun7i-a20-gmac.yaml     |   3 +
 .../bindings/net/altr,socfpga-stmmac.yaml          |   3 +
 .../bindings/net/amlogic,meson-dwmac.yaml          |   3 +
 .../devicetree/bindings/net/eswin,eic7700-eth.yaml |   3 +
 .../devicetree/bindings/net/intel,dwmac-plat.yaml  |   3 +
 .../bindings/net/loongson,ls1b-gmac.yaml           |   3 +
 .../bindings/net/loongson,ls1c-emac.yaml           |   3 +
 .../devicetree/bindings/net/nxp,dwmac-imx.yaml     |   3 +
 .../devicetree/bindings/net/nxp,lpc1850-dwmac.yaml |   3 +
 .../devicetree/bindings/net/nxp,s32-dwmac.yaml     |   3 +
 .../devicetree/bindings/net/qcom,ethqos-scmi.yaml  |  97 ++++++
 .../devicetree/bindings/net/qcom,ethqos.yaml       |   3 +
 .../devicetree/bindings/net/renesas,rzn1-gmac.yaml |   3 +
 .../bindings/net/renesas,rzv2h-gbeth.yaml          |   3 +
 .../devicetree/bindings/net/rockchip-dwmac.yaml    |   3 +
 .../devicetree/bindings/net/snps,dwmac.yaml        |   5 +-
 .../bindings/net/sophgo,cv1800b-dwmac.yaml         |   3 +
 .../bindings/net/sophgo,sg2044-dwmac.yaml          |   3 +
 .../bindings/net/starfive,jh7110-dwmac.yaml        |   3 +
 .../devicetree/bindings/net/stm32-dwmac.yaml       |   3 +
 .../devicetree/bindings/net/tesla,fsd-ethqos.yaml  |   3 +
 .../devicetree/bindings/net/thead,th1520-gmac.yaml |   3 +
 .../bindings/net/toshiba,visconti-dwmac.yaml       |   3 +
 MAINTAINERS                                        |   1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   2 +-
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 342 +++++++++++++++++----
 26 files changed, 447 insertions(+), 63 deletions(-)
---
base-commit: 9823120909776bbca58a3c55ef1f27d49283c1f3
change-id: 20250704-qcom-sa8255p-emac-8460235ac512

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


