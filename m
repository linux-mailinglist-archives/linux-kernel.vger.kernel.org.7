Return-Path: <linux-kernel+bounces-893709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05456C481DE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98DA3188FE6C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873B9330338;
	Mon, 10 Nov 2025 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXXf6n9n"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066D4295516
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792859; cv=none; b=S16KZYShLcJM524PyWQVvwoC8Tt1JZb2Omf0h4IM1BgLYIkGqOa2mqbbvop56IRHnbtDZgFrVdO4tJdq/KuHuplqI+0Ad+1dQCR3So31YJ6JzUyFOn0wu97ezCpUu39L7Ob6YzkfiPkeQdBae8m/CpEOLLsfq+MxuGaCC0FOpJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792859; c=relaxed/simple;
	bh=Nn93pG9GTk907Z5oYvQqtvL4mNR0sTn6esBD4Jp2XFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCRJEPM8j8RUmupZgw9bGw/gGINAoM3z+fFIvL3RmiVEdZULMPXbvMQGj0O1mTAEvIbz+GbylGGKWE+wl9YjcYoWeyDV/O6xTKjCm28JTczoUynDA+RJvip1w0Cbm5p1pnnXivo6M2m/fJiTu8HlV/UaZBlakxxrjRjXt5YL+no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IXXf6n9n; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4edb029249aso13790451cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762792857; x=1763397657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ARP0s0P8t6lHLXGPK7oqG4hn2hPk4JBv7/AQ4HrLq7Y=;
        b=IXXf6n9nhmSnymPWmqhjSmnDiR9Up4GTSKZzRllIwT71BVMh/tG5PHzDXfE8YDO62P
         im2WhPVKJmn1o9X6hlJd21VkAsg4IhHJKDYrgMVzClVLABJHJmHRx+hlwsN90izo5jGx
         B+pZGOV25MXrrP2znz2IvIYD4uL4+agnoMF9i7Ec4johf9cye4TtsfJSgJTyPow6+Ap2
         ee6J3qUJ/BirQ83jzYU1221z66ZbqKN1q/Zy1nDzded68tkiuamw4GKbfide35oSdjlu
         60YLCTC0EcOvqP4PbiQZfmBos3Qs9HgVy5+biHMlixcETr2qxfBFilHO7Yqe4dMxBgIE
         DEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792857; x=1763397657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARP0s0P8t6lHLXGPK7oqG4hn2hPk4JBv7/AQ4HrLq7Y=;
        b=thgKLMKWafVNcf4RLPxkAASofJbnQpu1nqXF2bgssapQfAD7W+AyMJrLsYfHp5rHa5
         CugTSU/XWUWvQe8+e11JMHzsQyY81uU8uFgtin3gx3DXJKxGbkj8yRRbnni9uq+sCyfF
         VxgRK/EnzomYD9KEut76gRWBGEtZiMXyABGbMhsWxz7eNrF7of2NPNzLp3GnmQMaXDeJ
         dhL0ws16ahbfzSyjz0XlE2RgFGaM/g/HfH1hY7LSE1FBdcMy9ueMBeFcLRNcIAE1L6cf
         t9t8C1zpAVseh82iZ1Vc7l72dKJHaIv7hWF+tuc7X1WbvSjdeGx5XWemlaQ2SZoVvDkB
         ryyw==
X-Forwarded-Encrypted: i=1; AJvYcCURCNdDNw5cpyVxAfFy94qfrEMkxXRCKzv3c+xGw5VfapWnoR/IQna7fiHssWkYYbJQAg5h0p1VXVLlVlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIjaVAX7b22Q5EhDXxPUqImQABf/6FQKMf0hC0VkouMtsxkTI7
	0YoWQD0w9SUhJUJrPKb0c9CMf/ut3YN9f/6/36btq9Cky00L08ZmWYTcqpVGh2xCZwDluCUR5ex
	DtG7I3v0EVzEJDjZgz+57X+ojyfdFp3Ur3RPfPUN3
X-Gm-Gg: ASbGncvRJfnr2Vd7XVGeUmZJvts2Lb8hRLoJYl5m0lfIh2w8JvlW1o1H9KErF2jqoZA
	NCcrM14R241D1gqhDS1keiOmTDVPDvhwIKiUXqpDhGanfjUO++AWXY6Hl3+huZQOxqf/YZrHEw/
	DnWhwzVprCdydumqPmhNJEL0dUa9SoR3F9lXNUGCokPvnzoRtkaOkndp1OikLRoL6bAAOEIoztz
	sJJFrFXB8sL4ZdHEqvWAQIzdFJnM7PNswc2SSMIDE3z/AN1rqLS72uoG+dq7bhyp+ZBlUncWE9F
	pbfibLQHaaJV6n6Nv3TavL9qdw==
X-Google-Smtp-Source: AGHT+IFXtIVYv/1akorIwGTU2TyeYWKo/ZKjasuLxC+KldJLVH++s5nwoozhcb1g1AswN8A4ZgMNuJJXiz33fQE7EOA=
X-Received: by 2002:ac8:5d05:0:b0:4e8:aa15:c96d with SMTP id
 d75a77b69052e-4eda4fec971mr97364671cf.55.1762792856275; Mon, 10 Nov 2025
 08:40:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761763681.git.m.wieczorretman@pm.me> <932121edc75be8e2038d64ecb4853df2e2b258df.1761763681.git.m.wieczorretman@pm.me>
In-Reply-To: <932121edc75be8e2038d64ecb4853df2e2b258df.1761763681.git.m.wieczorretman@pm.me>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 10 Nov 2025 17:40:19 +0100
X-Gm-Features: AWmQ_bmi0ifqdxD1pRga8rXt1izLseEvw-FOTscdlGLXMffgSbt_R_kuG7tm2tc
Message-ID: <CAG_fn=V6pbNdN3w0Jr5rCL=M27-bOBt4AK8rB7UvvwT=3g4m7g@mail.gmail.com>
Subject: Re: [PATCH v6 02/18] kasan: Unpoison vms[area] addresses with a
 common tag
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
	llvm@lists.linux.dev, linux-doc@vger.kernel.org, stable@vger.kernel.org, 
	Baoquan He <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"

>  void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms)
>  {
>         int area;
>
>         for (area = 0 ; area < nr_vms ; area++) {
>                 kasan_poison(vms[area]->addr, vms[area]->size,
> -                            arch_kasan_get_tag(vms[area]->addr), false);
> +                            arch_kasan_get_tag(vms[0]->addr), false);
> +               arch_kasan_set_tag(vms[area]->addr, arch_kasan_get_tag(vms[0]->addr));

Like set_tag(), arch_kasan_set_tag() does not set the tag value in
place, so this line is a no-op.

