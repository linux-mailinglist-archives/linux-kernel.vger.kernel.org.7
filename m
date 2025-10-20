Return-Path: <linux-kernel+bounces-861289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0ADBF24ED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802D83B9AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC84283C87;
	Mon, 20 Oct 2025 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQeUNVAX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E727AC48;
	Mon, 20 Oct 2025 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976235; cv=none; b=Qrbpr+p+EnFHfq3YU1Zb5a9qx0y08dQIJTygU438YiahWMv/PWdwc2M/evaUPCq/5fyyiD3l4L+Nm6fJXlNEpdO95JDJ9kOw1TR9trwD14Q5jwKeVRpuCFQxFq95MZLuT4okVHOJBqiTXmIIiqhQBGxfjUSOyOKpezgnj9HB4zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976235; c=relaxed/simple;
	bh=PTSBkKOFzjQfn3WycpT5x6OZ24XSKTqM3cXc2NT58hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMZRQoAbHMblyohhlZJpd+Zb1RVNBCVnvU41f/w++KZLAvst961oVwWtBiUfjdRBtWz77lPjW6x+P3aRBHods72rt8M7T3IqpmFqaycnEHGAkETe7AHaHNrdc3iMx0Dmu7LvNYDAlfVwrl5gY2Oc8vF8k/k8i+MTIP1Y43fq+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQeUNVAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F145CC4CEF9;
	Mon, 20 Oct 2025 16:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760976235;
	bh=PTSBkKOFzjQfn3WycpT5x6OZ24XSKTqM3cXc2NT58hw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rQeUNVAXwVMxDa7klmBpKqPkBd0QDMjH3nB7u4DpeXk6dTkTROx3cVWm/iw5r08GS
	 7o9+WV9sHCf5uUvJsf+kEo5IvaYG8kpJoIX4xo5wGh9l4KyGTgtyp1oU+YbAhoex/l
	 REkrSyP1dqTOAP2UeyTMa4BgDCcFbusz8ZYvxqX/Lr1FU4+0bDkv6+BhgWpUxAXnK1
	 vyx25e5V3ibrhZkFJ+/RLVdqX4/ai/mkgMC2o8DMjIFC9zNFjHxbGyUQVdaeEJ0xiy
	 w90i/6s2mBSiwjs+BKcANjMW6UMt96hah6qyg2SrOkxH5VRBGDF+Sk4/OWb4mpmWi6
	 64ul2XvTpqEHg==
Message-ID: <aab92ea9-60a4-43e5-bbee-96484d15f3a7@kernel.org>
Date: Mon, 20 Oct 2025 11:03:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v6 0/4] stratix10: Add framework for asynchronous
 communication with SDM
To: mahesh.rao@altera.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Richard Gong <richard.gong@intel.com>,
 Alan Tull <atull@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Gerlach <matthew.gerlach@altera.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250924-sip_svc_upstream-v6-0-c88ef68bf24e@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250924-sip_svc_upstream-v6-0-c88ef68bf24e@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/24/25 02:39, Mahesh Rao via B4 Relay wrote:
> The patch set includes the following changes:
> 
> - Add protection for querying memory objects in multi-threaded flow.
> - Add support to generate and maintain message id and client id for
>    asynchronous communication with SDM.
> - Add framework to communicate with Secure Device Manager (SDM)
>    asynchronously by sending a request and polling for response.
> - Add commands for performing Remote System Update (RSU) operations
>    asynchronously.
> - Migrate RSU driver to use the asynchronous communication framework.
> 
> ---
> - Link to v6: https://lore.kernel.org/r/20250901-sip_svc_upstream-v6-0-b4db7f07cbb2@altera.com
> 
> Changes in v6:
> - Use guard() helper function for svc_mem_lock.
> - Fixed comment message style according to kernel coding style.
> - Added fixes tag to commit message.
> - Removed id generation patch and use in house ida allocator.
> - Changed lock of hashmap db lock from rcu to spinlock for better latency.
> 
> - Link to v5: https://lore.kernel.org/r/20250708-sip_svc_upstream-v5-0-9c4289256d54@altera.com
> 
> - Link to v5: https://lore.kernel.org/r/20250620-sip_svc_upstream-v5-0-732d4ac08a32@altera.com
> 
> Changes in v5:
> - Use FIELD_PREP, FIELD_GET() and GENMASK() for bit
>    manipulation for ids.
> - Bring down probing when stratix10_svc_async_init()
>    fails.
> - Other minor fixes.
> 
> - Link to v4: https://lore.kernel.org/r/20250610-sip_svc_upstream-v4-0-bcd9d6089071@altera.com
> 
> Changes in v4:
> - Added description for svc_mem_lock mutex.
> - Wrapped commit message and comments in source
>    code to kernel coding style as per coding style.
> - Added minor code fixes.
> - Moved variables to the top of the function
> - Removed HWMON support from in the patch-set, this
>    will be sent in a separate patch-set.
> - Added support for RSU commands to asynchronously
>    communicate with SDM.
> - Migrated RSU driver to use the supported
>    asynchronous commands

Can you please rebase this series on my latest tree:

https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=svc_driver_for_v6.19

Patch 2 is not applying correctly.

Thanks,
Dinh

