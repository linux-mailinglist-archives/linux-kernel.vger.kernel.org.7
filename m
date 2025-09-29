Return-Path: <linux-kernel+bounces-835826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAC3BA82A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C55A27A8649
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF1B2BE635;
	Mon, 29 Sep 2025 06:47:02 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651C1635
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128421; cv=none; b=hKRqUxinbkVxDQ4GmiE4o6gUuUCx9PW10Pp0anEtLBW6eZIoqaHVvECoZnEPO1VfU9I2T8JRq38u07tcSLnqbn5xZ18uAl+GHXwacyg6lTessJykhWKQv12b2a1BJ7ECWk3tnSHhgyria4d/ChAx3ZG/WGINC34wm9nsYX6RyTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128421; c=relaxed/simple;
	bh=Y20ShN7MXQAXzhkbhjDkC8nmDpuzrDaKoSwUszr/Fgo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TjE1yLYMiTetpyLwAJ+gZsar/M4Jtii5GNEG51Z5zP3hF+7ovHA0ZlPfFeCOwdt2IcAcfN4y+Ed8/X2Fe/fdqmuVxyJhmLYH68xfcmLncmQTWMd8pS+JPzpR8VQt2Yav9LyhnoDaGEifSHZflKt7bx7aa3j67H6IkwGX/M+ad78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1759128410t6a09a6fd
X-QQ-Originating-IP: IdaLYlmGSJLSQ1a+8luNa9lnBiG2H6cFH2F3fj9TJZA=
Received: from [192.168.30.36] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Sep 2025 14:46:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7642221811650524440
EX-QQ-RecipientCnt: 12
From: Xilin Wu <sophon@radxa.com>
Subject: [PATCH v5 0/2] arm64: dts: qcom: qcs6490: Introduce Radxa Dragon
 Q6A
Date: Mon, 29 Sep 2025 14:46:40 +0800
Message-Id: <20250929-radxa-dragon-q6a-v5-0-aa96ffc352f8@radxa.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFAr2mgC/33OTW7CMBAF4Ksgr3Flj3+wWfUeiIXjGYMXJMShE
 RXK3WvSRaMSsXxPM9/Mgw1UMg1sv3mwQmMectfWYLYbFs+hPRHPWDMDAUZ4CbwEvAeOJZy6lvc
 2cCKMSCEpspbVtWuhlO8zeTj+5kL9V5Vvf+U5D7eufM9nR/ls31wYJRfcxYhN8hGlbz7nkY/YX
 dgTG2EJ6BUAKiC0STvy0KjmBVBLwKwAqgLBRgXonSPc/Qf0AoC1D3QFpEDjdILohF0C0zT9AKO
 snMiIAQAA
X-Change-ID: 20250912-radxa-dragon-q6a-eedcdeaf3e66
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xilin Wu <sophon@radxa.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759128408; l=3080;
 i=sophon@radxa.com; s=20240424; h=from:subject:message-id;
 bh=Y20ShN7MXQAXzhkbhjDkC8nmDpuzrDaKoSwUszr/Fgo=;
 b=pq7hnzqvkF2nLnZgdO7cmhHHXJhlL97JFMkynfO7345AXY6F6WDo1yMNtwvxQyDHEoqGdkoMr
 f0ZAK1e9LtvBSj+/w12BNgTOvRRxPBywfj9/Dvh2gaD5fb6it9PZ82P
