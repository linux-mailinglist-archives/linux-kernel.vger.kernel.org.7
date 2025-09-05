Return-Path: <linux-kernel+bounces-803063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AC0B45A17
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F7E5A5EDC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41A635E4C9;
	Fri,  5 Sep 2025 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TLpy5jkd"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6AA13D521
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757081365; cv=none; b=sIhsxVwCMYYMHxKWoGSHC2EHGEZ/f4erXPtUpTOJJR2uCqUe7/g7u5c1EwPDq+ooDmQRqn2YeeO3VvmcWGivA2V22gOOdF4jc2KepWecAg97kwzehAOSDZe5F0LQkQlONSYmshgRZXHA1mktIO1Fd5nWne3iKfUorhXdTWOPWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757081365; c=relaxed/simple;
	bh=BS995w0OnvGk/aieZSL150wQJSc1v3dFE/VYYrjJD50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F0VWBklXzyjGodOPeYPC0XOdlIJ2uXT/TZw5ztt1RzwqkZsl2TBf05NwuaMyZNmIvsbJJotjQ34oZFaWA93JvXyKRIzOtavmvaPzRh18Lcs1adSs3+q4b7EWMfE5/6MeOEkSOw4IpJGHFR92viamr5noDNr5mX73WAfq35MImtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TLpy5jkd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 837311A0DD7;
	Fri,  5 Sep 2025 14:09:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5C8BF6060B;
	Fri,  5 Sep 2025 14:09:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7281C102F1C9E;
	Fri,  5 Sep 2025 16:09:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757081359; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yI09fP41lf9Q4jwENZ62/pXTkYZu2l4FuzKZ2cUvw8U=;
	b=TLpy5jkdnGeRb90/2Ct4Kpw35yI5HnazkuvIH0eJqeNp5JnZi8bja3sT7rXLjsab/BqWoI
	8OYOQ270phJ4AuHH6S/CyDVhqDmmAK9Q7ihSW33+emtEmzH8/pqIgMqgHwCRE1pNFPfTgF
	a7iHy8s92BEiwcSsJflOqXJiDxWvzdFr8J81/2RApJ6Qb3i69WQdzYuOffipWJpCRWDX2p
	/7JKl9eUxpvad+MWY7vZN+8C3AvgfKG9P/un7Qzqc5OgCbniVUn+xyG/rhHsy38FKgrRC8
	x+xvtkKXEUuPbiRDQVOYYpEHT09tZnbIgZjwvNaHIj2KAQtYTx5WRuFxlJzwKg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  richard@nod.at,  alvinzhou@mxic.com.tw,
  leoyu@mxic.com.tw,  Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH 2/2] mtd: spi-nand: macronix: Add randomizer support
In-Reply-To: <CAAyq3Saj5cmHAb3NPd=ZzJEvYD873s2CFKOyoxMrKk6Tj6yakg@mail.gmail.com>
	(Cheng Ming Lin's message of "Fri, 5 Sep 2025 09:14:40 +0800")
References: <20250808095503.906244-1-linchengming884@gmail.com>
	<20250808095503.906244-3-linchengming884@gmail.com>
	<87zfca9kur.fsf@bootlin.com>
	<CAAyq3SZbPpVX_LyoYaHYhA3ZNeb0NYWQ4KC6-+uubB1GGCqZag@mail.gmail.com>
	<87y0rhyq12.fsf@bootlin.com>
	<CAAyq3Saj5cmHAb3NPd=ZzJEvYD873s2CFKOyoxMrKk6Tj6yakg@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Fri, 05 Sep 2025 16:08:58 +0200
Message-ID: <874ithm1ol.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 05/09/2025 at 09:14:40 +08, Cheng Ming Lin <linchengming884@gmail.com> w=
rote:

> Hi Miquel,
>
> Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2025=E5=B9=B48=E6=9C=
=8818=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:47=E5=AF=AB=E9=81=93=
=EF=BC=9A
>>
>> Hi Chang Ming,
>>
>> On 11/08/2025 at 11:01:25 +08, Cheng Ming Lin <linchengming884@gmail.com=
> wrote:
>>
>> > Hi Miquel,
>> >
>> > Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2025=E5=B9=B48=E6=
=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:19=E5=AF=AB=E9=81=
=93=EF=BC=9A
>> >>
>> >> On 08/08/2025 at 17:55:03 +08, Cheng Ming Lin <linchengming884@gmail.=
com> wrote:
>> >>
>> >> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>> >> >
>> >> > Enable randomizer function by specific flowchart to set the default=
 value
>> >> > of RANDEN to 1.
>> >> >
>> >> > Randomizer introduces two new DT properties for child nodes to conf=
igure
>> >> > the randomizer functionality and coverage options.
>> >> >  - mxic,enable-randomizer-otp: Specify whether to activate the rand=
omizer
>> >> >                                feature.
>> >> >  - mxic,randopt: Define the randomizer area per page.
>> >>
>> >> Can we create a global NAND DT property for that? Enabling a randomiz=
er
>> >> is quite a generic step.
>> >>
>> >> > The penalty of randomizer are subpage accesses prohibited and more =
time
>> >> > period is needed in program operation and entering deep power-down =
mode.
>> >> > i.e., tPROG 320us to 360us (randomizer enabled).
>> >>
>> >> Do you want to share what is the added value in terms of lifetime to
>> >> enable the randomizer, given the drawbacks which are significant?
>> >
>> > The randomizer mainly targets extremely unbalanced data patterns,
>> > which might potentially lead to data errors.
>> >
>> > Please refer to the attached document:
>> > https://www.mxic.com.tw/Lists/ApplicationNote/Attachments/2151/AN1051V=
1-The%20Introduction%20of%20Randomizer%20Feature%20on%20MX30xFxG28AD_MX35xF=
xG24AD.pdf
>>
>> Thanks for the link, it may be pointed with a "Link:" tag in your commit
>> to further justify this addition. However it is sparse on details. I
>> would be interested by more details, such as "how many 0s? how many
>> bitflips? how often/likely?"
>
> Thank you for your feedback. Unfortunately we do not have numerical
> data such as exact numbers of '0's, bitflip rates, or occurrence
> probabilities to share. Instead, I would like to refer to the JEDEC
> JESD22-A117E qualification standard, which provides guidance on
> retention and endurance testing.
>
> According to this document, there is no single data pattern that
> represents a universal worst-case across all failure mechanisms.
> Different mechanisms may stress programmed cells, erased cells, or
> cells influenced by adjacent states, and thus specific patterns such
> as fully programmed, checkerboard, or mostly erased are each only
> worst-case for certain designs or processes.
>
> Given that no fixed pattern can cover all cases, the use of a
> randomized data pattern is considered a practical mitigation
> strategy. A randomizer distributes stress more evenly across the
> device by scrambling incoming data before storage and restoring it
> on read. This helps reduce pattern-dependent degradation and can
> therefore improve long-term flash reliability.

Thanks for the details. I guess you can add a bit of them to your commit
log as well. I'll welcome a v2 with the previous comments addressed!

Thanks,
Miqu=C3=A8l

