Return-Path: <linux-kernel+bounces-777123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56489B2D59A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1232A3BBB13
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A9C2D77E3;
	Wed, 20 Aug 2025 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w00Abl7L"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CE71F3BB5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677053; cv=none; b=V85WweglZPUQHizVYuqJlXjn0HtM6pXBE5y5E+NyxYZCL7ezfyJW89hUHfh2foKmvwA6a65ZbwNjnKossVGM+e0NY/sPncI8pX5mISqmPyFthIRvuzYbWRIKXiogize4GORG6cfXi9aWygGM2N8bDJH1vfMOpbNcSnnJGYBoDAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677053; c=relaxed/simple;
	bh=rbFXFjw4n1QivhuWIRmAWtZ9fMtej7RhLcACXFP/i3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nno0qkxSgyxQ3QgQUfbbJGQbzh/LhY4qDSIax+DWL6o5YSRV+nGSUcbpqj2XAfTLtcGXw0wzPDNERKkm77R0/kQlyih2IM6/TXJbHRrgdw690Z0N+qmKIberEbvQfWLXDsqdHF0DqEIT5DsYKXf+robG4FqSpyw+PQEtP+Q9RjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w00Abl7L; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55ce52658a7so5911845e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755677050; x=1756281850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbFXFjw4n1QivhuWIRmAWtZ9fMtej7RhLcACXFP/i3Y=;
        b=w00Abl7LIysvda5RITxZ3gyLq4xfappFa16LgbiYLPykC4dnMwAOUnsC/xSBnq7nW/
         qUU3yqZBVi7rfxH90gQ5a7pra1XDv1lIB9MS8r8MxKzWYF5GS7awXgROujXmCF47gCrQ
         oksu2jb1sZCFRD9qKTPEqZ5HuMy4Kbw2u/mkPXuU2jenNXN9aPtMsHjkibtHPMvB/CsQ
         7yhAuqMmnf7vf+MIYqZQKHI1F02/kuJAZ7nKGF56KGmtIDTHeliKk7HlaFFSEcLm+k5x
         W/XI1SLMshLnGDimdkgy23AeeBscKCQ22lJlFHJWoRCpgqH4jlGnbjcoE2HdMJpHbwdE
         zu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677050; x=1756281850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbFXFjw4n1QivhuWIRmAWtZ9fMtej7RhLcACXFP/i3Y=;
        b=NyKvjMJjuHjE1YtL+hO2HQPwgisr7F/luyvpos+YEb+IAIzFYDCQozGUsZTNqzql4y
         a7CFl+3XMkKUBt/2z2DRRK/O2fUc7SD4kc9kj+U3k7IKhOC8CGKXLZ+MRr2injB6Dj74
         jl/QouXC9amfYJljq6A/dydTmMtbIkxhDuUrzm8IYtYQnXCQybGMW6mvtNda2ZeeD50v
         8h2BBGIPomsnrA8wtindPwycwJPFga5j5UAcdmp5+cXYu/z936UsLWVXFYPRaR7e9rBa
         yogkypC002Ogak6R8gQOef/YudUruCEEb3+vk+y3hDzuvdK/nB+f8S9OqrkuyghfrJBr
         s8Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXhNin5EdTc/utwe3mamWjle69StH1pYvJbHEFfuHVZOGQZV4HEuJ+T3SDn2dJh9AvpqojHamYY049tCeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAkeNmwYIkriNiUFwVxIPe/wL4Jla7ZaGJN+eY6kObrelP+CqB
	qUaQh3tbNyGaKIim2suPgLm6hCSUScOpR4VzjK+OCG7TNvh+62KFIBgf+HIuoDYh9wHbAWDxdLE
	CkECIdTG6sCbaMz1Vw8D0lCLqUmss5QTYuqnSKU4=
X-Gm-Gg: ASbGnct4mISsdMsg7p5AAukWEbHGkTutfWZQ4t/BqqSWa4r1IG+75wtjYAROHJ3QLRW
	GHS7pL++G/jqpdMdtzmbkFE3ny8cmOQT6i8HCUGtkduBycPcymXDwDv3/+Gf4PR/JOATqHP6Ur9
	1bTAcwsu99DHLxKyRpBViX6d4ckhlFdCtJ3LjQmWiWbtccc99Rr1jTlCIUeMflW+VQoD4KESqRe
	WVpZ0loABdtd3yJ8CCm0KxO9/mo2m5jJEw5YOJFMC05OX1ezgFZkQ==
X-Google-Smtp-Source: AGHT+IGVK1oPtxH4WR1xR8qF9qbjjy/dcR0lYEGwtgT9scAs4HhXg+zq6box8q/WjPnqcqOrs9UAS7T3jjVlqulmz2U=
X-Received: by 2002:ac2:4ca9:0:b0:55b:732d:931 with SMTP id
 2adb3069b0e04-55e06b2dd6fmr405525e87.12.1755677049307; Wed, 20 Aug 2025
 01:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de> <20250701-vdso-auxclock-v1-12-df7d9f87b9b8@linutronix.de>
In-Reply-To: <20250701-vdso-auxclock-v1-12-df7d9f87b9b8@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 20 Aug 2025 01:03:56 -0700
X-Gm-Features: Ac12FXwkxxvaSnLooTWKfhclqEnR_RwAuKEDNHPFBz1DnCC5Fudpwl3wjm0bVsk
Message-ID: <CANDhNCqvKOc9JgphQwr0eDyJiyG4oLFS9R8rSFvU0fpurrJFDg@mail.gmail.com>
Subject: Re: [PATCH 12/14] vdso/gettimeofday: Add support for auxiliary clocks
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>, 
	Christopher Hall <christopher.s.hall@intel.com>, Miroslav Lichvar <mlichvar@redhat.com>, 
	Werner Abt <werner.abt@meinberg-usa.com>, David Woodhouse <dwmw2@infradead.org>, 
	Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, 
	Antoine Tenart <atenart@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 1:58=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Expose the auxiliary clocks through the vDSO.
>
> Architectures not using the generic vDSO time framework,
> namely SPARC64, are not supported.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Just as a heads up, I've just been bisecting and this commit seems to
be causing problems on arm64 devices, running 32bit versions of
kselftest nanosleep or inconsistency-check tests. Running the 64bit
versions of the tests are not showing issues.

From my initial digging, it looks like clockids that aren't vdso
enabled (CLOCK_PROCESS_CPUTIME_ID, CLOCK_THREAD_CPUTIME_ID,
CLOCK_REALTIME_ALARM, CLOCK_BOOTTIME_ALARM) are somehow getting caught
in the vdso logic and are *not* falling back to the syscall (stracing
the test I don't see syscalls happen before the failure), and the
values returned don't look to be correct.

The inconsistency-check output looks like:
# 5983032:0
# 5983317:0
# 5983561:0
# 5983846:0
# 5984130:0
# 5984415:0
# --------------------
# 5984659:0
# 2009440:0
# --------------------
# 2009724:0
# 2009969:0
# 2010253:0
# 2010538:0
# 2010782:0
# 2011067:0

Which hints we're returning nanosecond values in the tv_sec field somehow.

Reverting just this change gets things back to working.

It's pretty late here, so I'm going to try to dig a bit further to
understand what's going on tomorrow, but wanted to raise this in case
it's more obvious to less tired eyes. :)

thanks
-john

