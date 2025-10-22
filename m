Return-Path: <linux-kernel+bounces-864703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C87E7BFB613
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692B619C578F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848EA311958;
	Wed, 22 Oct 2025 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8E7pdZ1"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1088D3164D0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128538; cv=none; b=sy4jZiuZeR5E/8hxblMKZUfUnPUmi44ce6l4XPzcAa6YXPLbR0tlcnBdmHK7hKWeZRsZWzbfL93SU/Urm2GlZnVjS8weyEy+PPoXEreYYnpfvITTwK5clBdFionIDGLOoUR8zS2/v7iAjmWww7Ly3vzckH1n/gjJSAGbHt542SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128538; c=relaxed/simple;
	bh=JxX8h2yrq3MpbPFrw+JMQfyErcTY4Nr+Dg57grPhra8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RY8J2I5ppoNe067XbdfS9A2FZCdJ6l6n4VdS2gSX6BMtOMs/xa79JD9wEdEOgKRKOM59pwY+2ARwuC82KQoJQC7TxPtJfr8XQnp6O7cGUmMqI6AERJg0oJ/9GKgYTWXHB7sBp9JMCMX/jNvYNs6ukv8Ge/gw8chQfv46DfMUmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8E7pdZ1; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-890521c116fso775842785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761128534; x=1761733334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tg5CSyFuy1gjgzwuVzeNqzr1hqLjP8/oZVMupaN2ME4=;
        b=M8E7pdZ1qnxrQ4QbbFlfn/gFH247ze9bFwq6DcWK1Js20H0shc5px6N+wulfKq5QUT
         Fc37yQSX5uUAE8NdXQyQj4c7tFQadhPw+FqWt+/EBrRecArwPMYeipZawYw76hrrzYMP
         6GLoHof5brboJqFh8J8I9pMrciD3KaUatnN+9i3GPtb4o7Gq7Y/llgKPYiskViO4mGBS
         a1flwh8mggmhokE4kn81Gf0iPeyZOhxhTkRH/RTAFta8EzQi0LftQ2RYonHiFmqYkdbx
         8MIuJda/mLw/KfSrZz2bXPW5GQtm4jTxxBXdUpaNCojiir6jGEtBw/ElnVdzcvSVB0LZ
         SW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761128534; x=1761733334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tg5CSyFuy1gjgzwuVzeNqzr1hqLjP8/oZVMupaN2ME4=;
        b=lLG1VZ5zVqZrPD/qH/pv//9i1MAOHhYqEPP4wPmHeEs778cr7Z/1WXwaHvxjrf1rNH
         DfuzqnyBvmAa7iS4rPEHkXGpo+L05L2gEBqRrR7Pl+XgHsES9hzyLCzvfdoX90P/p1dZ
         xrn7iJml69WczRhPILpwfGtmMvkpGWt7YnW5pgFywgKxbatQp182Wlb1YbS4+kqSGun0
         od8jrG1oL5PBVR+90CM9MpDKZy6ZaLPNQOg421dB3XUiq2QUnOIEwWUHZqSs0WKQTyex
         t32TISuUQPkhpILkG0rqdq5pvVWWhZFLQm4ozQfBgHPKdQ08KThhOLLFx3LUeET6VJWg
         bJ4w==
X-Forwarded-Encrypted: i=1; AJvYcCUc/a69xhMkkIDNb90XJqSQwfs9MOXrQaK4G2+hU/odqv2ZgGQPSd6deHMLWht/FVqlUUAfuFPttcjt5OU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz01ItavCdOq0rPGNHgl+R0GZvS9QlAa+GR7TkypUbMmr5XGYZO
	1sh+PYv87vD67kpK7i3Xl7RJbXCvE/DvjxURxMQPP2VNRkw3Gp0FSjv1uYLOAH1wWkoeDtS1sid
	DXm3QEBujOmP8X7NYYir9eDxauJSo9OM=
X-Gm-Gg: ASbGnctUQS9qH+0zx9901NKOlQWaOzzRB6Lst7W5TT+5K1wHH8y2wi5pdNYvMoR+wlS
	UzpiuET0XdMO55b8o4ark90AjTvesGr2HpCSiijFwUpPRoeRVTr4Tw/qU5gDgrHF/UYCn1KOb2U
	BehpZd+Paa+5CqRw/QPMty+ybTbJgPvwED21MHVBIzNPIJYmzfR7KR4FwLk5xYSeTNbkUyommgz
	zpcwRuxqYahipkBhLR9zeQXBH5I3HBzbgx+uQum1g8dTuAgLVz3BqiFE3yKq7+GoXKyGDXTX+oL
	0gTPt1irko09JZuU
