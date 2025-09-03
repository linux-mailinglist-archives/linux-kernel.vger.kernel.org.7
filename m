Return-Path: <linux-kernel+bounces-798286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595CBB41BD9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA5E87A5237
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4748B2F0C73;
	Wed,  3 Sep 2025 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vok1qK4R"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205EF2ED84F;
	Wed,  3 Sep 2025 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895315; cv=none; b=EXDm95GfMo3Ece2FuVjUDVHWcfxj3F9MMlU+g+Xyc3PyIfIVZuw8e/KF5coanUupJyeHwR+BJG+RmyD7WZYei+abFdAdUIr20y16L4N2ouVgdPbT0SbMj1E937IGUm2ZRklOZdZQYnBjSxAKPg5PY+R9nFbA+LVohKNdIVAc2vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895315; c=relaxed/simple;
	bh=MT33R0JtPbGlbxTpxLWmtl9dyNYq9ekSL901r3ltk28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyC2KAkD4nWRnUepXfpaoLxaE9NxUs+HhckFi5sWNoWfRQqYuGS+OApc4WwgcTJf9TO+aYHYBdmNgRiRj1snXy9q+Vevx9eLFbpCNwdm9wdEHfYxhpPfWozgddsm0PQxZQP1gC8ZKy1Rdxkg3BU+DNtK4e2+Op9PYeBajYO18Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vok1qK4R; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24aacdf40a2so9369165ad.1;
        Wed, 03 Sep 2025 03:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756895313; x=1757500113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/5sRARH/MrxbC7CqhPIy+nQvt4VVCRT77w8qNlk6QY=;
        b=Vok1qK4RyMtHu7RYB+2WLbdSwjaxdN7LyB4yRzVJ4xWdVG9lv4ZYnfGPMrIw5p7FBF
         XkYzfStrnC6T2p706B2nTUEWynDfuiBuZmLqiGCWvmuDLliosWG7ugdaaVwXoh6aqT0O
         ySazH9riRj/lpXS1gjK1OUGolxD50lGptsIho98NTyqd7f6AQdE4Q6lCwULx7v7qWPsp
         9hWmf9/2Q72R/cnGn25ItWQRXuL+lAsiupdUQV7vOx3pZW5GZfiUsnw0QACnFaS5hdc4
         7FiTo8IwIFX1RREi6YGYnbWmDTGJQepIudF66v7PSUNrX8+FwsM8HJkPCeB8AYRgG3qM
         0kdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756895313; x=1757500113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/5sRARH/MrxbC7CqhPIy+nQvt4VVCRT77w8qNlk6QY=;
        b=Yo8KcezuXZ5FOrLqLMjDjd2rL9ea8T24ecwAvSdSWsWTNoeUX3KNDu6IfzRl+NiaYe
         LDGC9bi3SbhRzUTZcPnHtU1h4NWlVHcgHs6UWTlDPtpdK5ExUMww0cDZUxcp7iuXdA9v
         CaPaZ7Ou0zvYCVK2IKUClzmjyyoZ5ClSLSnOeBwgqa38yJXAn4SS/fKisKBvJ5XDDEc/
         i6FCb1s26ul3KNz5AbvM3xQTq9FrW1c1Y34uOz0uuti5pY8MK/x5Ue8aV8G9Ybvq9a0g
         Y0Bma8DKYF90H1klorNpyqA+nvNO8MDGHZEBm50cSWuw8ZMVeVSEmdd/Q2BRS8yXvaxA
         KHCg==
X-Forwarded-Encrypted: i=1; AJvYcCUw7Tfy8vWb6rDUXUCqzhLVN653ECTmm7dUlS793DcMPtkvh3jBs4iagVlzI6VzyCb/oSc5tUPtaQUKK84=@vger.kernel.org, AJvYcCWZsfQjI9ECFnoV61ivw5lRJRbaRid+0/6IDK48iEVSzy7EuspelkZwyq13PB/8lo6NlquOgC/R8Xm27DkBiqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF1lexfgz4rA7XkpAWX0vvX61LyM7Q/58TW+p2Vxv3CjEUe1Sj
	IKU9777/3Lgvz/kij9/J5nRmA0e6Ff1TG1NKvD4YX8yY1TviCXCGR2gllagCTIhEpK5FpPqHvXb
	LYTD/QG2UgRInNLd6q47bu01uWwRqorA=
