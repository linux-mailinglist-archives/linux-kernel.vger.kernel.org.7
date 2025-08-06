Return-Path: <linux-kernel+bounces-758025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B96BCB1C9DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA70A7A9B17
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7DB299952;
	Wed,  6 Aug 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOaslUIS"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4AA23F424
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754498472; cv=none; b=YZ2zUKEcRebAw5KCI5W+K49TnH0SmWOl/9UqPM9svY6KCWxNrvBzN8rUV14OUzFPtmJ5xlBqz905Av8jcMzfhsWtqEfe7urzzj/F76js9066UQRTbz2iTEWqhpQX4ffdZus6ZshF2YDRrB2JQTa92UASil9IuUwhMSWF4kOIxfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754498472; c=relaxed/simple;
	bh=rcbhhWO3sInLq+c0K9StwvtwXmBD3WCh+nTvUzuXAx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6aAipg2nUvO36YQnGeC5hFUmBRhFvqEb7fapfIrf8fPrarOhT0bJwwQulS7bEfthtPI1hlecSVjMkN9fBLsJ9HeyS9w1vbe7H3hxxb+P0/bizUSCQu3aFCpiHrUoVtEFLE7aUBUeoAMm8nzfcU91Iv1CshRA1dc6Hl1SdSWru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOaslUIS; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-433f3bc84e0so85720b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754498469; x=1755103269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKjnlbXnuZDOVwbZXpA57f2rMGHXfB9Dj3veqVS6tjI=;
        b=lOaslUISuO2/MSsyRH5JzTq7aK45Cw18OOmMlM6d9S2u23irPAEm4oSUGH4XlPJy4N
         Iq3rNkrzVgi64WVdOm1S42pcnO7f5rT9ucSEW8L7ds18xgU1XEm0d/vO1pXkVsq3wlZf
         NUalpZlDBU060NwQ7RCyzOaiGaYVIjRWwzschGjDH/VlqPpwDHEeAShgeYNSVsFCskI9
         1mab5F49z85TBlLgy/Y1ob1pj5w27o+N1vSKZr1ChRzFT9R3H6STP8kexRmFjnBOqRi1
         bb99ojtzXCV8NbvdBGVnmhmFEsWdgkiUq285+fYjSg45PVwe3VUsLRaAlbLaawPk8KMq
         EuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754498469; x=1755103269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKjnlbXnuZDOVwbZXpA57f2rMGHXfB9Dj3veqVS6tjI=;
        b=pC5udFjd9ij0XhQxeeSiUa5KvSHFr3y6/nm4vF4AoYdJNIe8DduXGuAuGAOklFcFi2
         BjgM+apvRXHe0U97wVjMr7LnJ2ZqgwVHiqr3nxmn5yARuEVU0Wm3w6e+BjWRIV3jywMO
         h3QSRUQ+Ta1enDRl3ZZz9qPkQyjLXbB4ismZjCPmMEm5PkSfZAbvTB4aKQOlKMLy3QJU
         12q5Trt3fUpYmqVO88PVFLzQwd51945PdydHHBbfn6uIwENN0P807x3I176ZI9+Ihu6u
         FamBrt9vw/2QdkFE54aWPW2NxmoEh6ph/7tICPVuQa4pAk5YqU59GaPx2rK0Sx3JxnCg
         sQtw==
X-Forwarded-Encrypted: i=1; AJvYcCWslYKeXsVBf7IslX2bU6Hf6SoFqH64PrML+1xumnCQoYIWjAG14dmLChHm4M2IkHtsUyIa5/fIeguJYHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+75/t+qdNpwEOr80GhY0Ub+ra3opzI0B/FNo6uOXPx72A8VM
	vRuQ0dpV0oM4XBQ96pS4d9ii8IrJ2OmYMhp0UVwLx4sZorH0N3mXNooMostJiAThKTjCYu+KIlf
	bR+Xp+C8+ef5qRElGeOjRSUs3ISerfZE=
X-Gm-Gg: ASbGncs6ZlK1Ags7TBEgwK55rL7w8TSrvm1RBr21zn2q0tHypeXZ3Q6PFiEv1H7eqSj
	HQbapYD8WIZGrk6nqx2SSiDlZKB+0LYLrPr53SwyZFiQP/6G6KwBrsDX1mGZLF9kqsr86/0588a
	mQIL0TpnJlUi4+ga5px13KZqmBacuZeUaezjcFqYcr2tpiz22H10o/Ci8AA+csFZKCn14W6zhyH
	vRfqdw=
X-Google-Smtp-Source: AGHT+IHBrOu7yFP0WeByjmPefTQVEwMJNMXNbJH0N++jTBTymV1JO4pREkUjYBUyktFlTHy2+iLdO7/FhC+BPbomTRw=
X-Received: by 2002:a05:6808:4f54:b0:434:bef0:2f0 with SMTP id
 5614622812f47-4357c2d732bmr2028110b6e.6.1754498469571; Wed, 06 Aug 2025
 09:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806161748.76651-1-ryncsn@gmail.com> <20250806161748.76651-3-ryncsn@gmail.com>
In-Reply-To: <20250806161748.76651-3-ryncsn@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 6 Aug 2025 09:40:57 -0700
X-Gm-Features: Ac12FXx6LKiBeTs1LYzlP5VfWgE4JIbB2kDZOxmdeXAg57zMCFN1ArHE8cj7vwk
Message-ID: <CAKEwX=N8sUdAfgGdHs+S3Sr62AJ94+6nbP62Smv_z0xxzz_t4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm, swap: remove fragment clusters counter
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 9:18=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> From: Kairui Song <kasong@tencent.com>
>
> It was used for calculating the iteration number when the swap allocator
> wants to scan the whole fragment list. Now the allocator only scans one
> fragment cluster at a time, so no one uses this counter anymore.
>
> Remove it as a cleanup; the performance change is marginal:
>
> Build linux kernel using 10G ZRAM, make -j96, defconfig with 2G cgroup
> memory limit, on top of tmpfs, 64kB mTHP enabled:
>
> Before:  sys time: 6278.45s
> After:   sys time: 6176.34s
>
> Change to 8G ZRAM:
>
> Before:  sys time: 5572.85s
> After:   sys time: 5531.49s
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

