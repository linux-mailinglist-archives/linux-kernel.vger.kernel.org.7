Return-Path: <linux-kernel+bounces-737104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23664B0A7D3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8DF16A343
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA682E03FD;
	Fri, 18 Jul 2025 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yGnP67TA"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3D82DCF64
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852946; cv=none; b=Ju41VtwrIG5nyVOJo+l/CtpH7p68Pu91/mEgzoGsbxjWY/bGSIWZ/UdUQF6dJoMebMv+kPJ0jLPXz8MN9bBjVAVjeOh3J/O6RU8eBhZjCwLYRKeciZHv3TQcJ2PFzY4oi7S8n4B2399QzR+6Rl/W5kJeMWyC522ZzEuseBBS38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852946; c=relaxed/simple;
	bh=4Vfku2YS9tu3aYWTykK4Ku/U89qRWW3/HUMuhIP/xd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lvQpWZYFiDKK50KEJtUFrwvihoY9tFoZi0r6QKd53CtxoV1cfymln47fMHuNX2ABrPbZ10ALllqtDY+6dWvHIqGD/Z7OSAD3H4vvXy08BXElonWd6uox5J+lT62P1FMLc8BiTT8vTdsfuODSyUSSUgtcwIcx9ji0YdnXHJFvXjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yGnP67TA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3122368d82bso2876127a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752852944; x=1753457744; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FMufa9slHHq3UhWrTz98ZkkB+x6OEpY7SyDzwmKTqZs=;
        b=yGnP67TA1aeUipLt1QKuhLpnCnv+D1az3GIpyyaq6m2Hbf5N8KDI8i0jrTuThQlJTC
         zhhNcq0qMC+fj9tw+dmryilRVfbQJbAgqOtzjse4pdWN4l/WqzXl3IGkWcBaAQjXGBgU
         S84omCGltJrEy1FcJvSHroMAzIzeeDguDVSCde6cKCL8wo6ROLojATx0rS6pLajgr5vY
         OfB2ZKpXpajdmeOGZlpb45BQF+1RuoKQlOuzeJTYpJX3k5hh1BEG3dMH83ZM2JjB4qOl
         loGpmqD2uBFii+zb0rTcZvyOEh4osNQeRSWnD1FngsX3X05sL8xkNA38XaPDkbrMQUea
         V0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752852944; x=1753457744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMufa9slHHq3UhWrTz98ZkkB+x6OEpY7SyDzwmKTqZs=;
        b=FBjnye0pBNkAz1np74xZ5G/xyE1Xqh8pBUN3T5MtPCQa531Qz05sFQUwHtm848ZiSb
         X7LqhbampqRlJZCQa3yv5ZWK6R/dLM3d6wciCaWtVMjWne/pZDBRKRqjOCVI33Oz2kEV
         i1MWw2KEOThmrivp0j/BlPcj22LedoSyDE1LMD8sX1gcOvFQq02nVzklnWZ+/r7ExWrl
         QxqjcWcmsKz11V+7Pu9vLQbl7I8DpGXR1OkxE7J8V7LMgkJItUJP4DgL0BmyD42blU9o
         yzAmXXgPGXmSNlsuGnReLXEvnDOrS+RS1OjgvbegEjpjQnH0fV9ejQNjpi/2GArCwBcB
         KzaA==
X-Forwarded-Encrypted: i=1; AJvYcCUsJ1i7OVqkkhXbJDqLBqoW9RHc2izmEyIWz+qTVFoeIDG+BWBj4BV63u7i0xNvra97x5dIdVFfc7o4/3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy20UZa7Hgu7sPvLfuXjfHIkTdE5gNGUGxkDK4Lv+HSc3Zsz28h
	VmITfZ0jS+zMezJBjO910XPFQvYTE4KBj4VpHg7NFqfTzMf59CWY5SHYmzXfKGrhScCg008TxeR
	uqbRm4g==
X-Google-Smtp-Source: AGHT+IH/1HWlOEGTinigbtGS/fI4pZaE0lBuxsB7y4G9gSRNWOYWs+b2FnDCG8rAn4n/EHZZ46lLEQTU4do=
X-Received: from pjbqa6.prod.google.com ([2002:a17:90b:4fc6:b0:315:f140:91a5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3511:b0:312:ea46:3e66
 with SMTP id 98e67ed59e1d1-31c9f45e1c5mr12926141a91.21.1752852944417; Fri, 18
 Jul 2025 08:35:44 -0700 (PDT)
Date: Fri, 18 Jul 2025 08:35:42 -0700
In-Reply-To: <930ca39f-41a6-44d4-85b1-552c56a417e8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611095158.19398-1-adrian.hunter@intel.com>
 <175088949072.720373.4112758062004721516.b4-ty@google.com>
 <aF1uNonhK1rQ8ViZ@google.com> <7103b312-b02d-440e-9fa6-ba219a510c2d@intel.com>
 <aHEMBuVieGioMVaT@google.com> <3989f123-6888-459b-bb65-4571f5cad8ce@intel.com>
 <aHEdg0jQp7xkOJp5@google.com> <930ca39f-41a6-44d4-85b1-552c56a417e8@intel.com>
Message-ID: <aHppzp0WIbLZfVqu@google.com>
Subject: Re: [PATCH V4 0/1] KVM: TDX: Decrease TDX VM shutdown time
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: pbonzini@redhat.com, Adrian Hunter <adrian.hunter@intel.com>, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com, 
	kai.huang@intel.com, reinette.chatre@intel.com, tony.lindgren@linux.intel.com, 
	binbin.wu@linux.intel.com, isaku.yamahata@intel.com, 
	linux-kernel@vger.kernel.org, yan.y.zhao@intel.com, chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 16, 2025, Xiaoyao Li wrote:
> On 7/11/2025 10:19 PM, Sean Christopherson wrote:
> > On Fri, Jul 11, 2025, Xiaoyao Li wrote:
> ...
> > > 
> > > I'm wondering if we need a TDX centralized enumeration interface, e.g., new
> > > field in struct kvm_tdx_capabilities. I believe there will be more and more
> > > TDX new features, and assigning each a KVM_CAP seems wasteful.
> > 
> > Oh, yeah, that's a much better idea.  In addition to not polluting KVM_CAP,
> > 
> > LOL, and we certainly have the capacity in the structure:
> > 
> > 	__u64 reserved[250];
> > 
> > Sans documentation, something like so?
> 
> I suppose it will be squashed into the original patch,

I dropped the commit from kvm-x86/vmx, and will send a full v5.  There's enough
moving parts that I don't want to risk going 'round in circles trying to squash
fixes :-)

> so just gave
> 
> Tested-by: Xiaoyao Li <xiaoyao.li@intel.com>

Thanks! 

