Return-Path: <linux-kernel+bounces-778193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A24B2E270
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98151C838E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64C7334718;
	Wed, 20 Aug 2025 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijGAaa/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4679E3277AA;
	Wed, 20 Aug 2025 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707704; cv=none; b=bT/KmQN0aoJjnNIQTwy/5CdrjGwYTmnQ28M69ses8WXbTB4lnyfYNPtNwojxejrHFOZqdtBRliIkBqyu/qB+C40UPSxW1QbloDXak1N2+1skEwfJuQFjIbusnSEWkGjLUnq68FqEIEfyXToW8dr6CDTCq8qZx02L7Ct07h4ox4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707704; c=relaxed/simple;
	bh=0v49ZCs+KcrnAsogjZvRFHcVhQAaER7OfcCStKcAGiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bP01zif/ypv0OWSB/HdRxSmuKSVElXuxUmNXKwEojVXDU4h1O7PylyzoXZ3pbEKOW3jP8/HO/6ojHtM8sfYJvIEqF56D+8qYbwGCFLmhr+QIh+C29qdkHE14YdNmmRjaTOSh7DuwTwYaWKaMVfYx/dY5KkomOwIXnCVv5iFjiMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijGAaa/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E896DC113CF;
	Wed, 20 Aug 2025 16:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755707703;
	bh=0v49ZCs+KcrnAsogjZvRFHcVhQAaER7OfcCStKcAGiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijGAaa/PdByQD2evorBqzsMciW470R/Zfu80c54df+WKD8vM+ZOXl6uiOs5j7/Gh/
	 jVaVLhj0CfuCH96IZIB9r9AN8Ol6vuYp0I0rKPrAMdskCqJprxNfWzyeoICzOzeKQU
	 /jFD3eJUcIOCKr/0teV1BsvTt+JqP8JSWT7O5cs9Vsu8m4wFeWboFWZLXOFhiGvb0q
	 Ay84i6AQJEQUXCTFOeFXLpzHjAspn1Cl8b/N8FY4/w39urO6ZiymVj9aiKDxxQdTtv
	 9JSOgFDLFczGoTFPREIqCHf8I9wfywLaaq8UrzSmF1NM/6jgWY/0UO94FoDbOk8R6w
	 2Xlld+bwrJlyQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Richard Leitner <richard.leitner@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] usb: usb251xb: use modern PM macros
Date: Thu, 21 Aug 2025 00:17:42 +0800
Message-ID: <20250820161743.23458-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250820161743.23458-1-jszhang@kernel.org>
References: <20250820161743.23458-1-jszhang@kernel.org>
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


