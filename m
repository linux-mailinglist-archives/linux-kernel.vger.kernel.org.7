Return-Path: <linux-kernel+bounces-733708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FF1B07813
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C2E3B610A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BB625A338;
	Wed, 16 Jul 2025 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QCcjgLai"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC13220F2D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676195; cv=none; b=evZqyB1sgKoO7chcFef2G/TjOU9W7WMnM2BKdNjXj/m3fL5XjgiAlvs7QPmX/zfvdss3Vr7R1c+A82vpILbXFAgImqcjTv4l0NsyudS5QnoqFeQisP3XTeineCBse8LjnrxefxznzoyyLRZ5p6Dki8dIWmwVTAHn73Bln3o5fzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676195; c=relaxed/simple;
	bh=01PZ/xKuO5lByV/sYsB5ZFdAMbt7OpQEfhoPNdSub8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NITpgyhQTicQgf67LFPr8SPwX+SVeujGn52/EOoP7CZwGH09e2+mhbBPg59N45RUa8vBijWZrzoeF6bllwFZ72I8E0LNCdDKY3yZhaJnVzDKM6hF5qnWBiPAI9L9d3qaFsigNfqax/d02IZ/gQM7oAxXqAPXXv5xWab+2kh2+pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QCcjgLai; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab86a29c98so482621cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752676192; x=1753280992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9dJcIYNmFLt97FV6TaWcTMU/S/O8suqtyZyGxaHRnM=;
        b=QCcjgLaiZEZi+2OWleSRsZg9kzlZjZO/YfyKTukXhUaKDPwHodqg5dXlGgqf1U7KrT
         18+GpStUYjPEeUHHQV6qrO5sZr4bkevIOct5sjcIp3eu/xGxJXx1a+MBH5+4V0UkGN3e
         2RcYPtcREp8y8JBlR4reAdbOEekJ+FU94sTrL2i4NyPkeS8BBHa5RqWdf4HDmBNobWVz
         e+QIL007vhhFhz1Mjt4rPoCaErJXHliG7K551i98IMtNKkDTOGnZ4VF2q6rAOxuXGOe2
         zpHQu1dI4NFUdBHGzqfh4N10WBMA1vSlJiAUioyb2PQwzH3l5HXIHNwJfwzk1DHjLloY
         0Geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676192; x=1753280992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9dJcIYNmFLt97FV6TaWcTMU/S/O8suqtyZyGxaHRnM=;
        b=O+86oXTJnhTLLg3IX6/oJIJtrZqC2wzb6/DIOilWjX6Id7Nat67erNPaHhaTZ9U5/q
         E0qLjRdGN14VBtgX24t4Vrep0wFIy3USvK9pfGUsppGq+dOwNou25VqWvfweqCwNR5ur
         YGQNPesJfs+3gc7skxY9NPk88eaMjig0vV9V83XfLRUVPKBKzeogrP5xs8YSnSRgrewe
         NaJTZeuXGW9xXnxJNwaYzFNHPt0fIcs44oB5XrVju+4xAF5+uI+tCCGuVmV52/uAbCCl
         hhaFFnFG3lCH4lKvVspPHMrzdyCDYZYJUaEskJO63nstXt/soBvLoxF0r/GQw2NNE2+a
         4EOg==
X-Forwarded-Encrypted: i=1; AJvYcCUOU15wpYCdkDdqISL/uKveVbF/y4wyADXJ7JJ5ZQ65jnQFCftArLCvDC44vjHxN2/CS9Sz0qjZQGH1+fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtGE1rJ0KwaEqCvTqEhBgns91HBYdn1xUb7iUviv8VHHGxxItZ
	FF0wamMjvFeKl64eFnvETBAGxchJZpEf64a+9LZ88ZdY9XcB/zjAqRAABHoLJZuJ/N1WDWlO/IS
	UrlCjIuczpJrCV2lll8yXgZ7yJuiunsf6856uOVPv
