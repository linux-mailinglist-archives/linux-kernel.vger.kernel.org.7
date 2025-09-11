Return-Path: <linux-kernel+bounces-812295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4746EB535C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826ED1757D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1289341AC0;
	Thu, 11 Sep 2025 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="luusbQob"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843132BF38
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601345; cv=none; b=DIVN1cS9L+gT45dexvY0WrVpfV6LzqTlZPoHR5LXzeS/eGP486oF6eQ2guqH9GwCDWv0GBo2XIugbNmIqtbV/bYpcQU1kav9iqg4M4RrzqvRh0am6vtVFiEv+ZijROh30JFvVbexTWQrfRq6I9oSijSrKx0Z3nN8HoFb5qnHqW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601345; c=relaxed/simple;
	bh=OZSFRR3m0RcZ0aCctV8DPRcpigMznLiN+vHi2hm6xfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzVSMumC3A58Bcl/zq1Be0Ga0KSGV9dNkR/wl/8MhmbcnAVx6moNp8rGFYcMwLJoNIUEFNEgkNWxH6As2gLiytOopi15rZVLiESLUd/r2bb9cGo3FZGIwmE+Gr86fUY9xj1BmpRzoXHYWsvR/fN+E/KBwK9LSI9ldn6r5SmQkm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=luusbQob; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ca3b4343-f538-4db9-90be-fc9aa2854263@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757601341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXjkB0t5I8EFqUaQRQVUcc6w6ST88EZ7TlVvOqu4u8w=;
	b=luusbQobTnOdzoitzZymP78lbIeTEczsiQ+GuglI0b3NFVMvWV8RI40NM0UoKFe5x2ZElJ
	L2Lr1EguHLWVck8EJLOeIcxx8MWsNrw0+EYRaAtBv1bQcZDt8TSAZ6tGSrAdfFRfViy+BI
	aEcLqUfmXWmKMZ9KcGILYzNXB+clV7E=
Date: Thu, 11 Sep 2025 10:35:37 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] net: xilinx: axienet: Fix kernel-doc warning
 for axienet_free_tx_chain return value
To: Suraj Gupta <suraj.gupta2@amd.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, michal.simek@amd.com, radhey.shyam.pandey@amd.com,
 horms@kernel.org
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, harini.katakam@amd.com
References: <20250911072815.3119843-1-suraj.gupta2@amd.com>
 <20250911072815.3119843-2-suraj.gupta2@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250911072815.3119843-2-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/11/25 03:28, Suraj Gupta wrote:
> Add proper "Return:" section in axienet_free_tx_chain() description.
> The return value description was present in the function description
> but not in the standardized format.
> Move the return value description from the main description to a separate
> "Return:" section to follow Linux kernel documentation standards.
> 
> Fixes below kernel-doc warning:
> warning: No description found for return value of 'axienet_free_tx_chain'
> 
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index ec6d47dc984a..0cf776153508 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -773,7 +773,8 @@ static int axienet_device_reset(struct net_device *ndev)
>   *
>   * Would either be called after a successful transmit operation, or after
>   * there was an error when setting up the chain.
> - * Returns the number of packets handled.
> + *
> + * Return: The number of packets handled.
>   */
>  static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
>  				 int nr_bds, bool force, u32 *sizep, int budget)

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

