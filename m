Return-Path: <linux-kernel+bounces-879238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6143C229C2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CB51A6288D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E90133BBB0;
	Thu, 30 Oct 2025 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="jIfWXJ6J"
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83FC338F52
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761864979; cv=none; b=Kkgs2jmTW917aKwmofEp570AfcHXkXQS6QlH+lBxvpFUxaixSlq68t6MsrHKlQ4Zt/tkOQsk7ZZBlATbff4isAmagteOuauGWfA+ggUbdaOEbQwkJnvFFkNa85+lqg/Qjk+i2NtuIcwg7cAUGEhAcn3mvMloLy+CcPkA4MiMUX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761864979; c=relaxed/simple;
	bh=za7GP3ze8Bl47AzFh0DvbMIKVK7iHE91wg6Ax4tQvpE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TSCsitpDnfdANbqJOkGsaGKOosxtJ9mXZVLd4QhF/TiDfnylHEwmJaIcdTt75Bbnb4i8bSaaHt1wiDS14Y8rPqdnYDmzMsIogLWH46DeC0lp4i4ZeZjJw2nVYyG13rkDe0UjWEQ2LAod8yoY07nk39mmdz0OrHzMs5b37W/h7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=jIfWXJ6J; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: c1bb6f3c-b5e3-11f0-9c78-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c1bb6f3c-b5e3-11f0-9c78-005056ab378f;
	Thu, 30 Oct 2025 23:57:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=ylYUdD1zsIaoFYNnP7ZvpCwbn0I6EnGCUZk4aQXYy8Q=;
	b=jIfWXJ6JvHmgeHu0b8PQMmki5ka2ftgtfAoS7kxsSetwXwZzVPiVTXZj63Xd2vtsrc/G9VEUAWyXZ
	 AlE9+KwvU00MiCR5K4I1t8CCqj0wgVqpQhOeTcmaEg4jF+xecgTb/FfznEBRwZA0mM3YexczJqi1M7
	 GROZok8Zz5ubccKHHVDZsxCRNvBNfAOmfxs4wS42rGNG5G2emtwYF87lssJMBPn680PSYgkf6gxq2V
	 73FdJycDYwT2kpcHu8YVjm8U5FDhedtPOTJC1A3w2NXPmpaCWUqjWyZJa/rWgUZyLBuig0/uzWjP/v
	 POlPe5vODZ9TFBc2kWGV2PCoyJxUcyg==
X-KPN-MID: 33|ca/ZxccZVDam99Hen6bJnYEEjZf2chUC12A3lDXQQ2P5A22zf/6UBcLhte+uVP7
 andT0kKZAePGc4EaA8/+kOXYxUjJy0ZHgpBybKaJJ4BM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|UiRTcqtvZTApAAKfOxUFhnDCNoPZ2z2I8w2NISP77sD9h3w9YQM2X2eToCLFSOk
 8vdp6JpUhwej1IkWSS2OVSw==
Received: from htpc (5072af59.static.ziggozakelijk.nl [80.114.175.89])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 9e52390f-b5e3-11f0-a6c9-005056abf0db;
	Thu, 30 Oct 2025 23:56:07 +0100 (CET)
Date: Thu, 30 Oct 2025 23:56:06 +0100
From: Philippos Boon Alexaki <palexaki@xs4all.nl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Philippos Boon Alexaki <palexaki@xs4all.nl>
Subject: [PATCH] Input: xpad - add support for the ZD O+ Excellence controller
Message-ID: <aQPtBpx6bQMCw1tF@htpc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Adds support for the ZD O+ Excellence controller.
Tested with a wired connection.

Signed-off-by: Philippos Boon Alexaki <palexaki@xs4all.nl>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 4c94297e17e6..3805780d5be3 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -296,6 +296,7 @@ static const struct xpad_device {
 	{ 0x10f5, 0x7005, "Turtle Beach Recon Controller", 0, XTYPE_XBOXONE },
 	{ 0x10f5, 0x7008, "Turtle Beach Recon Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x10f5, 0x7073, "Turtle Beach Stealth Ultra Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
+	{ 0x11c0, 0x5505, "ZD O+ Excellence", 0, XTYPE_XBOX360 },
 	{ 0x11c9, 0x55f0, "Nacon GC-100XF", 0, XTYPE_XBOX360 },
 	{ 0x11ff, 0x0511, "PXN V900", 0, XTYPE_XBOX360 },
 	{ 0x1209, 0x2882, "Ardwiino Controller", 0, XTYPE_XBOX360 },
@@ -541,6 +542,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori controllers */
 	XPAD_XBOX360_VENDOR(0x1038),		/* SteelSeries controllers */
 	XPAD_XBOXONE_VENDOR(0x10f5),		/* Turtle Beach Controllers */
+	XPAD_XBOXONE_VENDOR(0x11c0),		/* ZD O+ Excellence */
 	XPAD_XBOX360_VENDOR(0x11c9),		/* Nacon GC100XF */
 	XPAD_XBOX360_VENDOR(0x11ff),		/* PXN V900 */
 	XPAD_XBOX360_VENDOR(0x1209),		/* Ardwiino Controllers */
-- 
2.43.0


