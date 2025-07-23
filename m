Return-Path: <linux-kernel+bounces-743151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83100B0FB37
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582C75634EB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD77230BFF;
	Wed, 23 Jul 2025 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jEQZmeI/"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C586725776
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753300713; cv=none; b=BFeEn04SwHPgl3Ymh2pURvm0JDuC1q1uDC0kBRiaTsA99UTPPwKnO+Qye7EzAM3/Fi1g2ZfljZG9NQKifQ0+aN+VMfkouh7DAysuJBGbxVYCzhiI7nH2VDLuU2qedA+yr39fFz0lUUceFzASJuWtkeKQw1kg6C1JyRmK08DZWEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753300713; c=relaxed/simple;
	bh=g8zhiVPOKgsXsJtn0IpsS+vCHNdsx7XJj10DE1qeXds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSS/euCyh4l6OlWBumDXiyVvOPZ8wbS4TbL4sSaTMvj+hN1hLWBVvYMEKEenFVEP+ebqsXZACo9bguAszzBenGLk7YWMyXwVMatttWv2pjHb0ZUkVMGWieTCZK/glXwNuluiwwoZSONqUbCa1TdUOI63CL3PF7ipb4LcvvVK1IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jEQZmeI/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4561514c7f0so2410255e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753300707; x=1753905507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+wSphNwAMpLftkYCJIT/z3kQtESm9gjVoVF0r2++5I=;
        b=jEQZmeI/qm8uwXf8e7eim57vZffeoYpHQLAHwJG13Mk3ncIVnE2SzDAO7vhP+P2h7F
         SYS1XQLdR96ytwTiri4bNdVY8CRxKdoJ+vRk4jn3PHK/d8UH96WbiutYZR9VZSffQeQU
         gOORX//7sVdVl2vz1oULxC3p4o8KKdgGtmLM+o4xVrNrmsGMLYvGV9VlLXuMxrm+y2Eq
         b/s4W2cyfuFNRmkA6KU7qDaTPLg5KQ+l4I3zb8M3DSpH/PookHYpXRhLs+gjgUstdS6U
         83aL71uC/wFDz53mbC4HZlnE2VfFHJdd7zRPlDZC4U7HSO4XYWf4zbjmnxWGCCQMiKFr
         5c+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753300707; x=1753905507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+wSphNwAMpLftkYCJIT/z3kQtESm9gjVoVF0r2++5I=;
        b=GRn11MqWYFJC2KWSJKVIZkPYIQ6M1S6jnF+iFsbnC1jZmlnVnd6xLQGowqgVsFmehA
         sEI5NHBIiOILH63gxKrP9FCoaGfhzByNdkuIGV2ic/hGF1LD8uMwHhEBC4Cd4iGFjTYI
         rcXSJqw9TK8W+rnStcbhTjANDhp1BGx63wclHvam9jsiWSkvxRkpamd76F7mx7R5G8YK
         qhxAO+YLXfu4Wcjqah0gr7Q758wNiyQczBq/djNrHnEog9A10B1d/Dx2RCt8o1jFf2Cw
         rkVwWX40EnAOSviQoPh4cAaN5hiMK18/ImvqAPftrB3lZ0LvZCcRfVkNSsNX1IZ8XW8p
         wepw==
X-Forwarded-Encrypted: i=1; AJvYcCX8iFqbeleQ+UNo5wkcq0JxIV6C8dFeAfhEwGma7LazsfDZJFVDMItTrZ3DvfuQw9DtfLafU6oSKQdZkBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUybIeIEvncJKhj/f6dqjeVlE2uK58MMJ8bELo554Ct95Wj86q
	Aq8iJijH3VY30EZNF03njnsPEhIhqAclNlHOsBnLCZppXkSHOPAIjKBeUQkQr7A9tgtESsv4R6l
	KzCG8RFBJdHz9QZj8IFFaD8V5AO5Cqova3s84Tk8K
X-Gm-Gg: ASbGnctTk8zfsS0nnMfRqpwjKAe02cBg6OeNapjFxymyWZBtXpfF5v3iLAJsMGsFdrP
	6vS1G/kp++/u8PVVrNDXlrvktX+BtI5xPbXi5xhvh2bvQsQ2gz8fpR9WmKofND9LZhGyPfW29x9
	5CU8fd4uK4UJc6znq/3/Fsa5hvvHHUSXW876/NmhniqMFKSMKOOuaZ50FjphtUmEcwozIAJag+D
	3FzGSdo
X-Google-Smtp-Source: AGHT+IFaDTU6O3IJMCvXOkDzZcTMBsDv+ztlngHv9aGs7ot96t0vQqO3XwvIou4OVwXTVfLDTeY9Gc8RfPDT1X5xwVU=
X-Received: by 2002:a05:6000:2901:b0:3b6:13a1:8861 with SMTP id
 ffacd0b85a97d-3b768ef8e92mr4135128f8f.38.1753300707100; Wed, 23 Jul 2025
 12:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com>
 <20250723-lock-class-key-cleanup-v1-1-85fa506b8ca4@google.com>
 <DBJIDFSMYASO.3VRN4ZZEUI8EX@kernel.org> <CAH5fLgjWFa8TjTL+rfv7Zd+OQqhkKqWvyTkGf60pMUyQ=c4sXg@mail.gmail.com>
 <aIELxq_iVMfjszkh@tardis-2.local>
In-Reply-To: <aIELxq_iVMfjszkh@tardis-2.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 23 Jul 2025 21:58:13 +0200
X-Gm-Features: Ac12FXxMV-RP24FaIH2r0YNWB6v_mOHMqRPtrQ5jEyR_mwy2TutgiYw_IKyQKKQ
Message-ID: <CAH5fLgiOaZRki71X7oDPpz1OnNEbPgPLmcxbJXscdbDBhUy6=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: sync: refactor static_lock_class!() macro
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 6:20=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Wed, Jul 23, 2025 at 05:01:39PM +0200, Alice Ryhl wrote:
> > On Wed, Jul 23, 2025 at 4:36=E2=80=AFPM Benno Lossin <lossin@kernel.org=
> wrote:
> > >
> > > On Wed Jul 23, 2025 at 1:49 PM CEST, Alice Ryhl wrote:
> > > >  impl LockClassKey {
> > > > +    /// Initializes a statically allocated lock class key.
> > > > +    ///
> > > > +    /// This is usually used indirectly through the [`static_lock_=
class!`] macro.
> > > > +    ///
> > > > +    /// # Safety
> > > > +    ///
> > > > +    /// The destructor must never run on the returned `LockClassKe=
y`.
> > >
> > > I don't know how lockdep works, but Boqun mentioned in the other thre=
ad
> > > that it uses the address of static keys. But AFAIK there is no mechan=
ism
> > > to differentiate them, so does lockdep just check the address and if =
it
>
> In lockdep, we use `static_obj()` to tell whether it's a static obj or a
> dynamic allocated one.

Oh, ok. In that case I will adjust the safety comment.

Alice

