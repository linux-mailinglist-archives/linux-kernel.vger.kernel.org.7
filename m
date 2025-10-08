Return-Path: <linux-kernel+bounces-845705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19375BC5E54
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D02CB4FC060
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5861B29DB9A;
	Wed,  8 Oct 2025 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjEQDZ0e"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA3D25486D
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938506; cv=none; b=Bsd7aGjGpfZN+MlRE0YOIEew7Ru7JBaBaJ+GxN3ErwnWCqjlCRxnL6CRT2mgyurQgRCXyjgAE0houloXbfa0dEPP/IvXp+LJgyWebecO5Hdl233nbDh1nUOcFWLd++OsOCB7Nfg32E5MMerg9FAHp2/2GvpmaoWQwvUAKKzTukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938506; c=relaxed/simple;
	bh=2LGlFA5NwtyOxfaDrKcUAZJIjkhQzJAUzFr0Gk/nflE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEmoI0mJOLIb/qCd+bQY/SR76kvkhLQ0VR8DIHxwOm/fq9b0SDVatBRtwt63IQP+4MPGprbi3pEZenT2/kmd5VXBX45XesD+/HIagwRjgRq1Y9WqHWBPF/NaFsAhOYKujuuHy2uSfJhlk6daLlp25D7U0kuUlCJPEym5NaQmhuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjEQDZ0e; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-93ba2eb817aso450292239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759938504; x=1760543304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jnz0wfzGjq/RWuaaZQleG175ixspg2bx6DBLy2dhJEw=;
        b=NjEQDZ0e+OjvIUJHDRJM8zmfiSQou+zCsZhFrnHNymWHaO9R3AAaUawpvmsElBIic8
         BEYrsmgKe6E0WdmwUDCqLsWBrQhlADzPcTrROf0bBSX+aWogmvmArCOZbqWFGJeXrO6Y
         7r9dyCjYb5PFpyajmlklxCBM6RrFP44wcb8MgAG81oijFE++n+QVYPquZPlRHsbvjF6b
         qQtwtPaRqIPd+996wRbTSSxObylYCnnO/2445hrBTEytMUGMyQ/GTMkpD6OxACJY4Xlf
         ferb6lR/TukJWJ6TS0w+Fk6k1AzmLCEE9asIAWaulMcYDyP1tcqTeug0NB4b16B0OIg8
         w4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938504; x=1760543304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jnz0wfzGjq/RWuaaZQleG175ixspg2bx6DBLy2dhJEw=;
        b=LuybQw8Ft98t629duQzGS2pe73EQms0cEYqA7yQpPEQ44wqNqb9wvqrPAWnyPo6Ko/
         cET8bCtvk7+Tlm81epSWUK2yfph6nXxSWya9fMX+D83NDdFWO0pTjeJTwuCbH2GYhPBy
         iA2AHKFfxjGRimzRRh0wJVWHMTxx82BoxVILZMzxM04bj0K54lspIpdaShTNyh9E802Y
         CgrL2HDrsFvfeplV/aq4sypAmMzrvnUIpRsrxuFYWH6MbpBCPnYEd3LPyd1QUw5efiWn
         3ugfsgy0bhLGJ864DzJn3+L++cZgqaR9nxEsqhazvrXzm5geCgpzizwFvxyk5sXTw76u
         y3Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVn7tQgdeMc8sZ+MY7DkwKILDhpfIql7FTboc2cRDislLs+sg30e6N1o4N9vR3JBdP/SgyBKxpSbNJXegM=@vger.kernel.org
X-Gm-Message-State: AOJu0YziSP/ltBzUt7x/qNERCMyUX0Lpkds8PFap3uEStfvgtWCbxQ4J
	QthAKRKceRMc2YvwidV/iiEbsA1d9RqOvAJUvdiUf/BL2uuHHDpxxB4mtijKqbpPKD7AFuilebD
	QEVrk4Tb2YuHxj3c7KMH/Se+HCii8T+Q=
X-Gm-Gg: ASbGncvFB6qrtCD5DvBNTvVusj923ij0W4J0NeGoaEcQ1A/gHXjwBXwhypC8lGHIwFi
	l9NifBTsLB7o1NUAOPXaSaIfUv9iSsD4YjdS9a/W7rcd8G++lAoVPd/ieQ+YdEb/7QLUhtpkZVL
	0Sil62K4RsEP1B+Ul6FIInQoQkx6PqrDV130Kua0LHxFYW+b+VEVHnv9NA2W87a1iVEl2T1aAzm
	t8XAStuB7gjRB9qcrzcvTlUJ+N4
X-Google-Smtp-Source: AGHT+IEkR8j835l36xMLsRghzDg6ytuUIEPKbr6li+EEc40XA820BGG77XOwW3X2r8mrb0/M/8veOVpZAajhmXsAn5Y=
X-Received: by 2002:a05:6602:340d:b0:8d3:6ac1:4dd3 with SMTP id
 ca18e2360f4ac-93bd18b16bdmr434509839f.6.1759938504211; Wed, 08 Oct 2025
 08:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003203851.43128-1-sj@kernel.org> <20251003203851.43128-5-sj@kernel.org>
In-Reply-To: <20251003203851.43128-5-sj@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 8 Oct 2025 08:48:13 -0700
X-Gm-Features: AS18NWC5GQ_ulUnl9tKx3ywuwAWkm3a_xsU1pqdxQwVuJQmPm7aLfdyq0B3aGXQ
Message-ID: <CAKEwX=M1JiHzgLVvROjfd2Pz7E6c4DCgzn85aWHPS+6qKMeS1w@mail.gmail.com>
Subject: Re: [PATCH 4/4] Docs/admin-guide/mm/zswap: s/red-black tree/xarray/
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 1:38=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> The change from commit 796c2c23e14e ("zswap: replace RB tree with
> xarray") is not reflected on the document.  Update the document.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/admin-guide/mm/zswap.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin=
-guide/mm/zswap.rst
> index 283d77217c6f..2464425c783d 100644
> --- a/Documentation/admin-guide/mm/zswap.rst
> +++ b/Documentation/admin-guide/mm/zswap.rst
> @@ -59,11 +59,11 @@ returned by the allocation routine and that handle mu=
st be mapped before being
>  accessed.  The compressed memory pool grows on demand and shrinks as com=
pressed
>  pages are freed.  The pool is not preallocated.
>
> -When a swap page is passed from swapout to zswap, zswap maintains a mapp=
ing
> -of the swap entry, a combination of the swap type and swap offset, to th=
e
> -zsmalloc handle that references that compressed swap page.  This mapping=
 is
> -achieved with a red-black tree per swap type.  The swap offset is the se=
arch
> -key for the tree nodes.
> +When a swap page is passed from swapout to zswap, zswap maintains a mapp=
ing of
> +the swap entry, a combination of the swap type and swap offset, to the z=
smalloc
> +handle that references that compressed swap page.  This mapping is achie=
ved
> +with an xarray per swap type.  The swap offset is the search key for the=
 xarray
> +nodes.
>

Acked-by: Nhat Pham <nphamcs@gmail.com>

