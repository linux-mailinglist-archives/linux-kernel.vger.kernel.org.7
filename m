Return-Path: <linux-kernel+bounces-683088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A50FAD68C8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 09:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E6817E966
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 07:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC9821B18B;
	Thu, 12 Jun 2025 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmKB497N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782F42040A7
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749712743; cv=none; b=ZVwEK8Wa2qDPvXLkwtniv2SfaW7BB9UUSBwYHWrZU0DZA5I+r9vdnbS3V5TFhSqCyTwFhYqe0rOe0xwyVaDtUbZoKYfThaKcnm8KtDmqo1kyr6HIDt4oOZYtmkwhv/DMdr8lQ+XVLNWxdIpcWX7Dd2/2UewCjKSTgakNPCW3MNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749712743; c=relaxed/simple;
	bh=E4o4+NkVdMsSwo6NSZE73XR/7IFF09J3OvpKyCjdrdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmN1G696hoiHW7+8Dqwncc2Q/qhgJZ5njqsX4nbQEFC5noIgljD9+GDK2Tmg4XynnansnD37zbOPi9VPj1mIgKDZS6p/lc9sroOrzE2ZF5mV9qqT16+WfEGA4DQA6iUEUvJ/qV/5oQKA4jG4jisBKvRE8zZA2c7XGEBr7alZuPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmKB497N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749712740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/FORcX77Z/dfz/4nX8LN31ZOLAOS6nLNcf+1RkLQzco=;
	b=fmKB497NXqhqNvWLva8gBQc372cXhBrvyahq592mjetQ6v/gr3+g4lBrNBWsDNTP3EG03q
	QYTjpP04JO26j7nz3IV+p5jnXu4YaPhvdUcRDeVQEHoepni2jA4j4RjEFeJ8iagthUbvQI
	fYgavZw5WQqO8sE7H/UGSc9o5aWWJAQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-rtYPPIvJPbeBO-WXyavA9w-1; Thu, 12 Jun 2025 03:18:57 -0400
X-MC-Unique: rtYPPIvJPbeBO-WXyavA9w-1
X-Mimecast-MFC-AGG-ID: rtYPPIvJPbeBO-WXyavA9w_1749712736
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f6cc5332so394476f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 00:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749712736; x=1750317536;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/FORcX77Z/dfz/4nX8LN31ZOLAOS6nLNcf+1RkLQzco=;
        b=p/0mITtrC9RRZXVtxEqB/0hChLFt2zVuz9JxJsFmFrp7gwP/7niZ90XxWLzIhPpmqT
         ab+rSBQYLWHY3vQJVDsQ58CJR1c0EnzPKijEAzYXv34NytwUKJ3UT+mV9cwZikrtz4RG
         zEI4xcBN+HtKlELHetBgKjW3pQ7j98IeG0Khs1RuTFeLCOX6s+ed5uTFfN9obJHZIoYU
         FVtzEpMwQohS/XALuQDorLfYwjP6bSZTCI4Zu2GuD7r5m7pwfhCwAxsehaQjE58HuHRM
         ltXKZj5IvFsbrloCminH+zfVbdUjQOWZhw8O9lEFuGUUCwVovz8AyfLlXIGAOkqLzt8a
         g0og==
X-Gm-Message-State: AOJu0YyY+CTyG9fMZW/bIwXfHXcBkEwGkeHJZzS2OP9ldkCXGnBUWCOi
	v74GZjQOxP6LIv5R5xP0fIV8+jkbSr2GpiKCTpcOEIg0ypx04p1wTC4gdRLigsdMIrSV7pviN09
	+s33hMBEEiTAhl5FGjPf83cU00Vzp1TNWSuXvyp3CAhQEPeLmlm/+sEgn+8E1zB81sA==
