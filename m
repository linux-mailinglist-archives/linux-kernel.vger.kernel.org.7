Return-Path: <linux-kernel+bounces-809105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F02B508B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87071C626CB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23EB265CC0;
	Tue,  9 Sep 2025 22:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ2Hstc7"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF0A23A9AC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 22:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757455468; cv=none; b=WgYEWMzXW+KGIyTYNO6HmNzvm5PDw+PJWQUUdIZUj10a4cEmfr1pl6Ym3vX2NBlPpJOSbicnhBmViXUk93I1hZgBOxP82hTTRlZM4dBC8UJCY1kBFTFZdblghYyII8n2Sk2wC9iO4//3pnIexfnRFaWBP/TTNB+8rRwRWK5fKuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757455468; c=relaxed/simple;
	bh=vJE7SAtMU597GHTC8LkC90WpJdQrYFWukdI48tYxJKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kjq6yrJel10Ll6VXG4EE2cPn47GykDoidzRTBTveonAxZcZZelJHJohQOdKrixp2FzGtz1KuF993MFycRNMOvajLGvaJkDk4aPSV3oBqR817y7dCGK2Cvk6dRWwlKeYMFomOTn8DOEcYQ5YIVy+Gdkvlf1IRH6vIqY1Txrurk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZ2Hstc7; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55fc2236ce0so1148771e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 15:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757455460; x=1758060260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJE7SAtMU597GHTC8LkC90WpJdQrYFWukdI48tYxJKQ=;
        b=dZ2Hstc7zFsxKirwsahBNJrBqdtCUAK9fJirHm/3fOOwd0qOEd2XwKN0QBoWU44Z44
         Oeh7BQv3bl/hwzidSpHpiF1SzFxq41gNGgmkWZBgMp535o5wgaY/X2edOExE0nT5uYkU
         IWiSFbCX5lA+5Q9U3DW5aQLH8d/9u8FHuNIJV/bR7Dstp2K74ZHx0WDBdd4Oz2NVN0qP
         6Ml/YjEg/3pMj0GHMzrLhDeFEcc6qmuk+3s0wj5eUNpc8A8aazPzTYx1ntOYgdOyygwp
         TK4ZYlJMYS1wfw2ARThHca5RfNm4a9gXfsB5cvO9TDbtAMVY3U0KKDnrayUx/niwo+ld
         NTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757455460; x=1758060260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJE7SAtMU597GHTC8LkC90WpJdQrYFWukdI48tYxJKQ=;
        b=q+celoYh2itRZBDryrm74zq4kK62ZrCvOpI+lj6cz2Dpo39iboU54OWf/Vz1/Dsbxm
         TG1h+jnXM4ykLue6BTaYN8mDm2301SSDGvWQRIe5nlWkByI60CleA0oYVJsmsTQXS6xU
         +DNLm+F2VoLBeI/gjXpUs28uRM9KLOfJ5rs/vd+IgN6f8o78/Vq9OXz84feiSedCIZYi
         iyNvjRDjGUdOSiNHwliA1GwAi/CY/oqFaSPDS4dgda83taVeLeb8kZMDlcvlK5AHDuwi
         wWGyAsUDecGego05b7IjxbWngu/HhbdNpRGaFeBOHHTj+Bt7yRnoKnRP0N+hWwmAWx3e
         w60Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWor9w0DJ/kcmdXMK7bzIdyoZ3cQtiew58TlCztdfYSZMW9A9JFnzVryCCCGxUKXcWKH56kxa1WWh3WwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNeOMVStbqchCSHxexvT3yoTRredH9HELVaEKm15PKpZyF3k6g
	jSzy97wj13SxGHvs81ys6H+J8vKFmOMqK4c9ed8wlDw/CS9FRHY4uL1AQBzhHBWA9stAJrf6Io3
	fRFBUYVkFrEif0UqRf5g2YSF8SoeF0Oc=
X-Gm-Gg: ASbGnctFcLa2AIxZhbec6zQHFt9H1+NJxKDAWYrpWPvxCAiH6MNxPskME7jIWYmh+qh
	fdsn0NE5c2NIKuXXIXnrEIA5zA/j1yYbp5gf77JlK+XMjNx4By2Wc4uLNF0k8fG7pPuSt+Dp227
	Uv2SzSQWieQ6EWky7TC/hDQ5iFmShr/sXmwFXpFXZVgG695KPhQhXBiRmADyhBtcD1zRnMwibo2
	gsF/jy1hlxXv4GPd6c3b6bomvJlcjDLlSF/tZBwHAb9EB6PYcEaykc+/6hDtU5uuM9/lkVNhkuD
	cF4H6RwEPGQU3axFY3wfjLd6uz8Oo3zKZZlq
X-Google-Smtp-Source: AGHT+IGaa3tKhTEeaj82Fyo2xoHmCsDsP1VnOtUkctEIYGUN0qmz9E5woHXIzyMUU0VsfLfEZBQ0b8TrzmrdoI/zncM=
X-Received: by 2002:a05:6512:3ca4:b0:55f:4a0d:3f50 with SMTP id
 2adb3069b0e04-56262a40f6amr2161481e87.7.1757455460118; Tue, 09 Sep 2025
 15:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-num-v5-0-c0f2f681ea96@nvidia.com>
In-Reply-To: <20250908-num-v5-0-c0f2f681ea96@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 10 Sep 2025 00:04:04 +0200
X-Gm-Features: AS18NWBzPuHqngmTpgXNZpIRD-OdqL2Y5OEaYpGUN_Vn-7watZfMYtmQRtqbWzI
Message-ID: <CANiq72mYzgx0dB+yO4BFBRCNEKBcONx56Jp=h7HKVXzkbRn_Sg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] rust: add `Alignment` type
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 3:26=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> prerequisite-message-id: <20250808-falcondma_256b-v1-1-15f911d89ffd@nvidi=
a.com>
> prerequisite-patch-id: 2439f5f9b560ee4867716f0018b5326dcd72cda3

I guess you had this in your branch but is not actually needed, right?

Cheers,
Miguel

