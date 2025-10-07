Return-Path: <linux-kernel+bounces-844487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFC8BC20B0
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAAB03B33A9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB281FDE09;
	Tue,  7 Oct 2025 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nZYxYjVo"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AEC2147E5
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853344; cv=none; b=agwXWHWPWwg2/viiDdoXahdhtYzMFK6p0EKFU55r1JA0h1dZYg6cThpF7RqffvQJWZoZZfAs1CVMx6VcJIKV//JXMfu1KWV3/0x1ncZTTX6vkujB45e5UToLtgG06y+qCZW9T2Pbx+1vNetwfTSMOliPyOQrMnSJtZenwUhTSvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853344; c=relaxed/simple;
	bh=DNrkTp8RX4EWI1fAzGGJws0mK3inDtIcz0wHqoLXV7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gxad/XnmX+Yg1RyH2TrjD37RAbPraOQ6SymqRA4BucyDDh/XLjZCUWhmy3ZLSGwEuDLMkmZ/sapqkc0Gv2KMbXcbGCeF92QPcoF3BLFUI5VaYlBsWqiovlpa88OYKVaWzBgwndIrWhDkkdYa5OTcX2zYR9+jO8DrajOmBRXoPlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nZYxYjVo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b5a013bc46dso4577991a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759853342; x=1760458142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJ0YWNcX4bsIgpSbsUgjSTbO0BQRfqHw10UQrW5qhyY=;
        b=nZYxYjVo90OSPYfhlZevjObHoWfwLddvUzCRz56LPceftI2vHC0UUN6bH9X+ScGoHd
         qd3MxXVhHxaXFUVpp5EBjLMnjowQkwroGpxqnpatEZetRhppOdEnWgGUZUDnx7suQr+R
         P4rxo3WtsDUzatyQ4paG1HK5iEg/J6/BGoebt7wEKTEQCmzSrf8FTKkmsErUo+LgmTDv
         8eyduH6nLsDRb0y2DI/9H7Ob8KnRXfpLr37Ebv/cnqjooTiLVndEDjVEAdV96BzG193r
         hAz7HVPfm+xP9IkpSts5VhmigneaoKGj/xy38MagLN4jinStSvP7Kays8c1ofd5Gdz6T
         Qkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759853342; x=1760458142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJ0YWNcX4bsIgpSbsUgjSTbO0BQRfqHw10UQrW5qhyY=;
        b=NGkqgrkhmklDt4bV2WEVHFMNtEl5RtGAGKmc1KQvokNgNEwgon+sVZqMwK63Jf5vGD
         z1Y/BPoZum3tmh+wHvQHbceeiSALJ6S9SLLC0HcBnIGFn+/YcJOmxaQz4J1UiTsyGHTN
         wcgyAqvdryopnfcEbFlysjhCzNFpn9M+gwP3mDJT/5ehAXzAKC1pfPXD+77U2InvST4t
         BoRSVi15FOu+Kkavqd927q90BEZNU4aVDJpsRjZbymQWeEHLUU7v8i11V86pYRrG0Dra
         zsi3yO3MrIxfcdKB6dQZyGt/RtOC6kbXqT+b9B5Byx2ey2IukTBlHZWZPC7s8f4xnMn7
         DaMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEDSA93AAxhute9QNGuHWIqnElOo/v6h/rn3WgECIsz6g9SHokxJqk/CGvoVJmcS9/RPlu54SPcHDLmNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh0fE+5AHsFZ8gXSHjqEnVfLRLCJenExzTwUnvlvxuPw2rHB3U
	3Fb+XYeMyK+KmYaMbAUUW29ifW7R8D8Rm/AWqfLZkrwm3q3tYm97UaLvcAtpNrTPVj+ERJORxxP
	klNIqKAZxPqLQEKmYDXRB3QgR0A==
X-Google-Smtp-Source: AGHT+IEYnZENF0iYfPvW2pKAC0HwriPBAzHA71m0TIFC4/qk5L1ugLas6mZSYli5gIFzefd51lLPNWeTsm2sXC+1aA==
X-Received: from pgac17.prod.google.com ([2002:a05:6a02:2951:b0:b58:7d6e:e9c3])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7351:b0:2a2:850:5605 with SMTP id adf61e73a8af0-32da8130f75mr82710637.23.1759853342371;
 Tue, 07 Oct 2025 09:09:02 -0700 (PDT)
