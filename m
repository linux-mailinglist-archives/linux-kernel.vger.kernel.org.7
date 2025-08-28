Return-Path: <linux-kernel+bounces-790271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5262B3A3EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE821C26F64
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BAC21C9EA;
	Thu, 28 Aug 2025 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="S2yGD3gy"
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADC921FF2E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394230; cv=none; b=qqd2HANlmIwEjICtv3soxbVav3PJsJ+4Adb90OkWq5kNeGbaEyvMDZQvRF4ZnvIgBLk/LwmcGCyaQJrYhgiTcG7aDQiodVP3BFSgFo9ryBUev96oy3Mf03fQ5iWy4oWtz3osL2h793ZlwhI4IbJpV2l2sFdBRwq8b239InpQXMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394230; c=relaxed/simple;
	bh=t4JHR48faVpHkkLYUynzmkUuKEEh+Rr6PtyzYR2k5AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eH8PC7Dv8tBOsRl6uyCPooVkjCH/VMPKSTENaw2gokyWUOh1z8ggD4BjOAtSeNtZNEDW/pL47JpUXffTCNkJhRvx06e6sq5rn0jkAUtbPXfm2QQGdUsn49CkJdfqlyGv5nzg0DkUM4F/+8ypCP83fPPisrTGw/5AxeWhOTdOjOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=S2yGD3gy; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202508281517020ca054014e00020753
        for <linux-kernel@vger.kernel.org>;
        Thu, 28 Aug 2025 17:17:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=/Sc8VtAekG74Yre+F0dRoNX7U3zMOwGrv7yc4rDKHUc=;
 b=S2yGD3gyKTN/XesNRXy0iG8Gp4wyFrxLI6HY2FXrNpKnErdaGJP/nte+MqDMs4QEYZVPPL
 NhGb8wmkjykvmt0E7AspuuUkDO8RJI8nGXSPYlDW8rZcb2PijTZRctSVRZnz2PWpIkljW40f
 HNFNfOSKQ/EST0Nt950DJ23XNj7tfHjonuMj0rfPbnCFCORLSF8duK0DkXpi3lYd0uOPQzYO
 YBJvqKzxYTEtVHAqhoyCcOO3YoSPD5haB+Twcy2kG0ak5NuufLspvQ5va4pXgBil0N1GEOGN
 KgrHOQATUIirK+RjX8M4BevZQvGFouSkzJI8QRNoAN1S9paLTdHZjSUQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patrick.wicki@siemens.com,
	stable@vger.kernel.org
Subject: [PATCH] eeprom: at25: fram: Fix chip range in comment
Date: Thu, 28 Aug 2025 17:16:42 +0200
Message-ID: <20250828151648.348612-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

The first chip supported by the commented code is CY15B102QN, fix the
copy-paste error.

Cc: stable@vger.kernel.org
Fixes: cf4d2ce1eded ("eeprom: at25: fram: Detect and support inside-out chip variants")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/misc/eeprom/at25.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 2d0492867054f..8d4938e5f213b 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -404,7 +404,7 @@ static int at25_fram_to_chip(struct device *dev, struct spi_eeprom *chip)
 		chip->byte_len = BIT(id[7] - 0x21 + 4) * 1024;
 		break;
 	case 0x2a ... 0x30:
-		/* CY15B116QN ... CY15B116QN */
+		/* CY15B102QN ... CY15B116QN */
 		chip->byte_len = BIT(((id[7] >> 1) & 0xf) + 13);
 		break;
 	default:
-- 
2.51.0


