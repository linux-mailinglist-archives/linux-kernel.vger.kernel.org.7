Return-Path: <linux-kernel+bounces-864762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 113EFBFB7AF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DED19C077E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64440328625;
	Wed, 22 Oct 2025 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UwUQ8MOv"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03FD328628
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130458; cv=none; b=TAv2h/EcqOzJyBAlJdv8oAe2ZfoDetWHi1i45XjnyH3cT1S/5RcSM+e+SzLNaKFzDghKKaK10twBqjz9IRrCC72D/W/w1bK22WJ535SkHc0UoBovcv68oKFF1+9wOWj5x1B08j9EFB79jPtBwe58xR4jXxs9blTjfzGqirQuKWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130458; c=relaxed/simple;
	bh=d7jUkFL1eJWTEq7eHvG14dm7yQK74ertjYj/FEO1lbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0xl0MgMym3WLIevJl/+bpZpD3k0J0YmwWa/ShEN46Jmuox3AMjSH+eHS3rt2qvyxq74bP3C2DnhNb1BZEEFUS7ur8ONn3+zobNCn7ZVQiW0bccBfImzH05LHKzOXbouAb4b1x61JDDN2uXswY6NgVFzFeTBCw12QAJrGGr1Bqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UwUQ8MOv; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ef93f062-cee9-46db-ac1e-126257b9cb0c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761130454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7r/FSaphUOIgXSDh2hBB3Nz8pJSiLq/cQZ/SimISKqQ=;
	b=UwUQ8MOv3EbzUvyzYjKh1grzQ9IOXP7RfMcFvIC3nxx1mSx2srYa6xrSpjsMGpr8ADwr3n
	gNZbHDTLs6gNq/VVv8KPDAdvEWzQFj/5ySD1olqZX3mk5j6JST/RT3wa4SFlTJRM6webYk
	l+0NdbFqDJ7gYm7xamcIrENXTemo394=
Date: Wed, 22 Oct 2025 11:54:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v15 3/5] net: rnpgbe: Add basic mbx ops support
To: Dong Yibo <dong100@mucse.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 andrew+netdev@lunn.ch, danishanwar@ti.com, geert+renesas@glider.be,
 mpe@ellerman.id.au, lorenzo@kernel.org, lukas.bulwahn@redhat.com
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251022081351.99446-1-dong100@mucse.com>
 <20251022081351.99446-4-dong100@mucse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251022081351.99446-4-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/10/2025 09:13, Dong Yibo wrote:
> Add fundamental mailbox (MBX) communication operations between PF
> (Physical Function) and firmware for n500/n210 chips
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>   drivers/net/ethernet/mucse/rnpgbe/Makefile    |   4 +-
>   drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  17 +
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  70 +++
>   drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   7 +
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   5 +
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 405 ++++++++++++++++++
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  20 +
>   7 files changed, 527 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
>   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
>   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> 
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

