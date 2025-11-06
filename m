Return-Path: <linux-kernel+bounces-888854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E247C3C19C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE0A3B543B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9360F29D295;
	Thu,  6 Nov 2025 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="OdOBHfbu"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3692989B4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443087; cv=none; b=nPgjjtnIheWVK3gUytivO3BvNecPr3ABzeIu48Mo9SIYRyZMngpLUCkxHK4ZKnH4ArxIQvyVWpP+5Gd6eCnLEKWwpMWcQg0urGfh3dHhzKVPb6X5nzfNeY2J3ABborlhWcx5hzt/sR/xZw7isQU7+wHdOBTFckqGoRmO9Zu55ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443087; c=relaxed/simple;
	bh=q7sHWixTWPakJjpCcPxaoq8AAo162rx3AhfF7uVu25c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFzhJLO63T0DA256X0zc8z50vkEWzM6u2bn6yeAs0F+XYtAYWc6yVHJzBwGM+Rx+0wBLU4UMHefyYxcGZyFXCTZ97wSVwArAarungyHHdXNEY7VFysidEi7BmKDftaCiLavz4V4awjZprEPzG4+hadxnNmPfHqVCz/v+xwg1LsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=OdOBHfbu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429bccca1e8so767097f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1762443083; x=1763047883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yiPq/j8AAJTo8QumL7Ou0ccmUXufOZkM5RLHegjZVMs=;
        b=OdOBHfbueRgB62YMyO/xKfh2Zf+yMHwDrCxlE6ZShHQdhZuWQ+n15KOGbvk9ITW06D
         dVs6oN2MurfkC2rWyFo4uH1t2CBIsqJfl2SOQ1XRs7Z+kukQxdL1/zT7M15GG/YjdUe2
         rv0467B33Xhgc8vcR/we4HLVvNo1TL/ytPIYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443083; x=1763047883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiPq/j8AAJTo8QumL7Ou0ccmUXufOZkM5RLHegjZVMs=;
        b=RFZFDZhvwGzVgj6K7e+kVmRIgTczGMQaFphmWSQ7O9lwLsv74o7dt/lC5pMsmVs8Xm
         bwUJgfL5eZ0hLHppvIf5TUAjn0uU75+Up9VgOsRGqJf1d/LMg77QNK2xYrlSAbvGKEaI
         THWzxaYhI5Fufp3xkcztASfLOJ59tsNRKbUIswqbxWnozJE3TZB+jLraIj93FoUxUi9I
         Lf7jPvaM89eCJHlOT09gJQR4nzRdhUK2dW3YX1IYLZZVRb/IYB34sC7zTwrvocVfLV0x
         qvjkC9Via1h/cC3HHljx5rKxVtWvKitp9DJFGakOjMQNzyJCMgPCAzCkGhMMtta6r7nr
         69UA==
X-Forwarded-Encrypted: i=1; AJvYcCV3p/lTkX/p5EieK6B25OgNrFmy/Y6aLzRP9UCiq1+5stvejK0auF2iylpe8LoH/ayl/i1gIHkFLXYEJJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw32ceuL84wRZdnaP5aBEW2BmsDsskmBQP1+WRacZMDPk6bijNr
	x69btiyP+zKUxeNGdiWh9TJM2eihlruIPSrj8E6aeDFNxxoQWDt01oEz3i8fXgYIFBw=
X-Gm-Gg: ASbGncspaIs4FN41raWipvdk1EyqyhKEjdVrB+5HfP7P84tLis7mayOLCy/ba3zo+/g
	qeOEONN1NJLTWCZ+ezilh2sScUNG+4njX41id4Sphx6gcqtB4Qgf8TZTdW7GrUZAu6nvJ4AXokY
	r8oLyjGGCqkR4vEtm6hI3R8g9Mq0mgViVYH00imh0sRhoq6f9cxGwzBHwRcdRMReuWTPwJDx17L
	kj5iyRjUE0a3gbaWZYSEyXiE4ooEXlz0GcrI72QfVBV0ScI3CnrKx3dgcNp0TKzw9EhHw30kBO9
	+VR4OmmPdgx7FIssIj8wybjXUoD2GxmZ4g6wIfOHM5lUaVUGmE6xRVjIDGzIXbrDtrVpuPJxXeJ
	3JY9uG+xBwpYP8ti+50ylkTUL+38Ud4TT0I6ChMgWpkxsiwtFsHmFaqivdRSqaK8p1vpeYFjFkp
	8S6IinNyC3tOnOw4TOlNYO6qC+
X-Google-Smtp-Source: AGHT+IEDkfl3qHSikpIA1Fyk7Grp63BtfKWcdxvISif02sG/ljkZgpwjNMkZU5Sn7DWLfr/nw/w+YQ==
X-Received: by 2002:a05:6000:2c07:b0:429:66bf:1475 with SMTP id ffacd0b85a97d-429e32c6cb6mr6521748f8f.3.1762443083270;
        Thu, 06 Nov 2025 07:31:23 -0800 (PST)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49a079sm5966719f8f.32.2025.11.06.07.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:31:22 -0800 (PST)
From: Riccardo Mereu <r.mereu.kernel@arduino.cc>
X-Google-Original-From: Riccardo Mereu <r.mereu@arduino.cc>
To: andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	broonie@kernel.org
Cc: linux@roeck-us.net,
	Jonathan.Cameron@huawei.com,
	wenswang@yeah.net,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	nuno.sa@analog.com,
	chou.cosmo@gmail.com,
	grantpeltier93@gmail.com,
	eajames@linux.ibm.com,
	farouk.bouabid@cherry.de,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	mm.facchin@arduino.cc,
	Riccardo Mereu <r.mereu@arduino.cc>
Subject: [PATCH 0/5] arm64: qcom: add support for Arduino UnoQ SBC
Date: Thu,  6 Nov 2025 16:31:14 +0100
Message-ID: <20251106153119.266840-1-r.mereu@arduino.cc>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for Arduino UnoQ single board computer. 
UnoQ combines Qualcomm QRB2210 microprocessor and STMicroelectronics 
STM32U585 microcontroller.

In some files we decided to keep UnoQ code name as "imola".

As this platform has a microcontroller connected to the microprocessor
we needed a dedicated spidev and to add uart2 to qcm2290.dtsi file; both
are used as interfaces between microprocessor and microcontroller.

Some GPIOs on the JMISC connector have been defined but not used in
qrb2210-arduino-imola.dts; this is meant to facilitate carrier dtbo
development for users.

Riccardo Mereu (5):
  dt-binding: trivial-devices: add arduino spi mcu interface
  drivers: spi: spidev: add compatible for arduino spi mcu interface
  dt-binding: arm: qcom: add arduino unoq codename
  arm64: dts: qcom: qcm2290: add uart2 node
  arm64: dts: qcom: unoq: add dts for arduino unoq

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/qcm2290.dtsi         |  24 +
 .../boot/dts/qcom/qrb2210-arduino-imola.dts   | 467 ++++++++++++++++++
 drivers/spi/spidev.c                          |   2 +
 6 files changed, 497 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts

-- 
2.51.2


