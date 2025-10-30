Return-Path: <linux-kernel+bounces-877556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35475C1E699
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A97D4E6380
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E78832D0CF;
	Thu, 30 Oct 2025 05:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiprPBMP"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8182D063D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761801943; cv=none; b=ZlvBjPBO6VERnrq9pO8wG3WaCoX5FVy33OEjkmhkYQB2O8oGcvCVNpc6xsDhjRpCmFXaEcH7WGeWlxa0bRkG8ev3pebB85VxIhuMFKVejer6mddTXDFr9PdTtNxX8mgX3pCiO332UMrvEn4D0FOAZ2MYT/vl0uQcm1N93D8P954=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761801943; c=relaxed/simple;
	bh=GpxJRWhQ3eXHwdU9ZgpR7Yuo3ekC6UL+YpfvAE70JCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOLLbrPHxqJcIdqqR4elTsGg37+DJYGVH++n1QKW1F+8W5IS0dM3nCKbM/hSGa94jh4109BdTPtjXk8ExAntY9JqW5nbtfikw3e5KFaimk8d9gRvggRn2V0a79sZFN70Xaxw3fAnDU8L1XqKYtuAoqknChCxumqYbq5nmQ3GEcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiprPBMP; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3e9d633b78so164438466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761801940; x=1762406740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfysZUiKw0ccehvHsLCa5x6Zv8Uvqd+yTXJjIb1Wj5Q=;
        b=GiprPBMPH5ViuOxtgy2QVuTr2Zg1sun5vbn4JuGRq0XqSCIjxLnxZ4GjaEoqxp1XqQ
         W29bIKPvwHcOwl5h4nuCQSmq2fhYNH3BQlu7xJYWUK+yChmx1CYW5A0JwhWSWI+4+1/b
         3pq+G7AXw4TWw5rjcTIJUtT9lsrDifu1zLvCshQQIAy7AvtmODAEoN5gf9hTaTxZblub
         zL8UYPdNEXHAk5oiWG40JKXFCH6nyXQaw+F+0cuz59Av4A6vHdl/lrtwde1PH76iDXRv
         TpWMh2VsZXdRNCcqMfUCtdCwcIjyQbGTWo+kRuHThFBD7kVvMiNWeq12lQC7MYg3d1H3
         ddLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761801940; x=1762406740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfysZUiKw0ccehvHsLCa5x6Zv8Uvqd+yTXJjIb1Wj5Q=;
        b=eoffFk5CbllCWFnbJMaewv2XlNUBYr9xL36/KBLlTZAU+Zov5cStHiFxLE5Y01tB3v
         2qyRLbfSXsynuWyA6nxmG7OCYftgbWgR8+lD91V3aFDKT1SZWPZBDe4J3Ul0fK25cyFp
         Jr/tbatlf7yLsodmc2ZmRbvM7WYNgOC6G0oSeU6l7wMbCmh/lpdnIvzyYfHTYd9MAbyx
         o4Gp493EyYwM2gsuQTDrALuLuSzTfjc6ehnTElDF0j8IgTNAk9I5AD3lH0kVvjshf5Af
         NTURuiooZRTzSUVcV26KCRjq/beabEDsZ63TEePz2gMW1MumG/eve5cwenNfv3qPb3Ns
         kATg==
X-Forwarded-Encrypted: i=1; AJvYcCXE/weUcwDpmnAUZcloqN64XXHf8lGbgf/5bDGCNAZPRxGPGcl4zlEeYjal0S6yqTwdsBzsYX+RTgr77nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0fML2RlG23KPtCHAPbg47pByeZ/IpyuLk5Y+ItY7b3q/15s21
	noKvkQpi4YaC7+r0Gh0R3kyR5V+mGmL3ExAzRqZzG44Vp9gh5ModMP3lTruzxAsvQIdRfMw8Fi7
	L9IpMatz8p+9chz/eQM8QHd90AcLkHoo=
X-Gm-Gg: ASbGncugBIEdl6t4SbLeAID2Ekel6o+TdpZ2/5P7Ene56feKMHft90yWKH2aZiTVEKB
	Wiwj8D2D2HL+jjRoOedXhtox8kllF7t1HUkfGqyx0t9jkyGbco/rHtd19vQlGSdAu4HzAT4gfOa
	K+VzacuucvHBvHh5LMCAeVeGowLVbKjqbGtWoX0SVvNxbVdAxwRidCwuVA9PaJE7VTgJ+wApA8x
	n9WV1bFgUj9kzL3j0X+7PxBdhT8fhA4czPUQCLK3MW1TCuhQgfRAACJq5pGf9dW
