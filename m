Return-Path: <linux-kernel+bounces-800865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE865B43D1A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F7A1C846BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D7F3054EB;
	Thu,  4 Sep 2025 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="M4Dh/9Ss"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C961B303C8F;
	Thu,  4 Sep 2025 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992312; cv=none; b=CVppR8fEYL7h+ev/W7OygwrchVDWtny/pGmavzYldVdZyqph/6Hu/e2sObdlh9UGokOTWHyXfkJCSgCABy8D+9nAF9dUPvczoHT8A6NQ9hg2Pb4IqPZJ4aD+r3cFo+f0SttX3UaUki4zJeRGBUbbj2FdfBpxtihhm7b2S45+gTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992312; c=relaxed/simple;
	bh=bQUAriiAuroBfSipJWUaV90q4Lm0SHqTWn2SZmuqEPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsurhw0Hmc/t7kLmwZLyzoZMp5vDlYuiPXQghLViWBS7o6c3W5rpB9m06Jh8+5f7hsh93UDZIg5PgiQSB0pCnFmYsaeLIHzVWQsbS5W7BHo20SS8LYJA/B4fOOKenshh25DBBbxs1CWAw/85quoo0fBxacrFfwOuQcJ9kRGDjy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=M4Dh/9Ss; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 4971EC6B06;
	Thu,  4 Sep 2025 16:24:59 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id DD250C69D9;
	Thu,  4 Sep 2025 16:24:58 +0300 (EEST)
Received: from antheas-z13 (x5996a855.customers.hiper-net.dk [89.150.168.85])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id EFD3F1FE9CA;
	Thu,  4 Sep 2025 16:24:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756992298;
	bh=oGbCRbQsWN+PQEVyqIMQqWOAxDT3DCy81vGw9DcQKxE=; h=From:To:Subject;
	b=M4Dh/9Ssnu1zkJY5ARMMrZIHRnJVBvKPMEpXBTYad9I4rscM6eDWh3IzXAWQ005Qa
	 O9NN34Okowsz/0Ts2gABFWMac2OORQ5meTWQ30GSylutt4lR/N9xDkO3WWcvIP/8rA
	 n9G8Smz5b26RC1ZtwmMeAc+w9ktJB7mwvETmz5d/WxyREaI8quPov6tjUYN8cYNZCL
	 UFW+qI+C4nvyog0oSc0vqmcppIQpB9MU/3uGvX+JcamjIaUgwCW7lOW+TvwW52eTHw
	 BNxE90ddZoPnMZctBIhr3GAjC94BXYB+VtutyhW3Mv9LePey31AzLVS49dAJs2FOxZ
	 6O0peOB64BTNg==
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
Subject: [PATCH v1 2/2] platform/x86: oxpec: Add support for AOKZOE A1X
Date: Thu,  4 Sep 2025 15:22:52 +0200
Message-ID: <20250904132252.3041613-2-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904132252.3041613-1-lkml@antheas.dev>
References: <20250904132252.3041613-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175699229858.1084194.12051309279760000304@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Very similar to OneXFly devices. Uses the same registers.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index 4f540a9932fe..54377b282ff8 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -124,6 +124,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)aok_zoe_a1,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AOKZOE"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AOKZOE A1X"),
+		},
+		.driver_data = (void *)oxp_fly,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-- 
2.51.0



