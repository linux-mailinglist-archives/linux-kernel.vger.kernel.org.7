Return-Path: <linux-kernel+bounces-878821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAB8C2189D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683261898821
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E42236C23D;
	Thu, 30 Oct 2025 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdxVrIps"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793836C250
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846110; cv=none; b=LdeoOUMhihM/nQWf1jS5VBReVdvcrJUpzyFGgbznijGzn2HnSiekVf3yXiLiFQXGkszQ+9XDAHlRW2Y+lExY90BQbRvs7kKeJk2+MFyNvVQ5iSZ1rGoRz3N4nhJKLW/n8SXe0/b5O+Pf7mRinDBtlplWo6q0Y3emDiipo6yDqdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846110; c=relaxed/simple;
	bh=PPpcJ+LeQYqPWNStI16pHKVV4v0AwdL8+TrLmQI+rT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8V0lVlmqrrkH71YaIXlOKPou+D4w7BEs+jj9zlT6pIz4zjHCzFfdkaEINlrJIWX8CilcYLKweOCX5jYXKp/m49TqemeS298eq7VgmjfYekhY4pCr8uY1p1yV1bBRbhCu7Dntz+vD2FBp+5/FGMd3VkuXfcPwp9qieSyPl3NCqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdxVrIps; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-591ea9ccfc2so1906107e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846106; x=1762450906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2tMZVGlgJ/tzJ2avrVXvI1uqWovw6kCly6XeUNYPNL8=;
        b=YdxVrIpsJ4mo3HLfVZubJ6QOHHve2693DQtkqm+ElY0SajtuQASRDMKP7EfhCz51QO
         GMN2ErnsgM7b9c0q9Pg2twXfLKgcsKMynaLa8164+9LCQznrl09m4gaK2tfxELBDeQaX
         T3qZw3BnExhUMK3FDHeKFr/4nsQ1z/FpYBGE4tX7wkMm8vaVmv+jbpJmQhzbqGiEie5l
         qHMoHW14tXysiJ0i+RuNDhh46jTsw4jUreLArinPHTix4f6rpz5LL0dzFp6iE4vIClY7
         77YuuPmhJLrDWDBM3Wv4f4Tf+6zYeUrnWbG0OtD92jnKEaf1vIWhd+rY0qw9Gp4FUwOF
         2Scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846106; x=1762450906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tMZVGlgJ/tzJ2avrVXvI1uqWovw6kCly6XeUNYPNL8=;
        b=DGeFioBX7h6WGQ5WMb42y+xG1B6iId7zAoq3fybA7x5NfJy/4b+5Gp2I7XJDD+ns13
         c0RanvzdVS6DtqSuxyL0bpazxVvbXyDD8NReHqT3iJmBQ1ZtlgLej4XrsclXQXr0nR8r
         Cu/WHri36XabqLT0bgVK3k/uzBaMnTNHHNXJVUpXnZQP94BoUgRC9edzQetsIOu11kk0
         BC6OY5HgwdnfK9RyjtSIthDj+a2haDH9SakPPJIu2u/jrc06o8P9fQUUy15la9p5hCb/
         pN5qn+t8rlONZrKYCU6yOnDbgikOyu1BY6iAiYQN8K52RSmFHnSeAMbdg6IoJjPp4Qmk
         2mxA==
X-Forwarded-Encrypted: i=1; AJvYcCUGrkGxgGjlvfT3S4gSzTwQcM1G4ipqUx04eRo75jKEYWXNlmVNEhzHHeDHpibHlFmUqKM9L2WAOkRB1JA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/oIR8tK50vKhIpvZwf7JkTiZwjUC2PU+rSGOmZhbaSLU4OUcD
	GuIo6QbUcdFp1soXz4hCakAoQi/UdtK7s9XLghkEZQzKW3FvgaD09W4tyPuvWa/0
