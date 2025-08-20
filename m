Return-Path: <linux-kernel+bounces-778562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE524B2E75D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BEE61CC3E13
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3185A2D1926;
	Wed, 20 Aug 2025 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w5uFRzjV"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D475026E71E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724728; cv=none; b=nl0Ud4ZLzxFg/y7GiEl1vuBajx14TWMPjDLi/gfxcWXqjR535GxMCcNzjKqL+HOYIn8ebQf22JE0P+kAutPv3Pe3mLVqnDVBGLjSFMXQ31pqdXv+o/fKmQ/SW/M3uk8keDEHpdFqu9oYPrnJYtoigXCmXCZQVi5Hl5HVPMLYC18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724728; c=relaxed/simple;
	bh=LjWgtUe2ffDBIWe5AFEdQGtloc8BFsTdPCWfRERMshk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqSZqo/LpgVl0FDsd7vH476PG2b8wR6U692e3cHBAJ9F+qTsMeF6eGV1kdTnbtIi8CyxAyTgJJrOJKMGqJgJj2mPIA5i8pNqvr4qHO/r8c7FTRk4BZoAC84nGXLHEO9RztcwqBgEwvdRUwuO86HHHmLljTFRzZWEggeKqFJI0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w5uFRzjV; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b29b715106so49101cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755724726; x=1756329526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YanTK0e4sjbxPtv/E87AJagkyaCOqYnz6w0QIlh+WUM=;
        b=w5uFRzjVLHGoWA28qun18g8F+qm8/UmNNMO0jRdnF3Rpf3dfqsha8zxn1xxBsI3NBI
         HWzFT8vVEFFmqPy184XOZeqDWaDCBTCq9/sDgXgi4i6low7lnxw5E62gPiRiD2lxt0Hf
         iIfMd8sWPn+dfe1PFP/EPZQoQEeSWQ4t4HMwb49atVeuZFU9zoJIAL8h4rS9izg+Q6tj
         ik7BK0oT1fz6ZkxZGZfOxrouXlj+Z70dSuzY7t+cXyUxqJ1DzQqvkKQ9ZfmRNXV6+2iN
         rGGwP4C4MhKCVilbOmfCUtuyb1N+uugtpo5NTV3knsJrh+OpP6H2XI49vU+ouio3nJjN
         UBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755724726; x=1756329526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YanTK0e4sjbxPtv/E87AJagkyaCOqYnz6w0QIlh+WUM=;
        b=i7v/xvvhLu3xxhPKGikq2bvIprhAFCq24CqyjDbepiRAxCUk08KGCn4Do7Io5rqBp5
         dxGVsRhU9aprofWGHZWGWIYR73qcevnp1qrP6a5txZYGenRW7CyrwSbCm6nsBLbb8TJt
         juGNNb6yJkhbyKYFUXGF+23dcbEo6Y/ZLmD7SuGizLR8bUh1gckU4vI2hOBkTANEqv0w
         gqLOd+DoVPy91w3XV5a+Zkx7JP1I5NFTJjYDeTZgdfatsAFcNded0F5lu75E/oaOySjP
         u9tbg8TjVz3nKWKKUJhQ3hcAZeIeg99WMv2ARp9Rv6n6tuBu+HXUs0p8s7IXgzEOSZE8
         G/iw==
X-Forwarded-Encrypted: i=1; AJvYcCWt5YwSgESklTdwPS4OvwLDiJjwbGV1KsVsIebzNL5V+YmroaE2KVPb248j1Mf1C3HBE7CaT3mH8dzUJMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvldwb/77dU6m0m99WLxGCVkMnYUtF0A7MyuaIM6le+xkM4Mz3
	7YoaWk8KKDDajvw/Fhf0cWrajkj6x8xqt3nH92su4OOD5Mtw6gP7Be+agIlWyGLMo6BsuwH1WWx
	tj82FakeDyzZM7pTwi/hwUgmDNjkNL5sGisFuNBiX