X-Gm-Gg: ASbGncvbmTsv/KfSU5rkwpAq+mfkpZkL5FpjCXeJW8FKuwb3+ASzB0STrInAHCzsHPc
	Sp2M7D8wKhsQw3LUTRKUvVEo9bE2CLxiHTC+SfTpouQODRtx0hg1ACzmKMIPd5W7BTQwO7A2LkR
	JglWmKaYaYEUayi3B8ivQlAhTGTZ1vkXWEIYhPGP8O4rdztZ0gBi4oENXB9JktVmEfm2IRCZtp3
	gW1c7Ee3hZ+xodOrnDtPS5Onmr7HuSfREybqCSTke1fkwITyRe0GoksenWcU3aycWsZL7mo0RjW
	1tQiRDFqhdNB6+s1DMyRdjm27Eo+Uk8QWfEbL+9goFLAEOPbvLZwP7w0+HXCb7kgjxjemDgqLmd
	7lsIjgAz6KtPM4NvYApEmJqUfpo2rjg+yL77cSuTdKbjK/6P53Q==
X-Received: by 2002:a05:6000:1acc:b0:3a5:1c3c:8d8d with SMTP id ffacd0b85a97d-3a56080ad40mr1700213f8f.55.1749712735788;
        Thu, 12 Jun 2025 00:18:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnuzBb21Wl7Xf5s9zBtEXduPrHUbE8WIdQsQ0ZDweoN2mKdK4HhlsxKte8GKHdxrB+9zyk/A==
X-Received: by 2002:a05:6000:1acc:b0:3a5:1c3c:8d8d with SMTP id ffacd0b85a97d-3a56080ad40mr1700180f8f.55.1749712735299;
        Thu, 12 Jun 2025 00:18:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2c:1e00:1e1e:7a32:e798:6457? (p200300d82f2c1e001e1e7a32e7986457.dip0.t-ipconnect.de. [2003:d8:2f2c:1e00:1e1e:7a32:e798:6457])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5619ab781sm1100303f8f.43.2025.06.12.00.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 00:18:54 -0700 (PDT)
Message-ID: <990ce9cf-0e48-432c-a29f-0bd1704eede4@redhat.com>
Date: Thu, 12 Jun 2025 09:18:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] mm/huge_memory: vmf_insert_folio_*() and
 vmf_insert_pfn_pud() fixes
To: Dan Williams <dan.j.williams@intel.com>,
 Alistair Popple <apopple@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Oscar Salvador <osalvador@suse.de>,
 marc.herbert@linux.intel.com
References: <20250611120654.545963-1-david@redhat.com>
 <lpfprux2x34qjgpuk6ufvuq4akzolt3gwn5t4hmfakxcqakgqy@ciiwnsoqsl6j>
 <684a5594eb21d_2491100de@dwillia2-xfh.jf.intel.com.notmuch>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <684a5594eb21d_2491100de@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.06.25 06:20, Dan Williams wrote:
> Alistair Popple wrote:
>> On Wed, Jun 11, 2025 at 02:06:51PM +0200, David Hildenbrand wrote:
>>> This is v2 of
>>> 	"[PATCH v1 0/2] mm/huge_memory: don't mark refcounted pages special
>>> 	 in vmf_insert_folio_*()"
>>> Now with one additional fix, based on mm/mm-unstable.
>>>
>>> While working on improving vm_normal_page() and friends, I stumbled
>>> over this issues: refcounted "normal" pages must not be marked
>>> using pmd_special() / pud_special().
>>>
>>> Fortunately, so far there doesn't seem to be serious damage.
>>>
>>> I spent too much time trying to get the ndctl tests mentioned by Dan
>>> running (.config tweaks, memmap= setup, ... ), without getting them to
>>> pass even without these patches. Some SKIP, some FAIL, some sometimes
>>> suddenly SKIP on first invocation, ... instructions unclear or the tests
>>> are shaky. This is how far I got:
>>
>> FWIW I had a similar experience, although I eventually got the FAIL cases below
>> to pass. I forget exactly what I needed to tweak for that though :-/
> 
> Add Marc who has been working to clean the documentation up to solve the
> reproducibility problem with standing up new environments to run these
> tests.

I was about to send some doc improvements myself, but I didn't manage to 
get the tests running in the first place ... even after trying hard :)

I think there is also one issue with a test that requires you to 
actually install ndctl ... and some tests seem to temporarily fail with 
weird issues regarding "file size problems with /proc/kallsyms", 
whereby, ... there are no such file size problems :)

All a bit shaky. The "memmap=" stuff is not documented anywhere for the 
tests, which is required for some tests I think. Maybe it should be 
added, not sure how big of an area we actually need, though.

