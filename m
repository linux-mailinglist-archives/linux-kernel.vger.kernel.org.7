Return-Path: <linux-kernel+bounces-644565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A84A6AB3E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 18:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126668669F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C86254863;
	Mon, 12 May 2025 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZXUEKjQ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4512522B9
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068839; cv=none; b=LuWX/N29p7x/WxsMJgQ3RoqoG0U2IiLUmR9Un4wu+hJzGt/JpbaRJ+kmuASwI12ZHJ8k5FBqdRkkBbQp0Tx2LXs6xoJYyeelmV+0qnKx+XJCytguVqVYHs9cELB+YD5HT0og18NMSE8cuiOwE3rn8ohekRMVqadH7r/DEprnIWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068839; c=relaxed/simple;
	bh=+7g8C9pigGg8HsLVGgE/yY/8hL62ZtMTebzLDdJrqQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtVebI9LqWsxazhOrGZNN+mZyLCAMm0w0CJcd1xe3xwLu1thS7vg26cBsfmEigTDkKVWG8cwWhDsDEbA/CrhKCabZT3SI8PAO2QJxLoZBr9aEUixOh2kyDVvmeoL23yjRxtUacAdbxFzh4Jt0CP64GrZadknnVFQskj4Gq66/2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZXUEKjQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22e39fbad5fso7685ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 09:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747068837; x=1747673637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wFf0hJ9R+brtsQBQCeNTypwNssDSYUtK88BdgqA/I4=;
        b=PZXUEKjQ5IxWlfIKCT+b7bBMJ/J6p0qeN+8hk7efAEE7bluh+t3b0SJC+m8xzaPWCF
         IyvXr9o08fBNSHkUNF2hLUQb2GN5LlN300ZL1LzHPnU3vVkGKzJX0RyWxukmiKRHLdxe
         d1CGlvWK5+R5BQ7BBh/O0dXjRq064LumbUSzfnbbpSuLS8bDmm8IAK7Qdk4Lq+uJoyDM
         4C/DmkFeToAXLmdy4MvROBc/tYbYYFpTetpJ9gy9rTQiFpJxRDlTFCio7LkIxpLDMjYK
         fSvNXkeygJREIxJhUN2gKVdRep0OLFOBatlS1XN0ab9VH0kuuAu/N0TjCCoqW+c+nPyh
         BoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747068837; x=1747673637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wFf0hJ9R+brtsQBQCeNTypwNssDSYUtK88BdgqA/I4=;
        b=SdVtJ+f3Vy0r2uMo+xhyrtWBGQiP47NjwaXW9vOn6gTN8OL3dpu3Ed0sRdmSkO+DlB
         3ddrgrE7k4s2jpXIERT4j8xT4u5hL80c5Hvi/J/fjsCS9j9gvxY/ILBbfgwaBz16tenQ
         KhvXC2drGqpkwK3BGtqtI0+DJwGyq6yZVTXWqstj066fF55hJJ2h8asivL9isjAxRK5Y
         Fth5JlB6Bg06673Ac01LRUxgOQrq6KT0IwCl6AAnF4LL1/s/p/BZmsbkSzKd7TuKtn2H
         r3rvNUEJziB28OvW5sQsumYsUMCcU748MHLu7PnCIjSB4kALPQBmQjf+vP4GV2+vOz4p
         DPdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlG0TQJ/DMBvP7suW3euNV0/zn8+1SRmyLZvDQPuN/ejGzFQ8aqeqdTJE02HX/Y6k3jxU1MUDRwCYP3Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtZyLkm66DsaUs72v6TLsp5UXmaoq1tj0UfuhBorwWu0tf7CAG
	ArglAPbdJ42BTbYqLx7BjyHFzz9wTfQ8IX9mQ3OgxwHCgEnzgDs5471IuPaYzMkh3WBUkd2sHN5
	vs/HpaXeJURm8QZY3qR95DcEJJ6aET5ZOO6KP
X-Gm-Gg: ASbGncvEs2Wv7HkcnGLhHkH6rJGIfgxNvWxB7z8B/NPXwM38hdNUMUjkIwna7Bcr8su
	Ph443vfmCJErNV1GrpRbHWC/XmbMUMAiLCJxzdA0LdplizVWQJ3jfxJPaYGTfvMAB+ggrTQ47Bd
	z3K6DyIkc5LTtqKrm0G0dxtNcFx/OEyGLMWu40sJsYvxIAts05pydMiFumpnWJ
