Return-Path: <linux-kernel+bounces-726592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE270B00F08
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198E616EAC0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9287B28FABA;
	Thu, 10 Jul 2025 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2VjfGeBT"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530DF1D432D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187816; cv=none; b=gzsnvaTDHxavCgt/kNsG95JRHMNveQ1LqdwIl5nyHM0tfCd1WV8aszivk3OHu/Xbh38C3xqxCf/Va/dRldwKJCjWzFaIksVIh258wvvxU4DhjI33e898luxJJyUT6H5qkQqQkdeYKm05DHzsvvQXMJLZ0KHX938lfxniU+puXNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187816; c=relaxed/simple;
	bh=6k+yvKiEGjlCmNBLH8ibiPw3tKuW0PRb4arVjEcAMbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSc+vINdrKbQdVP6VVyqBzOufiEzruNBl/k+XcsF3T4QKO7PZv8zf1Mb4ooPMlIbOo9SN9hiR345td6gPLq+OWb1IxB2zVXUFZL82hlHq9IkxAkyD93Q+Ry+ATm4uK5tX7v1HzSbvKM8RYMRMAEER4FAQnyLanmp+k1rxjrMy5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2VjfGeBT; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a9e8459f28so128301cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752187813; x=1752792613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYpjEn88cxKSZZ/B6NkChJLl7t99A1EwGgw5xpGtDAU=;
        b=2VjfGeBTCve6KUKL4qHWJtSiZIRjp4pKqpRDx3n9h5syJdnxWTeZ0Em1kA0AcviVZ9
         BoiqoLejks/zJgs0SvND+oFXH7lOVI4vJzVw7pAsuS8TMySkhdEAgbAYkFU8JQCniLz7
         lJaLMcdVnVDlexU/7BtBz1PpQ45KLYL0JrQpU2pPUsun3EgfCsRo0mxtzE5B6cBcV71M
         4f8o3MMoD026jfBxTeZT2gjE2XcvDOBctg4/tB/lsGtW0sav/k+Pf5SHRf6SuxNyFigK
         DPN0jei1piqWrQqaIJwT1CN7YjWbowltj2CsztP669C3p3sb0P9zGtfet/CG2mMYYzUX
         M3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187813; x=1752792613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYpjEn88cxKSZZ/B6NkChJLl7t99A1EwGgw5xpGtDAU=;
        b=G5Aa+lcCf0HvyEDtExYgHwz7xf7G1+biVQHC+jdB7d0r5RUs3iwirg24FH/yKSyObQ
         iNdcZp9QxuZCbot1UF4gzvHvygMfxjb+oEVzm6Vn6Xn70mDh8GZ0uNzOv16nL5nVatzj
         b6fA4uvoxqRD6922VnyVjsDaqRu4wCZVf+XubdNcmcZIDlMLTqQUpuLbTm6jCn8G4k1x
         DyMd33WjQiySFwEfabonTmHGbjG9zigd2+r8FgRAYHiWG+PB1EplE4SMIBePfdzNdVrs
         Dlhd0TjX0kceJtGTEOzqxW9zoOdiPVQlS0LdOCy/JxLKWj2zSPD8LF0EUY1/IHMimOpi
         q5QA==
X-Forwarded-Encrypted: i=1; AJvYcCWhhFeOOaLbZ/nA4biXmVZlIcldWeM69Cj3QVu9/HFgAKcTOYIeKTgIzFmd2nMMHCnQPF0b4M5G5jW14Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoB5Wcu0lgQ5UodozORt6EQGhQt91sPteMaJLr/eN4sriCYH1V
	n/qNWCzlvMzchJO7/Vc7FwtPJ9BcX46ZkicBGivBe4MAk9LH7KD2Np3f0dXIiWrd9rWg++a9Nnu
	vvC7pOpp0knYgn6yVk7OE3q3PPp4AgHk46AgvoTM+
X-Gm-Gg: ASbGncsQFzGHwAXgZRUYIaGk7DvMsQ41/hXi68AhtDSZjDpuN85LLeRAJa3yFLCcucG
	o10XcVEnWrH4uCoVnrYEkjqu+eRR35G9QdaX1PYrtxnoGtABk0MNmNgtfNbA8xYplYlGngj33Ro
	qCNo1EMmnvLwAAcOnhUXL6WF1dG2neoMmudPYkZxB4khjFstLWY5v5G2Zf5QLgDl+s7mgNTj61q
	+E2XQ==
X-Google-Smtp-Source: AGHT+IFJ+GIH08Q93yw1aKv49aCnim80ePlY0qR39QylTSlZvdcHTY6+wZL5hmQgDEnMuTrMcArJu7TwqGrnC3LprT8=
X-Received: by 2002:a05:622a:7d8c:b0:4a5:a9f4:b7c2 with SMTP id
 d75a77b69052e-4aa35e062e4mr477031cf.17.1752187812532; Thu, 10 Jul 2025
 15:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703023946.65315-1-jiahao.kernel@gmail.com>
