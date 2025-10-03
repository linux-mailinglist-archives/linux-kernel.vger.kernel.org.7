Return-Path: <linux-kernel+bounces-840948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7A5BB5CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 04:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 050654EB2AB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 02:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDA52D3756;
	Fri,  3 Oct 2025 02:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWJFN79A"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FCF2AE8E
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 02:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759457931; cv=none; b=f+735HD+GJMNjx4NjHBkY8ak+pZQVslU4RFPBg4PfUIqzfeThn0WS8qAFlmBmV8KIJm0VwR7Vf26Jb4iRPTjH940vxGx2mKzs6J3bOmzodCAX6Cq3mKwZL/MNL+YC+bNpu2Nl7YuhG7J85ulBW3ml8iGCsZmcKa8KxQCoSTAeq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759457931; c=relaxed/simple;
	bh=YwdIWqYwyVfdeCv+Niz43GiSsR+lHbtXSQFoDV7XnBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgHIKHpH4bh40I4CLEjozrId0VFBn9RMePS7WQ+e+sTun0+AjRjNV+Y2bg0ncgnG/z7KVXkbjkR3NgMiFyhFtLmqdunj5VUp/mWOKYBoXTKnZaxQAJka0jAUog7xDksong0ilXHtoioarATfL6Pd9k9f+jpo1K+7rZRac4Zd3xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWJFN79A; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so13340825e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 19:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759457925; x=1760062725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e/i8EbjlbnXxewfi6hJm/z/4ZP0XZNKcXcN/4b871g=;
        b=NWJFN79AMeM6DsxRpE+O8M9CNrXkzLxdWrjMG0Egzg9gl0DLd7BTgCOL7DJvW/eFKr
         ynTbLkw8RiRsDqT5ZzMyLVc1J2brv7fN8+K6IY6Dn/HOXEBYK2cnov0x14XBr8ajHEBt
         o54URJ1Nv0Q2E9uyLJAufdKy9hhkvhWZRXSQi2W03EVSCYi+bllDjSSMJyM2fKtdNo0R
         9F5ZtXuKgRZtMgfZh+v6radU+Hy6G3lKxQUySu5t0Zm982uwLT4EUZ+BRmY7pQ/8MX+X
         mcvZErUc5wlDXsSYZMBwVi8Ps+PibM16WWzX+k/Uxnv0FoehMD3fgOxlWm+Kq/AQvMHC
         sPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759457925; x=1760062725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2e/i8EbjlbnXxewfi6hJm/z/4ZP0XZNKcXcN/4b871g=;
        b=gLH2iT/lm9CalPuaA2nYV0W9uWOaYPKxCHNWzviSuNfhTrwIL5hytTJ+37LsrGzriI
         w46NOXpYqhk3ODPMOHoAKJfSigDEXta5ArccqlTsHSxFXaZDjC46JsMaegnkMnOLnit7
         rt8rXfYTJaUnLKlWQsL0cQlffy1jS/2e2G3iRsykM+mV9AYvUhqB6BQxkca87VrxiJyB
         8WHwi5OnDUC/hZnD6ELsOEwlPhjuMECfR2Xw8pJTRkpwv3zCAvlcXJuZuaqbffNyVYKC
         R71n44M660McOdm7FynJP8jZKZcl/h0XY0RsIg4SfNqvyw9lMNm7sGwiXqd5P5yQbqxa
         JOPA==
X-Forwarded-Encrypted: i=1; AJvYcCUFyvD8M6pW5S6psQNIJ3nYShqSU54eplK3RU7LyyuQzKR+hMhu6KCwvhO0u1W8MZgEl1BUNVkTAN54M/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPKG0Uu7lo7eXF69ws+hol3bbeaP39U743E3zIgjr28xfBUiSF
	vmRgEe72EnYKg9wn2Ypz07JVPn8sr+LsKZdlCXD2WbIqdem9v1roa3wqkupaGNcKkBbvO2cSviu
	ZCpZsKYujQa0mGVoUZBOialS2MqK/MFk=
X-Gm-Gg: ASbGncs09U2jZ3emy/N1y4SIQduD7FgaS8l2cz6jrB3ETnbVOxzezhEwBzujabB01GV
	yVbM1sc52EuckTJLwOjC3cR5ymrsYOiEUbt1r+mwtv7d+vDC5lvp3TRUm21i0BtLmzaEzlzX9FH
	emOOGHhpDurmYalCd8K8NRUzGPlsChS8vFhD1c4mp4ca3pAPhMvnoj0vRvDU8dJFph8guCvbNuS
	dzzWQNs6DvJjT91Kj4JeNBHesLxS4bmh8PI0kcEs+aaSRSZQg8z4Yix5s0F
X-Google-Smtp-Source: AGHT+IEUdi5h2t7CXTLul7ivkETFz4Fjf+lqMHwgof5CobhAX/VcEKSKvJeht/4smjkDa2Hgzo4fwK0xXe88/EAzHP8=
X-Received: by 2002:a05:600c:8b65:b0:46e:2861:9eb2 with SMTP id
 5b1f17b1804b1-46e711002e7mr8372685e9.8.1759457924865; Thu, 02 Oct 2025
 19:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-4-laoar.shao@gmail.com>
In-Reply-To: <20250930055826.9810-4-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Oct 2025 19:18:33 -0700
X-Gm-Features: AS18NWB-xO-pJI19YtwvzZWDSOLQVewqObSZM817yMkm5nTGr0yasX6RQmgofXI
Message-ID: <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, Johannes Weiner <hannes@cmpxchg.org>, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	David Rientjes <rientjes@google.com>, Jonathan Corbet <corbet@lwn.net>, 21cnbao@gmail.com, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, lance.yang@linux.dev, 
	Randy Dunlap <rdunlap@infradead.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 10:59=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
> +                                     enum tva_type type,
> +                                     unsigned long orders)
> +{
> +       thp_order_fn_t *bpf_hook_thp_get_order;
> +       int bpf_order;
> +
> +       /* No BPF program is attached */
> +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> +                     &transparent_hugepage_flags))
> +               return orders;
> +
> +       rcu_read_lock();
> +       bpf_hook_thp_get_order =3D rcu_dereference(bpf_thp.thp_get_order)=
;
> +       if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
> +               goto out;
> +
> +       bpf_order =3D bpf_hook_thp_get_order(vma, type, orders);
> +       orders &=3D BIT(bpf_order);
> +
> +out:
> +       rcu_read_unlock();
> +       return orders;
> +}

I thought I explained it earlier.
Nack to a single global prog approach.

The logic must accommodate multiple programs per-container
or any other way from the beginning.
If cgroup based scoping doesn't fit use per process tree scoping.

