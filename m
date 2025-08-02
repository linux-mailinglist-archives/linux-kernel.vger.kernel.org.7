Return-Path: <linux-kernel+bounces-753998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EEAB18B84
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 11:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA047B10CE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 09:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45842036FE;
	Sat,  2 Aug 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fjeg2Ipm"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757DA1F4165
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754125362; cv=none; b=ugiaGTYVJitr37/ZOGB6LbQBpHuHMBSeQL9Zq3r0HLTO0TYJE9Y0Ou59SC9Nh5ZQVSrUvQ6DJYKrxzXpiw6ff6n7rbCRwIC3J2ZGJswuTHLC77LQ1P34t+6FikHYgdFzcQCFHKFCxOdyhaFvoZAuOegmK1oDrw4xs3mKYbmOpoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754125362; c=relaxed/simple;
	bh=tE/ycKV78Xqu6awmy1vGaYwLfvEhozTkRG8Leg5kafA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M70YB0kSTynJalj08J9m4k1FTmu/ZiFsBlUTVz95VF/awKbbEXpTnJBDm/Qb1bO21rbmrb/Yv3w3x0GocgPsNp85Xy3uW+xA3uR3qArTGCDXmVEf4ccjSNItRc3+Zh+c9wh9CJmhtF4OZ/alMqrqWoSqH4DcfWonXRvdvaZzBiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fjeg2Ipm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-458aee6e86aso9087985e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 02:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754125359; x=1754730159; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U/dnL5CfASf7BSwg8zUGgo87QSvNoaNIJBZuuBOd20Y=;
        b=Fjeg2Ipm1nAlUTzjt1e5NiFfCrabjd3DsGqN1oUa0hD+0spmCClkG+MZBoLSSDrhJo
         eubaZlnwsB7qt9nRxG4eQ2fGG/eDRG/D709GNjZ8SC+8Pu80szPf+jyBbVt1/uTZJAYp
         pfES1rgdIy+iTJZi5pbw/D1qfzRdKJJ+C3dcKQTnjl+e0n5ysDsIVaAxPYEBn0XSseVS
         0jgEBV6+p+uqBtQ0Z6CPbgU8QCE6rZT9pK4xCdjVIq1Iidno2AlBfeK+78UyZ/H1v3AH
         JqiJPGhBDMDCm4vmyvWpFvpEZk79csXEvKd50q0wpgPwj/9YDXP/XIc3ev8etpadDkqu
         IA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754125359; x=1754730159;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/dnL5CfASf7BSwg8zUGgo87QSvNoaNIJBZuuBOd20Y=;
        b=MY5kZRvrXjRHTr+eZTFcliA/tRdiyZD/t2w0hziAWeeBIIjeRn8kqhfkxY0NXfel3Z
         5tRxWJfYWrZiWr3qlVKG8kRGqfZCqwFqXutcuOXETYeOJAVWyPDCVFF0Jwx4W4kWUS2j
         434IhctktgbFHS81EYyFompQrhMdQrx7qOIszgds0VQEaaikBoSCQ8sw/sTV8IImB3L3
         TIZMDpmWH0U7lW6duyxe+glK781zoYfe/Mxpa+5Yt4HSwLSCwg4v+AaiCGX/xkOKpLax
         oVHfXygDBentGnBPSp45iPKQAsl8g4U1zDzMgnxS3cvitcIGfLhHUqALKJhuW+LEvL4x
         colw==
X-Forwarded-Encrypted: i=1; AJvYcCVqKxH2/hvLyuxrqdJ7LGsFiu0o4rBhQqsVKytR6+39YmNQEObq14OPYGUccZAZ59cCpmd+OU4mYqvmX0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYO4yUwpFi6Cz6SwggMiIfukhFnzXEtm8svOubK9LX0xvSFJpN
	qAPl6tsuxK1MM5oVizll8u4fDz/uhMM0WfvLC5W3cMK9XIFHSkTptJkWhp795b84Hg8=
X-Gm-Gg: ASbGncvbrXAl0bL3AM54gCMduCECSRvNoY85Y5QJfXLa5N4fQ2m3t34RwSCsoUc4mXv
	QPZtlPoxo/7P2FDIELMcahSicbW7Rh31FMP4tYFg6y4okf0fQJPEnybMrfObyVWiDdwKM7LZjci
	+t8AU64ZnNn68gvaH+otCwClxDTvzOlX+3y0KZAISWSmksuRw92H1L5lxHK3nHSoZjjYbKJLo+4
	S8wMNtk/6AoCeER9QDSkCN6/rk4xIMw1AExuf6UFn01TcJaMn4XeEmq+ztLUOTWyvKOfmXA3WDg
	mQG8E9Unx/gPqpIBJnkfJtGY9t3C1+8nWexg3U0Z9PYxQ7DL3laOVDKfBML+SfToQkpQImX5rdw
	3pDIoKJZjtGi0wswDyf5lPaafoXw=
X-Google-Smtp-Source: AGHT+IGD1hqwEMqQ7r+1+t1Ud4D2Xaj0ub7nD4dO+TqiU68vja/VuwOkDoIJFNO3HEop6/QEYJVv+w==
X-Received: by 2002:a05:600c:a46:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-458b6b30363mr15584125e9.18.1754125358709;
        Sat, 02 Aug 2025 02:02:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458bd5a1148sm6429065e9.0.2025.08.02.02.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 02:02:38 -0700 (PDT)
Date: Sat, 2 Aug 2025 12:02:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] media: atomisp: Fix incorrect snprintf format
 specifiers for signed integers
Message-ID: <934c7ffa-1386-45a0-a4e7-f2b93cca6370@suswa.mountain>
References: <20250801160023.2434130-1-colin.i.king@gmail.com>
 <CAHp75VeDt=1=9epJPQjzfyyph09bov9UWWwpaAXgu01Egf1hag@mail.gmail.com>
 <10626b28-9619-47ea-abad-db823c01bb96@suswa.mountain>
 <CAHp75VdfZwmRzGAeN7rLoab2oT8eKyUF1mUGj4d+y98jZS7EHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdfZwmRzGAeN7rLoab2oT8eKyUF1mUGj4d+y98jZS7EHA@mail.gmail.com>

On Sat, Aug 02, 2025 at 10:45:49AM +0200, Andy Shevchenko wrote:
> On Sat, Aug 2, 2025 at 9:32 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > On Fri, Aug 01, 2025 at 11:57:43PM +0200, Andy Shevchenko wrote:
> > > On Fri, Aug 1, 2025 at 6:01 PM Colin Ian King <colin.i.king@gmail.com> wrote:
> > > >
> > > > There are incorrect %u format specifiers being used to for signed integers,
> > > > fix this by using %d instead.
> > >
> > > Both of them sound to me like the fix of the symptom and not the
> > > cause. Can we simply make types of the iterators to be unsigned
> > > instead?
> >
> > Making iterator unsigned by default only increases the rate of bugs.
> 
> How? Please, make sure this is relevant to this case.

You're suggesting that he should change:

-	int i, j;
+	unsigned int i, j;

It's just bad advice.  Making iterators unsigned makes the code less
safe.  It leads underflow bugs when we do subtraction:

	for (i = num - 1; i < limit; i++) {

Now i starts at UINT_MAX.  Which I guess is fine in this example...

But it also leads to endless loops in the error handling:

	while (i-- >= 0) {

Making iterators unsigned is a bad habbit and it's bad advice in terms
of the data that we have with regards to bugs.

regards,
dan carpenter


