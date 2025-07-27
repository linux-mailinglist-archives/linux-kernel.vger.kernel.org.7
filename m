Return-Path: <linux-kernel+bounces-747131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25984B1301C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7963B93E6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 15:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2344213E6A;
	Sun, 27 Jul 2025 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yWSXGF17"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF8D1E0DE3;
	Sun, 27 Jul 2025 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753630897; cv=none; b=eS8vRk2uHvvJ/EW9PfUQquum9vhw9vbaZCIrndUmS9V6WgJwzjGmkU+U6Mivm6/XlhBf/Dao1xKAxwGoWdmKuBJU4a0g8bgtMCnkXr3WpiIUMBvjh2a0v02anxs+N4FcOZgl+hW9Hjp6CyBRza5ljq3eQqfRYvZw9gJMVD1c2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753630897; c=relaxed/simple;
	bh=fdWsRr76VPxCb1sl1z2gOTjS+byCJ1yMoFJqtEpWYgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1NdTeiroWIn4F2xseu7UnEsmIzOvcrU/FtmJ9K7/m8Ad/er882eUAjjRtj0npGDgr9jQz5ngiMnLJ3287ig9wnnXeaEZEqoTWMSqUfmT+CQT2XkNA7VJOpAcy2mPlo3EwaJFz8q6RjSVuXyaJB/I08/mSorUaSU4S78D7uXY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yWSXGF17; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=d5ryRhpyND7wEhukHccAa9IlpSds5iUzN84/Vv2SGcQ=; b=yWSXGF17nfhsTwPzfkXMnKng+G
	Ca7TNYvp8is2UUWbCdHkcOpGPCEYAJalh+xSrYC2DFYAYxC6l+r//97CaobWk+/G4zd3ss1z1qx7m
	X/O5q8q/R7qiH3xZFDA3+SlcG+DAvP9ben3LkEr7vZg7We60/DVI2IJds2Gm6TQwlIzKvYKh4fiLg
	QPw5+pt5Flj1os1isgRv+OBsehHfJOYiIM2cCLsPNaI4EUfpOzOT3QIAC2QVdzRJkqY4IUe4MluQx
	TiRmnzXeR7UNoZBHTf78499PVy6DX5p7QM3Dv+5TD41WSKr4DJ6DtJkkVESeOG6q9xlNFNlGfCxDT
	kHNqC0Rg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ug3V7-0000000Cs3W-1fxZ;
	Sun, 27 Jul 2025 15:41:25 +0000
Message-ID: <5ac25ceb-023d-409d-8e7e-014d010c5028@infradead.org>
Date: Sun, 27 Jul 2025 08:41:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: powerpc: add htm.rst to toctree
To: Vishal Parmar <vishistriker@gmail.com>, maddy@linux.ibm.com
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 corbet@lwn.net, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20250727110145.839906-1-vishistriker@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250727110145.839906-1-vishistriker@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/27/25 4:01 AM, Vishal Parmar wrote:
> The file Documentation/arch/powerpc/htm.rst is not included in the
> index.rst toctree. This results in a warning when building the docs:
> 
>   WARNING: document isn't included in any toctree: htm.rst
> 
> Add it to the index.rst file so that it is properly included in the
> PowerPC documentation TOC.
> 
> Signed-off-by: Vishal Parmar <vishistriker@gmail.com>

There is a fix is available and scheduled to be merged (when?).

See
https://lore.kernel.org/all/98a8a5ef-45fd-4b1e-a775-d1e1306ad682@linux.ibm.com/


| Yes. I am planning to send it as a fix patch in earliest rc for 6.16.

@Maddy, does that mean during the merge window after 6.16 or as a
merge into 6.16-rcX (which is now)?

Thanks.

> ---
>  Documentation/arch/powerpc/index.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/arch/powerpc/index.rst b/Documentation/arch/powerpc/index.rst
> index 0560cbae5fa1..173a787b6cc3 100644
> --- a/Documentation/arch/powerpc/index.rst
> +++ b/Documentation/arch/powerpc/index.rst
> @@ -36,6 +36,7 @@ powerpc
>      vas-api
>      vcpudispatch_stats
>      vmemmap_dedup
> +    htm
>  
>      features
>  

-- 
~Randy


