Return-Path: <linux-kernel+bounces-823509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E084B86AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B80466083
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F005B2D7D2A;
	Thu, 18 Sep 2025 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYPJ/zd/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5312D4B44
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223964; cv=none; b=FQXVssl4HYQRqez/cH8IxMaPeX9A3GKkeq/h4XClTZnig+HLW8QQuEybqw7UHBKzkzFdVq/OTLVUh2dBeCtBlY7m2PVPVfSvY0T1Xm0BdU/04Q+AerxYId2VqGbAX+CCae4+SeUtHjKQKk5fwu12i/CuSKkuKVA7nOH91UiaMkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223964; c=relaxed/simple;
	bh=lcg0mne/0P4+Payj2CrtKmUHmNb002KoZxCKpx1PeIk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0EKoPCR5z4ooKLVmnvwGmRWus22mLbUHMkPjs5Dzvz1Az4sZAZbzgcwJOBcAk/KjdizHfCEo4sMRMFly4QhgyQYcY5OMJsAYjh2pX979Au5Mi1sBX+fYSpa/OyKMz5HlFWEfpgN0G5aeRw0EALHbSrHIwQLAuczXdAO+vqjjLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYPJ/zd/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758223961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FrxP5xNcG3tL5SGiDQEqP5O3t4o9iAHN60NtSVZIh5U=;
	b=gYPJ/zd/sYqm9xaK7xbKI8wyzSku6VcEeGB5E6cVtibv57ow15GgwD+VuulV1PqXF+e8+C
	UTlmfgY0ipbrpD9iMCOdQliGLNeugl06Ya746I9+eNjv8RwfaWcOhr5ha8NKf1R4yFWo5a
	FsoHNE9Z0+pvbrX1CrLnaaxKYmMeqIs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-VmxNMMp_PXyaZlGzXxqCiw-1; Thu, 18 Sep 2025 15:32:40 -0400
X-MC-Unique: VmxNMMp_PXyaZlGzXxqCiw-1
X-Mimecast-MFC-AGG-ID: VmxNMMp_PXyaZlGzXxqCiw_1758223960
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b60d5eca3aso32949721cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758223960; x=1758828760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrxP5xNcG3tL5SGiDQEqP5O3t4o9iAHN60NtSVZIh5U=;
        b=V7rTPyL321UOgno6zIqRdMgp/vqEfw2RFM5VUaWVqEkv7t2Yy2pSAWevvXslprup8Y
         enizeELUdq0yg6Nu0UYx76Su4CLrvtLp47nsxD0k4Icf+bu5zz7YS6j3R2cpBZzLghrG
         wyZ8fghlVRP+9ezE12dusPB3JUoPWRq5ryq7a9aGSZhWmO1zDrOwo4H6UnsEQg3HBeca
         LoVRMNiNeSoY70gJ9kpqH/SAEBwgeZfrugt3BPdhVejyUNSLlC9saV/nGg1/XhbJGezo
         DTOcghiO1i8D1ezmuqjY533IUBCthKVSPlwgwkwxipeVa+sxhvjreFCm4MKJr6u+JilX
         fYBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGJLraWBZHdOop+UUTR3y1W6zmoITiNwxVa/7atkAE0w86sky+O8bmm9G5l01ObL9Qb3PMixzmUooDq2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV3L4vr+URq20KyN0ASnbYHAuHfU7yfTIbFHX5GuX7eVnjwMG0
	u1dxNkOcInb6n7Yhi+fxc7+1UbdiFOTDXdvIu61MZ8N4SO7xNreicNpDMre8CjQwMNFeB2Q8GlL
	hFHTl/M17DVNId+O8ee6923//pwpyjaFDSkXH2P+te5lUMouB9uZ3IBxDIOQ+e7b1Mg==
X-Gm-Gg: ASbGnctHHt/8Foq/tG2ppFSuD+B5/3i/IokNSWTNnWUdCpkLFCgAdF2+LL0YFf4226s
	hSx4kv0hw2HKATuNQjtZCEmG4WHEpKGB3Z09EMf2Px3gNi0Gdmf3uZzE7bHC4+nzI7twwJ6wn7V
	FPaLv12Hx6FD4CTWQ75CRRCBaYWfO9M9Ez5Z8IKcxdBaxrP7mYMrmhOfMkcD8sq/xe17Fz3oaHX
	B9QbeOf8g1ZA9EFUWUN8FDElKRapfrlxPt3jIyL7eKlHM+O2QhLAklRL43osxoze8OujKi5aKx5
	fyI29GgDSNZRLGxqW+6n9oEnr/zUbFqsnCc37F5s6FhlNGp+Rl9RBM1mfpnkDV5ZNN93ZfOsaAW
	Xqf1aA5+HYNEZNgtBqrf1aA==
X-Received: by 2002:a05:622a:5793:b0:4b7:b44c:9fd4 with SMTP id d75a77b69052e-4c073d943efmr7226171cf.80.1758223959762;
        Thu, 18 Sep 2025 12:32:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvFx9YHg5jdY/lipm2LL0MJse3fnFRollEDEK2u/yHDAZ3diTQ/mHqSJpJks7YE+ILPdXElw==
X-Received: by 2002:a05:622a:5793:b0:4b7:b44c:9fd4 with SMTP id d75a77b69052e-4c073d943efmr7225721cf.80.1758223959270;
        Thu, 18 Sep 2025 12:32:39 -0700 (PDT)
Received: from x1.local (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda1fc418dsm17972111cf.12.2025.09.18.12.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 12:32:38 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:32:36 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <aMxeVMkwLdkChhYd@x1.local>
References: <aGfsaIIzHWfjcNFd@x1.local>
 <e7vr62s73dftijeveyg6lfgivctijz4qcar3teswjbuv6gog3k@4sbpuj35nbbh>
 <930d8830-3d5d-496d-80d8-b716ea6446bb@amazon.com>
 <jxekhkhbn7uk23oe24svxrs3vfuhseae57sqagndqgh2e7h33o@kfkygmrvjb5n>
 <aMp-kW3OLqtZs8sh@kernel.org>
 <du5pzxmfk6lile3ykpaloylwz4eni6disj2oe25eq6ipzqemiw@ybcouflfnlev>
 <aMvEu9m7fJLnj862@kernel.org>
 <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>
 <aMxJ3inEs_RRyqen@kernel.org>
 <2rkvuudmsf5tv66wya4f7m5niwnodu42owzmro5jzyc4fcep5n@lre7hir4qjli>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2rkvuudmsf5tv66wya4f7m5niwnodu42owzmro5jzyc4fcep5n@lre7hir4qjli>

On Thu, Sep 18, 2025 at 02:32:31PM -0400, Liam R. Howlett wrote:
> I believe the location of the code that handles the folio.  One would
> decouple the folio processing from the mm while the other would decouple
> which processing of the folio is done within the mm.
> 
> Does that make sense?

Not to me.

do_fault() allows allocation and some other things (e.g. trappable),
uffd_get_folio() doesn't. They're fundamentally exactly the same otherwise.

-- 
Peter Xu


