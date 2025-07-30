Return-Path: <linux-kernel+bounces-751273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D95B16722
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0BE5833DC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C4A217F3D;
	Wed, 30 Jul 2025 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVlTJ9V9"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212771EEA40
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905186; cv=none; b=hWQ9HE30jBbDtfqe9SD9ZRm3T4ouYKUlfVLPWkmUL2nfxWn1GczRoBqyQ+IvglLB+M3HTx7i26ft6hVRTHozt8WbLp5ycNIS0tW4YYBhQeGGQEL2Gk/DQ3QK8KeXbmA3J1WRt9Sxwbjo6Vl/WUyi5JzrKes0KRfBDfUx9lvlTPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905186; c=relaxed/simple;
	bh=MfTnB37EEj32Y5FjkQTo/dmxJhOyRQ8e/zW2nSleFZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ViNJ7klHPgIhn1zs80hi5acDdkiDq63Oo6+Vw35aJ8WkEQolbYFUwVmylS5Yt1ZgFN0NVwkez13yKMOhRn0jE5meXvU+UEfe3w0NkOlraq10emALldCWcXeav8sJlTzY987dPKjOCQweyCjnJqYsO6qTk2ED/Xp1xngsnUn8y3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VVlTJ9V9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b77b8750acso75763f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753905181; x=1754509981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WTJ04XJW9rCytOzTtWrCv6iwwB/BOv81eXrzl0rsCXk=;
        b=VVlTJ9V9NR5vDJXL59iPaEy7QidU7PNCsxKvAX4nhzmkpsmSzKSUMbx86VfwLExSBP
         lS0979r/NYNvb41duV+1JBHnV3CIZeR4pdtjIvehnEXiCCWTfoePIMzk/GIDWaSutSe5
         HWRPjKg3owRSPkM5JNrtj2J62JpwzgAzKnjLw4e8PnrPwpOYHPFUZfbGrmo6ktMErWrY
         xKfvcd5tEqKP3N50zoUFgoBTkt1iw/tZhy3bKQjokT0LbUi/v7skJxBnwNRaGB/e3lmu
         y3xpK8EX1ec1xIfVZ5jsRp/XTjl4K9oFZ9iSb/KhxZDjGLC9L5tcR/q0FgSGW4Ni1Yrd
         QSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753905181; x=1754509981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTJ04XJW9rCytOzTtWrCv6iwwB/BOv81eXrzl0rsCXk=;
        b=ZMgaxrXrXjjL57hPvx6AYlbGI9d0EhnD8bWDCm3yy3oorQ2CuyussYCMlNNFQcQYJF
         CP+9vFRJ1esJBcB5FEFWEDOddFtEvTsDASswBsOFZZDdCJe4oqEGo4e6FFtguCbIsBPO
         7kP53iPJKD7Tp3KGzf6TYY21u6b8ox5negCwbVLJu73HYJhzbm28vwvoA7ePCWxioeJq
         eCrq3QtuBd8ARdjdpSJkVeU0P5D7MkcNQ12XjYBdB7QsstXbNKMiqfPrBEZMCpoGGfJ9
         EVG+JNCJxueK5ZVrQqcxgHA2qxDWPQjFVq82o6kbzn269BlLRTcoybnQOr1Du9ZJ+efI
         4MCA==
X-Forwarded-Encrypted: i=1; AJvYcCXu+6swsUMpTQa61rcwkPeyQ2jwp7XJiT0UMCYzlj1wxEGagIwv2k7Hg54YSq+izaG7dg6bSrgEZapPNxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/XzMRYSuO0jEW5NakUC3lwx9bN/eAD9z4fmsoFeQbcvGLObUh
	/JePwSO4urjaIkpBKMA5fWwqB92DlCdNh7OFBlAktHSX8PKXftZbtomBBakgXlf6Nlg=
