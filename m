Return-Path: <linux-kernel+bounces-868938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 578E6C0689F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6EA64F07BA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9749F3191D6;
	Fri, 24 Oct 2025 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtxQh2r1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F7A2DF122
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313168; cv=none; b=E0XQ9xrec9swxxLhAr7mu0/MAnJYnh7ydjKMAxOJk7DuQjyKJnLH0SE0Gbcz0RE2M0Qm36VsyvzaQF5rZdvYhN1awTXONbZYPgLePKVdObFsholZaaQI8BpFWfwcl2qJ0GoyRTzhVkF0V5jykaI1xMu4MKn0/rdZDQ2g9YVOSiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313168; c=relaxed/simple;
	bh=0a2kqt6iVxlZdKDlZmDEyPfN7lXlndVaRP9a7YHS/HI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LvgzWqBiGzufEkFym3QH9vGZqreDqbMrFbbdhBIEnkGqILqGKArNcdKqWXSFNmHvY+SfUj7pkd75fPBYPl+KQeCvnz4cbzYvBUQGZWLRYh1q46+CQFmAyrkV5SrOVWqi4dXtjxxUN8NSKy1ZwJB2HS6Qq9pXJ5nCoCLnANEpXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtxQh2r1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761313165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fG1DHSPbDkPo2/41ZMex3EtNSlx98sY6rv/jsEJLq4g=;
	b=TtxQh2r1NFV3DNZucgm1NsnviSFadvY3LdZhUVZ7KsAjS8BzUhaZMh65XyMBtlhF66RVvD
	NlH9UwAt2DQbxlW+ryzV3+S6bqoT/JgHPzs6gTSzNCJ7LCWNXXijkLs7UuKFD3akK4D4JC
	VGFf/f8UJIIMiw1TzSceKLFySJ6/+FQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-ywVYJffGMz647TzFQJ3pRA-1; Fri, 24 Oct 2025 09:39:21 -0400
X-MC-Unique: ywVYJffGMz647TzFQJ3pRA-1
X-Mimecast-MFC-AGG-ID: ywVYJffGMz647TzFQJ3pRA_1761313160
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b6d752b2891so37534066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761313160; x=1761917960;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fG1DHSPbDkPo2/41ZMex3EtNSlx98sY6rv/jsEJLq4g=;
        b=O/1pX/idlK5mVWiylxGFXlEmCVaQHfWMv3oTNdL7fRwqxyYdP7oqzRcYx74yFFKlg4
         GvNR9nPp7MN08IU7SsG5bCE/kkftNW3lCACJkcl6kuqRM5s1XHg4QfmUzFCeRuj7lcGy
         Xcn7b3z2pPZrPqWq2uN2lBDMvx9XeFcbjpufm+2FCjv/ps02YM2Hlyo8snI9zJEPPjgl
         /nbXqUGkDlKs925Rgv2hZL0kH/OhIo7W/WxzTShshNyURIXBSOKcW2hA1WZUYMmcHrfQ
         Rr0m1iLozEc3iAf3GcokWXzZ/7SYGduntRIdfZDoCJQtnPUHC0qeJ5QGG4xi7eGz+iPc
         Alww==
X-Forwarded-Encrypted: i=1; AJvYcCUUEF4yS2sdYOhkHwwVFuZVko2I7zrzuTQeRb72QUktiZiLCT3DD042SAvSiU4UXuQsCIjVMOpld8t0hpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaRbpZ0MbkASH8OK8LniOb/pYmm/l6Q/7r18CWzkLoEdqzUivF
	B1AawHDoI4D6gA2p17TtnWcWB4mOTR3v5D7W2GhzEgbEyyxIQw2HbYSEWNvn2ECUAUID8wANtMK
	qw9oinU6r44tyy8iRCvA/1GszD5RK3YIda/I4Slyn16uRBa4Hz2NPv5vvOrZutIHYSQ==
