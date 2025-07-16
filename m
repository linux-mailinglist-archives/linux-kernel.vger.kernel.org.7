Return-Path: <linux-kernel+bounces-733732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF76B07856
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D151664BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69AD262FD5;
	Wed, 16 Jul 2025 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSa3yVn/"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8150208AD;
	Wed, 16 Jul 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676918; cv=none; b=YELnX8gUqems3UHiWuvqwCFGBCz+kqcYvyzZQHlF1r3BWgGVzGfJAau8qmyrcx5Ic1pHEzqVoEt21Zguthocq+SW5rkwpY6EiMAEhNdGeiDmriezuLG8INyMc9Rn8dKmXmREJ1NBxkFebLUgrm313fD9yvmCn2ilI2aZQDap3Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676918; c=relaxed/simple;
	bh=lFPHEHn8FO64LpPGdlmRUTz/8ppyFHalaL5CD6vWlgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naDDm+YX4wsD/J2P3jXGn7Til94JmK21BOvcANTZjBEcAZrp7UYb0sULJaX1sw6Vo0/YpHZi/jPw6a19YanIzq3EnYRfZ99URoQf8HFH05VEoa7RPjPv6ZYWyNkDU4R+f95F9/x7vE+ZwaqI0zWtGq4HDPXnRRzcYmVzxI781N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSa3yVn/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c3d06de3so19693b3a.0;
        Wed, 16 Jul 2025 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752676916; x=1753281716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbIiA4Lrn5lhcE4V8wonAl/f7aSLqrLYo1bemfK45Ok=;
        b=SSa3yVn/fQKLrpJEIkSX1Zcf0gxuR1cnOvbPTZ71vHKYPcJFDEwXYFB/WAqOzRdN03
         ZmVqc4Fg4/VTrTMaQzFXTu7abyr2/c/LLi5Yc5XMAZ4OChl+ysouCCUDa9I/g6IMPXl/
         Iy7TgDX4jY8DdB2nOc/2DhuN5wQjkii52J+UTmFdySavgadxnkc+oo5MK7/s8bXx3dPQ
         z76AyKikrwxoV0r5ZpoulzY5mRCSmSjI8Ho9TveFvdiMRuxOfrJTjYL/0vAfx25sUaeH
         aTldEeEuKLmGfX9ittail3abKd82ofWUw4G/PEsTqH0NrruWpJMzvYn6+vgyJosAO6O1
         VXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676916; x=1753281716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbIiA4Lrn5lhcE4V8wonAl/f7aSLqrLYo1bemfK45Ok=;
        b=vXFDkBNpKZx2lvj13pm/OyyvNeRDWjPVMsdj2wsjG0QxT/JR/7NnjktUvYG+O3koGN
         TYgXycZGpafCkXQTDyEWGuRXVoq1Jn8om4hgyDiqT/2JQKC7egpr53zmQyH/W9TiUseA
         b1rHxlyhNYpSAhsrbu+CBIH/On5ORyaOt6k/QU1qnsVV36IPu2bMA821su+C4uOc0XYW
         ETpagS737uMdoXCGjk4uoIZTjl62bC3gsIkaC6XUBbnsAV3DYabcJDB87HsI57taMJ+C
         47S5MWoo1Lz/9kebpncuKwpRbRQMlNyu8qIIjkSM2a+XnKYrjyCuNEEuApc1R8xa8tWr
         FfRA==
X-Forwarded-Encrypted: i=1; AJvYcCU2ozp9M9832PBLLMQNEuwmLGwL8BckHqUE2rVhMC9RQcIw+WFHf8W07C+8QmmERIevkPG+RtpOiXOr8PQ=@vger.kernel.org, AJvYcCU6xZWRMZUkFv61e2pmQYr5SCd9WOoJUq/TMBnPd3kCdr1m/X+DWzoF2XWgh65+fRRL/7oR2O/0g7lm@vger.kernel.org, AJvYcCVbaMjzxznaH+KXfdMRdy6Ep8Pc8UuW1vnCRxF2GmrPV1oTvsJncEAVC4L2cNfe3MJHQczR/7gWTnQdmfxp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9WXJlupF2gbw6arrpU+MR+9oNHSTNO7uDJBoyIFvX1AlN1kub
	VyuREBWmkt578HnhO7RrIxe8ZI9M+8uqnBHAOtAV0O/eCYasQJbnvAyF
X-Gm-Gg: ASbGncuQOEOAVtHSAYuky/NWALfQwKuCgUpF7cFRC4HGSfBOjL0e10X+UWkzuDDMAlR
	TI91an89O1bSDCaD8fAtLH6cCLYTI/jOVjZtfUXm8F+sJY/L3fHq4KJLwBgHCFfg8B7OuQI96lQ
	UWRfv2E57raSzigAdr+2fG3WkpZjNzQ4nGJGaQI3ZUM5VyLLhNtk0QYyFhbNlnjrHFafDAaWcNb
	iCMgZC6f50uJ+HCuVrTeA83KuSsIg1Fp0i2QCNBlTRd1WD/qtGH9DvtzdYIXZX3MJyT6OSxu0Ss
	9SXvgwidgk3KX2HzObgvJPy62bXoIhF/vIqfYBX6dfalVS5a3N90u/LjICFU42oYgrkrV01YdXZ
	u6MKpM/6uW1MHyL2QK7S5agkoyyiJcIc2lKY=
X-Google-Smtp-Source: AGHT+IFImA08aof3XwI/kXP2dr24zv0EdH7as17SlX0fPIgLzV66SUkcwz634chn804K4HPRH45x+g==
X-Received: by 2002:a05:6a20:9188:b0:215:e60b:3bcf with SMTP id adf61e73a8af0-23812e5021bmr4863282637.30.1752676916164;
        Wed, 16 Jul 2025 07:41:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4caa9sm14210175b3a.111.2025.07.16.07.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:41:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Jul 2025 07:41:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jim Wright <wrightj@linux.vnet.ibm.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: hwmon: ti,lm87: Add adi,adm1024
 compatible
Message-ID: <95638555-309a-47d7-bc61-d8a4cf821afd@roeck-us.net>
References: <20250701-dt-hwmon-compatibles-v1-0-ad99e65cf11b@kernel.org>
 <20250701-dt-hwmon-compatibles-v1-2-ad99e65cf11b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701-dt-hwmon-compatibles-v1-2-ad99e65cf11b@kernel.org>

On Tue, Jul 01, 2025 at 04:00:41PM -0500, Rob Herring (Arm) wrote:
> The adi,adm1024 compatible is already in use. Add it to the lm87
> binding as the device appears to be compatible.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter

