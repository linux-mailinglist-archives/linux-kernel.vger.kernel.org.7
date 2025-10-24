Return-Path: <linux-kernel+bounces-869476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C71A9C07F98
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ECD78352BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F1D221282;
	Fri, 24 Oct 2025 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="geM+DAGz"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B4B2D4818
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761336009; cv=none; b=ILvdxm29CWIlOPMv+1KtNJZUGzV9g+TT3dUAtPSq2i14QEVV2PkV79Hgl6CuTQE/VQ6w1DsCft9zlzPV9EIvNc07fV5QEUNEL7+AXrLksKKsPQSHcCK1TMEhyR/uwTGBxeucw5sy44TyoE77WrZRObXv98wM1ETwQyQuk2XDGWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761336009; c=relaxed/simple;
	bh=a4koWH+uqJVKoQzJxiNmNcNNsMWDLmJfJjHP1FtuH/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V4YJGLsv+/jwbeb9foeZz3gSYbQl5Th/9IWnxuCqO5CS7TpSgyOBOhKlhSt8AsiVDQYFO6QtuJ2dsowAlQmbNQJWVaNS3AmvPDlOaB83ywi3rXNlDDbqlzSCmijsR17lIOSKuLsEcumvIGFnYMP+pFTPY6NWqWMOLtlQsyiMhSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=geM+DAGz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eddb7e714so2137775a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761336007; x=1761940807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jQWuTAypPk4Voj8xFEEPW+odzMpA448UchXUYWZIJLM=;
        b=geM+DAGzseBjrFqioJ1W/Eb/zWprmG7Qy7BVwBHEjzqWRKSCJ6bXoeeRvdmPmwO/Y2
         7ScD8DxTUTZt57vj7qIvwre17KxQ/+aOMQ1B34ap7ReR+UKPbLlOSu4SdfkyAqfV1wne
         XpLq/eZFk/2XuEZ5G8pUitFMsLHC0nuyWVCfDf70iBC48ybwkv7sVVMyQA9hznGZZIB4
         9gHj7WUllFwmMB/R8hjuAx4Sn50EqR1v2Kh6fvomi1K8I/C4xfl66uhXuYNl9dqZWlny
         UDN/IF4viol28/wl1BUZ2+xrGvLEXmFCN3liVx+7W1xTgdSIgwVbcpu0yOrJYsHXp3kI
         cWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761336007; x=1761940807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQWuTAypPk4Voj8xFEEPW+odzMpA448UchXUYWZIJLM=;
        b=kESxHeCdhh6EQy8f3ThfbFpzrXFWG04LIo7MGDCl7NxYonQVBpqEVko4HlmAhcnees
         NV+iAh1nRHRkvvAt8pMHmIjdh/MhD4uAsRWpCt75c2uuMBgUkqCjKpJAL1OPu/U2uHFo
         u2X9MwO9fMmPpmsv5LQCKTPurK49g3xDMGHAzBZalgPhNkytr3HgEf2GZ8FGnBc2ddIl
         h7bXSHbfORqrpH7F0dlZIR6iGRXQxCqJ6kUcymW1vcJpwgxmfhMJy0qd/C+FOtlwJpTo
         x0Ylqioc0bZ5402b0zxXT1lppgqE/S6JiVjqkufAoKEtNf69gpEqNF9ZF8pbcoP/sXI0
         /OPg==
X-Forwarded-Encrypted: i=1; AJvYcCWqYQUROQOPe2YUE5wUHTx/hHcq0LMFG9PwspixdZv1lOSVNGfVXFadtgUNdxRGIxcv1psirweuThIn7XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN+BElvGMICnFY+lPTNiCmAGbpzXp4VaIghC8z5q1OdJQl8MXR
	ggpRgxgFCBYhav0C9o5yuuakHIEQVLEVb6ou9zr7F5qjD2IZTeVQmJ84HcDkDwVYOjkxJqX6MY0
	Y3oJ3yg==
