Return-Path: <linux-kernel+bounces-755696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0749EB1AA84
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B294F188C37F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A001215055;
	Mon,  4 Aug 2025 21:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3gIuYzA"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C824634
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754344126; cv=none; b=eqDmWQCbO4IKZVaLYU08QBsgcozizOO6EW37fTXScII/hm0GSEw+yB5VSDTOe7mAgMsq4lQo3YMEDw08V5Li1Gl4Jx7WVjzQhH42E1iwXWXXzDUU9o7Y6DfR4/v6R5eUvDNwRhzsbbxqLRIjh/fHpVA13HiY2B0TH+xnfmsdlf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754344126; c=relaxed/simple;
	bh=kDC+e0x36v5yDL4hRYJaFAUN7zYjv9QTDdbWwhgVnG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhgDJilgKPyjGeeY2CX3aU62xqXEp8djyTvidb2OBdncUgm8fIzPrLz4R53Pt6+72bw8nAfn6mKNbZQ4lnnpMgwXBea98eFtmRYZlW2kDrrsobXsSs1VXft1HLgrFP3cnfRmD20Zwt+qK5kNhqz5wqIS9/1uP7lYsx8zKYFbOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3gIuYzA; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-88bc71ff9b0so1974363241.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 14:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754344124; x=1754948924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkVWykS6hCsn+sBU+xav7wxsK66ozGOyeXXP9ZKMhQY=;
        b=E3gIuYzAHACQFQO42UVgFWo5n3XDaffCMbVeViW2SGTwC+5g/RS72dNiMG1dbPlWvf
         QGscMt8MtnWA8m8Jd4t1X2OPPfwpZbqPU/kXCeY5KQs8Cp0hIXHoRQUI6qYxabGIOsnC
         THO5SoNAvriBDqEKsAkeUdorgks1LdC0sIE+xtNnNtccz9f27wrvu3BwSSXtJlbVm4/r
         FVqT3YmMZSFUo6Z/2356UznY26g3Oq6N+QIPLb9VeupRp8dB8troesGrbjtrNrnGmTDY
         xAdvBhPuB0+bXuL6D1CZFpLnv8QaV4SWKVr9VnwrVTFBIYmrgzYRH3zkaX/Pr4jxhofH
         V2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754344124; x=1754948924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkVWykS6hCsn+sBU+xav7wxsK66ozGOyeXXP9ZKMhQY=;
        b=K8wxriVxl0wOxgAAIF9jKjj7aOHA8t4pTYDZk+ryHrravDEg02bqFyA3/N+IeKYJZn
         N6b4O98OL0xia4o0HjD/kI8+4AwI2ZoNPW+1Mzz+A6Z24ooHOglav7ZUOKuktGzem14Q
         NTVMiJTt3YtinwNFpnstYLp2KYefAgIb5VmBPCId8Etznl1KQd1cydtRRs6ypjiZaVjr
         FX3g1Cf6jwoK5duuOoiwPn37d9IBTtdV12/hQwrsIfwNfwn2XcMIH9dsbbRpYnXWW7C6
         0C0gPxdkdIjI5yBkxaaR7jLWDwfgAAdy3XKDXN9zte2+Wh8osFkF0Ua1qjX6x5A05K5U
         2QBg==
X-Forwarded-Encrypted: i=1; AJvYcCUYoC1450iV7AUuJD8sR5bjcfCp1EWMQcB+NBiMXMszixWWJ8590rRTXDzcPPaXv5xW+F5DIqDsz0hHcC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlm0ptM+cujWa7pc9HdJzhDJ86dxXUi/flXDUHh1HPzXgnwuDc
	c254SjxLMS7ylNF7MRbXkVkz2nuiaosY15OQiIPngdykarPQCH9v/LTc8GyX20GE42N40BoIxMQ
	6/3xix8KY3mYS3TQZhTDJUoD4fRuYJEc=
X-Gm-Gg: ASbGnct24DLY/Zeu7j3X84NsJijfmgCzIZD1LtRH/x3p0ZLAwbNqxs6zi42M3EQBhI4
	ICGgDOjanGR4cMGdmD2qc5bRBd3d05wvZy8cSRT3wLRRnP6XD9OcE4Tn6DuyKdqmQJB8DLZGcRP
	oQShRMcAmhzLHXGRDMQxk2KvsLiebZPgcMEsrLRUnk+8uNONBkajPUgM1oRoSHEgwi8UbHWhWvC
	yDwKQ4=
X-Google-Smtp-Source: AGHT+IHpRjfMrlG9ZlCq5AhjD8/HSKNvGraWFA12xbDdMtQQsEay8IeUKx9EaEgk778U6wfDNaXD5a6q9Pbd7E8y2SY=
X-Received: by 2002:a05:6102:26d3:b0:4fc:156e:1046 with SMTP id
 ada2fe7eead31-4fdc4212c13mr4980106137.20.1754344123908; Mon, 04 Aug 2025
 14:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607220150.2980-1-21cnbao@gmail.com> <aJAFrYfyzGpbm+0m@ly-workstation>
 <1d1d97f9-2a67-4920-850e-accf4c82440e@redhat.com>
In-Reply-To: <1d1d97f9-2a67-4920-850e-accf4c82440e@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Aug 2025 09:48:32 +1200
X-Gm-Features: Ac12FXwWuOB4aHDWxv82Z-ff62MNcG24p5-GDgdLvCO-VcGPJBIhpHkcI52g-pg
Message-ID: <CAGsJ_4ypaAySaWyatH4Vu_dz--gEXUWk3yAQwM_8JTdR6U3fQA@mail.gmail.com>
Subject: Re: [PATCH v4] mm: use per_vma lock for MADV_DONTNEED
To: David Hildenbrand <david@redhat.com>, "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	Tangquan Zheng <zhengtangquan@oppo.com>, Qi Zheng <zhengqi.arch@bytedance.com>, yi1.lai@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 7:57=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 04.08.25 02:58, Lai, Yi wrote:
> > Hi Barry Song,
> >
> > Greetings!
> >
> > I used Syzkaller and found that there is general protection fault in __=
pte_offset_map_lock in linux-next next-20250801.
> >
> > After bisection and the first bad commit is:
> > "
> > a6fde7add78d mm: use per_vma lock for MADV_DONTNEED
> > "
> >
> > All detailed into can be found at:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___p=
te_offset_map_lock
> > Syzkaller repro code:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___p=
te_offset_map_lock/repro.c
> > Syzkaller repro syscall steps:
[...]
>
> Skimming over the reproducer, we seem to have racing MADV_DONTNEED and
> MADV_COLLAPSE on the same anon area, but the problem only shows up once
> we tear down that MM.
>

This seems to be where the race happens.
Hi Lai, can you also double check if the below diff fixes the problem?

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 374a6a5193a7..6b40bdfd224c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1172,11 +1172,11 @@ static int collapse_huge_page(struct mm_struct
*mm, unsigned long address,
        if (result !=3D SCAN_SUCCEED)
                goto out_up_write;
        /* check if the pmd is still valid */
+       vma_start_write(vma);
        result =3D check_pmd_still_valid(mm, address, pmd);
        if (result !=3D SCAN_SUCCEED)
                goto out_up_write;

-       vma_start_write(vma);
        anon_vma_lock_write(vma->anon_vma);

        mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,

> If I would have to guess, I'd assume it's related to PT_RECLAIM
> reclaiming empty page tables during MADV_DONTNEED -- but the kconfig
> does not indicate that CONFIG_PT_RECLAIM was set.
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

