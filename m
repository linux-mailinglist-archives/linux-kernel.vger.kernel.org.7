Return-Path: <linux-kernel+bounces-841366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F30BB71B1
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01FB44ECD2A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5013D1F1306;
	Fri,  3 Oct 2025 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d990GyQ9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258DC134BD
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500142; cv=none; b=eOckxxyo3QOhn+wtXR7YgBrwkEDLPWQoGZH7dx6PH57eFd9OmTUR6ZyjJa+AizTk7cTenM/+GjTn8HeYISRd4IUf4HxnTJgXgnq18b5grrha8BRavD5xA5FwgMZq02gL3x0vkhrKIlEs/Ro9Sy15TnIYUi/YVEMmKrythx6W/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500142; c=relaxed/simple;
	bh=859GHIjZ0IVwATJeHr2R6KKk/lpoEHaK7W5BvgTfhFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBG4aOY+5e+p+hgn/Rg13QIT4ftzzlrXBZ6vdUOaxwxeYqQLhPVhIXb08y14I5swtBfLbWWhKocAMMlVKQQZvJNMan8kg/peIN49XPjwh6s7y3AdlOOktbD2Kb0InBbXdQr6sFw8VCjEYhNrOPAseKe/1f8gqWOyO9HJV3lJr/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d990GyQ9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759500140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FfdNLsJo1+niCnnKhS//GeejM6UpWhfStrR/oS1d2Yo=;
	b=d990GyQ9kwrT196VFyJ+XEA74648HTMfoeZj/tuoBD7guZzbd67KQYmDT8YO5+Dy2dc8x9
	/PQwxzwXa1K1JAyUsgrB/rH47pwWn0CWHrtH7JWg6GbI855cJ+CVRhKQFcA6Z7mQ/0C5Uw
	dBZk2gr9+lg6+6aPnXyjdRHQAHnZy6U=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-PPOdlXwWO2i9LnVimAqdqg-1; Fri, 03 Oct 2025 10:02:18 -0400
X-MC-Unique: PPOdlXwWO2i9LnVimAqdqg-1
X-Mimecast-MFC-AGG-ID: PPOdlXwWO2i9LnVimAqdqg_1759500137
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-43f7bca4787so674972b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 07:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759500137; x=1760104937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfdNLsJo1+niCnnKhS//GeejM6UpWhfStrR/oS1d2Yo=;
        b=QDUDPCo74KPDGkgKicfsUWsh5LdhiKHV3Nt8LVHcPcZfipWldcjW0BcZfQu4cZ/v2t
         xfAeobtwJyaIhUrwiqbLm5zJu88CJZWwxgIK9zLIg1lLReJHI+H3PY9kl7VysOqzYRZY
         iqU4aVd1QAq36xiUsKyfqN6S7dlqSi3l8VDPfcegDzgKWKL4wvjy1NSyl3fTd/1inqVW
         RQjN/6p8BWFcUUgd65nuSpQRE/DX4QRWHw+dkK2EFj7GxppfJnjBmIi9rR7FA0bvn4fL
         TVo518nXvpYbmNV26OlESCkPh2NcyS+/rZzhOynVfSGbVGXgEJWotPHtSh8bjCIvB3Ye
         MWjg==
X-Forwarded-Encrypted: i=1; AJvYcCW1Hf6UwotQuFMEhp5S8wsB6CDhNjeDG/GjlEqtU+Iw+vUwePsttAHc6uUzHnBTaVlbxTLUHXO/cQo1JDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza6uub38M+DnpIyskOR4XaQzKN4qzLtmYoE6DyzZRlkmS0Tgbk
	YiAZeru28Sj2DeoX3gbdKhSqtTqwSr57D6ph8FAO8e6JKRKI1ZbW6mnf3w6DOf1w8MnrhrWaiB9
	bWZIffXlQLan/0q0J7GaCJbC54+Yx0qb3603bjeyCjcc6QyuCUL6/IJu6SCIg8jcofg==
X-Gm-Gg: ASbGncvoaX3Edwnv0cWTcQZc+i/wn/kbcyZNd98/kq29MLf8ljzUv33UTPAznDgkYe2
	/u4YJcVgS341Dj6iTvU9Woawaf5ocaEowXjROFlfIANtXuSv10mCHFS4lCeQs/+ZysrJOy9Ufx7
	hzi7gSy4eYlZtFjcWIaYeWgJucMbNlgY5stNNb+DTuma9kbW9VIU8UzPjZ23cNx+16YvhE61Lkc
	28q/PwwFgJEhQKKBYmaPcniF8E949kAXX5thjO/ilGg/pBLv97MrA9JhOXEPZ7Le2SX8MbAPugu
	bpkg6JGldmjPMPIcv5blOmqhl7szY20G9CGw7A==
