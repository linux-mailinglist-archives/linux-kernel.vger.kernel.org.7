Return-Path: <linux-kernel+bounces-790637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B7FB3AB2E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052AA1BA8422
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58C327D77B;
	Thu, 28 Aug 2025 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AsweaK26"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C327E071
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411147; cv=none; b=s2UPvZCdL1oguK10svfLqZwgpwh1yZ9zOS4Ei7EMlwst3Rw0eb1l9P+vbYdnXTkMWNgn236NSWwslO1AwaeXqFb5cfJuszMT3kKwROta+3sq/jcR2kD7weI5UDeHJ9R7RLhy6JjBNGiXb9bac3Cj7rZPudpCMRpbEwrMKhxnU1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411147; c=relaxed/simple;
	bh=t4M1DGGSu84GKZww69xAOCv/b4Z9RzHTknYIfiROzw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wamtc48BhlLvKIZC/ZnoVFbLL4cuuNLgUIyQbI9oLENT042vmybfrdCkSr8bk4l4wKJlLVo2G1HPiPIR1lIkH3YJvL4gwciHXzCit1FUaZ3AfPUVgqQUCRYfg/ZTSMcPyrppHNp+/mA4sfoJeI1/vm+eUwjQnj9yYbCu8Bkk5Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AsweaK26; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-459fbc92e69so23145e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756411143; x=1757015943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rb1Ys+OS8pMllVi9x1vwj1VWFDJ6Jd401gcPHSeVaJI=;
        b=AsweaK26icQwWumPzA9aBXLyJQGziafonFRhQ5MY2LrvVkX/m5hODOvNb5PxxTk8zq
         JesgV78FSKHKrCjsVFC9BWfM7O9jzsui30XNVa1n+ovucMv5k74qwT2xvB1oyqyvDJeu
         copJKVt/HhaU+Gvv46rVF7+6Du4QbrnBCGNQsr43x6QudwJuCbQo3sVx364TflpAm0dF
         v+2LOyw6i1UvZWSEg6xKCpBIvO9LkSRyyEeAKk6SHX3Rej96HOWnKQF+7fn9Cisxf1di
         wgtJ3EMOpboToBCUhoZgGL3X3AZ+P44Q6OPEn5NWiWiyEK1jgr9T+XmB+bpkOglWUMhl
         /Uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756411143; x=1757015943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rb1Ys+OS8pMllVi9x1vwj1VWFDJ6Jd401gcPHSeVaJI=;
        b=kjrZ0ZUYm5bgfsQY8z28ITGhSiCp1HznJcJeCykHbvGqNGvBI+emNROh9JLrrP1st/
         0kb4fc8sKodBJtY4Y9mvzuXu2UdbHLFHF09OagvFeygu+MHWbyPIFLX6mXz3OC1qsQb1
         rhfA4uUOeJOkek/Q0XidDRctSidxVYR70tzDu27++ZgRatkkqEcESjEmtXPdaQ1eLbRh
         9qb3K/y8z0Pdtr/rok4na43eNzhNpFmOyfxlnQpeKA/dAxM9zQD5Za9RycJ8JiTYILoM
         idB14Ncz2/lpQjS7T+rB7b5JcCN1ZUjPa/ei8LhRsWN4IukfDSQIRvl4BTA8fv4W5c6l
         O8wA==
X-Forwarded-Encrypted: i=1; AJvYcCVW9euk5G73/+UWm/xFuqk+pq6UOgA2CIrgvo8okK3/w6SUIeno3vwMY3e3iYVnDkOsv18IPrrrAY+0gUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc2r1DNIc+flOkP910RUgBF+Affwb7VTdXr0z84UAny9mfaKmI
	az7kj+unr+TWpF5sNA8E1uDLzF9mC4FKbyE5b+fwVZ/7cDcOKZb8z6RyRmatCGD7dAg0vHB6kdo
	jYTZXI7AkShlBvNH4vU+S8z7juJCqtJypSq48e185
X-Gm-Gg: ASbGncsnA/XDiSgmW1cu1u51xMo2kSX3+sKp1S3T13/25UKwJQaAqN119xMAIui38qK
	q2bWq5cHkN643uugw0nCMl6y2eJXu8g5iDM/r/hFRieledhx1nEqcwSAppVJ6af5aDgtszBFSC2
	l+vcYNTcYm8Vn0YS8GEkQbkqQqpVN1jufF/asT86bDD8yffaufnvHMKN3Q82aWaCyD4yNKJne+Z
	oOXlQFMGAAOaQ0iLMFc/whIZwsZRfCihLqj+Ol5LM8f
X-Google-Smtp-Source: AGHT+IELO4yISZz+NofHK6C5sRr8016R68b1/4gVNR4ZG7rMts1wuKSLEVBc8+N5qzn2cwo5rC4hEXYji1cmxRvYCnw=
X-Received: by 2002:a05:600c:8219:b0:45a:2861:3625 with SMTP id
 5b1f17b1804b1-45b65ee0f36mr6131575e9.4.1756411142902; Thu, 28 Aug 2025
 12:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aLCiHMy12Ck3ouwC@hpe.com>
