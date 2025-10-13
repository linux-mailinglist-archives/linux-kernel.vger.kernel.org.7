Return-Path: <linux-kernel+bounces-851241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2970EBD5E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A23C4EC8CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8072D877C;
	Mon, 13 Oct 2025 19:11:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD2F2D6407;
	Mon, 13 Oct 2025 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382710; cv=none; b=dw6F39wF8nVgwcxTK4xrVtIZpYJIQpa+VVprDLGnAh4VFM2zT+NLPGiryw5J/xHToXiBsHgG5XmSchxB79VmH1mInfp1y9unFeuzwyJ3x+5VFCpSM9smYDootfyzBPU87ixD55Uj3LB/6/hi0e6FoJL3O7eqlCGE+8pXHvbkzXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382710; c=relaxed/simple;
	bh=HE2/MBiEF5dbI9Kn+UQq6dB71bCQB9WlQUqt6LbSF/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XcMgy29F401xohD9WysFaksL4t5ooWs8ng0cBcKNkEsXa3pOfSO8CpvivHiPxmPy9PUIEVjkNev3JNrDknmS6+DwnlN0CyTauRWk/bqoNBMvu/ZIos3R2B7KP6PgkzXwcoJ16KOUpAa90MoJ4LIDq9pcJ9YgF68lyoCjp9Pe2aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABA1C4CEE7;
	Mon, 13 Oct 2025 19:11:49 +0000 (UTC)
Message-ID: <b8e8ab20-d499-4eeb-8a4b-a52d366b3b09@kernel.og>
Date: Mon, 13 Oct 2025 14:11:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] clk: socfpga: agilex5: add clock driver for
 Agilex5
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
 Dinh Nguyen <dinguyen@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>,
 "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Ang Tien Sung <tiensung.ang@altera.com>
References: <cover.1759718838.git.khairul.anuar.romli@altera.com>
 <a4e14e6002d3941fcb918053c1453eb1a757ef49.1759718838.git.khairul.anuar.romli@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.og>
In-Reply-To: <a4e14e6002d3941fcb918053c1453eb1a757ef49.1759718838.git.khairul.anuar.romli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/5/25 22:10, Khairul Anuar Romli wrote:
> Add the new Clock manager driver to support new Agilex5 platform. The new
> driver got rid of the clk_parent_data structures as there are no 'clock-names'
> property in the DT bindings and use parent_names internally. This is based on
> the previous feedback from the maintainer.
> 
> Signed-off-by: Ang Tien Sung <tiensung.ang@altera.com>
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
> Changes in v2:
> 	- Add clk-agilex5 to Makefile
> 	- Add Kconfig to include Agilex5 clock manager
> 	- us of.h instead of of_device and of_address
> 	- use devm_platform_ioremap_resource to simplify the get resource
> 	- Fix bound-checking coverage struct clock_data
> 	- Clean up harmless TODO comment
> ---
>   drivers/clk/socfpga/Kconfig          |   2 +-
>   drivers/clk/socfpga/Makefile         |   2 +-
>   drivers/clk/socfpga/clk-agilex5.c    | 561 +++++++++++++++++++++++++++
>   drivers/clk/socfpga/clk-gate-s10.c   |  53 +++
>   drivers/clk/socfpga/clk-periph-s10.c |  41 ++
>   drivers/clk/socfpga/clk-pll-s10.c    |  36 ++
>   drivers/clk/socfpga/stratix10-clk.h  |  43 ++
>   7 files changed, 736 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/clk/socfpga/clk-agilex5.c
> 


<snip>

> +
> +static int agilex5_clkmgr_init(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct stratix10_clock_data *clk_data;
> +	void __iomem *base;
> +	int i, num_clks;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	num_clks = AGILEX5_NUM_CLKS;
> +
> +	clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
> +				num_clks), GFP_KERNEL);

Please fix these 2 warnings from checkpatch --strict:

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit 
description?)
#7:
Add the new Clock manager driver to support new Agilex5 platform. The 
new driver


CHECK: Alignment should match open parenthesis
#565: FILE: drivers/clk/socfpga/clk-agilex5.c:504:
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
+				num_clks), GFP_KERNEL);


total: 0 errors, 2 warnings, 1 checks, 768 lines check

Dinh

