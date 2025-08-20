Return-Path: <linux-kernel+bounces-778592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D6EB2E7B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BEBA285D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7487A33471E;
	Wed, 20 Aug 2025 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTLKgk+u"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1A4334382
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755726576; cv=none; b=qbssGQABTM7Y8hG849NskfJTlP2Dqm8uMUSia8V72kkgt4mbNfP1EgmymyQSkqk4GOtgMoSwbCIIe5ML3ZfAAsKr3Itlal+jSpzb6tQIUPB+BY4C/RF7m4B2Qgt8LhnWZwDiz6w/6c9XZc1S+k1cJZkZXmV3LO3iqcIkwflEdAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755726576; c=relaxed/simple;
	bh=9ejDQzzV79T1AiCbDCaryEpgNGQ78sTb+lEBCYg2KTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSsBNGorxNnCsLX8/RxKGvhf/aiYH5b65yDUEqO3/RLVKGY+4imAZD+zR2iZ8sXweAEkVeVzsAeUsQUHM9rJejLJkW36QWAbhLgOLvCVmUYlOzBEuDeHrtsbj6nbrsjdr/rjYz1zB9LYxvGM0N/CUvv9gJqMNFV98P+3KH918vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTLKgk+u; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b0bd88ab8fso81681cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755726574; x=1756331374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4BYW+YMamDQ0q1hw9SCc1ngncMsoC0jM3yESHRisTs=;
        b=dTLKgk+uBBrbQRi72/sP9GE23Ve5ouyjSYnQ+dPCiZAFGIGcNyOfO4Yt6n9TvuNv/n
         Cr6aWdwYHzbRJ5xqX8JApviDWSR0fNFOq85OJCx8LFpRdwxyGvn7Vlwn3pIePFFhV3ot
         R1QU/yblRZi4bW2F/kGAVCef6GaKSf6TNwAUp7fch9QM0vclASxrcOm0Kfi/XgYb2JVC
         XKbmSUHuXq+oXShUgUTumEmV2fVXs0uHWLKH/aYqvQx/QsOLY1LOkCZyHbYAZZUW9q0R
         QbqGrm2Ap5XBS+7/3UBc+jJ57QuhZEgdVIpmNYii7zLQ4cQBfpMhQIFLzwGIYHZRbmVe
         +DZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755726574; x=1756331374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4BYW+YMamDQ0q1hw9SCc1ngncMsoC0jM3yESHRisTs=;
        b=QNBzq94MLOWUD1aVpOdSoDCikUXmEWjJtVNz+BJG3/uRxlzyRP9rq6F5CD1YfAdYdh
         CZZtgT3oT9e6SRYEVCDMuD7hjpEl7EA3ye4wuw1iyZj9EjIeKAxM6EqM8NolwkG7Zz0N
         NLuU9knQgNkHdKyc9S8FtzsWoneGLHzcCAcXzbwphvMe+sMx8bM8FP2bpehh4/uk2M6r
         Orl1HPljBhI7txKbEjwKEAzghx9AEuq2ZNPwHKjVM8PVR/+EH/oWSxRWMpO+ByWQ8DyL
         7S+zmbCv0gTIHcCM3dAJDb+vrZ2e+JxH8mBArxorY8Aan5uhNAQDfHGjw6PdRggO/GQG
         8SJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe6mPjdTeXDUDGKgdTCrlsfQ1BWfRYlqGxM+HrrahmzG4KZCG6MzI3x18dM+sxyHG99ss5t5srQnzCzLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygHpB+3IlA9d1GYJwpzH3Orvvl3UHwd/Yflo1J3TiJz13VMdHs
	2DMF8clebZ1f9v9UEID3gusZAmLHtQ+scR2/cQoZn3ba8+BYT1016qfmC0qcX9vHVBt8Hl0vB97
	huAizQYgjachAYJSC7sjmonLhrJwI+J9BHNcLoiHd
X-Gm-Gg: ASbGncsi5GpcZu2AWWdJ5faiKaPKAgZk6h9NR0p+67UPdjs4LmfgM3yiJ8mTpsIrjVE
	49yy2rUOiK4/grOn73M76Zs0RbfZYuzYvD4rg3wXOLouSAQytsAh+TQAtnKsN3UiBTu1IASzGLM
	13XYgkCVi/9eXMCOZOMr38MIIeSjk+uDHjkPBcrVenorNv4DKrcY+tsT8w1n5O7efDGNVPXy+ex
	kBjWXuAmMDXswAp1wkRi8IUVARv1y6vBWOOasKr03UvRDw8R3M26yg/
