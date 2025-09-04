Return-Path: <linux-kernel+bounces-801423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D390B444D6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EACCF1CC2770
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7139D31A571;
	Thu,  4 Sep 2025 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ecf27iA"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CA43128CC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008286; cv=none; b=C9uz9XKfO/RZBxBN3SLxXEBrmSG1srtWcHtKrspl37KLWqjh4ugLb00uORyIG8M6u9t4mvVYa2jmUiprBnqKp2sctcO5lzUWVDg4qwNXrS+3l1pkPOllppZHjxrbUVKtLI+HwpS4tTtUDVPIU6jjymtLZRCmyKZzY4whcDuSwFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008286; c=relaxed/simple;
	bh=zL0BQBLVSP12qsO8N9fp3GBVIxlwd1bonh505oq0ysk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsQMO3fGwIN13qP8X7r2k92zwchAz919irIExZszGOjoguYnIVYcaYkPNzlL66uf3JsX/K8FMHFNCHem2wESttVXeoYFZzBa23z+vA8wKrOtXPRzY7vnpjUv90QvBat+OTkD0iQTL48Nfy6W/lfK7G3LiyjLzq9ziUS9+SyGdpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ecf27iA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24cca557085so16105ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 10:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757008284; x=1757613084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5f4CV7/Zq9AHWfcQkbq4wqzY80LXaCxVRDw6EMIrtQ=;
        b=0ecf27iAs2jcqVgXqGbioyuQnYgawdsNvgZpWchlSV4IZ6/V8ITAk8PDwsD2up5BrK
         lXX+q0WKwLEIOqMy5nJe5aW+cvScB1HevKbUVdgcdl3SOluauhTjcT0g1iCHZwzCPxjw
         q5xfV0FH7qPRh4byiTbHMlPPBpraqiFixNFpvOqa6ZzZVzlSIMx7EICIMelOiix5tH9z
         nGI1oZEfS+iCSAYi9OvSeIbHduc8GqnPjiZ59ZCr0m9SJxy5gm5OBPdZ8VfGvO2Wa3Ue
         dTH/q1rKgDbI1eLVIqbvxnF3gsuf4Kne9RvPTrVlg5tsUK+40xseSHAfDFMLrKAPE61l
         3anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757008284; x=1757613084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5f4CV7/Zq9AHWfcQkbq4wqzY80LXaCxVRDw6EMIrtQ=;
        b=nX8i2DwS0nb7J3QXLEMXSSlWoLLo+E1uLnHN9aAGKeWDfhS3H6rEu95iZWSDwMfogD
         0DbWGEkP8RA7XOHs1KSv+BZAOsDSrDpZz66innPj5MFfMbCSfeAXBqcUmVhn/yMOTvGD
         msibmJUeJySZB+bp55nPyiJRMy3Cg7XQKTgtG/2g/zOSScseRG/OairIh4vehmyyCqY0
         P8x9ECBO3s109dTxw3WIvEKi1S0q19ErRZ50XPgDWCuSQXqJN9eDQyc7acqxRBbPxkpo
         fEYE0667WSjDlmKR0KDleV2zIpiju4G5L3CFTmv0ceKtkSAB5dnhd/mwOhX22ZgiygHC
         zQGw==
X-Forwarded-Encrypted: i=1; AJvYcCX2cMoJDaJ+kaU+ECvm/uoBIPq2ZG5mSkl/mdOWNGZLi+GWsTrBc16jxoR/lzyj1cPjWllLI0mgTYzGxvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1UOc7+QpPVHfXWp2xfcJHplOXHY2YAZM43U5zGx0tph1zZQfF
	zW6zhTSo1pT01YJmzClsKJxzYjaUPXhL6u9JJQpjPhQ5+FGxCyubnA6nNufCVICjBE08CaHi/c2
	JkEOv4m/hH2iTDIVkVUF5S3xUOqf5grLfEvywKCh7
X-Gm-Gg: ASbGnctlElTkPt5m5eBzeU6Xb6Jdbp0uJ/qZhx2QlGL4fSNhiH2uCy2z932ZAra4Apf
	GMQ4LwMhy7jwPT4TijRN0WwcP1g6TAl6wiwdDHyRo82e9Yg69zH52mAzGFGTeF4b0nvmuKpMuTN
	toSSZ9lJAQYHgfOIT+YhUN4Bsu9OdvOgKueF/RpSuu2M2hA8+9Iy7oEpk/herPCudcWckCyD+5X
	Joyh+qBQeZfHD0YojopCrOa4iziAZYzZ/DFY/18yHcxM+HCc7lwFvA=