In-Reply-To: <aLCiHMy12Ck3ouwC@hpe.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 28 Aug 2025 12:58:50 -0700
X-Gm-Features: Ac12FXzKI2iUWzk8A5Vs745uV1abRMo4VLeJy6UKcLM1l6gTfbZW8s4ZlI0mr68
Message-ID: <CACw3F50kFq4V9+-JUdi+PEYbNUkOJZHPOy4VCowhKXW-sB=Ugw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memory-failure: Fix redundant updates for already
 poisoned pages
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: akpm@linux-foundation.org, linmiaohe@huawei.com, jane.chu@oracle.com, 
	bp@alien8.de, david@redhat.com, Liam.Howlett@oracle.com, 
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, nao.horiguchi@gmail.com, 
	osalvador@suse.de, rppt@kernel.org, russ.anderson@hpe.com, surenb@google.com, 
	tony.luck@intel.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 11:38=E2=80=AFAM Kyle Meyer <kyle.meyer@hpe.com> wr=
ote:
>
> Duplicate memory errors can be reported by multiple sources.
>
> Passing an already poisoned page to action_result() causes issues:
>
> * The amount of hardware corrupted memory is incorrectly updated.
> * Per NUMA node MF stats are incorrectly updated.
> * Redundant "already poisoned" messages are printed.
>
> Avoid those issues by:
>
> * Skipping hardware corrupted memory updates for already poisoned pages.
> * Skipping per NUMA node MF stats updates for already poisoned pages.
> * Dropping redundant "already poisoned" messages.
>
> Make MF_MSG_ALREADY_POISONED consistent with other action_page_types and
> make calls to action_result() consistent for already poisoned
> normal pages and huge pages.
>
> Fixes: b8b9488d50b7 ("mm/memory-failure: improve memory failure action_re=
sult messages")
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
>
> v1 -> v2:
>  * Continue passing poisoned pages to action_result() with MF_FAILED but =
don't
> update anything.
>  * https://lore.kernel.org/all/20250821164445.14467-1-kyle.meyer@hpe.com
>
> ---
>  mm/memory-failure.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index fc30ca4804bf..10b3c281c2ae 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -956,7 +956,7 @@ static const char * const action_page_types[] =3D {
>         [MF_MSG_BUDDY]                  =3D "free buddy page",
>         [MF_MSG_DAX]                    =3D "dax page",
>         [MF_MSG_UNSPLIT_THP]            =3D "unsplit thp",
> -       [MF_MSG_ALREADY_POISONED]       =3D "already poisoned",
> +       [MF_MSG_ALREADY_POISONED]       =3D "already poisoned page",
>         [MF_MSG_UNKNOWN]                =3D "unknown page",
>  };
>
> @@ -1349,9 +1349,10 @@ static int action_result(unsigned long pfn, enum m=
f_action_page_type type,
>  {
>         trace_memory_failure_event(pfn, type, result);
>
> -       num_poisoned_pages_inc(pfn);
> -
> -       update_per_node_mf_stats(pfn, result);
> +       if (type !=3D MF_MSG_ALREADY_POISONED) {
> +               num_poisoned_pages_inc(pfn);
> +               update_per_node_mf_stats(pfn, result);
> +       }

Thanks Kyle, the code looks good to me. While you wait for Miaohe's
review/ack...

Reviewed-by: Jiaqi Yan <jiaqiyan@google.com>

>
>         pr_err("%#lx: recovery action for %s: %s\n",
>                 pfn, action_page_types[type], action_name[result]);
> @@ -2094,12 +2095,11 @@ static int try_memory_failure_hugetlb(unsigned lo=
ng pfn, int flags, int *hugetlb
>                 *hugetlb =3D 0;
>                 return 0;
>         } else if (res =3D=3D -EHWPOISON) {
> -               pr_err("%#lx: already hardware poisoned\n", pfn);
>                 if (flags & MF_ACTION_REQUIRED) {
>                         folio =3D page_folio(p);
>                         res =3D kill_accessing_process(current, folio_pfn=
(folio), flags);
> -                       action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FA=
ILED);
>                 }
> +               action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
>                 return res;
>         } else if (res =3D=3D -EBUSY) {
>                 if (!(flags & MF_NO_RETRY)) {
> @@ -2285,7 +2285,6 @@ int memory_failure(unsigned long pfn, int flags)
>                 goto unlock_mutex;
>
>         if (TestSetPageHWPoison(p)) {
> -               pr_err("%#lx: already hardware poisoned\n", pfn);
>                 res =3D -EHWPOISON;
>                 if (flags & MF_ACTION_REQUIRED)
>                         res =3D kill_accessing_process(current, pfn, flag=
s);
> --
> 2.50.1
>

