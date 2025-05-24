Return-Path: <linux-kernel+bounces-661846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6E7AC319C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 23:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481951899738
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 22:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9477C27E7EF;
	Sat, 24 May 2025 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YylkEkDr"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2CF1DF258
	for <linux-kernel@vger.kernel.org>; Sat, 24 May 2025 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748123977; cv=none; b=jzYdOE4Jwb1W9Es3fHwxvEhouAoKrLvzPUUv9XpnM3rjRPa/3l4KfuAgqLPhz1hqwM3sjekFxefsWyesYGZlsIUKU6gJlFKjSWSogykUkiQCvvkFPOCOgzWrwpk61hYOWpVyEm5VceiFnhXJ2UHpeB3XfQ+OTYehELr7t4x0pZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748123977; c=relaxed/simple;
	bh=QprXBk0rj2kYUMPGVy8G0AZB6RTubNigaHYE0IxY3t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEzRQJAXyghOdIamYvmDaXqhQE3MAnFTo8C/wsY1QOXK3Ydj2kVYYNe5MvgBxxdY8QUU3WEss6eS7GYArGjGgJ0BGZ5woDrH6y9t1ZNqDSEbqFZwCAFfJ1x6sxZtqFQhp/QAdSUzbdDb5haKy8OWY4Q1QDhJVImcPddLcKGfMyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YylkEkDr; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3ca312c2-6749-45a8-b971-2cd0a1a0781a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748123972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MEtYIWCVhDrjslbC4nxHIooXXCWroqZxwKZTkbsJhGk=;
	b=YylkEkDriN38aO4t0bPeu+FI67hMmXuW/Lri5urUwYECRpDs95q5qVxD5oFDaKkRU/mK4E
	ZbaAw4krBfJFdXZbewBOBYzqV3T208OLTOU4tnkWK+Sf5SgO4e6bm690dnpi5Q3CQ1twfp
	XTYcb4GOMGjUJJHH0TflptfEY8xFH2I=
Date: Sat, 24 May 2025 22:59:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 6/8] gve: Add rx hardware timestamp expansion
To: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jeroendb@google.com, andrew+netdev@lunn.ch,
 willemb@google.com, ziweixiao@google.com, pkaligineedi@google.com,
 yyd@google.com, joshwash@google.com, shailend@google.com, linux@treblig.org,
 thostet@google.com, jfraker@google.com, richardcochran@gmail.com,
 jdamato@fastly.com, horms@kernel.org, linux-kernel@vger.kernel.org
References: <20250522235737.1925605-1-hramamurthy@google.com>
 <20250522235737.1925605-7-hramamurthy@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250522235737.1925605-7-hramamurthy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/05/2025 00:57, Harshitha Ramamurthy wrote:
> From: John Fraker <jfraker@google.com>
> 
> Allow the rx path to recover the high 32 bits of the full 64 bit rx
> timestamp.
> 
> Use the low 32 bits of the last synced nic time and the 32 bits of the
> timestamp provided in the rx descriptor to generate a difference, which
> is then applied to the last synced nic time to reconstruct the complete
> 64-bit timestamp.
> 
> This scheme remains accurate as long as no more than ~2 seconds have
> passed between the last read of the nic clock and the timestamping
> application of the received packet.
> 
> Signed-off-by: John Fraker <jfraker@google.com>
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

