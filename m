Return-Path: <linux-kernel+bounces-836548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2E4BA9FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3B03B29A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FBE30C634;
	Mon, 29 Sep 2025 16:15:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA381A255C;
	Mon, 29 Sep 2025 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162556; cv=none; b=lErmTU6q721CaImcYYXLEka+xoCsvixFY1Lk7lHO8B45FQyBddmBgtwPrjMCO7jvHPdNyhpUXlU/urPH7KhYqYwg97sVeCrSh+oWy6dAga1XogFd7XN8EWL3zmIQVDGub265v41iOdlb/PZ/XQo+yT4qOOzlW48iF/wPrqltUGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162556; c=relaxed/simple;
	bh=+M5B+B1LsZ5gx1eHzsSfwmw2uMsbJo7uFUYNNvKn1Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lsz+acO5qPpNk+pjluDVzPBfN0TYfE2o8glzqGM2KGi+H8UA/C52W0QKGrHalRgHT5pO2HAzE2CFcuWcCRdQC8MQzDLc63SXM49ZJaRBLMkH4G11wAYXZyEEqfzXV8tzHsyJm1jIPthJEc5Q/eTrkSu6/jMmdG+oTEYGQy23bD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3019150C;
	Mon, 29 Sep 2025 09:15:44 -0700 (PDT)
Received: from [10.163.64.106] (unknown [10.163.64.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C69F3F66E;
	Mon, 29 Sep 2025 09:15:49 -0700 (PDT)
Message-ID: <51812c42-39bc-42f9-8597-277afe690924@arm.com>
Date: Mon, 29 Sep 2025 21:45:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/mm: Drop pxx_mkdevmap() descriptions from
 page table helpers
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250929120045.1109707-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250929120045.1109707-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 29/09/25 5:30 pm, Anshuman Khandual wrote:
> Remove pxx_mkdevmap() descriptions, as these helper functions have already
> been dropped (including DEBUG_VM_PGTABLE test) via the commit d438d2734170
> ("mm: remove devmap related functions and page table bits").
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   

Reviewed-by: Dev Jain <dev.jain@arm.com>


