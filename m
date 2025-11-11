Return-Path: <linux-kernel+bounces-894574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FEAC4B54B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F311890F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2B2346E60;
	Tue, 11 Nov 2025 03:32:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCF7261B77
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831958; cv=none; b=L1C9WvkM+ealYWsN4flR/ldMSor3GdkSLRPlIhXPT4ILT5UrxzZOT8FzO2YobNfaKjIi87QAEk5IlZU2bC+cbCsL7yvxW6D9XSaPZ0V9XM7H7gzgiL1ADPqpV5c4Ouh/VNYoL4Nvq2EkKlIrRBUvMAwjTqYNfTRdfzK6FxmTAuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831958; c=relaxed/simple;
	bh=9yrqPyGC2JrbnSYhHBLz45DR2OjZ74laQo3SvwgYy+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubHrHPAf+bEzGHkhTjurAV9+ExpvB7Wc5/tM0RdFcXe7hQ3zH2r7NFcorPe82wVbF5DVZEJpFolU+BUDik/TyEmG+fKyLPVt1+ES5noVim/+Rn2B8BIPjy7u2xQxZLJX9DribRIc+92uNDzEPilcKDHxhJqN+XNgn/ldtw3YZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A909A2F;
	Mon, 10 Nov 2025 19:32:27 -0800 (PST)
Received: from [10.163.74.35] (unknown [10.163.74.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A62AF3F63F;
	Mon, 10 Nov 2025 19:32:31 -0800 (PST)
Message-ID: <cd05f470-b9ef-4fe7-840a-221dafbb886f@arm.com>
Date: Tue, 11 Nov 2025 09:02:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/ptdesc: Derive from the compound head in page_ptdesc()
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, vishal.moola@gmail.com,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-kernel@vger.kernel.org
References: <20251110063725.3118037-1-anshuman.khandual@arm.com>
 <aRHq4OdBCtC_V0eS@casper.infradead.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <aRHq4OdBCtC_V0eS@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/11/25 7:08 PM, Matthew Wilcox wrote:
> On Mon, Nov 10, 2025 at 06:37:25AM +0000, Anshuman Khandual wrote:
>> struct ptdesc (including all relevant helpers) support multi order compound
>> pages. But page_ptdesc() coverts given page into its own ptdesc rather than
>> deriving from its compound head as would have been expected otherwise. Just
>> change the macro to fetch the struct ptdesc from the compound head instead,
>> so that the same struct ptdesc is reached from all tail pages.
> 
> Please review
> https://lore.kernel.org/linux-mm/20251020001652.2116669-1-willy@infradead.org/
> instead.

Sure, will do. Thanks for the pointer.

