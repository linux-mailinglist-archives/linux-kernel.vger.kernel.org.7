Return-Path: <linux-kernel+bounces-743155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CE5B0FB43
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B7F16F068
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B306523026B;
	Wed, 23 Jul 2025 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZpGoJGN"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8581A1EF0A6;
	Wed, 23 Jul 2025 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753301271; cv=none; b=fYTc9q/Yb63MIQXNwBZF2Q4ZhtnhkUEx44mb1UuMxeNKFpfD0WnjxnrfcejkHpGVbsHXG46ZHxgfyw/PZRPtiQ3QGNshzO6HbMy/bzWMWDae7bHLjWTCNm6bNs0s4tYoQ+VA7MH+ogNSu8yvz3wbLvaCQbE1OAVvzIe9jvPav5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753301271; c=relaxed/simple;
	bh=AzwlVB+VkBQ4TexRPyaqJQxQJfBLTxz346ymrQrXuE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9nKlOJqoj0t/YPRQeMzpmycw1ndgFXCPuCLA1iqRxYddSBshHEA7LnfWVdkflVnu/nSDxAcxQs/G5popme0h/nc6IsYEhVetKWNrUfTsZm6pS9h+X3GQL7thwrASy03M5YaDEWPocOb1eWu/Sb0Ti1uyaXLL2pKGgFtBBGPSQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZpGoJGN; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7df981428abso46626685a.1;
        Wed, 23 Jul 2025 13:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753301268; x=1753906068; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ximF7FTk8o24QsEWOhuigQNmRA4htZCeUZFqjU1jVxs=;
        b=RZpGoJGNRcF2yd5quDApq9vta8Zv8GGA+de/JfqFYN92rPBzJgE6FQWhCNz+6PH7lM
         mOmdgr18QF1M5XFuGe0Lqdvwt9TwenHr5yQaRof5W4QaeNRsXV1B3+ejjt5BlB+p3/I9
         b+GNZFKPP/o15PTyJiPgUbSR7JVVH9PjIWxGVmzPReknk4k1Bg3IPsMTMh4uxNoi/DLd
         c3sA0J5TA/FHAIzyzpAcP1VkWBW0K8kFBNSXvgoZJmZts/QKoJJZX931YlbakE/JHt/q
         3EPfuP8Aguyn5ndO2beqI4nGLsPWj6GdDKwMHI1Jy51rx1Xtfva0vtuJ5X321r/AqZ7b
         SSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753301268; x=1753906068;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ximF7FTk8o24QsEWOhuigQNmRA4htZCeUZFqjU1jVxs=;
        b=MJkxy/+T4QXzwrSaimxNLcKRceQ3vThkkqt0RPcD8Wf/nOOBszpskoBX7e6brIkWRj
         bSgoxj8xXsqRFqfyDWKaDw37OTaz2rtMjJc93bE8xL9+zeesAhrRbtJMfItol7Uf+02L
         YQFfN9R0slgSZP643DOQ+I1vAnSps/avv2KlwzxfVPnLLf3SMZ1+7MTB4Pb+99AAGenD
         S+yeyhUJTylCHVdKwsPvuv3Kb7W2XKnuZeHRNPY7N1P31xwWzI/BQEIWMXPmOODYdNgG
         tp8Euh8BQjrIY3pTlqWjaKy3B/loe84avXPnw0bJGJP+hecBFo7tfMHRLkWk52z0AR8F
         PWTg==
X-Forwarded-Encrypted: i=1; AJvYcCU8TJsiMXcJMka9HasHyk4cr1TOc/u/fUv4tVKyIFOyBQ5txdKXab0hEw+8VwZtxtVTlAZ1F1if/S4bz2o=@vger.kernel.org, AJvYcCXb1QkA8GU3hWozJtcNDOCt7gjVq270TNjQ5hIcNAI/oIz38j1ghodi7UJKWmcSRL+76zeGXgggkIZK0vVebUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZlTMgEvub+LrIOWkvU0bloYavtfB2LTjhGJwNEHhAjmK3OwBJ
	tvrbarl355fD0YHQFaRy+jANRw5ypIx2T3RUQPR3dTKV43SYAUEWUuLf
X-Gm-Gg: ASbGnctnGj0xJmHTR3C76AnkrM+/YekAIjqpCOlT+iP+0EnZrN3ubGl7bJB4KFx6dll
	aZobTk71KnafDdxYvY2XHIkHRaklwGGbfeE5GPWne1wXP58rFhAe9czt3XX5CaaEGYTMeytpVhc
	e0vdgy0l36+q66basv6WTWVcFtmYyUXfDS1VAsVnheRA5sls9NQBS8xyQv/Y+JWceDVmw2OY3wm
	tJceDxwsm1DAmQyTqSexcr4Etx4+bLfLQD2rFzbNsbtjAP4rghOsKLpf55inNOOsT4H/K6c/9yJ
	u4EptK5ijCpr94MOyWqBO2U0WWjP78nhHaH9bHiS3mq9GRwbxfsE2R65s4NtN3ivIdTKZxs+17w
	ZoPNdNw8F49XRzAdD7xgMT9gRBu3h1VtzHmxwH1gV0nmEre0eAch0ifdhY1Gsj88SE9w04opq+s
	mhoVKAQZ564orB9ijytDniDug=
