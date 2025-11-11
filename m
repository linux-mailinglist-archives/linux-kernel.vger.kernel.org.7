Return-Path: <linux-kernel+bounces-894973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF42C4C998
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5810A3A570E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503FF2EB5BA;
	Tue, 11 Nov 2025 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRrFaKzc"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D211E2EDD5F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852478; cv=none; b=klDhdnltzXmz8JsB/sM+7I5L+RlVJvlT8rGlz2LT/Og7yvHl8qP5vyi8xElgB08bVd3IY4h97pcOMSO2uvbC/xghCgJlPRQ0tj0n0Zbf9NemT55wbkNX0H0oHlELFS0eQ6s37gGVbj73fExrQ1Px09lE4ZtEnqN7h4GTLE1Z9n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852478; c=relaxed/simple;
	bh=+fuZTmVdwbIHymrZKqGvMnKmh2q+5Yh8TQx/OG4Qt8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvLi/3mi8VwOIxnfBf0IkvVg2jwZlFy+qn27Wx8BcAUmLyVSmSzWgMg08cDZMrIq9qOKAbfaGroPC/wiR9TuNOsggArN9m/a7AV7Ww0STKfOJQWHuKzGFnX4WBVrsTqBCBau9Z7V2rrYLSnuI9KePE3HciIPuQN8l9qoyWlK+hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRrFaKzc; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4eda26a04bfso39094851cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762852474; x=1763457274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZTy2q2TNTCA3OHKdlCs5XdCV4IXpZdhN+lpNGYPqtA=;
        b=NRrFaKzcpsTBVmpCaZ88hi5hfqVLH+Jt04xmWSfk9MhSpvSRNUV0pkCXnEUjkOAMM9
         agQMVqNpFeEV1DVWSAt7Z7iM9Rqdb52RznIWb1B1S+Ji/ueerXlQHls2OtfCtQRJl22P
         d/n75+H+NlPtPQUzosQ11Q/OpCBDhACo5+1r9u9HyDsjOuij0NyhyoWLGQECkuWp5eoe
         U9OAQvkPVprcN4KmkW7oregyEJF50ilVdKnHmjn0TstCsOsIGWA84M9bS15Y7myiYkLo
         Dcak/e2F0jhM6+39EAKTNBVhOZ6RxiA8eam7nK+zkGanVB6ruA2dajPcEzAvcOcAH4vK
         nzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762852474; x=1763457274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lZTy2q2TNTCA3OHKdlCs5XdCV4IXpZdhN+lpNGYPqtA=;
        b=jNOBMGAnuV2aeINpJnY8Im3X5sN8lHL1cUhw9eDHxOhMlx0Njf3kCeHmsdZSOhGcqw
         a58Iyynmk67i4qn6koLGiNr8LdnzKBaw2XW1LmCXcMVIcb7rCCpH/qkgU2moqZFuSlI+
         776Y0eMZI/6YhZ5skBQ5qHQwpMHS+3Roks6QA4Zm7ugJI0dpaEbW3yETMspNX3dR6YsT
         QNTrJA6w9ugvURXcZwnmykgV39PE5kYvtmjBDehXip4qxdYrYi0/i4JQuRYnZtfgoTEK
         wSY8zOe1Ia7Ev1jFxHl030BHuwIVavpB/2NieVHJuo5FdAtuNovfyDsqbX6br/fzqzme
         BPgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPnYtkkZIOyLJDGmOoO+p1OJR2Nh25BBqMZP6uGC3K8PNpCq9tGnUVLQoKLRtSBYUplam7ybYsOWVFwvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZCGnBg38jGTksrVWynrIV7DowoL1ULACcdn1Rlu1jT3SvQ2k
	iTSjq9y/vhYuOjfsaWAC0SNI9BnqUF1rLuC8WPkZygv7BDfEptf+AUcADPa8C33JLFix5uQyVW2
	D6h5vPAuazozd8Fm/lIGzr+3LFFEJ8DWigfiokSb+
X-Gm-Gg: ASbGncv5iKVLRX49eyg5S3xohYTEOCqvAMnsCzZdJzq849lbT/JVnN7eGppso0xmsL1
	CihfReXu7yfAyhfkkkGbNpdi0WM+DbxxGmeQJg2FGMcKZBmdO5AK40kKaEjkFXTs09UUhh5dj40
	mWyqeaQ8eGr+Ct1ACdlkOKFGEq5SGH6SXNJ5ooiLc+zdA2p6oJgGaxVf0SkgKoNIDRMi+1RcI3d
	iHU9ReK5om2JGGaknIWwTWWnGzL9ITXPtERBSAUL1mUltF1lLS2jfBJF4gFcLcqcfKWxZ6Y916f
	SIjoHgF8xXTO79TKYfoxSzedelpaSkkXc7P0
