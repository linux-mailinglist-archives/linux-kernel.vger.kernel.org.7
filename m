Return-Path: <linux-kernel+bounces-843592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86C2BBFC95
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BD13C2EAC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471851F7098;
	Mon,  6 Oct 2025 23:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iwb83LuF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D234AEACD
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759793700; cv=none; b=aIvrPyIrE11P6V6Amg+wr9woa+D8WVB4lqEFR+SXOBZNmnOWPEgD6EkCYcu3DNBThxVYQRtWoE8vKwBeGHH2Fbf4vc0/X8ZpwpU0by7SeDWgEN6jqoszbfWY5Q83tC1xsFbrnGs2VW297vwCRWUFHotGmKvyDn7EIsLRphF/MVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759793700; c=relaxed/simple;
	bh=0iCjIY4+c4XiV5SfxYqhQBBBbIRDdht6/sZ+q8A+V9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccKPd1OkbaE3D05OqZkCnxO0O12qWTNF7/ywmNEGjUvvR/mZpkwxD2Lnxv+aSsvYF+Xfs+7mZgvKaFyZ2LTWUAw4jkETOG9u/kRL++UxGerl2QZt0UXSiXu5W6rBVeNdB53uhIAEaVZFnxfoT3WQaWdNOBXD+k9345EnKxdlidc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iwb83LuF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759793697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybILaILRCl7/UBex2ty3xf+O7+CzTBJ2uGf6Ymm2ESU=;
	b=Iwb83LuFT3WUjxbBOJAyvaCjfTRqSpQxAETXDORBkNMI4hJopj44ApBNNCNFcaTRUZ6Wdz
	1keZkmk6Z+SpbzQp7134BBbCfcY91idWQJzaGkB/VzkCO8QsuzaFT2xZzGBCKVNuXkeRvb
	sN3JQpfi7Wqf+mY8xNwRJ75qlyWsKjo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-Wkm0J3nlNcq4h_nwX9fVWw-1; Mon, 06 Oct 2025 19:34:56 -0400
X-MC-Unique: Wkm0J3nlNcq4h_nwX9fVWw-1
X-Mimecast-MFC-AGG-ID: Wkm0J3nlNcq4h_nwX9fVWw_1759793696
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4deb67c61caso151916471cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759793696; x=1760398496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybILaILRCl7/UBex2ty3xf+O7+CzTBJ2uGf6Ymm2ESU=;
        b=xN6uMdZ7ckrpiPIKXxv9kFd9r+dSHzbQJWS1d/J1RQzghtZChvu/IS0e7ROapn4s3m
         Zm1D1gZ6Jz/C93N9YU4wnXayecIwb0rtn9SJYAPD5EeRS9yU8oQCVt0fOwYO8PwqdHKD
         0Olzsoz5LK41KojCO8h8npS6pLyC1gz2HFLTkUFAcHCRT1VrQ5dAxQon37XOqtgDcJ03
         4vX5mzGJo8h1Wxv8GO1cT7e2W6ZQYCHaadqpZY0gaiFMAUe2d0PHn6CskG1Zns1V8ehj
         eqvXNpSRLnQe2j8NqMU0GEcyg7fowMVmISiLEGs9w1o9ItwdUqnygdolzWVV+VxBcO3f
         jELw==
X-Forwarded-Encrypted: i=1; AJvYcCXxdo/YGKagNs5BheR5BSMiqafiibtoCj10qTREHxBhlSPpf8AiTCUeMtVfryz+oybxX4bc1AW0atMLzpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ztgAt9AABphgLB0qv40b1KV6kSvhRIseJbAFTS3StvqwCMeY
	mzT01zhfMXKPLw1uMrIRlGOkDaZUE9oCHilrtpXBzbrM91SBja1JfWO8/Ry1oakuTgmvAtVsnKG
	AhPIehVurFpoN3m9gF5f5d+K7P2dZcQ+Ko5qM8Zm+S01RTOQeNkenEIqYi+VqZCrlQGQYe1rxHp
	z/+YstvQ1ZK1UtP7oiEyc+MROS/w7Em21G0yvavMRM
X-Gm-Gg: ASbGnctMJBVxYfXaf3PCbGtsGvC41MJyXFLoyDj+O3dBthOv51TUIWoJHUY+wZKeQRG
	xHDe9xusgYnD8CrrbCNOTrg52rKHVYfwmWmKH4VNVvJSCUNF2+5yBtvLm5dC9vfHh5lpQQqQiZX
	kxD+V31/N5DLbRJu2ouqXUwYj4/pA=
X-Received: by 2002:a05:622a:550d:b0:4b7:a3ac:701c with SMTP id d75a77b69052e-4e576a2b225mr222255171cf.13.1759793696051;
        Mon, 06 Oct 2025 16:34:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFA4nYNqarA2pFZ091eiqCpdMYvtmFpn4w2eYrABOe6c4Di935ydlDHXX3A55UKw8lm641HHW/4xWzWdWIfnU=
X-Received: by 2002:a05:622a:550d:b0:4b7:a3ac:701c with SMTP id
 d75a77b69052e-4e576a2b225mr222254891cf.13.1759793695714; Mon, 06 Oct 2025
 16:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz> <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
 <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com> <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
 <2e35b6dd-56dd-47e6-8dac-54f446f763f0@redhat.com>
