Return-Path: <linux-kernel+bounces-884768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC19C31122
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA00422F3C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D045F2EC54B;
	Tue,  4 Nov 2025 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNOArWOE"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353C825F99B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260697; cv=none; b=jtUyP6ejJBloA9RfZL151HubPJwXw6zgl3adNkv/KczW5BaTu8mKicIFq49y2aqm8S26Fq4bFnlmWWGorE+M7D0Dc5SJqbddYg7RNWqG6IB5fi0L0CUZozteUVWnI/ChkSDoCG2phMm9ukBa5Qg27k+rJPDZtqQ2Dhc3jSDl1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260697; c=relaxed/simple;
	bh=P0P09KrMQw7iDL1Zgyz7Mj/ducQCpx8Q4fKXzYK04mE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=af1KY/IcsttNe1LPnyXsCdWQT6zqeE3PZueQFAJVEtWTjnRLg8Dv6yLj010TjhZxZ/AGHT80IDMW0N6LZf5OqwRlWrk4UT6Qbd+T+O/+qZmdxSmXZR+WeTTQeE/tndb+U/TAMuwLZyiG6r+DumZmzv9NuzW5YUqaT7mtVGwZDg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNOArWOE; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a59ec9bef4so6746454b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762260693; x=1762865493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEiQIKJ+ye8rmj662E4uTeZxFBcM5WtKqV1kS9+TQCY=;
        b=eNOArWOEsY+6rvu6ik7GQ5VpxizTdXOLVWDx9XJNubYhE6m60kvQb14qbRgVEs0gHi
         Ky9LV34b89G/5pj6c4H8h6NQsAnO3gJEfyQiZCx+T6ZCBqmiOLHjiDTe+IWE5lRCW/v4
         +l0a5j2KXn2QiZGPWLPhGucHxIzopTKtwDTHNS42VMU8XoQvSShaosqPwQ5yVnEOC45n
         ij57WNJ7rvwcm2RKIxPx+w6EgMxJREzf1OW7ZNvE7TM27jXEBnHxeLxYbS9apzE3NHFK
         tbAYB98S4z7zbxQQ+Ih4Wu/+L+mFeCS4/ihV8WHsl+TI/01TCdKhx1tSpq5Y6/f4n3z2
         vwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260693; x=1762865493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEiQIKJ+ye8rmj662E4uTeZxFBcM5WtKqV1kS9+TQCY=;
        b=Ifl35lsEm26U+HjjstXgvMKjKnlevgQ5JfJOYgNCsTEZ/1QYB8x8DjJjGUoYXdhuwB
         e2i/5Ynf4Z5qaCcrMWLTM43TCJv7v7ggH+oLUOFO42CzRPEGhwWbN+AW5yDSuBwMP8wG
         lkeIv8lM1xE9QtROJkg6cd3Z+dIKIIVjbzRDDuze7jIwq2mCbks11tBM2sbIlVr8nmg6
         r0vT8RPnR8VBUgnAhwPvtVOAeHZhptdhiImVHv1I8p3+yNizB4OCqkBy2Mgl0FdIYQL7
         FPJdqWqSG924mJNbMwbgrkX6U4xPeprhZ7yvIXlJt5+JTGp0vBlpcvljrWNK2nHFc1Tk
         rhDA==
X-Forwarded-Encrypted: i=1; AJvYcCUE5OrNUs2P2yv6bY0qEQdGDSEfZ31r28ByJni71kHEO04upXt0ciwMDAN/udYDkkvgU9rpW6E6swtgU+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkNRHMK9xezjVve/iDMTjy0x6Ex04EtRr64bVtxJOlFqVPFf/M
	nhGr5f/3l/ALqaZsMcbFOr2ui3IjGRkKbZIZfmK8up30L84AhF0hh+QL
