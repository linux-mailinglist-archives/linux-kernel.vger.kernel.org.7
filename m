Return-Path: <linux-kernel+bounces-807256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFABB4A22C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F91B4E3192
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A066E3074B6;
	Tue,  9 Sep 2025 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="utthIyXj"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D31302759
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399026; cv=none; b=fFN88G+jT/iiAtUs8huSXC1pJbX1Gz+RFX0abMc/eDtBDf6oMMxkA0TYHQTct0wZPXRUebRiu6BSusVPGU1KFouPHKsEArOYyTARw18gBtztj1Oc2vrAUJtcF5rXDsbBNVVdBnVA0oXBEofA6J1dJq2KiqGbF+XvXqqJVI/Mhlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399026; c=relaxed/simple;
	bh=mxjz0iKNKI380CRgY/0z3HS76aIAQcf1zzsSXwi351Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pi9oVtbPQeNlXi4aCSD34sLrd3OKrBIy79+XtaR8n2b/7LR04BCYc3Y/uWmmdwovQkiOj/Bci+/bZ2An4BDKF6Qosdi3V3iIbwNbVWyHmQ/Xz2ebmEgJR/LfeUSMTlgEV34LkojMwWSXMN3yuTMnPQuwDGv3OhOqso0zj5uxIFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=utthIyXj; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757399014; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Z1Wkb174DBn870xlUkeOU+s2jwTcULtI9clHVJAqBRQ=;
	b=utthIyXjxVpqkIxo7LlbHaGI3xG3UsT3/ywyBUc+EwM2MCoPutFLg6r/3nMFKQGd624heBwGTYFV1WkI0K6leowJTTMVxYapJn1TAj2W7nHGRA8tZgs43MFchPfMPxIkzAlXR5vCgjkZ3H+g7BJvNU1y5Ve9ROo0RJi/SO4e8RU=
Received: from 30.74.144.127(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WncsZDS_1757399011 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 14:23:32 +0800
Message-ID: <09420e06-5acb-470a-9eb1-5f35d8b2a6bd@linux.alibaba.com>
Date: Tue, 9 Sep 2025 14:23:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm: skip mlocked THPs that are underused early in
 deferred_split_scan()
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 david@redhat.com
Cc: Liam.Howlett@oracle.com, baohua@kernel.org, dev.jain@arm.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 usamaarif642@gmail.com, ziy@nvidia.com
References: <20250908090741.61519-1-lance.yang@linux.dev>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250908090741.61519-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/8 17:07, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> When we stumble over a fully-mapped mlocked THP in the deferred shrinker,
> it does not make sense to try to detect whether it is underused, because
> try_to_map_unused_to_zeropage(), called while splitting the folio, will not
> actually replace any zeroed pages by the shared zeropage.
> 
> Splitting the folio in that case does not make any sense, so let's not even
> scan to check if the folio is underused.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> v1 -> v2:
>   - Update subject and changelog (per David, thanks!)
>   - https://lore.kernel.org/linux-mm/20250908040713.42960-1-lance.yang@linux.dev
> 
>   mm/huge_memory.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 77f0c3417973..6d99893c18e8 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4183,6 +4183,13 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>   		bool underused = false;
>   
>   		if (!folio_test_partially_mapped(folio)) {
> +			/*
> +			 * See try_to_map_unused_to_zeropage(): we cannot
> +			 * optimize zero-filled pages after splitting an
> +			 * mlocked folio.
> +			 */
> +			if (folio_test_mlocked(folio))
> +				goto next;
>   			underused = thp_underused(folio);
>   			if (!underused)
>   				goto next;


