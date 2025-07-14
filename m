Return-Path: <linux-kernel+bounces-730683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC38B04813
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175D64A2662
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B242367DF;
	Mon, 14 Jul 2025 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mrV7aq1d"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C150E230997
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752522588; cv=none; b=GzZpJezZTPR5PhbIGogiugXvy3+2g8j6mPyu+vaXbG6/RvIMbDNAkyC6vnAPrTe3AEPgODkIRha+GBvUpnigoI0jTkia4IEQ5E00X9OnWW4vWkGDA1tUQ5FYDgjNk7QFvc4wtJc4ctVduFSOM3vGgnybd3oq+UCxufUIQ8k5y2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752522588; c=relaxed/simple;
	bh=yWOqjM+tnJXB+iS8z8RSLG6VbltiE5lZkB4fv77IZdg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SZlCS/rYQAkJpX4+nUeF4yBtwaETKjgLuS7Jbr0EHaozvy4Bxfy/XYnwOrEz/jLyBB3M9PAG1dceHqUBfwoG3N7/DOLnSETbJBZbD6c1DDpBKeg0OH00u/CM7ATPFz00zygn8mf5q6aaAy1Wcztk9z6em2Q0NkyCel8doa7rLuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mrV7aq1d; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3bc9d9590cso4625254a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752522586; x=1753127386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ICcg0kScB2Zwj8UqwZwwX6H3Hb3sbc2THMrldLCPfAE=;
        b=mrV7aq1dFqDxTapv8jzGX8ekE7CbCBPrU54VhTHi7AiBfBjispbdVQbQ5/J2l7xTLs
         ETphmykk5WEbzRoYKXK57QDPxsm2TcXZ+WnShdd8GA0jdmoxnQXMyjMTkRd3+B+5GRPY
         eVSLY8IBW00BWNfacBDeW5cNIXm9Un+hxXCcC4ZjSM6E/MzQGAK5CZGpE244jZtK7YYc
         UIlpmjC2rHto2Ksxv02HJ7gjjlpFFLyRl3KHHpvhhmgO1yNPn92tc9xYX6IHnTqe6AWX
         A2spY2bSkjZvtNUlQhAx+5GXl+qWEjFk+hl1cxZdTQ3deZVAyPZdKPZP50AXph+yGGbC
         RzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752522586; x=1753127386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICcg0kScB2Zwj8UqwZwwX6H3Hb3sbc2THMrldLCPfAE=;
        b=PVni5+ml5oYR2Z128F5YFB4Qx7Ih4YlOnfpuUbTqoLcx0k1ofI5xLO4aiqJm8GZGRp
         J9pvJN9OvSY60We2WSg9ZSyCq+cCNbq+9i9iIb/jdR9uMIbAS3Vz8Z0jt44y4/zgEMtX
         p/BYpIf475pLIFM0ZIuqD/6PdjJ1TSK5CLnsvu+gx1eBgr+Bd3dQkb/7wEKbG1ron9wi
         EL9ZVFQVn2RN4zimmJJDD2omF3JBUgWgk4RdUygM9gIFJ8LXzw0B8NRfhF/dFUL9KtFe
         ZQDjbz5G6ycsHbSeQOR1gMAKkkCwv4CRN9WlJp4BDJRMAYKy+n9SmcBYsOC00nEXLm0Y
         AhpA==
X-Forwarded-Encrypted: i=1; AJvYcCWVdX4MOHFmScsU7S0bSHjVMRYViI3s8nHm6GvtTrhBR9DHz/g3TyZWTsfGQRdu+QQy5QIMUuQZQPmk+BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOij0w0VT6WUhZWthIkHpP1EGwzKzYghcUpwBwUFLmzTl7NC3W
	Nt8VDk5YLuMwdIBUWL15IGTO0RLVuLYSf9SZJLLzekrLJDV5qQS+ixnD5To3R7o/pjGDC3pziy1
	lTutCXVZiNesMF0FS6P0gU60pRw==
X-Google-Smtp-Source: AGHT+IHYRx34pwTQ1/zxuK41iVUIxojsyjeG9fu7hIcirB2HtzSq/CDTqyAKgWSVpxntbG5X9IzCGePZMY1LK4n9RA==
X-Received: from pfblm11.prod.google.com ([2002:a05:6a00:3c8b:b0:748:f270:c438])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7f8e:b0:1f5:79c4:5da6 with SMTP id adf61e73a8af0-2311dc59daemr19721553637.5.1752522585949;
 Mon, 14 Jul 2025 12:49:45 -0700 (PDT)
