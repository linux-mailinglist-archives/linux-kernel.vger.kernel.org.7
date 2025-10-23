Return-Path: <linux-kernel+bounces-866931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F06DC01128
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE9F1A618A7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8DD313543;
	Thu, 23 Oct 2025 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaHlntN2"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5215E312832
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221972; cv=none; b=gS6AReawwh50X90XgSa3/Kj/ovM6NCSVf5oXhKW3BiLYtHPO+Nx7qa6TjYPe19sXbliufE+4WaJu+XWGhcWa0gjScUk3lEPf1OOCWNM2zIcoejf3CH03LUdRaV15cWI9WSzVWfvrbn+b7mJpaJXYu2N2IVE2Tchw/IVCmLQHPsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221972; c=relaxed/simple;
	bh=j2RY7WVYLSN+jWxemj2+54D8zSqqYRLj140qaFpBs2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=McDcOzz8lxM0V3BqBmb/tzpk8DonBplgVY6v9NmBSLczzrQWY+mlZ08QTaFn+4hjrjHAsWF0ePNU/gktFDTon+t7CgjWFhyfMaceQO3uq3yQ+7VSEyZ0YfWtNBlw3McUQSWKGKu01cXzWMpFmBcNRVuJTIzgq7BUF26FgvOBAo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaHlntN2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33bbc4e81dfso905956a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761221967; x=1761826767; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H2q0viC1oKDoybdxIdGnsDv0XEKPZJRHKvcrkOAaotk=;
        b=HaHlntN2GQ49/2IC3tcIAVdblfCLyrV9HV0m8W/zptpe+CXfJZx8WAdqJNrQbqu6N+
         qwy8oGMojDTeOOksqcKOmvJQ49R2ZUxVtkelHeYMkyEHstOwMcAvz+TU98giAAxEECLq
         N7YBSIOgUQUTNnOyyIPX2a1zvVpq51I0Uc5hce4jEXvtDhTaccC/EfvSzLZ6d4O0Ql+i
         yxr5NkN9xHHh7sZgjsM0ML/eWppE1Uahnu0vkikzLPRg+fLjWeB6XSxs+VHjOzFeMqer
         vO7rOygzAM/Z1wU+lSBuljUIzRsg3ePVfpRrl4NPJPXrHCZxc5O1ZQyP2O/IopxdnUn/
         YwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221967; x=1761826767;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2q0viC1oKDoybdxIdGnsDv0XEKPZJRHKvcrkOAaotk=;
        b=hh3a0yV3ZhOZAbYdWsbfiTTW47/0QK3wI5/nLL0FgOmBwHC4wuYTlUHN3MGppL+5Yc
         oMhF9V0IAy78/MqNeyOC/aG/GwlS1IJGYiRQ/EprHTwEh3jH8KeXJu13dZUcVefgDq2T
         yRrSyLdxcQMAfnnIMh+z4FMyufZOC/y1iB4pVAbI7qrAi4svQ/4ErfEty3uHwZDuhlRJ
         ZoHAnB7uNnlw0tqfXf8/HZK/IqgdLZ3MCAQdS2C709EghTNeUxRTXZNUH6ZxcNuOGfvX
         +igl2iwSArtsMVMwPQ7rc2wWR99OgBkuUNfsZHy8AEVupf5aknz4xnh2ouGpGan3+nN3
         tIrA==
X-Gm-Message-State: AOJu0YySrwDBungbrWLOI5us75twLxn0dIqlPWypeYeLxhMDOhKEAaVV
	t03sNQjNT+RIDQ51zCY5wR4TjGuo7P/j2/7fFzAVY9KGMlJcLFUYLF35
X-Gm-Gg: ASbGncsTWn42a+6Qhjil6O8nogwiXyuD1eZKqoRvEts9Y7UdFpxx6if5+vJxf542JPh
	fUxcyuM/8nTBJXv9lXGROZsyVdk69Tt14cPs4fq+zRbpPIpKtQwzWmTqPSAVdvfRJ48WjnaB215
	DTc6899/U3dbVX9/dORbic9DdS2iZPIMuiuqtwBWMRncIQmBIZ0TwUfg78HB4+wLdWTGSlpCRpg
	alDu2fxN8aQwwX4qTCTbp/Ih03+OGFBKpVPvTt8hsXeY2hDjqiw7edjEZv12HB0NjKxhNNlyom/
	31SgLsxFPKrZx6oE9GyuFZzx6/4ojLutQLnocNtM1NM3gdRopT64mZvCzSJmNDbyyNwfmy5w57J
	h2x8EP+kKGpEAeM5dPhE+4+1XZsrnKk+Owxb5PLWsl90f7RGhL6kFtP301w5jPaqN/Z5SZGb33g
	kEd+6TMDoyumgGaE4OkZ4Zy1TLh17/EmiPgQ==
