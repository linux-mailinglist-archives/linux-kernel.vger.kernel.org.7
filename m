Return-Path: <linux-kernel+bounces-737124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 328E0B0A806
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47141C41CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA272E5B18;
	Fri, 18 Jul 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N8jsL1WH"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6929B8C2
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752854244; cv=none; b=qoAD7bGxQYYEcxqnk+PPJMx0q4fVNUnqCyoLGIk2baZUxJmZGC9gezYza86zwEEB5jGTjIkC79cVMvFQXUSb3iI5yP+3bGx5fl1qbxIL1hTPLPDwJYiRpxx+UrTLR+GKLWBLpyV0r5olQiF46vL0BELuA+dalX91GKNLF9Q0Vd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752854244; c=relaxed/simple;
	bh=gHGhnpTIs0SlK/0a8FDgsCBiZAOqX7pM8mcEaSxC8dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtetbprSfDyrNWoRIcsH2rnUOLxX4Yv9yn0caGBwbKV5ADyC3a+mhT0rdb2JuhE5EipjHuaoyVJ4jFmXeJrfz656W7bCSm99wAMGsxg7C2mmm0/exByKDkHwMtc3EAMAeUbI/ADZnlrE3hRr+NV6QeXPde13jtnjVQxzKUe+AcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N8jsL1WH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235e389599fso260405ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752854243; x=1753459043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8OwoX5mxh6UvTDR1Yv1NAz1aJQ0CYYYwNtDjaEd3rs=;
        b=N8jsL1WHZBxFJbQrjjFMXLJg9u1hpdAaHO+l1ztZHn27fp5C4OsW5Fa5EyQlzXA1YT
         z6JaraXg2VkZajf8pVHuUCKNb754dJpttjFbUlRAUN8/0GIE1kmcX9czrEi7PrYunnK8
         oZ+Hi33NYKyTgFc4XxSL4ePF7HkLyKiER5yOXDdlsOyXvYm2R2ZikIcusAU8G89Ry8+T
         JjoE41SUcj1NRQtKhzj/h/GuZT2qaatusf9MDPf3SFa2QqCdBPbZygsH0J0wjIzRTWvD
         Iv2wQu6RjzYjIbAECIaIVoPN6WA48jbanHpcPvWgZvuijyvrPlFzjMccxN+Xy8892MWy
         RqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752854243; x=1753459043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8OwoX5mxh6UvTDR1Yv1NAz1aJQ0CYYYwNtDjaEd3rs=;
        b=F8YIsDcHrzlvDl1y6Z2P4WFrGtBvGASpgueL8YXFBXwoIj2Am5Mc5curt6ZSz/LedH
         avKigiaZ85DGz4iVGeFE+Wih9DJNtlRYTsyPnqwAol5ChZQFZTxhnnu2q0yfuq9j+rMf
         Rhf1/k/rmSVRsIr8ICTbzahAIGwaLgpWJWnGyM4AN9Xux+ixdcI1csnXvdSPdtJKq5yO
         ujqJTkUkBUSCppIDelKXiMDBCw+UVLy9uynp4YjiKhSYFu97VqdMf7yRAJOND5DV8MGQ
         pATLt6K6yVYMdPc0XCIKTXVB0rS76WvBVawX3W5OGLNWEnuf7xMxELIOChm3Ti4w3+Un
         Luvg==
X-Forwarded-Encrypted: i=1; AJvYcCVIIhahh++yl9NNUiuJWC66HjxLhoWUJe6sBbmeZF8IuDPg5eyzj47zf98ds2bZ8Od8MRuOal3RZ936mEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjzeJ8CqinLJoRvLv/HvLjSWPckBI+Yk8TmhJd2XW+itGQdRU6
	geFk3mSfMaGIPkF2QwKvn0WEaBzot7zwNHdz/hGrF1xdinqA3jTv2tGIX529eOpVdKAVh8SAqWg
	mCZIinZiYCeJE4F7kqJGucgG931I4mHs8HxIEkZYErqWhJ2FecijxhuI9NiQ=
X-Gm-Gg: ASbGncslv9AmjcjS1KNVhDl4+mlWoNkJ+MRcDWSuQPey2GB6SG4qc5zDhqv7FpWAUkx
	nnnlc7c9tI6ZVN13BXIsAfr/3Mrk2TTsxjVRM5tvDaHItU9yB7gd8wEQdXP43pvguEk3PCgxYHo
	xM7lhmmln9q0W7VgR2YxElMmLnEtXbujmE5+Z1QGjVLdeMPkV1g2LEox4HvzJETjtmPPIV1Dpkm
	mas5M2p8OHyoruJl594bhPFMvWpgYDzK24mxanDLUqOa3MGRSM=
