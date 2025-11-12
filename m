Return-Path: <linux-kernel+bounces-898092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B5DC545B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AA134E3FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56D429B8F8;
	Wed, 12 Nov 2025 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNOTztXp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27626D2FB;
	Wed, 12 Nov 2025 19:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977541; cv=none; b=GAg6cgpa5vArYbkJ+djVZpTpOrfQe+fZqOJcvlJpxPhjAKtrnVAbjiM8wi9f3Lw8jVPh8O9TnaLDcnIS9wPQu9DD9aiVhgeP4uUBmeNfrVytcGInqeXPrEwScMRk/VG/3dURiMdMNgB2K428/A0LmCj9Zykc7lqDFEZC38afpws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977541; c=relaxed/simple;
	bh=qA1gBPYG6fLY52w2WE61R8d+PHhiZ2IulpfhWnd2Gf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zmzrw4mJE55jCMeIWi1Yvo5j7rdgPPaMMgHe9tANGwlEe5cXLdtp6vq6sCT8RInp0Rba8SbceV/RHXoudobjv5kobO7R5SYVx0ZbnlDEWTVziW62AYvzUuW+bG3zc6mivfaGEXuYJX+eQdzrKWXZWMi+zWOrp7CRhotZRrbMlV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNOTztXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB04C16AAE;
	Wed, 12 Nov 2025 19:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762977537;
	bh=qA1gBPYG6fLY52w2WE61R8d+PHhiZ2IulpfhWnd2Gf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gNOTztXpD8TlJBptngb5cvc6BySZ6qLPZOxc1lzu1Dth13hmIH7bWKzn4JmY1AlEW
	 fJ9sACZ433nJWjoe8jxWD6jZqGvbsO4FtWPfIGz9H+wSRPFPZLPE0FT92IXcLyhIjy
	 kqWhsXE8KCmdJAdvLHrNWzfNSXAJVam5L2nh94ZwRgr/RTalLJyuxNKq2W3F2PB1vW
	 ZhiG4WdaYEvkouO0xqViWLrQ5Ln56vhI/ufauwtD84mB2UbdmTQ+sdBnYR5DV7EnWj
	 pNnfH5mJ1uKNovijuc13g7EwJf1SAd3xPpZ0xHriLzCVWyXM5ZPRtxL7+UXzBMTAJe
	 g7WHukfv9FbIQ==
Date: Wed, 12 Nov 2025 13:58:56 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org,
	Paul Walmsley <pjw@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH] of: Skip devicetree kunit tests when RISCV+ACPI doesn't
 populate root node
Message-ID: <176297731621.2151636.2516355929483523874.robh@kernel.org>
References: <20251023160415.705294-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023160415.705294-1-linux@roeck-us.net>

On Thu, 23 Oct 2025 09:04:14 -0700, Guenter Roeck wrote:
> Starting with commit 69a8b62a7aa1 ("riscv: acpi: avoid errors caused by
> probing DT devices when ACPI is used"), riscv images no longer populate
> devicetree if ACPI is enabled. This causes unit tests to fail which require
> the root node to be set.
> 
>   # Subtest: of_dtb
>   # module: of_test
>   1..2
>   # of_dtb_root_node_found_by_path: EXPECTATION FAILED at drivers/of/of_test.c:21
>   Expected np is not null, but is
>   # of_dtb_root_node_found_by_path: pass:0 fail:1 skip:0 total:1
>   not ok 1 of_dtb_root_node_found_by_path
>   # of_dtb_root_node_populates_of_root: EXPECTATION FAILED at drivers/of/of_test.c:31
>   Expected of_root is not null, but is
>   # of_dtb_root_node_populates_of_root: pass:0 fail:1 skip:0 total:1
>   not ok 2 of_dtb_root_node_populates_of_root
> 
> Skip those tests for RISCV if the root node is not populated.
> 
> Fixes: 69a8b62a7aa1 ("riscv: acpi: avoid errors caused by probing DT devices when ACPI is used")
> Cc: Han Gao <rabenda.cn@gmail.com>
> Cc: Paul Walmsley <pjw@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/of/of_kunit_helpers.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

I guess the riscv folks don't care about supporting the relevant 
features either, so I've applied it. Can kicked down the road again.


