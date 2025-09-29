Return-Path: <linux-kernel+bounces-836535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00387BA9F33
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F8FA7A6371
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC3B309F1C;
	Mon, 29 Sep 2025 16:07:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403474A07
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162023; cv=none; b=t/94a9YEnIp2JvfNkdc8HOC2J0tPuOiKb3JDkpd2fRmK8ygmybt4FntHw+KzGoA+pmaZL8RbriQIMIGm0X00PDggu2iavGE3Mmm0AjbfrOT0znkHs2xUbgeCto2AmtPT2bBcl3yWU+PjamPFcaRLqsanA/Z0jySXY+p2HgN0h8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162023; c=relaxed/simple;
	bh=T48nbjbDbZwO80ZUzeyTy0EGVQqM5UxaOEfTGT6zmzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWBbnAUVqNxenqInvs6uLyRo+vlnYRPLYNS/r5mq9EUCS6wviW1TlkFnf8IfUW+Lhv/yjhV8LJnmPAGkqEMmbtvzHYSrwx7seVWbvpTlkWPrfbY8EP5IWmVHgz8Ii6vmClXJAG4DfiYEHeDHkWCySFNElYCypCtEn59ECnIkoS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50D06150C;
	Mon, 29 Sep 2025 09:06:53 -0700 (PDT)
Received: from [10.163.64.106] (unknown [10.163.64.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70CCA3F66E;
	Mon, 29 Sep 2025 09:06:58 -0700 (PDT)
Message-ID: <7cd5bbe1-c2df-4bc3-a06f-4565933d543e@arm.com>
Date: Mon, 29 Sep 2025 21:36:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/thp: Drop follow_devmap_pmd() default stub
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250929104643.1100421-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250929104643.1100421-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 29/09/25 4:16 pm, Anshuman Khandual wrote:
> follow_devmap_pmd() has already been dropped by the commit fd2825b0760a
> ("mm/gup: remove pXX_devmap usage from get_user_pages()"). The fallback
> stub in the header which is now redundant, can be dropped off as well.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   

Reviewed-by: Dev Jain <dev.jain@arm.com>


