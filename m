Return-Path: <linux-kernel+bounces-823943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1E5B87C78
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8207A789A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A56A230D14;
	Fri, 19 Sep 2025 03:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Haf1VF9E"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D7434BA2B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758251919; cv=none; b=Eo+LSaOBtHrQmjtEsqHHVGNngsY6dPiGI5gn+Wh5xFo8rh1Mcpkuoau16wpDRC+gXrpeUGjutQfD6oAB/2e5JuxQLuwJ5bb6YgwQaFw/YxXU9BzgWjuI4ONnuxp4v3ool9l8ve/tPXA6diA4QHQgHu1Y4F4M+jHU40eBm8+Plj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758251919; c=relaxed/simple;
	bh=2gRTbo0mBHkR4bjRfdj6Zo44eQJCdz0V/yUwVjwMFqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlaI14fJWk7eSyHOIW6KBu/63DsITfivVPQEM0KSiWvbhpFEUOMg/bA+sLuV5h4vNVw5STkTRFTPw5tZ7YWEFTrZKvhzfxzIEUcRBIg2mDq4WEUqfvWoz7m7Ja2HGnCAcuEhbanJWexBfAaAbXRiRs8bP89bPvMXxXodRktACbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Haf1VF9E; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32bb1132c11so2306389a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758251917; x=1758856717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nIkn8MOZTzpunLL/LuuQCeetAKojVprXC6dAWsG/zRA=;
        b=Haf1VF9E9cc8urw1sk1HVSR3N0SVY12+3bwlV4a6Aw6LdV610mgd342comwL85YHfl
         wKE+0UJapnl/EEjD7W9VZ+0lMLFWPAgV2Pbi4GPj7CfVUjVnMx4iybbXYr+mQ1hcI77U
         J9OiEAwX+fxou8wZRISaMmnN2lWaRHARFiRF58t4uIJJCoAYJ8Yrrv1WK7qs4yXxToUe
         pAchfEl0Rhj9X8zLXfB8qmPKxVwMtmcUaDyOrWrqpxXFyZ7Eb104sPjoaSUurngU4EHL
         Q7ISIgZTbJKzxWxVresDjx9a0qEvx1+7vrcyQPJpyJNYXch2IodySByRvLNj2qT/qtn1
         tRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758251917; x=1758856717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIkn8MOZTzpunLL/LuuQCeetAKojVprXC6dAWsG/zRA=;
        b=TA35EJOaiSf6nd8m3O3YP/F0anElOLwIF/2jFFn8MByUv6oP6GHwD/6lbhuUSLEVoZ
         csqTwfdwDS6gyKNC1LJ8KZiEozMiYICFiEk7AXT06furgrXaYWYPVwGMVRKFMaOGRV5D
         JBnLvxBGCq1+l+gvoNoID7BgBc767GJxq+rONvusbzWtquSuxWkVX/MOumOe4BbSQ0Ia
         S28cGfPmCqFmB0TF6q846hea2vyGRleGYrDjXp6odoJgsE6HqM0jn9EJu0+iJiFp65J2
         gE1XfeNqDMuwxAPyePjB8TiNE+dNwUfk0UILgNQ2TgexjWoerUwhOezHa+fNwpcsuOTM
         bOzw==
X-Forwarded-Encrypted: i=1; AJvYcCXHu9ULygLz7iZwWzp7zU+yXt+gvC88sKhxEcE64T+K6xBFFBqEXaSns49RoFTrMLzJvEL6Rf/egdyvn/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9DFOSF+XpXFFZEfcciKd9bxMaTQfuNA/QnXqZbF+t3/ePx3uH
	PG929wzfA9r0KAnXtj8WXpJf1drRK4y6TmZ6qpOCKR/HF65fcBw9p9Fmrcd3IMyYGpaJUJWrUAn
	DxHt5LXsdq/rgq2Vpe/mCYkNoXpbFk+SK12NFaKhwzw==
X-Gm-Gg: ASbGncs4DIu8p7ZpiAZRmby9wqvDCIQb1b1OdAlkVQH+MnhX8S5wlDJlGqItTMex7GM
	CukfvQemyaYZD+iX+pcb/8bk7idqPluHE1HPBQIruFGuoIgEB8Et+awGANmQ2Pi1zgk6KvbaODP
	i/mYmpj5sSohOkjoPywp8H9LDcl9ZAfxSB+sP8VU6GZFKyB1A7d9OuzgT79reoIEPHrmhgiyYSv
	3tr6ITdDBRNUwOHNWVt1Hv5YEtbRRDVR4fRnRtptgPwRc9YsAwv9oNzDr2KSCcYoKHdUQ==
