Return-Path: <linux-kernel+bounces-899906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 632B9C590D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E092541614
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B95A2EB5B8;
	Thu, 13 Nov 2025 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="0EPAovV5"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A1435292C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052747; cv=none; b=BPzCABsaxaqYXyjFO+u0TkDo/hN7cw3TVmhG1f2JY6PqylrReXW/ONvVaqO5OpAVmcRZnWysdWBiUBzY4x9p9IosGeCL3Auk8WGIGEse+WcwCgAdo2Y9zc/TY/5B8/4aGLAZx5JDFRGhT8Nu4uGixuq5QumcMxoi1KOLbOjXHYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052747; c=relaxed/simple;
	bh=N+Ft/PmrtbS1c2vl4AHC6AfYZVStrjBDS5Fxlyfgs08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERAANwCrWf/bOjSTllVngy2vm/iehr6wDCwFxEtqkhECVXWmYzvyDLRtJPli3Lgl+pfV10CHBbQ/B2QrMtZsU+gsqjYH3yugGF+i/vme6LK2+OaL0Umj+oNOY0P7tYFDPiFPbFmM3FWYovuZFLJ9JSfSiMwbbWoHNBtz4MhxJuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=0EPAovV5; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=nQYxBu/Q09Up2UjAV3Yg5ScyfmPTkQa5TKMKUGdESZo=; b=0EPAovV5uJ9I4Gl+FdrSz9CFI7
	ITev1dVXBwEZ3DRtZbNNMtUWd739+xgBuR0I65e2Skwt3oDO7ATFvwwdF/F1YBPikF0EmLakX006w
	9PIBqsajNCHbmA4zzRKWiFErRZNspjdJygT1hJtU4vW47lOCoCC9EIO30cCxjwyF+kWCvrTaMItuZ
	gPuGRhA2Qpo88ZYBJVEgOTHTaX4+MesRceuOlyeVWfRHR+DDX+hlZ07HVTO2hqGQWJgnlkvAUyDey
	0pDtnu61JbPRg/doGVKZZG3PzyDT4YJ3gDcxoRRJDx2YIMG480sXHjNSmqfVDwrPZANxsy2Lnt1Ce
	CYQtIx2g==;
Received: from i53875a11.versanet.de ([83.135.90.17] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vJaYa-0003BD-0M; Thu, 13 Nov 2025 17:52:24 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH v3 2/4] mfd: qnap-mcu: Use EPROTO in stead of EIO on checksum errors
Date: Thu, 13 Nov 2025 17:52:16 +0100
Message-ID: <20251113165218.449616-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251113165218.449616-1-heiko@sntech.de>
References: <20251113165218.449616-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EPROTO stands for protocol error and a lot of driver already use it
to designate errors in the sent or received data from a peripheral.

So use it in the qnap-mcu as well for checksum errors.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mfd/qnap-mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
index e3210541ec56..b4b630f7d413 100644
--- a/drivers/mfd/qnap-mcu.c
+++ b/drivers/mfd/qnap-mcu.c
@@ -178,7 +178,7 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 	crc = qnap_mcu_csum(rx, reply->received - QNAP_MCU_CHECKSUM_SIZE);
 	if (crc != rx[reply->received - QNAP_MCU_CHECKSUM_SIZE]) {
 		dev_err(&mcu->serdev->dev, "Invalid Checksum received\n");
-		return -EIO;
+		return -EPROTO;
 	}
 
 	memcpy(reply_data, rx, reply_data_size);
-- 
2.47.2


