Return-Path: <linux-kernel+bounces-887113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE2AC374DE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FDD44E2FC3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FE728851E;
	Wed,  5 Nov 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="TX8ysI6q"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D97527FB3E;
	Wed,  5 Nov 2025 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367343; cv=pass; b=YdYu9+qvXFMV//S5euxPIPRH1TE4Za+gyIVIq8x/A+0mN+A/HDkXr7CwlLImL6zsqF0s66e2S/2IvMsOePxtypAVYQ+X7gi8Qrk9LkQ8glBZ6/HFech0uqAICpgo057hK8qynY/N1kQ1ca03Swn4PMM/FW9P6jYsUMlXI67ruWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367343; c=relaxed/simple;
	bh=SU/bsUwM+HoPIs92Ouw+DFCvPKGPGahFo6YRpSY/4LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0U2gZkvOGKRSOlsBmRJnBhQGpKOBtMk5wMklPXuZydlIsUCazXnd4L7DDnN8z4OYPsfcMeJE9dazGfn4m8TE66YM7HteyjeZQaf7d8xvHWqVxjCRv6aFWSCBAURA1sz4u03GpXhrBX/vwVC6V8q+fGvZJuOIYvdw+8c6rKw28s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=TX8ysI6q; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1762367327; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DaNxRoIk5ACShAi6mWew7AbY9Ztesm/u85EnBqaBhJIgGHWKj47Fcd8n4D+1aZlHQBLGddNfTopjA9M14VP4LUEr64NpccqidNPrYapjmuoaz9msuTuFkqAZajGf5cIz43zsqrrZmnJMEr2YCU3xycm9zwipMGzNyWrFFXC7df8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762367327; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IGLjGXhNn4DguPrtx8t3L9/KLNA0+GEhlRcyDGItUWg=; 
	b=DsK6DwKyybvReC0kzi570g4fEm/IR2LrEstUtkZ4BP69Bi6VN3VTr/RlkAZW8MB4TUdzfjni/oMGI9ybm/xcJLijD2GxiV/1AuCtcOAC/xx4KMk3FyDql12B/Qbhb85WYzo5o4Tod8lPo1Ggb0dW93SPIz4lyAv1trnW2IDt+N8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762367327;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IGLjGXhNn4DguPrtx8t3L9/KLNA0+GEhlRcyDGItUWg=;
	b=TX8ysI6qnTySqQJbmQQn+SGRXCU5QxFk12KFwcR81HoiXGnU6Q9xT9Jb2L5ymy1O
	TIFlC2MQaVCHwodDv+SObxjlFx8Ew9eVA08hu3EpNuC4IQcraS8ips0WFIJPe+9JmR+
	PlvLZbmD9qbwtGiry4g8vol8DBZ7vwxg4Uy3n/bA=
Received: by mx.zohomail.com with SMTPS id 1762367325249927.5777512192999;
	Wed, 5 Nov 2025 10:28:45 -0800 (PST)
From: Rong Zhang <i@rong.moe>
To: Ike Panhc <ikepanhc@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Rong Zhang <i@rong.moe>,
	Jelle van der Waa <jelle@vdwaa.nl>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH v2 1/4] platform/x86: ideapad-laptop: Use str_on_off() helper
Date: Thu,  6 Nov 2025 02:28:24 +0800
Message-ID: <20251105182832.104946-2-i@rong.moe>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105182832.104946-1-i@rong.moe>
References: <20251105182832.104946-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Use the str_on_off() helper instead of open-coding the same operation.
This improves code readability.

No functional change intended.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202510311551.xjWbHTrm-lkp@intel.com/
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/2bae2ea7-2ef9-0cfa-0c2c-39a7043b2aa5@linux.intel.com/
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v2:
- Include a seperated patch into this series (thanks Ilpo Järvinen)
  - Fix missing include (ditto)
  - Reword commit message
  - Link to previous patch: https://lore.kernel.org/r/20251031184435.44819-1-i@rong.moe/
---
 drivers/platform/x86/lenovo/ideapad-laptop.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
index fcebfbaf0460..b61ed6993990 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.c
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
@@ -31,6 +31,7 @@
 #include <linux/power_supply.h>
 #include <linux/rfkill.h>
 #include <linux/seq_file.h>
+#include <linux/string_choices.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/wmi.h>
@@ -462,25 +463,25 @@ static int debugfs_status_show(struct seq_file *s, void *data)
 	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL, &value))
 		seq_printf(s, "Backlight now:  %lu\n", value);
 	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_POWER, &value))
-		seq_printf(s, "BL power value: %s (%lu)\n", value ? "on" : "off", value);
+		seq_printf(s, "BL power value: %s (%lu)\n", str_on_off(value), value);
 
 	seq_puts(s, "=====================\n");
 
 	if (!read_ec_data(priv->adev->handle, VPCCMD_R_RF, &value))
-		seq_printf(s, "Radio status: %s (%lu)\n", value ? "on" : "off", value);
+		seq_printf(s, "Radio status: %s (%lu)\n", str_on_off(value), value);
 	if (!read_ec_data(priv->adev->handle, VPCCMD_R_WIFI, &value))
-		seq_printf(s, "Wifi status:  %s (%lu)\n", value ? "on" : "off", value);
+		seq_printf(s, "Wifi status:  %s (%lu)\n", str_on_off(value), value);
 	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BT, &value))
-		seq_printf(s, "BT status:    %s (%lu)\n", value ? "on" : "off", value);
+		seq_printf(s, "BT status:    %s (%lu)\n", str_on_off(value), value);
 	if (!read_ec_data(priv->adev->handle, VPCCMD_R_3G, &value))
-		seq_printf(s, "3G status:    %s (%lu)\n", value ? "on" : "off", value);
+		seq_printf(s, "3G status:    %s (%lu)\n", str_on_off(value), value);
 
 	seq_puts(s, "=====================\n");
 
 	if (!read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value))
-		seq_printf(s, "Touchpad status: %s (%lu)\n", value ? "on" : "off", value);
+		seq_printf(s, "Touchpad status: %s (%lu)\n", str_on_off(value), value);
 	if (!read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &value))
-		seq_printf(s, "Camera status:   %s (%lu)\n", value ? "on" : "off", value);
+		seq_printf(s, "Camera status:   %s (%lu)\n", str_on_off(value), value);
 
 	seq_puts(s, "=====================\n");
 
-- 
2.51.0


