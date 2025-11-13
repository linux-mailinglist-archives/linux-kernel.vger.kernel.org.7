Return-Path: <linux-kernel+bounces-899785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD842C58C68
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E12D367A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59B03590CC;
	Thu, 13 Nov 2025 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2Hxzr9d"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADC635293F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050736; cv=none; b=JRegY46wN5JDZbCagkBsiswMdSxwhd56PnCTHNNX8tzmPmc0LW1HLl56MsjPaOBWQ1tbU0vQ95zwJD/+/pH3A6imj0/Mb+t77q00QCgowV8/xRlAOocR8n72besZ/sezLBQI0H/oNK8BfAmLkhDMmi5gCpGv3rScjU1ATwTC/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050736; c=relaxed/simple;
	bh=X+jglSuIcAqBj4r2Yvzejgtem7Zuj3d3HuPiUn8D4x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoQWzbDOW7Ah3MKlaMYLWNJOb+aghApQzJeOwISkmHx1Hh01x9QIK0uDqUlYqVmUUTgSBFTbFoyYvPqExEWz4UXk6qQxxOzUYdcgyBVR2r6WBtn59OqSffe6IlZRN9U1KO9iIKfK/u6dXgVoH3SrQuLaJsXGWOFnIneI3WqWMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2Hxzr9d; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-55b09f54e98so314883e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763050734; x=1763655534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+jglSuIcAqBj4r2Yvzejgtem7Zuj3d3HuPiUn8D4x4=;
        b=g2Hxzr9d1+BSv+THQ6Mf2zWVTLYFPfNC0n+CgAzWx4ljQRadWCZssG7VITcPJ/hdwb
         SfhWo508HygUpzjAoiUc3a1ooLqcasT5utH2z3Dp6muTbYmHa9N6WFd7rZJovYMtDlQu
         g6xMxN/o7TBprchv4nFV6515aowPDnqKV9QFHMDiwZwssURu7zQzhqAPPjRV8+HA0q2B
         B/frdEHcLxNCM5LYGwqqzLXv4qBD+dwRoFvmsfrE5HdrL4VKtDUlW/YETWvG1Dc+Obai
         WE+WCgAAGHYKbBbzsFnRh70tvOoQymvEr181iJFSPQCmhdcV8fYObR/3RdxhIB/A3ogg
         FhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050734; x=1763655534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X+jglSuIcAqBj4r2Yvzejgtem7Zuj3d3HuPiUn8D4x4=;
        b=uwHRiyffRjLimKhjRG+ayQ2S28OQbo0Iny3WpDj5kXB/XM4NlS2ypcW/H6zz5qwK8u
         PuF1ksR9psUvcaF2FzKdUZckLaGKpBJMGMfZKPKt4UNcc0hLaTuGNEYZl0dVSMrcWh6y
         syXdxIYBuuJtRGIngnqASY9ndZ4QVLXM2TOp7LBmyIsPNjYKRw8yKzfO7OOf67n6VOfy
         FgEI4mZlmnxk3gLRtb5laWtbCrNsJj2oFyyvqGY4MCBsSr48NoCY+6EC0CKBAfZCg8hQ
         eoVhTFQsPidIE6ab9RCIZDwIJ9b/pGkjaBmExmsXvf92tSCB/4BmnDCYQjONjUWrEPIm
         3fiA==
X-Forwarded-Encrypted: i=1; AJvYcCUvcT3oui27950K3rypdlcJ/JUI+Du8oiLAFp1/Kvky/bQ3jnrKsV1ZeDXyR+SV+ubhGSb2MK9/WLv2nJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaue6JQJQjhxVKqQ0uaL82q2WPH+RRJmSsIlzuO2WQ9ameDU4k
	Bnew3OZhT9nSMwISnwbU/wavWgoPJ6aawtNGNGA0WdBPTMHXdZhHGQj5lF5DJ4XzZXXnzRrLKy3
	eMkB2qHm0UQwxk2RP6aHHxD2juehaVFo=
X-Gm-Gg: ASbGncvZ1a8dI/+8P+cxfupKyF6WTjDYdfJXEETho8eWHMyKbzfd+sc3WsZiufF0QGW
	8r5xK6xvYCkRtQoRh/TtUcojmAsZlLbO9qY2GQnLU9B9MveASBoqsvL9dUyAJzqaTDRyqe70CUU
	0A4TB+DyyIvdPYyEKrPx/98yYAnNPFNRQOfhRoyWBNGv7knFIqR7NBkV7pa5mVgd2e+Zodz4ycQ
	042B0lh9jZW32KJ6XNpPDgY2roFxvt6INN29hNI1uAMWHdI9rJ1OR768+W2anU=
X-Google-Smtp-Source: AGHT+IHQlvloEzjKkY5BkMvD2gAnBdnRNb1amCMLvHF1Utj0ORHdSRDHFy5DC5NLvgH60/r/vrHA1AW5hpH3I+XpRwc=
X-Received: by 2002:a05:6102:4487:b0:5dd:c3ec:b5b with SMTP id
 ada2fe7eead31-5dfc5b72883mr124216137.31.1763050733707; Thu, 13 Nov 2025
 08:18:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113154605.23370-1-scott_mitchell@apple.com> <CANn89iJ_b6hfj96Me-8AZN92W+cA52HpGcu81J0MNtzeahpfXg@mail.gmail.com>
In-Reply-To: <CANn89iJ_b6hfj96Me-8AZN92W+cA52HpGcu81J0MNtzeahpfXg@mail.gmail.com>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Thu, 13 Nov 2025 08:18:42 -0800
X-Gm-Features: AWmQ_bnF1bGJN_bDR1NS8Ie2R0lRRCVzMsqRXHPobd7cBDwaINkzoduMtW9VB0s
Message-ID: <CAFn2buA+uHsRLU-TG9Xy42-pATex9Hh7kD4uCtcVRHAKVCgZow@mail.gmail.com>
Subject: Re: [PATCH v4] netfilter: nfnetlink_queue: optimize verdict lookup
 with hash table
To: Eric Dumazet <edumazet@google.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, phil@nwl.cc, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 7:50=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Nov 13, 2025 at 7:46=E2=80=AFAM Scott Mitchell <scott.k.mitch1@gm=
ail.com> wrote:
> >
> > From: Scott Mitchell <scott.k.mitch1@gmail.com>
> >
> > The current implementation uses a linear list to find queued packets by
> > ID when processing verdicts from userspace. With large queue depths and
> > out-of-order verdicting, this O(n) lookup becomes a significant
> > bottleneck, causing userspace verdict processing to dominate CPU time.
> >
> > Replace the linear search with a hash table for O(1) average-case
> > packet lookup by ID. The hash table size is configurable via the new
> > NFQA_CFG_HASH_SIZE netlink attribute (default 1024 buckets, matching
> > NFQNL_QMAX_DEFAULT; max 131072). The size is normalized to a power of
> > two to enable efficient bitwise masking instead of modulo operations.
> > Unpatched kernels silently ignore the new attribute, maintaining
> > backward compatibility.
> >
> > The existing list data structure is retained for operations requiring
> > linear iteration (e.g. flush, device down events). Hot fields
> > (queue_hash_mask, queue_hash pointer) are placed in the same cache line
> > as the spinlock and packet counters for optimal memory access patterns.
> >
> > Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
>
> Please wait ~24 hours between each version.
>
> Documentation/process/maintainer-netdev.rst
>
> Thank you.

ack. I will wait 24 hours to address Florian's comments on v3 (unless
instructed otherwise).

