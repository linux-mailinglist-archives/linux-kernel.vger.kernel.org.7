Return-Path: <linux-kernel+bounces-867244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7218AC0200C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E45C509109
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B14A30E834;
	Thu, 23 Oct 2025 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cb1EVlJo"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F171D5AD4
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231775; cv=none; b=SHu3w4JPrfNHtPo0Wtt5ygbiCezve3rDa8rH3ah5qtr3ZMXqdhchmn0RDZT4MemRE+9XoTdzIwbViJfqmfVcdinujBToKxpfxqIWdqb/bT0RHaBaHVUo8GrKfTlnrAbktDMicjJbi4Cavc27QT2k5pbQwPBL/+C0lolI0lnm8GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231775; c=relaxed/simple;
	bh=WE5qogWkRENsyIBIko2qUZacw09NDAcR9tS61XE4SZM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=W+tCRZEPsXqdCgPoaaPLLks9Qtk4NpLciwd3YIiXTgViDqFVTb1P2EYTTG5gSjKwpbssbyqaZ5yeHl2SM5knuOQV/heMhJo4SW6T/D2joYPrBiuAfJEdCjE23rdNheYCNfwJubm+o3pf/G6Q/sGFKEgfprLVx+F6IthJ0Kvt3Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cb1EVlJo; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-78125ed4052so1170599b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231773; x=1761836573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MkidSRQo/GOEYj0Tu2snWK+mqlcOOOStlJdAEW1rsn4=;
        b=Cb1EVlJotjwrHwpYde3qUxtyoEsbMtaVCJY0tDOjepjzBRrp6tfek6AiGaXZZ3jBFN
         fMLBvufWAeL/Y4Sd73kDED/CRsHHrgT+TtgCyGv+nPRiqsjJwngc8cTwM5NwqknQsIkf
         qqPDC0VgdA6B48ua/XM0iTnx4bFurT1dFwwSvIi/ZpTw5N7IqXBz+72g1EpPiMkz6IXu
         BVtiqhGungiRES3QF96mrUTtzNY0Cc4NsETQznZ2zChOm28zFpyiJ8jn3U4hzp0fXOwD
         gsfgByCnHIT5YJeFB8VtnNb5A9CiT6XgevRH7g6qyl3ZhiWXSNXa7hXjDDtQ11HtNQOf
         vOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231773; x=1761836573;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MkidSRQo/GOEYj0Tu2snWK+mqlcOOOStlJdAEW1rsn4=;
        b=Yjz6hRGOY+q4pV3qAGgo7JGR+atAep6/HY+uqEQva5vwHYVQE1TBr/msG7abbxbrv4
         +t860npM1HehxT6OQR4CyOtSY/TOWVhft3vVNWkwKMkgf6Van/D6dRNcKR5dwX3cK6ch
         1vbaIxM7xpgSUn8DVEDS5YyGSO1A+Q92QvL1XZXbEBLL03xaMEh/eWWEz9r0jY/DLnue
         iAgONBmj5Zxai3lMd2ojcpz3EXyspIrvGINnv1nG7QhJN3nT3o/dHux5G2/kICD3pYxt
         44D/+aAD+bMaFI+ND1s562z0lX+z2QEyMLAzfHXcW8aAgKe5sae+zcgAMGJjLUzZ91ii
         DSPA==
X-Forwarded-Encrypted: i=1; AJvYcCXoQqKYxWv97qhiTaP4wLRshxy4T+aoUR7aPkM/NI8dlGR1j5C1JqLPlmgDOdT59vaukcrFgwJBvOk0MN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsw0PJ8t9LSWnOeY0//MeRcuv3wZm/I3wddoL0Ouv+RmhJZg1k
	vhTokf045+9xfMHLFgIBXTir8QPQGeo7BLQz83YZTQFgAqx7CIQ9rJfsFl/mooi5