X-Google-Smtp-Source: AGHT+IFRWm1rtEbNwR3KFGPErRdd4R3mVRRvu48MrjC5a8f6eCYbxLpbuUvGVcgYOFHQ0WWKCVTztLX1ywhALcobmiU=
X-Received: by 2002:a17:90b:53cc:b0:32b:d8a9:8725 with SMTP id
 98e67ed59e1d1-3305c720a3bmr7519323a91.18.1758251916956; Thu, 18 Sep 2025
 20:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902042432.78960-1-luxu.kernel@bytedance.com>
 <aLciY2putG8g2P9F@andrea> <aMoyntAydNMtcl+3@gmail.com> <aMw3504EwlnDOJI0@gmail.com>
In-Reply-To: <aMw3504EwlnDOJI0@gmail.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Fri, 19 Sep 2025 11:18:25 +0800
X-Gm-Features: AS18NWC5wNl-OoaIA1pu7i6YWk6e1w0Ks7T1bU_3DmOuyDn3wFuQceusY1o8ZPo
Message-ID: <CAPYmKFt=5=t_nxY4FadG0_vSgAu1tXyO15OCvo5x6QorqM+BAw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 0/4] riscv: Add Zalasr ISA extension support
To: Guo Ren <guoren@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, ajones@ventanamicro.com, 
	brs@rivosinc.com, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com
Content-Type: multipart/mixed; boundary="000000000000efcba9063f1eec9d"

--000000000000efcba9063f1eec9d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guo Ren,

Thanks for your advice.

On Fri, Sep 19, 2025 at 12:48=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, Sep 17, 2025 at 12:01:34AM -0400, Guo Ren wrote:
> > On Tue, Sep 02, 2025 at 06:59:15PM +0200, Andrea Parri wrote:
> > > > Xu Lu (4):
> > > >   riscv: add ISA extension parsing for Zalasr
> > > >   dt-bindings: riscv: Add Zalasr ISA extension description
> > > >   riscv: Instroduce Zalasr instructions
> > > >   riscv: Use Zalasr for smp_load_acquire/smp_store_release
> > >
> > > Informally put, our (Linux) memory consistency model specifies that a=
ny
> > > sequence
> > >
> > >   spin_unlock(s);
> > >   spin_lock(t);
> > >
> > > behaves "as it provides at least FENCE.TSO ordering between operation=
s
> > > which precede the UNLOCK+LOCK sequence and operations which follow th=
e
> > > sequence".  Unless I missing something, the patch set in question bre=
aks
> > > such ordering property (on RISC-V): for example, a "release" annotati=
on,
> > > .RL (as in spin_unlock() -> smp_store_release(), after patch #4) pair=
ed
> > > with an "acquire" fence, FENCE R,RW (as could be found in spin_lock()=
 ->
> > > atomic_try_cmpxchg_acquire()) do not provide the specified property.
> > >
> > > I _think some solutions to the issue above include:
> > >
> > >  a) make sure an .RL annotation is always paired with an .AQ annotati=
on
> > >     and viceversa an .AQ annotation is paired with an .RL annotation
> > >     (this approach matches the current arm64 approach/implementation)=
;
> > >
> > >  b) on the opposite direction, always pair FENCE R,RW (or occasionall=
y
> > >     FENCE R,R) with FENCE RW,W (this matches the current approach/the
> > >     current implementation within riscv);
> > >
> > >  c) mix the previous two solutions (resp., annotations and fences), b=
ut
> > >     make sure to "upgrade" any releases to provide (insert) a FENCE.T=
SO.
> > I prefer option c) at first, it has fewer modification and influence.
> Another reason is that store-release-to-load-acquire would give out a
> FENCE rw, rw according to RVWMO PPO 7th rule instead of FENCE.TSO, which
> is stricter than the Linux requirement you've mentioned.

The existing implementation of spin_unlock, when followed by
spin_lock, is equal to 'FENCE rw, rw' for operations before
spin_unlock
 and after spin_lock:

spin_unlock:
    fence rw, w
    sd
spin_lock:
    amocas
    fence r, rw

The store-release semantics in spin_unlock, is used to ensure that
when the other cores can watch the store, they must also watch the
operations before the store, which is a more common case than calling
spin_unlock immediately followed by spin_lock on the same core. And
the existing implementation 'fence rw, w' 'fence r, rw' is stricter
than '.aq' '.rl'. That is why we want to modify it.

I have reimplemented the code and it now looks like the attached text
file. I will send the patch out later.

Best Regards.

Xu Lu

