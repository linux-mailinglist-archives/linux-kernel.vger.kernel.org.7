Return-Path: <linux-kernel+bounces-883310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF32AC2D0A2
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DAB189646A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B3731579B;
	Mon,  3 Nov 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqbUjvKg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E205314D34
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186413; cv=none; b=fJp050uuWka6ys5nwBy2V6tCoeZw5tZgBGtsO6smlVeVvuYVoxhofYmYinS6k9xXkYwsFTg9nKI7Q3UFDgxDYChBD787D74EJ9ko5tLsChtcUiPCBDG8k69TfNzi1V0CvoCCpiW+wG1KWLDGmiCWoYdXBxKJ1U2+fH5yCwF1f3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186413; c=relaxed/simple;
	bh=HZAR4YcmpTnmikIRDHvdPrG91DIqK5aLBrbuwckCKE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqofiPgMk6kTMDTSGqdiP4VVcvjVzQUZsWyFayZHtTV0oeczu9hvA4zu4mXhSE7Xsj2AahN2RtyF306SCC/8I3RYvlwLSiZ48NGRJJ/v77hV5HCbZkoJDTBT//tmwmGotIgn1KgDq4tMseepIVELv6YAKznAcxIuelRHML22/7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqbUjvKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84331C4CEFD;
	Mon,  3 Nov 2025 16:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762186413;
	bh=HZAR4YcmpTnmikIRDHvdPrG91DIqK5aLBrbuwckCKE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OqbUjvKgmv05HeI3sQ2BotDazzqLsFaAS47d9QVnq7IjOtGZ5UkmQ6lPg5Qkux/I4
	 USdstFtM3FkQjydcKoabb6HmSLARpUwXhDw+cAyMeIf48pAEhxDHfoWFsRboFgWIxb
	 JTRmp+nq+Z5651uR5wGT0oJ4OZvwe+m+obsRyV3U7oZ+yjZh1HabyOun7O3bnxXy6s
	 tERX5Z3GWm23BTWxhqLLUYb9PVH4LPl7RSBrMjOECBh3w7yBCnN/QtUICm2fyZOvpH
	 gqfQtbNU/QySxWIfSlC9acfnID8G++xt1FgbQPbdfAIvr44Eh6Y497+dZfQEOMU2nE
	 Z1XyV42vE7AkA==
Date: Mon, 3 Nov 2025 13:13:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Fuad Tabba <tabba@google.com>
Cc: linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/1] tools headers UAPI: Sync linux/kvm.h with the kernel
 sources
Message-ID: <aQjUqXb-iIVIg7Fc@x1>
References: <aQi-8IuAQ8CIPZuL@x1>
 <CA+EHjTwXWHUoH=-0z00gfWtSGKDymcBGgLdUyM0r0v65VR+86g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTwXWHUoH=-0z00gfWtSGKDymcBGgLdUyM0r0v65VR+86g@mail.gmail.com>

On Mon, Nov 03, 2025 at 03:57:55PM +0000, Fuad Tabba wrote:
> On Mon, 3 Nov 2025 at 14:40, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > tldr; Just FYI, I'm carrying this on the perf tools tree.
> >
> > Full explanation:
> >
> > There used to be no copies, with tools/ code using kernel headers
> > directly. From time to time tools/perf/ broke due to legitimate kernel
> > hacking. At some point Linus complained about such direct usage. Then we
> > adopted the current model.
> >
> > See further details at:
> >
> >  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README
> >
> > To pick the changes in:
> >
> >   fe2bf6234e947bf5 ("KVM: guest_memfd: Add INIT_SHARED flag, reject user page faults if not set")
> >   d2042d8f96ddefde ("KVM: Rework KVM_CAP_GUEST_MEMFD_MMAP into KVM_CAP_GUEST_MEMFD_FLAGS")
> >   3d3a04fad25a6621 ("KVM: Allow and advertise support for host mmap() on guest_memfd files")
> >
> > That just rebuilds perf, as these patches don't add any new KVM ioctl to
> > be harvested for the the 'perf trace' ioctl syscall argument
> > beautifiers.
> 
> nit: "the" is repeated. I've noticed this in earlier commits of yours
> to this file as well :)

eagle eagle eyes! Fixed.

Thanks,

- Arnaldo
 
> > This addresses this perf build warning:
> >
> >   Warning: Kernel ABI header differences:
> >     diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
> >
> >   Please see tools/include/uapi/README for further details.
> >
> > Cc: Sean Christopherson <seanjc@google.com>
> > Cc: Fuad Tabba <tabba@google.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> 
> Reviewed-by: Fuad Tabba <tabba@google.com>
> 
> Cheers,
> /fuad
> 
> >  tools/include/uapi/linux/kvm.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
> > index f0f0d49d25443552..52f6000ab020840e 100644
> > --- a/tools/include/uapi/linux/kvm.h
> > +++ b/tools/include/uapi/linux/kvm.h
> > @@ -962,6 +962,7 @@ struct kvm_enable_cap {
> >  #define KVM_CAP_ARM_EL2_E2H0 241
> >  #define KVM_CAP_RISCV_MP_STATE_RESET 242
> >  #define KVM_CAP_ARM_CACHEABLE_PFNMAP_SUPPORTED 243
> > +#define KVM_CAP_GUEST_MEMFD_FLAGS 244
> >
> >  struct kvm_irq_routing_irqchip {
> >         __u32 irqchip;
> > @@ -1598,6 +1599,8 @@ struct kvm_memory_attributes {
> >  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> >
> >  #define KVM_CREATE_GUEST_MEMFD _IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
> > +#define GUEST_MEMFD_FLAG_MMAP          (1ULL << 0)
> > +#define GUEST_MEMFD_FLAG_INIT_SHARED   (1ULL << 1)
> >
> >  struct kvm_create_guest_memfd {
> >         __u64 size;
> > --
> > 2.51.1
> >

