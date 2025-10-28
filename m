Return-Path: <linux-kernel+bounces-873022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29419C12D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF1040240B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5524329BD9E;
	Tue, 28 Oct 2025 04:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CMCKcqFZ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877BA29B216
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761625066; cv=none; b=nUakB7tSSE6eg7cXH1muRCN3UK2qWhBH/xFCzKxhqQc6bIfiRqA4M0c0GzJQFyM5pednNLPNH+TA2NaN0UJE3RHumc51l+Avk+Thku2pvyh83T7tan3wWX6adASKQHTGUVpZb5pqWovpmP5WBGVOEa+VEy3wjw3XFOS6qK60qOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761625066; c=relaxed/simple;
	bh=5Vq7u3nGd6Do3JsO9eJRTz/nrsOJguWIs6I8jqHn41o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNWUc5jKnHd/T+B8CI9gW4pQEh29lSWkKZDg0tL+Bv/zlz2LN/WK4cM6Ia2lLInigAM7wdugEWi1Kxxzd0ueLncZDqslv32y42xIjd/t3e7pWMoIwAQEv9lppwxmFIPc+141K3pIANVbt+P3dSD4cp13XuVXfB3AkDUHgmJpHr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CMCKcqFZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47105bbb8d9so27065e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761625063; x=1762229863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EafH425e5ZdVyi0FV+yegWkfn9dVJGmMSMrvuISBCM4=;
        b=CMCKcqFZhIhN9GrHzMt22pfSBpt3n53umu4a2LYUg/tvVWruM7FfnDckvCePB79NcV
         alCzGSqG+eZwdByWYPBw3sKUB6WN+zryHc4v7XTsogFm2MY3u5qmIBMknkMnEFwdZ8GR
         anDfpq3mRoktXpOBn8DJJNBmYHDqkzbruxcXVLyoTK3EvOQQ+6fY0S0wXALQ82uRGTsX
         Wvwu2btXwMi10P4vBUjoS1Ie8eS3XO2qc5IyFl8O+ikmEJ0Focl+6ARzgO5JaNTS6sOj
         x854GtrsNfY2euuqxztCC989l1ozRusb0k4mM4jN6r3TiVuZp52uyvOfAHZt0AlcL94N
         Yx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761625063; x=1762229863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EafH425e5ZdVyi0FV+yegWkfn9dVJGmMSMrvuISBCM4=;
        b=iS9JNoblN67Lzo5G0KXf/TdM4iUv2JrBTz742DKKM2VzwutjZ4u6BecgNcpHuplrR+
         aOe5p4/4nRteizgFRhQd/0MLtySQa5uzRFSQ8+50QcSQATU/yJz2AV93gjJFDVRKKeMw
         TimM/lvHhI2qXtm3SsWBuPsgK1jTiaxhUfCZK3s/KNgBZN0vlQS4TCj+q/9k5Rji7Kti
         ruHa8hgwazY6dBtOPeu9SGTiqotfYgIK0HFwlxAG6ELKuXj8f+C5v67vowW6J5RWEQxC
         aIqXUmfAFkM7yIBrwNvu2ytFsfqf9uD5VnVFt1c3ZkKbkiP17DCwDpx4/5LBXk0VO2/G
         A2CA==
X-Forwarded-Encrypted: i=1; AJvYcCVjCmuASsKFep0N/Ch3WQc5rPY5T3gpMy4pdH06by4/XEAVyWWmaqfcC8Q+YLzQYJpssYPgw12XJfWt6N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLqo0XpyrFgkARRHnWDMw4k8I7ErnWAuUQXEjignc5jplQcviq
	8fcFLOgEzpEbgAnbNNLSJLV2ZDgdlONzMdJELT5b8nuDhbXIvmFzbyx3kPkotvjwox8XV7K0Rw3
	ICnt+b4mJUoBlP/tenjd9qiWUPg0f944Ig7367ZfX
X-Gm-Gg: ASbGncunOyr4BXpVVbTbnBQW9bzCkI/MGs98K9Uj57+Xxcdll61h+29xAAMbdgx/c+l
	hdD8OxI3OCGBX8YdA4RxRPsL4188snVUCfLM9S/JKGMw+m+QVYzNFrm0tjovn5igbadpdoLogg/
	OBp/LaYHYGQmoJ+On0q8BEvAmlL50N/4/C68/IOqf3/9OgEQfGBq6SQXFdebz8UHf4FIlK26yJX
	TtuVDveAoD3Wcvcc50siFIAOdPYNRMjV+mrHbtSk3ysbxschr+4DSa/8DxaBye3+ajbeSwBBYrY
	rdVt6r7PBRyVC+dm3w==
