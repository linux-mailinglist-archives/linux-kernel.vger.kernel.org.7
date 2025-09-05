Return-Path: <linux-kernel+bounces-802323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE27B45105
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0DEA604E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A232FDC2F;
	Fri,  5 Sep 2025 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="bByfPBbN"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187DE2FD7A5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060000; cv=none; b=SYzTvvMbKXUCv2+xsl9r9TmkIsX3dvAF2RrXYzD+hG+8KWByESQXlAqwAWlDbml3xWlYUcL1VhyKKS3hlPKC/YOo1A1UacHCTQe6EeKhlSa2W9+kt/R2l8ipBAmtjJkH1mCdK+bpJuYvJK8zWRLnbbaSgdv1Jib5WUpunL+w68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060000; c=relaxed/simple;
	bh=4xWVXTWKgL97ndoP/Mc301YaNs/vNcEHPsm0gvEJjM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmUbXVwoPpic5APIMGR4gLivzlAhYcqC1mHlyKPgGWkAn/ip0yjWe91JQ1LXWSzJTLeseOjrlOjtaIYisEHf4hHzct7kaEsQ4iZyRv4SqP1qnJsIKeBk/W8LTnquWDtOtEkdZIqVj8uWhx1i+yeMbftmfn6N3n5YZYArMQz0NIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=bByfPBbN; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cJ8HG1R7Dz9t9S;
	Fri,  5 Sep 2025 10:13:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1757059994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rSnxdvmxv5OZzacM5YRTVKlEc3w6IJ1a52qN8HrYzSs=;
	b=bByfPBbNPy3LOaZu4299ZPvVQcOCGpwTSU3XkwjU9PcEqxl1+jVkVtDr6rOnmsU7mzdGI4
	bZNu3b9jXEUYrWWgupX92Jye4aytaM37Cyi90oLZkLzYvnFIO5pBISZhNOMxMWJTmkRsD0
	ORGzpoQqrRBjS8ZuKZxamSYpjJuHrDRSpt4GbvR6J1BHtgQfX5FWWw73Iwue0GcvXCHVTR
	R9a+t6DyLpSMyisd4QAPQh2VbMlqhKplwKCZs1Fa1VEjg4PoNNszTKsBH2x4y3DGXeyan8
	/L6iF+NKTfZnli0i39FH9ytKTBRCYn7VHA/G4o0/O4U3ZK8OjpEdtcy0/ylh6w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Message-ID: <e8d5eafe-db58-4b78-b029-de6a59fc4fd7@pankajraghav.com>
Date: Fri, 5 Sep 2025 10:13:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] huge_memory: return -EINVAL in folio split functions
 when THP is disabled
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Zi Yan <ziy@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 mcgrof@kernel.org, gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>
References: <20250904095129.222316-1-kernel@pankajraghav.com>
 <2psecfvsd4lbgcm6aflifi2kc6gof345txsvk7wtsytre5ehqt@4wyru36aaeel>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <2psecfvsd4lbgcm6aflifi2kc6gof345txsvk7wtsytre5ehqt@4wyru36aaeel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4cJ8HG1R7Dz9t9S

On 9/4/25 17:26, Kiryl Shutsemau wrote:
> On Thu, Sep 04, 2025 at 11:51:29AM +0200, Pankaj Raghav (Samsung) wrote:
>> From: Pankaj Raghav <p.raghav@samsung.com>
>>
>> split_huge_page_to_list_[to_order](), split_huge_page() and
>> try_folio_split() return 0 on success and error codes on failure.
>>
>> When THP is disabled, these functions return 0 indicating success even
>> though an error code should be returned as it is not possible to split a
>> folio when THP is disabled.
>>
>> Make all these functions return -EINVAL to indicate failure instead of
>> 0. As large folios depend on CONFIG_THP, issue warning as this function
>> should not be called without a large folio.
>>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> 
> Acked-by: Kiryl Shutsemau <kas@kernel.org>
> 
> Just curious, did you give BUILD_BUG() a try?
> 

Yes, I tried BUILD_BUG() but it actually fails the build because truncate_inode_partial_folio()
calls try_folio_split().

It won't be called in runtime because there is a check for large folios before we call this
function. So a runtime warning is better in this case.

--
Pankaj


