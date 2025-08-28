Return-Path: <linux-kernel+bounces-790374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9863AB3A638
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4215E62E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0355D32275B;
	Thu, 28 Aug 2025 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oDjU0KnI"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209ED32255C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398424; cv=none; b=BvsIHLZUgH/snKZCB5uuhxadb4EtLTgHImsyhqymG5bBJM7Q89yDxb5ykNOkpbLG8kcD9SAThcD4GGI9TKWbs+oUH32d+IqdvwP9F0eg9z1VzNC993f6vrz42l5P1qsnyUiLK6NiZoMirb5rWv7U+tFhU/SYe2qr1C38NzZ9/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398424; c=relaxed/simple;
	bh=vhIwjMEKHDUbgyw/UEvayi72XXEgzaWVlsm5VzzTmzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bRJes5Fn4c8T8azuz8o+qCawvwV0bql+vijpOzznL4bDm2Ofr1frnQ1dnre8Z/gUHJAIsY/cTzCL1ZFH5oSI+f5YH4DBuQBwfSv+npbkRXT7LjXe3kY/XHU20ifPawlnGDvvdmj7pHhUj5hWMa0cSN2qSA/IbgopTns1x71/Wbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oDjU0KnI; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756398420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LcTj8AYdceOqTQSQLAc0f2c7JRl5hi315MYDEFAy0FY=;
	b=oDjU0KnIjOdCGvWRlRvKOzLEFyXpZVCQdYpa3vBU7RH7GW7zIV+8apXzo+tW9pRB2fEMew
	P8PnkKt76JtLOUoExm5mJHbAEMVeBnuyG0wXxXfqCAwSjtYzvhRzsXJJHFsAs1jnqadTft
	Bsb03vAzsJuLdFQ7AfD9FU/MBJdHO0s=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] usb: storage: realtek_cr: Simplify residue calculation in rts51x_bulk_transport()
Date: Thu, 28 Aug 2025 18:26:24 +0200
Message-ID: <20250828162623.4840-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Simplify the calculation of 'residue' in rts51x_bulk_transport() and
avoid unnecessarily reassigning 'residue' to itself.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/usb/storage/realtek_cr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index 2a6c7c567e1c..758258a569a6 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -261,8 +261,8 @@ static int rts51x_bulk_transport(struct us_data *us, u8 lun,
 	 * try to compute the actual residue, based on how much data
 	 * was really transferred and what the device tells us
 	 */
-	if (residue)
-		residue = residue < buf_len ? residue : buf_len;
+	if (residue > buf_len)
+		residue = buf_len;
 
 	if (act_len)
 		*act_len = buf_len - residue;
-- 
2.50.1


