Return-Path: <linux-kernel+bounces-899000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9BCC568C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA58B4F089B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5789330D24;
	Thu, 13 Nov 2025 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uj6/Pi6b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F0C2D73B4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024994; cv=none; b=TOhKXntBC4wTRLzYCI6OmSTIZLVKcKpkD80mCPC026xzU/n5nn1XoyU2tkI9YPsU54FGSNrNXsxtEniTGkLej35wuY5jZHkvlEgiLpnRmLbW2sFANRBe34PqGgYhM3wnKUT475ddI/n4pjONYGjnBoVsoYaj6EnbA2a2v0RKun8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024994; c=relaxed/simple;
	bh=rHmd0rMUHyefZtIXeMVesUbxq18R88JCSA0oFW1Fm0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXsZ6eISDkqZ8Vo5CVOIPjn2ToFKwRqyS5p0qG9Dbn85vqRWcy2uxb0IpjtBn5o/Xp38VxDrZxZTL2r0uy/Nntoi1m1YVL4l6y8q1mg91dJtvrllOsCTpzYKlzqVHk2KuVdnx7ipa5+NCYN/FOSHPEQm47spUzfYDohLgu4XhaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uj6/Pi6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5EDC113D0;
	Thu, 13 Nov 2025 09:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763024993;
	bh=rHmd0rMUHyefZtIXeMVesUbxq18R88JCSA0oFW1Fm0M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uj6/Pi6bfNWw9ZykppZ3qDAZRUlr46B7/demige9vo17lWrcE75ESNOuLgJFYiQjk
	 8u5/IVA5HgmEyMUG83YUQqs8bmhFarX/1SdJofCeyX0Q9i9oA2in1+hNhxxTYal3iJ
	 4DUfJTloVfkqDlg/TPjiWY6my6JLWQ7kUqouZXhXcRJgL4W+YTsqP+Ul0us4XWLP2y
	 2u+zaaLg1iULPBIsBLLCfohBG5bBrdeYMUgA1KgAeWLNktelgyw/NkMK+16ELR/OnI
	 WX+m/WjJd86on3z4csb4zbIydeIC7sQI2P4EmrV17qM5k+XyzsU+vbwhDw1hi00DdL
	 jdKgUbGWYif6w==
Message-ID: <5bdd8b10-171e-4171-a1f2-43c029dfd8e4@kernel.org>
Date: Thu, 13 Nov 2025 10:09:44 +0100
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
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251113051322.1753532-1-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.11.25 06:13, Balbir Singh wrote:
> ret of type vm_fault_t is reused to capture the return value of
> nouveau_dmem_copy_folio(), which returns an int. Use a new copy_ret
> to fix the issue. The issue is not new, prior to this the function
> called was called nouveau_dmem_copy_one() and ret was used to capture
> it's value.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202511121922.oP20Lzb8-lkp@intel.com/

It's a sparse warning, is there any runtime effect?

> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> Cc: Rakie Kim <rakie.kim@sk.com>
> Cc: Byungchul Park <byungchul@sk.com>
> Cc: Gregory Price <gourry@gourry.net>
> Cc: Ying Huang <ying.huang@linux.alibaba.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mika Penttilä <mpenttil@redhat.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Francois Dugast <francois.dugast@intel.com>
> 

Fixes: ? Or is does this just fix a sparse warning and nothing "real" we 
could run into and cause problems?


-- 
Cheers

David

