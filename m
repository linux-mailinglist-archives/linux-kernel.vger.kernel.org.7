Return-Path: <linux-kernel+bounces-814181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA54FB5505A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209B2AA6659
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3245530E853;
	Fri, 12 Sep 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="sOXjcAsU"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9203630DEC9;
	Fri, 12 Sep 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685866; cv=none; b=HOfeARb9L1a2dy4UIykg+/xUfkjPuP7YVei4xgsFZ6dV14YXCPYvmPhCLa+EjM79a6TO6Y7p2uubCTqmOijqTjxLJ6VO+vxdSl5u9SbcWiIK+mPRr7vqeEl4fKfXVR3wQ6lqijLQ6KvmLQFQauJTCFT69RjIbd6TG3K6oOUcmfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685866; c=relaxed/simple;
	bh=w9uFsqm31/5h35rrL3ZqofDb5gPgbHxXm0Zt58AmuJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1783nxfrOCyRIWfLSJ9EQZvW3+v5TQ2zuLs3Sw03kxWaeKpKv6T5GcExa/RZzBc72+8gyFL4Vj8/kxiA77DH7e2VuMWZO13WUXiYaT5Ngu9AF84aC9Ktq4PQU43nxpsKo1CMfWnSqonm5kor2y4C41rMJ+fTqQ0RtvOsq3a5eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=sOXjcAsU; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1757685855; x=1758290655; i=deller@gmx.de;
	bh=w9uFsqm31/5h35rrL3ZqofDb5gPgbHxXm0Zt58AmuJY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sOXjcAsUfbs9YwWmaV7nnFY61EwxVxqLdplobRgz1dYEi9Ih8CJ3S+O+l3t/y6Om
	 vAHluFqU+qugipDOIJKbJCWzL7zSPe4JVs7Ew9PMIRBwmjj3mFKPYfFlI0FeNVGQ8
	 naHZESyOIWdKQwEkNGVAOCEqEFPP0Kfi81O21PG6u8/A4UboLborr2u2RVwhsoH9r
	 vU15tg/Sulny6p2Pg+1yMVwvqEj7YI4mRpu+w5bVBpRnagzjxk48Ge2Ah7RePZP8W
	 82Xh26kZfvwQBRgic4cNpVTY5ql0U/Lr4K/m3I8uQZTBF5PBZs038zZsimUfmu8pX
	 aUbJKQmoiuaPaiKz0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.58]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MowKc-1ucq7l2GR4-00lKOP; Fri, 12
 Sep 2025 16:04:15 +0200
Message-ID: <d5acfea4-10e6-4843-b67b-b23bdeb38dad@gmx.de>
Date: Fri, 12 Sep 2025 16:04:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: boot failure because of inaccurate page_pool_page_is_pp() on
 32-bit kernels
To: David Hildenbrand <david@redhat.com>, Helge Deller <deller@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Linux Kernel Development <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-parisc <linux-parisc@vger.kernel.org>
Cc: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
 Byungchul Park <byungchul@sk.com>
References: <5a004aef-9df1-4126-b167-1aae27d4240d@gmx.de>
 <1756327287@msgid.manchmal.in-ulm.de> <aMNJMFa5fDalFmtn@p100>
 <e326949b-5d8f-4a35-8116-015e784df421@redhat.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <e326949b-5d8f-4a35-8116-015e784df421@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yCTNPIItppZKZCjGChianVwoujDZohjRjoZ/5rjOxZwoCQblfoV
 QXxVzmh57tn0FDPCV71w0gy+s8BttD8m6zV9Z1gpwkPLGJQi54vtcbgkzknknvD2wam5RW0
 /G1HsCYE3e8y970fe+gTNvM9actSaaVIdlYWT/2av8zpt/onRaYsHTlekaNG213tqRFe8hy
 4e7KfVqrk9EBPM3QTGj7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HbMdUg+UC3g=;zLxJrjpIPI6uN0v3g0KRKZ+FFd6
 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
 pDT7iQ2uuZ6Wl0Tnf1/H7sMeniuGCOLw==

