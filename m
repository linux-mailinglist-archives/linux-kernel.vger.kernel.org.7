Return-Path: <linux-kernel+bounces-798333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 387B0B41C6C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED8B1BA6201
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821302FC874;
	Wed,  3 Sep 2025 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dV+Jylym"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6C2F746C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896817; cv=none; b=k5gzj+XTTWKC8HBwFCAX8GzdvDm6kjWKe13SrJSIuD/p+19WgNm5FId/yFvQkKjYJqYUSfNPXaIn5TtTHlpsHojs/OAzaFpebLhNez1kB1bGQA4P1SnvlyYBWqdYSGE3RjrIYKLMyLLSvl8sFoHawh8s3eetoIKyYnfNmHagXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896817; c=relaxed/simple;
	bh=3e9oVt0w/svBQtWNoWSoYk3mpUNiPpo+o4wpoCKBBe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKlx38co6GFL6SIvWBGERq1d9Pf+CN7BjCylzVIDDtlFRYKms1fDm/QKTy9qoJ1YXocN6RLonmIQXFFaTr2OAoLf+lLe6dm+DqaceCxEa3khmkjoi0+rB4IqaY0Eeikm118RYStwE7L85APhEJhkUyTHSIxnyYfS6jHGD4BqbLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dV+Jylym; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <be2b4af0-838e-4c7c-bae1-e74c027ad8fe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756896803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQM52vi5IgGsePrtSqbX4sI72O+u42u3GT3MlSFzMpU=;
	b=dV+Jylym2s7f47lDo8BasYH0lA1GhWy8yx3RqhGZJt9+WVR18sJk5RGePt/zM5wxUtTy6K
	MeF+RTqpnAjDxD9UNmsKPFucMcZsFB0jRj2dCthaNqSrqdAnTq2m1lVloQqwlqJaDsADue
	58uRJU9LzIIO+Rl6ulAutZLTeUmIsWo=
Date: Wed, 3 Sep 2025 11:53:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v10 3/5] net: rnpgbe: Add basic mbx ops support
To: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
 gustavoars@kernel.org, rdunlap@infradead.org
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250903025430.864836-1-dong100@mucse.com>
 <20250903025430.864836-4-dong100@mucse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250903025430.864836-4-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03/09/2025 03:54, Dong Yibo wrote:
> Initialize basic mbx function.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>   drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
>   drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  16 +
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   3 +
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 393 ++++++++++++++++++
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  25 ++
>   5 files changed, 439 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
>   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> 
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> index 179621ea09f3..f38daef752a3 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> @@ -1,8 +1,11 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright(c) 2020 - 2025 Mucse Corporation. */
>   
> +#include <linux/string.h>

I don't see a reason to have string.h included into rnpgbe_chip.c

> +
>   #include "rnpgbe.h"
>   #include "rnpgbe_hw.h"
> +#include "rnpgbe_mbx.h"

I believe this part has to be done in the previous patch.
Please, be sure that the code can compile after every patch in the
patchset.

