Return-Path: <linux-kernel+bounces-854807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C48BDF732
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3F819C8178
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F4732ED3B;
	Wed, 15 Oct 2025 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM5PC09c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BAE32A3C0;
	Wed, 15 Oct 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542870; cv=none; b=d52G/n1/jRwc0ZJFgtvSVI4okcv+gCoBO0lr0QU3/K3GdO/O/aGSrMep2CcZOM+yJJ6YHzDlwS6jCLuNjPeu/8CyKJkBkapsb42LE9IMg/gClagjNSXTCnMaQwRiE7Fpj+Ped7bs5UpIIJP+6xigjFL0N81kK6AD0CxVD5R+AyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542870; c=relaxed/simple;
	bh=1msbnw19IZ4ZHbNE1uvoShSsPtMAyhJKh5i9EIHWbqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZFtuzueAjZhlRmRzdKtpK+e1fyEZUjFX2rATyhmccox3EE8152jgkwmH8+XySUKTxr/+OFrnjLQRKvog7qEOtbbfTALsUSm+wrtQD5ExWzYja43ya/f0v8DdEZ9+PCLBHdI2j4PQfNxTuAi/6dmGCDzaDz/zE6TNovre55dKUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM5PC09c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FC48C4CEF9;
	Wed, 15 Oct 2025 15:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760542869;
	bh=1msbnw19IZ4ZHbNE1uvoShSsPtMAyhJKh5i9EIHWbqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DM5PC09cOpAw/OkwZysLUDgkYwR4cLoLHgaya5FeN5uKfFVoI8739VjpU7Ju8MiEF
	 LPYwi9Sr+oA+c7SywRsRGuFYJf+ZJQqw2fxe4HQRFId0Go2ysHVXbJhvrWM+eOA1mu
	 ySXfyPk+6IfqJ1n3Vjqi2z2bBJLdgGPGo54VRQMy4qBhyFqpozuLKJ+r4Nr05Lqt/L
	 68KdZBYr4RqoKUl8Hy43AelM32djaPsvBFdsX585fKYehibkmIQFCmkATkVaGihxZX
	 dXArLzJ1R91OQTyKB2UaPPtBPkppEobjpfwk00pph56b3py2VwkqtVDwjBIt1XNHix
	 Xt4w0S45fv6zw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B2ACCD185;
	Wed, 15 Oct 2025 15:41:09 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Wed, 15 Oct 2025 15:40:42 +0000
Subject: [PATCH usb-next v2 2/5] usb: dwc3:
 dwc3_power_off_all_roothub_ports: Use ioremap_np when required
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-b4-aplpe-dwc3-v2-2-cbd65a2d511a@kernel.org>
References: <20251015-b4-aplpe-dwc3-v2-0-cbd65a2d511a@kernel.org>
In-Reply-To: <20251015-b4-aplpe-dwc3-v2-0-cbd65a2d511a@kernel.org>
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
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8b7A31sSjEtDvUzzR5N+yvqwxrwkdNxxVX+gO2x53NWL
 TZT6WToKGVhEONgkBVTZNm+3970ycM3gks3XXoPM4eVCWQIAxenANzkQIY/vFbmLtp2ixbxnQqK
 ZAgqYN1yvj68SVhMtC4uWay5iPshw//kQuufIYo5OT9S1l188z6RM2W6ToLFYQaHqg/zPdM/neM
 DAA==
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



