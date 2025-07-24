Return-Path: <linux-kernel+bounces-744904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CCBB11254
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9B65464F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C9B2EE27F;
	Thu, 24 Jul 2025 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bfl89+sT"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCAE2EE267;
	Thu, 24 Jul 2025 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388953; cv=none; b=EuDISy+gHaAPtpAnIJAxyBrVxnSpvtpQ5N4nDqL2Pd8+JUHSz/Txx8ojAqSUnLXS5K5bBmV6OUb6jLhQ4JxjE5ZYAuvqJ2JfmZ9t5DRa9gOrJ8ErfMDBLIabqJagNzDVEo+A9Osmpa9bkXXSlWtLHNwTe2d//qnC23TRB6Xbb5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388953; c=relaxed/simple;
	bh=ZM/cVPMjqnDcAHexC1gwfwrsHc2MgoIp0pKcizUhlwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y84O2KmKofAfGH8TeuphwlwHrY1JDkH71oeyPM2Cd9xPJUTWM4WylQVnoh1+bXHxvnXEOc+62dSZlnZysMq3Ql+aMoJizn/L2ZIR0gbt3l6NCYhihzGEMeILVHv/rRz1UgnKocCCuLxCckORoAY3L8hFcwZzRk+YzZIKFu94kIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bfl89+sT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23c8f163476so1228575ad.2;
        Thu, 24 Jul 2025 13:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753388951; x=1753993751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM/cVPMjqnDcAHexC1gwfwrsHc2MgoIp0pKcizUhlwQ=;
        b=Bfl89+sTUqzeD0WUAU73EX7RvpiHlONpzMXMLiuM+dIY+RMN62sf8T2OQdwS/kQ/Tc
         5gooJXpTplfONdaIeDPMjdp277rMO5rSWKlI+q2jRbJ84e3zUlzCmfADA4wjmp7DFtC7
         NMqN0Sw2RQqpBuZQ4O5sM0TxjNGteZ7iF9Oz9OqCovLKR+ebPerBbff/AuZhYj6Tbqvg
         zt/iwkpzPQElg3R7jzAj6r3r0frUq89DnGP7/qWJO9CCjvLx0jc+TRe0t08D7xcH6Dwo
         ByahqEJdcNGa7HNfK6fjnTRrBBHKEVOoTtyXLdv81WqwkMoUNFdV3HqNZyFS45m4xSjn
         8vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753388951; x=1753993751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZM/cVPMjqnDcAHexC1gwfwrsHc2MgoIp0pKcizUhlwQ=;
        b=u9Iv60r3km1ZTQWyl7GhONLDgX8lsPXyKUKQiT5kxo6YQ11iZ4YifRpVkQmql6paN+
         S11Ph8SzuMZfOoI6k5Ce9BXZNwn5+wArSygYWwnZMrMSiakt+mgkwpEVL9fBkfml2kny
         H/YrGwUiVfZ7hLOOLL1eJv1RirfUz7tWyjgLfq1piTIva6o9bThrRlmJq0J+zObj5doc
         f1xF9TyUEQV6uYeGHrzc812G++tyGheeQypvrA6CoQlDizElB2Xkx6W3Pnhj0oDFH8HJ
         4OWadBPZY9ullwvt9gkdGqAnUL3ZqhueuRgu6PMg2A5QiMEx7x1/Q513Ox7iI7qJuwc9
         bXVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbx0HSSDWq4+jYTvtB8+j6AHsMH7S68a42pqHp3M13JTw02Gr0c4Vuwpzqx0MDWKgFRBbZGhrg6ggI+45W0i8=@vger.kernel.org, AJvYcCXYhuMMpwq9rJ/mYsogP8aGWlPhQNAapDn2ZLOBpXAPr36ZM7ijHDNDBIGJoa4ow5hRunu3kRI7Wb9ApCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJBuBAbPME0nq+M5z/g2KmqGF2NCIqyZYGl4KTTJinsZ6eDlAu
	vYuhplBCT3hzFEpRmkoitoRzVx6Wl/HCDOERUHKgopYBgZpCN+Qg+yhSJxhYFqmt+2vr1wPg3co
	KhGUHVjVJ9LZ8VcKFH7n+Cg2oz2CaON10ad1bjL8=
X-Gm-Gg: ASbGncsPmxm4+Xwan7scSd6IH6N+4De0njEP/S8yHRj5g/NIu409v1tgHbDbCd/fVNF
	68JtN/mdRlNapVihu/0F5izMEEt/CSrl3Ea1o9VeGv1706+3ZKskXE18MUcHBdhWyuXkjqX4cO/
	l58pYUozR0baDdxZnZH30khc0vNgscPkRe9UbEV/2GULr3pveqCUEga7qf1hK19IzwkM8cvFqzc
	J2t6Tgc
X-Google-Smtp-Source: AGHT+IEAGFB37ZidsHLIIaba8FiGeBk2ECZccsALYfokim6qqvD8w9f6H1DHr7EVTrqZ0BiawsUQhH+jUVVtuE4an9o=
X-Received: by 2002:a17:902:f54b:b0:234:ba37:87a3 with SMTP id
 d9443c01a7336-23f98172235mr43503445ad.3.1753388951451; Thu, 24 Jul 2025
 13:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724165441.2105632-1-ojeda@kernel.org> <DBKG6CA32OO0.368N1Y6VMIUTL@kernel.org>
In-Reply-To: <DBKG6CA32OO0.368N1Y6VMIUTL@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 24 Jul 2025 22:28:58 +0200
X-Gm-Features: Ac12FXxpi3gEikt92Cs8uSRLZnJHZD2m6LWFkt4o9DdE2xrir2WW5NTAjXO6LT0
Message-ID: <CANiq72m+t_vvBsSkgmHCtUvXOG0EOVTBoOij0XZTM1mzd7mNUQ@mail.gmail.com>
Subject: Re: [PATCH] drm: nova-drm: fix 32-bit arm build
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Gaynor <alex.gaynor@gmail.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 7:05=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Thanks -- will take it through -fixes once rc-1 is out.

By the way, in that case we should probably:

Cc: stable@vger.kernel.org

Cheers,
Miguel

