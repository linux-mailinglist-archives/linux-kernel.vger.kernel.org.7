Return-Path: <linux-kernel+bounces-780185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 412B3B2FEA6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D9E1D21EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70603376AE;
	Thu, 21 Aug 2025 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcyS3MDc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC1270553
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790071; cv=none; b=VWqvy+6yTYsaOyVbYNoDe1b2mEm5AIVJdYtCSHHulN8ZhB5G+KAfwYliqr73mNpIWhYxkUlZQaj0nuBwuo9nhcVYUZymjzNwyvTb2AnCF4vPOXIq1CYT3DZbL8wcK972VEEDXl/4AWAW0RAv6TUGA+khGTsQ4auLPPyQ/HzmKkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790071; c=relaxed/simple;
	bh=Eyf6DeidULNnQGCkA+/IU+Rn3dkvyFy2QYD+Ym0aiIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Usw7A5j5VRuRtNK4Krf3z3j7dMv5oUxgAw1p/etVvOJN7BT8636TWxtSU73saRq3mGXF66TRMORqzkindoP6vrQTiLaV7G/uiFMr1HOjc4aSlVPacsk3CzRSN+yc6XukDVUN+C36ka5CH8POPGP9KzbYyIKzJ7XcuFM3hrsapWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcyS3MDc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755790068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTgtJ49Xu9MWkFK2EAlVwrx17FYOOV7VldaM8h9Pwt4=;
	b=fcyS3MDcH86b/VIUXvtM3XwWEKEJtJghTkZongf1nUoF8JtqRbIRrkJYKoBKDsuQ+vgrMg
	vDxZiqDsDeHOJgwQKOvoWd2shRSsC/o9zPOs2CdwMR6OHjnsn+6QOayomOtdy2sF6Khr1Z
	bnBcmZyY0IaMi867FXSQW0XzgA+Ay0Y=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-ajmlJ2OcNdOCVUas3YAIpw-1; Thu, 21 Aug 2025 11:27:47 -0400
X-MC-Unique: ajmlJ2OcNdOCVUas3YAIpw-1
X-Mimecast-MFC-AGG-ID: ajmlJ2OcNdOCVUas3YAIpw_1755790066
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-71fbb9572fdso15620957b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755790066; x=1756394866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTgtJ49Xu9MWkFK2EAlVwrx17FYOOV7VldaM8h9Pwt4=;
        b=saCAOHgY+EncJDEej4bFxhSnPs/M0bcqRM0NSVhHgFiMaaklfvEysWOXXimYfy6vhy
         jNPYpi3+9xmsjoUnqqpn7qA+zNQMfpQp6k1lvo0HoOOUT1sbHqqk6tU0Tgce91vaAWU2
         96ne01cOvmVrUuDDzu0FgJzOFg+0AeoUKllcE39Xi+4YY4zRi4wUWWOon4XqRAR5A2kh
         R1R+o12XlwpVKZogo5dbuPXjra/fsGdZTKrEQw1y9/YkaxXvnIGEyA2IvqBhrpEQxUpJ
         Rs+3nXotTASeapbprnYEubM9VL3YGxLqvcn8mVThqA2xmAamf4hOt/+zPuIfpdPOTq8K
         9mPA==
X-Forwarded-Encrypted: i=1; AJvYcCVFK1AIRfJv18fruNt/LGrHglF5oB7QbZUCbAGjOmVk7q4+7eC/MDCRvP+R0VyA050oSI/nwwcvx1kJ0wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdDStDZFsWkA1+RVCb+TwpCIzSnRL5+ens8Fos3SGxsCFkenkQ
	eu8HI0/NtB7w/cWTEJaeONeyj/RzJx1+sXbX25erfISWbi5aEeTzli7XPUJDKhbg8ekHWwhmv+W
	Bd2svbNK7WWvnioHEhIeX0WUCSi+a0CDkHEiAST6mje8iFjQzj2Lun93swImxB77zll94fTdAjY
	xxT1P1YeikDlz7X56syxoC4MLLYycNg/E8B+vTPcTp
X-Gm-Gg: ASbGncsfaRGkcdoyXpXl9dsLSiS9tIKA1qRHGJaIvpo+BimfL96vh0/Z7JRvhyz2EIa
	7Xee49iPy/Up9gVnsPdASbHnVr042XgLToMkumNC70EcZjLSI3yhFt8FqCnW9Khb2bCMQqD+Y6y
	faXUnZv32GLBDQAcinwjvWzcs=
X-Received: by 2002:a05:690c:3606:b0:71f:c5f0:337b with SMTP id 00721157ae682-71fc88e8a3bmr32433217b3.1.1755790066394;
        Thu, 21 Aug 2025 08:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFc5TqILdLWzdl1VIfMGwn0VK5fkAbHYWIlUJd1eTuGNqYvohCQdcedJXpukc5CDWRWTZRM1EwqOto/rJviUU=
