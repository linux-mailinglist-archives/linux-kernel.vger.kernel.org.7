Return-Path: <linux-kernel+bounces-874313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA54DC16017
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0B6234D5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B608133DEE8;
	Tue, 28 Oct 2025 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZE3ezo2a"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA53C16DC28
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670700; cv=none; b=M2nzN3/M9cGcV6eH3oBED+rdccjcjIWbbfTIn3r05FzDSPntJQ8XoLzy4efRAnfrItDrEUkx1fVcx9Q6MKP3XEq/e8fzRjXXEY7+T6Vy+fmUJWakFeHyaF9p66mJ6RD3b3lDAHOl/bqDtITJrUxPAYSjoL2osbnFMBE7Ol+0014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670700; c=relaxed/simple;
	bh=aoFLmVyoMCMr76vl3NiHOrxx9PXBKoqcT8Cci/Dm5qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDJZcE2Btl86bNrLmIn6KE5HevxybmioCScG2DOWxOfQnQdXf3o5Hb2mYgxo7GbSVvrk6l9VQOij21tSVhRl21DaRVibexBt5SgZ+wCdmTc5UH8pQPRJ8Sm0srT8FxMVv4cP5/eHr2oUyQ+bgCi3MKix6PgDtRLVIt9qS6dPxks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZE3ezo2a; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <058529d6-01f7-48f8-8030-e62b95b9a45e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761670695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhhuV960WKiGx2T1AygxtReZoOMMVm0CZ8E13jhoQyU=;
	b=ZE3ezo2aXcfAMQ7h44hBctUxmd++Y82Yr9YZ5/g2DtnYyzSJf4aKQGD8JCoB7jNVN4H34v
	z+P0NP/vUfSWOBsiNk6Ol/8GqSVBn9zuwCRyrGNi18GVCv1cYhRoddb6rncMDwfce1SdSF
	oqvB0GPi6b/axRTMkDPEhOZWp1UYH4c=
Date: Wed, 29 Oct 2025 00:57:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] codetag: debug: Handle existing CODETAG_EMPTY in
 mark_objexts_empty for slabobj_ext
To: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
References: <20251027085214.184672-1-hao.ge@linux.dev>
 <CAJuCfpF+0ok85A1ZhbptSzrB-X6CUj=TMj9ZvwzjV1tO5PqFbA@mail.gmail.com>
 <d1456749-46c3-463f-bc28-f465b8ce6ff9@linux.dev>
 <CAJuCfpFJHE-VAOgKfoXJA+V-okvgQt_iEEUdvd4ZCaARFiWExA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpFJHE-VAOgKfoXJA+V-okvgQt_iEEUdvd4ZCaARFiWExA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

HI Suren


