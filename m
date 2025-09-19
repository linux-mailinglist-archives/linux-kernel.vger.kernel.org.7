Return-Path: <linux-kernel+bounces-824807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E299B8A301
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CCD1CC00CB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A6D313264;
	Fri, 19 Sep 2025 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Z/K4B9X"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA43E314A66
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294497; cv=none; b=tqt4zDdcwse7vw39qJYvqQ7M1lOMp43EQJdfPZ2OVoY5CAnLKyZz+CWZCiQGbB458qXAes+BPjpWkGMgqS+5h3chbhchrDsdy8UxlxOiMm7LxeWWr5fzncTeYpjSmc5VyeaSwU/C8MtQYc1pE7c8Xc1YG4eGwdQPw2MPKI0bl/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294497; c=relaxed/simple;
	bh=LFmZTAQu6xp1H90eoajASSZ3CmnWB3SEwm5mOewzT+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3HOcj4n8K4otoDqZeRvLi9w5t3LJXgZ6tat8aKSSmZCgGP/23vP5FNBBwy1CTUp8kNGQQ2WsmKz5sdQ/uls/KVKKtOcNt+UFkC0UrO4dAqz6DT4/uDThHll2grEK1ogENherTNpF+1vn4FYZgKDlyPZRpJfh9AuX3vsQQexyYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Z/K4B9X; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7f04816589bso220833785a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758294494; x=1758899294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFmZTAQu6xp1H90eoajASSZ3CmnWB3SEwm5mOewzT+c=;
        b=0Z/K4B9X5738MGfMqOKpD3WwNb4cORUHDzzxhKW2ALgC8FHrV92lpbWZysSIn3rAvU
         OOxG0s5hAKICwoSHQbBGyu+1rk8Jiz7C54Fz2cKjwOQxfrQmvCk80zTlwcrO7toIyAoV
         iamrutRis37nYKihP89VXeTlNZisi3Uv/c9SP+3WwQe1V1ObPBivW7CtXFID3BVMdKXK
         uCCAJEvD4yZot5OjUvWW1CGWaCDMYfVvDOys7+8jgEd1v2/BtuMQOLoKS9UO1w6ne3cH
         7q3zlEyQkVy4j8TM+VqyEErbsbayT75fJzv6lVZOAOfiIgGRz8t4dJB2BC00ZkGwcTWq
         qBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758294494; x=1758899294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFmZTAQu6xp1H90eoajASSZ3CmnWB3SEwm5mOewzT+c=;
        b=qd86AQSvFNPZ3hLwxFBYmEnPmhAcTsWClYk9h5IYxDopNruAfmo8vIyHmQWJY7B04F
         JK9Faj2hRQTmsm7A6tLyLmbpHTUgppR9EWP8DaQD3piMhn4LuBfP46Zze10GdFS7Q0LP
         pfNRgo+HrwfHiERYDPjuCbiY2wRU7JX3SApXjpklR8axOHiKUsAA239XLrKPorHVl/sb
         X2l70qZhLbTv1KVLZ1RN8jxCgjj9Uk+o243RXtrCdtvt5BzBM1KoN1Y3PkE1HJXfbNZX
         jbxT9DIA+KInnF3GWyYJfC9OLOXOAqUV0mwWvSouCWCSAQHh5T4DPakSMDVcHMtDLnGN
         A29Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6vuiXibOdV5cK2OKp3fDLDuiCa4J1tq5NG79A8uIc/JgPJ4Foy3d/8h7XLgqXiJ0QD5QXFEanM2i2g0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YymFCyWh4LNYFbCkWCFqrEFIRvT5j0IIQK9bIQfhV9eLDsTSr8W
	+zlvn2iqOMZLsNkLf3MmkI9HvALH/7+ktUgQwQwQkCX8IK/BR0A289rIEDiZ96vHtc54HbETbMR
	cVhXPq8HescpP+zpfNnAgQbRy7gDQUGF+S4vajUNK
