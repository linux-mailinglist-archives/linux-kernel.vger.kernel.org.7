Return-Path: <linux-kernel+bounces-827572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 921C9B921F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AE71898881
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B4131079B;
	Mon, 22 Sep 2025 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV6qaTpd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E449310620;
	Mon, 22 Sep 2025 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557084; cv=none; b=a1vNgof8jzgKCU4SrarrTxp+1IPhkK6ppsxC/vrMsowvyPDzGegYSs7f9VLPJqcbJAjExezQ4anXhXaEjiNg9GwgV+d0Kk7MISLNTYgWtntaZQdiGyfDR9PL3nluZylpkYvkrffkTX9UrbzAvSJLruQ4NtUZG7GUbOtuH5GFxwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557084; c=relaxed/simple;
	bh=j8+H6d+N9dsULNeU+aYEW3KWGEvfUeD2U3M3YFhZX0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaNl3Hp6m417wfc9xuOL7hIDHVyr4ygHIcxYxmdeX5Iir70ruXhLTMCLVluD6LO/kwkdn35rFxcbzhe2BmKk96mHygdAhcFFgHf60tKIFRLrpFXvEMQ6zHV+9wUNJbiUMfNu+M3WfZUt+PjUOX7NnPEwOUnnbd23pbS4FHUv3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV6qaTpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C880EC4CEF0;
	Mon, 22 Sep 2025 16:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758557083;
	bh=j8+H6d+N9dsULNeU+aYEW3KWGEvfUeD2U3M3YFhZX0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BV6qaTpdj8ZlZB++F+0X9FE1SAOjVxZ6TJWOPovFbM7fyQcFy2s1UqH3udVbA3ppc
	 S3/H4Pdl121rg+2w0w9Gsx9fyZAzAPWOy56X+PT0+VQKhFXMpghfsBJusqTVtRXuk7
	 U9Y6gWZTM4kyJg68CGQrK+ToXKzW9DyeEGhnIBwXY+nYQgznWLnpXWhLc9X9Ayk8Pw
	 7QFVyGKnOaQTjjy+cwvSaCbqWSXiXoIzb5qwAGWaBw7CbujMNK/fnkh4rQRJ2YUP+2
	 /WyLR4l01zXFjOQeDkmyRbRbyKRGzPCJTyzPicsmvc9ScxR96fem5HfM1bkbk2MYcG
	 EWOQ3U48Y1RHQ==
Date: Mon, 22 Sep 2025 11:04:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Drew Fustini <fustini@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>, Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>, Conor Dooley <conor+dt@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Han Gao <gaohan@iscas.ac.cn>, Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Guo Ren <guoren@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/5] dt-bindings: reset: thead,th1520-reset: Remove
 non-VO-subsystem resets
Message-ID: <175855708160.137911.10472182890366112328.robh@kernel.org>
References: <20250915095331.53350-1-ziyao@disroot.org>
 <20250915095331.53350-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915095331.53350-2-ziyao@disroot.org>


On Mon, 15 Sep 2025 09:53:27 +0000, Yao Zi wrote:
> Registers in control of TH1520_RESET_ID_{NPU,WDT0,WDT1} belong to AP
> reset controller, not the VO one which is documented as
> "thead,th1520-reset" and is the only reset controller supported for
> TH1520 for now.
> 
> Let's remove the IDs, leaving them to be implemented by AP-subsystem
> reset controller in the future.
> 
> Fixes: 30e7573babdc ("dt-bindings: reset: Add T-HEAD TH1520 SoC Reset Controller")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  include/dt-bindings/reset/thead,th1520-reset.h | 3 ---
>  1 file changed, 3 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


