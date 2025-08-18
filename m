Return-Path: <linux-kernel+bounces-774535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A373B2B3E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCC219673C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770E127AC32;
	Mon, 18 Aug 2025 22:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIA689si"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25B11BE871;
	Mon, 18 Aug 2025 22:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755554746; cv=none; b=r+8wiSkSjut5eOXs3qUk0e6bIfPuUqrodW/DTu/SW9wJrcMprcNdUAHKkUdh6T7dyzhQSzJn8dQ7cGqo8A+i2AQtpDSdpus1xAVZumZ6MLds9W+VZPwdDgk+9L7GPb8pD5rgxzlCan35LylqiHUtCmCwoIRssWpIZN6iXfGlMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755554746; c=relaxed/simple;
	bh=tbdpi7XIur9WcAC+P5MSy6xDHzhA2ulOnLYBc9gKssY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Trns+VtLmPDgfRBLNQwnuRVRJDmFPQE/X8zsgfoG55tju3JjS57DfWnPjUR9RnRfN2LTSoJXwlAOZNrngzuY5NWUQmqmoP6Ze5ePA80adsiOCVgYP+5Hv2M2xtb0vATV5ATMkeBLLOunrxE3pH5g4zsNQiW1G/R0kolahS6YRKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIA689si; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E155C4CEEB;
	Mon, 18 Aug 2025 22:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755554746;
	bh=tbdpi7XIur9WcAC+P5MSy6xDHzhA2ulOnLYBc9gKssY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIA689siNo2YeYCKw/S/6qBkgFMqY1dVeqAYupbm9ir5sr/1OhW67LX07aleZOt6V
	 yYU8dO0a65YhUBCwhyYXMWL2asbdbqB92Hsfjt8DnpPU5j7ZtflYp5SkbktQoG6C+R
	 zwYLeO+YWeNOrXr21zzQpKs1zenxoO2qFAESgDfhOWeD8GnbtMh978x48gT0MpGQKR
	 9qoaN4dZN21JRTJ2LA5XdB135rV/ENYb0OLcUF2xp3cHPMN42KKgRzFjE55gPCwRYf
	 5YmN98Z+z3g1m+4M9ThbZ0DcvZuqlL6pb41mAd/gfrIche1fSYd3cjkbSqIsVJ8jE7
	 ZpVqfZR2ITYIw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 00:05:41 +0200
Message-Id: <DC5W7UQHOJSG.310L4WJ0AKZFE@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Ryosuke Yasuoka" <ryasuoka@redhat.com>, <arnd@arndb.de>,
 <gregkh@linuxfoundation.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <dakr@kernel.org>, <lee@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rust-next 2/2] rust: samples: miscdevice: add lseek
 samples
X-Mailer: aerc 0.20.1
References: <20250818135846.133722-1-ryasuoka@redhat.com>
 <20250818135846.133722-3-ryasuoka@redhat.com>
In-Reply-To: <20250818135846.133722-3-ryasuoka@redhat.com>

On Mon Aug 18, 2025 at 3:58 PM CEST, Ryosuke Yasuoka wrote:
> +    fn llseek(me: Pin<&RustMiscDevice>, file: &File, offset: i64, whence=
: i32) -> Result<isize> {
> +        dev_info!(me.dev, "LLSEEK Rust Misc Device Sample\n");
> +        let pos: i64;
> +        let eof: i64;
> +
> +        // SAFETY:
> +        // * The file is valid for the duration of this call.
> +        // * f_inode must be valid while the file is valid.
> +        unsafe {
> +            pos =3D (*file.as_ptr()).f_pos;
> +            eof =3D (*(*file.as_ptr()).f_inode).i_size;
> +        }

Please include abstractions for writing & reading the file position
instead of using `unsafe`.

---
Cheers,
Benno

> +
> +        let new_pos =3D match whence {
> +            SEEK_SET =3D> offset,
> +            SEEK_CUR =3D> pos + offset,
> +            SEEK_END =3D> eof + offset,
> +            _ =3D> {
> +                dev_err!(me.dev, "LLSEEK does not recognised: {}.\n", wh=
ence);
> +                return Err(EINVAL);
> +            }
> +        };
> +
> +        if new_pos < 0 {
> +            dev_err!(me.dev, "The file offset becomes negative: {}.\n", =
new_pos);
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: The file is valid for the duration of this call.
> +        let ret: isize =3D unsafe {
> +            (*file.as_ptr()).f_pos =3D new_pos;
> +            new_pos as isize
> +        };
> +
> +        Ok(ret)
> +    }
> +
>      fn ioctl(me: Pin<&RustMiscDevice>, _file: &File, cmd: u32, arg: usiz=
e) -> Result<isize> {
>          dev_info!(me.dev, "IOCTLing Rust Misc Device Sample\n");
> =20


