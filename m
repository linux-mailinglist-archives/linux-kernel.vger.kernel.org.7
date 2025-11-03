Return-Path: <linux-kernel+bounces-883395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64407C2D506
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA4064E8FC7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF36431AF3E;
	Mon,  3 Nov 2025 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IAVWywP7"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5008231960A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189044; cv=none; b=ERGFzKCn5n/SXQPeVU7eS0IzzjL8ZLHQhWm3EUK8yStt/ZmaupcwOtum2K6hqgJt2ujBGYupiC3crpzQK5iWgTcLEtYZMIf5o1CixrPz6CCj5IlwWBc6d5My2rJ8RiLOlhfz8A4Q2pUgKpqMr0dQYFbldXPNTwR48RlZYZLZJ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189044; c=relaxed/simple;
	bh=gXSUHmcaUphZGHWjr/dbElnyU/fHkGguUYmUjOgo1eQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NitF7Ti5j6G76ZdasGKRm5qJm7Mgt30Y9rzcOMPJ3nEdakrJI205/qlwrB6OT0i04m/j7k1Git08m697hpz2S29A8Dsf+Gwr83ne8qFQmiyAh8AoXGeKQ8Bb8NjfJ0A2RaJiKqPRQsxrBpDexHm7Mnve01D76yNL6ew2ZYOZGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IAVWywP7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4770d4df4deso99205e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762189040; x=1762793840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXSUHmcaUphZGHWjr/dbElnyU/fHkGguUYmUjOgo1eQ=;
        b=IAVWywP7Idg4kbCL+ROhMARrDFCBIxbjkdsLw1UQdN/alB4sj7DknqS9kndjk1Sad6
         sRZAJp2zPfsV3gDKEUrtX/foayTCWwVHIMxvH3GhOAQt8Hw9lLT54UjkPjjWXeW6wA5c
         ihwMqed1uL2WxM7riuZ/lIUHtF3gmN3wbCFUw7IOCm/IbUU8neQM+299rdgXY8g4064X
         vHeMsy5PuLRlikfVgC4IUt1tHKVL2KeKVHvglqKCxM/gOUDyEiQOcRp2gnLq/z0uUdhn
         g61wGzFiKwMJI0FRzKcatyyvv19UEwbhpZXzBdncDfsS/QZUDcNS1VVdzcqwudvo+djT
         HWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189040; x=1762793840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXSUHmcaUphZGHWjr/dbElnyU/fHkGguUYmUjOgo1eQ=;
        b=cxWC4Uezef608a7ggjCnZH7FXHi0hhsAcWknBMEe2ckUZDoCzvXhM7LiC5oMY9oOfh
         a6TG3UUQQo+ZFboOLbdl1u61OOQfkO6Ss/QS5Aavm+13WYgK2uXIrhiE43+n4q5q1LAR
         /fZt6+il0CDvdZwj1cTnPPMWDfix9Gta90VASv5rH8EWPzELDKG1/+KUvcXkyDQJJDNn
         G4kW7QkuqhP7TGOksH+nj8M0uLIBdA9q1LsWq8BvDhZRR1oVMSOeLE1O0xZspxOcL5Tq
         9BxCHd0blMUHGaPUidHuiM8uM5J3va+E9UIXQhDWn2TEE9l2Dxi7upcBPBBj5hxSVEa+
         OoNg==
X-Forwarded-Encrypted: i=1; AJvYcCVSiKPq2hnMmQxihK4IbZ/sIz8m9g2ykO5vgyMImac9kSDrJK3kKGK91DVKBrwi0+Jlj9xbKlyhxI3i5r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSeOBZx3fu3DbAABl6v2F58BDQRbMmjzlirqFymGr3Vgkjp0Ns
	yl79VOTHM+MuGVhTC13H10Pi1FnVHDL6p1U7iV3Wid5cOcqROLA6SElI2C676NUuN2gxPneGcsp
	DflBup07oysxhCIndwZ0mO2xfQy01KZfUYC8X7UXj
X-Gm-Gg: ASbGncv7UMf1ElLQdEx8Yomp4h5jmzd2jBiKqF7Gqcy5D9xoFdRWWV70ebfmrJ4q9yi
	+MU+LZLXZj+WrsT3VIvq0t12G9HhLWKloPabAma0T00Ze2+dAx0oCdQbIT3OlZ8THF1I0lW2RIH
	joTpSSaooSjK+W/15tI+42FLz76rV2nkAEgCIoW/Ph90QUWEbiEjJNyyAPUcPMpx8jBHKvbEzJE
	nVuKgO5jcg8XinbTXpZD7wq9GgAtz/mZosCE8rPZqsOzZM+7WuiyrJyEO/X9Y/VhG9La5tLjtBV
	lKuf05DtYWrFXuJbaQ==
X-Google-Smtp-Source: AGHT+IHltJD7aAfzyanPskcCGEW/r71vqTVXp8jRpi/mhU0n51LF+Ree9stW3JVC96zs2RiHGJB+80eotHc/1zCN5ok=
X-Received: by 2002:a05:600c:a103:b0:477:1afe:b962 with SMTP id
 5b1f17b1804b1-4775494bf56mr266115e9.1.1762189040413; Mon, 03 Nov 2025
 08:57:20 -0800 (PST)
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
 <CACw3F51qaug5aWFNcjB54dVEc8yH+_A7zrkGcQyKXKJs6uVvgA@mail.gmail.com>
 <aQhk4WtDSaQmFFFo@harry> <aQhti7Dt_34Yx2jO@harry>
