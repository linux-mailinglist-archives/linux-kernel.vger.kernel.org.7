Return-Path: <linux-kernel+bounces-769454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA90B26EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F3BA4E0F91
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037BC230D0E;
	Thu, 14 Aug 2025 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RkYsB+6h"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5645223DC0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196209; cv=none; b=QzgSYvwg6shjWyGL06QI7og9oL4fGAW59JNhsGkCHgKOb95gbK3F9aP/+EcgHfV/4F6oKA/I3zi7u5Mj+zEpdcLcyFGgdx4I3JlDMZDdq4hYFdHJOEGnm9eBD1w1ApbZGfQA/DCabePCdy/79aXDg5s1TX3VklPAhvTzYC1rG78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196209; c=relaxed/simple;
	bh=A4c0iTOf2R71rU6WSqW1yP7mOGni3aEu/5lN6bh82ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfDrvdAxV/uzetTveVXSNYj7RZ5jGJl/aYS8hxTh1bVUPh135oZQtj6d4SZ3bISsuev2awfv/QSzcSXKUP3DG0uNe8WtnCU9ECPjNZdBNJYGXibyuRCwK1Xvd0kHanBBq+X2jfaIRwncDXDWF+52m6UyROZGwewI3y8xG7LCoQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RkYsB+6h; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-242d1e9c6b4so33915ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755196207; x=1755801007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig/c0W4/BOO1c1TnermMCysZ+XWEDUNRpnYsEQ42d4w=;
        b=RkYsB+6hzpQ8MaI6myIK+xqd3t2Ox3QnLZmmYNKK4ZDdZga/2Ib5v2bEhnObqJKom/
         FAc88W4Qd5Kze4dZf/iY8STZnNkMLW/SvYJTj2qgQKNFDP1pPFjr/rAmdytwqDJUb3B2
         4/T70/SbHEWg2lMcOi7ZKKgd89HRUiDxhZOru8tFUjrSHAIJblvJlbU4xmaROliXuNWj
         wtRtI6iBtgaN528SJgQUWCJ17rFnGK6Fs0S0EYP9rzHPb9ZBijgp6LL5IAmy7dW1Z5km
         QVo7mkecdp4skRn1fMzeIVgiakzD3p8NsgUULEbOclfo2LbVTzJiV4XzO8hFWaAprJJP
         dYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755196207; x=1755801007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ig/c0W4/BOO1c1TnermMCysZ+XWEDUNRpnYsEQ42d4w=;
        b=nrrAg7fom3FqrG94nGiqOr74HeVf4IHO9wKrwfTDtXbz4aAKWJePFFLB+/m9cHa8iS
         26cijAioqxkSYKwm6OsBjHZut3ys8CsKwPY9d/dnSMgbcfRcZvedncqZB5+DVDirfd9W
         xF6sABnHucU50F8XnJ3508v3EQag2cO82Ns2zf+eI6GbdlNCYZv7kDC9R8A5eU3Kz71E
         LTLs/Mz3PS0yn/9LQ06SF29PkvS/YeJAKmnhhd3IRRguoLKAVFdz6S2z6hjnPUOjPvZH
         /1N3y3drBPNoejBOvEB71WKRAS83PsGdp0RaKmVg+IZ+LFdsGbxSxbaaafelkzDUvAOM
         AaDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWisuUUumIW6NZnRLNCFltU5g1i/F/kbecaQg/juMhNCBHZDEBzCO2d6X5VrhGBgKYsGjFIvwZujh50MI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8SN+Sv7yt5zruqIVHqWhpH11J/c5zNfrYHjKCbpiRc7SEbSNM
	CuSc6JBOxSMDbqf24WUr1pi+LugrGfrgs5SdyrU3m+cxJuopUZaTd2pIVc/jadDvKpSMb+1BBtV
	wLvfTMK3vMcTOB/cMheFC47IQeknAX2dOnZmsd8gy
