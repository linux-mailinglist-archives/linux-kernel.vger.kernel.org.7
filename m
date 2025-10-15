Return-Path: <linux-kernel+bounces-853678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B24BDC520
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 732564F1C59
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749B8274FE8;
	Wed, 15 Oct 2025 03:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1hNNWJ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF41325487C;
	Wed, 15 Oct 2025 03:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760498397; cv=none; b=MztKiCYdvu/aQBNgpZ7kUe5BzdSz/OJZi5tJG7bHUnOsJjrwqUQ7C2XwYXjnpf+JWEjGREWiZ/1gLEPkhaEeOb2LQCXfpxd/O8oggRgzi8NbRMbZxXyo0R6adDXR/UWtYVPVQ27s2sY7r1XgY0JfeY3JU0GcxbZOPLRYx+MlK9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760498397; c=relaxed/simple;
	bh=2Cxa/q4DAu5r+A3h1YX2ECqhE765wvQqU/Vghauoc90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+XJ17pR2ZTJ82XNmDUdphnQPNUu/FYyCKZjEGt4oyskigvBBB/XnjKmpRanzrEsQAieAnIQi9qc/NGVrgLNyiCIlgjQXNDNHcNnV4dACbMrgMvw9B5WYhtcU1raFuSxR3hUNnVfmNj3FgwmYumJMxMGTbJ/tGJYcdSskZ9rNQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1hNNWJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624CDC4CEE7;
	Wed, 15 Oct 2025 03:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760498397;
	bh=2Cxa/q4DAu5r+A3h1YX2ECqhE765wvQqU/Vghauoc90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G1hNNWJ4hbV0VooC6mwGjO+pWzOlBkEEL2sceR7ZyaR6Kuo1361elr8drRICwAVmb
	 v7d44Y08nzHp0zzI+/KzQUwhKpfd+xwkulSKRRhs9yLaGW2lsfjFuXg1cHltLnnHMS
	 awHTFgjIJuQ2etc4yiaqSNkBsRXxLOG8gbIdQGIeIjs50+fMWwmXykOqm8YXJYBnSz
	 dlko8OIdS1RxyTWQHg/C+/7QFR/jn7zDJzpxMA47RjfGA25MPFAdQvTbSIV3jVdGUH
	 tEO91W3X+WO6zHeLljRxxvnwrvpDAiY5hLmZDV3Mdgh64NKN1Af+BV0GorXBtHzx1Z
	 Etmn3XgeReX8w==
Date: Tue, 14 Oct 2025 20:19:52 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] usb: uhci: Work around bogus clang shift overflow
 warning from DMA_BIT_MASK(64)
Message-ID: <20251015031952.GA2975353@ax162>
References: <20251014-usb-uhci-avoid-bogus-clang-shift-warning-v1-1-826585eed055@kernel.org>
 <c0d1dc65-6f55-40b9-bbfa-09e8639a28e0@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0d1dc65-6f55-40b9-bbfa-09e8639a28e0@rowland.harvard.edu>

On Tue, Oct 14, 2025 at 11:07:27PM -0400, Alan Stern wrote:
> On Tue, Oct 14, 2025 at 04:38:19PM -0700, Nathan Chancellor wrote:
> > After commit 18a9ec886d32 ("usb: uhci: Add Aspeed AST2700 support"),
> > clang incorrectly warns:
> > 
> >   In file included from drivers/usb/host/uhci-hcd.c:855:
> >   drivers/usb/host/uhci-platform.c:69:32: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
> >      69 | static const u64 dma_mask_64 = DMA_BIT_MASK(64);
> >         |                                ^~~~~~~~~~~~~~~~
> >   include/linux/dma-mapping.h:93:54: note: expanded from macro 'DMA_BIT_MASK'
> >      93 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> >         |                                                      ^ ~~~
> > 
> > clang has a long outstanding and complicated problem [1] with generating
> > a proper control flow graph at global scope, resulting in it being
> > unable to understand that this shift can never happen due to the
> > 'n == 64' check.
> > 
> > Restructure the code to do the DMA_BIT_MASK() assignments within
> > uhci_hcd_platform_probe() (i.e., function scope) to avoid this global
> > scope issue.
> > 
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/2136
> > Link: https://github.com/ClangBuiltLinux/linux/issues/92 [1]
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> 
> Do you think you could instead copy the approach used in:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?id=274f2232a94f6ca626d60288044e13d9a58c7612
> 
> IMO it is cleaner, and it also moves the DMA_BIT_MASK() computations 
> into a function scope.

Sure, would something like this be what you had in mind?

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

The

  const struct of_device_id *match;

  match = of_match_device(dev->dev.driver->of_match_table, &dev->dev);
  if (match && match->data)

part of the change you linked to is equivalent to

  if (of_device_get_match_data(&dev->dev))

if someone wanted to do a further clean up.

Cheers,
Nathan

