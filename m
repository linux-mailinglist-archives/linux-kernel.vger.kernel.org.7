Return-Path: <linux-kernel+bounces-792430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426C9B3C3CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134BC16F73A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354F33375B2;
	Fri, 29 Aug 2025 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="LhiyRWoe"
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BAD21C194;
	Fri, 29 Aug 2025 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499476; cv=none; b=FLhMnE5hS9KuwZQ/leaUrZZCqsT/bVpDruTS+RUYcrIZwBlYmc+rmWLTwmRS5DmQLJJFU872QEAsur4JEFgUZmX7t3/J6coUztB5+TVRWdm2yfM0CMYyyk5iFNWWs91We25N8Ru/FmeMf/eO8g72IZJbunC7G88v4q8jnjg/VWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499476; c=relaxed/simple;
	bh=SJivwaFIMN9pzc/GzyVi63H3VG5P90Cy+u+DLytb+Y0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=YzRWzoyxNUYXvXWrkigTenRubrCvo5uqldwCpa3dALJlLZzqiFMuFPBek9t8C7iKSCDGADLOk/ZK8z6J1IJBWFwiR+d+dD1CVu7b0Sg9QqvZLzuxaaUiQdJR9c5W4zSKtEGLvgR1vixRVzv2v+sG/3K8j1sVZ+ShRlnS2gyqaVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=LhiyRWoe; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1756499411; x=1757799411;
	bh=DvTREl3RPMtyVXWwp9xdMSUcqBDVOu5mAI1D2OmkO9w=; h=From;
	b=LhiyRWoeU46kPZAZU1Kp04Be4TjynW7S6Brz4wrTrUCwoI3+xx6A11UkZn4YcQ5tg
	 eyZP5Kwyh+I1pTAQZFPQm8WRUgXJ+qM6GRxsz/XS5/b8WVF2fnsApJdX+KoC/4x0ug
	 kd7PWptpePabIyDDkN/SkxS9pJ9YfEV1MALgTGOe3GX/xW/ou/+FSPTkvDoWneAJiD
	 cagjPl76NbbKcF/z04/35NuYMLsFvkLLLa5abWXkAt5CSSyh4S+QXWtU79LGc+eI9h
	 B/BU67Hv7dTRsRHOR+hURIY04hTBl3smzAHkGmL8IeJrfFrIFVCuKYjPWFTv4Ds8D+
	 jCqCrg2wkCwWQ==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 57TKU90L021409
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 22:30:11 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 Aug 2025 22:30:09 +0200
Message-Id: <DCF72OWEVZH0.3BSSAMUXM5I2J@matfyz.cz>
Cc: "Jonathan Cameron" <jic23@kernel.org>,
        "David Lechner"
 <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Andy Shevchenko" <andy@kernel.org>, "Lee Jones" <lee@kernel.org>,
        "David
 Wronek" <david@mainlining.org>, <phone-devel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] mfd: 88pm886: Add GPADC cell
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
From: "Karel Balej" <balejk@matfyz.cz>
References: <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
 <20250829-88pm886-gpadc-v1-2-f60262266fea@dujemihanovic.xyz>
 <CAHp75VdxGs-tifyD+T+H+TPq9ZY0Oz5zfKsoqf2uuekZCnfizA@mail.gmail.com>
In-Reply-To: <CAHp75VdxGs-tifyD+T+H+TPq9ZY0Oz5zfKsoqf2uuekZCnfizA@mail.gmail.com>

Andy Shevchenko, 2025-08-29T18:47:19+03:00:
> On Fri, Aug 29, 2025 at 1:18=E2=80=AFAM Duje Mihanovi=C4=87 <duje@dujemih=
anovic.xyz> wrote:
>>
>> Add a cell for the PMIC's onboard General Purpose ADC.
>
> ...
>
>>  static const struct mfd_cell pm886_devs[] =3D {
>
>>         MFD_CELL_RES("88pm886-onkey", pm886_onkey_resources),
>>         MFD_CELL_NAME("88pm886-regulator"),
>>         MFD_CELL_NAME("88pm886-rtc"),
>> +       MFD_CELL_NAME("88pm886-gpadc"),
>
> List seems ordered, please prevent it.

Ah, I never explicitly realized to keep it ordered, seems like I was
just lucky to implement the components in the right order :-)

Anyway, yes, please keep it ordered. When you fix that, you may add

Acked-by: Karel Balej <balejk@matfyz.cz> # for the PMIC

Thanks,
K. B.

