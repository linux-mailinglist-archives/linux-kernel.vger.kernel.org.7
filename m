Return-Path: <linux-kernel+bounces-673623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE35DACE3B8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 19:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4853A41ED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D991FA85A;
	Wed,  4 Jun 2025 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S00XEt76"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6FC1F30C3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749058519; cv=none; b=cs+zYYtMtwPUx0SV2D4f4+tPXnxsFYp0yC8bBcqGwV8RATJrUvzkuwcRArY1Cezqn5I4ceKGijQ1FoSmiw+yX8ojkGuYSDmdBlDJriovU+d85bp9eajDgVVWvYUmRlXpkmtmTaGcLqzmEhkavxe4NZN+5HLHnJYzIfSsivAF94I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749058519; c=relaxed/simple;
	bh=zzxwxQCDKAB4dboxV2rmHCeBL+5T0U4Nw6SEwvA2beQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IHReHI4ZPPZZV+lOsYdvoxJW/yor5dG9K4lBwIWmpoAhINob1Gs77LYlziCpXrS5hgFGf+O2ohx+saKbRhTLV+0KHBWAIwjCTG7JZigO646tltgUtzcximgRvpBO2TMYYI22RPNlRyaUDAz76YAI+h6UySHDjorlrXKpxpMUHRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S00XEt76; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-312436c2224so137382a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 10:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749058516; x=1749663316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t5pH19kUin7kuIgMaTOqCzsDR1YIA5s6PqreVVlqrfc=;
        b=S00XEt76I0O2wA1Jls5cKqrxYWLkxXgPg/YxxBd6wYSi6q1JsXrCZXMfZDN/VCljFL
         4gUFmMaA5+pzmM6cRl/LwAxKf4rgTTDNoRq1c3sb3kgQCwIaUyUHh9o94D4We1A9lj9E
         Jm5Z7ESfEfNzC/yD05SQSBugNMnNYRfPbZWZTQzq6qeH+d7TxnkFtFX1B0R23lkOKIuP
         NYWOUfisZ/EivYcKOeeHnNpq6Mg+9cUB7OGffUccRwB+r8X1gcqBUjOZK02D0WYJEuaz
         nu9NL5ahqFqkcg4ovFS5vGPKVa56gK0/X8IK/iUm+Q2bng7pdVmhQY+7Zm+cQBMm+IZl
         R9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749058516; x=1749663316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5pH19kUin7kuIgMaTOqCzsDR1YIA5s6PqreVVlqrfc=;
        b=OInBOJXrreU3yFPd3yfptIazFl2qnpHU0jJZlVE0/VVAqiXYEjhP+/KMfiZiqQdyWF
         DGdWp/2HLBtKHxzqDCe0XU2nuYUjv74GADvT/jgCy9Ow6qeuE6XX6ZW4KI1DfTSzJy26
         +XvKf4LpcM/aIfQZ5OdAnjSTwslo+1BeEJSfYKt6rnE4IT1hgEXo/53ZKmAnzPnm3XWZ
         1RlZ5CALyt1YmbMG2Z8nMuZ95GJOBzGlE8v5vXX5Wo7toSoEhzbfbSCcSIg5sVf+n/o5
         QnZ9VlmuuJtS7k4QjdS47OZFrJaEF3fPavJgeusCJn//4kgceIDcjyQd8dcS5s5ywDmM
         PJ/A==
X-Forwarded-Encrypted: i=1; AJvYcCXzZ2IYSZZBJZDviFD4KHdPZQWd36yQ9rGgR3ZjehUCJj6qWRHuAbKMMFRNubS2z+hYbq9beOIQgoBmQsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcHJacObt/A5pgSsP0/GfiE9oGfKqoECyiEsq/5B2Btpged8K7
	iLlaXcAPVNRqH+d5C7MEIfH9SC3ChaAgtXHSEJ+//a9RAQJWpeuNSsDRV3of9FcyUWbbyPtqJ0P
	XY00R7Q==
