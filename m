Return-Path: <linux-kernel+bounces-846266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A194EBC76E8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 07:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75D0D4F0435
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 05:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4172425DD1E;
	Thu,  9 Oct 2025 05:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D28gY1Vh"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA4D34BA49
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 05:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759987908; cv=none; b=VRsSNCw1C7ytYTPebDWtkiowP2cCWIhUxOozh6cpT+I58rYywlNVIrdBECzTudmgBdIKn84dyqXKsIrMcKZxstWVlOfjxrY3lAFNvltMIacvKjMnu+JcJdjezpQo7lPGU9I8QVmFYue2ZJHYaqb2CONNyncGBC+0snRsxsQkLtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759987908; c=relaxed/simple;
	bh=DtYjP+vXLXgAZNxBX24Bk0iIqisASSxMWtQytwpIfX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MX/pfsrzv3r8tbWTOllKJow7DmavtArZiIyrdRIjgZxMAdLo6e9W9coZQBrWybU106NF/a1FJegtELikTt2/KrJF1Tb01ItiKdLWVN27IE1LQye6gRyL+KXMWhr+RFSVUIdnubdwLOo5INA9Di72VdrDSX7ils4a5M+CEaTQ5qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D28gY1Vh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f44000626bso422816f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 22:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759987905; x=1760592705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yHOn7kSJUuZzuRLr1EeBDE27yXsJobQdyRlQ5XfVZzQ=;
        b=D28gY1VhafkJDLh2jGgXqCnXk+41QM8M7Nf78aO2mf4WGpnaWTK7RqHLhLtpcrW6VE
         qxSW6bosaMq4YoB/xnt9dQ/pe+2yLCJMjgPKlvjtvgVzmzyKk6x0aSKaDvwRVJVY7rNL
         ROR8up+bDoowKFxtOifbfxufU+RVzGVXtmxNvOoiahkc6u8TSaXW1B65Xh/1LBvqVymh
         yF3z7lNAhB2+PMkoKvXYtoD8L/kYEfBK+YawfoEWIXUMVj597mobUFxfc0VGmQ7JOIct
         AZXSTYUhEZHZunZiI2l2a13FJHdU5jujDEv8uJRO8hXShNhgDkP2PUvyQQ1sou6yP6LV
         MG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759987905; x=1760592705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHOn7kSJUuZzuRLr1EeBDE27yXsJobQdyRlQ5XfVZzQ=;
        b=BxN2yEF5PvNj1x6B7ppDVj+ozai0A86XSAFu//e5DcJEjKNMr7GLM/hC7VL15+If1q
         RJCOV76NlyQCSqm6s55TTvO/CyikdIf18cWyNEKLKTwRfDYo750oIsouyA82bix4JEx7
         H7CMwrqPor/JYspzauHigJMpNP7YUi5lZfbhvXeJlV5VWKlKTX9yukAASUjbG2uLDnUg
         p6ke2i+zqIKDUoSH9bDjhV+96RPu80daFg+x+c8Ehw8HPDBp75cbZiZT7eKGKujebbv1
         BpuhIAGcjLOE/mn66Xy2/dOvpXLba1Ia2KKKWJExJ1hgX1Fh45V/9KMEWQLXODj1f5lf
         paNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbsqJQv7byoDzuVPUmK213n1t69qn45e5l5VazrsLiIboz0buOg0DlgtUMXz9gcdemduUSPepsRixBVtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4VORidSKnQ/iq4IEuvdF+82Ds32tfR7Mq+hbMVaNFKVBBcvUd
	I9UgAZE1DyYMWr7UF1LHRk+DIy/m8VFsRtWlqQSpvYcXrL7zvV6rUDig5vwW9xOiGJ0=
X-Gm-Gg: ASbGnctiiVvNj0PTtbplVEoisn86yt6Wjgb7lrAMKxiNYkm63Snu9FKYu+JueQypEaA
	qBgHCnAPMb0UzPa+m2wipR76zKM/qApv5ZjOdqIPnrKTflGzDYRlbp0aDEa97A+pLXgJR9icc/4
	T3nLu8W1oiwIMHutGqDVqDdFpWYnZnFhMv+tXGLccO5bC1EFhv2U5EYmkRrzhd3KTmoXeRCBqj0
	V0Evs/9IbOTt6hSF3AaCWbc9P/CJRJfyNRm7YYwximU7fGJ1LqbbqyYlCElr35qqmbUVfEW7BNd
	Q7Z4vfKGHN+u7NBJXFlSeA6rGws6h+h/4BD3+rlYznK4IAuoh4svabu4ZNY1VGRtmdJR4b2HcuD
	ket+Yejj52KCoCHIvkMgafuMLjSCMCd+LXxRZUsCvxzwkTG/qVjrXcTkpAQfj9Wl4illOvvvcWa
	7vnto1
