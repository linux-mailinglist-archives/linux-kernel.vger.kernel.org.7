Return-Path: <linux-kernel+bounces-783853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E82DB33382
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D914D16F8DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 01:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F222066CE;
	Mon, 25 Aug 2025 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="anNkY9sH"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD68834
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756085173; cv=none; b=oMMzrYljI7MQH5Cb1csUau3jSUN3n9kbYEuZ5HcDDVXFX7SAxiT9Da2PkZ6Aj3oRrgIJnM7uF5Z97qW03Kn64f0/zJUfjyhbE2l3x0x+nrbppDCOXqcGfW4nTn609ftVI2cAQ4HhdGX7R/Nt4P8l+vy+VXgN827rTYlC+8hMwHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756085173; c=relaxed/simple;
	bh=ldXgaE0ONhb86qsJsXi0FtxoH3OcIHXXwSV+lGOse+s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WUDkDVMW7naypxX5b+vSdiKh9H8nL9ptDcNUeujudQ6Y7UUlb45WcCipOTK3obM1vy313yk8Ljr9L6LRzS4NIFGNC9q50jkt+xL/UhkoNHjUNT14PirGkvnK2D8WGDqCBP/WsbwXRS1OKwpL+45jCsYsnKbGCb5yC6eaXkPasIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=anNkY9sH; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d603b674aso27091777b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 18:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756085171; x=1756689971; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b3aLhKf+1bQX6jPVz/mhVq6QH+09EMxI761Jrd6xObQ=;
        b=anNkY9sHVFceGCAJJaeJasyXMPuXM62FauyraORENpwUusLHF8BbXmKU3Pc6tMhGr0
         nz4XszGXKrhQfu/YjSu7qFU/COYUh7Mmo6/+CEf9v6abnn60KE8DTHA07J6YQrjbo+ZU
         uG6hNpm/Fg6g0Na1+vZxsRXWxEgZ3fN6kMe2te/Lvv/4I5DGqQUM4/ktTHVyD90oX8J/
         nRqHXG8HmG031qGZAglpO6KjjFpQM6qBi2IwbXaHT1TU8utkBYtbL7KEGKOKVTBjbUmm
         6brMCinIsUSasP2AtY418JLl3VS9QjKG1a7A55Lq4SAQheN5KvZq61jOukvp/M7ymE4V
         Y1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756085171; x=1756689971;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3aLhKf+1bQX6jPVz/mhVq6QH+09EMxI761Jrd6xObQ=;
        b=odvtF9/g5FzamGir4YlGX5lGcBBawsRxa/KZ/Bm02WNrcoI/q/NF9in6XImfilVh+W
         cje/HYPoSmOsY81ONPNwd3x9gFHPQzsRRthGIvGd7YPR5SNBWXxgNQ9bJI3FHx6VhHCm
         s3y2Xmk6Tp6iwlTRtK01NAdnj6qt6O9iFjX46EEO5hmRBrG/BCP5uijOoOsbF5gNdEId
         UYBtqH6c3/zdPSEtWAKDSIWufmZmhQ4KtsnNtu7Tt37Nsza/WW+ppuZUbhNrHmmnimCm
         xuNOkOxa6n052E8sld7grMKVSG9IrMZ/bQpxZdgGDMvAbJ+SatYZaRKCvqH2dVSBvqya
         qvEg==
X-Forwarded-Encrypted: i=1; AJvYcCWHi04oS6YaYXzfO8k4214GwLiiElOVZXlp/mmgE+xQlMgIx2zxMz7hovL7UbydsxEEH3UMTyqGF5/mek4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOO2cUiUg/5FtBySI3s+1ySYy7h4Ik0DsKPUg0VmDEgzLZujX9
	lDd0pUOTUknOyVGVSMnaoBXif//UbbyIo6UnedTqS3GxXEMlhGkrWIBYUS8aHnTKOw==
