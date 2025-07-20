Return-Path: <linux-kernel+bounces-738515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44AEB0B975
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 01:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED00C171642
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 23:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5E9221540;
	Sun, 20 Jul 2025 23:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBz6Uhjv"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C341A27462
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 23:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753055994; cv=none; b=JAU7HCZzv6tVD9dk71WozWzkq0E+OhHUphuuU8y/YDRTqkuhDssztPue/yzl7h8yooMRIh0JYhNtEptrr0DuQWxVOOFOfWOWJ2tQWMv+TgGQQ0r56o3q9W27YisMn554aStt/ZdvMnBqCthGj0Qi2os8ebqP5HaBy7cMas7GqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753055994; c=relaxed/simple;
	bh=yyP0cAHLjLGTXIwsqoVsYbivIjDmWqE3USO5jFPSehM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9nRJJzpO+4RQ5Pk1Qq3KNmW0OHFsBqR0jfMHfOzD919T3BAp1Pl/G+V6+LLOoIIsG7tUxpkqRA8zYpv1OjEKYoSZdoYx+JpkpC7IDy6v9qS0R4Q8Z5wel7QjzzSrdWt7fEtaaUO10oDo8LtsW2ogW9eFUFbOxtNmz3ScVbBLdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBz6Uhjv; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-88131f0badcso5769940241.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 16:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753055991; x=1753660791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMDu15B94CMFfjtDZHBtBYYs1+zD5YCySOnFKbF30Fk=;
        b=KBz6UhjvuDHkirIIABdVSNTKXolo4NcxL+MSa87K+pqa08erFfQnXHCeWkbeNP85zn
         gJz/xAuQ/oay9qEkknzLzczbiLbks1PxLjXN3R7rSp+S4dpCC25qumlgCAZem/TDCHN3
         lbxlrqV5d0ffcDhk7Pd0vMB2uIx4WC+qeeH4qTNjU4KpfSzwiMQMeGyUf/dZdrPjR8Pf
         g1ap6cY8iGbrInXIveeBI29g92aRe9y7qsK3Ot27oVqE2BWspBzqqGSO4UNxCupe6kne
         4Izd7rl3hsg7aveWBnDEruETW8KNl4vF+7YZVLeDQEPoCbqUiTe5nFERMs+0Ftw3ZW8g
         fOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753055991; x=1753660791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMDu15B94CMFfjtDZHBtBYYs1+zD5YCySOnFKbF30Fk=;
        b=Wg/JRuppUXhCbV9cVXq8ZJ+UvVtPCH81wN0OLca3PSdcXT6WYV7NWi8UqsV8xvq3gN
         CsYaB62sMXM7x9slnelTCSvodBzCJaHSk4mm0NojJoD++HcoEA4N7qTlGRM9fki/ySYt
         eNfJD4Yw6Vmo+9lY65kc/Ax+rwfqGmyIvcpEuSwiXKAFxRazhlxZ3UXI9PuUBeGcA0B+
         uhSeJNJyxTiO+tQwsPBt8EYpRKoXLMayubO5DnkAfdp9ZbgJmQ1R0a2Jf9wuxxycnzt1
         4XXre2TvzIaqFXTC7wEWq3px5AfKU8A3Jf6pBqgDUrIXbOb121kEw70HlricAN2R6KWs
         /TSw==
X-Forwarded-Encrypted: i=1; AJvYcCUa8YCU36DwGZZbaN3kdfIXwK4c+iYxfMm6F6uA0HQb86CixBx+Az1HiEjPEaqLZstHWpgYGFhFRv6WsYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUwsj/Pn1cIKFgszkYTKOzQOf0aMydtc8Bti1zKE7lK+/eBlmC
	FcQWUWrNJhRSu74OwmEmxq5zdTwltFxku3mI9XxO4DfMDumvL8+6cV1ypO2SLX15Fs0aFxQn481
	derMAMP0eCOhmu9tzTcI6XCQlWs5oeo7vJBg57Gk=
X-Gm-Gg: ASbGncutDFNY0zN2uO37lDtHM6mVGAXwemIv00JfY1JeZvrJ1M9FRIdegvlvUBM2X6E
	vmqxTIerb5sdv0oOGx2VJqcc78fJU0yP8xY6MjipqXgfHyCasMgwjbIsSljL+u9BByBIi1Sr7vx
	uOrWxUa6F9K+qnbQuzpfgCJd6TwkDhKoXlDYivRu5SsTR4x+uKCTBNZ+Hof2EmeWs5eJra+0xrO
	47QCBM=
X-Google-Smtp-Source: AGHT+IG7L0m6HoBIB4Bw4NGY3fjZtWacuz0hzTbVUc6/5aUuTbOVmBAoM4nq8umtZuw19e9HBRzvUyaNBDZrSXYi79s=
X-Received: by 2002:a05:6102:5490:b0:4e9:b66d:3c11 with SMTP id
 ada2fe7eead31-4f95f41a4bemr9512749137.19.1753055991556; Sun, 20 Jul 2025
 16:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718090244.21092-1-dev.jain@arm.com> <20250718090244.21092-4-dev.jain@arm.com>
In-Reply-To: <20250718090244.21092-4-dev.jain@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 21 Jul 2025 07:59:39 +0800
X-Gm-Features: Ac12FXyjRyO4euuMXuvHEdYT2dtlu9tE6s7OP6fEeHvddqbhgMqFlrnYNQfVQPE
Message-ID: <CAGsJ_4xiUZzQNR57qpebcwKxV1T_S90j-=Z0EQ0s=1u3Q7rG8w@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] mm: Add batched versions of ptep_modify_prot_start/commit
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com, 
	willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com, 
	anshuman.khandual@arm.com, peterx@redhat.com, joey.gouly@arm.com, 
	ioworker0@gmail.com, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, 
	christophe.leroy@csgroup.eu, yangyicong@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, hughd@google.com, 
	yang@os.amperecomputing.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 5:03=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
> Batch ptep_modify_prot_start/commit in preparation for optimizing mprotec=
t,
> implementing them as a simple loop over the corresponding single pte
> helpers. Architecture may override these helpers.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  include/linux/pgtable.h | 84 ++++++++++++++++++++++++++++++++++++++++-
>  mm/mprotect.c           |  4 +-
>  2 files changed, 85 insertions(+), 3 deletions(-)
>

[...]

> +#ifndef modify_prot_start_ptes
> +static inline pte_t modify_prot_start_ptes(struct vm_area_struct *vma,
> +               unsigned long addr, pte_t *ptep, unsigned int nr)
> +{
> +       pte_t pte, tmp_pte;
> +
> +       pte =3D ptep_modify_prot_start(vma, addr, ptep);
> +       while (--nr) {
> +               ptep++;
> +               addr +=3D PAGE_SIZE;
> +               tmp_pte =3D ptep_modify_prot_start(vma, addr, ptep);
> +               if (pte_dirty(tmp_pte))
> +                       pte =3D pte_mkdirty(pte);
> +               if (pte_young(tmp_pte))
> +                       pte =3D pte_mkyoung(pte);

It might be interesting to explore whether a similar optimization
could apply here as well:
https://lore.kernel.org/linux-mm/20250624152549.2647828-1-xavier.qyxia@gmai=
l.com/
I suspect it would, but it's probably not worth including in this
patch.

> +       }
> +       return pte;
> +}
> +#endif
> +

Thanks
Barry

