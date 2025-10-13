Return-Path: <linux-kernel+bounces-850989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57083BD5503
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00DF8504E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA5230DEBD;
	Mon, 13 Oct 2025 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcgrY57x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB93228CB0;
	Mon, 13 Oct 2025 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371438; cv=none; b=TZR59JC/vYD0d8wECj7yuRI3xXu9ajfBOpxoVySkmg0CNhA3A09FycKp5haowF5kdMvP4pG+sEZFL94SS5/f1JarauPfxpExVTnUlcgZYeKN4mBRLf2ap6U2qEHXADQjSV8mreDS47WmAO5dzLcHFQ5Pu5ZAXlPL7GYC6cX2/nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371438; c=relaxed/simple;
	bh=1msbnw19IZ4ZHbNE1uvoShSsPtMAyhJKh5i9EIHWbqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ChFom5zIGUXKvA8c438MWKbHxAcUtsm0piQeYo2pQhzTq/CoTVNGG8RU7ha000AM7SLNLoSJuhbbNt95LVSKsJE0rIU3YeajOg6U+Zsni+uOUjnR7dQVRvo/d/dn4uSlz9Ko19+UTZUyzR/JRPghTidg9soIwH80VmucvChNkgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcgrY57x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07B83C4CEE7;
	Mon, 13 Oct 2025 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760371438;
	bh=1msbnw19IZ4ZHbNE1uvoShSsPtMAyhJKh5i9EIHWbqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tcgrY57xbQJPNoedJMEgxY56xS2Dm6qFSuAVD6JQtugMah1NTOWGkBFet1tA7mYr2
	 hcFVE86nZuHst2FuW6t7Yiur7XYMbMYarRPG2mehUIn4l8SukgGmalv8lIOSmQDiic
	 vn2FKnp1A9CKQWew0xxh4fK2w+oUoEZserb0iyNf3eFj0D8jFczYucy8awUTW5kNAw
	 kx7tUerxkiwL8NlmG0vZiM9HwPJv08VneZ7+5PZYhM5FfMM3IabxhhzFacw8vTtU0S
	 iwolXKTNgV8Sxw4VxT4cMZ4Dg+ejuz5WkwmNkZXdxBAssICyV4iqQ7GqNwxmQZ2LR5
	 ef2JDTYXUrWcw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC9CCCD18F;
	Mon, 13 Oct 2025 16:03:57 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Mon, 13 Oct 2025 16:03:26 +0000
Subject: [PATCH 2/5] usb: dwc3: dwc3_power_off_all_roothub_ports: Use
 ioremap_np when required
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-b4-aplpe-dwc3-v1-2-12a78000c014@kernel.org>
References: <20251013-b4-aplpe-dwc3-v1-0-12a78000c014@kernel.org>
In-Reply-To: <20251013-b4-aplpe-dwc3-v1-0-12a78000c014@kernel.org>
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sven Peter <sven@kernel.org>, 
 stable@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=1msbnw19IZ4ZHbNE1uvoShSsPtMAyhJKh5i9EIHWbqU=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8Zbpae/bNrM77haON2MDD4TO4Xn+02Np08KvjaX/pDm6
 agtv8naUcrCIMbBICumyLJ9v73pk4dvBJduuvQeZg4rE8gQBi5OAZhIwT1Ghum8ydkWR9aZvDTb
 9XX+WrX7JyqTp57NK7yitn+aitrXts+MDM+2F5uJx3e9/p7rF3nX0ztgtapY7M2w75G+d1IeGLm
 6cQMA
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
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
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



