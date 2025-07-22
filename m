Return-Path: <linux-kernel+bounces-741019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A040B0DEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32212582B39
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE1F2EAB8C;
	Tue, 22 Jul 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTI1FH+0"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D7C2236E8;
	Tue, 22 Jul 2025 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194872; cv=none; b=sTM8T9UL7PrJ12jrze7KSsBPgBR/CMXNSKDOfGsNJaJhvB3qvejq1lt3hSgbPo+1aSpeXyF0tNSado2DD7cnEp30tI2enczIRUZ8+ckOfZAYVqOojYzcJtG3V37LgzlWKX4+4hYctWwkG6X2AmB7+icZebaRhuvb0onqVqNxpKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194872; c=relaxed/simple;
	bh=WbS1AEBNeY7MKsTnTG+Fdp4S4p4dysRYufHASJvUyCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kypXrdaAmvxPaBnZb05opBozk2ENZziI02CIGBblRFvZbBUAY97fspX/vHql1ut9x72W8uZOBbi98uxq10Q5PoWz530vR0nPvmplOK0miLKb3tSQaGCQjozCy6jKYurYsICv23l3FqDc4RrcTC7Wxl6CUs6GYGtQZ1RFWoBkM1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTI1FH+0; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e2e3108841so654540785a.3;
        Tue, 22 Jul 2025 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753194870; x=1753799670; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XXA8ehJAeU9SuKzdIpK8b9KgCTF/AV+BxhlLom5+gUQ=;
        b=LTI1FH+0tLEnWynB/b58clrKgfav6kGw6A5HcVeR33H50bq/+8lwxnKVU0WGTDYQjw
         RWUatIGi4TekKlS4K7237DN7xlzVaJJBcGZZMX6sHzM7kdjfHyaukYe2+2134+MoMYIm
         CpTfOwgo+Zm/56SKHeHXsxaVIRNFeCQeE2BzS9hVz9feNOsm5nQQ/r0CYXqzOU9ZuKNR
         e19tGP9FOHwfR/AvhWxvUsjZAedd7XvdvZHAPCSGP1ayOotHVdJZ6Y0f+MP/E1Jh5JJG
         s3M/OkmS8w98SIw0OkAbvh1oi4c8c65YXiNeK4e3FtFLwAVfsdNZgyvDYXbX/BHuPRBU
         kq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194870; x=1753799670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXA8ehJAeU9SuKzdIpK8b9KgCTF/AV+BxhlLom5+gUQ=;
        b=Rxyq0JHufUdyrZq4NKcvLfLwbQ7Bdp1ynvayRs3m4DVoK1e/SWalfmjkeEVqbf4AC0
         9SpaTlvxmgnaMG3RKcdseWtOnQhq0XTEtYLc7wFwIwUvAPDcwM+flyRwMW/87MGuTWqX
         47PE3eJjEr/7HKZj+wb9aPa3golDZqR0FsAKk4S6NMdCOM1F+uI9ODwHcdVdrVuGsy+5
         L5fRUC5A9sbychzdG9rePOz7xBI8EPPkIq6mWIVGmD8tbMiZExywVR2xYJVTJIb6zo3E
         ji6nggIjcNvt2YeHyutiNtlk5yNgxcWtfOwIUV211gILoGJKKv1IK9iOTCvAqPozbU8t
         YFYA==
X-Forwarded-Encrypted: i=1; AJvYcCUhUf+tT1w2ni9gIyhW6qi5z70xZ672YOsF2tgMBSnTx23mXEZsh/27povpBbqTeorhbGtg/JUEgqFBI9g=@vger.kernel.org, AJvYcCVPRCz5WAoXAUBWc2jhWsuk17U8jUKlNaeQeWT4vEgjazb6+x8W4d2O+Z2f4gPVfrqCNHfc//VPLb4l5UE7Cvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ93Nzo2sZqk7+MPw8j6rY1rIjnlmBED/L/l+YZA8c1TGtchVs
	nzs0J/+t69E33D7kMOiNWlBXYPe0CvfPHBzoazPoFPLu3pF9ZxIIDEOb
X-Gm-Gg: ASbGncsXkdsUpXcvPL+PYdRxF/Q1bZo5Ent+HPkIwU1KK8DN7xTAJTAx6J+2QKHe01J
	JSlQ5aSkyKl0nJ8s8XXstq63njPO0q1vtFNK3EAOQYyJI7FB+2xlJOt4Qq4XUH/mkzzSOMPyqtn
	GFewGU5UQjdOLXr47r/kS4IeVoLD8EcdhmYetiWHgzBgTJQKhfSzKgOlfWVvxUfkBGP307wXAHM
	q7iorv9D2ZMC9DYjHpdLgSKKrQWqBEmxtc03uLvoREBgP1MApB5p54z84yyHtmhx8Ll1yJNeFYR
	SpzgUl0cKXaXYJNOkBUVliw1iIiS2aBCEKPtNIaeJBgy5dSjBuqpIIydOnSBYlbzyIMSDqgcP3R
	qtB9fnfxL5oBdnqFQncg54Dxgjs+vuZWwK0a7LVP/MminlmYSa86D52O+9L01tleBmM//hFob6D
	KiZ40D1S9xpUQ4WgTso2Vpwxs=
