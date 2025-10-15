Return-Path: <linux-kernel+bounces-853878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46749BDCCBE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A5B40815B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE8B3126C6;
	Wed, 15 Oct 2025 06:53:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AF421A447
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760511188; cv=none; b=gjgTMC8rP8xZ9OkA8v4kYclQUUU7BSL3Nwqu6MBs4TmvBnRkjpUM+ORKZ4ic+c9Fmf/KUlmbrdslz9BJ9xjHB8OLuzmVJb4DRH8ZPhCMaLxUJy9Xxzs6wTQHI7A7MzRE/lpu+NAxaXPpQN0LUJfTzqIISpxs4OVPR8N2dfnAWsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760511188; c=relaxed/simple;
	bh=+iF4VGasPXgYJvdb/CVqJ/5eoKxrSStgs4Fpr58UwtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4t8YUWHGAPRfkYP59g+Q/JWErIHfKmq5zbAEhLjabFS5V0qz29jOfa8ugxWDsbQWwkC4Cha4aXysFPTPCMf/agX3qv1ZU6GzpF9EnXFFlCAZWllZb/8sDDvHFPixGQ+yqwtv8cM6BoihHW8vwFLACpXhGEyowEPwsfNNq9fwzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AFA21A32;
	Tue, 14 Oct 2025 23:52:58 -0700 (PDT)
Received: from [10.163.67.182] (unknown [10.163.67.182])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 627503F6A8;
	Tue, 14 Oct 2025 23:53:00 -0700 (PDT)
Message-ID: <32ad68ef-a306-4572-9554-7200e06f78e9@arm.com>
Date: Wed, 15 Oct 2025 12:22:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/khugepaged: fix comment for default scan sleep
 duration
To: wang lian <lianux.mm@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Andrea Arcangeli <aarcange@redhat.com>,
 Rik van Riel <riel@redhat.com>, Wei Yang <richard.weiyang@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251015064333.31274-1-lianux.mm@gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251015064333.31274-1-lianux.mm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 15/10/25 12:13 pm, wang lian wrote:
> The comment for khugepaged_scan_sleep_millisecs incorrectly states
> the default scan period is 30 seconds. The actual default value in the
> code is 10000ms (10 seconds).
>
> This patch corrects the comment to match the code, preventing potential
> confusion. The incorrect comment has existed since the feature was
> first introduced.
>
> Fixes: ba76149f47d8 ("thp: khugepaged")
> Signed-off-by: wang lian <lianux.mm@gmail.com>
> ---
>   

Reviewed-by: Dev Jain <dev.jain@arm.com>


