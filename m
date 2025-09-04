Return-Path: <linux-kernel+bounces-799827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E02DB430B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68105E4AA7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756BF1940A1;
	Thu,  4 Sep 2025 03:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D2SFw0jV"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14913225408
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 03:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756958253; cv=none; b=FvJ2RmNnoRHGqBJvwOkYKIsst3OPNTu88sX/351a7bE75T82NGorJIwAwxHBvzYjNa1bhSvOSdUdPUy8ZVr7FwdVEeBv9GOTyTyZOBbjJx0hXdRS6AJCtL0E1XZsHVNNhQp70e3SE4S3UgO2draiG2dzGYWEPo41qn+3iCSnDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756958253; c=relaxed/simple;
	bh=xEMhVLidfWLK5GfLI3r1fuX8bsDGHXjmX0LNLTjKG/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyn3QeyjhdragdUJgSXy+fj8xYIdPoEU0Oh12qgkU3SdhWxOJVAWJvewCWoQ531EZgk0O98ytKD90WuKhoKnELSeOk2OVGVya1QuyyCaQc0PtsFt3f3RRudWne8PAg3JasQAaxaKZWGpXFyh/uEGKtovvvDMUtiFdJrCZFya628=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D2SFw0jV; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b48fc1d998so121711cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 20:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756958251; x=1757563051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBTqFKoXnKiOcm50nqRS6Yy8I8KtvrzJ2PezTalB3Tk=;
        b=D2SFw0jVmMTzHtfxHEZeSbYbI55HcwaViZ9wIPXodxvaY/ZL+IrsJHh1gFj/PM8gJQ
         JzkPh0eaNyKUnMKxAVzaZtb73saeE9oteGo+CDtSfyKVO/pXGW2++RW1CCZ/mPEd3ExB
         pnLuDCki+E/WYpCYZSMwlfc03oSGHRYo/bBDz2W7aJYGZxCgajMcOpbmyMzAR9SjLZ1q
         zb2JNF+tysaFANvFToC/DTx6m7B6JlcpKdgjMmZXZqc3WiXKOXhjRmJJgJF1lVmnCxVR
         9n76T2ZSalguYnUiIgiHMJNUBCLp3C81qtR97S+w8TGPH8MEeJCCPpyIzq5UtNWxcMTW
         EaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756958251; x=1757563051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBTqFKoXnKiOcm50nqRS6Yy8I8KtvrzJ2PezTalB3Tk=;
        b=myLg6YfW5yEFeGpimg0M3dlQVjxcnurMUtdOBorVYfPgfewzfqBO7IDanzuS9hhmXi
         yhJfPBYj+LvZcnM7LS7HkItmmRqIOS6KkcIBv7jYEhlM9RJKhh3Ch0eu+uUHdblSODyO
         n7MmH3vibXjHn+r4yk7UPdLBYeArn74TYc54HJCw7wAtN6QFVrejUJVA28aVyo4qe1cB
         05+LL5PLsLgnpksCUCr61lyoZS7wGxWUqtBNEmrx6kki5hDXEwnB1o+/oDUVeW01Fd/T
         CSJ5/LI0Y6cjWeM/Hu2Pr7O8aku+fVxGNKjDhjM7/EBWCC0C2I5fSlDj/SRK1Wv+bG8z
         aBuA==
X-Forwarded-Encrypted: i=1; AJvYcCVtasVlAkjLjKSShKrcAOR/y2tHqicxA9hOpVRcS7TpS6hKGKd4Jgc1TLD5u6YEJmuWZ67YGkf6KdZQrso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyuCKtN53hvuZsSstPBrrJx+ddVeILZvTMoVS7CzDas8WZ/Uhr
	WLZ6+cny2LdBukzVPDZYYlXJGRLswClz6ikNEjgydP/MJDZf1bWcXuAxy0uAYZOSdCTjeFrab4k
	nsAK+mHKETcRX/7wfkv8Wkwyt4rIowwLZs6dcVcW8
