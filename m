Return-Path: <linux-kernel+bounces-804328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD02B4723D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A455A0D41
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E8E2F1FE1;
	Sat,  6 Sep 2025 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWA8+H3o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1AA20469E;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757173419; cv=none; b=HVOXv43rtfgCdaQesdcioWD3QbB6LBCSaI6FfXXBZnmF6ho3I4uYiiW8SWD1uon/C8aB8W8B9jdemdYxHQPaH8jrIJOxXhvpcjnV06kE61ONaYUQ8Pn8xi7pYsbQgabrxrlU+tCvhxJ0QwE9iXV7MZjUkBoO7eXZXfSiJDkQ1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757173419; c=relaxed/simple;
	bh=Q8PS/CHcVU9sVoFvstzk8Tw0m//oeM0x0Mm79e4aeeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RScCXJsqzzY3sABVXQPtBYLf/rhKO8t5qsLQyOq3mMAOhsJPwMGaiEncvr7wvQy8Ts/J7bQ4poyg6JArIMJ/2fhr+6tbU/el3xMuDjGsZsmgDH+20vwSUuhx9h9aqeAzuBQ5uZw5PCBn3y/ZKYEKWjNxwdu5VCU5ACBmO2H2w4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWA8+H3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51894C4CEF9;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757173419;
	bh=Q8PS/CHcVU9sVoFvstzk8Tw0m//oeM0x0Mm79e4aeeQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZWA8+H3o5lxJeOz0/0ZNMqEOZ1XJgDCUXDnU+EyAZEJxThMe8qLib7FqcCigQyRv0
	 lsS4FIaDfDOhg8rzANlfvhOYvQEVaaDTj9EhlubhMT2LryGTLY9CVgR7lXhgtHmqD8
	 f1SFd7Ljc9bfNd5izXyE7qxcUyd6WLNYTbSLdZQink2CM3p6zGCDObQC/GuzWq7tSn
	 8BX2EUCyTPzELyzZxuMn0w6AgXaA05UislMxj4Suev5NL0ChH6zeNJedrsb4/bijVV
	 24UHW8rvQskhGIQsl2mf+AFNmGFA7yH8DviijBKxQWqsNUhQECQGG5gkmTE8cj4Ilr
	 xUz3AWZItKUBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFE2CA1002;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sat, 06 Sep 2025 15:43:15 +0000
Subject: [PATCH v2 02/22] usb: dwc3: dwc3_power_off_all_roothub_ports: Use
 ioremap_np when required
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-atcphy-6-17-v2-2-52c348623ef6@kernel.org>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
In-Reply-To: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 Sven Peter <sven@kernel.org>, stable@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=Q8PS/CHcVU9sVoFvstzk8Tw0m//oeM0x0Mm79e4aeeQ=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8aesNktsybFzVVaed8xlyc7weRDuT6/vvjjdfN7r61Rf
 JT+s3luRykLgxgHg6yYIsv2/famTx6+EVy66dJ7mDmsTCBDGLg4BWAia6Yw/I9KuJ5ww0JJXST2
 usDtWCcJRrW1egs23c5g0n/g/756HRvD/7I81oyq2YXTBMt2dE0x8olUj6iwvPPhfaeK+McVTpP
 ZeAE=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

On Apple Silicon machines we can't use ioremap() / Device-nGnRE to map most
regions but must use ioremap_np() / Device-nGnRnE whenever
IORESOURCE_MEM_NONPOSTED is set. Make sure this is also done inside
dwc3_power_off_all_roothub_ports to prevent SErrors.

Fixes: 2d2a3349521d ("usb: dwc3: Add workaround for host mode VBUS glitch when boot")
Cc: stable@kernel.org
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/usb/dwc3/host.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 1c513bf8002ec9ec91b41bfd096cbd0da1dd2d2e..e77fd86d09cf0a36161c20ad3c83f10e67099775 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -37,7 +37,10 @@ static void dwc3_power_off_all_roothub_ports(struct dwc3 *dwc)
 
 	/* xhci regs are not mapped yet, do it temporarily here */
 	if (dwc->xhci_resources[0].start) {
-		xhci_regs = ioremap(dwc->xhci_resources[0].start, DWC3_XHCI_REGS_END);
+		if (dwc->xhci_resources[0].flags & IORESOURCE_MEM_NONPOSTED)
+			xhci_regs = ioremap_np(dwc->xhci_resources[0].start, DWC3_XHCI_REGS_END);
+		else
+			xhci_regs = ioremap(dwc->xhci_resources[0].start, DWC3_XHCI_REGS_END);
 		if (!xhci_regs) {
 			dev_err(dwc->dev, "Failed to ioremap xhci_regs\n");
 			return;

-- 
2.34.1



