Return-Path: <linux-kernel+bounces-852538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27859BD9460
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E966A1921229
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8579D3128BA;
	Tue, 14 Oct 2025 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="oXzcrXgm"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1579312819
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443897; cv=none; b=uNRnm6NDKlQfZr96iUURbSnYLQa2wlY3/IKktr7FfbtOR66sTmqMqSG4pXev36f8+YpUYPVlOZuUKto9DX77Q7NMCJMke2kpIVlc10TtBcsG8js3FZwCsMm181ZPU6fHHNfuFByO2z25T8m6SeVv7bwdqfDYu/4RGA1n4TcnBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443897; c=relaxed/simple;
	bh=h5OUnC0qS1XyOkwz0rbMd9zjA2g5kjfcThDxR8eek/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ACsQxduWFUiScaEEGN3EiVpkrtZGQR7HOUWrhlF3cfAk5R068UNH/uWveWN16H3rR8utb68SVDyAqeCFeR0cmIHBjvWH2d3WFCCfS1SK2KdLGejdgFlRyHZVZ8TGJrfGyZSv4Is5qiHHZ5Tc+paESoVliZM5OgOdhb5DgwZKotk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=oXzcrXgm; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3e44f22f15so756864566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760443889; x=1761048689; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMsvvNxUXmnvKGYayr5xM294MMb/IoJ0IjM92sbPoFI=;
        b=oXzcrXgmrCDRGvmrRSJnHHbOZjifFYFc2o7Kk22vmURU5q12kV78QS5VrZzpjMNV9y
         ooz9XAxpDwOrOGA58LlAgk8JXm+pQRyleGm/a4f5pBXP3/0zDHfw53+SS0VvsTCWstxx
         xar22NpEZL3O7gmq0ymKttCDxga/wz9nP6xSmNPoovWlrnC1HRQjXq4ytUkhmOpkssA8
         /PrEnnY90J7tJGNYv5kdbmFKJdpXOcwXXyhpfaTt/ew1phTUMk++SvptRldAQS3ycDW3
         SGWEVX4uVA4xAkAS+37VYguKuJNndx6P3qjFKiujQUkTLmgKNMVSqgg9AN0uPlR5hiLF
         ewBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760443889; x=1761048689;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMsvvNxUXmnvKGYayr5xM294MMb/IoJ0IjM92sbPoFI=;
        b=l26keh3QJYaHlLHnCgVXHhtzFss5dTuTcaznxYBioyec5vfon0IUDIs2z5IsYHA0Ym
         Qx/5UaSwR4ywfrMYEBuHC7aN/R8m9iUrsnalsoncB0HSJzmjSuU7Z45jcLHI6TVnvYOP
         ci6qaeUtBHjBK642ngcjzEY53aSSX7zG9rRJmnD3YlAV+1nAFwUS4GavvTRy/l2dDome
         hWhdsbsLVB99RWiGcekW1v8vT+tcxagQ8xmIyN35M+zGeGz8ZkGOjf8G9SOIVOc022hY
         tw2WE5b7KbeG+GF1tyhUXBU3+YaVmAMjR54LZEeY88LdAppSKrHotzPYxBWqmPH6GoDC
         4YxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC6EfXmYrN9QxRiw3rHGWCu504L76qx56YqV5o1OL57yY7RSnC75qfTJYPKx8bdTqMqsXqNgbw0HNxHd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD7SU+jv658e9ESmZ0rGeAlIto11Kei8KKQptDC4UFSZ93p7tk
	nDA0OIrWEMHIWHCMm1NF0o27rxSA6MAhXMIwWEG6toVK4dZrLlN6Cy/SGwS8kVeGE+WEK/UuD35
	tXP7DBWg=
