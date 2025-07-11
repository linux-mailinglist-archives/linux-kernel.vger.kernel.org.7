Return-Path: <linux-kernel+bounces-728165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90760B0240F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F49547D6A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C382F272B;
	Fri, 11 Jul 2025 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2/4RH7DR"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB84C1F4179
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259588; cv=none; b=eNeTTj2fugLyR40TvZ9H2t5jBbAjyWu4hsuwARhVE1m2fwZTKHrViIXzx24bSLr6YzgUr3RbCUvWAk1NxrW9skGSIG+65/L5R4KhLTv4ldPMZlR0x+DzrKaJcLZmYxGHmIuzGq2uIRbEuqEIRXKlh424VKoMzXN8quE1suyvM6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259588; c=relaxed/simple;
	bh=zYiGdxOL7zThjAm9ak0MVc2aInvxHTk2ZyWy/3uXVMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=la6fgcW4jySr00cLf2rV9MYp4C1sZBfx2oeZwEPic1IsNqOyP9Kkil/DMGzdDiDpo8WfMCCZ/5EcaEQ5xun86iFBA444yWn1lMbbezPCaaXckC4lGpDD8vvcPvaHb4UTPkRtMtRJ+ekVUzd/CwEBex0QSq/eXoUYiDroC9Vcdp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2/4RH7DR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235e389599fso28645ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752259586; x=1752864386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3aEobjPCY0l74zDE1rwtOs+YJ5bZnTUHt69hJSYx74=;
        b=2/4RH7DRN5G74KcdeYXokmQVQakFapSUnWGexVPuq7ByDI9RDIevdghyLBaKVoAbn7
         47cn6P5biuf1yttsxMz4DiywObC6Y0ICvAGm+aiC7mi1L8dAEMCyhA2HUyOGKXf9B2iN
         riQKS+4+6m1Ix3C/HQxukkaftqWXFCio98RqLEutjm+MPlgWhNz83b7yr1n+ZSWI+Eq7
         5+jdfNB54n20ic5Siwya6keu3anCm1iEwfkQmd7ZVnYlal6pDsSzX0xiRNjX4o0c+Kgp
         4R7yZGYG9ZvMw6BMmuAoH8pOEMbaMa6my+dy+YGI7na/TnJppWKM2xZWrIirNQNnxaQQ
         z+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752259586; x=1752864386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3aEobjPCY0l74zDE1rwtOs+YJ5bZnTUHt69hJSYx74=;
        b=vVy25/HUsyLtiqE9hPIRL6tJdVFSib0XXyjFtMaQzhMJSNvsFLeucsRT0CjC6xxi/Q
         a669aydUjKRkdnuygAg3B2BD38d4jIoQahZRvC/HUt6E4H/GAVxdgkq/bIB/VsdvveF3
         9WV1ot4Mu4fDgBx4roG9jUOPL/23+5c8T2ZpuXloXxUSYytQJTD6t9+p7dyf+cDHqqNu
         SQe811wE7ys/WGqKoeRKUrA/mA/aQ5axRBoRbYGYgkTOTHBgmAwGUwSt+N5VqxWbCS3+
         3ca1+ES6F73Yb+BTm2yjxlm0o0qLLgBfel202A3R3IYjXSv9MIVC/FIlKx0fqYDPENHA
         4wBA==
X-Forwarded-Encrypted: i=1; AJvYcCV+lsvg01B7BagTaIPppqJZjf9CF+Sz6gJZ3ihRajcr78bASQYMe33MR2F6EnU/7goCJoUVI2ZoTbvxyrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA45jkdept5GhCyiqOo3RrXrAefeVw96Qyd4Wojy3ipnsCb0MG
	ykqK24FD1mPYhR2yyxnRofpx6f3XmrZvDIB5TSWys+AsoomP9wky1xZxkfP9GOMt7AsHeyuYc70
	Bw+N2O+AItnNl9CM4pYMUiYqJNrfryUUj4ts90KM3
X-Gm-Gg: ASbGncuPHBq4DeBkbO5m+PLgPji1pET9tN8IJjiS3J8aTq4RVXFciV0VDCm7WKNLHGL
	d4w8T7qWeifeONeVVQgAc9MIfMcTXDaOiqHoWnwggeUiXb+/p3M/fFuGFWj8MCAvki5KLxvN0ub
	fbF2sIYBTa2eK0AI+M1Amo7SYLL//e7vsirLLmWevsAvrDvsat4ifzL2Hx5ixgSrUhX9oraB4Q8
	WS5M1aIWGTl6d+O8zfytuklD+n0G9Xnbpsumw==
