Return-Path: <linux-kernel+bounces-723738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77022AFEA7E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D2F1C82ACB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6769F2E041F;
	Wed,  9 Jul 2025 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="yQGPicK6";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="HClRKehy"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB8F22B8D0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068434; cv=none; b=R9nekovphzcYqmlM2FH4pCOipV+r54tdKZ71JeYbm5RVhsGG5QHmrbflOe5AvuFqlErnIgqdRW4d89pQrxUtTlX7dnB2gYWrX7reSBc1FlmWN+qU8oZ31VGBrio52XNnM6Bfxi+YBUGs0hGSa8sBeUxlLG1OqhdBKIoFvTALbwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068434; c=relaxed/simple;
	bh=aQZymKyUrc/5I7EINX0x89zpUBG4TPzjuyZgGXp8cJA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=M7sAyv3pDFkbplMjUOQY3OBtqwxMGFuxgW5iyQikSak6gSkVQZbY6mEfg3TXFPyXOfO0EJTceolINW8tgWq/2GgY3417ZbBWmcqzuXbQznB2mTw3a3WCUChW9QpSrj+E5F3NQzhH7vEeRtpQ2UGGvn3eBdbx+qlYCh8JQ67Chlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=yQGPicK6; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=HClRKehy; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1752068428; x=1752673228;
	d=konsulko.se; s=rsa1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=9wNmXzsT2Qm51iGkMW4W5Cj/ccZe0He2BomSiCEZkp4=;
	b=yQGPicK6w3+28Yo5sIl58kfKYkdW1IWfx00KTopXUszMdQcH41UNa9nmn8KcgR+qdkHF/btI5xuz/
	 etbJKDvR5BwYmOxdc247JXKwUqFfGpQzg45l9wKNb1G9B+B8KcJf2np9xg/JkTFnNf82SjHu90oSxz
	 3cU6NMetiMOSZYNBFOmAumLiWF3jeeulgBdZsWKVdw/rygP5hwBeslZf5cW3SXqU2ffLLvELROOcQ2
	 J7RwO4b1egyy/WjOC1JYKrX9ZUuuPuYI1+J4tW9eMZolC12GVmODmuP6bLn7ridnsu7lvOmchjvucu
	 4l8Jqur4xU2hVOmfqr+O+nHDjuUcgxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1752068428; x=1752673228;
	d=konsulko.se; s=ed1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=9wNmXzsT2Qm51iGkMW4W5Cj/ccZe0He2BomSiCEZkp4=;
	b=HClRKehyLxD+atMHjqjFXjYpFGiwwHdAYs1D322FiACSdZUNRNlg9hMQ0NJXj9dFNv4cfeAHDm/Eg
	 G4FsTXMBg==
X-HalOne-ID: 45a67a1f-5cca-11f0-a5c1-81a63d10fb2d
Received: from smtpclient.apple (c188-150-224-8.bredband.tele2.se [188.150.224.8])
	by mailrelay5.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 45a67a1f-5cca-11f0-a5c1-81a63d10fb2d;
	Wed, 09 Jul 2025 13:40:28 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v11 2/4] mm/slub: allow to set node and align in
 k[v]realloc
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <76FFFF68-15F3-4A36-BF1D-A33CF36FDC9E@konsulko.se>
Date: Wed, 9 Jul 2025 15:40:17 +0200
Cc: linux-mm@kvack.org,
 akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org,
 Uladzislau Rezki <urezki@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux@vger.kernel.org,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7099B4C7-311F-466D-B12C-BDC52FE34A65@konsulko.se>
References: <20250707164755.631374-1-vitaly.wool@konsulko.se>
 <20250707164908.631462-1-vitaly.wool@konsulko.se>
 <4c5852cc-2ca5-432b-8426-01c108df66cb@suse.cz>
 <76FFFF68-15F3-4A36-BF1D-A33CF36FDC9E@konsulko.se>
To: Vlastimil Babka <vbabka@suse.cz>
X-Mailer: Apple Mail (2.3826.200.121)



