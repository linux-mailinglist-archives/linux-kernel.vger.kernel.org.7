Return-Path: <linux-kernel+bounces-727375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1375BB0193C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A2D1CA800F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A9027F01C;
	Fri, 11 Jul 2025 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDHjN/0H"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3839427F015
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228156; cv=none; b=bUJNAtLXAePgsYQT8CfvGBSSrihG6LYxzskzHGCSaMg5AvifyvFbBZBaVUlO+UrSmQfI4ZmReFav3JWariD975/ViQEA0AmX6BhO07yYoBP2xo1/dWa22n+fzDDBWVwT6BdZybKPpBvcVzhohpbgeuOZXRTOla1SYjWaPxJGApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228156; c=relaxed/simple;
	bh=YykaaxSK319lKEMyhZZtukxic2rJfvQhL2mSEvHDGQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVicugODj5SmDiBZdq8X7lVORM2BtP8aOIVLBEtIpUnfSB2QHGj+lx4o7MfhiwVnDpSfEF5swEB+7fsMUzCsUPHQkZwRxgosapGh6kiJjAkTrFhdpzRv30vLSbiWDUvx2PYWRGNaGjHnoCgWTDngnJGALyAmT0oWAAwnZSeZa1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sDHjN/0H; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-455b00339c8so2569775e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 03:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752228151; x=1752832951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3XCYABFMBC1fHadbt0BASB51W8QW6xg/j/nDStR70c=;
        b=sDHjN/0H436DIaUwFDtKqxFiNEY5bCr4/RD9eW0eJfAbOTfUA3Xnjb3e3FAEg026FZ
         clfiMsBjvkdeIk9XPMbchUEVY0sKomrzXxTCKkz72v6GEPcUkF3c672BriYsYhaXHgeg
         Nfdn2DzpLEeavRwG3E7Pf0sM/uVhg+tC8O9eh9owMLMIHiF8lsiWfI69Fs2JB8D0MeA6
         LvNPsaSDaA+zSyIz0zrh14BjfBDfaeuJp56CfekD8qrdGcDjVPAOrhcbfoFss4BRZppT
         0HjFXM3j5/Mm8xIGsuP9ljRYyXgP6gf3TrVWGSXIq5R7dsI9eALB/U3aKD38ulzw1uey
         EKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752228151; x=1752832951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3XCYABFMBC1fHadbt0BASB51W8QW6xg/j/nDStR70c=;
        b=wiSzgcxOgH15zxCh8RzQdW/vOHrGZ3RnCaSUrdeYEpidTWUjoAtWVgmhbAETJJSWpP
         opHbdOqfzp6RF80WKiPrVRqv+PgOgnlFUg20/KTQLMfGTeVIEy1bKN+GHTBD0QRb6ss7
         OZtiodt8F0ujjAIrc/U9FFM3Roh0FVmQSb68KjAPAt7ctNSP9fl5VHMjKmI9sY86P3j0
         uo8v5clKtGjUawQCDnO3UzhBzXFwX0ZGjPtfqecMnNoY8JyCHT2sIn8oAivP2Nd3kc/Z
         QMbAR7gDgk8bP+VpN/nlaALETkfU/wIhOTxVsV0UGgbl6sAcaAMjJHcPgCM4hVl0OfM/
         /uLg==
X-Forwarded-Encrypted: i=1; AJvYcCULN4rnBF/8XMUiMkdobzndasjJHu2TkCrJdvdy0Om8mhjh0+fpkd8YphXCV2KdQf26e2ybA8jgMAOxfU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4WbR7Ve1pYDP8wQ4CCeIeODkQv3Z8ZNlwEX8qb0iqLkvLzSWo
	2CghuCBQ9mwJVaRaEMwRgJEYM5yX6804Cn/xBlRvp6ruYSnwCsaHJ/w4j5UsKAmUWbUJJJlE0Y3
	r0QC3/KafSM2s1HnC7CrlNT9wDB+krL0QPyvCmwhX
X-Gm-Gg: ASbGnct092MzmULItgCCi6gO1T933vowOuEBC5I91RFfPDr0ZE9R+cYfQEJjx/0JjCb
	OdextY+oqcUL9NbS4uV8swtnVUC7e/E7JxWZHInKXNWHoqHYkTw8xI4PfbBnA3PsGGeIa01B3FK
	q2WGf5KoNruG2OBpa5EMqf8Zb6Ny6Z1K2NL5L4rkFLDo3dfN9QNcIEAfF4v8K4QFEFOsWeNSokA
	RU/W2zFGHuY/iSZekY=
X-Google-Smtp-Source: AGHT+IGUQIrtfVItwM5tfYsJuZwsz9X67ZfbXHpoiNYzH5FRyT3WE8B4aAME5Tzz2IbykJRHbQAYa9NR2ZyDDp7Ds+g=
X-Received: by 2002:a05:600c:468d:b0:441:b3eb:570a with SMTP id
 5b1f17b1804b1-454ec151c5dmr24053175e9.2.1752228151317; Fri, 11 Jul 2025
 03:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
 <20250708-rnull-up-v6-16-v2-5-ab93c0ff429b@kernel.org> <1RnkSkM82_BGKhOM4PKNTPqEQdSFQhpr6UlkVOD7EDhmTJxZ_hlNFhVuiqpUtKKW1uFUFSB7Ow3LJ31nvHUnDQ==@protonmail.internalid>
 <aG5ttHBYW3SQlSv7@google.com> <878qkvhy7p.fsf@kernel.org>