X-Google-Smtp-Source: AGHT+IFGUkMo72XtIDtRZQxsg8iEIpPOalHrRQb2UF7dbfk05jKrnWFz19mVH5FaHif/YNRD3lIjfVB88vVhiMYfmvE=
X-Received: by 2002:a17:902:d48b:b0:215:9ab0:402 with SMTP id
 d9443c01a7336-22ff003c410mr4741835ad.18.1747068835998; Mon, 12 May 2025
 09:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aBldhnTK93+eKcMq@yzhao56-desk.sh.intel.com> <CAGtprH9wi6zHJ5JeuAnjZThMAzxxibJGo=XN1G1Nx8txZRg8_w@mail.gmail.com>
 <aBmmirBzOZfmMOJj@yzhao56-desk.sh.intel.com> <CAGtprH9fDMiuk3JGSS12M-wFoqRj+sjdtEHJFS_5QfKX7aGkRQ@mail.gmail.com>
 <aBsNsZsWuVl4uo0j@yzhao56-desk.sh.intel.com> <CAGtprH-+Bo4hFxL+THiMgF5V4imdVVb0OmRhx2Uc0eom9=3JPA@mail.gmail.com>
 <aBwJHE/zRDvV41fH@yzhao56-desk.sh.intel.com> <CAGtprH9hwj7BvSm4DgRkHmdPnmi-1-FMH5Z7xK1VBh=s4W8VYA@mail.gmail.com>
 <aB10gNcmsw0TSrqh@yzhao56-desk.sh.intel.com> <CAGtprH8=-70DU2e52OJe=w0HfuW5Zg6wGHV32FWD_hQzYBa=fA@mail.gmail.com>
 <aCFZ1V/T3DyJEVLu@yzhao56-desk.sh.intel.com>
In-Reply-To: <aCFZ1V/T3DyJEVLu@yzhao56-desk.sh.intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Mon, 12 May 2025 09:53:43 -0700
X-Gm-Features: AX0GCFueALu8dJdQCA5WbTVkWsnl6wrCmPn80alX3VDZ-GSW6LusKy119rLdREM
Message-ID: <CAGtprH8GfY2NjVM4=iVoWOenoexB1vs8=ALYTC-y7suf__+3iA@mail.gmail.com>
Subject: Re: [RFC PATCH 08/21] KVM: TDX: Increase/decrease folio ref for huge pages
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, x86@kernel.org, rick.p.edgecombe@intel.com, 
	dave.hansen@intel.com, kirill.shutemov@intel.com, tabba@google.com, 
	ackerleytng@google.com, quic_eberman@quicinc.com, michael.roth@amd.com, 
	david@redhat.com, vbabka@suse.cz, jroedel@suse.de, thomas.lendacky@amd.com, 
	pgonda@google.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, ira.weiny@intel.com, isaku.yamahata@intel.com, 
	xiaoyao.li@intel.com, binbin.wu@linux.intel.com, chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 7:18=E2=80=AFPM Yan Zhao <yan.y.zhao@intel.com> wro=
te:
> ...
> >
> > I might be wrongly throwing out some terminologies here then.
> > VM_PFNMAP flag can be set for memory backed by folios/page structs.
> > udmabuf seems to be working with pinned "folios" in the backend.
> >
> > The goal is to get to a stage where guest_memfd is backed by pfn
> > ranges unmanaged by kernel that guest_memfd owns and distributes to
> > userspace, KVM, IOMMU subject to shareability attributes. if the
> OK. So from point of the reset part of kernel, those pfns are not regarde=
d as
> memory.
>
> > shareability changes, the users will get notified and will have to
> > invalidate their mappings. guest_memfd will allow mmaping such ranges
> > with VM_PFNMAP flag set by default in the VMAs to indicate the need of
> > special handling/lack of page structs.
> My concern is a failable invalidation notifer may not be ideal.
> Instead of relying on ref counts (or other mechanisms) to determine wheth=
er to
> start shareabilitiy changes, with a failable invalidation notifier, some =
users
> may fail the invalidation and the shareability change, even after other u=
sers
> have successfully unmapped a range.

Even if one user fails to invalidate its mappings, I don't see a
reason to go ahead with shareability change. Shareability should not
change unless all existing users let go of their soon-to-be-invalid
view of memory.

>
> Auditing whether multiple users of shared memory correctly perform unmapp=
ing is
> harder than auditing reference counts.
>
> > private memory backed by page structs and use a special "filemap" to
> > map file offsets to these private memory ranges. This step will also
> > need similar contract with users -
> >    1) memory is pinned by guest_memfd
> >    2) users will get invalidation notifiers on shareability changes
> >
> > I am sure there is a lot of work here and many quirks to be addressed,
> > let's discuss this more with better context around. A few related RFC
> > series are planned to be posted in the near future.
> Ok. Thanks for your time and discussions :)
> ...

