Return-Path: <linux-kernel+bounces-813343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E132B543E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BBB31885D03
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9D92C2348;
	Fri, 12 Sep 2025 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/BjyCPo"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5932C21F0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662188; cv=none; b=g8P7m2EjEI+1T23VGyn6/OPlZQf74sOaVDiHOcYwKuQcSKBiYKM5QZWhZHfHK9Y0O5iqFbtZ+M9LmOfGW2/XWgzq80FVh9zgT01NRz6kvh3UopmOe/x9Z/Np165FTc28fmHUK22dyYeTKSzhWBFuPcmwuFRJxQxvJv0Jtpes+/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662188; c=relaxed/simple;
	bh=24gKbmpZi/9Rh7t7JIuJkgy+kYSzfVfk0Br6AQTuA4s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MmZV88qMuxIUDPkfQhc9ILCB5c3aXV8RPerMEIJdYvK5z9TVyL/99KOFZt4govAKieoeGe1lyDb/oWOTMddGRwUJuls8kqq0qlunbfwELfejemXrPiX14ZNgvMmF1SKlokpA5IV0SeF3igqwhkrHFOgH4GlyP5Ng3g+PvOEt7D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/BjyCPo; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-812bc4ff723so145023185a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757662185; x=1758266985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=I8szgG/sO6WMFzNe8UNeKbJn6avdSRrf05268GJd8/Q=;
        b=L/BjyCPoCUcpMSZOyz4ycOrRn+ZF4QrIfKxhRROvhbVvcWdqhzWf0U4rJx6rSwLjja
         1gc2PR1xMQjHFDvCt2nipuBKhEzRVfFbhUDwGTU2AO68pXuVrLJggWJV8PKtnc0Sd/Wq
         tAsUmcfqqMfYIZ5+b8GKhsigSPJDsM6p+SZQGWH/1F6iZ6uxC7XrsKcoCMl/l204XG17
         CI40JZOkL6AW+u0YuNm596J3bqSiaVJrySki7jEhp/k40SZo/8fycnI6sXVp0AXViaKz
         g0yTQX0tDpSMLF19JAuAZAfD7zFDlVLbcuDLn9n8+UsAFxEo+bf06MueVOquyk+azx0q
         NY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757662185; x=1758266985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8szgG/sO6WMFzNe8UNeKbJn6avdSRrf05268GJd8/Q=;
        b=Meu3+ueR7ZYhfljAYO8IFSb3k55uCNDKV0byubso6voUwZGTnimnrVrEKtvECtreK9
         +QhJxf9uBNWozdPJNSRHI4BpeVigEnglKdt6MwNokB2Uk0mC8Mn2qS5g02g40Kpab6Zi
         HMlp0V+uqJQ7yA2t4k00i8zTf6nymy8fGf3btZhfQ3tzs0RrqVcwysu2JgYjkNgSAuti
         +H91UYm6BYZm1LMwNLlFgotKB1pBH+TfUwAY/nRcUTXz6dtjvStZcTkD/BDMdgs4tTu0
         JcxvT/LC2TqRKYXK2jdFwZzq8DwT98O0Ls1mlSrLVAfbmjIHH4gwZRyZFKR3H8s8fRO0
         mVnA==
X-Forwarded-Encrypted: i=1; AJvYcCVhb10r553sFAQw9Lu9S/MtuSj6VbjZnDRFqp31ek+Hh2VeFhjqZMyLX1hcpIpy2JjGmoFrrDNZaDHdxjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4wLWfM6laq+I3M2dGlpHT0XOzcqR16YW59W0rcaUwY8tzjNqN
	R7lqDaTO7/TSkjS6OUZuXc9O3EDBWTYV7agroCHjwdjGMq096wZGXW+5
X-Gm-Gg: ASbGncsTcZVPemVTIf/1VBtRP/53Bq3ImHSYUz8RxgeuLWaLQxYL91Cu7o0A97oVzMN
	1WNMnW26IrReP9LLKJgxWVuK1pOCxSC4IYBbB5n8ohBGJYc8DnS/Lm4Qfn64x2ChD23SGRalhfy
	kMeUOYh3tGHgTbNujbkFBXZ3m3PCW3yoV8WemMM0JX+PIXr7C2hOXKP309nnzbwx7YMupve2zgh
	HwM6Gx2T67n9/jkfp/Yf7o2X/tB0GH/y8lrQ0th+ss6NDtlofXG0+QYCKzA0q3KYlcrMZXWhnkg
	Ta78TOdVdM3pYCB+QFHwhxTW8g0mZhDsdT1eq+SiQSytoLDAb5NxbJWI42r9ZkGDnIbhIar6xw7
	GEEo7xVSjoULY1j0rTjr6KgnEfbPJJpEbJZcauyoUc8j835jUErfec+9QMotlb3s=
X-Google-Smtp-Source: AGHT+IFYnmneqniwknQ76UBKqo2PVhyjtQdkT2E4yuv0BYQEOJJbrJdzPVSzVNSCK5I9g6ZPYhPGuw==
X-Received: by 2002:a05:620a:4689:b0:811:f4e7:c7f6 with SMTP id af79cd13be357-823ff6d68bdmr250731885a.48.1757662185273;
        Fri, 12 Sep 2025 00:29:45 -0700 (PDT)
Received: from localhost (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cd704508sm226655285a.45.2025.09.12.00.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 00:29:43 -0700 (PDT)
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
Subject: [PATCH] r8169: enable ASPM on Dell platforms
Date: Fri, 12 Sep 2025 15:29:39 +0800
Message-ID: <20250912072939.2553835-1-acelan.kao@canonical.com>
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

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 9c601f271c02..63e83cf071de 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5366,6 +5366,32 @@ static void rtl_init_mac_address(struct rtl8169_private *tp)
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
@@ -5373,6 +5399,9 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	    r8168_mac_ocp_read(tp, 0xc0b2) & 0xf)
 		return true;
 
+	if (rtl_aspm_new_dell_platforms())
+		return true;
+
 	return false;
 }
 
-- 
2.43.0


