Return-Path: <linux-kernel+bounces-863767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CF3BF90F4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 685344ECEFF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C43529E11D;
	Tue, 21 Oct 2025 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHsKOKQb"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF24350A28
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761086077; cv=none; b=eEOrpSzhXIrVAOVseuzlLe8g7mPxCbdbFxM7zy2s9TGYLDS7amU8z2QS5ce/9mrSM+irUpnmf2r527JqQdOg+smuMvWkDvi/Dckg6XMtxcCACCJF655arU6bscytNlzA9uotYjkDWcsSDSRiu7PIMdZ4SWxEjjNvMcUHah8D3R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761086077; c=relaxed/simple;
	bh=IeoT7WRzABBSz4YfCNDzlegECV0bAt318h7fRGN5RJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsfsBGafVDLgMLAcILwcYkG59Bv7irTifHmxiVEiNOD/N94zYPQlWz0BuuF22fBfMnUfh+L28ECo3aOKpWIi4dmRc2LGapVFmVddDcwv0vWoHRqaeRqfjLFX+nv9dGd9xHjoKHGHlO05IkZ/JH70LW4yQaENiMOcosPcql3hVwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHsKOKQb; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c44ea68f6so4254a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761086074; x=1761690874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKO4Kp6dH5qBsfNYhJL1nx41dfgyVlu5TgJiEzgyusc=;
        b=bHsKOKQbtxRS7PfqyFqsWbg3XtGVQcaD5nH0+kY0bFMJF8GoVMgfRA/bpAk8xx3nDi
         LCc/1Gbz3IkLueOji+gvuuZ9SU9OeAIaMLrm+AgkHjL8Yd1q2FvDuVYEQw5QmLZO/i/s
         rTyYSmcRhAGj1j5QM7AebUFZ8qVmb3CpZln7uQUHPN6yG5AmbwCsso41FUFOBEAbtFYR
         hI77sJZ3/f0YFU3nf8QrRC/qtuAMigQ9YCIr+XxTkKWuIJWJa3HZdgvrqkQ7CMNciLLR
         jn37l45ZjbDSQzKLW0qppKF1H4i37/VNvFnZi42oqB8FG6y/ad1ncsFk2WoXkwEBbLep
         ynzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761086074; x=1761690874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKO4Kp6dH5qBsfNYhJL1nx41dfgyVlu5TgJiEzgyusc=;
        b=vpumqk65dQLrf6anBEAaCkoGM8HpLEPzEjipJdbrEfxJ5Xk1efZEP2BiDRPdOEjZTT
         3QpI5eexczBeRbns59BASNAOdpIusjDlNxFIA97/6G8Lf2hKMi5vTLn/gQ/5/OwS0i0K
         6IG3FGgJCrXZa89Ulb4zO4N3h+0QsZbVaMAm/Nw4mgzxBZAjUsB0a+VcK2YWn7R0YYzv
         /E8yagPyGtlQaXFRh39Vgvk6Azf/DxcmVkefXjUv0RZfLDXwL5cG9oboxfWrCtAbplRc
         Y9Xs6GZ7ekHRhVB4kijYDHTvZ2T7GlBVJujCv24W8dABwdahRXDt2BYn/x4SFDBeiovh
         95TA==
X-Forwarded-Encrypted: i=1; AJvYcCXuviUetmq2GNmHdosvW1lal/YbRD6w9tPHrS5pVQfrb75bCn4BgzUXcMZvoXTkrc+wjYCdJJdIuQqLPnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZt7WPg/xSxRwppT0I4ybrSTMhQdY1dMVRCSL5AJOBTBpAS/T
	Ry6FZjfLj9QrZewWZO0QmEm70x/8zm5mBmoY1k+GHXpUavjNIcBZAZ6mHTTZfklNlB/qhHp8kJF
	rtGMfcH2q1Tp5d4pE0li+SUeYkiOWkl8AAxuCTCJ3
X-Gm-Gg: ASbGncshYWXnY//SQmpJ2x1ydhm0VA1m4FguhIlurLExF3M/xMFE+4YZeqZFrVxTJhJ
	Z7tOqaoisR+WQjIBhkBZQDfSIEl9eZL8pTjvO3XGlxA8NmgzZvAMqdtFNkhB3Wp3jnCuXr9ubw8
	meDksw4IGpoSzmbKi67uIVbzkKv96oqA24iQhAEPNdzaHza4i638GjPV0smVILQEYHdOW1FFNSe
	S03KWylC9uwzB9uNZXbg7HGHqWAoEViWXbUKggL4Vb0EfE+u3V2KFWKk0dvbp4RCqvgYpQ=
