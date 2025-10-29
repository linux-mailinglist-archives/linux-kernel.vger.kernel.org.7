Return-Path: <linux-kernel+bounces-875659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC060C198B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AC53BF67A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D09E1EE02F;
	Wed, 29 Oct 2025 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YfW2UM64"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A52F6596
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731843; cv=none; b=KOy1Ds3Kl4VUwPqX+xE2hL5VBzjW5avEOzG6rnfUL2ECD+1i+7MgVQpAqP9JPabfUm4nIDqPGIv6nzPhXxMQpQxRgOQowGIAjXD8VxRPvZ4E98Bw0RIylG4DdkXyVyS72Wk9bdrW4xWzCZf9NYWuDjZ4x8VAEPcJNSa7IQAufTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731843; c=relaxed/simple;
	bh=Dck0T8VjW9cA0em3mIDfRLuS/NSrAfL7WS9l1oS4gkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPhwUKSWER7KXsCq6UTYK+9eeD0a/Bo5qpdcSLHaHfjenmGMlt64ta1fFrvOfDZLCRSNO2H83HCg6a7QVwbVhz6YWnnJm7xNGsCHvVw1nAjV+cgYH1/Syke28tyLQaBkCop4FYQOniupYdmdi0pvbM2RME50Lt/hB4xmm+K3BUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YfW2UM64; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761731840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qqgl0WoEbTgKKe2Gmw+CbLcc1Ynjine2xgmP5Tg3jQI=;
	b=YfW2UM64wxSK1R0Wcz9n6lL2iJYnc8SfZinuUbfN9QKfzfrMDfcjSXNk69Ss8VpV8pmCRV
	sDqoDATH7xNvWBqsrALSPVxvinZwZgUKrQahjG31DwaKSyueaPisg3Pb0/2LYJwraRyGBz
	jkjTz97A+5NMVfC3qgZJLYi6g2iKUQI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-bU7zGPJ6NSKLwltTPQmp-A-1; Wed, 29 Oct 2025 05:57:19 -0400
X-MC-Unique: bU7zGPJ6NSKLwltTPQmp-A-1
X-Mimecast-MFC-AGG-ID: bU7zGPJ6NSKLwltTPQmp-A_1761731838
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-427015f62a7so3297205f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731838; x=1762336638;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqgl0WoEbTgKKe2Gmw+CbLcc1Ynjine2xgmP5Tg3jQI=;
        b=UySIqVgFnRiwRlv+MD/F36vErlhj3+TBFqp76iYk3+nJNZjv95QqxNbOkv2fgj964x
         4r6Y13wR2agvB078s/kwR4qaxWtyxx5xc9tRhcQgfdNt1Ix0qg2KDvQcMNEzDbbRnceH
         rnRlGY4DcrHIe/U6BPVvD6nTf7zoYzWo9bdnXeOJxdMhzDjC0KUMANkxQum2unqUmkxz
         cOIHRZ3OU70KvW+ZMuTAYhO1hFzmIS6kKS1DKp3QUirQi20e8XUzUUg6agIwshDAZnN2
         Yh6FpPsa9ta7+Ei38kiU2Zd7LSPmsdeFAvD+bqZzCLTzDJUXwOTkiEWSlYNJFSMUKyQf
         +/Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVjbBWZfYkuZ0H3crDGUwtIZx06Mpq4UctomqmA1QkUeM2qz8BhGfPihFBDOMrzpicr/wmJEih5MGiys7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5kQphHOYlqslsUQoghQtQ2fID9TE6hfRtBzYWDAVjwpCWhTEO
	/NKsc3w1CsDtoaubknBCmPxRmy0NGv5negPHe39/B6UnofYBViBDPE18gm/HV671C1GEdL1gvkr
	3aLakMQNmyHXwmjEk2AWjE2Xj7LPezeVLMcmcCg38WrnycnEY0ffHs4ObSQL36scIEg==
