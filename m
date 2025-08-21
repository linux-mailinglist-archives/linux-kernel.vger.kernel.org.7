Return-Path: <linux-kernel+bounces-780446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C227CB30202
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19419B61A54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158CA345751;
	Thu, 21 Aug 2025 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dACeYnc8"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C13343D77
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800645; cv=none; b=W+CL1Lz7GOJbJyH+413KuQxm9TL+wvgHE6jX+loWyWqhknhbLYsnx8RlyRhqa7GgjFfsBUQwSTfBDIX80AvDF5AxbJmhy/QddV/U3d23ppzU56hAkISy6rnHwhdHuMVjD6w5LS5yt/h9OYEyxTYAvXvhqr/aOpZ8hD5w/UwVN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800645; c=relaxed/simple;
	bh=PcPxhotZ4dmlM/chIJxSdYMAflFmCEQ5m8cSmQZufH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYHRKd3Rrt/JVsMCumPqkvLsQG+RIC4Z3B7vwb/U3QUUnKZCvpKWDX7EsXYKCyQ5oE3uRzUokCZqm4LDV2Aync+bXeKZjjAMlksuA1++n/KJ5vGemcKsXGsXMODIwFFHqh5ebfzNI6n2Of28f7SEIdinq1kIvecAJCk6PYJ58wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dACeYnc8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-459fbc92e69so9245e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755800642; x=1756405442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S05XX1CMKeNm/D4lxTXlGtmP6fs7IzzZWQyQcXhC3KE=;
        b=dACeYnc8nCVK/SAO345I8JCMrrttj5npmW9Tx2amUSSQ0Xa9/obBM6WzHKVV5GQXRN
         miUTHMfXVmDC4nPUDLs9B+do3ZJiCkALClVAuzS5IRoOpzH7a2ByBteR5z3UDNg+Hxfk
         qSKoS4OGgTUaDZi5+JmbV8H1twsS5/RRT3YpjMfgc1Sne9bN32jmTF4I+hXuxOYkKnc/
         vJXvwILFHNi2HkkMLqXA0Sh762fIZtCHlIr9mTJ09H5oaKXg7R0I9E3D9mRc2fEXLHGp
         wp/meosFWiNN5ETO2p5X+eCpgJN2idYbLcOAj+uLitGRoV1SVQMUKlsaYv8NcH2Rh8fg
         insQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755800642; x=1756405442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S05XX1CMKeNm/D4lxTXlGtmP6fs7IzzZWQyQcXhC3KE=;
        b=I/PJirJIxAI3QsogIYZc2C4GEcDiCJVksSOQz/OvzGu5vgH8/DK+1Q5HazTjwMl0k3
         QwpkCgzlU2Gw+3cK5bO2kuC/NrPv73GVJ1jw+IzrlOr/4IONZky6KactC4wJP22aI6n0
         QuaSYZ2Nr9gUfcN6Ged4eZXWEIAbqLUG4LdfgrQGF5ndZ0DK/hejO8fS+891Y9btLFma
         Wtj6cRxC4O1JfuQcB79EamP7Ne/cKN2IzuIR0tSSStE6v/xPCOM7C73V9MHL0M0T9m0V
         pCCsoRd1uGI4kUxqUHsj0kjxpMFu6idr2QNmnQXH3N3OAACkYNa9a97eTArtwJA6lz6e
         KnJw==
X-Forwarded-Encrypted: i=1; AJvYcCXA6LjSnWzAe3uiqeWqO2jkEDcIBAlZEGltutvXMscbID0BFEqEESbpOdCwyu0+mH0iK+UXq6HuELnrVVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG2TNVSWAWZd/bdDBzpon7w9RIOrFWKZRDbUtEK2ixJofxpEGS
	2cg1WFaMpgGtKk6b5+nmEgbEra2YPjkFCMAyJMyWVEYxJ99amVMVscGi+K4cDr8SZKsXUN6usvG
	H+x79FwFA+SgW2FivI5FLYrXVtgSU9icIlgfSJ8da
X-Gm-Gg: ASbGncujklxNV8LlexzyppE4pSoSB1BZjzZ72frzXWA2Xtdtb77NHn+uHV9VKfNuoed
	i4uw4MmqF/HteadK3flwvtwI/7bJ8vHnx5v51aoZfHcdMsi9TzzEf3pLFZT5zm9IqPFeOCGbhG1
	9DUtfrqs6hLu/wPASJepeIdKDibVHHGlqDURm9mOSxYwo/y3Fsn8LRyIBNO1qpHwESIQt7X8ai6
	8vFv0a4JNL1mOLpCjsP04E/ZxnqobCx5Ch57Q/gquI=
