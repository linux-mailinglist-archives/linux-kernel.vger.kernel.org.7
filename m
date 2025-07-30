Return-Path: <linux-kernel+bounces-750905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549FAB1628B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1D8164AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210352D9794;
	Wed, 30 Jul 2025 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VmW6n4Ue"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0591F187554
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885219; cv=none; b=PHVswChzGdIyNsW72vwyBlRvE4ftgl9HALBIt8uc1FB/MrTV++VwIDZUwzvPfttGgN53vySF8wxMEKAkbjcwUtsz22NnE6F4jBJ0Diw4iosjawqKBETnahKlJ00R21ivm1JdIVHymjvqzw5B6ZpuQqQRwubC8wDh8qYgzmCl6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885219; c=relaxed/simple;
	bh=zbZ8zJ6FNNzVnMHRaX//DZkRQUevfKQvh7Gz3zKWny8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auF9P4eKGH9wzsu3p8bm2/RSMfBl09ITwn9v93oO7TfXWjdCVmrEK/RbvzqE+OIhE66k68Y4q8M097FSdFZrlyqaYXpaVuUxA7wydnYTeOD5dJgPzL+E9ypeu9z/DJudqVhPZC6FsFqThiI9mvrftVc5JdLHKz0w+v5UIHBFwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VmW6n4Ue; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-240718d5920so201425ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753885217; x=1754490017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5+kEdkXghppyQYetmPBQ6sqq9QmR3md7y7HiaGpJ0I=;
        b=VmW6n4UeXMci5ovMEVQwhWyl5xnCpM7Lv/LaJTLJmmHipCgQCHS42yIALS66dV5un0
         lVta1hj2fVzRWhXZ0vYk5w9Zw92EGDs7xA92pGSAFwqajgbnQqwtaA6A3Pn4oQb/i7yU
         l6uich3/CO5E4kOdBIpylGbeIBeRPC2hv+XNAjWKaac3vywdXy1+MJQYaz2DPHzDzTuz
         y06yOkO5jVXpWvCwNR25VdIJpJjqjQMwMM5r4WwNowNyf7bV8+eDEKr3G32NfydM/Hd6
         DxqpnHuRpd38PbtbEenY/BiHdLhgEBsDYQh37vOYdaqjXvQ30CIkp/ntm0FMCLVzFmQb
         +wKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753885217; x=1754490017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5+kEdkXghppyQYetmPBQ6sqq9QmR3md7y7HiaGpJ0I=;
        b=ZCxvnY6wkDXRZhEdxMJKHX422g9TIreUfVDsnxZoBWAWanDEQEAP9Jq9XS3vye/yVl
         w7JpXHj7xX66U1+bwKxkJElzKmbozhrtW9RVN3ZH5f3YNLg3Yi0oFYvrqHBqWMyhBrBr
         k+szioD471pB+CXXRjzgkehLucNnp69OwPNFzxPnDfJu4JSt7tBp7btnc/6zpWmBw+pt
         o8b0y6+OgMSkV9gCCalDSRT6ge8oLFSSVtJebh1LVWw9mhzMxplBTJyrBptrawRO1Kx5
         ShGnTd/mpEEb1+XEOFujtNCnAjWiwoP2nCu6y/XGmh3nnOErXsZ7jEF/ZEQtmkfHvcSA
         l3IA==
X-Forwarded-Encrypted: i=1; AJvYcCUpCp4s+YR+H+fQc3BK/xgUovSligC0+x5Jw37sd8BXjHiw7FGX1Ax9NISvgVlHiPwdrO6lEcuePVZ7MVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLpB6EgysmkFTFp3cABgIZ/KZQ7X95W1r4Ew9Qp2aVrmDXrD4C
	SfY6uifhUJK8uDWvK6hZ8EZ2dEwnl1JmF0xNLluYq58CiuO4rY8LEmdtLuig6L/9IemOdrp/TdH
	RDT6xtgXxkKEvubvmSdFSFRkXUp6SP6A2d6xrd71z
X-Gm-Gg: ASbGncsddRFrNBHKgm0paLg5EIQ6AGaz3rtYJZ91S+n6XdwshivOlKCAwVNsoel4B+L
	W8X5Gka3n1418WHYlqPrZax7YEM2HyAwzNvrPjGXIUKUG0uA4yVyNp/Wr31vr6kVxxfnS8FC/ee
	mc9x7J0Y9ytMrCdliLZRBA25U2b1U7I0Yb9YxIA48lEpEwno3bmJekI03euyEgYGLiccLECBLav
	iOS/A6PWTFtk4WBlSK5TjqZViTnZuvQAei6toVR
