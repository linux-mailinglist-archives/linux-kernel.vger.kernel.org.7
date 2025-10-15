Return-Path: <linux-kernel+bounces-855101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E78F1BE03AC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D26A14E9F29
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9D92FFFAC;
	Wed, 15 Oct 2025 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIxdogEm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AF1325496;
	Wed, 15 Oct 2025 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553814; cv=none; b=kVHZcfrNcUR6gClrtPDiCUgj9OBAnDvo7XLMpv2DapmLOxVe3N1wzLVR18KXoZYt4v4QZiMdIrU+spO9ZRbwIC66qvR3OVpfbGsOG4kXxqI3lRM9exGGkirleuhZjf1cNp/ADE+l/0GDVJ+gnrXxIVF0tha6P3gJA/3raHJa8TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553814; c=relaxed/simple;
	bh=SaNi7inb5n1alCq1NeyBjCg+fDtGlGrmovk6Zw2Bbgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rjGD5G3pGZRKlV26PdeMoaRCR9FXiYxQPQbm/ck57znG9hNn6qj4MDJ/TGuIjyVhl83BXLVNj+n5XEnsfp2oW1obCS9/vSz8k3i18xflo05aDY9rMPoFsDUFxW0TBVMIZSXIZPZ4jjHspGHvsIBvvQ34tPIRjQS/E7y6Mbmnyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIxdogEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BDDC4CEFB;
	Wed, 15 Oct 2025 18:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760553812;
	bh=SaNi7inb5n1alCq1NeyBjCg+fDtGlGrmovk6Zw2Bbgk=;
	h=From:Date:Subject:To:Cc:From;
	b=tIxdogEmn8lLwpjIFacTtw8t8i3wvzHYqefvtog8fBWpvop00Y5VXl9rKpcT1+cxH
	 83TNP0YQlY4RcU32+dgDYr7tHizugc0CJA4kmb78ZD5F+mV2sNjJwjrCQz1YPBYRRc
	 OYQq9Nsm8Wbj0Lgn0I2bgbNkmDFc96hApO9RM5SHNdwc12iuIfwoHSlBOJYouIcyAw
	 xm7fFAh92bN0FZoQ/qis+i9E3rlfL0QHgjxehB8tY61yC+nbLef9ofqLZQmlbmQCtA
	 qq21AvV0f0arIWcxsTW5ZU56OaQlAOiMxdWx3BVwneEalwJeTuLNpqBH+UQQBMMBLE
	 3fZ4iL9t0S9iQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 15 Oct 2025 11:43:09 -0700
Subject: [PATCH v2] usb: uhci: Work around bogus clang shift overflow
 warning from DMA_BIT_MASK(64)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-usb-uhci-avoid-bogus-clang-shift-warning-v2-1-68532d2f6114@kernel.org>
X-B4-Tracking: v=1; b=H4sIADzr72gC/53NQQ6CMBCF4auQrh3TNhSJK+9hWBQY6ETSmg6tG
 sLdrRzB5TeZvH8TjJGQxbXaRMRMTMEX6FMlBmf9jEBjsdBSGyVVDYl7SG4gsDnQCH2YE8OwlFd
 gR9MKLxs9FdlWqqaxuq4vWpS5Z8SJ3kfq3hU74jXEz1HO6nf9I5IVKGh1Y1qDOEpjbg+MHpdzi
 LPo9n3/AjeFfp7hAAAA
X-Change-ID: 20251014-usb-uhci-avoid-bogus-clang-shift-warning-a80166a24472
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3632; i=nathan@kernel.org;
 h=from:subject:message-id; bh=SaNi7inb5n1alCq1NeyBjCg+fDtGlGrmovk6Zw2Bbgk=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBnvXwdN1FWSfSr/xeC/0ua0/tfGfbtmB1140b2wY3FQk
 6iTxbvMjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRd7sY/tmsZ9toneix+MPy
 XvGzHmpt/RnHdVYKn146eY75d4aY1W4Mv5hSfquXsx3doB0t0HCs9OhNh1nrAnUkl+oknV5Urz7
 tMT8A
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

Restructure the code to only use DMA_BIT_MASK() within
uhci_hcd_platform_probe() (i.e., function scope) to avoid this global
scope issue, similar to the approach of commit 274f2232a94f ("usb: ehci:
Add Aspeed AST2700 support").

Closes: https://github.com/ClangBuiltLinux/linux/issues/2136
Link: https://github.com/ClangBuiltLinux/linux/issues/92 [1]
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v2:
- Slightly rework solution to follow commit 274f2232a94f ("usb: ehci:
  Add Aspeed AST2700 support") (Alan)
- Adjust message to match
- Apply Alan's Reviewed-by from v1
- Link to v1: https://patch.msgid.link/20251014-usb-uhci-avoid-bogus-clang-shift-warning-v1-1-826585eed055@kernel.org
---
 drivers/usb/host/uhci-platform.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
index 37607f985cc0..5e02f2ceafb6 100644
--- a/drivers/usb/host/uhci-platform.c
+++ b/drivers/usb/host/uhci-platform.c
@@ -65,13 +65,10 @@ static const struct hc_driver uhci_platform_hc_driver = {
 	.hub_control =		uhci_hub_control,
 };
 
-static const u64 dma_mask_32 = DMA_BIT_MASK(32);
-static const u64 dma_mask_64 = DMA_BIT_MASK(64);
-
 static int uhci_hcd_platform_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const u64 *dma_mask_ptr;
+	bool dma_mask_64 = false;
 	struct usb_hcd *hcd;
 	struct uhci_hcd	*uhci;
 	struct resource *res;
@@ -85,11 +82,11 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
 	 * Since shared usb code relies on it, set it here for now.
 	 * Once we have dma capability bindings this can go away.
 	 */
-	dma_mask_ptr = (u64 *)of_device_get_match_data(&pdev->dev);
-	if (!dma_mask_ptr)
-		dma_mask_ptr = &dma_mask_32;
+	if (of_device_get_match_data(&pdev->dev))
+		dma_mask_64 = true;
 
-	ret = dma_coerce_mask_and_coherent(&pdev->dev, *dma_mask_ptr);
+	ret = dma_coerce_mask_and_coherent(&pdev->dev,
+		dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
 
@@ -200,7 +197,7 @@ static void uhci_hcd_platform_shutdown(struct platform_device *op)
 static const struct of_device_id platform_uhci_ids[] = {
 	{ .compatible = "generic-uhci", },
 	{ .compatible = "platform-uhci", },
-	{ .compatible = "aspeed,ast2700-uhci", .data = &dma_mask_64},
+	{ .compatible = "aspeed,ast2700-uhci", .data = (void *)1 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, platform_uhci_ids);

---
base-commit: 877c80dfbf788e57a3338627899033b7007037ee
change-id: 20251014-usb-uhci-avoid-bogus-clang-shift-warning-a80166a24472

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


