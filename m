Return-Path: <linux-kernel+bounces-853808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFFCBDCA4C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320541927F25
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C0C302CCD;
	Wed, 15 Oct 2025 05:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1y43XQg"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B7E27874F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760507593; cv=none; b=sD6HNem2vv7/BFk8qsaO4LG3na4rszfLpNsx+NJKTdnZj0e2aOZF8Tx0bQ4JgvPyw6R29ymzSbwdlI1emit1IWCErC9Jp8NnF2YeJNWi1VylB/LD+sU0cPFh9NgAcRzsrKZMaMzYP6F/fjBtvwNSi2LJXyyk1Ze1OMg4TRo5058=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760507593; c=relaxed/simple;
	bh=O1fcHkwOsLK9Va+WIry1KaLb0cCpP3mI3c2QtZQNth8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgHDKHW8UZgK2lnd4zT3Wti+kqP1eN/FWbFDAvUgkQ95JZMtiRagDrbef9xcYfmda4sRuL64ykPiOaCPLCtI0VAk5vBnnxfRgnzGzUU5WSGg3JA4GxTpeRAwT4voF375PCCz/C3lt/M/O9Kh1cEPpLog3MNLUGP/nhPunv608+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1y43XQg; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57b35d221e2so1008480e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760507590; x=1761112390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFLT62ixVQldJQ7fYkTdCMI80L5ybOIFkFHbPj9dyUI=;
        b=G1y43XQgSaLWvI0iXecqFqsYQW/5izDiKcltzFTErNOVx/P4fQyjAofHhIop/xy6YR
         goVW4x5btV9huEhf4pKkGzEradeZ7pKaeyn9WRPb/4kv/Cc6B+8P+1jDRvImUIj4Q1Rd
         qMPapvFbgh26IHAK90879cuRdUHbBQFi3uqNnv0fiHc2RgX2/QYiBIx1Kp0X2HXSb2Kg
         khYcI19su8307MteAtwgLwvv1zX8yz5vUxcPUEt4MFSZnBLdWvlK/mjI9kysY6qm6rMA
         QJxwZgnjerw2SOJ2rlubsNxPjNU0YDbFlNtdPScP/+hktT99XpWE0zBKdrTjc9UmKSpi
         e2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760507590; x=1761112390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFLT62ixVQldJQ7fYkTdCMI80L5ybOIFkFHbPj9dyUI=;
        b=ZiGc9AjGVtZcNPWgPgIeodvNCfL4WmWsv7Yj6b7Njoh2kvRiT5IiD77MnvmzSWr2O3
         QUgPyIsUa1Y3baH9p5Ye0DADDW9EmMCmL7Fy1+SnOAG+DnYQuDe8nh3dCNA3EEOwVKG7
         9Ew41Lo0S4+XNoaiab+mcd7QFqA7klUFBe1ocOD3yoVpWH4HVIbsO4H0jRUzZKSKrp+H
         /xKwnojMf/9OU4aF0RhGkB6kyVdMw+X9yk0cHFIer6AihdPFiYHrVl9SqAkxFBt+z44v
         EFzZcFIkXt0f3lz6PasYuPHTLmsVQahq72snCQDk1et/y8IvSZh21apfVXbmE3Q6uJpG
         EGDw==
X-Forwarded-Encrypted: i=1; AJvYcCWaEUMBzA1rw48bn9Gw8GQacKqCVQo7y514QQEwC52cqVsZSJXF6mhPgmkVSxXlig2p5JhBIGeJwTauRds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7VztiISf+HlEexYvaUX4E4+F2mBXmXzDp0XRnNh07OZHcCt/C
	mbWfET0CdrNMFLuS3CiZwW4sR2NcuxHjTJDHYy2lWeFX259ZYvKkli4n6RY4ITGceMwCgv1P7YN
	DtCW0CpIVV9q3KWBrXtwUOVcIl94aw4w=
X-Gm-Gg: ASbGncssi0SmmosuUEY3b50saFhmRhbBoMs9H+Zsa6Mgg4sYGqw9QvwJTPdTDa4uQUR
	u0Oo1s7t5XP45yMi7p1cd95Rn7UyOyeOTzi23zCqyJkXETVUf7P20QH7vqdhYXToR2uQ0oldYfZ
	FDYWWjOV/EeLuMeheYytg9gmG0VvwK39d00+GAXyfHSmgDpFQ/7ZRO+IWm/aihxilij1w7LsZFI
	ZgBC63btGQ6DmjBx8TJWC1jO/4=
X-Google-Smtp-Source: AGHT+IFLUphpgOZG5QCNUsC60fCVIMlNWQyaFYF7MclW2rvaBp7nodjf6JgXjXmvHO9NPEejKXvxuliDGWMWkHx4m3I=
X-Received: by 2002:a2e:bea4:0:b0:36d:501:76bc with SMTP id
 38308e7fff4ca-37609c975f0mr40445141fa.2.1760507589531; Tue, 14 Oct 2025
 22:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014083230.1181072-1-zhaoyang.huang@unisoc.com>
 <20251014083230.1181072-3-zhaoyang.huang@unisoc.com> <87953097-a105-4775-88a5-9b3a676ff139@amd.com>
 <CAGWkznGN7W-txq_G+xpZ6DtH_1DNorYc=CxqUjebo7qfB4Sxsw@mail.gmail.com>
 <ecba7133-699c-4f3e-927c-bad5bd4c36a3@amd.com> <20251014171003.57bbfd63@mordecai.tesarici.cz>
 <97da9924-9489-4d30-a858-8ee5c87bc031@amd.com> <CAGWkznGnmb=8GgcrfDvY2REHdRZYVXZy=F3thXhK0FaSoiK7tw@mail.gmail.com>
 <aO8TKQN6ifOSMRSC@casper.infradead.org>
In-Reply-To: <aO8TKQN6ifOSMRSC@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 15 Oct 2025 13:52:57 +0800
X-Gm-Features: AS18NWBOWQWzhWDzp18HSEEZyxB5KfY1PDfoAz_DuZJ3dbHjn7xlZV-pDkl9jw0
Message-ID: <CAGWkznFG2_WGmLRmHnjV-49iTX0mrt9jxQBzZYK=K9U7eKJD0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] driver: dma-buf: use alloc_pages_bulk_list for
 order-0 allocation
To: Matthew Wilcox <willy@infradead.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Suren Baghdasaryan <surenb@google.com>, Petr Tesarik <ptesarik@suse.com>, 
	"zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Mel Gorman <mgorman@techsingularity.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 11:21=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Wed, Oct 15, 2025 at 09:12:07AM +0800, Zhaoyang Huang wrote:
> > > Could be that we need to make this behavior conditional, but somebody=
 would need to come up with some really good arguments to justify the compl=
exity.
> > ok, should we use CONFIG_DMA_BUF_BULK_ALLOCATION or a variable
> > controlled by sysfs interface?
>
> No.  Explain what you're trying to solve, because you haven't yet.
Dma-buf works as a memory allocation backend could loop thousands of
times alloc_pages for allocating order-0 pages to fulfill the dozens
MB demand, this commit would like to replace the loop by once
alloc_pages_bulk. Whereas, alloc_pages_bulk_array perhaps introduces
extra memory allocation along with direct-reclaim which could be more
expensive than iterating the list. so call back the API
alloc_pages_bulk_list as well

