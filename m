Return-Path: <linux-kernel+bounces-835122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3C1BA6543
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62161706DE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 01:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB55B1E47A5;
	Sun, 28 Sep 2025 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdygDJqM"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC092AE8D
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759021909; cv=none; b=L1n6HR9QG2ZEKPG7LKLWU495bIv5jbEBLt80G6TRwcERjBKZ3/1TV0SdWFSiGHlENLvLTETgXm+lgurThc61sr+ChnPMgZbcWGAg+f+zXzSHV5SCTRF/EuXzYHsFV/q+yDEcHEleqHuu1qt9a8jdiztlBiPi0T0KuNElZawhQ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759021909; c=relaxed/simple;
	bh=0Hq9+Z6UAmTgmqqVKnFTiMnWZOo5KByC4nsJVMmtiGA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=a0Zg+z8lsmZVRsl2+uRh7L9l33LZUwSFXyj4m7zZMA67noFiR7+Cx/hSTiDM082Vjlaf3EOCCNrtG5Msi3k+sELAnwtAHOZGkJqkA3mHcIXPgk5bC9Q+MTNqVav9DsTc5yQrlMTU6xcbHhel96MR+GkPm5k0832GssQvzFnEvtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdygDJqM; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso6585314a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 18:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759021905; x=1759626705; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Hq9+Z6UAmTgmqqVKnFTiMnWZOo5KByC4nsJVMmtiGA=;
        b=UdygDJqM5/ebpuEsy7OsBxVWPk/q2kOKDZ6tZ8vIj4LPn/wMfd5QnJf8yg86zyQrGB
         UBAxrjB/heEKJomV65adOcCbGxOgz3nFLcZdCzOZBNI9NLVE3814f3IztMiX5MoKCIe/
         0TtN84QrJ6fDL2glZZUGVAAHETBytLCBstW679lhjAYs705hIBcsxHXTabl9BX6EDypQ
         E0yKWdzdWXANbEYHsXPa39xYhfNpoigS45HrpsDGOrQPPip7ee6wIIuTZ5FO0ospMJZC
         sOBMXFradInWpTCBcYURx1fIG84RnD2liDupxCrOyHKIttw7Ie5lNXbQJJUSQQWNj+tZ
         E9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759021905; x=1759626705;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Hq9+Z6UAmTgmqqVKnFTiMnWZOo5KByC4nsJVMmtiGA=;
        b=Uo4ES/EDfWzAhn1FqHKfjCX0EyxequZQ3bSegKeRyYaQgDtZwL7qYE3GhJXjrMD6NF
         zlqDYfQLt8HWrrfo7ts17i+ASv7b+ulGuttU3Q3TJWsQQy1F2J7pj6yEUYskAbdhSjur
         hCmdmZCS5/qkzEeZFB8ZilhKDh28ZlJl9NtRdZnyF10iDAN/fCdZthIAM7Y2/KwnGpUa
         ui+54HUXsSA6YLEVkfErmQWpjnsA92D7Mxvd5asmFFIOPjhn2TIlEtahtwr44pVk2yGE
         jxiUms9fQX5nhaWOYc0oVTSZRtI2oYYRIAYxrTnzdKN1BM+sC5tTmYq5Ofd29QklDs2Z
         ifIw==
X-Gm-Message-State: AOJu0YyQgH0xsvxiSAd6Tj7eAtYWZMzczBdsdTID5TXx35/OTRKGHGIZ
	aTYvZBTKMKSlCr2K9a6zjOJ2lBNz4o9pjQMAXIA+pDQZmDen2BH5qgCQi3oMi5NOTk4rvr4Zvbw
	+sD9zo8HB7DQZQ4r+ctHvElScrB/SWJ/PyV0q
X-Gm-Gg: ASbGncvHPmbfpTTu/32eIbHMGBZzpS+arG4X+dvxa6WrHwdMJX+z0fLpA/MSZWUGmZk
	/fg0vNTtRHCQlqqwjcKve00+rKg4bqdjM0gLucSdC7moWH6KukOEHYG9E6tg3SG/wMcGBhNVvbt
	krcfMxaxP0E/IqfaSfPkDfXy0D2M0qpPzcjvoxLth21+fV7NZ9CuuKhwU4ry+xfbPUSAsx1D3g6
	/lI/G05GhN7AP35qZmSUyrlxPdgJT9Wn7g7+43AtIe65D35lnI0UdP72QJ2F+nV8H7HEWik+2K1
	6jQRpSftsA==
X-Google-Smtp-Source: AGHT+IETi0bCziw0ppSoRWryfJkfCfMTpncN71NnLSgWLxJ0jg0Cy4uB0q3mI6ISw3aVumH+Ih2VtLbeSFX1Da6iDas=
X-Received: by 2002:aa7:c6ca:0:b0:62f:67bb:d374 with SMTP id
 4fb4d7f45d1cf-6349fa81867mr8352004a12.20.1759021905233; Sat, 27 Sep 2025
 18:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sebastian Ramadan <slay.sebbeh@gmail.com>
