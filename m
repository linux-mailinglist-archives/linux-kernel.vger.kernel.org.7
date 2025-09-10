Return-Path: <linux-kernel+bounces-810836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8AEB5205E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524621BC2B11
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900C42D060D;
	Wed, 10 Sep 2025 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o9ELnF49"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB7223B623
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757530059; cv=none; b=Du7T8QfQce2hFtaIuhPr8dAZ+ClSmBHrGcZe2TJcqRkdu8IGEs7IkyQh0kTthEQtUNUmqc1pKRRBEPrbhdEHll/0iEwF3+0CVUeIKeAal6i4wLt0gb3w31s8YxGDlkLZDwM7YDt/HskBZoRUak+1fxuQImILO5aLdp3FNOVjEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757530059; c=relaxed/simple;
	bh=3wVIa3kxzyn1jKBO4FKiY5s1rZ0DI2Qt/ZAzIledNSc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JL1OsTl2raV9sEXmv/T5CmcQK1oR+JR5STIXQvMPv2GLgsFvsqQuZ8TzzUCRKyoAq8ZTIwZJ127KyOTYWrwkUoVadZaNUmpgFZrFDRXzHkiQDghbckrNNaDxl0hg548Io6e8+83sgQHxnf3U0uOGyKj75SMikgg7prCXhbz5Jqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o9ELnF49; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b52047b3f1dso9716120a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757530057; x=1758134857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FIyVRSowSoxm0jH+PFTbTpx3TzBNK5EeRuMI4ty+SJc=;
        b=o9ELnF49FhZqb7uHldeq1GZno6Ag9KzL7aDnQPqDYnR+d4ci7mksUNkStxaIqm7hOS
         agxn1OWCEBd6pzJl26tc8O9zwuAllbQZM/9IZIqzNnVOmQkKTf0itrRiGTaYap60cW9v
         q4CQ35qBGZAkBtZID67wnJ1Vc899DeqeVoeHHDGhnUKpmgg5041Ho8XPId4J0mJmkvcV
         9+xmZlD7hWQMl1VDvct5I+iOQlFNpaTh71R/vhsajVs8kd5eoQtyTcb1JpmsZiZ4Res6
         qcegzplU7UCao2ra9YmN9QpnRZW3oxXhRQL9e/gR/Gt0WK1V96ZS9yzFFlCvcxiNIS3z
         FSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757530057; x=1758134857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIyVRSowSoxm0jH+PFTbTpx3TzBNK5EeRuMI4ty+SJc=;
        b=toToVoVU/SraL3M813jZ07vzNDtYXodCPSf3oAxOPiAe12ZEArnt4ga6y4viFyAxNc
         lC8ErapbSduggd9S1hPYQN5lzUCEUEy4pgHQMR+MpFdOQ9z//+5Eyi/NTgCi/n4qBbWd
         Di3noI4S83d1/1gm0lZ8mcbHyB9SoJF8nDRSirxvHgB63fPFKQyrxFSBYga1ynxS1Uxu
         9LTXE3zkDJzfoyOml7UJActlDHbeZzn3EpT232hUNleADzYg41LZTawoN56gQLBN+9bF
         Q28f6eER2jhSpkeimYYyakymr1W98xEQqQOWmwM5rhEMBSC1z7X+zA3lV+37uU1+zwId
         WwGg==
X-Forwarded-Encrypted: i=1; AJvYcCVUXQr9KdvFtake0u5gm3vv2/WxfwGXqoI0TkW064GEtKg1JL4vHRhJ5BcayCBIrH+kozB0e3eShJE3too=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyWMB7lPNIMyTgxUzFZvIsmloyYBrsT9fxl3Y1slYw0avRsHY3
	0bq5NhKrKjDqcZN9YSG1l9YPINt6ULYF8T59mC2JVbNjt94jtj752ObCDeY6dSFe0R+Jz04T8C9
	+ASFaRQ==
