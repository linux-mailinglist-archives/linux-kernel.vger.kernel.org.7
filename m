Return-Path: <linux-kernel+bounces-720677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269FBAFBF25
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556633A67EB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9F7288A8;
	Tue,  8 Jul 2025 00:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fyMOF3hc"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CF91BC58
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751933672; cv=none; b=jyaFhyOyOBK4Oev3BvA//8YOT6u/6wNculxguOM//w/+g0qDW8p9vW7yn9+WAyyHZUn6jTnlJKoi/EQzatuoF2+J5QX6dVECQWVpsfigeRLgrzj3Q6JDEpIzj7z+3HEpvpTGW9nJMUD5S/xjVfxAcBX2TViB/NsEPJbohNtNkhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751933672; c=relaxed/simple;
	bh=Q3YduanZhg5Y0sB2Odh2fAerxegQJGenK+wI+G6lALA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTsPcgaWKNUaM78FPr10657oAx/tTu2ebT4RIj29QdaD63SmWmnJ53l4eINlNu5d7HEuSTTz+tOxGonIZWaymy66+H4SCIq3C4AkK8FPihBRvMgKnVwqZHxMpJ2HTWEQvdVo+0cy7yfK8bAMDKLQtoY9hKuAKBcWXvzC8vxY/MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fyMOF3hc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-237f270513bso45165ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 17:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751933671; x=1752538471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3YduanZhg5Y0sB2Odh2fAerxegQJGenK+wI+G6lALA=;
        b=fyMOF3hcl5vFT3PHgZ0XuS4zOHuRPNH6I6nAmUEHi7hVuZ7Tb6AexApnychhf2SWl9
         JGImb2iQteaEL+ZC/o7Jv3Fw7PYms7/qPE9+zLIENOph1dJSzqC/9PJIS3MOtqg2CJd+
         dOz67q2Wv60QWU/iHJ0ONsdCSyb9nX/kBPWESXvwpAIj23FCiTI275YJINlYpIS70Baw
         TVVE6O/Sc63Lvo2ZwxANe+0hoiGlGcCBQ0OoeFwW676YcMA/SPIWV1a0kDD4aineUAHc
         DOrZ+2lbhYpXSLRApWEYZe+x7/QqLhQG5Ro44rDEj3W7p/4dXUseDot0iwE662uEf+oX
         uSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751933671; x=1752538471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3YduanZhg5Y0sB2Odh2fAerxegQJGenK+wI+G6lALA=;
        b=N/Wij+s6QDkIUIyFLqohrRjI2azT4LHCe+f4HZRNJ4FcdO0MZcn3Ft0eLdclFICBAD
         4fog/bQkdaJcCkQZbxIW3vSDBdu8aXG6KSWmJeJ/D2m1xOpd2Lbzdu3z+pqOlekXbEbQ
         WZiyd7HIv7XThKY8RDAQo/rCaCxn1oxuMDiElCwLTt5Cg8FqHhR/A5fFc7aPvQEa4mK8
         vLmVEMvmgCndQPfK5sSId7lZurGtgIVcAOoSUTW3PUjPYJOkM+Tut+Cw7E08SyJHPbOn
         qZCIonNajpqEdmXY3LnqoIwDUqCI8ufoZgMSGJ7GJjkf4f/ceujc6W2ybkl3IVxsdx1w
         Os2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/hpRbM0ActFpkdCYUWAER0K+QTgJ7J937FbK0r0XNCGWaWUKWGbwlPTsqROymOW8cR1vyvVOVfAcBQ2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRJCJLL3FTnt5qAEJBr5wXJLOvU+F1TxNf43GyNvx20X3Iw+Zk
	3kvvMJ3X6S3QfaCszV6mpU8dC0ReVOWLV4DmsY3xp5Kwfb1tzqv51XSibPecMrLPrtECjAF2oGh
	molDnOj6qckV2GKFoSQ3YbzjVa7b8fO4jhUo6SrzY
