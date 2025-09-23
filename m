Return-Path: <linux-kernel+bounces-828940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C17CEB95E56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1A264E146C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD58324B1B;
	Tue, 23 Sep 2025 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPu1TXqR"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CE6323F78
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632145; cv=none; b=BPOenTahP7jMpmoP4D+oz4aDgb50rSEDDj3vJIv8kXxp18NMxr4asI9u1pcYkPrwNE6NTQdF5ZWKNmt4d79OMn4PVHob37BM75zuwToIBt8K+M6Tq2XLk0WGyHgv9n4mWwlZBWSulsIcOZGd8zVCMyBmiBbWDw81j6OajG46HDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632145; c=relaxed/simple;
	bh=bPsm5BeBlCI99myQ/NU1P5fqNGX5920h4zo3ax7qRNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iV2vWeGpVd2iCNed5jnuBLip5DMAQ36izq+XM958s0QAOtYR0OV8b2Gi41PpjYff/CiyvaHqBHuX13ZY4E4XYoAXr8XWyNPVPwhpJts56uPI5mKxET7NcVYDglFFrU6boKnbc+brg5vlrg8Gve/xcTcylsq7iDPA19XK7TVSZ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPu1TXqR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2699ef1b4e3so8034815ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758632143; x=1759236943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPsm5BeBlCI99myQ/NU1P5fqNGX5920h4zo3ax7qRNc=;
        b=EPu1TXqRMV9c3MkOmonYDNOUzm7pwPqZjgIheS/l365/v4CTMDcXk+VMKryE/aPC6f
         1c9Jte/mSTfShot6B9THGCB6V2z/fPSGGciuZ21zoFdcG7+aEpF73sAFRBlolzGV0HgH
         O7pqPrSvTdbZfUU1FzOdsy1Vc6ng+1B/bELxO97Ecn3P0A4+mywoUi35c0YN5aYQ/eZt
         /+k6lPXuFDOdbg7pwc+1hqKO6QbTZiK3Ik7WH4968x/fRvMD1VEdJddtQfjlgKyBeGKZ
         FC3wGPHR3OIyAp6iPcwwTyLs2qyVacXGlYHBcx/xXsgX9Fy4qEmbb5Ek+tOM/GkMk5rQ
         orOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758632143; x=1759236943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPsm5BeBlCI99myQ/NU1P5fqNGX5920h4zo3ax7qRNc=;
        b=mQGc0d6vvoWh1p5u/+665EYsHPOyo88TCIUnbESDJ6RTF8IqsHKo+aaUlc6jGr6X2J
         gCEL3TsYaD3aWD0IjI1R4n0tqz3hEo0hTmyq36aQ/rnf2BiwKyhTUi+h8LmnNtdRYZ3F
         svRM2sN3HVslPhAkjMtcAew5dBwcT+vGW1pkeQsQn0S2O8VNwBe5OTW3c14mQmoM+Z6D
         PPWwKD5gYFApvarGG1V+caSYT4Zq0TmXw1znUN+4k2xnspQdb38ZAR3Zk3onDi0rUfSh
         gK+TQUcuXwqQ/bp0EMomDIYRg9pOC4ZaCOAg1PRPhkXIZMj7/lvqJteMYqP/qKgRZvBs
         8bQg==
X-Forwarded-Encrypted: i=1; AJvYcCVdXJTbB5pzk5Sknl+XP8Oab9jMAmTctGzfd6sHqwtuWly38LGSYwMzuHwhvPkM6kMpphO4ce4fPsAeWC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGU5m4sKvMYt7tE9AhPabV9fgK9QeCU+Siu8P/7AOLMBpMBes4
	omoxqOtm7aIUYfoNYAMarXTlxDrPnBTHhpVLvwRty7/0goVIZ3mcBWhFjTiwUIYAhe/t5Sy1ywU
	KHNwD8dE7aTXo8H3TxIm3z5apU4ohdTo=
X-Gm-Gg: ASbGncvkOF4G3KTvrTgwTVo55G7m8HUwjVm6KCwB22HRKiWl0140snttOVMvQaqD3jE
	6kQ96aR/+9dNHTVnaJhKi07YQBpm6llS4WiIMeEXZeUL6rIEGlYhV9AEYvygr3/GwGgN/H/cchN
	hcf/ivr+cUr0BXAqiiPo/veZdVtYhdEX8wGY+ku0KzYpBcSjrBXh2NCZ1ETVowL8MX+IX96JoIG
	7YAFJNdOBe8lrVbPB6B2CR49JFUGTDRykR/odx4H5xmBcffYGVMuTgl2B8i5/Vqk9z1hgMCvdc3
	bCw1IK+Fq6X9vM4T+f35sl1jDA==
X-Google-Smtp-Source: AGHT+IEVYX6ve7luR5GnSM4eICjSDTUTZRS+D8hMwmZQRsSzuaYCoXRh0iyJrxTjeZJZllU7L9GVHzx0ugS/+Ydl4II=
X-Received: by 2002:a17:903:110e:b0:269:80e2:c5a8 with SMTP id
 d9443c01a7336-27cc94ca027mr19378695ad.7.1758632142902; Tue, 23 Sep 2025
 05:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <2025092338-elbow-dash-373d@gregkh> <CAH5fLghm-syjWRrj=G2==W4PorPq47bkAPfkeJ1UAsGbbRhPfQ@mail.gmail.com>
 <B4D07104-0A10-4B04-88CC-3F138A783811@collabora.com>
In-Reply-To: <B4D07104-0A10-4B04-88CC-3F138A783811@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 23 Sep 2025 14:55:30 +0200
X-Gm-Features: AS18NWBm0VpH3EPBG5YoC1bxFDVvYN6YlJxnFunV3o7Ts-fF_Inb73M49AabG_c
Message-ID: <CANiq72meH4zKk0P3y51+EQ2gZ2miBCmWSPYEJqVt2bBSrZ8t7A@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: usb: add initial USB abstractions
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 2:34=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Hmm, but the USB module is gated by #[cfg(CONFIG_USB) in lib.rs, so not h=
aving
> CONFIG_USB enabled should not return any errors and instead skip the USB
> bindings completely.
>
> I wonder if this has to be CONFIG_USB=3Dy?

Yes, the `kernel` crate is built-in and it is trying to call something
from a module.

Cheers,
Miguel

