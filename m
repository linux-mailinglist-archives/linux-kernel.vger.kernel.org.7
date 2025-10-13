Return-Path: <linux-kernel+bounces-851476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D5BBD697E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C01408244
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D692FAC07;
	Mon, 13 Oct 2025 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqFA6th1"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E442E9EA8
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760393688; cv=none; b=fXRFXMQqWkDJGcTJONgPxRQJJ31HLScW1RL0rgXxPqFkNUj4sKrKTkUyZ68BnAleBkvVNJvGYWJid9rLe/mi7NMJme4lXEOvnqzjbafNXsuuYnell8OD5nEVlYDzEC/fust38BuU3ksPBNmU6e9pmjVQNVhS/hLaWSVFERY9Iw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760393688; c=relaxed/simple;
	bh=Md1A2uKl6kgU9IrfwYn2P5juXiKTWAuirZuzuxL1e5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mzr3Ga9b0ag18CJf5NJMD06nTqWJ9H0K+e6L78OTB3HeCzWgMTnM4jT7TjvrcKf+86CeCsF+P3bPGRK2Jof9OPWJj2uEOUWhoDzPA8tL6kjL4PkjmCi16BnKcGaIsPpGqIBb+z7dZ/3pSJ2P2k/B6y5C3v65jbi1+z+gVK/ytLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RqFA6th1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e3f213b59so138995e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760393684; x=1760998484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md1A2uKl6kgU9IrfwYn2P5juXiKTWAuirZuzuxL1e5U=;
        b=RqFA6th1ObDj2OqqCttFyDpsYoAkENIh9eWUSftSHiBOFIdf6V0d8+64kMH1ADCOQU
         +TPgAB6DDRNZ7+u/FmDzdnnpxcJhkh0a/CsbBTKuxb4+KCjnmK8oMvAmlry9IZWoJGX0
         Txp/0zK5oMwyQhYJcyY9KTDrnZY37cK1qg9FeEzyVzeaRP06DP+nlUTqKupiB8LukBuU
         DzgjYAfUdnoWlX+shu+DPkOOQeanYtVAs9vm9iDuzGNqP7uaCaLvyAt3rgq/chNDMVVY
         nWCQemI1W+ebAAhH5PY9IXPDMHmbLIp8DRutEkOvg0YTz5qdaysaGdX0TvAn2nw1EMHD
         TwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760393684; x=1760998484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Md1A2uKl6kgU9IrfwYn2P5juXiKTWAuirZuzuxL1e5U=;
        b=BRoA04BPbpSUGvWioK8s9QWMz7z3MeYhFU7yk1ldD2q35iBQN/jmBIfqV2ifEl4Fjc
         apCqolGdBj22qkuKONupiYbwC7NbLSr/a49gzLN2rwkArOhGtJL0WfKouBqmEFmLtYJc
         8zqRHfM+ov0G1RXYxoO1mjtmvumzyfLEe2UIaLTppYu1R1WP4uEj3Ncws9gcgPXv5NsB
         /nTvsm1bc/DF4WKjMYCku8N0c3iOqqVF/Z5TVFY6FFqpmwisXuOQUdQLDPzboOrjTyeV
         WB6jNtfF0uljk6znPz5/zPgLDFLpVfkutZxeE7axyvNQjeQrc3/EH+MoBCAd8dsY810w
         HV2g==
X-Forwarded-Encrypted: i=1; AJvYcCXxuMKTNNOA5wy3wx7elS34nuxOsV2X2+cv09sp8Xe492dEvJciDkD6yGM4VpeRtZ/m1MTR28Q43IG7kaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyADva95CAdCUxLyPCk8W36MQn2Fj5oe5exvjYCiRLs70aGig1q
	1EDWS6R/dLKqODbxvfofRL5Kweqo1SSew+rv+ebPUN9vIvbHJ50738Wp6ah/4QB86ZIMAnS+JjV
	Jzu3Lx8DkDgIuZIIvsBxR7YX/ToDX9t+3/26qFgYR
X-Gm-Gg: ASbGnctSWjdHEfmpahSUg1WDRlTm1h3YtPB7RvNJRiLgob3mWaH2M1ClUllQfVlfrYY
	2EGaUqZf5ZEUZ/MSsom0+n6E9+GZq1dW2wqGhQRDZgqWkJCrjqJqzcmvxoashbnZ+7w+x0hMfiN
	WHh8gxiHJ30YtrZ1ruCiKWZ1/3AbadtBKJk6ZGmYGaF5n9TQ5hfyD0uUozlbk1dPIkftWa8BktV
	Gyux1NAPMu+WHsiGWl0ZmBEKFX2g7+AA8qShwCTFfkrOzDJqTOg+iAiYGTZFmriGSE5ziTYlw==
X-Google-Smtp-Source: AGHT+IFcJCh/82hxCUADD7PjVwqcXj1BKwAfYVrS6U33JU7OMnCpfeAPkBJ4TpIW4QhiLTbUSVarRug2eFkrw+QDiaM=
X-Received: by 2002:a05:600c:6008:b0:45a:2861:3625 with SMTP id
 5b1f17b1804b1-46fa9b29309mr9719185e9.4.1760393684151; Mon, 13 Oct 2025
 15:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250118231549.1652825-1-jiaqiyan@google.com> <20250919155832.1084091-1-william.roche@oracle.com>
