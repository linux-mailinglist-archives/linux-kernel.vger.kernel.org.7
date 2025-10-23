Return-Path: <linux-kernel+bounces-866742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCA9C0087C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D21A3A5736
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65122F0670;
	Thu, 23 Oct 2025 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JiaADP40"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AB92D73A5
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215862; cv=none; b=RZFQ5jweoZyvuJ+3yTzmudj2hsAf0pb5pZiXONfXJbZy/GOl/w8KMUILE9aYba2ESTxQmrq1bsEVHOPZxbnee/7ZCam3/lb1PXnFNhP1do2xZpNwTVwbyEoMwhgaViUcWiHgHiBCEWJLFlJN0rGRDmM7NXLz5C4/YTJ1s3/sZio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215862; c=relaxed/simple;
	bh=YYxfUPdfLOOxl7Euu9zdXiMarVpXjjOUqwtysvwPqAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgyOao0XuudVGLFbmEkSIYJVLbFzuqOm65Ca49q2iUiHXHDNN/TusvERLoOm+YNLU6aM6eALCSh/pMnGLFILKmO70xdsfp+VIWM5A1aUvhvDkch+dvFHB9I6DBL/22WiUqN+dYKtfAV4atVUczMMkq8GzbcDQEPWS0ZtvDDGKvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JiaADP40; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-421851bca51so621299f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761215859; x=1761820659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlbOJJaTUJl2R9AS5ER+G1wmL9urQDFVZkUedb+ly68=;
        b=JiaADP40+cdDUse3X8lkAmhG/cK7DQllg6z2yNIapco8KiopK+kDSldASAADjDL0t8
         3WD90uo635LI0L7l4X7Ody6moFNC9bEligxs5KZ+4CZ/bA8hORhbLCIIhxeh6KXwp+yi
         iQKi3cqNgdCly5TLF1MypNGocpERPCg3b/hj/XPKjTC10sUOobS9UyCKXT2FOxDkDpkq
         Gy3bQRcVWfBvGtKWLHbiyPabsFCgT3FVa7RWKiKds8I3aBC2dfhq6Rf1y/COWJmR+rTN
         It5PvSEZZ3SJCfO84lmYe0ijJTHXOZTn21Wkfq+0gFGrFDAM6fyglraBoArWwsBkI+TY
         SOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215859; x=1761820659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlbOJJaTUJl2R9AS5ER+G1wmL9urQDFVZkUedb+ly68=;
        b=KeAxa/MhA17kFFaNY/tiTsncj9SAlMZf0SpUb+92aQ0i+j65n74diTTdlgXOYNxNqY
         /2/zbl0V2x54W1zoqSit+j1xpyNQyxxTq8XE/XaPDdIKd914uEGQn2szl8drp6AV5EK8
         ZKmMCYj1eo+2UIXbV2k7PJwCf6x9fhD3tsArSpVOdYWA6orn/aRZG2CMwHUfNISBarjz
         QJq6wQiZDqYzBu9/TdVMiAmr0666TeZQbo3ocU284ygxDofcJ+weWRx+/s3HuusWB4Jz
         bto1w02FNawQBpSqFbLSk3F0jXKuq0l3DX1QQfzt6DpRsJW2KJbmeCk6sHlTYMt9vUru
         xQtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWojzpZYp4GoHqA87qE563g0sz2lWSfmgYeczT8/wIG0r5dSy1HpzG6wzdVlI3EtNYqmoglOmRLSs5P1Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIRF9YP1uN/19839qphXJp+bCiYVWxAh/iglpbbXZTkK8k2NbC
	fKngI8azGvbN0wDXD8iu/bn7h16OpSstjEB9m/DKmnOXwf5uBR4eXrx5PRsx8JNtczPYEjJmvfb
	ad1TjbJ9P0NBt+LNJPOJ91ReuB0bqgja8B4fmolus
X-Gm-Gg: ASbGncteriM6JfuJ8+7rc6jhkB5Wk7xCKECFdXwVmyuDDjoKZuk05pkDDL0xKCQW/j+
	wk+qyGrpNY+1xMSSr6F1emH38G9/gStgRfNjMgO0u39KNrmikGyW7lpaiRN5BCKLs5iIQTeA0IH
	inm1quWbhcX2Np5PhiUMT6WHnufkp2L3YDmR0zhsv6BN1Mnf0dNUhmf04RpN8C0SRLB4vmYrttK
	J/jmvVN16ajXO3N7EUVwnStiRpBOS+2KGkBl46AMau1J6FundLXQQLZg0a+jA==
