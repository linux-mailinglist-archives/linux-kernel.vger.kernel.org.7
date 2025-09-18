Return-Path: <linux-kernel+bounces-823351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D36FB862DC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3491CC122D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E38262FD7;
	Thu, 18 Sep 2025 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="mvFmr1Y6"
Received: from fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.64.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2744B1DF73C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.237.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215757; cv=none; b=d5tLt6w+JzzktAA/Bp18ANUOM5ItfCTZy8hkyzZDfR3sQJnhUK6TcdvLxAvVWtUmK4W1TCj+fwM30mMGadeGb02yPvtv0udeDTluaX0TV5oKFzE8W0jFEqXE8JBUW7/Dh+e1BGj4y14S+d43GI5IcBFtJQvJy9/SF1wJj95XXpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215757; c=relaxed/simple;
	bh=iyZa0p1vrRMdoEHPkgpNNeSSXB3RFoTJGH0tXzhP0KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XazhipdYzeGa4mQNgXL9f0NhuBsnuVdOIxGReodTnu40h1pFYucpWqYYERkuR2IjqA//MicamZ+BE4FgEUc+15GedO1aVKnCSYveChRd4p7/k0cnOAvLsfRneFghMaS4FQjskdwBbz0TRxnNXGc8IAx4uMhUhFiAuuVeFXgAWpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=mvFmr1Y6; arc=none smtp.client-ip=3.64.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758215755; x=1789751755;
  h=message-id:date:mime-version:reply-to:subject:to:
   references:from:in-reply-to:content-transfer-encoding;
  bh=tU54zEysCkLtfXawx7pO4eumYtyDwf8IrUxtTEuV2vQ=;
  b=mvFmr1Y6yQ3f6uekn2I+34ZCkv0TQmvZ5JZgXPAPxXZA1a5yym84s5IA
   TGjXUAEq4QXQtRQvX9EIzZCkBPFcRSCNIWRdL0FEnS/r4siITvueUO7em
   5RByrki1xVNDhjzYChiWjzToIZ5/HoMKKdDZob4d6RFwYCpPmX3sGz193
   tevhTtXl+uPTHIFxHDA2LSEHrsq4dhhkaKiD103Np8VO1vmUAmz8gvUJS
   ly8nJfy8qJXYtjySVEZME25uFXZBGnBE5hTbJclpi6JlyHx3CQ7036qif
   1geOMVKthdcEZuaY+DA1pC+mwlJWrmKUWobomr0TRGl2W8u9FdZ4aW+uS
   g==;
X-CSE-ConnectionGUID: rEWLAv1oSHWkvi8OMgYpAg==
X-CSE-MsgGUID: UXyoMKKmRXyYELq2QGcaOw==
X-IronPort-AV: E=Sophos;i="6.18,275,1751241600"; 
   d="scan'208";a="2233498"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 17:15:44 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:18576]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.39.25:2525] with esmtp (Farcaster)
 id b5ae4d2b-9548-41f0-82a6-0a7852741b62; Thu, 18 Sep 2025 17:15:44 +0000 (UTC)
X-Farcaster-Flow-ID: b5ae4d2b-9548-41f0-82a6-0a7852741b62
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 18 Sep 2025 17:15:44 +0000
Received: from [192.168.6.164] (10.106.83.11) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Thu, 18 Sep 2025
 17:15:43 +0000
Message-ID: <a1a48a0e-62d3-48d0-b9c2-492eb190b99f@amazon.com>
Date: Thu, 18 Sep 2025 18:15:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v2 1/4] mm: Introduce vm_uffd_ops API
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
	<rppt@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Peter Xu
	<peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Suren Baghdasaryan
	<surenb@google.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Muchun Song <muchun.song@linux.dev>, "Hugh
 Dickins" <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	"James Houghton" <jthoughton@google.com>, Michal Hocko <mhocko@suse.com>,
	"Andrea Arcangeli" <aarcange@redhat.com>, Oscar Salvador <osalvador@suse.de>,
	"Axel Rasmussen" <axelrasmussen@google.com>, Ujwal Kundur
	<ujwal.kundur@gmail.com>
