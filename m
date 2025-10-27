Return-Path: <linux-kernel+bounces-872746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F45C11EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6CD3B4D37
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3913168E0;
	Mon, 27 Oct 2025 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gE4BQbJ7"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67230C609
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761606313; cv=none; b=UmGq0FclmmNsLqjaKkvTNGLzpxJ9Jr/Xs3xJpKAs7vA/VCkjJfuMMrSParvsgHhgxdHVnbiG6GMjhBMEnTJiKCDn6b5Vo02HOsTnPtRxW+YeeKHyKav59vS4Tc+X/LoRUtqZ/J89w3IFHRYL0cFC7Cj5Two9Smu2LB8mFirBkvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761606313; c=relaxed/simple;
	bh=4QcjKyTr9fdqx3O9SBoesqfDFwLKYeF8Vx1HeQeexLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZ6CFFwzzuZIF3sr7jeXaBKDgZ7qAxi6w8OkheouzHH0L+o2jiRnjOEtYyfWwiJH65tIKE/rNCv+pfs7JP5oaEreUqVoJ+Q7y43+orHevg3E7OSliWqlfKdKVW97Tiwb9BM6awUlUK13sZVwdQ0jDR9wVXc31qa+wHOoBl83wS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gE4BQbJ7; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-932c428442aso4875110241.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761606311; x=1762211111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QcjKyTr9fdqx3O9SBoesqfDFwLKYeF8Vx1HeQeexLA=;
        b=gE4BQbJ7X3rwZgUz6v9Q3KIinB+iUorKImgepggtFv/UY/yTdwDo0nmdstSibyY0cW
         mEjhLwpkCgPXGOwWVkbHoGKbPfQZbEAtArNXBD2D0KvF2X+1tZdLk7HkUo4WvfWxzQki
         ecTl3Sp6GE174VCXt2Qpqs0blj6tOgL97yugL36bQNplq67Z/ie8zMIS711jyG3jHPJk
         RNWYKwiw7dJfZOVBpimnfyVZZVwDGzL5kM38kAyjWn2uhgqg/XOQlz55rr0bC+LriLQ7
         qkouSAU5zQ8DQ1c3V0cgvMIdlRZGBiYhaZaCcMpEi8qMsrPFOt+cdY1mGwyDEUo7gKRY
         T/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761606311; x=1762211111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QcjKyTr9fdqx3O9SBoesqfDFwLKYeF8Vx1HeQeexLA=;
        b=c8TY62rCbQkxrfJiDxVMfy8INfRsmKpcpC2bgPQFV6ClJtdMRTkpgYIea2BqeJXU1f
         MvjCJSja82XxrkoBNcrImxafq5BzfC45o3Tux/A8X3P5agMNN3TccsU3C4LI80dSlcKt
         RlKzHlawSV+mW/PC2iYvWiGis6yYsZ5VNpFaTzhm51Tu/BwSYnrNmRlvZryEVtELXLZh
         ywgZxBNCuI1PDl46QDe44SRymNvbWmOkJA0u9KBILzzvkICaYV6JrMf+lENH9/bnA4+8
         bNKVdUoq3IhpsejW68gxpMTFpNCqGDmsF5a75+KUMpPWcR8wmvCtHC3hIxXkELx5mfDk
         7Vng==
X-Forwarded-Encrypted: i=1; AJvYcCWDzLZuYGoRUcZcm0LfVC2Phtb3DtNAXMPXnGdHX+tebt40WBipdWeSOH/iwYZ7wYpRAvXc0ry+0te4DVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgkh/s5kVs7CXk/2uSkheijUAnUeMyi4IyQVZvc7xwBbkKhDis
	8NLukr6Rfnny9jXGt5lR8R7nwnOC1JtqCiNHuH86bbIplmgJw3E/Xse+RAJj30j4V5A4n7cvwwP
	MS86BiVMQF5qV7UAxzyETed+F8UO4QHIY4TlPWzNk
X-Gm-Gg: ASbGncuBcxskh9YsMK2O7wdxolXZDSvpDaFKeYgzSCmkyWgU++uultRpOifpeVVMoVX
	KvZMnuW6g2NEJcouhzlkJsvn9Fstyd1YGV4LhYJ7f8Ghhx9aVPkqsK5/wS197sdl8+9yZAVUy5d
	lVJtdE0u1Ybqhv2/N0m+QL12VN45NB12/erAB671YFvE0ZOO704aY9VcSTW0oG8Xgr4Q1/qvsB+
	p3yr73tJHpS+83rU8xygr/Y5Zr/oo1VCNR+F/INmg9g/NOaXeM7lUF1VLbjPjsm4d3Yix4=
X-Google-Smtp-Source: AGHT+IHpaQt5+0pcMaIPZPH6gSZTkFVrpAwY4H8c4baBjFBSVkthH7idSXvBuMd/bzOIGy2JEPxjML5/b0vPbAuuafA=
X-Received: by 2002:a05:6102:18d7:b0:596:9fd8:9268 with SMTP id
 ada2fe7eead31-5db7e0ae09amr369527137.8.1761606310932; Mon, 27 Oct 2025
 16:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com> <20251021000852.2924827-4-pasha.tatashin@soleen.com>
In-Reply-To: <20251021000852.2924827-4-pasha.tatashin@soleen.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Oct 2025 16:04:42 -0700
X-Gm-Features: AWmQ_bkP7kzVj43hv33PyztzJtnw3ebpuh-wFqU7ylSkamn2ND777xZJOuB-IiQ
Message-ID: <CALzav=fa0rxnf-ufDmV0uhA+zhoOB2vp9ksfNpeE0amxnLt0jw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] liveupdate: kho: allocate metadata directly from
 the buddy allocator
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, 
	tj@kernel.org, jasonmiu@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 5:09=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> KHO allocates metadata for its preserved memory map using the slab
> allocator via kzalloc(). This metadata is temporary and is used by the
> next kernel during early boot to find preserved memory.
>
> A problem arises when KFENCE is enabled. kzalloc() calls can be
> randomly intercepted by kfence_alloc(), which services the allocation
> from a dedicated KFENCE memory pool. This pool is allocated early in
> boot via memblock.
>
> When booting via KHO, the memblock allocator is restricted to a "scratch
> area", forcing the KFENCE pool to be allocated within it. This creates a
> conflict, as the scratch area is expected to be ephemeral and
> overwriteable by a subsequent kexec. If KHO metadata is placed in this
> KFENCE pool, it leads to memory corruption when the next kernel is
> loaded.
>
> To fix this, modify KHO to allocate its metadata directly from the buddy
> allocator instead of slab.
>
> Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: David Matlack <dmatlack@google.com>

