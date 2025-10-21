Return-Path: <linux-kernel+bounces-863482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF5FBF7EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657E83A9E95
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BE034C804;
	Tue, 21 Oct 2025 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7pOF8pE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4734C158
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068567; cv=none; b=lsY53ZKxGRQu68YbhrZcWZuJnX4znLO2+Nu5G0Hdh8uE4XO5JwxL7v11NoXXrJu7as69aN5OZuvhQcgfr0nTDorfQyFDV9EA0gM8L+9Q8ZSn05dFrXOgtwywyYGLUslO1vsPfHKYUn5sOV9YWTi9q5HKYIMOWljIDRmyG5xcBQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068567; c=relaxed/simple;
	bh=6yMfeZc/A1x2rnTQfFoaUQo0K0SO1qyb2eAV4ai3+g0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iy52LqY8MlP909Ig4nP3b44r1Iv2uM3t/+FJv4oVPDwWnnA+UgS0iB6ze+lCbalqHbl5HESAhH1r3e8fy4OVxgspZhbyzDSbm+5vALYC3OlyDh12duiOK2DOwsEZat8YPYdnbOPpX6VnyO7rv3w+8BTc1iEMLKr3Kzn/aLuctuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B7pOF8pE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761068565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HKohHX5PQdAgp4BuzOw5sJB5TQe1jmIOtleJ46IHraQ=;
	b=B7pOF8pEEHWPUVvAP5nkrjowckIrvsF0pOZaDwUKAnayuhD8QUjcnG3GbvtBfFdhhKQ00Y
	vGAVH2C/QsRHBJLdsYKr9llUPV+svUYY8DyZUzlKQGoXAKhB+xv/OnkKBnDgMLv1Ly4aWi
	N+43Hgxu+gYtJEodJ2RA0YgbOk6B+Bk=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-RwsmaJnzPBmFhFTQpYXZ2Q-1; Tue, 21 Oct 2025 13:42:44 -0400
X-MC-Unique: RwsmaJnzPBmFhFTQpYXZ2Q-1
X-Mimecast-MFC-AGG-ID: RwsmaJnzPBmFhFTQpYXZ2Q_1761068563
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-63e0c5c5faeso7365686d50.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761068563; x=1761673363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKohHX5PQdAgp4BuzOw5sJB5TQe1jmIOtleJ46IHraQ=;
        b=fHS7+36b9NBy16a0MLVn0z8meG6S7/NLLsJDi6xU/X+PGVau0yReEel7pCd8GqVxV0
         ViYEn7WewRi5XxnY8WyqNWQFg2agtsXg/9QTy8n/MvSO6A2jxw/pE7Us/Lz1AgUAi6mE
         yp8Thm7OHYuL6PeAtlnnqpGiB7tKEuz1/e5zGfWbJ8vWR0ey5M44ZX54CFLNQT+XRm1k
         /fTTFJcLhKNmdkUVMfzF2ixPePBu+EfNoRFSRZWpOHFpIedybfQFj1wcJKsYb5aMZ0KA
         Do8DBTP56uvmieZj0klyPECSMD2LAekDnAszyfLqh3KGwxYO8w4m6h+UCbdVY5Nr8AQY
         tNcg==
X-Forwarded-Encrypted: i=1; AJvYcCVzgp2uqXFmDTjiKM1P2LD8izM7XAHQEofPxi+gdLbjTvP8+W+gk4OT1lHNXBnDJdzriPvfWadCRvJkKWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMoQKTutsoln+o5kwTeUhQDrMgs7RI8bwvyG9WIInudSodWK9J
	X1Nak887cFCZynXVuqMbWRw6PmDWhoarX4uxoFWWpVUmRYb0++n8cxdK2OWa+CVrAzNoJuntsBs
	m+L9p2455Nn7xhMtEvc6NtEZImh7VhPY/khlCedaa43Fx2aN9ad5Mto/qLLFzu5cBJauV+0TY/w
	g/VHWC+kutV3Qwt7paB7uhonX0guMTAVlNuhSKX5VD
X-Gm-Gg: ASbGncthjKqsRq3QP+Z0bJqIztH2bn7jl8GsycZRqVGXz15/ubu51AEH8gFVUNQzkgI
	WV2kI1W47m3KkU8tXZWBtWdUCws+XurCpbVxycRrb00JCOoN8cJVeidmqs3vgbLgqOOWoWBAenE
	8YwIBBb+O5u0OL1ELA8f6ck++Uqz2N+aWv/hLMidr3p9h8HNrSJZtHDqTJXXLuB75EazlupQ==
X-Received: by 2002:a05:690e:118e:b0:63e:27cf:8350 with SMTP id 956f58d0204a3-63e27cf848bmr9752781d50.51.1761068563399;
        Tue, 21 Oct 2025 10:42:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPeGWBwa5Vswr2rx8OIJkKxxwANwfGdn0lP1anQB7PC3Rr8+J3MWt2Uu35saaXOFAM5Burzjh2O4us/ANDTeA=
X-Received: by 2002:a05:690e:118e:b0:63e:27cf:8350 with SMTP id
 956f58d0204a3-63e27cf848bmr9752759d50.51.1761068562975; Tue, 21 Oct 2025
 10:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021134431.26488-1-leon.hwang@linux.dev>
In-Reply-To: <20251021134431.26488-1-leon.hwang@linux.dev>
From: Nico Pache <npache@redhat.com>
Date: Tue, 21 Oct 2025 11:42:16 -0600
X-Gm-Features: AS18NWAATySbKWIjDNiNWbHZ1s7hUwaBcjhshia5Gj7faitPCJK3Mblb9Kitkrc
Message-ID: <CAA1CXcAgjZ2o44ifY_Ay9MjgGT6q0vfrRBy=vxyecH68YcMYtQ@mail.gmail.com>
Subject: Re: [PATCH mm-new v2] mm/khugepaged: Factor out common logic in [scan,alloc]_sleep_millisecs_store()
To: Leon Hwang <leon.hwang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 7:45=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Both scan_sleep_millisecs_store() and alloc_sleep_millisecs_store()
> perform the same operations: parse the input value, update their
> respective sleep interval, reset khugepaged_sleep_expire, and wake up
> the khugepaged thread.
>
> Factor out this duplicated logic into a helper function
> __sleep_millisecs_store(), and simplify both store functions.
>
> No functional change intended.
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

Nice cleanup!

Acked-by: Nico Pache <npache@redhat.com>

> ---
> v1 -> v2:
>   - Simplify callsites of __sleep_millisecs_store() (per Lorenzo).
>   - Collect Reviewed-by from Lorenzo, Zi and Lance - thanks!
>   - https://lore.kernel.org/linux-mm/20251020115350.8175-1-leon.hwang@lin=
ux.dev/
>
>  mm/khugepaged.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6f2ae2238b5b..5b7276bc14b1 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -129,9 +129,8 @@ static ssize_t scan_sleep_millisecs_show(struct kobje=
ct *kobj,
>         return sysfs_emit(buf, "%u\n", khugepaged_scan_sleep_millisecs);
>  }
>
> -static ssize_t scan_sleep_millisecs_store(struct kobject *kobj,
> -                                         struct kobj_attribute *attr,
> -                                         const char *buf, size_t count)
> +static ssize_t __sleep_millisecs_store(const char *buf, size_t count,
> +                                      unsigned int *millisecs)
>  {
>         unsigned int msecs;
>         int err;
> @@ -140,12 +139,19 @@ static ssize_t scan_sleep_millisecs_store(struct ko=
bject *kobj,
>         if (err)
>                 return -EINVAL;
>
> -       khugepaged_scan_sleep_millisecs =3D msecs;
> +       *millisecs =3D msecs;
>         khugepaged_sleep_expire =3D 0;
>         wake_up_interruptible(&khugepaged_wait);
>
>         return count;
>  }
> +
> +static ssize_t scan_sleep_millisecs_store(struct kobject *kobj,
> +                                         struct kobj_attribute *attr,
> +                                         const char *buf, size_t count)
> +{
> +       return __sleep_millisecs_store(buf, count, &khugepaged_scan_sleep=
_millisecs);
> +}
>  static struct kobj_attribute scan_sleep_millisecs_attr =3D
>         __ATTR_RW(scan_sleep_millisecs);
>
> @@ -160,18 +166,7 @@ static ssize_t alloc_sleep_millisecs_store(struct ko=
bject *kobj,
>                                            struct kobj_attribute *attr,
>                                            const char *buf, size_t count)
>  {
> -       unsigned int msecs;
> -       int err;
> -
> -       err =3D kstrtouint(buf, 10, &msecs);
> -       if (err)
> -               return -EINVAL;
> -
> -       khugepaged_alloc_sleep_millisecs =3D msecs;
> -       khugepaged_sleep_expire =3D 0;
> -       wake_up_interruptible(&khugepaged_wait);
> -
> -       return count;
> +       return __sleep_millisecs_store(buf, count, &khugepaged_alloc_slee=
p_millisecs);
>  }
>  static struct kobj_attribute alloc_sleep_millisecs_attr =3D
>         __ATTR_RW(alloc_sleep_millisecs);
> --
> 2.51.0
>


