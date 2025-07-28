Return-Path: <linux-kernel+bounces-748622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB02B143C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 23:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198BE189DF4E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B6826CE2F;
	Mon, 28 Jul 2025 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6A464UQ"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DC522FE11;
	Mon, 28 Jul 2025 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753737700; cv=none; b=OZXyE0jE+fzOvjo8CsryYKSpHCN6g1z7iOIW3fPbOTJfKrX1PQyOeG28CVv9mo+scxZaAvBC6Txo3aEiDoW2jiMEOuFHeofn2L5i6jzsFxphdRDv7+xVW1fjYpKtZIMzgRnSDfJ1g2LiJ41FyeS63u+yEe6l7uMhAdLppUD2BX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753737700; c=relaxed/simple;
	bh=UA7VN0xSe8Gpf9OvZtxxF3aLnGEtizy76YM22pyqK2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0OOXXiqfEt7BZbeehu9my27ZxoPcwR5qVMZSoVASTo92l59iiWWSpxh4T700017ytOmK+gI8aBtaHKAa2ZxZ4sZ/Kv93p0g7//RFxzE+INfKO4DsNxHmXVKNwVsmzcVPdzOGPSREloTuiFSTUwoER5QnhWjG376iIPqXPZvD4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6A464UQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b77b8750acso229001f8f.0;
        Mon, 28 Jul 2025 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753737697; x=1754342497; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RU2bqufwtKQ9dzDchkpeeGiLDTRcO+IVH+BNlkW1gOk=;
        b=a6A464UQmy1ctOnkG7Sg1tVq/F8Le2klMHhRHQ4O3XNSbr3gy8n5Xuu02LwyuIW3nd
         gK3jqPzWvnvv17uIqnrw1CzkyfsQZSzNitcO2Oyy2AkszKuRUQ9BP+GnB85fO4saTkHu
         44CaKzHJdTaSOSicVX2voUGMDMLoZurp3hRvdorhX39Yk7/olZAOb32bux8Opm+/C5/x
         PKSgTAWqAzYb65VoxYD8FLf4uC8juXb+E9HDEZwew7n200zkhwPOoljZ3PlzynNEdhcA
         yxXBCi3blPu/Gyo6O4N0dLDSxIte1pBrWiLUcx20wkxo1U+nfJdxjm6HxgTpincgoTjI
         HwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753737697; x=1754342497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RU2bqufwtKQ9dzDchkpeeGiLDTRcO+IVH+BNlkW1gOk=;
        b=NkBnoSXbyI0GOwLXY6EvJ9fCvEMOkKj9Ejw9nXlBFiQI54f5TJ7ZSNqeAo3R7FGb2V
         UxzVblO6mwNLTux+EjuTGysIPDCyqISo0GyPCfJpsh54I2r3e7xq1Fehh1Jq/y1/GULZ
         M313jBKuFHW7adqo+DtiiKkpnEg9d9Sp+/kVKVKV7QIvIPTOSpj8KckOYcY6MgsAG0Lr
         PjKxQVtHmCcZ8CvrEM2HgpHzLADRV5RSrpSnMm0SJW8OZ7W/YeAvofzjBpjFsKDN4qBu
         RXBlqtg9SmBNG+HfUzwJXzmWghKvtJMUn9gIBTzTYF+gvROMw9jfdrWw9wB2XI4MyEZr
         zHeg==
X-Forwarded-Encrypted: i=1; AJvYcCV3u7T76lZ1UR+EJ66KPhlMrMbVhYbe6dx7st7PI1CewY3DuSWt3Ku6hh5pA/5zJE5sZBX6A8YnEPkEq7FBuJw=@vger.kernel.org, AJvYcCWIJewnm53skPpMKnq/4Jg3q7IyYsWO6lLaTu1Zxr858pSslpsPI41D98QCNmqDQJgPgEMlV9t06oEUHdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbI7zOgjsYA+XfifBii19jsyxdw4v+VMC4iSfth0PY7LUSFlEX
	+UtDKJNFSRbgvUCV8gJu0iPcaRGqMDRKfc0z/r3u8fJw8db1k6K829V68vMBemMG/Au8GeKDQQt
	baCSx8HhF9up2JJRajLvP0UJYJI0DNk0=
