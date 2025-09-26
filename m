Return-Path: <linux-kernel+bounces-834566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E51EBA4F43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265464C81B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EA027E1C5;
	Fri, 26 Sep 2025 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="yJkoiPLH"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE252AE8D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758914278; cv=none; b=YwP8zWWEkOHLOOLIhA8rUDu2MDVQZhMKRosCk4SMtV2ZZK6hntvx7w6JMb+Pkec57Va04vMVWvHhucIo/EugK7RnDHjv35aMfN/HpH+QJ7hB/+hEPImQsmDGlOpZv7UOsk7iAlUy1jXKM49g0WZqmDRSO5FYfbgruQg8lYj9Joc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758914278; c=relaxed/simple;
	bh=YxfNRshw215L0wodq3iL1LXxlLhXHhh51dJCIVY/rCM=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=YNBkpxGk0G/JOc2KdXiPKRRzWGl/a4EcBi0eubE0MYgdMPR+DLYTIc+V7OXUUW99bK8mSuitQNyUCCQhsHQeOBWNB4j7EFcfqE4pdLylKEWJeqDhP3qgpUwziYK+TnR6ZPGn/5uiGhTgg/ifVgdlGTeEx+oYi4jzXcUMr7GyGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=yJkoiPLH; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so2186189a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1758914275; x=1759519075; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ur25y4KPAgkJxb7AAIQiwb2eaX3zSnJwUWUorsVvCmY=;
        b=yJkoiPLHOhvaCmRtCR/PzRbRWXTQdMCFr9+DezVa7NYMrFEJaWmk5HO7ghxZJWqUcn
         UxI1ivxgns97aiRlG4glUr31rjoCClybAmZ6uoHvpW+2d6kFcrSLvBLFnfvCHYZlwHZd
         J/bDY7G3fij2wgWjsAPeWo3ZtQDn/mb8HLKVDcO30S3105XHbipfJNrVgf9SZzYvon0g
         YGopjkSrUnG17NLDDf0gYrLDhuMPvt1//yHrq+jjW4ziP0JsGe7Pa0QGIOfOGEfsjDAj
         +jIU1I/QajEZl4eMLoGSyTrsEOpVzBhMt0ZjRXM1IeX6qLcK5vRyPGRcZXvDNpjeHmOK
         ROjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758914275; x=1759519075;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ur25y4KPAgkJxb7AAIQiwb2eaX3zSnJwUWUorsVvCmY=;
        b=IaTewSY/0QjvT8J71m3JFXw9W/7FEDx1hhYZ/7xT/HCutl1A9b6WdcCFnL64WRyaeu
         YGT2yvoNFpNnZbXYRhKa7ZhMYaDmT3GEO+br1qYZB8XsFCXoKS6+ni4n++dmbdsPYsnT
         FSF6zIxxrfY1HMaXIRYECrksxDVOYwkgnCeIn97iYBdDbT3hKzkdppks27053Qr379dk
         THLW1pI6ZSkB9Uul9xwQRo4Ap0dKI7Koh5NqnlPjtFuKcLBez6ZcKlpKdt9kYw4QJRNu
         PBRDHAO5eUT+tRZDD+uatUe23UyyHNuMZYKuTUggdMHqpHgTAXGtXFpEchEbpgaMCICj
         HJYw==
X-Forwarded-Encrypted: i=1; AJvYcCUgdL74FGo9ZYQtU2kc5CDgUDuGLwMLIf+SE9KEZonuwryckSstmyjbKx3OVVM6UP1AWaN60nFzibKm2yc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq8tC5NIkc+ZPpNSFxeKfQXaZ248mpRqFiz4UM7A5i7fwtrgeB
	eHhf2zS2l3RKgY8+LZWXxy2Aac47JGm+cSw5LKNm//kVfsSnQmIO9OBU/W5yf/LIsLw=
X-Gm-Gg: ASbGncu5xqRm1tHuqMFIXD1GlbbcKYmKSz3HLdasbaGcxCjPJDUlWCJ8aWcLcEwzucg
	tWJ806PxfI4aoi5MndlwYUkrIERMLIxmDr+IdzQ65LnK8NABCOJT+tPxvM+BjjFStAJ6fxieTNg
	gAZ/g6RT4/5QRx4/Tgcx3h2douhUAUNw3HlAmHkz4fTEJpL4yRah57XxKAc6j66evIIAxDy7Y/5
	Zcjvkx3OKNGb+rvFtf+q5t68yIfcmLE0E6qvfgpuCK00mpLr9RDTS6yt5lTOgmYZEV9gZVeaAIH
	ns+noLthCIDqV+lbqbqwsqmFRzA/q0YKmjO8LPtvWMABi5q6KwwH6JVotT1fYFOn++NVmDskNbb
	FXzTEHh/gOfThv1KY7b7eQGMbxxgETcIdxpCF7EPnJ4V896ph3m0qt031ZiiACUBr73h+uOeXqb
	het0KVHg==
X-Google-Smtp-Source: AGHT+IEqGHHfOCHYWY5HJi+Hs4lNleePoxMcwp/fg2hNFD5mPDO+fX1ABw+ovkuFZ6QkoVefj8AOng==
X-Received: by 2002:a17:90b:3a81:b0:32b:d79e:58a6 with SMTP id 98e67ed59e1d1-3342a2cadc3mr7331140a91.25.1758914274970;
        Fri, 26 Sep 2025 12:17:54 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33434ac9998sm3032879a91.2.2025.09.26.12.17.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Sep 2025 12:17:54 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <262BB988-A30B-4A4A-B96B-E604D86CA18C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_91D7CA21-5D0A-454A-AA15-DF88C6BC1BF3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: fix allocation failure in ext4_mb_load_buddy_gfp
