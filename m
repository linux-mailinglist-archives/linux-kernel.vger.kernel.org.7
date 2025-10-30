Return-Path: <linux-kernel+bounces-878876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C771C21ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B2F34F345E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F322322AE45;
	Thu, 30 Oct 2025 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="lP7ppbfl"
Received: from fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.65.3.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87E523B607
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.65.3.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847241; cv=none; b=RgiJqHf5fySQTHR0KxeqxTHZGFr9do6OwGNsJshmUhndcQiVa1ldGPvxP4uizlHvKgBr+v1KSslDPSMOpTVR6P7oYDE59YSyOt5v+3P/tDb9Wzd3HhN4USOmnCrixSM8GG5jW3nGsSsR+O8ljEnSjd3uri4IOsroWBPMLz5anqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847241; c=relaxed/simple;
	bh=iVLQgIn3lWgiQoO8C/gs1W/8mb+Z2Uld6E3EyWVLBu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dy/ZPViF5zdRDZTkXeooEAdl22f8ggto9Iwy95q4nxwar8Uv5Fh9zCstmZzz5vd3AMPP9eUrx/oDyYXMWmvlKNzhab+NnvnYojJO18+yaWIpS8ec/9zbtJJqJDpxLLCYO5YA3sDan5TN4iTSSUYQGhzC9lS8c8gbmMSggklkgCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=lP7ppbfl; arc=none smtp.client-ip=3.65.3.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761847239; x=1793383239;
  h=message-id:date:mime-version:reply-to:subject:to:
   references:from:in-reply-to:content-transfer-encoding;
  bh=E5wlxdnDcWixx3BBmRUtZ/2zQxVYjliI5U0iUUmSWIE=;
  b=lP7ppbfljTOhVMc0RcxKspXSy8ns67IvU9uZPk043omtUAgFYEONrpqJ
   kyOwsD4hiSbu2KlfieEW5aicK2DQyO3KX/R7M9f0kS2wA0Q6filSEG5Zn
   TofqT1lHm7KxY9dMENoWOkQEs4s2GWP1T+rIJR/e7y1WJX1kKrZ+wywdO
   TZxSWeWB3JJeDiPio7i4fMQZDpNpLxUuIelTB00EOH/CgrxJIAdhM+H0n
   P6jlBASun7ekLiP8/r7z9/ZFYQG9uR+86sem+DcY3t7avPxKNX8Fk5f0x
   +NuZsxzeC6+lNejVsaNcF2lwg8CIcC0ENzDgNZFSBqVBjPb9xIWtYo5UR
   A==;
X-CSE-ConnectionGUID: G8ewqpOrQEq2XZbS6lN9+A==
X-CSE-MsgGUID: DnvGQGwYQ6C6gQx2z9HmHw==
X-IronPort-AV: E=Sophos;i="6.19,250,1754956800"; 
   d="scan'208";a="4468863"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 18:00:28 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:12141]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.6.105:2525] with esmtp (Farcaster)
 id de7d695c-09e8-48b3-aec3-a2124ec2e8ae; Thu, 30 Oct 2025 18:00:28 +0000 (UTC)
X-Farcaster-Flow-ID: de7d695c-09e8-48b3-aec3-a2124ec2e8ae
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 30 Oct 2025 18:00:28 +0000
Received: from [192.168.10.151] (10.106.82.18) by
 EX19D022EUC002.ant.amazon.com (10.252.51.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 30 Oct 2025 18:00:27 +0000
Message-ID: <0b403696-addb-45ab-a9b5-60f231d9dc4b@amazon.com>
Date: Thu, 30 Oct 2025 18:00:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, Mike Rapoport <rppt@kernel.org>, Muchun Song
	<muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, Axel Rasmussen
	<axelrasmussen@google.com>, Andrew Morton <akpm@linux-foundation.org>, "James
 Houghton" <jthoughton@google.com>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Hugh Dickins <hughd@google.com>, Michal Hocko
	<mhocko@suse.com>, Ujwal Kundur <ujwal.kundur@gmail.com>, Oscar Salvador
	<osalvador@suse.de>, Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli
	<aarcange@redhat.com>
References: <20251014231501.2301398-1-peterx@redhat.com>
 <78424672-065c-47fc-ba76-c5a866dcdc98@redhat.com> <aPZDVuscFsYSlQjI@x1.local>
 <dtepn7obw5syd47uhyxavytodp7ws2pzr2yuchda32wcwn4bj4@wazn24gijumu>
 <aPe0oWR9-Oj58Asz@x1.local>
 <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>
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
In-Reply-To: <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D010EUA002.ant.amazon.com (10.252.50.108) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 30/10/2025 17:13, Liam R. Howlett wrote:
> * Peter Xu <peterx@redhat.com> [251021 12:28]:
> 
> ...
> 
>> Can you send some patches and show us the code, help everyone to support
>> guest-memfd minor fault, please?
> 
> Patches are here:
> 
> https://git.infradead.org/?p=users/jedix/linux-maple.git;a=shortlog;h=refs/heads/modularized_mem
> 
> This is actually modularized memory types.  That means there is no
> hugetlb.h or shmem.h included in mm/userfaultfd.c code.
> 
> uffd_flag_t has been removed.  This was turning into a middleware and
> it is not necessary.  Neither is supported_ioctls.
> 
> hugetlb now uses the same functions as every other memory type,
> including anon memory.
> 
> Any memory type can change functionality without adding instructions or
> flags or anything to some other code.
> 
> This code passes uffd-unit-test and uffd-wp-mremap (skipped the swap
> tests).
> 
> guest-memfd can implement whatever it needs to (or use others
> implementations), like shmem_uffd_ops here:
> 
> static const struct vm_uffd_ops shmem_uffd_ops = {
>          .copy                   =       shmem_mfill_atomic_pte_copy,
>          .zeropage               =       shmem_mfill_atomic_pte_zeropage,
>          .cont                   =       shmem_mfill_atomic_pte_continue,
>          .poison                 =       mfill_atomic_pte_poison,
>          .writeprotect           =       uffd_writeprotect,
>          .is_dst_valid           =       shmem_is_dst_valid,
>          .increment              =       mfill_size,
>          .failed_do_unlock       =       uffd_failed_do_unlock,
>          .page_shift             =       uffd_page_shift,
>          .complete_register      =       uffd_complete_register,
> };
> 
> Where guest-memfd needs to write the one function:
> guest_memfd_pte_continue(), from what I understand.
> 
> Obviously some of the shmem_ functions would need to be added to a
> header, or such.
> 
> And most of that can come from shmem_mfill_atomic_pte_continue(), from
> what I understand.  This is about 40 lines of code, but may require
> exposing some shmem functions to keep the code that compact.
> 
> So we don't need to expose getting a folio to a module, or decode any
> special flags or whatever.  We just call the function that needs to be
> called on the vma that is found.
> 
> If anyone has tests I can use for guest-memfd and instructions on
> guest-memfd setup, I'll just write it instead of expanding the
> userfaultfd middleware.

I used to use [1] as a test.  The test function can be called from inside

         if (flags & GUEST_MEMFD_FLAG_MMAP) {
                 test_mmap_supported(fd, page_size, total_size);
                 test_fault_overflow(fd, page_size, total_size);
         } else {

in your tree (tools/testing/selftests/kvm/guest_memfd_test.c).

CONFIG_KVM_GUEST_MEMFD=y should be sufficient to enable guest_memfd support.

[1] https://lore.kernel.org/kvm/20250404154352.23078-7-kalyazin@amazon.com/

> 
> Thanks,
> Liam
> 