X-Gm-Gg: ASbGncu1E7uKPbFnIlFBzLvzRJwZ5YaykyA+bjgrmxiJzsVKsT+ie4tkNyb16Zpsytp
	huIDS868qpanxWShb7zZTWO7WPuMvHGhOANRViT9LLOItE4cEA+vmjXHK9UOQQQ6wNqIK26of4l
	C1TViQaV2TLobZTANw4G93+C154mv7bJit5Ip0tb8V94s80KvL3fXyWLP8kiu4ga1wYgbPDBHIn
	O2bdSeCgpLS/EPBTtcJgXpIbVD39Y/RPu/31sODPvg8mcjGtyjfsXVP
X-Google-Smtp-Source: AGHT+IHQRQFKbAOxo3PCN2gG1G+ONSaIYJEXSt8UDmWnpQyb4QJhOGxYZUIFKUu3mwSBMEBJBwB01GXcO6yRlid9inA=
X-Received: by 2002:ac8:7d0f:0:b0:4ae:d28f:b259 with SMTP id
 d75a77b69052e-4b29f9a3674mr171551cf.1.1755724725381; Wed, 20 Aug 2025
 14:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-8-sagis@google.com>
 <55e8d6da-50e3-4916-a778-71da628cbc08@intel.com>
In-Reply-To: <55e8d6da-50e3-4916-a778-71da628cbc08@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Wed, 20 Aug 2025 16:18:34 -0500
X-Gm-Features: Ac12FXy_O78l2qvX7QDGviCsQ0A4AbxaWcPp4bMvbe2OHW1_jf70ZZip1EYTtc4
Message-ID: <CAAhR5DHc_1VtVTD=g=q7qvnrK0z57jwD38AoDSDK1buEb5WUDg@mail.gmail.com>
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

On Wed, Aug 13, 2025 at 8:34=E2=80=AFAM Chenyi Qiang <chenyi.qiang@intel.co=
m> wrote:
>
>
>
> On 8/8/2025 4:16 AM, Sagi Shahar wrote:
> > From: Ackerley Tng <ackerleytng@google.com>
> >
> > This also exercises the KVM_TDX_CAPABILITIES ioctl.
> >
> > Suggested-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >  .../selftests/kvm/lib/x86/tdx/tdx_util.c        | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools=
/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > index 392d6272d17e..bb074af4a476 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > @@ -140,6 +140,21 @@ static void tdx_apply_cpuid_restrictions(struct kv=
m_cpuid2 *cpuid_data)
> >       }
> >  }
> >
> > +static void tdx_check_attributes(struct kvm_vm *vm, uint64_t attribute=
s)
> > +{
> > +     struct kvm_tdx_capabilities *tdx_cap;
> > +
> > +     tdx_cap =3D tdx_read_capabilities(vm);
> > +
> > +     /* TDX spec: any bits 0 in supported_attrs must be 0 in attribute=
s */
> > +     TEST_ASSERT_EQ(attributes & ~tdx_cap->supported_attrs, 0);
> > +
> > +     /* TDX spec: any bits 1 in attributes must be 1 in supported_attr=
s */
> > +     TEST_ASSERT_EQ(attributes & tdx_cap->supported_attrs, attributes)=
;
> > +
> > +     free(tdx_cap);
> > +}
> > +
> >  #define KVM_MAX_CPUID_ENTRIES 256
> >
> >  #define CPUID_EXT_VMX                        BIT(5)
> > @@ -256,6 +271,8 @@ static void tdx_td_init(struct kvm_vm *vm, uint64_t=
 attributes)
> >       memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
> >       free(cpuid);
> >
> > +     tdx_check_attributes(vm, attributes);
> > +
> >       init_vm->attributes =3D attributes;
> >
> >       tdx_apply_cpuid_restrictions(&init_vm->cpuid);
>
> Do we need to set the init_vm->xfam based on cpuid.0xd and validate it wi=
th tdx_cap->supported_xfam?
>
I don't think it's necessary. And according to the TDX spec (TDX
Module Base Spec - 11.8.3. Extended Features Execution Control) the
mapping from CPUID to XFAM is not trivial. Checking attributes makes
sense since some tests use non-default attributes but right now we
don't have any test which uses XFAM features. We can add XFAM support
in the future if it's needed and do the check then.