Date: Mon, 14 Jul 2025 12:49:44 -0700
In-Reply-To: <4c70424ab8bc076142e5f6e8423f207539602ff1.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <diqzms9pjaki.fsf@ackerleytng-ctop.c.googlers.com>
 <fe6de7e7d72d0eed6c7a8df4ebff5f79259bd008.camel@intel.com>
 <aGNrlWw1K6nkWdmg@yzhao56-desk.sh.intel.com> <cd806e9a190c6915cde16a6d411c32df133a265b.camel@intel.com>
 <diqzy0t74m61.fsf@ackerleytng-ctop.c.googlers.com> <04d3e455d07042a0ab8e244e6462d9011c914581.camel@intel.com>
 <diqz7c0q48g7.fsf@ackerleytng-ctop.c.googlers.com> <a9affa03c7cdc8109d0ed6b5ca30ec69269e2f34.camel@intel.com>
 <diqz1pqq5qio.fsf@ackerleytng-ctop.c.googlers.com> <53ea5239f8ef9d8df9af593647243c10435fd219.camel@intel.com>
 <aHCdRF10S0fU/EY2@yzhao56-desk> <4c70424ab8bc076142e5f6e8423f207539602ff1.camel@intel.com>
Message-ID: <diqzikju4ko7.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 08/21] KVM: TDX: Increase/decrease folio ref for huge pages
From: Ackerley Tng <ackerleytng@google.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
Cc: "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, 
	"Du, Fan" <fan.du@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"david@redhat.com" <david@redhat.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "Li, Zhiquan1" <zhiquan1.li@intel.com>, 
	"Shutemov, Kirill" <kirill.shutemov@intel.com>, "michael.roth@amd.com" <michael.roth@amd.com>, 
	"seanjc@google.com" <seanjc@google.com>, "Weiny, Ira" <ira.weiny@intel.com>, 
	"Peng, Chao P" <chao.p.peng@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, "tabba@google.com" <tabba@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Annapurve, Vishal" <vannapurve@google.com>, 
	"jroedel@suse.de" <jroedel@suse.de>, "Miao, Jun" <jun.miao@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pgonda@google.com" <pgonda@google.com>, 
	"x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> writes:

> On Fri, 2025-07-11 at 13:12 +0800, Yan Zhao wrote:
>> > Yan, is that your recollection? I guess the other points were that although
>> > TDX
>> I'm ok if KVM_BUG_ON() is considered loud enough to warn about the rare
>> potential corruption, thereby making TDX less special.
>> 
>> > doesn't need it today, for long term, userspace ABI around invalidations
>> > should
>> > support failure. But the actual gmem/kvm interface for this can be figured
>> > out
>> Could we elaborate what're included in userspace ABI around invalidations?
>
> Let's see what Ackerley says.
>

There's no specific invalidation command for ioctl but I assume you're
referring to the conversion ioctl?

There is a conversion ioctl planned for guest_memfd and the conversion
ioctl can return an error. The process of conversion involves
invalidating the memory that is to be converted, and for now,
guest_memfd assumes unmapping is successful (like Yan says), but that
can be changed.

>> 
>> I'm a bit confused as I think the userspace ABI today supports failure
>> already.
>> 
>> Currently, the unmap API between gmem and KVM does not support failure.
>
> Great. I'm just trying to summarize the internal conversations. I think the
> point was for a future looking user ABI, supporting failure is important. But we
> don't need the KVM/gmem interface figured out yet.
>

I'm onboard here. So "do nothing" means if there is a TDX unmap failure,

+ KVM_BUG_ON() and hence the TD in question stops running,
    + No more conversions will be possible for this TD since the TD
      stops running.
    + Other TDs can continue running?
+ No refcounts will be taken for the folio/page where the memory failure
  happened.
+ No other indication (including HWpoison) anywhere in folio/page to
  indicate this happened.
+ To round this topic up, do we do anything else as part of "do nothing"
  that I missed? Is there any record in the TDX module (TDX module
  itself, not within the kernel)?

I'll probably be okay with an answer like "won't know what will happen",
but just checking - what might happen if this page that had an unmap
failure gets reused? Suppose the KVM_BUG_ON() is noted but somehow we
couldn't get to the machine in time and the machine continues to serve,
and the memory is used by 

1. Some other non-VM user, something else entirely, say a database?
2. Some new non-TDX VM?
3. Some new TD?


>> 
>> In the future, we hope gmem can check if KVM allows a page to be unmapped
>> before
>> triggering the actual unmap.

