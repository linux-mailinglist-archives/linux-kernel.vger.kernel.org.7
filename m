Return-Path: <linux-kernel+bounces-795914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05FFB3F954
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C0A482F5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DED22EA17A;
	Tue,  2 Sep 2025 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="fFtnC1zW"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2FC2E9EDD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803605; cv=none; b=Y3pld7+toH4A4ttNyZ0BjJNwV/AAy8NBS+8rCSBgwmVBa51vI+SE8FaKpJar+zvjO+xi+uAoZ4IBrO5uRgod3lhcx0i3sjx+RLsDOLKp2YcxyPXhbcOpWoyhBfk53E+dYL7KK0VZOJ4kvOB7r+7ZLASnuno5AgtTj7pr/CyA71w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803605; c=relaxed/simple;
	bh=xNK7ZbJpWHux4rtkInwb0kGP3CRd0QxulbDZD6FxFfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIsFJ+RAM7IUyok4d/G1oZTSMbq3ClivFGTWJoD05cjZ4PS/tKc/OKMfENA/P86FAbI8yKgpkiBdPf6qQw3pid6W5+ikrAUuAJKp1CY5gPR5f/hS6ssX1dcFAdB9s71weun+/lH2aiLjknZ2SBHkTP9+Qaz306qdzNO6UqmhJeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=fFtnC1zW; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cGKSb1P72z9tmC;
	Tue,  2 Sep 2025 10:59:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1756803599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6U/TCetAKMfHaRmR9thC/jSWNiJ+4ewzJjcPKb0o6s=;
	b=fFtnC1zW5WM1bgu/WlqUS/sI0OJC2MxE5x1uHvH6i4fIE165xyzxBv3FdZwJUjiyqLBbxQ
	g4c8bbAwCE/LViX2pTr7zdp4JZzAlFKCMi/fgOaJK0w/t+XCnUY7EfJFqdk+sQU52wNW9h
	40kEKzsONmRYpoT/m3a/rEpxXKETmHtAuLADBYcfnDtO+JXYmmrLXTz6xvHSHSS1EPGbO2
	Ox6+LVfcJIZUKo0hVScj0ulzP4pQHSS/H8y8PiqftQsTBfLMVKUUBzrDHQk9bpW7VllRsk
	PYRSoaoNd1FTzKOOuiwbVAAZrisJGYJJlNefrJvwYKY44e1IfEX0Ne+OldAQhQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Message-ID: <cdbc4c22-7a6f-4c01-8d2b-550b643318d8@pankajraghav.com>
Date: Tue, 2 Sep 2025 10:59:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] huge_memory: return -EINVAL in folio split functions when
 THP is disabled
To: David Hildenbrand <david@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nico Pache <npache@redhat.com>, Zi Yan <ziy@nvidia.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 mcgrof@kernel.org, gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>
References: <20250902084036.208921-1-kernel@pankajraghav.com>
 <1acb705c-4846-4a12-9e90-f7853da8a295@redhat.com>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <1acb705c-4846-4a12-9e90-f7853da8a295@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4cGKSb1P72z9tmC


On 9/2/25 10:43, David Hildenbrand wrote:
> On 02.09.25 10:40, Pankaj Raghav (Samsung) wrote:
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
>> 0.
>>
>> This issue was discovered while experimenting enabling large folios
>> without THP and found that returning 0 in these functions is resulting in
>> undefined behavior in truncate operations. This change fixes the issue.
> 
> Currently large folios that could be split are impossible without THP, so why should this be a fix?
> 
I was debating with myself whether it will classify as a fix or not. I have had people tell me that
I should mention it as fix even though I didn't feel like it ;)

But I agree with you, we can't hit this issue in the upstream kernel. I can remove the fixes tag in
the next version.

--
Pankaj