X-Google-Smtp-Source: AGHT+IEhtd6FMoBD9oW9VTHPjTNuAKD4LI9Bm+L8vr/ZIvRemEu0gME+w1twwea2P3HAp+5Fi55N6fK3//NhVxDsmnM=
X-Received: by 2002:a05:600c:1791:b0:45b:74f7:9d30 with SMTP id
 5b1f17b1804b1-477191e0eabmr589665e9.1.1761625062640; Mon, 27 Oct 2025
 21:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250118231549.1652825-1-jiaqiyan@google.com> <20250919155832.1084091-1-william.roche@oracle.com>
 <CACw3F521fi5HWhCKi_KrkNLXkw668HO4h8+DjkP2+vBuK-=org@mail.gmail.com> <aPjXdP63T1yYtvkq@hyeyoo>
In-Reply-To: <aPjXdP63T1yYtvkq@hyeyoo>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 27 Oct 2025 21:17:31 -0700
X-Gm-Features: AWmQ_bm9R7TnoGST5GcqG6bwJmlJM5TYefCTLaciqwqQYwwTV1Gje_wcNqRiI_k
Message-ID: <CACw3F50As2jPzy1rRjzpm3uKOALjX_9WmKxMPGnQcok96OfQkA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
To: Harry Yoo <harry.yoo@oracle.com>, =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>
Cc: Ackerley Tng <ackerleytng@google.com>, jgg@nvidia.com, akpm@linux-foundation.org, 
	ankita@nvidia.com, dave.hansen@linux.intel.com, david@redhat.com, 
	duenwen@google.com, jane.chu@oracle.com, jthoughton@google.com, 
	linmiaohe@huawei.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev, 
	nao.horiguchi@gmail.com, osalvador@suse.de, peterx@redhat.com, 
	rientjes@google.com, sidhartha.kumar@oracle.com, tony.luck@intel.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 6:09=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Mon, Oct 13, 2025 at 03:14:32PM -0700, Jiaqi Yan wrote:
> > On Fri, Sep 19, 2025 at 8:58=E2=80=AFAM =E2=80=9CWilliam Roche <william=
.roche@oracle.com> wrote:
> > >
> > > From: William Roche <william.roche@oracle.com>
> > >
> > > Hello,
> > >
> > > The possibility to keep a VM using large hugetlbfs pages running afte=
r a memory
> > > error is very important, and the possibility described here could be =
a good
> > > candidate to address this issue.
> >
> > Thanks for expressing interest, William, and sorry for getting back to
> > you so late.
> >
> > >
> > > So I would like to provide my feedback after testing this code with t=
he
> > > introduction of persistent errors in the address space: My tests used=
 a VM
> > > running a kernel able to provide MFD_MF_KEEP_UE_MAPPED memfd segments=
 to the
> > > test program provided with this project. But instead of injecting the=
 errors
> > > with madvise calls from this program, I get the guest physical addres=
s of a
> > > location and inject the error from the hypervisor into the VM, so tha=
t any
> > > subsequent access to the location is prevented directly from the hype=
rvisor
> > > level.
> >
> > This is exactly what VMM should do: when it owns or manages the VM
> > memory with MFD_MF_KEEP_UE_MAPPED, it is then VMM's responsibility to
> > isolate guest/VCPUs from poisoned memory pages, e.g. by intercepting
> > such memory accesses.
> >
> > >
> > > Using this framework, I realized that the code provided here has a pr=
oblem:
> > > When the error impacts a large folio, the release of this folio doesn=
't isolate
> > > the sub-page(s) actually impacted by the poison. __rmqueue_pcplist() =
can return
> > > a known poisoned page to get_page_from_freelist().
> >
> > Just curious, how exactly you can repro this leaking of a known poison
> > page? It may help me debug my patch.
> >
> > >
> > > This revealed some mm limitations, as I would have expected that the
> > > check_new_pages() mechanism used by the __rmqueue functions would fil=
ter these
> > > pages out, but I noticed that this has been disabled by default in 20=
23 with:
> > > [PATCH] mm, page_alloc: reduce page alloc/free sanity checks
> > > https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
> >
> > Thanks for the reference. I did turned on CONFIG_DEBUG_VM=3Dy during de=
v
> > and testing but didn't notice any WARNING on "bad page"; It is very
> > likely I was just lucky.
> >
> > >
> > >
> > > This problem seems to be avoided if we call take_page_off_buddy(page)=
 in the
