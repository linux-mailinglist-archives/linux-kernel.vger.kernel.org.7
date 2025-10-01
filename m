Return-Path: <linux-kernel+bounces-838334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 001C1BAEFC2
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02991C4CA7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB78A260565;
	Wed,  1 Oct 2025 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CGOo6OXc"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDDA1DC994
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759284604; cv=none; b=qx2xr6MARXk7I8OO9eK/BZxjs3AAjvOLQ85/X8YzBVC4W2MdZm4CDkhuu0NVy4CqQLn0rK6EgvqR5gfuUN/zZuR34Q28XIJiNQ7n1hFX0X4rLFvDpQ4lxzWn6nZ1/F0P7Q9pYhxEzZz7byvXGi1m7PtJYIX+xZmfk7rfYMajGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759284604; c=relaxed/simple;
	bh=ewy8bEtm2e2qFkCfiN1Yi8GekyihfoxvOUMheYkIH18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mF3VxYcek0ipRDVagw9HsJzl9I4N4RMswfzQ8bzGCve6JbF1htqDo5fAxvIldgEEz6+CVMvFVjYsnp3R5obFIudD1/TIPxFOAibXXTSaUdwVOQ/D/lsmxEftF0rnV/sxNwdcHCeHSuvW6rTm8LmeaooCR86g9WCMFQ0LbDLEge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CGOo6OXc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3d5088259eso515098766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759284601; x=1759889401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7erB5ZGDmVyr8AkZLrpn4uzVS17t4/mCKRzLiEmHgA=;
        b=CGOo6OXcmUhMZEtbtW6LWfGpxv2CPJrLc3u5NvfMLnGcYF2JmfHNbkS/zvArXz72pt
         nBN9XpvPN0zT0W/hIsjR2lBuP1y9KWsPzCSBFyEox7gZdjyT1eOjKzOFVULfYWUFLebg
         G4Bf/qgmLt7fG2EB9xlHiJZJFRMiHMXW+aVE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759284601; x=1759889401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7erB5ZGDmVyr8AkZLrpn4uzVS17t4/mCKRzLiEmHgA=;
        b=PwQmgD0dkZ5MAYWVjHDUWeOQGPF9+CqfadTX6RKMz3deKfdNw1Yg/e8ovWMqR3gH6T
         jS7L7j/RrvtqPUcVfDI4xwaWORiZiP0tRpIiWHMVyzeHn0DMAShx4uBF3cA8vkzqM0de
         lRxRiPMpB+aJau+eBprzvTUvssUZuqtcRxi1MYefm27ab31/rlFUuCUEAcP2EBCOjUjF
         fkUN22yf/Kv6urqCKnImal4si6YdYi7VBi/Wfr1Kzc4QGvCDLUrwhTrDoDkjh4jLnimu
         BYHf9IOarNrbp2NRM2U4673KVnYwHtPAtIpI7doYgkAc3s53Jdpo8Mb61J+1TK/h16NV
         dk9A==
X-Forwarded-Encrypted: i=1; AJvYcCVP0U1ULhVaVHlXsRP7jDYrZ6/Laa11YgwS8UJt85C1suknkZxKxWecM400Qi9yJ/gkqRHjPclVUPiiCSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywzYX/Ev7OsMG9IiilmtglkqT/JZwUfI/LhIkxHbfRfLXR1JJn
	fXDe3cqmxnLWJCkz3AL4T1/1310MDAG+ourdnJpdzUoPFdtjJ02rAvNzgIA5wtg1CXll+SnqMlt
	yB4rR7XQ=
