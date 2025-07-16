Return-Path: <linux-kernel+bounces-733740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40255B0787D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289A21C233AF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD722EE998;
	Wed, 16 Jul 2025 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zgMaAmSK"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A093C2C15B9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677170; cv=none; b=AxeGhHzq9FouPJSTEYTxartw1nHxRuKqyL3kyX0kOUDKx0YgWMwg77AaFD8PC6URoHK8l7kqru5Y6+sMefxdSsJLdOEKUMJHPOl4BdAPeNCMaxR1qHwpv0sUPfHk4CisqNa0qBPdh0gDNB8IMljQJYKOO9uz1iT8+kufCM75pSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677170; c=relaxed/simple;
	bh=n9/z3fF/0C01CrHoIFHDdD5Sh4DiNFnhLvxjo7maOh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiR4S+6mfGHnxN1Xo7KN8SNYe0iQMSNKI4khAmNRCzsCNbRJrKHJgQQa9ucPKbwxmFkiY0TpH0097sTiCZjUwmfflCrEinEI44tzZ1iU+rctvvnp6Om9YfKrOelstrpdXrwA7VClqozgKIgsA29ZQ4Fmz5hOKsGWNB28UYbir+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zgMaAmSK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a54700a46eso4243799f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752677167; x=1753281967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEGvPpVqb+Fvi+UqK3fdVHqFf016XV/901kj1g7cqLs=;
        b=zgMaAmSK94g2I8c8PpcPcsLxjXsmgEKqYQsKxqI3sTM/1hHqJjAlYU23bY4t+GghCy
         xcP0xn6a9GWCCEH81azOjJPcT/+Epw0Zjj2S18m8qBqN+999GAqSWP/imrxQ74s+tofu
         HvFpi2yXXWKypD4w0bSBgeJZXTWVjdxz2eUoUHdzUqIyJ+Y06BFCosI9A0qJhhbPfMrK
         QaMeR34/xbwet7QBKss8K27+7gP5drJZ2itHjmmE8YIZ9b4/0jUTsuRfi0yAStEwa7St
         pWkifvAWIe63Vw9THEU6kXt/ab+NNx4LVdEo2PoiKuThtUz95ucTeMWxW2MEu5F+t4ce
         +RRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677167; x=1753281967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEGvPpVqb+Fvi+UqK3fdVHqFf016XV/901kj1g7cqLs=;
        b=EAehkAVUxfPz7LT48l3tDa5aLcMS0eJqtUPRKhgkP1hcoJa9pqP+NywdtD1QpqsbHs
         RPJnfQDoH57MTQbMJ+CfuUkomA36ipgCH28mEQGt2INKTGGKyX/6w94Xqo7hpjIKfB4n
         oboFc/ayTJ0zGXIDwnDNGqlyLX8iq+AxgBEy8P1WsVocKbxjTDnPcFkozNesL8DIEOGb
         FsRpCOICEZDw6pooEF3tI13hgzOBjad8Y3b+nhIQCYmuuhAVadXpPuDP0ueBvE6IZ9Qo
         iT8le40P42XJsGvPfYK7jHggQDlN+b5uFWsGED0w3DFLQ6wZPIiY82W0860sYcGH1Ox2
         3pHA==
X-Forwarded-Encrypted: i=1; AJvYcCUli/HMfDMUY1QpuI2CucsvVNFgDNFEvpIpbTPU/QPOrBDZlxqrSQBsrHMyPpzQRy7uWD3wT8plRXXWrlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7X168Ae7PYDZDso1PMND+14dnPDYwwedJsNWLCZgX4oDNC076
	iIqGY221kVX4wyVtcYLRPQgd78eHpwbOTmJjTzAICPnmPv5o76EiJAlwUjok3WeoAzYCTuO7aD4
	F3PXBw2atwWow7EUNTM0bnN8HTegd0tvH2s7ojYVQ
X-Gm-Gg: ASbGncvNP+toNhhQVh41YtW1yXJMxKNKlWlCGuFkWDxnBdYVMh1jDK0qX31oBJPYuYo
	+04hRKj8AFSFrmYM9fY7MEdychdaMjwxOPaiok+L5qvnI20FBvbckKTwiK99y8iY90wMu5bCU7Z
	y9urif+85rFkhqrtotBkst2g7Ai2A3LjBjhUhX18yw1QymYWU7HnEHsCUcOqG7OgPc3yfyzbV1U
	W3FUz9V
X-Google-Smtp-Source: AGHT+IFAHBnZHLNrYyKfSBfa3jy+sfO8JJ+g2wXjd/pOkO9jRLTgL6WfpFC+NoeQ+/d/j4coTHY1LmnzbgyS/z9vVPM=
X-Received: by 2002:adf:cf0b:0:b0:3a4:dbdf:7154 with SMTP id
 ffacd0b85a97d-3b60dd8e5c4mr3015978f8f.54.1752677166930; Wed, 16 Jul 2025
 07:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
 <20250715-topics-tyr-request_irq2-v7-2-d469c0f37c07@collabora.com> <31EA1044-AA9F-41F1-97E7-D3C582C32167@collabora.com>
In-Reply-To: <31EA1044-AA9F-41F1-97E7-D3C582C32167@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 16 Jul 2025 16:45:54 +0200
X-Gm-Features: Ac12FXw4o_IZHo511I22hzkAseLhPcYg2xUkAXmB7tIIzyMTFWEK49V4bjcBMlM
Message-ID: <CAH5fLgjYcw4tX_CLKQYvR8j=aG0b0n_VYXOYVhGUUB_5s3A1AQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] rust: irq: add flags module
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 4:20=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Alice,
>
> [=E2=80=A6]
>
> > +
> > +    const fn new(value: u32) -> Self {
> > +        build_assert!(value as u64 <=3D c_ulong::MAX as u64);
> > +        Self(value as c_ulong)
> > +    }
> > +}
>
> Sanity check here, is this what you meant?

That's fine.

