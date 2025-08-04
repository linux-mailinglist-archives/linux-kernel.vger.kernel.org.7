Return-Path: <linux-kernel+bounces-755182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD543B1A2CB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC605161745
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBAE265CCD;
	Mon,  4 Aug 2025 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ap0Pb40m"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C39625B66A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312514; cv=none; b=CwHXeIqSoJ+iKHF2PfP6uPKLJLxC3PWMy8gVfn2XCPEToV8CFmuZA6lW5vzmNuozyfYt1iwDjrDBIiC4LzfEYk5NioOpPLvHLHVhZpX/4qvSAdC1GStp9Sas9E94equ5Iw3f3bJDpX61+WiuYbCXez/1dK6dE6DR9zPeFIk3H5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312514; c=relaxed/simple;
	bh=kC+cJmlpp/oD6ea0betOF2phNLemx2bySRrPbCxJFpc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W8wNY0grrwY9hGAMIbwbyiWvIEnQAxXmOtrKWJ4QapwTyJccGJmwkD/9R8VmAkWduQo7IZyZ9LOGkQ0090zEXMJiwHz7FSd5ZOdyEPbLuAaCRfnO7OQcvRImJPyKhAZTJbLJRmdONZB0L4/KjHA7sN6ckFWv84faLrsvlve6niQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ap0Pb40m; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af93bcaf678so346729666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 06:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754312510; x=1754917310; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KefGQki3y2vCgBk3//HIoldKMrauc2w652/PLEweYlQ=;
        b=Ap0Pb40mlpdFlHuMbC9Hn9qn3XG+wwauIGHaRfAT8KMgFK+FnH6oI0Vifae4ClzKLA
         u1c75rzbRJHusgPXIOOhQm/JfkPAKacypgGKG9EnhUgDddlCiSr+/BO8kcRdK8QGiUXR
         frSXuTKxingoGBQkKSPe8ipJXKpVmjqOYt2JtPy27HRLBiwupKksRIyEgvsyoIJWIS2K
         o0L6Z4nZs0rkOmTuj2rqW3T6r9yIE1Gs1mks1MqfRUlSwjb7MvyygQaUavUSu0M1Ywr5
         KTguJqJqUCiiWt9ia6fT9GHd6DRwrNHdPOZrfkKWH4b+WlHwdzfy856NUMpySNpYkQFw
         KQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754312510; x=1754917310;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KefGQki3y2vCgBk3//HIoldKMrauc2w652/PLEweYlQ=;
        b=tkRQTfgCZDmT6+OLivGIlIPYhP20cyRwkF2jtHMO+Sj0qsxAQMqp12VoCyYyWa96Cv
         /fhlbZYRzj0Uo3WN1VygLmuDs06NTH8B63WnGe4PHbFJOa623bKHaC9iQiJa60s1ON6t
         5PLANlL9CRztsZjz/0aHWQke0/NYUQ9N2Ch4v3FEVtRRij+07kQc+eUWlEBqwuq+BSVI
         okUy10BAAc5iLlDfRmAKpuexg+AnD6hUtP/QQWvAGkKF1LpLiJF3eRK3xxPeeQYuTFed
         dxbA7sToqs8Rjt8vcdRLUIasgtyAFKHDVyKrYlD8ZQWyRQMBsASBMbLDY3pyteeueD7v
         J5Ww==
X-Forwarded-Encrypted: i=1; AJvYcCU3nxnHcFsD9WqqQk/k4cu0duk0wccSl6o+krQtPgh07yPOAV6I628ijszQk62rtKuchUkJwGdQTZLylSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6jPnF5bvAmIcYFa28w0c8JAj17pMaG1C5olwoc8JygZdm8wrY
	PYqGBxdYDfx1Jn18jmMm6P2dqsCPSF+IUYMoVV0wSa+KSao8Fro2Kh0V
X-Gm-Gg: ASbGnctI4QNcTIOHE5vgKI6eUw1iNVzBqGspmE++H1TYLXAj5oL9/UVUTloSAxxAR9+
	gBXC1y8K3WJyKmv6lKVKkFAar7/AWfTilYIhg8lZRF31Wn3hT70821gHby/O98kqB4Nw/BpvnLC
	GEYJR2v8+Aj5Svw4Qreb88W82o3lWhVunQE62VNFhnQq0+qqgWOcQG95dwbbEn9volUhvQn2gNp
	iLZ3F5aHBylqyOUuwoA8EYdHACwfpLO2agv8hR0+W04b380rwGK5GF9F7fcty4Q+9AeO4iBgerP
	pn6vhOyagCW+G0Zltq+smmEopPVt+LQ/ptBwl8IRwRUnXxBVNCu+3GOVryyr8Om7uXO+x40JPPJ
	QkiOPgVzTaDq1gCAza5n2YZdZ5mzYjGDwKoECwp9B6mnGYshB
X-Google-Smtp-Source: AGHT+IHyaLHRw9WBl5ycUvUvKXhVXBKMJj40By+LLSFKNQMKMdFNjDt/FfyPBkA5DzimU7cf9mwASw==
X-Received: by 2002:a17:907:97c5:b0:adb:45eb:7d0b with SMTP id a640c23a62f3a-af940015660mr1070658166b.15.1754312509941;
        Mon, 04 Aug 2025 06:01:49 -0700 (PDT)
Received: from smtpclient.apple ([132.68.46.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af928c84154sm636824066b.84.2025.08.04.06.01.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Aug 2025 06:01:49 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] mm: memory: Force-inline PTE/PMD zapping functions for
 performance
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <c441e6ee-3118-4603-8c77-c5b2ef40982b@redhat.com>
Date: Mon, 4 Aug 2025 16:01:37 +0300
Cc: Li Qiang <liqiang01@kylinos.cn>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 lorenzo.stoakes@oracle.com,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasarya <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9D248293-2456-4642-9F18-8075F0596EC2@gmail.com>
References: <20250804123923.296230-1-liqiang01@kylinos.cn>
 <c441e6ee-3118-4603-8c77-c5b2ef40982b@redhat.com>
To: David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> On 4 Aug 2025, at 15:51, David Hildenbrand <david@redhat.com> wrote:
>=20
> On 04.08.25 14:39, Li Qiang wrote:
>> This change converts several critical page table zapping functions =
from
>> `inline` to `__always_inline`, resulting in measurable performance
>> improvements in process spawning workloads.
>> Performance Impact (Intel Xeon Gold 6430 2.1GHz):
>> - UnixBench 'context1' test shows ~6% improvement (single-core)
>> - UnixBench  shows ~0.6% improvement (single-core)
>> - mm/memory.o size reduced by 2.49% (70190 -> 68445 bytes)
>> - Net code reduction of 1745 bytes (add/remove: 211/166)
>> The modified functions form a hot path during process teardown:
>> 1. zap_present_ptes()
>> 2. do_zap_pte_range()
>> 3. zap_pte_range()
>> 4. zap_pmd_range()
>> Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
>> ---
>=20
> What's the object file size change?

I think that Li wrote that the size is reduced by 2.49% .

My 2 cents is that usually it may be better to understand why it is
not inlined and address that (e.g., likely() hints or something else)
instead of blindly putting __always_inline. The __always_inline might
stay there for no reason after some code changes and therefore become
a maintenance burden. Concretely, in this case, where there is a single
caller, one can expect the compiler to really prefer to inline the
callees.

Perhaps it is beneficial to compile with flags such as
"-fopt-info-inline-optimized-missed=3Dinline.txt=E2=80=9D to better =
understand
the reason.=20=

