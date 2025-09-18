Return-Path: <linux-kernel+bounces-794686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC20FB3E59C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C187E441C96
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B987335BDB;
	Mon,  1 Sep 2025 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5nrA4z3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ED8335BD0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733994; cv=none; b=KK80mAXp/WY5vr/0LlSOJAT/9FmDRrHkaPIWymV363p6UPgg3ws6SVZzCPnD9P5a/l0o/sooLfEXtbS70k4s1wlEzeNT6qTXFfwi2H6e/7I7KxYGhlYbYr4Mwgq+njfczS9lKyubKw8dO5qe4QKlkddyex8jh2kGQYdmG83XagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733994; c=relaxed/simple;
	bh=l0B6/z2BXWF5cKbgkiXKqZB4NZ/mtQWLtd4KFskMv1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VX6xOje1XMDCCiRYvggTlsryWyfANETbU/nlPDEbtYtzjdyiEfsL8tb7Z0jFxk3P34MVv58JzGRMv7OkYB7pbnHqqsp00uOlbEJRtoYWQ93cyFs572AlCdy1Zco3e8iM8RxUSqgVtnLCiECHJ9XJkXH1RBLmvBvb6BBeLbavvwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5nrA4z3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756733990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H3id/gOofLyuF/iZzklWJhNUkAhzxEH18RZFHORTa7Q=;
	b=S5nrA4z35c09AVrVMVEYu9HROB7xDPqxipPRCtLU2RLNkXz+1KIXCCKshj3n0TwBOxomej
	D+kkFksgwX8R/ca4sDAxtdTsMPIRuvMS+6d4M2vR9CZ7nrghls21sF2uj/FrusTg4CHEMb
	NQcpCfyya+y1t0mWbjeTAvoAptPX9DI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-zBj1w9yVPQGp13vKyYxpdA-1; Mon, 01 Sep 2025 09:39:48 -0400
X-MC-Unique: zBj1w9yVPQGp13vKyYxpdA-1
X-Mimecast-MFC-AGG-ID: zBj1w9yVPQGp13vKyYxpdA_1756733987
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so41202205e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 06:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733987; x=1757338787;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3id/gOofLyuF/iZzklWJhNUkAhzxEH18RZFHORTa7Q=;
        b=YtSBVYn5MgUy7t7Iin6ghqFKm+4xcPDPBjuYlR8StCpLjCnn+RL/5iDcqrnwpf67PC
         wTlGtwRYx9m7Z1qpD8UunNwai0m6e8f4mgnPRLhoDW084dGPP661WBNi9woK8lrlYuOs
         3JT3U2L5Z1maiF6QHOlgvn00iGp3JQOWfgHjASHGsZZ1EuD45WEPbzgMVeB4tFfNXA6L
         7nOTZ02tlvrLAJC2oJ6j+8brN6LNjfLfmc4BAdT+bUXdHazAEneZ6jg1G0jSrsQ4CbXL
         oCWDQCLpXSne6wI0ZNBRjcV/DptfPPpW+tcYRcbCpY7KgOekYMBSREqbnTTrE2WdM/p8
         roCg==
X-Forwarded-Encrypted: i=1; AJvYcCUXJuBpjfHwF4XP3HUcmJ52jNDnQZ5tuKckJjRXXLGRT7OuYrcxKJcnaUvTxV2+ubCOzj4XXqL1nEp0/VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzY3zGy3QieQCy7Y6A//a1lDWWxYQnYVNvEWru9ZMwoHFfcI/Q
	1Wi7ssa3jLxg0E9jpeuJ0u7XFLA5DRx1oBrlxAhTKFjjn3clwz5aSKd72Lu1eWP/23kCd6QndGq
	noVf4gEWMej+7RwXl7BdHTAjeDI1c1CaJ7HsVaFmNonUW/jw1kSSp6L+Hje51FMrU1w==
X-Gm-Gg: ASbGnctPdIdgMXniH5GkIZwn9j9PR9uovNHPtBHCMBx7oNYF8vU1MPjkjUtZju4ZOzG
	MCK1FvpEAgdUUvMVSkmlrtfsSP0yS7Sw6J4cqB3qCPOnFrqlc5aQtewTZWXtQGdiAtBQMC87Vyg
	m8RSjzu0RRbSgz2maBakY5t77W9Ao2fN5eA8rgQpBDAheVYYp4wTDAsHocxuKnIFI9boezpF76c
	LodfEYe67WojvgkFPOt3s7G5IGoO9e7dGrJf07l4bg9+J0Rl9KHN+9Aiip+x7EwrIxRNfzhm/8p
	amAhp44quSEFjCT0KfQe8my0eUhE6qLY6RciUYU0gXn/CzSpB+Bsq06/l1efbpnmwvAyw1jfWAX
	2HepafI52qZWGOFPmpCCBrM5YFsAFSKHnoBul10LpA71iy8nDDVn0X2bnag0odAVmO38=