Date: Sun, 28 Sep 2025 11:11:31 +1000
X-Gm-Features: AS18NWBIwe3m1PRJJlVKBiOzt0vAxYp4ZrkEYTABuW-Tdsj2ohE0UqWzXcXGfjM
Message-ID: <CAPKFLCSmGipHsG8PUt0PgGznxSFj8N47EGSa0XVt-coXrYrFbA@mail.gmail.com>
Subject: Reputable quotes on why Palmers approach is FAR better than Linus'
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Granted, it's not perfect but... I wanted to clarify why Palmers
portable macro approach is generally FAR better than Linus=E2=80=99
alternative inlined nonportable approach, using quotes only from
authoritative resources and world-renowned experts to show how out of
line Linus' tantrum was.

"The key to maintainability and reliability is to avoid duplication of
logic. Reusing code reduces the chance of introducing errors and makes
it easier to fix bugs in one place." =E2=80=94 Martin Fowler, Refactoring:
Improving the Design of Existing Code

"The result of E1 << E2 is undefined if E2 is negative or greater than
or equal to the width in bits of the promoted E1." =E2=80=94 ISO/IEC
9899:2018, =C2=A76.5.7 Bitwise shift operators

"Undefined behavior means the program may do anything: crash, produce
wrong results, corrupt memory, or open security vulnerabilities. In
critical systems, this unpredictability is unacceptable and can have
lethal consequences."
=E2=80=94 Bjarne Stroustrup, Creator of C++

"Software developers who fail to adhere to industry standards or who
produce software with undefined or nonportable constructs expose
themselves and their organizations to liability claims, costly
lawsuits, and irreparable reputational damage." =E2=80=94 Gary McGraw,
Security Expert and Author of =E2=80=98Software Security: Building Security
In=E2=80=99

"Undefined behavior is the bane of debugging; encapsulating risky
operations within well-tested macros or functions saves time by
localizing and eliminating sources of errors." =E2=80=94 Bjarne Stroustrup,
The C++ Programming Language, 4th Ed.

"Non-compliance with standards, including the use of undefined or
implementation-defined behavior, has led to catastrophic failures in
safety-critical systems, causing loss of life and significant property
damage." =E2=80=94 MISRA C:2012, Foreword

"When bugs are hidden deep inside repeated code patterns or scattered
inline code, the time spent debugging multiplies exponentially.
Encapsulation reduces the debugging surface and avoids cascades of
failures." =E2=80=94 Steve McConnell, Code Complete, 2nd Ed.

"Clean, reusable abstractions with well-defined behavior act as
contracts that developers can rely on without re-verifying every
usage, significantly reducing debugging time and effort." =E2=80=94 Robert =
C.
Martin, Clean Code, 2008

"Undefined behavior is particularly dangerous because it can cause
errors that are not reproducible, causing cascading failures that are
very expensive to diagnose and fix." =E2=80=94 WG14 N2341

"In safety-critical systems, failure to comply with standards can
result in catastrophic consequences including loss of life, severe
injury, or substantial property damage." =E2=80=94 ISO 26262: Road vehicles=
 =E2=80=93
Functional safety (ISO Standard)

"Undefined behavior in software is a ticking time bomb =E2=80=94 it can cau=
se
unpredictable and dangerous results, especially in embedded and
safety-critical systems where such behavior can lead to system
failures with severe consequences." =E2=80=94 Herb Sutter, C++ Expert and
Chair of ISO C++ Committee

"Software defects arising from noncompliance with standards or from
relying on undefined or implementation-dependent behaviors can lead to
fatal accidents in medical devices and aerospace control systems." =E2=80=
=94
Nancy Leveson, Professor at MIT, author of =E2=80=98Safeware: System Safety
and Computers=E2=80=99

"Standards provide a baseline for predictable, reliable software
behavior. When developers ignore these standards or use nonportable
constructs, they undermine the foundation of software safety,
increasing the likelihood of serious injury, death, or loss of
expensive equipment." =E2=80=94 John McDermid, Professor of Software
Engineering and Safety-Critical Systems Expert

"The Therac-25 radiation therapy machine accidents, caused by software
errors and inadequate adherence to standards, resulted in multiple
patient deaths, highlighting the deadly consequences of poor software
engineering practices." =E2=80=94 Nancy Leveson, =E2=80=98Engineering a Saf=
er World=E2=80=99

"The FAA mandates strict adherence to software standards like DO-178C
precisely because deviations, including undefined or nonportable
behaviors, have in the past led to software-induced accidents and
near-disasters." =E2=80=94 Federal Aviation Administration (FAA), Advisory
Circular 20-115C

In summary, we can see from quotes of our educators that Palmers
approach reduces portability errors and debugging significantly, which
then reduces the number of lawsuits we programmers may find ourselves
in due to actual damage and death, whereas Linus' approach is the
opposite and not generally what businesses want.

Regards, Sebastian.

P.S. stop discouraging us from following industry best practices,
Linus. This email sets the stage for you to be sued if that
repetitious and subtly broken pattern causes instability and/or actual
harm. You can't stand in court and say you've not been warned, now...