>
> >
> > asm volatile(ALTERNATIVE("fence rw, w;\t\nsb %0, 0(%1)\t\n",  \
> > -                       SB_RL(%0, %1) "\t\nnop\t\n",          \
> > +                       SB_RL(%0, %1) "\t\n fence.tso;\t\n",  \
> >                         0, RISCV_ISA_EXT_ZALASR, 1)           \
> >                         : : "r" (v), "r" (p) : "memory");     \
> >
> > I didn't object option a), and I think it could be done in the future.
> > Acquire Zalasr extension step by step.
> >
> > >
> > > (a) would align RISC-V and ARM64 (which is a good thing IMO), though =
it
> > > is probably the most invasive approach among the three approaches abo=
ve
> > > (requiring certain changes to arch/riscv/include/asm/{cmpxchg,atomic}=
.h,
> > > which are already relatively messy due to the various ZABHA plus ZACA=
S
> > > switches).  Overall, I'm not too exited at the idea of reviewing any =
of
> > > those changes, but if the community opts for it, I'll almost definite=
ly
> > > take a closer look with due calm.  ;-)
> > >
> > >   Andrea
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >

--000000000000efcba9063f1eec9d
Content-Type: text/plain; charset="US-ASCII"; name="zalasr.txt"
Content-Disposition: attachment; filename="zalasr.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mfq9rbsu0>
X-Attachment-Id: f_mfq9rbsu0

fC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18CnwgICAgfCAgICBhcmNoX3hj
aGdfcmVsZWFzZSAgICAgICB8ICAgICBhcmNoX2NtcHhjaGdfcmVsZWFzZSAgICAgfCAgICAgX19z
bXBfc3RvcmVfcmVsZWFzZSAgICAgfAp8ICAgIHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLXwKfCAgICB8IHphYmhhICAgICAgfCAhemFiaGEgICAgICAgIHwgemFiaGEremFjYXMgfCAh
KHphYmhhK3phY2FzKSB8IHphbGFzciAgICAgICAgfCAhemFsYXNyICAgICB8CnwgcmwgfC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfAp8ICAgIHwgICAgICAgICAgICB8IChmZW5jZSBy
dywgdykgfCAgICAgICAgICAgICB8IChmZW5jZSBydywgdykgIHwgICAgICAgICAgICAgICB8IGZl
bmNlIHJ3LCB3IHwKfCAgICB8IGFtb3N3YXAucmwgfCBsci53ICAgICAgICAgIHwgYW1vY2FzLnJs
ICAgfCBsci53ICAgICAgICAgICB8IHN7YnxofHd8ZH0ucmwgfCBze2J8aHx3fGR9ICB8CnwgICAg
fCAgICAgICAgICAgIHwgc2Mudy5ybCAgICAgICB8ICAgICAgICAgICAgIHwgc2Mudy5ybCAgICAg
ICAgfCAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgfAp8LS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLXwKfCAgICB8ICAgIGFyY2hfeGNoZ19hY3F1aXJlICAgICAgIHwgICAg
IGFyY2hfY21weGNoZ19hY3F1aXJlICAgICB8ICAgIF9fc21wX2xvYWRfYWNxdWlyZSAgICAgICB8
CnwgICAgfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfAp8ICAgIHwgemFiaGEgICAg
ICB8ICF6YWJoYSAgICAgICAgfCB6YWJoYSt6YWNhcyB8ICEoemFiaGEremFjYXMpIHwgemFsYXNy
ICAgICAgICB8ICF6YWxhc3IgICAgIHwKfCBhcSB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS18CnwgICAgfCAgICAgICAgICAgIHwgbHIudy5hcSAgICAgICB8ICAgICAgICAgICAgIHwg
bHIudy5hcSAgICAgICAgfCAgICAgICAgICAgICAgIHwgbHtifGh8d3xkfSAgfAp8ICAgIHwgYW1v
c3dhcC5hcSB8IHNjLncgICAgICAgICAgfCBhbW9jYXMuYXEgICB8IHNjLncgICAgICAgICAgIHwg
bHtifGh8d3xkfS5hcSB8IGZlbmNlIHIsIHJ3IHwKfCAgICB8ICAgICAgICAgICAgfCAoZmVuY2Ug
ciwgcncpIHwgICAgICAgICAgICAgfCAoZmVuY2UgciwgcncpICB8ICAgICAgICAgICAgICAgfCAg
ICAgICAgICAgICB8CnwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfAoKKGZl
bmNlIHJ3LCB3KSwgKGZlbmNlIHIsIHJ3KSBoZXJlIG1lYW5zIHN1Y2ggaW5zdHJ1Y3Rpb25zIHdp
bGwgb25seSBiZSBpbnNlcnRlZCB3aGVuIHphbGFzciBpcyBub3QgaW1wbGVtZW50ZWQu
--000000000000efcba9063f1eec9d--

