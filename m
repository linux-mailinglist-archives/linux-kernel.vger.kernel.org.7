Return-Path: <linux-kernel+bounces-841831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125EFBB857F
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 00:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D23A4C307E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 22:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEBC2749CB;
	Fri,  3 Oct 2025 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP5+XvuY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8E519007D;
	Fri,  3 Oct 2025 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759531580; cv=none; b=YJ37sSJadLBWeiZa2xmvNP2pNMrEOTCRNyjKpPJiQ1MlGc41HnoyUuZXqBO26/LnchhJyiOWvxnqSO7c5wNaUS1OVNpNlXhF1LtOdaDOfjo8RYbF7IO11MVfgSnjQsH6icr1XEWi56B1Pm9lGcNgmGZ5QwK/O1iE1bGh1jkFCzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759531580; c=relaxed/simple;
	bh=gIBQHcFKcBIdAPga4TBQFjUJoyny6CEqEN/10Zi2Q/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMoUwbDuJRgIKFpXbuwMvnu5fyOoIFkSg9V2k6UWnUQnUutfq4KR1Yiqx/TWb87cy/HbFTQtNcHdDI9rV8gUZr5Czg6tZYSmIbeYkfGFTgHG3NPI7L4ZbayNiirmw/vQjvXtq7Vth2Rm+ji2qLHdGjbS3j4K3jY5iKqklS1yzeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP5+XvuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E8EC4CEF5;
	Fri,  3 Oct 2025 22:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759531579;
	bh=gIBQHcFKcBIdAPga4TBQFjUJoyny6CEqEN/10Zi2Q/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DP5+XvuYagYXLfhO1np7W8ZssxsrnmVjNqaeA42iotzTWHd4wgDv4Vgw0RhRvH5kW
	 5yfTsBxP/a40CGsG66tALqe5NkwrDOGqYoColHYcP96HukTMidPum9k8/85UFa5s9+
	 3tWUJeMy2PjCYcJQ0bVu2IUxG6rmfHnyTdYVFfbe2AHTBJF0Y+8Y/4h+qVhsrHSUZj
	 5UGnleVyfgJ6YXRySNi9YdEIK6IbwmolXo0NK9TKyjd1KgjJL49F8A87zgt3DPGXdI
	 TD3tdCjmspn857+e6tcoL+g54g8UsDnhT0SoO2sClAhhXfJuH6SsAH9yfz7kDOl53a
	 yJ3GO564Kw9jw==
Date: Fri, 3 Oct 2025 15:46:17 -0700
From: Drew Fustini <fustini@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
	Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH v2 2/5] dt-bindings: reset: thead,th1520-reset: Add
 controllers for more subsys
Message-ID: <aOBSOZzOAeelS6Gi@x1>
References: <20250915095331.53350-1-ziyao@disroot.org>
 <20250915095331.53350-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915095331.53350-3-ziyao@disroot.org>

On Mon, Sep 15, 2025 at 09:53:28AM +0000, Yao Zi wrote:
> TH1520 SoC is divided into several subsystems, most of them have
> distinct reset controllers. Let's document reset controllers other than
> the one for VO subsystem and IDs for their reset signals.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>

Thanks for sending these patches.