X-Gm-Gg: ASbGncvE/n0gTwMGMxkv/2qdxK01ageKN26zK9ZjA72+tiqGC3FQbdTZRIFhAmJegJS
	5Q+I7ye1uU5iGx1tmbsoRGr7eU3gWiyGDDFdbjbOY8M3ehQ/OluPLCyrzDD7SSrz6E6CmO9a019
	RpC+4wa4Ms5g5zX1mZ5kHoz7U4ar8jRAv22eMPdd2Wt+4GDx+jKbWSS0TzJZmawArswx3eR0IDH
	qFEhVKMAt67brIBgdlMJ0R7ayct+yRA1j5zKaO5Jq0jHgOCn8mZduzntXtFeq4L+zNY+JKOeyET
	tgltRkW4tCwRllHsutjk6XeJqnLRDylSa+u1a9AJ54evpjs4JQxcyk60FqZ5S7JmPjONwDUY8jy
	1jp9FBliAE4fjgZ/yBQxsSi/uw9yHDyn27k5Bp0Zvk+VwJcQXxRRqUWjrUgNmZd3GqB3DCPhtQS
	DW7WRSyTyBU5JCQvoMNv0G
X-Google-Smtp-Source: AGHT+IFZFluB9dsq2YlcvF+JPNkYcFGugXCsVcIO5u4GWYzSwuAz49QarSliGDXworKFlOa+3d7gUQ==
X-Received: by 2002:a17:906:478f:b0:b3d:200a:bd6e with SMTP id a640c23a62f3a-b46e516a063mr190001366b.47.1759284600852;
        Tue, 30 Sep 2025 19:10:00 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f758csm1277947966b.53.2025.09.30.19.09.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 19:09:59 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7a16441so1081799266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:09:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXa+TCuYqbhDoGsVPvslivg4+bE5e0q7OV+uFfDN1lmp5IwxLqW8RWMRUINnRCgxbGyNnxFHfbKbc8xI6w=@vger.kernel.org
X-Received: by 2002:a17:906:c146:b0:b46:1db9:cb7c with SMTP id
 a640c23a62f3a-b46e4791038mr207901666b.33.1759284599468; Tue, 30 Sep 2025
 19:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928154606.5773-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20250928154606.5773-1-alexei.starovoitov@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Sep 2025 19:09:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whR4OLqN_h1Er14wwS=FcETU9wgXVpgvdzh09KZwMEsBA@mail.gmail.com>
X-Gm-Features: AS18NWBi9I9vAHH4YHKcIzlLSZYxGaQO5CqV_lK8IoryGo-bstgFslhzgwijcZU
Message-ID: <CAHk-=whR4OLqN_h1Er14wwS=FcETU9wgXVpgvdzh09KZwMEsBA@mail.gmail.com>
Subject: Re: [GIT PULL] BPF changes for 6.18
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, peterz@infradead.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[ Jiri added to participants ]

On Sun, 28 Sept 2025 at 08:46, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Note, there is a trivial conflict between tip and bpf-next trees:
> in kernel/events/uprobes.c between commit:
>   4363264111e12 ("uprobe: Do not emulate/sstep original instruction when =
ip is changed")
> from the bpf-next tree and commit:
>   ba2bfc97b4629 ("uprobes/x86: Add support to optimize uprobes")
> from the tip tree:
> https://lore.kernel.org/all/aNVMR5rjA2geHNLn@sirena.org.uk/
> since Jiri's two separate uprobe/bpf related patch series landed
> in different trees. One was mostly uprobe. Another was mostly bpf.

So the conflict isn't complicated and I did it the way linux-next did
it, but honestly, the placement of that arch_uprobe_optimize() thing
isn't obvious.

My first reaction was to put it before the instruction_pointer()
check, because it seems like whatever rewriting the arch wants to do
might as well be done regardless.

It's very confusing how it's sometimes skipped, and sometimes not
skipped. For example. if the uprobe is skipped because of
single-stepping disabling it, the arch optimization still *will* be
done, because the "skip_sstep()" test is done after - but other
skipping tests are done before.

Jiri, it would be good to just add a note about when that optimization
is done and when not done. Because as-is, it's very confusing.

The answer may well be "it doesn't matter, semantics are the same" (I
suspect that _is_ the answer), but even so that current ordering is
just confusing when it sometimes goes through that
arch_uprobe_optimize() and sometimes skips it.

Side note: the conflict in the selftests was worse, and the magic to
build it is not obvious. It errors out randomly with various kernel
configs with useless error messages, and I eventually just gave up
entirely with a

   attempt to use poisoned =E2=80=98gettid=E2=80=99

error.

             Linus

