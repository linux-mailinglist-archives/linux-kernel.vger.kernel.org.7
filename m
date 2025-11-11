Return-Path: <linux-kernel+bounces-895090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506A5C4CEB9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19937424179
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFBD32AAD0;
	Tue, 11 Nov 2025 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT8q/Fqb"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF43304BC3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855146; cv=none; b=dhSOiSI5qK1NLivEaDwR7nXapGaFqKXg8ab+vYBCk8CZZNcumTccTx4IVAbG3IWUXW0Oh3CFw3Yyvwg+Q1c+pe6sF0np+eLW8QvRcc+gr3aQuDeiele4j1o7lQgJpFWWWR8xWXzFcQSW5/d7gbROil0HkITOYu41/Kf8gs025/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855146; c=relaxed/simple;
	bh=lOCIaq5MYiqkjF7JN9o1JXdIKKWp75UQH8ZqzpRmiK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbewNM7PGRaZ8mDY1RxXgdz6LRDE8GOUIUxTHuOYQb2h+GMkURsq7TJ5QQTQWMNKej/uIsNesRhTqupwXNLLDotVuRHQp8x8yiwhI0qDmne2BuiqoXHind3rg17shvmTpSNQEemA5FReoKApd8t0z/UwXZaVYLK0N624suj7fJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT8q/Fqb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b2dc17965so2345372f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762855144; x=1763459944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjlk2cRXCuPrNRO+4Q+s712BaHBwWqkzdg7ZDqTvNUo=;
        b=WT8q/FqbP2eadLXthwJJn5z+xuQPjoCqwejuuerYPDyug3kui26cruq7aPMqlbm/aZ
         wWpRMsZyJ1d7WI3wRxoz8CAB0j4AcvxAz3+biCuNZ1mOIxt9XqCN3LJNRusMea8fNzTh
         EsSf4Np6r1KqobdEQzpob5ZV1rwqhGzLiJii21xrO0WeA4d1zOc/o1DxFGJDZY3grofU
         li8gqJlI9wX5MSRnXG2xAvL2xXaUUYbTlqj5+gFzPmz6M7G34BOgEP4VGylXtNMJ6E8n
         F3RU1rAInZp02DGnszTnCAFdjlEYGBpKHjTfzMXfEcOLdaCba/M7/GzWV8s6scKqhtzY
         qGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762855144; x=1763459944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cjlk2cRXCuPrNRO+4Q+s712BaHBwWqkzdg7ZDqTvNUo=;
        b=t/3msc12K6gzY573JDhHcVExIbtPugyGKvN7FbYwzw/KaiZverawq/EAKLsYv3+s71
         HD8vMwudB6KZmeffpQPscWruDmTRdWOeV5bKp8VUueBYl8zIUIpiYaVgT7CQ0TocVFYy
         Zh8TmgMlFa0fRoURVkT7Div5xilmq5oTZmcF1B726/yAmvy9p7dae2Zi26Jynw64WxmD
         cUN7aAktj/qp2bpOlSnrKfDuFjCNINQGk+912zN1RRt4Hl4mv7BbyhBN3I3ittIT80ih
         UYZZtiH3Yg38sqJpsQMoyRoWyh7FIbT8fqhM1aXrnqxejgva7Ei29QdOOF7Ko6m03lLH
         jorw==
X-Forwarded-Encrypted: i=1; AJvYcCVjMKfe8GQBr1X8AzSwcPxRZ/SkOoRHvM2bNS6doCCGoMexeKrnjQwEgjZvoY8CN3TaWOlxPKEfGtgtlGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1+nwtVas8loxKfr3etY08Hpr4PfVuAPJ4cXas2O8NgeldgNVL
	b7u/DsGH//DBZyYNy+lQS0CW0s1S7zEAhI4ukqW9QNgDTKsaZQLFhYforD9fe2F7ZkW8joZ9Tff
	0UWdB539Tc6SYKVmWw9J/RdmoTomB0y0=
X-Gm-Gg: ASbGncu2l9tDP3+QFBSQVgNPUwZJhvPrzTtC179gnJ2L0LCPTP4FiXFVAM+uHMfMp6b
	j5B+U0SV8G2sM2an669gs9z7AciMChQidBmX/oQTsZA2qYVdLZyduL/AFdrhIRVLa/Xr1qN2Epx
	KbwPsE0ErejpPm8IkUUaHpDSCN3liFC+eOSlHGDT50Cv3iICD/YY6DKQOhZVfyFQtoA8kaRz4Ul
	B1QwEIBA+/AkWXVJ+MT3FhUFSftgrVaarocqxKqiptcWB2DzoDpE7GrFmjxdYGGlKMhlRwZ
X-Google-Smtp-Source: AGHT+IGjntCvClMuhLxz7Fya0295cjdJ1m9OqTMAuyWKHxrVWXNBcWKh6jbg+Z6+nNLdGhpeB15uRACtQ6ldFO7VOgM=
X-Received: by 2002:a05:6000:2a0b:b0:42b:3dbe:3a43 with SMTP id
 ffacd0b85a97d-42b3dbe3f2emr3582660f8f.50.1762855143534; Tue, 11 Nov 2025
 01:59:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111091047.831005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251111091047.831005-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <5be2d1a1-3eb5-44be-aa96-797be13ea7a2@microchip.com>
In-Reply-To: <5be2d1a1-3eb5-44be-aa96-797be13ea7a2@microchip.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 11 Nov 2025 09:58:37 +0000
X-Gm-Features: AWmQ_blGjwEL6cAjvRlCMCOm_yxAQYhX3C4hQ33OpP5_-OFXdvaWUMEmwRVdWuA
Message-ID: <CA+V-a8uJ2Cg6tUWQ_tyApQL6s0F3A2VeJw8mBLiCfqXp5-gyMQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: phy: mscc: Add support for PHY LED control
To: Parthiban.Veerasooran@microchip.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	Horatiu.Vultur@microchip.com, geert+renesas@glider.be, 
	vladimir.oltean@nxp.com, vadim.fedorenko@linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Parthiban,

Thank you for the review.

On Tue, Nov 11, 2025 at 9:54=E2=80=AFAM <Parthiban.Veerasooran@microchip.co=
m> wrote:
>
> On 11/11/25 2:40 pm, Prabhakar wrote:
> > +static int vsc85xx_led_combine_disable_set(struct phy_device *phydev,
> > +                                          u8 led_num, bool combine_dis=
able)
> > +{
> > +       u16 mask =3D LED_COMBINE_DIS_MASK(led_num);
> > +       u16 val =3D LED_COMBINE_DIS(led_num, combine_disable);
> Follow reverse xmas tree variable declaration style.
>
Sure, will do.

Cheers,
Prabhakar

