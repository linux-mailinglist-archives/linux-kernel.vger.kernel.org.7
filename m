Return-Path: <linux-kernel+bounces-780183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF13B2FEA5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01BE1891E41
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E463277B3;
	Thu, 21 Aug 2025 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nY2rt5KH"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C524322754
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790042; cv=none; b=RC5B0ix+AK93RtFFHuGBBYIEUIHRarEg5zHetCnTz4P+fv/PghblByo0v+WcgGp7dn9nUD4u0jqvbo21QyXa6uuLSfNsy2DfHfDCV3uoQuwJK6edrJPGTMqZGyj0jo8oStWEMijarMssM92kyohJwyPcycSUhw6Z1XJjEsYpQEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790042; c=relaxed/simple;
	bh=RuVd6VhLx/ESvjcEdKEJ0sQssvWWc/dXK+bjffFMlDU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kwRKpNI6aYOb3oBLoNxTqbUGrSGJBXYvVOAytPRnXxid+y06vdxGCrNc/hi35bBpYApiyxTu3DI+HJvzb4q8YKbamUbL6+yY1txBW+uhq/uZvghRWKWL8L8e+V9fWaeZ6iIN6zIly1yUs3MPTmhWM/aLg2FBrILovniTDmDq4+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nY2rt5KH; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3235e45b815so1324921a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755790040; x=1756394840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0nOEic8CcwY+6hpqmum6A9VNU65AINFJfOA9KBUaPg=;
        b=nY2rt5KHHZ9Yy4NlUbKvDYneBU+HGEc0nCkNzpr7/PgG07v61rggWtSBy0BiFA/PyH
         B69LrsO4qc0npVOq0+FsJ/fDodVZitvoradAjktb84Exbp0V3vTAHtKuR9naLYSMwj8I
         Y6yGEU1cY7vU3qEQEuBtZMwy5+PWJ3SvkrTrTvs3lwCxMSe9OOOsxzNtweOhj+D1OmVR
         uze0DBliPIuvxoUlQtW86l2BVAuoxCryvYk/i0O5b+3LtFh8AKV8J8wgZx9ewlMWAmLG
         zXTFlrKIUrEcfnuIHju9QEKyKwgnD1/T8yMfAdtPHgAFaz3oDfAsr2/a3ggpGV1qcxTN
         ohbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755790040; x=1756394840;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J0nOEic8CcwY+6hpqmum6A9VNU65AINFJfOA9KBUaPg=;
        b=OPF+Wy4zSYAOEYKOAUjCpUpeUUteRFUk6qH/MxsgqC+weqBmqxy4S0usDRjbO6VndA
         OFOX12y0BD7fIRutvkoU7Z9Dy8HblCZTBBhm37KY3GVoFQo/ByfA8gAjJ3fZMU1jQJfU
         0KSobp2J6OflNY8yKbuIebuDJ52xYLDxKHDeteIJcr4dKh3HHCyEimEABttJL8Wfs8/Y
         MaI5K/9qdgK1daPO4H2JNEqdtUA5cJuqaYCrE+VamtLBpFl+fDxhATkD0p3u2mmpn7I+
         RsNfXDO1gNy7goivyvAzMKNp5VCMbIJLugRmf9ROZkF0f5KBhwb09x8M2boomb02TLqJ
         KvMw==
X-Forwarded-Encrypted: i=1; AJvYcCVfP6psn0znqaOvoWfhSQlYXo5cKMHMkKELKzv/dY5SELIXJc8DMn7Ilw/WZfLcLae06+pkS4EmG9l3Qv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo8/NdzGn7/bHb+1B+IDklX8LtNKQLbWx1g9mWo7E+N7jtRCo6
	7IrIfaeDYJDZhp8RG8qZQ50dJwOEzgHK3u/bwbqbervDkttMp3ZWv+Bj/JNw1eloRK4FZQbnKYz
	aggPwQA==
