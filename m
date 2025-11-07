Return-Path: <linux-kernel+bounces-890701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2FEC40B16
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15276350178
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A48A330300;
	Fri,  7 Nov 2025 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="owAuX2s4";
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="RN0rp9DZ"
Received: from mailhub9-fb.kaspersky-labs.com (mailhub9-fb.kaspersky-labs.com [195.122.169.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497AA32E753;
	Fri,  7 Nov 2025 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.122.169.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530897; cv=none; b=R7M6zPGZPSgBjYiC898LCtXhUnrZUDAoDiPGd8e9SGSCMZ91HF80JOxW9gm6uCnHMPJgZ0E4hN8Z3t6Vz26zD3HxnhIGm4A5lDcZ2zBfQqOTYFMpZ3Wmmg2LA6cuJBBjM+aWMKc3LaaAwzqfNdEf72RTHYQqwyldeZhPBCm1OWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530897; c=relaxed/simple;
	bh=0kPZIRWiQDeuxUV2+ZIjVBj0pHRaQ2tC4rF8+P00BW0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZqKkfHiyF5ttxUFlQtWL7VaZ8VAuigYSLopEg5czW+lFyX39UQD/YEsWfknUguoxhfhfy+iaM5tVIAEZflhKqx+3gyIlgqUvmo775bpJ3WY7sxqDvD3AeyiI1CZ9VnPrE4ekd35vSc68YeKBgfMbLxKZSL0ndouimjfvwES1dgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=owAuX2s4; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=RN0rp9DZ; arc=none smtp.client-ip=195.122.169.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1762530332;
	bh=YoL0rmniGZrR8nKZFcQUMl53tWAqxuZqCMgD831YzeQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=owAuX2s4ve3J1Pqi5nD1xfNa+PgHwEjIVTnL0I8LpsjTUXEtADXylpLPgl1fnrLM8
	 THOPkPuHZ7mJ0Js6Bh9pmhKe0btnsKv/PqEdLNyBb7HQ9DC10xFGAktTw9BIditFNJ
	 IuS/8CL0aj70yyj6+MPUnFgW+Z+fMmB1JqIqIlZ0WgnR72GrP4psC7mtVFm+xtnH2u
	 Uv1kZNLPUhuibYhKgCC7JkppQy5wSs5jim1/whZHJQcEBUfHgHQ0qLtIoayf+h1jTe
	 ohUyQPrUiYecO2XGDE5mDt7F1Vl2DVG2DKgt+N4x6L01Ri/rvidwXpxTgj7On380k5
	 jINzPFrbokriQ==
Received: from mailhub9-fb.kaspersky-labs.com (localhost [127.0.0.1])
	by mailhub9-fb.kaspersky-labs.com (Postfix) with ESMTP id C5D899002A9;
	Fri,  7 Nov 2025 18:45:32 +0300 (MSK)
Received: from mx13.kaspersky-labs.com (mx13.kaspersky-labs.com [91.103.66.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "mx13.kaspersky-labs.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub9-fb.kaspersky-labs.com (Postfix) with ESMTPS id 9CC489000C3;
	Fri,  7 Nov 2025 18:45:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1762530323;
	bh=YoL0rmniGZrR8nKZFcQUMl53tWAqxuZqCMgD831YzeQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=RN0rp9DZFnymQdKkreWZiih/4SBJF+FODp1Z3y/hMHuxE9XVBNa6dvKbwrfK/Ltrz
	 GYefEhqxfaF+KZTIJL06ydPvMvPAvFTOBAcAFxVUisFT9oTz4b4tg3Lfh58KlEIJCX
	 IlHBW/Z9nadQKLSZkgpSzxPRyOrzAA/WS6M+eUptIbkDxLEvc4tfABlmyLDc4wMs7+
	 i94SBHfxGW+Rf5yk0pqxeWFWSFMiCUUKUu/SHhQGKobgIW8CK1ZlhKPWYaQomQC1+W
	 3Jc9+YK+niI1hyq7WT7mny3mYc89hTVMzfwfrMdHKWYMj3rFreh0mQge1rkG83JUEs
	 q6IbBNJAxPz4w==
Received: from relay13.kaspersky-labs.com (localhost [127.0.0.1])
	by relay13.kaspersky-labs.com (Postfix) with ESMTP id C4BDC3E450E;
	Fri,  7 Nov 2025 18:45:23 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub13.kaspersky-labs.com (Postfix) with ESMTPS id 1D00A3E1CB8;
	Fri,  7 Nov 2025 18:45:23 +0300 (MSK)
Received: from Nalivayko.avp.ru (10.16.105.14) by HQMAILSRV3.avp.ru
 (10.64.57.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 7 Nov
 2025 18:45:07 +0300
From: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>
To: <linux-media@vger.kernel.org>
CC: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Michael Krufky <mkrufky@linuxtv.org>
Subject: [PATCH 0/2] media: dvb-usb-v2: add init_ready flag to prevent  race during device initialization
Date: Fri, 7 Nov 2025 18:44:24 +0300
Message-ID: <20251107154426.2116743-1-Sergey.Nalivayko@kaspersky.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV3.avp.ru (10.64.57.53) To HQMAILSRV3.avp.ru
 (10.64.57.53)
X-KSE-ServerInfo: HQMAILSRV3.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/07/2025 15:33:04
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 197892 [Nov 07 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Sergey.Nalivayko@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 75 0.3.75
 aab2175a55dcbd410b25b8694e49bbee3c09cdde
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: kaspersky.com:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/07/2025 15:34:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/7/2025 12:14:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/11/07 15:09:00 #27893311
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

This patch series introduces an atomic init_ready flag in 
struct dvb_usb_device and adds checks in relevant code paths. 
Drivers now verify that device initialization has completed before 
performing operations that rely on initialized device state. 
If the device is not yet ready, the operation is deferred until 
initialization finishes, preventing race conditions and improving 
driver robustness.

Nalivayko Sergey (2):
  media: dvb-usb-v2: add device init_ready flag
  media: mxl111sf: fix i2c race condition during device probe

 drivers/media/usb/dvb-usb-v2/dvb_usb.h      | 3 +++
 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c | 4 ++++
 drivers/media/usb/dvb-usb-v2/mxl111sf-i2c.c | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.39.5


