Return-Path: <linux-kernel+bounces-801971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 733B4B44C3A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87BB57B7DB1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E97E22FE0F;
	Fri,  5 Sep 2025 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCD6JhOc"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD88834
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 03:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757042650; cv=none; b=bp6LD3BC/yOyTxee1wR/JmK3UgxmMvEsXUw0/UiP5G5vzZiEK3rwWYDdpAZeuWz5pFrug7UZDeCuYh838eRKYGjPx/2uX5bcbQxzTOlLyJm6S5zjh2AVolzJ5vJ6xIEaZY5EIkqhvwhAqfGoegtPsnMH67057LUQ58ZSs4ggBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757042650; c=relaxed/simple;
	bh=M2rwiOR30AUoK/1BMehI/foxTsycL/hQduhY8reQFMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3zl8vOcxltW1ndbB5NG7Y2FHTdm6Rm0RB547qgX9Z70VlieVGgcmfMW4BhDWW/yhu6JISryFG/inGPKjmxBZYIAIEio16Fxp/FWW2l5nVYcsLlm857UjnYO3fm6mG89bQnV6tDo45C8R13R+pWK8etfl3lfuMgzFxar2CLjtu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCD6JhOc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24c786130feso16100095ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 20:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757042648; x=1757647448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2rwiOR30AUoK/1BMehI/foxTsycL/hQduhY8reQFMI=;
        b=TCD6JhOcUNSyZ+bL+8KIgMCWKpiqUYk31uVFBqgpXIc2/S8CQ5Uz/1UBb1YWd592jr
         /H6Qpg0MUoCKhmIyOeZqUgK4fj7wFJmTBvHBEPAPBElUUtqyLVEcZggz64mK+eRYD28f
         ZCC+0nlNiTY9qO0Ncy/tOBEM/gVCGZeZ5O63R8PK4FBaqIU8v5lDUG9Ai6MEl8H0cvx/
         H4U+H1VBiQ95IFAE9Cp9+Nn9Er//sdVaIMDEygvV92HPBLWwi5kXaMHLF2gjdD30QH1p
         2GGnlG/G5oO7C57tna1NhKppltDGzcD5v1qa2mg8d5s7qclE7+GVZ/wc0LNM4Tc0h2wX
         8mFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757042648; x=1757647448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2rwiOR30AUoK/1BMehI/foxTsycL/hQduhY8reQFMI=;
        b=EV6hs6xOK9ELbAJoO21/VNW9TwZZ6MR38xX6swYi/MhZ4i4Ck5OJ0JTHKjsfnuSLbi
         s8kGuY5d7U19Z1JunSHZ7TyEPaK/MWFGcyh+XMvTuXshxJjvWmiFOwRZTKWQWoBmJX0+
         okORsGKkPbL5ugGtGXX+TjL9PHO3prv3RXlOtSfk+ssfWb0Gh0+GMS74rnjEO/KxvVv0
         1sje7IC5Yo6S6Ty4wCVdOfrRbPlDEPIkon3PrTwlrCWW1qU2WrzAezYUHzjwFcWi27i9
         x/3asVE61RnRCltYYqcdosPSVdMDY0PyPEQcW6sznDGp8nAfjODF76Xb8fA4XtFROSNl
         B3YQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8R5tWHwNPU/5lsmPrBps/hpDEkQXmA4ptt7/GiHyCsBZwoqFKbPWGC6tcceCnJMoi6IWM+T0D/wUcMAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCOaDZ/72ei8P8qj4rb5z2n7yUZov6m0Fwp543pVzNhROGUkuL
	E5/r/bF595avE+VWzKklhXD5yHmU983bYC0/ka/mv8W685kjngyD15Hua3GuUadZMzYUtrCdi43
	OfIcvvrtOF218eZEq/O7cckfGhpsD0rQ=
X-Gm-Gg: ASbGncvt+Y73OjxAW8j9ohLCdcsCZVy7Py74LmKyrBO6KmuJJZX0XYuDoofBqOtibLZ
	fUWLQxcNRSJpHJJhdcP3x6vegHz0VXYfGBW9MX4PVDLhKCkBSGYLt9BlCsxEXmG+l5bsNpXerQ4
	FLnYmwThppmao7qWsRGrquNEqZuI9eZBIowqEuL86Ml4FVif5mIX/IEEbKxXN3RYr6yLM4DD7ol
	RcdgGQZuG+7Q/5Rv+cB4yhwg05s4l8JG6bKGs3CEOYihd2bc2H4ftlaTYAQqm+puXVwtZoFo/Tl
	sk+EmxTvTosunWjJelNtyAsOaEE=
