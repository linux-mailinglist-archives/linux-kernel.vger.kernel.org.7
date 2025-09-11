Return-Path: <linux-kernel+bounces-812553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE8CB539A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9A31CC190C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20121356915;
	Thu, 11 Sep 2025 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqxNHJ03"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C12B2877DC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609507; cv=none; b=rXh6XvK8soWsQXcHg2RhLmI7XweNZyMEQqnrPH2G8ZzoncXOMzswSXJTM9H/35TnaW6EFdi+y5p0fY/Dcxx0Xtj8yaLgjA1qZeTtZ9v3F9sJbsxuQZZYld3Q+iGPoKOBdsckmYYgFO2W80U+7ICf2WDD/zYDRVj66oABlbMvXVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609507; c=relaxed/simple;
	bh=zXhDABtx2g0qqVQ7wQo3OdGZr+hjq25GnG8pc4KCMI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hetAMijt87nUxGI4OC4ra2SOwH7HZfGoEg9M3X4h/mmBJZ+rKJHqcSvg+ALVmmT9bK+3NKgr8Z0w1Q1Jt0ntd3My3Rs7QkgoW7pslo3k55/KI0Guo1WkXN1oe/6Ozc/9akUHbnFBJgaEhDR11AR0V7wNTRden+w3Tp3x0bzx2Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eqxNHJ03; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b48fc1d998so5281cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757609505; x=1758214305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M56OV+DCbPOvXLXatH4lyJjMsHmjtzZ/ztacBy9y41M=;
        b=eqxNHJ03whYWFvVKXzZvHdAzJyhqQAGVLxBylfbsuuh8/BC+o0401lbjjxmjCsJQmY
         ZJzFRbsCmeitTOF1/9FM4oECDtStJWHg1YlhvYISgyKcUD3CXMtB3lHbSSogJfXgfPva
         usNROsmBDHO9lQqt9GKtJb6Xy6OS4xtxgTw2NcSBLHDIWcwSoMCdqwRzmQfCjXxQTB5Y
         Gx04Ftyv+NIFNBYegLQvTi6JuqIlrOX5l2hQE/MAf4uBA8mkkc5Nkbii9IRHXvohS8q2
         o/HhQ+FbaUhWGNZiBYaZfaF4/JB2FMpRR53URBquhwd0OJ3UbK4L35QbST99miG82GvV
         /G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757609505; x=1758214305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M56OV+DCbPOvXLXatH4lyJjMsHmjtzZ/ztacBy9y41M=;
        b=i2aByqUAlMhczosox3UW1K/F0YHqPONgGVEu070dhnow+2saJWQDoJ/XOmxT/ElkXU
         YeCNnb1rA0+NMv0JrHs42ZMAuXR8Bf+xzBDzM5MXOy3Pu/9dacotCdV/W96y3hPVLEsB
         N5si4viz+8a7CzmRyICQPbfTEBjVXvAF41hFKz2CFq3OlKpwgdYxMwUk7jHC5vu/cyWe
         peBMCglwG0SMpxjhqyI1cXn8uPbVlTKx5Hz88rFccXdoGzZgSk5pTJTyoOgLvOraZ7bu
         U2gb/oRtVYPhpaNMA013P44n68J4NsOH88Lv6MvbpThbPXWXPkLq2MfRH6pWCIM+ZzFA
         pLyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnrirFjk1T1F1bKUkba4lAeXiL82g1lM2P3Ksb+1WJ/ifj7nCWs0imsNOmjagJGjf+IW1zAEhxf5oY6oM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo5Zf1/nbb99bEWJLdZRRHZqi0LBx4Q8AKGNpF2qMe1XjMPuz4
	gtuXHI5LU+ZgruniVMzuJuPp71UDHUpX9VG4D+sq+Ej/+UP15doqSVUOV/2U36MY3NtDQcJ1FFj
	yfnuY1EjXXHESWoWLeaY5fCt0bNnin6qtEvbHE1fS
X-Gm-Gg: ASbGnctahYk5QQtdRoMtMLxAp1ZV+D/MR2OGmuCRvHkcnq5s9yOI4cu0leIfiF8U+tC
	l6SMQzcy0siGxsxk/gU3a9ldurp1gGYHj7puez9CQbAriiCkM5OSpIBERZ2CT+en0/rQTvowjqf
	qnsiCL4uQh0DBLefj5TTKgFdBk7cHkCXjRTtDjD+bQxyBxM/MoAk9aDit+mUF4gmixs5Y4GHfHR
	iPXEZ9zwVayqTxDltyaMOU4wbNruvjAdAgNc1QlX83G2rXJvjI3rSI=
X-Google-Smtp-Source: AGHT+IE+bObvDrZuyNPMo3PXWKyy8l5K3qtIDPqLnf9byW1C3+RMAG6A1j1o4bWTifLLF8jRBy/MYjGCUIpfRUBT0ug=
X-Received: by 2002:ac8:5e13:0:b0:4b5:e600:3d6a with SMTP id
 d75a77b69052e-4b625201ec7mr16575921cf.12.1757609504431; Thu, 11 Sep 2025
 09:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
 <20250909190945.1030905-8-Liam.Howlett@oracle.com> <CAJuCfpG4D4ikZO1c8zN7HNgLTAco1ggk21rg9AUFwoztA95qSA@mail.gmail.com>
 <dfd8b8c6-d697-4032-be2a-569b9629c564@lucifer.local>
In-Reply-To: <dfd8b8c6-d697-4032-be2a-569b9629c564@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Sep 2025 09:51:33 -0700
X-Gm-Features: AS18NWBeIrwsUJ0dxrLNZRQOjzHmferGdajI1AcDlFbkpGG2ylvimaJ6frwN608
Message-ID: <CAJuCfpGFXbSFnqQtikNq0RoMfc93cLLnqrApq8211H+FpZpJ1Q@mail.gmail.com>
Subject: Re: [PATCH v1 7/9] mm: Introduce unmap_desc struct to reduce function arguments
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com, 
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, 
	chrisl@kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 2:22=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Sep 09, 2025 at 02:44:05PM -0700, Suren Baghdasaryan wrote:
> > On Tue, Sep 9, 2025 at 12:11=E2=80=AFPM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > > +struct unmap_desc {
> > > +       struct  ma_state *mas;        /* the maple state point to the=
 first vma */
> > > +       struct vm_area_struct *first; /* The first vma */
> > > +       unsigned long first_pgaddr;   /* The first pagetable address =
to free */
> > > +       unsigned long last_pgaddr;    /* The last pagetable address t=
o free */
> > > +       unsigned long vma_min;        /* The min vma address */
> > > +       unsigned long vma_max;        /* The max vma address */
> > > +       unsigned long tree_max;       /* Maximum for the vma tree sea=
rch */
> > > +       unsigned long tree_reset;     /* Where to reset the vma tree =
walk */
> > > +       bool mm_wr_locked;            /* If the mmap write lock is he=
ld */
> > > +};
> > > +
> > > +#define UNMAP_REGION(name, _vmi, _vma, _vma_min, _vma_max, _prev, _n=
ext)      \
> >
> > Maybe DEFINE_UNMAP_REGION() similar to DEFINE_PER_CPU() or DEFINE_SPINL=
OCK()?
>
> Look at MMAP_STATE(), VMG_MMAP_STATE() for precedent in vma.c

Yeah but UNMAP_REGION() sounds like an action while MMAP_STATE(),
VMG_MMAP_STATE() do not. Anyway, whatever works I guess.

