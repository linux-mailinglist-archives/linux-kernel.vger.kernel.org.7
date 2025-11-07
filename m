Return-Path: <linux-kernel+bounces-890151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E93E1C3F56C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A667A4ECF60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703E32FD1B1;
	Fri,  7 Nov 2025 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jqL+WFqC"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352F326E6E8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510184; cv=none; b=SRzPGBG8iG8K+ACLxOp5YHh2fHCnZ9ju32ma9rbFXA72UBElIHXY4kKI7r/8mrj0oJgty8bIlL5h/7B90YQCXfk3/O9EgQtcoGm+x4GfJzMiP+oNRGv2S+iVqAw72kCtmlvhnqrtS5KgK1Gdz63KqTGb0yojy/jW3ltqFpERZb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510184; c=relaxed/simple;
	bh=IT41frSe/TXxYkOPY1B0l23x4224s8Ml2A1lui2zw1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IFU8QSGI5uKxOtKapdxe68o9lHjFEMfly2LrojOg3t4+yMs0+UBoPP/x/zDdQZcESrpE5W3hRA3QrmMk7Pq3f/xoXfcMOCPTyLUtssuFhy9l/KzLQlUNlNnrp20r2qFPP9qrfatmLfe3kTxk7bP2KEFnH8pYBqce7fNqtbGWG/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jqL+WFqC; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e21ea030-b05f-42e6-b479-b3e0789b9d97@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762510179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RaDqxpkLjNg3cRc3/oJ0cpx9kgShK1ofv8cia8fZS0s=;
	b=jqL+WFqCG/KC4hXV8npOOj3YWtk9v+qNVt6FPVd2OtJlwFhXYEqJVyDB1MIwv7eG2uvIHt
	6r6mo4TPFOkEeAu40k2lUokye9kYEcgqOuWaq/PLp6nKBbdwBa+7ok5gXsKr4I+7y+f/NC
	5b29q2cnI+3aFpe2ZfV2X20cw4zgJrM=
Date: Fri, 7 Nov 2025 18:09:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: madvise(MADV_COLLAPSE) fails with EINVAL on dirty file-backed
 text pages
To: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>,
 "Garg, Shivank" <shivankg@amd.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 zokeefe@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com>
 <8bc796e2-f652-4c12-a347-7b778ae7f899@arm.com>
 <ozkb6mcxuymlz7tm4vcnqf266gd4ruiik2zal2koo5ffprgxfk@35godtyix2cf>
 <43a8c8a6-388b-4c73-9a62-ee57dfb9ba5a@lucifer.local>
 <77a54f63-f5da-42a2-b24d-5c8a0f41d1e6@gmail.com>
 <0b84865c-5b23-4be6-9902-af9d5e63c182@amd.com>
 <0e616478-96d4-41e9-b6c1-fa641c36fba3@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <0e616478-96d4-41e9-b6c1-fa641c36fba3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/7 17:12, David Hildenbrand (Red Hat) wrote:
> 
>>
>> 5. Yes, I'm calling madvise(MADV_COLLAPSE) on the text portion of the 
>> executable, using the address
>>     range obtained from /proc/self/maps. IIUC, this should benefit 
>> applications by reducing ITLB pressure.
>>
>> I agree with the suggestions to either Return EAGAIN instead of EINVAL 
>> or At minimum, document the
>> EINVAL return for dirty pages. I'm happy to work on a patch.
> 
> Of course, we could detect that we are in MADV_COLLAPSE and simply 
> writeback ourselves. After all,
> user space asked for a collapse, and it's not khugepaged that will 
> simple revisit it later.
> 
> I did something similar in
> 
> commit ab73b29efd36f8916c6cc9954e912c4723c9a1b0
> Author: David Hildenbrand <david@redhat.com>
> Date:   Fri May 16 14:39:46 2025 +0200
> 
>      s390/uv: Improve splitting of large folios that cannot be split 
> while dirty
>      Currently, starting a PV VM on an iomap-based filesystem with large
>      folio support, such as XFS, will not work. We'll be stuck in
>      unpack_one()->gmap_make_secure(), because we can't seem to make 
> progress
>      splitting the large folio.
> 
> Where I effectively use filemap_write_and_wait_range().
> 
> It could be used early to writeback the whole range to collapse once, 
> possibly.

Exactly!

Since MADV_COLLAPSE is a best-effort thing, having the kernel use
something like filemap_write_and_wait_range() to writeback the pages
before collapsing is likely what users would expect.

Anyway, they just want to get a THP, whether the pages are dirty or
clean :)

