Return-Path: <linux-kernel+bounces-829314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECE6B96C67
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C615817D9BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E3D31E0E4;
	Tue, 23 Sep 2025 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NucJjwky"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9985D2E613C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644101; cv=none; b=Krnkbew6kesG6MzleG+XRC0od8vQ44il9OHpcsZ1DivEHA6wRHbRbwq8vNk2mM9TwlHmU1Mz25igqLQss4YGjwZaj2eO6PcOLH/2Q9dIKoPsUilb0o0tX20QH9/MWyoStMSwXKizxqPeHctPUkwxwkNoHy88tJJeLEt326dTAmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644101; c=relaxed/simple;
	bh=7s+A5FPvgZVYp22XNXA9oi7XjByCFaSyUroyMAErrpU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oLeS8i2BI1HwBC8ctHLzblJQdCmL8gvkNCJYSib+V4Xm5ZEPG7VP2zLRmiI5SFFNv6QJWmr8FXdXZlYHWmN5f/6LKEuPcHmm8wYmq8djONQ+/EWxeHaaIjbfRdkrGPIGaghDnNp74iOjbS23Pb3srOxWqny0cqmMt5vK2+l1hIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NucJjwky; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77f29b9e2aaso4809920b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758644099; x=1759248899; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+tYNF4K/77ITcUr0+JToP8xS2/zhcS2p8XYqUTK0ON8=;
        b=NucJjwkylAuvDAEFsW7gUGS+lQu/yXmK6Itc4cA0QQfjti/AJNAB7kZs2IyyA9A2AI
         Y654840YcTjRNhWiuLXtfrAzhx3dhHHdHx6zXS/9VTGgmEag2gXzZwUVIqXFhBKxPXVW
         MgxR1NIfHz/7e8cLzryvXEn1KqkzVZftX9w5mtHcqZo9MJprRsW/DMXIQMzmw3RJAjR/
         EbJZbYuhvKjuFmUJ7TjpWF9oSjZQKMKHyEMKNU8T97vj6LgSUpVgqdBloCrl7Lw+od/W
         jWTnjA1xsww9n7XOzmnwUpEHkyBIIIcNH4FddR2s5OsRjQFBqnj/E2JzslG9iOn2yCsA
         ER1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758644099; x=1759248899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+tYNF4K/77ITcUr0+JToP8xS2/zhcS2p8XYqUTK0ON8=;
        b=EDI613nbymLFPDVBrFNb+wpHVtSyD70+Up78tX3Bnf0kra6KIyCjyAd0c4FSkvazIG
         tF7BkW0OkzdXdmhDJ9DcHYrAgCXSvm3H2MBbIJARa8Zvm6mt94OiOkvKyARm4eb5vYU9
         9OpOugsZWFo+p9UJmgr5hmqSuYYd4k6IffL28ull/BVmjUkqC2DjOtkVVtstZJ/E3WpY
         oUsbbdnzbo108j8wYksoHR1pkcmJSmnyiERC6KNycjlM8s9mJF3Xv/86ea+CJ35DBlpH
         mGBK15RZP59InVKwyMYL4nAob9j/8utMSTxUzvMn1FhcFwXteGgY+DnxZP+GLiOshELK
         2B1g==
X-Forwarded-Encrypted: i=1; AJvYcCVdDRo5tc9FndgYlAJw8giDS9lo7BsMfZKvz4PNOZb8WFi/uhVk9a/wtcmse+pfF282mN2MTMpFRlrW1vI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw595U27TUSh+gbVSf2HQGG/hJO6rZJPMDONEP//ebHczdhq+0p
	kds+mm2SolRYJ3vAfedu5Ix1MmKAR04lD2dT263eZ0ypMRbh7bBYbAdg4gJ8vxxNV2OLSO2uOXU
	Hvg3XHQ==
X-Google-Smtp-Source: AGHT+IHD7L+PryqMRcEAyMIWx5h8kZMzWZlsPrrV/X3n0qIL0f/pV9BpQBHe6p3E+N7zso99rGpKKIiD2i8=
X-Received: from pfst22.prod.google.com ([2002:aa7:8f96:0:b0:77f:ad8:fbe9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:230c:b0:76e:2eff:7ae9
 with SMTP id d2e1a72fcca58-77f539308b9mr3647087b3a.12.1758644098926; Tue, 23
 Sep 2025 09:14:58 -0700 (PDT)
Date: Tue, 23 Sep 2025 09:14:57 -0700
In-Reply-To: <b9b4bb21-47db-4282-8d4c-eedb836fbfb9@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919213806.1582673-1-seanjc@google.com> <20250919213806.1582673-3-seanjc@google.com>
 <b9b4bb21-47db-4282-8d4c-eedb836fbfb9@intel.com>
Message-ID: <aNLHgel7cZZ1THrv@google.com>
Subject: Re: [PATCH v2 2/2] KVM: SVM: Re-load current, not host, TSC_AUX on
 #VMEXIT from SEV-ES guest
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 23, 2025, Xiaoyao Li wrote:
> On 9/20/2025 5:38 AM, Sean Christopherson wrote:
> > ---
> >   arch/x86/kvm/svm/sev.c | 14 +++++++++++++-
> >   arch/x86/kvm/svm/svm.c | 26 +++++++-------------------
> >   arch/x86/kvm/svm/svm.h |  4 +++-
> >   3 files changed, 23 insertions(+), 21 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index cce48fff2e6c..95767b9d0d55 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -4664,7 +4664,9 @@ int sev_vcpu_create(struct kvm_vcpu *vcpu)
> >   	return 0;
> >   }
> > -void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_area *hostsa)
> > +void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm,
> > +				    struct sev_es_save_area *hostsa,
> > +				    int tsc_aux_uret_slot)
> 
> Passing the tsc_aux_uret_slot as paramter looks a bit ugly, how about
> externing it?

Yeah, looking at this again, I agree.  I'll post a v3 (already did; forgot to
hit "send" on this earlier, /facepalm).

