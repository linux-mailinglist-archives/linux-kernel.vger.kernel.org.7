Return-Path: <linux-kernel+bounces-768522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D34FB261EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC53E3BA67A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559D12F745C;
	Thu, 14 Aug 2025 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLpJnsON"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A072EB5B4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166406; cv=none; b=DBggWmdSCPJ2ghUMaaRzDXM8ZFxzzPzQGg7gz2xwiD1gm1+wBWNhTMdIWtL4mZlVbwVBOlcLfYeFvG1Woc5vz/bWkyRg6w6eoZQAE4OyANqTOJgeibUyPcZICz09lB089DkoCfyreUjwLaJkuA6E/WoY6Uxov8xRuhf7iPtDT/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166406; c=relaxed/simple;
	bh=fWV0Vky7dLN5wLLAfrWbf/PWgWvlpmsQDAwFJM1cuFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZUfvP2l8FumtF2TBynZG74aGoKplyUXiUpLiFan1MogX39Vs6AgcQyXhmCoI7WWJ/YhdSpfjdnj7E8rDWp4CS+s90CHlHRuWEbhs8cqxSai/QtxG9MWvBpgQese6bQuq9jGC8cCP7NuA+DD5zo6Hh1QLlpI/4Boacv7DY03GLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLpJnsON; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32326e8005bso854992a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755166404; x=1755771204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWV0Vky7dLN5wLLAfrWbf/PWgWvlpmsQDAwFJM1cuFQ=;
        b=fLpJnsON9iyjPAfKR1IdAKdIqIyK451N07DMVTxt6Zonx0ernXYun3joPg2Ib/9q7F
         KOXjIH1Oh8xMuRdPYvf2yoiVMM2jN4dqR9Peg0/RsthQspc57cMkUXl4UD/8LnCvGmwZ
         8AilPh4rMMX0tItTs4gU8EjbmesZGGLC8FxTHSJcN33e6K1sgYGQr9f9jiMi14DZJz44
         jpY9AZCRogLsy35RXZNX/u3q7JE18cEcxWcjghYRNWhnO3Y+motBI9okuJeUXa2dngAX
         3fqWVtofBXX4BoYVdTeUu2VhEBjVMPk+j0J/OF9PrgPrF/zbHUrI4Ht20+DtZJxKDIDE
         eqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755166404; x=1755771204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWV0Vky7dLN5wLLAfrWbf/PWgWvlpmsQDAwFJM1cuFQ=;
        b=pXjCzO1hh+gbnu7O1wiQuE3rwwmqW0wkXtq452qDkgdoNWl9n2LjcIXP8i6JQ/e8Eb
         fkw5ZOfGT2FG35FyWbr7CzIGaEdEnk7xHdWtKfbzBDYURhqo6aFFzEQbbYM80CuH7QLd
         hIy/AVK+J3NyrNlpr517jyKSDvxesM15XgDuf2xL9WeGjsYzyktKD6pEP9P4LE28Muhe
         LGqs0aEzu3G+PGqGpdpPplWaUOIttioRr1aHYG8D0bAmcUMYLLQTWcK3hqI1XOo3tTRm
         6KIU3NgkDoes8U3GnSS9VF0zafdFTq8SzuH2ANgAtdgP2WzNy80jvQhBoEDn9Gq1LFat
         jGEA==
X-Forwarded-Encrypted: i=1; AJvYcCV3Tuzv85RF8ydW7MA0v0X+4gE3lTZnLDh24wgnru6tGIQrsfwf6vrNBKhN7JOVQ/BzAfgMEy1PbyTOlpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXa4Y6WdbCDj9lDHVfCnBkbiZWX8WE25oa6EacSxMJEV43XQeX
	2HIsRYravGoDiFjCEerRHrv2DYzTeENbLivhxE0mOc3CS3I+r3qdFAxuVRx72Jb2RIzXdfvcUs7
	DrXRsRPgMrzwurtzx8MYIRuYW+s1Z8kM=