X-Gm-Gg: ASbGncuSm79O/j6Ey2SeGdhj/UpiUGRJpWFEG6342f8jjJcGmu0KclVsAYq7CVTeQg4
	s+xmO9IXiR7q5uytg39cih4vb2sJ2cK7vhyOaPg4gocOg9UwXQdnJWd6Ks6UhellBev1A5aQ4qs
	grXhK1sJ0kmz3y7CTfPVXCp7ag7draapaSO2Pux0kJ/dA0ERbHNiqDuvuMA8kvXRzwIT/wSGgyV
	YlFzI8R4eot6P3Nf11Le+wdkrVSTxtgCamHNjIYw4QORMdy45NlHxVp9AbtAe6NTQ==
X-Google-Smtp-Source: AGHT+IEJ3rIt+hm3527BfevwvcRNLE+CbaQKjXaAlRRRLeXWlJYoOK5k1FQMQ32BZFyBpLy5XqDtrS+ugxQllWxJwvU=
X-Received: by 2002:a17:902:d512:b0:240:640a:c564 with SMTP id
 d9443c01a7336-24469cc0686mr251445ad.3.1755196206738; Thu, 14 Aug 2025
 11:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807093950.4395-1-yan.y.zhao@intel.com> <20250807094616.4776-1-yan.y.zhao@intel.com>
 <CAGtprH8a4i-U-4Z6=Bk87FsC2nG+UbTVWB1Sc8oYXMJs7pHUwA@mail.gmail.com>
In-Reply-To: <CAGtprH8a4i-U-4Z6=Bk87FsC2nG+UbTVWB1Sc8oYXMJs7pHUwA@mail.gmail.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 14 Aug 2025 11:29:54 -0700
X-Gm-Features: Ac12FXzYb_vWbUpk-pxM17D-jaCI2hnlVjz3bGZCmNK_-ADInzx_yScOkMMIGpI
Message-ID: <CAGtprH8da6iwwG6u6Z2EpGaqFVWWFJD4o3RUvDYmxDQ9qaYm0w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 22/23] KVM: TDX: Handle Dynamic PAMT on page split
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, x86@kernel.org, rick.p.edgecombe@intel.com, 
	dave.hansen@intel.com, kas@kernel.org, tabba@google.com, 
	ackerleytng@google.com, quic_eberman@quicinc.com, michael.roth@amd.com, 
	david@redhat.com, vbabka@suse.cz, thomas.lendacky@amd.com, pgonda@google.com, 
	zhiquan1.li@intel.com, fan.du@intel.com, jun.miao@intel.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, xiaoyao.li@intel.com, 
	binbin.wu@linux.intel.com, chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 10:31=E2=80=AFPM Vishal Annapurve <vannapurve@googl=
e.com> wrote:
>
> On Thu, Aug 7, 2025 at 2:46=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wr=
ote:
> >
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > +static struct page *tdx_alloc_pamt_page_split(void *data)
> > +{
> > +       struct kvm *kvm =3D data;
> > +       void *p;
> > +
> > +       p =3D kvm_mmu_memory_cache_alloc(&kvm->arch.pamt_page_cache);
> > +       return virt_to_page(p);
> > +}
> > +
> >  static int tdx_spte_demote_private_spte(struct kvm *kvm, gfn_t gfn,
> > -                                       enum pg_level level, struct pag=
e *page)
> > +                                       enum pg_level level, struct pag=
e *page,
> > +                                       kvm_pfn_t pfn_for_gfn)
> >  {
> >         int tdx_level =3D pg_level_to_tdx_sept_level(level);
> > +       hpa_t hpa =3D pfn_to_hpa(pfn_for_gfn);
> >         struct kvm_tdx *kvm_tdx =3D to_kvm_tdx(kvm);
> >         gpa_t gpa =3D gfn_to_gpa(gfn);
> >         u64 err, entry, level_state;
> > +       LIST_HEAD(pamt_pages);
> > +
> > +       tdx_pamt_get(page, PG_LEVEL_4K, tdx_alloc_pamt_page_split, kvm)=
;
>
> This invocation needs a return value check.
>
> > +       tdx_alloc_pamt_pages(&pamt_pages, tdx_alloc_pamt_page_split, kv=
m);
>
> IIUC tdx_pamt_get() will result in pamt_pages allocation above, so
> this step is not needed.

I missed that one allocation is to cover the EPT page and another is
for HPA ranges backing the GPA mappings. So ignore my rest of the
comments except about the error handling for tdx_pamt_get() and
tdx_alloc_pamt_pages() missing in this patch.

