Return-Path: <linux-kernel+bounces-841353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B648BB7108
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D515834622F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7AB1E230E;
	Fri,  3 Oct 2025 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lhs/1BtH"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3E81D7E42
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759499157; cv=none; b=f18+IiPc1v90CzKHmeUiONW9+5amDcTtdsdx5rd7sKDpKbrSdHGyD8wNetIVt2CXAqLicAQqi06R8iclTKGP2f6/FYPYT0zjHeH4WWKEHj8J9YTrkHXqa+TyNp504mOBQkXu7B+yI2mXSw+Pri9YbrwTzg3maPYmy5DKRg5tnkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759499157; c=relaxed/simple;
	bh=lAOM2D3q+yPPPrqg95DoD4MK+sOaAd20YYEUkxw5gc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxU4hxSpxXbP3Nq7oscgNusylaneVlLQn7U4Fxz7N6H9EEd5rdn7N0brAUm+IBh0H7RxI3TQxFxHl4TuV7HacFkno5kx4nT8fYsLIqrd8aMeAXcjsJJC4fA0IV9EBNX9mvf0lyRwximOXTrPA0oX/47zniYT4NBTxJooCzi7cx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lhs/1BtH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso2126154f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759499154; x=1760103954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7NnV3eqraDFqVYDcKFCeKin09qktano3eAT2xMof4Q=;
        b=Lhs/1BtH4CYX7sisGZhr1bUv9mrOs2oeBRZX2RXJG9ry7XNzmmuEUwhToBE0kiKyjg
         7IQ8G7gydYL8aPgOFbJnWDNPAgZdRBqDHMDQRbBkX1CXKd0/bfEwlJxjhs1KL3iParCf
         jcH53qPH/KKqkkrXBwbf+Eytzcsf+/6PD2FQVjRHppwJkOUO7GmbJg9f/ndjIDuMSanI
         P0hf/u/6sZdurPNOIYGjDdTC6VgcBDNT2M+Z3TJ9RUwVbB1718lIoVhUj+wiBlZ0pimU
         jb/qE4OJM0C6C9yPu9qW8HAJAqR60A3YU19jLAZjqBJfHlqP0AKmHAIi3Xsi5XO/rpTv
         NVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759499154; x=1760103954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7NnV3eqraDFqVYDcKFCeKin09qktano3eAT2xMof4Q=;
        b=pTCEccL/3+jlrYoxyi9o/rIWVsndjFU+gvnTc94Ax5dHDbPlOpiY6da4ymjmU5Mla7
         XxxxVZNorDmSPbIow55BVMmuXRYHxDCFFqtRdA8FX5SEzK8Xt7T4DCCpBaPa0Q+0LVC5
         ftd16rj3tVcl0v9ySbvFwQWgT5wKXNxovHYgIDvBdDRie9s6hUXFqN3j15FX9vv/wvQ2
         9Cn8ETUU9AxYPeuq4rXIhGvudrkJxKEx8cFoazEPtciqL125Ogvn9DaaZpDSD7tGExxu
         jjIfmbvhScMPomIt5SNvD1nrB2shvGuaQGQQmR+LJNVNYA8IL0W9FtMOZROA2aUU4O4Q
         3P/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+E9m+lbq58wJGEGXgLiVJcvGXpg2N0IdUN7pxceqI4oWDEav0PSTwc1c0BTgeFhEmzlSq/jtZPP/FZV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzru/wKVE2mmU8kLW9CC0U9UQJO5ilzGwwAOxVMHCwr18byh5N8
	x+JiEWdSwAodaJmwns1ByO6YtBHqpKBYbeGNs0q2A2yM57/06NnQKlWRvVN+TwaloQ==
X-Gm-Gg: ASbGncsLx7KxwGHZrEw4k9o73HI4x1P6vpNb800DPltePNWacYpt+2xzWc59oErtb3l
	hAciDa1TNTb7wneKwCNq9+JcG8TsXiYtVWDFcQiGJoqB5qxgppOmdzNZQoyjt7DGJYqbx2NMPh8
	wqZdvZPhKUBwkzTuMNSGUNAcHktkgZiDIpcsQoUZ5IPJIjT9Aaxna9T02Aqv3XcMiaEBVG2AoRK
	z37UE3xN/d4UAQkKZVSfGSUqgMogVyN+FepsG8TTpVnAlMLSxq1+9o6Oc8/5Ikcvf0oLowz/yp5
	j83h7RlJyDxToYXwZHE10HMuSZgwpzVCXYiLnjmf3ZSITfvPKbqpQBxf09aoFRZk4VestF0RKZ+
	izMY0vn6dM6soPLo+6jX44+3iOV24W8fTxZd1hQU39GPwlgMAKcZ3qPBVQw626f1iZGtmGx11xI
	nS0kEsLSMegCmsh9Q9YUwXXkA02BpH8Ejz1Xdx7sG2Vg==
