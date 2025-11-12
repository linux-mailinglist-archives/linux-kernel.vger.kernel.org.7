Return-Path: <linux-kernel+bounces-897869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0296C53DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8E204F6128
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A8734A771;
	Wed, 12 Nov 2025 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+lODzMA"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313DF336ED3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970384; cv=none; b=o56OfbUtTzmDIymWO9m7rW7KmmqIvrKlLfQgLdHDa/M+yJ7fMOniM8rYtsCGd/nAV9XSFxBoJ3X4uwOCVN3Iq/tjgA+jtnax75saOM0xcHo5NL95FSLudRrI6L9afBLeKCjt/CKA4NqnfQ+/RHFCPgrjRN6Td22gYwIQUDr1OWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970384; c=relaxed/simple;
	bh=VMAUbEYSF7PdWXFDavrRElWyYpN1b3ZWMA2LzFa6Y2k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pb+dTrdZ3J8oBxuKYeslfF6Hk9aLNYJ8V86n53TW0cgKhyANHWqqb/r4jx1GyWAdVxk07qSB+50JwIS/i4m/r7bp5AmlEfVQhljSJEaDeOs3kR40a/XrlaaEvQm/hVbTX8zqG02Hb2Oy9m8DeRdbtd/9qbgCN7Evdb1MPrSlJD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+lODzMA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b31c610fcso995241f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762970381; x=1763575181; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VMAUbEYSF7PdWXFDavrRElWyYpN1b3ZWMA2LzFa6Y2k=;
        b=H+lODzMACjD7fg/L1U6+HbCwcOMolOc0aTrT63QKgmM6SXru/m/q4Ye139eRW2IwHj
         HMFGQIvhbPgv5AavISf1FOsZSsQdhJG9ltjyuoKaSmOIGV7ZYvKiOEHgxXe3LVOUfAIr
         ieL9O//2ZM9oScIp03rc7rXiCknlUlr3FBNGHGZctVfKrz4HqW+ZoLSKi90p/+oE+ISZ
         zoMDXIT6rpsOHO8DzdzwOO9uXhXg2L/ys4MtOEJ/0CiTJL+pyIQlo08T9hySsloZ3dhG
         Uy0l3F2PFrDuGWZ9O7u+fXJy4dbISyK3yY4E6HH5MFyMf4iBDjYR2ynjdFjHqpWGyOei
         0x4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762970381; x=1763575181;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMAUbEYSF7PdWXFDavrRElWyYpN1b3ZWMA2LzFa6Y2k=;
        b=k91TJIELkVGK0QnS5MRot0G37Q1eMw/ma7f7Xnq9w5hOWh2EyZ+5B9Uhmptio47Y04
         cTQtt4RgWxzoL7P/sErQJsztFo2knXo6+jZragXhwJkEahHriMQwHN1gXgqOd6DmZ2kM
         sRGf0nIMD+fd3+Iegdx4buW3Ft8EyCAOfrNyCMmGN/fg+HlbB/zsBQiNjbjXZ28yFHZs
         JM5JYqGK8mi/RutOGvh87qQPXFT8IP83qmR4FvLiUkkOioJrQ0xqefNXBZDw54AIAQB+
         eCqHo7aj2dLp6wj7sYe9RPYhhy3/dvEyRn9Y8wBQzyKhAJBvgw6YydFIR7WuOTcLEOw+
         2SRw==
X-Forwarded-Encrypted: i=1; AJvYcCUe7nnn4i61fCHpV/0KW30nKEGbUz6cD5PwdwOpPDI1RA6MeEF+NktZYEIIpAWyRqSKOqeu6Zapjff5mAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzycribytUtVYmw85FvgFaYCitRtpKLbCr0lZRXIpbLV3GrpqsX
	5x2cxzTKjCTlxI2eoDRkihUK7HiqYMBT4uwgSXQAXoZ1MTfqM/xvXSEZ
X-Gm-Gg: ASbGncs30K6fqYWuNvL5HSfWxsqSJkzm3FBrgpf8fVLzD0Tbvi1Oao8OM/npcp3dWEY
	49Qc85DpQPItlkF5fvuHfwChAbZxTVgGq4sTA/BF/Ep71nPmAUE5duM2C0UDFdo7h4T//dY0AgW
	EShg/pDKTU9hE/HXd3e2ERsUewWrtV6J3ftn37EQ4QpeunNbsc2eZrVBmVMe7t8YelCkYELXZIa
	ovi12Ofa9Tu6D7tC0XPJ9IDe0ycO3jB/o1P5dMCNU/8FNF9mGRUByxI58H4C8xxTcuEQa3M5rh3
	0ckrqdWPaGDCQ3xLF/6YWITYGrKq5KOBgPoS4K/XlkOz7DVw/a02pIUktPHHedmZcgytpbNDpsa
	5vg86nWXSxk4m5rDZaV0fTTjtEqIMqTIDxmaiMYF96KkAh6vo//wjRgKxqX7aHL+9Xwld4U7H2/
	BcAKw5WhcUJrQwO18sQt0D/GHYt3uj66Y3QgQ0C5wi/YD3Y/xB
X-Google-Smtp-Source: AGHT+IF0tXIDjvKHKVJyTGY8/nCli7RyVbquCxKAUvzuud0KSAJ9auI/vjzj6364H+ausPb7LeEufA==
X-Received: by 2002:a05:6000:2dc3:b0:42b:2c61:86f1 with SMTP id ffacd0b85a97d-42b4bdaeb66mr3081729f8f.35.1762970381278;
        Wed, 12 Nov 2025 09:59:41 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm25264899f8f.16.2025.11.12.09.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 09:59:40 -0800 (PST)
Message-ID: <0ec0086b91528e67c9a5c1fe4c27b65a3cc9f8aa.camel@gmail.com>
Subject: Re: [PATCH v1 0/3] iio: core: fix error path in iio_device_alloc()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Cameron
	 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Date: Wed, 12 Nov 2025 18:00:42 +0000
In-Reply-To: <20251112145735.2075527-1-andriy.shevchenko@linux.intel.com>
References: <20251112145735.2075527-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-12 at 15:55 +0100, Andy Shevchenko wrote:
> The series is induced by the similar fixes in viio_trigger_alloc().
> Basically two things happen here: 1) add missed mutex_destroy()
> calls, and 2) refactor to make sure we clean resources with put_device()
> when appropriate.
>=20
> Andy Shevchenko (3):
> =C2=A0 iio: core: add missing mutex_destroy in iio_dev_release()
> =C2=A0 iio: core: Clean up device correctly on iio_device_alloc() failure
> =C2=A0 iio: core: Replace lockdep_set_class() + mutex_init() by combined =
call
>=20
> =C2=A0drivers/iio/industrialio-core.c | 18 +++++++++++-------
> =C2=A01 file changed, 11 insertions(+), 7 deletions(-)

LGTM,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

