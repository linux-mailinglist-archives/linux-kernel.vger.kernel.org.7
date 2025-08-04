Return-Path: <linux-kernel+bounces-754923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949D2B19E99
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70ED1798B1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0692417D9;
	Mon,  4 Aug 2025 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UC6sqRB/"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBED1E489
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298922; cv=none; b=EtpFtfdHsHyVFtEFIYo9vWyX+05eK0A+D4d8HSASBJ6H3Kj7LN7TBi1D/EwZxyItQScWRu9WXLuqOBNDzhHpkOpRRspI5Z6DFwCBBCHXa/DwvHD2BQpuX2l8JW3U2gGmQT0Eih6uwzd40W3twiVsQ8Sceys8xD/l9GXVBgB1BI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298922; c=relaxed/simple;
	bh=qFCaoHMm1VnEL10gVvLpdTFhZneV4lwru6bNk9ymWOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=as9cBKrSc3JwaFdIMnTkR5y6PY2MT0N0BBwzQa0V54fUhsM6FNShS02CpB4yVEWd41ab/b4XKdAmJp2Ps+4G02HUQBjE1PiG07w23eVb6GXXIW6pP9JorkehUf5kE393AKqGIslHbM3X4cKbOZ85CVSIB073iH82Et/4MFJLYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UC6sqRB/; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5397c00ad9eso134182e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754298920; x=1754903720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFCaoHMm1VnEL10gVvLpdTFhZneV4lwru6bNk9ymWOs=;
        b=UC6sqRB/nt2cEqYHusm/dY6EL6Thc0Umz5chbwtoprl945c3Uhg7qserkOhyi+3RE/
         cHktnRkWb0prGhKisbfTQk6r+7UaIQsrA4CtSfrTFD2OwLQ/7ZQ9RvgA4eOlmD+/2356
         YzXs2fenDXw/0UOYW1K/NQyhetgoo/vXWfaBWnnABlQShv3/twIEdMZqaf5tVbq0jGHG
         dgKhwBt6SPtLf+UOuSrUgtzeH+uHbJxli1dIKpkg1z1lf0DSAMvCSyM5nKwjckwFMylJ
         ORSDcXZp6jYnhcj1/NrXVjrCJejrgyk08q6COyuYQBXI/wo1kgDPDBAYbEVnTCkOwYYt
         DfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298920; x=1754903720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFCaoHMm1VnEL10gVvLpdTFhZneV4lwru6bNk9ymWOs=;
        b=L1HV9SYkjqoHQP43y9gP5qbG9fNwvaRWNRBawAzL5MC0kP92CfTN5gjZ/6nQPkXyen
         Ww/o80uIepM1JP89CsdpuKQWY9mFAceO1wSn8IGPsUD4uHdZ2a0Ex84Qh3WGtyvhEJVf
         2RLZiN6TwDSffGTU0oRAWr5et7kzMhqNlnnQLvOQEgPaIeHAkTcguAA/7x7nJmNwahNl
         8TlxIb7WSpf+6NIFXXkeEmQxEhAJR/NCxS2E8nk873lACwask6ah9Fd1jjXzVtQkyexl
         OGaPI0fgmD1bDRbBJHBFgkvgl+EL19j+Ls43c35gbLcNiX1jg8PdKe8m8sW7cWlGutAc
         NPRA==
X-Forwarded-Encrypted: i=1; AJvYcCXA5U7aQ+BdVHErgmDFIHf4rDjXNem8i3beX5cysk6B0h7WTPHvjiWu8VDm5rPcW8+km5PRiHjaJxUBs+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1NG38tAwTDy+0X/DTqZVcTLPr3idYwVj5UgQ6spbVev6No33y
	Hrz3Qv+S5h8x4fsO817vCNjSBrhU+pZW1E4+ipCEh5RnqGLC1OpABhD5Gkl9sRNaewCYW2pSecr
	g3EyDiGDmSonDMu4tE6Ui5a5dkDRyMS0=
X-Gm-Gg: ASbGnctpBJvcccCIWQsuRkPTl6i1cv0eXDjS08ewRoeTlIdARFTe/JRcywPNV5sGhyt
	4sVIEmJryHao9fO0etJhojQFOa1p9XFuwuxtQr+EQtYRUM2VCxWohi35sZhf07X1fwMyg188vcd
	i61ZBUIt04khkpVocsgdu/Ym+zZf+2xKage/T0O3KPJqbxyhrvUVDR1Yw3uqLVNSZNV4WD5QDyA
	TaiV9E=
X-Google-Smtp-Source: AGHT+IHydI6tDwWrpJjm9ELbGuWexGkYUn4GA18Pb/Ya3WOz9/wbanIAiL1QtWy60boNRaFhWPj5D1x1XXru/XojMOc=
X-Received: by 2002:a05:6102:2908:b0:4f1:7946:ed52 with SMTP id
 ada2fe7eead31-4fdc25487f8mr2740340137.12.1754298919609; Mon, 04 Aug 2025
 02:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607220150.2980-1-21cnbao@gmail.com> <aJAFrYfyzGpbm+0m@ly-workstation>
 <1d1d97f9-2a67-4920-850e-accf4c82440e@redhat.com> <4fa8f492-c7ef-451c-8dc7-38b031c8a092@bytedance.com>
 <d9d0890e-2837-49dc-9ca8-1d6c28e95a21@redhat.com> <aJB0Kdc6cx1lGkdb@ly-workstation>
