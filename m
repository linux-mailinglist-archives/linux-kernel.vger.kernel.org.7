Return-Path: <linux-kernel+bounces-847792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D62FBCBBCB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4C319E48D7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 05:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A53F1DE2BD;
	Fri, 10 Oct 2025 05:46:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3C77261A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760075197; cv=none; b=KOwyCvg2DcZHm2kR2aZEqqAhhF7Q6mfc/tUO4QsC4+w/zK4BU75dLiZ7/8QuZrkFnh2FjUMf5r3JTzcvpq/TGIURdEBC/92EgyB9PLUXti8j+MycAIX4nMsycyWzGsskwEBZw2UWMsopcQx9HLJFc80fxXhnYY2v5ZO/R3kfEJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760075197; c=relaxed/simple;
	bh=qVkjKocsgpXxosK6jJVJ+/n4lsJFkOvqwhN8FluemF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QF3qNoPmb38Ro7mRfUiAyTd626y+xtjisq8RaDrCGHAH3dMSTpGIatgNy2J8m2pcovmY3mcRmSpij+cx/KIfDXlkrSYxAr7JxTpMacJQIr+I0ehkAeyxdi1cCEqJJAsWG+MQp1fy7H7054xfL1tB6YXVi39kDaKRW8ibn2C5Qes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E0881596;
	Thu,  9 Oct 2025 22:46:26 -0700 (PDT)
Received: from [10.163.67.91] (unknown [10.163.67.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3D533F738;
	Thu,  9 Oct 2025 22:46:31 -0700 (PDT)
Message-ID: <13c257c7-1ff8-43b4-825b-03a3ceb32e96@arm.com>
Date: Fri, 10 Oct 2025 11:16:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: vmalloc: WARN_ON if mapping size is not PAGE_SIZE
 aligned
To: Yadong Qi <yadong.qi@linux.alibaba.com>, akpm@linux-foundation.org,
 urezki@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ying.huang@linux.alibaba.com
References: <20251010014311.1689-1-yadong.qi@linux.alibaba.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251010014311.1689-1-yadong.qi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/10/25 7:13 am, Yadong Qi wrote:
> In mm/vmalloc.c, the function vmap_pte_range() assumes that the
> mapping size is aligned to PAGE_SIZE. If this assumption is
> violated, the loop will become infinite because the termination
> condition (`addr != end`) will never be met. This can lead to
> overwriting other VA ranges and/or random pages physically follow
> the page table.
>
> It's the caller's responsibility to ensure that the mapping size
> is aligned to PAGE_SIZE. However, the memory corruption is hard
> to root cause. To identify the programming error in the caller
> easier, check whether the mapping size is PAGE_SIZE aligned with
> WARN_ON_ONCE().
>
> Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>
> Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
> ---

This should work.

Reviewed-by: Dev Jain <dev.jain@arm.com>