X-Google-Smtp-Source: AGHT+IGC4psX7BFwVp5/EZt6AoO2fspksDrjm6JpJHYnD3pPfkeUYVyd8slfJ9SVHbiSFD5UxYWBkg==
X-Received: by 2002:a05:6214:8113:b0:704:f7d8:703e with SMTP id 6a1803df08f44-704f7d88982mr248917056d6.50.1753194869529;
        Tue, 22 Jul 2025 07:34:29 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051bab2a55sm52170026d6.96.2025.07.22.07.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 07:34:29 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 826B2F40068;
	Tue, 22 Jul 2025 10:34:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 22 Jul 2025 10:34:28 -0400
X-ME-Sender: <xms:dKF_aNKo4bahADCRMV18cZHgHpDbozMzBWiWyqfShDKy0ETsRJ3xSg>
    <xme:dKF_aBCYBHR-mpvo_F0dnHdqPU2WSv4ooDvp_IjZNe9sbg3Dx9OaaUCyGOyQ-pFNF
    Gjql-Yo2h1Hy3UJHA>
X-ME-Received: <xmr:dKF_aFF-Bkm_vXObk0kvYmDlaY_PYmapp-yM4FdscdTLU427xnj-4eYEPQo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejheduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejhfeikeekffejgeegueevffdtgeefudetleegjeelvdffteeihfelfeehvdeg
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    peduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhoshhsihhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgi
    drghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihg
    uhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhr
    tghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    htmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:dKF_aGIWPrJxLP-tx3DeaeM3spRkxBO3bs1CsD8nYcx2Ih7SQTqOWQ>
    <xmx:dKF_aMrRaSocZCYI943g00YAnmXPieb-1AwGiOiVCs-OvQH2JJiaWA>
    <xmx:dKF_aNjqvSkKLM79YhvAHy5--BjuvGk-ucavxD50CiPvlZwUym_TxA>
    <xmx:dKF_aLZZYQfJPS-EBunA9ZuMTd-2ezhPGEScIhH39Ku12IJ3Sme3Fg>
    <xmx:dKF_aFn00_IUNKSSE19RlBILYXl6q97oG2bfsEpHr1kOR3p2VyQBov73>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 10:34:27 -0400 (EDT)
Date: Tue, 22 Jul 2025 07:34:26 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>,
	Mitchell Levy <levymitchell0@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: sync: fix safety comment for `static_lock_class`
Message-ID: <aH-hcnZ3hiQIQj-5@tardis-2.local>
References: <20250520231714.323931-1-lossin@kernel.org>
 <DBIJLR7XNI6U.21PMPODHE83DZ@kernel.org>
 <CAH5fLgh9aEF5V9rNq2a8utS=NxSU8rdxpKsNbsuPoMpDfHN0fg@mail.gmail.com>
 <DBIKI0KDP1J8.3MOHF5G3A6JEH@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DBIKI0KDP1J8.3MOHF5G3A6JEH@kernel.org>

On Tue, Jul 22, 2025 at 02:03:25PM +0200, Benno Lossin wrote:
> On Tue Jul 22, 2025 at 1:34 PM CEST, Alice Ryhl wrote:
> > On Tue, Jul 22, 2025 at 1:21 PM Benno Lossin <lossin@kernel.org> wrote:
> >> On Wed May 21, 2025 at 1:17 AM CEST, Benno Lossin wrote:
> >> > The safety comment mentions lockdep -- which from a Rust perspective
> >> > isn't important -- and doesn't mention the real reason for why it's
> >> > sound to create `LockClassKey` as uninitialized memory.
> >> >
> >> > Signed-off-by: Benno Lossin <lossin@kernel.org>
> >> > ---
> >> >
> >> > I don't think we need to backport this.
> >> >
> >> > ---
> >> >  rust/kernel/sync.rs | 7 +++++--
> >> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> >> > index 36a719015583..a10c812d8777 100644
> >> > --- a/rust/kernel/sync.rs
> >> > +++ b/rust/kernel/sync.rs
> >> > @@ -93,8 +93,11 @@ fn drop(self: Pin<&mut Self>) {
> >> >  macro_rules! static_lock_class {
> >> >      () => {{
> >> >          static CLASS: $crate::sync::LockClassKey =
> >> > -            // SAFETY: lockdep expects uninitialized memory when it's handed a statically allocated
> >> > -            // lock_class_key
> >> > +            // Lockdep expects uninitialized memory when it's handed a statically allocated `struct
> >> > +            // lock_class_key`.
> >> > +            //
> >> > +            // SAFETY: `LockClassKey` transparently wraps `Opaque` which permits uninitialized
> >> > +            // memory.
> >> >              unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
> >>
> >> Looking at this patch with fresh eyes (thanks for the bump, Alice :) I
> >> think we should rather have a public unsafe function on `LockClassKey`
> >> that creates an uninitialized lock class key. I'd like to avoid the
> >> `MaybeUninit::uninit().assume_init()` pattern, as it might confuse
> >> people & it looks very wrong.
> >>
> >> We can take this patch, as it definitely is an improvement, but I think
> >> we should also just fix this properly. Any thoughts?
> >
> > Could that constructor be used in non-static cases?
> 
> I don't know lockdep, so maybe yes? Or do you mean that it could be

Using in non-static cases is wrong. For static keys, lockdep could use
it address as keys but for dynamic keys, since they can be freed, they
have to be registered before use (that's what
`LockClassKey::new_dynamic()` is about.

See this:

	https://lore.kernel.org/rust-for-linux/20240815074519.2684107-3-nmi@metaspace.dk/

We would need to add "for static only" for the proposed unsafe function.

Regards,
Boqun

> abused?
> 
> ---
> Cheers,
> Benno

