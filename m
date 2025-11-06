Return-Path: <linux-kernel+bounces-888689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC012C3B9F4
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6725B4E754D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2005C335067;
	Thu,  6 Nov 2025 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn4OgOPK"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E147A30BBA0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438458; cv=none; b=BK/KjK1xYn6eVRMRFSdnIABYa8mGdWxMqveBPUk8Uc9tySvigh3aZ/LwT8zkfW/cGAwcHeW76XLZc7RHpt830IdmLTSO01gLpp8ghcs8EjbJZCnJcpQg1zol8j8Gr4HgIZa1XeEOgO9NofqwEA7YXA1/UGzRdKZ/8N80ic+1dB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438458; c=relaxed/simple;
	bh=U/AKouqgbPl/F0fdOW+C39rwVERBZcpoopfH3BTj9CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwX+c+QIhDgW5XZhl7NJBUc8TBqltmKiBZ9gPBzCqnNb9mYamrbflQYsb947Vt0/X1zcothSGygcG8f3hS9dTxdRVxbCFwD3CVjcFxZrubDvLXXUe5hRsA7IQ5B4tPlJWzL7tCJ6gFqGQmcKoJVsvclzwbBytulUFMey6E5ZKkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jn4OgOPK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2953e415b27so9955155ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762438456; x=1763043256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72EH5m1JIiQ8HjYUz65OXp9Zw63/fhkgRyPRxQjDTxo=;
        b=Jn4OgOPKRgLDj62PXrzsFsImmbUkS5m2UTPGpXPU9NumtPGQYGnSlTZfIuTvL2XZDe
         ElGv7aMYeFoq9+k+8qZRblvrPdX8ub/6PY3dDDBD7pqxxHOstxjtqosynbGr3yMk5OOE
         n/YC12LEEThowyOiq6CkOoVlPpjqkyL+aIAJEU70G5VTmFb22Zvv3I8sCjRKB9F/Ykcc
         Hqm8cc0ZoxK2coycvPmP1nM8QSNA9F7y7ymqPvBEX/mcruvLprW0inRoEgns1vvuFKoa
         hUZ3Ubd932KKvxNi+bmSw73YKatlfx8cS040R7PQJeyRhPnG3gRhcqpW552a7jzhPSr6
         oWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762438456; x=1763043256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72EH5m1JIiQ8HjYUz65OXp9Zw63/fhkgRyPRxQjDTxo=;
        b=PY+QpwJ5du1ip5GZEI3jlg75WUWVWKrFeRHAJ8k75fnw6Fp0FXYGY6VxpwYk/8iKUQ
         6ersK2vLWNHrZnQthwKx7xGKGNNR+pcdYW7BYvrXIl45L5r2HUdIqDhdAXuJz5j8wM8i
         sf2a1NOljcKDE/KgGaLCtkVyJmV3hHjaEGAu/7HhOxye7m6cm+nTjHs724d9OeZo4hOE
         dk0LPo/9ibYJlnUBIJv9j2BhkIujTyNIaM+HU1LgUb1BeniCMI3NepG9k0g5zmawUu2N
         3ObqQagxGYjZH+RZ/+KT1j5uVTabz2Iu2aF+PXtfVDTzRL6vgSNE4e9iunJddrBkP/H8
         mcyw==
X-Forwarded-Encrypted: i=1; AJvYcCUjsuN9AJlBkzRLlWxfeF+W3tL1ds1gYQjIm5P66mh7Rp/KrGL6ItFTDorW8JxC/tsz4jW3E0FNj7NcEjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRddYWIjqAKV3WQjl/qZEKFmABX+Z/ACc0SPp7MN30RnjUFgyM
	9OQpc9UNFDEESyLKfAaP80nyM8nM33x7yzFgW7O1eMjHowvIXmy8/wQq
X-Gm-Gg: ASbGncsMzFeQmGviZegkTwVQNU7JJ+r0Z2MqZgKxHDGXht7SNAD07XMKqOBnN1rp80m
	6/ohLWAEHjkTeXHl7mtP21R71cpJgoWwrgI4wuavk13oiMEOWCN0x070Ye3KkLjqbTmOnFkMyyZ
	PCBvF0+QhNDVNyzpEsWlDuOvIHVqIXPsdTP6m+k+cHdTPjcXvt1rzbbsFUeaMJPTHtmDRh3oDEe
	Y6e7pVVCQ4SPOVY7pm8PkJIKQr7rzbxkWyBHez3ixMPNH1OcTq58OJG8yWmnN91gf6W2bsNmNuh
	/Ls3zMjtpigW+DfIfdbGIIqeAR9b7mSZh3eAXMJmgzhhbEVUPeJhSMkyIgP1peU7Ep/sm1pQdLV
	gkyac2LahYXBYgdGOsSnwgKBq2T8FiYJoCnIXzsiP/r10gyrgwrXregkjqDIP6iLL1S8lceTkgx
	Hts7bomkZnOd84RTTR93X1LXP3tJReF2r/x3B3w49gQhj/a1J6FItzWTql5k4JP5KLsiQ/2HqX