X-Gm-Gg: ASbGnctAFviRENvSbHlQhldHZnHk6g25BZpksHp1WV1Pxg8MGqFSTxIDUKxQ1snieEB
	XtaPPNA1MBVUI1Y5Pdri98yVzUwI+WuiXVtkXJH9OjXYKWAwb2WLojHcT4er2Tupgs8iQrXMBqp
	1G5Z7I8lNhZwXtJDRRROKBm3ZXStyqBSyjjTyRCFj8vO5b7aOcG1/RfbDYd2HtdymFRfSyfXn17
	31CxhgdJWkXsA0+IuU+Ol6dhvAqwAzeBH1mJiQR3GofsPA4rXbhFMJ32R0gOM3FhYk/LeEVTyx/
	Ile4gq3RQvP+CCeemXnyEjgsEykhZgB+YCCdbJg+rg1xoxSOXO4mkkSyIGU/8XuOF1RjyS0b2yZ
	GVf/0VZHDJxaouYbtPw57MCrIVMyURsgbjlhD0wK7G+ecRZPMlFIdkYUqGAHIUbKWXwisBQb4lF
	0Ni+7vGdqELzW06oMRi/1NHTc=
X-Google-Smtp-Source: AGHT+IELJS/VgypvwZW3x15YFnjuVZsztTcNQMZAL82gjJINOSASLLTt97YgOiFDqSjEkK/zD14XKQ==
X-Received: by 2002:a17:906:4788:b0:b0c:fdb7:4df5 with SMTP id a640c23a62f3a-b50aa08f7f4mr2795931866b.18.1760443888992;
        Tue, 14 Oct 2025 05:11:28 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c124a8sm1137870666b.51.2025.10.14.05.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:11:28 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 14 Oct 2025 14:11:18 +0200
Subject: [PATCH] arm64: defconfig: Enable configs for Fairphone 3, 4, 5
 smartphones
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-arm64-defconfig-fp345-v1-1-53fe1eeb598d@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAOU97mgC/x3MQQqAIBBA0avIrBtQs5CuEi1iHGsWWShEIN09a
 fkW/1conIULTKpC5luKnKnBdApoX9PGKKEZrLaD0cbhmo/RYeBIZ4qyYbx6N2DomVjTaMh7aO2
 VOcrzf+flfT+w4o5PZwAAAA==
X-Change-ID: 20251014-arm64-defconfig-fp345-d3ece0c61c88
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760443887; l=6339;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=h5OUnC0qS1XyOkwz0rbMd9zjA2g5kjfcThDxR8eek/Y=;
 b=deFmsDMb3hA9OV2nip8NJEM7jqpCU5NQmHJss5z5D0EMbjhCjVDZl1lJyk+DKb/IyHzUXSsJ1
 wDYP1Z7dINBCr0OdBz/nIfkdIwjViGrHtogISKWU3DfEOipM+LpvVf4
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Enable base options for MSM8953 and SM6350 SoCs and device-specific
options which are used on the Fairphone 3, Fairphone 4 and Fairphone 5.

* MSM8953 SoC
    MSM_GCC_8953, INTERCONNECT_QCOM_MSM8953
* Fairphone 3
    NFC_NXP_NCI*, TOUCHSCREEN_HIMAX_HX83112B, DRM_PANEL_HIMAX_HX83112B

* SM6350 SoC
    SM_CAMCC_6350, SM_DISPCC_6350, SM_GCC_6350, SM_GPUCC_6350,
    SM_VIDEOCC_6350, INTERCONNECT_QCOM_SM6350
* Fairphone 4
    DRM_PANEL_HIMAX_HX83112A

* Fairphone 5
    DRM_PANEL_RAYDIUM_RM692E5, TYPEC_MUX_PTN36502, INPUT_AW86927

* QCOM PMICs (used on multiple of the devices)
    BACKLIGHT_QCOM_WLED, MFD_QCOM_PM8008, REGULATOR_QCOM_PM8008,
    LEDS_CLASS_FLASH, LEDS_QCOM_FLASH

* USB audio offloading (enabled on Fairphone 4 & 5)
    SND_USB_AUDIO*, SND_SOC_USB, SND_SOC_QDSP6_USB, USB_XHCI_SIDEBAND

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/configs/defconfig | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e3a2d37bd104..90a26dce8639 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -211,6 +211,8 @@ CONFIG_NET_9P=y
 CONFIG_NET_9P_VIRTIO=y
 CONFIG_NFC=m
 CONFIG_NFC_NCI=m
+CONFIG_NFC_NXP_NCI=m
+CONFIG_NFC_NXP_NCI_I2C=m
 CONFIG_NFC_S3FWRN5_I2C=m
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
@@ -465,7 +467,9 @@ CONFIG_TOUCHSCREEN_GOODIX=m
 CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI=m
 CONFIG_TOUCHSCREEN_ELAN=m
 CONFIG_TOUCHSCREEN_EDT_FT5X06=m