In-Reply-To: <20250919155832.1084091-1-william.roche@oracle.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 13 Oct 2025 15:14:32 -0700
X-Gm-Features: AS18NWAiJumx-M_L3wK9sogLN4v8v1yPjy0HWjrQ6WoH4VxJm6dQG73LRuSoLVE
Message-ID: <CACw3F521fi5HWhCKi_KrkNLXkw668HO4h8+DjkP2+vBuK-=org@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
To: =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>, 
	Ackerley Tng <ackerleytng@google.com>
Cc: jgg@nvidia.com, akpm@linux-foundation.org, ankita@nvidia.com, 
	dave.hansen@linux.intel.com, david@redhat.com, duenwen@google.com, 
	jane.chu@oracle.com, jthoughton@google.com, linmiaohe@huawei.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, nao.horiguchi@gmail.com, 
	osalvador@suse.de, peterx@redhat.com, rientjes@google.com, 
	sidhartha.kumar@oracle.com, tony.luck@intel.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org, harry.yoo@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 8:58=E2=80=AFAM =E2=80=9CWilliam Roche <william.roc=
he@oracle.com> wrote:
>
> From: William Roche <william.roche@oracle.com>
>
> Hello,
>
> The possibility to keep a VM using large hugetlbfs pages running after a =
memory
> error is very important, and the possibility described here could be a go=
od
> candidate to address this issue.

Thanks for expressing interest, William, and sorry for getting back to
you so late.

>
> So I would like to provide my feedback after testing this code with the
> introduction of persistent errors in the address space: My tests used a V=
M
> running a kernel able to provide MFD_MF_KEEP_UE_MAPPED memfd segments to =
the
> test program provided with this project. But instead of injecting the err=
ors
> with madvise calls from this program, I get the guest physical address of=
 a
> location and inject the error from the hypervisor into the VM, so that an=
y
> subsequent access to the location is prevented directly from the hypervis=
or
> level.

This is exactly what VMM should do: when it owns or manages the VM
memory with MFD_MF_KEEP_UE_MAPPED, it is then VMM's responsibility to
isolate guest/VCPUs from poisoned memory pages, e.g. by intercepting
such memory accesses.

>
> Using this framework, I realized that the code provided here has a proble=
m:
> When the error impacts a large folio, the release of this folio doesn't i=
solate
> the sub-page(s) actually impacted by the poison. __rmqueue_pcplist() can =
return
> a known poisoned page to get_page_from_freelist().

Just curious, how exactly you can repro this leaking of a known poison
page? It may help me debug my patch.

>
> This revealed some mm limitations, as I would have expected that the
> check_new_pages() mechanism used by the __rmqueue functions would filter =
these
> pages out, but I noticed that this has been disabled by default in 2023 w=
ith:
> [PATCH] mm, page_alloc: reduce page alloc/free sanity checks
> https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz

Thanks for the reference. I did turned on CONFIG_DEBUG_VM=3Dy during dev
and testing but didn't notice any WARNING on "bad page"; It is very
likely I was just lucky.

>
>
> This problem seems to be avoided if we call take_page_off_buddy(page) in =
the
> filemap_offline_hwpoison_folio_hugetlb() function without testing if
> PageBuddy(page) is true first.

Oh, I think you are right, filemap_offline_hwpoison_folio_hugetlb
shouldn't call take_page_off_buddy(page) depend on PageBuddy(page) or
not. take_page_off_buddy will check PageBuddy or not, on the page_head
of different page orders. So maybe somehow a known poisoned page is
not taken off from buddy allocator due to this?

Let me try to fix it in v2, by the end of the week. If you could test
with your way of repro as well, that will be very helpful!

> But according to me it leaves a (small) race condition where a new page
> allocation could get a poisoned sub-page between the dissolve phase and t=
he
> attempt to remove it from the buddy allocator.
>
> I do have the impression that a correct behavior (isolating an impacted
> sub-page and remapping the valid memory content) using large pages is
> currently only achieved with Transparent Huge Pages.
> If performance requires using Hugetlb pages, than maybe we could accept t=
o
> loose a huge page after a memory impacted MFD_MF_KEEP_UE_MAPPED memfd seg=
ment
> is released ? If it can easily avoid some other corruption.
>
> I'm very interested in finding an appropriate way to deal with memory err=
ors on
> hugetlbfs pages, and willing to help to build a valid solution. This proj=
ect
> showed a real possibility to do so, even in cases where pinned memory is =
used -
> with VFIO for example.
>
> I would really be interested in knowing your feedback about this project,=
 and
> if another solution is considered more adapted to deal with errors on hug=
etlbfs
> pages, please let us know.

There is also another possible path if VMM can change to back VM
memory with *1G guest_memfd*, which wraps 1G hugetlbfs. In Ackerley's
work [1], guest_memfd can split the 1G page for conversions. If we
re-use the splitting for memory failure recovery, we can probably
achieve something generally similar to THP's memory failure recovery:
split 1G to 2M and 4k chunks, then unmap only 4k of poisoned page. We
still lose the 1G TLB size so VM may be subject to some performance
sacrifice.

[1] https://lore.kernel.org/linux-mm/2ae41e0d80339da2b57011622ac2288fed65cd=
01.1747264138.git.ackerleytng@google.com

>
> Thanks in advance for your answers.
> William.

