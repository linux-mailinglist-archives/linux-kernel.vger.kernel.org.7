Return-Path: <linux-kernel+bounces-797706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B5BB4143B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354525E6704
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF77E2D3A63;
	Wed,  3 Sep 2025 05:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jejRidYg"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78213C2D1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 05:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756876612; cv=none; b=ruZhAXY7w99Ks9HsM547vhZL5lwf6YSfxmU3wtmLK8SE/54K9cJAPCgetVo1xcLsZPhBFZncnSVULQ4gU3z3xKz9f4xsWc8qB8KsfmvyJGoPVbwWtUkMUKhaxst4hjM8C67Nc4OtVuSfCMjr55BU5q0QpmzVoD/P4DBK6QkHJWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756876612; c=relaxed/simple;
	bh=SfX+HFKk7hvP9/Zkul0ED786IgPF9fuwbQBA5Us4FdM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XitmDQ35A08w3NeIcz9ljh5Q74uLje9UndLYSoLH9/cS6peqdpSx+LrXeoTWeuGZqOr4TWO+yBuY6Hd5C99BBc6i6I1QWQ5gYaV+4FFyLfWTgULb6/07gQCT5hyTiylt4nghw4LdfRSJdoPd6YG6VQTgY50G7gKFwuTc2swKNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jejRidYg; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61e4254271dso5258684a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 22:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756876608; x=1757481408; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SfX+HFKk7hvP9/Zkul0ED786IgPF9fuwbQBA5Us4FdM=;
        b=jejRidYgf8+UOMSbjjTgtVh6uchvNt0Ix3Pmeor/k0GzZQrcpmgvOgiUrm0GXEvGSI
         TIuLBozAPIIBENoDbE+UbWbgJ4WLZPjnQkLjCZjQj7KqcT3H/gMu9sFwGDX1/Wm8gAck
         t+UaIgdJLCoOZj83amHnO9MwT7gChwdyjdys6JILmKqqW6nCrUbhIfYnAqFEtDKgqFDV
         Zp6F92wUvFapbx9peTHV7VjH3dQWknTHS4fCQ4rAhJ/bz5SK+FYSW0rDlhgZzyJmOfOt
         eCmdGy568/4NE/PJxoPi3bRlpu0gWGi9ux/qdSVndnrNYwX5L5G6zy6Qv0R+63sEaSZr
         ySWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756876608; x=1757481408;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfX+HFKk7hvP9/Zkul0ED786IgPF9fuwbQBA5Us4FdM=;
        b=LtBR9dLhujhCC8ueCX2jDHba8/WeVka7VhLQF0jqb4QKhb/P3L3FNKbX1lfRPxs8iP
         t5DJkAHoBKGeklf4mZS/8bJP50Byjc8goqeYZph941SPh8X9K8QfFiPW0LqNYTpOT7uF
         xvYgx2A1uBC1NiYz5gVDbVZAELL20RZ3lW+CyM5ra5DjBwgM4TB9hS9ijCtksT6RzZZQ
         57EdDD9a5+uP4kOnr6IqqsbzGuf18vFtpwXqtpEUCG/NC94feZtjSAI2ePUrAya6ywTl
         7Ie0NRATSE9oE8UTaCoazNXxcHW+858399IE3ndFjC19C9VmsIfOVBRS0PJ9toujtACy
         00Xw==
X-Gm-Message-State: AOJu0YyBYyxcOzm6Y2m7fwH65eTmYuqUaxXccIl4ysZZ+5Mu1l9s27Ls
	sML5tiuIWE37JTkmfi+DU7Qcyd0/tUmvMpyPLAOq5ROIq4c6w+VpbgZNSwIkLqITKwzb2GaqdQc
	Z8YQP2T9NO4uAZ6/KNqaFKRufN7F9UYTQgg==
X-Gm-Gg: ASbGncs/0dbs/sficOHz+JRwOJsdXoTy0En91YzIUJL6kQTnjrCl22IQps8skpChXtQ
	iJqRDB50WeMV5uXMK86XdpKQj6OQcSbBSFlYRY+DQXfWGjVJbKTxO7KbJIxqvVLXqdct0D1v603
	7sSQyKVYobBUq4mTot2d+LJGvaFzJMsqUOm/3X5SInizfNhnc8d16epv7298WTlsVZlHOPhokrP
	zz9aQM3
X-Google-Smtp-Source: AGHT+IH3NQZ1J9pAfPLqm3a3KlMbg00I2389Ao7Jptxe5Gp9VvUDpdzglZexiXMcW9zTtT8mdb+R+KHopKP8gyJ0xJU=
X-Received: by 2002:a05:6402:4308:b0:61c:db49:aeb6 with SMTP id
 4fb4d7f45d1cf-61d26d75c5emr14465850a12.28.1756876608376; Tue, 02 Sep 2025
 22:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sebastian Ramadan <slay.sebbeh@gmail.com>
Date: Wed, 3 Sep 2025 15:16:35 +1000
X-Gm-Features: Ac12FXyCsbFqmPTP1uiJPAUuCQ6UjFs2eVRiVKBVGC_22rXya626AqEWumjYgC4
Message-ID: <CAPKFLCRrLYguS90i-c65o8S4x_QnmJYiJrkpJMzu2F8UsjnEBA@mail.gmail.com>
Subject: Thanks Palmer (& ChatGPT; I'm rubbish at mailing lists)
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

I recently followed the discussion around your make_u32_from_two_u16()
macro and the subsequent debate involving Linus. I wanted to reach out
and express my appreciation for the approach you took, particularly
from the perspective of embedded systems developers and strict ISO C
conformance.

Your macro encapsulates a pattern that, while seemingly simple, is
crucial for writing portable and reliable code across architectures
with different integer sizes =E2=80=94 especially 16-bit platforms where
implicit integer promotions =E2=80=94 or lack thereof, followed by shifts, =
can
lead to undefined behavior. This is a real concern for developers
working on constrained embedded environments, where assumptions about
int being 32 bits simply do not hold, not to mention organisations
that rely upon legalese specs and conformance to keep them out of
court, or from damaging equipment.

While Linus=E2=80=99s shorthand (a << 16) + b is indeed concise and familia=
r
within much of the kernel development ecosystem, it unfortunately
assumes platform characteristics that don=E2=80=99t hold universally,
potentially leading to subtle bugs and nonportable code. Your macro
helps enforce clarity and portability, and it encourages safer, more
reusable code that can benefit the broader community=E2=80=94especially tho=
se
working outside of the traditional GNU/Linux x86 or ARM environments.

Moreover, embracing such abstractions aligns well with modern software
engineering best practices: promoting code reuse, reducing
duplication, and improving maintainability. This ultimately decreases
the time spent debugging platform-specific corner cases and helps keep
the kernel codebase robust across the diverse hardware it supports.

I hope the community can continue to value and adopt these portable,
standards-compliant techniques alongside the kernel=E2=80=99s preferred cod=
ing
styles. Thanks again for contributing to this important conversation
and for your ongoing work on RISC-V and kernel development.

If you=E2=80=99re open to it, I=E2=80=99d love to discuss this further or h=
elp explore
ways to promote portability best practices in kernel patches.

Best regards,
Sebastian Ramadan

