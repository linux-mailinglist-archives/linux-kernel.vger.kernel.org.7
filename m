Return-Path: <linux-kernel+bounces-743932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9591FB105AD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63B877AEECE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630C425A2AA;
	Thu, 24 Jul 2025 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ2H1yd+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB05259CA9;
	Thu, 24 Jul 2025 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348832; cv=none; b=WL05fZ3dqgqO2hvnnzDs5+nX09h+Yv/Ih1Q6uCUEac9o93NoyJtZqEY8O5ZCul9JDiFgTzduNF9HdlXD2qJMHwMvjO5Srm1tvwa2CBLNo3MY7fWY9Xo9UxT5knMwHgBkIDlA80SOdbI4oYZ8dpmgzYvwnW45vHI4WPS+a6kNQNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348832; c=relaxed/simple;
	bh=hqvA7P/13its3aivenGaO2NqOrueFUv24Dfs34xTs3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBnn3S3pWywTLIdPvq//uI5FqnmPXZK/Uluk4GqDsxK/Hj1HWxr3FR0ISZcFZbBNb4awPowXhtbCQoYifjrv7AeXzX9/jht5dwcJ03TInMHebQJCOkX5vhWZ5pcDoKSyVpe4gyJqX5p+zE3P/JawgY3g+e6gbnHQT1w3KmxdsbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJ2H1yd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62ACDC4CEED;
	Thu, 24 Jul 2025 09:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753348832;
	bh=hqvA7P/13its3aivenGaO2NqOrueFUv24Dfs34xTs3s=;
	h=From:To:Cc:Subject:Date:From;
	b=bJ2H1yd+9vc/FEBk/fbohVen2PmqHcG/pXX6ekau9eKDs359qCUhbSwGOT9vrR+GG
	 3ncMojhITojXR7GKfRe98V8GzdCQbqVPTZQeHp3F0JY4RWrdpdmn1KWA5BeZDoGgUR
	 ANvCm4yavEQvxbDyHBuCTM3nOSLLTouK3LxnkRdYLJMMt4uL+up+gnd5K/3DS1vkT/
	 4AmEv1gyDBmfncuOSokYT2x98urb4r2AfsqZbXZDulPp57kUvt/ncgReP93sdCefwh
	 IOrHWG/ufDO0wcw9P2XozWtWWrbdwC1H7E4ucsZKsvMEWfC+NpENjbmz3Q8nhJq+tL
	 Wc0LGgQ+KGOpQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ues7n-000000005Wt-25Vy;
	Thu, 24 Jul 2025 11:20:27 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] usb: gadget: udc: renesas_usb3: drop unused module alias
Date: Thu, 24 Jul 2025 11:20:06 +0200
Message-ID: <20250724092006.21216-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit f3323cd03e58 ("usb: gadget: udc: renesas_usb3: remove R-Car
H3 ES1.* handling") the driver only supports OF probe so drop the unused
platform module alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/gadget/udc/renesas_usb3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index d23b1762e0e4..bdb88ab0ff73 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -3024,4 +3024,3 @@ module_platform_driver(renesas_usb3_driver);
 MODULE_DESCRIPTION("Renesas USB3.0 Peripheral driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>");
-MODULE_ALIAS("platform:renesas_usb3");
-- 
2.49.1


