Return-Path: <linux-kernel+bounces-853498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EF1BDBD2E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 95C8A353962
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A8C2EBB86;
	Tue, 14 Oct 2025 23:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2F54D4c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482532E5B11;
	Tue, 14 Oct 2025 23:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760485113; cv=none; b=JeTwX88PeRdNXSTJZQQdEyPrvD856TUI48e07SAHB5TFxKJNj20GVMU2PNrh8FNpgeNOy5fPI6ZGJDnvuvv0yg+e9N0ZgDIm2/DCHfteJpqoRbsyx/eUNKf22AtbVKENBRCLNiAajMr19n+7ualVZFzgEwU7Htcpj1QF1W6EL+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760485113; c=relaxed/simple;
	bh=RBa+ARWZImq2jN4SP1FuMQo3XNtxMHV4AIx03WOCftg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R8VkWx3MaCcEV5xSrPARGZi25Z/fSNWmrJ+dWzZbde+sVKw7LNVomAXz5wCGce4ClBIkwaOVYpsWNbMLoDABo/0NNXdE/JP+CnCejF/tPkMy4oyGz1Mig0P+phPcoYzz7jXjAFp0YbD9YxZSl/ijEFV8X9HJ0JwXPe0Ote5ntKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2F54D4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BC7C4CEE7;
	Tue, 14 Oct 2025 23:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760485112;
	bh=RBa+ARWZImq2jN4SP1FuMQo3XNtxMHV4AIx03WOCftg=;
	h=From:Date:Subject:To:Cc:From;
	b=p2F54D4caq5AZx1ZCsne/etc1qBn3tT7XlFn+nog15NmZhgKEGoiNZ6AuC7FlTVZ/
	 LtKFqQfXUESG/Msno53DuzheCFl+xwIH9pbG9Aemesn8P5+AsymdP2ghkD9rnu6q5P
	 /F7fWds/Js8AfSlGI7wuh7A1+I4nSwk0BCW8vX9i1Jgp0O5M6iozMQZLgeYNFyUsxi
	 gV5tpsf8pp7bfMQq3Zy8g3Rb4w6Po28YRZtJmVlgScD01GJaGJEAeHQKr/+F/z117B
	 egeAQCozpbjuIqcivtf9duN8eALWGBLn95Vv7cWofweuzCKC1KFnHsRT43nVuhxWyB
	 fBGJgxNXdbCFg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 14 Oct 2025 16:38:19 -0700
Subject: [PATCH] usb: uhci: Work around bogus clang shift overflow warning
 from DMA_BIT_MASK(64)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-usb-uhci-avoid-bogus-clang-shift-warning-v1-1-826585eed055@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOre7mgC/x3N0QrCMAyF4VcZuTbQljrFVxEvsi5bA9JKY6cw9
 u4GLz/4OWcH5SascBt2aLyJSi0GfxogZSoro8xmCC6cvfMRu07YcxKkrcqMU127YnpaippleeO
 HWhETXZ0fRwoxXgLY3KvxIt//1f1xHD84K9qJegAAAA==
X-Change-ID: 20251014-usb-uhci-avoid-bogus-clang-shift-warning-a80166a24472
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3323; i=nathan@kernel.org;
 h=from:subject:message-id; bh=RBa+ARWZImq2jN4SP1FuMQo3XNtxMHV4AIx03WOCftg=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBnv7n17K7Yhcxv33muLp17iXrwxtT/qaso2gx1Gjd/TG
 JV3TdFm7ChlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATCdzI8M/+qfb3N53cq47n
 Bky5LvLw/4HkxYG+j69X3VB44/bwc74wI8M/K6vGOtWpr0XbcuIynHb35FhorFxa/JOLS8xI/OE
 8Uy4A
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit 18a9ec886d32 ("usb: uhci: Add Aspeed AST2700 support"),
clang incorrectly warns:

  In file included from drivers/usb/host/uhci-hcd.c:855:
  drivers/usb/host/uhci-platform.c:69:32: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
     69 | static const u64 dma_mask_64 = DMA_BIT_MASK(64);
        |                                ^~~~~~~~~~~~~~~~
  include/linux/dma-mapping.h:93:54: note: expanded from macro 'DMA_BIT_MASK'
     93 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
        |                                                      ^ ~~~

clang has a long outstanding and complicated problem [1] with generating
a proper control flow graph at global scope, resulting in it being
unable to understand that this shift can never happen due to the
'n == 64' check.

Restructure the code to do the DMA_BIT_MASK() assignments within
uhci_hcd_platform_probe() (i.e., function scope) to avoid this global
scope issue.

Closes: https://github.com/ClangBuiltLinux/linux/issues/2136
Link: https://github.com/ClangBuiltLinux/linux/issues/92 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/usb/host/uhci-platform.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
index 37607f985cc0..f532d3a0acbf 100644
--- a/drivers/usb/host/uhci-platform.c
+++ b/drivers/usb/host/uhci-platform.c
@@ -65,16 +65,16 @@ static const struct hc_driver uhci_platform_hc_driver = {
 	.hub_control =		uhci_hub_control,
 };
 
-static const u64 dma_mask_32 = DMA_BIT_MASK(32);
-static const u64 dma_mask_64 = DMA_BIT_MASK(64);
+static const bool use_dma_mask_64 = true;
 
 static int uhci_hcd_platform_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const u64 *dma_mask_ptr;
+	u64 dma_mask = DMA_BIT_MASK(32);
 	struct usb_hcd *hcd;
 	struct uhci_hcd	*uhci;
 	struct resource *res;
+	const bool *of_data;
 	int ret;
 
 	if (usb_disabled())
@@ -85,11 +85,11 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
 	 * Since shared usb code relies on it, set it here for now.
 	 * Once we have dma capability bindings this can go away.
 	 */
-	dma_mask_ptr = (u64 *)of_device_get_match_data(&pdev->dev);
-	if (!dma_mask_ptr)
-		dma_mask_ptr = &dma_mask_32;
+	of_data = of_device_get_match_data(&pdev->dev);
+	if (of_data && *of_data == use_dma_mask_64)
+		dma_mask = DMA_BIT_MASK(64);
 
-	ret = dma_coerce_mask_and_coherent(&pdev->dev, *dma_mask_ptr);
+	ret = dma_coerce_mask_and_coherent(&pdev->dev, dma_mask);
 	if (ret)
 		return ret;
 
@@ -200,7 +200,7 @@ static void uhci_hcd_platform_shutdown(struct platform_device *op)
 static const struct of_device_id platform_uhci_ids[] = {
 	{ .compatible = "generic-uhci", },
 	{ .compatible = "platform-uhci", },
-	{ .compatible = "aspeed,ast2700-uhci", .data = &dma_mask_64},
+	{ .compatible = "aspeed,ast2700-uhci", .data = &use_dma_mask_64 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, platform_uhci_ids);

---
base-commit: 877c80dfbf788e57a3338627899033b7007037ee
change-id: 20251014-usb-uhci-avoid-bogus-clang-shift-warning-a80166a24472

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


