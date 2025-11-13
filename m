Return-Path: <linux-kernel+bounces-899280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC94C57441
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFD73A17AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CD63491EB;
	Thu, 13 Nov 2025 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjS7/pAB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5120A21C17D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034629; cv=none; b=mOSh/J71dTuKx9ZgD8pQ18+qocu0fI9NxX5F8Rs0pqEs//pLB1pigpZ94sYdCO9sTYKQbhL1/ez17+Bb62O8M9lBFW90PFt/MJ3l4LJ2dIpF3lHJ5lHxj5OJIGExm2DIYvGYAYcbSVAQiGv97v6Mx4ZAmpLU8z41nxlXzGflA4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034629; c=relaxed/simple;
	bh=Pa2RgIARzCnIXz9o1YbhSbulkMlyeUbZVlsIzcP3LEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AH2R7ceNX3taWHhHT3aRCFf9pXA6I7rrcuWOHsn1OvvqpdIeS9QQwNPClpfRcCC3yv6wsmdmrvyZWYyTLz6HiX8jvfF5b/SPLFGvD5yNvP6ZrIU8eKPS+SMPPofqnffCAJvg1QS0Tt3V/1hyy/khkTkgMY3yp8kuy6grA2lpVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjS7/pAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1B1C4CEF8;
	Thu, 13 Nov 2025 11:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763034628;
	bh=Pa2RgIARzCnIXz9o1YbhSbulkMlyeUbZVlsIzcP3LEg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EjS7/pABfgTH0LGoCqvoiauYcHaLTvT1cJh6jJCD5N5YbrXfRXgYWCRnQ44RDURMj
	 YwxvBMXsr1iaMMEZoWT8XtrvjMzk3FHXfyxC41Yz30zcSY66dtMQF3+FiV/N9LxcDI
	 sPaeqHe4mnqNeJlGpZQ0ZuyrbCeEbYYvZoVZLsEY069KRRpRoEflDWe5FMpKdxkr0q
	 mSlXjQqewIs/TyG3TQSw0rKW9s6nyHDEpuwv4PMGQflPlIcE1qz5kCMHT2+4DmJcVb
	 SN38L/lv2iYz0UnKrcRI1aUJuwES/Y1hFY9xU6HKf5sQuNbCet8Z107wGm6XF8Os2y
	 +HqJ9qqvVXqIg==
Message-ID: <48265d08-df2b-48df-959b-d2ed1407ceca@kernel.org>
Date: Thu, 13 Nov 2025 12:50:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix gpu/drm/nouveau: fix return type in
 nouveau_dmem_migrate_to_ram()
To: Balbir Singh <balbirs@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, dri-devel@lists.freedesktop.org
Cc: kernel test robot <lkp@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20251113051322.1753532-1-balbirs@nvidia.com>
 <5bdd8b10-171e-4171-a1f2-43c029dfd8e4@kernel.org>
 <7d5ff6bf-9e44-41da-a9b9-c5424c569e98@nvidia.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <7d5ff6bf-9e44-41da-a9b9-c5424c569e98@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.11.25 11:31, Balbir Singh wrote:
> On 11/13/25 20:09, David Hildenbrand (Red Hat) wrote:
>> On 13.11.25 06:13, Balbir Singh wrote:
>>> ret of type vm_fault_t is reused to capture the return value of
>>> nouveau_dmem_copy_folio(), which returns an int. Use a new copy_ret
>>> to fix the issue. The issue is not new, prior to this the function
>>> called was called nouveau_dmem_copy_one() and ret was used to capture
>>> it's value.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202511121922.oP20Lzb8-lkp@intel.com/
>>
>> It's a sparse warning, is there any runtime effect?
>>
> 
> No impact really, it's just a sparse warning

Okay, then please

1) Make that clear in the patch description

2) Make that clear in the patch subject.

In particular, the current subject is weird. Should probably be

"nouveau/dmem: fix sparse warning in nouveau_dmem_migrate_to_ram()"

Change itself LGTM, although I would probably call it "int err" or 
something like that instead.

-- 
Cheers

David

