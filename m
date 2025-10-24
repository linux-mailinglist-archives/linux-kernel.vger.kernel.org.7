Return-Path: <linux-kernel+bounces-868565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7531CC057C2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2165335BCAB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814E730CD87;
	Fri, 24 Oct 2025 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S2/4vdZp"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C352FE047
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761300393; cv=none; b=OFiO0ZUBnKXpgZ2eUtejLeb0E3hFbwd/f1Yc4hPNx3xgpxZr7BPPlTKacjcaBjTNOYdsiX7iVAy+f2eGXMQ/gvraVd9H+YT3TzhKYuv0+UOvwmnO8h8EUL5b3Uc9JHKei13I9VXel5/u8qERm+dqsN7buAtkKEP/KaFQS8Z6PP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761300393; c=relaxed/simple;
	bh=D1WLatxTBKa2YZcxHKBfolrAEDHX/YTChst2yMIVTYc=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=iQyFQItjiC94p5PBaFrcVEvcdAbne1ZnOYr7a/lTldwz8+SlDh5EHcB9xv3nL63lZsSEO8lKCau0ezd7dWsUJGfMUQqJiPaV5iN16xrWD0/K0eWnnfrzrXxWESy6iPOCWoy7Xu+C+E4JlkwRexDxJh33QeH2EBPbVtcmUZoyQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S2/4vdZp; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761300388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axIA7P+AQSjY62b1eHGJy8vlVdvRAxUy0/HBHXY5V7s=;
	b=S2/4vdZphxmPM284+KB8fDDlsiiG+nUBCHOC/X5U39uz8PLG2qH48UTVpCHdwBIV16uz+H
	Gx6hhje9oqy/kr6xr3GQU3s0HXEaJVRDB9NB408/0O1tXz77W4UO2NdenGTGr7cGkssByZ
	p6oxiXYYLZQm/kFZfYnkn/N2s2g+HMk=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] slab: Fix obj_ext is mistakenly considered NULL due to race condition
Date: Fri, 24 Oct 2025 18:06:09 +0800
Message-Id: <123334B8-89A9-48C2-BBD9-A601E0395AB1@linux.dev>
References: <8b152d73-ecc4-415c-acdc-3f5105412ac0@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
In-Reply-To: <8b152d73-ecc4-415c-acdc-3f5105412ac0@suse.cz>
To: Vlastimil Babka <vbabka@suse.cz>
X-Migadu-Flow: FLOW_OUT

Hi Vlastimil


> On Oct 24, 2025, at 17:40, Vlastimil Babka <vbabka@suse.cz> wrote:
>=20
> =EF=BB=BFOn 10/24/25 11:27, Hao Ge wrote:
>> Hi Harry
>> Hi Vlastimil
>>=20
>>=20
>> Thank you for adding V2 to your tree. Now, should I resubmit V3,
>>=20
>> or can you assist with making these modifications in your tree?
>=20
> Massaged it a bit more and now have this:
>=20
> commit b4bdf6770cadb8bffcf3dce7ad7a346979f79ede
> Author: Hao Ge <gehao@kylinos.cn>
> Date:   Thu Oct 23 22:33:13 2025 +0800
>=20
>    slab: Fix obj_ext mistakenly considered NULL due to race condition
>=20
>    If two competing threads enter alloc_slab_obj_exts(), and the one that
>    allocates the vector wins the cmpxchg(), the other thread that failed
>    allocation mistakenly assumes that slab->obj_exts is still empty due to=

>    its own allocation failure. This will then trigger warnings with
>    CONFIG_MEM_ALLOC_PROFILING_DEBUG checks in the subsequent free path.
>=20
>    Therefore, let's check the result of cmpxchg() to see if marking the
>    allocation as failed was successful. If it wasn't, check whether the
>    winning side has succeeded its allocation (it might have been also
>    marking it as failed) and if yes, return success.
>=20
>    Suggested-by: Harry Yoo <harry.yoo@oracle.com>
>    Signed-off-by: Hao Ge <gehao@kylinos.cn>
>    Link: https://patch.msgid.link/20251023143313.1327968-1-hao.ge@linux.de=
v
>    Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>    Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>    Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>=20
> diff --git a/mm/slub.c b/mm/slub.c
> index 87a1d2f9de0d..d4367f25b20d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2052,9 +2052,9 @@ static inline void mark_objexts_empty(struct slabobj=
_ext *obj_exts)
>    }
> }
>=20
> -static inline void mark_failed_objexts_alloc(struct slab *slab)
> +static inline bool mark_failed_objexts_alloc(struct slab *slab)
> {
> -    cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
> +    return cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL) =3D=3D 0;
> }
>=20
> static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
> @@ -2076,7 +2076,7 @@ static inline void handle_failed_objexts_alloc(unsig=
ned long obj_exts,
> #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
>=20
> static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
> -static inline void mark_failed_objexts_alloc(struct slab *slab) {}
> +static inline bool mark_failed_objexts_alloc(struct slab *slab) { return f=
alse; }
> static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
>            struct slabobj_ext *vec, unsigned int objects) {}
>=20
> @@ -2124,8 +2124,14 @@ int alloc_slab_obj_exts(struct slab *slab, struct k=
mem_cache *s,
>                   slab_nid(slab));
>    }
>    if (!vec) {
> -        /* Mark vectors which failed to allocate */
> -        mark_failed_objexts_alloc(slab);
> +        /*
> +         * Try to mark vectors which failed to allocate.
> +         * If this operation fails, there may be a racing process
> +         * that has already completed the allocation.
> +         */
> +        if (!mark_failed_objexts_alloc(slab) &&
> +            slab_obj_exts(slab))
> +            return 0;
>=20
>        return -ENOMEM;
>    }
>=20
Thank you very much for your help,=20
and I sincerely apologize for the actual trouble I have caused you.=

