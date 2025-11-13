Return-Path: <linux-kernel+bounces-899784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 24865C58C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A76F4383385
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F16E361DC4;
	Thu, 13 Nov 2025 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1pjjSg4"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E3835E550
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050560; cv=none; b=GP/PhzI0y7SAtaeg+J72ZZekp3NA5kBQ6MudUMXsRqaZSy9VZxwoh00Im5kpZd3cNYeoFKsSo+fZlXseeQ4Bd3qcgJOqxhdb1kXhJfgERTjvEo1M6UvWsDdk2w0Wvvy1DwM+VE8R6qlywpgrO1tBvtwOvtn0+/h8VpwMfz3V/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050560; c=relaxed/simple;
	bh=kafW6vm77X+S5eJdFGrqID+7DDj+I7gbTIu7zvP37RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkxjjwCyDGW1m8HNv6bshbhfCrraUQjxv0eFtxrKg4Mygf8MYSnNJcJcyozx+pAig3TCiQfOKF0uJw5myNFwEEYmXFtE+rZnh598H/NvYQfgsmccNrZ4tiwSchTwHKMhkSKpJKG9IvFDxH9igFc8hOeP45Q4zZGk2CqRDn7DM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1pjjSg4; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-93518a78d0aso527760241.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763050558; x=1763655358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtZrc8pcV94m9BaS5IFrkwCaXzwDk1JO5Dgtlvx9nnI=;
        b=C1pjjSg4y7VbbIQiWGAig7QPRE5zgmqH/55gQfJZRM+KANtXd2Mb8clkAgb1X9mKIh
         YS0lWKizGIfFUaVm6RNL2rm6pr2XytoNAyfBoyNK9Wi5baNBLqIBLAxR9oibluvYcAP3
         CAYYdn5eQheU7At9zJ2ShrWKV5RyLWDeeYAIj0Lo80XPUkp3kBtE7G1Ggo1aQ17aqGbj
         jgY2wjdJac1QkXXJ4YXh1+INLFcxEQQSz6wHIwZnBMO9wNR4lv0kFGiusFT3YBO79Hg1
         XrRdOPbCMWcSHSgWodgoRvlYBdpdjNIRDBApUsmQJe+i2E+7oHPxiUM+nVrNUKsVRWer
         83LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050558; x=1763655358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QtZrc8pcV94m9BaS5IFrkwCaXzwDk1JO5Dgtlvx9nnI=;
        b=tG598Ctxq+MES4NxyKo+VPEoqrIoLakeJC2JlWWRY3qcDLdlBAEfO3HaVfxkCTta32
         c1UzcvwPrDfnIbSG8iEtDvy7k7NswkqFZKnExHiH/xG1BDatkIlqMDlrgac8l9M4p0rc
         FrZ5I5c4QptyBjETjlSJzFOAcMGsrWtsyJ5TD/wwkaqhhauc6mQPPpYM0zvLtxU0cs3b
         EihzSa02SpUYiEsd9uIQQbNDzhF77konQr4aPJiX3Yr67bcbjhFUIaQF9edZF/w/brBx
         y9epBbvZNNn/WLIE+LRj1Ux0ouTBkwdULwo1xuXXNL7yohBmTjUI/09R5AIp6feLHDPH
         qeWA==
X-Forwarded-Encrypted: i=1; AJvYcCWtCa075D1UgBT8DHGibbDi/l3tjS48xkWuFtOF9ReNGEPygl4JX5HyPk1QN1L93VN67ZdYFZ19C8SuCjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrpNJasV+DYWW7tGKeqlAThmbL9SgCEruAOnUgn72E2Bh/0O1B
	ibOecMz2turHQFkmekugqGT9v0bqMUGA1mdaxtrFYx8ZrkSxbOXYrgdcsYb9TJ086YmcDeibEU6
	a1gSJSLcpu/jY559wJPweWgndyZXeE8k=
X-Gm-Gg: ASbGnctCDvvgdk/tKhnkvwO113Ufc4P5BbD+XJ7R+gezfI2o+sZ+wX+6AfmB3vPcVBm
	PD34tziB3Gw5K6pzYx4L1Ki36+1N8KVw3pBVED7r0AFe0+a2ZcvYzbIsTXwdbbuipxhzpJg1jPa
	0bwXrrhp8GohyKSW1ogqySDsYmfHJb9P+Ijv0YYSlIKjMluwTmy4hkbruc3sDeOwbO51PeOJxIb
	ByWPUFg+7aKNRYu2wbjyZ4xk75YAz7sExf4FOp7w54ix1OxfH5qWfznrNqKQ64=
X-Google-Smtp-Source: AGHT+IH2HUQ+XY5AWd7wrPGPnvmbvbSLt8KzksKdJcvdqRJKUPwqI37CvV3L4gFpgWh2H8+Lncy/ncP5xaKiRgSBfY0=
X-Received: by 2002:a05:6102:947:b0:5df:af0f:3094 with SMTP id
 ada2fe7eead31-5dfc5b9fa3amr116681137.42.1763050557931; Thu, 13 Nov 2025
 08:15:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113153220.16961-1-scott_mitchell@apple.com> <aRX_VP61EqRM-8z7@strlen.de>
In-Reply-To: <aRX_VP61EqRM-8z7@strlen.de>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Thu, 13 Nov 2025 08:15:46 -0800
X-Gm-Features: AWmQ_bmfelQ7mL859A_WFlpN488ACFKOjNy8IKc90uyX9-mjfPmXI3utiSYZVBs
Message-ID: <CAFn2buAJY0RpSBAevCVavq9cUkenBKe3QcnXFA+5qqiS=8z5rA@mail.gmail.com>
Subject: Re: [PATCH v3] netfilter: nfnetlink_queue: optimize verdict lookup
 with hash table
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, kadlec@netfilter.org, phil@nwl.cc, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 7:55=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Scott Mitchell <scott.k.mitch1@gmail.com> wrote:
> > +static int
> > +nfqnl_hash_resize(struct nfqnl_instance *inst, u32 hash_size)
> > +{
> > +     struct hlist_head *new_hash, *old_hash;
> > +     struct nf_queue_entry *entry;
> > +     unsigned int h, hash_mask;
> > +
> > +     hash_size =3D nfqnl_normalize_hash_size(hash_size);
> > +     if (hash_size =3D=3D inst->queue_hash_size)
> > +             return 0;
> > +
> > +     new_hash =3D kvcalloc(hash_size, sizeof(*new_hash), GFP_KERNEL_AC=
COUNT);
>
> This doesn't work, please re-test with LOCKDEP enabled before sending
> next version.
>
> > +     inst->queue_hash =3D kvcalloc(hash_size, sizeof(*inst->queue_hash=
),
> > +                                 GFP_KERNEL_ACCOUNT);
>
> .. and this doesn't work either, we are holding rcu read lock and
> the queue instance spinlock, so we cannot do a sleeping allocation.
>
> That said, I don't see a compelling reason why rcu read lock is held
> here, but resolving that needs prep work :-/
>
> So there are only two choices:
> 1. add a prep patch that pushes the locks to where they are needed,
>    the rebase this patch on top
> 2. use GFP_ATOMIC like in v1 and update comment to say that
>    GFP_KERNEL_ACCOUNT would need more work to place allocations
>    outside of the locks.

I will go with option 2 to make incremental progress.

