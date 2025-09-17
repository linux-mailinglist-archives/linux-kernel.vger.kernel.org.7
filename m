Return-Path: <linux-kernel+bounces-821745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7CFB82222
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 547154E050D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59F82820B7;
	Wed, 17 Sep 2025 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BQpR0Z7q"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAAD21D596
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758147356; cv=none; b=CwYO1mCqP6j45z7LzTP5ytmiyi3ZVKybi/HIWPnEkEcs41UkQs7iPmL/WT47UMC+4XdTYCki4UFAULQvXIccbfVh7KNqTcvKYH70g8rwjaMIvtKFK8i5nwoOtAzJSAoXS4+EJysIdbL5otdG+Xyy7iLaCB3F0pi8y1GPKCctGFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758147356; c=relaxed/simple;
	bh=Kd9UGKeQ1gYpGY/Nhf4uQCQ+fFAnl1+Ce2pz+iw3ShI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N48UBG0R8jOQPRYDP4Zxs7DzGGdv74Q2C9ZQdDhvAhN5nL3q25ZRqq6qtqPEA+lZaLn1/4hFhCYwdRmeJZLzeULqKE1U07aF2wOd0E/xXN4E/prr/S3AY/ajiKQDnBGuILrkNzY7N+A31/4Jswydao9nd/1JkSeS0HOVpbIb7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BQpR0Z7q; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45f30011eceso12855e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758147353; x=1758752153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p4ncEV/0Oe5T32Jx5hlprtEOLrd/1ewkvxiGL3vw0c=;
        b=BQpR0Z7qp1dbuQ0hwtjW+YEh67E4ir9mX8LKgw3ZtqZxOQyR0zMR1VGvczXhk8NXPB
         bFKEGEEIacBv27NmS+oUUdGFR21akiwXj1j937IGHrsW8L1QLJNm/J343Y9iJZ1HF8vH
         lFB/Y++NgNCVx+IclVLmef0aButZMoFmvbMVP0VMB0Xr5AAbFnjxqC37M9HyzJfJ5twB
         50b/3UHcAenuwa10gaSfWnA5KXyKLN9WoLD9GrijgZRVplpCrsRHISADc0Hmr0a97uMW
         dc0dmdUkt6e/pwsqh3xGJeeGlqbyLHjXfvzwfbRTDa3IIoh4Eo89dqhN3x/NQWgu62GK
         wZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758147353; x=1758752153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1p4ncEV/0Oe5T32Jx5hlprtEOLrd/1ewkvxiGL3vw0c=;
        b=hJFsSb0Lu6hUa+QxhckwZDOTq0GSrurC76FHpw61mDFdttLVucxV/k/+RiNbzEUTeA
         Gmh9cWnsEiLMJY+CH8px4T1VPK9ahIsaase/OCsi7m6QCDESgFYGNBCJAZROihiI7K86
         fydYOPLaKgHvy9c1prxolAdu2XXatXIsULtqEjnsbU9X+t+8WW2NS0/m+yUaPJV9QAeQ
         wo/A227i8yTNA1aSxYSKNbLaZUauieDCb0IXvl3AMtWMNLuhp02cWPHl5bwiYcQ7A/7+
         HC2K2BQ4O+aSbEuOEBGkLZEpbTsXq6eeydFleqtH/uyqbPFrDbKvp5y76/oB7hns7p9O
         9Njg==
X-Forwarded-Encrypted: i=1; AJvYcCXjwag4mQSI1urPG/faz1DqLDXFeXbZzLs+wr6ZJ/sG4yZ60HcItNCQjBxopuLbBEei+Ka9bf09BSFai30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw442Cbc0lRX5EhnMucekuHTG1XUu+sVL80s9NZq4J7QN5xSV9G
	UyS13i3I+sqQuWyHQBrXfyY4L8UkC1r4fwAGSF54ULOqhLlqitwowPcxB6iitrSpuFymGXKhmas
	Q6gjsJbO7YB81C445KF2uP1yDlOHrZhES7/cWOc63
X-Gm-Gg: ASbGncuOY3yCy1YkZykRGw6jE77AabDcL6atqjmxL0PCryiFZKwtAt5dGe5MEje67sT
	c0XGYNFNp4YPNTrnO4J9Txa0+kNgnniBWc0bFI10YKw5mhgb+oV54MpAww4yiU519SfmvzciBt9
	yY18uc0vWujipKQDfKDddbeCv0MDWvf7cy+7W4huPtL7uI8ANWs90LpjAJLtNBklXYAwOY8c85T
	ac0tMUvRbrkl7MeOvbrCnQiHzHkRuZv0kJxWJf81EM3wIb2lRHCeFtHoAXd/xM=
