Return-Path: <linux-kernel+bounces-837411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7F7BAC436
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1ECA7AA8FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E857C268688;
	Tue, 30 Sep 2025 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQXtqijk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A9E20468D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759224208; cv=none; b=UNwNWxb6AYjmR7msEA451nnNOjlW2LmJ7ZMtQe6lEx/AZXDfXWsQ1gBh6xE3J4ubzmdAgV0JZm4c6YOtKkVEOajKf98ZA19I2fIxpIpiJQ9db0FsHmZWG7F2B/MbtnwydSCzxnsJzE55abL05GYnxOrW+TeNo8npEcPe9Fbe+zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759224208; c=relaxed/simple;
	bh=n/8rtpwmxwuPX63ARd4OLDTXI3g83sH8IA7Y+bCva2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFuZcbjfvD6KF/sYqrM+v5Asc9Zfcij0w7auE2yAxZGV+uannAmVNJEAuaZulXssTHRbMIPvESf70E2Hn0T3XUeLnD0O+C62ZdSyxlxi/neodaiSmDr7llx8JXz4c9aos95bjawL7Fb2QQWKP89Ucbj8AHeAx/HqjLDhbpJZQL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQXtqijk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759224205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TVTRRja56NKyfYmtJWa6t4niAYLHaXsYHEoVzq9agdk=;
	b=BQXtqijkPj378dABWJmeBpc4v+BtH0Oiu4evEAXeYMI6R2Fky3nRL5tvgFIt/ymV+N0LJb
	PpaoFMHHUO6C+4VWIaBqsPW9lmiAMcoaaJW4geSca87kW5swb1GopeunDCZa2Vd3v1mYBk
	j9JSnO9+D1BCOvZkF7kOOeVipwCjsFA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-scqVo3b5Ncy_GG1d4RUZDg-1; Tue, 30 Sep 2025 05:23:23 -0400
X-MC-Unique: scqVo3b5Ncy_GG1d4RUZDg-1
X-Mimecast-MFC-AGG-ID: scqVo3b5Ncy_GG1d4RUZDg_1759224203
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ed9557f976so3748770f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759224203; x=1759829003;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVTRRja56NKyfYmtJWa6t4niAYLHaXsYHEoVzq9agdk=;
        b=sSHWgzgY5nIP/tZ4rpv/AGOkR7TBFCJUixtlwtjoK0do1YXLNtWwjUIeQqmUHdhbDy
         OvKVvoF9L/XZ7mhuQUjjwpPWljA5LUKDKsf4Ti/OUgi0aekl7vYpemtp+J+RoM+T872t
         raHRsUEwShiOHaoxdcpd5LgMp3B8jsrJFgflUtRjw68aLdjRGC5rT6IRnDCilGW25qq+
         Z4HwO14aAPP8VcVq1v4wnVfHpQq2K5O3cKWx52tKFU0zE6fxce6EvvKGSpu5ZEM8qpda
         irZrpqAK6yZ2mzRQ9VvairgLZKjBOSyuxDiB++8oYZ69hyhPAZeEOO5dT9inh4YI/twF
         DqfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgSS+zBXqZNIwq73EGi0gT9gfjHFiXaKuxdLmG/pmYn9QHIPndCZyc8rYFIZ05+Z3LYQptILMZ625O4b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUSKJdQs7aq8A9oXtaZWNaGzGz56+SA635FuIJyGltfQIr2ZBo
	67CEF5ILC75HU0ibfNIM2KjetqW20LX/YlYh0JhZ1v0gMvL1PW020415g8Y1ECc+fcwJ6sPmSAl
	TPc1OuCASOXDaTlOFai6zKPIyB8GO52+JBg39VRza0sV4EeOzAQdmHF8jLpGSwHnc10A6ZjUx6s
	rU
X-Gm-Gg: ASbGncshDeJdoMSe+5dkpd+uQ3jiAkAc35Zdbzf5X3XHhRtVK3zPey8OtUAjwCMSoi5
	D0K7NUqk83TltT8kYE8F0CHz+OeJyfYvy3wIklaRH5PmSlYfhJnkMToQux6OOx883Wye5hCSXGX
	4NT9RDzlvbM41qbj8LTF4Lrffngg2DAVwIN7HuMLUy4NXt490Kw+u94GqZ8gPbe9TtKvEUvkCUa
	VgfXAIp8btj0KHKOKyrRS2GK6514+zvuyt0EQC5qPjMYN4KdM8Fl+DgE5xNOsfKNJnr4OkTxeQ8
	ug/sRCzRkayuZM9EXgSndvNCmi5fXL0DkVc7Mwm6tmF7E31hDqZD7tay4cp9R2QE4gnPgAr6TlO
	YaL9xA1c1
