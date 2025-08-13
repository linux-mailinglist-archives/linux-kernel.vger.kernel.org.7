Return-Path: <linux-kernel+bounces-766471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 730E5B24704
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E1B3B4A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CF72777E8;
	Wed, 13 Aug 2025 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nvUDsrfR"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D842D1F7E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755080043; cv=none; b=Mo+x/GLE3UkUG7BEPuxodmsk0EuPt5o0fgerpJSwFThN7za1cVXdMqUNbHhqWBux+bWDgWZUi5lPoMiufyi2aPqcerBxRqtmvIAFA8xe/eiOrHf9DXO8CIeao8E+wMN3jM2YUk4SpXatMSseKYSnUpexaHvM4BwR7TRxAOn2V8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755080043; c=relaxed/simple;
	bh=U/6z9EuFW5yuEe5BDIjFeLvVI0kXMK2Jf0kmaFK/5dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F2SM55JNPT8f5hHB5RJoQSjT2aMYYPOgbtyU90XxhVfaeeXUmA9AFS+Lx6/hxsiwh5ifl45tH2TUeueEc9fePs9tnvnY9fE/P9xwzWG1J9PpFmpuCsxtbcMM2fd7Wixohn+JCIpeKgWXtYzplYxEPaWagAv1jeljvU4EeCws39c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nvUDsrfR; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755080029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aSS/JGql2rVWBGs/YfOqn5/C1ygBaFsXRhS+TJXTsnI=;
	b=nvUDsrfRBIvLA6GbHYTMNZTvKvne99xTN0deJDIk3MqMAwcttE8u1IkKq41ksqlFYOkGWU
	emT7OE2lORgS+ophQ5s28KCGEtX1kSKd0Cc5/dpUjutuWni6i0XSvwavCS9PdPNUBNaY5d
	9Qjg2+aJsXEUrlnxsIVu4NLsVFDI6aY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] usb: storage: realtek_cr: Improve function parameter data types
Date: Wed, 13 Aug 2025 12:12:47 +0200
Message-ID: <20250813101249.158270-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In rts51x_bulk_transport() and rts51x_read_status(), change the function
parameters 'buf_len' and 'len' from 'int' to 'unsigned int' because
their values cannot be negative.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/usb/storage/realtek_cr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index 7dea28c2b8ee..d2c3e3a39693 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -199,7 +199,8 @@ static const struct us_unusual_dev realtek_cr_unusual_dev_list[] = {
 #undef UNUSUAL_DEV
 
 static int rts51x_bulk_transport(struct us_data *us, u8 lun,
-				 u8 *cmd, int cmd_len, u8 *buf, int buf_len,
+				 u8 *cmd, int cmd_len, u8 *buf,
+				 unsigned int buf_len,
 				 enum dma_data_direction dir, int *act_len)
 {
 	struct bulk_cb_wrap *bcb = (struct bulk_cb_wrap *)us->iobuf;
@@ -417,7 +418,7 @@ static int rts51x_write_mem(struct us_data *us, u16 addr, u8 *data, u16 len)
 }
 
 static int rts51x_read_status(struct us_data *us,
-			      u8 lun, u8 *status, int len, int *actlen)
+			      u8 lun, u8 *status, unsigned int len, int *actlen)
 {
 	int retval;
 	u8 cmnd[12] = { 0 };
-- 
2.50.1


