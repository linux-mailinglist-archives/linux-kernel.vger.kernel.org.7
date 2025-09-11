Return-Path: <linux-kernel+bounces-812707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE8FB53BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE4D18852A7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAD936C087;
	Thu, 11 Sep 2025 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SXSyy+Bj"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952032DC788
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615931; cv=none; b=cyTl5RXmMPeyutAhw0UHgTJa43TQ/EMlFIBnlAlvsld9d1LMkNd+jpYjDmlnRCffece2UfzY8w5/Y8lEWDsyRXz9+555I8f7jNuI3tMAQfPH4N1J280AISeA6rG2hpd6LVrBJGkLpYQeskih7wxNe6LgRPqOu0GJ/muZZginVlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615931; c=relaxed/simple;
	bh=GkJ7M1IZYdSsPo+i7feYGJCc1WqaRmYrlPizjbHaxNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SzVZOFICW80kNDmzsDMIVhHW9zaVM4adADGMyjFFCiU1Bds1dTUuscq47PuHizIovxHO1qIGbs0Dca2oGHOUpWmjxsbzwoqSwPypbwAKrL2tAf+f6X7a1L+JutPVSc0G2bWw6dmo33M6N+eltUtXThZ6A07/nsJI6J12UGfYJfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SXSyy+Bj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7322da8so205861066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757615928; x=1758220728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbF8zTx95VP3sh7yY39VofhyD/D+G5JJGtohf6m3u/E=;
        b=SXSyy+BjO6HOLlaNq1NHTyx6+WBEcKg3dm+hcDtmUvzvoRRyweIqvl7vV8FANkjdNp
         6UrW90C7ywI4rFE7wGC42pLo080dYHw5tgOchVCWSBwiwJqvlhJv2pi3DcbIp+Aj7zNO
         ye05Ym9aA96DhWRvw2Cfdg4HqhipareLeGm17ZL6w1Mp4vyePlnRRqHpP1hrf9VUFfou
         6yeJtq/qKBUg3iTJsFUywzLBSSdFfh3qZO1b7j1LiujC43S7sqqhgOIY8off/Yq3VnWD
         z14Wdgg7p00ee0u5w95xADOhLWZVMuqW/W1xWdurXPCQfl6xO2adrm+mxFAtUl/Ewdvk
         Nhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757615928; x=1758220728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbF8zTx95VP3sh7yY39VofhyD/D+G5JJGtohf6m3u/E=;
        b=wmAoBRHVka25hzw4y7Hb6l56/p0G1k9RdBdwI59lPqZhT1zrkB2q4S5sVN314dQz/n
         iR9wel3CiwLbuJKT2sfajX/PGjtU+HJJM0xFuHk91Ir6WWyp30foOke//KCkCA/q1Fpa
         etNESVYBDfaOHYBf70ULK5GJ5Cp3ZozDdBZyoCrDPkdbSgOsIhGE8ghlS2wasRqexVX5
         JxZVhWPNdglzjA4ECVVVewRRr+K1WmDYxVKJnDb3eoXlMbscoFtjJGQn8XZBNte8h2Pv
         HxBQElO39CrRaitAyijfMRWJPLu5gNIi8ALTkwYpYOFfZx4gsVExgIIalECcsfdUj1f6
         m1ig==
X-Forwarded-Encrypted: i=1; AJvYcCUwDVU6hXxfpJGOePtGTC83P3gmrFKAKBJs8kQo+ihJNWP8zHp1lgMGV4BqJMl1MHk87o74TWK2Gm7M5X8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz64qwno4cNMaDY9+UhFQ3uTZ1nJpFzNwan5cYPr6+/4nNqd3Ww
	Ye+zEU+v+GtajueELQqk7+DHMhGR5hUpsVrB/PfqRBqE2CcQJ5nSFKG7fJ5iygN8Yp8=
X-Gm-Gg: ASbGncs18fVR63QxIjtlRuC4YI6kZnedjvEqE6H2RxGvQPQWWvNsg5OszEJCZL+HSpq
	l7lcJNvsY+Ld4TMsi/aizVj/w9V09GScOKvIJ45xLQJ4ay49frKbJVTri1s5R5+V3tVWq4cYlYg
	29xL87VAG2/OaS1aPLdT3wW+vLnYp+muSnQoO4PleP0Vb+2rbxFhTmSV8XLVVSqOL2rTxnoxPaB
	KiTVEUi34YmcDL17PWkzTIzXrQ0URk5RqyoUYy30WZ9WY35GRIXZj1qBiUjnrbgVQp3WDe3i9FZ
	ZHaFAA6mZryHXim15Y2w+cQQCbbGKc6TAG/WYEhOslYVa1rovKF/9rjkkLF4IWGZ5IOpLlznbcC
	hhJ7LCR9l+AZoWeGLhoShx/kAhN8ALRHZkA==
X-Google-Smtp-Source: AGHT+IFfRhww7baU6csHq4GdVkirSCrU/VY5yd0yzK5ef9Kv/UEII2ozzsptNvTG8NhJiOdRuVBr5g==
X-Received: by 2002:a17:907:2d1f:b0:b04:9460:c4fd with SMTP id a640c23a62f3a-b07c382915dmr12549466b.33.1757615927861;
        Thu, 11 Sep 2025 11:38:47 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:41:725:1e09:bed1:27ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31715fdsm183999166b.49.2025.09.11.11.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:38:47 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 11 Sep 2025 20:38:27 +0200
Subject: [PATCH 4/4] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s:
 Enable IRIS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-x1e-iris-dt-v1-4-63caf0fd202c@linaro.org>
References: <20250911-x1e-iris-dt-v1-0-63caf0fd202c@linaro.org>
In-Reply-To: <20250911-x1e-iris-dt-v1-0-63caf0fd202c@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2

IRIS firmware for the Lenovo ThinkPad T14s is already upstream in
linux-firmware at qcom/x1e80100/LENOVO/21N1/qcvss8380.mbn, so enable IRIS
for the T14s with the corresponding firmware-name property.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index 23213b0d9582822e9503e4acf18c62d5c8c7867d..0a989e9d3d23146cb9689b68ba6c5779283b3c98 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -967,6 +967,11 @@ touchscreen@10 {
 	/* TODO: second-sourced touchscreen @ 0x41 */
 };
 
+&iris {
+	firmware-name = "qcom/x1e80100/LENOVO/21N1/qcvss8380.mbn";
+	status = "okay";
+};
+
 &lpass_tlmm {
 	spkr_01_sd_n_active: spkr-01-sd-n-active-state {
 		pins = "gpio12";

-- 
2.50.1


