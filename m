Return-Path: <linux-kernel+bounces-782506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4689BB32162
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4725D3A37BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F03C23F26B;
	Fri, 22 Aug 2025 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dd0uS5m0"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5BF235355
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755883004; cv=none; b=Q4wWnfYrp9POFdHshKMTKGQ0wRSV60C5e+qsXk3vLwv26O+O4CEzUk09bOKljSlCvTMMH82oLoXXJqlk3ZuXD2OFf05ijJ2a9wRNs+SK5hoH53qg4oGg4JQtMLDlJF4aagLEVcU74yMvxIRjLk79xD25s6e82cQ8KGaZfN0FD7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755883004; c=relaxed/simple;
	bh=Reiqrhs0SwE9AhkJDRm2RhHstOruGMKD+ubZZAq37oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b70FfKWZNd6OsQNa3koA9+sbx+SLoos8bF7L5HZC7QZVWvnSCj7nHPL0lXVWNFchm//8WT7jMW5pl9JQ7vFIbtp0ISP2xL4rnoLmrkfG+B6RDE3tT01uEf/hw+Z4XSSJ1bZCwE3E1TA0umXsZidW0/Y4KfKiQWYP0BVG80Urzds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dd0uS5m0; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61c169a9720so541a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755883000; x=1756487800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Reiqrhs0SwE9AhkJDRm2RhHstOruGMKD+ubZZAq37oQ=;
        b=dd0uS5m0ko2ZbXKJj8ztYqUX5axaA+J9Ghv+3kKwe4nICiiWiffUxCzj823XDA6ZAd
         XMIBb7luZcNviZ161tGjblVzq1rpvsKIMY1jDBbohNFqOqQ4NvWFaGUDEtNzrgWNNVab
         g1qcEn2uLrR4p58DMSvF5uV/6UCSIUVx22zY6Y31/DPFUNMZm6EkmJpZd1h2b8jQnYVl
         xG9GI5nv1peaFbE/sYqABgTplDMTFf/ywTnAp6LbK0oFBBN1Gt6vkXIYghjQ6FxnaSMb
         +dnSRikpwOVGZ8qDX8/KB0JeWqBGOW8SdbemSdnWZWQmb54z9AtAXejbwJZEEcRHu13V
         7g9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755883000; x=1756487800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Reiqrhs0SwE9AhkJDRm2RhHstOruGMKD+ubZZAq37oQ=;
        b=UDNZMY1qOdLVGoUnDuazKRFwsTs3tidydO6KGHVaP7V14qJnpNT24NoM1ugVIuquoR
         G6zuRg6nj6esRZfzMKB0OLtSicalKf2kqODsWhNwdScpALcbmHsckB+nDh6+X4QyaIpn
         hEhXu4SJ+i0WcGxfNwnrJmuAXodtXUX/FzTodT4xgTgLSO/i3n2q8kgqWWxnANN9xcLC
         m19htmHzfCWmYE7roZ601hjm5Mk0uto9YHrY88U3zjPVOtxCMGXUFD8Ic5vtHizO02n4
         qBNvAaiYvZocfr1lQ+MLYsFdq6KM11LReOMql0TchNcVgLhRkk8viS5eVgYuza3loUMC
         Vovw==
X-Forwarded-Encrypted: i=1; AJvYcCVoQ0NB2y5G0/3oxGVagIp6u10oQ0ZeVn5yCV2OvocKWW/Dnsf4Rogg5gYyFyfmzPxcyXgPLl/chjKWP7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDhJA+mqW3EN6IgXb26OzgInpn+/3srNDoE/B370RJUG/Yq+F2
	ANV0QzBwefd/48YL3Wqi/xgR8Kkc69I2zyNAAFCFAg6yNOOc7i0WChvjE5ZaRV6dL3blQf+ofIr
	OUC2a9Ntd7T6+S3O6+dsdnnwuxeJpORrMM73Y1Q88
