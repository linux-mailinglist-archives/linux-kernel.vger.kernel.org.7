Return-Path: <linux-kernel+bounces-835155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65073BA6660
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086A517AECE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 02:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE1A248F40;
	Sun, 28 Sep 2025 02:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIoxK1wJ"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7B61E32D3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 02:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759026972; cv=none; b=BIPN5asWE1L33IppdKCpQekfBj8xlt/J8WZ4aqtjfNfSX2/u00CEC8hbBwltYsEx2Rw/CAWQUhENmLEbgy5eTcYSlRLwKGLg+luCvMy1afCNmmr99/CIA0ZczgTSi0mef9r8YXPLLbdJaHg/9hgm46gvtZhl1ys/NC/HBJUqoCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759026972; c=relaxed/simple;
	bh=4Fv1wYXHyeXTflKUE70KCKGjjd7Db6HeOyzZQXwDdfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7dXmsLtonmeXySddgc1tUhV7bkmAU4TdDxbFSNLQn4YiHY9ckvfz/jxx46IVS3AG80JmE6WX09Erfg9dDWyFETZLzLIOhK77ZAj6gxbpa5/lbR/lWgoBYrpmqCpHz6HKr8FqotscragmgsxQNfeYvTm82u5cIs4pE3S5T3C61g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIoxK1wJ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-85a4ceb4c3dso375277585a.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 19:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759026970; x=1759631770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gaDCzK/mppvE+TbZ3WPtXIvdSdoczZCrzHaCPLwFrU=;
        b=gIoxK1wJhedRgw3h6p6oMv6y8LgAS8F/yK77fdRPWum+mC51T8pKObNaDcEl6AFR4d
         TfKqSpJO+gvS5UaHqVa31CQPi0zGNsZCZeBLxvOpfgfoaaGISJzodrzONr43EbOMmVdp
         5mvdHtQ+X4PJOmo2O9WSwP4XKV3TTsPhY1UIuYMce7/NmWcAJYlI9dOC3zZg5tc3TgMf
         y1TnsMbPkyAFrcatK+LYtRrrBvVosVnKIkVv1niSbSUO3Jbqbg2IfzdPDFrbqS4aCg5L
         kAdJ/VDGKuq12Ul+NFKTiH7+wNW+boserU+Rdel3zgw2Ht/GGpZ30GCosycmYkFIznw0
         kdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759026970; x=1759631770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gaDCzK/mppvE+TbZ3WPtXIvdSdoczZCrzHaCPLwFrU=;
        b=Q26xI6UOUsrX/e+qo0IppeNhKt/QDRc4KAPJmwT+h1vAMAPIRQUuA6+5QQj0hgpQP/
         za7WiYldsMa+h5cW3zAjcctrHjTpYUSUyeq40IgNn1N600SjSXK5dUd8h+Y76Ym9Dctp
         4esbfAK9JPKLVPBebIin7Npj06rA1IbT7d8QdKyxGXzsUuLuUb/QA8z254psgk7Xankf
         VFDf8rTt2DKDBVrK/7xyQApF815DoX13AQ6hhSX+mglvr8Hp//0f5Kh+YhKkvelTg3XU
         PvFiG4fr6YQjQjyAakbL4YEcGo0dJYkGJzdHXN4KKY8cfG9sItTZXt7O5goWUqSiueI1
         Tv1w==
X-Forwarded-Encrypted: i=1; AJvYcCUL4yeePGoGJEqmHxzp9IuhUibQwgC9vvKBPzFeSeuiB2xNluNo7XVUPjC3QUxFcIDuSkws8JrgNWGhrIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+/5i/CErnkFezp6nzbo053w0EoljhYY43E/6hzcWxVrN39zX
	wzsYStSLEMjh0Ed40SqhygwzsM7hXLLKOXe8+h8WEecnB429SDkkG0unNrp/wH2pxONGfBJvbo8
	nUVQtB2S4eVTibZYSl9wklcx4S9dIoGM=
