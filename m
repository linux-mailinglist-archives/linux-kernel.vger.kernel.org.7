Return-Path: <linux-kernel+bounces-888048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B0CC39AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B776E3BC12A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070FD3093D3;
	Thu,  6 Nov 2025 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SS40bEUp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB983093A6;
	Thu,  6 Nov 2025 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419320; cv=none; b=Dbt9CjCB9DtxSDv4NM/9Na/nmdOcw8yiBjNypOOaGWWYecyq1b0C4ItFQtd1EPQfdf2wEK17A27KvaPG2MIXh9mRzkBLBgyuD7aHJhR7werRckFWpZbUBc2k6mg/gsoxXNoB+qBw+1VBzX2D3tBzL3p8RCdeBdpKdSAo+6W6aY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419320; c=relaxed/simple;
	bh=eTn5QPja5NrAhV8JqfC0hiE3iscC1h08zfLZuhblRmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSKLjvjS81Xero2JUngrkFSGR7CDLLbBRQbR+intCV8vPxf2jqC5Kc3JGL181hyj393zPe/CM1P/2s6aioFV4X6pNEdZ9SoDDhbvRlVc/uFdABz5G7lAF/u2wjNxMwzO39xoOl2Fu+xO+1zOBCpeedBZgIXmD0bk0V1IpHSjUs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SS40bEUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC98C16AAE;
	Thu,  6 Nov 2025 08:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762419319;
	bh=eTn5QPja5NrAhV8JqfC0hiE3iscC1h08zfLZuhblRmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SS40bEUpF/m+ZGjrRg7HIMgt34VuoX6zT/bTzevK+98TnoCw2xl36zwc4RCoTDjmx
	 xkxRNY6oguADuY5pZFvseYqivGr49DXX5WBg9no057TxlxBPPYrvnhJd79C8Bss0k5
	 fbwHMJj4useMfhIQdF13ZpRwyiXQC8iIxXV27T/hQKjs07VEH/Y4uul1P1GHF8IPUT
	 pcqesW99qc9MTMsl4HfaptzBoRSpp4d5OpDUm6V8vbLQ2REWTA/EY2MmYpDjX2+Tv/
	 yYzi3e97M1lNTvIeH+NaebLz6Q8RMry9D7BK5kB2MPyKkz7GzVG8qY7WIlVzwIqEMr
	 Nwecj39toUxrw==
Date: Thu, 6 Nov 2025 09:55:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Enlin Mu <enlin.mu@linux.dev>
Cc: robh@kernel.org, saravanak@google.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, enlin.mu@unisoc.com
Subject: Re: [PATCH] of: print warning when cmdline overflows from bootargs
Message-ID: <20251106-kiwi-of-total-valor-b27f5d@kuoka>
References: <20251105082717.4040-1-enlin.mu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105082717.4040-1-enlin.mu@linux.dev>

On Wed, Nov 05, 2025 at 04:27:17PM +0800, Enlin Mu wrote:
> From: Enlin Mu <enlin.mu@uisoc.com>
> 
> add debug info. sometimes cmdline in dts is too long,

I don't see debug info here.

Please use full sentences, starting with capital letter and ending with
full stop.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597


> developers are not aware of the length limit of the
> cmdline, resulting in some misjudgments.
> 
> Signed-off-by: Enlin Mu <enlin.mu@uisoc.com>
> ---
>  drivers/of/fdt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 0edd639898a6..077799b2f565 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1085,6 +1085,8 @@ int __init early_init_dt_scan_chosen(char *cmdline)
>  	p = of_get_flat_dt_prop(node, "bootargs", &l);
>  	if (p != NULL && l > 0)
>  		strscpy(cmdline, p, min(l, COMMAND_LINE_SIZE));
> +	if (l > COMMAND_LINE_SIZE)
> +		pr_warn("cmdline overflows from bootargs\n");

Why only OF early should have this warning and cmdline passed via ATAGS
or in ACPI system should not?

Best regards,
Krzysztof


