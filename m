Return-Path: <linux-kernel+bounces-751035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 908A3B1646B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178811888B75
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53FF2E1726;
	Wed, 30 Jul 2025 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kowalczyk-ws.20230601.gappssmtp.com header.i=@kowalczyk-ws.20230601.gappssmtp.com header.b="NeLKWtyn"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE62DECD6
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753891901; cv=none; b=T54e2Tds0wZ+4xdaRtQ54bmRQMii7/WczKtIKTKpOJNK5dVr91EiNrcWaU47PxOtqwgEyId+aRBY90ErHZnGWv3lV12URFiDbPEojn2tTSxtkUja0e0hG3NNpe6N8PfxvRQR3KMuYFfwqp2n+52Gs08Iw7DpNVmnH1YO9ehq0+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753891901; c=relaxed/simple;
	bh=Vmo9MPpzR3UA0aXhLoe6GzwAA9g82u5gZPhQFBCXDLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpVW0HgBFtmCqj4HPvzcLkKm1nWfG4Cs8xKr/Q3Glldg199gBGXwXkKDiIShdnMAF97u7Lw11HAgffUEEmUSOZLLM44SVZtZ6TSMjdNQT9snkCLsWlQAxPJ6mPtGMgj6byEiVd+qrmsQYia2XZbDfNaWRI6lE8XHT4XKbZ4hddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kowalczyk.ws; spf=pass smtp.mailfrom=kowalczyk.ws; dkim=pass (2048-bit key) header.d=kowalczyk-ws.20230601.gappssmtp.com header.i=@kowalczyk-ws.20230601.gappssmtp.com header.b=NeLKWtyn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kowalczyk.ws
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kowalczyk.ws
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61571192ba5so2861906a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kowalczyk-ws.20230601.gappssmtp.com; s=20230601; t=1753891897; x=1754496697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2b79vf5ak+e/xCZeuA0BNxm0tT114JbbliY/uAS1iI=;
        b=NeLKWtyntvIXM4S6WZZxILH2022aXq2Xn0FKWSdPsZh0+B7gtHdfKWEdqXnZGNmu/H
         37To894AhDqnzuZGuDvRFSrSYr/7ERUeGh/wmmRwWfpIc3PmDRzjbt4rPed8sX+Gp/dC
         MIl0x+OBsCDTEMKEFZwO5SGAbAlXaXoQ9anWIC++NXELHNw8X4vxQcUA6MZWr8N0Nzzi
         expzNNjsJIyusZc42ucY3ShkLXVkUrlN2abvSMF6aRPolPYiIufl5Xu9CF7YdZwqWo3x
         Gcx+ToCJElqm49/X5Amidh0j372wr6hEnt3XXnPNnYWb6bft62ALqHdLEWJ6NNvRJII/
         YDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753891897; x=1754496697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2b79vf5ak+e/xCZeuA0BNxm0tT114JbbliY/uAS1iI=;
        b=CBg5ZpuSTYRhYT721snLs3uMt+CcReaa3MQmNHY2ir1PDiHkwxecZM84oG5Y3omjat
         AUqqWKUV0FPxRdEgQ1QBtNlBKkJyes8hViKF4XTVWWaCoLOiyWC0+76nlXFah+fRT5eq
         lrxir2JB1qk5DBLuxUnJeTtbI8pUag8j8ZJoymDRCOD9dxqA0c9p99V0M8hdcMxORMNU
         JEbFFy3rkygAedN/QQInfeHGKC0A+Lcv/hDVdTFKj/eB7kKbqD84s8cPFE4EfDRLzZSo
         EHw1mBCzvgwegoABj/XSXaYfw2cvGVU23AuBfIE6NRZGIMpGrTQqaUbLhGWJfp1aX70t
         nElA==
X-Forwarded-Encrypted: i=1; AJvYcCVyWplf2iON0v1Uwg0idWuZHEUDYX4Lcls+yI9HhBJRy4vA2pfXF8iov66BLS4nz1+nfD5muINRtBdwuoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQjX9MEslHJjhh7oLGXeLXs/vZMmju0eldnVRCNsJjzVyFmhhr
	xDpiKwS8aTbefQe/X4Pdew/UZW/5WUuKMxk4aCheSrogrEaVLn8gtvR6Ip+Ea/BwA9e72tW1eYE
	rAMrOqvzRbQ2bdkteHtziQDc4104/97zXfvvvAuPN
X-Gm-Gg: ASbGnctwYxnMJDRUI2f/lF6zJkXnza1dMzG29ABjsWbXfz0HdPZrMEqWqGn84RXKWbT
	Jv8koWl0KUrHN7AKpAhPhztYu66M8VH56ci2wSQY9S8DBmA17ZanIrbdrLPV7lDHnlgpdRvgSSx
	6hhGNGW7d50ROKJ8As7+r4Lb7jh7/bJkEcBY3LoMLn3HmIl7aZ6hnJSMw+Gqh1aFsFLTH7Gov+r
	SZX
