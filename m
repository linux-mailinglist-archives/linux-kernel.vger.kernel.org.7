Return-Path: <linux-kernel+bounces-745284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B00AB117DE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D345865D2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 05:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0F91F7060;
	Fri, 25 Jul 2025 05:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMdLOQfp"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE4429A2;
	Fri, 25 Jul 2025 05:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753420823; cv=none; b=R2r0faT5ZwgatrGUSnzRSG6/OqoNHJxTfsn9HoM4BQ4yZTe46hPVJ1qE39Hcd+A6l/+eAXq2CoIJauHs38MjpKiv8MPPu8ou1PcWQ+TsccFy4XQZJ3yIlYHx9ymdcgl+4tJTcwNJUOYm2vskRHO+fbV+evvKTXpY/polKE+R3qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753420823; c=relaxed/simple;
	bh=WEET136+AnPYw11pgVjlC8up148t5G8RAovpKhbcgNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqE8F6nTsjYWDijZV9QI2QBYBVWBJlh02XkoM30PIxWWgd1cOETPe/4SpmiDhaJV1G6RbN4jZq3uJ0KNTdR4+zr1JR3rnvc5JXj4uXifNlSeArl7os8GEA/Q6xiQwc+DwNuBXIbTt/nEr0wlfeVA2lUX5vXnAP3e+ceqx/ebmN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMdLOQfp; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-313154270bbso1807541a91.2;
        Thu, 24 Jul 2025 22:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753420821; x=1754025621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nLFW2Etg7f00kiQg1GB1r0zuU1sWnFWDprHgwFRfFp4=;
        b=VMdLOQfp76UNvQknlx+5zeMAljUvtpwywq36byl3FdxnQ9/Gsl34MfHcUSNa+39/TM
         Dmc/1Tvly9xFgdgAbAC7YM7bfbv+XyqvWPLvyG0dNxMyCjgIV39a+Z09+B766flStC6k
         hcCVkz9QaUXYwMg05hKKi4C1sz00SbhxhEGQcTLz8t82DTylvXCWm56QprokVmU1071C
         t4odXxTxMuqHGnEFlmlNn1lCxJfOueRMc70iswoxkCtlAMwrvISixTROzzszWM1K3uUN
         fhT0Yq/5vmRGApcxstuSkjlUy9glEwME0D7PYXxRptCl8T4n5b5CTAi3hY2Vk3bLRyet
         NrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753420821; x=1754025621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLFW2Etg7f00kiQg1GB1r0zuU1sWnFWDprHgwFRfFp4=;
        b=Qg+m/s1nMQW3ZQIJbUlab++FSzgOUCF9XbMw+BDZfFzy+ljAT11y5RA6WPfckD8Y3M
         cdOQMu23DndqVNNmSeK7rD7HEDUPt08SyHQx86OQDXUnwxP4n061VXX+jRrxSkkvW9au
         iGsT20ylGiH5p34qgvxZm4u1XQE8HnJ6zgRU/Sg5pVyDKd5YDBD2EJNc4aLYjzAiR2cv
         zcwR8QDBcC9shNoElS8+DtqgMKwXmVgojhb2hCS2goWZSHLVqycjeNfnXJjNmaTr/qel
         0JoMf8nQ0LJXHsjvj1UUQiD21c+W+448TLrCUrxF4A/HhOG4hyt0/x7IblJoxCkUOUm/
         BQVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdW6wq31JGWkOUs8sg7ne5Z90hV2JL6B1RyTnf6zvjxeklii6Q+sep3jgZEYBQzUyClIhBdtVgUhpHhIie@vger.kernel.org, AJvYcCXxPTl9AaNzp60S9twWqb1rQfvDet+ZdVSGZpvH/4vW1YWHB3PlDFe/wJxjw0svw0x4Gl1IBKM5Yy07@vger.kernel.org
X-Gm-Message-State: AOJu0YxuUJttnOjPwEoDoOVUFSNifn7DJRDamqUp+29u2PcJimVL0cUz
	i6GRNxSwMbiw6A0BwMD3VwoqDKhaXEnOnXZiFxSu/N5vrSCr3aURuww8
X-Gm-Gg: ASbGncujjvKI47vlkiKJEOdNxF8XfqcbOHeDJgBKHYNmegKx9f9/hXMWmSCDlAJLDzJ
	uUldPvS0/nqWNewfJFO+Lvm0e/dk0fl5/pfzHofiuMRld7uDZgqvcysczg1X5wmF9JFs3S8XheL
	2hppK9AX7iIydjo3uj1adEp+06k2HN2d9w0DnR1kvcrpMANbcPu5SyZqUbTq+ukMTT36MSg2FbC
	vposei2YWTG6Q+UptTSrxRoo6hqbJHNd512lHTeSlSUdC0rnDXBL907shiIYX0zqLdtaYLUPljz
	ZCH0f5BO5jioYbSw9FaPEXjBHFy9xzoSDhPDRyalr/Sz1MHvSL9icHj6I/Mq31lV9jkaojhVBkB
	HsLj3YVIzCj1ezpESyzH50HjfBAngx2y2IkDFHzVU6wgRq8VLnu6ZGbsAAUm6x9QseauBSUN/+G
	Y=
X-Google-Smtp-Source: AGHT+IGYNEkx+OPyKPH2NYgCMOjXtnrPHP45w1/H3ht6Anh5i8C5DhT9XfjH7TYWya6okH861qSVtA==
X-Received: by 2002:a17:90b:2cc4:b0:312:25dd:1c99 with SMTP id 98e67ed59e1d1-31e779fd277mr795087a91.19.1753420821482;
        Thu, 24 Jul 2025 22:20:21 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e609617aasm2308647a91.0.2025.07.24.22.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 22:20:21 -0700 (PDT)
Date: Thu, 24 Jul 2025 22:20:18 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v3 07/13] ARM: dts: aspeed: Add Facebook Wedge400-data64
 (AST2500) BMC
Message-ID: <aIMUEhoCXU1C8em4@localhost.localdomain>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
 <20250723233013.142337-8-rentao.bupt@gmail.com>
 <20250724-overjoyed-panther-from-camelot-f2ff4f@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-overjoyed-panther-from-camelot-f2ff4f@kuoka>

On Thu, Jul 24, 2025 at 10:05:40AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Jul 23, 2025 at 04:30:03PM -0700, rentao.bupt@gmail.com wrote:
> > +		/*
> > +		 * PCA9548 (11-0076) provides 8 channels connecting to
> > +		 * FCM (Fan Controller Module).
> > +		 */
> > +		i2c32 = &imux32;
> > +		i2c33 = &imux33;
> > +		i2c34 = &imux34;
> > +		i2c35 = &imux35;
> > +		i2c36 = &imux36;
> > +		i2c37 = &imux37;
> > +		i2c38 = &imux38;
> > +		i2c39 = &imux39;
> > +
> > +		spi2 = &spi_gpio;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = &uart1;
> > +		bootargs = "console=ttyS0,9600n8 root=/dev/ram rw";
> 
> Drop bootargs. You are duplicating stdout path and choice of root is
> definitely not a mainline user friendly.
> 
> Best regards,
> Krzysztof

Got it. I will drop bootargs in v4.

Thanks,

Tao

