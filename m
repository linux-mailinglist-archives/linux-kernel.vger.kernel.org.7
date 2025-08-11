Return-Path: <linux-kernel+bounces-761741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D64B1FDEF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4171650A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715191B0439;
	Mon, 11 Aug 2025 02:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lseXBTiG"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F10BEACD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754880064; cv=none; b=sujCRTj0ajebgmiEQm9sm4v2qKEo0JDQjCtJ6WCGiWO6ob2RkduH9KwvikJyMDYkPvtn1kodafDkdKVe9r0rj1WT6+2Uqij6CiA+6/E6g7y3Q+/pSqIpOn0TIsEalqFjfrqUliPVHL29GQa7ZFL/l3ErXzFXt3nUVkt37QTVj1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754880064; c=relaxed/simple;
	bh=cogBvEAt0ueMitb48hqO68W8a94umpG5+fVB0VQ21e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhmsN7cTJYRcorYbyQn/F/4yosA/i50FSwZ/mCZKRZZxDLU1J54B3sILtCYePKEvobXghjQ2QIA5pym5LUms0LGO87AQ9wP+K/zTuGWwdk0WQuSfo71KlY8nOnbsWEIeQ0BkRtkCggv+5Gb6fOHSQoSOO941ORFrHNJbEZyVRBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lseXBTiG; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5393a18c550so1015932e0c.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 19:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754880062; x=1755484862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEPO79lcAqliTFFVAgSx9X04AvKfXDh6E7nn3ae49xc=;
        b=lseXBTiG+XX2BN4CPru9yi0WAcm059IYOR2bZjCTRNInS951/hKN0KjC9FUf1H+dN1
         Wlm3sImGa/DBA1O63YA1D2VYyj+QOBWYM76HN0PBzAb/DaUGSrOAPoSVuYbTkhXiVqob
         YUz//mc/LxI5Q6iSdf2V/+6sj6hWSa7kdSQb8Q12b7JJavWmePW7DIGAMRC4VaEHkJE+
         4KDgS8+WKdM8U4YeR7xp5ecHgQmKEdPiwTfxIHZJf3vz+OLZYm/Vg9iFwKH5wdzWcD46
         8o36OsD4azqIFKt6yomiB++L0DPEg9DW97nQoAn71JoQ3uWQeMHT7agYIPfxx8HKtp6Q
         DP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754880062; x=1755484862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEPO79lcAqliTFFVAgSx9X04AvKfXDh6E7nn3ae49xc=;
        b=qIsuKLiZXzv6vTPtfq0r1BZOm91CDCY63LnNM5ryBS+qzAc//2UOgyzCKLD2VRyUKW
         DMu3ceMW9tJR1bdil98hwYR9wpJrvzbKzQ6wXzmJ4vieLv6szbcM3sGpYEGnHeg0Orfp
         n51megZh3Vjcj3LvcGNB/w1eCSdu6EpTyN2Uqls/XtNZtMbxCgM0xdxoZbXzW4XSifXa
         4H1ENj7ojxpkXrWYfi51l+HMsF4y99FE4FR4SbnpMBfTX5isQN2AVWtDQgd0+KSneFNY
         w52kUBrsJZDQHvYvUuxtmYik5tAFCVs9L3sOBquxdLvgbtkzZNyBfwNesXhY5JobLi6W
         oitQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXbIUUdPGrSgdadczdwGQ+f3rhvrRRXmeABgDL2Yk4hawpCSVqU/3Ihedi+IDV0LspahdGJObMj96T6lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjN9MH2lNgTfNX4VC8zQlLyfYPowmdxD6NTni62ljAR0cla5aF
	APqzEq4t+NvJGTEUH17UWAkNnO5nZcxNdRlITj2p35wpAJDrzTo1Yt0FffnG3aoYXFwwoQef1rY
	fpJ+V7GY75Ds/obiZJ2502O94PTHB/x4=
X-Gm-Gg: ASbGncs3uP6vvyojUv5Cs9rxEZg1qlbqMB/xWWjthTwT/XAOmfPVS4sk9ycf7C9Tbp5
	GSvirNHzvk4NJDTfVIT2yEbPZ0S5qj1B6NnEFXnL3epjfaGJOCxdxgLr3rPyUGF8glg312yjqQ6
	f+jW1pQl3IDWXFhE6Q3tSHwvsGZE/iFJvhSlNa1TeuqsUC//byhznwcRdR1Ed2dffWvGxjueOrY
	OSENUA=