In-Reply-To: <aJB0Kdc6cx1lGkdb@ly-workstation>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 4 Aug 2025 21:15:07 +1200
X-Gm-Features: Ac12FXydsBD0TuZFpNyEUYcRbrcCg6kekPWWmL9gnPJlShdvwC4LshInjY3gdRQ
Message-ID: <CAGsJ_4yw4Qn7OWmUJeJZYuOHLjJ7L8kov3Th3vFPa3h4y0ur_A@mail.gmail.com>
Subject: Re: [PATCH v4] mm: use per_vma lock for MADV_DONTNEED
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	Tangquan Zheng <zhengtangquan@oppo.com>, yi1.lai@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 8:49=E2=80=AFPM Lai, Yi <yi1.lai@linux.intel.com> wr=
ote:
>
> On Mon, Aug 04, 2025 at 10:30:45AM +0200, David Hildenbrand wrote:
> > On 04.08.25 10:26, Qi Zheng wrote:
> > >
> > >
> > > On 8/4/25 3:57 PM, David Hildenbrand wrote:
> > > > On 04.08.25 02:58, Lai, Yi wrote:
> > > > > Hi Barry Song,
> > > > >
> > > > > Greetings!
> > > > >
> > > > > I used Syzkaller and found that there is general protection fault=
 in
> > > > > __pte_offset_map_lock in linux-next next-20250801.
> > > > >
> > > > > After bisection and the first bad commit is:
> > > > > "
> > > > > a6fde7add78d mm: use per_vma lock for MADV_DONTNEED
> > > > > "
> > > > >
> > > > > All detailed into can be found at:
> > > > > https://github.com/laifryiee/syzkaller_logs/tree/
> > > > > main/250803_193026___pte_offset_map_lock
> > > > > Syzkaller repro code:
> > > > > https://github.com/laifryiee/syzkaller_logs/tree/
> > > > > main/250803_193026___pte_offset_map_lock/repro.c
> > > > > Syzkaller repro syscall steps:
> > > > > https://github.com/laifryiee/syzkaller_logs/tree/
> > > > > main/250803_193026___pte_offset_map_lock/repro.prog
> > > > > Syzkaller report:
> > > > > https://github.com/laifryiee/syzkaller_logs/tree/
> > > > > main/250803_193026___pte_offset_map_lock/repro.report
> > > > > Kconfig(make olddefconfig):
> > > > > https://github.com/laifryiee/syzkaller_logs/tree/
> > > > > main/250803_193026___pte_offset_map_lock/kconfig_origin
> > > > > Bisect info:
> > > > > https://github.com/laifryiee/syzkaller_logs/tree/
> > > > > main/250803_193026___pte_offset_map_lock/bisect_info.log
> > > > > bzImage:
> > > > > https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/
> > > > > main/250803_193026___pte_offset_map_lock/bzImage_next-20250801
> > > > > Issue dmesg:
> > > > > https://github.com/laifryiee/syzkaller_logs/blob/
> > > > > main/250803_193026___pte_offset_map_lock/next-20250801_dmesg.log
> > > >
> > > > Skimming over the reproducer, we seem to have racing MADV_DONTNEED =
and
> > > > MADV_COLLAPSE on the same anon area, but the problem only shows up =
once
> > > > we tear down that MM.
> > > >
> > > > If I would have to guess, I'd assume it's related to PT_RECLAIM
> > > > reclaiming empty page tables during MADV_DONTNEED -- but the kconfi=
g
> > > > does not indicate that CONFIG_PT_RECLAIM was set.
> > >
> > > On the x86_64, if PT_RECLAIM is not manually disabled, PT_RECLAIM sho=
uld
> > > be enabled
> >
> > That's what I thought: but I was not able to spot it in the provided co=
nfig
> > [1].
> >
> > Or is that config *before* "make olfconfig"? confusing. I would want to=
 see
> > the actually used config.
> >
> >
> >
> My kernel compiling steps:
> 1. copy kconfig_origin to kernel_source_folder/.config
> 2. make olddefconfig
> 3. make bzImage -jx
>
> I have also uploaded the actual .config during compiling.
> [2] https://github.com/laifryiee/syzkaller_logs/blob/main/250803_193026__=
_pte_offset_map_lock/.config
> CONFIG_ARCH_SUPPORTS_PT_RECLAIM=3Dy
> CONFIG_PT_RECLAIM=3Dy

Thanks! I can reproduce the issue within one second.
After disabling PT_RECLAIM in .config, the issue disappears.
The reason it doesn't occur on arm64 is that x86 is the only platform
that supports ARCH_SUPPORTS_PT_RECLAIM.

>
> > [1] https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026=
___pte_offset_map_lock/kconfig_origin
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

Thanks
Barry

