Return-Path: <linux-kernel+bounces-762976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B380EB20D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48273188DFDC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664F91F3BAB;
	Mon, 11 Aug 2025 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hjpsB6VT"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13E2D837A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924819; cv=none; b=afEcNa6mXcOn3ugvDrZfYncDxhLB/4yMwjD6q6TsOcN8+watTm0xwBI1YefM95rmaI9k8/wwiaphAy+pNRAXCEDbkIyIeD+r4lIDrrgTrIhzWRlyBmBBaWFoNpzfhWJZaBy6cUTg9SO7KARatamReyKtQahkfA9/VeQnM+5QH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924819; c=relaxed/simple;
	bh=22hIP73PNcTI3glvq76LzhKxmFYfEESfF46nrwux6UA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yk2JIYgwpSV3PfamB5wRcR7nG2e4hLrbiIEvjc/tCpdrFxShkR+9LPNphu+FZkNWeAbCWThuZJOmDu6x7deJ+2AnJCdyE3gSzSBrVmyLBFJ06EFz7PlMiKA2Mupjl5DOfgxAIkfsFyCSHdBff7xuCdZZFlbEKvom0D0MtwoN/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hjpsB6VT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45994a72356so35591445e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754924816; x=1755529616; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8omthgshFkN10IjR2npcZp+fDyz1os1vkZm5ZoXU8Zk=;
        b=hjpsB6VTp6WCvoEG8HriMLWufDRCZJzyHk8ixj0d7ieye/owZ6gjzFciy34Kyak63G
         D4Kw7JG/pGN44A0HWc2fLedaxHKzNLMirW+TpBuhBAFIvpp/ldemZmZvDUmtwHps4o41
         20wliC4AWMwEgpBIKberNloxp44XOh6SKzlsvCO8Rwx8jRFHwjsdBvUMFncN0vnNtwBK
         v1zdI/KuUz4v89unu+wVuDfXoflj6QeMtwmHvGOyiOBbMf5scWoDvnwEENDbamNhpHgc
         FAhAniZ4S53gnFYQuU+Yc6G8C4zjKj0orAECXEk33GM7JtuwNwnqZMdWcPFvtrIjb1Ts
         lvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754924816; x=1755529616;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8omthgshFkN10IjR2npcZp+fDyz1os1vkZm5ZoXU8Zk=;
        b=edtlBeugcAp6d5/PD8ETU1GxC7HSdn+e2a0KlXAaqv2zpjSXDOkCoyn6vJYTzFpptc
         CFFulBawyw6U5l6DKBWGOm6V19x8S5djWsUzwIYSUi8n7UuysYwkguDUhIEwk56pHlQm
         gEcv0zF4mvDZPt9OZdr15cFVBV9YQ0gHlOsO3AAOEMv9LZcwZaBgQ7NSagNtIvqgHzif
         p8K7cA55+lL1LtjOPh4f7t9xCm19b+BVFrtGN0bhATvHsOq4qrZzC9iZv43BxfSlV9Kv
         92Eu8u76AGxqc3P919Bt1B+8iid5zuEtJLzh0QmqAfNc9gHjpBf4yFmYRWhhe5Y4qOfh
         M2yw==
X-Forwarded-Encrypted: i=1; AJvYcCXOK6uEbOrukM5cdSR/0j/1QF+WjpEllgVRvEozyukykB8PVG46B0oTrFKAQiOh1k62QbNWwRN2FhTmcgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv0RXKdGr9kYc2zflSCdoh6c0QWY7IaPFvJ31x0YICVcYoDDEI
	kBKIz1ETiP3kZEkpEnIc/XkhIYkfuDE6xy9MB3O6XW5wYGkdgccQuZX28qBVwBSS4S4=
X-Gm-Gg: ASbGncv16oWfjNkEAKZZPHSsHxcVdXzvTo0LVHRUGanli0h7jReGW15ykR5xUYLMGN9
	xO9nwv+EWofxVUT/nYPm1+XMMtdLMrsfP3t8yZfZpRte/fxbWPE+Tb1FtcOJ9kA3Rt7eNy8iNI8
	9BJwGGoUNOGwC7RnESfR1Jzs5hhL+4xj2skwGeykfS2nU/MbpBUR1VyzAZrTW0bjhL/Qj5huYHW
	1pgWhlMz4euvIOZHMjyra/fFCDQbIIR2uakaXkZCSk/jgxtQWuzWfjCqW2pHrprzjPXSbnsa2ww
	1fDvZCEzWGBg8wchCYrs5bKCndF1TBCMOPvB6xV10kBwIFk8OjLv7JI4iqWNYTrh4gKXr1GGV3W
	ALlwJFFbk5JUWoqr3yQ==
