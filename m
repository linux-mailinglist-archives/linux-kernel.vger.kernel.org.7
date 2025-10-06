Return-Path: <linux-kernel+bounces-843040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8068BBE470
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005FD1891F57
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358892D47F2;
	Mon,  6 Oct 2025 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="LYocGvGx"
Received: from mx13.kaspersky-labs.com (mx13.kaspersky-labs.com [91.103.66.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B233927FD51;
	Mon,  6 Oct 2025 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759759597; cv=none; b=PjN/VvwsZMMDp2JYkNeQfuDxUlJR0PVGZXRJgvmfBoi3vRfJMo2gOdFVhckX5K3awVQpRcS5jEH+XrYlmd+DWVM+hHJ3VDpe99/lTfvhVUdxWqHjUuuD9QNMxd4GvJ8iOX2tAJtkS26vhCrKxYKv4iJmJJNcgvNqRYL7MbV1p8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759759597; c=relaxed/simple;
	bh=Bg+LDPTfIuzjaYiybbYNDse+KEcJd0p3G95PkmbFPPk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NJqztQPdXEOKvGTXqP99e9Xp+pGcftXpIIcu/Gxby194NAu+aUYFy+kGDfe/Ptbk7Qj8RP6MpD2Kgm3Kx6Ia+PKwUBY4I7/67DgneDqLRfAl2RSyja7k2GMxFVPyGR/QuONg4+q0aHZMO75StNZfbkiE2rNjSjmAlaLbhth5fRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=LYocGvGx; arc=none smtp.client-ip=91.103.66.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1759759594;
	bh=5miWpi1kibqGA/F3XsgcIaA0DROTbkODnxAnR9p8Bjg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=LYocGvGxRrNhIkicVWuMLKhv/hCs69muNUJmya/+FgBVVZ1Hm7d5m2xL2FYpreK2s
	 r0LYilJwp0iTC3Iiw7yDzYyzWO220cyzq0Ej/PYinglF5rbstRVLjcrX7VOduucM2Y
	 2TlRG6T855PZJW1fz/pJq/75voBi5QTxMIZOKnUVynlg1zZYa3J18wTHEruRxExzbA
	 NOI1U9Mzp5RaTJ0uG7iaLIxDU2A0RwxtksdHU242kWH/rBC7UQ3Hgb2IPQZN14y+t7
	 MP9SchEXBWJ/rNljL51dZ1l5qsTVQ4I0BsbiS/km4vVm/f6+sO7FWw37VOmME6KXVK
	 KFYWrVveB2QFw==
Received: from relay13.kaspersky-labs.com (localhost [127.0.0.1])
	by relay13.kaspersky-labs.com (Postfix) with ESMTP id F2BAF3E46BC;
	Mon,  6 Oct 2025 17:06:33 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub13.kaspersky-labs.com (Postfix) with ESMTPS id 838CE3E35CE;
	Mon,  6 Oct 2025 17:06:33 +0300 (MSK)
Received: from zhigulin-p.avp.ru (10.16.104.190) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Mon, 6 Oct
 2025 17:06:32 +0300
From: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, Peter Korsgaard
	<jacmet@sunsite.dk>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] usb: c67x00 - fix potential division by zero in c67x00_end_of_data()
Date: Mon, 6 Oct 2025 17:06:30 +0300
Message-ID: <20251006140631.1406643-1-Pavel.Zhigulin@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV3.avp.ru (10.64.57.53) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 10/06/2025 13:54:44
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 196843 [Oct 06 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Pavel.Zhigulin@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 69 0.3.69
 3c9ee7b2dda8a12f0d3dc9d3a59fa717913bd018
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: zhigulin-p.avp.ru:5.0.1,7.1.1;kaspersky.com:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/06/2025 13:56:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/6/2025 12:33:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/06 03:36:00 #27884816
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

The function 'usb_maxpacket' relies on the value of 'epd->wMaxPacketSize',
which can be zero if the device reports itself as an eUSB2 device
(see 'usb_parse_endpoint' in drivers/usb/core/config.c). Under normal
conditions everything works correctly, but if a broken or malformed
device is handled by this module, a division by zero may occur.

Fix the division by zero by checking the result of the 'usb_maxpacket'
call.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e9b29ffc519b ("USB: add Cypress c67x00 OTG controller HCD driver")
Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
---
 drivers/usb/c67x00/c67x00-sched.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
index a09fa68a6ce7..3211843497cc 100644
--- a/drivers/usb/c67x00/c67x00-sched.c
+++ b/drivers/usb/c67x00/c67x00-sched.c
@@ -868,6 +868,9 @@ static inline int c67x00_end_of_data(struct c67x00_td *td)

 	maxps = usb_maxpacket(td_udev(td), td->pipe);

+	if (unlikely(!maxps))
+		return 1;
+
 	if (unlikely(act_bytes < maxps))
 		return 1;	/* Smaller then full packet */

--
2.43.0


