Return-Path: <linux-kernel+bounces-871196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0A7C0C9D2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8CBF3A405C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F8D26463A;
	Mon, 27 Oct 2025 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRRDv1lP"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544AD258EDB
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556478; cv=none; b=WVRMKwxYHUs8Gj1892HCbdrN3H6GmzNZgPc9LyxU2RUn46ofpTkSSpK6atUrRA2L+h/cjBxMGNucl+gF5PWEY9ymRgbOHiuRBgUGjjIzF2vDeZA/xYdSunTvwQvmNcmZyDhyi8dUUMhc9rOX2iKSdTDgVLOicuUX2C8gkyG+SWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556478; c=relaxed/simple;
	bh=k3ckgEiSkq+y7z9usMTBGQkVGgGdig/5c1NbkqTAlEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4ALCMH1JTmdIL/uT348wKK4QCL6dFzuUc9unIsihDLXq8DbZ3GBs9OXqQtlPSR18col71TDxjOhYLT4mPT4yjl0Ux7t/YGjhieaTanpPifdb8U3TefUXD1YVIUoChxjSWdEfqEswWXp8PLX2fxNiVzJTWpVXhSYVpjQHMOT9Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRRDv1lP; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4eba124d189so25624841cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761556476; x=1762161276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3ckgEiSkq+y7z9usMTBGQkVGgGdig/5c1NbkqTAlEY=;
        b=CRRDv1lP8cH6TlSx5KFFbFzIyaH3no4/hU0KuR87OQrZ/988ItqS9oWN6Q0ZWSDbU/
         SBuoqxBvGUuloYbV1Ri4eK5irPspYesW45ywyabPDHVwLwuvspYfCAsN/GG8QXuLLlNB
         ibreo0M3+eG2FaksDW+5IvGY6tIzrZFufCdx1FZX/C9639j4YQRxxU83U+okp28Y3/Rv
         X1v23fPpg84vW7VsgPN8u06wBeZXV0TL+pT3uLEi3ENx+MM0BRGgIg6cGTumM/ZW+DfT
         jzyBIkHgncdxdtzx7967PF5aEabBM+kbAEm5DS0aS4t3YtTQRp2rJkK7Z39JHHpejAMB
         S3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761556476; x=1762161276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3ckgEiSkq+y7z9usMTBGQkVGgGdig/5c1NbkqTAlEY=;
        b=byefIRhQs2jPe9xLXwUY+ExM7E3p8oZ2BwToypJ0ey9GkKRCaZPi8ypeve5Zu7SstI
         RdMgFMzeNwYykIcmnky+YpK5adOrvxyKcSPzVeR6N8X9CDlKzzP233dc+YMPBZjykOaC
         ZWmYdzxgTKCtrIgesNujXSOd7dyg8sT9OgHte+AvCCMPGw5obuklry9xS9W9ejeJnoij
         vTebkZueW7JZTsD+9ex7j7TAri6g2EyYX64iO1p7EerAqAwF1LiB1bzXq9IvWYWxbBTH
         MWTGt8FvfwshDyiUATPSj3vTVW2lOxfA4TJVnl3WIbRP+ykKxlCFwhkWGbaKN6wB4+jZ
         CnLA==
X-Forwarded-Encrypted: i=1; AJvYcCXr19IlMGIe5UR/dp82E2ejQXtV3qLbfyaQkBjdRzyM2q9O1sYxuiLhatpN6cN9A0BApue+BJ1xbAuHae4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu1RAlCh4MzL3R3pMbG2UK4pP2qw8zQybg68MtzbbDGDZBW3HS
	gNt1QzZDw4yw1NLPBtkRMX3A9RR3JB23e0nmYHzVu8s0VlX4TFLfdrRfm5NEoFtRWf+DoojEITJ
	L1Wx4xAhMtb1s2M2ehzHeKibzYd95hQw=
X-Gm-Gg: ASbGnct7lqzvzx5HFYSZPC6Ow1v1spDKzpCQFLW0xVQXzz20NiWnFP7E6feL9sSRjec
	nO5u1LIDiH5m1EYqyuiV3Gz12mXq2RV1NxcF8DdgJqJohAhVOylYPB44D8XgHIk0XCtkAS4kxtT
	8bM4EnYKgg4mLWLV4usOEwq7MtJ/BVYJh0K4JE/p/eFsQz83/+DxgrjN8/m/i+VhR1LKRv/01/y
	ZGV48dZ0Nrx6tAU+m9w2azro9P1S94H67e0RA58XodYooLWhEMLfeypXl3ZRZ1FWE7xCs7DtbTr
	5hkg2j5cfgXxJfDQsVxP/HzsFIUu
X-Google-Smtp-Source: AGHT+IF/2QvCzE1TEuKomhBiAScmROMfTstvpHg7L8JdAeBZ1CrC1wuEfqNsUGGYV9Dp9piQXEYqMgRlhzJKaaFXdAc=
X-Received: by 2002:a05:622a:d16:b0:4eb:a2ab:4182 with SMTP id
 d75a77b69052e-4eba2ab4738mr100138481cf.22.1761556476187; Mon, 27 Oct 2025
 02:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026194858.92461-1-sigmaris@gmail.com>
In-Reply-To: <20251026194858.92461-1-sigmaris@gmail.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 27 Oct 2025 13:14:28 +0400
X-Gm-Features: AWmQ_bny2G__jDeyWDUL9Y-J8F57fNDWZftO8M3HOK0HvZdNg6brhmmHAL6LiRE
Message-ID: <CABjd4YxsfxwEbic8QEabX1h9j0B3DBw9LWwctJx7SzdvXZdDhA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: pwm-fan overlay for NanoPC-T6
To: Hugh Cole-Baker <sigmaris@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hugh,

On Mon, Oct 27, 2025 at 1:09=E2=80=AFPM Hugh Cole-Baker <sigmaris@gmail.com=
> wrote:
>
> FriendlyELEC offers an optional heatsink and fan addon for the NanoPC-T6
> and T6 LTS. Add an overlay which can be applied if the fan is fitted and
> configures the fan as an active cooling device for the SoC package.
>
> Signed-off-by: Hugh Cole-Baker <sigmaris@gmail.com>
> ---
> FriendlyELEC heatsink with fan addon:
> https://www.friendlyelec.com/index.php?route=3Dproduct/product&product_id=
=3D305
> Vendor DT with trip points and PWM duty cycle values:
> https://github.com/friendlyarm/kernel-rockchip/blob/4944602540b62f5aad139=
fe602a76cf7c3176128/arch/arm64/boot/dts/rockchip/rk3588-nanopi6-rev01.dts#L=
75-L90

Is there any downside to enabling this unconditionally in the board
.dts? Overlays require more user configuration, and not all
bootloaders support them directly (e.g. systemd-boot users would
struggle). Compiling with overlays enabled also makes .dtb's a lot
larger due to added symbols information.

Best regards,
Alexey