X-Google-Smtp-Source: AGHT+IErn+S7Lo3tcvkDcjWls4tKiHbQGQvkGoFOV+v791Vf8loaYFkjMjAYIe9Wb0EbdLX8P8wL1dPep+E=
X-Received: from pjbdb4.prod.google.com ([2002:a17:90a:d644:b0:324:e309:fc3d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d83:b0:31f:2bd7:a4d2
 with SMTP id 98e67ed59e1d1-324ed15c158mr4291122a91.35.1755790040396; Thu, 21
 Aug 2025 08:27:20 -0700 (PDT)
Date: Thu, 21 Aug 2025 08:27:19 -0700
In-Reply-To: <f1ec8527-322d-4bdb-9a38-145fd9f28e4b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aIDzBOmjzveLjhmk@google.com> <550a730d-07db-46d7-ac1a-b5b7a09042a6@linux.intel.com>
 <aIeX0GQh1Q_4N597@google.com> <ad616489-1546-4f6a-9242-a719952e19b6@linux.intel.com>
 <CAGtprH9EL0=Cxu7f8tD6rEvnpC7uLAw6jKijHdFUQYvbyJgkzA@mail.gmail.com>
 <20641696-242d-4fb6-a3c1-1a8e7cf83b18@linux.intel.com> <697aa804-b321-4dba-9060-7ac17e0a489f@linux.intel.com>
 <aKYMQP5AEC2RkOvi@google.com> <d84b792e-8d26-49c2-9e7c-04093f554f8a@linux.intel.com>
 <f1ec8527-322d-4bdb-9a38-145fd9f28e4b@linux.intel.com>
Message-ID: <aKc61y0_tvGLmieC@google.com>
Subject: Re: [PATCH 0/2] x86/kvm: Force legacy PCI hole as WB under SNP/TDX
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Vishal Annapurve <vannapurve@google.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	Jianxiong Gao <jxgao@google.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dionna Glaze <dionnaglaze@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, jgross@suse.com, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, pbonzini@redhat.com, 
	Peter Gonda <pgonda@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, jiewen.yao@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025, Binbin Wu wrote:
> On 8/21/2025 11:30 AM, Binbin Wu wrote:
> > Variable MTRR has requirement for range size and alignment:
> > For ranges greater than 4 KBytes, each range must be of length 2^n and =
its base
> > address must be aligned on a 2^n boundary, where n is a value equal to =
or
> > greater than 12. The base-address alignment value cannot be less than i=
ts length.
>=20
> Wait, Linux kernel converts MTRR register values to MTRR state (base and =
size) and
> cache it for later lookups (refer to map_add_var()). I.e., in Linux kerne=
l,
> only the cached state will be used.
>=20
> These MTRR register values are never programmed when using
> guest_force_mtrr_state() , so even the values doesn't meet the requiremen=
t
> from hardware perspective, Linux kernel can still get the right base and
> size.

Yeah.  I forget what happens if the ranges don't meet the power-of-2 requir=
ements,
but the mask+match logic should work jus tfine.

> No bothering to force the base and size alignment.
> But a comment would be helpful.
> Also, BIT(11) could be replaced by MTRR_PHYSMASK_V.

Ha!  I spent a good 5 minutes looking for a #define couldn't find one.  Wha=
t a
bizarre name...

> How about:
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 90097df4eafd..a9582ffc3088 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -934,9 +934,15 @@ static void kvm_sev_hc_page_enc_status(unsigned long=
 pfn, int npages, bool enc)
> =C2=A0static void __init kvm_init_platform(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 tolud =3D e820__end_of_low_ram_pfn() << P=
AGE_SHIFT;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The range's base address and size may not =
meet the alignment
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * requirement for variable MTRR. However, Li=
nux guest never
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * programs MTRRs when forcing guest MTRR sta=
te, no bothering to
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * enforce the base and range size alignment.
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mtrr_var_range pci_hole =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .base_lo =3D tolu=
d | X86_MEMTYPE_UC,
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.mask_lo =3D (u32=
)(~(SZ_4G - tolud - 1)) | BIT(11),
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.mask_lo =3D (u32=
)(~(SZ_4G - tolud - 1)) | MTRR_PHYSMASK_V,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .mask_hi =3D (BIT=
_ULL(boot_cpu_data.x86_phys_bits) - 1) >> 32,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 };
>=20
>=20
> I tested it in my setup, it can fix the issue of TPM driver failure with =
the
> modified ACPI table for TPM in QEMU.
>=20
>=20
> Hi Vishal,
> Could you test it with google's VMM?

Vishal is OOO for a few days.  I pinged our internal bug tracker, I'll find
someone to test.

Thanks much!