> ---
>  .../bindings/reset/thead,th1520-reset.yaml    |   8 +-
>  .../dt-bindings/reset/thead,th1520-reset.h    | 216 ++++++++++++++++++
>  2 files changed, 223 insertions(+), 1 deletion(-)
> 
[snip]
> diff --git a/include/dt-bindings/reset/thead,th1520-reset.h b/include/dt-bindings/reset/thead,th1520-reset.h
> index e51d6314d131..68ac52ed69de 100644
> --- a/include/dt-bindings/reset/thead,th1520-reset.h
> +++ b/include/dt-bindings/reset/thead,th1520-reset.h
> @@ -7,6 +7,200 @@
>  #ifndef _DT_BINDINGS_TH1520_RESET_H
>  #define _DT_BINDINGS_TH1520_RESET_H
[snip]
> +/* DSP Subsystem */
> +#define TH1520_RESET_ID_X2X_DSP1	0
> +#define TH1520_RESET_ID_X2X_DSP0	1
> +#define TH1520_RESET_ID_X2X_SLAVE_DSP1	2
> +#define TH1520_RESET_ID_X2X_SLAVE_DSP0	3
> +#define TH1520_RESET_ID_DSP0_CORE	4
> +#define TH1520_RESET_ID_DSP0_DEBUG	5
> +#define TH1520_RESET_ID_DSP0_APB	6
> +#define TH1520_RESET_ID_DSP1_CORE	4
> +#define TH1520_RESET_ID_DSP1_DEBUG	5
> +#define TH1520_RESET_ID_DSP1_APB	6
> +#define TH1520_RESET_ID_DSPSYS_APB	7
> +#define TH1520_RESET_ID_AXI4_DSPSYS_SLV	8
> +#define TH1520_RESET_ID_AXI4_DSPSYS	9
> +#define TH1520_RESET_ID_AXI4_DSP_RS	10

This doesn't seem right. The numbers for each subsystem should not
repeat. Here the DSP0 and DSP1 items have the same numbers: 4, 5, 6.

This causes both clang and sparse to complain. I think you can just
change this so that TH1520_RESET_ID_DSP1_CORE is 7 and so on. The
indexes don't really have any concrete meaning other than how they are
used as unique keys.

The warnings:

  AR      kernel/built-in.a
  CC      drivers/reset/reset-th1520.o
drivers/reset/reset-th1520.c:655:32: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
  655 |         [TH1520_RESET_ID_DSP1_CORE] = {
      |                                       ^
  656 |                 .bit = BIT(12),
      |                 ~~~~~~~~~~~~~~~
  657 |                 .reg = TH1520_DSPSYS_RST_CFG,
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  658 |         },
      |         ~
drivers/reset/reset-th1520.c:643:32: note: previous initialization is here
  643 |         [TH1520_RESET_ID_DSP0_CORE] = {
      |                                       ^
  644 |                 .bit = BIT(8),
      |                 ~~~~~~~~~~~~~~
  645 |                 .reg = TH1520_DSPSYS_RST_CFG,
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  646 |         },
      |         ~
drivers/reset/reset-th1520.c:659:33: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
  659 |         [TH1520_RESET_ID_DSP1_DEBUG] = {
      |                                        ^
  660 |                 .bit = BIT(13),
      |                 ~~~~~~~~~~~~~~~
  661 |                 .reg = TH1520_DSPSYS_RST_CFG,
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  662 |         },
      |         ~
drivers/reset/reset-th1520.c:647:33: note: previous initialization is here
  647 |         [TH1520_RESET_ID_DSP0_DEBUG] = {
      |                                        ^
  648 |                 .bit = BIT(9),
      |                 ~~~~~~~~~~~~~~
  649 |                 .reg = TH1520_DSPSYS_RST_CFG,
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  650 |         },
      |         ~
drivers/reset/reset-th1520.c:663:31: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
  663 |         [TH1520_RESET_ID_DSP1_APB] = {
      |                                      ^
  664 |                 .bit = BIT(14),
      |                 ~~~~~~~~~~~~~~~
  665 |                 .reg = TH1520_DSPSYS_RST_CFG,
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  666 |         },
      |         ~
drivers/reset/reset-th1520.c:651:31: note: previous initialization is here
  651 |         [TH1520_RESET_ID_DSP0_APB] = {
      |                                      ^
  652 |                 .bit = BIT(10),
      |                 ~~~~~~~~~~~~~~~
  653 |                 .reg = TH1520_DSPSYS_RST_CFG,
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  654 |         },
      |         ~
3 warnings generated.
  CHECK   drivers/reset/reset-th1520.c
drivers/reset/reset-th1520.c:643:10: warning: Initializer entry defined twice
drivers/reset/reset-th1520.c:655:10:   also defined here


Thanks,
Drew

