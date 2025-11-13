Return-Path: <linux-kernel+bounces-899303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B3FC5756D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3618341FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD1D34CFCE;
	Thu, 13 Nov 2025 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQYyO0ey"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C601FF7B3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035657; cv=none; b=YWXr+SArabN1g3DpBXXIToS6Jsarh7/RXWtSpTG3avMBiuke4PUz5nnBKvqayvPKD45Ob90qpf6yb3lGjjuDBJwZNQ0tv22axpluCHB9+ujBEtliivnvb+ZYR7duuf/R43ygbmZ1T+KrpOnXmA6Ku+83N/L0/9cwQ0Tcp+PeYso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035657; c=relaxed/simple;
	bh=vzK+e/EERdiP7f4QpvpjeauHoZUwHHPjc798dHm05QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkHChdOviEMYVqlNU5rgK25DXM6nobq65m2ybKsvoyf7/S7wmyRvK+y/tj/m/udgXAzvysO69KZT7gbS1tfudHHvKwfsKPXjxcgF8SDqgkPmNQutj4L8zeJSBSCKkHsOKsKDnIRPLNSHG8ZdxZyRe75Pf6He3II4R516bL5h+l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQYyO0ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76980C4CEF5;
	Thu, 13 Nov 2025 12:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763035656;
	bh=vzK+e/EERdiP7f4QpvpjeauHoZUwHHPjc798dHm05QE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NQYyO0eyge9WGW2PKiUyuk73zZNfAKP/4yF22e+iiE4+ZoATBpS39Y9dSy2zdmsiE
	 5Al/pFilhBVSHupdRPoEgD7+yr3QfGDxOVhAV13hBA3SIx51DW5L21QdZBLjuJNGLF
	 Cf+k4Oc+D3yp4Uc0OM9b/cnX2BgbM5DRCBQV3LTA/m1dzn3sKBbXdNgk0x7zmf8qjJ
	 RiO4Xi7c9KsGYXWD+J28jnr1E15IwCizP4Go15vpDP3OtmmbVdtQuuhduY76yMCHRi
	 /tHEDf6lp2icY4aJO1D9P1udVnJPj7rn1ND7/QFKA3WvWT1yb1fmMa7OZ3zTG8BUXE
	 BX7Mh9TSvB/IA==
Message-ID: <dd1da795-d37a-47d2-87f5-50853ba43519@kernel.org>
Date: Thu, 13 Nov 2025 13:07:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: fix override of entry in
 remove_migration_pmd
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Balbir Singh <balbirs@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, Andrew Morton <akpm@linux-foundation.org>,
 Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20251113051352.1753714-1-balbirs@nvidia.com>
 <ed523668-92a3-4eaa-a999-4fb7a43e197d@lucifer.local>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <ed523668-92a3-4eaa-a999-4fb7a43e197d@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.11.25 12:56, Lorenzo Stoakes wrote:
> On Thu, Nov 13, 2025 at 04:13:52PM +1100, Balbir Singh wrote:
>> The softleaf changes exposed a BUG in remove_rmap_pmd() where the
>> migration entry was being overridden when the folio is device private.
>>
>> Use scope local entry for creating the device private pmde. Make the
>> pmde writable if the migration entry is writable by moving the check
>> softleaf_is_migration_write() prior to creating the device private entry.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
>> Cc: Rakie Kim <rakie.kim@sk.com>
>> Cc: Byungchul Park <byungchul@sk.com>
>> Cc: Gregory Price <gourry@gourry.net>
>> Cc: Ying Huang <ying.huang@linux.alibaba.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>> Cc: Nico Pache <npache@redhat.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Cc: Barry Song <baohua@kernel.org>
>> Cc: Lyude Paul <lyude@redhat.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Simona Vetter <simona@ffwll.ch>
>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>> Cc: Mika Penttilä <mpenttil@redhat.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Francois Dugast <francois.dugast@intel.com>
>>
>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> 
> THe logic LGTM but we don't want to have a bisect hazard here by having the bug
> introduced earlier then resolved here.

Exactly.

-- 
Cheers

David