+CONFIG_TOUCHSCREEN_HIMAX_HX83112B=m
 CONFIG_INPUT_MISC=y
+CONFIG_INPUT_AW86927=m
 CONFIG_INPUT_BBNSM_PWRKEY=m
 CONFIG_INPUT_PM8941_PWRKEY=y
 CONFIG_INPUT_PM8XXX_VIBRATOR=m
@@ -803,6 +807,7 @@ CONFIG_MFD_STM32_LPTIMER=m
 CONFIG_MFD_STM32_TIMERS=m
 CONFIG_MFD_WCD934X=m
 CONFIG_MFD_KHADAS_MCU=m
+CONFIG_MFD_QCOM_PM8008=m
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_AXP20X=y
 CONFIG_REGULATOR_BD718XX=y
@@ -828,6 +833,7 @@ CONFIG_REGULATOR_PCA9450=y
 CONFIG_REGULATOR_PF8X00=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_PWM=y
+CONFIG_REGULATOR_QCOM_PM8008=m
 CONFIG_REGULATOR_QCOM_REFGEN=m
 CONFIG_REGULATOR_QCOM_RPMH=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
@@ -934,11 +940,14 @@ CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_SIMPLE=m
 CONFIG_DRM_PANEL_EDP=m
 CONFIG_DRM_PANEL_HIMAX_HX8279=m
+CONFIG_DRM_PANEL_HIMAX_HX83112A=m
+CONFIG_DRM_PANEL_HIMAX_HX83112B=m
 CONFIG_DRM_PANEL_ILITEK_ILI9882T=m
 CONFIG_DRM_PANEL_KHADAS_TS050=m
 CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_NOVATEK_NT36672E=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
+CONFIG_DRM_PANEL_RAYDIUM_RM692E5=m
 CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
 CONFIG_DRM_PANEL_STARTEK_KD070FHFID015=m
@@ -992,6 +1001,7 @@ CONFIG_FB=y
 CONFIG_FB_EFI=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_BACKLIGHT_PWM=m
+CONFIG_BACKLIGHT_QCOM_WLED=m
 CONFIG_BACKLIGHT_LP855X=m
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
@@ -1001,7 +1011,10 @@ CONFIG_SND=m
 CONFIG_SND_ALOOP=m
 CONFIG_SND_HDA_TEGRA=m
 CONFIG_SND_HDA_CODEC_HDMI=m
+CONFIG_SND_USB_AUDIO=m
+CONFIG_SND_USB_AUDIO_QMI=m
 CONFIG_SND_SOC=m
+CONFIG_SND_SOC_USB=m
 CONFIG_SND_BCM2835_SOC_I2S=m
 CONFIG_SND_SOC_FSL_ASRC=m
 CONFIG_SND_SOC_FSL_MICFIL=m
@@ -1025,6 +1038,7 @@ CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_MESON_GX_SOUND_CARD=m
 CONFIG_SND_SOC_QCOM=m
 CONFIG_SND_SOC_APQ8016_SBC=m
+CONFIG_SND_SOC_QDSP6_USB=m
 CONFIG_SND_SOC_MSM8996=m
 CONFIG_SND_SOC_SDM845=m
 CONFIG_SND_SOC_SM8250=m
@@ -1117,6 +1131,7 @@ CONFIG_USB_OTG=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_PCI_RENESAS=m
 CONFIG_USB_XHCI_RZV2M=y
+CONFIG_USB_XHCI_SIDEBAND=y
 CONFIG_USB_XHCI_TEGRA=y
 CONFIG_USB_BRCMSTB=m
 CONFIG_USB_EHCI_HCD=y
@@ -1188,6 +1203,7 @@ CONFIG_TYPEC_MUX_GPIO_SBU=m
 CONFIG_TYPEC_MUX_IT5205=m
 CONFIG_TYPEC_MUX_NB7VPQ904M=m
 CONFIG_TYPEC_MUX_PS883X=m
+CONFIG_TYPEC_MUX_PTN36502=m
 CONFIG_TYPEC_MUX_WCD939X_USBSS=m
 CONFIG_TYPEC_DP_ALTMODE=m
 CONFIG_MMC=y
