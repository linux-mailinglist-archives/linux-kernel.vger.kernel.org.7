Return-Path: <linux-kernel+bounces-858043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D693BE8AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D42C4EAFAD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2916A33031C;
	Fri, 17 Oct 2025 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7oIWL7I"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AE932B9A1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760705534; cv=none; b=CvWefS5HTCfxkk89FtQCgPHb1PS8XmTdHA+BuBkRux6NbU/o1jo5ONJ7CTQJvQeHi9gXFTCk2EPi2MvoI+2CVDMblcA98CAPLsTbgbV+WDJ5Jr0FVQUFV032ZLiZJIU1Y8j1pkZKvrSrn4bBMm9KE2Kh3bABO1VGWU+/mrzpP4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760705534; c=relaxed/simple;
	bh=zGnu1o//e3bxZ1ijfWOYdQqIB9ZYrFiOJVInbImT8Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFzKDqCrCbBHRAjVOjVu+MXi4BJ6xZHhRrmmc4IBHDtYyTZEZUBuECnE2Ex1qjuabJKbptb4i4nUT9H4QswkrqQwSahQiMyh6fER+okD7c6OY3mMxZOYx2rQIcNB/bLCI5TsXsqvxB66bjKj0ER519VmbJYBvBwSk3n7Ae1FxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7oIWL7I; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6a225b7e9eso1326810a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760705532; x=1761310332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GX1z7rpYYkyy+tiYD/wTVd32X+5BN3gi9AYpbkqHgFk=;
        b=h7oIWL7IwCLGHrBimR3oMBZXgeCMZnN/XxCiTCPU2CcQjHnOCbi1se8kasJFdoKArG
         VuTLLnjuwDxUYNh8aWwEH+7qpxlHfAwSxnZvwX0uW24CSGmQ2kETgOU7sjwcbeZGZWJO
         exmU+rU/tetqEfyrM70o5nkN5DzeQ5DaAUoWdi2PHbAWCdtJCLxkeN3tESoxeqpnxje3
         haFfBcI3t65wtccqVw79YUOUWyx070KV2fauJ66JjhQXj/aomuZxXLqJfW9FLFwophTe
         hpOuHnPq5GD5pzEdbGCbRXsgqjdFWt2VvEPA8jfBot7eh02dDc7lCIa9kp8Gb0wtMMFZ
         7G3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760705532; x=1761310332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GX1z7rpYYkyy+tiYD/wTVd32X+5BN3gi9AYpbkqHgFk=;
        b=MTXH0G7vKoLrUpzD4yWhih1MKGMi+7s6P2SLCYxlTLWuU34WwTiAnCXWahNgZiPcrQ
         xjC0/Aif0oZ1Ccm3xX9jjKa7Mxpphs8xqIpz93FUi0KZ6D1XsfHkqfnMn2p4l3dt8RJy
         VO9gY6sxzsuQCh4HjhwqXOpovLTtUJQrV/+jN0tq1UhMG6+u5+pjSITsQN77OMHAdjQ+
         f2LF/beOl8neescPJ4Oy6w22TwgndI1X6mqamj3EUDK+dpMi7Ku19zrkZ9Pf2S8lwgu/
         caT0QN6z/EESO1K+sFR1sdzIzaBNJ/pgnxxm8x+kcYiN2oISNVXjqY1VnQFVujMJoFZ9
         dtSA==
X-Forwarded-Encrypted: i=1; AJvYcCXVgz5z2TtPNEVUjiRNeA9fFuZtDr9r4/0xroA4k84uM4eFAthu76SIg7q7H0uTjjvz/0rGqd368prv0vA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgx2Pj0klqzZmotnAS3TpxIXOIBOc+cc8vua/W83TENDZ7KUV2
	106eo8rO+70tJf3v+MP9wVAuyQFlTG5O4JMM7ySF7UMg3A17F5+fTHAJ
X-Gm-Gg: ASbGncsva70ZRMXQVW1WKUOF3NaWGQZKEeiJfsQSrPBO35bGqcJl+X3YdY5Vzdn/9h4
	dsb91R8KMKtaLb9h+aciWV9AQr8tc/3GBLo4PLiDy9YTUSq7gnv1EyVQ50m69UK34/JLj89ZIdI
	2uBQlDomRmF4TYAmquW1HgYss50OZLkQzsaA9njB1pxwosQM0nO6hEgvLCpK4VsGhCyHJ1Lk4hg
	KSNMw3/rz/Z0gTZO8CwDEFp1BH2UeEyHAvGNa1KGqZsutfmRGg86A1miOBESkK+cOJu2erasqWZ
	+Ro+JY/VEiNXbCh0kuO/biR5BrCKL5DlTmqOhr6Bwv9gD0zesE4IrNcx4TFMTJ2BKw/k2liGHed
	/ZcNVaYp/51Lq2q0jm46SnBSGxjOn21pUVAlnA0xDjVMUVob4tFkVwwr5lYV9+v5Dd4Cv2/nBrm
	f5OhbKSPNYL6ld8yv9iDq5UHg=
X-Google-Smtp-Source: AGHT+IHBD+b3NB37DW1NNJU0Y7CRgNRfgj81Km3ty7iNT68DqbwCZ3dOZD5XoX8w64DGClNML1SwEg==
X-Received: by 2002:a17:902:f642:b0:28a:5b8b:1f6b with SMTP id d9443c01a7336-290c9cbbd49mr47303555ad.21.1760705531800;
        Fri, 17 Oct 2025 05:52:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb6522d67sm5481626a91.5.2025.10.17.05.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 05:52:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 17 Oct 2025 05:52:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ankan Biswas <spyjetfayed@gmail.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, khalid@kernel.org,
	david.hunter.linux@gmail.com, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 2/3] docs/hwmon: Add missing datasheet links for Maxim
 chips
Message-ID: <bfbbbf63-bd7d-4b2c-9e03-a3d3c3db04b3@roeck-us.net>
References: <20251017105740.17646-1-spyjetfayed@gmail.com>
 <20251017105740.17646-3-spyjetfayed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017105740.17646-3-spyjetfayed@gmail.com>

On Fri, Oct 17, 2025 at 04:27:17PM +0530, Ankan Biswas wrote:
> In 2021, Maxim Integrated was acquired by Analog Devices.
> maxim-ic.com & maximintegrated.com links redirect to analog.com.
> 
> Missing datasheets now available at Analog Devices added.
> 
> Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
> ---
>  Documentation/hwmon/ds1621.rst   | 20 +++++++++++++++-----
>  Documentation/hwmon/lm75.rst     | 13 ++++++++-----
>  Documentation/hwmon/max15301.rst |  8 ++++++--
>  Documentation/hwmon/max31827.rst |  5 +++++
>  Documentation/hwmon/max77705.rst |  4 +++-
>  Documentation/hwmon/pmbus.rst    |  4 ++--
>  6 files changed, 39 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/hwmon/ds1621.rst b/Documentation/hwmon/ds1621.rst
> index 552b37e9dd34..415d4c3043a7 100644
> --- a/Documentation/hwmon/ds1621.rst
> +++ b/Documentation/hwmon/ds1621.rst
> @@ -9,7 +9,9 @@ Supported chips:
>  
>      Addresses scanned: none
>  
> -    Datasheet: Publicly available from www.maximintegrated.com
> +    Datasheet: Publicly available at the Analog Devices website

The "Publicly available... " text is intended to identify the web site
if a direct link is not provided. Either the text or a link, but not both.

Guenter

