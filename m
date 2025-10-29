Return-Path: <linux-kernel+bounces-875573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8411C19583
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CCAE5028D1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A944320A31;
	Wed, 29 Oct 2025 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9fxux5x"
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6116F31E115
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761729174; cv=none; b=XikY6/ohixIV/HahLBAp9CLCNhe0Q263D6/NsNbK9wuDoRaEGhHpKdGpQHwKo/RyUx93wRU/BcF5gO8pfKEAOO0KpjkxiNqpW7KtzsovTCB7V8oNr+8NFuLPr1/50IdlejtJfW4whEor1rHUg9WciWeCJT/P32ShIexqGuq3jBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761729174; c=relaxed/simple;
	bh=krm2oZWHXNyj2OY+480XxIMsziVCbnpUlmwLuLmd8oo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W6dGsn4TgoaoMh+nWC2Iu9BRcu6PAzxa8t/4UfTfNorAT4WDlQI7xJJj4th/A6+3/golKWBsdXkjr2Bl9JCe391Kb5vyidTpSgVE9PQuR/3PRViL9xNKr6JP4HwwIgspEnzHizMCxYlZpPWacTJ/1W+TUd3r7zZYPJhFm2Rmdrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9fxux5x; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63e255e9a20so7573358d50.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761729172; x=1762333972; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BBqHz8cFPV9OUQwbjare8Pel7U5XHqHAeYtuall28CQ=;
        b=s9fxux5xToO1bCeLUpuISSCurSMgPO2RGN/AEZghDTZsuKHjzlebAInKnXS1ejB6AD
         Ho9stdAb5AnLmJlVlrdjUomZ8XqQtfP1evsGC3o9Ux6JWh0PWXPfBUyqX8PmvSI0U73K
         EiunpJooJaHg69dVaTB3oNN0nkzlc7m1YWgGdVdMEABR8itBHWTQvIhdg5EdURgIzYbc
         rxJKUtUiswTTpJU309W+A4qiPhpVsrSAr6hf5Dfec1F/PMwn/gZe2GsXexrIJpMy7HzO
         8RBvD3DwYME7i3PeKI3rTmkzHibTLdvOreYDIUJ3Xiq1B/9VHD9qeIR/5Y3O0xT4E6QG
         MUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761729172; x=1762333972;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBqHz8cFPV9OUQwbjare8Pel7U5XHqHAeYtuall28CQ=;
        b=lRcBv6knVw1gJc9TfdZuPFyWqiwpYzweczlVlDRQVM3NcA2CzEg+kSloE6Gi1JKSLV
         bDCkva6oJiMy9zxvqeUqaLxDZCOOSX6RH3z7QU3J1nWhHnU51gM3oDYo758ippcT09r3
         T304sBQELLH8+u8Tt9T0xSTC7fInAuJ8fvt2EwZAB8BZUZxE4kKwMOo608fCRgMM7Klz
         sjLWDFh/OXo9kHLaeGrK6DJ+vYm1k6ilcd+yuE6/vemAnBe0AxctL/0hyJOdEDVx/H9y
         Oxk5Az+ZtQaUG9XkDeIq8CizsNDCXWcPeCnq2exHohocrWWhLjSWIr9IaqZlo9/gVZwG
         5Tsg==
X-Forwarded-Encrypted: i=1; AJvYcCUS/qaQ4HpRpwHtEDgMaAlkz4UPHclgiJRlKiVpmpRLIvyjSGROdvlwTSAcPHO5D9tQ4isYD2d/dcCxY6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWtTeIrga8qntWqRXGO/C4ib29/ZWs+CT2RH6s0EMQij3ALFCR
	+t+GsW5W7DIvU5gF3G5bMsAfNWXWOJawCxfNI6mcXmCC4uwf94bNgAFkw1juKYHl/2Dx8mWT/b1
	nx/lANw==
