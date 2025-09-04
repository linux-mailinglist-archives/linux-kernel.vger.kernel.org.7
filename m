Return-Path: <linux-kernel+bounces-800864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9294DB43D18
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2891B20BA5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C2C3054CA;
	Thu,  4 Sep 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="fp/TD7uT"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D94F303C88;
	Thu,  4 Sep 2025 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992311; cv=none; b=jIlbIhMTZotxWx/4TiXzb9eUlKmhH/V+dAQoTnlIhh4tWS7bljEJdc+QED0IWMzl5SJ+1hw+wmtlhMVEUiAPj+4lm1EBRTjooGlctOLttHX0eNsDZiT9j+LJKMDQatqNbNgRo3macBzP25HcutpTQSP1fN1/gnnMj28fr7YN7vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992311; c=relaxed/simple;
	bh=dzkOqL0d7DqdttfLATDnPkUVlorjA/hkgp48xHrdMjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NDR4WJvpy9zPgOkRdHGMjgkh1O1agj8KNju0ZFaDuLOiLlrc1z4b8g0205gPXFpca3jsEVT7ipoK+TrWvfUALLH4Yd83O+D79oVkM66MPUue18m4k5+jHH3mM4vCxyt5iVb25sVjHP3DjO9522iMHFalfNMei4/sz0fDEGDMS8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=fp/TD7uT; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 8A92BC6B21;
	Thu,  4 Sep 2025 16:24:58 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 072F1C69D9;
	Thu,  4 Sep 2025 16:24:58 +0300 (EEST)
Received: from antheas-z13 (x5996a855.customers.hiper-net.dk [89.150.168.85])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 2D6151FDD78;
	Thu,  4 Sep 2025 16:24:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756992297;
	bh=ofXj7gJpQSZEvH8V23T0dXr77n0A7e24hfWXys9MiZw=; h=From:To:Subject;
	b=fp/TD7uTGwck0WHk0jI+iGgNOuR+QWhXRbgD7H/f+qBTvgRh31QnjiXUNhSKUcu84
	 u8aX7QQ8fATBFkq+yCGBSFMXql8yoEkx/Vk9p2L5Zlq3iHnxf/WV+fev+9uHT/+B+N
	 cDDpZ8VL5AgWCUdPPr61LKf4gRLEs2fPSO0XqRndSziKO9+ZmcoWx9U6Xh5UIZuntD
	 YFKtQQPevvFTN7FgqhiHtQaPbXD0jO5wuYJ1Icb+521z/KovBtC6LbHSEwUD8Vayhz
	 by4Wmi5L8FNqD6HZXI3PDIo1Mqrr/o5h8CUpyMZxpexjcShPPzpFK32tt90gUMOHne
	 PL/kDabynNscA==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 89.150.168.85) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
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
Subject: [PATCH v1 1/2] platform/x86: oxpec: Add support for OneXPlayer X1Pro
 EVA-02
Date: Thu,  4 Sep 2025 15:22:51 +0200
Message-ID: <20250904132252.3041613-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175699229769.1084173.8558747650228626215@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

It is a special edition of X1Pro with Intel and a different color.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index eb076bb4099b..4f540a9932fe 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -306,6 +306,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)oxp_x1,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1Pro EVA-02"),
+		},
+		.driver_data = (void *)oxp_x1,
+	},
 	{},
 };
 

base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
-- 
2.51.0