X-Gm-Gg: ASbGnct1VsJzzNN7/WT9PW4k3SE1j01ll/uv2MThqenzEXfvAGoRnRa252GIwxxDyAl
	5BQqcoeMwJt++xzEjQZ9dIC72qVGdh888EZbwoztsxX5Y/MpRSxb/EHfFhro+TU59SJBXthBadj
	jpwdPqgvNSWNKFdUT6/ykfxoVNNYypLFmEZ3rknbZ/2eLZTBgJbV3A7ezxEt29zLC5NDtyZSHzp
	vHiUVn/VEe7VQ8Yl50P2qO6bUFALY3b9ARFirPzekubl//wffnWfBQFdxcGLtKYelJVvf3rsiST
	0gzuGmac+y++lDzmhLbpxgXlQ2y5XAQejQTLr+g9PZSCP0WHTm2juPuAZh6WAA8eq7Gs4F4EFX9
	ZeWEhve70AbNZhZ2XbiHWB6M2WnkkPoPzPFOd3WMvJ9a/zAgW
X-Google-Smtp-Source: AGHT+IF1QpqFcMkkrFcPI7L92Qa8qVcCM46GAZ3UfOx8fwQ0i6q08CK1SCZ+XKjU+FsVU7KYpwE0Xw==
X-Received: by 2002:a05:6000:2890:b0:3b7:879c:c14e with SMTP id ffacd0b85a97d-3b78e6239b0mr7443255f8f.20.1753905181405;
        Wed, 30 Jul 2025 12:53:01 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b78b26a4dcsm9556193f8f.32.2025.07.30.12.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:53:00 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: mbrugger@suse.com,
	chester62515@gmail.com,
	ghennadi.procopciuc@oss.nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: s32@nxp.com,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Add the STM and the SWT descriptions for the s32g2 and s32g3
Date: Wed, 30 Jul 2025 21:50:13 +0200
Message-ID: <20250730195022.449894-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NXP S32 SoC family includes timers and watchdogs that can be
dedicated to the CPUs present in the system. The documentation refers
to them as the System Timer Module (STM) and the Software Watchdog
Timer (SWT).  This design originates from the automotive domain, where
the SoC can be partitioned, and a group of CPUs may run different
operating systems or firmware.

On the S32G2, we found 8 timers and 7 watchdogs. On the S32G3, there
are 12 timers and 12 watchdogs.  Please note that the 8th timer
(STM_07) is not described here, as it is coupled with a specific STM
instance used for timestamping. This makes it somewhat special and
requires custom handling in the driver. It will be added later.

All timers and watchdogs are disabled by default, and are selectively
enabled depending on the platform configuration, which may include
different combinations of Cortex-M7 and Cortex-A53 cores.

This patch series introduces support for the SoC and enables both the
s32g274a-rdb2 and s32g399a-rdb3 platforms.

Testing was done only on the s32g274a-rdb2, as I do not have access to
a s32g399a-rdb3 board.

Daniel Lezcano (8):
  arm64: dts: s32g2: Add the STM description
  arm64: dts: s32g274-rd2: Enable the STM timers
  arm64: dts: s32g3: Add the STM descriptions
  arm64: dts: s32g399a-rdb3: Enable the STM timers
  arm64: dts: s32g2: Add the Software Timer Watchdog (SWT) description
  arm64: dts: s32g274-rd2: Enable the SWT watchdog
  arm64: dts: s32g3: Add the Software Timer Watchdog (SWT) description
  arm64: dts: s32g399a-rdb3: Enable the SWT watchdog

 arch/arm64/boot/dts/freescale/s32g2.dtsi      | 119 +++++++++++
 .../boot/dts/freescale/s32g274a-rdb2.dts      |  20 ++
 arch/arm64/boot/dts/freescale/s32g3.dtsi      | 195 ++++++++++++++++++
 .../boot/dts/freescale/s32g399a-rdb3.dts      |  36 ++++
 4 files changed, 370 insertions(+)

-- 
2.43.0