On 9/12/25 09:57, David Hildenbrand wrote:
> On 12.09.25 00:12, Helge Deller wrote:
>> As reported earlier in this mail thread, all 32-bit Linux kernels since=
 v6.16
>> fail to boot on the parisc architecture like this:
>>
>> =C2=A0 BUG: Bad page state in process swapper=C2=A0 pfn:000f7
>> =C2=A0 page: refcount:0 mapcount:0 mapping:00000000 index:0x0 pfn:0xf7
>> =C2=A0 flags: 0x0(zone=3D0)
>> =C2=A0 raw: 00000000 118022c0 118022c0 00000000 00000000 00000000 fffff=
fff 00000000
>> =C2=A0 raw: 00000000
>> =C2=A0 page dumped because: page_pool leak
>> =C2=A0 Modules linked in:
>> =C2=A0 CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.15.0-rc1-32bit+=
 #2730 NONE
>> =C2=A0 Hardware name: 9000/778/B160L
>> =C2=A0 Backtrace:
>> =C2=A0=C2=A0 [<106ece88>] bad_page+0x14c/0x17c
>> =C2=A0=C2=A0 [<10406c50>] free_page_is_bad.part.0+0xd4/0xec
>> =C2=A0=C2=A0 [<106ed180>] free_page_is_bad+0x80/0x88
>> =C2=A0=C2=A0 [<106ef05c>] __free_pages_ok+0x374/0x508
>> =C2=A0=C2=A0 [<1011d34c>] __free_pages_core+0x1f0/0x218
>> =C2=A0=C2=A0 [<1011a2f0>] memblock_free_pages+0x68/0x94
>> =C2=A0=C2=A0 [<10120324>] memblock_free_all+0x26c/0x310
>> =C2=A0=C2=A0 [<1011a4d8>] mm_core_init+0x18c/0x208
>> =C2=A0=C2=A0 [<10100e88>] start_kernel+0x4ec/0x7a0
>> =C2=A0=C2=A0 [<101054d0>] start_parisc+0xb4/0xc4
>>
>> git bisecting leads to this patch which triggers the crash:
>>
>> =C2=A0 commit ee62ce7a1d909ccba0399680a03c2dee83bcae95
>> =C2=A0 Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> =C2=A0 Date:=C2=A0=C2=A0 Wed Apr 9 12:41:37 2025 +0200
>> =C2=A0=C2=A0=C2=A0=C2=A0 page_pool: Track DMA-mapped pages and unmap th=
em when destroying the pool
>>
>> It turns out that the patch itself isn't wrong.
>>
>> But it's the culprit which leads to the kernel bug since it modifies
>> PP_MAGIC_MASK for 32-bit kernels from:
>>
>> -#define PP_MAGIC_MASK ~0x3UL
>> +#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>
>> Function page_pool_page_is_pp() needs to unambiguously identify page po=
ol
>> pages (using PP_MAGIC_MASK), but since the patch now reduced the valid =
bits to
>> check in PP_MAGIC_MASK from 0xFFFFFFFC to 0xc000007c, the remaining bit=
s are
>> not sufficient to unambiguously identify such pages any longer.
>>
>> Because of that, page_pool_page_is_pp() sometimes wrongly reports pages=
 as
>> page pool pages and as such triggers the kernel BUG as it believes it f=
ound a
>> page pool leak.
>>
>> IMHO this is a generic 32-bit kernel issue, not just affecting parisc.
>>
>> Do you see any options other than:
>> a) revert the patch (ee62ce7a1d90), or:
>> b) return false in page_pool_page_is_pp() when !defined(CONFIG_64BIT),
>> =C2=A0=C2=A0=C2=A0 which means to effectively disable the page pool pag=
e test on 32bit
>> =C2=A0=C2=A0=C2=A0 machines
>=20
> We should have a change coming soon that would use a page type and fix i=
t as well I think.
>=20
> https://lkml.kernel.org/r/20250728052742.81294-1-byungchul@sk.com
>=20
> Until then, the easiest fix would be indeed to go with b).

Ok, I'll send a patch for b).

Thanks!
Helge