X-Gm-Gg: ASbGncv2RKHqWS+XkZYkqLC4b0HL3jcpKbOwz2T/mCKnACtLC52WiK4Dz3QNlCy8uEe
	hHowk/5IaBx4Tfo4sisdoCmdRlXP6ulD7o5fZf7R8dLN2ccRhfnkoHqIno8el6miy/EOMqbAIoX
	8vxHx14F8AGDK3DRmyk2mBBYCDbbYbEb4awW8p+qM9NoX4t3vxU2ZITAGF6xBzpCbsjuATZ6O+P
	ehhCEyN7U2Ilqoyp8adj69F4BtMedmSHmV1Crk5hPRf5oPfrnJe0HnenqXPA4+F2SJwYITvlS9g
	UPs1sykJFc+mUNOywyuqjLud5v7dfKobB4uJ
X-Google-Smtp-Source: AGHT+IFEKoh9Yoyy+qA7m2lg3d/RWinqGDyMV3KpWiUNfa6fSFU2oSwzJzlC58Z+3GwCct3Y994q9UEQVEUOAmf9XNQ=
X-Received: by 2002:a17:902:c409:b0:248:79d4:939f with SMTP id
 d9443c01a7336-2490fc97225mr123506415ad.7.1756895313392; Wed, 03 Sep 2025
 03:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903095315.15057-1-yangtiezhu@loongson.cn> <20250903095315.15057-4-yangtiezhu@loongson.cn>
In-Reply-To: <20250903095315.15057-4-yangtiezhu@loongson.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 3 Sep 2025 12:28:20 +0200
X-Gm-Features: Ac12FXySq6GpPGdcsnBaBnSmKXNhwG7-Ypt-SnPNuOd4ijDkvAUU0G7fjPzdayc
Message-ID: <CANiq72n5hg-ZyGV4oEca9iCbmQByanFUpNTkS=QmE1k8MUBR8w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] LoongArch: Handle table jump option for RUST
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	WANG Rui <wangrui@loongson.cn>, rust-for-linux@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:53=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> When compiling with LLVM and CONFIG_RUST is set, there exist objtool
> warnings "sibling call from callable instruction with modified stack
> frame" in rust/core.o and rust/kernel.o.

Thanks for fixing this! I have seen it for a long time in my CI:

I think this is:

    Reported-by: Miguel Ojeda <ojeda@kernel.org>
    Closes: https://lore.kernel.org/rust-for-linux/CANiq72mNeCuPkCDrG2db3w=
=3DAX+O-zYrfprisDPmRac_qh65Dmg@mail.gmail.com/

Perhaps consider adding an example of the warning in the log for
future Lore searches:

    rust/core.o: warning: objtool:
_RNvXs1_NtNtCs5QSdWC790r4_4core5ascii10ascii_charNtB5_9AsciiCharNtNtB9_3fmt=
5Debug3fmt+0x54:
sibling call from callable instruction with modified stack frame

> (1) Please install rustc 1.78.0 (without annotate-tablejump option) or
> 1.87.0 (with annotate-tablejump option), do not use the latest version
> for now, otherwise there may be build error:

Nightly is not a released version, and it is expected that it breaks
from time to time. Even beta may break. We are ~2 months away from
that release.

In any case, I don't think this information is related to this commit.

> +config RUSTC_HAS_ANNOTATE_TABLEJUMP
> +       depends on RUST
> +       def_bool $(rustc-option,-Cllvm-args=3D--loongarch-annotate-tablej=
ump)

I think this may be fine given it is `-Cllvm-args` and anyway
LoongArch doesn't use a `target.json` (which is great!), but please
double-check reading what I wrote in 46e24a545cdb ("rust:
kasan/kbuild: fix missing flags on first build") just in case.

I hope this helps!

Cheers,
Miguel