X-Google-Smtp-Source: AGHT+IHNyXHD9tuJVWmX0HGoxsmgdCXdnVfsLSRiQVKCm3qLDQttk267xLovDM2ICaKjf/7vxbQtpUFH3F3g94OPSSs=
X-Received: by 2002:a17:907:7f94:b0:b3d:e757:8c36 with SMTP id
 a640c23a62f3a-b7051f28d17mr219852766b.3.1761801940298; Wed, 29 Oct 2025
 22:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-14-3d43f3b6ec32@tencent.com> <202510300316.UL4gxAlC-lkp@intel.com>
In-Reply-To: <202510300316.UL4gxAlC-lkp@intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 30 Oct 2025 13:25:03 +0800
X-Gm-Features: AWmQ_bn7Lyv0bXlIQEUl3x-IuvN0KJgIKA5RqyN4TyJ6a-kvBKh6n54oDVlmgZo
Message-ID: <CAMgjq7DcxG_8q9Kzwg-4kLBXw8eN8DvwmSR0gRUjYWPoFH8xsw@mail.gmail.com>
Subject: Re: [PATCH 14/19] mm, swap: sanitize swap entry management workflow
To: kernel test robot <lkp@intel.com>
Cc: linux-mm@kvack.org, oe-kbuild-all@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 3:30=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Kairui,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on f30d294530d939fa4b77d61bc60f25c4284841fa]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kairui-Song/mm-swa=
p-rename-__read_swap_cache_async-to-swap_cache_alloc_folio/20251030-000506
> base:   f30d294530d939fa4b77d61bc60f25c4284841fa
> patch link:    https://lore.kernel.org/r/20251029-swap-table-p2-v1-14-3d4=
3f3b6ec32%40tencent.com
> patch subject: [PATCH 14/19] mm, swap: sanitize swap entry management wor=
kflow
> config: i386-allnoconfig (https://download.01.org/0day-ci/archive/2025103=
0/202510300316.UL4gxAlC-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251030/202510300316.UL4gxAlC-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510300316.UL4gxAlC-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from mm/vmscan.c:70:
>    mm/swap.h: In function 'swap_cache_add_folio':
>    mm/swap.h:465:1: warning: no return statement in function returning no=
n-void [-Wreturn-type]
>      465 | }
>          | ^
>    mm/vmscan.c: In function 'shrink_folio_list':
> >> mm/vmscan.c:1298:37: error: too few arguments to function 'folio_alloc=
_swap'
>     1298 |                                 if (folio_alloc_swap(folio)) {
>          |                                     ^~~~~~~~~~~~~~~~
>    mm/swap.h:388:19: note: declared here
>      388 | static inline int folio_alloc_swap(struct folio *folio, gfp_t =
gfp)
>          |                   ^~~~~~~~~~~~~~~~
>    mm/vmscan.c:1314:45: error: too few arguments to function 'folio_alloc=
_swap'
>     1314 |                                         if (folio_alloc_swap(f=
olio))
>          |                                             ^~~~~~~~~~~~~~~~
>    mm/swap.h:388:19: note: declared here
>      388 | static inline int folio_alloc_swap(struct folio *folio, gfp_t =
gfp)
>          |                   ^~~~~~~~~~~~~~~~
> --
>    In file included from mm/shmem.c:44:
>    mm/swap.h: In function 'swap_cache_add_folio':
>    mm/swap.h:465:1: warning: no return statement in function returning no=
n-void [-Wreturn-type]
>      465 | }
>          | ^
>    mm/shmem.c: In function 'shmem_writeout':
> >> mm/shmem.c:1649:14: error: too few arguments to function 'folio_alloc_=
swap'
>     1649 |         if (!folio_alloc_swap(folio)) {
>          |              ^~~~~~~~~~~~~~~~
>    mm/swap.h:388:19: note: declared here
>      388 | static inline int folio_alloc_swap(struct folio *folio, gfp_t =
gfp)
>          |                   ^~~~~~~~~~~~~~~~
>

Thanks, I forgot to update the empty place holder for folio_alloc_swap
during rebase:

diff --git a/mm/swap.h b/mm/swap.h
index 74c61129d7b7..9aa99061573a 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -385,7 +385,7 @@ static inline struct swap_info_struct
*__swap_entry_to_info(swp_entry_t entry)
        return NULL;
 }

-static inline int folio_alloc_swap(struct folio *folio, gfp_t gfp)
+static inline int folio_alloc_swap(struct folio *folio)
 {
        return -EINVAL;
 }