> On Jul 8, 2025, at 4:03=E2=80=AFPM, Vitaly Wool =
<vitaly.wool@konsulko.se> wrote:
>=20
>=20
>=20
>> On Jul 8, 2025, at 2:52=E2=80=AFPM, Vlastimil Babka <vbabka@suse.cz> =
wrote:
>>=20
>> On 7/7/25 18:49, Vitaly Wool wrote:
>>> Reimplement k[v]realloc_node() to be able to set node and
>>> alignment should a user need to do so. In order to do that while
>>> retaining the maximal backward compatibility, add
>>> k[v]realloc_node_align() functions and redefine the rest of API
>>> using these new ones.
>>>=20
>>> With that change we also provide the ability for the Rust part of
>>> the kernel to set node and alignment in its K[v]xxx
>>> [re]allocations.
>>>=20
>>> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
>>> ---
>>> include/linux/slab.h | 40 ++++++++++++++++++---------
>>> mm/slub.c            | 64 =
++++++++++++++++++++++++++++++--------------
>>> 2 files changed, 71 insertions(+), 33 deletions(-)
>>>=20
>>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>>> index d5a8ab98035c..13abcf4ada22 100644
>>> --- a/include/linux/slab.h
>>> +++ b/include/linux/slab.h
>>> @@ -465,9 +465,15 @@ int kmem_cache_shrink(struct kmem_cache *s);
>>> /*
>>> * Common kmalloc functions provided by all allocators
>>> */
>>> -void * __must_check krealloc_noprof(const void *objp, size_t =
new_size,
>>> -     gfp_t flags) __realloc_size(2);
>>> -#define krealloc(...) alloc_hooks(krealloc_noprof(__VA_ARGS__))
>>> +void * __must_check krealloc_node_align_noprof(const void *objp, =
size_t new_size,
>>> +        unsigned long align,
>>> +        gfp_t flags, int nid) __realloc_size(2);
>>> +#define krealloc_node_noprof(_p, _s, _f, _n) \
>>> + krealloc_node_align_noprof(_p, _s, 1, _f, _n)
>>> +#define krealloc_noprof(...) krealloc_node_noprof(__VA_ARGS__, =
NUMA_NO_NODE)
>>> +#define krealloc_node_align(...) =
alloc_hooks(krealloc_node_align_noprof(__VA_ARGS__))
>>> +#define krealloc_node(...) =
alloc_hooks(krealloc_node_noprof(__VA_ARGS__))
>>> +#define krealloc(...) alloc_hooks(krealloc_noprof(__VA_ARGS__))
>>=20
>> Hm wonder if krealloc() and krealloc_node_align() would be enough. Is
>> krealloc_node() only used between patch 3 and 4?
>> Also perhaps it would be more concise to only have
>> krealloc_node_align_noprof() with alloc_hooks wrappers filling the
>> NUMA_NO_NODE (and 1), so we don't need to #define the _noprof variant =
of
>> everything. The _noprof callers are rare so they can just always use
>> krealloc_node_align_noprof() directly and also fill in the =
NUMA_NO_NODE (and 1).
>=20
> I don=E2=80=99t think that krealloc_node() is used at all at the =
moment. I thought I=E2=80=99d define these to be symmetrical to =
vmalloc() but if you believe these are redundant, I=E2=80=99m all for =
removing them.
>=20
Well, krealloc_noprof() appears to be used by nommu.c and it feels a bit =
weird to make nommu code deal with NUMA nodes. So unless you feel =
strongly about it, I would keep krealloc_noprof().

~Vitaly

