Return-Path: <linux-kernel+bounces-878799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AD0C2180A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B8F3B33D9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50B03678BC;
	Thu, 30 Oct 2025 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZcDMu0A"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E0B368F36
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845345; cv=none; b=YLse1iYMxDIs4J0o+sTYD4oGCyi5c3w3mA/gAi8Ownd7yIGeaYXSr9aDkZdGLZpZrgOJud51U88humB8PWkleYAgsdBGcp/xynwimA2K1CeiUPRK26W5UIC1LpsKrkCyIjm6xKHbMSvDN001MZ0HycZJQy3wakwmxeF+4gYIgR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845345; c=relaxed/simple;
	bh=9B4FKjvIHeWwZ+HKKf/2rxO9qlq4Uj//B3HDuNLqvBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6Dq9mcsDqvfBMjrHY2/xchEbf/GWR1/lCzwIXmCvKXuKKsWEkv+arlCHXnN2er/pbnqO5pRaZ8IlmQW6f9dKx/sM9z/y5LojvOanmGOVakSrGiMeuz6vJCzOObIBH9Nk3rVwDuG4C5cOug1QpbNwG3nIvuZR+x7dboHCbxy/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZcDMu0A; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4770d4df4deso3425e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761845340; x=1762450140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duKu/8Ky/t6prpCzomheaKrWsLhN82XKAnG9GJbzgTM=;
        b=QZcDMu0AYP+Mta3yu/d5/3/9ij9BxBU2qHWPiEKjsL2fuK31d0bVJ0j4lb+eldBhE/
         hhscKx8dXjtrqJZ7x6hpaOv9HNWEaH+Iq3K/mjGbEo2sTnbyTbnnLFhEtSY9FV0XFWLB
         HQykI9HeQMxN6WSYlWTMdEcwfVVEreM2Ju3gkioshZzhua1bvyUPa98WiRirfQTE2IQ/
         K960ohiWVjA4Qp4Oyqw5sNL4yJFf0tO254QU/3emZTpl8sVA4q+ng8cJSGoVedrzPUA8
         oRCEShDhUiCN1/zcUBEWT8+cI3SzVo2nxRTzMsGUW6KzxtyChBl3oUm37ZjGlCbc1+NX
         qcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761845340; x=1762450140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duKu/8Ky/t6prpCzomheaKrWsLhN82XKAnG9GJbzgTM=;
        b=AMv5lw/z56aVuIWnq7eSgrTwQ0ov8AQ2gKQ6cshoHlvUpc9zOe/rWnvdA+glO5poyN
         QCzoFwYCqw6w5h04mPf/QgLxJPBqKsMIv2dBTIpH1wmC1AHXXM/TgoCJ136vQrcsj8oL
         aDk3c+3w67zhCyIzTeTYTmlz027Fcv24lytSgMy2mOAbuYOUwHXh2F4V7etZtz/s7Ku4
         1pjlBC5gDpMVnLyPlTlsujVFTyfqtkqfJN5InKNiygRDXApnL82guyJpmrgdjHZpea4T
         /rkg085ED3aUGO+1mJ95FPY5ft2PVlSRZh8K33ZxNGdabuqNdqYQJJbeqpsCZcl18Q6M
         Ta4w==
X-Forwarded-Encrypted: i=1; AJvYcCUvrHJVizM66upSr7RgUFGdffgjONE9QGX8dUoJ1PcTLl7JEAGOi7QgZRfkRNeArnkUgLDVn5Eo/sdOw7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKPh+87oGvJD37thmgKtPoYPsXxYnuM6x7LFZCx3AO+pVJfegN
	iEhZeRuweb/Yaz4TzTrqgVdT1x6cCtwmiSbXRpZ+x5o86kQpKOHoT57JQvb2IqdfYiq+oiNUuKL
	IvPg4QHonL9Y/tdWzjIAu7MniSy4F7zTXlGa9hPz+
X-Gm-Gg: ASbGncsK7jjCXGFaxWihPhzMFrVh0dHor3I56Vq5ki+GM2XzD3O1FT0Mt/jCF3/9r/r
	YZLuCMWGQO/yi0b3nVVXDQQkgi8dswVhNCwyjX38COONJJ0uuUUungEy+MgTkteAxC7NuqENagb
	jdSFMQEeSve+Dede8qSTwoqcpGutt5xgzUqFAHxb7bVrBviZfmQZIjyTe5k9XSdLQ2FseP1wgrK
	yxGsJlmedXqARAsxOfU6ZHzXoAIN+C0qpqbButhUKsNrEE8fA8EG5RJY6YOSZqgzXdZPSWc4nO6
	lT0HpK+e+dHkeN8=
