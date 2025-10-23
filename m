Return-Path: <linux-kernel+bounces-866854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD84C00CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202D31A623D8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4333630E827;
	Thu, 23 Oct 2025 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Xq834mES"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8374D302747
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219529; cv=none; b=h/v+RREDorrSaVAk2IBPZ3gRp/RLa46//MIHVA0jhxl10PXI8k/kzPdxazwSDIk/CFmw9Nw1zcY/+3q7YBL3bLGU5jzpCtzyXkrrDXRbEbJMsuYsPM/SeeC7GtRhP3TZUI9jh9nYz1zcs9B1sum+VMhFhQ8Sqj8u42n+BereVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219529; c=relaxed/simple;
	bh=elbfjnjaPAJ522f0VXHQ329aVUbiNkpcToeJodR3e78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNC/E0WG7JN7dkqfQad7u2cJv1OMalzMQqF31wsVdNI5vC7+qVt5IbdBLrDhABc7rCxJ26WjJI2aIkQ7x7/OQnJaY15uN04urCSjtR2+G0oXWtnVPTByHY3Ut1mRqw/1GYhWponxkfuYCqYcYUBeid7WxiO7QuTCyobNvkkzzJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Xq834mES; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7835321bc98so610622b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1761219527; x=1761824327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7OfFvZSBGvefp2IlhmMNRYw7kz1hyuz0xjUoRSAHeZw=;
        b=Xq834mES791bTTrxSTRQufbSn0ov9XJarOZgqRneKfovg2CUagI6ijNwisJqsYfjyl
         k+TzFW/M+1v/eChI2vL7s0JBooaFCQssp+nrRlVMmCm6OcIiwSr0i7dBQmkBG/UjgYhO
         Tr44ds5b0L78fI1eD/eRjgSL0Byly6aSPRFJZoLusFSDBj9qHejd/E+RiznlhBcGEMhw
         ptX/2KRWFwwSS9zuaKoqFdF5bRr6MeLnxZHxzyVYPemGOjH3mdyAfAfG0P7rM9ToAJyz
         2M4JSdgZnfmKrWqd8XGYXuecb4md3Ny7nEwtSElRSqlOeqFbFIpUH1vW7McaVUnRj8gW
         +MhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219527; x=1761824327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OfFvZSBGvefp2IlhmMNRYw7kz1hyuz0xjUoRSAHeZw=;
        b=mhuGglxgeuE3LYsOBDdsJRvYTujlFwKr0xOAjO3CH/Sa/x5YWRM7e8TChkjTPmFhso
         Uz0CcWr+u5DSqzksL6+2J6EBIEP3zlFzDdtJcPr5t4EIlW39qtUhbdxVL0OZeV88IozN
         W9P57vmicsmLmCw4hecR6flb2BbwfzkoBNKw010i0XPIUOxmRBYQ/drEtZE/5u4Mkb1n
         fLHzwfCprXL7fG9LfXxVnONWa5Nlc+PJuYe9VP0S8e1TZpucsf5ZKX51VnMX2qUJhY/H
         NUop/iwdAEWq6SfRLU62LTde9rSTkW10kSd91iEQ2+rLBkvWbRNK8UwnGeIpUn3BcWtn
         K7TA==
X-Forwarded-Encrypted: i=1; AJvYcCXFTB2/3hl7slgTIqVyyrfAzxxVPB5W7OxF7mR57pDy2Bc8T1Z6UMo+S9SL5vd/O0k3OJf6tRu99pmH5Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMKuaGjH4ofCXatnROUMJZPFtayF/iGyvOzgKfRojxCyTWQVpT
	i+fGQJamDYB9WbeLA58XI9aNzyxQ1GZjOHUvjQoIJ2KcDJ1RvcL+wJ+HfU9TGYunG+o=
