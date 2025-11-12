Return-Path: <linux-kernel+bounces-898227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B630EC54A32
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C233B19A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B012E1F03;
	Wed, 12 Nov 2025 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgTEENXw"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F116C2DC338
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983480; cv=none; b=G9Ivz9FmfW03oid6MvGioKSUxC/lXeGhdLF5QGb/WDBiDLuheRNC60fwRonVtsYSzmd9LKUAVuAffdaqVep2CLjI14VJw6QqeAkUEO6ENaxWNyk1hSae5kt1kVMBsuzCey+38kYOVZuIbV2UruO/ILVFzt7OhfA0XPwAcWPzupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983480; c=relaxed/simple;
	bh=+bUleK0B8PiE7Fk0SaUF+J+QNb/VCv1zue5xnjCOWY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1y/KUmodGhWzHM/rASdkpBySxOI7ZRosgIP1Wvco5zL2YSlbBxnXj7tqeI5eM1W5OmdrENhgtGcUgIJFo/PrymDTimv54INVAVOrRQIIXUBiduePmMCPvjz0yFz1e/0reHKTKOHB+xoV9PN3wvgAYmRcqazHOMIpFkVxBgTJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgTEENXw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4777707a7c2so10534375e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762983477; x=1763588277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4evj7W1RMWi1DGU6HCMJFRDOHQDQQckuWXz5qPHKAuA=;
        b=SgTEENXwXrs74kTMQbThyXnkys1A6gZLa3d1WHDrC6/TMD2l3++C49aCIiKGttnrih
         ConG8RSwlQk13NCsGtQqov+KrOZsNUVgYM75HAkfcAz370LT4dfAkZlfvbQ+oLUTSvVz
         /0IK3Izf8I/+tjfaUnxK2hu6+dwJCeutLY/oD9wskfeZYLqk5ludPX1Rgzi5uh+GZwmo
         dKbhwxbUT1I68+D2FnxU7+shM+aTpJpqf2JaGqplFyeYbGkybwL9Z7bbgwnOPVabkd3R
         sBlfQa6pBC0YtnNAHaW9iVGRuMD0ssASooVXLxZxlzjb7pg/C58jOqtlL4rcFn+8r37B
         WGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762983477; x=1763588277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4evj7W1RMWi1DGU6HCMJFRDOHQDQQckuWXz5qPHKAuA=;
        b=ZZnxh2u5Rcwl6rihEfuXZHBnu449S/3iTtioYfFpIWCEtXsW0OFpMCYCnuIrgKZOVp
         7QU4g3vM8qnjm1nymhlql+JmOVExSNe4l4x/FGyGebAmr+I7dnE/iflf3uRzUQHQyqN4
         ZR9Y4awdgy5p5z+8MtXBf2k5GZERxhpbTdZk98Gk85H28MaXqhYSh8nJRGwXA+peLVf1
         kNy8uD1MRleCG/dW0gFQavXBDDCYzJJ0wUcu8cvdr/DB12R3bYl3dg1kBUXtUp2tnB9Q
         +qX2V6GKw4/Xb9TJUOsfbDz4HhvWlQ8d8WgXfDS8URD0o/QWfoYCfJ9W0jH1AAXZalUr
         LVMg==
X-Forwarded-Encrypted: i=1; AJvYcCX1pnJVMWC1jaJl+T52F89JnAVoxCW3wKEdX5pxnehrXzmSyCemKkC13E32A7lkqscHVRw1G7CkzXOLQx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTN/hCsBzsWIhKKXf/BbkTPiYJsNampduxe2jPapwxj4SKqGff
	ieUHWxAbqLsO6Pw4kVQwMMLpH54ffrpG0grZ0ofISdMELH9yBgsFyLsm
