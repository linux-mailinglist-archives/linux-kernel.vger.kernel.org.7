Return-Path: <linux-kernel+bounces-734917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F157B0882C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08683A457B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB864285418;
	Thu, 17 Jul 2025 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGz8+Z0R"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E31F9EC0;
	Thu, 17 Jul 2025 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742024; cv=none; b=j8F+33napE5p3mm39iOEPHBhW3FQEbHqFlQj2ITOg2gAeDeFu76WmVgyK+W0WzGKqliG8UfF0uiyyMTbvzWUcY23sasLq3KKvsTKlUm4Sqw3I+54Yp6KlY2xs9CMYijC1Ee7UcJ41iXIU5oK7pEYBYnxMNKh8HQbDI6FDTLTeeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742024; c=relaxed/simple;
	bh=SoZi3uH4bM8ut3s23CSSIKzUfpDb/RYJxJSCVL7F3f4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRHW68sRLWj06UjlQP+WdijkpzbsErSVEqPxQwQqXPmuXEgSbzsUmXLfPTt3jpzg+nuVjlUhDhTaHCyaguTLzvc8tyZl8QnQeUGFHbtw+5s8wNApM8jdaJV4V7HVD2UUfeyqUBNrfkJ1TRntwW3JJLk248YbG3jwmEDTvZ9CbX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGz8+Z0R; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab63f8fb91so6825801cf.0;
        Thu, 17 Jul 2025 01:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752742019; x=1753346819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoZi3uH4bM8ut3s23CSSIKzUfpDb/RYJxJSCVL7F3f4=;
        b=eGz8+Z0RMA5AIAh5fIt/cMmUZQCUjX2jAfw6hzu6R7ECe5s73t1WWGMj3nxZC/8Eqw
         9QSk91Tg5c7z/D1R21ia8FR0qxd5ADPogE62b3uTYWsGfZjRy0/45nrcevuxzCE3OhoT
         KcRylI3OgqygsKX1pyjkxWQFhOJ2HFrHUFvx/rZpLtIeCs/W6/vezw13hDidm++nktHN
         SXWVOJkegmNNe92mUeZVSlltS+xrKX/yRHjqYBAoDircfEPM396ITCQzXgL7CcfzWI/F
         63PAgDRFE30ZCjlqXu47DgMofFx1ijtEZX+1TWLf7ejJwIw/AsHxgWwAaeAOqvTLgnuc
         y6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752742019; x=1753346819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoZi3uH4bM8ut3s23CSSIKzUfpDb/RYJxJSCVL7F3f4=;
        b=g6os2MGZrowrzscp55eJemg3MItY7vZ8waTFT+lXZ7GIOWzAexyp1ZstcD8/yKwFtO
         5jqXAq/GE62sOIq48N1u6W7RV/dM341Mb0ErvmfR1vakUg6LyfNeh17/wjjvkxPRNFfe
         vA5wt/C3Th78EJEMW2SF3wX+VgoSlH0YGejvoAAUzjX62HiIhxLLKUMhrLTRTOWlFynF
         4nTGxMY1SC694a84mKQNFsR8Dbaxe4DBK1IVPdWSDaczI+dLBSBgCpgHL1h4h+/XBRRb
         Jc/eGygTjW7ol6ODSLJOdupt6MIjS6d+S4Qs8NYEl6zhNzpkngWEeoHW59ESNMKQUk+/
         djAA==
X-Forwarded-Encrypted: i=1; AJvYcCWDBbA7L0ZYGw8K+TcCwMbOUHfPdIa/JxhRm2oRsubkY0pPGJj4/mYdTRyyVR7vSZr8Qse/7m7IMxz+I2VF@vger.kernel.org, AJvYcCXQA3pdK84nghYUfFbnM4JMb1VTws85/t7pYml6RUVbS5pzWI2BubIKpbkRK2aT0aY8GERuuMgvlffd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4xj8GskFxoXxMJH2+OxxJBsW2ZeNoBQVPYXLbBvEXUiHkG1Bm
	mlWDKcJkC15QxTcybal3pb0yiwmKNOMmhvZnOb3L1TCa/kA/YPYKGCK++BsM0ix4mET4V1GZcTA
	W0LIQ5SlO2KAgSAFNtVIEebWVTJwPRT0=
X-Gm-Gg: ASbGncvXi0rQ/GZRn15QN8WzDSNwWvOPLB01lPfx4wohuPjTevIItnRL+vBMN0Vcgov
	8C6ch7ZFw60J1LPlymHvlGGsUHUSxTNnuNoHdBI3c2ItYTV6O+nkYGA3dCptZD7F+xnWs77GYLG
	evCiGgrNClKgxP346MAEGpS1Qp/EOLEamy4DlGKU4w4Vlx3VkBCHfP9hKmn6X/6EJ09GIZ58CBM
	+PbP73pkOv1YyD4
X-Google-Smtp-Source: AGHT+IHjj5vn0+lqcDlxTyECjf51uWo+wHz/e3GDdA4Lfz1XnPAokoHWuCf3MPYFpyI+USr4C4GDng9B+wsuijb5spQ=
X-Received: by 2002:a05:622a:228b:b0:4a5:912a:7c64 with SMTP id
 d75a77b69052e-4ab93d49434mr62145001cf.30.1752742019019; Thu, 17 Jul 2025
 01:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b6f8f705-f661-46cf-9dda-6f18f8658622@kwiboo.se> <20250717070006.192765-1-amadeus@jmu.edu.cn>
In-Reply-To: <20250717070006.192765-1-amadeus@jmu.edu.cn>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 17 Jul 2025 12:46:47 +0400
X-Gm-Features: Ac12FXzqkgYPLwPzfI0Wfzx3xJg_aHq911YS94XX9w26rk3khvCHNvT0xMmUc6s
Message-ID: <CABjd4Yxz=mrNpqgnHSgD0tr4ALH3YW9MvLULES568yHNFiPB_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: dts: rockchip: rk3528: Add CPU frequency
 scaling support
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: jonas@kwiboo.se, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	heiko@sntech.de, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	ziyao@disroot.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 11:01=E2=80=AFAM Chukun Pan <amadeus@jmu.edu.cn> wr=
ote:
>
> Hi Jonas,
>
> > One possible difference here is that the actual CPU rate is controlled
> > by a PVTPLL where TF-A will configure a osc ring-length based on the
> > requested rate and Linux only configure the regulator voltage.
> >
> > I have no idea if the configuration made by TF-A will have any affect o=
n
> > power usage, but I suggest we keep all opp here because both TF-A and
> > Linux is involved in configuring the CPU rate.
> >
> > The measured rate can typically be read from a PVTPLL status reg, it
> > will be different depending on the ring-length, voltage and silicon
> > quality for the rates >=3D 816 MHz.
>
> Alexey suggested that we remove 408MHz, 600MHz and 816MHz from the
> opp-table. Do you think it is acceptable to use 850mV for 1008MHz?

But why 850 mV? Vendor .dtsi [1] implies that chips with leakage
values of L0..L4 might be unstable at this frequency with a 850 mV
supply and need 875 mV instead.

As long as we don't read out OTP leakage values, we should pick a
voltage for each OPP that is sufficient for all possible chip
characteristics, meaning the maximum of all opp-microvolt* given in
each OPP. This will result in higher -L* chips burning more power than
they have to, but at least they will be stable.

[1] https://github.com/rockchip-linux/kernel/blob/792a7d4273a59e80dafca48ba=
11438f43a6d8bda/arch/arm64/boot/dts/rockchip/rk3528.dtsi#L268

Best regards,
Alexey

