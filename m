Return-Path: <linux-kernel+bounces-771494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FD7B287E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8261D0404C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143272BE040;
	Fri, 15 Aug 2025 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWxvIKU8"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9469025CC40
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293994; cv=none; b=gyHKBH8e1eKHCuU41KRRX9CfbbCDLetf0DCB1i4Zymr6I2m/MnvNcDVmW819UTMh3TetiC66I34LBTjOSbeB/+6YVPScxyWJR5D6dTA0MkiBQQ8BgTlhaHvAfx5ipre3WTCxbibweokGO3FCDZeA/eHDTh6GC0pxMdMKcVS/QuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293994; c=relaxed/simple;
	bh=YB3rAKCgagsVKrqJKoqNJ7K30Dr+290pPCNLX6i/qpg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lT6DwfrkwpjVzxm0TixFsTMLBLU+Pes2r1t9lsmux3w3bD6lINUqkgzFRACX3DleLMmhzmUm+11Y071cfQ0aEHkxuF9fOzl8Yn+CeedyaHJsoNdiQbkvGUrgQK2Yuj3u+t0AXUNtnXS3hEhyVLZhaAikOva3w7UWlA76vyvOKQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWxvIKU8; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47174c667aso1905750a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755293992; x=1755898792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IqwBeT1f/L2NrAA+F6JogCzBCowUmKSnA9zvOmZMIDI=;
        b=VWxvIKU8I7LHV7ngeEJKN0ZDXZ1co+emMSXfZtIF7s8f2DCOG/MpMksO3njNF3nnfV
         EsjpJet/scvob2B0Hd6vZqFrDVoQFiXRgOV0Mem7Cvgh+6WRUYRABP0vv+U/n8cqlq3B
         9ZRm6DoiFkIgGp4hdhHxZhzafN7hOGovaTbqBav6TeBuJjPnPZFbYKWdKMsWCyC7zHgj
         mylT712szsADi/V18H+Na4SiYUg5FbbNAQfVHNYAvUCB6aAYKComtYi9tHIEfPi5AdHv
         +pNSNd+PGY9VvCqyEEvf56qXHt0ozBU3vNfbqlGg7hQ5F9n7UVJiWnssnPVrQLgMl48M
         2bEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755293992; x=1755898792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqwBeT1f/L2NrAA+F6JogCzBCowUmKSnA9zvOmZMIDI=;
        b=Zk3O7G9nCTFYxfmH1pXiKYOEzRS5slRR07SgBNStylBksEouVg7RhsjdMrRcpniW9p
         EI6ZBggSCAUVLIodUjzzIo1weLm9ck9mp6V6jMJOwzxh9xKvBJ9SpVktAsOCGT+QoNTL
         yv/zPiLc43CTT4qc44nKbwvNIwETFOGHOze7Zz3S43QTvotmyl1uasxE4oMWp9x9e2Ei
         KebjeMesu9psc2IFGgFBMM/HsG9HuILMoC1QP1F7mt9ImczB23ATWD91uep6LpAmhz0g
         nHUoVCe4Osq22LgZl82YiGkQWd0g9L4y2fxxo1S39T4/xJE1OjOcve1Y0cMVUjGQpULD
         lXCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf91vcyBymYSTJ7hEAWlvcvaS4Dt9M/Vula+UZ6n4lgFQFIqSD6aGS98LUcZxcw9c+eRJppnvYr3mFKNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhRFubERPE6Yj6JeYWtvUFWUqIg7wAqAeQOBXHmDD+RA6/dlie
	ijYNcHAKYWefizYjH5AVf2F+emvjawUaGWdXDtC7xsLEuUxKniYL8ncmxAAYGg9a0RCsqxyyhqf
	1Xv9KTw==
X-Google-Smtp-Source: AGHT+IHlU7I+sDLgbQ5PnUP/tHwPn8TgiyEdcowGEu9d7+tdmHeZ+pFe0JefyOgZZFoVLr/VMTR+B1uI0A0=
X-Received: from pjbtd11.prod.google.com ([2002:a17:90b:544b:b0:31f:2a78:943])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:134f:b0:311:ed2:b758
 with SMTP id 98e67ed59e1d1-32341ea22a7mr4975504a91.3.1755293991935; Fri, 15
 Aug 2025 14:39:51 -0700 (PDT)
Date: Fri, 15 Aug 2025 14:39:50 -0700
In-Reply-To: <20250725065009.GAaIMpIVgAKi0kMBVv@renoirsky.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721181155.3536023-1-yazen.ghannam@amd.com>
 <20250722165615.GCaH_CryG7kNrAS4O6@renoirsky.local> <20250723183426.GA1158000@yaz-khff2.amd.com>
 <27E487FE-EC8D-42AC-B259-F8A18776C802@alien8.de> <aIKehTDgP-Nu36ol@google.com>
 <3cc16f7d-c650-43f2-b0ca-d99c427cd69b@amd.com> <aIKmeclza-9TDe4U@google.com> <20250725065009.GAaIMpIVgAKi0kMBVv@renoirsky.local>