X-Gm-Gg: ASbGncsYC5bXbEMB9PKxjvfrZcWda5lKfKkfp+OUmyMClZhgtSq9BxB9y3XlRK5SRi0
	p4FVJY1VJpbHLvfJz9yt+GuUEP4Ujb0f0DFkUdasIID0bQs/HPvsySTxdtcGPK9FN7gyrdZIEhE
	h//b2Z6SddKmHElEshDHnwBxnR0NiMJvCmxIBJBvIn0I4/wU/rn9Z4V2qXt7sPZiaB+4HALYt8R
	y2tOUT7NEJfWr3Mh4V8+cnYdIJcqnMz5ne7JHIOagJxPIyJbQgf9aLFAD9aUzLeSH4ROjRocclX
	yb6VbmuJo+CUYu8i8vefP5yPvd+5mR6cVSzEb+SOszNn0A+/AtXmdayFnUD5IBNrWfUd4E6QlTF
	hxYp86VKG4pRxPNt7Tpe8/kZr1580zL6rGw4z2CVxHb/+uGLvngB2HsggWckXY0yrqicMJF6SyV
	Y7jRF7tq+a43FtATo+bb2BPIgGmA==
X-Google-Smtp-Source: AGHT+IGANTE1PAot3QI3qrV6KnKmOlu6RAZN/pN1lxmSwTfpebaHhBK2S3CD8RB0Tducwg7ma+w5hA==
X-Received: by 2002:a05:6a20:49af:b0:34e:959d:e153 with SMTP id adf61e73a8af0-34e959debe9mr2135074637.15.1762260693540;
        Tue, 04 Nov 2025 04:51:33 -0800 (PST)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2a80459sm2338616a12.15.2025.11.04.04.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:51:33 -0800 (PST)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andersson@kernel.org,
	konradybcio@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudarshan Shetty <tessolveupstream@gmail.com>
Subject: [PATCH v5 0/2] Add Qualcomm Technologies, Inc. Talos EVK SMARC support 
Date: Tue,  4 Nov 2025 18:21:24 +0530
Message-Id: <20251104125126.1006400-1-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This patch series adds device tree binding and board support for the
Qualcomm Technologies, Inc. Talos EVK SMARC platform based on the
QCS615 SoC.

The first patch introduces the DT binding entry for the Talos EVK
SMARC board, and the second patch adds the corresponding DTS
files for the platform.

Note:
USB(usb_1_dwc3) supports host-only mode based on the switch SW1 on
the SoM, which is purely a hardware controlled as USB-ID and USB-VBUS
is not connected the switching cannot be handled from SW.
Hence from SW Host-only mode is supported on Linux boot up.

Changes in v5:
 - Updated commit message. (suggested by Krzysztof)
 - Introduced generic node name for can, dp, hdmi-bridge. (suggested by
   Krzysztof)
 - Introduced talos-evk-cb.dtsi, which has common carrier board
   interfaces.
 - No functional change in bindings file.

Changes in v4:
 - Updated product name to full form per Krzysztof’s feedback in
   dt-binding comment.
 - Hook up the ADV7535 DSI-to-HDMI bridge to base DTS file.
 - Add DP connector node and MDSS DisplayPort controller.
 - Added USB note in the cover letter for maintainers' awareness.

Changes in v3:
 - Addressed comments from Dmitry regarding USB1 `dr_mode` and 
   added a DTS comment.
 - No functional change in bindings file.

Changes in v2:
 - Renamed compatible to "qcom,talos-evk" (suggested by Dmitry/Bjorn)
 - Merged enum entry with existing `qcs615-ride` block (Krzysztof)
 - Fixed subject and commit message to use imperative mood.

Thanks,
Sudarshan

Sudarshan Shetty (2):
  dt-bindings: arm: qcom: talos-evk: Add QCS615 Talos EVK SMARC platform
  arm64: dts: qcom: talos-evk: Add support for QCS615 talos evk board

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/talos-evk-cb.dtsi    |  56 +++
 arch/arm64/boot/dts/qcom/talos-evk-som.dtsi   | 442 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/talos-evk.dts        |  87 ++++
 5 files changed, 587 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/talos-evk-cb.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/talos-evk-som.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/talos-evk.dts

-- 
2.34.1


