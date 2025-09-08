Return-Path: <linux-kernel+bounces-806734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF25AB49B20
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637017B454E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E302D94BC;
	Mon,  8 Sep 2025 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9KGOyzH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70842D948D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757363551; cv=none; b=b4nK+bWZpsG44phZbeOKUtV1CwfEnHyAUM9zJoNKyIzutb25bGF+wMMC+8fLPa3jUXkBX8RzSYH2kUzIOo3l2JpFVYupaGXdiyasJNtIgUYPwQjRiYpB+xtm+aeHGN+Fckm0MFdHlkx0yHj9Qs3V2apGpXbqaVqlBUduZauZtOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757363551; c=relaxed/simple;
	bh=ISzBikuO5/AQUfbX6TaDawBdF3DKRyP9ExusajZudB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhVT4uT1AzHTSs6bdQYWvJqqoIOpkEeevwR+5S+AknRhUjr7Q1k8L23Nvl0T/zYxRwZfWBqkYpbVrT9xkyiRZgXE+txIHxn/Uv2BQ6vFEb9yG43BWuqegwpsbB7FF315gm0Nnqf7PtlM4aI9WTI1UaDnny2+dlxthQk6p9h0ixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9KGOyzH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757363548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1ybgcdEsM9ns8A+Pl8rfnblzohG3wZoz4Ud/GugpTAQ=;
	b=R9KGOyzHsCXnA2VpBwktUe/s56br26ht6g54iKVzZ1ow/nMu+SQIGhazTA2UyfaqCjC3K/
	pv3lLegT6AqJ9JDSAnlB6Z5D8F/X0Ed5vMLG6D9F5yUDga8kk6zD8eNibLTIS+3V2LHdvN
	+wg/xJIwAKs7g8EEfQOqqKC2RYOX/us=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-kWqBH14fOfGPzKiBBmUp5Q-1; Mon, 08 Sep 2025 16:32:27 -0400
X-MC-Unique: kWqBH14fOfGPzKiBBmUp5Q-1
X-Mimecast-MFC-AGG-ID: kWqBH14fOfGPzKiBBmUp5Q_1757363546
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3e61deaf253so1710187f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 13:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757363546; x=1757968346;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ybgcdEsM9ns8A+Pl8rfnblzohG3wZoz4Ud/GugpTAQ=;
        b=SVDKNWm/ND+PJ9hooQWo3wcECcjfHy21iJKmTU00oMUPHWrDrrRD1hZ991iu5dCgPf
         JXSAidj9y0rbVkbmIXqK+/Y0RegJMggfQjYO3hBLboI3x2nn9nBpxTdegr1EFuBdtP8s
         sFlE922QxqkvBH5golAm5GksaAMqfs9BCjQ5zQVXlPndRluDLtbRyluGIYBU1sJlf0i8
         38SZ1RG2ERD9d0pmoMKPHZ6KQkC8ImiTvUL6fjDh5atuYo1IKCuo9ArlfFzXjZ8PgVVs
         Jhwb9buWNBlxlSzWZ8IOnWRWvfaTrRT+Gc7d0sePOd1Yer/INjozNT4zcuKIDYXWj3Ed
         hMEg==
X-Forwarded-Encrypted: i=1; AJvYcCUqGlzeH7XDjSQjrkDmjLwJit8BUWlm+EsP/pF8rrqfX9Q1rvEiXbcsYTnQFeqDuArcMSHMYF51DYhqKWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQmuyVux9vK6Il+vfvuuvBz5pUPqxFDnZavH37x6HoylfCjBSI
	+ncW7UaGIpgR0b/OR5yNIlogxg3vG6ZbZo5CxCJgGqRwguxOKX10lK2XDo9xi6ODEeGop4X7RBc
	Ga1rr5a2FB+RGRIEo8XiairhuT6MJZ3+UdlJS9adpQik1vSHrSdtYPo8K74BAi4Ym4A==
X-Gm-Gg: ASbGncuw7+5B0rdUFJWLpaU116crtmAa6xbwnv0K/B59ts/BYddyIubJLP4BbAb1T1U
	NatZwHvbymXFwmeimD42go2gQo1lOYf3dptX3+OUgkiFTUL3c5HN5ELkvjsS8afp8OdOu5mju8Q
	kN9m09eNuzSEz+0zoyP+6r6Ing/dfSSeJkwBGixRxDGu6g7GyHob7BtFHBZdF6K/K4kJEFsHWNB
	k1ExP09zsseIzp4vBIXoRNrx/pCicFZove5WU0uiCnLMfhLDsOitvpB0GDzaG/5dM5T8xL/hYLd
	mxv4Fm+RkIxeYQhJa3dNVnzHah2HQtlrf39GudUj8zQzvcaCls7asgAX/Tx13KH1vym3Lxw=
