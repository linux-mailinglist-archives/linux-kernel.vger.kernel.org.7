Return-Path: <linux-kernel+bounces-856917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29214BE5711
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A839F1A665B9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AE32DC793;
	Thu, 16 Oct 2025 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAsYphbZ"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D22DC78D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647677; cv=none; b=tLkqPD/VJEEkKHRFozODKsos0revs9tLrdxylt2/lQ7djyY3HulOL2bd23456r3grNgIKIVP1tHWtVmfFpuYa9+keOmA+VrHZGVIotI3s1mUv3TL8VhEOqkgSUvB8oWck63S6ZCEeybWroGFJ4GBeOXpXROXC3IOKBgNN37o5/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647677; c=relaxed/simple;
	bh=ndgdnL4NvZXc2YXbgp6JkfbQHOsj4MuJcCkc5VpFe/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cy2YXW9r6DtRjO7YZeGXxD+/AnVhK/RbdorqqoBISaxQ3gM/6M2BOLRlWwf7BWkM01hUIP8fDTb1Tp+egnPShjwJuP5DjmQrayXOc3GIkyLhalBd3QUqAmUDGQSc68OnpW6VWhJX+6426qZIWZtL1b8f5UylNzEQ8GYidt0wyvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAsYphbZ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-339d53f4960so1241665a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760647675; x=1761252475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onqj4CjIVJRLh43lyfVP55yMWDw9oV4qH8HlU6gjd2U=;
        b=UAsYphbZ4MRTWb6nOF2oYdTwBM7kMjqt3H5KRekV1snBYxE/SwbQfN7wge5KyO/PY8
         83gMgfYuD5ePzwm5dnfRiOovj2f2xMJvBK/nVrcXkk1I9HPIZKOhy4XgxDRYedCwaqSY
         Qt3W+raQA6SFeD8aFEDciCGljFlf9QrF+yuRtUeH8CH3qHO/72boG3SGgxrsPywOz+VB
         tqZ2p9vNZd5epbHdlQJa9zg7dlOtszigehn3JHyezeBbljes4hCBUUZ7C/V6gt6yOCN3
         c90pGCgVX1V+XpQy5s0rVkPoKp+lj1FaBxwjqeblBwmC+mtMPQokFNb3wcWc/26D+N56
         +0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647675; x=1761252475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onqj4CjIVJRLh43lyfVP55yMWDw9oV4qH8HlU6gjd2U=;
        b=NdeiSQwhAsubQPFYmqKqJw8X87DaM+X9tGGTGTDB4m4HKT6n/4vFhodF1kDONyScWT
         oIET91lCSspTPqqKTiekKphRslbnE/7BjdsDDIOoK45etNTyN8UBZsFuOxrQgrfPqrov
         61Wwv8JAXJeu+VD4UNviE7f+s97zgvbbD3rELGKHo1p/jfxsXyn7B4fP2tu2Yt3U9KZu
         WmxeuTVJX+CFfxwWHT0h81QYzsJdUe2cYdhZ8qwGFTyU+WMEb2IFnW2M1+cJqSapsVN3
         zc25mXKT7ya2PFHK6TM/QrVEmlW5bB8e+xM8M95hcsvxI3rr/u897LMGkDrWgVyL3ypx
         o76g==
X-Forwarded-Encrypted: i=1; AJvYcCUt6tG3MdDgh0pJPAdJDte6cw1V0FEUavJ8O/8ozVJLJsSPIPSLvHfYmCX8u+o9hkn1mX9b/Qfp/DR+Alk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2skhHAOCB3UPxoc2zI7p7OQbpISVfrvNGYTn2UI8y6PU6dcSM
	OqWTWFsNHJSqkezZlHpeSSUyG6mQN4bGGM2j6u194LE56XHmQg++wcRl
X-Gm-Gg: ASbGncv1VAVxdCKzBcIFWGV/U1VOuyEVCY6pTZZ3EImSNNvJny0RvhVFz9BToNIZ4kW
	79TaO/BBr9opejXGf/1NT4FjEOFMiGqSG6Tnyckgg009BjCNFxjJ8+AYZjQa2PiA616yj6hMYpb
	GeUn3c7AQaBf6iM00eDTcXSy/FLoi3YtT1NlXuX2BjSO7qp9p4oKw2bMUWR4LogdBaAglm179e5
	PbcJFyFtjOH4FvO9QG8biHfGIOHgG7Lw5yku63Xp6w/ZBKumdQmdbnI9t/3qV2ZnOb/7yXkXFeg
	v/gqNGsfHufOsaQ/PnP8PUUcm6frxBZOTxIA9785IBjDB4WVhkXstt0gnA8hjVqEtcrxPxpAmIR
	4j3eD3lf5mwrbwKZA39WVY2u2tN+/qirej+HTXq+afbbhM9sede1vymtn4cxR0Zk56NU/TPGv6n
	BKSCPzLYViRqWY
X-Google-Smtp-Source: AGHT+IH4G3cPfsZSOD6swv+Nr/r1bSZCKg8w/Ox7KOwwd15eIqRctEk/RfdSNTo8Nh6NWlqwEHC1PQ==
X-Received: by 2002:a17:90b:4b0f:b0:32e:8c14:5cd2 with SMTP id 98e67ed59e1d1-33bcf8faac8mr1245917a91.28.1760647675393;
        Thu, 16 Oct 2025 13:47:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a22bb5b8fsm3746596a12.37.2025.10.16.13.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:47:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 16 Oct 2025 13:47:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ankan Biswas <spyjetfayed@gmail.com>
Cc: jdelvare@suse.com, corbet@lwn.net, skhan@linuxfoundation.org,
	khalid@kernel.org, david.hunter.linux@gmail.com,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] docs/hwmon: Fix broken links warnings in lm90.rst
Message-ID: <dff61b90-31fc-4c96-9bc7-0f8aa8404689@roeck-us.net>
References: <20251016103049.2573-1-spyjetfayed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016103049.2573-1-spyjetfayed@gmail.com>

On Thu, Oct 16, 2025 at 04:00:47PM +0530, Ankan Biswas wrote:
> This patch fixes warnings in Documentation/hwmon/lm90.rst reported when
> running 'make linkcheckdocs'.
> 
> On 2011-09-23 National Semiconductors became part of Texas Instruments
> and national.com is no longer accessible. The datasheet resources for
> the chips are now available at Texas Instruments website and have been
> updated for lm90.
> 
> In 2021, Maxim Integrated was acquired by Analog Devices and maxim-ic.com
> redirects to analog.com. The chip datasheets are now available at
> Analog Devices and have been updated accordingly.
> 
> Some additional broken or unavailable links have been replaced with
> equivalents hosted by DigiKey.
> 
> Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>

Applied.

Thanks,
Guenter

