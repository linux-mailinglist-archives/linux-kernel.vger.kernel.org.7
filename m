Return-Path: <linux-kernel+bounces-843687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EF1BBFFF9
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 04:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D4B3C1F39
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 02:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25B538DDB;
	Tue,  7 Oct 2025 02:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IecgktYQ"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40908198851
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 02:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759802620; cv=none; b=c6Cx2uQn5AkcdJ8RUnIDsXAXKQzH9wIkvpNGpEJrMFEgGlw76d60AQtZtLAOYdKLSVpHOnCSOKmNMfRV/yM9ZWQNJ1Yvzt2bCacyDKqk+d9H2/Hm33sc7nnaJxddHc12p0oZDtHBHA2gypOUvReMznFqYoj3fgou9AS9d+3S9Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759802620; c=relaxed/simple;
	bh=RfNhaWLGRbdtrrGIfEYuYyqtlcjyyzdYih9p4WM74xA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eUXj4F/PjBlcfcNNgxe8DDkAk/SNHVlspIaZ75aNNTzdaY4yvyagW/Z3endCCV/djucARjJOhYMm+mqkTrGmez9naml8Jfne3BRRSWr2BxK6B0+I73zT1xJ3obQGPuMoWqth/+XV0ipoAhH+lcKS35Q+fr3E4ZFhWIWczpWDCIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IecgktYQ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57b35e176dbso7365636e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 19:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759802616; x=1760407416; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VVH75F2PB/hIhg3pTapevcz0FU+YjPLlBiSBEKhJKRI=;
        b=IecgktYQl++qRNXzeTovCp4QDkRypmJIrslJ7jvqg9PIf+gCZBXOLyeZq/PI0SheHd
         MQksw/qoCd/k1nzCx6+dw5HnOfqo653R2za10O7NIXuFP95v+CSflYUn4dISPOig1C6X
         /TX6/04tl/KelWFOS02I8o2m1n+VWeknVAq+e7JA4TrJwGvQWRAcpKMki/MfMewVXHAM
         PB8k2oTQFEI+4MdGcS2zWU3C6R4WjRaGCnE+PghKDoL6CFnxgW5FlN2BguwpNel6N2P7
         NHtyIpxwLHrBvCTXVyG64ePNYlCaZLQy+3q4WI+IpSew/t/OuwuF76OODAzsvRc9eIE3
         EMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759802616; x=1760407416;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVH75F2PB/hIhg3pTapevcz0FU+YjPLlBiSBEKhJKRI=;
        b=YkYfg3of0Z16f3asibIKsxyUp6B62Z/uSsGfNGkkvzrVlRB/o065TchYzuhfFBXEXj
         cGTBo58dDNHic4c3w5mJOiFT2LfsI+v4cKPzQ7JTONRTgJRkL6gqPid8j5Y3q0wunUCO
         ARIta+p9JeOvdEptJc3X1rea/m7whVH643XLCIaitsEuL/1t1KFepDRe/6NFUXoS1xOM
         Ra8hxShha3E6j/lLgfUdi9LpamOccOlrF87vnXwrl7fPdLBgq3o2Qmqb5EE574y1yPFY
         krRKLe7aNzZiQ5Ydf101+xCoMoyaNmbdkHXP/LCt9aufJtOoTwiJzoLyo9hsOcUbNnXb
         1F6w==
X-Forwarded-Encrypted: i=1; AJvYcCV41QI0DbE4aOd21FqqNAhv+6oRiaJ4/hamIUO+qsFs6pZvglVlpI7wQDSxH7fOvIgMOal+82t65nAQ3K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcWvkaqtDi2LhlH6dO/n/Y8Yg1txscuVq/rrLuIB+VLpzvYIlK
	28vV8CKTGrOJja+Pcuyt3jAyQl1hs4axVvQUEHfR+4hYW3OHP+FfXUbRAZfUQ94ZlIk=
