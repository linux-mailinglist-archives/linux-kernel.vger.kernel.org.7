Return-Path: <linux-kernel+bounces-769599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5950CB270D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04D63ADC83
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D0A276054;
	Thu, 14 Aug 2025 21:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuE8sVlF"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817232550D8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206820; cv=none; b=H7D5pdAndTObUJrEiiRYHMxt7dkhoWz+LmJf9tDs6nN0P+yk22PrF20VadguC0LrekP4hH3XdIIwnA9RsRx0H1lgZvGw55jNaFDEE3r/Xw68PyVWOdafZlfHBC3rb/MiQJlBzFfphQCWVRc5RZRMHi1psfvnNUP+6/+u63DKQ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206820; c=relaxed/simple;
	bh=9hlJmVkvTgYsNglHLI+V+sNFoEDGglb5EvZIAO9cQ2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKJDHkxc0T2OdgCDQqSshqx2fcf2Q0pxx51VsCG8YvDLt8gbD7GU8Aauki9eurEFkiVFkYao5JuhDHJxEfHy2XssSek3ZperCIfJL9KGtWRs4JoqFdiRA/Ud7RH+KqieVOX8LmWW7wVXu3mPsH3uxM8ESMgcuoGX7lLAPsZdiWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuE8sVlF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9e418ba08so713581f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755206817; x=1755811617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdjyiC9t2sFnVWubrduW9TaZqSWryaWv42jY5Hi7s4A=;
        b=KuE8sVlF9UKTs6lIwAtphb5ovcIK7TibI0ggC4UJBvJnVR4LXIpMG+4OIewHqxcF/j
         33hOLdG7pmD3dzEMrE3agmexSu+HsOnySCbmUeu1zk6OJ6JPCjHK+hSDd9/0ov777D0Y
         2IuFA/qZ28Oe3jv5x3vy4ktbS8OCaJoIEYU7O8Cr8qwOSUxZuE1nLoptcojCYGfD4PKy
         fNVcUGSr+eOtGG3uZxOOeICKVqMA0DAcdUrdFgtaPXh3UExyzAoQAeEee3z/sLNLUMHn
         JuHqznVlPZZ0bKJeLpSdCrdITxZ4qdLSvMFe2GpFmpBeGCaA6IGVrkOP3MRQlvqEXDly
         4c8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755206817; x=1755811617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdjyiC9t2sFnVWubrduW9TaZqSWryaWv42jY5Hi7s4A=;
        b=dVZxX9RmTXbiyVAvE3W4TZf7ba/Xt9SREA6qTS1sl+HmSCb+uodz3l3S4h8EBVyJNr
         3m9qqxccjTXXS5BIKbVFsxRVv9Bvz7H3PEyUgcqbn6nb8XuIoQaoRlpRXLJLbNl60dya
         hp9tgKqWIAC71e+Jm3ZePZOO/Xl9icP69OVhqY4wHk8nWDno2wdlQQCbkTtjCgo/8CZ0
         opq+RrI+fu9Fc0qnDYvz2eODqDpfdoLdbr53XcgKjkIDE7OJPtOGhxT6eWTlxDO691Em
         ts2EQs9d8HCxdd1L/JXfmXb+Q5D5xbBO0hy5bp3hw+4yLBjWotxSIaZH9luE/fcqBkeK
         Vf4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmljbtPVkmSkhMuIP+z5TBu2ULTzhU+jMVdPSC0/Jgkz86cPl+zF1XDWHdS9QM0Ijyx3P3KOyMU/IskGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkOoYzfYaCYt6bpJaWBJ75Knnx+x0QHfYFw/hI3iX7/RE1O+Wz
	kP/7P90Yhy8hnj4QlYz5A7BNRUYPJpyDdoNB2lUVuKevMxZnuuOo5DbE