X-Google-Smtp-Source: AGHT+IFCRKDiV45j8nfSSPazMv37IGqBBffmdRw3pH4dGClMUS1sq6qT4CcfZSHTWT3SkuCeES6cEwuqbx88QSTv3rE=
X-Received: by 2002:a05:600c:6207:b0:46f:a42d:41f0 with SMTP id
 5b1f17b1804b1-477310e383cmr86755e9.0.1761845339767; Thu, 30 Oct 2025 10:28:59
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250118231549.1652825-1-jiaqiyan@google.com> <20250919155832.1084091-1-william.roche@oracle.com>
 <CACw3F521fi5HWhCKi_KrkNLXkw668HO4h8+DjkP2+vBuK-=org@mail.gmail.com>
 <aPjXdP63T1yYtvkq@hyeyoo> <CACw3F50As2jPzy1rRjzpm3uKOALjX_9WmKxMPGnQcok96OfQkA@mail.gmail.com>
 <aQBqGupCN_v8ysMX@hyeyoo> <d3d35586-c63f-c1be-c95e-fbd7aafd43f3@huawei.com>
In-Reply-To: <d3d35586-c63f-c1be-c95e-fbd7aafd43f3@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 30 Oct 2025 10:28:48 -0700
X-Gm-Features: AWmQ_bmYKY6ggj7beaUai29I-PXUvJIYK1duVN36KusJtjmgIEZDYv_nIrP-5Lg
Message-ID: <CACw3F51qaug5aWFNcjB54dVEc8yH+_A7zrkGcQyKXKJs6uVvgA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>, 
	Ackerley Tng <ackerleytng@google.com>, jgg@nvidia.com, akpm@linux-foundation.org, 
	ankita@nvidia.com, dave.hansen@linux.intel.com, david@redhat.com, 
	duenwen@google.com, jane.chu@oracle.com, jthoughton@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, nao.horiguchi@gmail.com, 
	osalvador@suse.de, peterx@redhat.com, rientjes@google.com, 
	sidhartha.kumar@oracle.com, tony.luck@intel.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 4:51=E2=80=AFAM Miaohe Lin <linmiaohe@huawei.com> w=
rote:
>
> On 2025/10/28 15:00, Harry Yoo wrote:
> > On Mon, Oct 27, 2025 at 09:17:31PM -0700, Jiaqi Yan wrote:
> >> On Wed, Oct 22, 2025 at 6:09=E2=80=AFAM Harry Yoo <harry.yoo@oracle.co=
m> wrote:
> >>>
> >>> On Mon, Oct 13, 2025 at 03:14:32PM -0700, Jiaqi Yan wrote:
> >>>> On Fri, Sep 19, 2025 at 8:58=E2=80=AFAM =E2=80=9CWilliam Roche <will=
iam.roche@oracle.com> wrote:
> >>>>>
> >>>>> From: William Roche <william.roche@oracle.com>
> >>>>>
> >>>>> Hello,
> >>>>>
> >>>>> The possibility to keep a VM using large hugetlbfs pages running af=
ter a memory
> >>>>> error is very important, and the possibility described here could b=
e a good
> >>>>> candidate to address this issue.
> >>>>
> >>>> Thanks for expressing interest, William, and sorry for getting back =
to
> >>>> you so late.
> >>>>
> >>>>>
> >>>>> So I would like to provide my feedback after testing this code with=
 the
> >>>>> introduction of persistent errors in the address space: My tests us=
ed a VM
> >>>>> running a kernel able to provide MFD_MF_KEEP_UE_MAPPED memfd segmen=
ts to the
> >>>>> test program provided with this project. But instead of injecting t=
he errors
> >>>>> with madvise calls from this program, I get the guest physical addr=
ess of a
> >>>>> location and inject the error from the hypervisor into the VM, so t=
hat any
> >>>>> subsequent access to the location is prevented directly from the hy=
pervisor
> >>>>> level.
> >>>>
> >>>> This is exactly what VMM should do: when it owns or manages the VM
> >>>> memory with MFD_MF_KEEP_UE_MAPPED, it is then VMM's responsibility t=
o
> >>>> isolate guest/VCPUs from poisoned memory pages, e.g. by intercepting
> >>>> such memory accesses.
> >>>>
> >>>>>
> >>>>> Using this framework, I realized that the code provided here has a =
problem:
> >>>>> When the error impacts a large folio, the release of this folio doe=
sn't isolate
> >>>>> the sub-page(s) actually impacted by the poison. __rmqueue_pcplist(=
) can return
> >>>>> a known poisoned page to get_page_from_freelist().
> >>>>
> >>>> Just curious, how exactly you can repro this leaking of a known pois=
on
> >>>> page? It may help me debug my patch.
> >>>>
> >>>>>
> >>>>> This revealed some mm limitations, as I would have expected that th=
e
> >>>>> check_new_pages() mechanism used by the __rmqueue functions would f=
ilter these
> >>>>> pages out, but I noticed that this has been disabled by default in =
2023 with:
> >>>>> [PATCH] mm, page_alloc: reduce page alloc/free sanity checks
> >>>>> https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
> >>>>
> >>>> Thanks for the reference. I did turned on CONFIG_DEBUG_VM=3Dy during=
 dev
