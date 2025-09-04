Return-Path: <linux-kernel+bounces-801275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FCBB442EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A20C1890783
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D6D1D554;
	Thu,  4 Sep 2025 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye76iZPQ"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41826161302
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003815; cv=none; b=h60mi5Ye4ir7kGiDsSuPx8pn3m2NH8rgCdw3935/DnYeEuQAAdX6TCDFIfivUxBob6ZY6nIFjadoOrda27G6pV0H3ezkOW2GS6B7P1W4buJ+pkgJBpJC4cYHeUqYPj93LfNa/Rlm7sk48LhHUmKhEWhyJ9EQiAnQLcIk97y6aS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003815; c=relaxed/simple;
	bh=7904c62jqnr+Z9vpb9OeNuICRFS6lbka6nmTNqOdF0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUoaTQuK2ywtjiBT1MiCMB2Gt7kJ0h5ZwEQJSYTMBklM2w71l0RvwGm3NlOdrz2GVanPdgSLmmuaMTsVacn5AYjUXPajm31qwLdU0ShYMy+eUNkrJcoltE3mnFt4zU6mGrz9mE0Et+2/8jZP2pWrJ65IxoCP4THRhBw5hDD9lVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ye76iZPQ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61cb9e039d9so2156464a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757003813; x=1757608613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7904c62jqnr+Z9vpb9OeNuICRFS6lbka6nmTNqOdF0k=;
        b=Ye76iZPQmnif30gTNvizD8NlTxOA+LlejWyYP0lmtbeFcGrwfVFjorxPbpr2ny1QbF
         Kl9MgoB2R7JExmPGDnSy4LRdOtlbM20yK+20Ub2Ovh00JnBwUI+AHguFJkaH14l8KnRz
         mE4J38Kip1TKbgUQxjcTr+rWY8AC5jX1H+cqIO0oqrQhr48nauvYhaHSuS+4u+UMpYiU
         mv8258nP7zfwlALlwvp7sKanMJ/peytQtYsQWZw0nse9fuGI+uP6E2huxWRjx781WjIa
         lkt9eMTpjM0Is4QAUB52OYLRgY0tnCiO541qi/8P5oKYWuslhz8fhJiPzTTequHTeP9D
         K8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003813; x=1757608613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7904c62jqnr+Z9vpb9OeNuICRFS6lbka6nmTNqOdF0k=;
        b=PR24RfmpEO62+eX/gbIZMYHtI4COdzLraSr3ZWiHv3iD4WKoF1RNC+2akN9LNGUMAv
         kU9wzQ6v4vXwxQu+RzvUatXeOgYk/AWZfrFiDNJJgECBq0INwtzJgkR3UdnvWLd3GN/r
         bVh5UKX7KEVPR1ORCDeB46Yzt4Ryv1JU+qJwSjsZ5DpnjbI62jZtbkxxsgLehw1SlaGY
         bs/IIEFfnyOO+7luUqroISMQ788tnUbVedLH7tNeqnJRO4qkFeIyUF3EwbOQlfhhbWJ5
         vmUGXdl9a1q6Gg32CR1xGcnWJTyjUFYknV5GAn+sVDxqh5F3ZRkkT/nUNB5dfzifDoXI
         mS6g==
X-Forwarded-Encrypted: i=1; AJvYcCVUWv/MCECYGSZFXFIbqbOsLspuCgglVbTmN5J88jBMl5VIzdRQ2Y92Pa4dSYU5ygJeuG1/gCgrRikNKrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmRmVKqctmLMsuTHsLFw+yBK5LQZ3ZTIjNqqzATGMnlDgyR2Hh
	jy7IJsNULKb9ixykPsFUfSiEltnJNqtO3L3DgJGoL4SdHVeeKSC4R3oXdpRXetH1RhTVSEcZ1XB
	ovDpAv/AM7jXYNo6P8Syd8jPCaZzX16E=
X-Gm-Gg: ASbGnctYfLW4vL3IroaKQMndi8xN3EvSewWzbsSnH513p8ApbMvto4bE0GGkaKKYzA+
	b1Cz/z14EA12WnSYqJ6D+nEkb2OPvF0NffxPsIH18hETXHqLpApep5KPMKTMvq7P0IhLxEnTOEu
	l69PUCMBRJ6JczGdlWLwV27HaL0/mBU0lJVLw0NyTL9RCZhqjG71pWqY4oOOSahsryvBiTlJKpx
	L0TAQCkxQ6WzHeojb146Q==
X-Google-Smtp-Source: AGHT+IEA2UeIAkXr+e/tdWh3HGDsg++x/c5BndXwl04n0fDAlOHFSLcblpbp/pDol4/9hV6KP6nc7aCS9TcBGJams98=
X-Received: by 2002:a05:6402:504b:b0:618:aed3:38a with SMTP id
 4fb4d7f45d1cf-61d26ebbf9fmr16584771a12.31.1757003812505; Thu, 04 Sep 2025
 09:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <CACePvbWG85YJFpLDoFnz05tX2trUJFTzyuELMGYSYr5ye_hQ6w@mail.gmail.com>
In-Reply-To: <CACePvbWG85YJFpLDoFnz05tX2trUJFTzyuELMGYSYr5ye_hQ6w@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 5 Sep 2025 00:36:15 +0800
X-Gm-Features: Ac12FXxXIyA7Ak57QaP00eHzQFWcLDAWH7ZbkJmCacJCM3GF4SOIsmmFYuv5ftA
Message-ID: <CAMgjq7Bv99OHvbEiDcEMVYS5bRdSgSu75a8YUEQ+3roLiOo=ug@mail.gmail.com>
Subject: Re: [PATCH 0/9] mm, swap: introduce swap table as swap cache (phase I)
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 2:57=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Kairui,
>
> I give one pass of review on your series already. I Ack a portion of
> it. I expect some clarification or update on the rest.
>
> I especially want to double check the swap cache atomic set a range of
> swap entries to folio.
> I want to make sure this bug does not happen to swap table:
> https://lore.kernel.org/linux-mm/5bee194c-9cd3-47e7-919b-9f352441f855@ker=
nel.dk/
>
> I just double checked, the swap table should be fine in this regard.
> The bug is triggered by memory allocation failure in the middle of
> insert folio. Swap tables already populated the table when the swap
> entry is allocated and handed out to the caller. We don't do memory
> allocation when inserting folio into swap cache, which is a good
> thing. We should not have that bug.
>
> I also want some extra pair of eyes on those subtle behavior change
> patches, I expect you to split them out in the next version.
> I will need to go through the split out subtle patch one more time as
> well. This pass I only catch the behavior change, haven't got a chance
> to reason those behavior changes patches are indeed fine. If you can
> defer those split out patches, that will save me some time to reason
> them on the next round. Your call.

Thanks a lot for the review and raising concern about robustness of phase 1=
.

I just added more atomic runtime checks and ran another few days of
stress and performance tests. So far I don't think there is a race or
bug in the code, as I have been testing the longer series for months.
But with more checks, we are still a lot faster than before, and much
less error prone. So it seems very reasonable and acceptable to have
them as this is a quite important part, even for a long term.

That will surely help catch any potential new or historical issue.

V2 would have a few more patches splitted from old ones so it should
be cleaner. The code should be basically still the same though. Some
parts like the whole new infrastructure are really hard to split though
as they are supposed to work as a whole.

>
> Oh, I also want to write a design document for the swap table idea. I
> will send it your way to incorporate into your next version of the
> series.
>
> Thanks for the great work! I am very excited about this.

Later phases will also be exciting where we start to trim down the LOC
and long existing issues, with net gains :)