X-Received: by 2002:a05:690c:3606:b0:71f:c5f0:337b with SMTP id
 00721157ae682-71fc88e8a3bmr32432717b3.1.1755790065938; Thu, 21 Aug 2025
 08:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819134205.622806-1-npache@redhat.com> <e971c7e0-70f0-4ce0-b288-4b581e8c15d3@lucifer.local>
 <38b37195-28c8-4471-bd06-951083118efd@arm.com> <0d9c6088-536b-4d7a-8f75-9be5f0faa86f@lucifer.local>
 <CAA1CXcCqhFoGBvFK-ox2sJw7QHaFt+-Lw09BDYsAGKg4qc8nSw@mail.gmail.com>
In-Reply-To: <CAA1CXcCqhFoGBvFK-ox2sJw7QHaFt+-Lw09BDYsAGKg4qc8nSw@mail.gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 21 Aug 2025 09:27:19 -0600
X-Gm-Features: Ac12FXw32JsJSfHSBfYcPkLsEOjNfM5l-nBIkC40qTwdDNq4sNQAax1B3J0lGVw
Message-ID: <CAA1CXcAXTL811VJxqyL18CUw8FNek6ibPr6pKJ_7rfGn-ZU-1A@mail.gmail.com>
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, corbet@lwn.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org, 
	peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com, 
	sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:25=E2=80=AFAM Nico Pache <npache@redhat.com> wrot=
e:
>
> On Thu, Aug 21, 2025 at 9:20=E2=80=AFAM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Thu, Aug 21, 2025 at 08:43:18PM +0530, Dev Jain wrote:
> > >
> > > On 21/08/25 8:31 pm, Lorenzo Stoakes wrote:
> > > > OK so I noticed in patch 13/13 (!) where you change the documentati=
on that you
> > > > essentially state that the whole method used to determine the ratio=
 of PTEs to
> > > > collapse to mTHP is broken:
> > > >
> > > >     khugepaged uses max_ptes_none scaled to the order of the enable=
d
> > > >     mTHP size to determine collapses. When using mTHPs it's recomme=
nded
> > > >     to set max_ptes_none low-- ideally less than HPAGE_PMD_NR / 2 (=
255
> > > >     on 4k page size). This will prevent undesired "creep" behavior =
that
> > > >     leads to continuously collapsing to the largest mTHP size; when=
 we
> > > >     collapse, we are bringing in new non-zero pages that will, on a
> > > >     subsequent scan, cause the max_ptes_none check of the +1 order =
to
> > > >     always be satisfied. By limiting this to less than half the cur=
rent
> > > >     order, we make sure we don't cause this feedback
> > > >     loop. max_ptes_shared and max_ptes_swap have no effect when
> > > >     collapsing to a mTHP, and mTHP collapse will fail on shared or
> > > >     swapped out pages.
> > > >
> > > > This seems to me to suggest that using
> > > > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none as som=
e means
> > > > of establishing a 'ratio' to do this calculation is fundamentally f=
lawed.
> > > >
> > > > So surely we ought to introduce a new sysfs tunable for this? Perha=
ps
> > > >
> > > > /sys/kernel/mm/transparent_hugepage/khugepaged/mthp_max_ptes_none_r=
atio
> > > >
> > > > Or something like this?
> > > >
> > > > It's already questionable that we are taking a value that is expres=
sed
> > > > essentially in terms of PTE entries per PMD and then use it implici=
tly to
> > > > determine the ratio for mTHP, but to then say 'oh but the default v=
alue is
> > > > known-broken' is just a blocker for the series in my opinion.
> > > >
> > > > This really has to be done a different way I think.
> > > >
> > > > Cheers, Lorenzo
> > >
> > > FWIW this was my version of the documentation patch:
> > > https://lore.kernel.org/all/20250211111326.14295-18-dev.jain@arm.com/
> > >
> > > The discussion about the creep problem started here:
> > > https://lore.kernel.org/all/7098654a-776d-413b-8aca-28f811620df7@arm.=
com/
> > >
> > > and the discussion continuing here:
> > > https://lore.kernel.org/all/37375ace-5601-4d6c-9dac-d1c8268698e9@redh=
at.com/
> > >
> > > ending with a summary I gave here:
> > > https://lore.kernel.org/all/8114d47b-b383-4d6e-ab65-a0e88b99c873@arm.=
com/
> > >
> > > This should help you with the context.
> > >
> > >
> >
> > Thanks and I"ll have a look, but this series is unmergeable with a brok=
en
> > default in
> > /sys/kernel/mm/transparent_hugepage/khugepaged/mthp_max_ptes_none_ratio
> > sorry.
> >
> > We need to have a new tunable as far as I can tell. I also find the use=
 of
> > this PMD-specific value as an arbitrary way of expressing a ratio prett=
y
> > gross.
> The first thing that comes to mind is that we can pin max_ptes_none to
> 255 if it exceeds 255. It's worth noting that the issue occurs only
> for adjacently enabled mTHP sizes.
>
> ie)
> if order!=3DHPAGE_PMD_ORDER && khugepaged_max_ptes_none > 255
>       temp_max_ptes_none =3D 255;
Oh and my second point, introducing a new tunable to control mTHP
collapse may become exceedingly complex from a tuning and code
management standpoint.
> >
> > Thanks, Lorenzo
> >


