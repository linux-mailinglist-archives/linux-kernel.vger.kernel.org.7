Return-Path: <linux-kernel+bounces-880811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED6DC26A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE395403C1C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01FD2EDD44;
	Fri, 31 Oct 2025 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="RwnENpa0"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03492EB840;
	Fri, 31 Oct 2025 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761936300; cv=pass; b=l+ju8T02vGNPB5bzj4gufgk2VO4H1nI4H2auUzFzwogphDe+eaGlADMZ4hdxJF0E/WH73IU1XfXH8kAQu3VpO3j0nw8MZajBxRtnoIsKB+lxmUQwjHYZtp2x1vfJNSyZ/dmYpaolH2IrpLq3is36ZjWdVNFnkHuHziNgHRgiBJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761936300; c=relaxed/simple;
	bh=Kn0hVmiMZe6srWfx7oEVgbBhPTlhv5RyzSy+kHFBKOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jNCuMA3iJnV6C/JMRCUuxhttwaLFrW6NYOemf0DydmeBfH6mesqVAsQq4t+xWfVxJSZCwuBajHoRLhie+V/4xvj5HpigJzZJHVtSIkVACN8zCW1g2MzEIfvwfQJjfnDMCWZEFGjKUQDQoDy4kqAS982qr15e9hkqwJAJthePXxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=RwnENpa0; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1761936287; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TNJhZjrQ908OG7ijOQsBTCVU2u4CCixw/dNft+IBL4qmQtVXW54YyJzIf+iPelEkpMRf3uXS5IadTXVXoLd6rirIVY8zn5R7f+yeeDyj8AF8w1HqPihDSjYBVWLoKeGBHE26OsJS8+sRrDProM0qzZwIw65d5+093SHoI1VeLfw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761936287; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mTnzr/2dB/AFYQkUWIsbkhJfuI5/Ww9h9zII2/Fqn/Y=; 
	b=Xpvp3F1Lvt/lXF9uDDcY4NjbYqmdeVLGlTYRWqndLlYFnHSXsBAIx58F+VzltGf7ya65FsNs+apX8gXsgKJsffdZHV0rJKLsmOy4cxyb06gACpTmhNb+cNfPGV/VojkV8/jbKnQJ+mxx67frZATZLUd/3AFtD8ENkQprOF4CvnE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761936287;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mTnzr/2dB/AFYQkUWIsbkhJfuI5/Ww9h9zII2/Fqn/Y=;
	b=RwnENpa0T5Ei+8eWMiziZNZTa8LoJ8Oe7ZveFn0PBT/KnHzc15lFEENO346hxnXE
	1uZ/JeT+uFbaqA+5g7IJ3Di/Ej17tppo/k+yQa2awo124y8V9R9xBEzQVIWwJJA/Q6S
	mtSH9GxW++AYgiea9sraN7y8U/09miFoO3Qz4gEE=
Received: by mx.zohomail.com with SMTPS id 1761936285296268.1153145813903;
	Fri, 31 Oct 2025 11:44:45 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Ike Panhc <ikepanhc@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Rong Zhang <i@rong.moe>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH] platform/x86: ideapad-laptop: Use str_on_off() helper
Date: Sat,  1 Nov 2025 02:44:34 +0800
Message-ID: <20251031184435.44819-1-i@rong.moe>
X-Mailer: git-send-email 2.51.0
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

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202510311551.xjWbHTrm-lkp@intel.com/
Suggested-by: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/2bae2ea7-2ef9-0cfa-0c2c-39a7043b2aa5@linux.intel.com/
Signed-off-by: Rong Zhang <i@rong.moe>
---
This patch is based on 'review-ilpo-next' of pdx86/platform-drivers-x86,
hence depends on my previous patch ("platform/x86: ideapad-laptop:
Protect GBMD/SBMC calls with mutex").
---
 drivers/platform/x86/lenovo/ideapad-laptop.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
index d2bfaa532020..931a72a2a487 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.c
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
@@ -475,25 +475,25 @@ static int debugfs_status_show(struct seq_file *s, void *data)
 		if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL, &value))
 			seq_printf(s, "Backlight now:  %lu\n", value);
 		if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_POWER, &value))
-			seq_printf(s, "BL power value: %s (%lu)\n", value ? "on" : "off", value);
+			seq_printf(s, "BL power value: %s (%lu)\n", str_on_off(value), value);
 
 		seq_puts(s, "=====================\n");
 
 		if (!read_ec_data(priv->adev->handle, VPCCMD_R_RF, &value))
-			seq_printf(s, "Radio status: %s (%lu)\n", value ? "on" : "off", value);
+			seq_printf(s, "Radio status: %s (%lu)\n", str_on_off(value), value);
 		if (!read_ec_data(priv->adev->handle, VPCCMD_R_WIFI, &value))
-			seq_printf(s, "Wifi status:  %s (%lu)\n", value ? "on" : "off", value);
+			seq_printf(s, "Wifi status:  %s (%lu)\n", str_on_off(value), value);
 		if (!read_ec_data(priv->adev->handle, VPCCMD_R_BT, &value))
-			seq_printf(s, "BT status:    %s (%lu)\n", value ? "on" : "off", value);
+			seq_printf(s, "BT status:    %s (%lu)\n", str_on_off(value), value);
 		if (!read_ec_data(priv->adev->handle, VPCCMD_R_3G, &value))
-			seq_printf(s, "3G status:    %s (%lu)\n", value ? "on" : "off", value);
+			seq_printf(s, "3G status:    %s (%lu)\n", str_on_off(value), value);
 
 		seq_puts(s, "=====================\n");
 
 		if (!read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value))
-			seq_printf(s, "Touchpad status: %s (%lu)\n", value ? "on" : "off", value);
+			seq_printf(s, "Touchpad status: %s (%lu)\n", str_on_off(value), value);
 		if (!read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &value))
-			seq_printf(s, "Camera status:   %s (%lu)\n", value ? "on" : "off", value);
+			seq_printf(s, "Camera status:   %s (%lu)\n", str_on_off(value), value);
 	}
 
 	seq_puts(s, "=====================\n");

base-commit: ba06b928f05bfd2785260819f6b34b658a04a4e6
-- 
2.51.0


