Return-Path: <linux-kernel+bounces-815167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA67DB5607C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 13:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D834583EBB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 11:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C442EC57E;
	Sat, 13 Sep 2025 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfyd7Ffg"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6002EC565
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757762980; cv=none; b=BqYsKgVyV7MLtUMu3LrOxs+XWlwy52B0oAXEO5hmB3P3qcInsLUlw8qNxQy4RErtIbJcaZ1UKKH01w4LK22yy19PmevVBRvPkujdVhIlCKkxT9kDS2FUAnFfX3O0VYnnlpa0Wc6T7UaGsbxiMRe8ZV4Ys2mHJYzL4zL2JJCqScs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757762980; c=relaxed/simple;
	bh=TYXbLO+kOKJUzkyQuk0TWYQxWbv9RVNrgbRkhz69Gko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YsLOkOfiY8Zs4khHb/epweoGThxXgN42+qT5Yrv4orwc4ULAAE7Um1s2oy2hXHKHz/8e41kbuhxVi6rMsXz9gMoWMINcVdhtjHo8ZvMW6iwCfQAskLkPzwlxkENRLN4CR4xP1NvlIxOwjb6L1weTt54ESRpqgNlh/3pGkZKD7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfyd7Ffg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b07c2908f3eso267341966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 04:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757762977; x=1758367777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMMoSzCc5h3tOZ4YYR+aO/iNO1TdT3TVeZmWGA5I9nI=;
        b=nfyd7Ffg1nUmto4aL14FZ2/3q8E4WGdJT9FHeCnIVfkwJergzzv+ZlabR+KAxFV/Po
         PMJkhKy7aNzYYQYApXn8LMwjxlq7BrAf5bWEnDa/nNjbDMIRy2j5aQmCZLdLAUlQ/k55
         MDlTyk/CkEsNmp0E+LDdVXJIt1GbErMbeN5egVyoIhlAVQVKj9J7x/OEWG2hQ03DQkJn
         Bk1EMj+DZBYBSNCpFgwFR3nzDuSxTE9NZ7jIynxZVBASARfgJoXX/XeElEDCQRu9KpdJ
         y34rVnVMwQkUZPe5KJMOiswKpKLbR2EGHe1P253ZsL225/YwhReeeBt8ey6zwzCpQnRv
         9ezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757762977; x=1758367777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMMoSzCc5h3tOZ4YYR+aO/iNO1TdT3TVeZmWGA5I9nI=;
        b=rnbik5K1HzBkeucWXkkCLtzuB9dZVI0AbzK4xFMUB4TlY4Nznr8drKHaz3nlOzfHmu
         IiEQNdhF2ZDMQlJt54TvrTv1XuVhCufahFfNReLqyJkbqsj4jRazhasZPBl99CKM8qkn
         gfXAkFQaH6xJdsiOPvAGQkl7DCU1cl3WF20kpZGExIQn0kZIzYeE9RW1v544jV+m4b2z
         yR9r+QOFPy+3ubQq4Rs6JhoQuJuFs0D4ZFrmD9mORjCn89Fg68C/uWSHti1C3UHENxjr
         bZftpGVIpEVm2F+gmX/dOq/kWLQrL4ZhDcmMLpZdbE+dF+c6prVQBFHAg2ohsOLy0hfc
         c6pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWuyRiNXV7hjKHcQbMTdmWacBrYooO0AKDqdqEv/SJQLgE8DPulFQBOjDevwDUdP1lf74r7olxeL69VFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGoQLFTMSsMjKZtyLhjIdnLJKvBHImjx1wQ43Xqjxn8nRVZY2Y
	2o23za/VldCBcRz84y1aTIUlesTp95HaHD/I3y7lX5CIUhwcuRhBSzhF
X-Gm-Gg: ASbGncsLwU7CFf42LtqGvqzR7xilRwgwEsI02RDQ/YqYxn9Y4mU8jsntu6ccuhaOmDw
	rqxuG6bUKwyYNf4mtP8q2Ubft4bj5ZvZyhiB55CLp9Pd53Q+m/mFNk6t5uvYqhu8b/Qj8A3E0Kp
	RbKKY4i1PyqeUmP80SKgx0Jm+e1YbU7iAGsob20Dm36V6Js7QQVwqS/n0KI2OVM/qNQSmKR/J1a
	kCvHC8Hk6Q8R8hFpXTZkrF3KzzZMjr4nOJWCxSy7qFDgyYynTkKtrf2DFnEb0q1undum+AlMqRS
	rno7WbUM8PbriFcwTdG9/QcjJ5J9CnN5tyrFzO3HmnukLABSEm8DredSgjKeQSkuMFtT3AmAAom
	PLjaEbaY7jlmtpA7I2/Rws511yFPqaT2ve4TY2rDWaYsRiInjkqjryyY=
X-Google-Smtp-Source: AGHT+IHjrg9HhMV8KoVTmQL6sNcOl2lLDDIPwEcS0bg0jeSuB02uw0MNZjGq45peF5NvlyJozkp5Pg==
X-Received: by 2002:a17:907:968a:b0:b04:a289:7b with SMTP id a640c23a62f3a-b07c347f8cemr599471366b.4.1757762977003;
        Sat, 13 Sep 2025 04:29:37 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07de03d93csm167035166b.12.2025.09.13.04.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 04:29:36 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: sun55i: a523: Assign standard clock rates to PRCM bus
 clocks
Date: Sat, 13 Sep 2025 13:29:34 +0200
Message-ID: <12739001.O9o76ZdvQC@jernej-laptop>
In-Reply-To: <20250913101600.3932762-1-wens@kernel.org>
References: <20250913101600.3932762-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sobota, 13. september 2025 ob 12:16:00 Srednjeevropski poletni =C4=8Das=
 je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> At least in the initial version of U-boot support landed upstream, the
> PRCM bus clocks were not configured, and left at their reset default 24
> MHz clock rate. This is quite slow for the peripherals on them.
>=20
> The recommended rates from the manual are:
>=20
> - AHBS: 200 MHz
> - APBS0: 100 MHz
> - APBS1: 24 MHz
>=20
> Since 24 MHz is the hardware default, just assign rates for the first two.

I think it's better to be explicit than assume. However, this is fine too.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/=
boot/dts/allwinner/sun55i-a523.dtsi
> index 3aad1b909501..5cd6ddae86c8 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> @@ -767,6 +767,8 @@ r_ccu: clock-controller@7010000 {
>  				      "pll-audio";
>  			#clock-cells =3D <1>;
>  			#reset-cells =3D <1>;
> +			assigned-clocks =3D <&r_ccu CLK_R_AHB>, <&r_ccu CLK_R_APB0>;
> +			assigned-clock-rates =3D <200000000>, <100000000>;
>  		};
> =20
>  		nmi_intc: interrupt-controller@7010320 {
>=20