X-Gm-Gg: ASbGncsWqtU7eTdeBXoRDH/d4UWk95aXEQpYr8Oepea57UPtQp8SQJioQ+0Q+sL6/q8
	RenVsVKNOCMDlbbJU8wlI4nRYwW9gyeGg2+8HnyZrESwSf8Y/Vkwj2YvpY2ARbz2eBWEfI6vN7M
	ro4N3zCsn37OJi/Ry2Mt+cibQE8SRcRoPuRQlfev27aOVU7CJq9EVFdcpA1P+suINGNWuZpYVBC
	q4La576nFi0XvbhLTs3JfWl93WyFgf69jTHW06zFJWTvVLrCZAqd6sPCZjvDa3RGuAAITkOgohd
	vFNpydZB4mLg6o8lrVbLigs9J/W+4qQPb/RdsvYlXAFATLx73sloE15wLbpnV343JKsvYtKJq6w
	Gm/zHCC/D1PB55VLSvi/OZms/t72hBadQSNBfQWVfi9tLSI6lUprhMTSwAEvMecID1BVtkItlcT
	TOqZNd67WyxqOyjP7G8clBp15sIE73zU5GNiR0n1uTEsRwfhW6sqNcV7pUAz4x
X-Google-Smtp-Source: AGHT+IEUyMs7bw/KHzPZ51AbmO3wPAApjy9icdxMigxwWyr9bCi7kzw4YLn0xUhUa4b2Nc69MgGvKQ==
X-Received: by 2002:a53:cdcc:0:b0:63e:187b:f383 with SMTP id 956f58d0204a3-63f76dced0dmr1569801d50.52.1761729172087;
        Wed, 29 Oct 2025 02:12:52 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed198ef9sm34560117b3.24.2025.10.29.02.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 02:12:51 -0700 (PDT)
Date: Wed, 29 Oct 2025 02:12:48 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
    Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
    Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
    linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/2] mm/truncate: Unmap large folio on split failure
In-Reply-To: <qte6322kbhn3xydiukyitgn73lbepaqlhqq43mdwhyycgdeuho@5b6wty5mcclt>
Message-ID: <eaa8023f-f3e1-239d-a020-52f50df873e7@google.com>
References: <20251023093251.54146-1-kirill@shutemov.name> <20251023093251.54146-3-kirill@shutemov.name> <9c7ae4c5-cc63-f11f-c5b0-5d539df153e1@google.com> <qte6322kbhn3xydiukyitgn73lbepaqlhqq43mdwhyycgdeuho@5b6wty5mcclt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 27 Oct 2025, Kiryl Shutsemau wrote:
> On Mon, Oct 27, 2025 at 03:10:29AM -0700, Hugh Dickins wrote:
...
> 
> > Aside from shmem/tmpfs, it does seem to me that this patch is
> > doing more work than it needs to (but how many lines of source
> > do we want to add to avoid doing work in the failed split case?):
> > 
> > The intent is to enable SIGBUS beyond EOF: but the changes are
> > being applied unnecessarily to hole-punch in addition to truncation.
> 
> I am not sure much it should apply to hole-punch. Filesystem folks talk
> about writing to a folio beyond round_up(i_size, PAGE_SIZE) being
> problematic for correctness. I have no clue if the same applies to
> writing to hole-punched parts of the folio.
> 
> Dave, any comments?
> 
> Hm. But if it is problematic it has be caught on fault. We don't do
> this. It will be silently mapped.

There are strict rules about what happens beyond i_size, hence this
patch.  But hole-punch has no persistent "i_size" to define it, and
silently remapping in a fresh zeroed page is the correct behaviour.

So the patch is making more work than is needed for hole-punch.

But I am thinking there of the view from above, from userspace.
If I think of the view from below, from the filesystem, then I'm
not at all sure how a filesystem is expected to deal with a failed
folio_split - and that goes beyond this patch, and therefore I
don't think it should concern you in this patch.

If a filesystem is asked to punch a hole, but mm cannot split the
folio which covers that hole, then page cache and filesystem are
left out of synch?  And if filesystem thinks one block has been
freed, and it's the last block in that filesystem, and it's then
given out to someone else, then our unsplit folio hides an ENOSPC?

Maybe this has all been well thought out, and each large folio
filesystem deals with it appropriately somehow; but I wouldn't
know, since a tmpfs is simply backed by its page cache.

Hugh

