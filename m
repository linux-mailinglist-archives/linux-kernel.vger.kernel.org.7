Return-Path: <linux-kernel+bounces-798393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6780B41D39
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36BDC680319
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA692FB96D;
	Wed,  3 Sep 2025 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OtO/c1uL"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49222E8B8F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756899730; cv=none; b=Pxgh2hF2cXek8bc3q3jK8cc5+sjGLwSemUp/gzRuUyDw3mP1SaDx8bT6qwc9/IHPGqw77GZ1PU4X0BBaqJGmfyH25BzxQa7o6lqHQDEb9OTqLbR+u36OJTF43fODt5p0J2Qd8qEPKiCWYfzJoFm1zcp42QkxQFG+WCYZHL66xCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756899730; c=relaxed/simple;
	bh=0rqJGPrSdA1PEzC6ErrBXnN/AHdlqO4b6tAy+IDJM30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdM60xQPju0pSKLmUorRq2iIuqxVVNy2wi6PYTkZght70tdtuK9VRblsUCdxDZwOhhVcHA4bWPfRXZtm86DzDcLZTHL5sq5Yo33yO8f9pHRn6xz9V7iISW0wlMheLULQriwRh9j9d8HLJ19AmoFB47M38E42mkFMRA6QQwOOJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OtO/c1uL; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b47052620a6so680203a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756899728; x=1757504528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft7a1y38TQmqSZ+GiWBdbP1PqNWAejf1LfumBwWdqBM=;
        b=OtO/c1uL/uwzSC6eQGa75Ch1Gc2GN3XLl1F49JzfMU5n+t4EJKGQdXKjbpe+Maxn9D
         V1b9eC1G8y6i9IgvLXdEvciQzZ1xkW5kOSit5jnE4vV1wragSMHgF/m5r9+Dh+Nz2mwy
         SVnFE7WyU5NIByTmJaLAUgDNRITgTg95RU6Vdpq+AEDOZUvSBpvEqQdc+AU04tPv6eOY
         TQE4/aJ1Z/nzS8zVmFNy/Vs9DGQRg4xRIixteRNRE12374A408YlQFSmbEzF8wwpdCB4
         vfGAM2TSfpI9dChoOtYfjxZ0jkq8SO7xF43ppWfwnnh/HCe2SdOiNFGd5cGb3ptI4pf3
         jl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756899728; x=1757504528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ft7a1y38TQmqSZ+GiWBdbP1PqNWAejf1LfumBwWdqBM=;
        b=ryclyitBOnQ6V0kK5jO3oew0wDtVTZ7w557aBZlc/rSbCWy7vpZaJ7jHl+rOzGDX5z
         BJ55Z4cAj06B8Q/j8VGS2u3zT8pdU1mUQ0yt46k+b0KfMaZv3b54fmYjd0azoqiXlumT
         GL8bE9jhpHser8+32ZPqmW+fyUw1YVHY7D9bm8MWEfWmP4YM4mCqlJZVKqU3H7SoRiLu
         QI2SFjCRw6glr9cWernJCH+iS+HFroRvGKq7VlRe2nO6dTDAI9m9ejUIvoBqPtwHzEzi
         2pJkk8KZchJra1F8jIlNQ58IAA4/1Rki8kgYM2cGNsho3o94Jn7vEJ+IUevoBU17U+1I
         GkFw==
X-Forwarded-Encrypted: i=1; AJvYcCW+vn7Sy4US2gP9UKDidSKrZB2WfSnsJyxgWUkNl+TGXEqlAnQ3CR5i80pq5I9onM6sYhdz6I+ATNY2Ans=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX80999Rr86BrtXyuzRObfAyGvm0omG/2A+XFKl7za1GrwM2V9
	2HFZXEizmynHBp0jDeDPCwt8Bp6VjwF7/c4qnmRc3Wv5yMHPhb+xIwQo+EcpLtb8pjEGAIhPW9d
	BqP1YMSbGZ9re168lWg/slxW7tz1OMXLwfgS8+z9T4g==
