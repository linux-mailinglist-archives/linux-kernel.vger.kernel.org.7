Return-Path: <linux-kernel+bounces-759362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3406B1DCA2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3271164938
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1780D1DF73A;
	Thu,  7 Aug 2025 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fhT2rwqN"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D1013E02D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754588840; cv=none; b=L2rMer/3ZMkjrw+7mEUXxhX8AwZStOak9nQk61cJZciBQQdihl2XqnEo2G0vAyE0j7lTdL/mN0Z/R0RPZdQz9pAfDrJUjUHJalsFly41ptceRl3KjsHlXoIR+0JzRAPkou3iZrkL/AdsVPoWOEWjxlkpi3u5lKFiyPvh+7v+hCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754588840; c=relaxed/simple;
	bh=bxkn7i2AaddKJTrBuQ4SxegpUk68fzfrs9vOHQQz7TY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGzOP8mrU0OTufUZasLe15LgsRLAdJ2ZZxU5q8uDcRHNZee/ZHPIBf9TKgtsiKtls8aljPR5yX8UxyrQD0DH8WRAnzgH0OVYAm7gqrwM9G2zMJ2OyLsoK4WrvqQ+k51hwbFERCIlMMycq0/QB8SMXT0lWo2jwnH+ddMnAiRPkHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fhT2rwqN; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6154c7b3ee7so1301a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 10:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754588836; x=1755193636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDJdMpTFc0KMKXcRTALWA1S9ovbUgwwdEZq6bXr34JU=;
        b=fhT2rwqNKHfUVSPVphTLU/fFXvSUBUckpBTu9QnIoxoorMWZ4MciG6lrc7paVm1CgI
         xiaB2sM6YnNpMZKUz8ME/8Pi0HXWqkHSlGpiFihEbxxk140I4kpmE1sOyQamwWrikWHx
         +Yv0bWsbJ7/Iu37Wwn9kygzve2lx9a7Kh2ovchIxcNEM74bs/GYn7cZGHO+dU6g9JsGJ
         RZYWHhsbBELMoe+jfQG/EjJizqFYfMAf3cYNCT6Fl7+ZDGN8UJa+hoh8hpHVPzVAmSDb
         rMDMGxF0GsiiA330mf4Ic/2m8iZgzyFjJk69xNcRHnmepzwdnpD0z2Qh2JB2hu3ixNnf
         7Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754588836; x=1755193636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDJdMpTFc0KMKXcRTALWA1S9ovbUgwwdEZq6bXr34JU=;
        b=FloMUixEgrOZDxKckmv5Sna4mTN5rKjwITDa5WAsfrcVGSmc1BYivX07tGKhWgBD90
         +FlLS6aVCfmT1JoLGHTLpt4dZ22tYrJ2yv2Yun+XFK6mu0eiqp5CNo4WB6L4OS58RZRQ
         1uggUyms4db92Er1faV5ih5QET+6byVBV+lkz5FyHPMy4v9chetshXqr4iKSGhr5Dv8X
         9KxgrBNHyJWOp3tcDIxxS3pQCQM4zfmsWjlzvVyTzotDiYfLs4iV0ILN9uxo6J++VVri
         okwUPd9P2JBYUaCPQGp8vpiEiY7bmq88R2H+1qoL43Qrlg8YZg9cjnwouxhHIkEMoFXi
         bjGA==
X-Forwarded-Encrypted: i=1; AJvYcCVvR6embNZPN6u+kuHNNia1/XtO5m7aG8UPoohcOkSZUAW7UWb3cfSvB3xDtYp7hIGPRqAEF2uIWWSJgUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCg+7F3g/lSm6M++3O4BKGCDj6cvY27KjT+nmXB/zC3lTH3nMz
	d5PdeJvD0cxnXpBmy0hZtC5ju4h9UvQADOFQHF03tFDy9Um+GWay/pjYXGbEJOntprIZRLCciWT
	Fl4+oFk9IoEHRZmrteLP/uorGW/seWa2mXvXf8OzS
X-Gm-Gg: ASbGnctQTu7jx2NwhL3pVqAKqdUjZ/99NuZWngr/Ab471Jw+ziXce2dQUgLdCjc65Pl
	GccwcbjTzJ6tsdRI4A7aVGyxNu2e4+iW3T5MzQ1VdEdaev/ckmhDaqQZS39T1p/Fhl1DsXC7m+4
	FWbh/0vD2dAiPrZaJ3ghuwYCKSPwvUpDnyeAkseKd1CrtO+UFcBL8O31p4VABKWMNPriJha7rWd
	b+VPS+6Nx1m5r+NQwNoH19U9KbyVid7l8E=
X-Google-Smtp-Source: AGHT+IFVAwixRVEdAdG9acHP30gULaJwSYNDDdAwpFBfQR2iG91VTEgNHzYlsENI7tXxpeqYxK8IG0xUMq0IsdLdjZM=
X-Received: by 2002:a05:6402:292f:b0:615:63af:84c7 with SMTP id
 4fb4d7f45d1cf-617e0c2fea6mr1229a12.0.1754588835703; Thu, 07 Aug 2025 10:47:15
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202508071609.4e743d7c-lkp@intel.com> <9e3a59b2-11c0-43ca-aff3-414091f04aa4@lucifer.local>
 <CAG48ez3=8f3eShjAe9hrvivP+Dvyisw=X_Tr_phc-OX_4MzeDw@mail.gmail.com> <be074809-e1fd-43a2-9396-8f7264532c4d@lucifer.local>
