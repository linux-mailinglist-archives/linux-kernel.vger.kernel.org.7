Return-Path: <linux-kernel+bounces-846283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B9FBC7780
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 07:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441113E6107
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 05:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939ED23D7EB;
	Thu,  9 Oct 2025 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCLSU75p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FC9238175;
	Thu,  9 Oct 2025 05:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989364; cv=none; b=ulOWDZGkcOF7dH6t9hCf7WFjPqoMDV10oV9P/IiACmnLW3uadFLGyybk4ZRyOrJEE8cKInaOBhF2p8M8+Wr7yimxLfZI5eeztInGZqMMeGqotSgUFoagR3OrfwdQ0thZGkFwM6TKUXHFLLoVX9uzu9hf1dVbB+55Y3eeo/63K/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989364; c=relaxed/simple;
	bh=4Q58jztL4eaTDstPcFnxmFuXsHFst5YdtTLFjj8sN/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZwF07KpcZxHCVRePnh4IB8GnE8M7CHWfLfbLpSFbx2PcUPZGuBiS0yNilKITqaxds1AkxcFRmnq/9g/KhfY22g9XoQuVBB8aILz9Qg3slPvWAMpUI0baExqdttesKTI58lOLU9XMmDUrsktf1u0w5cdlUxGsEVbInA4HHhZbug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCLSU75p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345F9C4CEE7;
	Thu,  9 Oct 2025 05:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759989363;
	bh=4Q58jztL4eaTDstPcFnxmFuXsHFst5YdtTLFjj8sN/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WCLSU75pcKH4FEV87JlsZujdbvocP81unq/d5sf6m0nvLSmIqAZhXS3Li6+9yINxZ
	 ImML9ALdS5728st9TPqyovdnvi3J7EfL3W1Aj4tqQthrghCNs3oiWYz727pP/RPH7G
	 l7sXm0CQVUv93/07zL+H/ndRoBDfmWMUHcS7W2XrkdIJ8rVqkb+a7Z8vTx6rVljARH
	 qB+n4LlmRAPEUDYtuC0NT+Sd9QPq3u/ouF2HUA+2zpIIy4TMeaKoOE2VoNAPuPL7iY
	 b+7Fk1MVmj5dOW/p4kRbM0nihbiAVPtr9HkBMkiI9cpnqF7cp7RtHzurXaktB1PJ9b
	 h5UXs2V84og2Q==
Date: Thu, 9 Oct 2025 07:55:57 +0200
From: Greg Kroah-Hartman <gregkh@kernel.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	=?iso-8859-1?Q?Jo=E3o_P=F3voas?= <joao.povoas@suse.com>
Subject: Re: CVE-2022-50450: libbpf: Use elf_getshdrnum() instead of e_shnum
Message-ID: <2025100912-ambiguity-emblem-1f96@gregkh>
References: <2025100116-CVE-2022-50450-7ef7@gregkh>
 <ptkuwiorj7dby6ofq4thv6mxtu7kf2zgb4grpyng3ygjv6oyi2@3dsumpqpjrst>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ptkuwiorj7dby6ofq4thv6mxtu7kf2zgb4grpyng3ygjv6oyi2@3dsumpqpjrst>

On Thu, Oct 09, 2025 at 01:31:32PM +0800, Shung-Hsi Yu wrote:
> On Wed, Oct 01, 2025 at 01:45:20PM +0200, Greg Kroah-Hartman wrote:
> > From: Greg Kroah-Hartman <gregkh@kernel.org>
> > 
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > libbpf: Use elf_getshdrnum() instead of e_shnum
> > 
> > This commit replace e_shnum with the elf_getshdrnum() helper to fix two
> > oss-fuzz-reported heap-buffer overflow in __bpf_object__open. Both
> > reports are incorrectly marked as fixed and while still being
> > reproducible in the latest libbpf.
> > 
> >   # clusterfuzz-testcase-minimized-bpf-object-fuzzer-5747922482888704
> >   libbpf: loading object 'fuzz-object' from buffer
> >   libbpf: sec_cnt is 0
> >   libbpf: elf: section(1) .data, size 0, link 538976288, flags 2020202020202020, type=2
> >   libbpf: elf: section(2) .data, size 32, link 538976288, flags 202020202020ff20, type=1
> >   =================================================================
> >   ==13==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x6020000000c0 at pc 0x0000005a7b46 bp 0x7ffd12214af0 sp 0x7ffd12214ae8
> >   WRITE of size 4 at 0x6020000000c0 thread T0
> >   SCARINESS: 46 (4-byte-write-heap-buffer-overflow-far-from-bounds)
> >       #0 0x5a7b45 in bpf_object__elf_collect /src/libbpf/src/libbpf.c:3414:24
> >       #1 0x5733c0 in bpf_object_open /src/libbpf/src/libbpf.c:7223:16
> >       #2 0x5739fd in bpf_object__open_mem /src/libbpf/src/libbpf.c:7263:20
> >       ...
> > 
> > The issue lie in libbpf's direct use of e_shnum field in ELF header as
> > the section header count. Where as libelf implemented an extra logic
> > that, when e_shnum == 0 && e_shoff != 0, will use sh_size member of the
> > initial section header as the real section header count (part of ELF
> > spec to accommodate situation where section header counter is larger
> > than SHN_LORESERVE).
> > 
> > The above inconsistency lead to libbpf writing into a zero-entry calloc
> > area. So intead of using e_shnum directly, use the elf_getshdrnum()
> > helper provided by libelf to retrieve the section header counter into
> > sec_cnt.
> > 
> > The Linux kernel CVE team has assigned CVE-2022-50450 to this issue.
> 
> Hi Greg,
> 
> I'd like to dispute this CVE. The libbpf maintainer previously suggested
> such issue are viewed as normal bug fix, and not be considered for CVE
> assignment[1,2].
> 
> Quoting Andrii from previous discussion in "CVE-2023-52592: libbpf: Fix
> NULL pointer dereference in bpf_object__collect_prog_relos"[1] below:
> 
> > Libbpf isn't meant to be fed untrusted ELF files, as it's normally
> > used under root to perform BPF operations. So we generally treat these
> > issues of malformed ELF crashing libbpf as just normal bugs, not as a
> > security vulnerability. We even had issues where libelf crashed before
> > libbpf could do anything at all. But this happens only for
> > fuzzer-generated artificial test cases. In practice compilers produce
> > valid ELFs and that's what real world applications are ever going to
> > use.
> > 
> > ...
> > 
> > tl;dr: I wouldn't assign CVE for such issues, thanks.

Very good point, sorry about that.  I should have caught this in the
re-review of these, my fault.  Will go reject this now, thanks for the
review!

greg k-h