X-Gm-Gg: ASbGncsYxvlTjvbrQeqoOgjQj0Au1Je18oIwXxEk0psfW/+9F4/3EKMc/UIFuH7ecWI
	eV0K/qgg/hdcHN4fsgbTWXajy3n0m9LdAAxlZFKrNp9aq8IjElbd2vgpMO5iAbpvB3BMfgiaIgi
	nZV/BmkfG2qirRWWu3Bw4HgEar1wNXKMvWk3DwLWzCQPqsc5e7xGA1u55mqEXk1ZTaP/Vgm4jEu
	m0RUg0XyHPt/jeWtaMBfCnTfe8cNatAQxe4
X-Google-Smtp-Source: AGHT+IF1jgIoyk5R1Kif1z4ud/Iv9ltObgmGNfl91kkWVCZZHs4vDHtmbDAOFhVoWxeWru8tTtLk2fMmer7cvrmEICE=
X-Received: by 2002:a05:622a:1aa0:b0:4a9:d263:dbc5 with SMTP id
 d75a77b69052e-4ab954da1cfmr2945571cf.20.1752676192219; Wed, 16 Jul 2025
 07:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com> <20250716030557.1547501-8-surenb@google.com>
 <dd88b2fc-6963-454b-8cc0-7bd3360a562e@suse.cz>
In-Reply-To: <dd88b2fc-6963-454b-8cc0-7bd3360a562e@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Jul 2025 07:29:41 -0700
X-Gm-Features: Ac12FXzno4zj4-9Yms3LsC7vLEmlFKsL-np6yaN8ehs9Whc_WjCHA4V2guD--iU
Message-ID: <CAJuCfpGRAL6YPqTR9SpPPuTamGJLdg4OEGmPUMERYDgjQCHAiA@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, peterx@redhat.com, 
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 6:57=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/16/25 05:05, Suren Baghdasaryan wrote:
> > With maple_tree supporting vma tree traversal under RCU and per-vma
> > locks, /proc/pid/maps can be read while holding individual vma locks
> > instead of locking the entire address space.
> > A completely lockless approach (walking vma tree under RCU) would be
> > quite complex with the main issue being get_vma_name() using callbacks
> > which might not work correctly with a stable vma copy, requiring
> > original (unstable) vma - see special_mapping_name() for example.
> >
> > When per-vma lock acquisition fails, we take the mmap_lock for reading,
> > lock the vma, release the mmap_lock and continue. This fallback to mmap
> > read lock guarantees the reader to make forward progress even during
> > lock contention. This will interfere with the writer but for a very
> > short time while we are acquiring the per-vma lock and only when there
> > was contention on the vma reader is interested in.
> >
> > We shouldn't see a repeated fallback to mmap read locks in practice, as
> > this require a very unlikely series of lock contentions (for instance
> > due to repeated vma split operations). However even if this did somehow
> > happen, we would still progress.
> >
> > One case requiring special handling is when a vma changes between the
> > time it was found and the time it got locked. A problematic case would
> > be if a vma got shrunk so that its vm_start moved higher in the address
> > space and a new vma was installed at the beginning:
> >
> > reader found:               |--------VMA A--------|
> > VMA is modified:            |-VMA B-|----VMA A----|
> > reader locks modified VMA A
> > reader reports VMA A:       |  gap  |----VMA A----|
> >
> > This would result in reporting a gap in the address space that does not
> > exist. To prevent this we retry the lookup after locking the vma, howev=
er
> > we do that only when we identify a gap and detect that the address spac=
e
> > was changed after we found the vma.
> >
> > This change is designed to reduce mmap_lock contention and prevent a
> > process reading /proc/pid/maps files (often a low priority task, such
> > as monitoring/data collection services) from blocking address space
> > updates. Note that this change has a userspace visible disadvantage:
> > it allows for sub-page data tearing as opposed to the previous mechanis=
m
> > where data tearing could happen only between pages of generated output
> > data. Since current userspace considers data tearing between pages to b=
e
> > acceptable, we assume is will be able to handle sub-page data tearing
> > as well.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> Nit: the previous patch changed lines with e.g. -2UL to -2 and this seems
> changing the same lines to add a comment e.g. *ppos =3D -2; /* -2 indicat=
es
> gate vma */
>
> That comment could have been added in the previous patch already. Also if
> you feel the need to add the comments, maybe it's time to just name those
> special values with a #define or something :)

Good point. I'll see if I can fit that into the next version.

>

