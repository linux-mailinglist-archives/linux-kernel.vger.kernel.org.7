Return-Path: <linux-kernel+bounces-793585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D111B3D598
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 00:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3051898AD7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 22:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AE824DCF7;
	Sun, 31 Aug 2025 22:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFonVc5m"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED701635;
	Sun, 31 Aug 2025 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756679251; cv=none; b=LfD8NDSioGuMgNI6TBDxv6UChS7hjapChVYuf+O+Ww7KzbwkawvIj7WQNi8bH73g143Y5W+LY1kBolIU/xY3SKHXD09qKs6hKsjdzh8IttWi07GxgKPe+eLtylRnIqJ2RUS1becjtSusYbh3l/imFModqkoTyO79lrceQw+gS1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756679251; c=relaxed/simple;
	bh=mQ8vzewskgWtFGuGzTinZ3CVE7Jg3JZE9GMI4cZ4EPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVirQDLh1236jIIxX2l5tAFPqueewVCyKwEtYTN08+quUDn03xExHkKvmpY/Z8SjKSgMglrCE2ERxTpBSBjtAdQKImitM3ptiMTmIVzVc5xUgaho2vYGpDHBaalyIH942QW+H4DsbPd55SDLaTFjWp3sWgT2qUszaMWk6WqDdpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFonVc5m; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4d4881897cso1481507a12.0;
        Sun, 31 Aug 2025 15:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756679249; x=1757284049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtXLEX6fG4OiQ1TFQzxwhWoQmZ1/yTVQFiUuzOIQ3Qs=;
        b=EFonVc5mjEpt3TlFya1087NNTk6Fx14THgcrNb+ySb33JeCmGrxRKtfRfsF5YLZxqt
         ImorWuApBdRM+XNGBOnYZ/x6ORsEjJ3Yy17X66kpPTSDAtIQIVbqU4aEv0A9zcOiKWPu
         sFdmMItKjGvpzMwCxgfz4din/tOfRzCvOUl0lkLTdbFQe1TQrL+UUzQqTRr2GMvlkCLA
         /WuWfLgHWR4ZsQ+rnfCvn7dAe6vM6G5MBjHZJBF5OwXPiMgErlabT60OHg7NTMwt4+15
         kmLSZMLqmCSHB7KEq/+V623wZ8yWlecJ3AlJ9Pla2FZbk73690QprV/S/1373YlF7He7
         jm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756679249; x=1757284049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtXLEX6fG4OiQ1TFQzxwhWoQmZ1/yTVQFiUuzOIQ3Qs=;
        b=xCo5AmuPIJVJiBRlej+di4+UxsVdVRX1Y0uQzVyuA4oSEx5hjWZKHvQO3LVHJKLVfr
         makqrWZJplMOIe6m7i6Qy6vTyf+MVNy8DCNKpWNvtfVACxJwo0uTdOtQuFm6miaGqNc7
         2UEK2LrJ6hmb+qTCMZsAbuQOXYsMy3xbymK2nukAhxkpgABlbGck3ELjju8k81QnQ3+n
         +A29BJH9k5di0xaQISzox78n51imwge8dFJQvLjCmb3z0fWSmHVDnRAEgC3U0naVPD+C
         sXLEhtpGa/bYuAsIm4VCRAwlZ1combmj4uhbsIX8I3n3z8+WRAct6veVmHTwU/07/T8b
         NxWw==
X-Forwarded-Encrypted: i=1; AJvYcCX6/k0+RwukHr8zylTPvrIZqtFsJ7iYSMF0k4mHgS+Hee0GHbsCrjuqluaYH9SwNSJ7eMC32v33HhW/@vger.kernel.org, AJvYcCXGn17AZUdFSm8POpLLnn05Ci+i9qrnn5AfIPQD83SQUjWNG7WFlmK1jr/ec4P0TMn1mMCfsijA/NRWblPz@vger.kernel.org, AJvYcCXTHw/l7r8YSAvzniLhWBeJeTOw3bUNgc8M35RH48E8qO59FPhRtJZf0glf4MzjUQ/yghS/yFvkT7Z7bps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWOwGWL+/ZFGtLQeuuEg/J3g+UWVEitPrRWaGbx6XCqU8MQBsJ
	IT1rSdJQfHVvOASMm0vY7B776VsleBKWjqnxNy4iHJS9KwjOMJGa9bBA
X-Gm-Gg: ASbGncsVKoh99Y/Cbrr0cheNwIY1eVA6g2oADK4sxdJSExEk6vMQDRmG0Pb8bnY3rEN
	M4c3J2xE/LXMGt+FgHJ0uFUVX5zZpoDhSrZtKtVLEyvm0TbVVmGEJDBetwbUWZ9jpV1zqCXuxNi
	Qq9p/AOtp6cQyAxi6bPIOcwBV7vjyz6G3GAeA8mLw6OEFKBc8CdN2j6eaBiiVZZ3BFjqd+lnEfk
	LHtoLnNAE7f5k8o1G4IgXZTQ2OWAs1bqiN+5NaRMOWMe8xLLS2tv0eb9MyyRTcTpEXi4IpEzu6C
	G0VK8i/UzfGBOUBJ68It4Imo12B4w4DQ0bsgoQOKFqXJLM3YPMKyVtnWcUIv8ewZD/8jr8BDIp3
	xsesiNcY+rLNCuZwZYWNJ5hkdl7TUZ3ykC4hR2z+FxjtsiQ==
X-Google-Smtp-Source: AGHT+IETl0ERRnlP551HimgiMw3yad5Af9X79XGzuAKC774a1G3ZuRHfiqQ15C2CMH8IZ5Zfzy3eZw==
X-Received: by 2002:a17:903:ac8:b0:248:93f4:fe14 with SMTP id d9443c01a7336-24944b1b1f2mr64750755ad.33.1756679249291;
        Sun, 31 Aug 2025 15:27:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903705be3sm86070595ad.18.2025.08.31.15.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 15:27:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 31 Aug 2025 15:27:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: tmp102: Add label property
Message-ID: <008fa539-1f35-45b0-a69e-1ea877b96007@roeck-us.net>
References: <20250825180248.1943607-1-flaviu.nistor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825180248.1943607-1-flaviu.nistor@gmail.com>

On Mon, Aug 25, 2025 at 09:02:43PM +0300, Flaviu Nistor wrote:
> Add support for an optional label property similar to other hwmon devices.
> This allows, in case of boards with multiple TMP102 sensors, to assign
> distinct names to each instance.
> 
> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied (after making change suggested by Rob).

Guenter