Message-ID: <aJ-pJvrPyHyPI0qS@google.com>
Subject: Re: [PATCH] x86/CPU/AMD: Ignore invalid reset reason value
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Libing He <libhe@redhat.com>, 
	David Arcari <darcari@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 25, 2025, Borislav Petkov wrote:
> On Thu, Jul 24, 2025 at 02:32:41PM -0700, Sean Christopherson wrote:
> > Not necessarily.  There are a variety of use cases for doing nearly-full passthrough
> > of bare metal state into a VM, e.g. to deprivilege the "main" OS, interpose and/or
> > isolate select resources, etc.  I don't think it's too far fetched to imagine one
> > or more such use cases exposing this range of MMIO to the guest _and_ also setting
> > the HYPERVISOR bit in CPUID.
> 
> What would be that use case?
> 
> To tell the guest why the hypervisor rebooted?
> 
> Sounds weird to me but virt does weird things sometimes. :-P
> 
> > But whether or not there's a legitimate use case is beside the point.  I'm not
> > arguing this is at all useful for VMs.  I'm arguing _against_ splattering
> > X86_FEATURE_HYPERVISOR checks all over the place just because an error was first
> > (or only) observed while running in a VM.
> 
> We use X86_FEATURE_HYPERVISOR to gate purely-hw-only features behind it.

And I'm advocating that we stop doing that (with maybe a few exceptions), because
there are very, very few features that are truly bare metal only.  Some things,
e.g. SEV-SNP, might require proxying certain actions, but even SEV-SNP can be
exposed to a virtual machine.

> Because they don't make any sense for guests. Just like this one.

You're conflating running under (on?) a hypervisor with being a guest in the
traditional model of virtualization.  Running a privileged, host-owned software
stack in a virtual machine is beneficial/desirable for a variety of use cases,
and I expect the number of such use cases to grow in the near future.

E.g. as mentioned earlier, pKVM uses virtualization to de-privilege the kernel,
and Hyper-V's VBS uses virtualization to monitor accesses to sensitive state.

Future use cases could use virtualization:

 - to improve system stability/uptime, e.g. restart the VM if the kernel crashes
   as opposed to rebooting the entire host
 - to isolate different software components, e.g. to run post-boot functionality
   in a separate VM to limit the impact of an escape/flaw/bug
 - to limit the amount of code that has direct access to system physical resources
 - to partion a system into multiple machines (each running their own kernel)
   for performance reason; e.g. AIUI, kernel-wide locks are becomming more and
   more problematic as the number of cores continues to go up

Not all of those use cases will want to access "bare metal" features, but my
point is that inferring anything about the system setup based solely on the
HYPERVISOR flag is all but guaranteed to break sooner or later.

> And even if this one makes sense for some virt scenario, we want those
> folks to *actually* explain why removing the HV check for that feature
> makes sense. And why the kernel needs to support it.

That seems like a gigantic waste of time/effort.  E.g. imagine the pain/churn if
MONITOR/MWAIT had been limited to !HYPERVISOR simply because early VM setups
didn't support executing MONITOR/MWAIT natively.

> Just like loading microcode in a guest, for example. There's a reason we
> don't do that.  And when some day, someone appears and wants to do that, I
> would like there to be an explicit patch removing that HV check in the loader
> and explaining *why* it is doing so.

Patch loading is exceptional because, AFAIK, neither Intel nor AMD officially
support ucode updates while running as a guest.  Though FWIW, I do expect that
sooner or later someone will indeed want to do patch loads in a VM.

And even if Intel/AMD never support doing the actual patch load from guest code,
I can definitely see a trap-and-execute scheme, e.g. where the bare metal kernel
doesn't have network or file system access, and so the ucode patch needs to be
routed through a highly privileged VM.

> And until that day, that feature is hw-only. Just like this one.
> 
> And yeah, I know you don't like X86_FEATURE_HYPERVISOR 

I don't mind HYPERVISOR per se, what I don't like is disabling code (or going
down different paths) based solely on historical use cases, i.e. based on the
assumption that "no one will ever do xyz!".  I have no objection to pivoting
on HYPERVISOR if there is an explicitly documented limitation, or for cases where
there's a very high probability of making a bad decision, e.g. using FMS to
enumerate features.

The odds of _this_ particular code patch being problematic/interesting are low,
but I really don't want to set a precedent that it's ok to gate code on !HYPERVISOR
without a strong, documented technical reason for doing so.

> but I would like to save some of my sanity when looking at a bug report which
> says that the reboot reason reporting is talking crap, only to find out that
> a HV underneath is doing something silly, muddying up the waters.

That cuts both ways though, e.g. I don't want to debug issues due to Linux not
behaving as expected because someone incorrectly assumed a feature would never
be exposed to a virtual machine.

IMO, if you're regularly spending more than a few seconds sussing out the
environment from a bug report, then we need to improve reporting processes and/or
infrastructure.