X-Google-Smtp-Source: AGHT+IGJ23GsrNILCdW/8gbVtgjCsaLah5E0mTNdpSVoeuNI9VqG0QCaBp4Eb7N3Z7ssAPYGjAzlmA==
X-Received: by 2002:a17:90b:2403:b0:33e:2d0f:478e with SMTP id 98e67ed59e1d1-33e2d0f5967mr4230135a91.3.1761221966488;
        Thu, 23 Oct 2025 05:19:26 -0700 (PDT)
Received: from joaog-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff37c14sm2277474a91.2.2025.10.23.05.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:19:25 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
Date: Thu, 23 Oct 2025 09:19:15 -0300
Subject: [PATCH v1] arm64: defconfig: Enable i.MX95 configs for booting and
 Ethernet
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251023-upstream-imx95-smarc-defconfig-v1-1-62c6e6f5b315@toradex.com>
X-B4-Tracking: v=1; b=H4sIAEId+mgC/x3NQQqDMBBA0avIrDtgIqHGq5Qu0mSis0iUmSqCe
 PeGLt/m/wuUhElh6i4QOlh5rQ3m0UFcQp0JOTWD7a0zvR1w3/QrFApyOb1DLUEiJspxrZlnHP3
 Tpo8bnDcjtMgmlPn8D15wGHjf9w9b8i5+dAAAAA==
X-Change-ID: 20251023-upstream-imx95-smarc-defconfig-8972db535918
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
X-Mailer: b4 0.14.2

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

Enable the necessary missing configs for the i.MX95 to boot and also
have Ethernet working:

* CONFIG_NXP_ENETC4 for the network controller driver
* CONFIG_NXP_NETC_BLK_CTRL for the NETC hardware domain controller
* CONFIG_PINCTRL_IMX_SCMI for the pinctrl driver
* CONFIG_CLK_IMX95_BLK_CTL for the shared hardware domain controller

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e3a2d37bd10423b028f59dc40d6e8ee1c610d6b8..787d3ae3f5afeac486a905e0943e7b0e1dcee3a9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -354,8 +354,10 @@ CONFIG_FSL_FMAN=y
 CONFIG_FSL_DPAA_ETH=y
 CONFIG_FSL_DPAA2_ETH=y
 CONFIG_FSL_ENETC=y
+CONFIG_NXP_ENETC4=m
 CONFIG_FSL_ENETC_VF=y
 CONFIG_FSL_ENETC_QOS=y
+CONFIG_NXP_NETC_BLK_CTRL=m
 CONFIG_HIX5HD2_GMAC=y
 CONFIG_HNS_DSAF=y
 CONFIG_HNS_ENET=y
@@ -615,6 +617,7 @@ CONFIG_PINCTRL_IMX8DXL=y
 CONFIG_PINCTRL_IMX8ULP=y
 CONFIG_PINCTRL_IMX91=y
 CONFIG_PINCTRL_IMX93=y
+CONFIG_PINCTRL_IMX_SCMI=y
 CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_IPQ5018=y
 CONFIG_PINCTRL_IPQ5332=y
@@ -1349,6 +1352,7 @@ CONFIG_CLK_IMX8MQ=y
 CONFIG_CLK_IMX8QXP=y
 CONFIG_CLK_IMX8ULP=y
 CONFIG_CLK_IMX93=y
+CONFIG_CLK_IMX95_BLK_CTL=y
 CONFIG_TI_SCI_CLK=y
 CONFIG_COMMON_CLK_MT8192_AUDSYS=y
 CONFIG_COMMON_CLK_MT8192_CAMSYS=y

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251023-upstream-imx95-smarc-defconfig-8972db535918

Best regards,
-- 
João Paulo Gonçalves <joao.goncalves@toradex.com>


