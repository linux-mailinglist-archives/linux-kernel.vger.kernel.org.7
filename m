Return-Path: <linux-kernel+bounces-871502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27842C0D7FE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050E63AAF56
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9652D283FEF;
	Mon, 27 Oct 2025 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYp9dOlE"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83837168BD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567482; cv=none; b=NqVJeHkvgWYemEpKe2RLZvc5bkJVAdTQc6G9+XzNoDf2Tg5dCuQGI1gtpC47S//pxYkVwD0du7s9FFeyZCV8qiIyjVkNSNlOniM/4n3LIT7Rz9wdyRdwvKqwPihjJOhrVw4KIteSioT1EL05p+vWnMlI0dmulC0idUJd9IeDncY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567482; c=relaxed/simple;
	bh=GbRP4dLYSjIrd2WLgQv/5UKBFEZ0RFOmHg4miC8HQLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kc/Be5dFIEVIUybjSaCLKwBufOAiVF7SQpcEgJadoWmdBlT3D2SaD319/1WCrp+itXwzxQnXps07Zl4/IPNL1mOY6bu4NHyGvJyAp//GK+46rmC5N9tEb7fWy9ELbJEV4Q3wnJAmTle1OZdIH9pR0Fi+PYZ2usVIf/047zFP+mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYp9dOlE; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-782e93932ffso3378281b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761567480; x=1762172280; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N0RklZbmwkn8tuI09mtvTbzPIkOPBKf9i2aye/jiFz4=;
        b=lYp9dOlE7LvvEe0aZdp9D1r2rCIX/Ic6Aen6boLIoRjO1fhdWb1dbQ30vdVmmB9fhO
         uZLJWGU91urC8aP81VhhAKvf54TZCZp14betiDexFCF+szyHFmpLrxO4YJOfsk1IYgir
         CZDK20QV8BSYT9F5jjL5U533XWWef3NqVq2aHe2ZrxiuJNXnSbDOR4Db7Ebb1AWuxgz1
         d7alravJZgrzmfZCu/HerEPjEuLGcgUaP1mUo2a2sb0nhiIJXbJSiOvHfCLyYtXH0wEq
         XW3QyN4934vruegCUkBv+4P5nsN0KYFu4EtuT58V0BOPgzaxlt/lzdBBHC5d84ETHnXG
         U6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761567480; x=1762172280;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0RklZbmwkn8tuI09mtvTbzPIkOPBKf9i2aye/jiFz4=;
        b=eQ5MsUluANAVmGzLBDk4Pp2f1P68CUmNb5f0wnTaIiblU+cgIb7P1A3t6LLUYZ/dIv
         yLqEVUuKvSW5oVDSOLeDKsjwKsMcFz3VlzMVD0DKqtuYU9lcYl+Bb1IJBe4BFpM8gxeg
         6u0MZFK1IHt/f53OQYkmmvLQ4tMGW3OAQ9+AjJfcv83SiTjmwc+lHAgfdGCG2iz0RRf6
         ntyOU9i7OmVUVdAH1cTTbbhwjJUO6Nk6wZ10JZ0/N2OUcpnwX8KsSaVViVOSvmvCr/N2
         lKm/SmvzIE2U5K5L4plOC6K15/JKaT9vkvL349UX0esH9+6kFH3gOsGQfORgn0AUaR8M
         AhEA==
X-Gm-Message-State: AOJu0Yz/jBDOhHpyz02z0MwatAwAZvu19N1LM1cmE5ZhKx/M+gvjU62B
	Ht9Y7D8HY4ucp/4mRpcScdbslL3wwWu9JrlZmSnwVegH/InzyNvlcogC
X-Gm-Gg: ASbGncvOKIvSqtpbTefPoQ8fuqDVYx8Ff2tqm+bSuhMpjBN+co6hXf9YnlzioKj7NMC
	ZqKsy5jI2F0wF9SZGpvdyxIH8INHxX62SA6GBLx4wRSVBi1L8nDFNFzXdE1nVIwi0cNzpq96/xq
	Tz6rIpi8JZ/yueHTAx7DfYUlBry9Xhw5vi+hqF8ZP1dDPb+XD7Mpp5oo/lztg9Hvp1tLWGdiCo/
	rV/v6Gf7WMvNGgrh6ywcZlLTeounA3yIjSGT/jMzFNNtBYaX+mVOQVPpqMFpFOAz02jkc7PJknj
	so7B+RhlwZfToUjIZHP6HbP6cERiCsef5hqR3nZuBinqAp/U7D4mFhODePctfBsRz4jpphOp2YQ
	VZJvEnS7uV1m2cbkFED4pD0fkBAJnCkwdReoXY4ucqTbqV+avA91TVl5YiWufpSgzn7LYkQyhEv
	f8JvuzAJeJ55gFS95y1wQ=
X-Google-Smtp-Source: AGHT+IEwkXBY2OMy9ASrensu6jMrPB9Ho+SulT3M8md5DlEm9/4e426KOKOmOaSVBvx4B/22F0kseQ==
X-Received: by 2002:aa7:8096:0:b0:7a2:218c:962d with SMTP id d2e1a72fcca58-7a2218c974fmr29088665b3a.3.1761567479514;
        Mon, 27 Oct 2025 05:17:59 -0700 (PDT)
Received: from [192.168.0.8] ([2804:14c:490:135b:9fc5:9b54:db50:756e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140978dfsm7943873b3a.69.2025.10.27.05.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:17:58 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
Date: Mon, 27 Oct 2025 09:17:53 -0300
Subject: [PATCH v2] arm64: defconfig: Enable i.MX95 drivers for pinctrl,
 Ethernet and PCIe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251027-upstream-imx95-smarc-defconfig-v2-1-0f664b08d553@toradex.com>
X-B4-Tracking: v=1; b=H4sIAPBi/2gC/42NQQ6DIBAAv2L23G0Eg9We/EfjAWHRPSAGrLEx/
 r3UF/Q4c5g5IFFkSvAsDoi0ceIwZ5C3Asyk55GQbWaQpVSilBW+l7RG0h7Z763C5HU0aMmZMDs
 esWkf0g6qUq1oIEeWSI73a/DqM0+c1hA/128TP/t3ehMosJamptqpoRKqyyVtab+b4KE/z/ML4
 OqBTM4AAAA=
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

Enable i.MX95 pinctrl driver necessary for booting. Also enable the
missing drivers required for Ethernet and PCIe functionality. These
drivers are used on i.MX95 boards, including the NXP i.MX95 19x19 EVK.

The below configurations were enabled (listed with their DT nodes on
imx95.dtsi):

* CONFIG_PINCTRL_IMX_SCMI for the `scmi_iomuxc` pinctrl.
* CONFIG_CLK_IMX95_BLK_CTL for the HSIO domain clock controller
  (`hsio_blk_ctl`) used by the PCIe controller.
* CONFIG_NXP_NETC_BLK_CTRL for the NETC hardware domain controller
  (`netc_blk_ctrl`).
* CONFIG_NXP_ENETC4 for the Ethernet controller (`enetc_port*`).

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
---
Changes in v2:
- Rephrase the commit message to clearly explain why these configs were
  enabled and on which boards they are used.
- Link to v1:
  https://lore.kernel.org/r/20251023-upstream-imx95-smarc-defconfig-v1-1-62c6e6f5b315@toradex.com
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
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20251023-upstream-imx95-smarc-defconfig-8972db535918

Best regards,
-- 
João Paulo Gonçalves <joao.goncalves@toradex.com>