X-Google-Smtp-Source: AGHT+IExixEX4mfqVDgBE9/WcnbM9jM1MC9C6sqGwDfNo57Rdh5hdhkJkDYxwW4v2kQF18z8rbdK4A==
X-Received: by 2002:a05:620a:1709:b0:7e6:255a:5ff2 with SMTP id af79cd13be357-7e62a0929eamr554303185a.2.1753301268022;
        Wed, 23 Jul 2025 13:07:48 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b23944sm70773811cf.54.2025.07.23.13.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:07:47 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2B9D8F40066;
	Wed, 23 Jul 2025 16:07:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 23 Jul 2025 16:07:47 -0400
X-ME-Sender: <xms:EkGBaEcTbsFL4wzoFawjMJte_pb5fI3hQ-SaacB6kHW3zV7syCoJ_A>
    <xme:EkGBaO1C8o92rfE08ubA0orZKT4fbsIOKvu60hjmBvLpqJ-zAIkz_cZnM-uUivN9L
    T296iZajjEA4_AI6g>
X-ME-Received: <xmr:EkGBaM8_qCEA-Wjwq6hkD27E4KVEYlLoRI_ND-fsJJ_vt4xliTFoOut0B9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudekhffggeel
    feenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvg
    hrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtoh
    epsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheprgdr
    hhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtmhhgrhhoshhsse
    humhhitghhrdgvughupdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:E0GBaD5AlqJKxvdIVUSnx8Y0RVVN7db92d9IChGmkPi-D7fXJMZZ1w>
    <xmx:E0GBaEt5CvJx6uL40K4a3FDyKmGX_-1RF5rta2TU31-6ccLa5_czZw>
    <xmx:E0GBaF1A5BqboBSP772KCQmu---4c-NA0H4upufu9Z-4PsgcMibE_A>
    <xmx:E0GBaNoybbP_fik00g7rUSD1HBF3GJ7xmprlYNRXEGTB5Q189hFcfA>
    <xmx:E0GBaFIZsbQRURwyV9KG_jsJUxdVOO6lnTHnyi3MqFL3wrk37OOhwMQN>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 16:07:46 -0400 (EDT)
Date: Wed, 23 Jul 2025 13:07:45 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: sync: refactor static_lock_class!() macro
Message-ID: <aIFBEUdGU0r05wC6@tardis-2.local>
References: <20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com>
 <20250723-lock-class-key-cleanup-v1-1-85fa506b8ca4@google.com>
 <DBJIDFSMYASO.3VRN4ZZEUI8EX@kernel.org>
 <CAH5fLgjWFa8TjTL+rfv7Zd+OQqhkKqWvyTkGf60pMUyQ=c4sXg@mail.gmail.com>
 <aIELxq_iVMfjszkh@tardis-2.local>
 <DBJOYRYFZJ5I.26IFPSP138T23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DBJOYRYFZJ5I.26IFPSP138T23@kernel.org>

On Wed, Jul 23, 2025 at 09:46:03PM +0200, Benno Lossin wrote:
> On Wed Jul 23, 2025 at 6:20 PM CEST, Boqun Feng wrote:
> > On Wed, Jul 23, 2025 at 05:01:39PM +0200, Alice Ryhl wrote:
> >> On Wed, Jul 23, 2025 at 4:36 PM Benno Lossin <lossin@kernel.org> wrote:
> >> > On Wed Jul 23, 2025 at 1:49 PM CEST, Alice Ryhl wrote:
> >> > >  impl LockClassKey {
> >> > > +    /// Initializes a statically allocated lock class key.
> >> > > +    ///
> >> > > +    /// This is usually used indirectly through the [`static_lock_class!`] macro.
> >> > > +    ///
> >> > > +    /// # Safety
> >> > > +    ///
> >> > > +    /// The destructor must never run on the returned `LockClassKey`.
> >> >
> >> > I don't know how lockdep works, but Boqun mentioned in the other thread
> >> > that it uses the address of static keys. But AFAIK there is no mechanism
> >> > to differentiate them, so does lockdep just check the address and if it
> >
> > In lockdep, we use `static_obj()` to tell whether it's a static obj or a
> > dynamic allocated one.
> 
> So the code below will go in the non-static code path. Why doesn't it
> need to be initialized/registered? (but other cases need it?)
> 

Becasue all the dynamic lock class keys are put in a hash list (using an
intrusive single linked list), so you have to register it before use and
unregister after use.

> >> > is in a static segment it uses different behavior?
> >> >
> >> > Because from the safety requirements on this function, I could just do
> >> > this:
> >> >
> >> >     // SAFETY: we leak the box below, so the destructor never runs.
> >> >     let class = KBox::new(unsafe { LockClassKey::new_static() });
> >> >     let class = Pin::static_ref(KBox::leak(class));
> >> >     let lock = SpinLock::new(42, c_str!("test"), class);
> >
> > This will trigger a runtime error because `class` is not static, but
> > technically, it won't trigger UB, at least lockdep should be able to
> > handle this case.
> 
> Could you go into more details? What is the "technically it won't
> trigger UB" part about?
> 

If a dynamic key is not registered, lockdep will simply just skip the
initialization of locks, report an error and disable itself entirely. So
it won't cause UB.

Regards,
Boqun

> ---
> Cheers,
> Benno