X-Google-Smtp-Source: AGHT+IElSHIK+nFgCq+qGXxEYfAJicQBUs9O8jurR7Ssr4uaPjtm1X6j112grWmousd9jed4zUvBFs/XqJrLOCmyabM=
X-Received: by 2002:a17:903:1b30:b0:234:a734:4ab9 with SMTP id
 d9443c01a7336-23df6a2907bmr282615ad.20.1752259584520; Fri, 11 Jul 2025
 11:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703062641.3247-1-yan.y.zhao@intel.com> <20250709232103.zwmufocd3l7sqk7y@amd.com>
 <aG_pLUlHdYIZ2luh@google.com> <aHCUyKJ4I4BQnfFP@yzhao56-desk>
 <20250711151719.goee7eqti4xyhsqr@amd.com> <aHEwT4X0RcfZzHlt@google.com>
In-Reply-To: <aHEwT4X0RcfZzHlt@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 11 Jul 2025 11:46:12 -0700
X-Gm-Features: Ac12FXxHO3aH_ClVGK7BVe1DV9rCSynSWxs-Uxj1Wjji9UEyfhn7erZXSt82de4
Message-ID: <CAGtprH9NOdN9VZWkWLjYcTixrN1+dgWfC3rcdmv9rQBkriZrdQ@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: TDX: Decouple TDX init mem region from kvm_gmem_populate()
To: Sean Christopherson <seanjc@google.com>
Cc: Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com, 
	kai.huang@intel.com, adrian.hunter@intel.com, reinette.chatre@intel.com, 
	xiaoyao.li@intel.com, tony.lindgren@intel.com, binbin.wu@linux.intel.com, 
	dmatlack@google.com, isaku.yamahata@intel.com, ira.weiny@intel.com, 
	david@redhat.com, ackerleytng@google.com, tabba@google.com, 
	chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 8:40=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Jul 11, 2025, Michael Roth wrote:
> > On Fri, Jul 11, 2025 at 12:36:24PM +0800, Yan Zhao wrote:
> > > Besides, it can't address the 2nd AB-BA lock issue as mentioned in th=
e patch
> > > log:
> > >
> > > Problem
> > > =3D=3D=3D
> > > ...
> > > (2)
> > > Moreover, in step 2, get_user_pages_fast() may acquire mm->mmap_lock,
> > > resulting in the following lock sequence in tdx_vcpu_init_mem_region(=
):
> > > - filemap invalidation lock --> mm->mmap_lock
> > >
> > > However, in future code, the shared filemap invalidation lock will be=
 held
> > > in kvm_gmem_fault_shared() (see [6]), leading to the lock sequence:
> > > - mm->mmap_lock --> filemap invalidation lock
> >
> > I wouldn't expect kvm_gmem_fault_shared() to trigger for the
> > KVM_MEMSLOT_SUPPORTS_GMEM_SHARED case (or whatever we end up naming it)=
.
>
> Irrespective of shared faults, I think the API could do with a bit of cle=
anup
> now that TDX has landed, i.e. now that we can see a bit more of the pictu=
re.
>
> As is, I'm pretty sure TDX is broken with respect to hugepage support, be=
cause
> kvm_gmem_populate() marks an entire folio as prepared, but TDX only ever =
deals
> with one page at a time.  So that needs to be changed.  I assume it's alr=
eady
> address in one of the many upcoming series, but it still shows a flaw in =
the API.
>
> Hoisting the retrieval of the source page outside of filemap_invalidate_l=
ock()
> seems pretty straightforward, and would provide consistent ABI for all ve=
ndor

Will relying on standard KVM -> guest_memfd interaction i.e.
simulating a second stage fault to get the right target address work
for all vendors i.e. CCA/SNP/TDX? If so, we might not have to maintain
this out of band path of kvm_gmem_populate.

> flavors.  E.g. as is, non-struct-page memory will work for SNP, but not T=
DX.  The
> obvious downside is that struct-page becomes a requirement for SNP, but t=
hat
>

Maybe you had more thought here?

