Return-Path: <linux-kernel+bounces-720886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D741AAFC1B7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A064A78D2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE4C21767A;
	Tue,  8 Jul 2025 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBdC3zxy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C607C191F9C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751949381; cv=none; b=o82bEzfLjK73DR65SFZ9E5PHUn46tYE6yUv398nXk2iLM3Pvi1iCTqXpfeZIoWMWuLyopHdG43yboVjp0lbbMnVea1l+AxwW7R/91R029dIhFGMj2KONdm+eBOpvkq1g+deH4ZARMvy7AA8cdiZ6MI5KyBBm2DbWEIfAgnrRYEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751949381; c=relaxed/simple;
	bh=qTGDTcV1p5tJ6HcYmAwz71WaZ4eMKofozyVLBQsC9D0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/uHrcAgEpIdX7/JaV/s6XM1R9gyDMz0LgGtujvVdHe5p8fcl2DtWTURGFk2M2GRf3LMfgJdli+SynC7y7SscXgHvP7N+HliXJy8W15TeJgBCDbClncSbxsXzllR4TWMVaAErHCT6h2ula0ZeSja6WGyXmDa1jRF7KVEdG3Ku+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBdC3zxy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751949378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTGDTcV1p5tJ6HcYmAwz71WaZ4eMKofozyVLBQsC9D0=;
	b=SBdC3zxycP/dX697v6+4rdWEGWkoxGc9cGXOXqyqULyCxiqwlnQKdC6iNVGIy4KIAr7vdm
	d0bA2Pn2hTlq6Ig0A3tjIgOXqT5Jpszw0dzXYCiFHx76IX+w5Z8PLNZakK6QRnjyWqTp9O
	88Q0radNrZVpJCfsmKWocOd1Uem7qXs=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-1nVs1-2tN_O_WE9CwzEY_Q-1; Tue, 08 Jul 2025 00:36:15 -0400
X-MC-Unique: 1nVs1-2tN_O_WE9CwzEY_Q-1
X-Mimecast-MFC-AGG-ID: 1nVs1-2tN_O_WE9CwzEY_Q_1751949375
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-70e73d3c474so56661977b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 21:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751949375; x=1752554175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTGDTcV1p5tJ6HcYmAwz71WaZ4eMKofozyVLBQsC9D0=;
        b=GU/4qccdmEgWWeEw/NxZUkR/a+GDs92pa+0v3ERSmrInxzUylPB+zbMyetbbU3ZuCY
         nT9fIl7srfIhvHJrN39KWtPH+t67C+rQp1BvTmkLwpTD8rh/rtmKhRhNbbddSOCU8UrC
         adk9c8C5fUoOxneDKtNhq2K09AuWOsUtZZS1iYwfukRudBqF+5vx7WmEtf3flzEaxSsR
         PMUkNBcqgEfeAUYzT4oe7sKhV0r7385h5ccKIGPoMlIyTx0SEtZuEuUhxx6/6lmZk3vI
         BHbulHg+8eam5u/6uFbROb3pcdwlHSvt6y3oEJXHThxSnBKvfRqaKpLRF1qCglcU72bj
         zLAA==
X-Forwarded-Encrypted: i=1; AJvYcCV4r+xw6IXqJn8BMxjRy3VzgX6VzOtiHYuCaKo2DSVidySe2NNmPZhZhzSVWnf50BPTJWWa6fJFXz9mULU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIFIpp9Uv8a8/Ay4Xj8DVQp9XFj7xhvRDayrvaSnCBePz8avB3
	a+JZBbrLb57mkxn3S0QjMgcJjCQ97NaapixzFwxYmD5NqpkxYRUjQnQAqwGyQYDu6V9l3IJJvJ/
	0UEvuQ2eRSvkZ7hEbGc3cLTLvc5ONswk1fKKcOTEi/YdICtTIZMkpldzE7Zqk6/HwX3Sbe1KzBQ
	4fhAtX40iepPPPqb6zvtYIRLTcqZJzUVXmjF2b35V5
X-Gm-Gg: ASbGncuv+c/c/CyOCaFvuh2ToNf4emDDYZmxTXp4vcUKgCaK0DIOIfBMAU93RrUDVg1
	+yMc/hxG7d/0GegASm5yRmqt3qox8FuOEVed8HS0imRuEYU9BcRfGNW2HyVQNzdM0aG/2tZPqPp
	DDLI9m5Q==
X-Received: by 2002:a05:690c:30d:b0:709:197d:5d3c with SMTP id 00721157ae682-7166b5f6bcfmr211917557b3.11.1751949374975;
        Mon, 07 Jul 2025 21:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKjtH9W0tf3+AELmduA3IzT90z5Tmph6a1WdgnqS7MTd4DhLb5IlYzFbZ5iH11uL+3BnBYuaaRvKhebjyrKfY=
X-Received: by 2002:a05:690c:30d:b0:709:197d:5d3c with SMTP id
 00721157ae682-7166b5f6bcfmr211917397b3.11.1751949374622; Mon, 07 Jul 2025
 21:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702055742.102808-1-npache@redhat.com> <20250702055742.102808-2-npache@redhat.com>
 <9076b4be-8b1d-4434-a72f-d7a829a1a30a@arm.com>
In-Reply-To: <9076b4be-8b1d-4434-a72f-d7a829a1a30a@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 7 Jul 2025 22:35:48 -0600
X-Gm-Features: Ac12FXyKLeWcmAZn58XkB9-ZGx40IFZEQjeJRnPXwLLAOKV8sSiI_4SNmYsKQgM
Message-ID: <CAA1CXcDuR60EajhvSgGiwbNwTNiVi9-Pv6usSnnQWRC4ND9Vww@mail.gmail.com>
Subject: Re: [PATCH v8 01/15] khugepaged: rename hpage_collapse_* to khugepaged_*
To: Dev Jain <dev.jain@arm.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 11:14=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
>
> On 02/07/25 11:27 am, Nico Pache wrote:
> > functions in khugepaged.c use a mix of hpage_collapse and khugepaged
> > as the function prefix.
> >
> > rename all of them to khugepaged to keep things consistent and slightly
> > shorten the function names.
> >
> > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >
>
> You are essentially reverting commit 7d8faaf15545 which adds the
> hpage_collapse_ prefix. Since in the next patch you also unify
> madvise and khugepaged, removing hpage_collapse prefix would
> make sense, but then I tend to agree with Liam that dropping
> the prefix altogether is better. Having all the functions in
> khugepaged.c prefixed with khugepaged_ seems unnecessary work.
Ah thanks for pointing that out, I didn't realize they were already
once named khugepaged.

Makes sense, since there is opposition, and a good reason to have them
as hpage_collapse (or collapse) I'll consider either dropping this
patch, or changing it to "collapse_". tbh I didn't realize that was
what Liam was suggesting, I thought he was suggesting dropping the
hpage_collapse entirely.
>
> @David, I forgot where you replied but I remember you saying
> that we should not introduce MADV_COLLAPSE mTHP support for
> now?
Yeah Baolin pointed me to that thread
(https://lore.kernel.org/all/23b8ad10-cd1f-45df-a25c-78d01c8af44f@redhat.co=
m/)
I read most of that discussion as it was happening but missed that
point. I'll add the small change I need to drop the MADV_COLLAPSE
support and send a V9 in a few days (to gather more review).

Adding MADV_COLLAPSE support should be easy once/if we come to a
consensus on what the proper approach is.

Thanks,
-- Nico
>