X-Google-Smtp-Source: AGHT+IHemPTjIsdR1YNb/+xlTiLW1G5LRjaPzAhpWFbk4sYlRCe9oYxSANNytekk/pnnXGKW/F8DhZvLGLEWjJAFktw=
X-Received: by 2002:a05:6402:326:b0:63c:1167:3a96 with SMTP id
 4fb4d7f45d1cf-63e1d9d8d81mr17578a12.5.1761086074095; Tue, 21 Oct 2025
 15:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917215031.2567566-1-jmattson@google.com> <20250917215031.2567566-4-jmattson@google.com>
 <l7txoioo3gntu3lyl542jg3n3wvkqruf2qh33xy7lmr5mjgfq5@iw4wsfdurlc7>
In-Reply-To: <l7txoioo3gntu3lyl542jg3n3wvkqruf2qh33xy7lmr5mjgfq5@iw4wsfdurlc7>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 21 Oct 2025 15:34:22 -0700
X-Gm-Features: AS18NWD_K5CQ6npFasemkAoeOhQEDgS2K8RB8qQWd7NRuStJGw86eRedF-qkt_U
Message-ID: <CALMp9eSPgy7RdT9TwKkRD5oh6-74XfCCP_UZ1mJWj6Nb9P4P7w@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: selftests: Add VM_MODE_PXXV57_4K VM mode
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Eric Auger <eric.auger@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 2:23=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Wed, Sep 17, 2025 at 02:48:39PM -0700, Jim Mattson wrote:
> > Add a new VM mode, VM_MODE_PXXV57_4K, to support tests that require
> > 5-level paging on x86. This mode sets up a 57-bit virtual address
> > space and sets CR4.LA57 in the guest.
> >
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> >  .../testing/selftests/kvm/include/kvm_util.h  |  1 +
> >  tools/testing/selftests/kvm/lib/kvm_util.c    | 21 +++++++++++++++++
> >  .../testing/selftests/kvm/lib/x86/processor.c | 23 ++++++++++++-------
> >  tools/testing/selftests/kvm/lib/x86/vmx.c     |  7 +++---
> >  4 files changed, 41 insertions(+), 11 deletions(-)
> >
> > ...
> > diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/=
selftests/kvm/lib/x86/vmx.c
> > index d4d1208dd023..1b6d4a007798 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/vmx.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
> > @@ -401,11 +401,12 @@ void __nested_pg_map(struct vmx_pages *vmx, struc=
t kvm_vm *vm,
> >       struct eptPageTableEntry *pt =3D vmx->eptp_hva, *pte;
> >       uint16_t index;
> >
> > -     TEST_ASSERT(vm->mode =3D=3D VM_MODE_PXXV48_4K, "Attempt to use "
> > -                 "unknown or unsupported guest mode, mode: 0x%x", vm->=
mode);
> > +     TEST_ASSERT(vm->mode =3D=3D VM_MODE_PXXV48_4K ||
> > +                 vm->mode =3D=3D VM_MODE_PXXV57_4K,
> > +                 "Unknown or unsupported guest mode: 0x%x", vm->mode);
> >
> >       TEST_ASSERT((nested_paddr >> 48) =3D=3D 0,
> > -                 "Nested physical address 0x%lx requires 5-level pagin=
g",
> > +                 "Nested physical address 0x%lx is > 48-bits and requi=
res 5-level EPT",
>
> Shouldn't this assertion be updated now? We technically support 5-level
> EPT so it should only fire if the mode is VM_MODE_PXXV48_4K. Maybe we
> should use vm->va_bits?

I did update the assertion! :)

init_vmcs_control_fields() hardcodes a page-walk-length of 4 in the
EPTP, and the loop in __nested_pg_map() counts down from
PG_LEVEL_512G. There is no support for 5-level EPT here.

>
> >                   nested_paddr);
> >       TEST_ASSERT((nested_paddr % page_size) =3D=3D 0,
> >                   "Nested physical address not on page boundary,\n"
> > --
> > 2.51.0.470.ga7dc726c21-goog
> >
>

