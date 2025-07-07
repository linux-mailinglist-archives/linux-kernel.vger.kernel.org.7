Return-Path: <linux-kernel+bounces-720638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D41FAFBE9D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C844A1E6C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 23:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7959C26FDBB;
	Mon,  7 Jul 2025 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CnDT9NnY"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCDF27713
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751931131; cv=none; b=EXwDWoQRIu+jCBz8ewIafn1eJBYngLpVbTjBNmhT1sGaxQDZClitjaW4K528c6svzlYfS8tBf7k/imag9WdQa651p5qtLq32ouwvU+ylwF3VOw4LnVdc+VdE2E4tO7YgjcXs5/L4Phh4MsjWU0s8nASy1QGmfXbJoV4LRhLZt0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751931131; c=relaxed/simple;
	bh=1ffb14bfAcbOruhUZZk4RbIL9SB3DbmZ8qKgrgg4Hec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3crJTT0iWLeGq318T/E1Dwatzenao/8azix3G1hqpYu4CPcMHLyFt7PmNJRiq1xsOBm37OmMu6x7nQqjzSbvl9wwabSCAeE3rA5KUNkcXoGw8rekGxPGXHbetz5Bq8GaGKdM77ylgZg3MHdtubsGuMCh+dkHguhP5GmJbUbEn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CnDT9NnY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235e389599fso98595ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 16:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751931130; x=1752535930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b25Saen0Ouv9TFO7AIEKB3BvyD7uu12IqNtwgf3v9N0=;
        b=CnDT9NnYxL/0+3mvjXmqEsI1eOoOhMfTykQC7ueiVbnoeEQsvUwmSL/yLQItI6DMlR
         y+L7q/Lk1qy5LKLNxhqV3Hos8wokW7bhH9Ka8C20wZ0cDRjn5Vpy6eFbfIa2QdTH5sL5
         q3iDg9Yp3NQuWYho5pZ8GA+rZV7H9v+CBvz1u/+QWfU1qAMk+zCTrXBBOSoS+fa21fIp
         565Wc1N94lkhxO8mZ2F0MY6qNfgt1t+7iQaGAUVEtphoRmfgm7+6158qGx3fjFbqDhpa
         O0GFs6cbhNKwEu2ix1P5G2pxdRigPB2tE0Xc/et/L7LXgFDrkTGoHM6g2rmSAEd7CJjS
         e6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751931130; x=1752535930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b25Saen0Ouv9TFO7AIEKB3BvyD7uu12IqNtwgf3v9N0=;
        b=Q8nGtxD9pY3ywR4WnyOYNQsz6IPazvdYgizicKhVJSN2Vs7NTkq5evx9ygfXsxzLOM
         f5C9lzIt8tzcoic8i7P6hE7ZjAHw8lkoPc5LWbhYg+g9WmAq76FNqh8p3RGvB4AtAPjB
         QgJf1u5/aW+u/atKyLxMisbjKC3l7Nec0bITkuDZPjT+fSGa60bkRa1HiqRqm70suVoM
         dY5qO1AvVUvc2q6EGNaGmDY5TEn17U2bgXaj9b6gpdHFs7QxNsnMgeXp4mLtoGWDKLXj
         E23Y6sh8xgIYFianWH+UP05scLTq3TCm62tDLV1B9l4M6Pe0w7IsqFfz7amN+zDqo8D4
         X3Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXRhgVmwowcJl4noY+6JJdSUfEOjA2XrqnycDOQU7ZvfW5YPho+ppmLP+1ih5SnFduo/nmJAn7TL9m+XwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy5eBJ0atsDQdcGgesyoa8tQytr9rPPjIwoQe/GZ8SsSL7P8zL
	qK1QjQDLsTbmx6W4cmp7/Obn1dPmGNT9QA0VSsr7GVshx+xzlgmQ9WnRnuZHf9f5ybQsZ0VGL7w
	2I1usuZltA7TsyD8x5HChH20az3UNxcitGYO6tT02
X-Gm-Gg: ASbGnctZ2UVH9VL3QxcV9gO73cVDc/Le4lUAUHLg8TCvCOQifK6Ra1ikY1yiE7KTEOy
	GGkEbveMFKVhtcdxhC9j5pL2wzKUVdkfhMGWsW8udQuGuKLet2wITXpnegVzd37FyUFlg/r8V6s
	tlO0kZRkEkhqJj6Zy5oNw94uwhfihL8RQNXwhiHZ+FjJxvEFw7fo5UigSX1/dgCm/jxRt+dtsib
	A==
X-Google-Smtp-Source: AGHT+IGqmRprZYTBLI8qv+P8RjDA1HbE3ENdRoMTXbFRRnjoRR+yK0qlEKy2k3qHP1SasQQQ8ZzgWChIrCrLnGg4qR8=
X-Received: by 2002:a17:903:2f81:b0:23c:5f63:b67 with SMTP id
 d9443c01a7336-23dd0f824a5mr1163805ad.4.1751931129206; Mon, 07 Jul 2025
 16:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703153712.155600-1-adrian.hunter@intel.com>
 <20250703153712.155600-3-adrian.hunter@intel.com> <CAGtprH8boLi3PjXqU=bXA8th0s7=XE4gtFL+6wmmGaRqWQvAMw@mail.gmail.com>
 <2e444491-f296-4fa4-9221-036f9b010c1d@intel.com>
