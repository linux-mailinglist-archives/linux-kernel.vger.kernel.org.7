Return-Path: <linux-kernel+bounces-835113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9436EBA64FB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 01:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479893BFCC1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 23:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7165122A7E0;
	Sat, 27 Sep 2025 23:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSwrwwXP"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4194C9F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 23:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759015700; cv=none; b=QZ+utpQ1GijU5OdR8xIoGT2TAoT9tyrV/KeUwWTAOVc09KIllDfzfICbaGWJj70zbYbN0C6Vm4H66SlRtgFvCilYsm4qrhqZ/4u6dUqEZOuluyAi2LBF/OxzF+HbmoRb+xrDCaUQc1UWHfaNx4QFEmXZqb5quKGXzm866UsxQ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759015700; c=relaxed/simple;
	bh=cXZMFdkOujQwv9Ddtff5EzDGn4a9CexFASqpGTOlpCw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jjLBNSsu7x4KK2lelIwTJGZ1kpfBNrmE+dQ92Q4PDMD52CJe0ltAjysIXtA/M3DWy/u5NVZGuBGPi/DWnhziL3WPfU2C7SfnSbLCtQl/hPEoWkHwtWuiPHazksNeI/+q81MrLRg0JHYZMMTAjfk/LMG5JYQ/+fG9DGVP2TKuluM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSwrwwXP; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so6713318a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 16:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759015697; x=1759620497; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cXZMFdkOujQwv9Ddtff5EzDGn4a9CexFASqpGTOlpCw=;
        b=CSwrwwXPoI4YtnnAnBbk6b8D4T3DxsZ9aQ/krNeMA7Q9tr1HyaVt/HzavUb6llVbm/
         PjpxMHMpC1o8yGsgal26fxtVCLrJzsMFHvAb9XrH2Y1ZKYFF3BxQTV+ZrHG/jtPdJEnc
         nYKbgNyGf7xOwZ0Ub0oP9xHy+nJYHHkiZ3i8gJDR9RH+xlZsYRAZxDCEa0NkkmatyKrc
         HlwdD+RrBiKWh/0MwaNvBv5DfsUVJHKO+uX6BqOnYDwIBl55AzbUe2ySJ5TE3SGT3ywm
         8IKDoy3URZ80utzZ7UIt9V1vr4OYpbeVB7Ci4AMVqdxfFSSgAyp5h3a9DdZMUCbqWocb
         o7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759015697; x=1759620497;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXZMFdkOujQwv9Ddtff5EzDGn4a9CexFASqpGTOlpCw=;
        b=fuCv+BHVwlvNXphay7jD4cCKDQLcRi5gcrmboHpfGzwVXurSo8Q64iTnOZAeHewQd/
         pZyQlkA8DTLBZnWlUsZjvaptdV8V3gP20R5oiPA9eBQQMJ+o8mlap1a8rPJ/FtRpUi4D
         lkoBrCavDYPqXdd7ZY+KUgmdla/EmrwcN2EY0mByqqZSGl9Fbw6k2MyxYYWZUmX1iO6D
         p4cwlsyXON1JYlqnMtLm+qEeZgzIIOCeABBeRVMz6deEVcR6RHNTMF59JPpgyazEz7l8
         ws5ktM1YmAmU08+lkhmNIZ320/PlTEQiNrwe/6MjtEpw0NoTBSohJsSgf5R7rchkJ8vT
         cDlg==
X-Gm-Message-State: AOJu0Yw5pGnVid3CSDBNeK4Y/eGPqwqPANjqs41idhr4exkShGTye4XX
	7UW5dSrY+oFtkww4zKoOjljVienxXDKH5BvowbjLDJxNnTC4w9Cu+QnRu7UFs8DasBunSX1l8iY
	Ytnx9zDhT9KgnllZfUxn0/3t3IG5XnrFrlSUO
