Return-Path: <linux-kernel+bounces-867314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E59C023DA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C35E501298
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0424823E347;
	Thu, 23 Oct 2025 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="JrIYCLdr"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075392367DC
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234549; cv=none; b=ZA8MGB1q1aW+US9+gW4g1nUbK5MpblBahVI/LRucqz7gD1XDJlOMAGTwNsIlsEBa0qflMyqBeBfBEdTJ1RytYNNq/A24vj1Xc6LybaXSYnIOVurHjLCnkRO9S0bUzQWxYp82pqv0wsheBwMB5tNz3Dfcjz4595SyVEqnNJs+39Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234549; c=relaxed/simple;
	bh=TR0vyrIj5zOAmrWtxwLaf9B/tGNGrD4OYYiP6WG1Udc=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=QlGWYWG+QesMcmcvA63C3ARkLYueb7hqIW7X8SWEuKKgUds4LIUJKcaMbJjNC2nhgkaRD2+NlpIDt8Ijf25PYPhBKW8LMt8dlJFscShAlVL24krNIVYpZGb9Hc/dNwUblDu3GZETXPmpdUgFRsrcAh6z34IIi/UXAw4oGLlrJ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=JrIYCLdr; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33e0008d3b3so1086184a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1761234544; x=1761839344; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6l6v5GKhdHV57QLrRcfX0OseV//0wL094GM3Lc9kONI=;
        b=JrIYCLdrrQi3ahtK48HYqNZOktXIXOwDg/XD/YrSkNwKbbWxVpEAjHDZ7apWAM2rUA
         wzr2+FQu9q1EL5TUQOy5qRUJngDnp878XToShB7p6graYiBlQ0P7ilSVPr8YanLcCfA2
         7Vq+TJio+1qbqkTcZPeJOIXUwzrmtq4e/JORW1qCz2dmZ+1iA/OeVauUWB7C8/d9Zq+f
         LpDJfD/5MfrtzKpmE1BNOqeDDobImMYKcq/eLrJQhV0H1j7nInY0nwHOmhIarCAUX7nm
         l7s8T7gIGUfekTrWwShX7Y7RiJM6m7UH2686hmUxKBz6L1J9LsYBVVaK8ZQgAQdNynZr
         BAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761234544; x=1761839344;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6l6v5GKhdHV57QLrRcfX0OseV//0wL094GM3Lc9kONI=;
        b=qbiIjtQ6iHuvKpkWUngHHxkvoUz8CIBq5ElVuecbfNSSJZd+sooYhxsTGLQLPl7GBu
         EjrnNE5Y0aOUnAKooqH4EmTsL77HlVaWwzK07q22nVk+gDFEvq8uSRoLF7zF7r6HdMoe
         wA+AArwUMqYDMQspfqtP2WJ27R4ih+qPElmxEOTYsR3jphq4PK4QKQsO59nDOmZUsQgf
         jcsGXnXF/k13LUiCUSoZT4hpQ/t54bYkmIxocBDDl3ttBb9Bv7RVlPK7JiAC+byFPOtt
         OhvMDDc6Dvp7/JbNYPG8Lf2U6nEMNW0n4H4cm86avlwbbo7d8DZWURmNzkuVtsG9NvLa
         WLqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5r5VXjURQrlWvltxb+kHACuJKgwqBr74A9xgrqqzt7/Ght+SrOAnO927DUKgvbm9Ak8HXeeMvo9ymCeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyto/qzxTE3q/NG5hySygsT6p+oTvKdvf+jsqqsPBxj09mKLXrC
	aHxWrJZ9LZ7vzCDXHFloB9uepStWdcFhodHGMx02FxhXvk26sHdrnRa0F8zEcZDLjJM=
X-Gm-Gg: ASbGncuKqyhvFTiDpZnBi/wNllRY+vgiaigSLKZdzq7qus8KzYhwHmb3X5A1nxkVWcx
	+EQHlymjgJ9/ISFMjQmPYPijtBTD5CKRDdm6RIgnEGYVwPSJ2ptZJcmexUVaPdBdPqa6BK6+mVa
	n7oNpi7mRMdBh/YKxCGqL2Mnz1FKonRW3IdYDSmLYKJiFw39poOQJZx9Pw/q4+gZaGGygCAzfF7
	1ePTeQDg54FZj2e6Ec3BPuSCaYoAu0x04e/Ed4HxvPbj9+QP5Q/TIV1ER2napEdLGk5hp0wt5fU
	pqZ4VWIt4qRepiioueyWJ/etNhVi3Sc9g22zWio6uqAW2zlEwgMhXUMQmUArtzrswvtCtO2ccJf
	YjBz2d/yuUeeXVTYAoAtm74QQnuzm796MbLhQ9d+5vt8Sm7MLObO/QBYz0tQ0Ltt8VMPuHjgidZ
	OzPRWtbf1cYmaK9XKcNeSVoNTP8s59l7NZgSPbpTzM2SLrPf1r
X-Google-Smtp-Source: AGHT+IH3PwWqpiI3zcpwER2AyB/rp+AS9Y6D6TVLAKwCB2BvEfgzPHpJN6qvv4GuH89JR9PFSabRKQ==
X-Received: by 2002:a17:90b:5291:b0:32e:859:c79 with SMTP id 98e67ed59e1d1-33bcec1ab25mr31330207a91.0.1761234544113;
        Thu, 23 Oct 2025 08:49:04 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c13d58sm2446777a12.15.2025.10.23.08.49.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Oct 2025 08:49:03 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <AF891D9F-C006-411C-BC4C-3787622AB189@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_48E99939-A914-48C4-B30B-0EEA6EDDC0B0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC, PATCH 0/2] Large folios vs. SIGBUS semantics
