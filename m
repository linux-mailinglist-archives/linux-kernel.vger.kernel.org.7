Return-Path: <linux-kernel+bounces-812837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70754B53D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42021B27EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E102DA750;
	Thu, 11 Sep 2025 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMuLMZfJ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1302D8375
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624230; cv=none; b=gm9eoF+GKdtOrbECDooY6JhFTawEqCmidvHUwFMvlxonGEDJx6+np4fO0V7yYkl5I0x6u8sPB3V/lUGu3hZCR8IVQjSu4OsGWaIMC554Qx9ewfUMCCwKS5D6wLqSqGKwVuqiP9QUEkFj19WRnV/kulQUsaQP4VvlTdBWyzxuRCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624230; c=relaxed/simple;
	bh=nUEAyXgbLn4v9azKT5n1vztEvNCnWVI0bOzq5dWBoz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JBygQPofH+e4icETHaY2lQ3urqbS3o/OtYp9IRXn4cRD05ccjUkjfyzGOZ5J5H0CdkKWUv/htEJxgbw/umWQGILr7adiN4iAoF15F33/X5MJmWC8Y5A+NviaeHBwN+rZr/Gb5Jbejaqf87v4N+6bFxepwDAJC44jZXCeYVnx3BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMuLMZfJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b07c2908f3eso32597266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757624224; x=1758229024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0JmqMyBdGbQ8gI7VodLEj+HaxvKC2psqCBIe1Mn6TI=;
        b=DMuLMZfJNajLmfaPEPIeJslP5wEBbAiy6kG2XpsUU4ilXr/Uiw+bFTqA9gMPqVTnCy
         B/aEBONHFp43C/fatEgZ+tYnFIZMed5ZZKk+676tnPiQNqu/MtxHzN3OG3wcVv7XV4iX
         S9126ms33ZfGkeEdbhIizVmfFrLqy/i4vPbWV9r5GQxRznm1yE9pw4MOzuikkzVMf4uW
         zUPdfi9CUvW8q5iZDLDLbsB8i5L9V9AWxeqTm2UqMuTyRYXDbFHai6NZHTAcogKxegZk
         kfXEtajtuWCCDWbKYhXveNfNTcY/LR2i4Wwk4gxbc4B9FkESTDvsqWqVlfKa9vlBLoiw
         CEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757624224; x=1758229024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0JmqMyBdGbQ8gI7VodLEj+HaxvKC2psqCBIe1Mn6TI=;
        b=Vh7OQaEZH7z4bBf+o8+4rtFzPhylXh/vqp8P+Rcb+1Dceh1EteJhrntL5fUyq84eUY
         B81niZRseR2aeXcNdZXIfB8PQ+s8WGsP5tnio0vNcm39cuLPMXR4jnDmD6oNbuL+tI7Z
         s2AdSkHyIyVtF+zwMivadUL48eITbAbdUk6YwqIQ9p6jUimSlAvMpb7fKLy/8FxS/dHR
         P5Aaida7llDt5YluqS04bsn/saLyaB+GcUeIRoPDo+0zffKqhn5S8gvK9dsYsr5seqYz
         emC1kqBs1IbmLgjy+by6YFs6VAfsH0JonB14ul0nsv8SvxtA+ABHlDaMdJ4vid/hP7vz
         aNlA==
X-Forwarded-Encrypted: i=1; AJvYcCXNacyRVEe74dFBqgrELBGnp1LreLEUnXN0G752CCJ80tLK2mciypHH07VF3u9/PX4s9GhT5Zi7Xgvv4fk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6HrjJkkYvu47xz9Ty4QoZfks3BYnvkMv4reY0bktsEQra7ytl
	oDLQnh4PRosu203vWSTx28+UrGkqd4gHj1/hiw9ZNX0+t468qwGvbITC
X-Gm-Gg: ASbGncua+D05EwQ4C3tvnD0m5cpQd33hkxmXR9jgi3ApFMCIqNNp4hAj6w4TD8yNxcS
	qpAVNe3h4hFlDr5Pg506J82PXxYs9Kew2YiDipbbOCW1CW34kqLENS79JsjN1msRRpiU0kbEk/S
	0SO4faW4NwOwJ+b3f36abEavJQLQIpse6NWtABS67m5W2HiWCCDLbQQ/hjbyqZFiKc/PgJ3DDz3
	rwk+pZmmGLKw/CRwNLIljJ5kAcvohp+f4rxAaIKRE8GbBEUg/f9nT4/2S9orH0iGnT+zwT+4XER
	zny6stT161JtlP6yTW3FymJ/7bac5wW3C6AbM9NTmPWuMUX9VwNARkqcgV3KIKW4BneZ39IrRxv
	sZ4E5mKvzZ3i4N6uDJ9AZeTpl0s6u+c8=
X-Google-Smtp-Source: AGHT+IF32n+ghR2lvp3OruPrYSdGU7Y+rlNr3st/nMIgdWGllWQUKQeSB5kNG3qCsFPT9IxV4Ues/g==
X-Received: by 2002:a17:907:9705:b0:afe:764d:6b22 with SMTP id a640c23a62f3a-b07c347fa5cmr49768566b.9.1757624223756;
        Thu, 11 Sep 2025 13:57:03 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07c28f190fsm38775366b.39.2025.09.11.13.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 13:57:03 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 11 Sep 2025 23:56:57 +0300
Subject: [PATCH 2/2] arm64: dts: qcom: sdm845-starqltechn: add slpi support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-starqltechn_slpi-v1-2-93ebf951a932@gmail.com>
References: <20250911-starqltechn_slpi-v1-0-93ebf951a932@gmail.com>
In-Reply-To: <20250911-starqltechn_slpi-v1-0-93ebf951a932@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757624220; l=1353;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=nUEAyXgbLn4v9azKT5n1vztEvNCnWVI0bOzq5dWBoz4=;
 b=27svf7Ue9vYWwhzsEw473UyOaGIigV5yMC8y292nwZYZx8smqYzOpcLd5YpIxLyOkNEf7ioH3
 7TNd6E/3hIbDI+dM/LRkxqhQEgg05+jN7I+Z7kRmQ/a1S00gttS36VN
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add support for Qualcomm sensor low power island.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 32ce666fc57e..2c1157ee7b2d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -902,6 +902,14 @@ &ipa {
 	status = "okay";
 };
 
+&slpi_pas {
+	firmware-name = "qcom/sdm845/starqltechn/slpi.mbn";
+	pinctrl-0 = <&slpi_ldo_active_state>;
+	pinctrl-1 = <&slpi_ldo_sleep_state>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+};
+
 &usb_1 {
 	status = "okay";
 };
@@ -1028,6 +1036,22 @@ sd_card_det_n_state: sd-card-det-n-state {
 		bias-pull-up;
 	};
 
+	slpi_ldo_active_state: slpi-ldo-active-state {
+		pins = "gpio8";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-high;
+	};
+
+	slpi_ldo_sleep_state: slpi-ldo-sleep-state {
+		pins = "gpio8";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
 	touch_irq_state: touch-irq-state {
 		pins = "gpio120";
 		function = "gpio";

-- 
2.39.5


