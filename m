Return-Path: <linux-kernel+bounces-898810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B403C5611C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCE8B342EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADB232937D;
	Thu, 13 Nov 2025 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bi2blkGl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ED4328B45
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019144; cv=none; b=OCpTfq5SbqpVYt1RIlipGM4PZ0dTjYu/7dIr+M8J1CnKG0m4+/0AbocHyxiQwS3UVgfRO7sUVuGhnaInrsMDXuiU0LGxFUhmKGi/isaC5DWf0N27FTnTzbtjOVgfaoRbQSFWrey9dij3VjPpzOzmBEyfUL6mH6l357OMda18jxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019144; c=relaxed/simple;
	bh=6+s4EmAJUO31C3E6m+fUKs8Q2v9rA00c27ndUGZWmew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMwL2cH2UzorTDdfTPEB/Tq8BXS2oyIxRXHejrkJZjkHYKG3LvljRp3xx7UBzXReTgE7SvMGLllp1mMeQC8EMDjnfMyFGadPIsvC5Z8OIGx9Umz/ypS8byeiEtNvItLR0DNHJei9OQMeu+NiGxZ2Dyye1qcuoAkOeghM0W5on70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bi2blkGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F56BC4CEF7;
	Thu, 13 Nov 2025 07:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763019142;
	bh=6+s4EmAJUO31C3E6m+fUKs8Q2v9rA00c27ndUGZWmew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bi2blkGlg81MeUhv5K542nJxO+2kxzMA7Zp1I77pGmaKBzagsy9OIkW8yJIuOpBkk
	 z1oZ0X/oXTqaHgJeksOr2aHFFeWzlp2ys7jBs74xNaMjIqLBdG3TfyuSvUozgkZlN+
	 1isSDCtOyMmuRSiPOUdWl0DN/sOrx6pGv2HPGbFJBo/UzvoIXDp3ueDaMXwK3c/c4F
	 3ocikKixQH0Bb6JF90QB2Tk1U7lQA/aBd8SjVBXrgqzXQt7uRleP01YEonLDVKbng+
	 A/PvFgbGE3AQuJ9CqgnBlmbXiS8BXO1wkGvejjVMM9RBVA+ZEdNSvR6NLONwE6CsiT
	 CHX67KQjezRvw==
Message-ID: <b02a9217-f2d9-4005-b7ed-6f4198670ba3@kernel.org>
Date: Thu, 13 Nov 2025 08:32:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: softleaf device private fixes in
 remove_migration_pmd()
To: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>
References: <20251112044634.963360-1-balbirs@nvidia.com>
 <20251112044634.963360-2-balbirs@nvidia.com>
 <4e6286a6-721d-45cd-a4ea-e79e90e14fc7@kernel.org>
 <a9c8fd41-66c6-4cb4-a033-4138be701b3f@nvidia.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <a9c8fd41-66c6-4cb4-a033-4138be701b3f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.11.25 06:03, Balbir Singh wrote:
> On 11/12/25 22:37, David Hildenbrand (Red Hat) wrote:
>> On 12.11.25 05:46, Balbir Singh wrote:
>>> commit a6ca2ba46390 ("mm: replace pmd_to_swp_entry() with softleaf_from_pmd()")
>>
>> So should this be squashed into Lorenzo patch, or incorporated in his series in case he has to resend?
>>
>>> does not work with device private THP entries. softleaf_is_migration_young()
>>> asserts that the entry be a migration entry, but in the current code, the
>>> entry might already be replaced by a device private entry by the time the
>>> check is made. The issue exists with commit
>>> 7385dbdbf841 ("mm/rmap: extend rmap and migration support device-private entries")
>>>
>>
>> Because this confuses me. If it's already a problem in the commit-to-go-upstream-first, it should be fixed in that commit?
>>
> 
> Not sure how to handle this, because that would break rebase of mm/mm-new
> or I'd have to send a replacement patch for the original patch from Lorenzo
> (which does not seem right).

Yes, to be expected. Maybe Andrew can figure out how do address the 
rebase, or we can give him a helping hand :)

> 
> I'll post a simpler patch, but it needs to be on top of the series

Agreed, thanks.

-- 
Cheers

David