X-Google-Smtp-Source: AGHT+IF0RbHZTmyeGEceTHCSVk3sXAK7Fvg37ayxPFDsP6BZA0CVmeBroxYKzVp8m2JfRHhouMt2MBxOgQuv6Q7rqjU=
X-Received: by 2002:a05:6402:2553:b0:615:8f13:6324 with SMTP id
 4fb4d7f45d1cf-6158f1367d8mr2751996a12.1.1753891896854; Wed, 30 Jul 2025
 09:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0d734549d5ed073c80b11601da3abdd5223e1889.1753689802.git.baolin.wang@linux.alibaba.com>
 <ff93c415-7ce8-a331-9568-7543c6a37992@google.com> <817c59dd-ad54-47f1-ac16-9cb9583308d1@linux.alibaba.com>
In-Reply-To: <817c59dd-ad54-47f1-ac16-9cb9583308d1@linux.alibaba.com>
From: Patryk Kowalczyk <patryk@kowalczyk.ws>
Date: Wed, 30 Jul 2025 18:11:25 +0200
X-Gm-Features: Ac12FXy5SspHtr8bWKbmfyjbAMrdH8laeeJCxAogBGa40D3TbRxRNcwy2_YhjZ8
Message-ID: <CAJCW39LLyJjOyMNreiVd+SjS3dKSXwvT6kVz-sf8y9YpsU1dTg@mail.gmail.com>
Subject: Re: [PATCH] mm: shmem: fix the shmem large folio allocation for the
 i915 driver
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org, 
	ville.syrjala@linux.intel.com, david@redhat.com, willy@infradead.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, jani.nikula@linux.intel.com, 
	joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, tursulin@ursulin.net, 
	christian.koenig@amd.com, ray.huang@amd.com, matthew.auld@intel.com, 
	matthew.brost@intel.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
This patch solves the performance issue very well.
best regards,
Patryk

=C5=9Br., 30 lip 2025 o 09:46 Baolin Wang <baolin.wang@linux.alibaba.com> n=
apisa=C5=82(a):
>
>
>
> On 2025/7/30 14:54, Hugh Dickins wrote:
> > On Mon, 28 Jul 2025, Baolin Wang wrote:
> >
> >> After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmp=
fs"),
> >> we extend the 'huge=3D' option to allow any sized large folios for tmp=
fs,
> >> which means tmpfs will allow getting a highest order hint based on the=
 size
> >> of write() and fallocate() paths, and then will try each allowable lar=
ge order.
> >>
> >> However, when the i915 driver allocates shmem memory, it doesn't provi=
de hint
> >> information about the size of the large folio to be allocated, resulti=
ng in
> >> the inability to allocate PMD-sized shmem, which in turn affects GPU p=
erformance.
> >>
> >> To fix this issue, add the 'end' information for shmem_read_folio_gfp(=
)  to help
> >> allocate PMD-sized large folios. Additionally, use the maximum allocat=
ion chunk
> >> (via mapping_max_folio_size()) to determine the size of the large foli=
os to
> >> allocate in the i915 driver.
> >>
> >> Fixes: acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
> >> Reported-by: Patryk Kowalczyk <patryk@kowalczyk.ws>
> >> Reported-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> >> Tested-by: Patryk Kowalczyk <patryk@kowalczyk.ws>
> >> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> ---
> >>   drivers/gpu/drm/drm_gem.c                 | 2 +-
> >>   drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 7 ++++++-
> >>   drivers/gpu/drm/ttm/ttm_backup.c          | 2 +-
> >>   include/linux/shmem_fs.h                  | 4 ++--
> >>   mm/shmem.c                                | 7 ++++---
> >>   5 files changed, 14 insertions(+), 8 deletions(-)
> >
> > I know I said "I shall not object to a temporary workaround to suit the
> > i915 driver", but really, I have to question this patch.  Why should an=
y
> > change be required at the drivers/gpu/drm end?
> >
> > And in drivers/gpu/drm/{i915,v3d} I find they are using huge=3Dwithin_s=
ize:
> > I had been complaining about the userspace regression in huge=3Dalways,
> > and thought it had been changed to behave like huge=3Dwithin_size,
> > but apparently huge=3Dwithin_size has itself regressed too.
>
> I'm preparing a RFC patch to discuss this.
>
> > Please explain why the below is not a better patch for i915 and v3d
> > (but still a temporary workaround, because the root of the within_size
> > regression must lie deeper, in the handling of write_end versus i_size)=
.
>
> OK. This looks good to me. Patryk, could you try Hugh's simple patch?
> Thanks.
>
> > ---
> >   mm/shmem.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 3a5a65b1f41a..c67dfc17a819 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -5928,8 +5928,8 @@ struct folio *shmem_read_folio_gfp(struct address=
_space *mapping,
> >       struct folio *folio;
> >       int error;
> >
> > -     error =3D shmem_get_folio_gfp(inode, index, 0, &folio, SGP_CACHE,
> > -                                 gfp, NULL, NULL);
> > +     error =3D shmem_get_folio_gfp(inode, index, i_size_read(inode),
> > +                                 &folio, SGP_CACHE, gfp, NULL, NULL);
> >       if (error)
> >               return ERR_PTR(error);
> >
>

