Return-Path: <linux-kernel+bounces-836581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC912BAA121
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1DD3B6F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF56430B52A;
	Mon, 29 Sep 2025 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nb1eBvOE"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F126E610B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759164963; cv=none; b=HI6eGGOSUYxNzk4NasH1GNt3KC7MQzGLd5r0UCLKdFXhu/CGF7v5rTkoNmAEdwsgRM+9+VgIDdlIkTFM/qTr1dLo601Fw3m1V5v1TZtxKuk2gQe2mvW6BRlXyrGPd17pH4K8QYQEf13EagZZjjczxJTRe2b08dQfxSUl2ACCidQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759164963; c=relaxed/simple;
	bh=aq3fWZR1dXZm7LJywJmxuW6r/1l6NXgn+AwCN9U5644=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VqNZwo4Y2G51glMnc84pKak8kO2CS8N8k5Gd7lnlF9QDEFZcN2vAAwQqdbO5y4KgxKgMkCGiIYw+qIF9rYlfU834+cfynGHyXnKzkZ1lxVE4t5uj4kZV67YYlTxqEk3GQldp2tfvOMTjnGmyc6HErC/cy7UdbABg8B1FmO/DplM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nb1eBvOE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ec69d22b2so4587916a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759164961; x=1759769761; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9XbXmWXQ6yw7jgUXJGOGhYyHRPmszq8E1Tp17tZVzwo=;
        b=Nb1eBvOE6obtmOsCmHrBvHnCawNY9rIrIH/iH1NKD/aNY9viljgBfQRjYqEJlTtFEn
         UrtBM2RXIe3I7eF+NA2z7mDZf77VtTdjJUpFOPdyFQodPgf9XoI6nZIN8D2nccXURpwy
         5aiDWfrDmm8wmmq0SjTXQqIv8b50uZLh3dHK/+2cswdL9mp7Kl8w4GGk1WOBPr/cMiKH
         xkOzjQp9g//jPnIj97D5CCYS/JtjpsIHIUqAzmUcUu4yr2GD/d8LI5LT7GHF37QzsMpI
         CtwZYNsIihyoK6OUmNh9JAEDUELZRPCodiWI+KNe+j9OBXQAU2SXpzTDxoemqzWg8QG8
         efBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759164961; x=1759769761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XbXmWXQ6yw7jgUXJGOGhYyHRPmszq8E1Tp17tZVzwo=;
        b=USd9ekzOi0dZMu7k95/EtV97VOyBDrfQSYJ/vK0xxJrRLFmv8C3aCD/D3DLHKwzFVS
         DkSQGY98LjmtxQW9NybWr84oBQC6yWShajI55FFoEAM8NQV8ExN7htXaaMcX3nMBLNc5
         ieXKceO4QXdOJiCGCIJaW4pk8Dp7C7MdtAT1R+qLu3i9ziNkgjHQ734Jb57H2GT5F97A
         GMMeGeeI6bgn0BLDxa9ALOEC1QNtKt8WJ9GgWGsXyUM7dkd2wNwSloUxcqf6xblZrQrx
         vmuIc0M4pvnzXwE2pwD7gUGtWOW0R/RyjxqOeY534W8NOKA3hWFLfmSDzUh6uR5ACpKn
         kcwg==
X-Forwarded-Encrypted: i=1; AJvYcCVQwZkI+u/ek0GkLM2dJ6pbyCEXuzJe4zjb8f/WJxaZlzqt2aqP+kyjetYNeB8IdpR3nkyqgyJiPYImmvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFy3gqMII56Eg+bulZs/9u1LEFoakkch8EM5r/RneK/tBPEc2z
	MxwUzgAGra3XEN+LKJo1KTg7SuN0sNbrz+0ZfQlgjdm+WAN9M8SbjDJL4wop9/K0Ef4YMRYsNv8
	HB9toIA==
X-Google-Smtp-Source: AGHT+IFLjIzTUpc45LEGOUkPN7hnf1kgAXdO/j3/rwcUcXXzok9aWCqi6sPp1tEcnfxySBXZMf749JBhUC8=
X-Received: from pjst22.prod.google.com ([2002:a17:90b:196:b0:330:7be2:9bdc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ece:b0:32b:6145:fa63
 with SMTP id 98e67ed59e1d1-3342a216f73mr17472559a91.4.1759164961433; Mon, 29
 Sep 2025 09:56:01 -0700 (PDT)
Date: Mon, 29 Sep 2025 09:55:59 -0700
In-Reply-To: <diqz4isl351g.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926163114.2626257-1-seanjc@google.com> <20250926163114.2626257-2-seanjc@google.com>
 <CA+EHjTzdX8+MbsYOHAJn6Gkayfei-jE6Q_5HfZhnfwnMijmucw@mail.gmail.com>
 <diqz7bxh386h.fsf@google.com> <a4976f04-959d-48ae-9815-d192365bdcc6@linux.dev>
 <d2fa49af-112b-4de9-8c03-5f38618b1e57@redhat.com> <diqz4isl351g.fsf@google.com>
Message-ID: <aNq6Hz8U0BtjlgQn@google.com>
Subject: Re: [PATCH 1/6] KVM: guest_memfd: Add DEFAULT_SHARED flag, reject
 user page faults if not set
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: David Hildenbrand <david@redhat.com>, Patrick Roy <patrick.roy@linux.dev>, 
	Fuad Tabba <tabba@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nikita Kalyazin <kalyazin@amazon.co.uk>, shivankg@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 29, 2025, Ackerley Tng wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
> >                           GUEST_MEMFD_FLAG_DEFAULT_SHARED;
> >>>>
> >>>> At least for now, GUEST_MEMFD_FLAG_DEFAULT_SHARED and
> >>>> GUEST_MEMFD_FLAG_MMAP don't make sense without each other. Is it worth
> >>>> checking for that, at least until we have in-place conversion? Having
> >>>> only GUEST_MEMFD_FLAG_DEFAULT_SHARED set, but GUEST_MEMFD_FLAG_MMAP,
> >>>> isn't a useful combination.
> >>>>
> >>>
> >>> I think it's okay to have the two flags be orthogonal from the start.
> >> 
> >> I think I dimly remember someone at one of the guest_memfd syncs
> >> bringing up a usecase for having a VMA even if all memory is private,
> >> not for faulting anything in, but to do madvise or something? Maybe it
> >> was the NUMA stuff? (+Shivank)
> >
> > Yes, that should be it. But we're never faulting in these pages, we only 
> > need the VMA (for the time being, until there is the in-place conversion).
> >
> 
> Yup, Sean's patch disables faulting if GUEST_MEMFD_FLAG_DEFAULT_SHARED
> is not set, but mmap() is always enabled so madvise() still works.

Hah!  I totally intended that :-D

> Requiring GUEST_MEMFD_FLAG_DEFAULT_SHARED to be set together with
> GUEST_MEMFD_FLAG_MMAP would still allow madvise() to work since
> GUEST_MEMFD_FLAG_DEFAULT_SHARED only gates faulting.
> 
> To clarify, I'm still for making GUEST_MEMFD_FLAG_DEFAULT_SHARED
> orthogonal to GUEST_MEMFD_FLAG_MMAP with no additional checks on top of
> whatever's in this patch. :)