Date: Thu, 23 Oct 2025 09:48:58 -0600
In-Reply-To: <aPoTw1qaEhU5CYmI@dread.disaster.area>
Cc: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
References: <20251020163054.1063646-1-kirill@shutemov.name>
 <aPbFgnW1ewPzpBGz@dread.disaster.area>
 <d7s4dpxtfwf2kdp4zd7szy22lxrhdjilxrsrtpm7ckzsnosdmo@bq43jwx7omq3>
 <aPoTw1qaEhU5CYmI@dread.disaster.area>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_48E99939-A914-48C4-B30B-0EEA6EDDC0B0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On Oct 23, 2025, at 5:38 AM, Dave Chinner <david@fromorbit.com> wrote:
> 
> On Tue, Oct 21, 2025 at 07:16:26AM +0100, Kiryl Shutsemau wrote:
>> On Tue, Oct 21, 2025 at 10:28:02AM +1100, Dave Chinner wrote:
>>> In critical paths like truncate, correctness and safety come first.
>>> Performance is only a secondary consideration.  The overlap of
>>> mmap() and truncate() is an area where we have had many, many bugs
>>> and, at minimum, the current POSIX behaviour largely shields us from
>>> serious stale data exposure events when those bugs (inevitably)
>>> occur.
>> 
>> How do you prevent writes via GUP racing with truncate()?
>> 
>> Something like this:
>> 
>> 	CPU0				CPU1
>> fd = open("file")
>> p = mmap(fd)
>> whatever_syscall(p)
>>  get_user_pages(p, &page)
>>  				truncate("file");
>>  <write to page>
>>  put_page(page);
> 
> Forget about truncate, go look at the comment above
> writable_file_mapping_allowed() about using GUP this way.
> 
> i.e. file-backed mmap/GUP is a known broken anti-pattern. We've
> spent the past 15+ years telling people that it is unfixably broken
> and they will crash their kernel or corrupt there data if they do
> this.
> 
> This is not supported functionality because real world production
> use ends up exposing problems with sync and background writeback
> races, truncate races, fallocate() races, writes into holes, writes
> into preallocated regions, writes over shared extents that require
> copy-on-write, etc, etc, ad nausiem.
> 
> If anyone is using filebacked mappings like this, then when it
> breaks they get to keep all the broken pieces to themselves.

Should ftruncate("file") return ETXTBUSY in this case, so that users
and applications know this doesn't work/isn't safe?  Unfortunately,
today's application developers barely even know how IO is done, so
there is little chance that they would understand subtleties like this.

Cheers, Andreas

>> The GUP can pin a page in the middle of a large folio well beyond the
>> truncation point. The folio will not be split on truncation due to the
>> elevated pin.
>> 
>> I don't think this issue can be fundamentally fixed as long as we allow
>> GUP for file-backed memory.
> 
> Yup, but that's the least of the problems with GUP on file-backed
> pages...
> 
>> If the filesystem side cannot handle a non-zeroed tail of a large folio,
>> this SIGBUS semantics only hides the issue instead of addressing it.
> 
> The objections raised have not related to whether a filesystem
> "cannot handle" this case or not. The concerns are about a change of
> behaviour in a well known, widely documented API, as well as the
> significant increase in surface area of potential data exposure it
> would enable should there be Yet Another Truncate Bug Again Once
> More.
> 
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
> 


Cheers, Andreas






--Apple-Mail=_48E99939-A914-48C4-B30B-0EEA6EDDC0B0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmj6TmsACgkQcqXauRfM
H+CY1w/+JoC6DHdgP5p4CEVNhByOccTqDc9/xK5kbk0cN1d/jNA0jaz3s/jLATWn
DMDa3ZsuYDyYNk1KhlbLNZ/k1MJEh8mxq4pqUrmu4PpMFrO2037t0lkPdYxcakkW
+idSJxoIYQcCGS42vOUZ6gL40RIRLDdY/5zgCvysIF4aIbYyp/NJj58BBuzHahC4
MlejI5KKvqxYtvhCeCt0lGbSc4a/rmoI02hhKngMZ865oM2sEdSNQpjE6/J9COz7
XwbWqa9mth0aa5vuUt/RcL9jkFshItIUmhs4DxUtdHfXPSG4hDwM0jsJnNdRD/SM
RQY30IoDVBoefkwdhs+fvGbUivgw0LSgba56P+AjLChp6FAX1ASh3ML+4zxspqs4
fPxiX7BS7+ojkg0VtKEKJPk5Q6+4a1T3flIBq6tDE4UwISC63Vb4qA1CPCVbyVeU
zKAkfNMzSOlOMOYKAj51Nx9mj6NxZXLJvrS7jMCKiWh1m7B6a9GuDs7yQ5QQ+Q5v
PfheQd2jmcYXXRZpyzu3qhzJzPGpJ6seMJCZHwBQ3jg2zfiv+7gyGwedVKy/xb+j
Cd2xi0wN9hrGFKO2Ya2Zd7VIHkkWnjErwOm1x4QNsiqj9D6Hc9yJkHCG0dRb1Lwv
4064fTxGFyNuIujVcvPB6rXpKVJGhLEayMqrVtDjuzoJtA9vQJ4=
=kl6f
-----END PGP SIGNATURE-----

--Apple-Mail=_48E99939-A914-48C4-B30B-0EEA6EDDC0B0--