X-Google-Smtp-Source: AGHT+IHWCPZvoDFSg4WqETziRnUyxCYL1s75W+41J2DP5rPWc/ltfoQ+umUweKQ6xxD9ZWoOnK19xA==
X-Received: by 2002:a05:600c:2d55:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-45a10a2b870mr1071655e9.10.1754924816426;
        Mon, 11 Aug 2025 08:06:56 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:6841:8926:4410:c880])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abf0csm40107411f8f.14.2025.08.11.08.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:06:55 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH RESEND 0/3] arm64: dts: qcom: fix GPIO lookup flags for
 i2c-gpio SDA and SCL pins
Date: Mon, 11 Aug 2025 17:06:47 +0200
Message-Id: <20250811-qcom-gpio-lookup-open-drain-v1-0-b5496f80e047@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAcHmmgC/42NsQ6CMBRFf4W82WfaUkSdHGR10NEwNFDwReyrr
 RIN4d9t+ALHc25y7gTRBrIR9tkEwY4UiV0CucqguRnXW6Q2MSihClEKic+GH9h7YhyY72+P7K3
 DNhhyaHOtcykLa5SGVPDBdvRZ6lc4V5fqdIQ6+RvFF4fvcjrKZf2rP0oUuNuU20bnheqkPAzkT
 OA1hx7qeZ5/bBk6F88AAAA=
X-Change-ID: 20250701-qcom-gpio-lookup-open-drain-e3443115ea24
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1400;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=22hIP73PNcTI3glvq76LzhKxmFYfEESfF46nrwux6UA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomgcNGM0SwJl32lb62kmzoQGqQo3dhVABhfpNI
 mc9wtqEuESJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJoHDQAKCRARpy6gFHHX
 csRXD/0dbyRd63RJvLsuidKaIlZvzsQkEYR1ZudQLgUZfaJv3JJ9DFzyiE0uA7Negf4eSVnF3wI
 0TrtnKkCEkuOa04/0Fl38NNixWsOjc1nRTxQ8L8sFICt2YwkPexhxU6w8r3MOZOctfjHHg4Nhik
 mlcjrksoXMTdoN12Kk3/cQC98oypZ1z2dpvAfrNTjejv35SQ5jOPOaU0/eakubvnocziM2PPd4j
 XyMOVDW/iL19dXoP0xeyG22f45TY61RfPCmA/xRZz2tjMaTuZvnH73g517teAYJ2W5L56sHXY9E
 /pex7tHxpmLSqWxpCap0VyImTD82MeUqxNnprXF0gfYOOPdLfUeENT8hdCuCaSkoQ7Cp/qs2+ae
 wUCx3IH7kmeYyhsayi0yeQ1RwCkPQOmNxLgrHbgenWAtSfUavCOMqCyXPyit4CsxB7gCFdpRHyQ
 LRppCqoeQy66n71G3XNCeNMaxhDW3f0Kpd2cXVvt8cZs7zqHFtPnaj/I7rFYVaBNQmg1pFNHB9v
 8x6yOO/A17PxuJ+aj4n6AV2yo2Srm6gAsTu0IlXp5/JzmCj8Bkp/Q1lz46XJzuHArAR8Pk18/5/
 gXVyHaXYH9y7sEhVsViSPZtzR67axMJWZi0+4xh3F7V4TY6y0yKvPaE9a3iRLtfyDSUuYpBu0Sr
 QPeCTlDgJuj3hew==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Resending rebased on top of v6.17-rc1 as this missed the previous merge
window.

There are three platforms in the QCom DTS tree that are missing the
open-drain lookup flag in their DT nodes associated with the i2c-gpio
device whose driver enforces open-drain outputs. This causes the GPIO
core to emit warnings such as:

[    5.153550] gpio-528 (sda): enforced open drain please flag it properly in DT/ACPI DSDT/board file
[    5.166373] gpio-529 (scl): enforced open drain please flag it properly in DT/ACPI DSDT/board file

Silence the warnings by adding appriopriate flags.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (3):
      arm64: dts: qcom: qrb2210-rb1: fix GPIO lookup flags for i2c SDA and SCL
      arm64: dts: qcom: qrb4210-rb2: fix GPIO lookup flags for i2c SDA and SCL
      arm64: dts: qcom: sdm845-samsung-starqltechn: fix GPIO lookup flags for i2c SDA and SCL

 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts                | 5 +++--
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts                | 5 +++--
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250701-qcom-gpio-lookup-open-drain-e3443115ea24

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


