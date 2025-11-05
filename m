Return-Path: <linux-kernel+bounces-887482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F312C3856E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB86318C55F2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAA62F60A1;
	Wed,  5 Nov 2025 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGkqfFPT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC21299A82;
	Wed,  5 Nov 2025 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762384970; cv=none; b=pYg2GjfUnm2vyAGg+uHrXibzKmSmHhj40f0MXKd9c3Y/2ahA2VetDu/9wPXdbf9NHxC5jY2IyjmwpZg5bqJYSAoBob4DoEvT7MUaXYHFDf0TIjC39X+/xmvES3LxDkruFGV17v9vuHcXGCHAZO6ViPFZWDhmV6v2KYwNyIj0r3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762384970; c=relaxed/simple;
	bh=j48wxTVMNcBqTnSlqrPvSswDOfnZYxx9Wa5yXeAYAxM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QWnloskjfw5fnNPoEPvtuNtih14Wksgi0x+jhd5lcziCA8VYQ9GIHVMRfy8g4CA56OANKKWt4HH7y3VnP9IyO7Lw4xEMMKAz0zPdZLg3sGwk1gla8gn7yVwPF9Qtra2EW/R6UR7btrkdmGeQrNRTG7LHq95A66twm/icQ5MJs3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGkqfFPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31FCC16AAE;
	Wed,  5 Nov 2025 23:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762384970;
	bh=j48wxTVMNcBqTnSlqrPvSswDOfnZYxx9Wa5yXeAYAxM=;
	h=From:Subject:Date:To:Cc:From;
	b=kGkqfFPT2uF/FxLkWBtPVEfIHJ6TgFYvWnZKWKeswZh9CgE9/7GQuTFt1bQ4fFKTD
	 cWq4WokzXXsRL7XfAe1HzpklobPfXf3yXhYX3se2R3795M0DSiKoJjoVYFKw0pTTPt
	 7+l2qzZWtsFedWTfaTzkKSHri8vc6mv5qF5noieHU1v1q50Ggq2XYqsO1Z3EKL46kP
	 nw+wlaW/WHR97ZRNdm/yUM/Q1cGS3DjAbZh3WrHghT3ORoF4hnTyFjUo3hCVmMRyh3
	 Uekoyo1lxXPWEZl69hpJTM2nKTRioYOw4YEz8sKOTXxUA7SXUg8Tf71959CW2ffYdt
	 ixROyKphZgbIA==
Received: by venus (Postfix, from userid 1000)
	id 4257B182F6C; Thu, 06 Nov 2025 00:22:45 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/4] platform: arm64: thinkpad-t14s-ec: fixes and suspend
 support
Date: Thu, 06 Nov 2025 00:22:39 +0100
Message-Id: <20251106-thinkpad-t14s-ec-improvements-v1-0-109548ae75c0@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD/cC2kC/x3MQQqDMBAF0KvIrDvg2EhLr1K6kOSnDsUYMkEK4
 t0NLt/m7WQoCqNXt1PBpqZrapBbR36e0hesoZmGfhhF+pHrrOmXp8BVnDE865LLumFBqsbOBef
 vz4j4EGpHLoj6v/735zhOSJPuq28AAAA=
X-Change-ID: 20251105-thinkpad-t14s-ec-improvements-44d4c38fef71
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=j48wxTVMNcBqTnSlqrPvSswDOfnZYxx9Wa5yXeAYAxM=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBpC9xDP7dZwFcEba534SD2vGZ8tVt8m80E9qhYR
 P34hP7IdM2JAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCaQvcQwAKCRDY7tfzyDv6
 moHiEACLdfSmniditL3sdZCqkOjrF1ZKDOrIwK5d2nFT98b95n7Wh/Y6dr5KZ7+R602F69+uoKC
 RUCMV3lh//vPreJK2AMYgtYSQXTwgHC2C8rayIEBEXytExMGK2HuwPSO2CXMu40FWRS9HST9tIX
 /nYgXa5Hb6Q7EVqPqlaRdmltxZYJEwshbU2sXUit9kiZEQXI0Iw/GYgULRksBCul/1MOB59YTAM
 U2ePoGXGC2b03MiMhJSGAEcT+pM9jfNeuo9edCZh1AiKRyBM87bmsAm7Hd+oyULpfSQdq0FO5mg
 60LcLKcr1q+znbMIadJ/Yj6i9BE5hXYMW01HQqaFGMpbc8/HKRxK+6kfUYtdMwBFFlVBzwK8wRT
 EfdHJhLs3pYNYXpMIg+5CNEIfyBjMcQAfUWL3bXGok/l6i3pbyxoSCn3HbZ97oc6dti4oMdnsuN
 RXX74KQNv1gAgi/lKK3f+TYbJHw5yd6/Z8qQM3O/xaLGj3gqYW+ORJcpYRJOM1GlWCZoT3r4pLM
 xS96bHG7dlw93ZrseN0DCyN9WwCQfQpTjCYfx+uoLDFvkY500XvwVo1gjgnrNaHMZGvOGFQ/Vxv
 0avRNp5FHLv9zEV9dJ5DGN6gHt6jptjWvxnoWvAnmjKjQ9rtxiaLOPpts1WH3OTSrn22LPX7DWV
 2igywmD0fTvgk9w==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

I have a two fixes for the T14s Gen6 Snapdragon EC driver as well as
improved system suspend support. I've been using my Thinkpad with these
patches for a few weeks as daily driver doing regular system suspend and
things seem to run well.

If there is enough time after review the fixes are probably good
material for the 6.18 release cycle.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
Sebastian Reichel (4):
      platform: arm64: thinkpad-t14s-ec: fix IRQ race condition
      platform: arm64: thinkpad-t14s-ec: sleep after EC access
      platform: arm64: thinkpad-t14s-ec: add system PM hooks
      platform: arm64: thinkpad-t14s-ec: add suspend handler for keyboard backlight

 drivers/platform/arm64/lenovo-thinkpad-t14s.c | 73 ++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 14 deletions(-)
---
base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
change-id: 20251105-thinkpad-t14s-ec-improvements-44d4c38fef71

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