X-Gm-Gg: ASbGnctvjUzRCO2YyIRGsEhuJ0xxQMY0hMq11ftqpZi1uzU1BGEz8CdOG1+XZYzHGfC
	TyzelYQBZSqI3IsTDHxSrcBW0CECmVu7cZsgV1itecP2Fau6EXYz5XHwhQt50NJPMPKZQ4kpbUV
	4cs2TyIkAbem/sVcdSKdYt1Ddu7aV7qelvRrPlnW6Cq3wh+E7mN+mOY5OdQ+9QTcFTMDbMmDGXg
	LEKpnY=
X-Google-Smtp-Source: AGHT+IGQB8r/pPHGVfsNp7+7bw5sKWLbla7BkdMq5nUYbmAEN+NnBiJIz4CX6aB11P4WqBNN6+MQuuJXSxJySIi6080=
X-Received: by 2002:a17:90b:1d01:b0:321:87fa:e1ec with SMTP id
 98e67ed59e1d1-32327accbcamr4020043a91.34.1755166404565; Thu, 14 Aug 2025
 03:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812051949.983040-1-linchengming884@gmail.com> <152133202.103367.1754981828821.JavaMail.zimbra@nod.at>
In-Reply-To: <152133202.103367.1754981828821.JavaMail.zimbra@nod.at>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Thu, 14 Aug 2025 18:11:07 +0800
X-Gm-Features: Ac12FXz2rhhyBIh2oSvcLuHLhf31k4mVO-sI8GTQ2EvX_sMkocC2UqI39p7JvyA
Message-ID: <CAAyq3SaEqYiKhbjYwLH0p6F2G=UR-MwZF28AG1xVMoKhznS3Og@mail.gmail.com>
Subject: Re: [RFC] mtd: ubi: skip programming unused bits in ubi headers
To: Richard Weinberger <richard@nod.at>
Cc: chengzhihao1 <chengzhihao1@huawei.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Alvin Zhou <alvinzhou@mxic.com.tw>, leoyu@mxic.com.tw, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

Richard Weinberger <richard@nod.at> =E6=96=BC 2025=E5=B9=B48=E6=9C=8812=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:57=E5=AF=AB=E9=81=93=EF=BC=9A
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Cheng Ming Lin" <linchengming884@gmail.com>
> > An: "richard" <richard@nod.at>, "chengzhihao1" <chengzhihao1@huawei.com=
>, "Miquel Raynal" <miquel.raynal@bootlin.com>,
> > "Vignesh Raghavendra" <vigneshr@ti.com>, "linux-mtd" <linux-mtd@lists.i=
nfradead.org>, "linux-kernel"
> > <linux-kernel@vger.kernel.org>
> > CC: "Alvin Zhou" <alvinzhou@mxic.com.tw>, leoyu@mxic.com.tw, "Cheng Min=
g Lin" <chengminglin@mxic.com.tw>
> > Gesendet: Dienstag, 12. August 2025 07:19:49
> > Betreff: [RFC] mtd: ubi: skip programming unused bits in ubi headers
>
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > This patch prevents unnecessary programming of bits in ec_hdr and
> > vid_hdr that are not used or read during normal UBI operation. These
> > unused bits are typically already set to 1 in erased flash and do not
> > need to be explicitly programmed to 0 if they are not used.
> >
> > Programming such unused areas offers no functional benefit and may
> > result in unnecessary flash wear, reducing the overall lifetime of the
> > device. By skipping these writes, we preserve the flash state as much
> > as possible and minimize wear caused by redundant operations.
>
> We talk about programming a single (sub)page, right?

Since the UBI header is mainly written into a single page, the "unused
areas" here refer to the space within a single (sub)page that is outside
the header content.

>
> > This change ensures that only necessary fields are written when
> > preparing UBI headers, improving flash efficiency without affecting
> > functionality.
>
> I have been told that writing 0xFF bytes to NAND should be avoided.
> This is also why UBI initializes them to 0x00.

Normally, after a NAND flash block is erased, all bits are in the 0xFF
state. Programming 0xFF in this case will not actually change the NAND
cells, as the device can inhibit programming=E2=80=94either by raising the
bitline voltage or using a self-boosted program inhibit mechanism.
Therefore, programming 0xFF is a normal and harmless operation for NAND
flash.

>
> Do you have data which proves the opposite?

I am currently collecting relevant data, and will present it once it is
ready. Thank you.

>
> Thanks,
> //richard

Thanks,
Cheng Ming Lin

