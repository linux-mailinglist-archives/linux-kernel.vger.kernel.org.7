Return-Path: <linux-kernel+bounces-826099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C274CB8D880
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 11:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E87A17CFCF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2896F24BD03;
	Sun, 21 Sep 2025 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePkpnDhi"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FA11F09A5
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758446006; cv=none; b=bmXs71gRmY8VTfhkZffOHUl8xtB7VKrJ8E9PUxty6lE2yd7XCHN9aL2byYIFFkdgFtN35ywlDgj03ptWifxloFxy0/F8VwTy+mpd+BhY0syTRSCyawTM3fBwOqA25tUVPWIeQpoPM3fwOTUTI5akxg7d6GXn55PJwxfnPWYzLu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758446006; c=relaxed/simple;
	bh=gSufU8JIF3LVsmcBJIqQE/Y8EU8O84noC407rRmxu7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIyCvvsCD9Pfg2wSBm9dfUjGPye5imuvml26gtWpEvE765YVPWCS+ugVCEfnBsg6O5fgtnp155nUyHEPVz2hvR8bwi+tLesoR/6K7xMqm5pQzDmic45oCmzfukWWCuYxnxQj+YlqZSGK4kWPuCcBcXdalTt6cZqGWSSMHbQdtfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePkpnDhi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-269ba651d06so5539105ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 02:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758446004; x=1759050804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSufU8JIF3LVsmcBJIqQE/Y8EU8O84noC407rRmxu7k=;
        b=ePkpnDhihE1To+fkVZrzDieNHd5qGOIa0i+ivMdhGI/gBrwquAUuMu5/2vujBERa5Q
         H97GCr2q+JfGrfvvIx56oIoMEY6bY4rjt6MDKLGxTI81ydMX1kBSfZClK0xGuHxarM1N
         80tfya2qk516NfUsMR5ee9gJ0O6Ilp/Vw/Ou3v4RAdRIQWWlOzxRZrYj0/7ponTHJ3lB
         s9mGjf2e6s3mARZqvVwAxSpYvHRZwEwuvOG9v0IpW/FdqBgC4i/Won0+JnQzZXOQgJ5K
         scCHZFGaF2L9s0sK0sNpzN8k9KBMqlf8yKNf9++oN0fHm1eFM2mv9ppTOe/UkpJBnbpp
         74PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758446004; x=1759050804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSufU8JIF3LVsmcBJIqQE/Y8EU8O84noC407rRmxu7k=;
        b=MyVoQyqrrYzs3cRwXY4+1tt4VFMWJoLnc2Wh32O9Cr7GYTBrTEHs+PeCHDfmO5sSHY
         /uq07hWEOSWBQ9uDLjML3oTMosxkrmi5QaQ2SiZkop0TU6wZssrzraSFOv3xKXs+uguI
         DwZzd/f12wjt/ReSZk9pQkap4Rnc6f6ujstTl1OJQod5wu+rDcIPvH1Zs9Gysn1gCZAB
         mIYlypgwLa084cdXUcosZxDUv2UaV5WBW+u79+1wPcWmsiP0oiOlEnoQ9jv2vaBTj1Ym
         QAtj0WdvALaOTIOLHI9UPcu+xP2O6Wv3lMfXmmoApKhe8FDHwKLftv3qElRjfssOdegf
         9Sig==
X-Forwarded-Encrypted: i=1; AJvYcCUvp4eA+l+1hVvO5we6SZi5b0FiP2oAGnif6i+xXZ8FyVxe9bfCXXBZ0ApsaR3McBz0Rfx4z8QBrAndCwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhWngcTWDyeWS7wucxOWIyIqPm93xgSXRMVv1EA4Hz2HBKXti
	UCDyLLTZlAxaG4pYchQypR+AcPTTsp02nuoQD+fgxekKAcB/6H2DKPeRG6XPr7WvvpZ9d4IOcHV
	IZwUwnHgLKe9vleVeQ6rc1Zo6IYonoHw=
X-Gm-Gg: ASbGncvsF07IAI92YL+V7ojfPkG/eDgXCn0NTCCbfbYJynJQzHPboh/PLMQJIwQ2fnf
	tkXuoi5OtiaR3EALieEsmPqRUHSvom0xiUt++IAZNMYKe4kBot1Fchj5SBi/tfiEqOtSTmkDHtr
	Y0lNo4eYfvFMrprmSM8nNflAJtvYcK/kBm/nUf15SjbGnAiolgX+crqw2Fq4Gfbmreio1a/s0V/
	l0UzZxF9tT0rhkKdv/Zk87b7MmVrrroXF4x9KHrNVj5HQTNzqLbTYm28VX4A6hBgaxtmOeIceoW
	OKaCu8rh5JtEpGqGdetgNyR3kQ==
X-Google-Smtp-Source: AGHT+IEEZBGH2IzO3aNMwNCO6HHYoCeMwtPjKVajKnUsTtgN3Yo7ThUocVDXKU0+1Pj7nlDMql8MFH9vtVpYiMJG858=
X-Received: by 2002:a17:902:ecd2:b0:24c:c445:87c2 with SMTP id
 d9443c01a7336-269ba4479fcmr71628365ad.4.1758446004458; Sun, 21 Sep 2025
 02:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920161958.2079105-1-joelagnelf@nvidia.com>
 <DCXWEV3YO443.2EUZL32P96Z0D@kernel.org> <20250921004517.GA2101443@joelbox2>
In-Reply-To: <20250921004517.GA2101443@joelbox2>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 21 Sep 2025 11:13:11 +0200
X-Gm-Features: AS18NWDIPgmAIiZPso23f_sVGWVfZ4LD4KE-nCRi77OvdxwWwOWuJ-1OW5tHPyQ
Message-ID: <CANiq72kDkAtYQ6fBb4gPEJqsS10qmXRRZj34gDWqjAQEvmXVPw@mail.gmail.com>
Subject: Re: [PATCH] rust: print: Fix issue with rust_build_error
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, acourbot@nvidia.com, 
	Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 2:45=E2=80=AFAM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> But even if the pointer is a C const pointer, LLVM seems to
> always want to reload it.

What do you mean by this? I think I mentioned in the other thread that
a C pointer to const still allows the callee to change the value.

Cheers,
Miguel

