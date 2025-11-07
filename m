Return-Path: <linux-kernel+bounces-890871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6549C413FB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4E63B6C68
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C723396E7;
	Fri,  7 Nov 2025 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="HeYFu6gp"
Received: from mx12.kaspersky-labs.com (mx12.kaspersky-labs.com [91.103.66.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C308328B6D;
	Fri,  7 Nov 2025 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539405; cv=none; b=NhBJf5CCH4IsONJWl0ZZLQDVNoYz6iRmZXxBBG9PN90pCwFDRaanN3Z/IWPkGlFken2MY7XajeJCRwm4k/cqcoMD4Xeh2jnDKV9TQFuWj8/OGZmUNISgH0WDga2pzGPhVnLuxJUOgONjWH4xwCAtVhuWosxCwy+i6uq6DBFWwgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539405; c=relaxed/simple;
	bh=Xi75ePOiBwipzkX64VguLZPYu6lK2LKiNPyywNr6x+0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ccmRQiGn5xRE0SyKvN+NTr2som9kVf5OI1elegWQLmUyEU2/5nyOrYxjTOjAAcjESb/c0+jBPfekqhhfoVQlObHA+NA62BoLvn7Pnlvp8w3A45xc8k8s9Ts4oH2VSD2I89UkDfsV14zgDoF/hb0OYIuN/LcvPz4APomqzIFN8ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=HeYFu6gp; arc=none smtp.client-ip=91.103.66.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1762539400;
	bh=H1R1v7ueagpfrCvNWa+dlV0YbSTd9iEHgul82VXM2Kk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=HeYFu6gpYwh0VeXNk/e6+Nb7kTHcKd33PW+eM1t3NrpGST4+rGfGnqtjntdYawoGx
	 JnknUCaWOPAeeMoZEdUpajDG55VevKjTZDDzsIEOg9Sd+EiOJgNVuntN3/Qkf+XtMR
	 Ii43Ij3XgpEVMFTg8nvtV7WCYaeCCYsn0+BBDTtc8Af2169JRrKU9c12uLqdB1N3GY
	 4hYxt8Gql54fihjUAxK5ObHvUE9vvj2440xRrym0wzMLvYq9mN777GnlC04lZbco2V
	 nudtsOZRxFVSd1qTaNGtC+SZXTHvbswQl1GReAAjCjRQWbBFOY+yFO1sozGwcyJ2fB
	 u9Z0WUwdBh8ww==
Received: from relay12.kaspersky-labs.com (localhost [127.0.0.1])
	by relay12.kaspersky-labs.com (Postfix) with ESMTP id 272145A49A6;
	Fri,  7 Nov 2025 21:16:40 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub12.kaspersky-labs.com (Postfix) with ESMTPS id 6F4625A536C;
	Fri,  7 Nov 2025 21:16:39 +0300 (MSK)
Received: from Nalivayko.avp.ru (10.16.105.14) by HQMAILSRV3.avp.ru
 (10.64.57.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 7 Nov
 2025 21:16:36 +0300
From: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>
To: <linux-media@vger.kernel.org>
CC: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Michael Krufky <mkrufky@linuxtv.org>
Subject: [PATCH v2 0/2] media: dvb-usb-v2: add init_ready flag to prevent  race during device initialization
Date: Fri, 7 Nov 2025 21:16:21 +0300
Message-ID: <20251107181623.2139080-1-Sergey.Nalivayko@kaspersky.com>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/07/2025 18:01:40
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 197893 [Nov 07 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Sergey.Nalivayko@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 75 0.3.75
 aab2175a55dcbd410b25b8694e49bbee3c09cdde
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;kaspersky.com:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/07/2025 18:04:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/7/2025 4:59:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/11/07 16:52:00 #27893595
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
  media: mxl111sf: fix i2c race condition during device  probe

 drivers/media/usb/dvb-usb-v2/dvb_usb.h      | 4 ++++
 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c | 4 ++++
 drivers/media/usb/dvb-usb-v2/mxl111sf-i2c.c | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.39.5