X-Received: by 2002:a5d:5f45:0:b0:3ea:a496:9ba8 with SMTP id ffacd0b85a97d-40e480ca410mr18003946f8f.29.1759224202721;
        Tue, 30 Sep 2025 02:23:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8kxKym0XL78KwB0qdyY+0naOZrFtENcl3ZdbfIV0WoqTUk+yahydILwO1rCp3XZnwKFT+lw==
X-Received: by 2002:a5d:5f45:0:b0:3ea:a496:9ba8 with SMTP id ffacd0b85a97d-40e480ca410mr18003916f8f.29.1759224202270;
        Tue, 30 Sep 2025 02:23:22 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603381sm23402858f8f.31.2025.09.30.02.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 02:23:21 -0700 (PDT)
Message-ID: <0a60d99b-fa3b-482b-8171-ac63dcdf3168@redhat.com>
Date: Tue, 30 Sep 2025 11:23:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: Apply vm_uffd_ops API to core mm
To: Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Axel Rasmussen <axelrasmussen@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, James Houghton <jthoughton@google.com>,
 Nikita Kalyazin <kalyazin@amazon.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ujwal Kundur <ujwal.kundur@gmail.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
 Suren Baghdasaryan <surenb@google.com>
References: <20250926211650.525109-1-peterx@redhat.com>
 <20250926211650.525109-5-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250926211650.525109-5-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.09.25 23:16, Peter Xu wrote:
> Move userfaultfd core to use new vm_uffd_ops API. After this change file
> systems that implement vm_operations_struct can start using new API for
> userfaultfd operations.
> 
> When at it, moving vma_can_userfault() into mm/userfaultfd.c instead,
> because it's getting too big.  It's only used in slow paths so it shouldn't
> be an issue.  Move the pte marker check before wp_async, which might be
> more intuitive because wp_async depends on pte markers.  That shouldn't
> cause any functional change though because only one check would take effect
> depending on whether pte marker was selected in config.
> 
> This will also remove quite some hard-coded checks for either shmem or
> hugetlbfs.  Now all the old checks should still work but with vm_uffd_ops.
> 
> Note that anonymous memory will still need to be processed separately
> because it doesn't have vm_ops at all.
> 
> Reviewed-by: James Houghton <jthoughton@google.com>
> Acked-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

[...]

> +++ b/mm/userfaultfd.c
> @@ -20,6 +20,43 @@
>   #include "internal.h"
>   #include "swap.h"
>   
> +bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
> +		       bool wp_async)
> +{
> +	unsigned long supported;
> +
> +	if (vma->vm_flags & VM_DROPPABLE)
> +		return false;
> +
> +	vm_flags &= __VM_UFFD_FLAGS;
> +
> +#ifndef CONFIG_PTE_MARKER_UFFD_WP

While at it, you can turn that into an
!IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP) to avoid the ifdef.

> +	/*
> +	 * If user requested uffd-wp but not enabled pte markers for
> +	 * uffd-wp, then any file system (like shmem or hugetlbfs) are not
> +	 * supported but only anonymous.
> +	 */
> +	if ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
> +		return false;
> +#endif
> +	/*
> +	 * If wp async enabled, and WP is the only mode enabled, allow any
> +	 * memory type.
> +	 */
> +	if (wp_async && (vm_flags == VM_UFFD_WP))
> +		return true;


> +
> +	if (vma_is_anonymous(vma))
> +		/* Anonymous has no page cache, MINOR not supported */
> +		supported = VM_UFFD_MISSING | VM_UFFD_WP;
> +	else if (vma_get_uffd_ops(vma))
> +		supported = vma_get_uffd_ops(vma)->uffd_features;
> +	else
> +		return false;

To avoid the hidde return here, I think you can just do

	supported = 0;


Or even cleaner, just do

unsigned long supported = 0
...
if (vma_is_anonymous(vma))
	supported = ...
else if (vma_get_uffd_ops(vma))
	supported = ...
return ...

> +
> +	return !(vm_flags & (~supported));

I think this can just be:

	return !(vm_flags & ~supported);


-- 
Cheers

David / dhildenb


