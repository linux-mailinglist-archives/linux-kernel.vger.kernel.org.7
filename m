Return-Path: <linux-kernel+bounces-792432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC8FB3C3D3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD121726A7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B65343207;
	Fri, 29 Aug 2025 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wk0W3tb5"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF9230BDF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499779; cv=none; b=JO1wEFOY0u78Ey4jxCTAK0LMpqTpRUuqjZ3VyCsfZFMAFcErqY/dzGQ5k1Ck8UAZ0dJE9ZRAGv6TjWaf1MAPOujfr7Ba7VIxQkY6FnfRaGk+yxPBi775eDlr9Km90FMcBZ53MDcfcH7bOE+uV34kVjBBr5mOGNBACBCdwaw5Vmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499779; c=relaxed/simple;
	bh=f7FJrEwVoxFWdpi8JaS9q1mpqcfezXqHvjbf5vjaYjA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VIPdnM7xNrlnxBwVSkJwRzpPcBMtNO9jJCIT3ljy9SKtCdgBx0QBpQf8arsahMcepXsfBqdPaiM8HGWuU9YRlAtpJ9lCsiL/Y4amm226KjvgstxbHSorYXsPVPJOmxPrCi+k7bXYKRYEF+xDmeghc+O/5cIIOkynzfB0wMdk7dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wk0W3tb5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-327b00af618so2376015a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756499777; x=1757104577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1EnoJm+fc1GCJ0sZfgEWZ3hG+HPHGdLPejXFy3Ozn4=;
        b=Wk0W3tb51F8W4nvZS+IZz+lh1/3w50XiY6Gc9arvpDfvGAdQxyr0YOo/SMgMDJ16KX
         jvFTnOBnQ31RkP9pFs7JdRVWGS1W+Hs4zjuro3CreqEJgx4WAzAhPa8AuVuJPyIjF2QL
         SKChe9EVIwEU0Ty1t0EoCCqtUaaAIlpq3Kbjn2m1nfye5fwcUu+6S6jQ7oDmBtWDMcgW
         EBEeKN7GmV/YBFAGuEfVLkFEFRctu/vtMoFJUoZCxvpMLOHcmuMpDcQySHr16Y9g9/nB
         UXEuMM+41q6Seu4DMVXJbLYuEHnWF4l4RkXx7UB1tY8efNvVT02NCvxO7+ICs8ySLvNC
         CIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756499777; x=1757104577;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S1EnoJm+fc1GCJ0sZfgEWZ3hG+HPHGdLPejXFy3Ozn4=;
        b=quKFcqaiNypPxFJUTxk62T183Yym/H4sTP1wwiPaV/QraXs9xL1mNPSjzpTCYKcagN
         xBQT2VDANk26f6xTkYnq9s5M+BJ2mTuIrYSaUcvkVfF7LzsXIvS2bi5JWEiF5gguK0v3
         Mp72FkVT0LaEJnoRqJIjZmrhS3ySBjxEa/urm2kKUCVwBU1Bx4lqDn2iuhOAnQlBITkc
         qBpMEfH6MLPNSfSGqJ4aySB/sZyS14xX/m8wCHZexuIpx/LOpOERUBfwcT/FJ82aG+OI
         KF1KyqKyqRM9XihnoLqvY8p04anjwTvJROEwei6Ov6cL/EzXRcUQwEtG+pavHLMWzGch
         ipxw==
X-Forwarded-Encrypted: i=1; AJvYcCU6jaxOP/4zvJrXGUfcmldTAoyYbWY7ca6wL36fq8qlTJZCSVdo5Uum7aE0hFPHmwRn3Urae9ATpeAk3m8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkO2MZie5C3nQXXcaV4gKwFL0byX/ndW7K0oOPKJWD0Fz24khi
	ny5WYIUrco4a3Lb0sJ9ZVPDxtpitsr7Gb+GzxVEiLCop5fADjp9o9340BD8T3WG3cUp/OC4El7Z
	DjXLGmw==
