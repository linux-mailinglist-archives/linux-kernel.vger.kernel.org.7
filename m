Return-Path: <linux-kernel+bounces-742898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E1FB0F7FA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E5D3B94DE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FBA1F09A3;
	Wed, 23 Jul 2025 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMPKLfjT"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01FD149C41;
	Wed, 23 Jul 2025 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287627; cv=none; b=SbQGid+WXci95z9nmUbujxnBofaZ++RiXovlgGXszdo3JV2/8J+2erCFwaB8LqvtXVuJEAGkD2g84X7IBOwl4qOJBwlw3galRh7IJ+OxLfLuu4BTI8YSsBMbvTPqn+ZZSSuAZ8hdkORXIcVyKnrTVJTE5RQugm6AhSzlagA4Kqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287627; c=relaxed/simple;
	bh=yqrlYcPr/gWQZYxgyaHk64ebJUeCajl+/S6NptUZvdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ak2q0uc4aXJCa+nC5MQaNtilxO+ty37omfxgNaWAlYwbinorTjPKV/+Q8NblMhEsg15/7P4c/3wTlcdNysjJWy+fowFEgFgNdGVNiKO02AVfWZDOaDlBOYqHe7Vla/OcH+vTgrHWGxi6ObdLDNKXYi0DoL/5rwrbXefgOWFcR8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMPKLfjT; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-7070c45ce55so384276d6.0;
        Wed, 23 Jul 2025 09:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753287625; x=1753892425; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2jomhtmnpUH9sum81nnMcKhB4OeoqYAXQ94vIHmJQEQ=;
        b=bMPKLfjTmskD0MsKJvseuT0CzW9o5zx9ZF4+GVsG0uTLRCJ2g7Jn9hnMqImyytnW3h
         4Vqos7g02cfKmyYFWixxAjPJlG2M30WLfE+aN7Nu1rx50KW96qGSHjQEOMg2CgWJhg8Z
         Al8UA5iBs5PPBKYG+uhhn7fcqEPGBigZgPelu6U2owHJMA4Sk3zkQZjWkYTLwwhWh+gf
         ZD7xXSpRBoqLIvFvEWdocg/irLel0zbr2sW/iT7Nk0fze/YFeveeMwrmVwOurGgh24+5
         yntRVcHGAyk/GOHHG0nZ1Q74Gl4Ou9TJfrbj4u/icHY5hCKjZpBwVU0Yauvg3ivnIWNx
         iYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753287625; x=1753892425;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jomhtmnpUH9sum81nnMcKhB4OeoqYAXQ94vIHmJQEQ=;
        b=V6XsyRy5fP9GwBq5jNzFZGpK/1ZmR+A0iqk9lqQVsSUnuv9tnUnInfIcmGPIomnJC2
         uerW9YnTJQpEtUBOX7tvr0ClQLfroQlOCj0u+n0zjg+VQdH3AgAlSwWNfSnAVEHN6H0S
         c4Q3i/v4b7K/hKhcG6UsvVnD8PlGpL4tpslgPoR/5mM1ojKAhKnaeEcgMANtLOGzJ9ee
         fEQDnKhudAgrB6boYibCCr2gfAoag/z1F4xTWSIl0fi7Pr/Ou86Zj/ykdZ2EylGkrzjl
         11TbNN7GB2Fio4K8Hrx4yK/WcWTH8ZGrjYjvTRpK5TXj+KUWbMgpPQClSBOd7yOOjt17
         XqVA==
X-Forwarded-Encrypted: i=1; AJvYcCV9MWeZbnYFKx4qqzytd88cULdYOFVJA4CT8s2gNrbF+mUtk46dLv7z/OvBvYxAHdGHRoVFEFhF7xyujWM=@vger.kernel.org, AJvYcCVaaoarvKDVq2mLLiGDaErmvv9OUCqQ82PMTN9CVMrM9ZdN6Yn81yXSPajb9ppPrDhfBe8vrApOT7f4isx3upw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPiWKvkL/8IRd1ogKwrmnfukhNvUX/ZBD4n8mneyE3Oej0Kg5h
	qEJ45cZNs/RwtTd0OLSZHhQZ/c5ux0H3g0c1HkVyGHGC5DZZ8cvzqVIk
X-Gm-Gg: ASbGnctaTCs0UJy8/tqqu98QISTQoRkxNAT2TnbRy2gLl3GFgJSoZtzXi353aM8DdTE
	hB4vLer6WscKhezEqa5VnVskZB1HHKlBptclu8mQzueNsvOllU8IYxgEde7w8E217qh0hnPh0OV
	PhCwoHvl8xngZnS9Er3EbJg3JdYRcWdcp+8RXxheFZhqSUv2IHdzleF6PgReQpTjnxc8dmmEYCl
	+n9ZRCMGBBgJ4X551ERi6kzJk4Nc5VPhk2bwkAmZrqNRixuTTA0vmcjC7Y3RsiJYX1XsnVJewtX
	B+V1dOXik+diKLGPnc93+yMitzEfYXUgPiry/qWCtvLmxaGtZ0m7ieDcPwV/TQYBkD+81XAE095
	AsfnnHrC+0Cy0AP5yQGMVnaha+2MgugNSZN+tK441Nqxy4IcgsiZKz8ByYLdl4AV6ExtrTi8Cwb
	IvvfyvGrLSWNo4jONtZx+yFO4ZvandtO3Sxg==