In-Reply-To: <aQhti7Dt_34Yx2jO@harry>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 3 Nov 2025 08:57:08 -0800
X-Gm-Features: AWmQ_bkTLA46lp2jCX_gE30BD7c00kSfXnsdnOyhAycwpjTYtFfHvFxWpgPbyHk
Message-ID: <CACw3F503FG01yQyA53hHAo7q0yE3qQtMuT9kOjNHpp8Q9qHKPQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>, =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>, 
	Ackerley Tng <ackerleytng@google.com>, jgg@nvidia.com, akpm@linux-foundation.org, 
	ankita@nvidia.com, dave.hansen@linux.intel.com, david@redhat.com, 
	duenwen@google.com, jane.chu@oracle.com, jthoughton@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, nao.horiguchi@gmail.com, 
	osalvador@suse.de, peterx@redhat.com, rientjes@google.com, 
	sidhartha.kumar@oracle.com, tony.luck@intel.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 12:53=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Mon, Nov 03, 2025 at 05:16:33PM +0900, Harry Yoo wrote:
> > On Thu, Oct 30, 2025 at 10:28:48AM -0700, Jiaqi Yan wrote:
> > > On Thu, Oct 30, 2025 at 4:51=E2=80=AFAM Miaohe Lin <linmiaohe@huawei.=
com> wrote:
> > > > On 2025/10/28 15:00, Harry Yoo wrote:
> > > > > On Mon, Oct 27, 2025 at 09:17:31PM -0700, Jiaqi Yan wrote:
> > > > >> On Wed, Oct 22, 2025 at 6:09=E2=80=AFAM Harry Yoo <harry.yoo@ora=
cle.com> wrote:
> > > > >>> On Mon, Oct 13, 2025 at 03:14:32PM -0700, Jiaqi Yan wrote:
> > > > >>>> On Fri, Sep 19, 2025 at 8:58=E2=80=AFAM =E2=80=9CWilliam Roche=
 <william.roche@oracle.com> wrote:
> > > > >>> But even after fixing that we need to fix the race condition.
> > > > >>
> > > > >> What exactly is the race condition you are referring to?
> > > > >
> > > > > When you free a high-order page, the buddy allocator doesn't not =
check
> > > > > PageHWPoison() on the page and its subpages. It checks PageHWPois=
on()
> > > > > only when you free a base (order-0) page, see free_pages_prepare(=
).
> > > >
> > > > I think we might could check PageHWPoison() for subpages as what fr=
ee_page_is_bad()
> > > > does. If any subpage has HWPoisoned flag set, simply drop the folio=
. Even we could
> > >
> > > Agree, I think as a starter I could try to, for example, let
> > > free_pages_prepare scan HWPoison-ed subpages if the base page is high
> > > order. In the optimal case, HugeTLB does move PageHWPoison flag from
> > > head page to the raw error pages.
> >
> > [+Cc page allocator folks]
> >
> > AFAICT enabling page sanity check in page alloc/free path would be agai=
nst
> > past efforts to reduce sanity check overhead.
> >
> > [1] https://lore.kernel.org/linux-mm/1460711275-1130-15-git-send-email-=
mgorman@techsingularity.net/
> > [2] https://lore.kernel.org/linux-mm/1460711275-1130-16-git-send-email-=
mgorman@techsingularity.net/
> > [3] https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
> >
> > I'd recommend to check hwpoison flag before freeing it to the buddy
> > when we know a memory error has occurred (I guess that's also what Miao=
he
> > suggested).
> >
> > > > do it better -- Split the folio and let healthy subpages join the b=
uddy while reject
> > > > the hwpoisoned one.
> > > >
> > > > >
> > > > > AFAICT there is nothing that prevents the poisoned page to be
> > > > > allocated back to users because the buddy doesn't check PageHWPoi=
son()
> > > > > on allocation as well (by default).
> > > > >
> > > > > So rather than freeing the high-order page as-is in
> > > > > dissolve_free_hugetlb_folio(), I think we have to split it to bas=
e pages
> > > > > and then free them one by one.
> > > >
> > > > It might not be worth to do that as this would significantly increa=
se the overhead
> > > > of the function while memory failure event is really rare.
> > >
> > > IIUC, Harry's idea is to do the split in dissolve_free_hugetlb_folio
> > > only if folio is HWPoison-ed, similar to what Miaohe suggested
> > > earlier.
> >
> > Yes, and if we do the check before moving HWPoison flag to raw pages,
> > it'll be just a single folio_test_hwpoison() call.
> >
> > > BTW, I believe this race condition already exists today when
> > > memory_failure handles HWPoison-ed free hugetlb page; it is not
> > > something introduced via this patchset. I will fix or improve this in
> > > a separate patchset.
> >
> > That makes sense.
>
> Wait, without this patchset, do we even free the hugetlb folio when
> its subpage is hwpoisoned? I don't think we do, but I'm not expert at MFR=
...

Based on my reading of try_memory_failure_hugetlb, me_huge_page, and
__page_handle_poison, I think mainline kernel frees dissolved hugetlb
folio to buddy allocator in two cases:
1. it was a free hugetlb page at the moment of try_memory_failure_hugetlb
2. it was an anonomous hugetlb page

Let me know if my understanding is wrong.

>
> If we don't, the mainline kernel should not be affected by this yet?
>
> > Thanks for working on this!
> >
> > > > > That way, free_pages_prepare() will catch that it's poisoned and =
won't
> > > > > add it back to the freelist. Otherwise there will always be a win=
dow
> > > > > where the poisoned page can be allocated to users - before it's t=
aken
> > > > > off from the buddy.
>
> --
> Cheers,
> Harry / Hyeonggon