X-Gm-Gg: ASbGnct8b7OQ1McBSXA6uB49QN2tplqe8ZmkPX0h7hUUYIfYAQqwErOC9vgLx6HseUT
	S+pfZEg8uSBvgyGRWRG1oLGosqd43NCa0gy/mTRSYqa9OgXW7sKOM3minPwCS1hUH5w+2LRCidx
	A8wKEL/KtkkGefIKWqwPa+l+hKFRWXBN/DBjbSQjglJhBD+68zDi/nStNZQ5P5CIv1Z1bmDtWIE
	oLmveH//P4B3pxk2Chut2B4mPX8POdgCbMFilyGGMbTv+epexKll4Mu/1j48Rk4muAj2ZL2doNK
	8T4Tcvh74OL3DIOwJKnneU+GM+um6DXxhI79AXBvNLHPCxhe7Vo6+JsBQjUgHhy4XProM0lpbQ2
	jlrrWSf9uy0QFGKX2m51NwA==
X-Received: by 2002:a05:6000:4382:b0:3d1:8d1e:8e9 with SMTP id ffacd0b85a97d-429aefbdfe9mr1681133f8f.32.1761731837813;
        Wed, 29 Oct 2025 02:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExZbPXgteVglylVVAK83EpEE4FYesirV3Lvw5YT039orgd8FXfS/PEHBhcvC3TGm9e0tm7bw==
X-Received: by 2002:a05:6000:4382:b0:3d1:8d1e:8e9 with SMTP id ffacd0b85a97d-429aefbdfe9mr1681104f8f.32.1761731837363;
        Wed, 29 Oct 2025 02:57:17 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5768sm26116915f8f.24.2025.10.29.02.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:57:16 -0700 (PDT)
Message-ID: <6bbdf4ce-10e3-429b-89fc-ef000f118fec@redhat.com>
Date: Wed, 29 Oct 2025 10:57:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390: fix HugeTLB vmemmap optimization crash
To: Luiz Capitulino <luizcap@redhat.com>, hca@linux.ibm.com,
 borntraeger@linux.ibm.com, joao.m.martins@oracle.com,
 mike.kravetz@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, gor@linux.ibm.com,
 gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com
