Return-Path: <linux-kernel+bounces-858181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3A1BE9375
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD696256A5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD812F693C;
	Fri, 17 Oct 2025 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="Hqexg1/D"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A72F6939;
	Fri, 17 Oct 2025 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711604; cv=none; b=tlHiJ0snoP50GGn3v6Gtgl9EXtZSdhE7ZZ9lq0Rcn0BJL201zYI9CC2CJONmJAqpKZwtQIfu1hPhI9b4rH0VjJA48LevGqDL7f4S+csDwMeakZ3OBBPxWNgTwt3uLhLfpUXJr4nRNVN9UWvWqXj2x+HLFCXIKf8se/7xc2gUVvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711604; c=relaxed/simple;
	bh=fVvCz3Cpik3TdxhPNbRzhVT0GZj2LIF44Fiw/u4n9D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p/7LHd0DkuQjWUBabN2l+GuZ9+69n3B0n6679lxiFVSImCUAMWiZdP2H/GOmel8FtCovgmv3wEkLnzsLaEhNF4ZmmfEQMu5ACdNoI63PDGjViSvyC1qfOcg8PJXPs5CrFJPey9eZxfsoM5kb6/msJ43ehHuzwNgGJUyY6Kxkdpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=Hqexg1/D; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.buero.augsburg.tuxedo.de (business-24-134-105-141.pool2.vodafone-ip.de [24.134.105.141])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id B8D702FC004A;
	Fri, 17 Oct 2025 16:33:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1760711593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2XDUgZKp3ZjzB7WzKPrKtXmgnSLE6fMWhlzVB7fb2zM=;
	b=Hqexg1/Dr3a5Kx78ykfUXtvwdpcMXAqCTo2MaJe4B/cEOu2W5CTRljRSD/LGweROEu27ef
	sNFxxYtkz6MKhrzTxchGE8U+l/G8fATAUF2HRkZYOTHOhImY3EeXzkmgBp1moMZ24ITLKn
	e/cjX6Qp5A/xM5tw9kQr36O2431C19U=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tim Guttzeit <t.guttzeit@tuxedocomputers.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb/core/quirks: Add Huawei ME906S to wakeup quirk
Date: Fri, 17 Oct 2025 16:33:03 +0200
Message-ID: <20251017143310.40220-1-wse@tuxedocomputers.com>
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


