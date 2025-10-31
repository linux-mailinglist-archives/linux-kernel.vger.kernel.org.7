Return-Path: <linux-kernel+bounces-880536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64460C26062
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25D1189EC6E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C512F3C32;
	Fri, 31 Oct 2025 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oXxUaBUt"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AD62EC0AA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926482; cv=none; b=PvC71bKj0+4MLN5ui7ruqTRjIt405r9y69uLr65ORyls1QcA4j+wCItDL89p1yCwwXNifeIwxndOv+fNLu8vuvnfU3iuIdhBQX1gsv4pTAMAZrYGY4w0IQQxH98XydJkP7G/tZ8PTGLEK7D7rXRZuTK+FvJ3GJR4rU9CyckKpls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926482; c=relaxed/simple;
	bh=wuKNCAR9naLzRJVbZqK3vQEn3ShjHJSZ+aUJj/wLF/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PaVr3cC6FZeynRw1De1bbZ1JbUnSsh/wo7AQWeTrzgK9TMJbeWWI0NWa19B5vgsJAtiyi4KnZ9AEOqV62wTK3GeqDQkBMwkLX6WasZ5A+cB96wm6QWgDuF6ivZhB1s3tXbDKs/B71OFGSplNfvlNtoivD/c+r8gDIqh7LmpS0gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oXxUaBUt; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33baef12edaso2906011a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761926480; x=1762531280; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7n91hXfbqKaOek1a4KMSPayojDdoFizoG6Fs60W75tE=;
        b=oXxUaBUtFgpumjp4cM009snif40Njw9KDdRruFtXYQdPf3KdXkLEVmZNitMBenRbs4
         1mn/jH751V6UYun6lc7ApaaThhiT515kEt7QYFXjrxA81wpZiVH/tH3P1yCn/ewAj1WO
         Xceg7g0pqHTU1oKRtrIHPp3XlYcJI5tDxfmzJdmnteSIQ0wm4jaSxpNILdyBOx9yV4sD
         WbPtEMbaSTKEsL7Hn5FGnh+e/hzbthC8a4fhU4vzoGasC7azgXfh6p1Dg85LPs1yD3Op
         5o7Xf/g7FSPBPuNdyAQ0ZvBTD8bcJ1/WLIDstGflB5B5uim4T+oUFOl2RAFOPyVmwpHs
         Ty6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761926480; x=1762531280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7n91hXfbqKaOek1a4KMSPayojDdoFizoG6Fs60W75tE=;
        b=je4ajFalRPRfd6kyloreQQ6rw4nIti+RmepVCvNyuCIfEmcbFi5riNQlqhJbtYI8mA
         /JHQEva7CCqYhCIbF5399W1jmtFO2Qmpz+MJmxK2QBlYPIjJ6jIBCIKRpG7WWERNPujv
         OOL7zpl/zKMF99zndd8wPtXMNd8tSTz6KxA8oOmsdA/qI0dYX6/AIp74r7fwJHqqgYwB
         VSQPXh3FjNoUoWS1Rja/Rr/S4o52xwBGxRODQFhCKxNIThyA7KLWJj6CDNqFjK6HA25B
         4TEtWor94drvhZy5Ckf8lsTJ8ICtOyNKiqkfYK9zl9hACSaiDZdkEBUgQNo1TktFBAjh
         7iQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV5FZsbyDXXS7jyyJUVQ/oKFDGENO+mE/+QB0RUEUoh7cMNUkbb40BEabg9HxOWRe4dlqDGnundZtKYO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZgpBU/HWzRf2ApqqeTNC2i7lcqul1P9YTZaDJpYg1pfNlX5oh
	+azp0uxzrMGAaktYGlf3UdneB6LKSYx/xLwwURWzCwnlnohhoXuCfmPc3h+soT2wSEbfScd1oU9
	fvbxvdw==
X-Google-Smtp-Source: AGHT+IGhHC2El9WaUCCKm1Hj44ZgCrLgqsu/dbQUIstiiUukjm24CUn9fckX5YB+/0S+hCO8nrSQ+VvX1+s=
X-Received: from pjbip4.prod.google.com ([2002:a17:90b:3144:b0:33b:be14:2b6b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc1:b0:340:99fd:9676
 with SMTP id 98e67ed59e1d1-34099fd96edmr2583925a91.10.1761926479886; Fri, 31
 Oct 2025 09:01:19 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:01:18 -0700
In-Reply-To: <aQTSdk3JtFu1qOMj@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com> <20251028212052.200523-21-sagis@google.com>
 <6904c3834e3c0_231474100ca@iweiny-mobl.notmuch> <aQTSdk3JtFu1qOMj@google.com>
Message-ID: <aQTdTkMIukzt-YlA@google.com>
Subject: Re: [PATCH v12 20/23] KVM: selftests: Add support for TDX TDCALL from guest
From: Sean Christopherson <seanjc@google.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Sagi Shahar <sagis@google.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 31, 2025, Sean Christopherson wrote:
> On Fri, Oct 31, 2025, Ira Weiny wrote:
> > Sagi Shahar wrote:
> > > From: Erdem Aktas <erdemaktas@google.com>
> > > 
> > > Add support for TDX guests to issue TDCALLs to the TDX module.
> > 
> > Generally it is nice to have more details.  As someone new to TDX I
> > have to remind myself what a TDCALL is.  And any random kernel developer
> > reading this in the future will likely have even less clue than me.
> > 
> > Paraphrased from the spec:
> > 
> > TDCALL is the instruction used by the guest TD software (in TDX non-root
> > mode) to invoke guest-side TDX functions.  TDG.VP.VMCALL helps invoke
> > services from the host VMM.
> > 
> > Add support for TDX guests to invoke services from the host VMM.
> 
> Eh, at some point a baseline amount of knowledge is required.  I highly doubt
> regurgitating the spec is going to make a huge difference
> 
> I also dislike the above wording, because it doesn't help understand _why_ KVM
> selftests need to support TDCALL, or _how_ the functionality will be utilized.
> E.g. strictly speaking, we could write KVM selftests without ever doing a single
> TDG.VP.VMCALL, because we control both sides (guest and VMM).  And I have a hard
> time belive name-dropping TDG.VP.VMCALL is going to connect the dots between
> TDCALL and the "tunneling" scheme defined by the GHCI for requesting emulation
> of "legacy" functionality".
> 
> What I would like to know is why selftests are copy-pasting the kernel's scheme
> for marshalling data to/from the registers used by TDCALL, 

I almost forgot.  I detest the "throw everything into a structure" approach,
which the kernel used largely so that it could share code between SEAMCALLs and
TDCALLs.  Unless there's a good reason no to, I would much rather have prototypes
like

  uint64_t __tdvmcall(<all the args>)
  uint64_t tdvmcall_1(uint64_t arg1);
  uint64_t tdvmcall_2(uint64_t arg1, uint64_t arg2);
  uint64_t tdvmcall_3(...);
  uint65_t tdvmcall_4(...);
  uint64_t tdvmcall_5(...);
  uint64_t tdvmcall_6(...);