> >>>> and testing but didn't notice any WARNING on "bad page"; It is very
> >>>> likely I was just lucky.
> >>>>
> >>>>>
> >>>>>
> >>>>> This problem seems to be avoided if we call take_page_off_buddy(pag=
e) in the
> >>>>> filemap_offline_hwpoison_folio_hugetlb() function without testing i=
f
> >>>>> PageBuddy(page) is true first.
> >>>>
> >>>> Oh, I think you are right, filemap_offline_hwpoison_folio_hugetlb
> >>>> shouldn't call take_page_off_buddy(page) depend on PageBuddy(page) o=
r
> >>>> not. take_page_off_buddy will check PageBuddy or not, on the page_he=
ad
> >>>> of different page orders. So maybe somehow a known poisoned page is
> >>>> not taken off from buddy allocator due to this?
> >>>
> >>> Maybe it's the case where the poisoned page is merged to a larger pag=
e,
> >>> and the PGTY_buddy flag is set on its buddy of the poisoned page, so
> >>> PageBuddy() returns false?:
> >>>
> >>>   [ free page A ][ free page B (poisoned) ]
> >>>
> >>> When these two are merged, then we set PGTY_buddy on page A but not o=
n B.
> >>
> >> Thanks Harry!
> >>
> >> It is indeed this case. I validate by adding some debug prints in
> >> take_page_off_buddy:
> >>
> >> [ 193.029423] Memory failure: 0x2800200: [yjq] PageBuddy=3D0 after dra=
in_all_pages
> >> [ 193.029426] 0x2800200: [yjq] order=3D0, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029428] 0x2800200: [yjq] order=3D1, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029429] 0x2800200: [yjq] order=3D2, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029430] 0x2800200: [yjq] order=3D3, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029431] 0x2800200: [yjq] order=3D4, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029432] 0x2800200: [yjq] order=3D5, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029434] 0x2800200: [yjq] order=3D6, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029435] 0x2800200: [yjq] order=3D7, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029436] 0x2800200: [yjq] order=3D8, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029437] 0x2800200: [yjq] order=3D9, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029438] 0x2800200: [yjq] order=3D10, page_order=3D10, PageBuddy(=
page_head)=3D1
> >>
> >> In this case, page for 0x2800200 is hwpoisoned, and its buddy page is
> >> 0x2800000 with order 10.
> >
> > Woohoo, I got it right!
> >
> >>> But even after fixing that we need to fix the race condition.
> >>
> >> What exactly is the race condition you are referring to?
> >
> > When you free a high-order page, the buddy allocator doesn't not check
> > PageHWPoison() on the page and its subpages. It checks PageHWPoison()
> > only when you free a base (order-0) page, see free_pages_prepare().
>
> I think we might could check PageHWPoison() for subpages as what free_pag=
e_is_bad()
> does. If any subpage has HWPoisoned flag set, simply drop the folio. Even=
 we could

Agree, I think as a starter I could try to, for example, let
free_pages_prepare scan HWPoison-ed subpages if the base page is high
order. In the optimal case, HugeTLB does move PageHWPoison flag from
head page to the raw error pages.

> do it better -- Split the folio and let healthy subpages join the buddy w=
hile reject
> the hwpoisoned one.
>
> >
> > AFAICT there is nothing that prevents the poisoned page to be
> > allocated back to users because the buddy doesn't check PageHWPoison()
> > on allocation as well (by default).
> >
> > So rather than freeing the high-order page as-is in
> > dissolve_free_hugetlb_folio(), I think we have to split it to base page=
s
> > and then free them one by one.
>
> It might not be worth to do that as this would significantly increase the=
 overhead
> of the function while memory failure event is really rare.

IIUC, Harry's idea is to do the split in dissolve_free_hugetlb_folio
only if folio is HWPoison-ed, similar to what Miaohe suggested
earlier.

BTW, I believe this race condition already exists today when
memory_failure handles HWPoison-ed free hugetlb page; it is not
something introduced via this patchset. I will fix or improve this in
a separate patchset.

>
> Thanks both.

Thanks Harry and Miaohe!


> .
>
> >
> > That way, free_pages_prepare() will catch that it's poisoned and won't
> > add it back to the freelist. Otherwise there will always be a window
> > where the poisoned page can be allocated to users - before it's taken
> > off from the buddy.
> >
>