X-Google-Smtp-Source: AGHT+IETa168RMgXYCyuMbREDGOaHVmJadjLDpn2kmhrTSuNtoIw5sYpaUJCBGdkIQavpq6g1JLeI6FZ1TdA3bdskYU=
X-Received: by 2002:a05:600c:3f0e:b0:45f:2e6d:c9ee with SMTP id
 5b1f17b1804b1-4615364d0efmr2582795e9.6.1758147352822; Wed, 17 Sep 2025
 15:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMiu_Uku6Y5ZbuhM@hpe.com> <a99eb11f-a7ac-48a3-a671-c5f0f6b5b491@arm.com>
 <8c3188da-7078-4099-973a-1d0d74db2720@redhat.com> <aMsDJ3EU1zVJ00cX@hpe.com>
 <cd71fac2-bb9d-4e84-a074-2b695654e655@redhat.com> <CACw3F52p45t3iSZPjx_Lq9kBn1ZGTDZsxk+iQ-xFA1zdvdqqrw@mail.gmail.com>
 <aMsR4Tr9ov1pfucC@agluck-desk3> <aMsqdesM1ImJp1yt@hpe.com>
In-Reply-To: <aMsqdesM1ImJp1yt@hpe.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Wed, 17 Sep 2025 15:15:41 -0700
X-Gm-Features: AS18NWB0Be2bZgwB40bum70rJy1DrSew59KlnBWueOxwtEk5FxFH7XCa5Jb7Kdo
Message-ID: <CACw3F51w=HfA1no7BqpaKX4ta+O6KAwp8NnRMdePc7wFW1yQmA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, David Hildenbrand <david@redhat.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, akpm@linux-foundation.org, corbet@lwn.net, 
	linmiaohe@huawei.com, shuah@kernel.org, jane.chu@oracle.com, 
	Liam.Howlett@oracle.com, bp@alien8.de, hannes@cmpxchg.org, jack@suse.cz, 
	joel.granados@kernel.org, laoar.shao@gmail.com, lorenzo.stoakes@oracle.com, 
	mclapinski@google.com, mhocko@suse.com, nao.horiguchi@gmail.com, 
	osalvador@suse.de, rafael.j.wysocki@intel.com, rppt@kernel.org, 
	russ.anderson@hpe.com, shawn.fan@intel.com, surenb@google.com, vbabka@suse.cz, 
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 2:39=E2=80=AFPM Kyle Meyer <kyle.meyer@hpe.com> wro=
te:
>
> On Wed, Sep 17, 2025 at 12:54:09PM -0700, Luck, Tony wrote:
> > On Wed, Sep 17, 2025 at 12:32:47PM -0700, Jiaqi Yan wrote:
> > > +1. Given /proc/sys/vm/enable_soft_offline is extensible, I would
> > > prefer a compact userspace API.
> > >
> > > > would create a new file, and the file has weird semantics such that=
 it
> > > > has no meaning when enable_soft_offline=3D0.
> >
> > So the expand the bitmask idea from earlier in this thread?
> >
> > Bit0  0 =3D soft offline disabled. 1 =3D Enabled (but see other bits)
> > Bit1  0 =3D allow offline of 4K pages, 1 =3D suppress 4K offline
> > Bit2  0 =3D allow offline of hugetlb, 1 =3D suppress hugetlb offline
> > Bit3  0 =3D allow breakup of transparent huge pages to just offline 4K,=
 1 =3D suppress transparent breakup
> > Bit4+ Reserved for suppressing other page types we invent in the future
> >
> > Values 0 and 1 keep their original meaning.
> >
> > Value 5 means: offline 4K, keep hugetlb, breakup transparent huge pages=
.
>
> Do you happen to have any use cases or reasoning for why someone might wa=
nt
> to disable soft offline for 4K pages or transparent huge pages? I'd like =
to
> understand the motivation for adding the extra bits.

Not sure if making sense, but something I can think of are: one may
really not want performance impact as THP will be split, THP and 4K
pages will be migrated, and even wildly willing to defragment with 4K
pages with corrected errors?

>
> Thanks,
> Kyle Meyer