X-Google-Smtp-Source: AGHT+IGeoH/tnRINONrHIBmpzSB+8Y0C2HMREpMJp2NyyWL5F7495CGsYjLDD12r1W/V1nDjRZlt3kUFyeX9bcl9k+Y=
X-Received: by 2002:a17:903:3d0b:b0:24a:c62a:dede with SMTP id
 d9443c01a7336-24ac62aea77mr222773715ad.26.1757042648345; Thu, 04 Sep 2025
 20:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812051949.983040-1-linchengming884@gmail.com>
 <152133202.103367.1754981828821.JavaMail.zimbra@nod.at> <CAAyq3SaEqYiKhbjYwLH0p6F2G=UR-MwZF28AG1xVMoKhznS3Og@mail.gmail.com>
 <608935583.115196.1755171013804.JavaMail.zimbra@nod.at>
In-Reply-To: <608935583.115196.1755171013804.JavaMail.zimbra@nod.at>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Fri, 5 Sep 2025 11:21:15 +0800
X-Gm-Features: Ac12FXwkUXz6rL-5DfcSPLCoQbbs0Z-FsPJFhS36yJIDnQdEPM7ZEt30Cl_gtlY
Message-ID: <CAAyq3SZT67uwggdNX99qEc4bwSkUw2U=sCc6mon064D=f7oH=w@mail.gmail.com>
Subject: Re: [RFC] mtd: ubi: skip programming unused bits in ubi headers
To: Richard Weinberger <richard@nod.at>
Cc: chengzhihao1 <chengzhihao1@huawei.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Alvin Zhou <alvinzhou@mxic.com.tw>, 
	leoyu <leoyu@mxic.com.tw>, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

Richard Weinberger <richard@nod.at> =E6=96=BC 2025=E5=B9=B48=E6=9C=8814=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:30=E5=AF=AB=E9=81=93=EF=BC=9A
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Cheng Ming Lin" <linchengming884@gmail.com>
> >> I have been told that writing 0xFF bytes to NAND should be avoided.
> >> This is also why UBI initializes them to 0x00.
> >
> > Normally, after a NAND flash block is erased, all bits are in the 0xFF
> > state. Programming 0xFF in this case will not actually change the NAND
> > cells, as the device can inhibit programming=E2=80=94either by raising =
the
> > bitline voltage or using a self-boosted program inhibit mechanism.
> > Therefore, programming 0xFF is a normal and harmless operation for NAND
> > flash.
>
> That's the crucial question. Is this true for all NAND chips?
> Do avoid larger writes of 0xFF patterns file systems such as UBIFS
> also use compression a lot.
> At least that's what I have been told when I asked 10+ years ago
> how UBI works.

You are correct that there is an issue when blank data pages are repeatedly
erased. This can lead to cells entering a too deep VT state, which may
cause program failures in subsequent operations.

To address this, newer NAND generations typically perform a pre-program
step before executing the actual erase. This keeps the VT distribution from
going too deep, thereby avoiding the blank-page degradation problem.
Such pre-PGM techniques have been widely adopted for roughly the past
10=E2=80=9315 years.

Additionally, JESD22-A117E (page 6, section 4.1.2.1) specifies examples of
acceptable data patterns, including solid-programmed, checkerboard/inverse-
checkerboard, and checkerboard-with-fill patterns. According to
qualification knowledge bases, using 0x00 can sometimes trigger special
failure modes, whereas writing 0xFF is more robust.

Additionally, the Kioxia TC58NVG1S3HTA00 datasheet (page 63) also notes
that continuous program/erase cycling with a high percentage of =E2=80=980'
bits in the data pattern can accelerate block endurance degradation.
This further supports avoiding large 0x00 patterns.

Link: https://europe.kioxia.com/content/dam/kioxia/newidr/productinfo/datas=
heet/201910/DST_TC58NVG1S3HTA00-TDE_EN_31442.pdf

>
> Thanks,
> //richard
>

Thanks,
Cheng-Ming Lin

