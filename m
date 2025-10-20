Return-Path: <linux-kernel+bounces-861625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D73BF3352
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37593A9592
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F5A2F5466;
	Mon, 20 Oct 2025 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VblrGhtG"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F302DC330
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988610; cv=none; b=NhgAE0eRnO0jOxkeVxIHpowH+49P9Nl8s3pGfZUpIBEu0EpeopFohXa76qJJScVEF5FjT7qpdfdy7KFW2cY4fqH0njQMrD9S0B2fEPqP9WpGy5AVJtiwDXRFJAkqL5gqaHZ2nF+j+/NqbKdwCvVIpxJJJHnFuULTYeMT3pAAqH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988610; c=relaxed/simple;
	bh=9GdDL7+3mULH8MsHFnHWRsu7pRMHDK4Pcihd8YMTY1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQ3aE4b6EkrOj1eJyP4rFI+Eowd31ALNWHzEBBR+RsMRqzWMbuvNc+VcnFDo03Gvbhl3QAkjOiPPJseyoEVGDcZLgAK9hV+2Pk9S0Zgp9kWd3tVraIhyRYhS6az+fEFFsV2InZ/5kaYn32poZkttiZDi7zPU4jpsCNo+5CrwDww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VblrGhtG; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-58d29830058so5576676e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760988606; x=1761593406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFZNqT2D+DsLVgY6VgSkl2denBx7SAaoL+y9bEiDZII=;
        b=VblrGhtGbfm69ssIpjv2TWOn+ijpOO53JaiJUpKmahR5auwsbMn/07Zs4gIfq9cE9n
         3Gorffv94xvKmBvC0pcwPN26rJJHDZ+VHC33+NVztcH558wuPA+xFXC5HNO+QZy7b6Op
         g4clcf0spNrzrHe4tZLhJaoelyUCL/sHOkOAvts1chcLZAiKLBynq87IzBNxP3Y7N9xl
         jts4h6IXuLKZiqJGj/939urWXzsXhgMYL8ON90xZRfquCDd7TddzOAWe0tcHTPjqM0S/
         4+yRLRxmGFvN5uM8fKz12BzhNTVjK24ksa5zvazSrMaeNfCYZIq82C9Hx5McaBHXrMLO
         wjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760988606; x=1761593406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFZNqT2D+DsLVgY6VgSkl2denBx7SAaoL+y9bEiDZII=;
        b=qdAa6rMVVqf95zkrI5rPxIdt3xJJ8oyNyZlZnkxPvra2fbljFNmmat9AgY9PnZf4Rc
         xj83VRD/DtMF+yJ697uN1WkZ2rBcN5kXavhnVKPhpV6e2RAnhzVsLT8JPltl7xu6qiNB
         J/VtZIpfS36JU9cb4MdpS7rZjIeXb5lhyLmSAQV3meMldOgSsiBT8JeoL0mSMmRC2Dzi
         VsxRL4xyfyrV4+/OkDj3FADNUgawVl8knmW7SlO5qams3hGI7FDb9RPNTzim2Ae+Ycct
         r13yV/6GfdmA6wOG+zP+2iQZzb3+jXvhrJFfyzAjA01DlBhzwgDT5vv1V9ewPoE7nCVJ
         iukA==
X-Forwarded-Encrypted: i=1; AJvYcCVqyu8FtEp1Y2ayA4L9a0rgciF1iVfhiETSixUyizR2S3mbUm2V833G60XA2zrQESHYCYkdOBQozYdQOBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBRT/GHlj5vovk5IknCjV54oi9LH4WGVpJMJ9n+J1nJjBAFT1N
	tcsJaCxq6SooRz+l3D9novcXiW+eUB2YzJGeH4h9Sq9iNph98yMXiSKrL4rFBtQ2ociA+rvDwR+
	3bJGy/3E80CQ6ELE0mV9TgLjBVSt6OTw=
