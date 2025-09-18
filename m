Return-Path: <linux-kernel+bounces-776578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 621FFB2CF0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FC6621284
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18B5353364;
	Tue, 19 Aug 2025 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPTACsS0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5257335335C;
	Tue, 19 Aug 2025 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755641180; cv=none; b=ZViXQ1PdPbkffc7ht+2GJ/IYtxaZCZ71bKNNzxYC/nVfr0AJXZvMnuzvJJ1874dn+kC08oc5bUGQ2akdtQYxeHUykjVkJEDl52qyZvxY/QBNQ7Xpxf1U4wi1nqn7FnOGOQpw/XFhXLi0pI0u23AKrj6YN6waQrOGU9hB8ppyknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755641180; c=relaxed/simple;
	bh=OTDeCm9HOymxEQNwJGtR9/lrtoizXnTqgK9Gq9TglwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrTxEuaTDhtsMT0R0jW8YyOEllmNhyXs9NH10KpbrZuEZLgnrv2WlLg+UOHLTxqHFIVP0V3TAVN1LLugYTa94TdKNMh83WHby4P3YVb6D/jSpc1h8nRipZe2OpU2zjl0OrBXDRxIdVanxLnvm1tWT9WPtlkAKyXy49MLv1fp4+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPTACsS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39689C4CEF1;
	Tue, 19 Aug 2025 22:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755641178;
	bh=OTDeCm9HOymxEQNwJGtR9/lrtoizXnTqgK9Gq9TglwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPTACsS0wW62fJX4zTMYNM9vIqpAMWOCCRpHaQxqmq2aP+1mai9VnvWwh1+HadAsr
	 O6i0guZrwKMLUhCmNSSUzv6mQhuDNrOsjOrUxtcENZY3lOKHvlqjHR7LozwfxWT4fJ
	 GB2T9HZpcMpwEkgvmAS8KsSOkJe81ZU4wEPlTJCV1X8+SII6gqqv3x1IsEcKeq2/JB
	 2MUvvLDbm16THnCLrRt78gjBr+KHnHNqc1kUq5EIl3X5hCGM8bkdSVFMFccatCm6bU
	 1xr0EbYzN7RXV2GeHjl+Fiu8ZQlR4lROKsvRrCwxr6ab/Y+vxidru2037jQGXyK/DX
	 D3zxrWcO9b2tQ==
Date: Tue, 19 Aug 2025 21:06:14 -0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Jan Dabros <jsd@semihalf.com>, Kohei Ito <ito.kohei@socionext.com>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] i2c: designware: Fix clock issue when PM is
 disabled
Message-ID: <wnoawxh7umtbq2b73f4qpbbbe76b5eluz62g3csmq7k4uw2hnm@exggtdzkeyur>
References: <20250724042211.2160339-1-hayashi.kunihiko@socionext.com>
 <20250724042211.2160339-2-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724042211.2160339-2-hayashi.kunihiko@socionext.com>

Hi Kunihiko,

On Thu, Jul 24, 2025 at 01:22:10PM +0900, Kunihiko Hayashi wrote:
> When removing the driver, enable the clocks once by calling
> pm_runtime_get_sync(), and call pm_runtime_put_sync() to disable
> the clocks.

can we rephrase this to something like:

  When the driver is removed, the clocks are first enabled by
  calling pm_runtime_get_sync(), and then disabled with
  pm_runtime_put_sync().

Does it work?

> If CONFIG_PM=y, clocks for this controller are disabled when it's in
> the idle state. So the clocks are properly disabled when the driver
> exits.
> 
> Othewise, the clocks are always enabled and the PM functions have
> no effect. Therefore, the driver exits without disabling the clocks.
> 
>     # cat /sys/kernel/debug/clk/clk-pclk/clk_enable_count
>     18
>     # echo 1214a000.i2c > /sys/bus/platform/drivers/i2c_designware/bind
>     # cat /sys/kernel/debug/clk/clk-pclk/clk_enable_count
>     20
>     # echo 1214a000.i2c > /sys/bus/platform/drivers/i2c_designware/unbind
>     # cat /sys/kernel/debug/clk/clk-pclk/clk_enable_count
>     20
> 
> To ensure that the clocks can be disabled correctly even without
> CONFIG_PM=y, should add the following fixes:
> 
> - Replace with pm_runtime_put_noidle(), which only decrements the runtime
>   PM usage count.
> - Call i2c_dw_prepare_clk(false) to explicitly disable the clocks.
> 
> Fixes: 7272194ed391f ("i2c-designware: add minimal support for runtime PM")

This commit doesn't look quite right to me, although it's quite
difficult to find the culprit, as the clk api's have changed a
lot over time.

Do you think this is better:

Fixes: b33af11de236 ("i2c: designware: Do not require clock when SSCN and FFCN are provided")

It doesn't matter much as it won't apply in any of the two
versions.

The Fixes tag should be added in both the patches, but there is
no need to resend, I will apply them once we agree on the commit
message.

Andi