X-Google-Smtp-Source: AGHT+IEavx1XQVkYuSWqBefYKiu6P3uDkj7db45yOXEIBwP67t8LkAcoTa6xCOF8nZoREgj6u0pW7g==
X-Received: by 2002:a05:6000:616:b0:3ea:bccc:2a2c with SMTP id ffacd0b85a97d-4256713edf9mr2335026f8f.11.1759499154166;
        Fri, 03 Oct 2025 06:45:54 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f01a0sm8064916f8f.48.2025.10.03.06.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 06:45:53 -0700 (PDT)
Date: Fri, 3 Oct 2025 14:45:50 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, qperret@google.com,
	sebastianene@google.com, keirf@google.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2] KVM: arm64: Check range args for pKVM mem transitions
Message-ID: <aN_TjloudttqBUtf@google.com>
References: <20250919155056.2648137-1-vdonnefort@google.com>
 <87plbkxcvv.wl-maz@kernel.org>
 <aNG417MneSKBxyn8@google.com>
 <aNHcxAJXHeS2T7TH@linux.dev>
 <aNJmA-1ZlikW2Knw@google.com>
 <86plb7ync9.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86plb7ync9.wl-maz@kernel.org>

[...]

> > > > > > +static bool check_range_args(u64 start, u64 nr_pages, u64 *size)
> > > > > > +{
> > > > > > +	if (check_mul_overflow(nr_pages, PAGE_SIZE, size))
> > > > > > +		return false;
> > > > > > +
> > > > > > +	return start < (start + *size);
> > > > > 
> > > > > I will echo Oliver's concern on v1: you probably want to convert the
> > > > > boundary check to be inclusive of the end of the range. Otherwise, a
> > > > > range that ends at the top of the 64bit range will be represented as
> > > > > 0, and fail the  check despite being perfectly valid.
> > > > 
> > > > Do you mean allowing something like start == 0xfffffffffffff000 and size ==
> > > > 4096?
> > > 
> > > Yes, this is what I was alluding to on v1.
> > > 
> > > > But I guess that would still put all the following checks using "addr + size" at
> > > > risk. Also, I believe even the code in pgtable.c wouldn't support a such range
> > > > as it is also using a u64 end boundary.
> > > 
> > > I'm not sure I follow. Ranges are pretty commonly expressed as a range
> > > terminated by an exclusive value. This just hasn't been an issue yet as
> > > the page table code is only ever dealing with TTBR0 or VTTBR
> > > translations.
> > 
> > If I do exclude the end boundary, evading checks would be as simple as making
> > sure we overflow the end boundary?
> > 
> > e.g. __pkvm_host_share_guest(phys = 0xfffffffffffff000, size = 4096) 
> > 
> >         check_range_allowed_memory(phys, phys + size) /* nop */
> > 	....
> > 	for_each_hyp_page(page, phys, size) {  /* nop */
> >                ...
> > 	} 
> > 	...
> > 	/* Install a valid mapping to phys */
> > 	kvm_pgtable_stage2_map(&vm->pgt, ipa, size, phys, ...) 
> 
> Why shouldn't this be as simple as this:
> 
> static bool check_range_args(u64 start, u64 nr_pages, u64 *size)
> {
> 	if (check_mul_overflow(nr_pages, PAGE_SIZE, size))
> 		return false;
> 
> 	return start < (start + *size - 1);
> }
> 
> which correctly deals with the boundary issue?

I am concerned about allowing ranges that will still overflow "phys + size".

e.g. phys=0xfffffffffffff000 and size=4096 would pass check_range_args().

But in __pkvm_host_share_guest() that would mean:

  bypassing check_range_allowed_memory()
  bypassing for_each_hyp_page()

  but installing a valid mapping to phys with:
   kvm_pgtable_stage2_map(&vm->pgt, ipa, size, phys, ...) 


> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

