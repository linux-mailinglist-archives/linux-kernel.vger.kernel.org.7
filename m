Return-Path: <linux-kernel+bounces-894963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AE3C4C91F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC1C3B71C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781B5261B62;
	Tue, 11 Nov 2025 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="re7owBYY"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C84E21CC59
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852110; cv=none; b=L3PTBQVjoXVrs/nUDn7k2It9LGuir27Ou+bqOjDhm9/sMZmgO9QkHfYOVdyzUQedxD0/LzwzqOD83brsLCoXUVNguOjwf6GfXXE9aunp7lgfr0CH3YdEclzUWjSPUnNvosDQT6e/ydgkGTGutqg0ku09AW2UmdcsP/UViQZwpWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852110; c=relaxed/simple;
	bh=T+mH9+7PNLYr6Z/2ln9TuMbRS+qcoVyhy39YsWeg6dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lhi9bWkoPX8LCAF0HbnQnZohBR3B/bWmYs3kLWSyNYxqvDV7OUnpqqBgoi56zN/fGpCBQet9QhA7dxht2RMrfZu5sOgRP0XiHt9HS4q2lqx1fvzYHyOfmPxA3QsDQrQxtc6teaT3EeaXDhSjsxh4ItFLn9whdgal7roOkVX6wQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=re7owBYY; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8824888ce97so28385166d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762852107; x=1763456907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+mH9+7PNLYr6Z/2ln9TuMbRS+qcoVyhy39YsWeg6dI=;
        b=re7owBYYJrPTlSNKQcwaizDxrcmieeRuYuQ41APdnT5aR3nqNB71/0eTrKHKW25OEP
         jTynEBUFpZV66AhtMhI4jLnGlfZIyJUVU4EXJ28JpI+PZkDvTnFJWHV+dI+G7fSkkBl0
         Dkq+syf8qK7jZJwla9m/9JurteW6JeSWRIUkJQ6wehbDMLDroCObvJY7rj8Ia3x9jzEr
         UShxa6heHm1cRyWSTdS3baRg9U6ikWYyBl8Gm8psmNKIBh6X4j3lkN2OAhpPlNZP9AWe
         Ub7W+NwTMX75zZuf3tosBVf37Te4F/toDtjYuVISvXTwJj3CuZVop913uiuMZaWwE2LT
         HmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762852107; x=1763456907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T+mH9+7PNLYr6Z/2ln9TuMbRS+qcoVyhy39YsWeg6dI=;
        b=Sik421V1YBxyzHrOtkezlQTGHVmz9w2oiqRXkpGDyqzTgryIewp5vXNGHAp2gDO+Bi
         qWfZbEat0TAz+lsDoXRkygP/GkJP0+KyavXjXuG+dEdDt+bwvaeLAWSCi3VzgbAzIhb5
         vqwrU4nyjRo2vfOBg1TsTg+ONORbT9ev48kq/G7thnpI44d87Hp5qZBtCAFCXnPGgViS
         PrZFS+Tt/FdE/2/P1bo3pUDLXAYPfyfjdm3V0S+EScuzn93oVnZLpHGKDzIuJ7FFTym9
         ViLFF15Lj5h+pzzxk9+lAFuT/yI4aHYRwZdnpNJAQwmYZ64626rPxIHa6aUVwPHtVUhI
         uhmg==
X-Forwarded-Encrypted: i=1; AJvYcCWehjleWQj9QsoY7xIHZKxJvwEPwXYdz+AcWFxlVIe1la9vJplj1Th2bOWsWAaSIGzAAdXAQ8uZlkEeVKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4LXJ71IPi5Sq2RjLPi+HEIU/00PsZZdlTigA0lfx+78Re2wc4
	GtcuCfgq75gyoooc43u+0bHr971arxTSd/v23+/fM644dmpwLXidwPpEfpyq45yw4hu/IAnTUwb
	XEPXdfUwt2QsUORo6ABd3gDmjx7kmnBsnKMBJvdGf
X-Gm-Gg: ASbGncttkgU23qseCGf9ALmv9Qh0o9ROv4YE3tLNDar1+2k03KK5hguL8fV8xHImK3R
	ygjPYS/0LWG95G6pAEIxzBJbGeonqKQTaq8G1zFJzikuUdZuXmoX206j14IBZDLcKPMbZo2oH8Y
	cUAng+6li+2oniGZfYfW6mcyrN4uEx306EC2AxOMoGMm1UsEcg6F+ybAGRK/7B/UdM8UA+plLMg
	4oeBYkSwK7k3F1d0uUsiKcrCx0vKkDN+ij4uekDMgDy6VSXIjKRJXrVFi8PZGv1uSW8PqfrJrQ7
	5Gozopqd6ohm7+IhvcXq1wc9FlgmZ8fJ2L+I