X-Gm-Gg: ASbGncuWQ9VxxoXxNf7xAQES6qWnBtyfWqti7lcl3WL2TsG+vX8LMpTWbyI0qxY54jZ
	XsRriz5G/acGSqfjAdp0LPoDgdJlkQqNjYXKLoMj3CyQcVuuUBepniowNDloWloC2HFn7+iBEr3
	pfTbdSNLcotjN2gGGYtDs+TGiLNdn1Iq7oIiircMfgNPFWSyCB6aoigP30QFOLq/KKXZAd3wCPJ
	KPpKu9VWnwOtTcMNH6cepbXE5Upfs7CMjvnXJaDlL2+J0zREBlXxf9qZD4/KI3NRAEzbdr0qgqz
	U9c+hnoXjzQOwXke04Yvj43yD6UaM+nfwPjei6lkj5wnE00gbDDZDjyfsIK4mw6sA6iTJ2+MkS5
	2F3T7s1dYLVXxN5+q52kBuM5WctU6Fr9bmsBKJoCtbozaTPEuv5gVOUXUDsrpjt7NmgvUcMO1Cv
	N8tNTDqAkdJA+6q+2tYBqwaaMwARY=
X-Google-Smtp-Source: AGHT+IE59wDXoDY9Ty/nX580ekGeU+nSofSVIV4X1mRII6fAyM9CpBxt6kxcxiREme7sLfFLOLbT5Q==
X-Received: by 2002:ac2:4e11:0:b0:594:1a8a:3858 with SMTP id 2adb3069b0e04-5941a8a3a2dmr907581e87.4.1761846105581;
        Thu, 30 Oct 2025 10:41:45 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f6e644sm4793397e87.79.2025.10.30.10.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:41:45 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: a.shimko.dev@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_dw: Fix runtime PM and use _DEFINE_DEV_PM_OPS
Date: Thu, 30 Oct 2025 20:41:41 +0300
Message-ID: <20251030174142.2039122-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move pm_runtime_set_active() before UART port setup and registration to
prevent runtime PM from suspending the device during probe. This ensures
the device remains active throughout critical initialization phases like
dw8250_setup_port() and serial8250_register_8250_port().

Add proper error handling in dw8250_runtime_resume() to maintain clock
state consistency. If clk enable fails, roll back previously enabled pclk.

Replace deprecated RUNTIME_PM_OPS macro with _DEFINE_DEV_PM_OPS for
modern kernel compliance.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---

Dear Maintainers,

This patch series enhances runtime power management in the 8250_dw
driver and updates the PM ops to modern kernel standards.

Thank you for your consideration.
--
Best regards,
Artem

 drivers/tty/serial/8250/8250_dw.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 710ae4d40aec..0c0a9fc97fe3 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -643,6 +643,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	err = pm_runtime_set_active(dev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to set the runtime suspend as active\n");
+
 	data->uart_16550_compatible = device_property_read_bool(dev, "snps,uart-16550-compatible");
 
 	data->pdata = device_get_match_data(p->dev);
@@ -685,7 +689,6 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
 	return 0;
@@ -741,19 +744,25 @@ static int dw8250_runtime_suspend(struct device *dev)
 
 static int dw8250_runtime_resume(struct device *dev)
 {
+	int ret;
 	struct dw8250_data *data = dev_get_drvdata(dev);
 
-	clk_prepare_enable(data->pclk);
+	ret = clk_prepare_enable(data->pclk);
+	if (ret)
+		return ret;
 
-	clk_prepare_enable(data->clk);
+	ret = clk_prepare_enable(data->clk);
+	if (ret) {
+		clk_disable_unprepare(data->pclk);
+		return ret;
+	}
 
 	return 0;
 }
 
-static const struct dev_pm_ops dw8250_pm_ops = {
-	SYSTEM_SLEEP_PM_OPS(dw8250_suspend, dw8250_resume)
-	RUNTIME_PM_OPS(dw8250_runtime_suspend, dw8250_runtime_resume, NULL)
-};
+static _DEFINE_DEV_PM_OPS(dw8250_pm_ops, dw8250_suspend, dw8250_resume,
+			  dw8250_runtime_suspend, dw8250_runtime_resume,
+			  NULL);
 
 static const struct dw8250_platform_data dw8250_dw_apb = {
 	.usr_reg = DW_UART_USR,
-- 
2.43.0


