Return-Path: <linux-kernel+bounces-867938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 467E1C03F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19DA71A670C2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F6213D503;
	Fri, 24 Oct 2025 00:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPyCg07/"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19662AD25
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761266843; cv=none; b=G5m5vVaxrDxXk1euGBGRHcRptHLm9z8j/5XJ0dOdDu8l07549hL8/dbDv0p3/JJ4ltUUWTAA0YACT2tzeUJohRCr/Q2lAOTe5hURztwx5FCH1nhHEmj1JNHzQimPsKhgEls3SzxA17KiAwwj5PyFQHV803Mdqh8lL4qKxk+bDTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761266843; c=relaxed/simple;
	bh=8dekchQfMYsPgwmIHu1U8iRd6IWXI+KU+TikQrx5aks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjPJZqkhFxJiIA9OXmztZhejIKM1e73EIQZcdLW0/d2dWmcwovSGhK4vVVtzTw+vR6w80YufPIa8mO9Giu0scInm8DB65tYWPCCFLY6+vv9LGdPKhK1/q8T/jstmegsdgiAamFQd1JAljhB8eQ2gqSHqGHDzOAdR1XEMP59CFdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPyCg07/; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-88f26db50b4so143130385a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761266840; x=1761871640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dekchQfMYsPgwmIHu1U8iRd6IWXI+KU+TikQrx5aks=;
        b=KPyCg07/6NdhcIpy/Mz7mQj5L1sQId9Ulr0/rtDT97281k9S405zuQ0NMlLo+b4zo5
         k0rLwXb8eoUyNP/0K3LjX+jKuWg4UE2rUGPMpQQKMq+F+FBA+W7ovTgPwf/+k4TDKh51
         91g9YD6F29iJAgbJwUwxr/J6qLTvexe0EmAaZgpOpt1esC4c8PuQ3tB7MoLF54+WoT0r
         bX44Zv0m0pUsFunGpRgxGu4gpRcsxoAd6dyQWk1iDmkENMn8Ssit1WQSTRGAZ2URKp4m
         6l5pKTfJdLNrpKlHaFmcfd8WRRBVaVMgKJkV+e+LyQZ3W3Xz2W2IsJoRj+67n8M4/aKt
         DKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761266840; x=1761871640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dekchQfMYsPgwmIHu1U8iRd6IWXI+KU+TikQrx5aks=;
        b=lh9F4HIh+eTFhreV3jQL3glMBiqenscv9NTyo75FdSkWp0IeNZpEbIUiaqsbH7Sex+
         coH5+A5uLFoY1O8JD7ZZEOD0HbPQo8dLY7Yy29xR1sbuiCeWzaTN1GpXFkIta5+iYr62
         SMszvzw73OAUbhyea6vfr7O5MoJGht43Urw0WopraSUniRRVyA+2+aPQG0snUOGzIjhQ
         jVxiIK8pljyWWDe6gqtoxZYIjtnd1nXnt+scWv624M1uPqDloDwR4i3aldUC+QzWbYJn
         wCuHWG8FeLr/o6QP1frlLpaSKLfU0kxIKN8T6Opt2EadjwICTtYWLXW7/8McZXbKsw9h
         IKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbZHhwKYIjeeW3oPj1fMHF9xOMnPvkPVsSn/hutJUUsPOlJwzMG7kIPROAKRikN8BCgVgTFgKZi+WSdV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+9QDJ4Hzxv84tH2cCM7ntmLawp+T0SoHGUSeDPEoFX1/lt+y7
	5A6tZlsjr3L6reJzba86WEdhGyN4aqHKTkY24m/E1P0q8nFIrzTENXXRBXEYMRvsFvkKaonAVZ1
	f/qnfWXoZ1e6R9NQ08GIN8TsKo4FmPiA=
X-Gm-Gg: ASbGncuB9/xpJ5HDOihwBg31sP3ndQlUotGqZFcb6N6hxuU0Y0/anapw7coMt/cb2Le
	umJ6EdgkCCwlpiYE7VToMSPEZrleIjVD6kSZEZQu5m34HwiWwJJnFHqK2miIPUqrnY1N0fGQpoi
	LtWGzsdOht4n4it+9PPLaQ9HhmAmu0zJsj7/JukmzH9D+ZJ/KGtBqpD8fi/hGJ+4gkWHfhkNv+W
	93/gERhMS2gLinmPfzXmsOY3tuqGDVCd9B3291RcK7+ZyD/4xSX5Z2lkTW/r4d9FUH48f6D91wv
	cw1jR3rmkxo1FnLHvYhbzQi9RtI=
X-Google-Smtp-Source: AGHT+IGokajvF01sX9F7KXkvDGH2BAi4A0xlPGkcF5m+/FFCBakkYwkQlnjuvwYu0COErqKt6mUfvQXhm2R9aA7CSo0=
X-Received: by 2002:a05:620a:4510:b0:892:624f:7f74 with SMTP id
 af79cd13be357-892624f836fmr2622571385a.28.1761266840350; Thu, 23 Oct 2025
 17:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023065913.36925-1-ryncsn@gmail.com> <774c443f-f12f-4d4f-93b1-8913734b62b2@redhat.com>
 <f0715f2c-ee27-4e13-84d0-5df156410527@redhat.com> <CAMgjq7Chg6e_xL4wxYJqMzmCRENawQ63KSABrZ9zVbR4ET=YFA@mail.gmail.com>
In-Reply-To: <CAMgjq7Chg6e_xL4wxYJqMzmCRENawQ63KSABrZ9zVbR4ET=YFA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 24 Oct 2025 08:47:08 +0800
X-Gm-Features: AS18NWCj9MGFG1npl-3BLgwz1S4LiopMlEcRzQLs-xgJmd9nWQbr_QcVvyIi32Q
Message-ID: <CAGsJ_4wQ_9xTHxbRsipir7aiEdjeUNnYO5Xy67tRcFTQxfpZhQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm/shmem: fix THP allocation and fallback loop
To: Kairui Song <ryncsn@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, 
	Dev Jain <dev.jain@arm.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mariano Pache <npache@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >
> > Answering my own question, the "Link:" above should be
> >
> > Closes:
> > https://lore.kernel.org/linux-mm/CAMgjq7DqgAmj25nDUwwu1U2cSGSn8n4-Hqpgo=
ttedy0S6YYeUw@mail.gmail.com/
> >
>
> Thanks for the review. It's reported by and fixed by me, so I didn't
> include an extra Report-By & Closes, I thought that's kind of
> redundant. Do we need that? Maybe Andrew can help add it :) ?

I also think it=E2=80=99s better to use =E2=80=9CCloses:=E2=80=9D. In that =
case, we might need
to slightly
adjust the commit log to remove "[1]" here.

" This may result in inserting and returning a folio of the wrong index
 and cause data corruption with some userspace workloads [1]."

With that,
Reviewed-by: Barry Song <baohua@kernel.org>

Thanks
Barry