X-Gm-Gg: ASbGncsmIo1yKSeNG0Ic5gV+jIQeAnMBVLQ3I0jCjfeXvuSjOKVOoPlVU8r6sllyN15
	bxMURDgz1nrZ5+fcqHULpjAxnNs4ohHy9/7442D/d34HYVqZD+Evq17lx+9iCf11h9zIGk+zEl1
	p1d8XICCgY6+co/QRt2NfObilODn+hbOSJps0u9bKcXE8OItxbzCdxWIj4OcWB16w5k4ST3hHZ4
	OrDuS7uBrgILeC9dYxY2IrWg1rFcyGnwVfHjGxe4pA6CemryXl8aqyRhg==
X-Google-Smtp-Source: AGHT+IFABB+Avc6QHEeuwF0wDDVLti6c3tU1IhZy3ktnq5x4DGEQkfAEm9v882fixgRaXfqJkMAftPwoMHh9OXXEYTo=
X-Received: by 2002:a05:622a:19aa:b0:4b0:82e5:946b with SMTP id
 d75a77b69052e-4b5d8fa35c0mr1558801cf.4.1756958250768; Wed, 03 Sep 2025
 20:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-14-sagis@google.com>
 <4306ca85-1dcd-47c1-bb36-b76a2efe061f@linux.intel.com>
In-Reply-To: <4306ca85-1dcd-47c1-bb36-b76a2efe061f@linux.intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Wed, 3 Sep 2025 22:57:19 -0500
X-Gm-Features: Ac12FXzNFOBbPOriwT60z3j6ue-cC6R2KpQybuwxnW3mftmkIHbJGx0TKHh8AQ8
Message-ID: <CAAhR5DFb1063E_zOLf8af_v3tQxx06cHtGL26j5XtojRv2GvLg@mail.gmail.com>
Subject: Re: [PATCH v9 13/19] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to
 validate TDs' attribute configuration
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 4:22=E2=80=AFAM Binbin Wu <binbin.wu@linux.intel.co=
m> wrote:
>
>
>
> On 8/21/2025 12:29 PM, Sagi Shahar wrote:
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> >
> > This also exercises the KVM_TDX_CAPABILITIES ioctl.
>
> That commit message should describe what the patch does instead of relyin=
g on
> the title/short log.
>
> >
> > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > Co-developed-by: Sagi Shahar <sagis@google.com>
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >   .../selftests/kvm/lib/x86/tdx/tdx_util.c        | 17 ++++++++++++++++=
+
> >   1 file changed, 17 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools=
/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > index 3869756a5641..d8eab99d9333 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > @@ -232,6 +232,21 @@ static void vm_tdx_filter_cpuid(struct kvm_vm *vm,
> >       free(tdx_cap);
> >   }
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
>
> The comments are not accurate.
>
> The descriptions in TDX spec are for ATTRIBUTES_ FIXED0 and ATTRIBUTES_ F=
IXED1.
> They are related to tdx_cap->supported_attrs returned by KVM, but they ar=
e not
> the same.
>

I actually think that one of the conditions is redundant. Here's my reasoni=
ng:
If a bit is 0 in attributes then both conditions will be true
regardless of the value of supported_attrs.
If a bit is 1 in attributes then both conditions will be true iff the
corresponding bit in supported_attrs is 1.

I'm going to keep only the second condition which is clearer and
update the comment.

>
> > +     TEST_ASSERT_EQ(attributes & tdx_cap->supported_attrs, attributes)=
;
> > +
> > +     free(tdx_cap);
> > +}
> > +
> >   void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
> >   {
> >       struct kvm_tdx_init_vm *init_vm;
> > @@ -251,6 +266,8 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t att=
ributes)
> >       memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
> >       free(cpuid);
> >
> > +     tdx_check_attributes(vm, attributes);
> > +
> >       init_vm->attributes =3D attributes;
> >
> >       vm_tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);
>

