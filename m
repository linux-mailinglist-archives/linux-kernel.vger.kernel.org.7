Return-Path: <linux-kernel+bounces-752374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4517CB174BF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C5E1C21D49
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41F42222D4;
	Thu, 31 Jul 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DNGdjfJY"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912C121FF27
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753978282; cv=none; b=WCgmqvNAdDujrlrzK+N0io08taA73pgoT/94uvXc/83YXBTVwOCiH69/AVC0svRjGk2o0B86XO9jdOYy3Fn+trEZzC0i2dGIavhWSsO+hl5yIp9pTlmWcKdl694rAIT62DjBJi/LG7T59qqgA41NcGP9RBXVwddVIFd3Epsb1T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753978282; c=relaxed/simple;
	bh=XPJtLkScF22u86bMP4SDqxdWjENN1xCpfKx6sl1lASQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRvBBLMP7P8sAYsdrN7VsdPkYuHAJ9AaBL+2I4yOJhoyy/VD7SmUpMpD6HqCSOwLcjjE6L0U4lnjcEaHEI/aALJlGhiaP86bbKJsr54c6l7kChyuiIEUz0iveoeJIPk7U3ARJ01TB+m6xnIjMv2bebP9HNghB+uRn5fMsCsDHk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DNGdjfJY; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b77673fd78so438316f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753978279; x=1754583079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0pKCmCd/yQbFcsUErfFrwExl3US45KhBWUDTffbqywQ=;
        b=DNGdjfJYyND1WvAdr24uzmGbCBLFAxhJ2TdwwXIh8eLYdPAc2FYY214OF889L3SL9+
         2D/kHjcj0YVamjJ9HAbHOyhwr4bHXrB8SPBfqzBNTyy3LDIMvoKUSSeK2/wr/hbLIp3i
         2jiyYrFLlGiXOqqphN6LF9Rh7Qqa5/5lH8IX4ScMUW3Hddo6ieURNX3kJmuUXh9epdWp
         AIRTMk+PK27zrAIFAbN+0M1/zXXwXhYnb80/Id4KzKIbu1+AhhOtSOMvAK3R8aJo+Jvf
         h2tuAwNT7Ju/xeoS/nPTyhIRk7GOFwMhVL+p74pHPQGT7jFL9izX4rMOLHah1OF9s+S1
         sNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753978279; x=1754583079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pKCmCd/yQbFcsUErfFrwExl3US45KhBWUDTffbqywQ=;
        b=C0KKb1aXeIKW7YIRcsYLrB3AsH0Q5H0nSlCcB8/Y8SLOHAhjQG7KY+3aSGm9aFZ84W
         +F5b/ikcic+/YS2K9F8vjaAodfnrwqTbxc/uIBpmi7kkP3zhw6ANdhBMLRJ+fCLapV84
         CoYSwWSe1ZMolKz0TKuux2KDAubJfmI6EKAVLR3/MgjoHT4TeE7vedr+9ISYzhFutoh/
         NNM8gwYckWLF53UWYA2Ing9IBWh+zd+BTBMzRqaK7VL7FgLkTdg/fcXSGKFIBktb73In
         OrKfDsXnLAlcR4dTnHFlDzHicbaa51jrNR1CpEFmLnvdeHpPKR/O2am4GEC8pgR+2W2Z
         ZlFA==
X-Forwarded-Encrypted: i=1; AJvYcCUFqlO5qjwqca2gsj6mjh7qgJUL4ULVTQnCZBF4BszZFR/XamzMR6+KYB9jtVzl9HUNapyMcntjLoJ77nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhOGYeBjBN7c4ef3+b3I1pOmD3xk8mE5r54BVSRcUmAKoWwMY
	9BEbv6NVOqxp4UFIhbuj7L5enDOO2jBwVdVtmJQEIc1SLR/VR9CXmYrbkL0PukiBBdw=
X-Gm-Gg: ASbGncviWFZkQNxX7QjqvM6sGqoi1WO21T2lA4glXlstj0mz9IezJVliFRXgxzG+h7q
	QD/QwkrzqLeaUgufaMqERTjAiBE5PKCh8srv6F+qSprr3G6ILjVeHKkcUOZdI+66dznomemsI2M
	iiwCh5pgNS/8XyZhrBHStVZCGeDlh5k1HMqQdv+2L3AZv18sud6x/xsR/elz7g0Wke7y7QirQy3
	S3kSbLbrP2wNmaUmVPjzZY3DYn6emNJj4JkJSE/VchPd2GvR18zOAzaLhO/g02ZiuvZCFrX9Bec
	1Fk30bZNQDNQ1dELBqEptrHhnDRolxkGpP9ORd/rvN4J1FcMhKB7zOjSMcARyU9jKp3htAlks3X
	rOTVOxerSDS+Hk0oDLLhIDb0OE4I=
X-Google-Smtp-Source: AGHT+IEs0sZIeJXRDqHX2Z8CbdsVOdwVXngFwlkweiuRMlQRF2qpDns9PvEmRvHFDIc5h3NClMUWRA==
X-Received: by 2002:a05:6000:2003:b0:3a5:2d42:aa17 with SMTP id ffacd0b85a97d-3b794ff16e3mr6281554f8f.31.1753978278819;
        Thu, 31 Jul 2025 09:11:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a2f03sm2779242f8f.72.2025.07.31.09.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 09:11:18 -0700 (PDT)
Date: Thu, 31 Jul 2025 19:11:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [bug report] staging: sm750fb: Fix polarity assignment for
 vertical and horizontal mode
Message-ID: <dbd2df69-27cc-4fd8-8e5b-78b6872d5d16@suswa.mountain>
References: <20250723192528.77109-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723192528.77109-1-alok.a.tiwari@oracle.com>

On Wed, Jul 23, 2025 at 12:24:31PM -0700, Alok Tiwari wrote:
> In drivers/staging/sm750fb/sm750_hw.c,
> the vertical and horizontal sync polarity assignments were incorrectly
> ordered. 
> The assignment for modparm.vertical_sync_polarity was mistakenly using
> the FB_SYNC_HOR_HIGH_ACT bit instead of FB_SYNC_VERT_HIGH_ACT, 
> and the horizontal polarity line was commented out or missing.
> 
> This patch corrects the logic by properly assigning:
> 
> vertical_sync_polarity -> from FB_SYNC_VERT_HIGH_ACT
> horizontal_sync_polarity -> from FB_SYNC_HOR_HIGH_ACT
> 
> Please let me know your feedback.
> Thanks,
> Alok
> ---
> Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---

Did you find this copy and paste bug by testing or reviewing the code?
How does this bug look like to a user?  Please put that in your commit
message.

This looks reasonable to me, but the patch is badly formatted.

1) It should say [PATCH] in the subject.
2) The body of the email should be the commit message.
3) the --- should only come after the Signed-off-by line.

Try applying your patch with `git am` and review the log to see what I
mean.

regards,
dan carpenter


