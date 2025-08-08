Return-Path: <linux-kernel+bounces-760369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D1DB1EA43
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 036824E45D2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4447727F187;
	Fri,  8 Aug 2025 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="PZj0p3P5"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7663594C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662888; cv=none; b=EjAZHogIvKNLBUPdO1PJr8oSeyVdegKThoaSspfTyiPS1xpsSsVKMTINGU1rD++qDZpd2WfjEwgXFDqgGtddMlo8pzobD7vW5J+JeESLjY5MaSgAuETBysHP3JrEBRXYVcqQiK9HqTnAUBTyVZLj+EUd/je8ShI4qXcJ4QPHbd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662888; c=relaxed/simple;
	bh=guHzSvaBeM/USIv5SatPspIVxLVMpHFVg5Q5uwqdIbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjEm2wqEJUQpfH4kHubgl5xP2MMMLHwmykGFBWRWwOFQQcnQZxsJoER/MqJuDbEEgb1ikk2r+s0Ellp1gmqU4kuPHEVv6iufE7fCe02wWb4dZg3YVkSXc61i65LrD/YjzmxebPjrV+Mp8CNGvQVuH6v1vcqgwrEVE23zhjDk2UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=PZj0p3P5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23fe9a5e5e8so15430235ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1754662886; x=1755267686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guHzSvaBeM/USIv5SatPspIVxLVMpHFVg5Q5uwqdIbc=;
        b=PZj0p3P5CBkpC1ECOz705VGFb8J6RNwNlXIudjLxUC7dW8mRAUK741EnSstTlbl79W
         j2NuDXxtVb8wAAe+GsljSTGc4JNhg6tPJeXLJCSena9bj7oR0yHhOE6HjwvNCLwXxlGt
         XNxUUza85f4MQBE+tnGrqiY1/yolvyryy19/SZLwUaO6ouNfZTRp060znR6ZEqaW3oCz
         SdYFPb2g3pG1LyChwiQH+E1pEv1MEOtlzlub24n7r6YCH7Eav0NRMK9iWCX3BgiD/Yrt
         SrOA6FqtAqE2j4dI06vYGeY4frLBiBLjCUC3VEzzMuRUUBQ8TjKxRud0ctjHkrH7aqWK
         /XBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754662886; x=1755267686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guHzSvaBeM/USIv5SatPspIVxLVMpHFVg5Q5uwqdIbc=;
        b=B2CAfU5Ait0VgAEWMQzshNw3X/BtpVIY8q5KmBnLqB8uoHjfQpn74/TsrOB9XkUDbe
         WxFDvCoiUXKyHaEhrwk9l8KugnUxYlNyRyCJBXsrugKUiz/FkLBBIfvMhDJzYElkTCPf
         yef1y5NzSrbGbCzydGh3EEEmPQ2yOOwr/Nc7YPFxhfYBc7Uf6CSyRK6/bYquOmbCnI4l
         GDPg2SUBHRPg1CWcRwe3CSw/1fwY9R6vXdvDp9h7FXrMZ+sf74qGTPFTzAOeaYfrKXOw
         QOhHAz/QPAHpUhCD3Z0vZYsoDx/K7PSOg1rxbMz4bYm5C6M9G8laBHt8QnRCK7cgMdbY
         COWw==
X-Forwarded-Encrypted: i=1; AJvYcCXJeVu8Y/pc41uArJavqiIqu2M1nwwUfCY6GTjXL6G1ucshamnGq2aaeLS6Jsvo/2s6Itcmj+XOScm9GP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgSoWFZBbIkxXdL7NaapEdmAbH4vYTpX0K6FmHKqberVFI/Yfn
	gL2vUBAXjnyLCSg0yz+z7aGJF25tBAn/4lgLs1ftmsvASZp+8Gfdg66E8wOSHADZk97VUxoUk8J
	qzTzTX5pMGlc36pUvt0ZU512oAjaxC0n0C7VwgbUGIA==
X-Gm-Gg: ASbGncuwnNOPvS9gzUs9C+VNkZDxQDxWb88uQ10DGAciT0LDRvYMgG+c5JGnBG64TT9
	6ZZM+F37f7V4BcgU0zZkYGDT8z2eJJeojbTHM2Mjzps6C2I5CzAslWUjTPQfiHkYLFrnXrHzfqX
	/UcwfKv96YgXyD8cLRKhcxP5mdI76weeFIZBnvWLVXFAcjZFaA/OeizIMfIbvMPvSIzOKZw7ap6
	emkFQ92JBbNFxwvClifQktJBOamqpmvgw==
X-Google-Smtp-Source: AGHT+IFmZBg5ZwAP49VEb5vbGDIowxD/ct5MdC1b9On5aGdv3/h76JvUwtRiU/cQG4Jpl3vV708BLdqG7GyflYMwLpo=
X-Received: by 2002:a17:902:fc8f:b0:242:b42b:1335 with SMTP id
 d9443c01a7336-242c2059ca6mr52927975ad.22.1754662886384; Fri, 08 Aug 2025
 07:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722150152.1158205-1-matt@readmodwrite.com>
 <CAADnVQ+rLJwKVbhd6LyGxDQwGUfg9EANcA5wOpA3C3pjaLdRQw@mail.gmail.com>
 <CAENh_SS2R3aQByV_=WRCO=ZHknk_+pV7RhXA4qx5OGMBN1SnOA@mail.gmail.com> <CAADnVQLnicTicjJhH8gUJK+mpngg5rVoJuQGMiypwtmyC01ZOw@mail.gmail.com>
In-Reply-To: <CAADnVQLnicTicjJhH8gUJK+mpngg5rVoJuQGMiypwtmyC01ZOw@mail.gmail.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Fri, 8 Aug 2025 15:21:15 +0100
X-Gm-Features: Ac12FXx7v-SSukGf47arwGF9TbWihsALELCDJDlaUcJ6XfDaJwfnJlT_e7TVQHE
Message-ID: <CAENh_SRxK56Xr1=4MX4GhZuc0GF4z5+Q8VueTK0LDLj3wg_zXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Add LPM trie microbenchmarks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 5:41=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> well, random-key update when the map is full is also quite different from
> random-key update when the map is empty.
>
> Instead doing an update from user space do timed ops:
> 1 start with empty map, update (aka insert) all keys sequentially
> 2 lookup all sequentially
> 3 delete all sequentially
> 4 update (aka insert) all sequentially
> 5 lookup random
> 6 update random
> 7 delete all random
>
> The elapsed time for 1 and 4 should be exactly the same.
> While all others might have differences,
> but all can be compared to each other and reasoned about.

Having both sequential and random access for the benchmarks is fine,
but as far as I can tell the scheme you propose is not how the bpf
bench framework is implemented.

Plus, handing off a map between subtests is brittle and prone to
error. What if I just want to investigate the sequential access update
time? The cost of the most expensive op (probably delete) is going to
dwarf all over timings making it difficult to separate them and this
scheme is going to be susceptible to noise if I can't crank up the
number of iterations without altering the number of entries in the
map. Microbenchmarks mitigate noise/run-to-run variance by doing a
single op over and over again.

I agree we need a better approach to timing deletes than what I
suggested but I don't think is it.

