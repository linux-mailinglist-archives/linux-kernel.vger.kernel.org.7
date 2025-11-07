Return-Path: <linux-kernel+bounces-890642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF81CC408B0
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C5FB4E9C02
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E1532ABCA;
	Fri,  7 Nov 2025 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="wcFXdihT"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1812D7DFF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762528180; cv=none; b=fnEe6SrJyE+IiUSZvYU36zHDNezyU6AuUSZyKZk0zpErAYIkqlTeOsvvXbp5WYMd3CKw3HHGg+BKUFBhToRXKuebtrcJdNRCZXr269betpZaDt7beqxd08w2DQZAYxzkzqx2PbBZbaAyomYsGPS3jII4yBMXfaV1S+zG0NkefWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762528180; c=relaxed/simple;
	bh=ip6vY1YbgFNzJt16QLuYy3gdeQidUIDJGkzB1m/yE+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cA+cnsBtreE3h/rcc8drrUOktBZ/Z3VW2186WCKJSPGk9NvSwne2Ie3jB8Tg2Wm6b2BBcCOOr43AQ24gkZKK3D5T4oJerMEt5ITEDvxhYAAfUB9RDkVGsIvUT4g/P3GTa/QNu4HxQfe8Li+SqUyPdLSQGfzNGW7CYzrJafmG+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=wcFXdihT; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1762528177;
 bh=JtrOP7D+6cn9NXpGOjOJ8EQlpfaQQ1W6MRTCW9ClTm4=;
 b=wcFXdihThdctWN+lvIfgAcgRJZTzBnla127xgzjKmBp6x6B1AjTdtDXwxsMrbBqqEdpE9ubh3
 Scujx3OuaTICSazdOmTXFvA3hOAqGPG7IE3fiitkDqqgjAgJKDl4QJYLPSKMLwzU4dFQuJXJB19
 rmPLjJlIxfIYvpkZUMs5UUop72CQkf7K6kfKELdY5iDJFaOraPDwOu04jNBtoSVAqI/4otnhx+4
 iR8NYVGfIVW0sjWw/9KSMWxwSdR9PqRWgrkxZLN8IUC2OI/keHocEyWi7NnnFPwQcBGLZ90WxLh
 EToFKF25Ddue0E/HAqDIN7cWqsvk4uRwcMduBNsFhdAQ==
X-Forward-Email-ID: 690e094607551ffa40a0ed33
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.4.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <48108089-775a-428c-8dd1-a75344823ace@kwiboo.se>
Date: Fri, 7 Nov 2025 15:59:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v6 4/5] dt-bindings: clock: rockchip: Add RK3506
 clock and reset unit
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, sugar.zhang@rock-chips.com,
 heiko@sntech.de, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 huangtao@rock-chips.com, finley.xiao@rock-chips.com
References: <20251107013757.5013-1-zhangqing@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20251107013757.5013-1-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Elaine,

On 11/7/2025 2:37 AM, Elaine Zhang wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> Add device tree bindings for clock and reset unit on RK3506 SoC.
> Add clock and reset IDs for RK3506 SoC.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/clock/rockchip,rk3506-cru.yaml   |  51 ++++
>  .../dt-bindings/clock/rockchip,rk3506-cru.h   | 285 ++++++++++++++++++
>  .../dt-bindings/reset/rockchip,rk3506-cru.h   | 211 +++++++++++++
>  3 files changed, 547 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml
>  create mode 100644 include/dt-bindings/clock/rockchip,rk3506-cru.h
>  create mode 100644 include/dt-bindings/reset/rockchip,rk3506-cru.h

[snip]

