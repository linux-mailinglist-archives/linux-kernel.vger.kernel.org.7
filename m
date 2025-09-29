Return-Path: <linux-kernel+bounces-836386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7A7BA98C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A7A17ECAB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5191130C0E1;
	Mon, 29 Sep 2025 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1ZqkmIc"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5986230BBB0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155895; cv=none; b=Uov+X31gVmV4/t65jZmM+UDjIFEQWaMBkWIo1vxGD6bNNDADu/ewOgpZfFupAxpRsVgRhpIMEJUwYErmrJPnIpfhcRHJ0qiQIw7zqczYBJC4UpYijKxkLm5e66TFDh4H3GT37HOsivSeEgYIUkcZM1V5ryIvosh4Cw2dvLLChnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155895; c=relaxed/simple;
	bh=ot8hcRKjG+GhZEktY+15kwYYzRMRN2qEVMOH15R9us0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfcZjzgdSlpDTroVxP9760a9Z7i+xaxkd8Uepyl9Wy+FLkdf5XOQ6GXPgJlLaG0Od6yh4hd/5U0sGPAenBRaLiK0+Wk8fVFQJLG1pnxVb3xPy96vWsqN/MZK4kCACoYwRKL//bu5m29I81W7Mgu9MB/Y3ha0KF8Il+6xTMhgRbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1ZqkmIc; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b520539e95bso281017a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759155893; x=1759760693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ot8hcRKjG+GhZEktY+15kwYYzRMRN2qEVMOH15R9us0=;
        b=d1ZqkmIckNX2lrSGeU65Xhu7nXJ+Z+ZnTEmzt6NMRbmj3/E9L5tISrwe5o55miaXQ6
         r++e70H5FvP/3JdDWtBasjP3AR/Ey+el2NBIdjr5LydY78DIyQ3Vj8nmYXiFPDh1EKJx
         mBbVyBHRY7glXEnIgxwR2mcFB+VyrdjKUe2hehIRq/LZYiMT+AghUrR0uAlDCYdPlwNI
         TexgbRig4GjOtU6JJJleHkynApCOjRLUw/9vwNSFDGna5TDsYvY/Kqb50lawiTQVeRxj
         Y6kfkKzSdG3tH03EwI/DZeCIdCMEmmHCy0QpV5bmD3TwYx/tMqMOKaFNX3/8CDEOOIm5
         65Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759155894; x=1759760694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ot8hcRKjG+GhZEktY+15kwYYzRMRN2qEVMOH15R9us0=;
        b=W55bdXC5WDpMEXb+wTSMimqNBUbje8ybET5ioL9Qc7Ed/njffF7W67M8KtNyk9ADyO
         TehVuS9dtg6Y/2roEVQRGtlI+8tEPWBMkv4JrikiIfLymodbDo99wZl3xtYMDNSH/+SI
         qHEzTgCwF+BXLV2M2LhajOY1u1Nfrq5x/NqM+nvoag1GWNRS2MxGYIfwkxLF/9Fx7myB
         JQnjuTjJZxuMRmKRHdD0pnt0HHnH0AqftEt30reVQFPEF56xCkIONu5WO4vpYHIf0GSG
         2lbGhpl/Zfrr0OlDbFbTDUVvKSxwIdPQJcEuw1cZpA/qThBoNTUgK88wUd02wE5Vszky
         Ai5g==
X-Forwarded-Encrypted: i=1; AJvYcCXGi85BJpyHwlh7NU+y2K4fznLR8r5Xyhx0xVUlHGOpEFfu7nle49anHoibMNpcqp+xDxlWu7AhbYL+t0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ2qacHK1Uq40eJvR1NSSIWSclW62+/33elnnHSshPm/ji+WOG
	SfOM0B9SArMTCusLzI8XR/pQYxD61RP0v2qTKdyhzB45LfEz2i2VCTLGgDcPFr638G+yzXEmEL/
	vywhu2vIA4CyUHcZqdLDw1NYrfTQFInvRqMAz
X-Gm-Gg: ASbGncukLAKwPSsI77bAS97/eBXYoUIjqK4WqapLNSdXjfT4XELIq/FoBIufoDL3rYE
	b0O+awBLKs2xrgjDteV2A5dts7ZBwmF8k3+Bh6GjYEHIeVQ3PGmdyvMKwA/1NuhULlWEJNMBH7D
	x0uoYMY1aC7ne9kCN2QtAv6T1C7WXg/O5EKnZGmnEYe0Ff7U+4vz9UtDiVtKHXSuyGQbz7SXDIC
	KjmkPyIae5YCPDKhTce8mGTEyiCNv/5NH4uaFnQL8ZgHKkR3wmghcZ7q4RxlKfcHzeGXTPVxmTS
	KaeENw0PGL3vXztb3lvdnW+3oouWlKwW05Dn
X-Google-Smtp-Source: AGHT+IFO+CKcOfhjq3yagbAUNFRqtJ2JQPPv6IOGwZ4Z+4FHLSqV7RrX0bFPoMZ075YnvnY3rrn95mijVFVOb6eOUBY=
X-Received: by 2002:a17:902:a507:b0:25a:4437:dbb7 with SMTP id
 d9443c01a7336-27ed49d5fedmr70259715ad.4.1759155893602; Mon, 29 Sep 2025
 07:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754228164.git.y.j3ms.n@gmail.com> <DBWXJA6XF1VS.3PNHRWH030H0J@nvidia.com>
In-Reply-To: <DBWXJA6XF1VS.3PNHRWH030H0J@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 29 Sep 2025 16:24:39 +0200
X-Gm-Features: AS18NWAQUPZbXtjWExl55E-tjUwblkbPBQ5uQeLCMefcIVbUSmtt91RPmlpmau8
Message-ID: <CANiq72na_d6JQdyZ1S22mus3oom_jz93rpY+ubr4yOuvMY_fSA@mail.gmail.com>
Subject: Re: [PATCH 0/4] rust: add `TryFrom` and `Into` derive macros
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Jesung Yang <y.j3ms.n@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 11:13=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> I have tried this series on nova-core and it allowed me to remove 150
> lines of boiletplate just like that. As far as nova-core is concerned,
> this is a perfect fit.

It would be nice to see the (possibly RFC) patch if you have it around!

Cheers,
Miguel