X-Google-Smtp-Source: AGHT+IFHyI5tV3uPkHfzZQDwtLCu1xXfZdNpjQHEIN8gqbseljKndHdCHWJHLu5LbqQguzv8YlVvlOC2YwOH7fkw7n0=
X-Received: by 2002:a05:622a:205:b0:4ec:f151:6559 with SMTP id
 d75a77b69052e-4eda4ec1851mr145606591cf.27.1762852474078; Tue, 11 Nov 2025
 01:14:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761763681.git.m.wieczorretman@pm.me> <d6443aca65c3d36903eb9715d37811eed1931cc1.1761763681.git.m.wieczorretman@pm.me>
In-Reply-To: <d6443aca65c3d36903eb9715d37811eed1931cc1.1761763681.git.m.wieczorretman@pm.me>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 11 Nov 2025 10:13:57 +0100
X-Gm-Features: AWmQ_bknFBa8gAhB6UE8n7ZlyUgSKcguUN9eypJruwNRSxK5vCFPizbRNuQ2qaE
Message-ID: <CAG_fn=V4jVyS41MDxJeN-A2zk6WhTnxp7m3FRWmkXMpy5f+haA@mail.gmail.com>
Subject: Re: [PATCH v6 09/18] mm/execmem: Untag addresses in EXECMEM_ROX
 related pointer arithmetic
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: xin@zytor.com, peterz@infradead.org, kaleshsingh@google.com, 
	kbingham@kernel.org, akpm@linux-foundation.org, nathan@kernel.org, 
	ryabinin.a.a@gmail.com, dave.hansen@linux.intel.com, bp@alien8.de, 
	morbo@google.com, jeremy.linton@arm.com, smostafa@google.com, kees@kernel.org, 
	baohua@kernel.org, vbabka@suse.cz, justinstitt@google.com, 
	wangkefeng.wang@huawei.com, leitao@debian.org, jan.kiszka@siemens.com, 
	fujita.tomonori@gmail.com, hpa@zytor.com, urezki@gmail.com, ubizjak@gmail.com, 
	ada.coupriediaz@arm.com, nick.desaulniers+lkml@gmail.com, ojeda@kernel.org, 
	brgerst@gmail.com, elver@google.com, pankaj.gupta@amd.com, 
	mark.rutland@arm.com, trintaeoitogc@gmail.com, jpoimboe@kernel.org, 
	thuth@redhat.com, pasha.tatashin@soleen.com, dvyukov@google.com, 
	jhubbard@nvidia.com, catalin.marinas@arm.com, yeoreum.yun@arm.com, 
	mhocko@suse.com, lorenzo.stoakes@oracle.com, samuel.holland@sifive.com, 
	vincenzo.frascino@arm.com, bigeasy@linutronix.de, surenb@google.com, 
	ardb@kernel.org, Liam.Howlett@oracle.com, nicolas.schier@linux.dev, 
	ziy@nvidia.com, kas@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	broonie@kernel.org, corbet@lwn.net, andreyknvl@gmail.com, 
	maciej.wieczor-retman@intel.com, david@redhat.com, maz@kernel.org, 
	rppt@kernel.org, will@kernel.org, luto@kernel.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, linux-kbuild@vger.kernel.org, linux-mm@kvack.org, 
	llvm@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:08=E2=80=AFPM Maciej Wieczor-Retman
<m.wieczorretman@pm.me> wrote:
>
> From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>
> ARCH_HAS_EXECMEM_ROX was re-enabled in x86 at Linux 6.14 release.
> vm_reset_perms() calculates range's start and end addresses using min()
> and max() functions. To do that it compares pointers but, with KASAN
> software tags mode enabled, some are tagged - addr variable is, while
> start and end variables aren't. This can cause the wrong address to be
> chosen and result in various errors in different places.
>
> Reset tags in the address used as function argument in min(), max().
>
> execmem_cache_add() adds tagged pointers to a maple tree structure,
> which then are incorrectly compared when walking the tree. That results
> in different pointers being returned later and page permission violation
> errors panicking the kernel.
>
> Reset tag of the address range inserted into the maple tree inside
> execmem_vmalloc() which then gets propagated to execmem_cache_add().
>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Acked-by: Alexander Potapenko <glider@google.com>

> diff --git a/mm/execmem.c b/mm/execmem.c
> index 810a4ba9c924..fd11409a6217 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c
> @@ -59,7 +59,7 @@ static void *execmem_vmalloc(struct execmem_range *rang=
e, size_t size,
>                 return NULL;
>         }
>
> -       return p;
> +       return kasan_reset_tag(p);

I think a comment would be nice here.


> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3328,7 +3328,7 @@ static void vm_reset_perms(struct vm_struct *area)
>          * the vm_unmap_aliases() flush includes the direct map.
>          */
>         for (i =3D 0; i < area->nr_pages; i +=3D 1U << page_order) {
> -               unsigned long addr =3D (unsigned long)page_address(area->=
pages[i]);
> +               unsigned long addr =3D (unsigned long)kasan_reset_tag(pag=
e_address(area->pages[i]));

Ditto

