Return-Path: <linux-kernel+bounces-836933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908BCBAAEA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7AB16B07A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755A21A0711;
	Tue, 30 Sep 2025 01:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B8HOhXu/"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BFD54654
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759196967; cv=none; b=NVx+Gv7quty6e+AGyC4d0jIxsBaYz3G/585zbfOrWDQHQcpkXrShU1yDZ365CUDE+Q+XFWukZvmDMgMNFgWOJK3oHbzTIgHUJB7CukFZJzAsb8JvRYw6nitKc0CA94BBeOT/nR0OkbcXDaaTjJogjOsAPquEcgEF8PL1IIRwk0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759196967; c=relaxed/simple;
	bh=cccOvLIDs0brVn19lKW2cu082nXZ924OZUgqQqLgWy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7ewIRCmDStcVVvpYhx/RxRVBT+EXwU8bHerHCdj4KczRym//VFEWy6uyax9zP7t7hPuVxtPzuLXWpuJVEZRi4XrMFEcCbmWFKUE63AILVctkCUCFT9pZJQJT/j/25a4U46Mu2cHH4rsw6vlDJKbtZNXOub8YHw+/tXDUKnePKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B8HOhXu/; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCVuuJIWtlWO4RmyAOX//7LgcP9IZWn3N7hljeY4GeyK/JEoPgUB+/PAi2BjhPgbcUXL7GPJKzjO+E/Gwh4=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759196962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cccOvLIDs0brVn19lKW2cu082nXZ924OZUgqQqLgWy4=;
	b=B8HOhXu/G+ed4lo7yxhAgpmi3zaaTykcgbzs3nrrxTCbjs/cs27j0lfve3jiQipQwSp94H
	MJhGPsTHvlXMCOlMGDpXTG3INLhPA/yXs6H8SddxrzImQwvcjAaheyAqxNEGuh3sURZwOI
	lyIPWifHIkjjvQzPW5fSGc/ZGyhB9r0=
X-Gm-Message-State: AOJu0YytTQ5JMfLcLKQt85ms4MSCycn+zzC7KuwlzWxbmf5eTb9dpjdG
	WDa6KfvCubEKavQKwX1GDtzIFDj3OPADsG/WiB+tHJ17x+yNfpbeKgXF7ReVNy9pnoVGWW+GMU7
	alkK/tOJVUN9b678cxfrHnDkOn560jIM=
X-Google-Smtp-Source: AGHT+IFyudbMtZdS0/36vaHAY+KBcRFGx23xtJVbc/IL05kWT/AjSm5jL8atDU+wwYaYSRh1LwVacl/v4+VesV0jJio=
X-Received: by 2002:ad4:5ce3:0:b0:863:5c7a:7289 with SMTP id
 6a1803df08f44-8635c89b87emr43694456d6.17.1759196952850; Mon, 29 Sep 2025
 18:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
 <CACw3F50ijQ20Vg8ycMROSCccf_XtjB_fFvLGxvQZ7eaNQoLwGQ@mail.gmail.com>
 <SA1PR11MB7130ABC25E060D2CC4749E45891BA@SA1PR11MB7130.namprd11.prod.outlook.com>
 <SJ1PR11MB608350E5169EE77F86A51E2FFC1BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SA1PR11MB713082CA93E9B1C5F22CFBBE891BA@SA1PR11MB7130.namprd11.prod.outlook.com>
 <c1294b63-eeee-4d99-82b6-93eb3a6d0af9@redhat.com>
In-Reply-To: <c1294b63-eeee-4d99-82b6-93eb3a6d0af9@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Tue, 30 Sep 2025 09:48:34 +0800
X-Gmail-Original-Message-ID: <CABzRoya5wuXoMWuGb_+F0oBc0mCDVrjbXTZsoMwcfRT99Y5z7g@mail.gmail.com>
X-Gm-Features: AS18NWCEPx5gCS0R5WB1gxGkcM2qm8EcK_iKsr9vf6l6Pm-AjVLkn3oGjXPud8c
Message-ID: <CABzRoya5wuXoMWuGb_+F0oBc0mCDVrjbXTZsoMwcfRT99Y5z7g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: prevent poison consumption when splitting THP
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, David Hildenbrand <david@redhat.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Jiaqi Yan <jiaqiyan@google.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "linmiaohe@huawei.com" <linmiaohe@huawei.com>, 
	"ziy@nvidia.com" <ziy@nvidia.com>, 
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "npache@redhat.com" <npache@redhat.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "dev.jain@arm.com" <dev.jain@arm.com>, 
	"baohua@kernel.org" <baohua@kernel.org>, "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, 
	"Chen, Farrah" <farrah.chen@intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Andrew Zaborowski <andrew.zaborowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 30, 2025 at 3:07=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 29.09.25 18:30, Zhuo, Qiuxu wrote:
> > Hi Tony,
> >
> >> From: Luck, Tony <tony.luck@intel.com>
> >> [...]
> >> Subject: RE: [PATCH 1/1] mm: prevent poison consumption when splitting=
 THP
> >>
> >>> Miaohe mentioned in another e-mail that there was an HWPoisoned flag
> >> for the raw error 4K page.
> >>> We could use that flag just to skip that raw error page and still use
> >>> the zeropage for other healthy sub-pages. I'll try that.
> >>
> >> That HWPoisoned flag is only set for raw pages where an error has been
> >> detected. Maybe Linux could implement an
> >> "is_this_page_all_zero_mc_safe()"[1] that would catch undetected poiso=
n
> >
> > This sounds like a great suggestion to me.
> > Let's see what others think about this and the name (though the name al=
ready LGTM =F0=9F=98=8A).
>
> The function name is just ... special. Not the good type of special IMHO.=
 :)
>
> Note that we'll be moving to pages_identical() in [1]. Maybe we would
> want a pages_identical_mc() or sth. like that as a follow up later.
>
>
> So in any case, make that a follow-up work on top of a simple fix.

Yeah. IIRC, as David suggested earlier, we can just check if a page is
poisoned using PageHWPoison().

Perhaps we should move this check into pages_identical()? This would make
it a central place to determine if pages are safe to access and merge ;)

BTW, could you please keep me in the loop for the next version?

Thanks,
Lance

>
> [1] https://lore.kernel.org/all/20250922021458.68123-1-lance.yang@linux.d=
ev/
>
> --
> Cheers
>
> David / dhildenb
>
>

