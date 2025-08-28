Return-Path: <linux-kernel+bounces-790034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E721DB39E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23D7562207
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FB531062E;
	Thu, 28 Aug 2025 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p4x69p4L"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4E9223DD5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387130; cv=none; b=oiCOFqycKdiwiQ0Utjf/vqNeM14HO/1+coRfs+mCm/xBschFWrfJAaMkZPL8MMU8lwQeR3oxdnDK2HSi/73mMl79M2Bp+/MObS76RBFUAyhjtKSyxvQ9ATIz/zwd4smagLoYgsU+jT8lFnILA1RONurnrakf2oY97XqyJRd9uN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387130; c=relaxed/simple;
	bh=3+fLjvJ6M2nfneyCRPu7oLxAUIvhdsxi9nJsUcgZlL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAre0OPPRhJJXOBwgurTMeQNp7bcMNXSj+kGuRlteg62UeiGGnrxHZHlMHFOY8E2KWfQVCEotBYHVRI5lI+VqvY1CbIZlQyTRvJmesYSOEM5rGQ6IDet67MPrB0DbKxCTqHjEVQketJfuJgbIHdP2PaULqRx5wvRvgWPbJM4UnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p4x69p4L; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <29cbde11-b7bc-4eba-a0ea-b20e4a9ecb79@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756387126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ry9En1+c5A+U28mpyuIa4te1ntjO/Ol6s1tDM1CUBU=;
	b=p4x69p4L4rEm652q4nL6TBN+nI7ENQuX3ucJYGokT1ZfNGL3WYg1pluOS5LMmx9hgcNFCT
	c+/Hi2rvg/r5wtKbbV0LOn1OhHMj/rRxYnp72V7OR5AawUjTPLOG2XDaFUkFCRcUCw8mEk
	JmYk7oY+tcoJ1bAFqnbVlc6SCqxpZIY=
Date: Thu, 28 Aug 2025 14:18:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: igb: expose rx_dropped via ethtool -S
To: Ranganath V N <vnranganath.20@gmail.com>, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
 skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
References: <20250828114209.12020-1-vnranganath.20@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250828114209.12020-1-vnranganath.20@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2025 12:42, Ranganath V N wrote:
> Currently the igb driver does not reports RX dropped
> packets in the ethtool -S statistics output, even though
> this information is already available in struct
> rtnl_link_stats64.
> 
> This patch adds rx_dropped, so users can monitor dropped
> packet counts directly with ethtool.
> 
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> ---
>   drivers/net/ethernet/intel/igb/igb_ethtool.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index 92ef33459aec..3c6289e80ba0 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -81,6 +81,7 @@ static const struct igb_stats igb_gstrings_stats[] = {
>   }
>   static const struct igb_stats igb_gstrings_net_stats[] = {
>   	IGB_NETDEV_STAT(rx_errors),
> +	IGB_NETDEV_STAT(rx_dropped),
>   	IGB_NETDEV_STAT(tx_errors),
>   	IGB_NETDEV_STAT(tx_dropped),
>   	IGB_NETDEV_STAT(rx_length_errors),

This stat is never used in the igb driver, what's the benefit of
constant 0 value in the output?

