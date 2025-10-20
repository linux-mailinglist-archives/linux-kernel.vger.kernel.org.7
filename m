Return-Path: <linux-kernel+bounces-861337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7678FBF2743
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B4C44E56B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46B428C854;
	Mon, 20 Oct 2025 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcq7EZDj"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F342877D0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978058; cv=none; b=muKZ8bUbumMYL19iDXhvZcvGZje0xGNCfYhcBE9UPCc8GxblZwKK/KgGNcrNs7p50XxjDSk0B9ydWrNZKQ1ottbxktE2vXvfD4QoSZuknL82RJUDLUNqfuUHKqE6q+lE8bhYz7rZqEKQwgkSHmY4eRFWPXSt0HYbaHQ5wySC/og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978058; c=relaxed/simple;
	bh=B8q5ZAlve72N7q6bvOSXGkHTppjdvye5yLKtODQe/Mo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MREYkwwLd3bzqtnoQMHIdXgMeXAFk57mauH5Bvx7+uwQnO5wJprxVxN2gxW+sDT8I2AX8CFCN5o+BahW9474gYQrYs7cAGTF0tPYxYW3RDGX9Dlasf+oARf/ZBjOjvEbMMuS4HT5L9v/dWkTP40VmsugQTGzWK1IL88SVJgMJJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcq7EZDj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bc5d7c289so7913687a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760978056; x=1761582856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U281t6YsVgadzh80Xr8uQlzQ8nsQRfoBdqQApEXayt4=;
        b=dcq7EZDjwWiHAZyzfGC8GfQ66wVeP6gg7+gGYh6IdU56TYcbEZR5uRlVrImMmGH7iX
         BXWoAFtLzFNV+gBUVYSgLNc21P3cuNSSuyKpqPRGgIUx0XaiXa+nEIEz+3hswjVWdXC5
         f2VQ7qOincIP7mxfMuyXSfTA8H1TSupY0e6IKOBKTiBgSWqk0trO69wfC0MkHTpS8aDg
         7UEkZdc3jqjc8397mEte8msJtaSx6JsicUf+icc5oKMFqrA6DRA1ueBUdqWOR/igORQ4
         2iFPY8xJs9MhrSVb/py5VnwKPagHTnZh14SBqm4ShZxAY/h2joDEa2rd2KCPsyF3ADdL
         pNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760978056; x=1761582856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U281t6YsVgadzh80Xr8uQlzQ8nsQRfoBdqQApEXayt4=;
        b=RLHNpOCyyhaMUpf7QRy0MPrrOO+qt38YnVzdiJ5+hgWBrM+hluBkQGENtCwHMs4HSe
         Fo699wUM1xRCfmlsjSBxtAvAI6ndA1z6EsdDMvyVY4tToCyrgqGteX09kSUWkH7YKVxo
         PD74BriCFTdn4fZxpeIGBFJmDzlo1n7vFV/VlX96T67YR92npsmcsValWxMMjDAsuWvv
         uOcUc4wVfeUkRbEcobQhXm8776wPQ4ySNHSS0k++djeg7mPdb+wQHZEgmO8GHF7B4hlE
         BHqWPymELP3CH2hEpTAJV82kYanJWDf5fxkrVBUt2bSPVUIcTDzL7Z+SlC/4IxrEpK6u
         drLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEMjBIHKqeIk6/krYwOVBo3a1ZgJth9jFfctgtfND7Pox47zizGsG9iyzmQXnwGg6TlV4OaBmitNxcRLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRTl4VtsOavLnDdp/tsdZfY/6FEkCIYl5UytMtpbXnw9UzON/W
	n3E3A8PxFrf/fkzNlzXp9GMk7Hqvz3LsAdAFkR8TQTDaPoxCFcCSTn7EBizh9M/xPDlbh9cJcsJ
	grFBO+g==
X-Google-Smtp-Source: AGHT+IH/2gIQckIGBvPLTgMI5nZTn9xen9JOJcaPgjLLw4FsDPxt8568zPXkGc37Szl9ifCv4T+uIb3eOmI=
X-Received: from pjoa3.prod.google.com ([2002:a17:90a:8c03:b0:32e:a549:83e3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a49:b0:330:82b1:ef76
 with SMTP id 98e67ed59e1d1-33bcf914d79mr18775090a91.28.1760978056031; Mon, 20
 Oct 2025 09:34:16 -0700 (PDT)
Date: Mon, 20 Oct 2025 09:33:05 -0700
In-Reply-To: <20251016172853.52451-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016172853.52451-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <176097602114.439246.7705198528866990456.b4-ty@google.com>
Subject: Re: [PATCH v13 00/12] KVM: guest_memfd: Add NUMA mempolicy support
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Miguel Ojeda <ojeda@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Shivank Garg <shivankg@amd.com>, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="utf-8"

On Thu, 16 Oct 2025 10:28:41 -0700, Sean Christopherson wrote:
> Miguel, you got pulled in due to a one-line change to add a new iterator
> macros in .clang-format.
> 
> Shivank's series to add support for NUMA-aware memory placement in
> guest_memfd.  Based on kvm-x86/next.
> 
> Note, Ackerley pointed out that we should probably have testing for the
> cpuset_do_page_mem_spread() behavior.  I 100% agree, but I'm also a-ok
> merging without those tests.
> 
> [...]

Applied to kvm-x86 gmem, sans the .clang-format change.  Thanks!

[01/12] KVM: guest_memfd: Rename "struct kvm_gmem" to "struct gmem_file"
        https://github.com/kvm-x86/linux/commit/497b1dfbcacf
[02/12] KVM: guest_memfd: Add macro to iterate over gmem_files for a mapping/inode
        https://github.com/kvm-x86/linux/commit/392dd9d9488a
[03/12] KVM: guest_memfd: Use guest mem inodes instead of anonymous inodes
        https://github.com/kvm-x86/linux/commit/a63ca4236e67
[04/12] KVM: guest_memfd: Add slab-allocated inode cache
        https://github.com/kvm-x86/linux/commit/f609e89ae893
[05/12] KVM: guest_memfd: Enforce NUMA mempolicy using shared policy
        https://github.com/kvm-x86/linux/commit/ed1ffa810bd6
[06/12] KVM: selftests: Define wrappers for common syscalls to assert success
        https://github.com/kvm-x86/linux/commit/3223560c93eb
[07/12] KVM: selftests: Report stacktraces SIGBUS, SIGSEGV, SIGILL, and SIGFPE by default
        https://github.com/kvm-x86/linux/commit/29dc539d74ab
[08/12] KVM: selftests: Add additional equivalents to libnuma APIs in KVM's numaif.h
        https://github.com/kvm-x86/linux/commit/2189d78269c5
[09/12] KVM: selftests: Use proper uAPI headers to pick up mempolicy.h definitions
        https://github.com/kvm-x86/linux/commit/fe7baebb99de
[10/12] KVM: selftests: Add helpers to probe for NUMA support, and multi-node systems
        https://github.com/kvm-x86/linux/commit/e698e89b3ed1
[11/12] KVM: selftests: Add guest_memfd tests for mmap and NUMA policy support
        https://github.com/kvm-x86/linux/commit/38ccc50ac037
[12/12] KVM: guest_memfd: Add gmem_inode.flags field instead of using i_private
        https://github.com/kvm-x86/linux/commit/e66438bb81c4

--
https://github.com/kvm-x86/linux/tree/next