Date: Fri, 26 Sep 2025 13:17:51 -0600
In-Reply-To: <20250925020621.1268714-1-kartikey406@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
 linux-ext4 <linux-ext4@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
References: <20250925020621.1268714-1-kartikey406@gmail.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_91D7CA21-5D0A-454A-AA15-DF88C6BC1BF3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 24, 2025, at 8:06 PM, Deepanshu Kartikey <kartikey406@gmail.com> =
wrote:
>=20
>=20
> Hi Andreas,
>=20
> Thank you for pointing out the fundamental issue with my approach. =
You're right that removing __GFP_NOFAIL creates a worse problem by =
potentially triggering filesystem errors.
>=20
> I understand your suggestion about allowing the function to return =
errors so the caller can retry, but I need more specific guidance on the =
implementation approach.
>=20
> Questions:
>=20
> 1. **Function signature change**: Should ext4_discard_preallocations() =
be changed from void to int to return error codes? This would require =
updating all 13+ callers I found.

Changing internal function signatures is never a problem for Linux, =
except
userland syscall APIs.  This is even less of a concern if all of the =
callers
are inside ext4.

I notice that ext4_discard_preallocations() also has an unused "int =
needed"
argument that could be removed.

> 2. **Caller modifications**: How should the various callers =
(ext4_truncate, ext4_clear_inode, ext4_release_file, etc.) handle =
allocation failures during memory pressure? Should they:
>   - Retry the operation later?
>   - Skip preallocation cleanup temporarily?
>   - Handle it differently based on the calling context?

Looking at this more closely, it appears that =
ext4_discard_preallocations()
should not fail outright, since this would leak space in the filesystem.

I guess this goes back to a question of whether a warning message on the =
console
when the kernel is totally out of memory is a bad thing?  The whole =
point of
__GFP_NOFAIL was to put the retry in the control of the MM layer, =
instead of
having the caller loop and doing the same thing.

> 3. **Memory pressure detection**: Is checking (current->flags & =
PF_MEMALLOC) the right approach to detect when we're in memory reclaim =
context?
>=20
> 4. **Scope of changes**: Would you prefer:
>   - A minimal fix that just handles the allocation failure gracefully?
>   - A more comprehensive rework of the error handling throughout the =
preallocation discard path?

I was thinking one option might be to have reserved memory to handle =
this
specific case, so that *one* preallocation can make progress at a time.
However, it isn't clear if this one allocation would be enough to =
guarantee
forward progress, or if there needs to be a pool at every step along the =
way.

Just freeing some other buddy bitmap by ext4 and retrying is not =
guaranteed
to make progress, since OOM means it is likely that *other* threads are =
also
trying hard to allocate memory.

> I want to make sure I understand the preferred approach before =
submitting v2, especially since this affects multiple call sites =
throughout the ext4 codebase.

I think the important question is what the impact is of the original =
problem
that was being fixed?

Another option would be to return -EAGAIN or -ENOMEM (or similar) from =
this
function and then the whole "flush THIS inode from cache" would be =
dropped,
and memory reclaim should progress to some other inode that doesn't have
preallocated blocks, or some other memory.

Cheers, Andreas

--Apple-Mail=_91D7CA21-5D0A-454A-AA15-DF88C6BC1BF3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmjW5t8ACgkQcqXauRfM
H+CqgxAArlHlP0Iv+tWoaMRH2t0sbQDnz/9kAT1klGWdxhrtBdfxKKyw6KRb4xhz
s/8lLxYSryrPl3EwuikPK45S5ZDfjk/bFGkShQfVmjDoQ+JffABynNzU89orLJaG
a/lKwqgZHIeqvLEU73I7PWaUKjGHG8VOniq9fFjuqh9hETsW/eCesJegZs+NwYSD
GKyKpPe51ufxj2hA+og1C9YIUISScRGhylfXgwyQgkEa1vzmVYmQ7s2OzcOVMO6H
McH/zh/HKK1C/2825BixcrAmwtXCt/W+BxFCPPBSKiKA7s0U72Wpt0oUQ+j74rMh
IVMBRcWDV487PPXquXep3q3b4eMZkfmjM+c3F9dXpzpYMISwyu0Gxm9/qssDsusb
+QwuOG89WJHeYEsHRQF2T8ztbhpEJb5rys/TMu6rO5xai0jDP9p87czxTnVwVGQq
xdIGu0LsGkE2f3F5GrgXfasSJjvhNQtcgw5f7vGEp9h3BNsKv+hh8lsZQYAtJ+Ql
8g2gxacNUyOBCnwFS0iN/1lgvt7ZPkqMrL27DMKNh0+i25hCfWzrciRUBK406tTD
2zhWUMywADxcX+AGyCVvtwxsVKbjHdkcD42e11gIUn2sPR4GrRdtGOVo6BDAWQQQ
t1fkLx5/o5gMq6NdD1iuSo8YwEgFijmWkbb8EczwT296Jcdtnx4=
=wiB7
-----END PGP SIGNATURE-----

--Apple-Mail=_91D7CA21-5D0A-454A-AA15-DF88C6BC1BF3--

