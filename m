Return-Path: <linux-kernel+bounces-738419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8002BB0B816
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 21:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05ED1785FE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FAB22127A;
	Sun, 20 Jul 2025 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Y/WJKk4I";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="J0VCTLTo"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B860D374EA
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753041414; cv=none; b=rqiEMkDfazEQcDCjwLUH1D1huIWS/P3O3RkwTffbxcysn2jxvtekf4CWWrn0RzsPGQiodMUJ/zhovPVuYQkJKOvYPV0KWNYaEO+6OTxBd4pKWv3U4Su02LZxxIlYXJ8EXgkREbjiKBw24Kjxg0jM/iOJi4sDssFS0y0RPwEyVJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753041414; c=relaxed/simple;
	bh=0hAxktsI6HKh/I8PikjvqrfFM3YzFfIfAe3N2vxrl5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCJ77dGtKbrpXY7piLhN66O3+wYgms4kctwVI+FWdc+ZOv1enw6AXPvFbE2/b4JTvH4OynhJgQ68S9jo4Tw1RiZ7PMlt0xOR18RhjLmePrePqk6KXlf69ZHz8UYfYlo2RvamExI+GGPJg12XaDvvOUHmSyBO15GfvtAuaHOLSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Y/WJKk4I; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=J0VCTLTo; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4blZ6h4g9Cz9tK6;
	Sun, 20 Jul 2025 21:56:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1753041404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uGyE9d/XNI2XDNofnNseSp7f9u/AgFNDjaO+1oT6Aps=;
	b=Y/WJKk4IELJeIUbeBZ2ccObyM9qNZFDWzHxgHNAUxmXjh2SBQD8HZEsQp5wcBW4XDqCbYO
	DsqjGYAS37pJ7MViClgMzG/SWyZelGfZazmkVqKrD8M06vjC/C2NPfjnHxydIoCTh0prme
	fhdbDBMQa4Dt5oWNEP03udW29iBVISYmKiFp5sw54JWeG1kQ82cCVBrjC18jjtoBXJWS0D
	xLvucGRhVo93BiKIYiEDilCf6sovBTcCTP15G0zh7T1tjH0JwCLLIC4gdZNeyJztIW1U5+
	UaXxVOqPYbKTTNlCH043Vk6R1ys+lwQqODnV9rrlNxple0WSv8t8l5JF7KuHJQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=J0VCTLTo;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1753041402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uGyE9d/XNI2XDNofnNseSp7f9u/AgFNDjaO+1oT6Aps=;
	b=J0VCTLToANOQ/5IWnFbV9PaJPySPMy5ANbH0GDIJtL993IPv9FxZkoMsOmXRlg32D0YrL5
	OHjaHLWRA05Xc4Yfwf2AyzM5MRlhC9+U8VTA8Biro0ZXh4E30+dQA7IEx4tickTzjRP5Rc
	kTMdAduwG2Z/gcEx1wzxTvD2P6ODGK0392uAN35WX3d6STkAkdDbjAFsPzxBjmm/UkQ3xN
	lvty5FFRMOH4MBpkFzQ0bAQFaRGi3sM2PXrVHwejuzhABh0DjbDh8Jzf/Axfkv+kZEwLIm
	JT7sGar8NzJJ4cwRRaujeIhSbdy2bGC0bLy6t6Fp625JqGzxOmHESLH8JNR7EQ==
To: linux-mtd@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: winbond: Add support for W77Q51NW
Date: Sun, 20 Jul 2025 21:55:52 +0200
Message-ID: <20250720195625.413715-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ue7ubufmhhkpb9wob9yomuc6gty1oxhf
X-MBO-RS-ID: 8f9629195e8d8e87a2c
X-Rspamd-Queue-Id: 4blZ6h4g9Cz9tK6

Add IDs for Winbond W77Q51NW, 512M-bit Secure Serial Flash Memory
with Post-Quantum Cryptography, Dual/Quad SPI, QPI and DTR . The
flash part is similar to W25Q512NWM .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Michael Walle <mwalle@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
---
 drivers/mtd/spi-nor/winbond.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 63a93c9eb917..dcb6c9ec862a 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -343,6 +343,10 @@ static const struct flash_info winbond_nor_parts[] = {
 		.id = SNOR_ID(0xef, 0x80, 0x20),
 		.name = "w25q512nwm",
 		.otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
+	}, {
+		.id = SNOR_ID(0xef, 0x8a, 0x1a),
+		.name = "w77q51nw",
+		.otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
 	},
 };
 
-- 
2.47.2


