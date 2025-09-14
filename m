Return-Path: <linux-kernel+bounces-815646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFFAB56964
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE57189D194
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60941DE4CA;
	Sun, 14 Sep 2025 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jSCiUFo5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59DB1373
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757857366; cv=none; b=mbsiqeJwa94d8MaK5ckusm5qLBVqGbu1BFfU2SDE00S/3SX8xxtsuHClJcTr93yCv8osuz6JcG97BqADpwGQGRfEo2WwiudI26Aekmnh+N3a39qFH03KhZTFwj93+qLEHmy4JJrr9JrMQaytp++0Qr+QSk7zTflll3Rsh/Dp+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757857366; c=relaxed/simple;
	bh=oYDlfrb/Tc4g3zJT1KECMbk6jxJeMztwJvvkcS4yCqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7X4pBF4zgTMxC38vXeKPw5tKvLYkdS36CiBq1MKdG51zbpXLteWpGd0/bg+z3wGZqsn/YGormvBvGHksPaQn+04rRlHdCcPyPHVd1VNosGtNwQLYyZGz+XRf3pOhnWVZx7yDxDi7Mb8E3Zxia5VhLqmvkrOoKyUaysosEJPEwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jSCiUFo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104DDC4CEF0;
	Sun, 14 Sep 2025 13:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757857365;
	bh=oYDlfrb/Tc4g3zJT1KECMbk6jxJeMztwJvvkcS4yCqw=;
	h=From:To:Cc:Subject:Date:From;
	b=jSCiUFo5ozQVxcxgczuBXhi1CBjPJftKpZa2lReT8E8faFL1hdXhx4Jxv+oa/kCeD
	 ZWGP/karglmu2PKn4sm9F8xYqx6un1gXwnMkGHfPoJepo7r1gKek0r57E7c3gYjgnY
	 +iu0rtA9plV1x0F0kv1ndP7htIg7uUhCxBZT1h64=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>
Subject: [PATCH] cdx: make cdx_bus_type constant
Date: Sun, 14 Sep 2025 15:42:40 +0200
Message-ID: <2025091439-sustained-acorn-4af4@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 49
X-Developer-Signature: v=1; a=openpgp-sha256; l=1711; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=oYDlfrb/Tc4g3zJT1KECMbk6jxJeMztwJvvkcS4yCqw=; b=owGbwMvMwCRo6H6F97bub03G02pJDBnHjvm7mp3mY7dJu7JB8G2oScy/lE2Zf755tzQem71P6 2pI+BHXjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIV1mG+e78Hbszf3HaHP88 req015tT1y97H2CYHxDieEV+Nvuusg/nxPqfNc16HvTGEgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the cdx_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Nipun Gupta <nipun.gupta@amd.com>
Cc: Nikhil Agarwal <nikhil.agarwal@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cdx/cdx.c           | 4 ++--
 include/linux/cdx/cdx_bus.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 092306ca2541..26f296b4a489 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -170,7 +170,7 @@ static int cdx_unregister_device(struct device *dev,
 	return 0;
 }
 
-static void cdx_unregister_devices(struct bus_type *bus)
+static void cdx_unregister_devices(const struct bus_type *bus)
 {
 	/* Reset all the devices attached to cdx bus */
 	bus_for_each_dev(bus, NULL, NULL, cdx_unregister_device);
@@ -651,7 +651,7 @@ static struct attribute *cdx_bus_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cdx_bus);
 
-struct bus_type cdx_bus_type = {
+const struct bus_type cdx_bus_type = {
 	.name		= "cdx",
 	.match		= cdx_bus_match,
 	.probe		= cdx_probe,
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index 79bb80e56790..b1ba97f6c9ad 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -234,7 +234,7 @@ int __must_check __cdx_driver_register(struct cdx_driver *cdx_driver,
  */
 void cdx_driver_unregister(struct cdx_driver *cdx_driver);
 
-extern struct bus_type cdx_bus_type;
+extern const struct bus_type cdx_bus_type;
 
 /**
  * cdx_dev_reset - Reset CDX device
-- 
2.51.0