X-Google-Smtp-Source: AGHT+IGnjBrALMz00bhbW0eE2eYltdA4uM50iHZ54Y4zr/NCz2eT9UCef9cglvhlSULb7QAcPGQ6YPk3ZKf0ScENAHo=
X-Received: by 2002:a17:902:d50c:b0:237:e45b:4f45 with SMTP id
 d9443c01a7336-240a2210339mr3862855ad.1.1753885216823; Wed, 30 Jul 2025
 07:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618120806.113884-1-adrian.hunter@intel.com>
 <20250618120806.113884-2-adrian.hunter@intel.com> <487c5e63-07d3-41ad-bfc0-bda14b3c435e@intel.com>
 <ccee2a0f-18fa-4037-bf97-f359e0791bf6@intel.com> <d443db90-ced5-43d0-9f85-ad436e445c3a@intel.com>
 <9a4752a4-e783-4f03-babf-23c31cee4ff9@intel.com> <SJ1PR11MB60836014330204B2FBCC7418FC45A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <79eca29a-8ba4-4ad9-b2e0-54d8e668f731@intel.com> <807ff02d-7af0-419d-8d14-a4d6c5d5420d@intel.com>
In-Reply-To: <807ff02d-7af0-419d-8d14-a4d6c5d5420d@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 30 Jul 2025 07:20:04 -0700
X-Gm-Features: Ac12FXx-NEErOwD5zsvgMenGyME20wGkcAEBJZMWnCCssNMO3qRavJ35mIpH_0w
Message-ID: <CAGtprH9SpjSnR-u-AH+t6BB+0pzHbgLTUv0pu+dkYR=ZzEYicA@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/mce: Fix missing address mask in recovery for
 errors in TDX/SEAM non-root mode
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "Luck, Tony" <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	H Peter Anvin <hpa@zytor.com>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "Huang, Kai" <kai.huang@intel.com>, 
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, 
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "Gao, Chao" <chao.gao@intel.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 3:55=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 27/06/2025 19:33, Dave Hansen wrote:
> > On 6/27/25 09:24, Luck, Tony wrote:
> >> We've been sending a combined key+address in the "mce->addr" to
> >> user space for a while. Has anyone built infrastructure on top of that=
?
> >
> > I'm not sure they can do anything useful with an address that has the
> > KeyID in the first place. The partitioning scheme is in an MSR, so
> > they'd need to be doing silly gymnastics to even decode the address.
> >
> > Userspace can deal with the KeyID not being in the address. It's been
> > the default for ages. So, if we take it back out, I'd expect it fixes
> > more things than it breaks.
> >
> > So, yeah, we should carefully consider it. But it still 100% looks like
> > the right thing to me to detangle the KeyID and physical address in the=
 ABI.
>
> Coming back to this after a bit of a break.
>
> It feels unlikely to me that any users are expecting KeyID in mce->addr.
>
> Looking at user space programs like mcelog and rasdaemon, gives the
> impression that mce->addr contains only an address.
>
> The UAPI header file describes addr as "Bank's MCi_ADDR MSR", but what
> mce_read_aux() does tends to contradict that, especially for AMD
> SMCA.
>
> But there are also additional places where it seems like MCI_ADDR_PHYSADD=
R
> is missing:
>
>         tdx_dump_mce_info()
>                 paddr_is_tdx_private()
>                         __seamcall_ret(TDH_PHYMEM_PAGE_RDMD, &args)
>                                 TDH_PHYMEM_PAGE_RDMD expects KeyID bits t=
o be zero
>
>         skx_mce_output_error()
>                 edac_mc_handle_error()
>                         expects page_frame_number, so without KeyID
>
> The KeyID is probably only useful for potentially identifying the TD, but
> given that the TD incurs a FATAL error, that may be obvious anyway.
>
> So removing the KeyID from mce->addr looks like the right thing to do.
>
> Note AFAICT there are 3 kernel APIs that deal with the MCE address:
>
>         Device /dev/mcelog which outputs struct mce
>         Tracepoint mce:mce_record which outputs members from struct mce
>         Tracepoint ras:mc_event where the kernel constructs the address
>         from page_frame_number implying that KeyID should not be present
>
> I guess it would be sensible to ask what customers think.
>
> Vishal, do you know anyone at Google who deals with handling machine
> check information, and who might have an opinion on this?
>

I think it's safe to assume Google hasn't built any infra in the
userspace that needs KeyID bits in the mce address. That being said,
Dave's suggestion to "detangle the KeyID and physical address in the
ABI" makes sense to me.

