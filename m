Return-Path: <linux-kernel+bounces-809823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB660B5127E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E0F1C80E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF76E313E08;
	Wed, 10 Sep 2025 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsHLuDIL"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C0C313555
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496557; cv=none; b=NClRnm/9G08EGYf/qzJKKbJfd1LGQGJdiYm6qVKBy6vD5rg5MUR3C611hBV6KT0IXs6JB206ic9hTD7hxlz2EJf+iCXny+6JBgTrTKnWpZLOS8JwO13AwNNiEdjx1lPkKGWyTStAEOceYhTfbfAdUiaZ6x+H8Lv4G3xxTi1UHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496557; c=relaxed/simple;
	bh=VXUPr/CGM4c+tRRseulMYqpv7jOdMuu0jWSGWBouU24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRfSAbhDZwRoqIzdrhCbf1V8fasP9QIU4M6iqRcMqV91bvmSul2kbINC8k2T0WcAyyC8EqBrkcdhjd5skHncB5WJE9nfIfARzm4FpMmdwuYS3ClDFI4rsjzQtcjRt+hnEk1llfvahJSkfvzzoaPbnhyhHznxWWQXtwSIyS5Yj9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsHLuDIL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32b863ed6b6so5422236a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757496555; x=1758101355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EStkD296c7vzLzgwbJ5Q3SXD0IQ0ZzmhAtjORkOwDY=;
        b=YsHLuDILu4Hlvz+4WmYSFQ1K4MI5o+Wn/d2haEOR2uicdd3kuhpvFj+iyTGuYEemzV
         7NtX/Tp7DfOZY681AXsk1EzJWOSwxWSm/gq9ZfQanWnh678ai/jmilvf3+QnMmDpSbXj
         B7OdcUohhPbFyE1hBSzV13BfBJCi2B+aZIovaA8+eNbQCTUbKWAGgonOOt2keoZ59aRe
         dxOoyg7pX/d5rHRrabN6M6hIZysXJoyxBiqHEsv6E34s9SivfHFmY9/s45IQcQhdO+4T
         Acy10z7p/2ElqRkHG/HFbrBkX8eKJ4elB4omjPBU/VgSWeBRjbFbqqErWR2BCb9mWpGA
         XULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757496555; x=1758101355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EStkD296c7vzLzgwbJ5Q3SXD0IQ0ZzmhAtjORkOwDY=;
        b=r491IA1033rygQHHUUglf35nXAIxSyt9dPCEZzvfxgGSLAHcFzrTrjrqFQfebJYBWo
         Wgfo0HuPgmhuNIVOFMsEoJ/7lyp7m13lOc7Za+QfQIxVlNS3RazivbcJnMluCQNbV+g6
         URYdgC9FLlV+wgoTOpWd4RgERCBaxkcU61RxXLKqcq9nTneRALlNMs62us18q9cqx5o2
         F9QZeFpqdwcWWM7mntwSZZ0exC9q8GSZSYJ3ie0LJQdvUDiecANBclXzM65OD+U7V2S0
         o5ODOxcaZwuabRx8YPub6fV7lYmP65qhFwSsf67AgrPqhc0sDCBBiE0FPceLu5JCuq88
         OeEA==
X-Forwarded-Encrypted: i=1; AJvYcCVmp3G8KY/Pr/6rd9HmTlF0GSVqo3gtZvN5iZG7ltQv4Y9O+Nkt7igIF1TzqhPPCO/tz0kPkoJm+NUIAEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEc5HlI0U3/vo0fMxb+9oonW/T3c3iHo0InK0uVAYiQFWHilKZ
	E9/OKuT8c3RiFR6ECmDqkLKTUzk2GACpCAZSWItiblfG7p+HrRUNzY03PgKSW/2tyuawhvEi+kl
	blL5XlVqm/JeVYD+CFx+1BJOGEt+A49E=
X-Gm-Gg: ASbGncuEWeGHZ9aV7GFb+kZ+jp4AXvdJDcl1Iijd/9g9pRbMrYaWC4kbVkrj+MSch1I
	9xBysthE14glXPjNjdxKNtbG8Ln1U9yZoOq6IWQSPoey3+dscg2+2PunWEZInl0bbpZFtTsyvtf
	PNw93rv4o8Qb4pvcG4ObwR/stTHBdZbfOqTic7F9qJHWtKTdEhz5/iywPrgU8D17khufwKgoJ45
	7+YBihXRK4pmk+E8XxEjIIDs85duyZwt3tc65fym8GC2YTbVHdKU1I076HhG9J2+x4KD3i9FgGy
	GTNJdtkj90r4YzNt
X-Google-Smtp-Source: AGHT+IGEB857JKG31YkO+wgmi8nzIk7GnqXqtsczCzBdx0PaCn3Hyc42K+1wQCNnGRXZTYwvjj0A/Ujz6xcIxnfIqeg=
X-Received: by 2002:a17:90b:3f4c:b0:32c:38b0:593e with SMTP id
 98e67ed59e1d1-32d43f04f10mr17652701a91.5.1757496554818; Wed, 10 Sep 2025
 02:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910030301.1368372-1-linchengming884@gmail.com>
 <20250910030301.1368372-4-linchengming884@gmail.com> <87qzwed62q.fsf@bootlin.com>
In-Reply-To: <87qzwed62q.fsf@bootlin.com>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Wed, 10 Sep 2025 17:26:13 +0800
X-Gm-Features: Ac12FXyc3DERP3v19zMEjcuEfAYaCC68gYRcLvz6_-F0QwwNUbBhHRCfjh1WPe8
Message-ID: <CAAyq3SamY9vjQubd0BjpLb7J_W6JfKyyd987y+UioMV7UQ=94Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mtd: spi-nand: macronix: Add randomizer support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: richard@nod.at, vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, tudor.ambarus@linaro.org, mmkurbanov@salutedevices.com, 
	Takahiro.Kuwano@infineon.com, pratyush@kernel.org, 
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2025=E5=B9=B49=E6=9C=88=
10=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:12=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
> > +static int macronix_set_randomizer(struct spinand_device *spinand)
> > +{
> > +     struct spi_mem_op exec_op =3D SPINAND_PROG_EXEC_1S_1S_0_OP(0);
> > +     struct nand_device *nand =3D spinand_to_nand(spinand);
> > +     struct device_node *dn =3D nanddev_get_of_node(nand);
> > +     int randopt, ret;
> > +     u8 cfg, status;
> > +
> > +     ret =3D spinand_read_reg_op(spinand, MACRONIX_FEATURE_ADDR_RANDOM=
IZER, &cfg);
> > +     if (ret)
> > +             return ret;
> > +     if (cfg)
> > +             return 0;
> > +
> > +     cfg =3D MACRONIX_CFG_ENPGM | MACRONIX_CFG_RANDEN;
> > +     randopt =3D of_property_read_bool(dn, "mxic,randopt");
>
> Isn't that a leftover?

The property "mxic,randopt" corresponds to bit2 of the configuration
register 0x10. Its purpose is to control whether the randomizer also
covers the initial portion of the spare area.

Since the randomizer feature is only documented in Macronix datasheets,
it is not clear whether the "randopt" bit is used by all vendors. For
this reason, the handling is placed inside macronix.c.

For reference, please see page 28 of the following document:
Link: https://www.mxic.com.tw/Lists/Datasheet/Attachments/9036/MX35LF4G24AD=
,%203V,%204Gb,%20v1.4.pdf

>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

