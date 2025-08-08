Return-Path: <linux-kernel+bounces-760516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E30B1EC51
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D648565AEE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F281C5F39;
	Fri,  8 Aug 2025 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="HFWj363V"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1415E19EED3;
	Fri,  8 Aug 2025 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668103; cv=none; b=Cmt8u+4xLO65wtjrSJANhaB5GDuIwsEmlEfymp/QLOf3fo6waJDj6xWVo6CDHslWxndHiT9VfIWdk1nrwy+qzO8X/H/KLoJ7/7mjeCvK65TBYrvaNS4U75I6Y3B3ZLYfIDkPwE6XYkwiDKU8qailUN8njCnAOfIe9i/rSkED+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668103; c=relaxed/simple;
	bh=pLtvvApMWHVOZTFQ1cFKSziWrBGeo7Y4bH/R739LrkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rOGR6XpIF1fG5SE1HmIBHPq/Ys7GbOxNlMU8Liqz8oHgjes0Alk8WjkHjrLwprs6nhHV0LptRqJ+nDKTf+2/9JbM4ki6Kn6XX6AAFonSqkUFCBHBOVn5INjod/YbaOJQDbJqN97s60iIfK64fhIBGPogUnKZfyJwqOkRUy1BU8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=HFWj363V; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 81EB0485BA;
	Fri,  8 Aug 2025 18:48:12 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 94339485AD;
	Fri,  8 Aug 2025 18:48:11 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a02:2149:8b54:2b00:4bbe:4554:f657:4bd5])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 1ABC21FE633;
	Fri,  8 Aug 2025 18:48:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1754668091;
	bh=99eUG3CNzM0arOp7xBNc07BSZWLEZtBJze71+aCBs6w=; h=From:To:Subject;
	b=HFWj363V9LOXKvR4Us2RWZn2EPjhev8Nv8nv2b6T8Ep0hIl5KcStp+OFYTf2jYKpX
	 wtf/Kl+V2ECAE1/jRuyoiUMAJsO7qplvASgmBbvi1lw4XkYis7HHn6GMeaB792xu4h
	 Os0MzQp55Bl1TmwGXJk+lJ8ClCi0aSFZ4joG0D3AoufEOJZBcKpX318exBNDQbhdM2
	 mkhu9K7W2jf3VTqupQbd5/EUya1UKQUB/PIbcqvwckQqEOtyVsGd6gDOHWeHqMZdXD
	 0M+cQrXVQAkaXrFfpmAUKcCQbh42b1jfjGQwvNxn1pQ5t76NQy1G7Zc0ub6SpS9h6T
	 zMOaqP2FKwtVA==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a02:2149:8b54:2b00:4bbe:4554:f657:4bd5) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Mathieu Fenniak <mathieu@fenniak.net>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v2 1/2] platform/x86: asus-wmi: Remove extra keys from
 ignore_key_wlan quirk
Date: Fri,  8 Aug 2025 17:47:09 +0200
Message-ID: <20250808154710.8981-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175466809098.1696090.7962098088888285849@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.0.9 at linux3247.grserver.gr
X-Virus-Status: Clean

Currently, the ignore_key_wlan quirk applies to keycodes 0x5D, 0x5E, and
0x5F. However, the relevant code for the Asus Zenbook Duo is only 0x5F.
Since this code is emitted by other Asus devices, such as from the Z13
for its ROG button, remove the extra codes before expanding the quirk.

For the Duo devices, which are the only ones that use this quirk, there
should be no effect.

Fixes: 9286dfd5735b ("platform/x86: asus-wmi: Fix spurious rfkill on UX8406MA")
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/asus-nb-wmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index f84c3d03c1de..e6726be5890e 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -655,8 +655,6 @@ static void asus_nb_wmi_key_filter(struct asus_wmi_driver *asus_wmi, int *code,
 		if (atkbd_reports_vol_keys)
 			*code = ASUS_WMI_KEY_IGNORE;
 		break;
-	case 0x5D: /* Wireless console Toggle */
-	case 0x5E: /* Wireless console Enable */
 	case 0x5F: /* Wireless console Disable */
 		if (quirks->ignore_key_wlan)
 			*code = ASUS_WMI_KEY_IGNORE;

base-commit: 186f3edfdd41f2ae87fc40a9ccba52a3bf930994
-- 
2.50.1



