Return-Path: <linux-kernel+bounces-713876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D99ADAF5F81
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 19:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EAE1C40680
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D7F286409;
	Wed,  2 Jul 2025 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ousz9wXP"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192B62749E5
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476133; cv=none; b=F005MlnRPtRampJrEIyKhKxhIzJsmHq7zUKU35CGCOTJXqVhJX1XrPtO16BtAUBLx9eH3oDT+mWPvUSs9FGnLNY7gdFXqncj6BtswYCWSy1iy0zmIUmXvo6+mpwRSBoOve3TREWfVHleyj4/9SkUOTd10quHB5DnVNfFHqWZ2VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476133; c=relaxed/simple;
	bh=nHHaZGvcPq95A5vMLvVPDFhdv/sCx/ax7McJGeucM5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OZCGQXOt9O0SfdJmbX+PrEN4qX6sj43BsywGuGoUnjLGONkXQb8w6AeE1GcLgAq/zYg62k4RvDtwDlVQEINjGr0LmAo7vtX8TMLiV9cPEm5KXhiGDBWeUJnSDsQNvHruKA5RXaS84b4Eg4n51A9TxrvXRuj21ppCJMfa9a3oGA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ousz9wXP; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1751476132; x=1783012132;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=H3hxr2Fy/BBV4dpcyVkROyueSBD9Z+ON9jAG+cUHzRk=;
  b=ousz9wXPg/xIee4P7dVrCqMVdV4tqLS4jz1k6TNpVlHUy31+fTPvSsHa
   5VSHvyKr8JNlkEsKK7SU6x8hS2fur6/OV7KeP+vjy3U3s2V3ZV1dV5n8S
   Bf7T9FWMvpgG2W5Rbii6eznygVXdxdh8yphujyjPGMW7isF9I7akL0gc8
   T+Wflg4QgqntTqR+TkVZ+zdCBpM8e8qChY2vKwRrEJCFINX6G8UJNror5
   QRNOMNbMh9JiWqP78fhfWUem/8lRnBgxjJ2ir8ozelvijukFolykNCiYf
   42iutafnPTXNY+GvVU1cP+8mph33rJnhS1neDvx1mIIWP5GEHvofc8EP7
   w==;
X-IronPort-AV: E=Sophos;i="6.16,281,1744070400"; 
   d="scan'208";a="421152674"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 17:08:49 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:5972]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.240:2525] with esmtp (Farcaster)
 id 344cae8f-1feb-414e-987a-7036a54f2bb1; Wed, 2 Jul 2025 17:08:48 +0000 (UTC)
X-Farcaster-Flow-ID: 344cae8f-1feb-414e-987a-7036a54f2bb1
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Jul 2025 17:08:47 +0000
Received: from [192.168.3.69] (10.106.83.11) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Wed, 2 Jul 2025
 17:08:46 +0000
Message-ID: <cda7c46b-c474-48f4-b703-e2f988470f3b@amazon.com>
Date: Wed, 2 Jul 2025 18:08:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v2 1/4] mm: Introduce vm_uffd_ops API
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Suren Baghdasaryan
	<surenb@google.com>
CC: Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Muchun Song
	<muchun.song@linux.dev>, Mike Rapoport <rppt@kernel.org>, Hugh Dickins
	<hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, James Houghton
	<jthoughton@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
	"Michal Hocko" <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
	"Andrea Arcangeli" <aarcange@redhat.com>, Oscar Salvador <osalvador@suse.de>,
	"Axel Rasmussen" <axelrasmussen@google.com>, Ujwal Kundur
	<ujwal.kundur@gmail.com>