In-Reply-To: <2e444491-f296-4fa4-9221-036f9b010c1d@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Mon, 7 Jul 2025 16:31:56 -0700
X-Gm-Features: Ac12FXwUanPwhUwd2qO24xrbiqz5Xe6HKml-XwovpsbcB_MYLVSiljzosapeYaw
Message-ID: <CAGtprH8SqMH6GiRp=kgkUHxiPhtYDcrN8=AiudeTsS+7q2WGbQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] x86/tdx: Skip clearing reclaimed pages unless
 X86_BUG_TDX_PW_MCE is present
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, pbonzini@redhat.com, seanjc@google.com, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org, H Peter Anvin <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, kai.huang@intel.com, 
	reinette.chatre@intel.com, xiaoyao.li@intel.com, 
	tony.lindgren@linux.intel.com, binbin.wu@linux.intel.com, 
	isaku.yamahata@intel.com, yan.y.zhao@intel.com, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 10:38=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 03/07/2025 20:06, Vishal Annapurve wrote:
> > On Thu, Jul 3, 2025 at 8:37=E2=80=AFAM Adrian Hunter <adrian.hunter@int=
el.com> wrote:
> >>
> >> Avoid clearing reclaimed TDX private pages unless the platform is affe=
cted
> >> by the X86_BUG_TDX_PW_MCE erratum. This significantly reduces VM shutd=
own
> >> time on unaffected systems.
> >>
> >> Background
> >>
> >> KVM currently clears reclaimed TDX private pages using MOVDIR64B, whic=
h:
> >>
> >>    - Clears the TD Owner bit (which identifies TDX private memory) and
> >>      integrity metadata without triggering integrity violations.
> >>    - Clears poison from cache lines without consuming it, avoiding MCE=
s on
> >>      access (refer TDX Module Base spec. 16.5. Handling Machine Check
> >>      Events during Guest TD Operation).
> >>
> >> The TDX module also uses MOVDIR64B to initialize private pages before =
use.
> >> If cache flushing is needed, it sets TDX_FEATURES.CLFLUSH_BEFORE_ALLOC=
.
> >> However, KVM currently flushes unconditionally, refer commit 94c477a75=
1c7b
> >> ("x86/virt/tdx: Add SEAMCALL wrappers to add TD private pages")
> >>
> >> In contrast, when private pages are reclaimed, the TDX Module handles
> >> flushing via the TDH.PHYMEM.CACHE.WB SEAMCALL.
> >>
> >> Problem
> >>
> >> Clearing all private pages during VM shutdown is costly. For guests
> >> with a large amount of memory it can take minutes.
> >>
> >> Solution
> >>
> >> TDX Module Base Architecture spec. documents that private pages reclai=
med
> >> from a TD should be initialized using MOVDIR64B, in order to avoid
> >> integrity violation or TD bit mismatch detection when later being read
> >> using a shared HKID, refer April 2025 spec. "Page Initialization" in
> >> section "8.6.2. Platforms not Using ACT: Required Cache Flush and
> >> Initialization by the Host VMM"
> >>
> >> That is an overstatement and will be clarified in coming versions of t=
he
> >> spec. In fact, as outlined in "Table 16.2: Non-ACT Platforms Checks on
> >> Memory" and "Table 16.3: Non-ACT Platforms Checks on Memory Reads in L=
i
> >> Mode" in the same spec, there is no issue accessing such reclaimed pag=
es
> >> using a shared key that does not have integrity enabled. Linux always =
uses
> >> KeyID 0 which never has integrity enabled. KeyID 0 is also the TME Key=
ID
> >> which disallows integrity, refer "TME Policy/Encryption Algorithm" bit
> >> description in "Intel Architecture Memory Encryption Technologies" spe=
c
> >> version 1.6 April 2025. So there is no need to clear pages to avoid
> >> integrity violations.
> >>
> >> There remains a risk of poison consumption. However, in the context of
> >> TDX, it is expected that there would be a machine check associated wit=
h the
> >> original poisoning. On some platforms that results in a panic. However
> >> platforms may support "SEAM_NR" Machine Check capability, in which cas=
e
> >> Linux machine check handler marks the page as poisoned, which prevents=
 it
> >> from being allocated anymore, refer commit 7911f145de5fe ("x86/mce:
> >> Implement recovery for errors in TDX/SEAM non-root mode")
> >>
> >> Improvement
> >>
> >> By skipping the clearing step on unaffected platforms, shutdown time
> >> can improve by up to 40%.
> >
> > This patch looks good to me.
> >
> > I would like to raise a related topic, is there any requirement for
> > zeroing pages on conversion from private to shared before
> > userspace/guest faults in the gpa ranges as shared?
>
> For TDX, clearing must still be done for platforms with the
> partial-write errata (SPR and EMR).
>

So I take it that vmm/guest_memfd can safely assume no responsibility
of clearing contents on conversion outside of the X86_BUG_TDX_PW_MCE
scenario, given that the spec doesn't dictate initial contents of
converted memory and no guest/host software should depend on the
initial values after conversion.

> >
> > If the answer is no for all CoCo architectures then guest_memfd can
> > simply just zero pages on allocation for all it's users and not worry
> > about zeroing later.
>
> In fact TDX does not need private pages to be zeroed on allocation
> because the TDX Module always does that.
>

guest_memfd allocated pages may get faulted in as shared first. To
keep things simple, guest_memfd can start with the "just zero on
allocation" policy which works for all current/future CoCo/non-CoCo
users of guest_memfd and we can later iterate with any arch-specific
optimizations as needed.