X-Gm-Gg: ASbGncv6PJW62U0YVjWyy81MJ2v8Opt5nSwtn8rS+wMiCD12CQIyUJ3/LF3Dcfd68Io
	qqhC6Fya93iexHaCQD1PDujgTpvFcIbMQiNIagI7R9No0YbSEJX0ahQvrNqAtoNIxhPHqjo69HD
	AW7U4iWwRSkFCcJqfEkAy1tquNaeDEeCfcB/PeS7EesFMOeFsP1Xk4TMJZpB7/Ob7qDiWps+j4m
	Kkiiy0CcwQoBchvFjgpssMtzTTKZHdwnMe794PhncNPdfI3YdT9RU/Zchcm2WqgfVzN9sPQTmBC
	DXejUWnwKpzsglcdT8CKXcYNXETkAmv7OuqErZaVysKj5wuxtntcNADZROLmJn7PtjtvNLuLlsf
	dJQ3tMj9KG9Tz5CA7eAJaAtMO1svWRTG8yUQ847Q778aBOfCoQBZWil8Dks9FrvL1NSBBmwju+j
	MctsOAKeLeMEOyuqxU13zYdsRWM+5sbaPiKRGJKYcn1MNLfiiIKWA62SC1dGsoD2w4K+iF48uyH
	4nCjMuXu6OYQNX/fsC5YFdl2r8cQwEFcQHUv/O6BgOc6toQ
X-Google-Smtp-Source: AGHT+IFVREUT6iLk315iqZFQJC6ImzRQ9dAqU1Gfy56ootTo9We7Wq3zsRANNkZ3GC+r7RPmOIr7dg==
X-Received: by 2002:a05:600c:4ed0:b0:475:d9de:952e with SMTP id 5b1f17b1804b1-4778bd2ccf9mr9501615e9.1.1762983477135;
        Wed, 12 Nov 2025 13:37:57 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com (aftr-82-135-81-2.dynamic.mnet-online.de. [82.135.81.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e953e3sm54307145e9.14.2025.11.12.13.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 13:37:56 -0800 (PST)
Date: Wed, 12 Nov 2025 22:37:55 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: Change adxl345 depend to negate adxl35x
Message-ID: <whsmsygljixaqh3mfs34fnnlcyptxxxxlsujljawdj7jyl2ce2@a6oshhvsi6dv>
References: <20251031-adxl345-allow-adxl34x-mod-v1-1-cd65749ba89c@analog.com>
 <aQSL0wCr56zr5Y35@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQSL0wCr56zr5Y35@smile.fi.intel.com>

On Fri, Oct 31, 2025 at 12:13:39PM +0200, Andy Shevchenko wrote:
> On Fri, Oct 31, 2025 at 11:05:08AM +0100, Jorge Marques wrote:
> > Change 'depends on INPUT_ADXL34X=n' to '!(INPUT_ADXL34X)' to allow both
> > drivers to be compiled as modules. The user then can use the blacklist
> > to block loading one.
> 
> > ---
> > There are two drivers for the compatible:
> > 
> > - adi,adxl345
> > 
> > * IIO: 
> >   drivers/iio/accel/adxl345_core.c
> >   drivers/iio/accel/adxl345_spi.c
> >   drivers/iio/accel/adxl345_i2c.c
> > * Inputs:
> >   drivers/input/misc/adxl34x-spi.c
> >   drivers/input/misc/adxl34x-i2c.c
> > 
> > To disallows both being complied, the depends INPUT_ADXL34X=n
> > was added to ADXL345 symbols. However, it should be possible to compile
> > both as modules, then blacklist one of them in the /etc/modprobe.d/blacklist.conf
> > file. This patch changes the rule to !(INPUT_ADXL34X) to allow both as
> > modules, but still disallow INPUT_ADXL34X to be built-in and ADXL345 as
> > module.
> > 
> > The following compatibles are not shared between both drivers:
> > 
> > * IIO:
> >   adi,adxl375 spi/i2c
> > * Inputs:
> >   adi,adxl34x i2c
> 
> I like the idea, but I think this needs to be clearly stated in the Kconfig
> help for both symbols. So user will _know_ that in such a case it's their
> responsibility of properly made choice. On top of that you might want to
> investigate existing DTS in the kernel and see if some of the choices may be
> made at the platform / CPU level.

Sure, I will add a info for the user in the symbols. I think the choice
is on the defconfig that the user uses, the driver is a accelerometer,
but one exposes as an IIO device while the other as input (e.g., for
screen rotation).

Best regards,
Jorge
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