@@ -1232,12 +1248,14 @@ CONFIG_SCSI_UFS_EXYNOS=y
 CONFIG_SCSI_UFS_ROCKCHIP=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_CLASS_FLASH=m
 CONFIG_LEDS_CLASS_MULTICOLOR=m
 CONFIG_LEDS_LM3692X=m
 CONFIG_LEDS_PCA9532=m
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_PWM=y
 CONFIG_LEDS_SYSCON=y
+CONFIG_LEDS_QCOM_FLASH=m
 CONFIG_LEDS_QCOM_LPG=m
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_DISK=y
@@ -1386,6 +1404,7 @@ CONFIG_IPQ_GCC_8074=y
 CONFIG_IPQ_GCC_9574=y
 CONFIG_IPQ_NSSCC_9574=m
 CONFIG_MSM_GCC_8916=y
+CONFIG_MSM_GCC_8953=y
 CONFIG_MSM_MMCC_8994=m
 CONFIG_MSM_GCC_8994=y
 CONFIG_MSM_GCC_8996=y
@@ -1425,22 +1444,26 @@ CONFIG_SDM_VIDEOCC_845=y
 CONFIG_SDM_DISPCC_845=y
 CONFIG_SDM_LPASSCC_845=m
 CONFIG_SDX_GCC_75=y
+CONFIG_SM_CAMCC_6350=m
 CONFIG_SM_CAMCC_8250=m
 CONFIG_SM_CAMCC_8550=m
 CONFIG_SM_CAMCC_8650=m
 CONFIG_SM_DISPCC_6115=m
 CONFIG_SM_DISPCC_8250=y
+CONFIG_SM_DISPCC_6350=m
 CONFIG_SM_DISPCC_8450=m
 CONFIG_SM_DISPCC_8550=m
 CONFIG_SM_DISPCC_8750=m
 CONFIG_SM_GCC_4450=y
 CONFIG_SM_GCC_6115=y
+CONFIG_SM_GCC_6350=y
 CONFIG_SM_GCC_8350=y
 CONFIG_SM_GCC_8450=y
 CONFIG_SM_GCC_8550=y
 CONFIG_SM_GCC_8650=y
 CONFIG_SM_GCC_8750=y
 CONFIG_SM_GPUCC_6115=m
+CONFIG_SM_GPUCC_6350=m
 CONFIG_SM_GPUCC_8150=y
 CONFIG_SM_GPUCC_8250=y
 CONFIG_SM_GPUCC_8350=m
@@ -1451,6 +1474,7 @@ CONFIG_SM_TCSRCC_8550=y
 CONFIG_SM_TCSRCC_8650=y
 CONFIG_SM_TCSRCC_8750=m
 CONFIG_SA_VIDEOCC_8775P=m
+CONFIG_SM_VIDEOCC_6350=m
 CONFIG_SM_VIDEOCC_8250=y
 CONFIG_SM_VIDEOCC_8550=m
 CONFIG_QCOM_HFPLL=y
@@ -1719,6 +1743,7 @@ CONFIG_INTERCONNECT_IMX8MQ=m
 CONFIG_INTERCONNECT_IMX8MP=y
 CONFIG_INTERCONNECT_QCOM=y
 CONFIG_INTERCONNECT_QCOM_MSM8916=m
+CONFIG_INTERCONNECT_QCOM_MSM8953=y
 CONFIG_INTERCONNECT_QCOM_MSM8996=y
 CONFIG_INTERCONNECT_QCOM_OSM_L3=m
 CONFIG_INTERCONNECT_QCOM_QCM2290=y
@@ -1734,6 +1759,7 @@ CONFIG_INTERCONNECT_QCOM_SC8280XP=y
 CONFIG_INTERCONNECT_QCOM_SDM845=y
 CONFIG_INTERCONNECT_QCOM_SDX75=y
 CONFIG_INTERCONNECT_QCOM_SM6115=y
+CONFIG_INTERCONNECT_QCOM_SM6350=y
 CONFIG_INTERCONNECT_QCOM_SM8150=y
 CONFIG_INTERCONNECT_QCOM_SM8250=y
 CONFIG_INTERCONNECT_QCOM_SM8350=y

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251014-arm64-defconfig-fp345-d3ece0c61c88

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