References: <aGWMsfbayEco0j4R@x1.local> <aGbCbW7hUf3a2do2@kernel.org>
 <289eede1-d47d-49a2-b9b6-ff8050d84893@redhat.com> <aGfsaIIzHWfjcNFd@x1.local>
 <e7vr62s73dftijeveyg6lfgivctijz4qcar3teswjbuv6gog3k@4sbpuj35nbbh>
 <930d8830-3d5d-496d-80d8-b716ea6446bb@amazon.com>
 <jxekhkhbn7uk23oe24svxrs3vfuhseae57sqagndqgh2e7h33o@kfkygmrvjb5n>
 <aMp-kW3OLqtZs8sh@kernel.org>
 <du5pzxmfk6lile3ykpaloylwz4eni6disj2oe25eq6ipzqemiw@ybcouflfnlev>
 <aMvEu9m7fJLnj862@kernel.org>
 <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJnrNfABQkFps9DAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPOpfgD/exazh4C2Z8fNEz54YLJ6tuFEgQrVQPX6nQ/PfQi2+dwBAMGTpZcj9Z9NvSe1
 CmmKYnYjhzGxzjBs8itSUvWIcMsFzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmes18AFCQWmz0MCGwwACgkQr5LKIKmaZPNTlQEA+q+rGFn7273rOAg+rxPty0M8lJbT
 i2kGo8RmPPLu650A/1kWgz1AnenQUYzTAFnZrKSsXAw5WoHaDLBz9kiO5pAK