Cc: osalvador@suse.de, akpm@linux-foundation.org, aneesh.kumar@kernel.org
References: <20251028211533.47694-1-luizcap@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251028211533.47694-1-luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.25 22:15, Luiz Capitulino wrote:
> A reproducible crash occurs when enabling HugeTLB vmemmap optimization (HVO)
> on s390. The crash and the proposed fix were worked on an s390 KVM guest
> running on an older hypervisor, as I don't have access to an LPAR. However,
> the same issue should occur on bare-metal.
> 
> Reproducer (it may take a few runs to trigger):
> 
>   # sysctl vm.hugetlb_optimize_vmemmap=1
>   # echo 1 > /proc/sys/vm/nr_hugepages
>   # echo 0 > /proc/sys/vm/nr_hugepages
> 
> Crash log:
> 
> [   52.340369] list_del corruption. prev->next should be 000000d382110008, but was 000000d7116d3880. (prev=000000d7116d3910)
> [   52.340420] ------------[ cut here ]------------
> [   52.340424] kernel BUG at lib/list_debug.c:62!
> [   52.340566] monitor event: 0040 ilc:2 [#1]SMP
> [   52.340573] Modules linked in: ctcm fsm qeth ccwgroup zfcp scsi_transport_fc qdio dasd_fba_mod dasd_eckd_mod dasd_mod xfs ghash_s390 prng des_s390 libdes sha3_512_s390 sha3_256_s390 virtio_net virtio_blk net_failover sha_common failover dm_mirror dm_region_hash dm_log dm_mod paes_s390 crypto_engine pkey_cca pkey_ep11 zcrypt pkey_pckmo pkey aes_s390
> [   52.340606] CPU: 1 UID: 0 PID: 1672 Comm: root-rep2 Kdump: loaded Not tainted 6.18.0-rc3 #1 NONE
> [   52.340610] Hardware name: IBM 3931 LA1 400 (KVM/Linux)
> [   52.340611] Krnl PSW : 0704c00180000000 0000015710cda7fe (__list_del_entry_valid_or_report+0xfe/0x128)
> [   52.340619]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [   52.340622] Krnl GPRS: c0000000ffffefff 0000000100000027 000000000000006d 0000000000000000
> [   52.340623]            000000d7116d35d8 000000d7116d35d0 0000000000000002 000000d7116d39b0
> [   52.340625]            000000d7116d3880 000000d7116d3910 000000d7116d3910 000000d382110008
> [   52.340626]            000003ffac1ccd08 000000d7116d39b0 0000015710cda7fa 000000d7116d37d0
> [   52.340632] Krnl Code: 0000015710cda7ee: c020003e496f	larl	%r2,00000157114a3acc
>             0000015710cda7f4: c0e5ffd5280e	brasl	%r14,000001571077f810
>            #0000015710cda7fa: af000000		mc	0,0
>            >0000015710cda7fe: b9040029		lgr	%r2,%r9
>             0000015710cda802: c0e5ffe5e193	brasl	%r14,0000015710996b28
>             0000015710cda808: e34090080004	lg	%r4,8(%r9)
>             0000015710cda80e: b9040059		lgr	%r5,%r9
>             0000015710cda812: b9040038		lgr	%r3,%r8
> [   52.340643] Call Trace:
> [   52.340645]  [<0000015710cda7fe>] __list_del_entry_valid_or_report+0xfe/0x128
> [   52.340649] ([<0000015710cda7fa>] __list_del_entry_valid_or_report+0xfa/0x128)
> [   52.340652]  [<0000015710a30b2e>] hugetlb_vmemmap_restore_folios+0x96/0x138
> [   52.340655]  [<0000015710a268ac>] update_and_free_pages_bulk+0x64/0x150
> [   52.340659]  [<0000015710a26f8a>] set_max_huge_pages+0x4ca/0x6f0
> [   52.340662]  [<0000015710a273ba>] hugetlb_sysctl_handler_common+0xea/0x120
> [   52.340665]  [<0000015710a27484>] hugetlb_sysctl_handler+0x44/0x50
> [   52.340667]  [<0000015710b53ffa>] proc_sys_call_handler+0x17a/0x280
> [   52.340672]  [<0000015710a90968>] vfs_write+0x2c8/0x3a0
> [   52.340676]  [<0000015710a90bd2>] ksys_write+0x72/0x100
> [   52.340679]  [<00000157111483a8>] __do_syscall+0x150/0x318
> [   52.340682]  [<0000015711153a5e>] system_call+0x6e/0x90
> [   52.340684] Last Breaking-Event-Address:
> [   52.340684]  [<000001571077f85c>] _printk+0x4c/0x58
> [   52.340690] Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> This issue was introduced by commit f13b83fdd996 ("hugetlb: batch TLB
> flushes when freeing vmemmap"). Before that change, the HVO
> implementation called flush_tlb_kernel_range() each time a vmemmap
> PMD split and remapping was performed. The mentioned commit changed this
> to issue a few flush_tlb_all() calls after performing all remappings.
> 
> However, on s390, flush_tlb_kernel_range() expands to
> __tlb_flush_kernel() while flush_tlb_all() is not implemented. As a
> result, we went from flushing the TLB for every remapping to no flushing
> at all.
> 
> This commit fixes this by implementing flush_tlb_all() on s390 as an
> alias to __tlb_flush_global(). This should cause a flush on all TLB
> entries on all CPUs as expected by the flush_tlb_all() semantics.
> 
> Fixes: f13b83fdd996 ("hugetlb: batch TLB flushes when freeing vmemmap")
> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
> ---

Nice finding!

Makes me wonder whether the default flush_tlb_all() should actually map 
to a BUILD_BUG(), such that we don't silently not-flush on archs that 
don't implement it.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