X-Google-Smtp-Source: AGHT+IGDq8HMhbSf1ct91NB28Eh1Vrb9NeRli4XiXTjPP+TZZznO1vcEZTtmQOOPKF5flycqX6LRHZLxqng=
X-Received: from pjbpd13.prod.google.com ([2002:a17:90b:1dcd:b0:31e:cdb5:aa34])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2682:b0:327:e34e:eb0c
 with SMTP id 98e67ed59e1d1-327e34eed02mr6130218a91.7.1756499776809; Fri, 29
 Aug 2025 13:36:16 -0700 (PDT)
Date: Fri, 29 Aug 2025 13:36:15 -0700
In-Reply-To: <caf7b1ea18eb25e817af5ea907b2f6ea31ecc3e1.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <6783241f1bfadad8429f66c82a2f8810a74285a0.camel@infradead.org>
 <aKeGBkv6ZjwM6V9T@google.com> <fdcc635f13ddf5c6c2ce3d5376965c81ce4c1b70.camel@infradead.org>
 <01000198cf7ec03e-dfc78632-42ee-480b-8b51-3446fbb555d1-000000@email.amazonses.com>
 <aK4LamiDBhKb-Nm_@google.com> <e6dd6de527d2eb92f4a2b4df0be593e2cf7a44d3.camel@infradead.org>
 <aLDo3F3KKW0MzlcH@google.com> <ea0d7f43d910cee9600b254e303f468722fa355b.camel@infradead.org>
 <54BCC060-1C9B-4BE4-8057-0161E816A9A3@amazon.co.uk> <caf7b1ea18eb25e817af5ea907b2f6ea31ecc3e1.camel@infradead.org>
Message-ID: <aLIPPxLt0acZJxYF@google.com>
Subject: Re: [PATCH v2 0/3] Support "generic" CPUID timing leaf as KVM guest
 and host
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <pdurrant@amazon.co.uk>, Fred Griffoul <fgriffo@amazon.co.uk>, 
	Colin Percival <cperciva@tarsnap.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Graf (AWS), Alexander" <graf@amazon.de>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025, David Woodhouse wrote:
> On Fri, 2025-08-29 at 11:08 +0000, Durrant, Paul wrote:
> > On 29/08/2025, 10:51, "David Woodhouse" <dwmw2@infradead.org=C2=A0<mail=
to:dwmw2@infradead.org>> wrote:
> > [snip]
> > > =E2=80=A2 Declare that we don't care that it's strictly an ABI change=
, and
> > > VMMs which used to just populate the leaf and let KVM fill it in
> > > for Xen guests now *have* to use the new API.
> > >=20
> > >=20
> > > I'm actually OK with that, even the last one, because I've just notic=
ed
> > > that KVM is updating the *wrong* Xen leaf. 0x40000x03/2 EAX is suppos=
ed
> > > to be the *host* TSC frequency, and the guest frequency is supposed t=
o
> > > be in 0x40000x03/0 ECX. And Linux as a Xen guest doesn't even use it
> > > anyway, AFAICT
> > >=20
> > > Paul, it was your code originally; are you happy with removing it?
> >=20
> > Yes, if it is incorrect then please fix it. I must have become
> > confused whilst reading the original Xen code.=20
>=20
> The proposal is not to *fix* it but just to rip it out entirely and
> provide userspace with some way of knowing the effective TSC frequency.
>=20
> This does mean userspace would have to set the vCPU's TSC frequency and
> then query the kernel before setting up its CPUID. And in the absence
> of scaling, this KVM API would report the hardware TSC frequency.

Reporting the hardware TSC frequency on CPUs without scaling seems all kind=
s of
wrong (which another reason I don't like KVM shoving in the state).  Of cou=
rse,
reporting the frequency KVM is trying to provide isn't great either, as the=
 guest
will definitely observe something in between those two.=20

> I guess the API would have to return -EHARDWARETOOSTUPID if the TSC frequ=
ency
> *isn't* the same across all CPUs and all power states, etc.

What if KVM advertises the flag in KVM_GET_SUPPORTED_CPUID if and only if t=
he
TSC will be constant from the guest's perspective?  TSC scaling has been su=
pported
by AMD and Intel for ~10 years, it doesn't seem at all unreasonable to rest=
rict
the feature to somewhat modern hardware.  And if userspace or the admin kno=
ws
better than KVM, then userspace can always ignore KVM and report the freque=
ncy
anyways.

