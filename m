Return-Path: <linux-kernel+bounces-701957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6EBAE7BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 11:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D483ADAC5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 09:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC292877CB;
	Wed, 25 Jun 2025 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="LA8l7xCC"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D203281357
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842702; cv=none; b=Ek6Ot+aYAa1qRfH18nJBCCtlxdCvLTAP5i6d+zUMiDm9OPtQtIJR6e1QYet/BVN19DlpckK9HSUFQqAclkKSDlc57KVkfnxfPOZV2ld36IBMbVEOL2Y1pogXHLF9WSOuf5X7azkVbP68CBNJ/esg+io5ULlSg0s359OR19c7Ge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842702; c=relaxed/simple;
	bh=20OgU07hYw0BKvki0Oaix0JpyTN3z8RUI0obpczt4ZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aQ12Z2FaiewCMkDMp+bpY0Y5fZVnu/7bg2Wr5/RYlVPFj0lmUc2TH4WmcSz9C6GqnL7ND7IoJeiBXwmxalFV+CACFo0Wa0oDNQbf8PNNAEbb1SMy8w1Ulo979voZzuQxPtnXWdZhnyKR9LdIsBypoALOR77ntQhIJmsAhPmSOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=LA8l7xCC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso2608026a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 02:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750842699; x=1751447499; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uMKYOxxD7UdxTP/ee1363S4GDcIjdo0gX+UMgMSM07M=;
        b=LA8l7xCCcO9COtBMNSD+0HzPlMsC9vYezNo01bYnblQcNA/yCbIrI434lsJidHFI8Y
         Y7OhoTnd4TNZBOL4BO5UFhv/foxW/3kSTV2J2UjQqpyg7jdCtsPKf45y1uOj7aaIvkbw
         ezs9VH6Lp2woTb3+/h0F7EB+aENYptXVroPkLD9v9jVQl3+V+9rJYE+tcpxYI0xvUNil
         AwpWximdECgYzl5yFGKngL6/tGQSx303sBbgOUUP2iWV8zv0OL2HjKTK2MgxcnWBYqFl
         B9Dm7SqufpC2sva7t7vHQmxQcARIQLwNZC0oMM3wQ4o01bEMcuF6Bijljmcfg36CNRTo
         tIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750842699; x=1751447499;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMKYOxxD7UdxTP/ee1363S4GDcIjdo0gX+UMgMSM07M=;
        b=WHlIbtHTYJNydkuRgxqkW9mnQyrmcd4Vc4jgpao9XknIPLAb9H5HxNO3fxhiYQ90KZ
         YR07EpwD0IqXaRsjG7cQ/IjV8rNKF3WBSbtiWOlrDRsvMIQMoTgRFNl5cfyIWBPsOyIq
         FSdquOzULc3/X0w1wZEcPF+P1L55HnXG74S7LVv5hND4SUeKrDXfiaT5sSwAdP/aOw9L
         WVgPdrXjsUogvRYjWObH9PjbuJv3aHTODBxFlYcFzUYEcLo/E1FaqFtmW86nH3kUXtn9
         uOLRdVLGNTB/JdGCs/7LHzW61J/ooUq93adFOi3gx+YI3RmKV9DQIkYtxRBOxVgrmGrG
         LgBg==
X-Forwarded-Encrypted: i=1; AJvYcCV09QDWiM/QdEcs9qQYji1GwuCGJSrOe0SXCb3jg9JR9bDQB9cypsk2eSMYwZBst9gAePDafj9EtoBapcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxW7UJGjWte928gfCrofOyWNkKgFy+WDws7J0PsfO+huiNYGdF
	oYmOsHENc8rE/5wgdy3gHji7TH4zwCfwMiBqJEG9RvThj/TQfz4WI5TegVyzTYozI64=
X-Gm-Gg: ASbGncuz7g55FNo2rmsPnx6K94adPwanMIxk4h6D78+5oeN0wGtNIwEDKmRHwtZGCyL
	1LnKLTPmvATxjHItzISZ86fP/3sid+wVOQBlRPXbcEuBkaREEAydpe0OvngtL6nLli1286DR7k+
	yqWUkJh9ET8+sagRPQVAlQ12XA2fzH5Xw41/iqwmjvHjd2SMdgvTQxoSxZAycXFLhZvLTKLDWVf
	BJn4iHANhzCgM9Bq3Aq+JuOmmTOSh/c1hoivGP9uW2ToheZrc4KqF8TTm7Y92WWb6JOchgNK5po
	h4oaILZvgI+uok5/tz5MEqVEOR1fR9q5D/vpZX/8FlEXjgfSbAXT+T8dTub7Ncec3qEtznDjbsk
	4JTHkcsulheXEQU/zVv5VFeN2uauMGhSW
X-Google-Smtp-Source: AGHT+IEc7/hN2f9cmghjg+sMULShIBvhh5KvCrY+8l12A4p/2NB5EXrD1TehNzU0qc52lkbGcpeGcA==
X-Received: by 2002:a05:6402:2b95:b0:601:89d4:968e with SMTP id 4fb4d7f45d1cf-60c4ddc2ec6mr1441560a12.27.1750842698815;
        Wed, 25 Jun 2025 02:11:38 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f485d0asm2167101a12.64.2025.06.25.02.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:11:38 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:11:25 +0200
Subject: [PATCH] arm64: dts: qcom: pmk8550: Correct gpio node name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-pmk8550-gpio-name-v1-1-58402849f365@fairphone.com>
X-B4-Tracking: v=1; b=H4sIADy9W2gC/x3MTQqAIBBA4avErBswzf6uEi0kxxoiE4UIpLsnL
 b/FexkSRaYEU5Uh0s2JL1/Q1BWsu/EbIdtikEJq0UmF4TwGrQVugS/05iRUzkhS7Wh110PpQiT
 Hz/+cl/f9AJE4wKNjAAAA
X-Change-ID: 20250623-pmk8550-gpio-name-3fa2e349d567
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750842697; l=992;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=20OgU07hYw0BKvki0Oaix0JpyTN3z8RUI0obpczt4ZI=;
 b=wdifaQe+6/HlEDQF8LAH/wkqmOA1J/D1j9RVM28OKGvP2EQPBSEIw3ic+R9Uf3/dOocYrdNGd
 OSrCrGT94wkBZ+fFM6Wdza3osAI0Fsm92N1CGDGA6RUbsmWs90PSKxp
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

The reg for the GPIOs is 0xb800 and not 0x8800, so fix this copy-paste
mistake.

Fixes: e9c0a4e48489 ("arm64: dts: qcom: Add PMK8550 pmic dtsi")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pmk8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pmk8550.dtsi b/arch/arm64/boot/dts/qcom/pmk8550.dtsi
index c7ac9b2eaacfe6e8363448d9d2ffb4ac8f5f4dd2..583f61fc16ad570972ac166aef12183382ebb4c5 100644
--- a/arch/arm64/boot/dts/qcom/pmk8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8550.dtsi
@@ -64,7 +64,7 @@ reboot_reason: reboot-reason@48 {
 			};
 		};
 
-		pmk8550_gpios: gpio@8800 {
+		pmk8550_gpios: gpio@b800 {
 			compatible = "qcom,pmk8550-gpio", "qcom,spmi-gpio";
 			reg = <0xb800>;
 			gpio-controller;

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250623-pmk8550-gpio-name-3fa2e349d567

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


