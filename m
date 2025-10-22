Return-Path: <linux-kernel+bounces-864101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F32BF9E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679AA466DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E157B2877C3;
	Wed, 22 Oct 2025 04:07:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943A926056C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761106021; cv=none; b=Mn8R12owUdyrAtL+lhNuWW+1Jc6yjH10T+/QILWqwCc0GnPCVbqJARXHi9Cgr2vNDQD2AXYsgXCFMfzFy0ouvYQXhgVstR9dB58hdLm0zvCB+vrGyxLRwCT1JTXdNZA7NJj/9OYADl0l53CExsGNVm1LRkuDik2dcqzjh8kOvBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761106021; c=relaxed/simple;
	bh=eDo12jpZfo1MaXqNALR/lKe5SxuZgvzVORvf1Ka/xt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBmplDbmp7s5ZXUtDNf2BvLhJgDGdVUbrh/y/78GXIU39DXPJ35Wymx2YVHu1fUGjyYeVbDYhYgnBofy0PyRqeDlGhcsTz9qmbz+affVPSTvHIIGEoSet6F1jJwijEzI/iG3aWRD9t84r9f4W39MAL+u4w2YqC+Qyo8CnQbnPWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02FBB1063;
	Tue, 21 Oct 2025 21:06:51 -0700 (PDT)
Received: from [10.163.68.114] (unknown [10.163.68.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8581D3F66E;
	Tue, 21 Oct 2025 21:06:54 -0700 (PDT)
Message-ID: <5ba26eec-9b76-4561-bd8c-8798af7b2c15@arm.com>
Date: Wed, 22 Oct 2025 09:36:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2] mm/khugepaged: Factor out common logic in
 [scan,alloc]_sleep_millisecs_store()
To: Leon Hwang <leon.hwang@linux.dev>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251021134431.26488-1-leon.hwang@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251021134431.26488-1-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 21/10/25 7:14 pm, Leon Hwang wrote:
> Both scan_sleep_millisecs_store() and alloc_sleep_millisecs_store()
> perform the same operations: parse the input value, update their
> respective sleep interval, reset khugepaged_sleep_expire, and wake up
> the khugepaged thread.
>
> Factor out this duplicated logic into a helper function
> __sleep_millisecs_store(), and simplify both store functions.
>
> No functional change intended.
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>

Reviewed-by: Dev Jain <dev.jain@arm.com>


