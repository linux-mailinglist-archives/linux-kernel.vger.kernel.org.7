Return-Path: <linux-kernel+bounces-884072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F49C2F4C2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 05:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCB904E9FC4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 04:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC302609FC;
	Tue,  4 Nov 2025 04:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/s58CC+"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB72D132117
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 04:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229991; cv=none; b=iKcEy7EVR3w7G0MJVoxD8O38nakknj8kIqSH12DLL/hoMeihdLXqoiU1KJ/hebQw8hm1JXqQMhDbAN1+HJ1qcOL6iHAwWWA31lJY10gRQ+ZfgNwXgQAwl/6dzO6WxQzTtVel5ytZcPUiIIiCmdhevQKMOdC2taiP2p++A15fFWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229991; c=relaxed/simple;
	bh=IJDAf2KmbNhBh/iYdZEoGyigglgYfV7t1rIeDVcMKDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Osz+NwEcnC1NEpMVM/O5g0w/3vSEz3AQpxu+3zm3n4+z0TYtuHFrAtI9mKQ5rLIPsC+KpMfVNYwM5fWbm86b3RY13AOxbFxN762jccAsBOv1yZJg6+vFDS3wrO1kce5sGh4AJPPyh1SeFvpnwizmT/Etia9tEYmJ2u1lDmYryZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/s58CC+; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8909f01bd00so606678285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 20:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762229988; x=1762834788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHJdjMEE/xapcpdDdK8KASqwyVZ/30uRlTXAFHL0inQ=;
        b=d/s58CC+5WTdl97ZeYopVe5CGZtUC1RKhDM/dT61v1kEPFsqu5VHiYW6+dILURFmSw
         DBzHjNn5zCdAPW/jyTJ3wvPYOYKNbmaFJv2Y04496yvUDIbQ3K9CFT4sZvyiZEdErEn6
         0xsi5sLnNzUH9VVelCV7lmOtHqdfYL2P32lUXZoGeUTiiMV+OarUVw00D9G4SBDVlD6I
         g0nJY9wxRRcNKiiA0X+vhXDkCEzfNlnx3YeMUeZXXOJT4I8ZcUChenStV/mEJTX9mMIk
         qt1JdZMHyR5ilYty0hAd+uLky/btltvoXGW7c9sXmwxQ9GOzdJlPQ9lAkMweCWrDzW82
         KB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762229988; x=1762834788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHJdjMEE/xapcpdDdK8KASqwyVZ/30uRlTXAFHL0inQ=;
        b=n+EWj6u/If91Cg+V/c0YJqJPB7MBiCUJXWHY1Iaed5zl8CBGWNTCyfmmJy283pigOE
         VkthtNa48WNLOQq3f3crRwdZwoJfLxuBKFH74ys0IHkP2GAyQWKjatHtbcpxuPo3Tc5r
         ZOWMtdBHLgXsVn/ZlA8SwDOAjTKf0Q5w1yD9bNAUJZbbJfZbNQJIOiaFr/rhwRzIyrCT
         FU+YHg9KY6DCri2Ldj/WVB4zaZaBzKgukQHoTlEt+QIx2I4y3mH2MYOqv5txFINrnm8X
         YGV5pJygb8cpCPGWzHhlYP4Gh0YD0KER7xP2mM5GSO3arjRp0GDsEXC7jI2v1ZyuRXuo
         NWrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2BATUS8XFJ7Xh2tHoRxu/zi+2RarB5fULog/2BWlV2FnG8Ogy8EMnCfVpD7nOqe+lLw0ah4UYHdWWG9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBCTqMNBPizRBmSTCS8RlEXKnevJuidQUKnvFuYDNx0Ucj9rXv
	fBEfOI+KTi/sOKVPMJBjau9UPHOMIg2XO9PjNigNmDtySrdkTuGVjMZsfpuc5PotzqSuz6h9rFn
	/rm0uK4RZbNGQiuiVD5EiK7KKe2VLPzE=
