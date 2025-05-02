Return-Path: <linux-kernel+bounces-630550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052D1AA7BB3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 23:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730159E0F81
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 21:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FA121B18B;
	Fri,  2 May 2025 21:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rmHpAdGp"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E821ABDA
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746222798; cv=none; b=eIqup0NgXCWs1WlN2gjXetVUuA/k8+G5nGe1JJFsWUS0Y9uRHrkjkwKC3cJUYvtPRVS75bPLuK6ncCr86NvZ23pvdFbiTlQeJ1XLMXsEePAb2+cXsDOsE4Ru6RQOjlT4+PGP8YML6gYF8LYp7Dhx7VashdGEUial7cwY3yteFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746222798; c=relaxed/simple;
	bh=nCQfZRGnU7XdEzRqGD04fz4uMnP/E5gcgt1TqjuuJmE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=coJiEH2qCAbrw0TlCuhzB1k6GdBF/9JfRAFE2foTubDWRQ44w5z6moV+aqo8NRA7cKtHo3tcolIE/miEe4jjTYRCggdECRKv1WcvoNkEIJ6Pgk9hC3FOYXqvD29U4lBkfX2cjZhKoVElnOdy2Xyqm5noJIXN1dFiueeXx/1xkLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rmHpAdGp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-227ed471999so22151465ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 May 2025 14:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746222796; x=1746827596; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOOJN/3iLkJuzLWQ6HzhE0I5jjTP+F/Ic+GWLQnPrgs=;
        b=rmHpAdGpnl/AlAugtxLoRZytQrXzWjTZmljfrI24S3E061cfnjkFhRUo+uGWD73lmp
         6pL+2E03gn9Yr6hRJ2iZ3JdRlJYyqBBw5ur9/mTahYwd0OrGLP/4xoqK2kDWl6NxzuMV
         xpTUFqWMo1bHvgExx/TQpzhf1G23llH2t5iDN/h4wRxDqfY0YjFJtmwgFxVNy0BFWYQY
         Aw0EB3RXumzLMeoM/3RS4sHfEnnnxUMWGIq5m8ZxbWz21StY/aN53VBUtEqhIp+wchSc
         Tym3GMTHPI56jVGmaL7dDgDTNhmICsVf7LURnD+jQnttyY90C9kgNG/dHVxWJ5r9DnMT
         MdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746222796; x=1746827596;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOOJN/3iLkJuzLWQ6HzhE0I5jjTP+F/Ic+GWLQnPrgs=;
        b=cwjt41dfS02b0qRBN7iVKnzpO+cswz7UEDyw5B6t/O5r1kVcaJskyMe8FiDoI+PMXD
         N6/Wh2LckVba5hnpBPe8KIfnOwsLh8+PsegMoPRZ7Dpe8ufRrjhs3MxohmoJ+O4f6Tas
         ykGtQCDSdkCawWFNC+6JeJkb5t++b4zOE39NzXCAzs7wSXhtwod2Gz1riP346iee5LXr
         V6gc9UkjWai09BmXyNyZXusH6JpLtSu8rSY5ns2ztRF4nGXMs7xBcWx0xQEmfrallbs9
         JKp7UHevrFh4yMBko9qCL+oev6XIHxWyAU7ihCFOfXtivQcxdCp48IJvE6bIlhismJQ7
         FLRg==
X-Forwarded-Encrypted: i=1; AJvYcCXlEuXFR5tdRdSFVTdmnKkexCYfDYBY1Sv6gNBzKhFZBbANTJsxubnbu0E0TmLd60UdoQGWp0pkvZsaWCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKH3EkNs+wfuXetOTwW2M5uEmyRCgJymXVxPJRND753gvC+o61
	BJ1j2ime9xG2YEp47nXd39wgNBbd7b9wOh2tUn/8i1NxKHX8chxJMX4IGHQPjpIaBggS9hGDTL2
	nNA==
X-Google-Smtp-Source: AGHT+IHYs1MEn10lvN07xty29oFw5oiyxFAmn6SFBXdP9nD8jAOeMnNJQ3el6hmUPc7oHdKrGD6YxS6KF80=
X-Received: from plbml6.prod.google.com ([2002:a17:903:34c6:b0:223:432c:56d4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c25:b0:22c:3609:97ed
 with SMTP id d9443c01a7336-22e1031f6femr66397945ad.30.1746222796181; Fri, 02
 May 2025 14:53:16 -0700 (PDT)
Date: Fri,  2 May 2025 14:51:05 -0700
In-Reply-To: <20250502203421.865686-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250502203421.865686-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <174622200919.880464.5585413953831680839.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Revert kvm_x86_ops.mem_enc_ioctl() back to an
 OPTIONAL hook
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 02 May 2025 13:34:21 -0700, Sean Christopherson wrote:
> Restore KVM's handling of a NULL kvm_x86_ops.mem_enc_ioctl, as the hook is
> NULL on SVM when CONFIG_KVM_AMD_SEV=n, and TDX will soon follow suit.
> 
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 1 at arch/x86/include/asm/kvm-x86-ops.h:130 kvm_x86_vendor_init+0x178b/0x18e0
>   Modules linked in:
>   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.15.0-rc2-dc1aead1a985-sink-vm #2 NONE
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>   RIP: 0010:kvm_x86_vendor_init+0x178b/0x18e0
>   Call Trace:
>    <TASK>
>    svm_init+0x2e/0x60
>    do_one_initcall+0x56/0x290
>    kernel_init_freeable+0x192/0x1e0
>    kernel_init+0x16/0x130
>    ret_from_fork+0x30/0x50
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
> 
> [...]

Applied very quickly to kvm-x86 vmx, as I want to get the TDX macro cleanups
applied.  I'll force push if someone finds an issue.

[1/1] KVM: x86: Revert kvm_x86_ops.mem_enc_ioctl() back to an OPTIONAL hook
      https://github.com/kvm-x86/linux/commit/f2d7993314a3

--
https://github.com/kvm-x86/linux/tree/next

