Return-Path: <linux-kernel+bounces-861030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61000BF1A18
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A1B24FAE41
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F57B31DD8D;
	Mon, 20 Oct 2025 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="md9mWb92"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23E2319879;
	Mon, 20 Oct 2025 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967808; cv=none; b=DMNaxxrrkLULFb6y/iYOHBENY92zPKdX97VBYvgfSdS6UB1ZhXiIVQ8YX6fyVxyzCojnWADrp/Tz4BLT7aqPKDeTjKRz0uPXspGBj90Hh+NwlqF8En/WDCIJ3vv6g+28TgdbMs5YASWbEHHOp/aYJLvR83p7wiltKXXRmbM95lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967808; c=relaxed/simple;
	bh=8fFrhDP0KaCxAVrbpRUNmgPjoVBgr7VhwvgoaMy7WEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5cuSQQpxuZR5c+NLflZq1zNt7QJHTRIyzafmo7BlNFc/CK2uLEzue+10Z6SHQP3sZCi2++psmHEm9cFrYOHb/T1E5ZpkmoRLpm+JQEdSKHJJ1HBWRmELKfxVwY3G1hNUI1Iu/vdYXj9Mxw5FP5FW6b4OYMLfgYj1YWrU2s1r2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=md9mWb92; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (p508786f1.dip0.t-ipconnect.de [80.135.134.241])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 1403E2FC0050;
	Mon, 20 Oct 2025 15:43:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1760967794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VqFNqr3WY3AmlNUZZEYMTwy3oDDEKBrPqLIAZ2cMM6k=;
	b=md9mWb92ttEsjpldQJ488awxp95hlaZt8MsoK05CXzv6pi4lwiFslGVCmwIGzttSzV0cfB
	SxH9TcC+kdWoftrkJizckbR3mHStbNQ0kmMVB4gFtiH44GecAy9rIeXfqyVzTZxGliFLPu
	j6QZzMST4UoOa7AkFEx2enneIqI208M=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tim Guttzeit <t.guttzeit@tuxedocomputers.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] usb/core/quirks: Add Huawei ME906S to wakeup quirk
Date: Mon, 20 Oct 2025 15:39:04 +0200
Message-ID: <20251020134304.35079-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tim Guttzeit <t.guttzeit@tuxedocomputers.com>

The list of Huawei LTE modules needing the quirk fixing spurious wakeups
was missing the IDs of the Huawei ME906S module, therefore suspend did not
work.

Signed-off-by: Tim Guttzeit <t.guttzeit@tuxedocomputers.com>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
V2 -> V3: Add these version changes notes
V1 -> V2: Fix position in struct for it to be ordered by ascending dev ID

 drivers/usb/core/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index f5bc538753301..47f589c4104a3 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -467,6 +467,8 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Huawei 4G LTE module */
 	{ USB_DEVICE(0x12d1, 0x15bb), .driver_info =
 			USB_QUIRK_DISCONNECT_SUSPEND },
+	{ USB_DEVICE(0x12d1, 0x15c1), .driver_info =
+			USB_QUIRK_DISCONNECT_SUSPEND },
 	{ USB_DEVICE(0x12d1, 0x15c3), .driver_info =
 			USB_QUIRK_DISCONNECT_SUSPEND },
 
-- 
2.43.0


