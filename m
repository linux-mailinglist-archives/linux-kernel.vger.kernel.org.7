Return-Path: <linux-kernel+bounces-821776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3651AB82388
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CEF625FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE2E10E9;
	Wed, 17 Sep 2025 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c6McwHVp"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87322A1E1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150155; cv=none; b=RfwXSkzT45DmDzsVB8GTLUwrfU4zAdPjQ49cB/Geoiy1+9UJBjFJSPfFHF7yoKS/Xp35YuFsZOZhAWT8muMpL5GtqG7N/7QBpQ9QV6UUUc+bjpBgkPD1cxAiM07OE2HKFU5vfuyDbUIVNvIDBiaNRHI4irbK3m2WnG4nviB7jjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150155; c=relaxed/simple;
	bh=pgqaaTpUUF1iWySwtTjmi51gf1ofnrMUlJLbXGuFg1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmdpqEthXsi3VQtoIbnsMkFN/HtdwXKQioCSJep2brq+9Dxh9rId/HJ8DJhvynqa3bTokn5mmps8ykXVL5zDJYe/W5EWY44CnIj1aYWq32fOKEKVQEdlSgpV2AzvL86hvePTy7UgflmGmYTdUr2v6i01Jcm+02P+6VbjsNpqyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c6McwHVp; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b796ff6d45so99191cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758150153; x=1758754953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgqaaTpUUF1iWySwtTjmi51gf1ofnrMUlJLbXGuFg1Y=;
        b=c6McwHVpanK6WvCbUJOhnqUM4oVuh1Y3AWV7D2kLG3+oprUqstPaCnyztCsiscK7mZ
         svYdNS6NWT/K0NCPP8eD4gXlvfI4klerwTCTfcB8q4Dq0J/BoDlF3QJbRsGHdGu8+8wh
         FcVvakkfEoBhv0nqzLX/ILCuiODmQRXoLONB0LP093qhrzZ4Hs/+CaB7K+jxvrwXrD7q
         DkijPJQlQd6SNQyfdQ9qSt70CiV1Objwp1HX7dzji0Tipt4ZzD0t4j4lGL6ixnovbWxJ
         HmVvoHlwE0NPTAXQ2byv/+jnbN9ByPntSG43elh7/StSjg7PlUFgq4fHWAAWhefhzjgd
         zTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758150153; x=1758754953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgqaaTpUUF1iWySwtTjmi51gf1ofnrMUlJLbXGuFg1Y=;
        b=IdlLtT2daHicg2O/Uv1eSXpyVcl0FFv3cSrqb+AhZEvXhvcfkhFm3TMvISMNUQI2Rr
         jltLAc5Ov9rVgQXZ7pSQMZgmtyCVPDSpOVAdyBHlN3eOcW70f0rByKybmjIdRIfV03pL
         1FQ+2NyOYebl9HQ5Ei3e8/SCf4MtmrK7yzNt/2nBxJD6ortzmGK0NQaHZS7rRUMUt7zG
         0AYMju/zaam7vAvPEEjeivpuCsM7G6yjixhlSz2jRo9IldI2a1tpnjIcEGa1sPRKKJ3Q
         oPYIGUfe6sSxS+9LVYr4vjATBW4FIVPxg+i8tNX5F59iN6NqEgygzw2UHFAPNYnqfK0f
         Jjwg==
X-Forwarded-Encrypted: i=1; AJvYcCVE2XaXlBECTaqq8bAm68ShTAdmMEzGpV0fkLCRJmdSOeKfozDqcMnN//xMsdTTyIH8SRb6VxwlY1UWnII=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc6TYKTr9MnBx2aw6AQrYhiZCdpSm+jLLWkRoXa12uqhNSIwhO
	mnZ2MsxDozNs99Tvs5gMgd838zj/vreOSCRTLB/tRJ60aGMVAt2L6pGi6f5CixKJjs7LFsd4hh0
	oZBnVXYnk8b6fNOs3eWA33vdvZL+cZIMd8rwtSVMm
