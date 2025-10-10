Return-Path: <linux-kernel+bounces-847784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D2BCBB66
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCFC94E47A4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 05:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF46238C16;
	Fri, 10 Oct 2025 05:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgAYxOm1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ED01E9B3D
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760073939; cv=none; b=nmfN1w92F2pqbAKUR/f7erF7ksRvTz7MIhvJvQRB/XskD7OgnRQMZ9wabUKoBvEutruHLk3Czfq/vVBJPiJmpkCjItfRU8t5AB2EmsxD+Aqage8t+uimh8kvn5yowJ2qyfN266omarzWfx1h9BrnR6PcR82Z8T+fnfRVl+s9z2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760073939; c=relaxed/simple;
	bh=GXluhzyEekuhBdcSbhL8/EI3wLJYUL+QewwbLwip4sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHCEDbpR1Qc0yDMPoazcKLV9EfnMfSgkdXg/cyaKyWBWzvUQFwAScgFd/lwKGrApEFw6bytOf/xBswwSg4lnL47KtzspcF35KgbeBimKLc3fME3IsDU3QHL5l1b7TRsqEolyOmH8p9F81oAThkSp/zpY5o1fPlnYmjP/w5NMUq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgAYxOm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8211C4CEF1;
	Fri, 10 Oct 2025 05:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760073938;
	bh=GXluhzyEekuhBdcSbhL8/EI3wLJYUL+QewwbLwip4sk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IgAYxOm1sGOZIDpRtgR4D53NpFyvNfaHzGRlRa3kp26VUMJlPvi0f/RxocjJAasRS
	 Mxdf+/wSwuij/YWm7MHbzetBO609JQ94ZQl48lwJXnFfWqiK/HagH8RlDrvEK6NdpS
	 LW0mX/B+vVH8Be5yCSleqlDCrCWM63Ewr8OY4B0N8UlX/i/4+vw99W4p6N+iHhQKet
	 giRZY1/4GDhfNmplkzhR3jnmxZnpzFPoapi0iWT1wLZnizq8aoK9/AXZPSMANS1P9d
	 OFRfGYCdBi6DCqlzcZuT9VMDC0347Mwc7bCvUxTK8GfT6olij6tliQdYxoN8uzWvi2
	 ZJ4zfJGzMCahw==
Message-ID: <c39248ad-9adf-471f-a344-762920743d83@kernel.org>
Date: Fri, 10 Oct 2025 14:25:36 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme/tcp: handle tls partially sent records in
 write_space()
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20251010042514.704249-2-wilfred.opensource@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251010042514.704249-2-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/10 13:25, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> With TLS enabled, records that are encrypted and appended to TLS TX
> list can fail to see a retry if the underlying TCP socket is busy, for
> example, hitting an EAGAIN from tcp_sendmsg_locked(). This is not known
> to the NVMe TCP driver, as the TLS layer successfully generated a record.
> 
> Typically, the TLS write_space() callback would ensure such records are
> retried, but in the NVMe TCP Host driver, write_space() invokes
> nvme_tcp_write_space(). This causes a partially sent record in the TLS TX
> list to timeout after not being retried.
> 
> This patch fixes the above by calling queue->write_space(), which calls
> into the TLS layer to retry any pending records.
> 
> Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
> V2:
>     - Unconditionally invoke TLS write_space(). This means we don't need
>       to export tls_is_partially_sent_record()
> ---
> drivers/nvme/host/tcp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1413788ca7d5..6016510577bd 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1079,8 +1079,13 @@ static void nvme_tcp_write_space(struct sock *sk)
>  
>  	read_lock_bh(&sk->sk_callback_lock);
>  	queue = sk->sk_user_data;
> +

White space change... Remove please.

>  	if (likely(queue && sk_stream_is_writeable(sk))) {
>  		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> +		/* Ensure pending TLS partial records are retried */
> +		if (nvme_tcp_queue_tls(queue))
> +			queue->write_space(sk);
> +

Maybe remove this empty line too.

>  		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>  	}
>  	read_unlock_bh(&sk->sk_callback_lock);


-- 
Damien Le Moal
Western Digital Research