X-Gm-Gg: ASbGncsZNaMePHbumUyx70Ver9ANuV/fOcSzTubkZYyRdfftaIIvG1s+qINOacwOhdl
	9JVgcCQ7HCA80ironpy32a1tUkKZUQHU0wz2g0f3MKTkfxUrUf2OMzgis+537vcLGTflmNBEfK9
	+lqk9+P2Dv2sxj5NQjPbcOCj/ED2+VBIMi3gzClj9Av1GDASfNttktqzxDMaetDnmyqUEqfABxE
	xmmEIZQubiNfldBASpi8fyi7dWYLrOlJZkotV5roPpE
X-Google-Smtp-Source: AGHT+IFXIGut26LOc1CQf/XCARjxaINOLYEDzaorWnc/UwNjcbcHiAwfR23VgucQGTTwO2zZuZmzdzyyz3t2YgMZl5k=
X-Received: by 2002:a50:d69e:0:b0:61b:f987:42d9 with SMTP id
 4fb4d7f45d1cf-61c1a3c18aemr96810a12.2.1755883000214; Fri, 22 Aug 2025
 10:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+EESO6dR5=4zaecmYqQqOX4702wwGSTX=4+Ani_Q9+o+WUnQA@mail.gmail.com>
 <CA+EESO6iqowMAOnBPJjERqZym_qvd6kx8BDMQG8+3xQSrNFytw@mail.gmail.com>
 <CAGsJ_4xccre0rz5zgRTA=NbFzF4FLS-ZUohgLFnfTGY9Jdequg@mail.gmail.com>
 <3133F0B4-4684-4EC7-81FC-BC12A430E4C2@nvidia.com> <CA+EESO7_-64GU5v1FTMXbemQixPX+xo6SGm8r0txohZJLs97cA@mail.gmail.com>
 <aKhIL3OguViS9myH@hyeyoo> <3972cb48-2684-4ba6-ab78-66460a939929@lucifer.local>
In-Reply-To: <3972cb48-2684-4ba6-ab78-66460a939929@lucifer.local>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Fri, 22 Aug 2025 10:16:28 -0700
X-Gm-Features: Ac12FXx5T0E12LSSvBocUhz1H5FP9e1ihWkMaGNO3Tf3CJxonVxzYrWcs24n3UE
Message-ID: <CA+EESO5nE4uLhqgGaGTbSf_ke+TnZjw+ijJqys6omNpaaEF9Lg@mail.gmail.com>
Subject: Re: [RFC] Unconditionally lock folios when calling rmap_walk()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, Zi Yan <ziy@nvidia.com>, Barry Song <21cnbao@gmail.com>, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@redhat.com>, Suren Baghdasaryan <surenb@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	android-mm <android-mm@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 3:50=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Lokesh, this is a mess :/
>
> I've been a reverse mapping co-maintainer for 4 months now, please check
> MAINTAINERS before sending this stuff out. It's not really impressive to
> learn about this 2nd hand...
>
> Also I cannot get lei to get this mail to me, no matter how hard I try. S=
o
> it's _really hard_ for me to respond to this.
>
> And you label this '[RFC]' but I can't find any code (unless it's lost in
> the thread somehow). It should be '[DISCUSSION]'.
>
> rmap locking is _extremely_ sensitive and the discussion needs careful
> attention.
>
> It's hard for me to even track what's going on here or join the discussio=
n,
> could you just please resend, correctly cc'ing the maintainers/reviewers =
of
> rmap, and prefix with '[DISCUSSION]'?

Sincere apologies. I'll resend correcting both the mistakes.
>
> You've already got responses here so we're inevitably going to fork the
> conversation, but unfortunately I don't see any way around this, because
> I'm going to miss all the conversation that I'm not cc'd on.
>
> Anwyay I simply can't engage on this as-is, and I really _want to_, becau=
se
> rmap and the locking around it are issues of PRIMARY importance to me.
>
> Please try to make my life easier :)
>
> Thanks, Lorenzo