X-Gm-Gg: ASbGnctDMSP5A4GZNR9A6pWbyActDy7OALZdT3R5CHZi8+5+kGqbhMZ+wek+3bJNb3C
	eU9mmH+KcnkHgYGmiaPtTH15l5mLbdN9oCAej9RU7R893U093zFJJgy2i8/quJ+OcgEsHLWnP3r
	W56ke6tnoWWFKZ/y7b/ZBvbjxLN5vT8xN1OGGq7hBaEhlEpPuuQmuE8iyFvnJ1MK74ejyWE7Fdq
	KB83vefBW/ycecjlUY=
X-Google-Smtp-Source: AGHT+IGWg86QX4C8/NpH/V2L4qssJUsIEurSH31OpsC75G6cMP3B0xIwjJILaodtlUe6NnSKBpJRmqtnyfXXhUPF0JQ=
X-Received: by 2002:aa7:cd0b:0:b0:634:6e8a:d810 with SMTP id
 4fb4d7f45d1cf-6349fa9d354mr7887344a12.17.1759015696932; Sat, 27 Sep 2025
 16:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sebastian Ramadan <slay.sebbeh@gmail.com>
Date: Sun, 28 Sep 2025 09:28:03 +1000
X-Gm-Features: AS18NWD_AXV4OEG2VmylczKMl51QD8NTVIIXT7erIjglgI4tkWtbE3udZfNAyJw
Message-ID: <CAPKFLCRNQxcvSwyy6LckOPKV8EgBPe8DyOGYAwbGfs6VoRg2cw@mail.gmail.com>
Subject: Culture of unprofessionalism & lack of accountability for apologies
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I want to take a moment to reflect on an uncomfortable but necessary
topic: the persistence of unprofessionalism in kernel development
culture, particularly flippant public attacks that were supposed to
have been addressed long ago.

In 2018, Linus publicly acknowledged the damage caused by his
communication style, apologized for personal attacks, and expressed a
commitment to change. That was a moment of clarity for many of us =E2=80=94=
 a
chance to move the project toward a healthier, more respectful
environment. But when similar behavior resurfaces years later, as seen
in the recent RISC-V thread, it calls into question whether any of
that change was genuine or lasting.

The public dismissal of Palmers work =E2=80=94 someone who has long
contributed to a difficult and evolving architecture =E2=80=94 in the tone =
it
was done, doesn't just hurt individual contributors. It undermines the
entire community's claim to professional standards. The lack of a
public apology or even acknowledgment this time around echoes a
pattern: apologies are made, but responsibility is dodged when it
matters.

It's especially ironic considering that the criticism targeted code
meant to improve portability =E2=80=94 a topic that, frankly, is often hand=
led
with more rigor in the BSD community, where standard C and actual
cross-platform semantics are taken seriously. Palmers work, from what
I've seen, reflects a real effort in that direction. If anything, he'd
likely find a more appreciative and standards-conscious home among the
BSD maintainers.

This isn't about hurt feelings =E2=80=94 it's about creating a development
environment where criticism is grounded in substance, not theatrics,
where accountability means maintaining professional standards *even
when frustrated*, *especially when frustrated*.

We all want a better kernel. But we can't keep sweeping this stuff
under the rug. The damage doesn't go away just because no one brings
it up again.

=E2=80=94Sebastian

P.S. The average lifespan of a mainstream operating system is around
20=E2=80=9330 years before it becomes either legacy or niche. Unix is over =
50.
Linux is past 30. What started as a lean, clever system for
underpowered machines has calcified into a monolith propped up by
legacy assumptions and controlled by individuals who still treat
community engagement like trench warfare. At some point, we have to
ask whether we're preserving something valuable =E2=80=94 or just refusing =
to
let go. Modern hardware is no longer well-served by the abstractions
Unix was built around. Modern features in our hardware are
increasingly *misrepresented* or outright ignored by legacy APIs and
kernel boundaries. We've reached the point where the software
interface is not just mismatched with the hardware =E2=80=94 it's a bottlen=
eck
to using it correctly. No amount of flamewars about where code should
and shouldn't be will paper over that. In fact, if we're to get into
an inflammatory discussion about what code should exist and where,
here it is: Linux shouldn't exist on our modern hardware...

