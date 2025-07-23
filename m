Return-Path: <linux-kernel+bounces-742692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A73CAB0F56A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42FE8188EFAC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B092EF2B5;
	Wed, 23 Jul 2025 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bdO9Rqb0"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCE118E3F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281288; cv=none; b=aoLi7LrrPtBRZ0cc0ALcELFhse5iMLugB5xrpujHtx93mySSszlOMExq57KsdBn0zvWLqEMvdNPZ6BABFpAqMUPiC/RiglrQieorVy5KEfuIq3sJl6KwKsFd2VBBxZnj+EHfikRUVzsFy+Fv2hSMv4I475XWJZ20i21tMcHXJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281288; c=relaxed/simple;
	bh=ysBfbu4d44kHnuf79CcgYWd07b9mHFRage2arin+xN8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cCaJCDYNAPhkYugynYm1fEE3R+S7sn7qqiD4emlb0NBO8P2CI5QiiepDVozh5K+EXPJ0zSthRFfa+bYnG3nihp4CHD9yoGOY5rjND/83/sbpiJN2/FCRu1nfea42OyF4qEsJg2/5WNaysU9cqgjD0PYwW3sqzwcudRp6EylP8Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bdO9Rqb0; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74927be2ec0so11115b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753281286; x=1753886086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lvLcFjlMK4Aa8Y4hHvGWNB2FC+HyPO5sR5MFDq7rjfY=;
        b=bdO9Rqb0lJqPeGc2HR9/b2xH+d59ATKVx11Dk1H/pJnYQLyCcHrQJM6XTi2N4UMNCG
         BzRkRFC6KHxDrm63jNSZmSHPi999MXxEz/qDR7kjxzlRjDtX5jD/yRG0VgHmEjOdy30t
         3srpzGfJDwsXBoWkLdHi05z4GRPo1rPwDj8GOevAWh3YRvoFuoZ4Cvz48lOVB0DYTNpN
         INYkzoDmBZNsbzZBPT5KSQhaWcxeY6yt73vRi+EkXIfYCc68WLaomdbHlcIcWAyQr3Om
         4ZEM1XwCIY2xpK4kR1T7uE7YhsPYtNnadcZvaGQMtCdBsIh8AwGwQ7H0yvC23S7B1AL8
         IJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753281286; x=1753886086;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lvLcFjlMK4Aa8Y4hHvGWNB2FC+HyPO5sR5MFDq7rjfY=;
        b=jHTO9BBNGkZfk2l9rmbeHm9VdYVYSTdkwpM7PK5SHGc+mMEJ/Xyps11lzATPUjvTEV
         Z8tdcDfa+x/xUqD08iQT++n0JI0h9zJd4tMSuAdCnZmj8+GPaUGKbCvNfcai3dp2IVDj
         clF6bGdkEH/Zl+I69unKkDTLTMbvbKsz/CH4JI/53LPLiChY8ha+tykH6Ke0QDtm9JsS
         F/73Lwleoa4A6Ofp38bdIIxi6Ee+JiXlDFyQJC5u5jQOZkPigWIhcWgeQDndoyRJr2c9
         TXPqzbtBKOFTuBYql+kqjEbmiI4fSD7WdSw7Ez+eNGUG4lpOhundfBGG16tiKap/EtiW
         Q3og==
X-Forwarded-Encrypted: i=1; AJvYcCUmdweNStQXOiZ4CaU1+oJQSeuq4RDMaX2B2lEp0drCcAIwHamsiyPZ5cmJxD4xMLF2umr4ti9bdax7TjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTE/MO2Jik/UzRBlO/vOFDcsNL6If8eCrPhE4rdUOjLXE0zvco
	uQmNs2vKagMu9ZbJZJhVZmeZZyG8xO9EVe6GCUivIxuxP819RSAoB4xD2Qt7aGGYnLTpJ36qdNb
	MSIIx4Q==
X-Google-Smtp-Source: AGHT+IFJ3jH+Fv7e2r0eCvcCEiw5AAI+OI44sKQgvj6gziAc1ODmn+/riNrkBnIqvIBQx+4Mne9LWDhZsXE=
X-Received: from pgdy23.prod.google.com ([2002:a65:6417:0:b0:b31:c7e5:6664])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:614a:b0:21e:f2b5:30de
 with SMTP id adf61e73a8af0-23d49038c7amr4831933637.12.1753281286172; Wed, 23
 Jul 2025 07:34:46 -0700 (PDT)
