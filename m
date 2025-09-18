Return-Path: <linux-kernel+bounces-823099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B25BB857EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB19B4A178E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D131C3314;
	Thu, 18 Sep 2025 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bMjBielc"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B25E208994
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208418; cv=none; b=kYYMKvQ3J0rzLOTwk+Y+y1XVef/U4mYyDG9Cio30wxq1Ns584NUtcKvCfQIv9ffdCcndMJnTEwLX/SyfZ7H44FCkeEG4tjB5S7P+z12EAhJsfNgfezVS4OZL4/tphta9w0C+WB1YPGetjLdVgkptNEkwo2xD4UxUPSWljOC3YBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208418; c=relaxed/simple;
	bh=u0Oonq5rXsXHackeh+mC0B/Cd9fTXvTVENWJwcGJ6IE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OjdycfC01biOyMOgN9Wd8ao86xId49wW9VefN0JVdksiO/R3Ew1Qi/CwGwUsdes2lkbs1/EFX3xS1ggfTpMd2DntlWBcNuN2HmweF1utEimuCbT4ABskpLtqfE+z25k4Srlx3wLvUuuoSvSB9u4qcu3UAVhJLPQ0t9xj9OZcwTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bMjBielc; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758208414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UZlY27g1GzDBPlJ71lPF4nbjRPMZJNeQ8E8eHlGEEpw=;
	b=bMjBielcyPTWgweG0lIhynv/mDTv/i78P45QLd8IBLv+yeKGUsmU0V9pRFcDxOUbrAZGfc
	NOKYQ9F9Wbt9YpBES1ejBaVjcXafHQKTKCu5Jq5zB2pclLRky4ef72RoDrqmOv96T2uKFY
	RT8RL1GzVObGcnKGDMrkzOdyYAL9Sh0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Penkler <dpenkler@gmail.com>,
	Oliver Neukum <oneukum@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: usbtmc: Remove unnecessary local variable from usbtmc_ioctl_request
Date: Thu, 18 Sep 2025 17:13:22 +0200
Message-ID: <20250918151328.331015-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The local variable 'res' is only used to temporary store the results of
calling copy_from_user() and copy_to_user(). Use the results directly
and remove the local variable.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/usb/class/usbtmc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 75de29725a45..206f1b738ed3 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -1936,10 +1936,8 @@ static int usbtmc_ioctl_request(struct usbtmc_device_data *data,
 	u8 *buffer = NULL;
 	int rv;
 	unsigned int is_in, pipe;
-	unsigned long res;
 
-	res = copy_from_user(&request, arg, sizeof(struct usbtmc_ctrlrequest));
-	if (res)
+	if (copy_from_user(&request, arg, sizeof(struct usbtmc_ctrlrequest)))
 		return -EFAULT;
 
 	if (request.req.wLength > USBTMC_BUFSIZE)
@@ -1956,9 +1954,8 @@ static int usbtmc_ioctl_request(struct usbtmc_device_data *data,
 
 		if (!is_in) {
 			/* Send control data to device */
-			res = copy_from_user(buffer, request.data,
-					     request.req.wLength);
-			if (res) {
+			if (copy_from_user(buffer, request.data,
+					   request.req.wLength)) {
 				rv = -EFAULT;
 				goto exit;
 			}
@@ -1984,8 +1981,7 @@ static int usbtmc_ioctl_request(struct usbtmc_device_data *data,
 
 	if (rv && is_in) {
 		/* Read control data from device */
-		res = copy_to_user(request.data, buffer, rv);
-		if (res)
+		if (copy_to_user(request.data, buffer, rv))
 			rv = -EFAULT;
 	}
 
-- 
2.51.0