X-Gm-Gg: ASbGncsBIg9IZOZgKRJ5BVqu2C+D0JhAhVlDvUMfK+ON/iWSSAhOVdVt76IEqGW/8zE
	CkohUpce3uymH7l7s7pd6tg9qNfzAo3jYuRYCh1LD7Bdh9CMJior5AsnXpUEc2RT8Ckfp4O/SML
	dy4DK3z8GuU+GtuacGxlPsfGW+ZvU7NVSGuPvQDnj2KAfMUfmLPmfwXXVuXY4hDC2X5Ax7n8spn
	iu2YX+C8XZTSFq7gJ+3wXajX897dRy7QcchJUIO3+eOAtLKf0NRtt8+YiScIGkYWsGQAe2MbNsn
	puXip5CrN1eaCAwQo/plppL6/rP3hwpqbXByplVjM/TzqlF5WCeCEiU5qsuSPcDquGAJy2CPdkm
	MuHwJfeWy3WYFn0/FCpD4T/fmj/+maajNWZMiU2n1WOisRgKGpKAVF4Nq+V1rhMvNMPu75PIgig
	Z+JAXHcVyZAbRgfgAW9zY=
X-Google-Smtp-Source: AGHT+IHHKziB4DW0vGH8ZEE2qC8VyCgWT5aL4GbAYdnM68KSZZRJjeHEH23apvSlkqj43Cq8CCW/MQ==
X-Received: by 2002:a05:6300:218a:b0:2e5:c9ee:96fa with SMTP id adf61e73a8af0-334a861743bmr31698010637.34.1761231771359;
        Thu, 23 Oct 2025 08:02:51 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:18:134:cac6:d57:4699:a178:35c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb9259sm2367698a12.2.2025.10.23.08.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 08:02:50 -0700 (PDT)
Date: Thu, 23 Oct 2025 12:02:46 -0300
From: =?ISO-8859-1?Q?Eric_Gon=E7alves?= <ghatto404@gmail.com>
To: Lee Jones <lee@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: max77705: support revision 0x2
User-Agent: Thunderbird for Android
In-Reply-To: <20251023142144.GQ475031@google.com>
References: <20251014043255.176499-1-ghatto404@gmail.com> <20251023131732.GN475031@google.com> <CAMQHOhdzaak3c_jMuOXnukrE9LnCKvouOiAy8g0veRS2eQ3ikA@mail.gmail.com> <20251023142144.GQ475031@google.com>
Message-ID: <6D713FE3-EF65-4A48-A04C-E69396BC56F5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 23, 2025 11:21:44 AM GMT-03:00, Lee Jones <lee@kernel=2Eorg> wr=
ote:
>On Thu, 23 Oct 2025, Ghatto wrote:
>
>> On Thu, Oct 23, 2025 at 10:17=E2=80=AFAM Lee Jones <lee@kernel=2Eorg> w=
rote:
>> >
>> > On Tue, 14 Oct 2025, Eric Gon=C3=A7alves wrote:
>> >
>> > > Revision 0x2 has been tested on the r0q (Galaxy S22) board=2E
>> > >
>> > > Signed-off-by: Eric Gon=C3=A7alves <ghatto404@gmail=2Ecom>
>> > > ---
>> > >  drivers/mfd/max77705=2Ec | 4 ++--
>> > >  1 file changed, 2 insertions(+), 2 deletions(-)
>> > >
>> > > diff --git a/drivers/mfd/max77705=2Ec b/drivers/mfd/max77705=2Ec
>> > > index e1a9bfd65856=2E=2E5201a4c9c3f5 100644
>> > > --- a/drivers/mfd/max77705=2Ec
>> > > +++ b/drivers/mfd/max77705=2Ec
>> > > @@ -105,8 +105,8 @@ static int max77705_i2c_probe(struct i2c_client=
 *i2c)
>> > >               return -ENODEV;
>> > >
>> > >       pmic_rev =3D pmic_rev_value & MAX77705_REVISION_MASK;
>> > > -     if (pmic_rev !=3D MAX77705_PASS3)
>> > > -             return dev_err_probe(dev, -ENODEV, "Rev=2E0x%x is not=
 tested\n", pmic_rev);
>> > > +     if (pmic_rev =3D=3D MAX77705_PASS1)
>> > > +             return dev_err_probe(dev, -ENODEV, "Rev=2E0x1 is not =
tested\n");
>> >
>> > What happens when PASS4 is released but not tested?
>> PASS4 doesn't exist from what I've seen on the max77705 header files=2E
>
>Not yet=2E
>
>But not having it in the defined does not mean one won't exist in the fut=
ure=2E
I don't think it will, newer Samsungs already use a new maxim controller=
=2E
>

