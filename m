Return-Path: <linux-kernel+bounces-766802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E28B24B58
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7FF83AF935
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39892EB5CD;
	Wed, 13 Aug 2025 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mo4qNBds"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CD711CA0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093298; cv=none; b=X0MLCVAA6h6iHhkdHZhpQFmaMNLHaS1LHFbCw+XHeJA0VG/meqkQMIwcOa76pRguUMcy7tH3UCz40kNgSHintEfaonNtnI/hHxro/WDXMe+GQT5F3K9lZVtB9+AVkp+TzX3ga8LCKSnPZWwbnp0RSGQkezuMwixLyrIo8Negm0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093298; c=relaxed/simple;
	bh=Bsr3Xgf1pvt0rMkSUDDvq7T6BZJlReymd/Jc4jOjIgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=by4FHAANJlyj/AfJcEifr7qyPDpT0YQR1W6kN7JwGhtW1QK/23fW2u3fMTKApefmKwNyaBvGNO8i1hmVRk+QaWbnmFQjKOmOgSW574Y9WAvUP9+OZ+8bvHxj3gxEhOy6tudXe1cX6KzTHOR0V04lhrfwKB2EazXuX6UKwokkuA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mo4qNBds; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b914a9c77dso1352239f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755093294; x=1755698094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey7XIorOzAd7x0egX+tKCQ6muW37hs4s2Deiul4Gcbk=;
        b=mo4qNBdslknkhb84d65Z8mi2jUaF7/xuHRkgukdFg3HYIpxxpV+fM8avqTgxkJfXnY
         9a/YPhlZ3D5rAJqZrKRETXk7yfh9dcOi7SEJoCcEpO2DKTQ5qWFj+Z5WzmnkioReGaej
         CPN3Tw5o41qy1QTcZwROVlkvPi09gICrmcsPZLi3buLlN5gbmhtTP9ERXfemNNvIL5JR
         pR3kt9P5oJ3qkeAAlYKODEQeJgkhPIBM2QZ8/Icu4zoc2lfTDzGnxf8Ws3dhyL2wy80Z
         gR2bYL0WX0SMwTe4RLUEi2cpoDdkdcm5HqzILe91IOPiwy71bihWg4G54vU4uJQeR5H/
         LUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755093294; x=1755698094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ey7XIorOzAd7x0egX+tKCQ6muW37hs4s2Deiul4Gcbk=;
        b=F9DWMXnDe4o2iMT8kmwnFhxZ/K+4FJ4OQn+XcNvCSEGRVsNZa3zNo/arX5izGTNwHp
         vE5gSBSud82Mq8HNhOxOwk3KtjWYyR5Y/x/2DFxn/SIZuYSwY8/1zVMjSbb+GjrZlLAd
         BCEE/hau/i3FWJcWTAI2WtXGWLipqxAnhUqE7vfaSD3gEc53/0kYbyhFCMEexnkJPc7R
         YEtFwMvwWFrCvCBc4C+N+WrEvyJ0uOOvAGfPQBM9k1ym4GpidLXLpQwlOQPZDRhFL7QD
         rEe6qlKlWKRS+FIeeFYUphkVGxkAsX+mg19J/UpvGBCxaoAnXeWzA1r3tWa8/v8zAAdM
         gbTw==
X-Forwarded-Encrypted: i=1; AJvYcCU1IWf3a0JhTBjXiF+9kh9AjXeXOpVr4wQ4nIKM2hG13EHq5Yxm7hPVXN8HVr4+LAuKruNuq6hUsLtykYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgeJu3y9ZJbsNmfIwb1OUYC9iDOyQVqh7JElCwAW+T7Fzb4Cpt
	IYhNghGtOJrktG49OarjCeBYGtvaM5eWV6pZ62oreHVS1/pn+ejClY3NOFTdacVytAMS0b52Cmj
	ehAhEPOV1MSgtrY3mA+1u5qGE3MOUELv2lmr/gZWA