X-Google-Smtp-Source: AGHT+IGGiGzNQ2eAyJqdaO9JyMrXkP7w+emfDXwZMPoyyY2gy1i/zUBgnLRf870LMq5UXpv/uG8YRTM2WfKUuwW/Bjc=
X-Received: by 2002:ac8:5751:0:b0:4ec:f4be:6b12 with SMTP id
 d75a77b69052e-4eda4fd3621mr141844221cf.72.1762852106635; Tue, 11 Nov 2025
 01:08:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761763681.git.m.wieczorretman@pm.me> <56d9203b1fcb6281b0d29b44bc181530e5c72327.1761763681.git.m.wieczorretman@pm.me>
In-Reply-To: <56d9203b1fcb6281b0d29b44bc181530e5c72327.1761763681.git.m.wieczorretman@pm.me>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 11 Nov 2025 10:07:50 +0100
X-Gm-Features: AWmQ_bksKNIR8oRrvQW5ElnBBjqadCFUKWpQKwYmKonXZ13JEF-XHOSa5ehktsY
Message-ID: <CAG_fn=U3SLOoy_K-2ShOMYf80i4AE1tB1AL4w7wcJAXBxi+PtA@mail.gmail.com>
Subject: Re: [PATCH v6 12/18] x86/mm: LAM compatible non-canonical definition
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: xin@zytor.com, peterz@infradead.org, kaleshsingh@google.com, 
	kbingham@kernel.org, akpm@linux-foundation.org, nathan@kernel.org, 
	ryabinin.a.a@gmail.com, dave.hansen@linux.intel.com, bp@alien8.de, 
	morbo@google.com, jeremy.linton@arm.com, smostafa@google.com, kees@kernel.org, 
	baohua@kernel.org, vbabka@suse.cz, justinstitt@google.com, 
	wangkefeng.wang@huawei.com, leitao@debian.org, jan.kiszka@siemens.com, 
	fujita.tomonori@gmail.com, hpa@zytor.com, urezki@gmail.com, ubizjak@gmail.com, 
	ada.coupriediaz@arm.com, nick.desaulniers+lkml@gmail.com, ojeda@kernel.org, 
	brgerst@gmail.com, elver@google.com, pankaj.gupta@amd.com, 
	mark.rutland@arm.com, trintaeoitogc@gmail.com, jpoimboe@kernel.org, 
	thuth@redhat.com, pasha.tatashin@soleen.com, dvyukov@google.com, 
	jhubbard@nvidia.com, catalin.marinas@arm.com, yeoreum.yun@arm.com, 
	mhocko@suse.com, lorenzo.stoakes@oracle.com, samuel.holland@sifive.com, 
	vincenzo.frascino@arm.com, bigeasy@linutronix.de, surenb@google.com, 
	ardb@kernel.org, Liam.Howlett@oracle.com, nicolas.schier@linux.dev, 
	ziy@nvidia.com, kas@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	broonie@kernel.org, corbet@lwn.net, andreyknvl@gmail.com, 
	maciej.wieczor-retman@intel.com, david@redhat.com, maz@kernel.org, 
	rppt@kernel.org, will@kernel.org, luto@kernel.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, linux-kbuild@vger.kernel.org, linux-mm@kvack.org, 
	llvm@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:08=E2=80=AFPM Maciej Wieczor-Retman
<m.wieczorretman@pm.me> wrote:
>
> From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>
> For an address to be canonical it has to have its top bits equal to each
> other. The number of bits depends on the paging level and whether
> they're supposed to be ones or zeroes depends on whether the address
> points to kernel or user space.
>
> With Linear Address Masking (LAM) enabled, the definition of linear
> address canonicality is modified. Not all of the previously required
> bits need to be equal, only the first and last from the previously equal
> bitmask. So for example a 5-level paging kernel address needs to have
> bits [63] and [56] set.
>
> Change the canonical checking function to use bit masks instead of bit
> shifts.
>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Acked-by: Alexander Potapenko <glider@google.com>