X-Google-Smtp-Source: AGHT+IFtYY3qiI8xjQMQ2bKZKS2EHbuLaQsQVwT62f6KBUMnn+9sff36B3nw860TvM6kSbJYtEYl/5jnia8=
X-Received: from pjbcn18.prod.google.com ([2002:a17:90a:f092:b0:33e:287b:a4a6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c0a:b0:32d:dc3e:5575
 with SMTP id 98e67ed59e1d1-33fafb980efmr8190217a91.5.1761336005276; Fri, 24
 Oct 2025 13:00:05 -0700 (PDT)
Date: Fri, 24 Oct 2025 13:00:03 -0700
In-Reply-To: <68fbd63450c7c_10e910021@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAGtprH96B5K9Hk5h0FgxSUBa-pik=E=dLrO-4oxx76dxb9=7wQ@mail.gmail.com>
 <IA1PR11MB9495BB77A4FAFBD78600416AE7F6A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH-h_axusSLTWsEZ6QoxgmVs0nVknqNJx-iskpsg_qHKFg@mail.gmail.com>
 <aPiEakpcADuQHqQ3@intel.com> <CAGtprH8q5U6h3p5iDYtwRiyVG_xF8hDwq6G34hLt-jhe+MRNaA@mail.gmail.com>
 <CAGtprH9bLpQQ_2UOOShd15hPwMqwW+gwo1TzczLbwGdNkcJHhg@mail.gmail.com>
 <aad8ae43-a7bd-42b2-9452-2bdee82bf0d8@intel.com> <aPsuD2fbYwCccgNi@intel.com>
 <ca688bca-df3f-4d82-97e7-20fc26f7d69e@intel.com> <68fbd63450c7c_10e910021@dwillia2-mobl4.notmuch>
Message-ID: <aPvaw6NgPBq1paUh@google.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
From: Sean Christopherson <seanjc@google.com>
To: dan.j.williams@intel.com
Cc: Dave Hansen <dave.hansen@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Kai Huang <kai.huang@intel.com>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, 
	"sagis@google.com" <sagis@google.com>, "paulmck@kernel.org" <paulmck@kernel.org>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 24, 2025, dan.j.williams@intel.com wrote:
> Dave Hansen wrote:
> > On 10/24/25 00:43, Chao Gao wrote:
> > ...
> > > Beyond "the kvm_tdx object gets torn down during a build," I see two potential
> > > issues:
> > > 
> > > 1. TD Build and TDX migration aren't purely kernel processes -- they span multiple
> > >    KVM ioctls. Holding a read-write lock throughout the entire process would
> > >    require exiting to userspace while the lock is held. I think this is
> > >    irregular, but I'm not sure if it's acceptable for read-write semaphores.
> > 
> > Sure, I guess it's irregular. But look at it this way: let's say we
> > concocted some scheme to use a TD build refcount and a module update
> > flag, had them both wait_event_interruptible() on each other, and then
> > did wakeups. That would get the same semantics without an rwsem.
> 
> This sounds unworkable to me.
> 
> First, you cannot return to userspace while holding a lock. Lockdep will
> rightfully scream:
> 
>     "WARNING: lock held when returning to user space!"
> 
> The complexity of ensuring that a multi-stage ABI transaction completes
> from the kernel side is painful. If that process dies in the middle of
> its ABI sequence who cleans up these references?
> 
> The operational mechanism to make sure that one process flow does not
> mess up another process flow is for those process to communicate with
> *userspace* file locks, or for those process to check for failures after
> the fact and retry. Unless you can make the build side an atomic ABI,
> this is a documentation + userspace problem, not a kernel problem.

C'mon people (especially the Google folks), this is the ***exact*** same problem
as certificate updates for SNP[1].  Y'all suggested holding a lock across a userspace
exit back then, and Dan's analysis confirms my reaction from back then that
"Holding a lock across an exit to userspace seems wildly unsafe."[2]

In the end, it took more time to understand the problem then to sketch out and
test a solution[3]. 

Unless this somehow puts the host (kernel) at risk, this is a userspace problem.

[1] https://lore.kernel.org/all/20240426173515.6pio42iqvjj2aeac@amd.com
[2] https://lore.kernel.org/all/Zx_V5SHwzDAl8ZQR@google.com
[3] https://lore.kernel.org/all/ZixCYlKn5OYUFWEq@google.com