X-Gm-Gg: ASbGncvKhVTiCnZIiqa+tFaAgDBSNSAY3iH8PpNtG4vlUEKJs10+7i4NYpMvOiBRwZp
	Na0V5rVH8TqesyM5ZMV7v42WEmwOySL5Vh1/y4jBfwBq6Yt2O/sFZLFAFyxE4RZbxlsILCG+dP6
	N7IrA4YLIE/df+ZOMWY5NThG74xXe/a36yvBVEjClRuo6glibf9r8D7sbkHNe7gFQp9IFlnKL1S
	5VJ36+gZvKRMJ+sUqF30kKRNRRgkBc6TcKf8L9K0K/A9iKt
X-Google-Smtp-Source: AGHT+IGgiOq86zC6zEFb2YvDD1kPnLHYi085001r9Kc/KjWLAMpkwG/q07e6iXZKpfciPeZjcuE0yHOu4qwg2T1TXk8=
X-Received: by 2002:a05:6000:2886:b0:3b7:895c:1562 with SMTP id
 ffacd0b85a97d-3b917d24906mr2699615f8f.11.1755093294136; Wed, 13 Aug 2025
 06:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
 <20250812-rnull-up-v6-16-v4-11-ed801dd3ba5c@kernel.org> <mACGre8-fNXj9Z2EpuE3yez_o2T-TtqrdB6HB-VkO0cuvhXsqzECKWMhsz_c43NJUxpsnVpO_U0oLbaaNhXqRQ==@protonmail.internalid>
 <aJw-XWhDahVeejl3@google.com> <87cy8zfkw5.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87cy8zfkw5.fsf@t14s.mail-host-address-is-not-set>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 13 Aug 2025 15:54:41 +0200
X-Gm-Features: Ac12FXzSZBsTRd_3bSBK5cyzmFJUVfD341LZBlJNzhlp5C2WXoRm6AnVbM1u8aY
Message-ID: <CAH5fLggraEP7bwzJ+4ww8-7Ku-Z+d0Em3=NDUpa7r8oTLQy81A@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] rnull: enable configuration via `configfs`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 3:47=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Alice Ryhl" <aliceryhl@google.com> writes:
>
> > On Tue, Aug 12, 2025 at 10:44:29AM +0200, Andreas Hindborg wrote:
> >> Allow rust null block devices to be configured and instantiated via
> >> `configfs`.
> >>
> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> >
> > Overall LGTM, but a few comments below:
> >
> >> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/con=
figfs.rs
> >> new file mode 100644
> >> index 000000000000..8d469c046a39
> >> --- /dev/null
> >> +++ b/drivers/block/rnull/configfs.rs
> >> @@ -0,0 +1,218 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +use super::{NullBlkDevice, THIS_MODULE};
> >> +use core::fmt::Write;
> >> +use kernel::{
> >> +    block::mq::gen_disk::{GenDisk, GenDiskBuilder},
> >> +    c_str,
> >> +    configfs::{self, AttributeOperations},
> >> +    configfs_attrs, new_mutex,
> >
> > It would be nice to add
> >
> >       pub use configfs_attrs;
> >
> > to the configfs module so that you can import the macro from the
> > configfs module instead of the root.
>
> OK, I'll do that.
>
> >
> >> +            try_pin_init!( DeviceConfig {
> >> +                data <- new_mutex!( DeviceConfigInner {
> >
> > Extra spaces in these macros.
>
> Thanks. I subconsciously like the space in that location, so when
> rustfmt is bailing, I get these things in my code.
>
> >> +        let power_op_str =3D core::str::from_utf8(page)?.trim();
> >> +
> >> +        let power_op =3D match power_op_str {
> >> +            "0" =3D> Ok(false),
> >> +            "1" =3D> Ok(true),
> >> +            _ =3D> Err(EINVAL),
> >> +        }?;
> >
> > We probably want kstrtobool here instead of manually parsing the
> > boolean.
>
> Yea, I was debating on this a bit. I did want to consolidate this code,
> but I don't particularly like ktostrbool. But I guess in the name of
> consistency across the kernel it is the right choice.
>
> I'll add it to next spin.

For your convenience, I already wrote a safe wrapper of kstrtobool for
an out-of-tree driver. You're welcome to copy-paste this:

fn kstrtobool(kstr: &CStr) -> Result<bool> {
    let mut res =3D false;
    to_result(unsafe {
kernel::bindings::kstrtobool(kstr.as_char_ptr(), &mut res) })?;
    Ok(res)
}

Alice