X-Gm-Gg: ASbGncuqP0ClWP24soBXNcZVyDswMQ5VkbhBsRLXy0nmqMdvWs7PTEsfJBX5L/LGlJh
	e/dKwXfDWhu2kqpN3tgCeQo/iBnCwSdQWcnEr52wWveUaIFLuGKQqvK3Pj3DSYk1hxGjo52wKmh
	wjUr15+9n29xsr1R9+44JQiZY1pBAPjOs7n4alV0s3MmZZ4AfcPtk/8wr/I2E/YYK6ZbifhHXmL
	Qx6egYuFjti/DM0+vlTtewsPosXwza4k8lmAdUQ386UfNQUmQCmLqyw3c0=
X-Google-Smtp-Source: AGHT+IFtJbKlmEkW5GGySvPf1/HOA+JVG5Zy6u8Y+RfeMdmIZ6i1j+zUKLBeK7ONCJdCDpwadOW6zM4NzlV/gKsIpD0=
X-Received: by 2002:a17:90b:4e88:b0:31c:39c2:b027 with SMTP id
 98e67ed59e1d1-32815438312mr20559057a91.7.1756899728089; Wed, 03 Sep 2025
 04:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902042432.78960-1-luxu.kernel@bytedance.com> <aLciY2putG8g2P9F@andrea>
In-Reply-To: <aLciY2putG8g2P9F@andrea>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Wed, 3 Sep 2025 19:41:57 +0800
X-Gm-Features: Ac12FXyU8EgKWXBaEJy_wfubw9BJFW5J8dcyAUN_yKwbpnfcVBbrt6BJ6erPgkA
Message-ID: <CAPYmKFvLSri1-PKSHfgG03w3zLbp9w2FaY7v5-jM__LufqPf2Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 0/4] riscv: Add Zalasr ISA extension support
To: Andrea Parri <parri.andrea@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, ajones@ventanamicro.com, brs@rivosinc.com, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

Great catch! Thanks a lot for your review.

The problem comes from the mixed use of acquire/release semantics via
fence and via real ld.aq/sd.rl. I would prefer your method (a). The
existing atomic acquire/release functions' implementation can be
further modified to amocas.sq/amocas.rl/lr.aq/sc.rl. I will send the
next version after I finish it and hope you can help with review then.

Best regards,
Xu Lu

On Wed, Sep 3, 2025 at 12:59=E2=80=AFAM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> > Xu Lu (4):
> >   riscv: add ISA extension parsing for Zalasr
> >   dt-bindings: riscv: Add Zalasr ISA extension description
> >   riscv: Instroduce Zalasr instructions
> >   riscv: Use Zalasr for smp_load_acquire/smp_store_release
>
> Informally put, our (Linux) memory consistency model specifies that any
> sequence
>
>   spin_unlock(s);
>   spin_lock(t);
>
> behaves "as it provides at least FENCE.TSO ordering between operations
> which precede the UNLOCK+LOCK sequence and operations which follow the
> sequence".  Unless I missing something, the patch set in question breaks
> such ordering property (on RISC-V): for example, a "release" annotation,
> .RL (as in spin_unlock() -> smp_store_release(), after patch #4) paired
> with an "acquire" fence, FENCE R,RW (as could be found in spin_lock() ->
> atomic_try_cmpxchg_acquire()) do not provide the specified property.
>
> I _think some solutions to the issue above include:
>
>  a) make sure an .RL annotation is always paired with an .AQ annotation
>     and viceversa an .AQ annotation is paired with an .RL annotation
>     (this approach matches the current arm64 approach/implementation);
>
>  b) on the opposite direction, always pair FENCE R,RW (or occasionally
>     FENCE R,R) with FENCE RW,W (this matches the current approach/the
>     current implementation within riscv);
>
>  c) mix the previous two solutions (resp., annotations and fences), but
>     make sure to "upgrade" any releases to provide (insert) a FENCE.TSO.
>
> (a) would align RISC-V and ARM64 (which is a good thing IMO), though it
> is probably the most invasive approach among the three approaches above
> (requiring certain changes to arch/riscv/include/asm/{cmpxchg,atomic}.h,
> which are already relatively messy due to the various ZABHA plus ZACAS
> switches).  Overall, I'm not too exited at the idea of reviewing any of
> those changes, but if the community opts for it, I'll almost definitely
> take a closer look with due calm.  ;-)
>
>   Andrea

