Return-Path: <linux-kernel+bounces-782651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC234B32328
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3024B1D27FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CAC2D5C64;
	Fri, 22 Aug 2025 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUWpPkOs"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7817929B20A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891972; cv=none; b=sS00CaemC9GmEL+5XbEeuN/NUI1dIoUj6uKSB5LGkW6d+yUHmnc7l6cmywq/EdPL9WQbEo69bZh+LsAbfRqwWXhRF5DYvov38HeN9UdHl9ZByUHy00c4oKhzzFfinxUNAymfEsOpLFtpfjjvYbAEYnJbAYTKrJy36QVXOwR3lk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891972; c=relaxed/simple;
	bh=XBIUH0wquQctWkgcUJPdSrr7nfWPNHBoFiNbn8Q/vok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUvEjEECgdov9BN1RV6zFYN60hNe2hD3+7fFmGr8kbyQ8/RpDpdsb4+s0AgyeADTq40hl/9EKn6WYbOlH+OZcWjJW+j2X7zK6AEUmCinq4ii1A/lKdSLdxROMefr9XuNAe+9rND6HlWEULl6gDrPWTm3WKX9GpLL0J8CjKZJkt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUWpPkOs; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-618660b684fso2001a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755891969; x=1756496769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDGPq2QAoamqAsn96zDYfVwrsh9uyHlSfDp4Mt63PH0=;
        b=iUWpPkOshd2mUXVt+rBH22eNjxhtSdMpQMdXL+Sg76oTxb0XrNSBPb+ygkQQox2iH8
         RuZziDcm7Omrsv9tS3dEQrMSrhCnRnOWspTBcpkX3TzniYxwfYNUyfkh+H1dRymc0Uur
         alpwRFGLngP6PYeq6DReukClGyT59aKk5pwR0FtwRahPUDwWliTXwROROw4+kuCMQ+8c
         XFcjseldZGzUEFLij/x34u7USjHWBLzPN186BEmjtNEo2grwJXOAIvBwWBK8yMWYqnii
         T+UTquaAiGBJwI4FnYWqHg7W5QemP3VZ9VSOIGJCBvn5UgO767o4GXvpDi1CP9sH6Lh3
         eW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755891969; x=1756496769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDGPq2QAoamqAsn96zDYfVwrsh9uyHlSfDp4Mt63PH0=;
        b=ZeJopsaGMjBnH6w/nSd2afeSAsOo7p/OO5ddhUFJGpAOyjvpECkrhtr517YpcMiS3Y
         BlO3WsBqPXBqamykIrXel6e0wkG+zb441Kd5tBJ25W6jR4l5u/FixOA4Y4DS1SSg6A/Q
         mR5r/WSquRsNh6UKBnYu0vvHwscTkx7f/yzXk6VqhPcG/qYpuY5VqQUeBDg5OtrBtxGI
         m0FIXqrwdMnC1du1VmLir0L9Q0IX42JMZnMTapsOQelZi9ENkqf+fPEkIg1otxWo02vP
         fIutb+49+ycynT5JeN8GLWTsrfkTo5LOQF6kuCXvMrsKFdWShBv4KUKb9IeWYBtjudhs
         kWMw==
X-Forwarded-Encrypted: i=1; AJvYcCXMBuSK1iSSL4nJEaV/7EVK91oxIssHuj9i/4KSR2wF9KoR+L9wIGC9Moptr983Bk3iceFQXhQYcTv0VqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrqdkokJd8Ia7/8LTxUNm2upSdI0RnG0GJvE4VKhmEMLy0htdo
	uuTT+OwmXxvyYt6YS9VyxP1PHc7UtJi1QjSImsJyC76eF5t9PcK5G7YIlHT2my5dpRHK+eKg+FX
	Ak2RaUN+ZaToCEJcAuMC9d9I0NTwJ5GGZLeKPA8Dg
X-Gm-Gg: ASbGncvMkjtWpGccVUvSCu87sLo+CdAL1EgZJX77SvDcSgWdR9v2LSx4N37DDiSUweO
	sce/wmfos93djvgyx7jRKRKkqIdTdVSqMiHZbIKgemizJ3vd48EOLqxTpeVbZatCjYbiFlUk8UQ
	IuSgkJCZyl4y1wSs9g0Y9UgxPFq5u5lU7F5fVcUicQ8dSh7NDrLd+8TIgHehiEFpGW/W/e1KvYT
	5xcc6A74eV4gmLA1nlpkY1HbHS3BJTOcI5JcMk=
X-Google-Smtp-Source: AGHT+IEp5JtOIpLeEMiI4+ZgwDstAGg61BU3UaS/vBzIt/3oQq6zs0o3AsSV2sCxqe1VwQ3ShoALvJizriSBAYLp6Cs=
X-Received: by 2002:a05:6402:2393:b0:61a:590c:481c with SMTP id
 4fb4d7f45d1cf-61c361f8759mr8808a12.6.1755891968513; Fri, 22 Aug 2025 12:46:08
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822170800.2116980-1-mic@digikod.net> <20250822170800.2116980-2-mic@digikod.net>
In-Reply-To: <20250822170800.2116980-2-mic@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Fri, 22 Aug 2025 21:45:32 +0200
X-Gm-Features: Ac12FXwjpgWQzX75-i1-fxwmf--db3NEnzMzNGlpF6QflXz8uRcHgI7dwyXvzpA
Message-ID: <CAG48ez1XjUdcFztc_pF2qcoLi7xvfpJ224Ypc=FoGi-Px-qyZw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] fs: Add O_DENY_WRITE
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Robert Waite <rowait@microsoft.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Scott Shell <scottsh@microsoft.com>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Andy Lutomirski <luto@amacapital.net>, Jeff Xu <jeffxu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 7:08=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> Add a new O_DENY_WRITE flag usable at open time and on opened file (e.g.
> passed file descriptors).  This changes the state of the opened file by
> making it read-only until it is closed.  The main use case is for script
> interpreters to get the guarantee that script' content cannot be altered
> while being read and interpreted.  This is useful for generic distros
> that may not have a write-xor-execute policy.  See commit a5874fde3c08
> ("exec: Add a new AT_EXECVE_CHECK flag to execveat(2)")
>
> Both execve(2) and the IOCTL to enable fsverity can already set this
> property on files with deny_write_access().  This new O_DENY_WRITE make

The kernel actually tried to get rid of this behavior on execve() in
commit 2a010c41285345da60cece35575b4e0af7e7bf44.; but sadly that had
to be reverted in commit 3b832035387ff508fdcf0fba66701afc78f79e3d
because it broke userspace assumptions.

> it widely available.  This is similar to what other OSs may provide
> e.g., opening a file with only FILE_SHARE_READ on Windows.

We used to have the analogous mmap() flag MAP_DENYWRITE, and that was
removed for security reasons; as
https://man7.org/linux/man-pages/man2/mmap.2.html says:

|        MAP_DENYWRITE
|               This flag is ignored.  (Long ago=E2=80=94Linux 2.0 and earl=
ier=E2=80=94it
|               signaled that attempts to write to the underlying file
|               should fail with ETXTBSY.  But this was a source of denial-
|               of-service attacks.)"

It seems to me that the same issue applies to your patch - it would
allow unprivileged processes to essentially lock files such that other
processes can't write to them anymore. This might allow unprivileged
users to prevent root from updating config files or stuff like that if
they're updated in-place.

