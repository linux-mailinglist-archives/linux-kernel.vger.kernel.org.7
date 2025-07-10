Return-Path: <linux-kernel+bounces-726301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0BFB00B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01B71CA2430
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EB42FCE14;
	Thu, 10 Jul 2025 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qObU1zue"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E052F1FDD
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171986; cv=none; b=lxd2FWX3K/4SYyy5HnR+VNrRYGiiaOoi9cxCmwkiiDuQx+zYfUZg75j4i4bTr4egUyTpO6eouZHW6JK9U1fj9ywRv0Nw++HebMb28YQ2/ZvgYcWXcPpIuIob330dgkavL3guRjn8Na7qSv3Hh9j/qUi2qNV8aqsJ3U5IKo7Euh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171986; c=relaxed/simple;
	bh=DQ/y57eCcvCivMqXieykxCIkDza/1dPM5uPabJRz16o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5vmrD6cQHVE58occKxLcoPIJOTMyhyX22LCshyZYKzxiPn0XcH43++sUeAE6U2opVYRtGzzODtqBkTNCeYAf7IPR1AInUOZZhqkvOnoiShPEq7kUixpds3srTZ6fFv/b+o/zPM2Xf8E5Vi0WuS6MuaLmGBP7BzV7HFjK8BDQdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qObU1zue; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso1515a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752171983; x=1752776783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpVeUDzlloshth7hyY4uUrRygX8GK+L0hY7EdHxCTWk=;
        b=qObU1zuerGhbYWlfulILtsMApJEO572cb99Ey657M5ZIW5FJn9qSNnybTUmZwPXmoo
         6P1pcpOL17ZItstd3CjuuSqb+erRZa4J7rQHM4ORASF5f11JNxKu0xDSlD/J1YA71gHW
         fRONoNj2vmMzTagcuqJ8ulV5PLMfLTdVZdq9OlnKV82aY69cKtL9CZ7kzUANxH271wGA
         P/Hks07foD1XCHZENTyruReqQLmOfQkLM1ii2gdSVPyMb9nohjNE0lRXOR4A/JvkN58F
         LwP+GaUG6r4NOEEdxPUCvO054zG9vCYleh3rFncue61UmbDCdFOBqnJEfIScIY/iHIC5
         JcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752171983; x=1752776783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpVeUDzlloshth7hyY4uUrRygX8GK+L0hY7EdHxCTWk=;
        b=kmt/eid0Vbq8hLLToBrPPFxRKsoz4PZS4SJqCubOiewrnCuhDKrst18RnguIbMzTrq
         zm0FtraoAoalHyaR4qWxHDHpMMiU/H1EBXLhXfXYFGW8nJRNBczZd5ZWbTVHWNq8JsYB
         iNXb1NgkUM3hoEGZxV5dMCc+tAVKPVpSQSxGTKKjpTpLZgqRsb0lymIxQCJcS0YK+bGD
         oN/0RoqcbFagtykXkR878t3dTjWTBM1pc6YmY3wi7JrxBlpvmlkU/T/tHRGY3wNTUV+L
         ZKDclESaw9OTSRVL+GQCqEKcPR3mbenX9/Gv7wqZHsx1euAnFj4Pr9KlRogL7s0DTJl9
         cklw==
X-Forwarded-Encrypted: i=1; AJvYcCVOCdjT7Vc0ZX/ki7UhG5uR7s4GmzQZXXp1z4EH/0yKtB6trHkUfx1cBwjqahLwBEisH5PM79JKlA17GHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI4Cyto/0A4S1nMq57UtEGwaN8nh6XWl3F4BITsouwf8RkJnBQ
	sx46sBboxeX/OB6mh0BE1yla2wvzCioqRhuawvnWQLqRI/8kfrajkcMXCAQwmfaVyw46bTEERR3
	k00j/geZhUl06bi3gWrbh6/GgAW2vFYr1DGpjtcBu
X-Gm-Gg: ASbGncsEMlMsZyO32o0XMJ+r6C6tw6cFCZCm5i/pox1OXftMJAtrAfGv8acP9M+8G84
	5K+/Z0uH8nZvf+T/ZIMygqxBIrBzOeG4rqAsoxsmTdwJTuR8Tmm3od7v2fJdA4QiRsDaayU+d0f
	1ECWZXzb9JDZJIeIlmKBk2h9h3rBTQHPIk8DPFokIANaD98DkXdCh3GaJF5VM1q0p7J0z6Yfg=
X-Google-Smtp-Source: AGHT+IFt7W8JAheHiVqwt4ZBR3CQtXpumX/T7A5/rBmH2QebswkJBxnWs6YN36d9U3n7K42s+O7r2vNQ3sha7Qd9AVA=
X-Received: by 2002:a05:6402:24d3:b0:607:d206:7657 with SMTP id
 4fb4d7f45d1cf-611e687e614mr10195a12.2.1752171982710; Thu, 10 Jul 2025
 11:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com> <20250710082807.27402-8-byungchul@sk.com>
In-Reply-To: <20250710082807.27402-8-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Jul 2025 11:26:05 -0700
X-Gm-Features: Ac12FXyyC8r-KEBOBjPhKMa8MrPinEu-RU7EeVBu--QTlNg-z0ciuFeVDRS6Ldc
Message-ID: <CAHS8izMo5QLb5CrrdfBnaG_1kWd=D7iQM+2vB0Gm-pbH9tmk1g@mail.gmail.com>
Subject: Re: [PATCH net-next v9 7/8] netdevsim: use netmem descriptor and APIs
 for page pool
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 1:28=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To simplify struct page, the effort to separate its own descriptor from
> struct page is required and the work for page pool is on going.
>
> Use netmem descriptor and APIs for page pool in netdevsim code.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  drivers/net/netdevsim/netdev.c    | 19 ++++++++++---------
>  drivers/net/netdevsim/netdevsim.h |  2 +-
>  2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index e36d3e846c2d..ba19870524c5 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -812,7 +812,7 @@ nsim_pp_hold_read(struct file *file, char __user *dat=
a,
>         struct netdevsim *ns =3D file->private_data;
>         char buf[3] =3D "n\n";
>
> -       if (ns->page)
> +       if (ns->netmem)
>                 buf[0] =3D 'y';
>
>         return simple_read_from_buffer(data, count, ppos, buf, 2);
> @@ -832,18 +832,19 @@ nsim_pp_hold_write(struct file *file, const char __=
user *data,
>
>         rtnl_lock();
>         ret =3D count;
> -       if (val =3D=3D !!ns->page)
> +       if (val =3D=3D !!ns->netmem)
>                 goto exit;
>
>         if (!netif_running(ns->netdev) && val) {
>                 ret =3D -ENETDOWN;
>         } else if (val) {
> -               ns->page =3D page_pool_dev_alloc_pages(ns->rq[0]->page_po=
ol);
> -               if (!ns->page)
> +               ns->netmem =3D page_pool_alloc_netmems(ns->rq[0]->page_po=
ol,
> +                                                    GFP_ATOMIC | __GFP_N=
OWARN);

Add page_pool_dev_alloc_netmems helper.


--=20
Thanks,
Mina