X-Received: by 2002:a05:6808:1784:b0:439:ae49:9159 with SMTP id 5614622812f47-43fc1828ba0mr1175497b6e.36.1759500136878;
        Fri, 03 Oct 2025 07:02:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEisDW2mGnc04qMiO0ty7y+ZeCROu3lxEpJKjD24LI/W2t/5ZFdYU4iCFfZ9dw1K+GrywtPBw==
X-Received: by 2002:a05:6808:1784:b0:439:ae49:9159 with SMTP id 5614622812f47-43fc1828ba0mr1175402b6e.36.1759500136107;
        Fri, 03 Oct 2025 07:02:16 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bd785963sm38628446d6.35.2025.10.03.07.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 07:02:15 -0700 (PDT)
Date: Fri, 3 Oct 2025 10:02:13 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Axel Rasmussen <axelrasmussen@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <aN_XZbQjuYx-OnFr@x1.local>
References: <20250926211650.525109-1-peterx@redhat.com>
 <20250926211650.525109-2-peterx@redhat.com>
 <f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com>
 <aNwmE11LirPtEuGW@x1.local>
 <f409cbe7-7865-45ab-af9a-6d5108bc5ad4@redhat.com>
 <aNw_GrZsql_M04T0@x1.local>
 <43d78ba7-8829-4a19-bdf3-d192a62cdac4@redhat.com>
 <aN08NxRLz7Wx0Qh4@x1.local>
 <ad124fb6-a712-4cf5-8a7e-2abacbc2e4be@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad124fb6-a712-4cf5-8a7e-2abacbc2e4be@redhat.com>

On Wed, Oct 01, 2025 at 04:39:50PM +0200, David Hildenbrand wrote:
> On 01.10.25 16:35, Peter Xu wrote:
> > On Wed, Oct 01, 2025 at 03:58:14PM +0200, David Hildenbrand wrote:
> > > > > > > I briefly wondered whether we could use actual UFFD_FEATURE_* here, but they
> > > > > > > are rather unsuited for this case here (e.g., different feature flags for
> > > > > > > hugetlb support/shmem support etc).
> > > > > > > 
> > > > > > > But reading "uffd_ioctls" below, can't we derive the suitable vma flags from
> > > > > > > the supported ioctls?
> > > > > > > 
> > > > > > > _UFFDIO_COPY | _UFDIO_ZEROPAGE -> VM_UFFD_MISSING
> > > > > > > _UFFDIO_WRITEPROTECT -> VM_UFFD_WP
> > > > > > > _UFFDIO_CONTINUE -> VM_UFFD_MINOR
> > > > > > 
> > > > > > Yes we can deduce that, but it'll be unclear then when one stares at a
> > > > > > bunch of ioctls and cannot easily digest the modes the memory type
> > > > > > supports.  Here, the modes should be the most straightforward way to
> > > > > > describe the capability of a memory type.
> > > > > 
> > > > > I rather dislike the current split approach between vm-flags and ioctls.
> > > > > 
> > > > > I briefly thought about abstracting it for internal purposes further and
> > > > > just have some internal backend ("memory type") flags.
> > > > > 
> > > > > UFFD_BACKEND_FEAT_MISSING -> _UFFDIO_COPY and VM_UFFD_MISSING
> > > > > UFFD_BACKEND_FEAT_ZEROPAGE -> _UFDIO_ZEROPAGE
> > > > > UFFD_BACKEND_FEAT_WP -> _UFFDIO_WRITEPROTECT and VM_UFFD_WP
> > > > > UFFD_BACKEND_FEAT_MINOR -> _UFFDIO_CONTINUE and VM_UFFD_MINOR
> > > > > UFFD_BACKEND_FEAT_POISON -> _UFFDIO_POISON
> > > > 
> > > > This layer of mapping can be helpful to some, but maybe confusing to
> > > > others.. who is familiar with existing userfaultfd definitions.
> > > > 
> > > 
> > > Just wondering, is this confusing to you, and if so, which part?
> > > 
> > > To me it makes perfect sense and cleans up this API and not have to sets of
> > > flags that are somehow interlinked.
> > 
> > It adds the extra layer of mapping that will only be used in vm_uffd_ops
> > and the helper that will consume it.
> 
> Agreed, while making the API cleaner. I don't easily see what's confusing
> about that, though.

It will introduce another set of userfaultfd features, making it hard to
say what is the difference between the new set and UFFD_FEATURE_*.

> 
> I think it can be done with a handful of LOC and avoid having to use VM_
> flags in this API.

I waited for a few days, unfortunately we didn't get a second opinion.

David, do you feel OK I repost with the rest comments (almost renames), and
if we want yet another new set of features for userfaultfd, we work it on
top?  It'll be a trivial one patch to do the mappings if we want.  The
current patch is also the minimum changeset we need to unblock guest-memfd
minor fault.

Thanks,

-- 
Peter Xu


