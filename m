Return-Path: <linux-kernel+bounces-746998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DC5B12E14
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 09:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E123B2C27
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 07:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F681DE3DC;
	Sun, 27 Jul 2025 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9KM0xjO"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAC778F2F
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753601187; cv=none; b=KmtuRJve80m4VOUp5kIm9osS/odv1CQD/wseb6kRFQ3bZTkMn9+mFHQkh3Ku99MVVCKjr1PuzH6BV611xEvdM0jfvAqaU03yKK7eHHaJZzh7iNBB2xtgpLcQ45q51vpEv2UP6MP9g3vw/UDkxVJy/LYqsFzxjoJvYu5ut8apfTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753601187; c=relaxed/simple;
	bh=v4EvxtM0FlPFPooOxZDpq23OAktK0/hYmSISabSOzfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tianDCFbon1EtRrwjVBweFqQWhgHVZd9U2q4nyD1gcTVxhMKGDJsEWwfaAkZN8vDpn2MIKr2ScJ10UtC1EjQEc6ocVw8+5VPmPbLKmZrwFDlIX1llu35Yw33nkfzvu2Lv9Ip3t/ZjY8Fdv98sdqnThuZGqZTlT/uurCCRcV9Ljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9KM0xjO; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4561dfd07bcso18396195e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 00:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753601184; x=1754205984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYA/mlpFhoAgLlyJyI/zaVuKxTjKNQCnG5bY4qRayaw=;
        b=v9KM0xjOdGQKotiWzt1VI09E/ObN88Zv42BCzv1zKOWeGaaTD6QKX6W+81uFF65flT
         jkBUxXA4zMcD++He8lZT98wsvCh6ao/aC91yExfqEgyUvYhIhVA7hs2vNDH9Dvkyb+8w
         EGtO5VREit268K1xE60UdpE5zq3+yP31uwza6jJ1I5pmUaM9T9CY6Pm2/PHZ2XDzhfes
         sav7GtgyD9Uoq2l2YBspat1m2VbgT+VuBY0kXjYixW8cIAoEJS9ukqJiOtp/14upflZX
         nEmgF93gSKlrLxA11EV4dogI4zMGaQI600qcjIwQTM8UH2/MPJM5riW0yzyJH1rnI9HH
         TTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753601184; x=1754205984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYA/mlpFhoAgLlyJyI/zaVuKxTjKNQCnG5bY4qRayaw=;
        b=RzSlEbjzL8Ua0wirgDXQTRbpBk72yoto05WvUm4uxLfSv6TvPOAd9x0nV9Gmj7a56C
         DWNzNd4dOi8rSNmX6zUsPIpvrLUzemwqlkwW8qGXkJfXt/jqWKrYwR9B6rH0BH7kXnps
         sQeSz2u2u5n6AfhPDcdWRzLLYcxE9AviZN4LJ8IXk7ki+sFBUB8RepPA6FiKaPUacygG
         B+E8g+nlMZ+S71NpdNAuCXksmfWFbolAcc8/qN11FWMe4B7GYXNvq9V4uXkLIVYdQRtL
         09FJQamTxUBInRp3wrXhK5v8XijDP9gHOawGJWiSMCbd8zqqk53zh2vTutxK501FPUML
         xmMA==
X-Forwarded-Encrypted: i=1; AJvYcCVSGaWgvOvcwCP0Zcp158aG7TEDJZbw4rRDhBXIKsTgr1VbanpI/c0wghqgQh7hY0HKPX0bN705u3PosI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZ8WzkmNWqwejen1ew2ks/6oUjidOs4oknLj8I24mqhwms7z4
	h6QntuNXFYHZfrM5EpVC8T9UwAtTF8Vdyl+oFNtyvkx91bc+tyxdXNXzgVKp81X/iCST6v2uYbP
	GiCTdife7Lz/QFiBzRg==
X-Google-Smtp-Source: AGHT+IGkYbuVyCL9njlWBZBiIImJLuzgaag2wlEsUvwO2eSkQ2Id7Xy+y9MUoDW0BCgjl1nDrU7dNyNFqFVxZWw=
X-Received: from wmop12.prod.google.com ([2002:a05:600c:468c:b0:456:eb9:5220])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3510:b0:456:2698:d4d9 with SMTP id 5b1f17b1804b1-458762fd2acmr64164575e9.3.1753601183814;
 Sun, 27 Jul 2025 00:26:23 -0700 (PDT)
Date: Sun, 27 Jul 2025 07:26:22 +0000
In-Reply-To: <DBKQP426YEFZ.3EBGU020XKF3M@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724185700.557505-1-lyude@redhat.com> <20250724185700.557505-3-lyude@redhat.com>
 <DBKQP426YEFZ.3EBGU020XKF3M@nvidia.com>
Message-ID: <aIXUnsZao-7Xs5XM@google.com>
Subject: Re: [PATCH 2/2] rust: time: Implement basic arithmetic operations for Delta
From: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 25, 2025 at 10:20:08AM +0900, Alexandre Courbot wrote:
> On Fri Jul 25, 2025 at 3:54 AM JST, Lyude Paul wrote:
> > While rvkms is only going to be using a few of these, since Deltas are
> > basically the same as i64 it's easy enough to just implement all of the
> > basic arithmetic operations for Delta types.
> >
> > Note that for division and remainders, we currently limit these operations
> > to CONFIG_64BIT as u64 / u64 and u64 % u64 is not supported on all 32 bit
> > platforms natively. The correct solution we want to aim for here in the
> > future is to use the kernel's math library for performing these operations
> > so they're emulated on 32 bit platforms.
> >
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  rust/kernel/time.rs | 86 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >
> > diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> > index ac5cab62070c6..8ece5a5d5a11b 100644
> > --- a/rust/kernel/time.rs
> > +++ b/rust/kernel/time.rs
> > @@ -251,6 +251,92 @@ pub struct Delta {
> >      nanos: i64,
> >  }
> >  
> > +impl ops::Add for Delta {
> > +    type Output = Self;
> > +
> > +    fn add(self, rhs: Self) -> Self {
> > +        Self {
> > +            nanos: self.nanos + rhs.nanos,
> 
> Should we use saturating ops here as well?

I'm not so sure ... I think it is useful for + to have the same meaning
always, and that meaning is "addition where overflow is a bug".

Alice