X-Google-Smtp-Source: AGHT+IFgi72u+XAyFB7UNUnQ78KCwwZ31ziMPnV0eIv4PjDoKng8evgPNW6wi8hbBTzsrhbCEYntoxga6S5rFlzzpxo=
X-Received: by 2002:a17:903:1986:b0:234:afcf:d9e8 with SMTP id
 d9443c01a7336-23e39284266mr4452875ad.7.1752854242330; Fri, 18 Jul 2025
 08:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703062641.3247-1-yan.y.zhao@intel.com> <20250709232103.zwmufocd3l7sqk7y@amd.com>
 <aG_pLUlHdYIZ2luh@google.com> <aHCUyKJ4I4BQnfFP@yzhao56-desk>
 <20250711151719.goee7eqti4xyhsqr@amd.com> <aHEwT4X0RcfZzHlt@google.com>
 <aHSgdEJpY/JF+a1f@yzhao56-desk> <aHUmcxuh0a6WfiVr@google.com>
 <aHWqkodwIDZZOtX8@yzhao56-desk> <aHoQa4dBSi877f1a@yzhao56-desk.sh.intel.com>
In-Reply-To: <aHoQa4dBSi877f1a@yzhao56-desk.sh.intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 18 Jul 2025 08:57:10 -0700
X-Gm-Features: Ac12FXzIuH1z9pcRagA9yRiVXAqCitoCmPwRxtP18wjCrYHSx6XUN_jtcMtJrnI
Message-ID: <CAGtprH9kwV1RCu9j6LqToa5M97_aidGN2Lc2XveQdeR799SK6A@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: TDX: Decouple TDX init mem region from kvm_gmem_populate()
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com, 
	kai.huang@intel.com, adrian.hunter@intel.com, reinette.chatre@intel.com, 
	xiaoyao.li@intel.com, tony.lindgren@intel.com, binbin.wu@linux.intel.com, 
	dmatlack@google.com, isaku.yamahata@intel.com, ira.weiny@intel.com, 
	david@redhat.com, ackerleytng@google.com, tabba@google.com, 
	chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 2:15=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wro=
te:
>
> On Tue, Jul 15, 2025 at 09:10:42AM +0800, Yan Zhao wrote:
> > On Mon, Jul 14, 2025 at 08:46:59AM -0700, Sean Christopherson wrote:
> > > > >         folio =3D __kvm_gmem_get_pfn(file, slot, index, &pfn, &is=
_prepared, &max_order);
> > > > If max_order > 0 is returned, the next invocation of __kvm_gmem_pop=
ulate() for
> > > > GFN+1 will return is_prepared =3D=3D true.
> > >
> > > I don't see any reason to try and make the current code truly work wi=
th hugepages.
> > > Unless I've misundertood where we stand, the correctness of hugepage =
support is
> > Hmm. I thought your stand was to address the AB-BA lock issue which wil=
l be
> > introduced by huge pages, so you moved the get_user_pages() from vendor=
 code to
> > the common code in guest_memfd :)
> >
> > > going to depend heavily on the implementation for preparedness.  I.e.=
 trying to
> > > make this all work with per-folio granulartiy just isn't possible, no=
?
> > Ah. I understand now. You mean the right implementation of __kvm_gmem_g=
et_pfn()
> > should return is_prepared at 4KB granularity rather than per-folio gran=
ularity.
> >
> > So, huge pages still has dependency on the implementation for preparedn=
ess.
> Looks with [3], is_prepared will not be checked in kvm_gmem_populate().
>
> > Will you post code [1][2] to fix non-hugepages first? Or can I pull the=
m to use
> > as prerequisites for TDX huge page v2?
> So, maybe I can use [1][2][3] as the base.
>
> > [1] https://lore.kernel.org/all/aG_pLUlHdYIZ2luh@google.com/
> > [2] https://lore.kernel.org/all/aHEwT4X0RcfZzHlt@google.com/

IMO, unless there is any objection to [1], it's un-necessary to
maintain kvm_gmem_populate for any arch (even for SNP). All the
initial memory population logic needs is the stable pfn for a given
gfn, which ideally should be available using the standard mechanisms
such as EPT/NPT page table walk within a read KVM mmu lock (This patch
already demonstrates it to be working).

It will be hard to clean-up this logic once we have all the
architectures using this path.

[1] https://lore.kernel.org/lkml/CAGtprH8+x5Z=3DtPz=3DNcrQM6Dor2AYBu3jiZdo+=
Lg4NqAk0pUJ3w@mail.gmail.com/

> [3] https://lore.kernel.org/lkml/20250613005400.3694904-2-michael.roth@am=
d.com,

