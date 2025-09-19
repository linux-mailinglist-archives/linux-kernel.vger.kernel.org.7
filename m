Return-Path: <linux-kernel+bounces-824475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A78E6B8955A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236237E1D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2203430DEAF;
	Fri, 19 Sep 2025 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E7tAE8H4"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F4D30CDB9;
	Fri, 19 Sep 2025 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283077; cv=none; b=Zorc9j9jLC53Pr/XC+/WEXSrjd7jKyxlLQYiHZX9VZtJ/HDYOsInlRKaWzrZwiY4gSzPOI4+VUFpupmKvO2nIAJlBUzvwPSE9mP5GRo8MmJRC5SsO40aSrerV3V2Sdg51YEnGyhCoRO+AO8wGUZcLMly9ir243Mpi4TQt015aiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283077; c=relaxed/simple;
	bh=KR3FJmlJvtd65Muxd63xrmx06R6KmJHYs2/e7ruIfO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJ7GFA+OuMIsMCwtwLJ9qRjElIHqO2YGbMIv/nZsUWwi06ySETcZ/RsgnDrJSiU4y9p4LKjbTVbKD2pCCI/e73cCfdaarcn5o4Tp9F44c/oxMiekXZ4AVYN7dvIoEEZs8ova7QQlUN2pgrLvzm2mb9RIThyChKwLYI9mgKtx5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E7tAE8H4; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758283072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0rO2wW68rSedEDCCjxodwfMESNI+P46hNUk5VIQj2Q8=;
	b=E7tAE8H4EQD8W9wBoVdXJMOZSTvCmrAkzwtUTL0r1B7chlkuIT7pgpKH6um+Gs4jrmqLEo
	I0WwYgwffaRKjGZnrI83ilK+bw8dNjiohiYE3gt9W/PPx7rEt0BYTJ3N9By2BqVqZOFX3P
	95gAEYPc63gPvSEH2rkJixr0mXfEKlU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Jann Horn <jannh@google.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] USB: core: replace kmalloc + copy_from_user with memdup_user
Date: Fri, 19 Sep 2025 13:56:50 +0200
Message-ID: <20250919115654.1011141-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user() to
simplify and improve proc_do_submiturb(). Replace the hard-coded 8 bytes
with the size of 'struct usb_ctrlrequest'.

Return early if an error occurs, and avoid manually setting 'ret' and
using 'goto error'.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/usb/core/devio.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index f6ce6e26e0d4..3bc54a5c59ff 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1670,13 +1670,9 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
 		/* min 8 byte setup packet */
 		if (uurb->buffer_length < 8)
 			return -EINVAL;
-		dr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL);
-		if (!dr)
-			return -ENOMEM;
-		if (copy_from_user(dr, uurb->buffer, 8)) {
-			ret = -EFAULT;
-			goto error;
-		}
+		dr = memdup_user(uurb->buffer, sizeof(struct usb_ctrlrequest));
+		if (IS_ERR(dr))
+			return PTR_ERR(dr);
 		if (uurb->buffer_length < (le16_to_cpu(dr->wLength) + 8)) {
 			ret = -EINVAL;
 			goto error;
-- 
2.51.0