In-Reply-To: <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D002EUC001.ant.amazon.com (10.252.51.219) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 18/09/2025 17:47, Liam R. Howlett wrote:
> * Mike Rapoport <rppt@kernel.org> [250918 04:37]:
>> On Wed, Sep 17, 2025 at 12:53:05PM -0400, Liam R. Howlett wrote:
>>> * Mike Rapoport <rppt@kernel.org> [250917 05:26]:
>>>> Hi Liam,
>>>>
>>>> On Mon, Sep 08, 2025 at 12:53:37PM -0400, Liam R. Howlett wrote:
>>>>>
>>>>> Reading through the patches, I'm not entirely sure what you are
>>>>> proposing.
>>>>>
>>>>> What I was hoping to see by a generalization of the memory types is a
>>>>> much simpler shared code base until the code hit memory type specific
>>>>> areas where a function pointer could be used to keep things from getting
>>>>> complicated (or, I guess a switch statement..).
>>>>>
>>>>> What we don't want is non-mm code specifying values for the function
>>>>> pointer and doing what they want, or a function pointer that returns a
>>>>> core mm resource (in the old example this was a vma, here it is a
>>>>> folio).
>>>>>
>>>>>  From this patch set:
>>>>> +        * Return: zero if succeeded, negative for errors.
>>>>> +        */
>>>>> +       int (*uffd_get_folio)(struct inode *inode, pgoff_t pgoff,
>>>>> +                             struct folio **folio);
>>>>>
>>>>> This is one of the contention points in the current scenario as the
>>>>> folio would be returned.
>>>>
>>>> I don't see a problem with it. It's not any different from
>>>> vma_ops->fault(): a callback for a filesystem to get a folio that will be
>>>> mapped afterwards by the mm code.
>>>>
>>>
>>> I disagree, the filesystem vma_ops->fault() is not a config option like
>>> this one.  So we are on a path to enable uffd by default, and it really
>>> needs work beyond this series.  Setting up a list head and passing in
>>> through every call stack is far from idea.
>>
>> I don't follow you here. How addition of uffd callbacks guarded by a config
>> option to vma_ops leads to enabling uffd by by default?
> 
> Any new memory type that uses the above interface now needs uffd
> enabled, anyone planning to use guest_memfd needs it enabled, anyone
> able to get a module using this interface needs it enabled (by whoever
> gives them the kernel they use).  Kernel provides now need to enable
> UFFD - which is different than the example provided.
> 
>>
>>> I also think the filesystem model is not one we want to duplicate in mm
>>> for memory types - think of the test issues we have now and then have a
>>> look at the xfstests support of filesystems [1].
>>>
>>> So we are on a path of less test coverage, and more code that is
>>> actually about mm that is outside of mm.  So, is there another way?
>>
>> There are quite a few vma_ops outside fs/ not covered by xfstest, so the
>> test coverage argument is moot at best.
>> And anything in the kernel can grab a folio and do whatever it pleases.
> 
> Testing filesystems is nothing short of a nightmare and I don't want mm
> to march happily towards that end.  This interface is endlessly flexible
> and thus endlessly broken and working at the same time.
> 
> IOW, we have given anyone wanting to implement a new memory type
> infinite freedoms to run afoul, but they won't be looking for those
> people when things go horribly wrong - they will most likely see a
> memory issue and come here. syzbot will see a hang on some mm lock in an
> unrelated task, or whatever.
> 
> I would rather avoid the endlessly flexible interface to avoid incorrect
> uses in favour of a limited selection of choices, that could be expanded
> if necessary, but would be more visible to the mm people going in.  That
> is, people can add new memory types through adding them to mm/ instead
> of in driver/ or out of tree.
> 
> I could very much see someone looking to use this for a binder-type
> driver and that might work out really well!  But I don't want someone
> doing it and shoving the folio pointer in a custom struct because they
> *know* it's fine, so what's the big deal?  I don't mean to pick on
> binder, but this example comes to mind.
> 
>>
>> Nevertheless, let's step back for a second and instead focus on the problem
>> these patches are trying to solve, which is to allow guest_memfd implement
>> UFFD_CONTINUE (or minor fault in other terminology).
> 
> Well, this is about modularizing memory types, but the first user is
> supposed to be the guest-memfd support.
> 
>>
>> This means uffd should be able to map a folio that's already in
>> guest_memfd page cache to the faulted address. Obviously, the page table
>> update happens in uffd. But it still has to find what to map and we need
>> some way to let guest_memfd tell that to uffd.
>>
>> So we need a hook somewhere that will return a folio matching pgoff in
>> vma->file->inode.
>>
>> Do you see a way to implement it otherwise?
> 
> I must be missing something.
> 
> UFFDIO_CONTINUE currently enters through an ioctl that calls
> userfaultfd_continue() -> mfill_atomic_continue()... mfill_atomic() gets
> and uses the folio to actually do the work.  Right now, we don't hand
> out the folio, so what is different here?
> 
> I am under the impression that we don't need to return the folio, but
> may need to do work on it.  That is, we can give the mm side what it
> needs to call the related memory type functions to service the request.
> 
> For example, one could pass in the inode, pgoff, and memory type and the
> mm code could then call the fault handler for that memory type?
> 
> I didn't think Nikita had a folio returned in his first three patches
> [1], but then they built on other patches and it was difficult to follow
> along.  Is it because that interface was agreed on in a call on 23 Jan
> 2025 [2], as somewhat unclearly stated in [1]?

I believe you can safely ignore what was discussed in [2] as it is 
irrelevant to this discussion.  That was just reasoning why it was 
possible to use UserfaultFD for guest_memfd as opposed to inventing an 
alternative solution to handling faults in userspace.

Regarding returning a folio, [1] was calling vm_ops->fault() in 
UserfaultFD code.  The fault() itself gets a folio (at least in 
guest_memfd implementation [3]).  Does it look like a preferable 
solution to you?

The other patches it I was building on top were mmap support in 
guest_memfd [4], which is currently merged in kvm/next, and also part of 
[3].

[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/david/linux.git/tree/virt/kvm/guest_memfd.c?id=911634bac3107b237dcd8fdcb6ac91a22741cbe7#n347
[4] https://lore.kernel.org/kvm/20250729225455.670324-1-seanjc@google.com

> 
> Thanks,
> Liam
> 
> [1].  https://lore.kernel.org/all/20250404154352.23078-1-kalyazin@amazon.com/
> [2].  https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?tab=t.0#heading=h.w1126rgli5e3
> 