On 2025/10/29 00:19, Suren Baghdasaryan wrote:
> On Mon, Oct 27, 2025 at 6:31 PM Hao Ge <hao.ge@linux.dev> wrote:
>> Hi Suren
>>
>>
>> On 2025/10/28 03:44, Suren Baghdasaryan wrote:
>>> On Mon, Oct 27, 2025 at 1:53 AM Hao Ge <hao.ge@linux.dev> wrote:
>>>> From: Hao Ge <gehao@kylinos.cn>
>>>>
>>>> Even though obj_exts was created with the __GFP_NO_OBJ_EXT flag,
>>>> objects in the same slab may have their extensions allocated via
>>>> alloc_slab_obj_exts, and handle_failed_objexts_alloc may be called
>>>> within alloc_slab_obj_exts to set their codetag to CODETAG_EMPTY.
>>>>
>>>> Therefore, both NULL and CODETAG_EMPTY are valid for the codetag of
>>>> slabobj_ext, as we do not need to re-set it to CODETAG_EMPTY if it
>>>> is already CODETAG_EMPTY. It also resolves the warning triggered when
>>>> the codetag is CODETAG_EMPTY during slab freeing.
>>> I'm not sure what scenario leads to handle_failed_objexts_alloc() and
>>> mark_objexts_empty() being used against the same codetag reference.
>>> Could you please explain the exact scenario you hit?
>>>
>>> handle_failed_objexts_alloc() assigns CODETAG_EMPTY to the elements of
>>> the obj_exts vector while mark_objexts_empty() assigns CODETAG_EMPTY
>>> to the obj_ext of the obj_exts vector itself. In what case do these
>>> two calls operate on the same reference?
>> This issue also occurred during our memory stress testing.
>>
>> I apologize for the incorrect description in my commit message:
>>
>> The possibility of its occurrence should be as follows:
>>
>> When a slab allocates a slabobj_ext, the slab to which this slabobj_ext
>> belongs may have already allocated its own slabobj_ext
>>
>> and called handle_failed_objexts_alloc. That is to say, the codetag of
>> this slabobj_ext has been set to CODETAG_EMPTY.
> Ah, ok. Let's see if I understood this correctly. The slab from which
> slabobj_ext objects are allocated (let's call it slabA) tries to
> allocate its own slabobj_ext, fails, then succeeds and calls
> handle_failed_objexts_alloc() which sets all elements of its
> slabA->obj_exts[] to CODETAG_EMPTY. Then slabobj_ext object is
> allocated from slabA with __GFP_NO_OBJ_EXT, therefore it leaves
> slabA->obj_exts[obj_idx] intact and equal to CODETAG_EMPTY instead of
> NULL. At this point, slabB->obj_exts points to an object in slabA.
> When slabB is freed and free_slab_obj_exts() gets called to free
> slabB->obj_exts, it detects that slabA->obj_exts[obj_idx] is not NULL
> and generates this warning. In your callstack stack the freeing seems
> to happen inside kmem_cache_alloc_noprof() and I think that's because
> we lost the race and freeing the vector we allocated here:
> https://elixir.bootlin.com/linux/v6.18-rc3/source/mm/slub.c#L2165 but
> the scenario is pretty much the same as if we didn't lose the race.
> The warning would happen later on I think, when we would be freeing
> slabB->obj_exts. The key for reproducing this is to fail allocation
> for a slab that is used to allocate slabobj_ext objects. Is my
> understanding correct?


Yes, your explanation is extremely detailed and thorough.


> BTW, your fix seems fine to me, I just want to understand the scenario
> so that we can explain it correctly.
>
>> To quickly detect this WARN, I modified the code
>> from:WARN_ON(slab_exts[offs].ref.ct) to WARN_ON(slab_exts[offs].ref.ct
>> == 1);
>>
>> We then obtained this message:
>>
>> [21630.898561] ------------[ cut here ]------------
>> [21630.898596] kernel BUG at mm/slub.c:2050!
>> [21630.898611] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>> [21630.900372] Modules linked in: squashfs isofs vfio_iommu_type1
>> vhost_vsock vfio vhost_net vmw_vsock_virtio_transport_common vhost tap
>> vhost_iotlb iommufd vsock binfmt_misc nfsv3 nfs_acl nfs lockd grace
>> netfs tls rds dns_resolver tun brd overlay ntfs3 exfat btrfs
>> blake2b_generic xor xor_neon raid6_pq loop sctp ip6_udp_tunnel
>> udp_tunnel nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
>> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
>> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
>> nf_tables rfkill ip_set sunrpc vfat fat joydev sg sch_fq_codel nfnetlink
>> virtio_gpu sr_mod cdrom drm_client_lib virtio_dma_buf drm_shmem_helper
>> drm_kms_helper drm ghash_ce backlight virtio_net virtio_blk virtio_scsi
>> net_failover virtio_console failover virtio_mmio dm_mirror
>> dm_region_hash dm_log dm_multipath dm_mod fuse i2c_dev virtio_pci
>> virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring autofs4
>> aes_neon_bs aes_ce_blk [last unloaded: hwpoison_inject]
>> [21630.909177] CPU: 3 UID: 0 PID: 3787 Comm: kylin-process-m Kdump:
>> loaded Tainted: G        W           6.18.0-rc1+ #74 PREEMPT(voluntary)
>> [21630.910495] Tainted: [W]=WARN
>> [21630.910867] Hardware name: QEMU KVM Virtual Machine, BIOS unknown
>> 2/2/2022
>> [21630.911625] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS
>> BTYPE=--)
>> [21630.912392] pc : __free_slab+0x228/0x250
>> [21630.912868] lr : __free_slab+0x18c/0x250[21630.913334] sp :
>> ffff8000a02f73e0
>> [21630.913830] x29: ffff8000a02f73e0 x28: fffffdffc43fc800 x27:
>> ffff0000c0011c40
>> [21630.914677] x26: ffff0000c000cac0 x25: ffff00010fe5e5f0 x24:
>> ffff000102199b40
>> [21630.915469] x23: 0000000000000003 x22: 0000000000000003 x21:
>> ffff0000c0011c40
>> [21630.916259] x20: fffffdffc4086600 x19: fffffdffc43fc800 x18:
>> 0000000000000000
>> [21630.917048] x17: 0000000000000000 x16: 0000000000000000 x15:
>> 0000000000000000
>> [21630.917837] x14: 0000000000000000 x13: 0000000000000000 x12:
>> ffff70001405ee66
>> [21630.918640] x11: 1ffff0001405ee65 x10: ffff70001405ee65 x9 :
>> ffff800080a295dc
>> [21630.919442] x8 : ffff8000a02f7330 x7 : 0000000000000000 x6 :
>> 0000000000003000
>> [21630.920232] x5 : 0000000024924925 x4 : 0000000000000001 x3 :
>> 0000000000000007
>> [21630.921021] x2 : 0000000000001b40 x1 : 000000000000001f x0 :
>> 0000000000000001
>> [21630.921810] Call trace:
>> [21630.922130]  __free_slab+0x228/0x250 (P)
>> [21630.922669]  free_slab+0x38/0x118
>> [21630.923079]  free_to_partial_list+0x1d4/0x340
>> [21630.923591]  __slab_free+0x24c/0x348
>> [21630.924024]  ___cache_free+0xf0/0x110
>> [21630.924468]  qlist_free_all+0x78/0x130
>> [21630.924922]  kasan_quarantine_reduce+0x114/0x148
>> [21630.925525]  __kasan_slab_alloc+0x7c/0xb0
>> [21630.926006]  kmem_cache_alloc_noprof+0x164/0x5c8
>> [21630.926699]  __alloc_object+0x44/0x1f8
>> [21630.927153]  __create_object+0x34/0xc8
>> [21630.927604]  kmemleak_alloc+0xb8/0xd8
>> [21630.928052]  kmem_cache_alloc_noprof+0x368/0x5c8
>> [21630.928606]  getname_flags.part.0+0xa4/0x610
>> [21630.929112]  getname_flags+0x80/0xd8
>> [21630.929557]  vfs_fstatat+0xc8/0xe0
>> [21630.929975]  __do_sys_newfstatat+0xa0/0x100
>> [21630.930469]  __arm64_sys_newfstatat+0x90/0xd8
>> [21630.931046]  invoke_syscall+0xd4/0x258
>> [21630.931685]  el0_svc_common.constprop.0+0xb4/0x240
>> [21630.932467]  do_el0_svc+0x48/0x68
>> [21630.932972]  el0_svc+0x40/0xe0
>> [21630.933472]  el0t_64_sync_handler+0xa0/0xe8
>> [21630.934151]  el0t_64_sync+0x1ac/0x1b0
>> [21630.934923] Code: aa1803e0 97ffef2b a9446bf9 17ffff9c (d4210000)
>> [21630.936461] SMP: stopping secondary CPUs
>> [21630.939550] Starting crashdump kernel...
>> [21630.940108] Bye!
>>
>>>> Fixes: 09c46563ff6d ("codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark failed slab_ext allocations")
>>>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>>>> ---
>>>>    mm/slub.c | 12 +++++++++++-
>>>>    1 file changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>> index d4367f25b20d..cda8f75b72e7 100644
>>>> --- a/mm/slub.c
>>>> +++ b/mm/slub.c
>>>> @@ -2046,7 +2046,17 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
>>>>           if (slab_exts) {
>>>>                   unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
>>>>                                                    obj_exts_slab, obj_exts);
>>>> -               /* codetag should be NULL */
>>>> +
>>>> +               /*
>>>> +                * codetag should be either NULL or CODETAG_EMPTY.
>>>> +                * When the same slab calls handle_failed_objexts_alloc,
>>>> +                * it will set us to CODETAG_EMPTY.
>>>> +                *
>>>> +                * If codetag is already CODETAG_EMPTY, no action is needed here.
>>>> +                */
>>>> +               if (unlikely(is_codetag_empty(&slab_exts[offs].ref)))
>>>> +                       return;
>>>> +
>>>>                   WARN_ON(slab_exts[offs].ref.ct);
>>>>                   set_codetag_empty(&slab_exts[offs].ref);
>>>>           }
>>>> --
>>>> 2.25.1
>>>>

