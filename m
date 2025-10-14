Return-Path: <linux-kernel+bounces-853114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A2ABDAAB3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8030D4FAE81
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C47302CB5;
	Tue, 14 Oct 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfYAn02o"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEDC2FF166
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460141; cv=none; b=jhyCS3DZCbq3q/gP62ZB6uK9pzS+PDg+DYLb5f1t666gvYTQMu3Tmt9iJy7igcEvAl1GpmRoztdwDu8HU/+eBqlVaD5f9NwUHGFFtcg2R47LhSEmzsbB6UzfnXznOog0B5qgRhMrJbc8YVoHc5BmwG5d7VbJYYMPMcQX35YTvP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460141; c=relaxed/simple;
	bh=Qx/eEo2ROVIPmgrj6FFyvxVlP5xP/FaQp3gFsAscr8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIKOcP46lNKLrbV/SZLxwwIhiUGSPCuNGWAoncutBzX+tAGvtzvMy1E+435BLzyECl19ryxyM3ft2GUjnU10GSlRgh+hwLRYcDdySZor/+/b36RWDB1v3pkZY/5gTLNgN8rIlC1Bt5sHBLSA/7QvM1y2bfWe14++CNyLzC4+0D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfYAn02o; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-269ba651d06so8621685ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760460138; x=1761064938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qx/eEo2ROVIPmgrj6FFyvxVlP5xP/FaQp3gFsAscr8Q=;
        b=nfYAn02oEy1LxPZC/UTU+gUf46kkZR3qRioGbw4eEl78EMmQiDlU02q4wK1PZa93si
         7Yl9tLoG6oUrdFHJy0Aw8ZEuR10Ls/SwkcXZiAFERx7kICel20dXe4231x3b5sP/hfBB
         8P2GqXqg9S+DClGpRSHnbej+X5NVUo9xCfJwjdoU7y4uLO1LSDul7hPbyEGRW9s635JT
         tt/LU6elijZ7hKxdFbjpV08RwSX8fFFN8tE2b/TYfTvB9JA3f5OyFBM8j/HM8iBz6grO
         alWy7NMpuRjCCO1mMToJSeGMCi46mipVirpji21ICvHQ/eErfdL/12HVoSHT2hOq1d8u
         eAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760460138; x=1761064938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qx/eEo2ROVIPmgrj6FFyvxVlP5xP/FaQp3gFsAscr8Q=;
        b=AGOMsOqZv0+iiLQg9DBURK0jplWIZW3/AR08dzuCxS7osrxaqTQEz6g9XLYCEO50ge
         9FpGF5X5vXHNbo6hdxSeU7iMR8Uj+In1nSpeFGCHfq9/UvRqfTELa8uI8T2y0jmhuYrM
         ypKIdWsXjGJvVuLmGR0XgKgV237TXSYfHCI7jp6B2uqVpgC0v/jPqYWNMHXSbGP8ahRf
         04CuYELsJXlOW54Dq5O2qM7EU3+AlN4B9BpBm+r/1LBu35RtejKtVHniUJ8o0C0ki/bS
         rP8pqGh7RtR1mMvbtT9T3xO+BSqcFtC2m9YJuPdh/15gBo113dQZXVkNP/XnfX+M49Eg
         X9QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF2NxlcWba7+vgWAM5ZeCa/UCoEvYi3lICfhH7osB2zZMiG7/McH5cfzqg9iTDTWvZLn0BAqcb4xpY1nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgaRHq46BT9wqt8pknTl5W3yBDrEBqh5nUOSrorWQ57b85+mdQ
	OF6Nd16ljXT75ke9pYJ/tVeWZI3588h2euT0ceAIskBuV+AqQFfmMMvRtPFrI3swPhXGbOMttyf
	EqZxwbhvt9QoWX1wy8fClzhcHdV7D4ek=
X-Gm-Gg: ASbGncsXP0OmwrjOMZubgI0PWSX8geyWMCIW2B8VBV2kwIhWp+ku1M+lIQWyCnew2iq
	QxprYZjiAFabHobAYiUCy3CuOOOtT5ciwcNRPwJN6EHV81FeI9CNW3EXo2xLHAut/nJf7y9U83b
	vN2Vxw1PCG89mOkGZY8zOwhJC8z7gfAW44z4W+MeLcqU4J3OL/7V7eq9E1SDSqG4SI7OScK3Yz/
	Y67VxTN7BbrduHpQ0S/qYNwqB/2q06a4I+krkXsJAnNqpIjQS+O1QH/5GDSGzKQqfThlMrJ0PEr
	RFvcePwHzI6T5Y7lU9H7jWQlVy1E2mNu2FPDwerqYmPH
X-Google-Smtp-Source: AGHT+IFm0NocZUOA7deQKev6cTvUimVZbWYXQYPu94G9wpQohGmRSl6mxcEZ0e/f5qO6pZB6kdK7mFOzs9rqiJR2e0I=
X-Received: by 2002:a17:902:ea07:b0:269:85aa:3776 with SMTP id
 d9443c01a7336-2902745664amr187372845ad.11.1760460138023; Tue, 14 Oct 2025
 09:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013001422.1168581-1-ojeda@kernel.org> <aOzET46lagm-p8go@google.com>
 <aO51pV5WSmqnT4rL@yury> <aO54nxGil6a5hLQN@google.com> <aO55B_ishdHO2uiW@yury>
In-Reply-To: <aO55B_ishdHO2uiW@yury>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 14 Oct 2025 18:42:04 +0200
X-Gm-Features: AS18NWBtweXgcaBwWxSZPbyhJpQmvLi4CG8z_VcU2bxMhsLFlMa-fdtcHq67J60
Message-ID: <CANiq72=oiJdA_0SyBCzNmf-XL9DbCN+sOrXmVR2TUhYeuZV29A@mail.gmail.com>
Subject: Re: [PATCH] rust: bitmap: clean Rust 1.92.0 `unused_unsafe` warning
To: Yury Norov <yury.norov@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Burak Emir <bqe@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 6:23=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> OK, will do -rc1

Thanks Yury!

Yeah, these should generally be sent as "fixes" to Linus; otherwise we
will have red CIs.

(I don't add the Fixes tag for this sort of change because the
original code is fine).

Cheers,
Miguel

