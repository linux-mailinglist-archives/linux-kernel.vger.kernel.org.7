Return-Path: <linux-kernel+bounces-843026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF34BBE3C5
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA913B74B0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5CC2D46C0;
	Mon,  6 Oct 2025 13:54:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5566A27F19F
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758839; cv=none; b=qbt+kYE/nHJzpPDv41+SpnfIaOkCESoi+wYNvZa5aeUIMwfrAn6ZreyhsRNre7mb8UklifbXCEUJZ1j+VZP0ObwfMl5J+upmWodyX1eXFgIu1tckno1+JrsvSmUMZg7puU73g9cIbH0/uGfghkF6mPMymh9z1fBzR8p24wqOaAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758839; c=relaxed/simple;
	bh=FEJ/8bgV1ek/fE6kHbi9de5agG1iCj5gCnXHtuWr7Hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCVvcsMBL2LLqmR0lVufyFAWuOMJROr6CNNJUNKVI3Mj9leHx0W8cPe6jIyUz5Gg7b3wnqUTR60xZpLgrxEr0f/SJQaPAnDLV4GvVChN9xb6Ibsibl2OtwEiPAVXTNnw/qWiJ/ZAijnKWS3st7fHcQk46K+G2x4sPTYbwJjp+Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AFAE1515;
	Mon,  6 Oct 2025 06:53:47 -0700 (PDT)
Received: from [10.163.66.9] (unknown [10.163.66.9])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECFD03F738;
	Mon,  6 Oct 2025 06:53:50 -0700 (PDT)
Message-ID: <5b6f302e-b2bb-4ad5-a8d5-4e1a8fa2af70@arm.com>
Date: Mon, 6 Oct 2025 19:23:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: Consistently use current->mm in
 mm_get_unmapped_area()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251003155306.2147572-1-ryan.roberts@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251003155306.2147572-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 03/10/25 9:23 pm, Ryan Roberts wrote:
> mm_get_unmapped_area() is a wrapper around arch_get_unmapped_area() /
> arch_get_unmapped_area_topdown(), both of which search current->mm for
> some free space. Neither take an mm_struct - they implicitly operate on
> current->mm.
>
> But the wrapper takes an mm_struct and uses it to decide whether to
> search bottom up or top down. All callers pass in current->mm for this,
> so everything is working consistently. But it feels like an accident
> waiting to happen; eventually someone will call that function with a
> different mm, expecting to find free space in it, but what gets returned
> is free space in the current mm.
>
> So let's simplify by removing the parameter and have the wrapper use
> current->mm to decide which end to start at. Now everything is
> consistent and self-documenting.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>

LGTM

Reviewed-by: Dev Jain <dev.jain@arm.com>

>
>

