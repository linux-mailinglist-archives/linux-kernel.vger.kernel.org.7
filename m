Return-Path: <linux-kernel+bounces-746430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AF5B12698
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA104174449
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4229026CE0C;
	Fri, 25 Jul 2025 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D3msxMRH"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA816269D11;
	Fri, 25 Jul 2025 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481308; cv=none; b=XLO9x8ZjAaAOXX/Ij15gSCgIlFaYq0ohYbWARovPMaU87P1ChmT3FXnrrvZl5nal4IN8AZSXI7lvGLkmVkdLd8XhJBJeqtn9JNQ9QQ7vWd6cgOyO34dDIQ5S4NcM3fAZD7qsVL5OZ8XzrONzHI8eElfGJ/LTzXmh6gCvQfuqnSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481308; c=relaxed/simple;
	bh=VJ50li0AH58SWukwXrrIDXxeP9yPYrEW27D+aiR7rEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tmp5GS4dr1OubQUhNWzpwpINtJd5riyRKgiHEw4JEY5eleDeGB42MSAOWQ4mthpm95xAhyeg/I118CgWJhUEqxRQYF80KqnXfRY5JD07/IsT401rkLSRMF1I7uTXmEp7MSYLM8A6ApwaPISfABJbNSqg1bsQcJkrO1bmATers9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D3msxMRH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753481305;
	bh=VJ50li0AH58SWukwXrrIDXxeP9yPYrEW27D+aiR7rEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D3msxMRH3P7ibTeBxs5mcxGh4r80AfP1U9Ud7/5iU1D75wPi/LLiCGtiCfOWW/egx
	 EagmEnjgnTFNZmzFEVqQGLe2T0/D3T6ljPxAN/8TWUUjC06qyPO8DnF8rDBjdi9QPg
	 n188hMHaPumC5xWRB5ZDSnButtv4ow0S/poPjT5qie3ODLGcay/UvWIpLehgNYhSrU
	 dX6lrUEcDDvuxK1pgubK2kw/xZB3ZtN5lY2SrUpArqCnAd61AKabYDvc2E4yi4IsJG
	 geUHndjBvB23FszYdKPSeoNicyLMVggLpHQ5N0yZsr3REMev4QThXMZ7bAMraphRsT
	 lOAn8tJCWHQKA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 1327417E14D6;
	Sat, 26 Jul 2025 00:08:25 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 26 Jul 2025 01:08:10 +0300
Subject: [PATCH v2 08/18] usb: vhci-hcd: Drop unnecessary parentheses
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-vhci-hcd-suspend-fix-v2-8-189266dfdfaa@collabora.com>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Fix a checkpatch complaint:

  CHECK: Unnecessary parentheses around

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 00729ff76206905fafc263422c3ad4bcc28ba774..d74bfde1f71c50f2f4e7b69dfaf7687619e8c310 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -255,7 +255,7 @@ static int vhci_hub_status(struct usb_hcd *hcd, char *buf)
 		}
 	}
 
-	if ((hcd->state == HC_STATE_SUSPENDED) && (changed == 1))
+	if (hcd->state == HC_STATE_SUSPENDED && changed == 1)
 		usb_hcd_resume_root_hub(hcd);
 
 done:

-- 
2.50.0


