Return-Path: <linux-kernel+bounces-656563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6BAABE7EF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 01:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77F8189C880
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 23:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE0D256C77;
	Tue, 20 May 2025 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qpri72VT"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225FA1DA61B
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747782964; cv=none; b=te3nZR58CVoi80imOW8ojl1oIy/MyPVmsz70lFNPtOtxVaJnThh7jqlRqyNauJtA5niiEgOfIfA3CoH7HsiStQy0inbogz2stagZnhxMYwv0WilQus3A7DBlZ4FdKDq1il/K20IB3nvlp4AXhMLfgfu38NLFqr5YQY7Mfq4434E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747782964; c=relaxed/simple;
	bh=V49+wvZSkSClDuCcnm25JfpxZ7oWhgCCRdsoYwrf/VI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U+kAZdiTNRncv75CgIZu3oRC+IgNEFW1sy0G4NyMHxyI2D0RhNz9VvXtX8307eJQuf6oxunnS3bbefrExkOR+oCYkaMChD3NEt3XxydvDByCmmmNjLUaidfBxQ3ECuIHi3X8nJlG0FzWXAdLDSELtzpjD7WY8XUTyRGSE4k7pC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qpri72VT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7429f7f9ee3so4153636b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 16:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747782962; x=1748387762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4cbee5BV2pMryTjZId+rssa6eMiSUYJChHQbxz3+S4=;
        b=Qpri72VTuCRty6EX7q89ILJ3tEtTZ+xuok76F3GDrO0iIJbEvRaqBby06GqIU+WRDL
         kpqupcvWit/AtduU8wHuKceF35zxSRMyoZ2BVDjdanQck9Yh9OQEZxXMlybIoPbH6Tai
         02zF7/rWOt5OFE2hmwlhiZUxElYfzEXb9CIShduWMwYVTexJZxUDvVX9PAT4NGV8iFYb
         IJuuvplhKAxOsrgwAV4lZ720lUxfUxZNYS8A3l465ef639DRG3Z1Q2erj5920lEErWf7
         vfC8BbqoYP4Hfh64vTuVvc20aJcJ279yB00MvPmEY9c6S9ERG65XCin63C3kU0rtqR7v
         YtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747782962; x=1748387762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4cbee5BV2pMryTjZId+rssa6eMiSUYJChHQbxz3+S4=;
        b=ej9w0WAbIdoCha66g6fXEXYuuYlGKQ755M0pL32XIayndkjmCJCTyYyrsNW4EunX8d
         5tOsVXCa4RiXQ3GMmL98naeDCbSFTI2pDrkjOtOF+PCKVzCT6ziegPb5HehKxOrsUbMu
         G/LQ9rIgCktDuAmzzu/hc2ndl83tZP+EHhjiahMLhLMX5QNObTO3v1OMxrq/9DEdpxcK
         VZmFlZMikI2mvthsXWGbVUa7g1AeXBT2LGsaTdWh8hgCdbgfHn4PUbivBEqPSN8UKsi4
         +jxfFdaqBTR4l0Z/X+T5kTjl80vQRutXooWv1MqyUP1uoOJpfNuvsz8tBwJapxNVx/A0
         Oo4w==
X-Forwarded-Encrypted: i=1; AJvYcCXsLr6SFRnm3Z0GLSiCKQZOeAzU7E4vvnQxtZGGe3jqKrA9S1QRa8K58KUU4Kq0Mi/Cc8PFw3RKbOZSHqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPFbsty4yigMH+QcM42p2zyXdQKn8rrG4p3L7iMYZgxh678Oy0
	oHXaR/eFLydCWeiGZc4853301gWZDhJ7op8iRIPXGLIplT0qnXV9y10sDIYc98M7tBXwT8P8ShJ
	XhUtb3g==
X-Google-Smtp-Source: AGHT+IHkdzkAlbF7H+doOwdZzLuUT4V6bPTxDi+HdVal9AMrCuWDaMB1CPv0u5ndAaOdTSloz6Jct2KSJAI=
X-Received: from pgbdl10.prod.google.com ([2002:a05:6a02:d0a:b0:b0c:3032:f595])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a341:b0:1f6:6539:e026
 with SMTP id adf61e73a8af0-216218e668fmr29244428637.15.1747782962355; Tue, 20
 May 2025 16:16:02 -0700 (PDT)
Date: Tue, 20 May 2025 16:16:00 -0700
In-Reply-To: <aCzUIsn1ZF2lEOJ-@x1.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516213540.2546077-1-seanjc@google.com> <aCzUIsn1ZF2lEOJ-@x1.local>
Message-ID: <aC0NMJIeqlgvq0yL@google.com>
Subject: Re: [PATCH v3 0/6]  KVM: Dirty ring fixes and cleanups
From: Sean Christopherson <seanjc@google.com>
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, James Houghton <jthoughton@google.com>, 
	Pankaj Gupta <pankaj.gupta@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, May 20, 2025, Peter Xu wrote:
> On Fri, May 16, 2025 at 02:35:34PM -0700, Sean Christopherson wrote:
> > Sean Christopherson (6):
> >   KVM: Bound the number of dirty ring entries in a single reset at
> >     INT_MAX
> >   KVM: Bail from the dirty ring reset flow if a signal is pending
> >   KVM: Conditionally reschedule when resetting the dirty ring
> >   KVM: Check for empty mask of harvested dirty ring entries in caller
> >   KVM: Use mask of harvested dirty ring entries to coalesce dirty ring
> >     resets
> >   KVM: Assert that slots_lock is held when resetting per-vCPU dirty
> >     rings
> 
> For the last one, I'd think it's majorly because of the memslot accesses
> (or CONFIG_LOCKDEP=y should yell already on resets?).  

No?  If KVM only needed to ensure stable memslot accesses, then SRCU would suffice.
It sounds like holding slots_lock may have been a somewhat unintentional,  but the
reason KVM can't switch to SRCU is that doing so would break ordering, not because
slots_lock is needed to protect the memslot accesses.

> The "serialization of concurrent RESETs" part could be a good side effect.
> After all, the dirty rings rely a lot on the userspace to do right things..
> for example, the userspace better also remember to reset before any slot
> changes, or it's possible to collect a dirty pfn with a slot index that was
> already removed and reused with a new one..
> 
> Maybe we could switch the sentences there in the comment of last patch, but
> not a huge deal.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Thanks!
> 
> -- 
> Peter Xu
> 

