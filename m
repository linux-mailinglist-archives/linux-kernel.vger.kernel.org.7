Return-Path: <linux-kernel+bounces-769179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A07B26B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127E85A5E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5072238C24;
	Thu, 14 Aug 2025 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKtoWLOL"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D333A2264B8;
	Thu, 14 Aug 2025 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185640; cv=none; b=Bba3bfArqTKPNpk0D1bzXiRTXN0sdT3eVZQVM3oqdpvZjqmYClWyf1+5VQcRKDqPuZWo9mNMSxbTa5d7056vL6WDCmwQamgs3h5k6hc8oD+m14j8e/U3pWd02lb9IQQdK9JD8h/8pjp4g2UhlQLmlhG+u5XDCqJw46W0lwPrgts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185640; c=relaxed/simple;
	bh=Nq6aUc1/B4cTBa0sp/QpHeGcEL/dEYhBVIwVBFy+pqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgqMiMoBLEYG7iFS9hLbBww8z+Se7YSEXCMJ7nHR84e1eiH4c998tYGnPVbZj+QJLnhiW7HgXwBv3jBOFNQxTdrghpp2qlr9NKz1ZiwPVbrNOn/4qP/y7/GHOuoGXpodD3fAIqJWiEj9tDJfo0jEKb3jSsZuYXGTzcMR5sqJDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKtoWLOL; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32326e25000so146270a91.2;
        Thu, 14 Aug 2025 08:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755185638; x=1755790438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nq6aUc1/B4cTBa0sp/QpHeGcEL/dEYhBVIwVBFy+pqg=;
        b=hKtoWLOLs2kzVsLHTB1rNbT5u9g3GAZmj5e3UItkxm3vXVRXhY99PdazrLQtn1QiIl
         voCa2dMAU/ovtU5teA725WLsZPXdZ3njQe8c8tJ6cOD0O9hiVBEmy33F7k9uIHM/XrKG
         JlFTWzuk9KsbsCQ0haFKyUHWaL4CSN1WkYIgEQO9Rzzl0ywl6ov8x7wOazd3tzzgvzZ8
         MY/vbcxrfQ7wFbm3HitcXq7jGFjWsQxWvBtTk8I3s3v6iEh4VkH6tXgRlRAOJz3F51FJ
         wHs3LOt7tS5Q6Dj7z7OIR7+kNSwcN8H/Q81dIF+2YLdApLUvzp5rTdYkbACZbHibh+yA
         qmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755185638; x=1755790438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nq6aUc1/B4cTBa0sp/QpHeGcEL/dEYhBVIwVBFy+pqg=;
        b=Fp8RDc9uouC5KyReRHh+gQarGI9SCEl+fQK+RSO0QpmWdLvUCLYG8dMFZ4WsIMJkCo
         geljMMNaAhsDedyF8Z0q18Mv4y+L430s6BWf499Y/FUOI0y+QW+q/0lPQ034dzPrqLD2
         VlS/6bw+R7BpV4L/N3WdNoIPsPiRVd7BOth7/yxFedqUjfOe+U/8CG3qXrEv4I4cXVcR
         95UFCn4Fo40A53GKpOlcyFjZ7+ZI/Xthky7q/SvD/9IzzXYUVHr716GNA6ybenROAYcU
         PEMXx0UH1M7iuofzCf92Xpicgcur/BXpIAJs47L9mBoop/Ww8eKiZDWBxRQnauYmyDw+
         Uaiw==
X-Forwarded-Encrypted: i=1; AJvYcCUBuKjxCz3GZ+2K8d9hGP9OFzZ4DngpDxNMJA/r8ahfV4bEdI5W81h1a+8t6iLyNkeyKyXsVcOGd1UFD9A=@vger.kernel.org, AJvYcCX0N9lnEA8qdDqPLuylDr9cipwyuYJPhtGNjdLazclr1cZsL/Bxcw2j/rp6UsYrMYPnHC+KI5QI4+/R4/9ILYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YytTsA0JmSFHT75dc6eRoHa1BfCSKBrcjWO/wdX5uxmMxKQAKbk
	QRPiTADfMzeVIGP0ynWDtTuwHxSt+6ataPCNU7sFZ6IfxPYr5Y7Ss9rJGPKg7UtD5kXIpC9ioWc
	VHFE/V4lP5Ue/+eZ9J3sOe7vCjh7VgVU=
X-Gm-Gg: ASbGncsS+Cy/N5zGVeU/W9zUsOSIb/DPMsIMZKOhpgIdXPPDRFD9HDUdUe52ttHjb9y
	2w/SbQ+URD0c1LJyK0lM2w31altYqnRXULHb2C/Gek73GX9drw0lCxgr5jFrgBssiqzVbuWhHAm
	lBuujdp1eWxaMTo31UwfKLSwP2NfUA4ZUluW+V0z75ELj8pht6sYDbUS16PJgN59ZkKLnqTwpdh
	gkc9AX2nbqVvHj1pAw=
X-Google-Smtp-Source: AGHT+IExebqpquUbhbP79oNaoqhWawZvxeYfYRRjXoj1XNHbnsxMKW1hibJDfr5mk2Qen8wXb//p7fJ9VAKFesJ/+1I=
X-Received: by 2002:a17:902:dac6:b0:240:2bc6:8ac4 with SMTP id
 d9443c01a7336-2430d0d2218mr57153305ad.1.1755185638075; Thu, 14 Aug 2025
 08:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814093046.2071971-1-lossin@kernel.org> <20250814093046.2071971-8-lossin@kernel.org>
 <CAHC9VhQXOezJ2=B1BQOqLgfuzDJEVS5G_r9+_bQ+OUNTpjZCKw@mail.gmail.com> <CANiq72=vhPsGjSx9u0FvDa6uzMFkFQFP9qG+DhtZ_U5TyV=bJQ@mail.gmail.com>
In-Reply-To: <CANiq72=vhPsGjSx9u0FvDa6uzMFkFQFP9qG+DhtZ_U5TyV=bJQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 14 Aug 2025 17:33:46 +0200
X-Gm-Features: Ac12FXyvLo49VMmYiEU1CpyzrkHMikMWdnppn1qvjYsfqG-8BI26C6b0-0xA8JY
Message-ID: <CANiq72k8kWHeBGLgHVE6vN36n6ashq-TVX3+h6WxLtc1jpUefQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] rust: security: replace `core::mem::zeroed` with `pin_init::zeroed`
To: Paul Moore <paul@paul-moore.com>
Cc: Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, Jocelyn Falempe <jfalempe@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 5:31=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I think the idea is to take all these through the Rust one with

Or through the pin-init one, which gets pulled into the Rust one.

Cheers,
Miguel