> diff --git a/include/dt-bindings/reset/rockchip,rk3506-cru.h b/include/dt-bindings/reset/rockchip,rk3506-cru.h
> new file mode 100644
> index 000000000000..f38cc066009b
> --- /dev/null
> +++ b/include/dt-bindings/reset/rockchip,rk3506-cru.h
> @@ -0,0 +1,211 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2023-2025 Rockchip Electronics Co., Ltd.
> + * Author: Finley Xiao <finley.xiao@rock-chips.com>
> + */
> +
> +#ifndef _DT_BINDINGS_REST_ROCKCHIP_RK3506_H
> +#define _DT_BINDINGS_REST_ROCKCHIP_RK3506_H
> +
> +/* CRU-->SOFTRST_CON00 */
> +#define SRST_NCOREPORESET0_AC		0
> +#define SRST_NCOREPORESET1_AC		1
> +#define SRST_NCOREPORESET2_AC		2
> +#define SRST_NCORESET0_AC		3
> +#define SRST_NCORESET1_AC		4
> +#define SRST_NCORESET2_AC		5
> +#define SRST_NL2RESET_AC		6
> +#define SRST_ARESETN_CORE_BIU_AC	7
> +#define SRST_HRESETN_M0_AC		8
> +
> +/* CRU-->SOFTRST_CON02 */
> +#define SRST_NDBGRESET			9
> +#define SRST_PRESETN_CORE_BIU		10
> +#define SRST_RESETN_PMU			11
> +
> +/* CRU-->SOFTRST_CON03 */
> +#define SRST_PRESETN_DBG		12
> +#define SRST_POTRESETN_DBG		13
> +#define SRST_PRESETN_CORE_GRF		14
> +#define SRST_RESETN_CORE_EMA_DETECT	15
> +#define SRST_RESETN_REF_PVTPLL_CORE	16
> +#define SRST_PRESETN_GPIO1		17
> +#define SRST_DBRESETN_GPIO1		18
> +
> +/* CRU-->SOFTRST_CON04 */
> +#define SRST_ARESETN_CORE_PERI_BIU	19
> +#define SRST_ARESETN_DSMC		20
> +#define SRST_PRESETN_DSMC		21
> +#define SRST_RESETN_FLEXBUS		22
> +#define SRST_ARESETN_FLEXBUS		23
> +#define SRST_HRESETN_FLEXBUS		24
> +#define SRST_ARESETN_DSMC_SLV		25
> +#define SRST_HRESETN_DSMC_SLV		26
> +#define SRST_RESETN_DSMC_SLV		27
> +
> +/* CRU-->SOFTRST_CON05 */
> +#define SRST_ARESETN_BUS_BIU		28
> +#define SRST_HRESETN_BUS_BIU		29
> +#define SRST_PRESETN_BUS_BIU		30
> +#define SRST_ARESETN_SYSRAM		31
> +#define SRST_HRESETN_SYSRAM		32
> +#define SRST_ARESETN_DMAC0		33
> +#define SRST_ARESETN_DMAC1		34
> +#define SRST_HRESETN_M0			35
> +#define SRST_RESETN_M0_JTAG		36
> +#define SRST_HRESETN_CRYPTO		37

My original question and your reply from v5 follow below.

On 11/7/2025 2:24 AM, zhangqing wrote:
>> Is there a reason why this (and the RV1126B) reset names now include the
>> RESETN name in all reset constant?
>>
>> For RK3528 and prior mainline SoCs the RESETN part of the name has been
>> striped from the constant, suggest we also strip the RESETN part for
>> RK3506 and RV1126B for consistency with other RK SoCs.
>>
> The current practice is to separate the reset id from the clk id.
> 
> Follow with others RK socs(RK3528、RK3588、RK3576.....)

and

On 11/7/2025 2:44 AM, zhangqing wrote:
> The reset id and rst-rk3506.c were automatically generated from our trm 
> using tools, while some of the previous chips were filled in manually.
> 
> It is not recommended to manually modify the content generated by the 
> tool to avoid unnecessary errors.
> 
> It is not necessary to change SRST_HRESETN_CRYPTO to SRST_H_CRYPTO.

Why do we now need to have two part of the indices name to represent it
is a reset, i.e. the SRST_ prefix and the RESETN in middle of the name.

	resets = <&cru SRST_ARESETN_MAC1>;

The example above seem unnecessary verbose with 3x reset:
- resets as prop name
- SRST_ prefix (software? reset) in the indices name
- RESETN in the indices name

Maybe the SRST_ prefix could be dropped if we now have RESETN as part of
the indices name?

Your tool could be updated to strip the verbose naming. For RK3528 I
used a small script/tool to strip away the RESETN name and to generate
the macros used in rst driver.

Regards,
Jonas

[snip]

