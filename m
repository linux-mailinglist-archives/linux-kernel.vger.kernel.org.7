Return-Path: <linux-kernel+bounces-830676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A30B9A47A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19D317AE016
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22623308F05;
	Wed, 24 Sep 2025 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXWTUPow"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A48307AC2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724605; cv=none; b=Tv5fbznh1oOIoROUA1P+CTbhH+NSiBVvnLwv7QwTEC5vKtMQADTaujQAkw7nZC8bUIVyXwtofe9y7AEwwxJMR65sszdrsnsSNi87utYgjE7FtrJb04WM9rjGfmdt3zc7rn4UqQ4X+U2Y6NJPw72jyfSAPiWIdnbbUa3E9In0I6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724605; c=relaxed/simple;
	bh=VidlVO50el1H467lJApxsWJXJg6s6uikstqa3zxjdVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlRjwf6KVaeAEw5wedNBo5DsPd8uSDui2dpxQxUqA5xvOh1A9Ws2reiRvOP/F+KDa1c5JsnioRAWKEUHGncny/xfwte6WDwCvAauWssUHW+Pi8zbZ385SwaEJoyXxymr9Kuoq9mR10TFBhzwveSK2VL0GnteaBRlqgg6raJaJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXWTUPow; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b5516ee0b0bso3950354a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758724603; x=1759329403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxgE/VwqMUnmRpk2sPi0rJ9F4/7o5NXDeAMdW4raKNM=;
        b=BXWTUPowVR1rYmOJKOswTxz5Idb79j9b3HcjQTtWHPOoT/Nsmr7L1MhKKUTyKHDCmc
         hY8VkTQswu9ZLT7Ur1tV9ERdtSNyXzMCRjw9QD6B62BqkrshWNIgYihDi2kKpstUhSAu
         KBS9yGyIpWiuSSAqRGJ6pkKoVJshiwn+0rZ3R/PTSUQF9apW6IXZWzl/Xuzv6H4JuYZn
         lOWgyEwwn0EDSZvb7+ep8ri0SwmWdlymVX6pOFrFAdG4vUQn/HM2SqD8EgDbtK/Bdo4K
         KQF0c0Ew2/ujlNOnQNlox5YDrE7D7g+yuKK9mgBgYwkhPT1KL1+Lqo3/4A0vhXzD4c3b
         S8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758724603; x=1759329403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxgE/VwqMUnmRpk2sPi0rJ9F4/7o5NXDeAMdW4raKNM=;
        b=eGYGMB8oKlcaAGz0Mu3eFmo+BAvjAonmK3p0lMerP0pEez4y247Xx10hpJQPabiROI
         f3wIik1O4JkE4oInYEeLvOxNL/UmmaoJ8TBAIwAP5oyqzpOBJcjoTHgmrAw/xfKNSb3i
         s28FuziUQurt+Jw6Q51Ni7ShIjp4KKIUHCof/2ZDRAr18eTuGqsfnmFCRebe9mX7GmUd
         hPPhu1mdcMEEPoto5o/eTjVpbshRT3cvhUqgXZrZQ2XHgDCpllrlZmZ2WN4O+vh3avqX
         tBcuylMVF0zareJh7Ka1AfI8r5ze2hnOgmXmOnKsE3LJdlMAExtB0j+mwuYV7j3rkViq
         JP3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9mqVu1pAwArmETw8iYy0Wasac/CPpybowxE1jczRTk3DobYyoRuFwfCHbQSvE4bU63Vl0yVm3cRk4J4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+30V8Ns363Ltyt9xYHGsiwKv9GtHPE3gU3ztDOtPy0nfGBzn
	MIa84RPfjPnX9VTiGaFfxL2biNELpl6nJir52HfanDdwCOLXVcFZ3u6t
X-Gm-Gg: ASbGncsMRQWtSTO2RQ1Ray8QnuQLQvblyRydfGgYpOlOdDKxsojsf2C53DZ6VokbvoS
	VVnLRl7wL2nSt2ZfgB5fD5umYrAabu2xo7roAf+De3+so4aNtXM6wwk4cM6Leza5k0XujIhF3hx
	i63gQCGIi8qRmcd+rKNdxJ0UcrM3N80SajmooPbhxXT3tsY8aVnywrGfCDmGOOqywAVXvAt7Yxs
	2gdsaz6tsaOc4MLUTB1ZGXxOVzJORPCJV/jLGfEtmVTXDRP/PIuEkokU4a38jxDRJU7TPtq5pcO
	Gao71sh3fi+6BCNHc8fANGCIamoUKkpPCyf4BkxzINMex+PqfEUWEutnrhBp90Tr6XKN21aFvi4
	AEWFDWg5cqCj3hWHCRK+dVPNy/RPZoJew+pQ=
X-Google-Smtp-Source: AGHT+IHu6iImWwWebqU0fIT3geKZJI+vQ7lMRP2q7Y6UID/bj52Rxi/gS4qRBD5nGfGbcaTqWRH+Jg==
X-Received: by 2002:a17:902:e5d0:b0:267:a231:34d0 with SMTP id d9443c01a7336-27cc5623567mr78793925ad.42.1758724603132;
        Wed, 24 Sep 2025 07:36:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980310ff8sm189560205ad.110.2025.09.24.07.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:36:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 07:36:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cosmo Chou <chou.cosmo@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jdelvare@suse.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, cosmo.chou@quantatw.com
Subject: Re: [PATCH 1/2] dt-bindings: trivial-devices: add mps,mp5998
Message-ID: <4f57c182-d3d1-4007-80db-915ebbb6fe1f@roeck-us.net>
References: <20250916095026.800164-1-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916095026.800164-1-chou.cosmo@gmail.com>

On Tue, Sep 16, 2025 at 05:50:25PM +0800, Cosmo Chou wrote:
> Add dt-bindings for MPS mp5998 hot-swap controller.
> 
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Guenter

