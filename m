Return-Path: <linux-kernel+bounces-863405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B5EBF7CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F304822AC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603A334A797;
	Tue, 21 Oct 2025 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPKpWGmE"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1207D3451BD
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065783; cv=none; b=WbBdugNaDuRz0UN8LVYqhlu6ryfSqov/dJw7atKvAiRblFMzYrpUrOfVGpDVndYCTWqzsrNObMXLjNgCLbD17SIaUpdyKseeQIvv5EW2MR4EJs5b69+fL8Z0pKIeIGYVi1e/brs8m5HtcsceRlafULKSF+AhCdJ7n3J/Eko88V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065783; c=relaxed/simple;
	bh=RDkmhC4PKjh9lbEZgOEdown78rPWmXw4ycUHNJGAVxA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iahgJqpXifbnJG02JtPDI0htHjMNemyI1qw/6rv8sSqBNeE1KZafAImGbMcTHDrzGQ5HlOdhLhCgD1YH8c3v3ceHby/JnwsUdyXt1qgbQmZ5js9m1kvPfer4ade4yM2ZqIWqiJAv5Kw30X0D/j3ayTm1a248fUMVwxvM/UUoePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPKpWGmE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-290bcced220so50769345ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761065781; x=1761670581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QUj6Jzqtl7pAwgzbknudC50aTFamgZNMeXgKkiBAGZE=;
        b=tPKpWGmEKivEXxdU8f8bGol07sovXlyfKaALXNfbDwkiYG8RRBCXe4jwynp8t5+cLO
         n4S4GPFfxO5vNleG17p7jNQX1CdGFIpn48l+JIvwL05qc9ojiIuvhTa88yMZM+HdrQu0
         A9hVm/97VP5Bc2oNMPN4OOf8ZBdebNd4NnZN7jk4ocm08QBCh5MDp8AbpPQuBROSMZhs
         1u5K3l3LdJG28D2/CXyFDbItvIJ6zkKVCd7vDAlZ9MKQA+Q1Txhpsw6UiD/PGr3JE47i
         l1Tl6RZhXMmB0RXRinbma7+SwLkCEIRsXH9GZGTx9cORocrzbL0k6CamIsgwrdZxrTZA
         alYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065781; x=1761670581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUj6Jzqtl7pAwgzbknudC50aTFamgZNMeXgKkiBAGZE=;
        b=uxn6EjCZUbIa88ICpFB2uPvSn/vH/l7Hhz1nIbIP3crNtcoD40tuOT8GiZT9j0xr1D
         OGtV1FNLL58U2zVNhA1cmXOdPkttTdJFsVZvr8XVnhcQeF7y2mrBd6QZCwngoH2ARpfX
         zdX6OLB70ZDymjzlHDCfGIkVx+mKqcakH/F2OQzJj5eubuFElj54Pr00bvf71qjHZ7y2
         ZCkpvQ1TffHfej6y3d7i6lV++9weXYWfbwHhqsEr9cU6WY7UmOAPOnaNJzNTWAKVyyqo
         53tvtV/+eVc7VFg1mfwfKfAQW3PqVliFm0yX7HRqvJqu+ayh4m+EViEFW6+257ZHCtJe
         yscA==
X-Forwarded-Encrypted: i=1; AJvYcCUJZ+A2qkmSLxCBIKB/w4jMEWDSAAeGro0yHwBXqg+ZfRiGokfz+UrLL6IcDhc4Gto8l49uq2jaAWahwyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdW3shsBMmY0eyOhggkkGx8aqjbBPYITwV6scyB9NTzgAG5O7h
	qTuKqYYCVNkDu9FRgl9RcsvM5BFMOtIpo+siEO9PlXuhogW2zW5PPnpBleoCZJdOKCXqHJIRCH3
	2e275YQ==
X-Google-Smtp-Source: AGHT+IGOqKmUzCbfjGYr8B2jY/C1mdIZnvxK8+ss+AVkwVotQdjiGEd+3SJ7VfMTaFoQGYSh7+8f99sR5n0=
X-Received: from pjre3.prod.google.com ([2002:a17:90a:b383:b0:33b:51fe:1a75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e88e:b0:250:1c22:e78
 with SMTP id d9443c01a7336-290c9c89c9amr235880025ad.1.1761065780727; Tue, 21
 Oct 2025 09:56:20 -0700 (PDT)
Date: Tue, 21 Oct 2025 09:56:19 -0700
In-Reply-To: <d0b369c65e33518d57a40a70c0d13f70bd64db47.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251017003244.186495-1-seanjc@google.com> <20251017003244.186495-24-seanjc@google.com>
 <d0b369c65e33518d57a40a70c0d13f70bd64db47.camel@intel.com>
Message-ID: <aPe7M1aUPwqDmQbY@google.com>
Subject: Re: [PATCH v3 23/25] KVM: TDX: Use guard() to acquire kvm->lock in tdx_vm_ioctl()
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "chenhuacai@kernel.org" <chenhuacai@kernel.org>, "frankja@linux.ibm.com" <frankja@linux.ibm.com>, 
	"maz@kernel.org" <maz@kernel.org>, "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, 
	"pjw@kernel.org" <pjw@kernel.org>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"kas@kernel.org" <kas@kernel.org>, "maobibo@loongson.cn" <maobibo@loongson.cn>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "maddy@linux.ibm.com" <maddy@linux.ibm.com>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>, 
	"zhaotianrui@loongson.cn" <zhaotianrui@loongson.cn>, "anup@brainfault.org" <anup@brainfault.org>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Kai Huang <kai.huang@intel.com>, 
	Yan Y Zhao <yan.y.zhao@intel.com>, "michael.roth@amd.com" <michael.roth@amd.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	Vishal Annapurve <vannapurve@google.com>, 
	"kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 21, 2025, Rick P Edgecombe wrote:
> On Thu, 2025-10-16 at 17:32 -0700, Sean Christopherson wrote:
> > Use guard() in tdx_vm_ioctl() to tidy up the code a small amount, but more
> > importantly to minimize the diff of a future change, which will use
> > guard-like semantics to acquire and release multiple locks.
> > 
> > No functional change intended.
> 
> There is a tiny functional change. In the default case it no longer re-copies
> the struct back to userspace.

No?  The default case doesn't copy the struct back even before this patch, it
explicitly skips the copy_to_user().

	mutex_lock(&kvm->lock);

	switch (tdx_cmd.id) {
	case KVM_TDX_CAPABILITIES:
		r = tdx_get_capabilities(&tdx_cmd);
		break;
	case KVM_TDX_INIT_VM:
		r = tdx_td_init(kvm, &tdx_cmd);
		break;
	case KVM_TDX_FINALIZE_VM:
		r = tdx_td_finalize(kvm, &tdx_cmd);
		break;
	default:
		r = -EINVAL;
		goto out;  <====================
	}

	if (copy_to_user(argp, &tdx_cmd, sizeof(struct kvm_tdx_cmd)))
		r = -EFAULT;

out:
	mutex_unlock(&kvm->lock);
	return r;

