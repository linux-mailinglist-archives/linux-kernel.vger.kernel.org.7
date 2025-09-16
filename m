Return-Path: <linux-kernel+bounces-819455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBE6B5A0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285865219DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2662D73B9;
	Tue, 16 Sep 2025 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aQEk3/vf"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D92D0C97
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758049465; cv=none; b=kNU9EcZmDIYM3vpt5gAuRJUnKD4nyYwlzV0i4xezDFFW0xmHdP9flZDg/KS+/wJ63WDAg+z4K4tX3dY7jBj1HxdMQnsnFYnBfDfVSoBqq0j/e1njHdeIs3Ope4aAIGjGVn5UAkFKoApDloKbByahP0fb8YwrH2XE4vrwHi9dCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758049465; c=relaxed/simple;
	bh=eVMZ8aJw3wzjCNrVys1HEp1kSdur0B6Zj2ywjbkTItM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCxwNEh3XW3odp4VuxuAFuK7oSrlWO8fAvJIxxS5keAPG/Y0WmNKltHUbeSdZiXcXNHvxGdGMl0pOvPEvsuEokPrH00PRzw440DTF/jz9IrwxC99jeW0eK7ANSjzmuXqoAc1P+xbKGcVFAi84ukW+1FkqV3n74LVyfXhg9WmWA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aQEk3/vf; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d605d4af-69dc-491d-85a3-b1681b89abd7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758049451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HXOAPEjzekOAjE4mciNBEhLhGsM198o+7B85xHhnuzA=;
	b=aQEk3/vfn2molZrZKNuI31cy6yCYMkCI7CiNCMpqf1iPYO5lrulrKVailmopFUznZ86QU7
	tsSsgwMKsfaAuhZf5ARVKNEwUicYVqghTmaaeLua0aGGC7zp4jipiFyRfROryJqLfIEkKh
	XLiC2oDRJgC3dygNGBLNW4+Vblncp8k=
Date: Tue, 16 Sep 2025 20:04:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] libie: fix linking with libie_{adminq,fwlog}
 when CONFIG_LIBIE=n
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>,
 kernel test robot <lkp@intel.com>, Naresh Kamboju
 <naresh.kamboju@linaro.org>, nxne.cnse.osdt.itp.upstreaming@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250916160118.2209412-1-aleksander.lobakin@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250916160118.2209412-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 16/09/2025 17:01, Alexander Lobakin wrote:
> Initially, libie contained only 1 module and I assumed that new modules
> in its folder would depend on it.
> However, Michał did a good job and libie_{adminq,fwlog} are completely
> independent, but libie/ is still traversed by Kbuild only under
> CONFIG_LIBIE != n.
> This results in undefined references with certain kernel configs.
> 
> Tell Kbuild to always descend to libie/ to be able to build each module
> regardless of whether the basic one is enabled.
> If none of CONFIG_LIBIE* is set, Kbuild will just create an empty
> built-in.a there with no side effects.
> 
> Fixes: 641585bc978e ("ixgbe: fwlog support for e610")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202509140606.j8z3rE73-lkp@intel.com
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYvH8d6pJRbHpOCMZFjgDCff3zcL_AsXL-nf5eB2smS8SA@mail.gmail.com
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
> Sending directly to net-next to quickly unbreak net-next and
> linux-next builds.
> Also to net-next as the blamed commit landed recently and is
> not present in any other tree.
> ---
>   drivers/net/ethernet/intel/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/Makefile b/drivers/net/ethernet/intel/Makefile
> index 04c844ef4964..9a37dc76aef0 100644
> --- a/drivers/net/ethernet/intel/Makefile
> +++ b/drivers/net/ethernet/intel/Makefile
> @@ -4,7 +4,7 @@
>   #
>   
>   obj-$(CONFIG_LIBETH) += libeth/
> -obj-$(CONFIG_LIBIE) += libie/
> +obj-y += libie/
>   
>   obj-$(CONFIG_E100) += e100.o
>   obj-$(CONFIG_E1000) += e1000/


Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

