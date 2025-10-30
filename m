Return-Path: <linux-kernel+bounces-878201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C7CC2004A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC05462B81
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBAB31BC96;
	Thu, 30 Oct 2025 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0LW+ue8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA662DE6F5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827332; cv=none; b=RYDIRxEFACjZwIzWTVHT4nhXzO3+kj7OHjdaQIYu4AEci5/4S3MxjssFzPQPUmS7u8A3ne5dxvH8m+FaVzBxQBd0RXU0gaJ+UZD1KI53n/yhqz360Tfcs5yJQfqJOj5Ga0peyDfGcl20S/3kHWV2clWII6OSC2IR9bpFMbMgY68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827332; c=relaxed/simple;
	bh=3rsc6ptPvWByOYOhRv+nQJ1v7jnad7jLTGQxU4GRYQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMWGpgxQBsDvFSUaaJuRVkoazFlvs6wgOTKtbSJj2iTYT6eway3HaQqtKDpg7MuKaksRXujwrhDDOBDPLLO/uyrAMYzLy6ykuE7j/i+Rfed7igRzrvfDVR8UZKWqUSA1Y2Y8kaQx1TWurBqfesIR+30TPeu2sEEt0qGjSfw0k+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0LW+ue8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761827329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WMVXs8TQMP3kSanWp9H8RTwHILJeUuZYlKUFoW3Nlw=;
	b=A0LW+ue8xSq37qODwE/SfXSorgI0WFb9q6F0bfaunm3r084Ibu8fbyvgz9rK3LNFyIs9KG
	tJH7n7JHa79HqJCqxEyLoobStESqLnLi2GqwejlFEpq4EqimTAIlMBVyh3NyKCvW5ZO37O
	/dVkacldbuQ62JM35d+J011/iGnR4Dk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-vvSHLEuOMN6AwLtnViXgIg-1; Thu, 30 Oct 2025 08:28:48 -0400
X-MC-Unique: vvSHLEuOMN6AwLtnViXgIg-1
X-Mimecast-MFC-AGG-ID: vvSHLEuOMN6AwLtnViXgIg_1761827327
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4770e0910a1so6741445e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827327; x=1762432127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+WMVXs8TQMP3kSanWp9H8RTwHILJeUuZYlKUFoW3Nlw=;
        b=KDHvEc+Or4qKmDb/XzMahxGIK7dg+6xGrj0yDljv9wYdW7nQfrjvTU8koRyE6gsoV5
         2+APXARzfATyDuTvBLL7sLSq6kZK1TtU4jlhRZzHNVmZFgua91RVEnSoWljdtxpSrg4t
         DkziZ4isYwHe8tf3+FxUhcmHHKFhS4w0flTwpqgBLKLf22feHM7V3bxm8AHNBKtlBx9C
         EHybDI7GvKvS6FY1swA7MDQ6ClGmjZ41zJarUvw44Sb1wEw7TK0s/49sZfgH3b8T/JKw
         Yo1dSiRAB8qmlgEUfvxSHNxTrRt2yVgat8CcQa4efNLPDsizqZllJGsX6N+TqgPhcCqE
         InFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX5cN5WeltmlYGgqnpm3TiCTwOaYsEuKUZ06vTMQ+nMPJaJ50/ZdbfntPes60sJEiuU27PnUrI72LKe00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsKcwDuRdnwhJd/j2ppOpzRvc1C7G32TNYAWKYANbx3tL8h2oA
	GtMKPCTF+4WP7ppqU7pr14pxRSafG9LQcFe/bkty9dhQ5HE/CQ/F9XyzNGRldlL4m44ucidKwWn
	/Q+GifsnvAGdNtB+/9LrXRaO8TWrNFdvFYKJ+gMjz/HbWGxwJOr+7sjBD5mXacaPy9A==
