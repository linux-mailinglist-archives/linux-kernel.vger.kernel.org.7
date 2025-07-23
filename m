Return-Path: <linux-kernel+bounces-743046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 946A4B0F9E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB473BC0D5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1CE22A80D;
	Wed, 23 Jul 2025 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fTzvHWit"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D2F229B2E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293320; cv=none; b=qTvmvh0wntiwJMbB+ukWf9zkWqMBTIsRjG5lIT1hjPbphwLK0v6ZF9seW/4R3AmsV2yq2WiMY1eCLDJrKP7HHjR73y0PE3zol/odkAgc3yMJvb0dh0XeRYkABpsjapPDb+0am8/OdHS5QNtG2mGScAr+FqZAGuRD+kjtJar+kDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293320; c=relaxed/simple;
	bh=5lIGGRFfecz/Eoh8rfRoSoukLF8S9VnoZ3Vch/Zqav0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlXoCgw02hI8YC47kkjc5f+0gxZrnTQwY/Irf7onZ2jL7wF0ospCfTc1uaktWaVLXhytebmQ8O2qU7l8p7UouCBa3G5DDNiQof4rDcYgxi/4A+/yIPzZ92wzfL9EnUsGeuK0xRgiMEQc6CIQNsHx9NKFg5Fr1vmzcrWeOhLYHjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fTzvHWit; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab86a29c98so42891cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753293317; x=1753898117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lIGGRFfecz/Eoh8rfRoSoukLF8S9VnoZ3Vch/Zqav0=;
        b=fTzvHWitfvYJLj7h+NPreynoTZz2ef73fDFvLDBBMJjtffHw+Vt5eNEUZZTA1JUCUx
         7BTGuYnuSXPjVeRmxCshNye+iPU1+4PddY1lAImpJ0RuaPKINirNmoJhczJVm1xl1p+c
         uwzeguU4SEQtcyxJLEy7a9Qkzh7u2euYUB2qwp4KhxhQPuoKqCVfw6yEf91Z4tN1KqQW
         3gnCgkIqyNO7BM3YQKVs2jS1BVii6une/rN74xEdxSIkGC9QumFh8O85uI9eOP3AZbgF
         P/4x1vGko7VEJbaiT792aiHSf20Eq1jH88ekylpGCEWX+0z78K8vLTOD+yhG1C+otKRv
         DBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753293317; x=1753898117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lIGGRFfecz/Eoh8rfRoSoukLF8S9VnoZ3Vch/Zqav0=;
        b=H2C91JKGX1M0IDOjYfI1zopjxppLeiB66W3EcHvbVmZcJ4kA7w1UVbjkJuv1iDNc3h
         NzdCp52skU85dk4Pik/8ootNsljB8q4EbQrrUkOVbsmx6zAXJoMUvrYjxuELetD6lK8o
         /Md3PqAvcOLpz3IaNa5gH2ilq5/ZfLaIKvUX3WyeF5F8Ow/o3tfzTsCnFwvRP6iqSR9R
         vp7vZYk3nr3Kfot665Dqh7tZPbgBBEuKizxGAvQbkggLVX1Oqg9anZVO+AR7TnoVLbbL
         8r83m+1UhnS2wRhtOKv5tgKO+zIpcpztPazF8ut0f/mE3ZBtDN6+VMrQE5m9676A0YRp
         i4QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVeFWci/Urp5i88T+npap/3qOFCVPdHlaMHa+2TSNM9ud/c1cZxLGUynGh3pJ9jPtQHnT6r7+1NhPOVMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKg1MZsJwYvcUxj3VLONGCQS70Rs/oxzbQQGQ0+1hb2TAsrP02
	88IlJNXa95SaqnVvk4F38DTQQ3TI/2ZRpcw7UU7qjI45luOODHkXtfIkh9feXsYFCFbcX+xJ8wm
	ThRL1fjKKF5Bss7eR/S7eNPTBxgZ68ADKtDkgXIbV
X-Gm-Gg: ASbGncus+iooqq/c8se2coQ+c5z3t//ouO4r/VfFdSiMJhijG7CdCZwGjRGtbE5vrl6
	X/P/v+t8BYlQlOiVimEAZ9ztNttVgqeHCkIeQM/ifav6b+dS/UVGsH2xaA2YRTmYvOwlqTUvx0T
	ajB9ZNQaIxDL6CqrOfFrf7Pxfvm3QN2sv73nCTVwWAR6OoFJlj18tbTZ5/tzjx2hdwvNhP725WC
	anxUom13xipwJhy41wJq9gXb9b6RiJymBqO
X-Google-Smtp-Source: AGHT+IHIKb31VYdVn/B6IVZUU3PWhb2/5MfZYxh690PVLsXGE19hQzPxB6Xh1gdfAV/1uPW5r9M8TtfzZfISYoj9Mso=
X-Received: by 2002:a05:622a:111:b0:48a:ba32:370 with SMTP id
 d75a77b69052e-4ae7ca859bcmr114781cf.10.1753293317052; Wed, 23 Jul 2025
 10:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <16c97e30-19c9-41e8-b73b-c0b3c8eceff3@suse.cz> <CAG48ez1qhjQNHC+3572udqVWHTANFpQ0ngxn_4ZDC9F8NCXsFA@mail.gmail.com>
In-Reply-To: <CAG48ez1qhjQNHC+3572udqVWHTANFpQ0ngxn_4ZDC9F8NCXsFA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Jul 2025 10:55:06 -0700
X-Gm-Features: Ac12FXzYuz8rR2OGf5wlGnp-T-d0ODjwT1WWx2V0IdyNNVzpMhdL1wsVFoFEQ-Y
Message-ID: <CAJuCfpG5VeW5+GdceeRCLDgX4CuFm2xQUG6UAAoLwF7oW8aU_g@mail.gmail.com>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
To: Jann Horn <jannh@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Pedro Falcato <pfalcato@suse.de>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 10:50=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
>
> On Wed, Jul 23, 2025 at 7:32=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> > On 7/23/25 18:26, Jann Horn wrote:
> > > There's a racy UAF in `vma_refcount_put()` when called on the
> > > `lock_vma_under_rcu()` path because `SLAB_TYPESAFE_BY_RCU` is used
> > > without sufficient protection against concurrent object reuse:
> >
> > Oof.

Thanks for analyzing this Jann. Yeah, I missed the fact that
vma_refcount_put() uses vma->vm_mm.

> >
> > > I'm not sure what the right fix is; I guess one approach would be to
> > > have a special version of vma_refcount_put() for cases where the VMA
> > > has been recycled by another MM that grabs an extra reference to the
> > > MM? But then dropping a reference to the MM afterwards might be a bit
> > > annoying and might require something like mmdrop_async()...
> >
> > Would we need mmdrop_async()? Isn't this the case for mmget_not_zero() =
and
> > mmput_async()?
>
> Now I'm not sure anymore if either of those approaches would work,
> because they rely on the task that's removing the VMA to wait until we
> do __refcount_dec_and_test() before deleting the MM... but I don't
> think we have any such guarantee...

This is tricky. Let me look into it some more before suggesting any fixes.

