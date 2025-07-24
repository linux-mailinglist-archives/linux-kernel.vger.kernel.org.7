Return-Path: <linux-kernel+bounces-743405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA21B0FE4E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEA24E64ED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61207081E;
	Thu, 24 Jul 2025 01:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcwPJVMQ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54F228399;
	Thu, 24 Jul 2025 01:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753319035; cv=none; b=QPPlFaIUyPL8SmWPRLiNygEpXU8BP+GL38+21PrECDs7yaAyD7K1XIqkE3AdSRvyA03kGC0tbgUk+9/pX2YS005joVopgpWKLtHNLlRJme3h5U2ca/OKk0hPTmj8rFW2dLL+J8bP1DP5g38JZ1gA39CdiZcm3MDpOUsn/Jj+5ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753319035; c=relaxed/simple;
	bh=oxMLT292oAQr1YDKS+b1hRMncAE3wMbx4SjGB8Xtl/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+im2ZmW7/4KRejgGTbACvKrx306pH9O7omQ88k8xV65o7qsw/a9Tp4Zoc3165n5Kt/ZTNMTiCoDLqQs+Wdltzosi2lVqH0cwX1RxLwLBjdU6Arajvk8Fk8dRC69YmDJwbUeZQov+xVD16E+nAlCi1aPrDHLnhAgQ2o0KFiqpyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcwPJVMQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23c8f179e1bso4365275ad.1;
        Wed, 23 Jul 2025 18:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753319033; x=1753923833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ola36QVTNrbThBTKVTSKPubN1/zqev6+ed2BRlcpJ0o=;
        b=WcwPJVMQhtklk6/LHewIjw/zYzKTuKfFTQoSJ/SBSxnT3DUg7cHcBq8rI1b0GIa2BT
         ybwUMqw56UT/uos0bfJC+h+uYaDWQmoHHukHfZEM6QHgmGHOdFu8KmtIJU07EjAraDqu
         MbdOPi9Nw2g6oUNnF9S10MjH/MToIh8zgRZOeI+Jvw/u3nM+pE2W3yPo5ivih25DEGJ1
         2/ZiyWhzR1BDX2oSr0WJ7LgR97QQ/UxCTyUNdIBg2e+A4PxcBZ04ZugYDG6xUCKFT4F0
         jjzr7SUhBX0acr1vps0fhmikTSdnN7vGR0/Pa9UE6DmzS9IMlRDzj1x0hzSypNvKSEuG
         ghFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753319033; x=1753923833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ola36QVTNrbThBTKVTSKPubN1/zqev6+ed2BRlcpJ0o=;
        b=tyWrHNHbVgTyoa8Je5ypDmCXm5MgqHLdhC2shg6rhNzB/HOy6+HYFMlVmSRXPBL6Iw
         izEr/bByomlttOgXTf/YGwHhbs2b2d7EjU8Qsu06oid74X5RfJCKyBz2foCSVGUYE/1B
         I2oB5XEg80/57R31VV+2ADcY7jTgb4OTA4Y/IaxUraEg4o6XsoJAWgFmDq89ApxlAVH+
         QFYqZLkAce/8LGYUWRcPPwz6FzGnJGrap7hJuHS1b8OBXDTKiVX8EGP6KiM8iN1VDS+I
         y7u7RT4f+yxhZHsz7cZEwBcLhimfnXlr2R7Rfzk79A7o11en8mOOLvZTdiIAPsIM7Ybb
         G52Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpQZD2Hb+0IwIQujP0AxFCaGJyWN12ilepfuTvT8ExHTH7X/W3y4PyQB+HZWF7kNNj0pHJa996jORVTpSf@vger.kernel.org, AJvYcCWytgZFQGF0QzHRBujxJxzhtijW0ehtBW4jWszVPGBRwL4TspkRuu7LQOAE+2eGZHDRVJhCLKb1AOaW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7YNC1CLUjz42WYx8xOR1YSP5M6tq3cdxRjh9riKAMKL+4VGRx
	lko+gke7HF74KkIlWpg3dXjacI3f1A2DTG1TzI2Vc7PBNoJiq2cHIN1H
X-Gm-Gg: ASbGnctnv+Yz7yfb8XsVeE27RFn4C10Vs+6vwOKnc9kH2uqxFkB1/ZJVShq76emCKcH
	+xNX27t6GdP/+alk5HOeNtdr49rVJLv6njiJ5PnPaOdspYh6DNa8Zdne9npxq0WrQUNcAocHxCQ
	BRAdCRvq7AqEjsdARx3o8A6YqosWWWD4mbbca1IYQprjKzmA6R8UbqmR2drxwPJGC6lydR2zoih
	x37ts0V8pXUbtBsJ/skh9nNN8qUexOEn6nnaNGoBJNm/8VY7IaGvx36giDBFziH25QXBLJHBpwv
	Wa1P6S1CWBiRAh9fNNPX7ltg8BnUm+2zf7gkPv0oxgrbWrV+oSKWMhMhh9W5AWssn69IFbxLEqR
	caFbAK2y64hqu66BjtPKEhDSuhCKk6wbF6mDvykE4LVLhZe6sDo2peqI2WL7osiEw2iu2hKIdO/
	0=
X-Google-Smtp-Source: AGHT+IFgaOGMceKN4aw59L0CUk1l7GDQtyX01Zhw6G9VYFu6+CkQUCsVgi4C70MsUhb+musZe+qrOg==
X-Received: by 2002:a17:903:1a2c:b0:234:e7aa:5d9b with SMTP id d9443c01a7336-23f9814c6damr56396695ad.23.1753319032958;
        Wed, 23 Jul 2025 18:03:52 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48f04afsm2229035ad.163.2025.07.23.18.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 18:03:52 -0700 (PDT)
Date: Wed, 23 Jul 2025 18:03:49 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v3 10/13] ARM: dts: aspeed: Add Facebook Fuji-data64
 (AST2600) Board
Message-ID: <aIGGdbIX9HaV4dB/@localhost.localdomain>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
 <20250723233013.142337-11-rentao.bupt@gmail.com>
 <d09667e5-992e-4ced-ae30-7a4116a72c62@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d09667e5-992e-4ced-ae30-7a4116a72c62@lunn.ch>

On Thu, Jul 24, 2025 at 02:03:20AM +0200, Andrew Lunn wrote:
> > +&mac3 {
> > +	status = "okay";
> > +	phy-mode = "rgmii";
> 
> Does the PCB have extra long clock lines to implement the 2ns delay?
> 
> 	Andrew

Hi Andrew,

Thank you for catching it. I didn't notice the settings because the file
is copied from the exiting fuji.dts with minor changes.

The delay is currently introduced on MAC side (by manually setting SCU
registers), but I guess I can update phy-mode to "rgmii-id" so the delay
can be handled by the PHY?


Thanks,

Tao