X-Google-Smtp-Source: AGHT+IGA0cc2MsqIi2v3soRYA7wyuboVLwnAUYnmJZ4HX9Wd+I7yOtr1+D3FG3Cnj1zqgW6+UrInkw==
X-Received: by 2002:ad4:5943:0:b0:705:1fc3:ec20 with SMTP id 6a1803df08f44-707006ad90dmr45690406d6.48.1753287624524;
        Wed, 23 Jul 2025 09:20:24 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b90616asm65753976d6.35.2025.07.23.09.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 09:20:24 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id C3F45F40067;
	Wed, 23 Jul 2025 12:20:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 23 Jul 2025 12:20:23 -0400
X-ME-Sender: <xms:xwuBaIE5rwTLJM0ZV5w8YQY_BCWAkzaQczPuTIh0ID4UrIR3DSvZDQ>
    <xme:xwuBaJ-lf0QH3XASsUfChtkkvsQq54vR_M7mzX0oHHTRgXcLDcREEZ9ryRQVFAMog
    NS1qr6UeEkBn55OHg>
X-ME-Received: <xmr:xwuBaJkxn2AusqDjdLqZhA2CWOQuYuSLSmje_1JeEPxmMUVdgJ_S36meVFo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudekhffggeel
    feenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehloh
    hsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtoh
    epsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheprgdr
    hhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtmhhgrhhoshhsse
    humhhitghhrdgvughupdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xwuBaECvLmHq98GVuz2Eb9yvTpjEkZxTkFanElfYfcK97aXQ3OfpeQ>
    <xmx:xwuBaCWJhR45V0J0UiOYW7SkZX2hLdb40qbXGSgJEk_myK6Jtr1oEw>
    <xmx:xwuBaC_cf0SMlezEAJedI0pZn6A3hHAGd5UJi1jcI7o6UJoKl33Ojw>
    <xmx:xwuBaEQ3RfprRy21eOvTudX8R-NNBcQsDBjKDXDiLIIQo2I1pOrabA>
    <xmx:xwuBaHQ2WvApmm7fN_xmU7M7Ihj9VGpwv9cZ14p8V9rW_JcEfNAjw6L8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 12:20:23 -0400 (EDT)
Date: Wed, 23 Jul 2025 09:20:22 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: sync: refactor static_lock_class!() macro
Message-ID: <aIELxq_iVMfjszkh@tardis-2.local>
References: <20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com>
 <20250723-lock-class-key-cleanup-v1-1-85fa506b8ca4@google.com>
 <DBJIDFSMYASO.3VRN4ZZEUI8EX@kernel.org>
 <CAH5fLgjWFa8TjTL+rfv7Zd+OQqhkKqWvyTkGf60pMUyQ=c4sXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjWFa8TjTL+rfv7Zd+OQqhkKqWvyTkGf60pMUyQ=c4sXg@mail.gmail.com>

On Wed, Jul 23, 2025 at 05:01:39PM +0200, Alice Ryhl wrote:
> On Wed, Jul 23, 2025 at 4:36 PM Benno Lossin <lossin@kernel.org> wrote:
> >
> > On Wed Jul 23, 2025 at 1:49 PM CEST, Alice Ryhl wrote:
> > >  impl LockClassKey {
> > > +    /// Initializes a statically allocated lock class key.
> > > +    ///
> > > +    /// This is usually used indirectly through the [`static_lock_class!`] macro.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// The destructor must never run on the returned `LockClassKey`.
> >
> > I don't know how lockdep works, but Boqun mentioned in the other thread
> > that it uses the address of static keys. But AFAIK there is no mechanism
> > to differentiate them, so does lockdep just check the address and if it

In lockdep, we use `static_obj()` to tell whether it's a static obj or a
dynamic allocated one.

> > is in a static segment it uses different behavior?
> >
> > Because from the safety requirements on this function, I could just do
> > this:
> >
> >     // SAFETY: we leak the box below, so the destructor never runs.
> >     let class = KBox::new(unsafe { LockClassKey::new_static() });
> >     let class = Pin::static_ref(KBox::leak(class));
> >     let lock = SpinLock::new(42, c_str!("test"), class);

This will trigger a runtime error because `class` is not static, but
technically, it won't trigger UB, at least lockdep should be able to
handle this case.

Regards,
Boqun

> >     let _ = lock.lock();
> >
> > Because if lockdep then expects this to be initialized, we need to
> > change the requirement to only be used from statics.
> 
> My understanding is that it has to with correctly handling reuse of
> the same key. In your scenario it's not reused.
> 
> Alice

