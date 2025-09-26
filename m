Return-Path: <linux-kernel+bounces-834435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32148BA4AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B302F3BEC05
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78CF2FE59F;
	Fri, 26 Sep 2025 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqLEN+AT"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC271B21BD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904875; cv=none; b=r4IKxr/Yp+E6HKXqnXrvGSWmqqO+kHME6QzNdNMo1QTKuVhZrHCiWyoUG2degJs0mOwIH8ljao3kKj9+Il2KY78ne/XWm4Bms9IiRG7P0Nzp9Jhoux1Z0pdBNk3kNmF4udc2heoMD25cpj6mxah+qD5qNrAhQSU8mjBlHb65npY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904875; c=relaxed/simple;
	bh=aVQU6Uf390VwLwgOyoJaPwfqW7aHy5b1UHicJhjquUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DK5cVTV/Jo1n/gTCPnFAhbiR8I131A2nRKJ1Cf9E+GFeHSJWHePzGrRF2x95gLiDrE1jIQyNHUwZCas9xy/gloF5e+MTPZxnIUTo+muwXeef5r55C0ssSDAOvkgaPVPR6dOGe61QwkhfIbIZB5qQNoJas128Exkjaogr0xFGNYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqLEN+AT; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b38e5c2e055so123859466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758904870; x=1759509670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhK/I355tEzWCZLpIKaGMRHfbyhnGIybWqmQS9Bgtnk=;
        b=RqLEN+AT7n5V2WesU8DRL27SNAii/eB5vBYcK/Afxxm4OpGrXcwYNQYfn8CcyJwsin
         ENUpQaqWNqsobAd43zFIqRyKCeg8BiPB5udZ4+NCBkQWLSOG9bCgbIUY/hhbbwLlZ3w5
         StrgGfbpDgJymtSA+IP6ml1edupmpsKEoTg18Cyit3TAO5rS8+WoWZT+gdZgprLz3Ors
         PhrQ0ehV/Zw3fcMBP+8DqenCY7VwWVJigSKydGsvSs55fXrSDUFMsyB+JOPEZEFKyki3
         Br4sJm8mZ3egoXudL9QTAcEKnNaFhvnFoN3LsyERYEHoA0j+jT7S77icTm0/MQzCEYqz
         KdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758904870; x=1759509670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhK/I355tEzWCZLpIKaGMRHfbyhnGIybWqmQS9Bgtnk=;
        b=jxmgZ2kpSDnZReZfn7PDv1l0neac8QMKuW2q5w9712YsOS/++CxYWbV6Kj6RSZlaX8
         DRaZV9ORlC9P0tSYaoj0Zuh7obADxpuT4gzbzWTURRH9Cs1/egQyOLNdwo8fQG68p1jx
         vQRQwNYFhXdjwEUDQ3fVrGRB/vjZ6G5cJI4rX8yCCNmqiEzvjZwdA90B85LTMRTcOEp8
         UkL9X+4ZPew5wpR4ldr2f7fhQt96FqczdsQNPtVxMFLwufeEeWXMl8DGc2cVMAcm7e9J
         X4YWG1q/Hlzf7zZG9J0OKCKoUpt6xU53Z2SaGrKBGfAVqoMLn/rozoJb4SzY8wRAtvIU
         M5RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfu8lJ4rDIMgTxL9bHj/rIBxQ2fndiYFxaW2LEZOb4Syv/c4GR8ihGvhG9tnuTLIuM62QPRNTQe3Q0OxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+SPV3GWaPZVh+6khbcg7MPqLZERoQpePYSUNiROyU8BiYlpfV
	Z13oUg7URUIlIr0nSHZl2ojquaN2w3vnMwcbcbXEC1cFR4nXCpQytkJCSZFoOyMkyO5V7nfS0do
	GpxqPYmovoh5D7czNEPKbd623EsCrzYo=
X-Gm-Gg: ASbGncu1qBag8GtNP/aWXBM9nSBtHn4LEJ3HM1w+b4RSGkxzeBd5NCB01tDU9+gdHrl
	6lhP+kQMUTkdH/66Ii+/XuIj8X+nEMPizeVrPlKCXEVbWNhRvtPNEeYknt5j34/Wr2/8ngj4spi
	d2GVKCkwezF4TwRM5cTKCtjaIu95JRwRcs8v5z5uVPy1FNpJRQTep/mUiZ+Wh31w+sYGm2cxY6l
	jpgaNABubrUejCSCWh8WaH1CYS1cx4x6W+mC1/+YKLLC9i2OcaBNLw=
X-Google-Smtp-Source: AGHT+IGiAgB3Cp3l/+LWlbB0J5SQqcA//CNAV4YTQyXTFqA9cx49Yh6QtYgAgO3MbSqw95Dgnu0URBo7YFe9FVeY/8Q=
X-Received: by 2002:a17:907:86a9:b0:b3a:1300:e8e4 with SMTP id
 a640c23a62f3a-b3a13102ed4mr8997966b.12.1758904870081; Fri, 26 Sep 2025
 09:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924204409.1706524-2-joshua.hahnjy@gmail.com> <202509260132.awvdNKqF-lkp@intel.com>
In-Reply-To: <202509260132.awvdNKqF-lkp@intel.com>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Fri, 26 Sep 2025 12:40:58 -0400
X-Gm-Features: AS18NWAvPCxQoYx4Q1NMydC8ffwXDXCS1U2zPQc-T1l-6SyQtlRE3k2R9alT660
Message-ID: <CAN+CAwNBg+3RwAsBxOEMk6aK+tb2O45wfnJxBdxRPSBi+vHEUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/page_alloc/vmstat: Simplify refresh_cpu_vm_stats
 change detection
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
	Linux Memory Management List <linux-mm@kvack.org>, Chris Mason <chris.mason@fusionio.com>, 
	Kiryl Shutsemau <kirill@shutemov.name>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Fri, Sep 26, 2025 at 11:34=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> Hi Joshua,
>
> kernel test robot noticed the following build warnings:
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Joshua-Hahn/mm-pag=
e_alloc-vmstat-Simplify-refresh_cpu_vm_stats-change-detection/20250925-0445=
32
> base:   097a6c336d0080725c626fda118ecfec448acd0f
> patch link:    https://lore.kernel.org/r/20250924204409.1706524-2-joshua.=
hahnjy%40gmail.com
> patch subject: [PATCH v2 1/4] mm/page_alloc/vmstat: Simplify refresh_cpu_=
vm_stats change detection
> config: mips-randconfig-r073-20250925 (https://download.01.org/0day-ci/ar=
chive/20250926/202509260132.awvdNKqF-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project c=
afc064fc7a96b3979a023ddae1da2b499d6c954)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202509260132.awvdNKqF-lkp@intel.com/
>
> smatch warnings:
> mm/page_alloc.c:2591 decay_pcp_high() error: uninitialized symbol 'todo'.
>
> vim +/todo +2591 mm/page_alloc.c
>
> 06fb80866d37b0 Joshua Hahn    2025-09-24  2564  bool decay_pcp_high(struc=
t zone *zone, struct per_cpu_pages *pcp)
> 51a755c56dc05a Ying Huang     2023-10-16  2565  {
> 51a755c56dc05a Ying Huang     2023-10-16  2566          int high_min, to_=
drain, batch;
> 06fb80866d37b0 Joshua Hahn    2025-09-24  2567          bool todo;
>
> needs to be initialized to false.

Thank you for the catch, I think Christoph also pointed out the same
thing earlier.
I'll be sure to fix this up in the next version! Have a great day!
Joshua