X-Google-Smtp-Source: AGHT+IEh644nHLMZG8iruWmlaHBNnlnTbIkx/itMwt/c/NwkFBDlRPw5quOq+bS+v13cY3D6K+I2B/zINw8=
X-Received: from pjbmf11.prod.google.com ([2002:a17:90b:184b:b0:2fc:3022:36b8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da87:b0:311:e8cc:4253
 with SMTP id 98e67ed59e1d1-3130ccf5106mr4607756a91.2.1749058516652; Wed, 04
 Jun 2025 10:35:16 -0700 (PDT)
Date: Wed, 4 Jun 2025 10:35:15 -0700
In-Reply-To: <1392db34-0c37-49db-8ece-68c02ff3520d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529234013.3826933-1-seanjc@google.com> <20250529234013.3826933-12-seanjc@google.com>
 <1392db34-0c37-49db-8ece-68c02ff3520d@redhat.com>
Message-ID: <aECD09sxnFAA2Te5@google.com>
Subject: Re: [PATCH 11/28] KVM: SVM: Add helpers for accessing MSR bitmap that
 don't rely on offsets
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>, Chao Gao <chao.gao@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 04, 2025, Paolo Bonzini wrote:
> On 5/30/25 01:39, Sean Christopherson wrote:
> > diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> > index 47a36a9a7fe5..e432cd7a7889 100644
> > --- a/arch/x86/kvm/svm/svm.h
> > +++ b/arch/x86/kvm/svm/svm.h
> > @@ -628,6 +628,50 @@ static_assert(SVM_MSRS_PER_RANGE == 8192);
> >   #define SVM_MSRPM_RANGE_1_BASE_MSR	0xc0000000
> >   #define SVM_MSRPM_RANGE_2_BASE_MSR	0xc0010000
> > +#define SVM_MSRPM_FIRST_MSR(range_nr)	\
> > +	(SVM_MSRPM_RANGE_## range_nr ##_BASE_MSR)
> > +#define SVM_MSRPM_LAST_MSR(range_nr)	\
> > +	(SVM_MSRPM_RANGE_## range_nr ##_BASE_MSR + SVM_MSRS_PER_RANGE - 1)
> > +
> > +#define SVM_MSRPM_BIT_NR(range_nr, msr)						\
> > +	(range_nr * SVM_MSRPM_BYTES_PER_RANGE * BITS_PER_BYTE +			\
> > +	 (msr - SVM_MSRPM_RANGE_## range_nr ##_BASE_MSR) * SVM_BITS_PER_MSR)
> > +
> > +#define SVM_MSRPM_SANITY_CHECK_BITS(range_nr)					\
> > +static_assert(SVM_MSRPM_BIT_NR(range_nr, SVM_MSRPM_FIRST_MSR(range_nr) + 1) ==	\
> > +	      range_nr * 2048 * 8 + 2);						\
> > +static_assert(SVM_MSRPM_BIT_NR(range_nr, SVM_MSRPM_FIRST_MSR(range_nr) + 7) ==	\
> > +	      range_nr * 2048 * 8 + 14);
> > +
> > +SVM_MSRPM_SANITY_CHECK_BITS(0);
> > +SVM_MSRPM_SANITY_CHECK_BITS(1);
> > +SVM_MSRPM_SANITY_CHECK_BITS(2);
> 
> Replying here for patches 11/25/26.  None of this is needed, just write a
> function like this:
> 
> static inline u32 svm_msr_bit(u32 msr)
> {
> 	u32 msr_base = msr & ~(SVM_MSRS_PER_RANGE - 1);

Ooh, clever.

> 	if (msr_base == SVM_MSRPM_RANGE_0_BASE_MSR)
> 		return SVM_MSRPM_BIT_NR(0, msr);
> 	if (msr_base == SVM_MSRPM_RANGE_1_BASE_MSR)
> 		return SVM_MSRPM_BIT_NR(1, msr);
> 	if (msr_base == SVM_MSRPM_RANGE_2_BASE_MSR)
> 		return SVM_MSRPM_BIT_NR(2, msr);
> 	return MSR_INVALID;

I initially had something like this, but I don't like the potential for typos,
e.g. to fat finger something like:

	if (msr_base == SVM_MSRPM_RANGE_2_BASE_MSR)
		return SVM_MSRPM_BIT_NR(1, msr);

Which is how I ended up with the (admittedly ugly) CASE macros.  Would you be ok
keeping that wrinkle?  E.g.

	#define SVM_MSR_BIT_NR_CASE(range_nr, msr)					\
	case SVM_MSRPM_RANGE_## range_nr ##_BASE_MSR:					\
		return range_nr * SVM_MSRPM_BYTES_PER_RANGE * BITS_PER_BYTE +		\
		       (msr - SVM_MSRPM_RANGE_## range_nr ##_BASE_MSR) * SVM_BITS_PER_MSR);

	static __always_inline int svm_msrpm_bit_nr(u32 msr)
	{
		switch (msr & ~(SVM_MSRS_PER_RANGE - 1)) {
		SVM_BUILD_MSR_BITMAP_CASE(0, msr)
		SVM_BUILD_MSR_BITMAP_CASE(1, msr)
		SVM_BUILD_MSR_BITMAP_CASE(2, msr)
		default:
			return -EINVAL;
		}
	}

Actually, better idea!  Hopefully.  With your masking trick, there's no need to
do subtraction to get the offset within a range, which means getting the bit/byte
number for an MSR can be done entirely programmatically.  And if we do that, then
the SVM_MSRPM_RANGE_xxx_BASE_MSR defines can go away, and the (very trivial)
copy+paste that I dislike also goes away.

Completely untested, but how about this?

	#define SVM_MSRPM_OFFSET_MASK (SVM_MSRS_PER_RANGE - 1)

	static __always_inline int svm_msrpm_bit_nr(u32 msr)
	{
		int range_nr;

		switch (msr & ~SVM_MSRPM_OFFSET_MASK) {
		case 0:
			range_nr = 0;
			break;
		case 0xc0000000:
			range_nr = 1;
			break;
		case 0xc0010000:
			range_nr = 2;
			break;
		default:
			return -EINVAL;
		}

		return range_nr * SVM_MSRPM_BYTES_PER_RANGE * BITS_PER_BYTE +
		       (msr & SVM_MSRPM_OFFSET_MASK) * SVM_BITS_PER_MSR)
	}

	static inline svm_msrpm_byte_nr(u32 msr)
	{
		return svm_msrpm_bit_nr(msr) / BITS_PER_BYTE;
	}

The open coded literals aren't pretty, but VMX does the same thing, precisely
because I didn't want any code besides the innermost helper dealing with the
msr => offset math.

> }
> 
> and you can throw away most of the other macros.  For example:
> 
> > +#define SVM_BUILD_MSR_BITMAP_CASE(bitmap, range_nr, msr, bitop, bit_rw)		\
> > +	case SVM_MSRPM_FIRST_MSR(range_nr) ... SVM_MSRPM_LAST_MSR(range_nr):	\
> > +		return bitop##_bit(SVM_MSRPM_BIT_NR(range_nr, msr) + bit_rw, bitmap);
> 
> ... becomes a lot more lowercase:
> 
> static inline rtype svm_##action##_msr_bitmap_##access(
> 	unsigned long *bitmap, u32 msr)
> {
> 	u32 bit = svm_msr_bit(msr);
> 	if (bit == MSR_INVALID)
> 		return true;
> 	return bitop##_bit(bit + bit_rw, bitmap);

Yeah, much cleaner.

> }
> 
> 
> In patch 25, also, you just get
> 
> static u32 svm_msrpm_offset(u32 msr)
> {
> 	u32 bit = svm_msr_bit(msr);
> 	if (bit == MSR_INVALID)
> 		return MSR_INVALID;
> 	return bit / BITS_PER_BYTE;
> }
> 
> And you change everything to -EINVAL in patch 26 to kill MSR_INVALID.
> 
> Another nit...
> 
> > +#define BUILD_SVM_MSR_BITMAP_HELPERS(ret_type, action, bitop)			\
> > +	__BUILD_SVM_MSR_BITMAP_HELPER(ret_type, action, bitop, read,  0)	\
> > +	__BUILD_SVM_MSR_BITMAP_HELPER(ret_type, action, bitop, write, 1)
> > +
> > +BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
> > +BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
> > +BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
> Yes it's a bit duplication, but no need for the nesting, just do:

I don't have a super strong preference, but I do want to be consistent between
VMX and SVM, and VMX has the nesting (unsurprisingly, also written by me).  And
for that, the nested macros add a bit more value due to reads vs writes being in
entirely different areas of the bitmap.

#define BUILD_VMX_MSR_BITMAP_HELPERS(ret_type, action, bitop)		       \
	__BUILD_VMX_MSR_BITMAP_HELPER(ret_type, action, bitop, read,  0x0)     \
	__BUILD_VMX_MSR_BITMAP_HELPER(ret_type, action, bitop, write, 0x800)

BUILD_VMX_MSR_BITMAP_HELPERS(bool, test, test)
BUILD_VMX_MSR_BITMAP_HELPERS(void, clear, __clear)
BUILD_VMX_MSR_BITMAP_HELPERS(void, set, __set)

That could be mitigated to some extent by adding a #define to communicate the
offset, but IMO the nested macros are less ugly than that.

> BUILD_SVM_MSR_BITMAP_HELPERS(bool, test,  test,    read,  0)
> BUILD_SVM_MSR_BITMAP_HELPERS(bool, test,  test,    write, 1)
> BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear, read,  0)
> BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear, write, 1)
> BUILD_SVM_MSR_BITMAP_HELPERS(void, set,   __set,   read,  0)
> BUILD_SVM_MSR_BITMAP_HELPERS(void, set,   __set,   write, 1)
> 
> Otherwise, really nice.
> 
> Paolo
> 

