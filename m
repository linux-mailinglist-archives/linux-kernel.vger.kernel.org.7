Return-Path: <linux-kernel+bounces-869238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B9BC07607
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21CB94E3400
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9F8337694;
	Fri, 24 Oct 2025 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lzJoDO81"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396513054E8
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324350; cv=none; b=I0bHE34kq345sNGDVOhXBHlBFxM9BsbOsz3OxaxhIZ93kD/TqWmNrCneEzz7HemQYR9d53ZUxeTUp++lCPslGA+A1eg/rkm1OEzRyWqqoW5do+h7DgSE5dKSGpS5jEWG6B7wsrP9BMjmTPWIY4IVBFWJV3IkP2XkYJOt7fBkVCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324350; c=relaxed/simple;
	bh=l8fHPPkC4JRlA1R9eBG/HBWLmHeZAxOGw9dz4ZOhCvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcbJ6AHlmGKOF1vjtPVvNmefJIf+0VfuTjYopWWU/29SLoBT947rjleQkThAj6WPkHRXyMHe10+rifIwK+t6lRc0C1b0xHEinPMa+HSNXUTu9gdTCMjizz/25DoPwA/zZOYukjpdL7v64lSQxru1FtsPwn5JPXcYk4Y8M2OAXac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lzJoDO81; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e6ec0d1683so7031cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761324348; x=1761929148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tp94m+0iT2dB2E8reOhXroB6plr+CCHWM/+pbCZUMQM=;
        b=lzJoDO81WHJOg9h67mGvL06kNlZ4CSMFA88zLpAkZ7wWpR4UB2Um3IBz0+KpUotgaR
         qYiqh50/oLerda2L8fg8Y5NoHeJlbvwe/WKoKZBy62InUQCWjKz+1P2ANipd8iqRqvvu
         kOiqMGBvBg/SWno4KzMxRLE+HZyh+WmwVzQS7jc/MDx0HLbS7Tge5y/6ZZ8y0C2FxdoP
         9c46Sg2hdpajGsJQzAyZC4HnbHJjF5ILMvg1RxMNuyum1x5BhXrKLWwD6GvqjyEB5VMy
         T5MsMMYQjUtTNGuVOLWPhm9mRb83F3PhGxtre+EEYfgFBKh3Fej8DwPZSkGKtFBd0TOD
         GbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761324348; x=1761929148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tp94m+0iT2dB2E8reOhXroB6plr+CCHWM/+pbCZUMQM=;
        b=uEFXXsX0yz/ptpdYgF7/S6FuzzfL4W1bZDXnC6vZc+KJPTTYAsjsUjhJG7HvnWyGd9
         pChZ9xojHGMa/Mt5bQL9E71M3Qvw3gkuttOOiWo+RtWibjdC2GDXl5dHp2erhBqUX28/
         AZufIDvSxGjAsjQ1gGBy8Cey2mAf5AThCFwr7j0KIWozhuiQIPQ/sPor3WA3vEwqgK7k
         CXfr1gcRJOi8doOaXH4vVbL06x+HDL76oottS2AB9P5GwhDuKtwKVHtQ6iD3REpvAsIn
         uAAdedoQfOcKC1nHxAzH3zq/gbFPFaXzKzyADk+PDBzABWqQDeD/UxKIlq1dqPpNAvsc
         AIbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzlZ2FmDATHwMJvU4g9X/4qIs8Kz00PR0i3G6E4GZr+8xS2/eAd6EuJJwK2qgQ2J2+Tc7mBdgtKavGXcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//jKFV434/eP934+EA2N5qEKCRUrJ+5g2i3zRFEv3csmBniBZ
	mMEXQww0IeLhul+2TxD9O4Fj6N3DA/HR3n2JudKeHwb+qjFiWgyZkH2qLHp4ClFoW4q5I59rvGz
	Oq41mHwfNUhE978RTyyunctpwMfVdi9RTGq6X2Hrb