Date: Tue, 07 Oct 2025 09:09:01 -0700
In-Reply-To: <aOQkaJ05FjsZz7yn@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003232606.4070510-1-seanjc@google.com> <20251003232606.4070510-2-seanjc@google.com>
 <diqzplazet79.fsf@google.com> <aOQkaJ05FjsZz7yn@google.com>
Message-ID: <diqzh5waelsy.fsf@google.com>
Subject: Re: [PATCH v2 01/13] KVM: Rework KVM_CAP_GUEST_MEMFD_MMAP into KVM_CAP_GUEST_MEMFD_FLAGS
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Oct 06, 2025, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > Rework the not-yet-released KVM_CAP_GUEST_MEMFD_MMAP into a more generic
>> > KVM_CAP_GUEST_MEMFD_FLAGS capability so that adding new flags doesn't
>> > require a new capability, and so that developers aren't tempted to bundle
>> > multiple flags into a single capability.
>> >
>> > Note, kvm_vm_ioctl_check_extension_generic() can only return a 32-bit
>> > value, but that limitation can be easily circumvented by adding e.g.
>> > KVM_CAP_GUEST_MEMFD_FLAGS2 in the unlikely event guest_memfd supports more
>> > than 32 flags.
>> 
>> I know you suggested that guest_memfd's HugeTLB sizes shouldn't be
>> squashed into the flags. Just using that as an example, would those
>> kinds of flags (since they're using the upper bits, above the lower 32
>> bits) be awkward to represent in this new model?
>
> Are you asking specifically about flags that use bits 63:32?  If so, no, I don't
> see those as being awkward to deal with.  Hopefully we kill of 32-bit KVM and it's
> a complete non-issue, but even if we have to add KVM_CAP_GUEST_MEMFD_FLAGS2, I
> don't see it being all that awkward for userspace to do:
>
>   uint64_t supported_gmem_flags = kvm_check_extension(KVM_CAP_GUEST_MEMFD_FLAGS) |
>                                   (kvm_check_extension(KVM_CAP_GUEST_MEMFD_FLAGS2) << 32);
>
> We could even mimic what Intel did with 64-bit VMCS fields to handle 32-bit mode,
> and explicitly name the second one KVM_CAP_GUEST_MEMFD_FLAGS_HI:
>
>   uint64_t supported_gmem_flags = kvm_check_extension(KVM_CAP_GUEST_MEMFD_FLAGS) |
>                                   (kvm_check_extension(KVM_CAP_GUEST_MEMFD_FLAGS_HI) << 32);
>

Had the same thing in mind, I guess having a precedent (and seeing it in
code) makes it seem less awkward. Thanks!

> so that if KVM_CAP_GUEST_MEMFD_FLAGS_HI precedes 64-bit-only KVM, it could become
> fully redundant, i.e. where someday this would hold true:
>
>   kvm_check_extension(KVM_CAP_GUEST_MEMFD_FLAGS) == 
>   kvm_check_extension(KVM_CAP_GUEST_MEMFD_FLAGS) | kvm_check_extension(KVM_CAP_GUEST_MEMFD_FLAGS_HI) << 32
>
>> In this model, conditionally valid flags are always set, 
>
> I followed everything except this snippet.
>

I meant "conditionally valid" as in if GUEST_MEMFD_FLAG_BAR was valid
only when GUEST_MEMFD_FLAG_FOO is set, then with this model, when
KVM_CAP_GUEST_MEMFD_FLAGS is queried, would KVM return
GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_FOO | GUEST_MEMFD_FLAG_BAR,
where GUEST_MEMFD_FLAG_BAR is the conditionally valid flag?

>> but userspace won't be able to do a flags check against the returned 32-bit
>> value. Or do you think when this issue comes up, we'd put the flags in the
>> upper bits in KVM_CAP_GUEST_MEMFD_FLAGS2 and userspace would then check
>> against the OR-ed set of flags instead?
>
> As above, enumerate support for flags 63:32 in a separate capability.

Got it.

