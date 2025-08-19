Return-Path: <linux-kernel+bounces-776059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC4DB2C80A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD52B162881
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59AD27FD40;
	Tue, 19 Aug 2025 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Gtapy4UD"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEFF277008
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615746; cv=none; b=LGhi6CS9nzeuZZlPNrrIrFHPaZkTXjkbTVfxlabWVDoASIXCkLCJMJeRXSww/f8efEOf5LpPPr2cRg825CPCwdP1lg/t3K6ptEefjBPtzRw7IzF/bbMS9ycvM0PXXGxOsNv3tHIHXPGnXzGbRVFJSXBGT4y0iizK4Xc737/Ip/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615746; c=relaxed/simple;
	bh=UJ/laQvODenSS7FKqK0uE7wzV4yOI6b5LUkxJj66RJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5HMSue5Sn0442E+b2ettvQ0aL1+MXEHrDkQqxrKnFhNwp6xrT9t0GxfjqX+xo215N1yhIMrmiuAHP9mRFQS91d1zQ8BRDCTmFYkf58BEW8akqvplOge36sJULZOlUVLQRls7WbqOTFP0fKuqQh5Gl9Yl9vKU5TZ14fPVuifvhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Gtapy4UD; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-333e7517adcso57468391fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755615742; x=1756220542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJ/laQvODenSS7FKqK0uE7wzV4yOI6b5LUkxJj66RJU=;
        b=Gtapy4UDat+Cs3kNHEXt8nYenuK47I9UqQbFT5e3MW5X2rsC6j2I8fRSMo43jHRlgD
         F7Fv2KMGwTqch1iogPIYDqX9gAEugZ/pwE+HcqD/ETXEJapMhizgRzpTXE96wvgM0Oz4
         DmOkLnvwVdMu8SpRwmQx017Hlup7hhebrSyLs+kzsqJ7u7eTAOhg3PV486Y3g8l11Eek
         HQKprPYQmpEeJSEvYBO3/WLhbMdkjOlE4qwq6eW9ihSQEpBCaZ8LwCx6I8i8l1U06K3o
         z12hDx26gxUF6EaNptY58wR1EO1Uq9cDTFZNoApmXlDcmmk+ohOfepkvq2apiVyG75qb
         IpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615742; x=1756220542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJ/laQvODenSS7FKqK0uE7wzV4yOI6b5LUkxJj66RJU=;
        b=vbUZgD1p2yqBRESkldnsiDAOQw+zbrN3rc19us4/sYNZUAbnpQRaoEwBrUSge3GEXW
         LlOtrLKa7HyHGi5HCMG3zgOI6igMLS79MYK+RqOTy5fMiOAx6KugTusAoBweVJr1ASFo
         k4aFp2/bVDONDNHCWcYMq30vCsV/cU9XPdjsV8FQSwfUGO1evy5nL2fkccpZcbBClOfg
         SrzwZAVFs+ng4QXcO1lD6Ov2O+6pz63Cv//wzqkhacjqEVdiT0U5Tv2jHMiD/WiwZ4u5
         N0HjxP5lNFsmEvVgO2/d3LIKgH4parmUnvTRdiU6Me6NLoy+VfU1NGEiuSwA3wHTKtjw
         ditg==
X-Forwarded-Encrypted: i=1; AJvYcCVqr5zKW6IWzbXA0pGe0fHiWbujfozk8FGqmcjfzoycXnBupLkoKNlK849A2tAe6iispeErBMu9PG5wP6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJw35BXCIANPMh7enApHsbdtHsmITlqXpDFGQFME1ZffEcW/KP
	4GqCcHv/WZuYZcG7+zD5G1UlKQti3lccmI0f9ghWkzuhcR/HkclWoVwDKaOQOopg9q6tIWqy5GR
	+KncvfmhkAex6uza7uaALm1cVMMC0dgvr/2jaP1gKJg==
X-Gm-Gg: ASbGncvbXUj6VUYO0e5wXOVZFC7XfdOQRAy22/kgsVv2MjYPxLf7XspvCPrdjbR3wRI
	kDvJYKWFAMUIqwjsFTo9VAlowbZL/Qxh0ZC6RP+kqEqnmovGH1jhAPo4iNxJYiooPIolQTLywHl
	7Uz+Ebv/j1Fn34jHkSnG7u8Vq/Vs1g3msEfo5BjkhFtILakOnR/NTr1QJ3MUyUClL8u08qVywNV
	U9JVL4sM2a7WZl1cC9TJ1m2ieuoCUDXhs1HrWjutg==
X-Google-Smtp-Source: AGHT+IEQt3BRtkjZ/CEQyRxB5/fQWuPJmmuJup3AesqNZ68WSzASFJZwiqG7Tu4QPuyMPNUXWCO4kN3arXh/DgbkcPg=
X-Received: by 2002:a05:651c:4c9:b0:333:b9db:f994 with SMTP id
 38308e7fff4ca-3353176483emr7860001fa.6.1755615742093; Tue, 19 Aug 2025
 08:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818183214.380847-1-bcollins@kernel.org> <20250818183214.380847-4-bcollins@kernel.org>
 <01eebb48-17ba-467b-b227-96784917c50b@baylibre.com>
In-Reply-To: <01eebb48-17ba-467b-b227-96784917c50b@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 19 Aug 2025 10:02:11 -0500
X-Gm-Features: Ac12FXxMP6uMsuK5LruMDdiY1MXNE_Mg2NbXu81YxUgiHffjOZ0aArC_GNr_vrY
Message-ID: <CAMknhBEbUjoHfN+7sQgwo8eW6u=Qt-Bwvfq4JJbo27oN4D2Sdw@mail.gmail.com>
Subject: Re: [PATCH 3/6] iio: mcp9600: White space and fixed width cleanup
To: Ben Collins <bcollins@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Cc: Ben Collins <bcollins@watter.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 9:55=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 8/18/25 1:32 PM, Ben Collins wrote:
> > From: Ben Collins <bcollins@watter.com>
> >
> > Make tabs consistent for register definitions and also fix width
> > to byte size.
> >
> > Signed-off-by: Ben Collins <bcollins@watter.com>
> > ---
> Reviewed-by: David Lechner <dlechner@baylibrc.com>

I made a typo above. Should be:

Reviewed-by: David Lechner <dlechner@baylibre.com>

