Return-Path: <linux-kernel+bounces-881893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFD7C29292
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E86A4E7C0A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8932D94AA;
	Sun,  2 Nov 2025 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ycFW5x0k"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B6B267B90
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762101619; cv=none; b=f1rUKhwaYG5cssuTyjR/fNGTWUT042YIWIqYOS4Zl7FZUNTZ/SX+3PVhexBnjD6Mn/a1ZGtV8T+g57gSUHP39zOkHj14jyJcTijRK3f4ObFzdxgVE6/Rco/LNa8ExevchVLbFlglmEEqRa2EZlWr23AjIA1mq/wH31gK5QFj1oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762101619; c=relaxed/simple;
	bh=7e8bhWKRVDtf8aKVV0+AAUPqW42KeeIQqV6I3K53e8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNYpFIR+tYoOp2og3u8qi15NQ064IjswL+GrXkbXRVutQJd9l+VE9ors8BFhMBQHooIONh5LValUBCwdJN97ueORLVzVYvw/+V7icA8dPYyDkUPUt1l99EHHtvKjCPSOpP9wAtpLjykXnfGtVPqSaEWhTnr+062J2RKO9pL7FP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ycFW5x0k; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=FXGH735qWrvmiJLs+utyhLgjj/KKbRgYW73cH1TeOdo=; b=ycFW5x0kxKenOWLqCfrpUfESYF
	lHO2DkklYEuQAQVm5pAKh64JobtGS28gvuJuUVeIOO9hwXOq5vMvyw67gtaYJDIPGifv5Zq8XOydK
	yg0GHQE3GPGJNAHxquGQTtKdNWuKmiKTefvnu9g/hRQdbWbTrU8JcsNH8mJhGt2NtVpFglhsc0Ga/
	woljkOWgjJUFCd9QxYbamETZ1s+ViqHgVZyBjSG9hjv/froPDvUVmV5grTjI50bAKlF2ZQYrdoPoT
	m9lB/gEt6KMv6JRhyj6KqkiAruqFunzzHqpBBnyQNqU/P1MOKLL+GWeBX8ukJ43wVAfXcXQlfTkDL
	JMHnq9Ig==;
Received: from i53875ba9.versanet.de ([83.135.91.169] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vFb7f-0003Q7-VE; Sun, 02 Nov 2025 17:40:08 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org,
	srini@kernel.org
Cc: heiko@sntech.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mfd: qnap-mcu: Hook up the eeprom sub-device
Date: Sun,  2 Nov 2025 17:39:55 +0100
Message-ID: <20251102163955.294427-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251102163955.294427-1-heiko@sntech.de>
References: <20251102163955.294427-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the qnap-mcu-eeprom platform-driver as sub-device for the MCU.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mfd/qnap-mcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
index 4ec1f4cf902f..2be429a50611 100644
--- a/drivers/mfd/qnap-mcu.c
+++ b/drivers/mfd/qnap-mcu.c
@@ -264,6 +264,7 @@ static const struct qnap_mcu_variant qnap_ts433_mcu = {
 };
 
 static struct mfd_cell qnap_mcu_cells[] = {
+	{ .name = "qnap-mcu-eeprom", },
 	{ .name = "qnap-mcu-input", },
 	{ .name = "qnap-mcu-leds", },
 	{ .name = "qnap-mcu-hwmon", }
-- 
2.47.2


