Return-Path: <linux-kernel+bounces-785710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3738B34FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3594A24082F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1202819DF66;
	Tue, 26 Aug 2025 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kcf4Ft+X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F3118FDBD;
	Tue, 26 Aug 2025 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756166552; cv=none; b=hA0luct3xIYzkSfOQL6gsZrO54JdxU/VtBiVs9+HpXHCftFZLk+zA0DsFxF9WCEg6fJb06KQbxRD5Zt5nk7IIvXa5ZT199YvgfHw0NbP910MLisW+cB9c2T7fgGjnEdqH2wIK2F2G8c6wfB0AEQEQTTbPSpBkjulhNTQYMdSKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756166552; c=relaxed/simple;
	bh=E+HOFeMVe9JLsQxHTXcM4m4kgtbJpD9lr4nTy7ApPo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLopibEBE0+cOFJE3qLmeq9XSUPd+FJbG7gJwCR3zsw1nWUuiXbQFD5gasfGGKgT41kdbfkSepEFT6/PY/CEFCvUWj1BS5hF3tD/xu7W3Pprtcl9+xi3d9QwAyveSA1lhpytx+iCwX6I0oX4PgQr2fTw0hrJtuijjQEExT6wHsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kcf4Ft+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471A5C4CEED;
	Tue, 26 Aug 2025 00:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756166552;
	bh=E+HOFeMVe9JLsQxHTXcM4m4kgtbJpD9lr4nTy7ApPo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kcf4Ft+XNPoTlcNh1cq6k6cOt1CZ9VF7T4lZKnCrlj7N04KSnjwmM2/clmbQ3A6Qm
	 JseVZUM2iONiwAZbyBJimypHBmuBbgQW1BmTI100O/77EA06npnW+puVrzR1q1xF4y
	 lw0HNsaoeCWvbtOSAgoo+QCs3j4PDl2aH3izwlLY1GFqD8zKsNpoVlp48xZ1sit3Q2
	 VvL5S6DpFTbl172AJPpYrIcAyIJdLGkNV0qxWC6YDTim6r64ftctf2aiZpZQ7ZyAW7
	 VwiPmd0k/IJsQUTV0TnR9RngkcIvNLjCvAYamquX3w6kNjnuAZXVY4dbvz/KNNFMnv
	 ZHCsxPJF8apGA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Richard Leitner <richard.leitner@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] usb: usb251xb: use modern PM macros
Date: Tue, 26 Aug 2025 07:45:08 +0800
Message-ID: <20250825234509.1041-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250825234509.1041-1-jszhang@kernel.org>
References: <20250825234509.1041-1-jszhang@kernel.org>
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
Reviewed-by: Richard Leitner <richard.leitner@linux.dev>
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


