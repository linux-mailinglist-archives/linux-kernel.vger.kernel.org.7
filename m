Return-Path: <linux-kernel+bounces-869342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5299FC07A50
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAECD3B6611
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D57347FF5;
	Fri, 24 Oct 2025 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9MoNn9J"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FD0313277
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328954; cv=none; b=s9wylvTkOqDvxRcv4jM2dKlSOX3Vup71Z9fxW3AtpPpF6iIRblpgnJbwHmUpFEA48RZygu7tR+73aDVgSwnPfnXScMkD0acmAttVnDc6ww3z4sHDR7fPZMPbVLC0oe0Rl+WDYW6sxpRY4Y7qddhxhDQ5daOxGXSHXVkxBTNygi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328954; c=relaxed/simple;
	bh=NqIgJcJa2diXyLKkZeV5zTmt7c/3DcWq0YdvpFsQs1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8zTSIK99ZPxjgI78fptE+kK6IXASmdcEWVosggewuFb79eCcpckKlOP2vAOoAgYkzpG2MffyOcRVlDkVdFnw1t/6maXKenIIuoja5xWt0aOLfDioo/UDWTvv61tybFW4pOYrjV6QTWKtK+5YUQfwChl2kP0v21CE1r5iumY9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9MoNn9J; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b47174b335bso214910a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761328951; x=1761933751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqIgJcJa2diXyLKkZeV5zTmt7c/3DcWq0YdvpFsQs1U=;
        b=U9MoNn9JMoV+ejoI9l7i2tBdHgVTB1X42wQkQ/RvY36W7RueHRauazQL9niaJmZHsZ
         octavXG2A7Sk/UdosBZV6lKwpJ+Qk+P5uYLwoCbEDMzYhe/uWAjl1nYEduWAm6MHAPZw
         RojdrkuoSsx07slerizWuEzac879W+sQnn9x113e6B5KlhifUgywkc0wGb4UsMFAhVh+
         von4uMpMz+0/JVur296QBGDC9SwOETAbDCT7JplmeZ6sK4N7GOCKuNBDAW56wFobynJV
         6I7rffhwtrQMSL5tVNQyRGAJVrCsI9G6LDg3fVdX3CtSQ3HtOtlDOy55CnRmPBPGzCjH
         Y83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328951; x=1761933751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqIgJcJa2diXyLKkZeV5zTmt7c/3DcWq0YdvpFsQs1U=;
        b=YKGW72LNk3hZHvXbTy/BjjMNoV8qrl6QsbGofrHYxAMCO8fq6kD/UqY68i81L3oTwt
         Cdr2C5EKYzWrMQA9EV5Dp/PpLXnLx620DV+J1942GsozpPBEEEjMkeaermE03Z0VhxtV
         PJrt5aclU6XLOdctec5GD+1FBFCYPpOYJ2bsdq8tC50Ajsa+0SDC/6InwjH0HX7ad5Us
         lMHEujKLsWuYctJmGDlOQj5aWmN7ep0nsHKGv1I+KxVAXY60B3BCffk+0cxXepHagrc2
         xbO7E8IKslDpzLeIByf0Rjm2Z8uauUXOKtZW0WMSwPrL5Pg55jqhT/FnFrj2oqeXY7eK
         i6XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB8okGEWObObR1+NBjPdDcf//8URCMVaQiv+LxK1UhDi6niBQYNhs87lGS61/HTITOGYGJ9MdIMFq9L3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YygF/lOFNUoo015xSoIQkXnR1aYsgn+7UvSmv2IPWoswaOz8Vxe
	sVd26CeYZuPn8MXF1fVVr5hmsC+gryEzSnvds0upFWVWRC86Kg2huCSxLMPvBJLBGRcFikVRjl4
	WeulCZnqc4TgA/ZTyI8VoS5rhUiU9fdo=
X-Gm-Gg: ASbGncvaWjoH/86TiXQ3TTSmni1BPXgdHCA8zevDbNm9g/nH9EZkIPfizIlW0OC7u/+
	5OhFYtluj7IQGRm0z5+omYetsdxJYA7C+/HDqqmG90GFV2d++hUBvYxG+dGN90yF3cDvx/MQX8s
	1sGH3//Q4Bn9AbGHKxSUScL/NbIfH5Wb0VEg/JW//+3W4DW6oFywHmv1XHTdV5MKYZM8Dew12oU
	YPaTALnP7mWSBgRQ/XC0YQWvZsjKAVef8dtMKJe1fzi3eydsZa2UZd9mExxOIIMYFL4UTHVm4ml
	aITwKyrp9PXI24jcGH4yGkWg+CPZHXrGkQOpCoBbsrZIS2GBk9ypazgiI7V4vEvShPu4F7EOQ2N
	5zqQTgOThmZ7mbw==
X-Google-Smtp-Source: AGHT+IFXN036gyk3u8TwThknCoOvSHyTdnq5f+a1361AXFhp2hDWxvNZ+IEnVkZLJJwnHPwu6ofnzTCYlg9/mxn7rEg=
X-Received: by 2002:a17:903:f87:b0:27e:da7d:32d2 with SMTP id
 d9443c01a7336-292d3fbbf0cmr97350035ad.7.1761328951021; Fri, 24 Oct 2025
 11:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-6-dakr@kernel.org>
 <aPnnkU3IWwgERuT3@google.com> <DDPMUZAEIEBR.ORPLOPEERGNB@kernel.org>
 <CAH5fLgiM4gFFAyOd3nvemHPg-pdYKK6ttx35pnYOAEz8ZmrubQ@mail.gmail.com>
 <DDPNGUVNJR6K.SX999PDIF1N2@kernel.org> <aPoPbFXGXk_ohOpW@google.com>
In-Reply-To: <aPoPbFXGXk_ohOpW@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 24 Oct 2025 20:02:18 +0200
X-Gm-Features: AWmQ_bknF0O4glT__QBpD7EtGbQw3f2JbbITF9mBVx4ARFlGbB71froz6CcT2AE
Message-ID: <CANiq72k8bVMQLVCkwSS24Q6--b155e53tJ7aayTnz5vp0FpzUQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] rust: uaccess: add UserSliceWriter::write_slice_file()
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, mmaurer@google.com, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 1:20=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> I would love to have infallible conversions from usize to u64 (and u32
> to usize), but we can't really modify the stdlib to add them.

I don't have a link at hand now, but we already (recently too, I
think) discussed having these "we know it is infallible in the kernel"
conversions. Maybe there was a patch posted even.

Otherwise, I will create a good first issue.

Cheers,
Miguel