X-Received: by 2002:a05:6000:659:10b0:3d2:633f:d02e with SMTP id ffacd0b85a97d-3d2634f1711mr4945711f8f.2.1756733987316;
        Mon, 01 Sep 2025 06:39:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF16bYB/CPbtI8bBu7Fukc9/QEkuztuZV5dc0Mxq3hfWjQ0mUxmJtka4Y09bvawf1aVKd4/5g==
X-Received: by 2002:a05:6000:659:10b0:3d2:633f:d02e with SMTP id ffacd0b85a97d-3d2634f1711mr4945678f8f.2.1756733986750;
        Mon, 01 Sep 2025 06:39:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6fe5sm238421945e9.5.2025.09.01.06.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:39:46 -0700 (PDT)
Message-ID: <72558e21-2ebf-448a-a93a-3d1a3181a592@redhat.com>
Date: Mon, 1 Sep 2025 15:39:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arch: copy_thread: pass clone_flags as u64
To: schuster.simon@siemens-energy.com, Dinh Nguyen <dinguyen@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com,
 selinux@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org
References: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
 <20250901-nios2-implement-clone3-v2-3-53fcf5577d57@siemens-energy.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901-nios2-implement-clone3-v2-3-53fcf5577d57@siemens-energy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 15:09, Simon Schuster via B4 Relay wrote:
> From: Simon Schuster <schuster.simon@siemens-energy.com>
> 
> With the introduction of clone3 in commit 7f192e3cd316 ("fork: add
> clone3") the effective bit width of clone_flags on all architectures was
> increased from 32-bit to 64-bit, with a new type of u64 for the flags.
> However, for most consumers of clone_flags the interface was not
> changed from the previous type of unsigned long.
> 
> While this works fine as long as none of the new 64-bit flag bits
> (CLONE_CLEAR_SIGHAND and CLONE_INTO_CGROUP) are evaluated, this is still
> undesirable in terms of the principle of least surprise.
> 
> Thus, this commit fixes all relevant interfaces of the copy_thread
> function that is called from copy_process to consistently pass
> clone_flags as u64, so that no truncation to 32-bit integers occurs on
> 32-bit architectures.
> 
> Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
> ---
>   arch/alpha/kernel/process.c      | 2 +-
>   arch/arc/kernel/process.c        | 2 +-
>   arch/arm/kernel/process.c        | 2 +-
>   arch/arm64/kernel/process.c      | 2 +-
>   arch/csky/kernel/process.c       | 2 +-
>   arch/hexagon/kernel/process.c    | 2 +-
>   arch/loongarch/kernel/process.c  | 2 +-
>   arch/m68k/kernel/process.c       | 2 +-
>   arch/microblaze/kernel/process.c | 2 +-
>   arch/mips/kernel/process.c       | 2 +-
>   arch/nios2/kernel/process.c      | 2 +-
>   arch/openrisc/kernel/process.c   | 2 +-
>   arch/parisc/kernel/process.c     | 2 +-
>   arch/powerpc/kernel/process.c    | 2 +-
>   arch/riscv/kernel/process.c      | 2 +-
>   arch/s390/kernel/process.c       | 2 +-
>   arch/sh/kernel/process_32.c      | 2 +-
>   arch/sparc/kernel/process_32.c   | 2 +-
>   arch/sparc/kernel/process_64.c   | 2 +-
>   arch/um/kernel/process.c         | 2 +-
>   arch/x86/include/asm/fpu/sched.h | 2 +-
>   arch/x86/include/asm/shstk.h     | 4 ++--
>   arch/x86/kernel/fpu/core.c       | 2 +-
>   arch/x86/kernel/process.c        | 2 +-
>   arch/x86/kernel/shstk.c          | 2 +-
>   arch/xtensa/kernel/process.c     | 2 +-
>   26 files changed, 27 insertions(+), 27 deletions(-)
> 

(Adjust To: list)

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


