Return-Path: <linux-kernel+bounces-788376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD78CB38386
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02BF3ABB0A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35287212D83;
	Wed, 27 Aug 2025 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="eqxS/kK2"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAE0350D44;
	Wed, 27 Aug 2025 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300479; cv=none; b=PKA/rUwPUwOLtTs+AJRDiq3YU2uIzztHmZZ4AFB36KXtyEdP+8SLDL4O62Dp5k7KJ6U0VfSkXTgzvbo8MlvHyHwtgOfzO82gG43iJrEzl23hV5af46tDkqqiEAqDOvw3USe2L3viHKX4n57+ha9PBaXOjE4Hhbbdt0seqJWGZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300479; c=relaxed/simple;
	bh=XsTRRz4BTX2KhPuoFFU7MrW0RBviwDXWMSW/gPPwM7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B9Kz7uD1njVKtpHvsZr7WiY6no0mPJVm4+xhTB0BEFQ4rymTg4B6YJvfzSO3Q5RkMTWhV0SnrYRSvNQnWeDmdRBL0Bg2v+I58pomdLAzIBaPam8IIkynQptw+VAohFozh1fvYHSg0zXaKg2PyZGcVgThZc9VKlICoSLViiaOqIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=eqxS/kK2; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (p5de4594b.dip0.t-ipconnect.de [93.228.89.75])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 5F3122FC0052;
	Wed, 27 Aug 2025 15:14:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1756300467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FqPgpq5SHXLx8DYXA2ddMhOwpyfjgYUmrPIjnikdu8w=;
	b=eqxS/kK27fbIX5Da6DjV2v1LcZceMTzP0vXO2tyUFn6pAH7DbnuupxseJm0m06UYV8oUK6
	RGlaEAyz+Nwe8kcpzFAUujUk3wUsx3HYq9122bSoUb6y+fURw36lxh5esahxWQfQ2LLRhP
	k/ehUGVOSoMaGoWs1Hj0ez94QUIUgeQ=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Christoffer Sandberg <cs@tuxedo.de>,
	Werner Sembach <wse@tuxedocomputers.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/amd/pmc: Add TUXEDO IB Pro Gen10 AMD to spurious 8042 quirks list
Date: Wed, 27 Aug 2025 15:13:51 +0200
Message-ID: <20250827131424.16436-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoffer Sandberg <cs@tuxedo.de>

Prevents instant wakeup ~1s after suspend.

It seems to be kernel/system dependent if the IRQ actually manages to wake
the system every time or if it gets ignored (and everything works as
expected).

Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
---
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index 7ffc659b27944..18fb44139de25 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -248,6 +248,20 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Lafite Pro V 14M"),
 		}
 	},
+	{
+		.ident = "TUXEDO InfinityBook Pro 14/15 AMD Gen10",
+		.driver_data = &quirk_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "XxHP4NAx"),
+		}
+	},
+	{
+		.ident = "TUXEDO InfinityBook Pro 14/15 AMD Gen10",
+		.driver_data = &quirk_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "XxKK4NAx_XxSP4NAx"),
+		}
+	},
 	{}
 };
 
-- 
2.43.0