X-Gm-Gg: ASbGncuvb2YZQl2CIP5lmLthvLijQscu24OUymwN8NzbdAcuB+YmGD5dtmqwYjZOl9f
	XZ+CbxatnU6U9MphUOg8WzGfDzfmgxJzd73vZnaFd14Q6NQ/KR2f0lRXNvQP3CBkUGoIuc8NUuI
	ZRw6wRp9lL9ZkP++TvsdFyJOl05t30EID1EgDFVK4r3paZGSZB3pbQDrZbxP7DQp4217KNdhQpy
	0vDXlTio2SyomfMV47B+1C+9Ly/N939RqVnhQ==
X-Google-Smtp-Source: AGHT+IFR40Mffz39BAytKY3HCLacxnJ1WKp/TI2KMqqv5ab7iIIVbpHo/r7oLhpjnTyf+invw9UKbqtbStpZDWCH5zU=
X-Received: by 2002:ad4:5d66:0:b0:710:e1bc:ae42 with SMTP id
 6a1803df08f44-79910e91071mr49973476d6.10.1758294493230; Fri, 19 Sep 2025
 08:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com> <20250919145750.3448393-10-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250919145750.3448393-10-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 19 Sep 2025 17:07:36 +0200
X-Gm-Features: AS18NWA8NT9J6yW558WFqJ9v7KlWvLUFu5ioEKltNkloZ03huDtjBzwZEdnYYKc
Message-ID: <CAG_fn=VVWKR0JLCTZ8HvB51UX3EYrFg1s_xD-ohOKDQwDHOxHQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] fs/binfmt_script: add KFuzzTest target for load_script
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, andreyknvl@gmail.com, andy@kernel.org, 
	brauner@kernel.org, brendan.higgins@linux.dev, davem@davemloft.net, 
	davidgow@google.com, dhowells@redhat.com, dvyukov@google.com, 
	elver@google.com, herbert@gondor.apana.org.au, ignat@cloudflare.com, 
	jack@suse.cz, jannh@google.com, johannes@sipsolutions.net, 
	kasan-dev@googlegroups.com, kees@kernel.org, kunit-dev@googlegroups.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lukas@wunner.de, rmoar@google.com, shuah@kernel.org, 
	sj@kernel.org, tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 4:58=E2=80=AFPM Ethan Graham <ethan.w.s.graham@gmai=
l.com> wrote:
>
> From: Ethan Graham <ethangraham@google.com>
>
> Add a KFuzzTest target for the load_script function to serve as a
> real-world example of the framework's usage.
>
> The load_script function is responsible for parsing the shebang line
> (`#!`) of script files. This makes it an excellent candidate for
> KFuzzTest, as it involves parsing user-controlled data within the
> binary loading path, which is not directly exposed as a system call.
>
> The provided fuzz target in fs/tests/binfmt_script_kfuzz.c illustrates
> how to fuzz a function that requires more involved setup - here, we only
> let the fuzzer generate input for the `buf` field of struct linux_bprm,
> and manually set the other fields with sensible values inside of the
> FUZZ_TEST body.
>
> To demonstrate the effectiveness of the fuzz target, a buffer overflow
> bug was injected in the load_script function like so:
>
> - buf_end =3D bprm->buf + sizeof(bprm->buf) - 1;
> + buf_end =3D bprm->buf + sizeof(bprm->buf) + 1;
>
> Which was caught in around 40 seconds by syzkaller simultaneously
> fuzzing four other targets, a realistic use case where targets are
> continuously fuzzed. It also requires that the fuzzer be smart enough to
> generate an input starting with `#!`.
>
> While this bug is shallow, the fact that the bug is caught quickly and
> with minimal additional code can potentially be a source of confidence
> when modifying existing implementations or writing new functions.
>
> Signed-off-by: Ethan Graham <ethangraham@google.com>
Acked-by: Alexander Potapenko <glider@google.com>