X-Gm-Gg: ASbGncvWb5aXs95vRjaHocDeIt5usqtU3W8f9xfn2fAMfaBCpTu0Et3qPOzxExc+Snu
	O7LE/dwntJWz6mclm6WHXaKSz7sDk1L2ocwVlhgHsM4FLQWZUOY7wG1H8Z5vlLKSx81HLpt/hcj
	RxcLK/5pw1bx1UoWQq7/oE8b9K21Igr9PDEqTxWGY/v27nrMl9gTD8qfJO/2ZXPTmags2KO/Yqr
	A==
X-Google-Smtp-Source: AGHT+IG6uFwfViV4uRKlN7dtoaYWYJ2cAvUBFCR9zSfu99Vwne4/Ojg06Ia/L5ZZcaIijmv3rovYpa5VMqmmYY4ViY8=
X-Received: by 2002:a17:903:98c:b0:234:c2e7:a0e7 with SMTP id
 d9443c01a7336-23dd0f66398mr1276695ad.4.1751933670151; Mon, 07 Jul 2025
 17:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <aFPGlAGEPzxlxM5g@yzhao56-desk.sh.intel.com>
 <d15bfdc8-e309-4041-b4c7-e8c3cdf78b26@intel.com> <CAGtprH-Kzn2kOGZ4JuNtUT53Hugw64M-_XMmhz_gCiDS6BAFtQ@mail.gmail.com>
 <aGIBGR8tLNYtbeWC@yzhao56-desk.sh.intel.com> <CAGtprH-83EOz8rrUjE+O8m7nUDjt=THyXx=kfft1xQry65mtQg@mail.gmail.com>
 <aGNw4ZJwlClvqezR@yzhao56-desk.sh.intel.com> <CAGtprH-Je5OL-djtsZ9nLbruuOqAJb0RCPAnPipC1CXr2XeTzQ@mail.gmail.com>
 <aGxXWvZCfhNaWISY@google.com>
In-Reply-To: <aGxXWvZCfhNaWISY@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Mon, 7 Jul 2025 17:14:17 -0700
X-Gm-Features: Ac12FXz8PyaRfu4rhO-WaL1IGCmpiHbF9FfbCawryHLn0bG8xOVNVPi0PuKZNZ0
Message-ID: <CAGtprH_57HN4Psxr5MzAZ6k+mLEON2jVzrLH4Tk+Ws29JJuL4Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
To: Sean Christopherson <seanjc@google.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-fsdevel@vger.kernel.org, 
	aik@amd.com, ajones@ventanamicro.com, akpm@linux-foundation.org, 
	amoorthy@google.com, anthony.yznaga@oracle.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, bfoster@redhat.com, binbin.wu@linux.intel.com, 
	brauner@kernel.org, catalin.marinas@arm.com, chao.p.peng@intel.com, 
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com, 
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, graf@amazon.com, haibo1.xu@intel.com, 
	hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 4:25=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Tue, Jul 01, 2025, Vishal Annapurve wrote:
> > I would be curious to understand if we need zeroing on conversion for
> > Confidential VMs. If not, then the simple rule of zeroing on
> > allocation only will work for all usecases.
>
> Unless I'm misunderstanding what your asking, pKVM very specific does NOT=
 want
> zeroing on conversion, because one of its use cases is in-place conversio=
n, e.g.
> to fill a shared buffer and then convert it to private so that the buffer=
 can be
> processed in the TEE.

Yeah, that makes sense. So "just zero on allocation" (and no more
zeroing during conversion) policy will work for pKVM.

>
> Some architectures, e.g. SNP and TDX, may effectively require zeroing on =
conversion,
> but that's essentially a property of the architecture, i.e. an arch/vendo=
r specific
> detail.

Conversion operation is a unique capability supported by guest_memfd
files so my intention of bringing up zeroing was to better understand
the need and clarify the role of guest_memfd in handling zeroing
during conversion.

Not sure if I am misinterpreting you, but treating "zeroing during
conversion" as the responsibility of arch/vendor specific
implementation outside of guest_memfd sounds good to me.

