Return-Path: <linux-kernel+bounces-818268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B06B58F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B41C7A7EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3072E8B81;
	Tue, 16 Sep 2025 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Qg/yyuyP"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93999DDC3;
	Tue, 16 Sep 2025 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758007856; cv=none; b=Btbbikr2r1eMuozN4OsbATyGabaXxWvv8DF6X1DXS7F8BjmiBPN6Ugk2lTrA3oNdK4ZmGoEJS3fPkVERRT+79X2LiPv5b62jjRepjgrY3WRdGE9UYx+S/dESVC+uc2WX3gML243iTjElsIIK3Pb9EK6tO8Rt9o8Y1xXAQ0ggsQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758007856; c=relaxed/simple;
	bh=wPde9TMwBGkziAuGp2yA+MirGEH2dlnMkHkt0kJI6hI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZ8fuqM6lFSELczUOR0S7z7XMdIjjQVUgls3xxqP206fk/nnUSC5mJsC+9pIl43yvUWt/9UJgFtNmIxvjLFhwb/nSwq6YsM3ffcV02t6CytSN/F6FpjAJJwMRhHKo1YmhB0OPa/jVtF58Lrk/axAxBtqTtcfGlzRkx+l9xbycwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Qg/yyuyP; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id E760FBDC2C;
	Tue, 16 Sep 2025 10:30:52 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 01183BCF50;
	Tue, 16 Sep 2025 10:30:52 +0300 (EEST)
Received: from antheas-z13 (x5996a832.customers.hiper-net.dk [89.150.168.50])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 1702E1FE646;
	Tue, 16 Sep 2025 10:30:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1758007851;
	bh=d/UIKDx5Gt/ffx4MsbsrnzAol/o1JTVv1V+uDA3j8Rg=; h=From:To:Subject;
	b=Qg/yyuyPdG34/xdxwNSLjJ6oOrz+Guoajiw0jjwcoep4SYb+z1ewfb7EUaHUSROck
	 Nmg++RcvDYjF5W2LccsIDXlNhYU/WMkJLlgDfZeAq8KnNj0rpYdu9GPKMtC6d2YWvx
	 ekwQR0uP00Ttxjz3Jhpfz0lb7awqUKD4Rf9SbGq3uRl+eOrJZe1k2SrDLzWp6dQqzZ
	 +0gYYhPFfEKAb11p2X1ZK0NQIvyL0UUERGcbi7NIHpioQLtOoQ2zF/5IKZjgJQLOfZ
	 woRX4cccnZxoHanFPLnZPTND/bRYCqREwam1kIqZFoHHx1r+AACU1zia3R2WYi1sXg
	 YLDdeKJirHryw==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 89.150.168.50) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Rahul Chandra <rahul@chandra.net>,
	stable@kernel.org
Subject: [PATCH v1] platform/x86: asus-wmi: Re-add extra keys to
 ignore_key_wlan quirk
Date: Tue, 16 Sep 2025 09:28:18 +0200
Message-ID: <20250916072818.196462-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175800785164.3205569.9673175359798985343@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

It turns out that the dual screen models use 0x5E for attaching and
detaching the keyboard instead of 0x5F. So, re-add the codes by
reverting commit cf3940ac737d ("platform/x86: asus-wmi: Remove extra
keys from ignore_key_wlan quirk"). For our future reference, add a
comment next to 0x5E indicating that it is used for that purpose.

Fixes: cf3940ac737d ("platform/x86: asus-wmi: Remove extra keys from ignore_key_wlan quirk")
Reported-by: Rahul Chandra <rahul@chandra.net>
Closes: https://lore.kernel.org/all/10020-68c90c80-d-4ac6c580@106290038/
Cc: stable@kernel.org
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/asus-nb-wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 3a488cf9ca06..6a62bc5b02fd 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -673,6 +673,8 @@ static void asus_nb_wmi_key_filter(struct asus_wmi_driver *asus_wmi, int *code,
 		if (atkbd_reports_vol_keys)
 			*code = ASUS_WMI_KEY_IGNORE;
 		break;
+	case 0x5D: /* Wireless console Toggle */
+	case 0x5E: /* Wireless console Enable / Keyboard Attach, Detach */
 	case 0x5F: /* Wireless console Disable / Special Key */
 		if (quirks->key_wlan_event)
 			*code = quirks->key_wlan_event;

base-commit: 46a51f4f5edade43ba66b3c151f0e25ec8b69cb6
-- 
2.51.0