X-Google-Smtp-Source: AGHT+IG2BOE0oeHdc4t4ECTctmW2QFQI3q8AQkFko/cxIrgHnmuMUZ6t1eZCL+rR3A+ORt6KxQGEsMHFsBpNkF3i3r8=
X-Received: by 2002:a05:622a:1aaa:b0:4b2:939c:9c1a with SMTP id
 d75a77b69052e-4b29fa207ecmr301941cf.13.1755726573716; Wed, 20 Aug 2025
 14:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-8-sagis@google.com>
 <55e8d6da-50e3-4916-a778-71da628cbc08@intel.com> <CAAhR5DHc_1VtVTD=g=q7qvnrK0z57jwD38AoDSDK1buEb5WUDg@mail.gmail.com>
In-Reply-To: <CAAhR5DHc_1VtVTD=g=q7qvnrK0z57jwD38AoDSDK1buEb5WUDg@mail.gmail.com>
From: Sagi Shahar <sagis@google.com>
Date: Wed, 20 Aug 2025 16:49:22 -0500
X-Gm-Features: Ac12FXwYN1C90LI3qHlNYuKcfDKloRvqVELySll9JL4970wNlJjS2gBdc8BTSas
Message-ID: <CAAhR5DHh2vw_UkOexGSmGMnzXww-n5exgUHp3bb5debjY9suww@mail.gmail.com>
Subject: Re: [PATCH v8 07/30] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to
 validate TDs' attribute configuration
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 4:18=E2=80=AFPM Sagi Shahar <sagis@google.com> wrot=
e:
>
> On Wed, Aug 13, 2025 at 8:34=E2=80=AFAM Chenyi Qiang <chenyi.qiang@intel.=
com> wrote:
> >
> >
> >
> > On 8/8/2025 4:16 AM, Sagi Shahar wrote:
> > > From: Ackerley Tng <ackerleytng@google.com>
> > >
> > > This also exercises the KVM_TDX_CAPABILITIES ioctl.
> > >
> > > Suggested-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > > Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > > Signed-off-by: Sagi Shahar <sagis@google.com>
> > > ---
> > >  .../selftests/kvm/lib/x86/tdx/tdx_util.c        | 17 +++++++++++++++=
++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/too=
ls/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > > index 392d6272d17e..bb074af4a476 100644
> > > --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > > @@ -140,6 +140,21 @@ static void tdx_apply_cpuid_restrictions(struct =
kvm_cpuid2 *cpuid_data)
> > >       }
> > >  }
> > >
> > > +static void tdx_check_attributes(struct kvm_vm *vm, uint64_t attribu=
tes)
> > > +{
> > > +     struct kvm_tdx_capabilities *tdx_cap;
> > > +
> > > +     tdx_cap =3D tdx_read_capabilities(vm);
> > > +
> > > +     /* TDX spec: any bits 0 in supported_attrs must be 0 in attribu=
tes */
> > > +     TEST_ASSERT_EQ(attributes & ~tdx_cap->supported_attrs, 0);
> > > +
> > > +     /* TDX spec: any bits 1 in attributes must be 1 in supported_at=
trs */
> > > +     TEST_ASSERT_EQ(attributes & tdx_cap->supported_attrs, attribute=
s);
> > > +
> > > +     free(tdx_cap);
> > > +}
> > > +
> > >  #define KVM_MAX_CPUID_ENTRIES 256
> > >
> > >  #define CPUID_EXT_VMX                        BIT(5)
> > > @@ -256,6 +271,8 @@ static void tdx_td_init(struct kvm_vm *vm, uint64=
_t attributes)
> > >       memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
> > >       free(cpuid);
> > >
> > > +     tdx_check_attributes(vm, attributes);
> > > +
> > >       init_vm->attributes =3D attributes;
> > >
> > >       tdx_apply_cpuid_restrictions(&init_vm->cpuid);
> >
> > Do we need to set the init_vm->xfam based on cpuid.0xd and validate it =
with tdx_cap->supported_xfam?
> >
> I don't think it's necessary. And according to the TDX spec (TDX
> Module Base Spec - 11.8.3. Extended Features Execution Control) the
> mapping from CPUID to XFAM is not trivial. Checking attributes makes
> sense since some tests use non-default attributes but right now we
> don't have any test which uses XFAM features. We can add XFAM support
> in the future if it's needed and do the check then.

I just saw the comment on "KVM: selftests: TDX: Add basic TDX CPUID
test" which suggests adding xfam support. I can add a check for xfam
when I rework that patch but I still think that the values for xfam
should come from the test and validated here instead of being
calculated based on cpuid.

