Return-Path: <linux-kernel+bounces-775068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F40B6B2BAEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D011217836D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A7F3101AF;
	Tue, 19 Aug 2025 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IV3QuXD3"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE1130FF37
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589186; cv=none; b=LnYir5qhOyeIKq2wkbzFKaUOKq+1a+gu7JHYTSh0c6buAUFmEPjkXVGC9x6gBGWmG1+wB5NBESz+Qp2CXdlzwxcKG+uKhnpSwZvdSopKN7jxanFzdTE/WphPTMj5GDItFEeJv/0vG3xCQiIiwme5T2WTCPmgkPcfM3sCY6ZO0Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589186; c=relaxed/simple;
	bh=eRD1kroDbQ1a6DO8DjocsXJeFSn2D5Gc+Oh+p/Mt9VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qh9mavTeBfSjtpfZo/KL/f2Q980vWoUfeK4VWQz1RLTaPLWYa8aAA9YO8kFPAM9IROjYvhlzEJPlcNTlpoMBEhAM+1JzS+M2n9BPlUxHXpBGxkzwPGhq8s9cqKrOqhgYmeshl/7y8QqWGMON+la0yp0N0oNc7I9jItCdEJwAsiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IV3QuXD3; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7a8dd3dso707057066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755589183; x=1756193983; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlGG0MimgPVuD1cdmYrztEX7ylcMD0YKZDmGx1Z6TgU=;
        b=IV3QuXD352E59L5BMLMf6kLkcnbLhEjwYZamSvGr9mYFh8dPwHGk5NOm11PAYsfRZ9
         cRGdOnkF5F42HpPdr4SVopjGPESMpZ3FhvBhw7h854zrXgwRJR/LOxR+ylHi82i0Osf7
         Ngwn0FR9eVHabfMOgdceAh8FcZqze4apAC1Cq+rv0sma5lFoEY2hDnVIxoDt7r3OxpIO
         J1bXPHm11H4e6nxgLGx5gEF0AQaR1yyqVlhKQa42PvKbHgrj1e/LVO9gvNXkd5a9gn+7
         O6eVS/Njp/FyQYbK3GmwMKIIIbTXnP+YnzMlVN9MvNEtUmirlzo/8931NJOy0/s8MpJh
         YHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755589183; x=1756193983;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JlGG0MimgPVuD1cdmYrztEX7ylcMD0YKZDmGx1Z6TgU=;
        b=SBPNscK5f6dypCimPvTdZxQgcAGj3VVlM9uX66Oy7Fis3n1UmzFir3SsiR1Z8apuXP
         xjCKI8b6XnW61pZ+W1RJGnlQoJ957aquQwBHB/kY2ntsgfZaSwh2xiTtg+S+bY4f9hBe
         hCE4U3knV31IBQ+pB2e4lQFyjPL4T99H2zhIEah60yLE0s3jjrIeFYcO9krwNzXijabo
         eehMgD3ywDUoeoD2DsIqh4Yt00e+2II0igD+ryKEhIujlSkpmDAaJIWLmfnpCX9iB93q
         NNSmsWUgNfeI/QQ7k2JGSaw5w1eZGyCHurXxXF2L8Z5i5UOKfvq5rbV0nlijvc4y2kUx
         cQJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWcgVOeWh5xvF4wGY5yp6hJBifrIfaypAe75EAM8Y1deay1eWIwm8tATC1zucCvu8po2qKG62/+9QgcwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPPmE2UQ6PPOP83A0MBP5QeQhhlqjP7LiQ6HKg+0T+bD5OeLI8
	Gk699+PhCN21eUVqPYS5Pl/mXUhFzhCKDr9SFG4tVhH+e+I3IcjXHh/+
X-Gm-Gg: ASbGnctq0z2Z9QSqlFr+749T3PyLvxZO3S55vBE85/hyarDmFMTClyytoJx+xvvy/+6
	afVMQll3g7/qw20jXbDIj7JA/CA6NYgHZKx8h0xJCjEhnTa8QLQnJMuwgibOgIt0vvA05Bi7QQ8
	guIJFZw99qf0+55QGybV+EpLSfr3C+jzV9hUh0Yff4YP+4ywAxKgfYWwgnX4vByptG0qnNof/Hz
	yghUlwhzHjUfbJce1m7aa6T4feMuRbsmGuI3LpJkBAJGKgZcmPkfXVK5/o5EXyVyBVRPSAOx4LZ
	6Q1re+cVOs5cJxdgLHZCWWlsqIfmL15PulNiWyZGI5e7uUWTGxDCbk0h0czg9NN6reZJTVA6ilE
	X1tE0YgQAbhlNz2VICmZ4GA==
X-Google-Smtp-Source: AGHT+IFDydZFQrkosnxXfosEK8EVZgkb6qLnlT4kiVd7o1+cVB/7rTEUO0G9UdoGYY9iwV3LjvIXOQ==
X-Received: by 2002:a17:907:3e1d:b0:afc:bcfc:b3b7 with SMTP id a640c23a62f3a-afddd0d283amr142302066b.38.1755589182644;
        Tue, 19 Aug 2025 00:39:42 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce53f2bsm973006866b.4.2025.08.19.00.39.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Aug 2025 00:39:42 -0700 (PDT)
Date: Tue, 19 Aug 2025 07:39:41 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Justin Stitt <justinstitt@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 0/4] mm/mm_init: simplify deferred init of struct pages
Message-ID: <20250819073941.esl7z5ibqqeabunh@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250818064615.505641-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818064615.505641-1-rppt@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Aug 18, 2025 at 09:46:11AM +0300, Mike Rapoport wrote:
>From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
>Hi,
>
>These patches simplify deferred initialization of the memory map.
>
>Beside nice negative diffstat I measured 3ms reduction in the
>initialization of deferred pages on single node system with 64GiB of RAM.

Nice cleanup.

For this series:

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

I guess the speed up is from "use a job per zone". So we do initialization per
zone instead of per memblock range in the zone, right?

>
>I don't have access to large memory machines, so I'd really appreciate
>testing of these patches on them to make sure there's no regression there.
>
>The patches are also available at git:
>https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=deferred-memmap-init/v1
>
>Mike Rapoport (Microsoft) (4):
>  mm/mm_init: use deferred_init_memmap_chunk() in deferred_grow_zone()
>  mm/mm_init: deferred_init_memmap: use a job per zone
>  mm/mm_init: drop deferred_init_maxorder()
>  memblock: drop for_each_free_mem_pfn_range_in_zone_from()
>
> .clang-format            |   1 -
> include/linux/memblock.h |  22 -----
> mm/memblock.c            |  64 -------------
> mm/mm_init.c             | 195 +++++++++++++--------------------------
> 4 files changed, 62 insertions(+), 220 deletions(-)
>
>
>base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
>-- 
>2.50.1
>

-- 
Wei Yang
Help you, Help me