X-Gm-Gg: ASbGnctB0PhcNCfEU/8/b+UhXh/WiH8SNph9zznt6sOx12eVCHlaiO022KeDRCfK+rv
	7SQ2h8BoESGHrUm33T+cyb52HMRp1qtfwrRBjq4R4NJK+zAYR9B0eQqDlGCJRKyi1Edop26Rj+T
	zj/GAyfiFXhdu6h8VLNmqvTdvzcEoLEJ1p+N6XCYcwz3OCYr55juqLsjpEf6SGLAB56SfGW9cHN
	nw5o7BaPNLEc5RqNnq6B1WGBD/gcpgJp3ZqO+Mm1VsI9HWOF4UAK7v2ETqXyaCJvO46ok6x5hXX
	Kuki5lPCpQy147GrLGX4qd3SsxAWRkfGjoaTF1poVgEmWRT0jogQXUQbOzg/VJC/LZQU4PVgl/j
	vcg6TSiYFgRpF7hgfMqPnPuMD8+FewB/dnWwBS3ZcprbeJOzsEBceZTb/Gid5EFEEFAwyd9MvQW
	bBEd1HKegvaOArqv4PNDcYJgu8Mbyc8+ZFXgEII7gBNVtkCUqospl+syR3aqnaxA==
X-Google-Smtp-Source: AGHT+IFGvY2Pdi6Kzm9/7JRxOvRXqUtuxuo/ixSX3c7klUnIdzpgEtIPhjSJGnNNJmvDxy7KykQvkA==
X-Received: by 2002:a05:6a00:9509:b0:7a2:7256:ffb4 with SMTP id d2e1a72fcca58-7a272570178mr3763899b3a.26.1761219526650;
        Thu, 23 Oct 2025 04:38:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dc12bdsm2225482b3a.72.2025.10.23.04.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:38:46 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vBteV-000000011nJ-0x06;
	Thu, 23 Oct 2025 22:38:43 +1100
Date: Thu, 23 Oct 2025 22:38:43 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH 0/2] Large folios vs. SIGBUS semantics
Message-ID: <aPoTw1qaEhU5CYmI@dread.disaster.area>
References: <20251020163054.1063646-1-kirill@shutemov.name>
 <aPbFgnW1ewPzpBGz@dread.disaster.area>
 <d7s4dpxtfwf2kdp4zd7szy22lxrhdjilxrsrtpm7ckzsnosdmo@bq43jwx7omq3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7s4dpxtfwf2kdp4zd7szy22lxrhdjilxrsrtpm7ckzsnosdmo@bq43jwx7omq3>

On Tue, Oct 21, 2025 at 07:16:26AM +0100, Kiryl Shutsemau wrote:
> On Tue, Oct 21, 2025 at 10:28:02AM +1100, Dave Chinner wrote:
> > In critical paths like truncate, correctness and safety come first.
> > Performance is only a secondary consideration.  The overlap of
> > mmap() and truncate() is an area where we have had many, many bugs
> > and, at minimum, the current POSIX behaviour largely shields us from
> > serious stale data exposure events when those bugs (inevitably)
> > occur.
> 
> How do you prevent writes via GUP racing with truncate()?
> 
> Something like this:
> 
> 	CPU0				CPU1
> fd = open("file")
> p = mmap(fd)
> whatever_syscall(p)
>   get_user_pages(p, &page)
>   				truncate("file");
>   <write to page>
>   put_page(page);

Forget about truncate, go look at the comment above
writable_file_mapping_allowed() about using GUP this way.

i.e. file-backed mmap/GUP is a known broken anti-pattern. We've
spent the past 15+ years telling people that it is unfixably broken
and they will crash their kernel or corrupt there data if they do
this.

This is not supported functionality because real world production
use ends up exposing problems with sync and background writeback
races, truncate races, fallocate() races, writes into holes, writes
into preallocated regions, writes over shared extents that require
copy-on-write, etc, etc, ad nausiem.

If anyone is using filebacked mappings like this, then when it
breaks they get to keep all the broken pieces to themselves.

> The GUP can pin a page in the middle of a large folio well beyond the
> truncation point. The folio will not be split on truncation due to the
> elevated pin.
> 
> I don't think this issue can be fundamentally fixed as long as we allow
> GUP for file-backed memory.

Yup, but that's the least of the problems with GUP on file-backed
pages...

> If the filesystem side cannot handle a non-zeroed tail of a large folio,
> this SIGBUS semantics only hides the issue instead of addressing it.

The objections raised have not related to whether a filesystem
"cannot handle" this case or not. The concerns are about a change of
behaviour in a well known, widely documented API, as well as the
significant increase in surface area of potential data exposure it
would enable should there be Yet Another Truncate Bug Again Once
More.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