X-Gm-Gg: ASbGncuxh5YX7Oy25BuLvXjYSvIso476HL7DNuLvaScgIQGGuaMkx2Kg58qlK4PnBIh
	VPe/+UJ9N1QQzgO/0UWlyZHVUY4nNL0RTL7ClehCptkUgzsHLaETgado3Yfds9abwqmWp6XQKdk
	GgOt1GQDOsIN+3RW2SDehonYbceL2WIsXlgdrSh/X++3Wvgo1a2w2hnobwDv5HMKdugkAqA5vXc
	3+MOdvJzIeUJAKxItLRtDfB1UpWTK2KfpokEBTd
X-Google-Smtp-Source: AGHT+IHnq1iQHeWMKuSQugJPOx00XM25zFz3DY6x3bvclf3J79sZ9kAygJiKa532lIGzwPDc6XeY3m1ajK+uFjTTk0k=
X-Received: by 2002:a5d:64cc:0:b0:3a5:8977:e0f8 with SMTP id
 ffacd0b85a97d-3b78e50f320mr777443f8f.19.1753737697146; Mon, 28 Jul 2025
 14:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624042802.105623-1-christiansantoslima21@gmail.com>
 <CABeNrKVYy=9QKvTwnDPfRhXuJLCFgA9bbvd34V-P8jHLEJSGEg@mail.gmail.com> <CABm2a9egd7xq5OwEB+pq21wSPJS-89wY5Z3J8Kpay+3EsywDpQ@mail.gmail.com>
In-Reply-To: <CABm2a9egd7xq5OwEB+pq21wSPJS-89wY5Z3J8Kpay+3EsywDpQ@mail.gmail.com>
From: "K. York" <kanepyork@gmail.com>
Date: Mon, 28 Jul 2025 14:21:25 -0700
X-Gm-Features: Ac12FXwVabOOGIW0xDIGk8GunND1x8zQsSekggC45CLb9CdCsQEdU08M2iRnOlk
Message-ID: <CABeNrKWn4_qsAE2pqgGwVuspf7wnzT=xe_hZpuy-0HVTLD92DQ@mail.gmail.com>
Subject: Re: [PATCH v8] rust: transmute: Add methods for FromBytes trait
To: Christian <christiansantoslima21@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	dakr@kernel.org, gary@garyguo.net, linux-kernel@vger.kernel.org, 
	ojeda@kernel.org, richard120310@gmail.com, rust-for-linux@vger.kernel.org, 
	tmgross@umich.edu, ~lkcamp/patches@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 28, 2025, 12:39 Christian <christiansantoslima21@gmail.com> wrote:
>
> Hi, Kane.
>
> > > +// SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
> > > +// patterns are also acceptable for arrays of that type.
> > > +unsafe impl<T: FromBytes> FromBytes for [T] {
> > > +    fn from_bytes(bytes: &[u8]) -> Option<&Self> {
> > > +        let slice_ptr = bytes.as_ptr().cast::<T>();
> > > +        if bytes.len() % ::core::mem::size_of::<T>() == 0 && slice_ptr.is_aligned() {
> > > +            // SAFETY: Since the code checks the size and alignment, the slice is valid.
> > > +            unsafe { Some(::core::slice::from_raw_parts(slice_ptr, bytes.len())) }
> >
> > This is incorrect -- the second argument to slice::from_raw_parts is the
> > element count, not the byte count.
>
> I don't understand, did you mean that the safety comment should be
> changed or the argument? If you can explain in more detail.

The code is wrong, and the comments should be changed to match.
The documentation for the function says:

`pub const unsafe fn from_raw_parts<'a, T>(data: *const T, len: usize)
-> &'a [T]`

> Forms a slice from a pointer and a length.

> The len argument is the number of **elements**, not the number of bytes.

The code is wrong for any type that is not 1 byte in size. The len
argument should
be `bytes.len() / ::core::mem::size_of::<T>()`.

The code will also panic the kernel for any type that is 0 bytes in
size in the % above.
I'd probably choose a build assert (`const { if size == 0 {
panic!(...) } }`) for this.

>
> Thanks,
> Christian

