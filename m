Return-Path: <linux-kernel+bounces-801216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 317C5B44234
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149701CC2920
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C98D2F361B;
	Thu,  4 Sep 2025 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enl43B9Y"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390332EBB92
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001980; cv=none; b=ZPhVIhbaKBROrX1lvNv/72niDH7/viP4eQIBKy7+8W7Wa7ROQO7HISgYM/pD+g1L2WspR+Q66Cnp3c+3Poseg4WfAiaDRl0LNiPozONW92Siq8P8s5EWoFxSEQbzTzTetJ0yM2OpPvuziRUyxnIWlEFS6Qx4gP6Roge60lOR2KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001980; c=relaxed/simple;
	bh=TJB1/hNYsH8Q20BteySCtJnDw0ynZ68mEzNhyiDKstk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIr+NBC4zeMeou7BsjOtE5KUoN1nKBisrhwWbUhZHIsLUaebP9NeoKOh0uNozt43I7km+LHTfsdg2EFo4OpN1aNXgjTsZliGIYXqgMVOAzMS6VolkmNl9w8iVgitx5LwkirDQaKc6T5Fx6gldB/DcKpPc6Y+svgqXoVeOmKcjao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enl43B9Y; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61d143aa4acso1816035a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757001976; x=1757606776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJB1/hNYsH8Q20BteySCtJnDw0ynZ68mEzNhyiDKstk=;
        b=enl43B9YHzgP3uzb4qK8XFlyOuJIT/G3swGCP0T/qvS/ds7/AoNJ7MATZ+Rb7QmU9d
         dfO+v8GZq70JryLWiC5z87SIpZxWNtIDKYldr4WEt6lOdTgepyXNHFCg2esVaMu5kaMV
         LRR0FZi+c4UTdlA+8T7YLug/qDjlpoT6ogSujZ9udadrcgKccNes4CfoipZjxxxZWKm0
         UWoqr1QO6JIpvnx+v19nz0wUCpmfi7VXhpPbeIoxcgwrYVDZtprQF7lIDVgg1PeVkT+U
         NOs4oiSHuwD8ILNMFcvOruEVGN9wC1ILwfbI9YNBvBOh84K1VzF0/eboWqgz7TFGs6tL
         3mKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757001976; x=1757606776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJB1/hNYsH8Q20BteySCtJnDw0ynZ68mEzNhyiDKstk=;
        b=lSXtS208X1xqtUVxPE2A6wTNCEKmQDtAxBOSZnOU1RPcxz03FmS5/Km7RX2bPqteHO
         hanIkjVJ0Jbb0IpDliqpUTUwv3uY+3yPcxNTl1hfPj2SUIltAARbAHMcCd/GrVZAGCrP
         7M2mMb3+bf9QpdN/uw7ICN8Q0/asR4eRKlb69crKCrxPIA/ngq4Hpc7lkhoObIIS3jRD
         fMgBBS61Y/IRXctHoRjNbgqXmGBmShG/QC1gdkxSovlyF03oSjtTIYpaGGu4I/RWDT6d
         qyZEWqe31feUoN/ksf3Zw7II7CjPEHTzoq8LPdTii73GW3JFmyzRinCFqQ+GoxYDVbmn
         gQzw==
X-Forwarded-Encrypted: i=1; AJvYcCUTy1Rd9F/PqmM8YoyN166akNLxeYPcdAA6uW9DqA+Q0pdTy6E/3fYAU9yVqCW1EA5m1usX7aQ/DyIzbfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgs2n0hww8ls+nQ/twJqoQJw/iqJJAGMf0BzaWbKbloYRG1/Qw
	bMLcvAapS+WA+cB26o74O9AWwmUS2rRJsrFP3nyOX5XMywO6AGwHWZiWK6MsgSymZZZUffSWfyv
	9Ocqm5l+xXIVr1Yp2MO7BfnjpvIT8zjo=
X-Gm-Gg: ASbGncvd7XNRdfGM0PL9C7PtygHzBaXP2PcHSbIOK5/GiEHaQKiRajeRCpqI08WgK1V
	c4CWYSGvj40fyc+JPjZr9CuLUq0z2S3VZYNNYy+De9e0HiWuviU6Hw9tsSNcOddai5tU5QPecAb
	6DdjpGZJeNoUmzQJzcMPQHkDjRAPkH32uu01F+jCVcn25q1MnMGkiuVjsv4rASQAdWrqVZOcXJi
	DFoBBlOJ9Q=
X-Google-Smtp-Source: AGHT+IHOugCOPsyWMYI/9frBi1EDh/M6MUda/nljZdBGVaeD4eAkldmiAKLHeV9fd51Mn6Vw2gFbWeyKSwJn5vu8fHA=
X-Received: by 2002:a05:6402:2686:b0:61f:afe3:9177 with SMTP id
 4fb4d7f45d1cf-61fafe393f9mr2096912a12.2.1757001976066; Thu, 04 Sep 2025
 09:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-2-ryncsn@gmail.com>
 <CAKEwX=O-_khBw0h3F+Uqx-8joMPHb-aOBuODx6LVO3vEZ38tpw@mail.gmail.com>
In-Reply-To: <CAKEwX=O-_khBw0h3F+Uqx-8joMPHb-aOBuODx6LVO3vEZ38tpw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 5 Sep 2025 00:05:39 +0800
X-Gm-Features: Ac12FXxv3acge-iILq_OS5ASCS0n5qK1Bxoju9QuUQYOMxssZswBOiwQNaPmA3s
Message-ID: <CAMgjq7Dy1ma_jq-AutAGjOXfinFPOLVJatz7dnHi_Nc563q2cA@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm, swap: use unified helper for swap cache look up
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 2:10=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Fri, Aug 22, 2025 at 12:20=E2=80=AFPM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Always use swap_cache_get_folio for swap cache folio look up. The reaso=
n
> > we are not using it in all places is that it also updates the readahead
> > info, and some callsites want to avoid that.
> >
> > So decouple readahead update with swap cache lookup into a standalone
> > helper, let the caller call the readahead update helper if that's
> > needed. And convert all swap cache lookups to use swap_cache_get_folio.
> >
> > After this commit, there are only three special cases for accessing swa=
p
> > cache space now: huge memory splitting, migration and shmem replacing,
> > because they need to lock the Xarray. Following commits will wrap their
> > accesses to the swap cache too with special helpers.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
>
> My personal taste is we should have one patch to do the decoupling of
> readahead update and the swapcache lookup, then another patch to use
> the swapcache lookup helper in places that previously cannot be used
> (due to the coupling of swapcache and readahead).
>
> But, this looks good to me :) Feel free to add:
>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
>

Thanks, I think I'll just drop the readahead update for now, it is
harmless to keep it out of the lock and it's really small change, I
didn't measure anything different either way.

We may test and figure out how to read ahead better later, not really
related to this series.