In-Reply-To: <be074809-e1fd-43a2-9396-8f7264532c4d@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Thu, 7 Aug 2025 19:46:39 +0200
X-Gm-Features: Ac12FXz0pqhZ5ZXNMYXrgkg69OVAPBJ7j_8d24_PRsIXf3jxPz6zdWEIncqLCrg
Message-ID: <CAG48ez3=kLL4wBxAVSa2Ugrws+-RFQMdNY9jx5FAdbhpNt8fGg@mail.gmail.com>
Subject: Re: [linus:master] [mm] f822a9a81a: stress-ng.bigheap.realloc_calls_per_sec
 37.3% regression
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: kernel test robot <oliver.sang@intel.com>, Dev Jain <dev.jain@arm.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Bang Li <libang.li@antgroup.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	bibo mao <maobibo@loongson.cn>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Ingo Molnar <mingo@kernel.org>, Lance Yang <ioworker0@gmail.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Peter Xu <peterx@redhat.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Yang Shi <yang@os.amperecomputing.com>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 7:41=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Thu, Aug 07, 2025 at 07:37:38PM +0200, Jann Horn wrote:
> > On Thu, Aug 7, 2025 at 10:28=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > On Thu, Aug 07, 2025 at 04:17:09PM +0800, kernel test robot wrote:
> > > > 94dab12d86cf77ff f822a9a81a31311d67f260aea96
> > > > ---------------- ---------------------------
> > > >          %stddev     %change         %stddev
> > > >              \          |                \
> > > >      13777 =C4=85 37%     +45.0%      19979 =C4=85 27%  numa-vmstat=
.node1.nr_slab_reclaimable
> > > >     367205            +2.3%     375703        vmstat.system.in
> > > >      55106 =C4=85 37%     +45.1%      79971 =C4=85 27%  numa-meminf=
o.node1.KReclaimable
> > > >      55106 =C4=85 37%     +45.1%      79971 =C4=85 27%  numa-meminf=
o.node1.SReclaimable
> > > >     559381           -37.3%     350757        stress-ng.bigheap.rea=
lloc_calls_per_sec
> > > >      11468            +1.2%      11603        stress-ng.time.system=
_time
> > > >     296.25            +4.5%     309.70        stress-ng.time.user_t=
ime
> > > >       0.81 =C4=85187%    -100.0%       0.00        perf-sched.sch_d=
elay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
> > > >       9.36 =C4=85165%    -100.0%       0.00        perf-sched.sch_d=
elay.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
> > > >       0.81 =C4=85187%    -100.0%       0.00        perf-sched.wait_=
time.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
> > > >       9.36 =C4=85165%    -100.0%       0.00        perf-sched.wait_=
time.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
> > > >       5.50 =C4=85 17%    +390.9%      27.00 =C4=85 56%  perf-c2c.DR=
AM.local
> > > >     388.50 =C4=85 10%    +114.7%     834.17 =C4=85 33%  perf-c2c.DR=
AM.remote
> > > >       1214 =C4=85 13%    +107.3%       2517 =C4=85 31%  perf-c2c.HI=
TM.local
> > > >     135.00 =C4=85 19%    +130.9%     311.67 =C4=85 32%  perf-c2c.HI=
TM.remote
> > > >       1349 =C4=85 13%    +109.6%       2829 =C4=85 31%  perf-c2c.HI=
TM.total
> > >
> > > Yeah this also looks pretty consistent too...
> >
> > FWIW, HITM hat different meanings depending on exactly which
> > microarchitecture that test happened on; the message says it is from
> > Sapphire Rapids, which is a successor of Ice Lake, so HITM is less
> > meaningful than if it came from a pre-IceLake system (see
> > https://lore.kernel.org/all/CAG48ez3RmV6SsVw9oyTXxQXHp3rqtKDk2qwJWo9TGv=
XCq7Xr-w@mail.gmail.com/).
> >
> > To me those numbers mainly look like you're accessing a lot more
> > cache-cold data. (On pre-IceLake they would indicate cacheline
> > bouncing, but I guess here they probably don't.) And that makes sense,
> > since before the patch, this path was just moving PTEs around without
> > looking at the associated pages/folios; basically more or less like a
> > memcpy() on x86-64. But after the patch, for every 8 bytes that you
> > copy, you have to load a cacheline from the vmemmap to get the page.
>
> Yup this is representative of what my investigation is showing.
>
> I've narrowed it down but want to wait to report until I'm sure...
>
> But yeah we're doing a _lot_ more work.
>
> I'm leaning towards disabling except for arm64 atm tbh, seems mremap is
> especially sensitive to this (I found issues with this with my abortive m=
remap
> anon merging stuff too, but really expected it there...)

Another approach would be to always read and write PTEs in
contpte-sized chunks here, without caring whether they're actually
contiguous or whatever, or something along those lines.

