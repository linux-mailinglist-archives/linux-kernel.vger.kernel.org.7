Return-Path: <linux-kernel+bounces-890583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1F0C4068F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFAD3B56F7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9882765C5;
	Fri,  7 Nov 2025 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="WiLhOPCi"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90352322C98
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526495; cv=none; b=oZcNXGlYka6toZ7rjs73cUT+JEO4+vPpxYFcYGOx/gx0PRqvRjIGixjkhV9EpAvwGcp0gHY91iUGPwsw8tKNihFSeWrvGJvz4HXd1dYvt1n6nQ3KjWAregvsFohdLn4Vn784zaJt/N0tPy3Y2Qjc+mi/WLoqBoW/8ah7ZUjOrio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526495; c=relaxed/simple;
	bh=rzx2U3ZPIYKyLywBf1c4Lqbu9Kgk7+2zJBa+iQQn1cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNbfVBUluUhULNBTojr09pdAAdPPGzsGH3BnDCep0JqOr8oz5XNPcyPDOlA973phbaX1uHyUL9GO9MT+9I/2Hjoq2mudjoHUBpUrzcXjPR/jWaWHxgzOCqLnIMlGnNvFX2/DB1TmlkA5250sFQPvnFe50qN900FUFpAVk2stlFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=WiLhOPCi; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1762526491;
 bh=dBnEo9kQFWn16Gia7CBsD427l5/li0reZ07Ety+v/ps=;
 b=WiLhOPCiRjoV0WYthVc32NJdNtuUF5oUUE4n5uA1N4M2nM/Br3QvdOH9+2UejrjCXmbvuAKvL
 E7ckW7fAq5eZQLCbkYZjEiSSrdOAMmD/DNHw8cO0Fcyw/xDxll4Zl+5dWKjU+RZK30NkbQkglBa
 EY+ujzMBuZ9UGdG3xaPvXgv1DUF29HHcLyAyoWwpu9Fmk0gxhHov95CbyipuwIQcvPhkbqJG4Pm
 k54rsVMbCq+DkFFrV8zPUPdl5YuCiBSOE2DqK4s0z/GKLDDnAh/XKL2u2s9fiw21F1/PYwJAwot
 ibA3bV7n6csVxv2VwqVWsTLDMUQuP6sA5ZFjjjLyYUAw==
X-Forward-Email-ID: 690e02ab07551ffa40a0e268
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.4.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3be7a6e4-4025-42b4-a73f-a9d05e64191d@kwiboo.se>
Date: Fri, 7 Nov 2025 15:31:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] dt-bindings: clock, reset: Add support for rv1126b
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, sugar.zhang@rock-chips.com,
 heiko@sntech.de, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 huangtao@rock-chips.com, finley.xiao@rock-chips.com,
 Conor Dooley <conor.dooley@microchip.com>
References: <20251104030633.2721038-1-zhangqing@rock-chips.com>
 <20251104030633.2721038-3-zhangqing@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20251104030633.2721038-3-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Elaine,

On 11/4/2025 4:06 AM, Elaine Zhang wrote:
> Add clock and reset ID defines for rv1126b.
> Also add documentation for the rv1126b CRU core.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/clock/rockchip,rv1126b-cru.yaml  |  52 +++
>  .../dt-bindings/clock/rockchip,rv1126b-cru.h  | 392 +++++++++++++++++
>  .../dt-bindings/reset/rockchip,rv1126b-cru.h  | 405 ++++++++++++++++++
>  3 files changed, 849 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru.yaml
>  create mode 100644 include/dt-bindings/clock/rockchip,rv1126b-cru.h
>  create mode 100644 include/dt-bindings/reset/rockchip,rv1126b-cru.h

[snip]

> diff --git a/include/dt-bindings/clock/rockchip,rv1126b-cru.h b/include/dt-bindings/clock/rockchip,rv1126b-cru.h
> new file mode 100644
> index 000000000000..d6040058c21f
> --- /dev/null
> +++ b/include/dt-bindings/clock/rockchip,rv1126b-cru.h
> @@ -0,0 +1,392 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + * Copyright (c) 2025 Rockchip Electronics Co., Ltd.
> + * Author: Elaine Zhang <zhangqing@rock-chips.com>
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RV1126B_H
> +#define _DT_BINDINGS_CLK_ROCKCHIP_RV1126B_H
> +
> +/* pll clocks */
> +#define PLL_GPLL				1

The clock indices should typically start at 0 not 1.

[snip]

> +#define HCLK_RKRNG_NS				362
> +#define HCLK_RKRNG_S_NS				363
> +#define CLK_AISP_PLL_SRC			364
> +
> +/* secure clks */
> +#define CLK_USER_OTPC_S				400

And the indices should typically not contain any jumps in numbers.

Regards,
Jonas

> +#define CLK_SBPI_OTPC_S				401
> +#define PCLK_OTPC_S				402
> +#define PCLK_KEY_READER_S			403
> +#define HCLK_KL_RKCE_S				404
> +#define HCLK_RKCE_S				405
> +#define PCLK_WDT_S				406
> +#define TCLK_WDT_S				407
> +#define CLK_STIMER0				408
> +#define CLK_STIMER1				409
> +#define PLK_STIMER				410
> +#define HCLK_RKRNG_S				411
> +#define CLK_PKA_RKCE_S				412
> +#define ACLK_RKCE_S				413
> +
> +#endif

[snip]

