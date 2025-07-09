Return-Path: <linux-kernel+bounces-723536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C321EAFE82C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017034E6624
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFE62DECB7;
	Wed,  9 Jul 2025 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="u+xMDE7L"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B02DA74C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061615; cv=none; b=hAN1VoAnVD+lRSzauEaftu6Tas49aQkkN2sX3atTZP/TcS20ymDLb8PcU705x5hFrxS1yGlWx+A1mCVoqr5ucqUwo/mt6Oaf9DbttLuO5qB6X6ONKJTVU8q2rmI+12PJROITM75xsJitsyNBMO6k1GWtrfoB9pbpb/95has2PAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061615; c=relaxed/simple;
	bh=hC4XiUyCXvfKUfUdujggOXgHdLNV4lf1H8qLCscQ3Zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gTvhVwjWtf7Y1Gc5MzqT+PfoCqlyt6Q+JaF3d4qe1FfYKbNh+Jud/XIJ1un2F7Y9eGgWgYiCgv/SYAoGgOgfIUyup31D2UPtZ5UZYzYVXt9pu0qB+W4TS9JXHHcMj5C1TYywp412GYosQShhSrvwxrorEIkdtNrEQR8rYonQiQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=u+xMDE7L; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c5b7cae8bso8850635a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752061609; x=1752666409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bpa1qe4qe1U2tW+ccEjSHAObelYY5h6LZZSGvF+pGw=;
        b=u+xMDE7L0X3yoC4TxKZQvTud3oIy5LyXnoSeMEHz+v+9PjCqZnmkMHCSi4NTmBXxbU
         6Z3GE2APvlyDmqvoIzH8ohA/qOxz1FBCAJz7yN637L4WAnSUImeL87RqZ0GnuX2mdT6v
         AhPov5DkFGPPHXsQCRWiRajKyz0W+x7ZuXSCZUMSBIMvUaGUScJ6CG9xToal7gE8+k9p
         5h+oAm72VIWgQnwS31O+AS1ezIYUudUNO03QVY2vROv4tyaPpHIKxUcLl3Q3FML6BFdY
         LVlh0Q5za5gdLYYTXY5uyc5ZqFpmF65ma+J70yQi8yW2qlOx4gHC24JySM+UTeQGNcSr
         8ZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752061609; x=1752666409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bpa1qe4qe1U2tW+ccEjSHAObelYY5h6LZZSGvF+pGw=;
        b=KT2Oqh4w8+x4QzXxyior8zICPZjsx4OzWK77Bv4jvpUJjnGBiX9Mw43QD3haImkAPm
         ERIMnLP0gDWjviM9lZdQP+YSHPbmX/U5Zz95cMooMtK0g6cyx/nNYs7TMBc042kbMkJX
         PCoMHI4OIthYV//SHlhM6VRqZbLY/Wod5jUzXaspLd8KEXW79fTWhIfKb5XuL4y7topC
         7bICxGB0ofdQU2xPEJ8TCOmPbnRE2KdJCc2lF29UPAE7iE/KF8Z1rolWWwK05uyi79SF
         evImgF+mfz+OOCMNYotcvXblDYjkuq81j2DeTlqzJoL3cmZpemZKoH9vOEorqNMVT5tr
         NlTg==
X-Forwarded-Encrypted: i=1; AJvYcCX88Blxe8SRpyoJryn92f7Eo7ElRTAniC+K89ubVgZuDxHzknIGDCFYXr2EIAf4pqVfFw4ynkVYAV+kycE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Q9J9FrJcNsepiY8Tc+FbuxzaRSCiB+QBrHAtSrPdBxdqg/rF
	nRoErAZj6yV7L+PK5hZxo49CxNQvglxt0JnjMbblk/aMN5MUltGa6I6MBg/oSM6/axY=
X-Gm-Gg: ASbGncublaXwLOzPn1NuzO8ELFx0/voID9fGe+J0DLxjm6fE0GHrRZoK4P5v9Y1GC3y
	u9HGeSQW3qA3ifPK9Zo5jk09Q59LomqR0wgUx+ulrOhlKuC11zhEKrqBatu+6siYAX4z+8FQHaf
	XiUSDZZSv6bt6BRDNrEMYci2D52OyV14w5oi1ch7QMT1RiQMQ6aQcf0nW6iOGrzyJmf8kP+s84A
	BgsLEWDII4SyyZOSQeDcqPXh2jy0AlnhmWMnqb+8xXmNfN5N4LJ9Yb7TjAZgdpq5cyA/Mzwdknx
	/63bURWnWvcEBLedLxVYmBRDS6V/oFDoR7nC/z4PzJwRG0/PH/7NHkVZqGYElZGWA5kmWgqY+hO
	KpDwaY5krmKpZxUJGy83DruJ1I9827IQM
X-Google-Smtp-Source: AGHT+IEa3VxKGGtmpJqSqUpaGE5jivuUSxb7qkbnXKu41EclZPptdV4vVLyJP7ntg8X8h5wcm0ceXQ==
X-Received: by 2002:a17:907:c283:b0:ae0:db23:e3e3 with SMTP id a640c23a62f3a-ae6cf5c0132mr248175366b.16.1752061609399;
        Wed, 09 Jul 2025 04:46:49 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f692e4ecsm1102995266b.55.2025.07.09.04.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 04:46:49 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 09 Jul 2025 13:46:36 +0200
Subject: [PATCH v2 5/5] arm64: dts: qcom: Add PM7550 PMIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250709-sm7635-pmxr2230-v2-5-09777dab0a95@fairphone.com>
References: <20250709-sm7635-pmxr2230-v2-0-09777dab0a95@fairphone.com>
In-Reply-To: <20250709-sm7635-pmxr2230-v2-0-09777dab0a95@fairphone.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Fenglin Wu <quic_fenglinw@quicinc.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752061604; l=2089;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=hC4XiUyCXvfKUfUdujggOXgHdLNV4lf1H8qLCscQ3Zg=;
 b=h+IOj2hBQ3I6W+a+vQJaatA2VbxLX/L6dXEb4kRe5+aHbi3nsUWGLE9ZKVDSnGLxp5qWzVFcG
 c3PpiaHPXufAZcvursiA5Rs+k8oJGNcZ1iri5Kab6VB9Dbrbl1zMCRE
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a dts for the PMIC used e.g. with Milos SoC-based devices.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pm7550.dtsi | 67 ++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm7550.dtsi b/arch/arm64/boot/dts/qcom/pm7550.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..b886c2397fe735edc92f2c3f307eb4d206961f11
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm7550.dtsi
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025, Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	thermal-zones {
+		pm7550_thermal: pm7550-thermal {
+			polling-delay-passive = <100>;
+
+			thermal-sensors = <&pm7550_temp_alarm>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					/*
+					 * Current Linux driver currently only supports up to
+					 * 125°C, should be updated to 145°C once available.
+					 */
+					temperature = <125000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
+&spmi_bus {
+	pm7550: pmic@1 {
+		compatible = "qcom,pm7550", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm7550_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm7550_gpios: gpio@8800 {
+			compatible = "qcom,pm7550-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pm7550_gpios 0 0 12>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		pm7550_flash: led-controller@ee00 {
+			compatible = "qcom,pm7550-flash-led", "qcom,spmi-flash-led";
+			reg = <0xee00>;
+			status = "disabled";
+		};
+	};
+};

-- 
2.50.0


