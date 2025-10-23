Return-Path: <linux-kernel+bounces-866236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237E6BFF430
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FD63A65B0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCBF265621;
	Thu, 23 Oct 2025 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2RoKxBn"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB3EDDC3
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761197994; cv=none; b=eX+5OlWTRo33EZQVXewrZRtZ5cib5gZbKPuAcuQPjunkf6wwSJcxmlxyjTmI2OA9tt4aMHCk3nhYN0YQxbVzojRaz1YTuBHIkg5eenfrM3zqCp/bDnotW4/FKvSaPrhFI4e9doZ/AHfF9h2p6Hm04nHGLipqpQ0yiYBMBoLh/eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761197994; c=relaxed/simple;
	bh=FsKIh8Sr2YempVn4RfoujlQjHMyiuNGVB5flJcwQHSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXEobhNP7R3k99IDZF4MY7GyqX6/qo67HePrb353i/iRx1wqDuXhTtSSp4JpfBpBw1SLLatbn/sv0P/y1all2N/wM/j1QwBA5VN4am8yYVDjhC6aERltYk+tggmsAbMsxDOjhBrLxbk1h2+a5xgOhpR2T5wA8JLCQpULVt6RRnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2RoKxBn; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-88f86727622so49085885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761197991; x=1761802791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsKIh8Sr2YempVn4RfoujlQjHMyiuNGVB5flJcwQHSo=;
        b=k2RoKxBn+OX2ZZzGHGW6meZ/o/uTw1VDjCY4LJzsFjk92PaTYIcXVOjtQrqS1/dKjL
         zu+HoFu/QEWWVsRnq17yAQGR/6uvZk3MGtCRiBO70IN/zAsNKws8dpqqpqq+vaDj9VlM
         4o9yPR8z2TxBRyHfq7mkqwFBDWQsWicZOLUjx9/03OjZteLtzn7tC7wogsOJ9zhn7TgB
         Fes/5rzf0GCL28KHv2W421d8wHMMrNs2xFTNuQX3roRM8YTg8GeBHDKWdEuzKm8TK8WA
         8fe8VuL31viOAQvQt2NIlqmFn8BvQvGB+UPysu9GGr8gI0PWNPqW0j/KNzAkgMWLxHjl
         C3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761197991; x=1761802791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsKIh8Sr2YempVn4RfoujlQjHMyiuNGVB5flJcwQHSo=;
        b=djXSVzJZRDGF/InFOB1Dgzt3N9I9qRN0A9ecnhQnetoyP3qDwp+IzeEOiPGTpYzdEW
         qHFOzXseVWrSueFOWbcMawJSEEbjdan9AwqH51WI59HqlfV2qLeYzIDYl/fDxk0FgwG7
         UMYEr0RuOigK9WzyUfLydfIaXSGbEecCR6W036rvyzmKDVqgVcBYnEV68z934oMsKX34
         mO+5BYDlkh0nW8W1Km36Z9G/QpfrsCffwuR7GPuIfuOAK6y4lOMSF1GJe1nNCv6garAh
         yrmnd0B/o+sevALQzxOKWoJILqIfHz0ijGKFBcweUsxvMAQ7o7FEZ7wH8+l0vpo27DkK
         HIkA==
X-Forwarded-Encrypted: i=1; AJvYcCWj8Z0miFIaa0OcwrMpxoYX8pQZF+IGqxb8HScDjNETZxhmmHf5SBC3BqfITaoK+qnTUCHPTKXpaPXR9RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq1AojPZq/6sIfYBeI3K+oE9agmRVcc3pyenlMBWSQQUYBVzEF
	D6qgJTlBH1PMpPOzvaoVGSGZb2HZIUoUuFl+YYqQEB6OQLhb/Dvflx0vbUxSOMNPbLKxZg0NRtp
	V1VpwLxexZ8BPD+O4Hk29sK51GRD+dWw=
X-Gm-Gg: ASbGncvHKN8kE7fiVwarzNn/YfNJFeMqzpo7yCSCBo+e8jcMhogIcBz/jdsUlJpyMuF
	hKPSXbC1d0GoT3BEZezVNM1BWukki2eZxYEDBBzZ9K6s85U6nQN8iLMXILasZ///2FqAYSDbEFR
	in/4Cuh4hZ6PoOZDtLak0n0X+6ElVKcVS2ZBeBDI/XKUVpJWCj11gx/oN6Yxvlc6/1Qsj/WEUES
	th9ajnH5PATyW8Jd03G+3yU5mrFR9XrIjL4uxX1g81II31oU2wjCDd7L1y6LOjzmpqPfi3X1B/L
	0HIexj8vjSJuz/Rn
X-Google-Smtp-Source: AGHT+IFTcAOtXGOZhl7XZO47Jw5as7yHXv1okWMKdwokC78k4R5PlQjBIcNv/sxneXQntHqjozJlsExm4jwJsJf+GKs=
X-Received: by 2002:a05:620a:2990:b0:82e:ce61:f840 with SMTP id
 af79cd13be357-89070fc102bmr2871005985a.84.1761197991234; Wed, 22 Oct 2025
 22:39:51 -0700 (PDT)
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
 <87ms5j4444.fsf@DESKTOP-5N7EMDA> <CAGsJ_4xhJSLnXOZy4kPmnif5Paq+OPN_Ww+rPk2WO4-ADSC0Yw@mail.gmail.com>
 <87qzuu1kg2.fsf@DESKTOP-5N7EMDA>
In-Reply-To: <87qzuu1kg2.fsf@DESKTOP-5N7EMDA>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 23 Oct 2025 18:39:39 +1300
X-Gm-Features: AS18NWDKv8WT7U0pZbWb-8Jorrgh3QZSKh6u4PKNw3UoBHBCpCMmg3gw3nK3q9o
Message-ID: <CAGsJ_4z7SASir4gWThfePdnvw82TB8E6rXnzJ=CieaFnJpJt7g@mail.gmail.com>
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

> >
> > A:
> > write pte
> > don't broadcast pte
> > tlbi
> > don't broadcast tlbi
> >
> > with
> >
> > B:
> > write pte
> > broadcast pte
>
> I suspect that pte will be broadcast, DVM broadcast isn't used for
> the memory coherency IIUC.

I guess you=E2=80=99re right. By =E2=80=9Cbroadcast,=E2=80=9D I actually me=
ant the PTE becoming visible
to other CPUs. With a dsb(ish) before tlbi, other cores=E2=80=99 TLBs can l=
oad the new
PTE after their TLB is shoot down. But as you said, if the hardware doesn=
=E2=80=99t
propagate the updated PTE faster, it doesn=E2=80=99t seem to help reduce pa=
ge faults.

As a side note, I=E2=80=99m curious about the data between dsb(nsh) and dsb=
(ish) on
your platform. Perhaps because the number of CPU cores is small, I didn=E2=
=80=99t see
any noticeable difference between them on phones.

>
> > tlbi
> > don't broadcast tlbi
> >
> > I guess the gain comes from "don't broadcat tlbi" ?
> > With B, we should be able to share many existing code.
>
> Ryan has some plan to reduce the code duplication with the current
> solution.

Ok.

Thanks
Barry

