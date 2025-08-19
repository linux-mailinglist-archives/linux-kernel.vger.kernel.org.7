Return-Path: <linux-kernel+bounces-774642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2948CB2B573
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D14616796B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61CC1DE3DF;
	Tue, 19 Aug 2025 00:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fcl5vWTt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA5B1C32FF;
	Tue, 19 Aug 2025 00:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563978; cv=none; b=GhuyBcO+aXJw4fROsSNKh9iu8z0RaR7cQCGF5x6AHMmQOHQHha3JYBjpoonwACqDAsSVeWCdQdGn6NbHzI2pQKFN6LqE+pVKctdKJDiQWpSgbryomWuhnKIZOoF3RFJN4PccO1YCWs6AvM7OLAa+vI8U8pKie2R5TI+vwzQEPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563978; c=relaxed/simple;
	bh=0v49ZCs+KcrnAsogjZvRFHcVhQAaER7OfcCStKcAGiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuPH+GxMHMd75puPZ+EEzLi/RD0IIsD7H6XYj5VLG1pXQ3tw+DYwMKccfalO37ugAE/16Tco75Zsw+n01s2HdiNtJ88zDhmSB3H14NeTx372cbAxQ8NDRlK63Q8xZ8hrI+Eg5WBAVbCZHKZ25wN8updFPao0guGuH9fx1/a/uZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fcl5vWTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CADC116B1;
	Tue, 19 Aug 2025 00:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755563975;
	bh=0v49ZCs+KcrnAsogjZvRFHcVhQAaER7OfcCStKcAGiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fcl5vWTtZFSObT8RS4N9BZ4tVkR0QfSV6hkX/b/Hvb6lgeu9Y6mfOGvo4oOG/tM/m
	 i1DhyfrP0Ok+n0hyMGM3xAa2Nfbzc320m9jtNguq8Bt6tS5t2h11dUH5IbBwt5mLBz
	 2pihHCB12pKgenRy5MSLP+lsqZ8M7kh+QQWifCOxwoMhPGZ8eA6pT3pbf9c6zbcuv7
	 CbT0hMI4IKVUQ6F2uSvnZWCDLYhABTuXPLl/04pxVdkTjuneVj5iZfa1136LDS6qhR
	 VwDwlI2LrYgHcd6hJ+JiRyEvrGHsS4CycybpIu73n0x4J7cZPcTivlG8dztaIC7V06
	 x77yg1btvo4/g==
From: Jisheng Zhang <jszhang@kernel.org>
To: Richard Leitner <richard.leitner@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] usb: usb251xb: use modern PM macros
Date: Tue, 19 Aug 2025 08:22:16 +0800
Message-ID: <20250819002217.30249-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250819002217.30249-1-jszhang@kernel.org>
References: <20250819002217.30249-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the modern PM macros for the suspend and resume functions to be
automatically dropped by the compiler when CONFIG_PM or
CONFIG_PM_SLEEP are disabled, without having to use __maybe_unused.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/usb/misc/usb251xb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index 4fb453ca5450..cb2f946de42c 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -698,7 +698,7 @@ static int usb251xb_i2c_probe(struct i2c_client *i2c)
 	return usb251xb_probe(hub);
 }
 
-static int __maybe_unused usb251xb_suspend(struct device *dev)
+static int usb251xb_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct usb251xb *hub = i2c_get_clientdata(client);
@@ -706,7 +706,7 @@ static int __maybe_unused usb251xb_suspend(struct device *dev)
 	return regulator_disable(hub->vdd);
 }
 
-static int __maybe_unused usb251xb_resume(struct device *dev)
+static int usb251xb_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct usb251xb *hub = i2c_get_clientdata(client);
@@ -719,7 +719,7 @@ static int __maybe_unused usb251xb_resume(struct device *dev)
 	return usb251xb_connect(hub);
 }
 
-static SIMPLE_DEV_PM_OPS(usb251xb_pm_ops, usb251xb_suspend, usb251xb_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(usb251xb_pm_ops, usb251xb_suspend, usb251xb_resume);
 
 static const struct i2c_device_id usb251xb_id[] = {
 	{ "usb2422" },
@@ -739,7 +739,7 @@ static struct i2c_driver usb251xb_i2c_driver = {
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = usb251xb_of_match,
-		.pm = &usb251xb_pm_ops,
+		.pm = pm_sleep_ptr(&usb251xb_pm_ops),
 	},
 	.probe = usb251xb_i2c_probe,
 	.id_table = usb251xb_id,
-- 
2.50.0