X-Google-Smtp-Source: AGHT+IGAJ/WwMySwd32nkeR5X9Y03nD2OKRkLV9ZWlktV4dgbEHfBj/QYGnOAE1hTkrvp2B/i2b6vwUdUdzxGsf66Nc=
X-Received: by 2002:a05:600c:820c:b0:45b:4acd:836d with SMTP id
 5b1f17b1804b1-45b5178cc11mr78945e9.5.1755800641402; Thu, 21 Aug 2025 11:24:01
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821164445.14467-1-kyle.meyer@hpe.com>
In-Reply-To: <20250821164445.14467-1-kyle.meyer@hpe.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 21 Aug 2025 11:23:48 -0700
X-Gm-Features: Ac12FXxIQjlnaJcpKiZifZHaL_GQKCBr-ZXYxrrQp4nBKl4flBBfpBecptv_Ts0
Message-ID: <CACw3F53KmKRJyH+ajicyDUgGbPZT=U3VE4n+Jt3E62BxEiiCGA@mail.gmail.com>
Subject: Re: [PATCH] mm/memory-failure: Do not call action_result() on already
 poisoned pages
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: akpm@linux-foundation.org, david@redhat.com, tony.luck@intel.com, 
	bp@alien8.de, linmiaohe@huawei.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, nao.horiguchi@gmail.com, 
	jane.chu@oracle.com, osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:46=E2=80=AFAM Kyle Meyer <kyle.meyer@hpe.com> wro=
te:
>
> Calling action_result() on already poisoned pages causes issues:
>
> * The amount of hardware corrupted memory is incorrectly incremented.
> * NUMA node memory failure statistics are incorrectly updated.
> * Redundant "already poisoned" messages are printed.

All agreed.

>
> Do not call action_result() on already poisoned pages and drop unused
> MF_MSG_ALREADY_POISONED.

Hi Kyle,

Patch looks great to me, just one thought...

Alternatively, have you thought about keeping MF_MSG_ALREADY_POISONED
but changing action_result for MF_MSG_ALREADY_POISONED?
- don't num_poisoned_pages_inc(pfn)
- don't update_per_node_mf_stats(pfn, result)
- still pr_err("%#lx: recovery action for %s: %s\n", ...)
- meanwhile remove "pr_err("%#lx: already hardware poisoned\n", pfn)"
in memory_failure and try_memory_failure_hugetlb

This way, all the MF recovery result kernel logs out will be sitting
in one place, action_result, instead of scattering around all over the
place.

>
> Fixes: b8b9488d50b7 ("mm/memory-failure: improve memory failure action_re=
sult messages")
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
>  include/linux/mm.h      | 1 -
>  include/ras/ras_event.h | 1 -
>  mm/memory-failure.c     | 3 ---
>  3 files changed, 5 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1ae97a0b8ec7..09ce81ef7afc 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4005,7 +4005,6 @@ enum mf_action_page_type {
>         MF_MSG_BUDDY,
>         MF_MSG_DAX,
>         MF_MSG_UNSPLIT_THP,
> -       MF_MSG_ALREADY_POISONED,
>         MF_MSG_UNKNOWN,
>  };
>
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index c8cd0f00c845..f62a52f5bd81 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -374,7 +374,6 @@ TRACE_EVENT(aer_event,
>         EM ( MF_MSG_BUDDY, "free buddy page" )                          \
>         EM ( MF_MSG_DAX, "dax page" )                                   \
>         EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )                        \
> -       EM ( MF_MSG_ALREADY_POISONED, "already poisoned" )              \
>         EMe ( MF_MSG_UNKNOWN, "unknown page" )
>
>  /*
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index e2e685b971bb..7839ec83bc1d 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -948,7 +948,6 @@ static const char * const action_page_types[] =3D {
>         [MF_MSG_BUDDY]                  =3D "free buddy page",
>         [MF_MSG_DAX]                    =3D "dax page",
>         [MF_MSG_UNSPLIT_THP]            =3D "unsplit thp",
> -       [MF_MSG_ALREADY_POISONED]       =3D "already poisoned",
>         [MF_MSG_UNKNOWN]                =3D "unknown page",
>  };
>
> @@ -2090,7 +2089,6 @@ static int try_memory_failure_hugetlb(unsigned long=
 pfn, int flags, int *hugetlb
>                 if (flags & MF_ACTION_REQUIRED) {
>                         folio =3D page_folio(p);
>                         res =3D kill_accessing_process(current, folio_pfn=
(folio), flags);
> -                       action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FA=
ILED);
>                 }
>                 return res;
>         } else if (res =3D=3D -EBUSY) {
> @@ -2283,7 +2281,6 @@ int memory_failure(unsigned long pfn, int flags)
>                         res =3D kill_accessing_process(current, pfn, flag=
s);
>                 if (flags & MF_COUNT_INCREASED)
>                         put_page(p);
> -               action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
>                 goto unlock_mutex;
>         }
>
> --
> 2.50.1
>
>