X-Gm-Gg: ASbGncvcE0x3P/2a3UsHKDEj+hN74I1u7gnqukmSdh2tGrlekdk1ZU6Sqg4dS8nSt4o
	SBxSzpCtci4Cv7CGUb9OjnL7FVMOYnYEY6dNxVf68lKbB7Wy3x76z9dbJ9ozh2MAlll6ElrzolL
	MDneJ33kNKC2xq6WZLHotbhUBMnom9a8P/OnxD0apm7OJkC9SkY4WmC+LIVsBYcCQFf71QhZJJI
	9hDBiWxKQaqK7D7Oui4/F5b4A96CFDEZA/z5iwvukz5Omn43W/Ox217EuZ2kRoZzS/DFbOudP/A
	yhW/dUbVBzBLzYHtyJwH6cPLeDgIKAkUcW59FMCCtnt5fZP7zlHjCuL/XHbHURVKXLupeKYA1HZ
	QqK7cyAjDw+6Xau60AYUkTc9ock2Q9ZleC+24hKXZpugAqXNnLPHA0m5lELEgBeo/EpM=
X-Google-Smtp-Source: AGHT+IHYpF/hJauL5pI8FzqJ8svbdfh/Bd/h6gQ27dVo1UcfsAhIfHsh/9IYIDD2N36bQ3USf6JKnQ==
X-Received: by 2002:a05:651c:12c1:b0:363:d806:7d5b with SMTP id 38308e7fff4ca-374c3402645mr40853581fa.0.1759802616329;
        Mon, 06 Oct 2025 19:03:36 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:22ae:baa0:7d1a:8c1f])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f3b81e45sm5150391fa.46.2025.10.06.19.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 19:03:34 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v2 0/4] qrb2210-rb1: HDMI/I2S audio playback support
Date: Tue, 07 Oct 2025 03:03:28 +0100
Message-Id: <20251007-rb1_hdmi_audio-v2-0-821b6a705e4c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPF05GgC/z2N0WoDIRBFf2XxuRZn1N24lNL/KCGMOpsIde1qE
 goh/16bQB/Pvdxzb6JxTdzEPNxE5Wtqqawd8GUQ4UTrkWWKnQUqtKDUJKuHwynmdKBLTEUCeR2
 i00twLProu/KSfh7Cz/2TK2+X7j0/Q5G5NXp45+HtX7tVjwhKbiEjOiXbGgPVKK8gldxh7wz4Q
 JP7+Eor1fJa6vH979BTYxlKzuk8D4YmsBrMBA5H1kE7GEfL7ILBxbBCZ8nYnRX7+/0XpHS7SPs
 AAAA=
X-Change-ID: 20251007-rb1_hdmi_audio-1ab3cd93fc9e
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, Alexey Klimov <alexey.klimov@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2

This series adds a feature to playback/output audio via HDMI
on the Qualcomm RB1 board. Since RB1 and RB2 are very similar
to each and other and most likely use the same mainboard therefore
this series is pretty much a rework of the similar patchset for RB2.

Changes since v1:
- added tags;
- patch that adds sndcard compatble is moved into separate series
and also one new patch is added there;
here: https://lore.kernel.org/linux-sound/20251007-qrb2210-qcm2290-sndcard-v1-0-8222141bca79@linaro.org/
- resorted cpu,codec,platform subnodes of HDMI DAI link
(as asked by Konrad);
- apt => APR in "arm64: dts: qcom: qcm2290: add apr and its services"
(as suggested by Dmitry);
- resorted pins in LPASS TLMM node (as asked by Konrad);

Previous version:
https://lore.kernel.org/linux-sound/20250302-rb1_hdmi_sound_first-v1-0-81a87ae1503c@linaro.org/

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
Alexey Klimov (4):
      dt-bindings: pinctrl: qcom,sm6115-lpass-lpi: add QCM2290 compatible
      arm64: dts: qcom: qcm2290: add APR and its services
      arm64: dts: qcom: qcm2290: add LPASS LPI pin controller
      arm64: dts: qcom: qrb2210-rb1: add HDMI/I2S audio playback support

 .../pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml     |   8 +-
 arch/arm64/boot/dts/qcom/qcm2290.dtsi              | 113 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts           |  55 ++++++++++
 3 files changed, 175 insertions(+), 1 deletion(-)
---
base-commit: 4a71531471926e3c391665ee9c42f4e0295a4585
change-id: 20251007-rb1_hdmi_audio-1ab3cd93fc9e
prerequisite-message-id: <20251007-qrb2210-qcm2290-sndcard-v1-0-8222141bca79@linaro.org>
prerequisite-patch-id: 0644af1b677a6f0aa2cf85736ccdfc2495a4c9d4
prerequisite-patch-id: 986319766f2f9e41cc702af7f6ebbb764f5117da

Best regards,
-- 
Alexey Klimov <alexey.klimov@linaro.org>