X-Gm-Gg: ASbGnctKmCel9qNoPmJlxz5hjTTyCcSOhW+Bf4jh5QsNcms2FIolbKkrcpprEa6OfYC
	/NIsf98ls1CuuXyCTVzCZd4Wzlyr0/r386nfPmGwg75urnVNuqp3sZbk2YjhpfptlFTZyF/gleD
	LAUGzOZJr3buSr7hPelmwl5gCeMq7yY2eBVUp7dGPYSWSJRJSfdOll0HKi3Zmp2OlaZzozXUdVd
	Sgt6J4lJwFyXAVJVMoefSDL2kqOxETVOHzLW+/wnBJqPfT2wviKkkpAM0axPDhJWEVs60mBvkm/
	fHko67yG0yWwPKCKxQ==
X-Google-Smtp-Source: AGHT+IHj9jJsKJWJhcz77Qoyqqh2QgHDB/OktV5aMTXEGJP/cspOjR+15VD0ZBgbsEKzvzwaFG7Jo2NnWVJOzgywjrg=
X-Received: by 2002:a05:622a:cb:b0:4e6:e07f:dc98 with SMTP id
 d75a77b69052e-4eb93730b28mr5610111cf.9.1761324347845; Fri, 24 Oct 2025
 09:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com> <20250925172851.606193-14-sagis@google.com>
 <68efcb7ee33e5_cab031002e@iweiny-mobl.notmuch> <CAAhR5DGcz-2=a6Q2zZS_eP2ZjNNPs65jNG+K50tdVAQfC6AbbA@mail.gmail.com>
 <aPui50JMEcuIl7-8@google.com>
In-Reply-To: <aPui50JMEcuIl7-8@google.com>
From: Sagi Shahar <sagis@google.com>
Date: Fri, 24 Oct 2025 11:45:36 -0500
X-Gm-Features: AS18NWBLOljVToQUAT57VvW_ehimBaX2k2m0jrXQCZpfD9mmAYUsGAZUGeqHF5Q
Message-ID: <CAAhR5DFJKTTY3tN7AU=BXDRJAGjuortmK0ruQWU8RB_Z6jVugQ@mail.gmail.com>
Subject: Re: [PATCH v11 13/21] KVM: selftests: Add helpers to init TDX memory
 and finalize VM
To: Sean Christopherson <seanjc@google.com>
Cc: Ira Weiny <ira.weiny@intel.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:02=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Thu, Oct 23, 2025, Sagi Shahar wrote:
> > On Wed, Oct 15, 2025 at 11:25=E2=80=AFAM Ira Weiny <ira.weiny@intel.com=
> wrote:
> > >
> > > Sagi Shahar wrote:
> > > > From: Ackerley Tng <ackerleytng@google.com>
> > > >
> > >
> > > [snip]
> > >
> > > > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/t=
ools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > > > index 2551b3eac8f8..53cfadeff8de 100644
> > > > --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > > > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > > > @@ -270,3 +270,61 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_=
t attributes)
> > > >
> > > >       free(init_vm);
> > > >  }
> > > > +
> > >
> > > [snip]
> > >
> > > > +
> > > > +void vm_tdx_finalize(struct kvm_vm *vm)
> > >
> > > Why is this not a new kvm_arch_vm_finalize_vcpu() call?
> >
> > What do you mean?
>
> Ira is pointing out that upstream now has kvm_arch_vm_finalize_vcpus(), s=
o you
> can (and I agree, should) implement that for x86.c, and do vm_tdx_finaliz=
e() from
> there (based on the VM shape) instead of requiring the caller to manually=
 finalize
> the TD.
>
> Unlike SEV, where userspace can manipulate guest state prior to LAUNCH, T=
DX guest
> state is unreachable from time zero, i.e. there is unlikely to be many (a=
ny?) use
> cases where a selftest wants to do something between creating vCPUs and f=
inalizing
> the TD.

There are actually a few use cases for calling vm_tdx_finalize
seperately from the create phase. One such case is when a user wants
to add additional memslots for testing shared memory conversions.
Another one is installing interrupt handlers. But these are probably
rare enough that they can call __vm_create() and vm_vcpu_add()
manually instead of using the wrapper