In-Reply-To: <20250703023946.65315-1-jiahao.kernel@gmail.com>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Thu, 10 Jul 2025 15:49:36 -0700
X-Gm-Features: Ac12FXzTGOYUKLnZHR8owxernOgT6vdMzRe_1JRpV9KHcx557604Zy1xnBC1seQ
Message-ID: <CAJHvVcgoGwnk4TdZxj=Lvhny4sus0eZ=MbuWEVK0m6fACLFRow@mail.gmail.com>
Subject: Re: [PATCH v2] mm/mglru: Stop try_to_inc_min_seq() if min_seq[type]
 has not increased
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, yuzhao@google.com, yuanchu@google.com, 
	shakeel.butt@linux.dev, mhocko@kernel.org, lorenzo.stoakes@oracle.com, 
	kinseyho@google.com, hannes@cmpxchg.org, gthelen@google.com, david@redhat.com, 
	zhengqi.arch@bytedance.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 7:40=E2=80=AFPM Hao Jia <jiahao.kernel@gmail.com> wr=
ote:
>
> From: Hao Jia <jiahao1@lixiang.com>
>
> In try_to_inc_min_seq(), if min_seq[type] has not increased. In other
> words, min_seq[type] =3D=3D lrugen->min_seq[type]. Then we should return
> directly to avoid unnecessary overhead later.
>
> Corollary: If min_seq[type] of both anonymous and file is not increased,
> try_to_inc_min_seq() will fail.
>
> Proof:
> It is known that min_seq[type] has not increased, that is, min_seq[type]
> is equal to lrugen->min_seq[type], then the following:
>
> case 1: min_seq[type] has not been reassigned and changed before
> judgment min_seq[type] <=3D lrugen->min_seq[type].
> Then the subsequent min_seq[type] <=3D lrugen->min_seq[type] judgment
> will always be true.
>
> case 2: min_seq[type] is reassigned to seq, before judgment
> min_seq[type] <=3D lrugen->min_seq[type].
> Then at least the condition of min_seq[type] > seq must be met
> before min_seq[type] will be reassigned to seq.
> That is to say, before the reassignment, lrugen->min_seq[type] > seq
> is met, and then min_seq[type] =3D seq.
> Then the following min_seq[type](seq) <=3D lrugen->min_seq[type] judgment
> is always true.
>
> Therefore, in try_to_inc_min_seq(), If min_seq[type] of both anonymous
> and file is not increased, we can return false directly to avoid
> unnecessary overhead.
>
> Suggested-by: Yuanchu Xie <yuanchu@google.com>
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
> ---
> v1 to v2:
>  - Modify commit message to make proof clearer.
>  - Use one bool to detect any increments in min_seq[type], suggested by Y=
uanchu Xie.
>
> Link to v1: https://lore.kernel.org/all/20250630080603.36171-1-jiahao.ker=
nel@gmail.com
>
>  mm/vmscan.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d48e8d365502..d5b6924aeb8f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3919,6 +3919,7 @@ static bool try_to_inc_min_seq(struct lruvec *lruve=
c, int swappiness)
>  {
>         int gen, type, zone;
>         bool success =3D false;
> +       bool seq_inc_flag =3D false;
>         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
>         DEFINE_MIN_SEQ(lruvec);
>
> @@ -3935,11 +3936,20 @@ static bool try_to_inc_min_seq(struct lruvec *lru=
vec, int swappiness)
>                         }
>
>                         min_seq[type]++;
> +                       seq_inc_flag =3D true;
>                 }
>  next:
>                 ;
>         }
>
> +       /*
> +        * If min_seq[type] of both anonymous and file is not increased,
> +        * we can directly return false to avoid unnecessary checking
> +        * overhead later.
> +        */

I think we can make this comment (and probably the commit message) even sim=
pler.

try_to_inc_min_seq (and inc_min_seq) are both called under lru_lock,
so I don't think there can be any concurrent modifications going on.
(Note readers don't necessarily take the lock though.) So I think we
can simply state it like:

"If we didn't change any min_seq, we can return immediately."

This patch had caused me to think we can do even more to make this
function simpler, but I spent an hour fiddling with it and I don't
have any concrete suggestions. So, I see no reason to hold up this
patch, it seems straightforwardly correct to me. Any further
simplification could just be a follow up patch later.

You can take:
Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

> +       if (!seq_inc_flag)
> +               return success;
> +
>         /* see the comment on lru_gen_folio */
>         if (swappiness && swappiness <=3D MAX_SWAPPINESS) {
>                 unsigned long seq =3D lrugen->max_seq - MIN_NR_GENS;
> --
> 2.34.1
>