X-Gm-Gg: ASbGncsbrq3G9329xGDFAnoTXqwcM/jr4yCcu+OrJAT1AN3QnjoKSOymcYkphfZjGvU
	HUQvfHgF4cCOmQ8lYWvz1Hz11m4GQuGlVHPFoDHd2/Qrpy/aZGWd1SQqdz5fjHPIw6Crt5lVMkp
	FoDmdgODbZmG6wYYszzgImiTtsrpTGKgM5nBsY6tA1/Zw8Tm3n+i9gzrmU9m/bpihRbjHaCWhQo
	ihacOqagXUaSMhKKaQX2TUmhCsZaFCyE011H4myK9A9qvg0xH0=
X-Google-Smtp-Source: AGHT+IEzrIRNkapYZtuzG9WFj/jlawGAcqNjlZSzbgOX3dCv7E2T+yBJS3MoM5SUVq717wHU1xry8WXSW8zEZoWw0ng=
X-Received: by 2002:a05:6214:d09:b0:82d:f77f:28c3 with SMTP id
 6a1803df08f44-82df77f34ebmr78705576d6.30.1759026969739; Sat, 27 Sep 2025
 19:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926093343.1000-1-laoar.shao@gmail.com> <20250926093343.1000-3-laoar.shao@gmail.com>
 <146b95bd-e0f0-4e6b-a9fa-5a8f11355268@gmail.com>
In-Reply-To: <146b95bd-e0f0-4e6b-a9fa-5a8f11355268@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 28 Sep 2025 10:35:33 +0800
X-Gm-Features: AS18NWBmL8y2V1x6RK8Hi5Yh_Mzxczyqhv8V1kW5X07v9F-7y38eCcLmLbTOSok
Message-ID: <CALOAHbAGPZX+V4CBRyGhHtQ2mVFJWD4CUX+9Fujp-JAiK426Xg@mail.gmail.com>
Subject: Re: [PATCH v8 mm-new 02/12] mm: thp: remove vm_flags parameter from khugepaged_enter_vma()
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, tj@kernel.org, lance.yang@linux.dev, 
	bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 10:50=E2=80=AFPM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 26/09/2025 10:33, Yafang Shao wrote:
> > The khugepaged_enter_vma() function requires handling in two specific
> > scenarios:
> > 1. New VMA creation
> >   When a new VMA is created, if vma->vm_mm is not present in
> >   khugepaged_mm_slot, it must be added. In this case,
> >   khugepaged_enter_vma() is called after vma->vm_flags have been set,
> >   allowing direct use of the VMA's flags.
> > 2. VMA flag modification
> >   When vma->vm_flags are modified (particularly when VM_HUGEPAGE is set=
),
> >   the system must recheck whether to add vma->vm_mm to khugepaged_mm_sl=
ot.
> >   Currently, khugepaged_enter_vma() is called before the flag update, s=
o
> >   the call must be relocated to occur after vma->vm_flags have been set=
.
> >
> > Additionally, khugepaged_enter_vma() is invoked in other contexts, such=
 as
> > during VMA merging. However, these calls are unnecessary because the
> > existing VMA already ensures that vma->vm_mm is registered in
> > khugepaged_mm_slot. While removing these redundant calls represents a
> > potential optimization, that change should be addressed separately.
> > Because VMA merging only occurs when the vm_flags of both VMAs are
> > identical (excluding special flags like VM_SOFTDIRTY), we can safely us=
e
> > target->vm_flags instead.
> >
>
> The patch looks good to me, but if we are sure that khugepaged_enter_vma
> is not needed in VMA merging case,

Calling khugepaged_enter_vma() is unnecessary during VMA merging
because it's already handled: for non-anonymous VMAs, it's called upon
creation, and for anonymous VMAs, it's handled at page fault.

> we should remove it in this patch itself.

I'd prefer to handle this cleanup separately. The goal is to keep the
THP changes minimal, even though I've already made significant
modifications ;-)

> If the reason we are removing what flags are being considered when callin=
g
> khugepaged_enter_vma in VMA merging case is because the calls are unneces=
sary,

Actually, the rationale is that the flags can be removed because:

 Because VMA merging only occurs when the vm_flags of both VMAs are
 identical (excluding special flags like VM_SOFTDIRTY), we can safely use
 target->vm_flags instead.

I will update the commit log to clarify this point.

> then we should just remove the calls and not modify them
> (if its safe and functionally correct :))


--=20
Regards
Yafang