X-Gm-Gg: ASbGncvEGfjAq7R6T9hbdgKZ2WwdimAvLhwjMW63KimRJsEmKv63oC95ysNSoMsamv3
	oJZrO+wS83+1pmZ5MChWB7ymkqgM1S7dDhVWWnjnpp2xhBV7+KPU1KrJDEVfsIZ9UnId7xRktyK
	Xen4DW2we7JJrqWGGi4C2XuE3S5xgpm/5V4s+yyuAuN55mAkwIEp39vHFDhyr/ih6tCOtOSuI4K
	CfScClQ0gdd56/5LXylS/gqwwZQx62KoHr5Rn5zpEp9/3waR2JkjIq3qBIl4e4TYqMYobBshQwf
	Ysj9TRYVtIP2jAcsSA==
X-Google-Smtp-Source: AGHT+IH8pJ/l725F7jpzit86CNm+iBx7HYI5g7kErnw7UkpgGPy+kn1LJM6uau/6mX+yCgesQsO7k/FLWd0sn0ytGhY=
X-Received: by 2002:a05:6512:682:b0:583:ac7e:4e1a with SMTP id
 2adb3069b0e04-591d8502b29mr4582945e87.23.1760988606107; Mon, 20 Oct 2025
 12:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526-p3450-otg-v1-1-acb80ca2dc63@gmail.com>
 <CALHNRZ-pE4EA=x-7LuJev60=aOwGt2eDf9mGVHWJ8SPGisBchg@mail.gmail.com>
 <CALHNRZ_W6gQknMr=eKEcB6-k5HBBkE6JfJ9LFntX9L+NTo5hUQ@mail.gmail.com> <iiooyryqjbfutvyycrk4wxgkhow42bnks7ndkkqy2zujv47bly@2f3sgagl6yte>
In-Reply-To: <iiooyryqjbfutvyycrk4wxgkhow42bnks7ndkkqy2zujv47bly@2f3sgagl6yte>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 20 Oct 2025 14:29:53 -0500
X-Gm-Features: AS18NWBRKorxOsoZ_E9SDZMzdQeGC1t6Wb2mP6Y3s6-jRK4cbkxihFxXMR8bUok
Message-ID: <CALHNRZ9OTfYqKzP4Dk80q8bFY8ZWF1=bTCBPRuVNJKGNe-L=hQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: tegra: Set usb micro-b port to otg mode on P3450
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 4:41=E2=80=AFAM Thierry Reding <thierry.reding@gmail=
.com> wrote:
>
> On Thu, Jul 31, 2025 at 04:40:05PM -0500, Aaron Kling wrote:
> > On Mon, Jun 30, 2025 at 2:35=E2=80=AFPM Aaron Kling <webgeek1234@gmail.=
com> wrote:
> > >
> > > On Mon, May 26, 2025 at 8:22=E2=80=AFPM Aaron Kling via B4 Relay
> > > <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> > > >
> > > > From: Aaron Kling <webgeek1234@gmail.com>
> > > >
> > > > The usb micro-b port on p3450 is capable of otg and doesn't need
> > > > hardcoded to peripheral. No other supported tegra device is set up =
like
> > > > this, so align for consistency.
> > > >
> > > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > > ---
> > > >  arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts b/a=
rch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
> > > > index 0ecdd7243b2eb1abba9adbe9a404b226c29b85ef..019484a271c396edc30=
200e8592c713455a8e1a4 100644
> > > > --- a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
> > > > +++ b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
> > > > @@ -514,7 +514,7 @@ pcie-6 {
> > > >                 ports {
> > > >                         usb2-0 {
> > > >                                 status =3D "okay";
> > > > -                               mode =3D "peripheral";
> > > > +                               mode =3D "otg";
> > > >                                 usb-role-switch;
> > > >
> > > >                                 vbus-supply =3D <&vdd_5v0_usb>;
> > > >
> > > > ---
> > > > base-commit: 405e6c37c89ef0df2bfc7a988820a3df22dacb1b
> > > > change-id: 20250513-p3450-otg-b947f31843d8
> > > >
> > > > Best regards,
> > > > --
> > > > Aaron Kling <webgeek1234@gmail.com>
> > >
> > > Friendly reminder about this patch.
> >
> > Re-reminder about this patch.
>
> Sorry for missing this earlier. We're in the middle of the merge window
> now, so I can't apply this to a tree that feeds into linux-next, but I
> will pick it up once the merge window closes.

Reminder to pick up this patch.

Aaron