In-Reply-To: <2e35b6dd-56dd-47e6-8dac-54f446f763f0@redhat.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 7 Oct 2025 12:34:19 +1300
X-Gm-Features: AS18NWBxUcyeBHV1k29L8uNzXCcsOUwxNIfTLpM3voYn0O5GxYm8lT2LXMD4oz0
Message-ID: <CAO7dBbUdZg7Lp+7bHzpQSpP7PX4YO=isTEDeA3X8N+VihkCusw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
To: David Hildenbrand <dhildenb@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, kas@kernel.org, Jiri Bohac <jbohac@suse.cz>, riel@surriel.com, 
	vbabka@suse.cz, nphamcs@gmail.com, Baoquan He <bhe@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, 
	akpm@linux-foundation.org, Philipp Rudo <prudo@redhat.com>, 
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>, linux-kernel@vger.kernel.org, 
	Michal Hocko <mhocko@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, Oct 7, 2025 at 5:45=E2=80=AFAM David Hildenbrand <dhildenb@redhat.c=
om> wrote:
>
> On 06.10.25 18:25, Breno Leitao wrote:
> > On Mon, Oct 06, 2025 at 10:16:26AM +0200, David Hildenbrand wrote:
> >> On 03.10.25 17:51, Breno Leitao wrote:
> >>> Hello Jiri,
> >>>
> >>> On Thu, Jun 12, 2025 at 12:11:19PM +0200, Jiri Bohac wrote:
> >>>
> >>>> Currently this is only the case for memory ballooning and zswap. Suc=
h movable
> >>>> memory will be missing from the vmcore. User data is typically not d=
umped by
> >>>> makedumpfile.
> >>>
> >>> For zswap and zsmalloc pages, I'm wondering whether these pages will =
be missing
> >>> from the vmcore, or if there's a possibility they might be present bu=
t
> >>> corrupted=E2=80=94especially since they could reside in the CMA regio=
n, which may be
> >>> overwritten by the kdump environment.
> >>
> >> That's not different to ordinary user pages residing on these areas, r=
ight?
> >
> > Will zsmalloc on CMA pages be marked as "userpages"?
>
> No, but they should have the zsmalloc page type set.
>
> >
> > makedump file iterates over the pfns and check for a few flags before
> > "copying" them to disk.
> >
> > In makedumpfile, userpages are basically discarded if they are anonymou=
s
> > pages:
> >       #define isAnon(mapping, flags, _mapcount) \
> >               (((unsigned long)mapping & PAGE_MAPPING_ANON) !=3D 0 && !=
isSlab(flags,
> >               _mapcount))
> >
> >       https://github.com/makedumpfile/makedumpfile/blob/master/makedump=
file.h#L164
> >
> >       called from:
> >       https://github.com/makedumpfile/makedumpfile/blob/master/makedump=
file.c#L6671
> >
> > For zsmalloc pages in the CMA, The page struct (pfn)) is marked with ol=
d
> > page struct (from the first kernel), but, the content has changed
> > (replaced by kdump environment - 2nd kernel).
> >
> > So, whatever decision makedumpfile does based on the PFN, it will dump
> > incorrect data, given that the page content does not match the data
> > anymore.
>
> Right.
>
> >
> > If my understanding is valid, we don't want to dump any page that point=
s
> > to the PFN, because they will probably have garbage.
>
> My theory is that barely anybody will go ahead and check compressed page
> content, but I agree. We should filter them out.
>
> >
> > That said, I see two options:
> >
> >   1) Ignore the CMA area completely in makedump.
> >      - I don't think there is any way to find that area today. The kern=
el
> >        might need to print the CMA region somewhere (/proc/iomem?)
>
> /proc/iomem in the newkernel should indicate the memory region as System
> RAM (for the new kernel). That can just be filtered out in any case:
> dumping memory of the new kernel does not make sense in any case.
>
> >
> >   2) Given that most of the memory in CMA will be anonymous memory, and
> >      already discard by other rules, just add an additional entry for
> >      zsmalloc pages.
> >
> >      Talking to Kirill offline, it seems we can piggy back on MovableOp=
s
> >      page flag.
>
> We should likely check the page type instead if we go down that path.

If choosing a proper page type/flag is hard, maybe an ongoing new
feature for makedumpfile can help with that. In short, if we can get a
workable page flag for CMA to get filtered, then proceed as usual, If
cannot, then we can use eppic/btf/kallsyms[1] in makedumpfile to
programmably determine page type and filter it out. See the program
for determining amdgpu's mm pages[2].

[1]: https://lore.kernel.org/kexec/20250610095743.18073-1-ltao@redhat.com/T=
/#m901bf1413b844648c86e8a84d75b66d0531b9f92
[2]: https://lore.kernel.org/kexec/20250610095743.18073-1-ltao@redhat.com/T=
/#m38362d258e3b0bdc14a64e54a6acd5b85810ca26

Cheers,
Tao Liu

>
> --
> Cheers
>
> David / dhildenb
>


