Return-Path: <linux-kernel+bounces-843465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B795ABBF894
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5C324F2203
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29782620D2;
	Mon,  6 Oct 2025 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R//hCR17"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466FAA932
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 21:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759784561; cv=none; b=WoEZNth5D3cYr5LYe6cmhciHnfcGwEp4uKkclNk3DJQTOkUMoAfepgdgTFjNoL2NOA00iOamyMhqp/Vxk2wVGr8co7zuf0qgthbvPQ+U9qQo/BgnKa/TeGOnXbrcEzrUIZjwIIzgUPM1PR7X6xtmOU0jW35y1M/r22ln0olpBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759784561; c=relaxed/simple;
	bh=a39DmeoIaMZW5g67bSS2EstB1zkyQkv+c1el+UMRssU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9UeXLRoTjsJPAAE1laDmMerw8dsBFqLNmoyuVS/7DgwZHmdYiDmKUV62H2Pec3ekqemW/++L/28LD0hgc413bSoW+qTFSVJS5p2RHCEz2NTYWx2sllZ4yLAakGSIHVr4NXInPYRI00Ao5iMe/yb5qO1bk7ASRE2I4b2iVmS1qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R//hCR17; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759784558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ymk03Atrx/x0O99GjOXWpG6K/ZE8/FGkAGFxmtXS5cQ=;
	b=R//hCR17jCyF5uUKX2ZV0QWM29yK3vvIkrg4Q6Xnz6GCkwZYyijJ6d5MW0iOPvrCe4gqcq
	vzl/+QoDnQu1X2LcFoRfwuu48GPNvrhAOEc8G+FWwdK3eefQU1KwZ+vmsUjdDdJnYx87TK
	uYWkYc9mbz2q+Uax1jW8Sm/mbeARl5Q=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-8fcQkF7yNbSfCF6sFvkyag-1; Mon, 06 Oct 2025 17:02:36 -0400
X-MC-Unique: 8fcQkF7yNbSfCF6sFvkyag-1
X-Mimecast-MFC-AGG-ID: 8fcQkF7yNbSfCF6sFvkyag_1759784556
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-89018ea59e0so9436092241.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 14:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759784556; x=1760389356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ymk03Atrx/x0O99GjOXWpG6K/ZE8/FGkAGFxmtXS5cQ=;
        b=P4Y3AAI+BnmevXUvQVis5c8bQjIKNieNg6mW8KyeVSPtasx3Q9lsqLVxv1QcbXkrlS
         wjsOAjMjEXltAbQMU5yxwyQL7PcCf/yq3VjUFkN0XYp6PI3g8qJxUJEOI2lFkmQHm5qH
         ElxCn4A8k5baDimKtSs4x5dB4bNDxU5e/QRHjEUztS7eYLzIgqc1KqAufMD0wocPnd8W
         Jn04jYNgp/kNEhuR7fVxiNc52kUcXROPYgQYoBfRZMe82UmGMT4WhhT+FKFNkjrzkGbj
         1Iz3rkxFz+y0UU83jh5EyktwIGGZCD/+mZDuA0f7W5GFc9CLFuXIHyTuC4rK8i+UhF0d
         YkLw==
X-Forwarded-Encrypted: i=1; AJvYcCUAcES4Pv2AReWeOq/POwOEs3yDkOPtxUTkxJwbwuWqdxIelKT+Sb6Qle5CCa6fKXeQkW0TBATa9Mg1EkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgSD9m5H0KiCEwFbu/HGN7xfNIY68XysJHyaGkRSGIMTKrueyy
	OqGGrjugRgcBdaKfT7tMEspZWJcwZ6yqQ22Hanry4hHPD1E6SoyrW5oCepL/10ozJDUjOYPbbP+
	8EdhmHigL62sqb0yK+3/1vUgfESxyLwrVQFtosWktpY1oLKD9C27pDpBMbeL13R+kTQ==
X-Gm-Gg: ASbGnct3TRXE34wDsY8Ryc/wFnEzTvFfLd46UVuKQqQsv2Ez1c7YDa/mRxw0D2lV0/e
	kj9act1ux7gKaRCRMWD+cBA4OQKMkisiJJA5b9Jq3e8VZptZc6k+Ako3EY2JJeqnpBB48yMJjJr
	6o7YWYlH9dINu4/Ee7lwIy7LwduHO81qBH5FFrlrA0T089nqfX0haIHmwW5C7TRc4f7UmccvIVi
	y9aieUDuWPznpITej2PstQhiBOeGODwRoGIRutjCjOtSXaKhF0ClbQ5T7HXFGK0Vb7VEH2oPbnU
	hZ7i8OLzK9HVrDXQzDH9BIpNF9dlTvN57Em6fA==
X-Received: by 2002:a05:6102:32c4:b0:519:f3b6:a1ae with SMTP id ada2fe7eead31-5d41d113720mr5161974137.22.1759784555822;
        Mon, 06 Oct 2025 14:02:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUIbyFy0bAXxq3hF6obawCdsm67GU+uNu9K0VYS4VwETotxyroLK2fz6RCNecsQisNvYCK5g==
X-Received: by 2002:a05:6102:32c4:b0:519:f3b6:a1ae with SMTP id ada2fe7eead31-5d41d113720mr5161917137.22.1759784555258;
        Mon, 06 Oct 2025 14:02:35 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60146sm130567276d6.11.2025.10.06.14.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 14:02:34 -0700 (PDT)
