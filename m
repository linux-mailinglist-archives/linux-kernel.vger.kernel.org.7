Return-Path: <linux-kernel+bounces-723532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2A4AFE818
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573DE587A4D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8E32D97B8;
	Wed,  9 Jul 2025 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Cq8SsObN"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E81D253340
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061609; cv=none; b=K6PQcbVlOVU0/QRSaa7mSopczMW9JfzoFeAy5X/YVWTwGSfFeNphkUWW6fDB7vWQGaiVh4tSzkYBtEk0RJJRjjV0R7VdDGeniXU17JgXQXA3rvzvNXBQTRlx+YkGEd5B/mjPigHkGJmAXoSUqmjW6SWSZvVx6VK4pHSouivp87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061609; c=relaxed/simple;
	bh=QyvA1Nzk0SjLU+31bm2SPti95aMonnwGc0oDKOHnSlM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UM9O8Q0GrT/iQzVVq1mRxJuWvm2D6ZI0Qb9SiHW7PVxdwyqzyHFXzXhnc11+BEn2VR8O6wOQ8dU5hDopfKig7S/TnBZs4wYW0iBVlzYQKGcTU9D0m8YVQLiBkYr60AUmqyOwatOtcsIXrd/LK1RPRIDZt9HUD1LsVRIeXqmlJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Cq8SsObN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0df6f5758so908233566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752061605; x=1752666405; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D9byk3wugrhJNxEcWXLExtPl6Yl//CkYLrNeWbYR494=;
        b=Cq8SsObN6jBPDbSirTwLQ6P73n0RFav8rTtglQi/+X1YITPNipx7nAVKwqpuQKQK49
         2TjN8xpmwTyBSjmGLx2SUdj6PNvCkSiyYJsAnk95/7pEGDprQTF5COFyeSyQ/UQOYCB+
         Gqd56S7s+80L+o2RRhMzq2jh1dP9XAnSmw6WYb6G0X47tySGWnCkSsuOWqrVHoUGifJW
         Nfn0LPMi38EB2sBg4BIMx4FPNNlfgqOpwoC4HL8hicncQLNVw+p32H1WKwUgFVYFe5Rw
         k4c+MApylsw8XeTjWX2aOkUy9tvsBnjv5ZFMeVJsF7JnGDd7Y/r9pNfaPcvwVuFOufA9
         cKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752061605; x=1752666405;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9byk3wugrhJNxEcWXLExtPl6Yl//CkYLrNeWbYR494=;
        b=mqnXv6QFtqqdGKbmd5iqpa/jfQ8KCsvr6kHQfPU/GWnO3EEnsvtQk0DAUOGqzcQxfq
         tlkhz09vnSiL5O7fE163JmjdvANCJse1dLckPkJqq7YWCgd7p+mlv1IFOCuuc88cv+dJ
         4tGnO2L+Z8Fw/JXxEXJrO91al1d6eZarxhLWu1XVp41p/zbyeT0vkiOMAAdyP4fEC7y4
         Flt79PZUAjakIGRTZpIlBJN/B6ZI2zxZEiGiLwFJLQP9j9YHSq7dDRa5LKrxWP23Rir4
         GqYQDSX0KzqhKmG84bbCMNHspRUauaNRSG7599UEsL56iPq9axSnQM7B/d5r86xH7Fe3
         Mavg==
X-Forwarded-Encrypted: i=1; AJvYcCVx13pIB5TfFCAr8LFVCV7GImlPFrO0V/K8lBYLuwFECKxBNpz8tAqWnuxmlGGEjDALpegkXbIa1fUiXQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEWskilC7I5vOyyRbG4IJbuuMRd9BCg7Xvy6pOrp9lYfq5gLh1
	yegjkZZUgIpAR6nlJWH+K/zNg3+EqCmbg831VpAomtADc8oIfiS3GG/XfSD+HKwFqbo=
