Return-Path: <linux-kernel+bounces-756507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94342B1B53D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0B087A2444
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4302701D6;
	Tue,  5 Aug 2025 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e9+C93D5"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739FF18A6A5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401759; cv=none; b=VE8Wv6UGah00kUiNphYFIRyZN2njT1UASv3osEN5UPPpU7sW/OoLQ7MGRRXhn1ti5GyDIgMZ5ZUNzAIi4YsMPXb355OieocoOeVzcvW6LiqAP9Ph3zxCsiXiZ3LaXvB+i0nwSwaoNoHkYKBpj0MEwVqWqIREM0H1eEFkMMZdJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401759; c=relaxed/simple;
	bh=4+Xv8HdJDjCg0JB1inWUoSSIwe9H0xI17e7G1z+kA+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D5CPtnVV70iWgkLIEgQ2Wn/BRkFVjDTt+eG22VZ1RXveUebyPEj9Z5H2EKwEpAoFR6qUdav/dKsc7G9xhyabrCFbxILXowDKnp0yebAgt8OwIShXaeFAIuAKcAX4fp384oq80//DfSRGfJKiTand0XjMrRJ4cVLrpqxI6Z+4Urc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e9+C93D5; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-240908dd108so45629415ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754401758; x=1755006558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D4i1z/XvcGAbannfCkDoRIkqe8/O998kxAd0zY9gLJc=;
        b=e9+C93D5GVsyAr5cpn798fBFgbJW3+peZXkkf2T/EkiM6sxiTreoH4QCXszXqjvEf4
         0JLL0Zho9eVvuTbw88zw18ju6JrMZB4ke3BwEOVYnGAW9imcpdxmY8PtZ+pUbIFQYCEq
         /WNomT3NMBWfzWfLe8iq/kJl79eUIDNwNfQ6FdyQv2+5BXWsluovCKspOK3fqwQPtaLF
         wOFYMYIY1W2CeqVPqF4eEepNp+X2MQh4ZRc+BSuKH3vwMeV/Ep4IhP3eQ9HHDiEjITHp
         ZC8thK6l4JvG03ljPUI8AToGofZUgW4Da1N5CqvNJ2KhShPPgSLqMp+u4S8HeojKwP+h
         9vFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754401758; x=1755006558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4i1z/XvcGAbannfCkDoRIkqe8/O998kxAd0zY9gLJc=;
        b=ut0u6Sr3p1CS6uhF9LoRucQNy400rV1nFQwIthJz621ZCNAUIAJg/dURB8kLW1eJzd
         4kbeO4qZy1M3o0IOkgpISNJwwwvbHC9iCu0YwB5ccFgsbcoZf8MKeLjujaVgs2Xw8SX7
         VLlAF6wcR0QkLHmnuUawRSIL+uk1cJrov1gtLHnJDBuVbxfeG1TvJVa1YVjNWk20lXah
         4zHpWeICS6p1o4rwIKhDwVw6rPvkP8n13vBLGV4lrNJFoOxEAqdQJjzSMhewKiVLKPrD
         gim8Oa0r5+PVQNXIAfjanwTGW9h+3kNgfNQB/W4R6RBGMTHLAB0S0alt1j/y67CTLOPx
         AMbw==
X-Forwarded-Encrypted: i=1; AJvYcCWYlwTg9U5pel9L6UmhMTzTqUf+HXD9c8btj1eriHOWSJF9Onhc1sO+umHqdWRFgBL0X5xpL6Ti+YxJ4p8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0jJFAWlWHNYkSOfYIPd09GlGL3OrZXFBRfW8ZMkmz7K4aN566
	THYuJmtql4Mf2VIcR7R24dJpFUib31S+JrSiCHrs2S2qWkYkDH03OhaB+R8kKutPXtIq7VuS7/T
	vZGsRXQ==
X-Google-Smtp-Source: AGHT+IFKrK4DyvDs6icrv139iiVhcAJ0rM2fF5QOWM4aN0sWp3WOepuMUy4R3vBuKLLHhh/FqQWKc6J3ksg=
X-Received: from plbu12.prod.google.com ([2002:a17:902:e20c:b0:240:801d:1089])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2451:b0:240:ac96:e054
 with SMTP id d9443c01a7336-24288d93ae0mr51708995ad.23.1754401757653; Tue, 05
 Aug 2025 06:49:17 -0700 (PDT)
