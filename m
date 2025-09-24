Return-Path: <linux-kernel+bounces-830671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F45B9A422
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD0A3AD11E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDF8306B3C;
	Wed, 24 Sep 2025 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vrPqVq5n"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBDA21146C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724383; cv=none; b=HgXVXul+/YHFeMYR7Enz6/OCp4E3zDDL+a3xTVsYRG9QlugTWbONNFaRMBNCeWH6dsPkrwPptKMOCLkaks4Pur4J1b43zCEgN5UElm274tbzjJQybmo3biwsoqfu5qEYASrX3vkDI/Oe113K+t7Iu8RJNXzvCPpYAbX1zbQ9Pvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724383; c=relaxed/simple;
	bh=ZekXIlCHnjNzUhvgAUC9R4R1p5Dc9abTUwGR6ICwmDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AH6WSy7U5yvWRnQTeyMcurhe9+6Tu1nUAVnrnR6Iu5+uDibU14bWYcSrrBJ8ldPgPxWNEf/Sozor9tpCBmHfK29fqCnm4OLb3ZnEdUHYIhlyfCQ2QUMsT8pCQRH3Hs0feKrRCIB4qtQecaN6qbLvZQ77kGYsBFdzaybhTdPuiAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vrPqVq5n; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <98ea9a9e-bc94-4322-b210-64277c00cbe8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758724378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pigf3btXJV2Qy9NfNgzlCWs0SPNMcnN6PDLn4Fh6gjU=;
	b=vrPqVq5n5sEHVf7WDL19ZntapmBXl1XJxD9hEy6ErKEbfJChPG3n4fRNe+a3Z+R+fUgUn4
	MLUij4sNMN65dInrKz5dtuTux65+UaFThydnDBzS2q11qLYGnx7/Zqvx4xz8v1+mrAV0mr
	uuWbKqOuQ6Nvzt0UPvkMiA/CLOmibjQ=
Date: Wed, 24 Sep 2025 07:32:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: linux-next: manual merge of the bpf-next tree with the net-next
 tree
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Amery Hung <ameryhung@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
References: <aNPVsFPIJUbcepia@finisterre.sirena.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <aNPVsFPIJUbcepia@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/24/25 4:27 AM, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the bpf-next tree got a conflict in:
> 
>    include/net/xdp.h
> 
> between commits:
> 
>    1827f773e4168 ("net: xdp: pass full flags to xdp_update_skb_shared_info()")
>    6bffdc0f88f85 ("net: xdp: handle frags with unreadable memory")
> 
> from the net-next tree and commit:
> 
>    8f12d1137c238 ("bpf: Clear pfmemalloc flag when freeing all fragments")
> 
> from the bpf-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc include/net/xdp.h
> index 6fd294fa6841d,f288c348a6c13..0000000000000
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@@ -126,16 -115,11 +126,21 @@@ static __always_inline void xdp_buff_se
>    	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
>    }
>    
>   +static __always_inline void xdp_buff_set_frag_unreadable(struct xdp_buff *xdp)
>   +{
>   +	xdp->flags |= XDP_FLAGS_FRAGS_UNREADABLE;
>   +}
>   +
>   +static __always_inline u32 xdp_buff_get_skb_flags(const struct xdp_buff *xdp)
>   +{
>   +	return xdp->flags;
>   +}
>   +
> + static __always_inline void xdp_buff_clear_frag_pfmemalloc(struct xdp_buff *xdp)
> + {
> + 	xdp->flags &= ~XDP_FLAGS_FRAGS_PF_MEMALLOC;
> + }
> +
>    static __always_inline void
>    xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
>    {

Thanks for the fix and it looks correct. I had noted that in the recent net-next 
pr [1].
https://lore.kernel.org/bpf/20250924050303.2466356-1-martin.lau@linux.dev/

