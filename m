Return-Path: <linux-kernel+bounces-855639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303BABE1D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35EF1886516
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDFD2D47E9;
	Thu, 16 Oct 2025 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ1U0q+3"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447C378F43
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760598071; cv=none; b=b/f6Td7Vm9Nhid/Kx2+1BVTUabacthL5e4I67VMWAQmC+g7QhRrBXFwOphPj3r9WEHqkL0SQSEqkY+/5v7GGwnUuqgNPn4GvolwwFL3TGKXCFrAqFkB9xdZLy8+t2XAKbNyA1CNKfYY4/zmCj5SYXITFDTeS2tAcp1q23NwlNDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760598071; c=relaxed/simple;
	bh=vDcdkcO33abxC4TnKZFWyjF8Ipj6BQMFJF2qYzz1w7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVo7eCYAzw2xKm5SLEr1fB2IiLz9LUQst4bmduQbgyQxi+vAylXCBvwU445C1NsdrQklwJ83MuAWaiHjjRko60RIHbTKu8//OsSAxaqgBhq+rizXMBXSZPJjU5nqpO9uAo1RoDw8FarNRvt1PtKT1bEHF7Yh7SU0xi7E04IaGG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZ1U0q+3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so246634f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760598067; x=1761202867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CgQpFz1+9Zq2VExIEJHCudhv9BcyFA2koCTdblK9hs=;
        b=QZ1U0q+3sg/IOfWRc6MBPPhtNfbeE0kIp42W81bqkQtXXRnPD06DE1Mr6CdZQk26nG
         4slPgMtLvkqPLg134UIDPQYwZ52Sq4pPaxFNXfBEZoez4VBFGItF1ZIIYrhbe4nuCVau
         sZ5jGpe4pL6QIioMkNSe9jgOYJlADs7ImXmeu6w9Tqzh7qRnBZs2+KbEZOP5YqucSxRp
         VnX67rq4bzB0vcXMKWiZ3oWwm6jXk01nRkQciauCUxAfksN+MGNmAeFdmj/eSpQQl4Dy
         lk1B16wMaSFIP9HZXSAumwZ4hBQt5XACxK/4FhMR1eRYr3hihpI/vucTSoGY4ZfQgZS4
         C1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760598067; x=1761202867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CgQpFz1+9Zq2VExIEJHCudhv9BcyFA2koCTdblK9hs=;
        b=ELAy3oYgUMQGF+R5w2iKga0al3Nqc5hJwobJ/HKdWjPczFR77PJrdfb20WBP/2Qra8
         jouQCDkYV8ZLnAFgWDorOnCuofOHQ58yaAfcG4yQETJX3OQPavi9zneSfVOe5l4S6rfL
         06NaPzYFc4rJJUYWR67V0ycUbwiJNbelt1ZGIL4w0vujyG6czWqwaf9PkpTTsAOnsJr/
         J90SJ72fsjwgcP+BqQ4/cqoThKf7Eux0V2XtwNwO0u27IBCD9wkVVO/DhTQ/zx2TpP4B
         HNnGQi5YKv6rn/OoY6KpsDpW90JDsp5QwhlDWpb7NNg3MYJEs2S62KJEusB4e9MhsK4o
         c6yA==
X-Forwarded-Encrypted: i=1; AJvYcCWDmdl31px+2YSIyg3MmSc3GaMJwBux6EVi/bfUmWBr8Es0kM7Z23d9Z0Sy5BQNGtDQQGK+sUY2jPKVOfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzQAks2qjRyoLMEYDTHqeGpPN/EJ4+T8F5Qh+bk3p5GfbWihYW
	79yMmlSUHTOH3LuR/xB3VShO6mLFFjTIilxkC7JypocVH6llxEizMaZdHLCLOvxt5+FaS9ZRdxb
	hHPoVlJ2JNkFPafAx4rDI2dQcpcwjLS0=
X-Gm-Gg: ASbGncstnzQ5p/or2jd1+qKwrQjNY4tu9rBUag0hB0XtBp3ZvIspe/1ih7srU4LC+bB
	gai9qQb+o/H6/8luuxj5T0Q+j3GgtICT0tua3rKkcB56JSezNniUx/0C+YK1f5s7txB1OaWPHXJ
	osVLr2QYQ10ezZ5IveLul4/CG7jXrxPzMOhlyy+ZcZpCX45YUuetNfrCOjO/lvg+8WuFo6/NZNL
	4KgIRFAPIbAW8il2BfI2nKRAx3kvxw8d6jRSbVDOZuP4jzxGhS7tToJDdYBlKKUn8GNgpqgyvt/
	5eBxnoY=
X-Google-Smtp-Source: AGHT+IE/QoaGfvrFFNkg/zp/kyT7JmowtxdagZlFC9qI35u9ouLTiaZf602K70Y3uTAToSg/Y9suDA7MeHQGM3SNeTI=
X-Received: by 2002:a05:6000:603:b0:407:77f9:949e with SMTP id
 ffacd0b85a97d-42666ac7026mr19754082f8f.21.1760598067327; Thu, 16 Oct 2025
 00:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013060018.43851-1-clamor95@gmail.com> <w3bn5bqxqjhf4uvxov47rwlvmnbic6xnlk25xbpnbmi2eyup7q@tjuiu7pl3mmo>
In-Reply-To: <w3bn5bqxqjhf4uvxov47rwlvmnbic6xnlk25xbpnbmi2eyup7q@tjuiu7pl3mmo>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 16 Oct 2025 10:00:56 +0300
X-Gm-Features: AS18NWBNnSxArNN_YGflj1sewGtpazTYDp07r6whpHpGwvXLBORgvLxkZeeTdZc
Message-ID: <CAPVz0n1-jN5WLFq4e0CZrneExrN_A=GNeGTwGHTCj14NAta+jQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2 RESEND] i2c: muxes: Add GPIO-detected hotplug I2C
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Peter Rosin <peda@axentia.se>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	=?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>, 
	Herve Codina <herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 16 =D0=B6=D0=BE=D0=B2=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 01:5=
0 Andi Shyti <andi.shyti@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi,
>
> On Mon, Oct 13, 2025 at 09:00:15AM +0300, Svyatoslav Ryhel wrote:
> > Implement driver for hot-plugged I2C busses, where some devices on
> > a bus are hot-pluggable and their presence is indicated by GPIO line.
> > This feature is used by the ASUS Transformers family, by the  Microsoft
> > Surface RT/2 and maybe more.
> >
> > ASUS Transformers expose i2c line via proprietary 40 pin plug and wire
> > that line through optional dock accessory. Devices in the dock are
> > connected to this i2c line and docks presence is detected by a dedicted
> > GPIO.
>
> This is a resend of the previous series.

Yes

> I want to understand
> whether this effort can align with what Herve and Luca are
> working on. I have not looked into the implementation details
> yet, but I want to avoid overlapping or conflicting patches.

Herve and Luca did not come up with anything meaningful, they provided
just a few rough ideas. It will take an inconsiderate amount of time
before there will be any consensus between them and schema
maintainers, and even more time would be requited to settle this into
schemas and implement into drivers. Why should I suffer from this? Why
should changes I need be halted due to some incomplete 'ideas'? This
driver uses existing i2c mux framework and fits into it just fine.

> Thanks,
> Andi

