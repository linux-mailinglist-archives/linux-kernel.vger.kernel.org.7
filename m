Return-Path: <linux-kernel+bounces-840489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8DCBB4895
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E5747B7179
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E484725A33A;
	Thu,  2 Oct 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5j44dFY"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D1B1DA0E1
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422476; cv=none; b=cSAzsy56Lw1fNUQxxX18Ew6u64Iwo37o9QznU74PtZ3SGbOK4VjysP/YbwraQGAVbUnMg5SYpp7YokuBdbpiaanw3FsXfKBdZ+Fnbv7NvisoEKB5dUp3svZq5BaX1t1ikQ+Zb12q2TJhMGgpcblD2RoDVEOxdZFHIngWo7gP4V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422476; c=relaxed/simple;
	bh=6P8PdpETu4JNDLuK6zlPSVTpwWgTkevlM36iYzRTPwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtpRZa+IqRntbJya4zu7VxT0OBHhsovpECybaqASJ+j0neYIEos9JIr7s4KVNGe21arLGRgMC+mhIrn1OuS/kUB8Yxl+utbb5NT60VuCzvH64x6u6Hi263i0GNXtbRle6TonH6uQqiKWPTSeciCwOQdDE/GjU7OuIx9eDwRrfYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5j44dFY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b55517e74e3so1416793a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422474; x=1760027274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MIx1cgazS4vSFCcdU3NLCPECgs+mJUW/PomE8mLbHI=;
        b=B5j44dFYWUOlHCn/pCvYEdl74C3TgzANfjcctywXm7qJCtjGENvdQ2+k7HFTtFfjxy
         hyHuiYguqujKmN8OBQU0ISjPnii3SNHnFzwk7t+kwrIHv0okFylgjjwVm9RWlPNPYfJM
         5iYqFcvvz5QZuniwyP2echa82fSwjtzqeDdINbSf3CxFWfl9wxQzZlt8Xz1CkXN3alcn
         Gso7/SHGvP19TN54axD3Way9tZv+muvdDdsxUdIL+2+qREldeilLw6NioTEyuFYhlkMz
         FllXGWQCCZPVEDJi7CA9/zeofB858kSq690ZroBxPHL/EgeOAJm0q+uC7jrLsIbXYNO+
         HYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422474; x=1760027274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MIx1cgazS4vSFCcdU3NLCPECgs+mJUW/PomE8mLbHI=;
        b=GVZhM4kQQqmGnuRemG3f8T1eqE/ax3OHNGieiVL55xlC/9p0ZIiYItgbQOl8rfvL9l
         mP43UzBZaij+zNI+f8qNMwGOcT/GqXO3SDnB2s58OJ+dSrkq1ikZJJtQ00ZqMJqdZ9+n
         spl4EYdsZWqJVXtrSRL1An98qw8PVB1/Lt85LVLmlXZUQH5ujW2VCGqGwuFTtupqQNjZ
         jOrEpG9aoS5oVFikZwtVCYNgj2sq4sbghiK20IkFWHh/5y9LIQn0WGtxB/TVZfHyAmt6
         U1aqomGI8iGTx5XCqgMYyv5b1dgqz5Flyv7TYveG4BXpjJ0OdhgfyIltjltRZPX6SMLi
         VAxg==
X-Forwarded-Encrypted: i=1; AJvYcCUHEo6GJGdFSsnSEguVEmTvvPSmvzSQkDq9AUr7D0mNSm8cX96yz58B38XzaTgMwP2a78K5XfnG/+Z2GVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwryMlH1/m+MSlWAeIS9u+KxuBDkKwcezGbk7un7+peqU+epCR4
	zXsVmQ81JY4eGF+I/3mS7N5FGb73mxAjHQqbo2urFdMCufoaKesRRQefLIRXFhC3LcWsOD9Lz8J
	9OniKk34/5HLTuS1D0IfXnGa0ECJQUYE=
X-Gm-Gg: ASbGncus0kKQ5XSurK1c+NMUfq8zvit5bMTwZoCfJzEA6CKPZ8TT/KfiqeEBDj6oRz5
	8O52rmuM5rThCjvSuY6AtJnU9AkEaKsvIdD3iRFLxwAbdhpSnRvx7h38AoYma2MB9s9t6R+wv6Y
	MVoJm40wmC3gBfrQJx89jZWJH/VhFdiiI/nmtb731hSY2/LHhzKPnlWk/jec4Y/jnkgk9zE1+C8
	LI3V3Izf3jnrbl3RlLvQuCDm5mdF3A=
X-Google-Smtp-Source: AGHT+IE264pwEl1Py+B5Xh9WvrM0/n0gzZfa2yw7thnQZLAo0gAAHCDysz98mjnnKEJ1frpS6mNIZHS1sZMZP+3Dyfg=
X-Received: by 2002:a17:902:f54f:b0:278:bfae:3244 with SMTP id
 d9443c01a7336-28e7f31f073mr119647195ad.54.1759422474219; Thu, 02 Oct 2025
 09:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729141142.13907-1-e@freeshell.de> <20250819-sushi-change-1254c2d2a08d@spud>
In-Reply-To: <20250819-sushi-change-1254c2d2a08d@spud>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:32:49 -0400
X-Gm-Features: AS18NWBxdQwDblikz4B95tTiZeIyNZADBMQZlumlTwR7d0S68rpJfqzNjYf7xEo
Message-ID: <CALC8CXcAGobb__cs65bPT-vL-YVbpG-4f0j6FuiTgANFY7uw=w@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: dts: starfive: jh7110-common: drop no-sdio
 property from mmc1
To: Conor Dooley <conor@kernel.org>
Cc: E Shattow <e@freeshell.de>, Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hal Feng <hal.feng@starfivetech.com>, Minda Chen <minda.chen@starfivetech.com>, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

E, Conor.
That white boy you used to play paintball with.

On Tue, Aug 19, 2025 at 2:13=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, Jul 29, 2025 at 07:11:35AM -0700, E Shattow wrote:
> > Relax no-sdio restriction on mmc1 for jh7110 boards. Property was
> > introduced for StarFive VisionFive2 dts to configure mmc1 for SD Card
> > but this is not necessary, the restriction is only needed to block use =
of
> > commands that would cause a device to malfunction.
> >
> > Signed-off-by: E Shattow <e@freeshell.de>
>
> I'm going to apply this one to for-next, to give it more of a chance to
> soak.
>
> > ---
> >  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/ris=
cv/boot/dts/starfive/jh7110-common.dtsi
> > index 4baeb981d4df..b156f8703016 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> > @@ -290,7 +290,6 @@ &mmc1 {
> >       assigned-clock-rates =3D <50000000>;
> >       bus-width =3D <4>;
> >       bootph-pre-ram;
> > -     no-sdio;
> >       no-mmc;
> >       cd-gpios =3D <&sysgpio 41 GPIO_ACTIVE_LOW>;
> >       disable-wp;
> >
> > base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
> > --
> > 2.50.0
> >