X-Gm-Gg: ASbGncviBvOQX4mKVdN94D6OlyC7EtlVEZkpiUlLps5aro7WRvLEOWwOcmtmKHEBvuX
	U6hBgP24VsSndh0437IzL5wdzg1F8YqXcJlkT34YZai94P7HGEV5V7mcb/yzEp+ULDBkuBjbQEk
	+o3JuBdP/ZZoAlp+6woRxK5CXYRlRWGCisZkSEyrM2jJB5wR6nU4QfxuLyknM7ECPTDyOLimaCS
	vArSuCcTJ4khVFxZIcXuhKGvf/rDCgMg36rLwpzz/izmz7NhTeYy6+NEyjysdW2ZidkUXv7bvIx
	gs11u/TiU4Vq+m19TpSocSXlk84=
X-Google-Smtp-Source: AGHT+IH+5RRmTLyNpLIP6XrC7qEFKTxDYBgtFCpqxbfJLWWu5/DWtPIwC9vO7peSq0UZx7LZCNaKunPtQOQRW95H5sI=
X-Received: by 2002:a05:620a:7103:b0:866:73f7:25a2 with SMTP id
 af79cd13be357-8ab9b598b23mr1762087485a.64.1762229988351; Mon, 03 Nov 2025
 20:19:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com> <20251029-swap-table-p2-v1-4-3d43f3b6ec32@tencent.com>
In-Reply-To: <20251029-swap-table-p2-v1-4-3d43f3b6ec32@tencent.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 4 Nov 2025 12:19:37 +0800
X-Gm-Features: AWmQ_bmTFRrhwXCcOBLUnvIw4tjUmphj21GmvzG37YUU2k9yPanr3-g3-dGf8iw
Message-ID: <CAGsJ_4xOd0CJLZvzvZu9mRLjVvV0OSKE8NcBAYe3wvHFtLjWyA@mail.gmail.com>
Subject: Re: [PATCH 04/19] mm, swap: always try to free swap cache for
 SWP_SYNCHRONOUS_IO devices
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 11:59=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> Now SWP_SYNCHRONOUS_IO devices are also using swap cache. One side
> effect is that a folio may stay in swap cache for a longer time due to
> lazy freeing (vm_swap_full()). This can help save some CPU / IO if folios
> are being swapped out very frequently right after swapin, hence improving
> the performance. But the long pinning of swap slots also increases the
> fragmentation rate of the swap device significantly, and currently,
> all in-tree SWP_SYNCHRONOUS_IO devices are RAM disks, so it also
> causes the backing memory to be pinned, increasing the memory pressure.
>
> So drop the swap cache immediately for SWP_SYNCHRONOUS_IO devices
> after swapin finishes. Swap cache has served its role as a
> synchronization layer to prevent any parallel swapin from wasting
> CPU or memory allocation, and the redundant IO is not a major concern
> for SWP_SYNCHRONOUS_IO devices.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memory.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 9a43d4811781..78457347ae60 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4359,12 +4359,21 @@ static vm_fault_t remove_device_exclusive_entry(s=
truct vm_fault *vmf)
>         return 0;
>  }
>
> -static inline bool should_try_to_free_swap(struct folio *folio,
> +static inline bool should_try_to_free_swap(struct swap_info_struct *si,
> +                                          struct folio *folio,
>                                            struct vm_area_struct *vma,
>                                            unsigned int fault_flags)
>  {
>         if (!folio_test_swapcache(folio))
>                 return false;
> +       /*
> +        * Try to free swap cache for SWP_SYNCHRONOUS_IO devices.
> +        * Redundant IO is unlikely to be an issue for them, but a
> +        * slot being pinned by swap cache may cause more fragmentation
> +        * and delayed freeing of swap metadata.
> +        */

I don=E2=80=99t like the claim about =E2=80=9Credundant I/O=E2=80=9D =E2=80=
=94 it sounds misleading. Those
I/Os are not redundant; they are simply saved by swapcache, which prevents
some swap-out I/O when a recently swap-in folio is swapped out again.

So, could we make it a bit more specific in both the comment and the commit
message?

Thanks
Barry

