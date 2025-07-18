Return-Path: <linux-kernel+bounces-737162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E804DB0A8A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 184DF7B830C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE7C2E6D28;
	Fri, 18 Jul 2025 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="k2xjDQaR"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020E2E6D0A;
	Fri, 18 Jul 2025 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856765; cv=none; b=eskaiofJi0+lxvY6K31ZHokzanHunZnGhfcgp4enbiN+gf0Lo0EyEbQthWj4ZdmV2yn9S6dpaM80dxexJwV9sSHyUCtmvuXEJw7G4NZnlq+iaZzqxqvGzD+qSirPAYIc0MBORvRiCXj1lxIfs1a1GP2mVkFPHuRpVBTWTCMWyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856765; c=relaxed/simple;
	bh=+UBQRYw3W/UWgB2uiLYbjsD6CgO4qG9xOCRwwLiNDD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiAb99B1obT0d1TLG/ls211iAgIGBB1sGndWzcqUby/u62BjxMMnuvj82dn4Hq4jdYutrCvJlxk20ZZM0omqq9jbRU1qWpJODFA8kUKMStvE3bs62D1dbWvK1CmTdkM6HPOABzjh+W6y0dWFtqx2Zzq/pFC5HfJU/urccpGGZ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=k2xjDQaR; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 98ACC46F5D;
	Fri, 18 Jul 2025 19:33:13 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id DBE0D461DF;
	Fri, 18 Jul 2025 19:33:12 +0300 (EEST)
Received: from antheas-z13 (x5996a89a.customers.hiper-net.dk [89.150.168.154])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 05C081FDA75;
	Fri, 18 Jul 2025 19:33:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1752856392;
	bh=rnsrsU9mk7kUkH23FzGwLOYEs3ZCpDGe5WOtpS909xY=; h=From:To:Subject;
	b=k2xjDQaRbXPIX1OI9QGOtQ7HpR/Qqv4eXCBPwmktWu1AnUnzA7H1E9+ais3wDNijs
	 Pb4/nhTHhavix2P/lTTV4GEalJ4d8hGJTnL0Q0ycN9e6KVGv9fY2FKV09jrv95+Mvx
	 LXRU/gTuyommKzcD20HXnSRmK/KjpN8wD6sA6UZhIZbdzFQ6jWzZJ4DN/Q2ojT1sN2
	 geD1TCcMdu0qRVlC9TNUNmRMZRc3tkoES4dSaFQGfsFew2lHIEV3c1h3fZdNytHDnW
	 zmqUH9Vp4aaHfYNZC7qWzr+tVZCV8xep6m3ProfpRA1MEW1frT1S78z37dA/SbIK7z
	 8FE/zmzaj0SyQ==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 89.150.168.154) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= <samsagax@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Eileen <eileen@one-netbook.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1 2/2] platform/x86: oxpec: Add support for OneXPlayer X1
 Mini Pro (Strix Point)
Date: Fri, 18 Jul 2025 18:33:05 +0200
Message-ID: <20250718163305.159232-2-lkml@antheas.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250718163305.159232-1-lkml@antheas.dev>
References: <20250718163305.159232-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175285639246.3276370.3961436218321101426@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.0.9 at linux3247.grserver.gr
X-Virus-Status: Clean

The OneXPlayer X1 Mini Pro (which is the Strix Point variant of the Mini)
uses the same registers as the X1 Mini, so re-use the quirk.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index 9839e8cb82ce..eb076bb4099b 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -292,6 +292,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)oxp_x1,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1Mini Pro"),
+		},
+		.driver_data = (void *)oxp_x1,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
-- 
2.50.1