X-Gm-Gg: ASbGncspyMs/ASjKkbvqzXdcsf+9rNS69RPOZ0BNMVovtYnzXFJPsMutIwDcB1I7CHk
	O4KEo24F4JWIOmTFxTgQ1v/0JoM1lPjWl6rphG635o0iutB5xcAirVE/7cyVHEPjuyOCy+Ivhj8
	6JI6pgkI32gZlgNrtqgpGzS0iEir3YaqREw2JaHVYQXzbVcY7vmJtX0O5KsH51/fjAzN3QtmfXc
	XYVk5EWopCGosUMLmZa8yjSzVCB+G4Pq20uVqtjJf7SnU39fU+lOb29pA1ZfCOCFGT+8FSJJQ/4
	93VFzbcxO0BzjzpQHH7Y99PSf66g2aEsk5/O3PHFiDc1zlit04KsBBf+hjO0HTBV6gYPy2q0Vss
	M5TztK5BWisMM+fNJcNCeRG0sq7SSdE3/4sBszWJcfU8=
X-Google-Smtp-Source: AGHT+IHBY4d9/GJbkWPqXT8J9DnV+IVC2JC5zKF0B4Pu1i/DLBMpRHhTFOQ7JRtodytv/0C23aztEA==
X-Received: by 2002:a17:907:d09:b0:ae0:cadc:e745 with SMTP id a640c23a62f3a-ae6cf7898c1mr227993066b.40.1752061604773;
        Wed, 09 Jul 2025 04:46:44 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f692e4ecsm1102995266b.55.2025.07.09.04.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 04:46:44 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/5] Add support for PM7550 PMIC
Date: Wed, 09 Jul 2025 13:46:31 +0200
Message-Id: <20250709-sm7635-pmxr2230-v2-0-09777dab0a95@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJdWbmgC/2WNQQ6CMBBFr0JmbU2ZOhVZeQ/DouJUZgFtWkMwh
 LtbSVy5fC/576+QOQlnaKsVEs+SJUwF8FBBP7jpyUoehQE1kraoVR7P1pCK45IQjVbMRK6xrun
 xDmUVE3tZ9uKtKzxIfoX03g/m+mt/LfprzbXSCsm5y8lo8qa+eicpDmHiYx9G6LZt+wAJU/DXs
 gAAAA==
X-Change-ID: 20250620-sm7635-pmxr2230-ee55a86a8c2b
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752061604; l=1221;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=QyvA1Nzk0SjLU+31bm2SPti95aMonnwGc0oDKOHnSlM=;
 b=jI/LuA8Et9Jz6IIYCbCbiaDVHZiqDKZl8RRZgpLS3RuN+Ax4/YMmJKN878+dc6PtGL37LqaEB
 8y7Tzyw54BiCUEH/z2jsIb9abrcrERJIg7UyIA8WsR/u8lKqzjp6CUQ
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

The PM7550 PMIC is used in conjuction with the Milos SoC. Add binding
docs and the devicetree description for it.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- PMXR2230 -> PM7550 (Dmitry)
- Replace some SM7635 references with Milos
- Update critical temperature trip
- Link to v1: https://lore.kernel.org/r/20250625-sm7635-pmxr2230-v1-0-25aa94305f31@fairphone.com

---
Luca Weiss (5):
      dt-bindings: leds: qcom,spmi-flash-led: Add PM7550
      dt-bindings: mfd: qcom-spmi-pmic: Document PM7550 PMIC
      dt-bindings: pinctrl: qcom,pmic-gpio: Add PM7550 support
      pinctrl: qcom: spmi: Add PM7550
      arm64: dts: qcom: Add PM7550 PMIC

 .../bindings/leds/qcom,spmi-flash-led.yaml         |  1 +
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |  1 +
 .../bindings/pinctrl/qcom,pmic-gpio.yaml           |  2 +
 arch/arm64/boot/dts/qcom/pm7550.dtsi               | 67 ++++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |  1 +
 5 files changed, 72 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250620-sm7635-pmxr2230-ee55a86a8c2b

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