X-Google-Smtp-Source: AGHT+IF7maTSQiS4kZPLIabukQBdn/rZWFtqT50NtIAJr4GO0YjV9vbHGhXIn7kavPdqJnen7ikTwzQkeGILfRe8wuI=
X-Received: by 2002:a05:6000:25fd:b0:427:587:d9ae with SMTP id
 ffacd0b85a97d-4270587d9c1mr13312291f8f.9.1761215858529; Thu, 23 Oct 2025
 03:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-6-dakr@kernel.org>
 <aPnnkU3IWwgERuT3@google.com> <DDPMUZAEIEBR.ORPLOPEERGNB@kernel.org>
In-Reply-To: <DDPMUZAEIEBR.ORPLOPEERGNB@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 23 Oct 2025 12:37:25 +0200
X-Gm-Features: AWmQ_bnHmpaGJ5SXvKhXy7BPOYeRX2L2uNppxAQX8TK3YbD6TWoOM-Pb_fLGRa8
Message-ID: <CAH5fLgiM4gFFAyOd3nvemHPg-pdYKK6ttx35pnYOAEz8ZmrubQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] rust: uaccess: add UserSliceWriter::write_slice_file()
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:35=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Thu Oct 23, 2025 at 10:30 AM CEST, Alice Ryhl wrote:
> > On Wed, Oct 22, 2025 at 04:30:39PM +0200, Danilo Krummrich wrote:
> >> Add UserSliceWriter::write_slice_file(), which is the same as
> >> UserSliceWriter::write_slice_partial() but updates the given
> >> file::Offset by the number of bytes written.
> >>
> >> This is equivalent to C's `simple_read_from_buffer()` and useful when
> >> dealing with file offsets from file operations.
> >>
> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >> ---
> >>  rust/kernel/uaccess.rs | 24 ++++++++++++++++++++++++
> >>  1 file changed, 24 insertions(+)
> >>
> >> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> >> index 539e77a09cbc..20ea31781efb 100644
> >> --- a/rust/kernel/uaccess.rs
> >> +++ b/rust/kernel/uaccess.rs
> >> @@ -495,6 +495,30 @@ pub fn write_slice_partial(&mut self, data: &[u8]=
, offset: usize) -> Result<usiz
> >>              .map_or(Ok(0), |src| self.write_slice(src).map(|()| src.l=
en()))
> >>      }
> >>
> >> +    /// Writes raw data to this user pointer from a kernel buffer par=
tially.
> >> +    ///
> >> +    /// This is the same as [`Self::write_slice_partial`] but updates=
 the given [`file::Offset`] by
> >> +    /// the number of bytes written.
> >> +    ///
> >> +    /// This is equivalent to C's `simple_read_from_buffer()`.
> >> +    ///
> >> +    /// On success, returns the number of bytes written.
> >> +    pub fn write_slice_file(&mut self, data: &[u8], offset: &mut file=
::Offset) -> Result<usize> {
> >> +        if offset.is_negative() {
> >> +            return Err(EINVAL);
> >> +        }
> >> +
> >> +        let Ok(offset_index) =3D (*offset).try_into() else {
> >> +            return Ok(0);
> >> +        };
> >> +
> >> +        let written =3D self.write_slice_partial(data, offset_index)?=
;
> >> +
> >> +        *offset =3D offset.saturating_add_usize(written);
> >
> > This addition should never overflow:
>
> It probably never will (which is why this was a + operation in v1).
>
> >       offset + written <=3D data.len() <=3D isize::MAX <=3D Offset::MAX
>
> However, this would rely on implementation details you listed, i.e. the
> invariant that a slice length should be at most isize::MAX and what's the
> maximum size of file::Offset::MAX.

It's not an implementation detail. All Rust allocations are guaranteed
to fit in isize::MAX bytes:
https://doc.rust-lang.org/stable/std/ptr/index.html#allocation

Alice

