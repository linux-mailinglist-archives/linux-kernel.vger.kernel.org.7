Return-Path: <linux-kernel+bounces-759387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167E7B1DCE1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2AC47B1394
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43682248A0;
	Thu,  7 Aug 2025 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IjKHGVc/"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0E221737
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754590079; cv=none; b=DZ/KgxyWhAPkPkhB6hVQL4tq+w9mIw8knFxGgjRsiU8MRu6RafAYweGemSZ/ZQSI/XIUrvCvaEJVC5J/FZC44gEH0lgfHQt32pQx4WjGNaTYJ2miQ9DrF4Gr3i4JXqBxoTFEQ1TTF4Jt8TwOLRSaBmUv+B9Qs29GVYpxcYjY9Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754590079; c=relaxed/simple;
	bh=OJjrlRJdnoSfaEsthcGrvehuO++RaWyGHz6KW+JMhbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ck4g8A1MAJVa0CRSutV5N9000vROXgPjxshZOHWX+O1j9sDcIR7qFmyeU7IefkTx9UP81LKidd1YzXD5NVDwTHCvas/Hau9oeJPcu0C0X+tioYE/tYzslRqz4Sopu6OIrE4URZI0Wx8q1FuYj46ZxNdfqkMIfI4+eHn1lvkJc2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IjKHGVc/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6156c3301ccso1323a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754590075; x=1755194875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJjrlRJdnoSfaEsthcGrvehuO++RaWyGHz6KW+JMhbA=;
        b=IjKHGVc/ZCUBlEz7zun6AwnjXmRdrHk42JSvTWJJ7Yw8+V+bsEVyrX04TlseDafqC1
         U3QQOEpsIMIz7wrcA6qQunq5lQQYqSgpmugCEtsBiHwv4H/13iBK64RX5to9PJGl1E56
         62PFMFRx6qMriFaczX1zRJMJzRF/TmxBoDuWpzk6fH3rC2i/NeMY5R1Df+pCeLKo+Lln
         gAkVugJ38U03iE0erhrQcoGefG8ETUQWHDlXTozXVxreahLZ/yLL4/oQZdvhICnEWLnO
         elJ8jz5IyW9U5PvAcp0BG7fwn+iiXAxtO2TrFfSlzPnTSa0rOSHp2H9Be0wO7HjfeU0Y
         dE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754590075; x=1755194875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJjrlRJdnoSfaEsthcGrvehuO++RaWyGHz6KW+JMhbA=;
        b=Fy7ZtO2nntotO/zjUV/8pP25Elr0ChiAUEQtEt5KXkfRTDN98R3uodAkcvhTupAmF6
         RpR7gHlKz+9POhjfPRs0H0jlL0VBkLMhgzuFqnkH5Y2weNUyapSiOJbEarMZggSzom2F
         eTrSh+w3aitAKo/cqutDVDryAQv3tWEXrzrDiO0vCI7ouPfV0PhEGS2oeOOXKfjY9oGC
         tJeRMivXY3oGWwZ8DOdZqJVpKqSbf57gT1dkusWOf81Pu5JJFIwT4uvqgZcf9rhJx5CJ
         sExKcNRcgKuyj1PI/MU4mNR8ciyuCroufIdM22L6zdudzaD8bUsL837+vT15gHw0bZ9x
         c+tw==
X-Forwarded-Encrypted: i=1; AJvYcCUFrbGrIKAJocxvHkb05GXqgjsXZo2iE5iisty8TN5cZK1gxAouMaRvjQVTQMnERAAMFUa6/4n0DbOAquw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhV1waGlFhRHHgzcPgygDmQv17uNNT2YOG7gdVt6lLUcrvFUj+
	nFcc8OFV0uE+oGG0DR9qh35CsprhWXMiMEFTlbCCKk1GpVSTkUPka5sUfSSg5qQ95as9eN+9zyQ
	Zk08Mb38s1jnz5ZcT+QTumfsC2YfhBpuJ+e8g9b1U
X-Gm-Gg: ASbGnctzYufEDkjLD/cb/lDvPZ4rJuBceyW8LdF6Afk5rvHXFVLi3Xop3SHozJjJYkM
	lkNjOQJte+dF96Jm0i5rBag0fMLg+idGvCbne6ZQwJZ2uGQ4MnMnLhzbVlddIFQXU1S61ODEIFF
	nGMA15m7DVFXFPJ9i3Nmq8a1ed0m1xM3PxLjvHB8v3JEMxG82HWPleVxBW7axb0dSlJ7mRI63FO
	/3P6kE9EdXA4B11hkq3gPUs6/tsNjxzbgmZJclt8dqJKQ==
X-Google-Smtp-Source: AGHT+IEvzSpesfYkgCCAObC0Xg+i6NHA/CnpVU4+05f2BuAcOX+avD3vpz0PZpZe3fpUS1se60bl8/syKu6NXlsQlSk=
X-Received: by 2002:aa7:c40b:0:b0:615:49c4:893f with SMTP id
 4fb4d7f45d1cf-617e1500d80mr6028a12.2.1754590074764; Thu, 07 Aug 2025 11:07:54
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202508071609.4e743d7c-lkp@intel.com> <9e3a59b2-11c0-43ca-aff3-414091f04aa4@lucifer.local>
 <CAG48ez3=8f3eShjAe9hrvivP+Dvyisw=X_Tr_phc-OX_4MzeDw@mail.gmail.com>
 <be074809-e1fd-43a2-9396-8f7264532c4d@lucifer.local> <CAG48ez3=kLL4wBxAVSa2Ugrws+-RFQMdNY9jx5FAdbhpNt8fGg@mail.gmail.com>
 <e4f5faea-ccec-4cc7-83de-1a3c7013b81b@lucifer.local> <cbc2e23d-69ab-4820-9942-c7abf2066ff7@redhat.com>
In-Reply-To: <cbc2e23d-69ab-4820-9942-c7abf2066ff7@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 7 Aug 2025 20:07:18 +0200
X-Gm-Features: Ac12FXzrdHLe93hwXByTP7b5qoMtUlDB28KMIEXNNyEkjC99e8lIwwa1vdl72oo
Message-ID: <CAG48ez1vM35DZ=kTSd4+ndgR6y33AodLLC2KbfbhGrkDaqdnNQ@mail.gmail.com>
Subject: Re: [linus:master] [mm] f822a9a81a: stress-ng.bigheap.realloc_calls_per_sec
 37.3% regression
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, kernel test robot <oliver.sang@intel.com>, 
	Dev Jain <dev.jain@arm.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Barry Song <baohua@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Bang Li <libang.li@antgroup.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, bibo mao <maobibo@loongson.cn>, 
	Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Lance Yang <ioworker0@gmail.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Peter Xu <peterx@redhat.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Yang Shi <yang@os.amperecomputing.com>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 8:02=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> Sure, we could use pte_batch_hint(), but I'm curious if x86 would also
> benefit with larger folios (e.g., 64K, 128K) with this patch.

Where would you expect such a benefit to come from? This function is
more or less a memcpy(), except it has to read PTEs with xchg(), write
them atomically, and set softdirty flags. For x86, what the associated
folios look like and whether the PTEs are contiguous shouldn't matter.

