Return-Path: <linux-kernel+bounces-726559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6B7B00EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC00A587825
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FC429B8E2;
	Thu, 10 Jul 2025 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8VBNmhB"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C342356D2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752186372; cv=none; b=WOpYNTol8pU+f+JBD569mjwaoBglgy0C97DaVLPS++ac80T6UUMsk3rgEofdNqs0DxEyQQpZJp5ui+FcF2EZCp1nP+7cmOXAfvsi60VYfa+FBy68ZqeUhQkvP6E6LDD9wGEtxk/w0pVi+VxcLXHnY/Y9aumUor65trxaPlGUOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752186372; c=relaxed/simple;
	bh=PAwdx7yQJaDiQwqXLGk/2c9Pc41R7EGeDWdFr48RaBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mPUqFMsSo8AP6UAB7h0iad6qJynjXgPxh7i36wCnrlaX9QuK8dB/r/9bwcn15UgEIf596Wq08YVhX1dmgbSYMyI2RWj9V6j6cjevwTV4H0GxyLzmvxYWNpC7FXUBzsf/z8DsWpIWp8t96NKfGVGuNCBpzuyjfKelxNZpaQLVO4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8VBNmhB; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311e98ee3fcso2338747a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752186371; x=1752791171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DMwGaTnJHiEZwM46fLKhjgHCPfMN98ZSYJRCaCWRfIQ=;
        b=I8VBNmhBjIXuDDK+yMUvM0ZvulyrSpn1rA7nlSgeXmlvYdqykVMZpLXSrxVBKY1DzG
         1vS9AojbDG4uK36AwTJCaMGQOs8zZvyR93iAISzlOYkvt0FRAQTxIKEdNqBbxs9g7RUG
         NjHUSSvK8DeeZHeNmG25GPEPgIlAWw5bFhfBASoAFyPvp89rYXE1Z/DPKdMRbqmVq4HQ
         QHIcr9wLl9WB703D74zsbf0dNXkPMJYYHEN8ybgeSo5d5DVdEpcfiTtRRaW0aW87qBEj
         Zbb31mWmOPGva5D9g0d6sn+sr5XAY+xenASX+QU5cvhdeKkFb03Ax1sB/2dJcsgJnAJF
         TsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752186371; x=1752791171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMwGaTnJHiEZwM46fLKhjgHCPfMN98ZSYJRCaCWRfIQ=;
        b=nuYePU/7q+/DDVquKI7kNVykAUSdnnp7PFSEluv5v3rEagNXbtQR9hZpiLIIq2wbiK
         UeNJZiUyxzurKgD6Q4bXmxtqec3uNr6iP1VwSPNnyg84lz9pStbA6dzp+Tzb3b0gROdo
         ALtU5ImwqfXO6BB0xNg+HfaNrhfzO3VXDl/tLGj4pFiPJX+O8Hd6e/e1ATtzfIeVT/Su
         TWnDvdOEjxp8ot79YjILW7NwBUCV0r7TknWe3p4R0pRdFGmkdG1vk4VHsPfLKtzIdYxY
         0tLoxeYxgrJ3uCOZ0aAqEDsNL992vJDpsICfQ4voFHQJgHBXV6q7yG9mEZU57LQrVWA8
         RXEw==
X-Gm-Message-State: AOJu0Yyvjc8gAvjCZr4KwvavmQwR8nrwXV90myjGCR+73TrGvURB1HfN
	Q+8yiWN2i1oZYV8zTCchv740zuq/AdJHvVYQT4DjFdhlJFM4VYCRGjtjIzQNGPiNaksq0lgRSMf
	jfX3EcA==
X-Google-Smtp-Source: AGHT+IGkuJR0X0T6W2fHvka7uv2cWLoK8i/pohTsuZPiX7WHSmWs0rGCP7Zp0LR4VbMYlGAG0/KuEy+dHWE=
X-Received: from pjee11.prod.google.com ([2002:a17:90b:578b:b0:31c:2fe4:33b9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57cc:b0:2ff:4a8d:74f9
 with SMTP id 98e67ed59e1d1-31c4d4d074bmr1153930a91.10.1752186370783; Thu, 10
 Jul 2025 15:26:10 -0700 (PDT)
Date: Thu, 10 Jul 2025 15:26:09 -0700
In-Reply-To: <20250710102917.250176-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710102917.250176-1-pbonzini@redhat.com>
Message-ID: <aHA-AVQQkUYmcsSP@google.com>
Subject: Re: [PATCH] KVM: Documentation: document how KVM is tested
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 10, 2025, Paolo Bonzini wrote:
> +Testing of KVM code
> +-------------------
> +
> +All features contributed to KVM, and in many cases bugfixes too, should be
> +accompanied by some kind of tests and/or enablement in open source guests
> +and VMMs.  KVM is covered by multiple test suites:
> +
> +*Selftests*
> +  These are low level tests included in the kernel tree.  While relatively
> +  challenging to write, they allow granular testing of kernel APIs.  This
> +  includes API failure scenarios, invoking APIs after specific guest
> +  instructions, and testing multiple calls to ``KVM_CREATE_VM`` within
> +  a single test.
> +
> +``kvm-unit-tests``
> +  A collection of small guests that test CPU and emulated device features
> +  from a guest's perspective.  They run under QEMU or ``kvmtool``,
> +  are relatively easy to write.  

IMO, selftests aren't meaningfully harder to write than KVM-Unit-Tests.  They
require a bit more boilerplate to get started, but in many ways I would argue
they're easier to write because the C code has full control over the VM.

E.g. doing multi-threaded testing in KUT gets painful because it often requires
using IPIs to coordinate between vCPUs, trying to test different vCPU models
requires writing multiple config entries, etc.

And I think the boilerplate "problem" is mostly solvable, by expanding the KVM
selftests harness to handle the bulk of the work for simple tests, e.g. see
https://lore.kernel.org/all/ZjUwqEXPA5QVItyX@google.com.

The reason I bring this up is that I'd prefer to steer people in the direction
of KVM selftests over KVM-Unit-Tests.  Or at the very least, not steer them too
hard towards KVM-Unit-Tests by suggesting that KVM-Unit-Tests will require less
effort.

Because selftests can define the vCPU model and VM capabilities, they can provide
significantly more coverage than KUT in many cases.  E.g. one of the things on my
wish list is to rewrite KUT's MSR test as a KVM selftest that tests both guest and
host userspace behavior, and that permutes over various vCPU models.

And from a maintenance perspective, having selftests in-tree is a huge benefit for
me.  That alone is honestly reason enough for me to push for selftests over KUT.

All that said, this looks awesome!  Thanks for writing this up!

> + `kvm-`unit-tests`` are generally not
> +  KVM-specific; they can be run with any accelerator that QEMU support
> +  or even on bare metal, making it possible to compare behavior across
> +  hypervisors and processor families.