X-Gm-Gg: ASbGncvzNFwoRBv6PXOO+9p0zx1gJNx5nr6vejsLZUVBOZoWqDwUg3uprUvYNkGcO9R
	0sYyMNErAJiQuea4wg8cgg6dG2YSfbfGcayAQsXzqIBhmrhm9RFyPCozk86A373ScKoQq5Aet40
	Gwnu5eAj5l87gGrhyemkwdl8a403dXly1F6MTbNYMC7qis+vSlejALzhyeNczuqVDtHoH5+F/Lw
	z/iW9A0ojiu6WWXNzxfJGNhCUdt6rNZ4wiXkggCUEvFgMX54XMmT1Gm7/JY5diHGHpVCzAMGf2R
	uf5uaJysVYR1jLSZ9/ymcnZpYAvxyqhyHjXdFqw3i0SLsecNU/fbI6aKCHH6LgcYvwB5vSgYoT7
	BVLQBjRGiNZzlxX4iP7q56kvehA==
X-Received: by 2002:a17:907:3e90:b0:b3f:ccac:af47 with SMTP id a640c23a62f3a-b6d6ffa8aedmr262717366b.31.1761313159938;
        Fri, 24 Oct 2025 06:39:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1Mowrct2anncqbgqXnkT9wHJ5bHC9THXx7DoXugw/+p5rNYtBxKqachux7PP31bYCorHybA==
X-Received: by 2002:a17:907:3e90:b0:b3f:ccac:af47 with SMTP id a640c23a62f3a-b6d6ffa8aedmr262714066b.31.1761313159376;
        Fri, 24 Oct 2025 06:39:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d514172besm534099066b.46.2025.10.24.06.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 06:39:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6ECCE2EA565; Fri, 24 Oct 2025 15:39:16 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 makita.toshiaki@lab.ntt.co.jp
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 ihor.solodrai@linux.dev, toshiaki.makita1@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net V1 1/3] veth: enable dev_watchdog for detecting
 stalled TXQs
In-Reply-To: <176123157173.2281302.7040578942230212638.stgit@firesoul>
References: <176123150256.2281302.7000617032469740443.stgit@firesoul>
 <176123157173.2281302.7040578942230212638.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 24 Oct 2025 15:39:16 +0200
Message-ID: <877bwkfmgr.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> The changes introduced in commit dc82a33297fc ("veth: apply qdisc
> backpressure on full ptr_ring to reduce TX drops") have been found to cause
> a race condition in production environments.
>
> Under specific circumstances, observed exclusively on ARM64 (aarch64)
> systems with Ampere Altra Max CPUs, a transmit queue (TXQ) can become
> permanently stalled. This happens when the race condition leads to the TXQ
> entering the QUEUE_STATE_DRV_XOFF state without a corresponding queue wake-up,
> preventing the attached qdisc from dequeueing packets and causing the
> network link to halt.
>
> As a first step towards resolving this issue, this patch introduces a
> failsafe mechanism. It enables the net device watchdog by setting a timeout
> value and implements the .ndo_tx_timeout callback.
>
> If a TXQ stalls, the watchdog will trigger the veth_tx_timeout() function,
> which logs a warning and calls netif_tx_wake_queue() to unstall the queue
> and allow traffic to resume.
>
> The log message will look like this:
>
>  veth42: NETDEV WATCHDOG: CPU: 34: transmit queue 0 timed out 5393 ms
>  veth42: veth backpressure stalled(n:1) TXQ(0) re-enable
>
> This provides a necessary recovery mechanism while the underlying race
> condition is investigated further. Subsequent patches will address the root
> cause and add more robust state handling in ndo_open/ndo_stop.
>
> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  drivers/net/veth.c |   16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index a3046142cb8e..7b1a9805b270 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -959,8 +959,10 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  	rq->stats.vs.xdp_packets += done;
>  	u64_stats_update_end(&rq->stats.syncp);
>  
> -	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq)))
> +	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq))) {
> +		txq_trans_cond_update(peer_txq);
>  		netif_tx_wake_queue(peer_txq);
> +	}

Hmm, seems a bit weird that this call to txq_trans_cond_update() is only
in veth_xdp_recv(). Shouldn't there (also?) be one in veth_xmit()?

-Toke


