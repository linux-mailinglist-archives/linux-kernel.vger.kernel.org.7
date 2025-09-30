Return-Path: <linux-kernel+bounces-837789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B896BAD2FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA1A3C1FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4CF3043CC;
	Tue, 30 Sep 2025 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="4yngYK1t"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423F6214A8B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242758; cv=none; b=UbIF2BO78//PFxYqCH4YMfCh5PqrhXt9rLx0I2ggofYXfvFOCfTWkWyTCn6zBDArADG80P79SiyzpxFcvslDZuDkGZJ3oTmPSXj66TR7JiFhqO+fWO1EXMmjLJZtujH6JvuFFYnjc3VD77NhixtodxY/M2okEA3mM21L8im5LSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242758; c=relaxed/simple;
	bh=e33Ua60plf36TGZ8AqkpnW6fFz1iOr2OCUIOOUwqFxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IZmVBhGiZB0McUu4erzjDILFXWEYrgbplsIzJyu7bgcO6zDIVOl12sfcoH1REsy0xsO4GsX4NRhqgpXlvw39InlOSLLEpIoXyTOqvtegWCNv3FGj8AdnwshBkOXhe1/z8pnz84qhs1/Up95dtuI6yOvYh0l1VDah0zmCqSGs7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=4yngYK1t; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63667e8069aso1521219a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759242754; x=1759847554; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIXFkHTmTBNdoxIiGuiXY5Mb/iVkGyXh19PiQ5Z7rqw=;
        b=4yngYK1txH4CiwIHx7cTJTv8qMwBRP5wznfEtNYWAAWxDTExd1ieTWuQvp6mcLkqpM
         Q15XYAZ7GtE9WzwWhtAfZj8bMt0LhuuzGnaQp5+1wiDkrqCa/6JzMPbJzz9FbTga/0qp
         9/j+2H9e3Ve9dSvHF4yiiIzrhXXZ06WUYVHO/DQb8rqIQ7tekvWttW9Y7MWbDQ1/1UBH
         2hM75zMfneGfyvsWApdPQxm1ph0QzFwnV8yT2gvICe94nU42aaTiMJK8KtUyThP+ZRUu
         Q4jIitb1SgPUZhJhErUejthTkwCO41lk20Y/v8KUxdFX61BDMAcxTQfgOiHo/jIgpUXb
         /FWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759242754; x=1759847554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIXFkHTmTBNdoxIiGuiXY5Mb/iVkGyXh19PiQ5Z7rqw=;
        b=vMHxyHG0OdMcp0f3Pb7z9ASsbACZvbtUv6PH/yQm87B1BE8Euzu/E7407ubXFPJG2Y
         LhAq7HtUvdrNgirQGly8CsqcMI0496H0pnYWFYN+Mq+3k8d+1fV9L90RbvSu/N2HTkrn
         fEWRDyXJqKecyYXskaV44GvnxO4Acj8aGPwaxGHrxB+sNk1B6ftQdlbDi/bX10xBmyra
         dgKSbGxriGsJD2j6olQYQOl1aVOE55hz90VkTmceGE1bzkUlQwtDte7b2UkVlRqUIely
         p/5DugoVcT5pc3lpW1FwApRnJRoTnskz9TDsl7pGRdaWPYNzNCoEhdnN67y2preGvQpc
         SRwg==
X-Forwarded-Encrypted: i=1; AJvYcCV4BXiTdqRlOX1iIHBFONZntufBvKjqpoctK1g94jI6Yv7dDh/Ge9Cqd3d1eKDyM7Gv7+qE5drvYfjhAvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxD2DVGHnhauLv9STVhS8Edxp3GH3PShRuI8F50ypbQWFM55wO
	au+cPuDgPlnVCjaza3UVNYFKe1wMl+WTH7mchjZoXID8f8MXuMSuL4Ndk5Esk7aTDUM=