> 
> http://lore.kernel.org/20250521002640.1700283-1-marc.herbert@linux.intel.com
> 

I think I have CONFIG_XFS_FS=m (instead of y) and CONFIG_DAX=y (instead 
of =m), and CONFIG_NFIT_SECURITY_DEBUG not set (instead of =y).

Let me try with these settings adjusted.

> There is also the run_qemu project that automates build an environment for this.
> 
> https://github.com/pmem/run_qemu
> 
> ...but comes with its own set of quirks.
> 
> I have the following fixups applied to my environment to get his going on
> Fedora 42 with v6.16-rc1:
> 
> diff --git a/README.md b/README.md
> index 37314db7a155..8e06908d5921 100644
> --- a/README.md
> +++ b/README.md
> @@ -84,6 +84,11 @@ loaded.  To build and install nfit_test.ko:
>      CONFIG_TRANSPARENT_HUGEPAGE=y
>      ```
>   
> +1. Install the following packages, (Fedora instructions):
> +   ```
> +   dnf install e2fsprogs xfsprogs parted jq trace-cmd hostname fio fio-engine-dev-dax
> +   ```
> +
>   1. Build and install the unit test enabled libnvdimm modules in the
>      following order.  The unit test modules need to be in place prior to
>      the `depmod` that runs during the final `modules_install`
> diff --git a/test/dax.sh b/test/dax.sh
> index 3ffbc8079eba..98faaf0eb9b2 100755
> --- a/test/dax.sh
> +++ b/test/dax.sh
> @@ -37,13 +37,14 @@ run_test() {
>   	rc=1
>   	while read -r p; do
>   		[[ $p ]] || continue
> +		[[ $p == cpus=* ]] && continue
>   		if [ "$count" -lt 10 ]; then
>   			if [ "$p" != "0x100" ] && [ "$p" != "NOPAGE" ]; then
>   				cleanup "$1"
>   			fi
>   		fi
>   		count=$((count + 1))
> -	done < <(trace-cmd report | awk '{ print $21 }')
> +	done < <(trace-cmd report | awk '{ print $NF }')
>   
>   	if [ $count -lt 10 ]; then
>   		cleanup "$1"
> 
> In the meantime, do not hesitate to ask me to run these tests.

Yes, thanks, and thanks for running these tests.

> 
> FWIW with these patches on top of -rc1 I get:
> 
> ---
> 
> [root@host ndctl]# meson test -C build --suite ndctl:dax
> ninja: Entering directory `/root/git/ndctl/build'
> [168/168] Linking target ndctl/ndctl
>   1/13 ndctl:dax / daxdev-errors.sh          OK              12.60s
>   2/13 ndctl:dax / multi-dax.sh              OK               2.47s
>   3/13 ndctl:dax / sub-section.sh            OK               6.30s
>   4/13 ndctl:dax / dax-dev                   OK               0.04s
>   5/13 ndctl:dax / dax-ext4.sh               OK               3.04s
>   6/13 ndctl:dax / dax-xfs.sh                OK               3.10s
>   7/13 ndctl:dax / device-dax                OK               9.66s
>   8/13 ndctl:dax / revoke-devmem             OK               0.22s
>   9/13 ndctl:dax / device-dax-fio.sh         OK              32.32s
> 10/13 ndctl:dax / daxctl-devices.sh         OK               2.31s
> 11/13 ndctl:dax / daxctl-create.sh          SKIP             0.25s   exit status 77
> 12/13 ndctl:dax / dm.sh                     OK               1.00s
> 13/13 ndctl:dax / mmap.sh                   OK              62.27s
> 
> Ok:                12
> Fail:              0
> Skipped:           1
> 
> Full log written to /root/git/ndctl/build/meson-logs/testlog.txt
> 
> ---
> 
> Note that the daxctl-create.sh skip is a known unrelated v6.16-rc1 regression
> fixed with this set:
> 
> http://lore.kernel.org/20250607033228.1475625-1-dan.j.williams@intel.com
> 
> You can add:
> 
> Tested-by: Dan Williams <dan.j.williams@intel.com>
> 

Thanks!

-- 
Cheers,

David / dhildenb