X-Google-Smtp-Source: AGHT+IH0+WOm7wLSz7CqoEeSNxHJVjj0HcdHxJggm0dkGfXWhUMxvQNA/sy9WZaKNmunfer1xkN/gg==
X-Received: by 2002:a05:6000:258a:b0:425:8bc2:9c4b with SMTP id ffacd0b85a97d-42666abb51amr3110198f8f.6.1759987904570;
        Wed, 08 Oct 2025 22:31:44 -0700 (PDT)
Received: from u94a (27-240-56-184.adsl.fetnet.net. [27.240.56.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8b0068sm32973811f8f.26.2025.10.08.22.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 22:31:44 -0700 (PDT)
Date: Thu, 9 Oct 2025 13:31:32 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@kernel.org>, =?utf-8?B?Sm/Do28gUMOzdm9hcw==?= <joao.povoas@suse.com>
Subject: Re: CVE-2022-50450: libbpf: Use elf_getshdrnum() instead of e_shnum
Message-ID: <ptkuwiorj7dby6ofq4thv6mxtu7kf2zgb4grpyng3ygjv6oyi2@3dsumpqpjrst>
References: <2025100116-CVE-2022-50450-7ef7@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025100116-CVE-2022-50450-7ef7@gregkh>

On Wed, Oct 01, 2025 at 01:45:20PM +0200, Greg Kroah-Hartman wrote:
> From: Greg Kroah-Hartman <gregkh@kernel.org>
> 
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> libbpf: Use elf_getshdrnum() instead of e_shnum
> 
> This commit replace e_shnum with the elf_getshdrnum() helper to fix two
> oss-fuzz-reported heap-buffer overflow in __bpf_object__open. Both
> reports are incorrectly marked as fixed and while still being
> reproducible in the latest libbpf.
> 
>   # clusterfuzz-testcase-minimized-bpf-object-fuzzer-5747922482888704
>   libbpf: loading object 'fuzz-object' from buffer
>   libbpf: sec_cnt is 0
>   libbpf: elf: section(1) .data, size 0, link 538976288, flags 2020202020202020, type=2
>   libbpf: elf: section(2) .data, size 32, link 538976288, flags 202020202020ff20, type=1
>   =================================================================
>   ==13==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x6020000000c0 at pc 0x0000005a7b46 bp 0x7ffd12214af0 sp 0x7ffd12214ae8
>   WRITE of size 4 at 0x6020000000c0 thread T0
>   SCARINESS: 46 (4-byte-write-heap-buffer-overflow-far-from-bounds)
>       #0 0x5a7b45 in bpf_object__elf_collect /src/libbpf/src/libbpf.c:3414:24
>       #1 0x5733c0 in bpf_object_open /src/libbpf/src/libbpf.c:7223:16
>       #2 0x5739fd in bpf_object__open_mem /src/libbpf/src/libbpf.c:7263:20
>       ...
> 
> The issue lie in libbpf's direct use of e_shnum field in ELF header as
> the section header count. Where as libelf implemented an extra logic
> that, when e_shnum == 0 && e_shoff != 0, will use sh_size member of the
> initial section header as the real section header count (part of ELF
> spec to accommodate situation where section header counter is larger
> than SHN_LORESERVE).
> 
> The above inconsistency lead to libbpf writing into a zero-entry calloc
> area. So intead of using e_shnum directly, use the elf_getshdrnum()
> helper provided by libelf to retrieve the section header counter into
> sec_cnt.
> 
> The Linux kernel CVE team has assigned CVE-2022-50450 to this issue.

Hi Greg,

I'd like to dispute this CVE. The libbpf maintainer previously suggested
such issue are viewed as normal bug fix, and not be considered for CVE
assignment[1,2].

Quoting Andrii from previous discussion in "CVE-2023-52592: libbpf: Fix
NULL pointer dereference in bpf_object__collect_prog_relos"[1] below:

> Libbpf isn't meant to be fed untrusted ELF files, as it's normally
> used under root to perform BPF operations. So we generally treat these
> issues of malformed ELF crashing libbpf as just normal bugs, not as a
> security vulnerability. We even had issues where libelf crashed before
> libbpf could do anything at all. But this happens only for
> fuzzer-generated artificial test cases. In practice compilers produce
> valid ELFs and that's what real world applications are ever going to
> use.
> 
> ...
> 
> tl;dr: I wouldn't assign CVE for such issues, thanks.

1: https://lore.kernel.org/all/CAEf4BzbvmwmAmZMvzo9gxyUwy9SQvC_2gFQ1wO-Zvw=9BT=J2g@mail.gmail.com/
2: https://lore.kernel.org/all/CAEf4Bzb2S+1TonOp9UH86r0e6aGG2LEA4kwbQhJWr=9Xju=NEw@mail.gmail.com/

[...]