>>=20
>>> void kfree(const void *objp);
>>> void kfree_sensitive(const void *objp);
>>> @@ -1041,18 +1047,23 @@ static inline __alloc_size(1) void =
*kzalloc_noprof(size_t size, gfp_t flags)
>>> #define kzalloc(...) alloc_hooks(kzalloc_noprof(__VA_ARGS__))
>>> #define kzalloc_node(_size, _flags, _node) kmalloc_node(_size, =
(_flags)|__GFP_ZERO, _node)
>>>=20
>>> -void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t =
flags, int node) __alloc_size(1);
>>> -#define kvmalloc_node_noprof(size, flags, node) \
>>> - __kvmalloc_node_noprof(PASS_BUCKET_PARAMS(size, NULL), flags, =
node)
>>> +void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), unsigned =
long align,
>>> +      gfp_t flags, int node) __alloc_size(1);
>>> +#define kvmalloc_node_align_noprof(_size, _align, _flags, _node) \
>>> + __kvmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, NULL), _align, =
_flags, _node)
>>> +#define kvmalloc_node_noprof(_size, _flags, _node) \
>>> + kvmalloc_node_align_noprof(_size, 1, _flags, _node)
>>> +#define kvmalloc_node_align(...) \
>>> + alloc_hooks(kvmalloc_node_align_noprof(__VA_ARGS__))
>>> #define kvmalloc_node(...) =
alloc_hooks(kvmalloc_node_noprof(__VA_ARGS__))
>>=20
>> Ditto.
>>=20
>>>=20
>>> -#define kvmalloc(_size, _flags) kvmalloc_node(_size, _flags, =
NUMA_NO_NODE)
>>> -#define kvmalloc_noprof(_size, _flags) kvmalloc_node_noprof(_size, =
_flags, NUMA_NO_NODE)
>>> +#define kvmalloc_noprof(...) kvmalloc_node_noprof(__VA_ARGS__, =
NUMA_NO_NODE)
>>> +#define kvmalloc(...) alloc_hooks(kvmalloc_noprof(__VA_ARGS__))
>>> #define kvzalloc(_size, _flags) kvmalloc(_size, (_flags)|__GFP_ZERO)
>>>=20
>>> -#define kvzalloc_node(_size, _flags, _node) kvmalloc_node(_size, =
(_flags)|__GFP_ZERO, _node)
>>> +#define kvzalloc_node(_s, _f, _n) kvmalloc_node(_s, =
(_f)|__GFP_ZERO, _n)
>>> #define kmem_buckets_valloc(_b, _size, _flags) \
>>> - alloc_hooks(__kvmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), =
_flags, NUMA_NO_NODE))
>>> + alloc_hooks(__kvmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), =
1, _flags, NUMA_NO_NODE))
>>>=20
>>> static inline __alloc_size(1, 2) void *
>>> kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int =
node)
>>> @@ -1068,13 +1079,16 @@ kvmalloc_array_node_noprof(size_t n, size_t =
size, gfp_t flags, int node)
>>> #define kvmalloc_array_noprof(...) =
kvmalloc_array_node_noprof(__VA_ARGS__, NUMA_NO_NODE)
>>> #define kvcalloc_node_noprof(_n,_s,_f,_node) =
kvmalloc_array_node_noprof(_n,_s,(_f)|__GFP_ZERO,_node)
>>> #define kvcalloc_noprof(...) kvcalloc_node_noprof(__VA_ARGS__, =
NUMA_NO_NODE)
>>> -
>>> #define kvmalloc_array(...) =
alloc_hooks(kvmalloc_array_noprof(__VA_ARGS__))
>>> #define kvcalloc_node(...) =
alloc_hooks(kvcalloc_node_noprof(__VA_ARGS__))
>>> #define kvcalloc(...) alloc_hooks(kvcalloc_noprof(__VA_ARGS__))
>>>=20
>>> -void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags)
>>> - __realloc_size(2);
>>> +void *kvrealloc_node_align_noprof(const void *p, size_t size, =
unsigned long align,
>>> +   gfp_t flags, int nid) __realloc_size(2);
>>> +#define kvrealloc_node_align(...) =
kvrealloc_node_align_noprof(__VA_ARGS__)
>>> +#define kvrealloc_node_noprof(_p, _s, _f, _n) =
kvrealloc_node_align_noprof(_p, _s, 1, _f, _n)
>>> +#define kvrealloc_node(...) =
alloc_hooks(kvrealloc_node_noprof(__VA_ARGS__))
>>> +#define kvrealloc_noprof(...) kvrealloc_node_noprof(__VA_ARGS__, =
NUMA_NO_NODE)
>>> #define kvrealloc(...) alloc_hooks(kvrealloc_noprof(__VA_ARGS__))
>>=20
>> Ditto.
>>=20
>>> extern void kvfree(const void *addr);
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index c4b64821e680..881244c357dd 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -4845,7 +4845,7 @@ void kfree(const void *object)
>>> EXPORT_SYMBOL(kfree);
>>>=20
>>> static __always_inline __realloc_size(2) void *
>>> -__do_krealloc(const void *p, size_t new_size, gfp_t flags)
>>> +__do_krealloc(const void *p, size_t new_size, unsigned long align, =
gfp_t flags, int nid)
>>> {
>>> void *ret;
>>> size_t ks =3D 0;
>>> @@ -4859,6 +4859,20 @@ __do_krealloc(const void *p, size_t new_size, =
gfp_t flags)
>>> if (!kasan_check_byte(p))
>>> return NULL;
>>>=20
>>> + /* refuse to proceed if alignment is bigger than what kmalloc() =
provides */
>>> + if (!IS_ALIGNED((unsigned long)p, align) || new_size < align)
>>> + return NULL;
>>> +
>>> + /*
>>> +  * If reallocation is not necessary (e. g. the new size is less
>>> +  * than the current allocated size), the current allocation will =
be
>>> +  * preserved unless __GFP_THISNODE is set. In the latter case a =
new
>>> +  * allocation on the requested node will be attempted.
>>> +  */
>>> + if (unlikely(flags & __GFP_THISNODE) && nid !=3D NUMA_NO_NODE &&
>>> +      nid !=3D page_to_nid(vmalloc_to_page(p)))
>>=20
>> We need virt_to_page() here not vmalloc_to_page().
>=20
> Indeed, thanks. It is a c=E2=80=99n=E2=80=99p error, we had =
virt_to_page() in earlier patchsets (i. e. up until v10).
>=20
>>=20
>>> + goto alloc_new;
>>> +
>>> if (is_kfence_address(p)) {
>>> ks =3D orig_size =3D kfence_ksize(p);
>>> } else {