In-Reply-To: <878qkvhy7p.fsf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Jul 2025 12:02:19 +0200
X-Gm-Features: Ac12FXxr-8pN5bwGCwORG6U45Emsz82nZAIPI7oH6OS8Ef91_XrzptO86C551CE
Message-ID: <CAH5fLgjwmXJP2LcE8UKP1gdqbsTA5QyynLcw5iG93hXeLuOBAA@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] rust: block: use `NullBorrowFormatter`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 11:29=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> "Alice Ryhl" <aliceryhl@google.com> writes:
>
> > On Tue, Jul 08, 2025 at 09:45:00PM +0200, Andreas Hindborg wrote:
> >> Use the new `NullBorrowFormatter` to write the name of a `GenDisk` to =
the
> >> name buffer. This new formatter automatically adds a trailing null mar=
ker
> >> after the written characters, so we don't need to append that at the c=
all
> >> site any longer.
> >>
> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> >> ---
> >>  rust/kernel/block/mq/gen_disk.rs   | 8 ++++----
> >>  rust/kernel/block/mq/raw_writer.rs | 1 +
> >>  rust/kernel/str.rs                 | 7 -------
> >>  3 files changed, 5 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/g=
en_disk.rs
> >> index 679ee1bb21950..e0e42f7028276 100644
> >> --- a/rust/kernel/block/mq/gen_disk.rs
> >> +++ b/rust/kernel/block/mq/gen_disk.rs
> >> @@ -7,9 +7,10 @@
> >>
> >>  use crate::{
> >>      bindings,
> >> -    block::mq::{raw_writer::RawWriter, Operations, TagSet},
> >> +    block::mq::{Operations, TagSet},
> >>      error::{self, from_err_ptr, Result},
> >>      static_lock_class,
> >> +    str::NullBorrowFormatter,
> >>      sync::Arc,
> >>  };
> >>  use core::fmt::{self, Write};
> >> @@ -143,14 +144,13 @@ pub fn build<T: Operations>(
> >>          // SAFETY: `gendisk` is a valid pointer as we initialized it =
above
> >>          unsafe { (*gendisk).fops =3D &TABLE };
> >>
> >> -        let mut raw_writer =3D RawWriter::from_array(
> >> +        let mut writer =3D NullBorrowFormatter::from_array(
> >>              // SAFETY: `gendisk` points to a valid and initialized in=
stance. We
> >>              // have exclusive access, since the disk is not added to =
the VFS
> >>              // yet.
> >>              unsafe { &mut (*gendisk).disk_name },
> >>          )?;
> >> -        raw_writer.write_fmt(name)?;
> >> -        raw_writer.write_char('\0')?;
> >> +        writer.write_fmt(name)?;
> >
> > Although this is nicer than the existing code, I wonder if it should
> > just be a function rather than a whole NullBorrowFormatter struct? Take
> > a slice and a fmt::Arguments and write it with a nul-terminator. Do you
> > need anything more complex than what you have here?
>
> I don't need anything more complex right now. But I think the
> `NullTerminatedFormatter` could be useful anyway:
>
>   +/// A mutable reference to a byte buffer where a string can be written=
 into.
>   +///
>   +/// The buffer will be automatically null terminated after the last wr=
itten character.
>   +///
>   +/// # Invariants
>   +///
>   +/// `buffer` is always null terminated.
>   +pub(crate) struct NullTerminatedFormatter<'a> {
>   +    buffer: &'a mut [u8],
>   +}
>   +
>   +impl<'a> NullTerminatedFormatter<'a> {
>   +    /// Create a new [`Self`] instance.
>   +    pub(crate) fn new(buffer: &'a mut [u8]) -> Option<NullTerminatedFo=
rmatter<'a>> {
>   +        *(buffer.first_mut()?) =3D 0;
>   +
>   +        // INVARIANT: We null terminated the buffer above.
>   +        Some(Self { buffer })
>   +    }
>   +
>   +    pub(crate) fn from_array<const N: usize>(
>   +        buffer: &'a mut [crate::ffi::c_char; N],
>   +    ) -> Option<NullTerminatedFormatter<'a>> {
>   +        Self::new(buffer)
>   +    }
>   +}
>   +
>   +impl Write for NullTerminatedFormatter<'_> {
>   +    fn write_str(&mut self, s: &str) -> fmt::Result {
>   +        let bytes =3D s.as_bytes();
>   +        let len =3D bytes.len();
>   +
>   +        // We want space for a null terminator. Buffer length is alway=
s at least 1, so no overflow.
>   +        if len > self.buffer.len() - 1 {
>   +            return Err(fmt::Error);
>   +        }
>   +
>   +        let buffer =3D core::mem::take(&mut self.buffer);
>   +        // We break the null termination invariant for a short while.
>   +        buffer[..len].copy_from_slice(bytes);
>   +        self.buffer =3D &mut buffer[len..];
>   +
>   +        // INVARIANT: We null terminate the buffer.
>   +        self.buffer[0] =3D 0;
>   +
>   +        Ok(())
>   +    }
>   +}
>   +
>
> If you insist, I can write something like
>
>   fn format_to_buffer(buffer: &mut [u8], args: fmt::Arguments) -> fmt::Re=
sult
>
> although I am not sure I see the point of this change.

I don't mind. I just thought it was simpler since you only need to
support a single write instead of having to support multiple writes.

Alice

