Return-Path: <linux-kernel+bounces-884323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88207C2FDEC
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21D14222CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F7D3164A0;
	Tue,  4 Nov 2025 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPbwNonw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0612248A8;
	Tue,  4 Nov 2025 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244556; cv=none; b=PPJSEuV9TkeNkaFLUqrwl+r5VC2jPRSo1zo+ZfRKqRMB29D5LqXzgN95W/5a0P8Ak0tG3ranhHnfg+HQ++DXFjE9AadBbd8CfgXxMb6t/i3WYLvNhgVKxZnw/3XFzky6qm7EQR83pIoddpoAevKhRpCkgQYPQ2WMcEcLeuVa2h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244556; c=relaxed/simple;
	bh=ReIHYoZ0hfuPqjEQELfx5zZWt5YlSXlsiSnCN8jUknA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdgeG9Uge1wt9ffKVLYMfIgrV3T+gvqUrNC13+rpytMYAxc22CR+0jDRNz474JFoMejqvqOP219xitU+jQGyxzkSeRZs5vaMmNg2kPR2NP1QddIZuwoxEWjAh3I+BjOgg4JPBx/HbK1tB2OmiZi3XCnRskTR+CbdUAs4gj+PoWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPbwNonw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D539C4CEF7;
	Tue,  4 Nov 2025 08:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762244556;
	bh=ReIHYoZ0hfuPqjEQELfx5zZWt5YlSXlsiSnCN8jUknA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZPbwNonw93eAJJvAlPi5vo8zgVf76U06SpHwN8KcdItl2PD2A2gaGXwc6ZjgWx4uS
	 wb801lM9uqwgMc0JomOoA+VmFd+G2mvXpEZ7ddbT+wQyqcrhMHOEgeV27krAw5KbxX
	 2KU2rKAJO6ZuWiiPrrm3YwlXeVMwGrBbz+YyXho3rjEu3tuVIIx0UkuFxytgLmMNz2
	 kyB0Gott5qFfuh3RI6jNeECSOkrtWGvlhrjJPzyTzGSjBJPfqEWZi8NYgsp60vA8P9
	 U6ERelUNMVbVP8VMRNGL/KQAVcDzR6CzGYZf6c80bCUP5jdkTwl8Sozrpz1aOogxMg
	 OjSVmzxjry5xw==
Date: Tue, 4 Nov 2025 09:22:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peter Shen <sjg168@gmail.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	peter.shen@amd.com
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: aspeed: Add compatible for
 Facebook Anacapa BMC
Message-ID: <20251104-mellow-denim-dogfish-4affdb@kuoka>
References: <20251103093320.1392256-1-peter.shen@amd.com>
 <20251103093320.1392256-2-peter.shen@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103093320.1392256-2-peter.shen@amd.com>

On Mon, Nov 03, 2025 at 05:33:19PM +0800, Peter Shen wrote:
> This patch adds the compatible string for the Facebook Anacapa BMC
> which uses an Aspeed AST2600 SoC. This is required before adding
> the board's device tree source file.
> 
> Signed-off-by: Peter Shen <peter.shen@amd.com>

Still broken email/DCO chain. Run checkpatch BEFORE you send, not after.

Best regards,
Krzysztof


