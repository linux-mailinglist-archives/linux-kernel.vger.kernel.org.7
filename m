Return-Path: <linux-kernel+bounces-788409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71158B383F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D949821BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3487306D37;
	Wed, 27 Aug 2025 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAMKJVgS"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE9228F1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302417; cv=none; b=QkHw3ktJhEyOi/RYxShUeuXD9uWXnrb22fHt43Z5aLAwJhsZKT5WqNyRQiK6GvFm4wM/HuHO+pINGNAqhwFpo4uqSM+pcclZ21Yos0nYKtjicCPx12xE6PKiF4IdEb8ZFd5S6sd09ZbLxijGp0jRDPQHuwYt0pYqrTNzbfqMDuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302417; c=relaxed/simple;
	bh=ajtTmcH0Rw+RQP6CIk/J5eUechM69LLIqZ8n3NZbgqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBn8RPsIHe4FJdJW0SViQ1ZSGk3cimrT+Ym1pbE3B/LZ0x+H9KeCNbq2jJzny7ZeHIe4lzw8JCJCdImXMrKOwL1/67Z9Zesn3KflwmYJkRAYacK45ulFvLYHZt3WwyVifgQEEVgNYv5t8734P/FSp+TC281rmBjC23pWS18zDGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAMKJVgS; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3367e0f9c1cso21340851fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756302414; x=1756907214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWdtgwMC4xOmfKmxCHPIWNUnKj2dqPGspbwOLyOacsE=;
        b=hAMKJVgSMD43pAXkIuw1z0LMvalEuD9o6c+Jvi5ZH3BHJeGBK6FS//hxAcIBLxxVQv
         6wHj9sCiKjekNZajKLo6zqGWNAsjmDJ/xsWKLcJS1xp19qu7q2Nh4I9GMzyI5CQ2dhQb
         TdDBikFcnmnJnuklue53cdR+Yhle/TZonO/zUdD5EbcvXMFnp1Lecai8VLNnoRK6yQTF
         UzKLTPrik74RJCXNkN8NNp1J5BjCZ5fNxVrTKHR84fZAt3mRnViCxHpRcaeqTZOdUYDO
         y+7Od6iA4skaCuCZKj5fCYUiX42Yi9EVVK4NCDq3osXgoledTEissNpSmIp8lH+GlO/o
         YvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756302414; x=1756907214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWdtgwMC4xOmfKmxCHPIWNUnKj2dqPGspbwOLyOacsE=;
        b=uNdtPrwraKHpgRghBl1kMbaFEkycMxwgIu2MN2ZTj4CyttALny9Cx2YMKygJ7gQ2rV
         USmrbfW4DpGqxc3lFn3HAvjIHlO19z276gu/zvY46eSRgCd0ukfISLreyfF5K/PUWfUQ
         Ul8QYufbZiMMG1O9O8rosDA02RKfkwSHOtpXkJR6QGKDWEDd7ZGkUFEwlyg0wH83SaJG
         qCK9FXhxjIyRJy3Pb5QlaqrdEdxDJrP0MzK3wamPs4w9ieXyLcZ53p1+n6u58hxvj3fe
         PwpEVZHdaBFCP17Q9q96exNbpse1ej2NBA5JjEpp2Sdxg3tMzLWc8xHOxmRblDOhIf3J
         IDgw==
X-Forwarded-Encrypted: i=1; AJvYcCVbk/bYlG1Px+DKdhGhAhRkQ1k+wKuFW+fij8o8KbW1dluKs5PpWYGb2BY/R8WTwwnDqU5Y3gbsb8AD3+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+LZ4q0vrAXlJYGHNNTIrfflPCDCCw69OTM9tw3tLRWAM1Nnfw
	/FNv2SE91HuEIhI7NePhLVnJG2iHnY1rre2IduQ4ABl8U1VDGKI/I4Qk+hADIDRzKXVCi5K1F5s
	tABg5ZKwqFMyiObZ3spkKt8Wf64maH6k=
X-Gm-Gg: ASbGncsGUyXzbcaczHwtifeHbKGNrFi62Vwbc3OJdOkVY6QwtF5qYjQBjLRANHwKakp
	l1DjLx1c8v9ul6H+eFOXycJkT8svTLXkNOq8hBG6U5wQJQth17W79dgRHKaxadaSDyTWEFHNich
	Ek9IYNMoj1fSgYdH3I2AInIJmP1FobNHwWSubz5k11b9phZeydGAEmRXPOZ6GOkwhF9MCHAMaRP
	gpm9xQ=
X-Google-Smtp-Source: AGHT+IFjPl2md36EjKemozMYhYwDLSCZh2KeLt3TyuHDY9I2P4jqHFGfc3BYtzJxAKzHDYtC6+Y3UQVaMl8l54xjk0g=
X-Received: by 2002:a2e:a4b7:0:b0:336:8c6d:dfe3 with SMTP id
 38308e7fff4ca-3368c6de41emr11268681fa.18.1756302413473; Wed, 27 Aug 2025
 06:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-2-ryncsn@gmail.com>
 <aK6A76NVcV2j+J57@MiWiFi-R3L-srv>
In-Reply-To: <aK6A76NVcV2j+J57@MiWiFi-R3L-srv>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 27 Aug 2025 21:46:16 +0800
X-Gm-Features: Ac12FXyR4V0OeH51yDQpMdfxm3IPqgbIMY4zg2e5mYKtqWnw1-Pko8dcKcOhbWI
Message-ID: <CAMgjq7D93cj6CHxJDKc1ax5SCeb9QvFt38YWQM_rrF7SRi+zCA@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm, swap: use unified helper for swap cache look up
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 12:48=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> On 08/23/25 at 03:20am, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> ......snip...
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 99513b74b5d8..ff9eb761a103 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -69,6 +69,21 @@ void show_swap_cache_info(void)
> >       printk("Total swap =3D %lukB\n", K(total_swap_pages));
> >  }
> >
> > +/*
> > + * Lookup a swap entry in the swap cache. A found folio will be return=
ed
>
> Lookup is a noun, we should use 'look up' which is a verb here instead?

Hi Baoquan,

I just checked filemap.c to see how page cache helpers describe
themselves, 'Look up' is better indeed. Thanks for the review.

