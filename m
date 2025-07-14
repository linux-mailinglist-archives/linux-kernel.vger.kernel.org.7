Return-Path: <linux-kernel+bounces-730670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10229B047E8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5E617C2ED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBD81FFC5C;
	Mon, 14 Jul 2025 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ON60AI2Q"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A329A41
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752521519; cv=none; b=kF82t8tD6YAuIuZtK4Ft1VRn+sw6sq3DnOSUKDtxq1jdxgIzHLSBQp8R7T/oOyUztGVX4UWioQN6WZ876JYJhqGUQq02I2Ar6WIvU/q7XCs4UzoWRwim8XlsiiuAYmBhB2egUbuUcH/0EHpPxH5HRhnnu+iDiMk80yAJNV8l0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752521519; c=relaxed/simple;
	bh=zLrbypOrzR46GTL8Pt/5KkdnLKETdTLW70b15jUQbUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JScaQg31fr48H2euZavRII4PKWY5M1YGoZtgl5TwvAx554+8ySJ5NgJkiDHT7b+UzRvLSZZvJckmlJh1WxNuyVozRSOSJhu4mQ63getNhiNpbnLsYWfemMZ+ZUyfFlDGZySldAujphMl/DDtZ7DzDZj4RcJlGrgtGvJLbDIoGkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ON60AI2Q; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31393526d0dso3371834a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752521518; x=1753126318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLrbypOrzR46GTL8Pt/5KkdnLKETdTLW70b15jUQbUA=;
        b=ON60AI2QfGVXeqaAPu5KaqfxLU+TjHLbXUFhVJ9+QnKVJOHKEtrlTNOOvUo9gcBh2x
         JQ6MCt5GVHv2V/jDShCr+OfoL0DzAH/Lu1N59kQfYUGG/X8mx0JUsS9gGAT2ftWJ/GWP
         eoB+SF4fhTTDYVwLO3tQtnQlOkCNepOAMveknM+rqFYbBq+e5WKj0RZtrgP+WZz1KjwP
         Q5oTazKsparBEeO5WhalRvKDJa2PPhxcphRYJiZ+3UY8JZGC1cYexqWRe5DQHcLh2yKC
         FDmH2CfC5Q+D3WbsNaP4Mn1SwUzOhFIOYjAlu2Z82w1IpeF33aFMP66U9zOzA7QFwmXl
         rtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752521518; x=1753126318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLrbypOrzR46GTL8Pt/5KkdnLKETdTLW70b15jUQbUA=;
        b=Uzis1AZ9bjiCwU9dnGzSyQJFxcUwPE0UKAQPrrXjGRP2Y8eVdqVCAajIHuKPRwLkEA
         fq/cqYHApjmHN3j2jqGwarFS9K1JJ0t5Dwced9Q8cVkrIqH+Yl8yqG3dE3pS5cb4kH0f
         szy+jzb0+epC1FKG9feynXgetYRzDDu1GHJu0qUF9vGsYFVtaC/2FyItVpj5fw/4Yu5A
         n39W/v7N+KCOFGDWRv/6G6HYAjUb6dQHSOClX2xHBFqS/eWb+SlWkGiMmB+FkOKMPb4p
         OnPF0RItqbFocV+8UyY+bLkKb/NjHIuf80LeWM4cX1Y9smnknu255Nv3hV/rwmvrYaSH
         lXRg==
X-Forwarded-Encrypted: i=1; AJvYcCUkDslgfBJeJzFaY4pq5eewbYutaFxfH2reWb3YFSs2B9bHHhrZ5qx13DDgrYLQ5Qk4r4yhsViUcXW4wmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNIeEzmwh//U9xIc/F+u0JVFk6r81+2A1vLQRE2JNnYBp0IgUB
	0TtdDl7CAJbTaE6JzB8BB8X7b7HhIBvjXpUJ1ce0jjAUQLHInmEeSxgR9yrsiqwgS6BQSLPmHla
	OzLPkJv0zahHtUJNXiP5maxA8lA8N9y5GUFVbMgRD
X-Gm-Gg: ASbGncvDDKW3UEo+pFknxRi/vflhDgTjNZ/YztSzvasIdvmdIHjFYQqUeXegTxLr6xy
	zogFInteRy9R5OwQ9nBAcmPaza2HrWLQHVaEhkDbyMhz0eUSvRku8WnknMxI159gkG07BbJaEn8
	jqY7wFw03mLVHiCyHk75MXuS+F+MBPE33PYnHu58WbMsDfKfhEmCOpbD9KKhk3Ib5+NhMlucoi9
	ZPMTXuI
X-Google-Smtp-Source: AGHT+IEDsiYxX3feyKKPWzR2t9muyDoNO4YK4kUIFl03g6sLc5hPJWuyzDuLWzJTAUc+YNhH9AD5VTE4+VvICtNKxQo=
X-Received: by 2002:a17:90a:d88e:b0:312:959:dc4f with SMTP id
 98e67ed59e1d1-31c4cc9d4f4mr21733366a91.5.1752521517702; Mon, 14 Jul 2025
 12:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714-topics-tyr-regulator2-v8-0-c7ab3955d524@collabora.com> <20250714-topics-tyr-regulator2-v8-1-c7ab3955d524@collabora.com>
In-Reply-To: <20250714-topics-tyr-regulator2-v8-1-c7ab3955d524@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 14 Jul 2025 21:31:42 +0200
X-Gm-Features: Ac12FXzQIy3omIUEcNHlxi_83F8sPIeBn9e-6qbpPK1wclA7WZXBKCaASY_2_mg
Message-ID: <CAH5fLghT+wkrKr_2oUQg3EfzZP-ahYDsKtnLcZbeZn6gj+hgzQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] rust: regulator: add a bare minimum regulator abstraction
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 8:52=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Add a bare minimum regulator abstraction to be used by Rust drivers.
> This abstraction adds a small subset of the regulator API, which is
> thought to be sufficient for the drivers we have now.
>
> Regulators provide the power needed by many hardware blocks and thus are
> likely to be needed by a lot of drivers.
>
> It was tested on rk3588, where it was used to power up the "mali"
> regulator in order to power up the GPU.
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