X-Received: by 2002:a05:6000:40da:b0:3e2:b2f0:6e57 with SMTP id ffacd0b85a97d-3e642f91589mr8254852f8f.36.1757363546312;
        Mon, 08 Sep 2025 13:32:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuDegDqgJ6N0gGE/Lb3UGdgK1piEs+PdHsr5oQcTDbsibAuF1ZyiUHJADT2Pc11YvmZEdCvw==
X-Received: by 2002:a05:6000:40da:b0:3e2:b2f0:6e57 with SMTP id ffacd0b85a97d-3e642f91589mr8254820f8f.36.1757363545827;
        Mon, 08 Sep 2025 13:32:25 -0700 (PDT)
Received: from [192.168.3.141] (p57a1ae98.dip0.t-ipconnect.de. [87.161.174.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d701622b92sm31349052f8f.58.2025.09.08.13.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 13:32:25 -0700 (PDT)
Message-ID: <5b7e71e8-4e31-4699-b656-c35dce678a80@redhat.com>
Date: Mon, 8 Sep 2025 22:32:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/22] Add support for shared PTEs across processes
To: Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de,
 bp@alien8.de, brauner@kernel.org, bsegall@google.com, corbet@lwn.net,
 dave.hansen@linux.intel.com, dietmar.eggemann@arm.com,
 ebiederm@xmission.com, hpa@zytor.com, jakub.wartak@mailbox.org,
 jannh@google.com, juri.lelli@redhat.com, khalid@kernel.org,
 liam.howlett@oracle.com, linyongting@bytedance.com,
 lorenzo.stoakes@oracle.com, luto@kernel.org, markhemm@googlemail.com,
 maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, mhocko@suse.com,
 mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de, osalvador@suse.de,
 pcc@google.com, peterz@infradead.org, pfalcato@suse.de, rostedt@goodmis.org,
 rppt@kernel.org, shakeel.butt@linux.dev, surenb@google.com,
 tglx@linutronix.de, vasily.averin@linux.dev, vbabka@suse.cz,
 vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com,
 willy@infradead.org, x86@kernel.org, xhao@linux.alibaba.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250820010415.699353-1-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.08.25 03:03, Anthony Yznaga wrote:
> Memory pages shared between processes require page table entries
> (PTEs) for each process. Each of these PTEs consume some of
> the memory and as long as the number of mappings being maintained
> is small enough, this space consumed by page tables is not
> objectionable. When very few memory pages are shared between
> processes, the number of PTEs to maintain is mostly constrained by
> the number of pages of memory on the system. As the number of shared
> pages and the number of times pages are shared goes up, amount of
> memory consumed by page tables starts to become significant. This
> issue does not apply to threads. Any number of threads can share the
> same pages inside a process while sharing the same PTEs. Extending
> this same model to sharing pages across processes can eliminate this
> issue for sharing across processes as well.
> 
> Some of the field deployments commonly see memory pages shared
> across 1000s of processes. On x86_64, each page requires a PTE that
> is 8 bytes long which is very small compared to the 4K page
> size. When 2000 processes map the same page in their address space,
> each one of them requires 8 bytes for its PTE and together that adds
> up to 8K of memory just to hold the PTEs for one 4K page. On a
> database server with 300GB SGA, a system crash was seen with
> out-of-memory condition when 1500+ clients tried to share this SGA
> even though the system had 512GB of memory. On this server, in the
> worst case scenario of all 1500 processes mapping every page from
> SGA would have required 878GB+ for just the PTEs. If these PTEs
> could be shared, the a substantial amount of memory saved.
> 
> This patch series implements a mechanism that allows userspace
> processes to opt into sharing PTEs. It adds a new in-memory
> filesystem - msharefs. A file created on msharefs represents a
> shared region where all processes mapping that region will map
> objects within it with shared PTEs. When the file is created,
> a new host mm struct is created to hold the shared page tables
> and vmas for objects later mapped into the shared region. This
> host mm struct is associated with the file and not with a task.
> When a process mmap's the shared region, a vm flag VM_MSHARE
> is added to the vma. On page fault the vma is checked for the
> presence of the VM_MSHARE flag. If found, the host mm is
> searched for a vma that covers the fault address. Fault handling
> then continues using that host vma which establishes PTEs in the
> host mm. Fault handling in a shared region also links the shared
> page table to the process page table if the shared page table
> already exists.

Regarding the overall design, two important questions:

In the context of this series, how do we handle VMA-modifying functions 
like mprotect/some madvise/mlock/mempolicy/...? Are they currently 
blocked when applied to a mshare VMA?

And how are we handling other page table walkers that don't modify VMAs 
like MADV_DONTNEED, smaps, migrate_pages, ... etc?


-- 
Cheers

David / dhildenb