Date: Mon, 6 Oct 2025 17:02:31 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Axel Rasmussen <axelrasmussen@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <aOQuZy_Hpu1yyu29@x1.local>
References: <20250926211650.525109-2-peterx@redhat.com>
 <f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com>
 <aNwmE11LirPtEuGW@x1.local>
 <f409cbe7-7865-45ab-af9a-6d5108bc5ad4@redhat.com>
 <aNw_GrZsql_M04T0@x1.local>
 <43d78ba7-8829-4a19-bdf3-d192a62cdac4@redhat.com>
 <aN08NxRLz7Wx0Qh4@x1.local>
 <ad124fb6-a712-4cf5-8a7e-2abacbc2e4be@redhat.com>
 <aN_XZbQjuYx-OnFr@x1.local>
 <cq3zcvnajs55zr7cplf5oxxjoh54fb7tvo23hehd5dmh4atvum@6274mneik6hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cq3zcvnajs55zr7cplf5oxxjoh54fb7tvo23hehd5dmh4atvum@6274mneik6hu>

On Mon, Oct 06, 2025 at 03:06:39PM -0400, Liam R. Howlett wrote:
> * Peter Xu <peterx@redhat.com> [251003 10:02]:
> > On Wed, Oct 01, 2025 at 04:39:50PM +0200, David Hildenbrand wrote:
> > > On 01.10.25 16:35, Peter Xu wrote:
> > > > On Wed, Oct 01, 2025 at 03:58:14PM +0200, David Hildenbrand wrote:
> > > > > > > > > I briefly wondered whether we could use actual UFFD_FEATURE_* here, but they
> > > > > > > > > are rather unsuited for this case here (e.g., different feature flags for
> > > > > > > > > hugetlb support/shmem support etc).
> 
> I think this supports the need for a code clean up before applying an
> API that generalizes it?
> 
> I would expect the uffd code that needs the same uffd_feature would
> logically have the same uffd flags for the uffd_ops, but that's not the
> case here?
> 
> Is this because uffd_feature != UFFD_FEATURE_* ... or are the internal
> UFFD_FEATURE_* not the same thing?
> 
> > > > > > > > > 
> > > > > > > > > But reading "uffd_ioctls" below, can't we derive the suitable vma flags from
> > > > > > > > > the supported ioctls?
> > > > > > > > > 
> > > > > > > > > _UFFDIO_COPY | _UFDIO_ZEROPAGE -> VM_UFFD_MISSING
> > > > > > > > > _UFFDIO_WRITEPROTECT -> VM_UFFD_WP
> > > > > > > > > _UFFDIO_CONTINUE -> VM_UFFD_MINOR
> > > > > > > > 
> > > > > > > > Yes we can deduce that, but it'll be unclear then when one stares at a
> > > > > > > > bunch of ioctls and cannot easily digest the modes the memory type
> > > > > > > > supports.  Here, the modes should be the most straightforward way to
> > > > > > > > describe the capability of a memory type.
> > > > > > > 
> > > > > > > I rather dislike the current split approach between vm-flags and ioctls.
> > > > > > > 
> > > > > > > I briefly thought about abstracting it for internal purposes further and
> > > > > > > just have some internal backend ("memory type") flags.
> > > > > > > 
> > > > > > > UFFD_BACKEND_FEAT_MISSING -> _UFFDIO_COPY and VM_UFFD_MISSING
> > > > > > > UFFD_BACKEND_FEAT_ZEROPAGE -> _UFDIO_ZEROPAGE
> > > > > > > UFFD_BACKEND_FEAT_WP -> _UFFDIO_WRITEPROTECT and VM_UFFD_WP
> > > > > > > UFFD_BACKEND_FEAT_MINOR -> _UFFDIO_CONTINUE and VM_UFFD_MINOR
> > > > > > > UFFD_BACKEND_FEAT_POISON -> _UFFDIO_POISON
> > > > > > 
> > > > > > This layer of mapping can be helpful to some, but maybe confusing to
> > > > > > others.. who is familiar with existing userfaultfd definitions.
> > > > > > 
> > > > > 
> > > > > Just wondering, is this confusing to you, and if so, which part?
> > > > > 
> > > > > To me it makes perfect sense and cleans up this API and not have to sets of
> > > > > flags that are somehow interlinked.
> > > > 
> > > > It adds the extra layer of mapping that will only be used in vm_uffd_ops
> > > > and the helper that will consume it.
> > > 
> > > Agreed, while making the API cleaner. I don't easily see what's confusing
> > > about that, though.
> > 
> > It will introduce another set of userfaultfd features, making it hard to
> > say what is the difference between the new set and UFFD_FEATURE_*.
> 
> If it's not using UFFD_FEATURE_ defines, then please don't use
> uffd_feature for it in the uffd_ops.  That seems like a recipe for
> confusion.
> 
> > 
> > > 
> > > I think it can be done with a handful of LOC and avoid having to use VM_
> > > flags in this API.
> > 
> > I waited for a few days, unfortunately we didn't get a second opinion.
> 
> Sorry, been pretty busy here.
> 
> If we can avoid the flags/features, then I'd rather that (the derived
> from uffd_ops == NULL for support).  We can always add something else
> later.
> 
> If we have to have a feature/flag setting, then please avoid using
> uffd_feature unless we use it with UFFD_FEATURE_ - which I think, we've
> ruled out?

Yes, there was no plan to use UFFD_FEATURE_* in vm_uffd_ops.  It's because
UFFD_FEATURE_* was introduced to almost let userapp have a way to probe the
capability of the kernel, rather than the layer to describe what features
userfaultfd has.

For example, we have UFFD_FEATURE_MISSING_SHMEM declaring that "the current
kernel supports MISSING mode userfaultfd on shmem".  This feature flag is
essentially of no use for any other memory types, hence not applicable to
vm_uffd_ops.  OTOH, we don't have a feature flag to represent "userfaultfd
MISSING mode".

Thanks,

-- 
Peter Xu