X-Gm-Gg: ASbGnctVmDnRiich12s34pPeKyODHt3HzrmbOqOqcQEPL8w6k282sBp/Jn6fH0y8vt6
	UIpSm6YWh28XOdL9f/W7Xr7Gv1Bmloj75u0cHNrVffYCt0kkUcOZb9hq/rStux70MDwAO//wSAh
	TazLPgRG8X1XAmqiEQloXjtQqFejZ0QVl+p/xbYCHZhOdIZRIWzsP1P/qveM1akq46hyotk5h/X
	/lFCjD3/NMuTZsy+Gp6gzVETX6vi0O6/secItzVwm8zg4mMfQgpuDPPjNNNvMSrE6MBQzPzk7Zd
	7zqr/LSQ7eYPchHm7dTzVUmop6p3WupDb49QhJeiAbIJwPHca0Udmp1XyOqCQ0EQIzZcmoL4Nuj
	iwH+D8T4i4kIrvj1fXy+3M86oz2fIhpAidw4jBww24wdQrLwDSdq+MLBCrAGTiKnB00PHUz4Jx8
	+nTQimiQNTrkFKA3NIlM8jGEE38MaH
X-Google-Smtp-Source: AGHT+IF4zIeQ3qsHZ3+7UkuA/aOdurdD1kBt+SKdxxprt50KcUOpEsL/VmP3CuG2akjIJLRWC6zMMQ==
X-Received: by 2002:a17:906:9b52:b0:b3e:1400:6cab with SMTP id a640c23a62f3a-b3e140077cemr768626066b.17.1759242754466;
        Tue, 30 Sep 2025 07:32:34 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3dc2cf61dbsm499858466b.29.2025.09.30.07.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 07:32:33 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 30 Sep 2025 16:32:19 +0200
Subject: [PATCH 1/6] arm64: dts: qcom: qcm6490-shift-otter: Fix sorting and
 indentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-otter-further-bringup-v1-1-7fe66f653900@fairphone.com>
References: <20250930-otter-further-bringup-v1-0-7fe66f653900@fairphone.com>
In-Reply-To: <20250930-otter-further-bringup-v1-0-7fe66f653900@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Alexander Martinz <amartinz@shiftphones.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759242752; l=1473;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=v6xz/ZGwlg/QGlKUsUnQN36bAJwH/12cvFwX4EAV52I=;
 b=i4zuAYPuetFXrwGGozmgWJMqu0/p6T19lPn9Mw22TYB9UCGPqRugYCz9/k18mXnwUbkTDkMGp
 /WXsZdhO6SYC/NFQ30eCPSEPTu8dCpDT+g2/wr3ktFUkmwsMCKeGG+V
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

From: Alexander Martinz <amartinz@shiftphones.com>

Make sure the nodes are sorted correctly, and the indentation is
correct.

Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index eb8efba1b9dda422dd0295db2a52420a1a23d070..8d45e6ac0e445b9e20bb9c1520f804623c505653 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -857,7 +857,7 @@ &uart5 {
 &uart7 {
 	/delete-property/interrupts;
 	interrupts-extended = <&intc GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>,
-			<&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
+			      <&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
 
 	pinctrl-1 = <&qup_uart7_sleep_cts>, <&qup_uart7_sleep_rts>, <&qup_uart7_sleep_tx>, <&qup_uart7_sleep_rx>;
 	pinctrl-names = "default", "sleep";
@@ -920,10 +920,6 @@ &usb_1_dwc3_hs {
 	remote-endpoint = <&pmic_glink_hs_in>;
 };
 
-&usb_dp_qmpphy_out {
-	remote-endpoint = <&pmic_glink_ss_in>;
-};
-
 &usb_1_hsphy {
 	vdda-pll-supply = <&vreg_l10c>;
 	vdda18-supply = <&vreg_l1c>;
@@ -950,6 +946,10 @@ &usb_1_qmpphy {
 	status = "okay";
 };
 
+&usb_dp_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss_in>;
+};
+
 &wifi {
 	qcom,calibration-variant = "SHIFTphone_8";
 

-- 
2.51.0


