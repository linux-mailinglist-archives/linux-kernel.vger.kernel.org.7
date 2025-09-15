Return-Path: <linux-kernel+bounces-815988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABADAB56DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463B13BC469
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B93A1F419A;
	Mon, 15 Sep 2025 01:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H52uPVwx"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED821E7C08
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757900166; cv=none; b=I9zIim4P3JRxkWzmUWg8ZtxODHI0YyF0j2G5tSfFWcUAJLKDAQJYc+ONT+3WItwE3LmE6jm3Ou72aoFTIP/inG68x1wZLBjxFEPU9fLxc9zhIvEK2gL3lBeLaMKWHvW9a7RMFdAGDEaDrCsjYtoAsc8oKnInCiGByuJbeQtkVwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757900166; c=relaxed/simple;
	bh=yb9WE9HIAyoUaW+mI/ekeAWzSZvV44iengjA1skUwN0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bAjnBU7k4/SdQSysS5rHDGL9xUM/zczdt875D7N9vl82wJxKqAbKo/bn3O/1rIFeTzl4Et5a3o3zT0BEZ0dCvxFORYl1HI+MibMOQrpynZzz+LFpW/L2tO1p1g3IYivFxvAxYMr18uJAL5UnBaIJHgHUBK1OuEsIE2S/JFrJIgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H52uPVwx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7742adc1f25so2440098b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757900163; x=1758504963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=I50PR1sb6c+Kf5/fqciK4isgrfq54NRzC8HjVn10y7I=;
        b=H52uPVwxGaoix0kNnTwzQd5vxIRxQyaHKAKeEgnbIMUy0LPFhOvaLMIjZqnWfbHRuy
         dGijkM33QX6eBCYApjNQcpuqShShqnBcMozcsCv1X2yB5dshOwRhW2WVFwfyTy9K31r6
         q7QyS52/JbWuB59Xx5+4Q7/YVAZRagIrp5GWPDZ2o5vgezUC6XSfIletBCNmR/js4Jj9
         xBvE02HrWfYuW2MUpTs1Bow/F54o+CwOVdxrNer/BRNGVZazStPwD7HT+I3jJ0W2jq5r
         C69o9dh3IjHsblyEd/L86ZxXDhDyM3+yrqKRscEcI5xgpbQW5ZKRSjZDOYJN5eTCgalk
         kntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757900163; x=1758504963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I50PR1sb6c+Kf5/fqciK4isgrfq54NRzC8HjVn10y7I=;
        b=GKU4mkpp0We2omenY/XQXUYJIazCvFA6vmMce+2lTF3TMirYKqRY1WntJGjYf3iT4m
         tl9ONuZERKTUcXZAemmw1A/7SHTKC3/37ztvPgGk/Wa7Jwt9mNxe4sdCQL8ImY5GH3zt
         L0W9pTKCvyqkR3Ca29AlVRD/cGMv8oAwan7e67I5Af0wbrIYRssiYRo38jmY9Sb76S+U
         9g9bZrX7L9DHErHpTZFBJPo6BvW8XFxJg/kQ5QX71u0YCnUXwXe5caTwL71Is0SlSpQc
         fc9SxyxbyXxOJydnm2YOoop0CksZQPvCULAmppfLchyiMEbCZasbWPoH+ZnK3W+R5cvy
         vp3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6pYMkRTd/JfhTXexaPs09sIOLehv1cXvgVuvzRffUayoQg/nmQPeVekJS3v2RlzC/z0UKtPcriu7Q1OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxswuN1dI5gZfN4LBPolcGVVN0gnai0vaR86QOq/jGzWNDlJaWh
	f586btKvsGisLtg6Ojd/AJk6h2+GhMPQnhT1BwTnJPwQO+I3CrxoAaZk2iXueZSq8qY=