X-Gm-Gg: ASbGnct0HG4QZ4qzL1vFYazVRBwxZcFJWVpbqwr5/eJlxhZS4073wW56C/SRxei3TRb
	FJjKfNThKAB+HHSzwgvTczeSZYdWJO+tn2XweOHayA5gEnHekAaHngn8+gAAsfdHxEFg119AEEf
	x/WbOVWdZNM9uGVdo5Vl+S1qzhSlG2FG6K8j8o5jOgotzFm2XIAqCosmnIAPky6XyLVssdfAAhC
	VC6PPlV29/g0mjSRQ+DpBL2sEhbutA9/oaflaiy2r1JTmPjKe8W7bjePmWb07Xf5JiR2+uQELvH
	tVQiqYeaPuzx4Ss/kAZ5T+JSO+zYWXR/8gSDs3QzRK4yer+NeAhHGoalClm853rRH8sXr2vR37Y
	qaGiDMOdhRBB6A9JWt8NhYcGxxv5sjUqQ6wUjcULUfyZLQgDgdhbhRHDTAeCi
X-Google-Smtp-Source: AGHT+IGEklx+oeMWF1vXpOz6vHkVD4MYz9DztWdjDoQHv4oIdmzSLGiJHDTuR+2qvmRGK+UOqiIskg==
X-Received: by 2002:a05:6000:1a87:b0:3b7:9564:29be with SMTP id ffacd0b85a97d-3b9edfbcbc4mr3472504f8f.49.1755206816591;
        Thu, 14 Aug 2025 14:26:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4533f1sm52559367f8f.42.2025.08.14.14.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 14:26:56 -0700 (PDT)
Date: Thu, 14 Aug 2025 22:26:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Qingshuang Fu <fffsqian@163.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org, mhocko@kernel.org, zhengqi.arch@bytedance.com,
 lorenzo.stoakes@oracle.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Qingshuang Fu <fuqingshuang@kylinos.cn>
Subject: Re: [PATCH] Fix the data type inconsistency issue of min (tier,
 MAX_CR_TIERS-1) in read_ctrl_pos
Message-ID: <20250814222655.0384e05d@pumpkin>
In-Reply-To: <91d72c49-22df-43ed-aeeb-0b93a9da3bfa@redhat.com>
References: <20250808072106.153449-1-fffsqian@163.com>
	<91d72c49-22df-43ed-aeeb-0b93a9da3bfa@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Aug 2025 09:35:19 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 08.08.25 09:21, Qingshuang Fu wrote:
> > From: Qingshuang Fu <fuqingshuang@kylinos.cn> =20
>=20
> Subject should probably be
>=20
> "mm/vmscan: fix build bug in read_ctrl_pos"
>=20
> >=20
> > Due to the fact that the tier data type in min (tier, MAX_CR_TIERS -1)
> > is int,but MAX_CR_TIERS is an unsigned type, directly using
> > the min function for comparison will result in an error:
> > from mm/vmscan.c:15:
> > mm/vmscan.c: In function =E2=80=98read_ctrl_pos=E2=80=99:
> > ./include/linux/build_bug.h:78:41: error: static assertion failed:
> > "min(tier, 4U - 1) signedness error, fix types or
> > consider umin() before min_t()"
> > And MAX_CR_TIERS is a macro definition defined as 4U,
> > so min_t can be used to convert it to int type before
> > performing the minimum value operation.
> >  =20
>=20
> Please use empty lines to make the description easier to read. Also, I=20
> think you can simplify this heavily.
>=20
> We should add
>=20
> Fixes: 37a260870f2c ("mm/mglru: rework type selection")
>=20
> BUT
>=20
> this commit is more than half a year old. How come no built bot=20
> complained about that?
>=20
> IOW, what compiler are you using and why are only you able to trigger thi=
s>

I've remembered that this code has shown up before.
With the current minmax.h it is ok provided read_ctrl_pos() is inlined.
In that case statically_true((i) >=3D 0) is true - so the 'signed' 'i' is
known to be non-negative.

But as well as 'i' being signed, the entire loop is silly.
To code is called with a 0..3 to execute the code once (actually in a loop)
or 4 to execute the loop 4 times.
The abstraction is just wrong.

	David=20

