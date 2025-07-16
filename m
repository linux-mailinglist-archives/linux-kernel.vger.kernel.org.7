Return-Path: <linux-kernel+bounces-733165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6475AB07112
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C94189E38A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BF42F003C;
	Wed, 16 Jul 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ghJ35+az"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612472EFD9C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656561; cv=none; b=bqEASBcUnZFrPedGrwL59fM0mt6Xqz5I17xaOoLCnxktSd7RBs15U4HUYrplZkt+AJAeeZAg2IQXQDh0b5JO0w6+SebFXEOFMIwDRktVhxjQUw7N2bRtcybwxAGtcWAQWQKfxUUb82HNdj+FnPrhRbp2mIONHZREkUFhG4RSg9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656561; c=relaxed/simple;
	bh=gWNSA5bMeT038SwG770NbaScl1hnC1g1Pzb74ptMoLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYwRgar1gLs4vWmQa+v/GFGJM9tPenmu7GWE9THKPb1uzGUUKvYO49LtPyyUy7bgtjLKqM/rU/Vo1hes30Dt+YPZXD+VihOcsxThNRkx1YlunPcNwTkco7cp2SIve5Ex+6hZWZoK6bBgAjhJXFRsSXMm/LTRyYh+6DIArb3JVsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ghJ35+az; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d3f72391so62215345e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752656557; x=1753261357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DU+chVMZKPU+za4znspG/6bfzEqGboZ2pfvVasC68c=;
        b=ghJ35+azm1Z5dGdCCPB5ZVertZMZVqK0Lqc/EWrbVQpx3G+Zo41/K0n9X2hk3edisZ
         S9uTbkRQb2mUGMkPN45FtMwDvB4fk1Z1vQn83BINL8KmxtnC4TMhEILg+gYrFw4QHljO
         HKfEW8O9Xr9ZXHak4F/ooJPOhcwXrZA5LCaKexZOv5kqImlpWD3QsywpyACL3stWDuwh
         +6uh0Px4e0cwkzZ/q+/kpoqfw1bFPTaoVyh5hqutf4og53sJplxloVMK9+8OAYV2Z87G
         MH8HFf8vlMAfZG542WEoCqn4vaQYhlderjOtDhLtrdFXfsaLwj4+HTVwe/WIB0mkFr2R
         K4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656557; x=1753261357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DU+chVMZKPU+za4znspG/6bfzEqGboZ2pfvVasC68c=;
        b=SvN73ixh2IjTR6tfp04LxET7qup4DtkPmmxYCkLqA3nTX7H9lz5Ny8neETAXbnYwfy
         UV/+AVLXCCXmaio9/pSYbMWGX97WDYCkTkfm/u//EVNxpM08UFHorwVrqxdPR0dS4yer
         IXQJt4CBIBaH0a+arMU31PtyOICGrm4nbzL2DhTrTPc70YUM+JSRCGiKDeBnhsZF3o89
         g+GF3dB71p8OEIXiObgQnwTL6HOOeuRt0dl7+51NqitSsw3P6ncfDZTeusOAKPOxQc4M
         IlqK3PDXSZk3hjz7hV1Ofn1CzKAUUYlyEyCDLZM87GgXKPloEHgtQSkB/zPnk49n8nul
         Oi0g==
X-Forwarded-Encrypted: i=1; AJvYcCXyTyVahtFnV/t/rmpDkiOXwEWpFJZkRJH3FazpBp17Pl94Nre1+en3BBSzRKVRWJ4RpaTxuacXIDRku6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YznvxAMPHyf6TNYRlJe9JWtSaTkez2BruoNtt8EaPHW/ios02hU
	oLZnQ2SgZCshv7BXJM+rmY1n6LPe1BLR6Gisy2erDiNqmcw9ZMU1EVdURxzAAO71CHQ=
X-Gm-Gg: ASbGncsLKaxZkLAoCViDdHp5Wji2JxJmMPXNRQh+ARfmfO85UzXLqnaFyUGZokGS6xG
	658I3hfEri29t+6ff44fGi9AN4fUB1spQAAWscqELuudDojdKqx+sNN2nL/MDWMpEg3shfardjH
	cVcDyuJgyo/CbicvTq9hNTYtgRxbC7eMIS9hf7GfkpK89FAhFiH6Z/gBTrOgURxgnq9IMHgS/Tj
	6r73dskCwIDZLGO3AxWOfQfBzHOb1KGiJUDY2+Ow7UKmvo0FikhnmuomShADzguEvjRO1zR4nlH
	cPA2AaGafJc3MBGgrH1bJCvO6/LE9fT+9F1S1v2RSm/zjvgV+mSbAfH1luVg5UqSl6IY/9UJEh7
	e2/qVMGsA8kGulmOy8N7zNFQ=
X-Google-Smtp-Source: AGHT+IFd1A5c1zO9GBABwQI2kHUsUg+7vssajggMaoc11A3BqmcR80bJTa/022VUfiROeI8C7pZWxw==
X-Received: by 2002:a05:600c:3e12:b0:456:1bae:5478 with SMTP id 5b1f17b1804b1-4562e364789mr20439455e9.2.1752656556687;
        Wed, 16 Jul 2025 02:02:36 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:e8b9:11d7:19c9:41b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f33f0sm14574135e9.2.2025.07.16.02.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:02:36 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] gpio: viperboard: Unlock on error in vprbrd_gpiob_direction_output()
Date: Wed, 16 Jul 2025 11:02:35 +0200
Message-ID: <175265653234.14840.942937667387824922.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <9e72018c-e46e-4e55-83e4-503da4d022fc@sabinyo.mountain>
References: <9e72018c-e46e-4e55-83e4-503da4d022fc@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 15 Jul 2025 17:58:34 -0500, Dan Carpenter wrote:
> Unlock before returning if vprbrd_gpiob_setdir() fails.
> 
> 

Ah, of course. Applied, thanks for the catch.

[1/1] gpio: viperboard: Unlock on error in vprbrd_gpiob_direction_output()
      https://git.kernel.org/brgl/linux/c/5103fbb7b59f7a078284a345d82bdab0f0ee6d08

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