X-Gm-Gg: ASbGncv50MpyUDIfl30tUpK54hBl9GWPQFu4qtjyj2YrVPXQEKpTEwSrabFGM87+3I3
	QAF70SpMWrVZRS5gJgUQuRaFzJIMOJkS970Ax486zCiXuJov76aBIEF/fXLgPELmJRQGIHJqGQx
	VU14/ipR26+8LKmqZEEfBjIFVjEv6cIHpNZOEUyh6ytbNw3HsG2GJ2wM4zNBj7blHxL6jRmuWQt
	soY0gFme/I0OcIskq1zjFRkFV1bmC0v4p9iqZ0FWVu+kJAY0zghf0kb9kwsKDDTXl/0YZMSNLnQ
	fafLWrqU6PTLdT+gjsGG/ZWVnrZ52i35JHgKorTaLVyVn5mvyAOTWRSIDshEi3vMW5qygqObtcn
	uS/9f1kSsdK9oHgZdToFPGS6or+xO99K9KV1pQgiu2ig+L35XGEXZ0iRcX0kg48Wwwd6+BPthB/
	ElhMj8I79zGHcxCQ==
X-Google-Smtp-Source: AGHT+IESXET44sa1Didt3BQ6M8/RKA8XAwX3ohwCFfZmIhEtpdeEqGT4wCJzBu0c72swRla11eCTgA==
X-Received: by 2002:a05:690c:94:b0:71a:2093:3558 with SMTP id 00721157ae682-71fdc2abbd8mr130068847b3.10.1756085170475;
        Sun, 24 Aug 2025 18:26:10 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff1881f12sm14366797b3.38.2025.08.24.18.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 18:26:09 -0700 (PDT)
Date: Sun, 24 Aug 2025 18:25:14 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Will Deacon <will@kernel.org>, David Hildenbrand <david@redhat.com>
cc: Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
    Frederick Mayle <fmayle@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
    Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>, 
    Ge Yang <yangge1116@126.com>
Subject: Re: [PATCH] mm/gup: Drain batched mlock folio processing before
 attempting migration
In-Reply-To: <aKM5S4oQYmRIbT3j@willie-the-truck>
Message-ID: <9e7d31b9-1eaf-4599-ce42-b80c0c4bb25d@google.com>
References: <20250815101858.24352-1-will@kernel.org> <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com> <aKMrOHYbTtDhOP6O@willie-the-truck> <aKM5S4oQYmRIbT3j@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 18 Aug 2025, Will Deacon wrote:
> On Mon, Aug 18, 2025 at 02:31:42PM +0100, Will Deacon wrote:
> > On Fri, Aug 15, 2025 at 09:14:48PM -0700, Hugh Dickins wrote:
> > > I think replace the folio_test_mlocked(folio) part of it by
> > > (folio_test_mlocked(folio) && !folio_test_unevictable(folio)).
> > > That should reduce the extra calls to a much more reasonable
> > > number, while still solving your issue.
> > 
> > Alas, I fear that the folio may be unevictable by this point (which
> > seems to coincide with the readahead fault adding it to the LRU above)
> > but I can try it out.
> 
> I gave this a spin but I still see failures with this change.

Many thanks, Will, for the precisely relevant traces (in which,
by the way, mapcount=0 really means _mapcount=0 hence mapcount=1).

Yes, those do indeed illustrate a case which my suggested
(folio_test_mlocked(folio) && !folio_test_unevictable(folio))
failed to cover.  Very helpful to have an example of that.

And many thanks, David, for your reminder of commit 33dfe9204f29
("mm/gup: clear the LRU flag of a page before adding to LRU batch").

Yes, I strongly agree with your suggestion that the mlock batch
be brought into line with its change to the ordinary LRU batches,
and agree that doing so will be likely to solve Will's issue
(and similar cases elsewhere, without needing to modify them).

Now I just have to cool my head and get back down into those
mlock batches.  I am fearful that making a change there to suit
this case will turn out later to break another case (and I just
won't have time to redevelop as thorough a grasp of the races as
I had back then).  But if we're lucky, applying that "one batch
at a time" rule will actually make it all more comprehensible.

(I so wish we had spare room in struct page to keep the address
of that one batch entry, or the CPU to which that one batch
belongs: then, although that wouldn't eliminate all uses of
lru_add_drain_all(), it would allow us to efficiently extract
a target page from its LRU batch without a remote drain.)

I have not yet begun to write such a patch, and I'm not yet sure
that it's even feasible: this mail sent to get the polite thank
yous out of my mind, to help clear it for getting down to work.

Hugh

