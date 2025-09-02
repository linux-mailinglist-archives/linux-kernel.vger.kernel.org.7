Return-Path: <linux-kernel+bounces-796333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC695B3FF0E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45F73A12C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B55F3074A7;
	Tue,  2 Sep 2025 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CNOaDqs2"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99772FE56B;
	Tue,  2 Sep 2025 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814229; cv=none; b=FogNl8tTl4t1Rs+jY0RGCKHpAtZFurvzS78EVcIQqp9mMLMOD0fV4C0KFf+7KCqZ5Ln7smyWYIJvK1rhBD/ebL+K0eoYqycijrySR1tffaIPM+aP+a9X9ePpwIFpzRVQgSo0zt9cN8ckAekIMJGktXVRht65I4gx9QTHpfTFJa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814229; c=relaxed/simple;
	bh=frPPyOmJEkW6VaQqxMP9t4HLApPpDWQVGoHyIt7wG1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=We5s2b8tL/gZwk2HIGkYL0Ts/aMviNn9cJoBltHod97ICGeOEH3V8aZwh/XH3Y4fIj5BmLCTqByOFu5FCndfeat9T5l8uUd7miL8meag3Un5PFcvmZFtdJlXFIEmWxPlbRcPr9sq5Tw7EAF+/jvpGgsAoqIf4v3iphiIo9GCV8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CNOaDqs2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756814225;
	bh=frPPyOmJEkW6VaQqxMP9t4HLApPpDWQVGoHyIt7wG1M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CNOaDqs2TRJZzRYh8c5eioqfIVG73KHK5yDZPLwI04Gb2/zhjHFR71ie4HmElGZj6
	 Bj7lqJMaEH8Uf8kM0zconWb3QbnbBC5Vk4Z9lN51qjanWTn0wkUJZmLoNVY3nWikSV
	 eiQSCZaHNyYv5UNrcgvXE8Tez1pQXdc1+vZ1DljHIaESbKHSTb+tkljiwh0eWyvJWp
	 /CBu+rbC9qvEKC+tKm+mRPRaf027Ji7b4AKwAsVZBhVUlGnBM7GxC0KARciWtEgKGh
	 smPeHyXq+6/qvwFXZ/byt78G0zljzxgrhdOEcMhpzAyVlgGXvyx4uBNrwt1tCSPfHB
	 cSIvGeFbpUKoQ==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 0C2D417E131D;
	Tue,  2 Sep 2025 13:57:05 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 14:56:33 +0300
Subject: [PATCH 11/17] usb: vhci-hcd: Use the paranthesized form of sizeof
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-vhci-hcd-cleanup-v1-11-1d46247cb234@collabora.com>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Fix the sizeof usage issue reported by checkpatch.pl:

  WARNING: sizeof *desc should be sizeof(*desc)

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 5b9cc84947781f79d69751ebda950cb293db7cb6..3296914dc89e6e7b7754b92d02b44de441c6714e 100644
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
2.51.0


