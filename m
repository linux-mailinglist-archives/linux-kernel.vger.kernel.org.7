Return-Path: <linux-kernel+bounces-619505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F3CA9BD72
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 06:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B691BA1793
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 04:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591C2215F42;
	Fri, 25 Apr 2025 04:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OIHatB9f"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E581531D5
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 04:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745554377; cv=none; b=ULx3fmEsnMV6n2iC//ZgDpU5P73Ng1cFW0HYPNrpyI09sIuZ38Wg2gTUwrfuX0iWkK/thRmCWP2CM8y8c/N1LEVoKCMwzVIcBTnf/7DM08KW7ISg0RNGrrEGANokRl5pzt/0Fko8E57I1pFXDwi2H4HA0LjbECAOFJOffsetX7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745554377; c=relaxed/simple;
	bh=b2pAXetJULXEnnFyEESt08oVkWnz1P2Man5JhsrC4Hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FG974YR54CBuw4ehlvy8gZ/AT2S2oHtxaDZgUKuvZJiMD1v0vDy6hJGK2TChn3HckSdoEKRm4j3ICDBZypnHptZ0B8Cns6oBcPU69aYc5YyEU33Hfr9Yl8fDPPL4li9eDNHNvakqPwTq/fShf4IBiDASHts5PxNgjy/Ym82tq+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OIHatB9f; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCUQOsPGHT/TetRri01PwG/wE8Q8WVQAhbi3hH6+w9zsz7gcjRE8zKm0+QrdO3MNXnWjqTP3jtED@vger.kernel.org, AJvYcCXGkgMdj4HV2zA5sN+YF86Y12MeW5tmEn63zELJCNWZnHITKXXCB1vMncMrAKz15ytAZw2zFmPbAKs06/LU@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745554362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2mtNrSaQ2PMmqwH0ic+MZZ8ViISCFVttpoI5zUwLHNg=;
	b=OIHatB9fJkg3NxPsEEq6AD9oVFYBygDqUnzorjYgGEptjncpWScLiC2ibFy07P80soVMqa
	a4yz1x4Tyg0bneGB7fy3uMMlbJlrh4u49noNwX10/1xT9o0z+nSH3vMeetJFiYSjaEdZqi
	bJ+nl3oc80IyboUn0Tm7yVrreZX23Dc=
X-Gm-Message-State: AOJu0Yx16YfkT+ofJnAsJfqAtvyjI4Z+63mguC+FaQpK+RA0ZOpedzdC
	XuF+8ofxqTdNEdHUDWlmqgGivWvLGveBrgPIP4fBdlN3bIZAAeEJB4F0aA08dXZ4tKT+d6tfcej
	1T00/FFat3JFv/McdnU+R30eYDps=
X-Google-Smtp-Source: AGHT+IFmLpjKxR57HyCffy+sMZ3CV+PVfgHBvX42G1fsrDFI1qCmT4zv/WHgdidxKJ+BtkqUMk6syDI59v5iyVoShBg=
X-Received: by 2002:a05:6102:809a:b0:4c1:85d9:5641 with SMTP id
 ada2fe7eead31-4d543dc0ad5mr279452137.11.1745554360344; Thu, 24 Apr 2025
 21:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425031935.76411-1-link@vivo.com> <20250425031935.76411-3-link@vivo.com>
In-Reply-To: <20250425031935.76411-3-link@vivo.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Thu, 24 Apr 2025 21:12:29 -0700
X-Gmail-Original-Message-ID: <CAGj-7pW2Dy4U=x_MU8D+-o+JFLrQfO=b4tXD-J4B=ocHrv6fmA@mail.gmail.com>
X-Gm-Features: ATxdqUGaDuyn2ofbT9vT6qgsV071ukZncxDejKSKADe5y2Dv7UQRv6bonTv-m4M
Message-ID: <CAGj-7pW2Dy4U=x_MU8D+-o+JFLrQfO=b4tXD-J4B=ocHrv6fmA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm/memcg: use kmem_cache when alloc memcg
To: Huan Yang <link@vivo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Francesco Valla <francesco@valla.it>, Raul E Rangel <rrangel@chromium.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Huang Shijie <shijie@os.amperecomputing.com>, 
	Guo Weikang <guoweikang.kernel@gmail.com>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 24, 2025 at 8:19=E2=80=AFPM Huan Yang <link@vivo.com> wrote:
>
> When tracing mem_cgroup_alloc() with kmalloc ftrace, we observe:
>
> kmalloc: call_site=3Dmem_cgroup_css_alloc+0xd8/0x5b4 ptr=3D000000003e4c37=
99
>     bytes_req=3D2312 bytes_alloc=3D4096 gfp_flags=3DGFP_KERNEL|__GFP_ZERO=
 node=3D-1
>     accounted=3Dfalse
>
> The output indicates that while allocating mem_cgroup struct (2312 bytes)=
,
> the slab allocator actually provides 4096-byte chunks. This occurs becaus=
e:
>
> 1. The slab allocator predefines bucket sizes from 64B to 8096B
> 2. The mem_cgroup allocation size (2312B) falls between the 2KB and 4KB
>    slabs
> 3. The allocator rounds up to the nearest larger slab (4KB), resulting in
>    ~1KB wasted memory per allocation
>
> This patch introduces a dedicated kmem_cache for mem_cgroup structs,
> achieving precise memory allocation. Post-patch ftrace verification shows=
:
>
> kmem_cache_alloc: call_site=3Dmem_cgroup_css_alloc+0xbc/0x5d4
>     ptr=3D00000000695c1806 bytes_req=3D2312 bytes_alloc=3D2368
>     gfp_flags=3DGFP_KERNEL|__GFP_ZERO node=3D-1 accounted=3Dfalse
>
> Each memcg alloc offer 2368bytes(include hw cacheline align), compare to
> 4096, avoid waste.
>
> Signed-off-by: Huan Yang <link@vivo.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