> > > filemap_offline_hwpoison_folio_hugetlb() function without testing if
> > > PageBuddy(page) is true first.
> >
> > Oh, I think you are right, filemap_offline_hwpoison_folio_hugetlb
> > shouldn't call take_page_off_buddy(page) depend on PageBuddy(page) or
> > not. take_page_off_buddy will check PageBuddy or not, on the page_head
> > of different page orders. So maybe somehow a known poisoned page is
> > not taken off from buddy allocator due to this?
>
> Maybe it's the case where the poisoned page is merged to a larger page,
> and the PGTY_buddy flag is set on its buddy of the poisoned page, so
> PageBuddy() returns false?:
>
>   [ free page A ][ free page B (poisoned) ]
>
> When these two are merged, then we set PGTY_buddy on page A but not on B.

Thanks Harry!

It is indeed this case. I validate by adding some debug prints in
take_page_off_buddy:

[ 193.029423] Memory failure: 0x2800200: [yjq] PageBuddy=3D0 after drain_al=
l_pages
[ 193.029426] 0x2800200: [yjq] order=3D0, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029428] 0x2800200: [yjq] order=3D1, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029429] 0x2800200: [yjq] order=3D2, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029430] 0x2800200: [yjq] order=3D3, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029431] 0x2800200: [yjq] order=3D4, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029432] 0x2800200: [yjq] order=3D5, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029434] 0x2800200: [yjq] order=3D6, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029435] 0x2800200: [yjq] order=3D7, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029436] 0x2800200: [yjq] order=3D8, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029437] 0x2800200: [yjq] order=3D9, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029438] 0x2800200: [yjq] order=3D10, page_order=3D10, PageBuddy(page_=
head)=3D1

In this case, page for 0x2800200 is hwpoisoned, and its buddy page is
0x2800000 with order 10.

>
> But even after fixing that we need to fix the race condition.

What exactly is the race condition you are referring to?

>
> > Let me try to fix it in v2, by the end of the week. If you could test
> > with your way of repro as well, that will be very helpful!
> >
> > > But according to me it leaves a (small) race condition where a new pa=
ge
> > > allocation could get a poisoned sub-page between the dissolve phase a=
nd the
> > > attempt to remove it from the buddy allocator.
> > >
> > > I do have the impression that a correct behavior (isolating an impact=
ed
> > > sub-page and remapping the valid memory content) using large pages is
> > > currently only achieved with Transparent Huge Pages.
> > > If performance requires using Hugetlb pages, than maybe we could acce=
pt to
> > > loose a huge page after a memory impacted MFD_MF_KEEP_UE_MAPPED memfd=
 segment
> > > is released ? If it can easily avoid some other corruption.
> > >
> > > I'm very interested in finding an appropriate way to deal with memory=
 errors on
> > > hugetlbfs pages, and willing to help to build a valid solution. This =
project
> > > showed a real possibility to do so, even in cases where pinned memory=
 is used -
> > > with VFIO for example.
> > >
> > > I would really be interested in knowing your feedback about this proj=
ect, and
> > > if another solution is considered more adapted to deal with errors on=
 hugetlbfs
> > > pages, please let us know.
> >
> > There is also another possible path if VMM can change to back VM
> > memory with *1G guest_memfd*, which wraps 1G hugetlbfs. In Ackerley's
> > work [1], guest_memfd can split the 1G page for conversions. If we
> > re-use the splitting for memory failure recovery, we can probably
> > achieve something generally similar to THP's memory failure recovery:
> > split 1G to 2M and 4k chunks, then unmap only 4k of poisoned page. We
> > still lose the 1G TLB size so VM may be subject to some performance
> > sacrifice.
> > [1] https://lore.kernel.org/linux-mm/2ae41e0d80339da2b57011622ac2288fed=
65cd01.1747264138.git.ackerleytng@google.com
>
> I want to take a closer look at the actual patches but either way sounds
> good to me.
>
> By the way, please Cc me in future revisions :)

For sure!

>
> Thanks!
>
> --
> Cheers,
> Harry / Hyeonggon

