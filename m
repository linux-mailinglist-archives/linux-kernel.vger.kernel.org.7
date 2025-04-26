Return-Path: <linux-kernel+bounces-621400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0335A9D8E7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 08:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131041C017DB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 06:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110B21E521D;
	Sat, 26 Apr 2025 06:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="j3Y50Rlo"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F601D63CD
	for <linux-kernel@vger.kernel.org>; Sat, 26 Apr 2025 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745650547; cv=none; b=B1ZMcc+mFih3sI2CGe0pW7JbV0kFiVIr8Ho16Ny3M0sXkJEo/L0DjsoPk1THwZf4DpxtggwhbhV3ZciEWIGXoD86OQl77TvzqSXOYWbsoeuNj652CsATFY/i/lCgNugQRG859XGREIlECDUY3uoYSL+IOJkBrN3MDzC84+xGzOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745650547; c=relaxed/simple;
	bh=YtEkNTHUG+n5iHo3EXZNJ4qo4UYkQllu7HZAWLn/jqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDTFC8wwXYd/SzmIbDvtJqS0zI5FM+y9NrOi7u3qM4J/0ZzCXkWbJ1zP+ByP1RLciJSjDgC+yxUW3x0isxRpTs36L4lvmoAM3d8kQcGsWDtkeHv9RnjmGCd+oeFKbEr4niUD5lKQmv6KsScKkQ/MAPpBer7ZoLZVoceLVzlk5Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=j3Y50Rlo; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id 8VlruxuYwMETl8ZRquq4e2; Sat, 26 Apr 2025 06:55:38 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 8ZRouxOtS79Ii8ZRpu3BXV; Sat, 26 Apr 2025 06:55:37 +0000
X-Authority-Analysis: v=2.4 cv=FY0xxo+6 c=1 sm=1 tr=0 ts=680c8369
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=FOH2dFAWAAAA:8 a=maIFttP_AAAA:8 a=iox4zFpeAAAA:8 a=MCMyBeqthVF3y6c2b0kA:9
 a=QEXdDO2ut3YA:10 a=qR24C9TJY6iBuJVj_x8Y:22 a=WzC6qhA0u3u7Ye7llzcV:22
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kBkRlnDp5Hdmm2yE73zuDnhdBvqAkeMGF98g6gosTXE=; b=j3Y50Rlou93+yINb2qrM0pNoFE
	SWsdOKVHichB/jZPJ3XljpzTaseSD+mWbf7y2BRVv5WlhXOIfBUij8SFDuviGBheErbtcnDW0W8uV
	zd+vcRtEdrs6w5NEnAdecsR0ydByiaCXCYd6dwIHnP/Kxy48FgZbYEz4/ioPfbY1Vzw622YNXwOrj
	TEaMlA0ewMXlr6MeUmPXW//lqYu671uX7Ren3XtaC/cGu8jnVa6REO8nEKl4sOxExT7LtJ1jyDfje
	1/LQUoISw7Y5FVqb0DvC9/eJUKsSn2uum6oDDJ6DnnVt22H6syAqHMLaa/ZG2v5zSWHWG5g1ZcUrX
	RHwK7Y+g==;
Received: from [177.238.17.151] (port=30278 helo=[192.168.0.103])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1u8ZRn-000000000fQ-3dXR;
	Sat, 26 Apr 2025 01:55:36 -0500
Message-ID: <4dd1e595-21c2-4a6c-a7b9-e7c945d3a7a2@embeddedor.com>
Date: Sat, 26 Apr 2025 00:55:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: compression: Adjust cb->compressed_folios
 allocation type
To: Kees Cook <kees@kernel.org>, Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250426062328.work.065-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250426062328.work.065-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.17.151
X-Source-L: No
X-Exim-ID: 1u8ZRn-000000000fQ-3dXR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.103]) [177.238.17.151]:30278
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLtrUyZwsqxOVXzAlJ1DEEGrSYUvvgewFOnErwRjLem9Ug7kOjtlG0bvNtDdPcJSlCzQGscKl2ZYruE4zRrbg4xXBD+G0pkYUjmbFkZQPvozN+Yk65EC
 fKf/n2finTPHoq6NVLkIAv1u9xURxuowhk2g/O+wQ1517WtO8wzIMRdv+7CfOz9MVGcqZDkSpdhEXveEi4ivQqCurWuJbJOM+Sh4EW56DvaQzpFDSnsPWLcb



On 26/04/25 00:23, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "struct folio **" but the returned type will be
> "struct page **". These are the same allocation size (pointer size), but
> the types don't match. Adjust the allocation type to match the assignment.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: <linux-btrfs@vger.kernel.org>
> ---
>   fs/btrfs/compression.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index e7f8ee5d48a4..7f11ef559be6 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -606,7 +606,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
>   	free_extent_map(em);
>   
>   	cb->nr_folios = DIV_ROUND_UP(compressed_len, PAGE_SIZE);
> -	cb->compressed_folios = kcalloc(cb->nr_folios, sizeof(struct page *), GFP_NOFS);
> +	cb->compressed_folios = kcalloc(cb->nr_folios, sizeof(struct folio *), GFP_NOFS);

Why not `sizeof(*cb->compressed_folios)` as in other patches? :)

-Gustavo