X-Google-Smtp-Source: AGHT+IEo3lyx4SSF6ocI62uHYt7YAX7f4+Hxtin616U9H0IjwoISSx5SOupuX9cHRYryvyjl4G9V4w==
X-Received: by 2002:a05:6a20:9186:b0:341:c4e5:f626 with SMTP id adf61e73a8af0-34f838e271dmr8901776637.7.1762438456066;
        Thu, 06 Nov 2025 06:14:16 -0800 (PST)
Received: from [192.168.99.24] (i218-47-167-230.s42.a013.ap.plala.or.jp. [218.47.167.230])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7af82208befsm2890508b3a.39.2025.11.06.06.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:14:15 -0800 (PST)
Message-ID: <4abd5327-ccb7-4dbc-9b09-e98069312e2f@gmail.com>
Date: Thu, 6 Nov 2025 23:14:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V3 2/2] veth: more robust handing of race to avoid txq
 getting stuck
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, ihor.solodrai@linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, makita.toshiaki@lab.ntt.co.jp,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@cloudflare.com,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 netdev@vger.kernel.org
References: <176236363962.30034.10275956147958212569.stgit@firesoul>
 <176236369968.30034.1538535221816777531.stgit@firesoul>
Content-Language: en-US
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
In-Reply-To: <176236369968.30034.1538535221816777531.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/11/06 2:28, Jesper Dangaard Brouer wrote:
> Commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to
> reduce TX drops") introduced a race condition that can lead to a permanently
> stalled TXQ. This was observed in production on ARM64 systems (Ampere Altra
> Max).
> 
> The race occurs in veth_xmit(). The producer observes a full ptr_ring and
> stops the queue (netif_tx_stop_queue()). The subsequent conditional logic,
> intended to re-wake the queue if the consumer had just emptied it (if
> (__ptr_ring_empty(...)) netif_tx_wake_queue()), can fail. This leads to a
> "lost wakeup" where the TXQ remains stopped (QUEUE_STATE_DRV_XOFF) and
> traffic halts.
> 
> This failure is caused by an incorrect use of the __ptr_ring_empty() API
> from the producer side. As noted in kernel comments, this check is not
> guaranteed to be correct if a consumer is operating on another CPU. The
> empty test is based on ptr_ring->consumer_head, making it reliable only for
> the consumer. Using this check from the producer side is fundamentally racy.
> 
> This patch fixes the race by adopting the more robust logic from an earlier
> version V4 of the patchset, which always flushed the peer:
> 
> (1) In veth_xmit(), the racy conditional wake-up logic and its memory barrier
> are removed. Instead, after stopping the queue, we unconditionally call
> __veth_xdp_flush(rq). This guarantees that the NAPI consumer is scheduled,
> making it solely responsible for re-waking the TXQ.
>    This handles the race where veth_poll() consumes all packets and completes
> NAPI *before* veth_xmit() on the producer side has called netif_tx_stop_queue.
> The __veth_xdp_flush(rq) will observe rx_notify_masked is false and schedule
> NAPI.
> 
> (2) On the consumer side, the logic for waking the peer TXQ is moved out of
> veth_xdp_rcv() and placed at the end of the veth_poll() function. This
> placement is part of fixing the race, as the netif_tx_queue_stopped() check
> must occur after rx_notify_masked is potentially set to false during NAPI
> completion.
>    This handles the race where veth_poll() consumes all packets, but haven't
> finished (rx_notify_masked is still true). The producer veth_xmit() stops the
> TXQ and __veth_xdp_flush(rq) will observe rx_notify_masked is true, meaning
> not starting NAPI.  Then veth_poll() change rx_notify_masked to false and
> stops NAPI.  Before exiting veth_poll() will observe TXQ is stopped and wake
> it up.
> 
> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Reviewed-by: Toshiaki Makita <toshiaki.makita1@gmail.com>