X-Gm-Gg: ASbGnctzgNnC+/Dbe9J7n8rq18zPb5DFvxTp3HGmUzIONPkD8aJyrPg9PlJ7d2OCOL3
	D4fl6pzk6y+/cfIM+Ep2oPtshfZEuxjFLT9w+0uVJPltWC9kxuAS6n8SPRFy63TAqWTZFlZE9XN
	BdiiKG7eVjsMg81N873xkvyxVk0bcUPM/PDlmqu8PHQyVgKKll1zir1hoyb1kCt0ovdIsuOF2k+
	iLfpIfgFf9m/KP+xaZkXH5RMVFC38h0U7TvGjVeeOOhx4uhY2a9VNANtCo40DajgZouPA+5m5VI
	F4qjyqhPRIc0VFPMa9vHQAUWG3LZAAApCWgdGqaX/CIfuoe3AqMRuFUNvpT01+LgeCltsVOJ5Dv
	xl1omOg==
X-Google-Smtp-Source: AGHT+IGFMVb/wFefQlJrGcNvzhdhqfuAfoI4o9Hf9+Fsprsa+2vUekNuvrmiPLJD2F1qsCnnfwMSwg==
X-Received: by 2002:a05:6a20:2586:b0:243:b190:d132 with SMTP id adf61e73a8af0-2602c71ab5cmr12045312637.59.1757900162628;
        Sun, 14 Sep 2025 18:36:02 -0700 (PDT)
Received: from localhost ([2001:67c:1562:8007::aac:4468])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b169f2edsm7048640a12.19.2025.09.14.18.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 18:36:01 -0700 (PDT)
Sender: AceLan Kao <acelan@gmail.com>
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Wang, Crag" <Crag.Wang@dell.com>,
	"Chen, Alan" <Alan.Chen6@dell.com>,
	"Alex Shen@Dell" <Yijun.Shen@dell.com>
Subject: [PATCH v2] r8169: enable ASPM on Dell platforms
Date: Mon, 15 Sep 2025 09:35:55 +0800
Message-ID: <20250915013555.365230-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable PCIe ASPM for RTL8169 NICs on Dell platforms that have been
verified to work reliably with this power management feature. The
r8169 driver traditionally disables ASPM to prevent random link
failures and system hangs on problematic hardware.

Dell has validated these product families to work correctly with
RTL NIC ASPM and commits to addressing any ASPM-related issues
with RTL hardware in collaboration with Realtek.

This change enables ASPM for the following Dell product families:
- Alienware
- Dell Laptops/Pro Laptops/Pro Max Laptops
- Dell Desktops/Pro Desktops/Pro Max Desktops
- Dell Pro Rugged Laptops

v2. Add missing linux/dmi.h header file

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 9c601f271c02..1692c38cc739 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -15,6 +15,7 @@
 #include <linux/etherdevice.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
 #include <linux/if_vlan.h>
@@ -5366,6 +5367,32 @@ static void rtl_init_mac_address(struct rtl8169_private *tp)
 	rtl_rar_set(tp, mac_addr);
 }
 
+bool rtl_aspm_new_dell_platforms(void)
+{
+	const char *family = dmi_get_system_info(DMI_PRODUCT_FAMILY);
+	static const char * const dell_product_families[] = {
+		"Alienware",
+		"Dell Laptops",
+		"Dell Pro Laptops",
+		"Dell Pro Max Laptops",
+		"Dell Desktops",
+		"Dell Pro Desktops",
+		"Dell Pro Max Desktops",
+		"Dell Pro Rugged Laptops"
+	};
+	int i;
+
+	if (!family)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(dell_product_families); i++) {
+		if (str_has_prefix(family, dell_product_families[i]))
+			return true;
+	}
+
+	return false;
+}
+
 /* register is set if system vendor successfully tested ASPM 1.2 */
 static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 {
@@ -5373,6 +5400,9 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	    r8168_mac_ocp_read(tp, 0xc0b2) & 0xf)
 		return true;
 
+	if (rtl_aspm_new_dell_platforms())
+		return true;
+
 	return false;
 }
 
-- 
2.43.0


