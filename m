Return-Path: <linux-kernel+bounces-765330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FDDB22EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3B4189FA6F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5182FD1D6;
	Tue, 12 Aug 2025 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UINiRLsn"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F780268C73
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018906; cv=none; b=t6wZbSrRcnZkMIUF+0vtJ6ok+cv0CZ2BvfWgMjgesETZmS4c+nPevxqS7eHmYH3cb8OV0Ys6yWacHX3IT6PRBxlHnaj0aPXsUvc4GNYFoxXklzpJ7TtV+lz/ydIk5pE5cyzd723+YqARKPihqi65vbc5BdY5pElwePxO8vKgp5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018906; c=relaxed/simple;
	bh=emH/9/qIpMML7VwyXCdOqP+butuG+Y1J3ry+obz5qAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fd5LTkWRGXYD+kgnLULLumZ/Ng3PSOnTBtgsxQmgjr5dF8pdkMXokIn9+7mwO7muAlfMmHi/TMGR/oCB/L3XWpXrAfVLb2IcMlgmB0g5x8rkdDb4m/XYm6I0AY59oduQeeIPsLimjjlPjFbGeG08k4860IxEQVwWki+Xz2S5zlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UINiRLsn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-458b49c98a7so37414775e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755018903; x=1755623703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emH/9/qIpMML7VwyXCdOqP+butuG+Y1J3ry+obz5qAU=;
        b=UINiRLsno3oDyC1X36/sR51O+B1XPVQ8wP9dgrT3z0HacxrZdDkV9PzhhDwR09Japm
         STk0dMZqQ76sdXARO+FkVZ69S71s4AR2XYzNPgc0HRJLwsOLAi1i1Z/OcdwOPGGWA1oa
         7A77vie+p8oEZI1m8a2VOrCxOJGued1rGsoFgZcz3kEE2LrByUfthWw+mh5hDG/zPCmC
         gpFN8elQ5NQFK/YUkmfck8hlKCC/+LdNxbgL8r2ytacK/bV201WfKZLmvVuTF+2owRsk
         6fd1OSlPOJh51wj9kyaWz7IQYt4LV6n2lQ9umvQGCuCKlvTKggH7qplvByK8frCqusqv
         rjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018903; x=1755623703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emH/9/qIpMML7VwyXCdOqP+butuG+Y1J3ry+obz5qAU=;
        b=TkRQc6SRHJR1yfQmVrLF0UKFbdsCn+btTg8RdvULnGa8gQl75OpU/iTcxYgS5wX+k4
         8SbR19HTV/klDV9vR0xQ4TnReMmM+DHUPtfXoYYzSoYpoQnNVuVt2aao2ZM2ExEmVny2
         w83TnYG69xzCZdZrqbMRIvIeuocrAqcPhIwWUVhvTXXF4UJX0ChdRnGviDj5gxh8NdK8
         C6SQW2JXQab0TrB9uUvn8VZMwyQ8XXVbudbEhIlXD7+Y0oNC0AzuybgC1+zaF4/4qncs
         /aIJl53njgjZGn9856cSbJsXKA94SobjekitZg/6SYbHsLWNS6UC/FKkqVOGUouyFJ6O
         6PFg==
X-Forwarded-Encrypted: i=1; AJvYcCVDKKmz+i+iQY5b/jFIImxkVPIkFJ5PK+6/EBkk/WiJx8PpeB8ZQ5eS6Re09DeaUM3gsbIHn8yyJKu+Njo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOTJ2IGrm5gjplFEPeelYAsNoQ7aSiGC+D3Os13svZuYTUrA9W
	F0T9HO66lL639yCc3Cd1VwrsS1gpqlBziKWpMX/9Wvr+8oV9JtJfADHOFX7OgIzAtfw0KrEKvYO
	kjsQP7KZBMTv1zKaS8jl7+qXmjCfaJlE=
X-Gm-Gg: ASbGncsMJHaqvlRN4CKrPye0V4xa02xE4TJ/j4Y30fAqWmoTABpMW5pos+aEoDh1fed
	GBZ4Lee+2XTg+/yLsvCiP3DJD91KOQiAacAKJ3Ml8EcxNJojMaNyLFOdC4Pq9AVveRJ/KkjysOg
	s3Codq6e5OSWDrqfbWNzBPC/skEvfMSLocx5jU3C4IOy8jo5nq3V4N5KlfUr5xj1Izzem7xNFC2
	kYudWJaMg==
X-Google-Smtp-Source: AGHT+IGscrYxQbMP7OG5PufoX/l5kbYx6BXGvLE32aEZsthI+SSXhiJax8zZreBUwk0pOZEPsu00PUEuLZoC4WM5glQ=
X-Received: by 2002:a05:6000:2386:b0:3b7:7489:3ddb with SMTP id
 ffacd0b85a97d-3b91730553amr137411f8f.34.1755018903312; Tue, 12 Aug 2025
 10:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812124941.69508-1-bhe@redhat.com> <CA+fCnZcAa62uXqnUwxFmDYh1xPqKBOQqOT55kU8iY_pgQg2+NA@mail.gmail.com>
In-Reply-To: <CA+fCnZcAa62uXqnUwxFmDYh1xPqKBOQqOT55kU8iY_pgQg2+NA@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 12 Aug 2025 19:14:52 +0200
X-Gm-Features: Ac12FXxbfIp4CjdMiDbk99JZKDZitEGnh3AeOJx4PqX8F5dQQ1jZuZRm61N9EdU
Message-ID: <CA+fCnZdKy-AQr+L3w=gfaw9EnFvKd0Gz4LtAZciYDP_SiWrL2A@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	elver@google.com, snovitoll@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 6:57=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Tue, Aug 12, 2025 at 2:49=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote=
:
> >
> > Currently only hw_tags mode of kasan can be enabled or disabled with
> > kernel parameter kasan=3Don|off for built kernel. For kasan generic and
> > sw_tags mode, there's no way to disable them once kernel is built.
> > This is not convenient sometime, e.g in system kdump is configured.
> > When the 1st kernel has KASAN enabled and crash triggered to switch to
> > kdump kernel, the generic or sw_tags mode will cost much extra memory
> > for kasan shadow while in fact it's meaningless to have kasan in kdump
> > kernel.
> >
> > So this patchset moves the kasan=3Don|off out of hw_tags scope and into
> > common code to make it visible in generic and sw_tags mode too. Then we
> > can add kasan=3Doff in kdump kernel to reduce the unneeded meomry cost =
for
> > kasan.
>
> Hi Baoquan,
>
> Could you clarify what are you trying to achieve by disabling
> Generic/SW_TAGS KASAN via command-line? Do you want not to see any
> KASAN reports produced? Or gain back the performance?
>
> Because for the no reports goal, it would be much easier to add a
> command-line parameter to silent the reports.
>
> And the performance goal can only be partially achieved, as you cannot
> remove the compiler instrumentation without rebuilding the kernel.
> (What are the boot times for KASAN_GENERIC=3Dn vs KASAN_GENERIC=3Dy +
> kasan=3Doff vs KASAN_GENERIC=3Dy btw?)
>
> Thank you!

Ah, you don't want the shadow memory for kdump, sorry, I somehow missed tha=
t.

I'm not familiar with the internals of kdump, but would it be
possible/reasonable to teach kdump to ignore the KASAN shadow region?

