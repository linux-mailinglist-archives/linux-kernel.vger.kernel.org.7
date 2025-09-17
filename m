Return-Path: <linux-kernel+bounces-821331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A446B8100B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DEE168EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D792C29ACEE;
	Wed, 17 Sep 2025 16:28:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4632A229B1F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126488; cv=none; b=Kd8HYjd83Gr/KHUmnTcpFRFk+mTkRUKEil5LPEM8O4Df0A90ed3SQJUlKc6lZjyqLigKch8vBIxb3JMVoFGjH2J/yjGnj6t/x7YSQAqwSPNdYi2brSaEGvouOLw4nlPqIv95a8ngaospnpjhCf+3QRelJyTem/n4h1o2O4iOveg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126488; c=relaxed/simple;
	bh=pebIO8LxpQm+Zj3FiHFYPL6YW0OTGI36pvolWFTfS2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqMfCORc+nfBIgzfbMXTCRVqWuystpZhHZ/CPkJO2viJIROvdypcFdPAYwSQXtpBaMRCU9d5cREyrjH0DNxu2IEL7rKw6CD+GYfxsGXHNLqylp1gKJyAQnB3EDZ9UWGlx687ohaiEhOeH5BQEjtmS4OsbtxaZeJChB9xEaTzlnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 351AF267F;
	Wed, 17 Sep 2025 09:27:57 -0700 (PDT)
Received: from [10.57.80.26] (unknown [10.57.80.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B07303F673;
	Wed, 17 Sep 2025 09:28:03 -0700 (PDT)
Message-ID: <e86e2aa5-c66c-41a9-a56d-74451df0d105@arm.com>
Date: Wed, 17 Sep 2025 17:28:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, Dev Jain <dev.jain@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ard Biesheuvel <ardb@kernel.org>, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <e722e49a-d982-4b58-98f7-6fef3d0a4468@arm.com>
 <dd242f5b-8bbe-48e8-8d5f-be6a835a8841@arm.com>
 <aeb76956-f980-417f-b4e7-fe0503bb5a2b@os.amperecomputing.com>
 <612940d2-4c8e-459c-8d7d-4ccec08fce0a@os.amperecomputing.com>
 <1471ea27-386d-4950-8eaa-8af7acf3c34a@arm.com>
 <f8cf1823-1ee9-4935-9293-86f58a9e2224@arm.com>
 <bf1aa0a4-08de-443f-a1a3-aa6c05bab38c@os.amperecomputing.com>
 <39c2f841-9043-448d-b644-ac96612d520a@os.amperecomputing.com>
 <d7cd4004-bacf-47b0-9cd8-f99125e02238@arm.com>
 <fe52a1d8-5211-4962-afc8-c3f9caf64119@os.amperecomputing.com>
 <8c363997-7b8d-4b54-b9b0-1a1b6a0e58ed@arm.com>
 <4aa4eedc-550f-4538-a499-504dc925ffc2@os.amperecomputing.com>
 <1cfda234-1339-4d83-bd87-b219fbd72664@arm.com>
 <55a79826-48e3-41c0-8dbd-b6398e7e49a6@os.amperecomputing.com>
 <92719b15-daf8-484f-b0db-72e23ae696ad@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <92719b15-daf8-484f-b0db-72e23ae696ad@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yang,

Sorry for the slow reply; I'm just getting back to this...

On 11/09/2025 23:03, Yang Shi wrote:
> Hi Ryan & Catalin,
> 
> Any more concerns about this? 

I've been trying to convince myself that your assertion that all users that set
the VM_FLUSH_RESET_PERMS also call set_memory_*() for the entire range that was
returned my vmalloc. I agree that if that is the contract and everyone is
following it, then there is no problem here.

But I haven't been able to convince myself...

Some examples (these might intersect with examples you previously raised):

1. bpf_dispatcher_change_prog() -> bpf_jit_alloc_exec() -> execmem_alloc() ->
sets VM_FLUSH_RESET_PERMS. But I don't see it calling set_memory_*() for rw_image.

2. module_memory_alloc() -> execmem_alloc_rw() -> execmem_alloc() -> sets
VM_FLUSH_RESET_PERMS (note that execmem_force_rw() is nop for arm64).
set_memory_*() is not called until much later on in module_set_memory(). Another
error in the meantime could cause the memory to be vfreed before that point.

3. When set_vm_flush_reset_perms() is set for the range, it is called before
set_memory_*() which might then fail to split prior to vfree.

But I guess as long as set_memory_*() is never successfully called for a
*sub-range* of the vmalloc'ed region, then for all of the above issues, the
memory must still be RW at vfree-time, so this issue should be benign... I think?

In summary this all looks horribly fragile. But I *think* it works. It would be
good to clean it all up and have some clearly documented rules regardless. But I
think that could be a follow up series.

> Shall we move forward with v8? 

Yes; Do you wnat me to post that or would you prefer to do it? I'm happy to do
it; there are a few other tidy ups in pageattr.c I want to make which I spotted.

> We can include the
> fix to kprobes in v8 or I can send it separately, either is fine to me.

Post it on list, and I'll also incorporate into the series.

> Hopefully we can make v6.18.

It's probably getting a bit late now. Anyway, I'll aim to get v8 out tomorrow or
Friday and we will see what Will thinks.

Thanks,
Ryan

> 
> Thanks,
> Yang
> 