Date: Wed, 23 Jul 2025 07:34:44 -0700
In-Reply-To: <4acfa729-e0ad-4dc7-8958-ececfae8ab80@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAMGD6P1Q9tK89AjaPXAVvVNKtD77-zkDr0Kmrm29+e=i+R+33w@mail.gmail.com>
 <0dc2b8d2-6e1d-4530-898b-3cb4220b5d42@linux.intel.com> <4acfa729-e0ad-4dc7-8958-ececfae8ab80@suse.com>
Message-ID: <aIDzBOmjzveLjhmk@google.com>
Subject: Re: [PATCH 0/2] x86/kvm: Force legacy PCI hole as WB under SNP/TDX
From: Sean Christopherson <seanjc@google.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, Jianxiong Gao <jxgao@google.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dionna Glaze <dionnaglaze@google.com>, "H. Peter Anvin" <hpa@zytor.com>, jgross@suse.com, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, pbonzini@redhat.com, 
	Peter Gonda <pgonda@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025, Nikolay Borisov wrote:
> On 14.07.25 =D0=B3. 12:06 =D1=87., Binbin Wu wrote:
> > On 7/10/2025 12:54 AM, Jianxiong Gao wrote:
> > > I tested this patch on top of commit 8e690b817e38, however we are
> > > still experiencing the same failure.
> > >=20
> > I didn't reproduce the issue with QEMU.
> > After some comparison on how QEMU building the ACPI tables for HPET and
> > TPM,
> >=20
> > - For HPET, the HPET range is added as Operation Region:
> >  =C2=A0 =C2=A0 aml_append(dev,
> >  =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_operation_region("HPTM", AML_SYSTEM_ME=
MORY,
> > aml_int(HPET_BASE),
> >  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HPET_LEN));
> >=20
> > - For TPM, the range is added as 32-Bit Fixed Memory Range:
> >  =C2=A0 =C2=A0 if (TPM_IS_TIS_ISA(tpm_find())) {
> >  =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(crs, aml_memory32_fixed(TPM_TIS=
_ADDR_BASE,
> >  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0T=
PM_TIS_ADDR_SIZE, AML_READ_WRITE));
> >  =C2=A0 =C2=A0 }
> >=20
> > So, in KVM, the code patch of TPM is different from the trace for HPET =
in
> > the patch https://lore.kernel.org/kvm/20250201005048.657470-3-seanjc@go=
ogle.com/,
> > HPET will trigger the code path acpi_os_map_iomem(), but TPM doesn't.

Argh, I was looking at the wrong TPM resource when poking through QEMU.  I =
peeked
at TPM_PPI_ADDR_BASE, which gets an AML_SYSTEM_MEMORY entry, not TPM_TIS_AD=
DR_BASE.

*sigh*

Note, the HPET is also enumerated as a fixed resource:

    crs =3D aml_resource_template();
    aml_append(crs, aml_memory32_fixed(HPET_BASE, HPET_LEN, AML_READ_ONLY))=
;
    aml_append(dev, aml_name_decl("_CRS", crs));

If I comment out the AML_SYSTEM_MEMORY entry for HPET, the kernel's auto-ma=
pping
does NOT kick in (the kernel complains about required resources being missi=
ng,
but that's expected).  So I'm pretty sure it's the _lack_ of an AML_SYSTEM_=
MEMORY
entry for TPM TIS in QEMU's ACPI tables that make everything happy

I can't for the life of me suss out exactly what Google's ACPI tables will =
look
like.  I'll follow-up internally to try and get an answer on that front.

In the meantime, can someone who has reproduced the real issue get backtrac=
es to
confirm or disprove that acpi_os_map_iomem() is trying to map the TPM TIS r=
ange
as WB?  E.g. with something like so:

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 2e7923844afe..6c3c40909ef9 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -528,6 +528,9 @@ int memtype_reserve(u64 start, u64 end, enum page_cache=
_mode req_type,
=20
        start =3D sanitize_phys(start);
=20
+       WARN(start =3D=3D 0xFED40000,
+            "Mapping TPM TIS with req_type =3D %u\n", req_type);
+
        /*
         * The end address passed into this function is exclusive, but
         * sanitize_phys() expects an inclusive address.
---