X-Google-Smtp-Source: AGHT+IEDLJGMO3AphcAHDNXaSjkdvGKKt2jtxrGUIyclDPwEC7z8NsNkYyuOZtHLhM94tSbrdteIaNUcsSs=
X-Received: from pgke16.prod.google.com ([2002:a63:f550:0:b0:b47:6f88:6843])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a06:b0:250:720a:2915
 with SMTP id adf61e73a8af0-2534441548fmr22969863637.35.1757530056588; Wed, 10
 Sep 2025 11:47:36 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:47:35 -0700
In-Reply-To: <aMFiBZARu5pD+Zzq@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909093953.202028-1-chao.gao@intel.com> <20250909093953.202028-4-chao.gao@intel.com>
 <c0e5cd9b-6bdd-4f42-9d1b-d61a8f52f4b8@intel.com> <aMFiBZARu5pD+Zzq@intel.com>
Message-ID: <aMHHx4Pu4eWdNQJj@google.com>
Subject: Re: [PATCH v14 03/22] KVM: x86: Check XSS validity against guest CPUIDs
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acme@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	john.allen@amd.com, mingo@kernel.org, mingo@redhat.com, 
	minipli@grsecurity.net, mlevitsk@redhat.com, namhyung@kernel.org, 
	pbonzini@redhat.com, prsampat@amd.com, rick.p.edgecombe@intel.com, 
	shuah@kernel.org, tglx@linutronix.de, weijiang.yang@intel.com, x86@kernel.org, 
	xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 10, 2025, Chao Gao wrote:
> On Wed, Sep 10, 2025 at 05:22:15PM +0800, Xiaoyao Li wrote:
> >On 9/9/2025 5:39 PM, Chao Gao wrote:
> >> Maintain per-guest valid XSS bits and check XSS validity against them
> >> rather than against KVM capabilities. This is to prevent bits that are
> >> supported by KVM but not supported for a guest from being set.
> >> 
> >> Opportunistically return KVM_MSR_RET_UNSUPPORTED on IA32_XSS MSR accesses
> >> if guest CPUID doesn't enumerate X86_FEATURE_XSAVES. Since
> >> KVM_MSR_RET_UNSUPPORTED takes care of host_initiated cases, drop the
> >> host_initiated check.
> >> 
> >> Signed-off-by: Chao Gao <chao.gao@intel.com>
> >
> >Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >
> ><snip>
> >> @@ -4011,15 +4011,14 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >>   		}
> >>   		break;
> >>   	case MSR_IA32_XSS:
> >> -		if (!msr_info->host_initiated &&
> >> -		    !guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))
> >> -			return 1;
> >> +		if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))
> >> +			return KVM_MSR_RET_UNSUPPORTED;
> >>   		/*
> >>   		 * KVM supports exposing PT to the guest, but does not support
> >>   		 * IA32_XSS[bit 8]. Guests have to use RDMSR/WRMSR rather than
> >>   		 * XSAVES/XRSTORS to save/restore PT MSRs.
> >>   		 */
> >
> >Not an issue of this patch, there seems not the proper place to put above
> >comment.
> 
> Agreed.

It was there to call out that KVM doesn't support any XSS bits even though KVM
supports a feature that architecturally can be context switched via XSS+XSTATE.
I'll find a better home for the comment (probably move it in patch 5 as
Xiaoyao suggested).

> I am curious why PT state isn't supported, which is apparently missing from
> the comment. If it is due to lack of host FPU support, I think the recent
> guest-only xfeatures we built for CET can help.

Presumably, perf uses PT across multiple tasks, i.e. doesn't want to context
switch PT state along with everything else.  For KVM, PT virtualization is
intertwined with perf, and so wholesale swapping guest PT state simply won't
work.
 
> Anyway, PT is only visible on BROKEN kernels. so we won't do anything for
> now besides documenting the reason.

Yeah, PT virtualization is riddled with problems, just ignore it.