X-Google-Smtp-Source: AGHT+IE/3b8sPJKpYGeK7oU85pQOncW+STxSebtEdgTCPGH/HESFfdjgboseK2XGkBZX91Fw4LOcIAmv4JXkuThCDGs=
X-Received: by 2002:a17:903:283:b0:240:5c75:4d29 with SMTP id
 d9443c01a7336-24cf5994170mr241895ad.0.1757008284007; Thu, 04 Sep 2025
 10:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903232437.1454293-1-kaleshsingh@google.com>
 <827c844f-7106-4f62-a108-1f83544aa56e@lucifer.local> <43ryds7hzhs5bpaxznco7fppmakdb4f46agwtsc5erudqfoz2x@7y4jgbtft7jj>
 <413ee338-1795-433c-b3d4-72c870488d95@lucifer.local> <84aad392-3bff-4f98-b612-5e9a046edb36@redhat.com>
In-Reply-To: <84aad392-3bff-4f98-b612-5e9a046edb36@redhat.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Thu, 4 Sep 2025 10:51:12 -0700
X-Gm-Features: Ac12FXyT6XQaoSAVRSJwX4zOcb1nmPXZsqOrxsSrYiMr1nQbN0UJKDP2mFJkfEk
Message-ID: <CAC_TJvc=5=iS8gCumJWqH5eF4XufFSogqtWHJmiH5WBN1A6gng@mail.gmail.com>
Subject: Re: [PATCH] mm: centralize and fix max map count limit checking
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	akpm@linux-foundation.org, minchan@kernel.org, kernel-team@android.com, 
	android-mm@google.com, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 10:42=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 04.09.25 19:33, Lorenzo Stoakes wrote:
> > On Thu, Sep 04, 2025 at 01:22:51PM -0400, Liam R. Howlett wrote:
> >>>> diff --git a/mm/mremap.c b/mm/mremap.c
> >>>> index e618a706aff5..793fad58302c 100644
> >>>> --- a/mm/mremap.c
> >>>> +++ b/mm/mremap.c
> >>>> @@ -1040,7 +1040,7 @@ static unsigned long prep_move_vma(struct vma_=
remap_struct *vrm)
> >>>>     * We'd prefer to avoid failure later on in do_munmap:
> >>>>     * which may split one vma into three before unmapping.
> >>>>     */
> >>>> -  if (current->mm->map_count >=3D sysctl_max_map_count - 3)
> >>>> +  if (exceeds_max_map_count(current->mm, 4))
> >>>>            return -ENOMEM;
> >>>
> >>> In my version this would be:
> >>>
> >>>     if (map_count_capacity(current->mm) < 4)
> >>>             return -ENOMEM;
> >>>
> >>
> >> Someone could write map_count_capacity(current->mm) <=3D 4 and reintro=
duce
> >> what this is trying to solve.  And with the way it is written in this
> >> patch, someone could pass in the wrong number.
> >
> > Right, but I think 'capacity' is pretty clear here, if the caller does =
something
> > silly then that's on them...
> >
> >>
> >> I'm not sure this is worth doing.  There are places we allow the count
> >> to go higher.
> >
> > ...But yeah, it's kinda borderline as to how useful this is.
> >
> > I _do_ however like the 'put map count in one place statically' rather =
than
> > having a global, so a minimal version of this could be to just have a h=
elper
> > function that gets the sysctl_max_map_count, e.g.:
> >
> > if (current->mm->mmap_count >=3D max_map_count() - 3)
>
> I enjoy seeing sysctl_max_map_count hidden. But map_count_capacity() is
> even more readable, so I like it.
>
> I don't complete like the "capacity" term, but I cannot think of
> something better right now. Maybe something around "free" or
> "remaining", not sure.
>
> I also don't completely like "map_count" (I know, I know, we call it
> like that in structures), because it reminds me of the mapcount ...
> talking somehow about "vmas" would be quite clear.

Thanks David, my original implementation started with vma_limit() :).
Maybe something like vma_count_remaining() ?

-- Kalesh
>
> Anyhow, just as an inspiration my 2 cents ...
>
> --
> Cheers
>
> David / dhildenb
>