X-Google-Smtp-Source: AGHT+IG9M12oTQKXjakVvm7O5EdRoYMgP2LrdwPJngQsDTIg4mJl6/p9kPCNEkiFHHbjllCvovPLKhqLUYDr9ffqJEs=
X-Received: by 2002:a05:6122:134c:b0:539:1142:21a1 with SMTP id
 71dfb90a1353d-53a4ac10d5amr3628046e0c.0.1754880061889; Sun, 10 Aug 2025
 19:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
In-Reply-To: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 11 Aug 2025 10:40:50 +0800
X-Gm-Features: Ac12FXxh4BM1Q0JSTNoPZLQDxlAY6NtAXyQ0P5zZ1A7rFzDEZOlSUIymDp7nKis
Message-ID: <CAGsJ_4zuEcgg7U0yCMu6ayKqRPACtvuzUsC9vUxBk2PgMzaf_Q@mail.gmail.com>
Subject: Re: [PATCH HOTFIX 6.17] mm/mremap: avoid expensive folio lookup on
 mremap folio pte batch
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 2:59=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> It was discovered in the attached report that commit f822a9a81a31 ("mm:
> optimize mremap() by PTE batching") introduced a significant performance
> regression on a number of metrics on x86-64, most notably
> stress-ng.bigheap.realloc_calls_per_sec - indicating a 37.3% regression i=
n
> number of mremap() calls per second.
>
> I was able to reproduce this locally on an intel x86-64 raptor lake syste=
m,
> noting an average of 143,857 realloc calls/sec (with a stddev of 4,531 or
> 3.1%) prior to this patch being applied, and 81,503 afterwards (stddev of
> 2,131 or 2.6%) - a 43.3% regression.
>
> During testing I was able to determine that there was no meaningful
> difference in efforts to optimise the folio_pte_batch() operation, nor
> checking folio_test_large().
>
> This is within expectation, as a regression this large is likely to
> indicate we are accessing memory that is not yet in a cache line (and
> perhaps may even cause a main memory fetch).
>
> The expectation by those discussing this from the start was that
> vm_normal_folio() (invoked by mremap_folio_pte_batch()) would likely be t=
he
> culprit due to having to retrieve memory from the vmemmap (which mremap()
> page table moves does not otherwise do, meaning this is inevitably cold
> memory).

If vm_normal_folio() is so expensive, does that mean it negates the
benefits that commit f822a9a81a31 (=E2=80=9Cmm: optimize mremap() by PTE
batching=E2=80=9D) was originally intended to achieve through PTE batching?

>
> I was able to definitively determine that this theory is indeed correct a=
nd
> the cause of the issue.
>
> The solution is to restore part of an approach previously discarded on
> review, that is to invoke pte_batch_hint() which explicitly determines,
> through reference to the PTE alone (thus no vmemmap lookup), what the PTE
> batch size may be.
>
> On platforms other than arm64 this is currently hardcoded to return 1, so
> this naturally resolves the issue for x86-64, and for arm64 introduces
> little to no overhead as the pte cache line will be hot.
>
> With this patch applied, we move from 81,503 realloc calls/sec to
> 138,701 (stddev of 496.1 or 0.4%), which is a -3.6% regression, however
> accounting for the variance in the original result, this is broadly
> restoring performance to its prior state.
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202508071609.4e743d7c-lkp@intel.co=
m
> Fixes: f822a9a81a31 ("mm: optimize mremap() by PTE batching")
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  mm/mremap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 677a4d744df9..9afa8cd524f5 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -179,6 +179,10 @@ static int mremap_folio_pte_batch(struct vm_area_str=
uct *vma, unsigned long addr
>         if (max_nr =3D=3D 1)
>                 return 1;
>
> +       /* Avoid expensive folio lookup if we stand no chance of benefit.=
 */
> +       if (pte_batch_hint(ptep, pte) =3D=3D 1)
> +               return 1;
> +
>         folio =3D vm_normal_folio(vma, addr, pte);
>         if (!folio || !folio_test_large(folio))
>                 return 1;
> --
> 2.50.1

Thanks
Barry

