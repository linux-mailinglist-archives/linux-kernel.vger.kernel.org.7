Return-Path: <linux-kernel+bounces-746434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC39EB126A3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B854E0D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7F626FD97;
	Fri, 25 Jul 2025 22:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZXsQ6pAp"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4110826D4D0;
	Fri, 25 Jul 2025 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481312; cv=none; b=ltIISZiMmJHiFNlVbvAbawBmdRNU2/ZgOrzc34gzLq5Nxb83i4L1deLSVOL8fhxjQb0U7pgKO+T50tj46mKhpmuL9lZ1SOvLF/Q98ytC8k+Mz4g7JP+gOIDWbFaTu8vSleT2iyF8M5VbiK2qwm+YCgc0nEvX2MELoBbroHL1ujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481312; c=relaxed/simple;
	bh=NnjK2MqU5nffK8egqTxIMASgUTDHt8S5nHUSvK3y1Kk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YdKoEH5/mOHXIR/fxonQnUkRBJyq4jrJ80C+s1iAVbys/ZkV89rPz63PpjwuQiH2M+Y3F25ofl/mfWGOoSsNPleqhqm5mbKCwKAGGkt2h+yU2lYxolgTmz/xb8e2hszrJaoWuZt1seiIDwNtzrthlFPnEwY1S3rPpg8wTaz2KWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZXsQ6pAp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753481308;
	bh=NnjK2MqU5nffK8egqTxIMASgUTDHt8S5nHUSvK3y1Kk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZXsQ6pApIGk7oYMoIKxlR28SO9u2Gebu0bgbjhQfO3CRPzZdGRx/XrrPlYPBnOKqW
	 Jh3XPK8LSCUIxkZnNcilUYSPoppMXAd5QkUGt6WqbfH07PlYSBUGB+ACFthGPkDgJW
	 KaEwznNZTn+55lvRuAoUbt3BmdxDgKl65XF8m9UoMBMwr/QyeKqGNqHTaIH+Fux1Qs
	 /MI71M1igz9ll09Du8F3SUX+gPr0nTQml1bLWhLWzoY8dk5D0Lhl5nhLWhRmHlWash
	 bon/rP1rEBPteQGhrJHdSPGjGpmyysv/laWlAha6SWC/JdP7XdEMRlamSi5a7ueYi+
	 SbI4vu0b8wVdA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 79F2617E1522;
	Sat, 26 Jul 2025 00:08:28 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 26 Jul 2025 01:08:14 +0300
Subject: [PATCH v2 12/18] usb: vhci-hcd: Use the paranthesized form of
 sizeof
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-vhci-hcd-suspend-fix-v2-12-189266dfdfaa@collabora.com>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Fix the sizeof usage issue reported by checkpatch.pl:

  WARNING: sizeof *desc should be sizeof(*desc)

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 34ce2d70cfca6ba7fd3003b878036c8eb332eb81..96afb4242bf8bb7e9334d8dab08eb77cbcf24924 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -286,7 +286,7 @@ static struct {
 static inline void
 ss_hub_descriptor(struct usb_hub_descriptor *desc)
 {
-	memset(desc, 0, sizeof *desc);
+	memset(desc, 0, sizeof(*desc));
 	desc->bDescriptorType = USB_DT_SS_HUB;
 	desc->bDescLength = 12;
 	desc->wHubCharacteristics = cpu_to_le16(HUB_CHAR_INDV_PORT_LPSM |

-- 
2.50.0