X-Gm-Gg: ASbGncvV2X0LeXmJ/9R2HoAQhmO6XU0N0e28TNLUB3LduPk7/QS/lswuB35XZ2RH0Dm
	AdoRs5I0FPocJGPZMrBuu60M/ttUdkFy49DeldgJ4JDwnRu7rikO8WnxjttJpeD0pXm6kcAIt6h
	GvWOMX83pzRX47iFQ7j+UPQ7rsg4FaJrs7TUVLdgoasuQWtsB7lDyjTmSsQfEZXqzn0rfMbhIsB
	nDQU/S41XJOQXIGnWy49AG+5ccEHUrk7OFAcPt3yjInCiQ8odnB9rUemZI//HDi/aqpfQgpeLH9
	co3nL780I/87x6jwLyM7X34+PLWZ4oKUSbma615LdFDE2edau9FCXAW9o5cKpgUQWKLK/KbB6tv
	BUk2ET5TbuovrivqGngYF7X66spTXz0USU/0J0elXIcin
X-Received: by 2002:a05:600c:4511:b0:477:e66:4082 with SMTP id 5b1f17b1804b1-4771e1ec1d1mr66499305e9.29.1761827326751;
        Thu, 30 Oct 2025 05:28:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQc3JgzM1QEslivftQlK3inQluENUMNYgDE1rjtok3+8IGknzl6HMn3biCdPkc1D7PQaX66g==
X-Received: by 2002:a05:600c:4511:b0:477:e66:4082 with SMTP id 5b1f17b1804b1-4771e1ec1d1mr66498985e9.29.1761827326363;
        Thu, 30 Oct 2025 05:28:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289adc18sm41187325e9.6.2025.10.30.05.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 05:28:45 -0700 (PDT)
Message-ID: <154ebe12-6e3c-4b16-9f55-e10a30f5c989@redhat.com>
Date: Thu, 30 Oct 2025 13:28:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 2/2] veth: more robust handing of race to avoid txq
 getting stuck
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 ihor.solodrai@linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 makita.toshiaki@lab.ntt.co.jp, toshiaki.makita1@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@cloudflare.com
References: <176159549627.5396.15971398227283515867.stgit@firesoul>
 <176159553930.5396.4492315010562655785.stgit@firesoul>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <176159553930.5396.4492315010562655785.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 9:05 PM, Jesper Dangaard Brouer wrote:
> (3) Finally, the NAPI completion check in veth_poll() is updated. If NAPI is
> about to complete (napi_complete_done), it now also checks if the peer TXQ
> is stopped. If the ring is empty but the peer TXQ is stopped, NAPI will
> reschedule itself. This prevents a new race where the producer stops the
> queue just as the consumer is finishing its poll, ensuring the wakeup is not
> missed.

[...]

> @@ -986,7 +979,8 @@ static int veth_poll(struct napi_struct *napi, int budget)
>  	if (done < budget && napi_complete_done(napi, done)) {
>  		/* Write rx_notify_masked before reading ptr_ring */
>  		smp_store_mb(rq->rx_notify_masked, false);
> -		if (unlikely(!__ptr_ring_empty(&rq->xdp_ring))) {
> +		if (unlikely(!__ptr_ring_empty(&rq->xdp_ring) ||
> +			     (peer_txq && netif_tx_queue_stopped(peer_txq)))) {
>  			if (napi_schedule_prep(&rq->xdp_napi)) {
>  				WRITE_ONCE(rq->rx_notify_masked, true);
>  				__napi_schedule(&rq->xdp_napi);

Double checking I'm read the code correctly. The above is supposed to
trigger when something alike the following happens

[producer]				[consumer]
					veth_poll()
					[ring empty]
veth_xmit
  veth_forward_skb
  [NETDEV_TX_BUSY]		
					napi_complete_done()
					
  netif_tx_stop_queue
  __veth_xdp_flush()
  rq->rx_notify_masked == true
					WRITE_ONCE(rq->rx_notify_masked,
						   false);

?

I think the above can't happen, the producer should need to fill the
whole ring in-between the ring check and napi_complete_done().

Am I misreading it?

/P