X-Gm-Gg: ASbGncshbdg+CAaeX1Vezcxe/y7g7DilM4Ea/fOXyZTnmqEtU1UQG2Wu7cocnHcYN/o
	KgW0Jfw+b3VHZUSgtRHzCGZBa0QNhMRACrMWkVuKBfV7OserjN7F4L1eSgvBV1omFXYyqFOWbep
	p0pRvJ6RKwLwnH55Mnp5piP/Nrz+QJPPmAmYnvDBw/rB169uzvqgqTFTDqBVp6mtB2L75yeGwcq
	4xrKL8pkam8Wnd39YgBEyvzMjSUy7E=
X-Google-Smtp-Source: AGHT+IHfNd/k82j9KQVELxfP/PHIbhVVGF3yc0CdD17H0HaS07rG6JkXznFxGYRKvVp7xhpstaqIEbhS5CNnvvGnMEY=
X-Received: by 2002:a05:622a:1998:b0:4b7:a2be:bc71 with SMTP id
 d75a77b69052e-4ba2e66f7c9mr8883171cf.9.1758150152768; Wed, 17 Sep 2025
 16:02:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915230224.4115531-1-surenb@google.com> <2d8eb571-6d76-4a9e-8d08-0da251a73f33@suse.cz>
 <CAJuCfpHXAhGZb1aOPyHOPiTWSwQJi570THqJQcjrVPf=4Dt3xQ@mail.gmail.com>
 <a8519bca-ae16-4642-84a1-4038b12e8bb0@gmail.com> <CAJuCfpFJabb02OK8Rj08d7WU_7AM674i=vsZxzfw7i7h-PGftQ@mail.gmail.com>
 <e5e3d96a-d0aa-4466-8303-5a7e8f96bbe5@gmail.com> <CAJuCfpEULVxMixDjrk_xg7+3+97dkcMmkDd++BaR17X4tDSs6Q@mail.gmail.com>
 <af62a2c2-3c01-408d-b694-aa7e95d23c18@suse.cz>
In-Reply-To: <af62a2c2-3c01-408d-b694-aa7e95d23c18@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Sep 2025 16:02:21 -0700
X-Gm-Features: AS18NWC5wZWoJ9h1q0dLcyZhaQxEfSzQ_NlOG7YOUGtZPGOPImgmHsFxTkhQl-o
Message-ID: <CAJuCfpFAt1jS49R5xR1MELd83oh7MN5GWd2hSMEj2SQVjyJxyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, 
	kent.overstreet@linux.dev, hannes@cmpxchg.org, rientjes@google.com, 
	roman.gushchin@linux.dev, harry.yoo@oracle.com, shakeel.butt@linux.dev, 
	00107082@163.com, pyyjason@gmail.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 12:38=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 9/17/25 00:26, Suren Baghdasaryan wrote:
> > On Tue, Sep 16, 2025 at 9:52=E2=80=AFPM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >
> > Hmm. Missing a large allocation and not knowing about it can be a probl=
em...
> > I'll start sketching a patch to see if tracking such a global counter
> > has any drawbacks and in the meantime I'm open to suggestions on how
> > to expose it to the userspace.
>
> Could it be made to look like an actual tag in the output?
> e.g. lib/alloc_tag.c:1234 func:untracked_slab_objects

Technically I think we can do that but it feels a bit hacky... I'll
keep this option in mind and wait for more suggestions. Thanks
Vlastimil!

>
> (probably some better name conveying it's uknown due to failure to alloca=
te
> objexts)
>
> Maybe even implemented in a way that it's not a specially crafted output =
line.
>
> > About concerns on the IOCTL interface, would it be more usable if we
> > get the alloctop [1] or a similar tool which can be used to easily
> > issue such commands into kernel/tools?
> >
> > [1] https://android-review.git.corp.google.com/c/platform/system/memory=
/libmeminfo/+/3431860
> >
> >>
>