X-Developer-Key: i=sophon@radxa.com; a=ed25519;
 pk=vPnxeJnlD/PfEbyQPZzaay5ezxI/lMrke7qXy31lSM8=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NL5QmF6cTPb+XYhkav4v78CysmHhEbPPizck9iFuwm1JQpD6QCf8pnfF
	J+Xvrq9i9NRQ7AXPPEJmz0RjXc6SmS8b+8gLxgnOLKPQOh8GEs6H0IXrGRbMURMtvtFfWVU
	KCM4x9O6t4G+3t/u9IvLy0AhXkjQfVQBKoUkMWfLSOXz00oKPdB8sm5n4JqzxPFmR+T1JGk
	YmUPK85vrTvnawYmJhgCKwr+L6VZofs6JdgmBkzSaIgroDSZmuXl18GLDwRuGW0kPOdLgYh
	/V7yDFCK5RbPGr4veB6eoRITUW7Z5BLQIIzXA1g7i8FtPpKT1Zx9abD7FAGVWYIcszBpqT0
	HEHXwSwluyxC8igJtt6kuMIIAEOlbsc1+WN48LsdpJyAcgyN48PL5uHZrlitbl0OoKIWXSP
	iAs5NljAXh1orLY/A2v1ukSjmrWDuIXP+wC7oZ1SxRfWe3xZDdAOQ4xoezNBQ+0J1QxbgWJ
	9YVTTXtFHNaMZWvuIZPt76lW2UWS68oRlTJNClrdRzw/GfhEXu0mMcU1mH0bOVbue17HJyP
	ntOtLX5pAQjPqZbXxVoKMwp/wJxLnPX+0FgmDFTXthm+FrPu7UIfeoNaHcvyDqmRdzvn3GE
	gwjI4mjY+P+8ACFECAIiyoMsUui0TpovJrxc1pCSc6PlaQi9kc3rI9pmf5t8bFUYGBglvBq
	3zAOnl+g5wKQCZRAwRxkwyqfKUKM52Guv7v56a5dIqZuXsFTEBWGeu66llNPcRs9mYIYr2r
	9xNp/OrqT8mWrTC7mrvu9OnJ7toFBu9NkTNxvi5HpyWTtZfJPv4XFj+9fxDfHQoGU7Xfssg
	+OZR+JkxRli3s2sYsQEjzWEKEagatLqDxRM7H/6QglyjRJMwRqgegSBqLqLbWbiteFE0SEG
	KhdiHZ2qNBXzlyj5+Lnj9Kjwxv08w6QZmdzgyIKDmSfLMzNDBp97KHO2mF4cKlo6qc4k+BO
	FNXpqp2ys4UTcgX3Ch/hWr65AxnjJbhl9173A37yXVVA0DPTx4dLo1eTsnF4iTVJ1D7Qg46
	Dv3OQ8DXkZVQ8dSqPyPQazZmf3tU3sBB6EDHp1Mw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Radxa Dragon Q6A (https://docs.radxa.com/en/dragon/q6a) is a single board
computer, based on the Qualcomm QCS6490 platform.

The board ships with a modified version of the Qualcomm Linux boot
firmware, which is stored on the onboard SPI NOR flash. This allows
booting standard EFI-based bootloaders from SD/eMMC/USB/UFS/NVMe. It
supports replaceable UFS 3.1/eMMC modules for easy user upgrades.

The board schematic is available at [1].

Features enabled and working:

- Configurable I2C/SPI/UART from 40-Pin GPIO
- Three USB-A 2.0 ports
- RTL8111K Ethernet connected to PCIe0
- eMMC module
- SD card
- M.2 M-Key 2230 PCIe 3.0 x2
- Headphone jack
- Onboard thermal sensors
- QSPI controller for updating boot firmware
- ADSP remoteproc (Type-C and charging features disabled in firmware)
- CDSP remoteproc (for AI applications using QNN)
- Venus video encode and decode accelerator

Features available with additional DT overlays:
- CSI cameras
- DSI display

Features that will be submitted separately once the required bindings are
merged:

- USB-A 3.0 port
- UFS 3.1 module
- HDMI 2.0 port including audio

ALSA UCM and Audioreach topology patches are available at [2] and [3].

[1]: https://docs.radxa.com/en/dragon/q6a/download
[2]: https://github.com/alsa-project/alsa-ucm-conf/pull/601
[3]: https://github.com/linux-msm/audioreach-topology/pull/24

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
Changes in v5:
- Change LED default function to panic-indicator
- Fix line break in sound node
- Fix status-not-last in usb_2_hsphy
- Remove unused regulators to avoid potential issues
- Link to v4: https://lore.kernel.org/r/20250924-radxa-dragon-q6a-v4-0-10d584f2c806@radxa.com

Changes in v4:
- Change CDSP firmware to use the existing one from linux-firmware
- Describe onboard USB 2.0 hub and ports
- Add configurable I2C/SPI/UART QUP controllers
- Link to v3: https://lore.kernel.org/r/20250915-radxa-dragon-q6a-v3-0-a6c32d988ed7@radxa.com

Changes in v3:
- Dropped patches for USB/HDMI, UFS and GPIO.
- Removed Reviewed-by tag from the board DTS patch as it was significantly
  modified.
- Link to v2: https://lore.kernel.org/r/20250914-radxa-dragon-q6a-v2-0-045f7e92b3bb@radxa.com

Changes in v2:
- Move codec before cpu in sound node to get sorted.
- Drop patch dependencies in cover letter
- Separate the changes that have unmet dependencies, and mark them as DNM
- Link to v1: https://lore.kernel.org/r/20250912-radxa-dragon-q6a-v1-0-8ccdbf9cd19b@radxa.com

---
Xilin Wu (2):
      dt-bindings: arm: qcom: Add Radxa Dragon Q6A
      arm64: dts: qcom: qcs6490: Introduce Radxa Dragon Q6A

 Documentation/devicetree/bindings/arm/qcom.yaml    |    1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     | 1095 ++++++++++++++++++++
 3 files changed, 1097 insertions(+)
---
base-commit: 590b221ed4256fd6c34d3dea77aa5bd6e741bbc1
change-id: 20250912-radxa-dragon-q6a-eedcdeaf3e66

Best regards,
-- 
Xilin Wu <sophon@radxa.com>