References: <20250627154655.2085903-1-peterx@redhat.com>
 <20250627154655.2085903-2-peterx@redhat.com>
 <aaaca9d4-b8df-45b8-a3a4-a431c99f26c7@lucifer.local>
 <CAJuCfpHN6vpDx+UNPEzJgZ_qD9USTJZ_+yZzQg2BpF_aRpufYw@mail.gmail.com>
 <982f4f94-f0bf-45dd-9003-081b76e57027@lucifer.local>
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
In-Reply-To: <982f4f94-f0bf-45dd-9003-081b76e57027@lucifer.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D013EUB002.ant.amazon.com (10.252.51.109) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 02/07/2025 16:56, Lorenzo Stoakes wrote:
> On Tue, Jul 01, 2025 at 10:04:28AM -0700, Suren Baghdasaryan wrote:
>> On Mon, Jun 30, 2025 at 3:16 AM Lorenzo Stoakes
>> <lorenzo.stoakes@oracle.com> wrote:
>>> This feels like you're trying to put mm functionality outside of mm?
>>
>> To second that, two things stick out for me here:
>> 1. uffd_copy and uffd_get_folio seem to be at different abstraction
>> levels. uffd_copy is almost the entire copy operation for VM_SHARED
>> VMAs while uffd_get_folio is a small part of the continue operation.
>> 2. shmem_mfill_atomic_pte which becomes uffd_copy for shmem in the
>> last patch is quite a complex function which itself calls some IMO
>> pretty internal functions like mfill_atomic_install_pte(). Expecting
>> modules to implement such functionality seems like a stretch to me but
>> maybe this is for some specialized modules which are written by mm
>> experts only?
> 
> To echo what Liam said - I don't think we can truly rely on expertise here
> (we make enough mistakes in core mm for that to be a dubious proposition
> even tere :) and even if experts were involved, having core mm
> functionality outside of core mm carries significant risk - we are
> constantly changing things, including assumptions around sensitive topics
> such as locking (think VMA locking) - having code elsewhere significantly
> increases the risk of missing things.
> 
> I am also absolutely, to be frank, not going to accept us EXPORT()'ing
> anything core.
> 
> Page table manipulation really must rely in core mm and arch code only, it
> is easily some of the most subtle, confusing and dangerous code in mm (I
> have spent subtantial hours banging my head against it recently), and again
> - subject to constant change.
> 
> But to come back to Liam's comments and to reiterate what I was referring
> to earlier, even permitting drivers to have access to VMAs is _highly_
> problematic and has resulted in very real bugs and subtle issues that took
> many hours, much stress + gnashing of teeth to adress.

The main target of this change is the implementation of UFFD for 
KVM/guest_memfd (examples: [1], [2]) to avoid bringing KVM-specific code 
into the mm codebase.  We usually mean KVM by the "drivers" in this 
context, and it is already somewhat "knowledgeable" of the mm.  I don't 
think there are existing use cases for other drivers to implement this 
at the moment.

Although I can't see new exports in this series, there is now a way to 
limit exports to particular modules [3].  Would it help if we only do it 
for KVM initially (if/when actually needed)?

[1] 
https://lore.kernel.org/all/114133f5-0282-463d-9d65-3143aa658806@amazon.com/
[2] 
https://lore.kernel.org/all/7666ee96-6f09-4dc1-8cb2-002a2d2a29cf@amazon.com/
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?h=kbuild&id=707f853d7fa3ce323a6875487890c213e34d81a0

Thanks,
Nikita

> 
> The very thing of:
> 
> xxx
> <hand off sensitive mutable state X, Y, Z to driver>
> yyy
> 
> Means that between xxx and yyy we can make literally no assumptions about
> what just happened to all handed off state. A single instance of this has
> caused mayhem, if we did this in such a way as to affect the _many_ uffd
> hooks we could have a realy serious problem.
> 
> So - what seems really positive about this series is the _generalisation_
> and _abstraction_ of uffd functionality.
> 
> That is something I appreciate and I think uffd sorely needs, in fact if we
> could find a way to not need to do:
> 
> if (some_uffd_predicate())
>          some_uffd_specific_fn();
> 
> That'd be incredible.
> 
> So I think the answer here is to do something like this, and to keep all
> the mm-specific code in core mm.
> 
> Thanks, Lorenzo