Date: Tue, 5 Aug 2025 06:49:15 -0700
In-Reply-To: <6891826bbbe79_cff99100f7@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523095322.88774-1-chao.gao@intel.com> <20250523095322.88774-8-chao.gao@intel.com>
 <aIhUVyJVQ+rhRB4r@yilunxu-OptiPlex-7050> <688bd9a164334_48e5100f1@dwillia2-xfh.jf.intel.com.notmuch>
 <aIwhUb3z9/cgsMwb@yilunxu-OptiPlex-7050> <688cdc169163a_32afb100b3@dwillia2-mobl4.notmuch>
 <aJBamtHaXpeu+ZR6@yilunxu-OptiPlex-7050> <68914d8f61c20_55f0910074@dwillia2-xfh.jf.intel.com.notmuch>
 <aJFUspObVxdqInBo@google.com> <6891826bbbe79_cff99100f7@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <aJIL2wR3p1o_N4ZE@google.com>
Subject: Re: [RFC PATCH 07/20] x86/virt/tdx: Expose SEAMLDR information via sysfs
From: Sean Christopherson <seanjc@google.com>
To: dan.j.williams@intel.com
Cc: Xu Yilun <yilun.xu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	linux-coco@lists.linux.dev, x86@kernel.org, kvm@vger.kernel.org, 
	pbonzini@redhat.com, eddie.dong@intel.com, kirill.shutemov@intel.com, 
	dave.hansen@intel.com, kai.huang@intel.com, isaku.yamahata@intel.com, 
	elena.reshetova@intel.com, rick.p.edgecombe@intel.com, 
	Farrah Chen <farrah.chen@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 04, 2025, dan.j.williams@intel.com wrote:
> Sean Christopherson wrote:
> > On Mon, Aug 04, 2025, dan.j.williams@intel.com wrote:
> > > Xu Yilun wrote:
> > > > So my idea is to remove tdx_tsm device (thus disables tdx_tsm driver) on
> > > > vmxoff.
> > > > 
> > > >   KVM                TDX core            TDX TSM driver
> > > >   -----------------------------------------------------
> > > >   tdx_disable()
> > > >                      tdx_tsm dev del
> > > >                                          driver.remove()
> > > >   vmxoff()
> > > > 
> > > > An alternative is to move vmxon/off management out of KVM, that requires
> > > > a lot of complex work IMHO, Chao & I both prefer not to touch it.
> > 
> > Eh, it's complex, but not _that_ complex.
> > 
> > > It is fine to require that vmxon/off management remain within KVM, and
> > > tie the lifetime of the device to the lifetime of the kvm_intel module*.
> > 
> > Nah, let's do this right.  Speaking from experience; horrible, make-your-eyes-bleed
> > experience; playing games with kvm-intel.ko to try to get and keep CPUs post-VMXON
> > will end in tears.
> > 
> > And it's not just TDX-feature-of-the-day that needs VMXON to be handled outside
> > of KVM, I'd also like to do so to allow out-of-tree hypervisors to do the "right
> > thing"[*].  Not because I care deeply about out-of-tree hypervisors, but because
> > the lack of proper infrastructure for utilizing virtualization hardware irks me.
> > 
> > The basic gist is to extract system-wide resources out of KVM and into a separate
> > module, so that e.g. tdx_tsm or whatever can take a dependency on _that_ module
> > and elevate refcounts as needed.  All things considered, there aren't so many
> > system-wide resources that it's an insurmountable task.
> >
> > I can provide some rough patches to kickstart things.  It'll probably take me a
> > few weeks to extract them from an old internal branch, and I can't promise they'll
> > compile.  But they should be good enough to serve as an RFC.
> > 
> > https://lore.kernel.org/all/ZwQjUSOle6sWARsr@google.com
> 
> Sounds reasonable to me.
> 
> Not clear on how it impacts tdx_tsm implementation. The lifetime of this
> tdx_tsm device can still be bound by tdx_enable() / tdx_cleanup(). The
> refactor removes the need for the autoprobe hack below. It may also
> preclude async vmxoff cases by pinning? Or does pinning still not solve
> the reasons for bouncing vmx on suspend/shutdown?

What exactly is the concern with suspend/shutdown?

Suspend should be a non-issue, as userspace tasks need to be frozen before the
kernel fires off the suspend notifiers.  Ditto for a normal shutdown.

Forced shutdown will be asynchronous with respect to running vCPUs, but all bets
are off on a forced shutdown.  Ditto for disabling VMX via NMI shootdown on a
crash.

