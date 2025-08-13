Return-Path: <linux-kernel+bounces-766154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFACB242F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EF4165FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAA92DCF5F;
	Wed, 13 Aug 2025 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYNS9sMr"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721B92D73B7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070859; cv=none; b=I7yXgoulRQaZYpB8dz+wsogxUTHvN1JNGOO80iyJ8p3dBHYqy/qVI4aDRhXaXKdqto+UyJdD01YCE79/5HSz9Jpl6OP3h6fX3fJeIMPgt65N3RIxA2WLLXBdaKaBuxHkPc1IZ56dAyq54u3g+FHnAgP/uEiulelAjeFcTKo9GS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070859; c=relaxed/simple;
	bh=c9Ccc4FdRlKahKVue2t027gTXn3WFY4nUn/bdTfbFWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsUdTjB0MYzffJDqkvWBMfEEsWITCV9PXnHud8BIFuf1fm+XkeBpzuoTQMGcXTORKUtqbzZSirblCumLMfoUKr57lsgnCUaJXLJw9E88wRaYfWto/RFqf8mavj4EwtaQZezZO0lI5AeEvPA73qI4YNacvFZ82W+ujjvS8AYpE6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYNS9sMr; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b79bd3b1f7so3025503f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755070856; x=1755675656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9Ccc4FdRlKahKVue2t027gTXn3WFY4nUn/bdTfbFWk=;
        b=oYNS9sMr6a1jozHeEjf+SffWX8dSDvJxiFp8QIjNJr1EF9wwdkZQsblYzf+SIU/YY2
         4bxlhy3CpnZy/s2efNbWCnwrZeR2q9Ut1aWWoZ+TKwEgxVjN83WTgir9MozdhVEiopO8
         rf9S8FV5MgkKwSUp6zIo0999djvYEhsmEUvJUj65Zyp7aG323LL5AfelEN8METZ2t7P7
         WLruAOqR46oDWgVfGl78cbp1WyLUOmcVEUcSbk6wd7uBNflOO5KpmTezRTFid0QCFlha
         XyeLFPxICKNonexgxUOSBWkUURyLDjbiBFzhTyp3Bqeu067/Sy+3wqs/4veTwsL6dE/h
         LYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755070856; x=1755675656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9Ccc4FdRlKahKVue2t027gTXn3WFY4nUn/bdTfbFWk=;
        b=KXyqJRClAs25XqgyjrV3/PSlfPS6NE95mBAl8B4wl6ExZWrmBjVfC8IWtoz6RjSS2g
         fkvG5lOGNH9Kp9GpL5WcfWXw3Q4gHzKObizrOzWq1oEagE+PaOkuH3Y0nkD3ucMYIcEM
         bMenDJqzgo7Lo4Q7VITpuN6XjD37RnROSRtQuQ7MgrJMUZShh+HpX59bQkm+96gkr7RK
         5uwIKjpCcPYYyN9QojwKkxaSGI0ybOt4oWAFUm65xXJFoHaI7uhnjU/Ulmntt2Bbga9L
         6IyK4KJbNTGr+H37cyJbuoYy08B8smd/jlCr+aKa+Be4wz0hiKwLboESLOQAlEYkof5v
         41bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlT6Ev5c7gbx83GbriWrOpyQ1sD4ATGEdvNoi2vCd+3S5ivstTAPx4OxS00c/D9ShsB5CjxY2VOo27P+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzdi5f03eg1rwZ1i1Iol1foYmRtHN8jgN0upyvcez3iYAja913
	YhgZTH8AHYG16rT11/z4AyRUYIsfzKpkPfmzr1UYqW1Adj35BbI7ZG9NUs2h3WYCWUemyt2TIy6
	7yt8I7uOGSEOT1982vsdPc/YSYyGI7MqjzLkYd7jv
X-Gm-Gg: ASbGncvUABJBhIOOw7wJ1MDr1guifV9GwFErsR3Nvj0pZUhp6C53xTwi88MNxE3tiOj
	5jeafSaarAUxTpNX7Wy4yTIPcRYYxE76l89tFeNDm+6yEx5fxAwBb4GTjVmYMZCoAv8C1W4rNH8
	p5xyWMDJkc3EhtMQUzkUc7PCILEcExyvY6nZMYVxz7zhTfW/aXU8wCA00rPat48nNGbk4PahOW3
	uNluAQ8FPzMRCXGFys8J/doECDU+cfucVG7ImH3JvaLvOuqdAXdfeK+FDo=
X-Google-Smtp-Source: AGHT+IGGtpaH+it538UfR2iaRDBz9X7fJpT1gAY6RgW0EDKE5fzEZ79ezay15oRdLHx3Xf5OdtuQ3FdbihxaglEAAsY=
X-Received: by 2002:a5d:64ca:0:b0:3b7:8fc4:2f4c with SMTP id
 ffacd0b85a97d-3b917d2b0f8mr1196666f8f.1.1755070855659; Wed, 13 Aug 2025
 00:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812144215.64809-1-baptiste.lepers@gmail.com>
In-Reply-To: <20250812144215.64809-1-baptiste.lepers@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 13 Aug 2025 09:40:42 +0200
X-Gm-Features: Ac12FXx8h4Xky-40CstbMiW32Dc7_qYQSYrfMREs0zT_bsEsb1sqx3OupPHpEcM
Message-ID: <CAH5fLgg6eFYZ906GPFev_nha0axsUR71yC+En4X_fMjSn85UiA@mail.gmail.com>
Subject: Re: [PATCH] rust: cpumask: Mark CpumaskVar as transparent
To: Baptiste Lepers <baptiste.lepers@gmail.com>
Cc: stable@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, 
	Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 4:42=E2=80=AFPM Baptiste Lepers
<baptiste.lepers@gmail.com> wrote:
>
> Unsafe code in CpumaskVar's methods assumes that the type has the same
> layout as `bindings::cpumask_var_t`. This is not guaranteed by
> the default struct representation in Rust, but requires specifying the
> `transparent` representation.
>
> Fixes: 8961b8cb3099a ("rust: cpumask: Add initial abstractions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>

Only during CONFIG_CPUMASK_OFFSTACK=3Dn, but yes.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