X-Google-Smtp-Source: AGHT+IHgh/2ue5XLoiEIIP3qVcbBgpSwlGUDyMrIbpcYgXG8Fb2NWv4YHZCQZ79f1++pVClCNC7jVN49zC4Kgu6WL3s=
X-Received: by 2002:a05:620a:8083:b0:890:cfbb:f9a3 with SMTP id
 af79cd13be357-890cfbc03a5mr1867383185a.87.1761128534358; Wed, 22 Oct 2025
 03:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
 <20251013092038.6963-3-ying.huang@linux.alibaba.com> <CAGsJ_4xaA8QRjP9H=n1hQfEfGop7vOd5Y=J+KQzuOyfa8GK-kQ@mail.gmail.com>
 <87a51jfl44.fsf@DESKTOP-5N7EMDA> <CAGsJ_4zPH0fwBOLQwh1y6jG3tCXHLGRCTyVVSCWb+NfLCEMV0Q@mail.gmail.com>
 <871pmv9unr.fsf@DESKTOP-5N7EMDA> <CAGsJ_4zW6ogVdi=t9JCuvGD9N21mA_ORXRCakw4Av68d9n+DDw@mail.gmail.com>
 <875xc78es0.fsf@DESKTOP-5N7EMDA> <CAGsJ_4zKGS-Xd-58ufXGoyRfaZWd8wTgv0b6ibHJ2aS14mQqtw@mail.gmail.com>
 <87a51j6zg7.fsf@DESKTOP-5N7EMDA> <CAGsJ_4y32i3aNYPum=8J3_Kt6vOSisr_jg6btB-YG1uQBqHG7Q@mail.gmail.com>
In-Reply-To: <CAGsJ_4y32i3aNYPum=8J3_Kt6vOSisr_jg6btB-YG1uQBqHG7Q@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 22 Oct 2025 23:22:02 +1300
X-Gm-Features: AS18NWBircPFuACNmjNln0NVeJ5pMiUTEtaKbz7xy8k3SeBdgLEYQqjplgyUxCM
Message-ID: <CAGsJ_4yeygfzna6SRG3poD9cXhFNz21-he9psiKvMTMG8WBgmg@mail.gmail.com>
Subject: Re: [PATCH -v2 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Yang Shi <yang@os.amperecomputing.com>, "Christoph Lameter (Ampere)" <cl@gentwo.org>, Dev Jain <dev.jain@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Yin Fengwei <fengwei_yin@linux.alibaba.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 10:55=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Wed, Oct 22, 2025 at 10:46=E2=80=AFPM Huang, Ying
> <ying.huang@linux.alibaba.com> wrote:
>
> > >
> > > I agree. Yet the ish barrier can still avoid the page faults during C=
PU0's PTL.
> >
> > IIUC, you think that dsb(ish) compared with dsb(nsh) can accelerate
> > memory writing (visible to other CPUs).  TBH, I suspect that this is th=
e
> > case.
>
> Why? In any case, nsh is not a smp domain.
>
> I believe a dmb(ishst) is sufficient to ensure that the new PTE writes
> are visible
> to other CPUs. I=E2=80=99m not quite sure why the current flush code uses=
 dsb(ish);
> it seems like overkill.

On second thought, the PTE/page table walker might not be a typical
SMP sync case,
so a dmb may not be sufficient=E2=80=94we are not dealing with standard loa=
d/store
instruction sequences across multiple threads. In any case, my point is tha=
t
dsb(ish) might be slightly slower than your dsb(nsh), but it makes the PTE
visible to other CPUs earlier and helps avoid some page faults after we=E2=
=80=99ve
written the PTE. However, if your current nsh version actually provides bet=
ter
performance=E2=80=94even when multiple threads may access the data simultan=
eously=E2=80=94
It should be completely fine.

Now you are

write pte
don't broadcast pte
tlbi
don't broadcast tlbi

we might be:

write pte
broadcast pte
tlbi
don't broadcast tlbi

Thanks
Barry

