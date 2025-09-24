Return-Path: <linux-kernel+bounces-830701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02152B9A53E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31A44C49D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED1F3002A6;
	Wed, 24 Sep 2025 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvkujbXU"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB87CA4E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725251; cv=none; b=Nztinq8noYSznD7oMVugwHQiiXo7A+R7YMZBMMtxMrhtbTTerlYAX2743pePRIhA3NsIgmbvvNOajYN85hpZ7F4ZaB4g5CpY1bd4f/eDKEAMm1690veUhm5o8iwju8iXk5Cf7eVBQILNsAXl0MacV1x44R5L3hsrYhvdfLHkVYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725251; c=relaxed/simple;
	bh=AgDrnMXXXJYoDpwAwUvpBn1pSggFOiq/LNM+/BWg5jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II4mhQM2xd+8Hh+ugdIDxILZcs+wI6fNGUC4oIk4UJLIwETXUUs0vrjxNu9jAxetHLc3qJHhf4zD62IDf3LJx8nYt7MO/VEnh49Q5V9mpX+Mg5z3ES3BIFf+HPSby9f5FfJi8Gs2qDoc6+pMihQkjczBWLGGmFGEdTa4x6KRuNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvkujbXU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77e87003967so2830628b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758725250; x=1759330050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuKXuzOjDOxictCX/voBvqBpBAsKrQMGlOEziz1SDD8=;
        b=LvkujbXUSLTMAgY9TUy7P7PDXfgPB0X4TiO6u2qxgoKhnQrbz1VygPkM61Oz9olJkw
         uFfbTd0s8j7Cd69nI+TXslCoZBsFnaWbrHfIOqE3K5XU5JSHcpU1HmrLImPy0Bl+6yzj
         GyTkUo+Lb8OCO3EsRl8uz+kVwfvCOxFuMw5s1xI/W1hm3IfbEbrvPcZysxHU/aCcOnEc
         21aTFs2Rm19+ndOaR+qEl0FJ3FzkZ7pfNDA8REnbWElRxVS7hECaxfrabEQGAT57YAvz
         xDwuufCyZCX7zmHrKLKN6H17AjeqX5jtF82MzJvqy2EF800HODRfRXdkuoV+axOAhJuv
         Z/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725250; x=1759330050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuKXuzOjDOxictCX/voBvqBpBAsKrQMGlOEziz1SDD8=;
        b=VGjv42jw73hETsWzykl0OSek+WDi3CC/4VEaDv9M0JBh3bA710MW6yCLYq0JRc5Vp1
         v/8NCFlUtNpIh6xnG58dmOkddbsNPqFrZa/ti1tAojRrvPBdm9nwZnxueie524Q0pneZ
         wMdwzotxDkP6i3KUUwE4sm50lnMEAuodlAHb048UNMvrLpHJaVfhkX/ethSx39YBBw9a
         YhWB0bsmJFpO0UVNvIkO2al9ymnLSSu+gcIe2ShH2IyniTKmMDNi1YTefADgCnPwTEr1
         n5xoISIcY0YNj4HNuzPJwSG5FHrdde+qVyRnVvsTdrc9l5fiRZR03oQkoMNiIhOrnAji
         D+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWWoysWT7JLpYSU7/JzLUCgBvLixdBjHqCUznVgQemS21NbXbGIwh+JlJKOY0MA80oteQe+qEk+605wg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztARCu1sRVfiqzQ4ImUUaPee86lvpwyMAOZK5oQSoMRS2LW3Uh
	vyBE/JKgQSZ+/y2FCHuELQQ6C94YlRuDnRPr0SxRx1U5UkWt70JHV/7Mzm1v7oj/
X-Gm-Gg: ASbGncvFuLFVMXUOcrg/lG5naqrLkOfeF2BFKI2soTBac+dmjzHRNiIzvtA9Qu/EEor
	L4MFsUyviAcgiV2NlL09o7vYsoOvpl/4MndyQCwZ/1aPMXGFQ4pGBY5yngxncqNcF4LhGJd1unk
	1c7bhwzu8jFvTixpNnnmbjVOvEGtZ/8yf//pwtbuJswlXhGMKD4XPd4ouG9wHBtCE/WLQ9+kO46
	OuQarQKLhLNIZ9D+ItClx8910Nby8s/+qXf83JmvjlZjKb9zVImyk+lgV7sYBRxSNU9XApnRMgE
	mVesUP4klvD2HapchIVFEGtuxLqzPUrZwb3o5u+7nN1wqZ7F6Peg7SRWEGFxiKkAQrVuos9Y/uQ
	qoAIJZv22ocj7mwtUOUxJOLhAUN+p6NA6D1k=
X-Google-Smtp-Source: AGHT+IFFBGlyzzgM0DUwXPrRh1qzXutsF069Qhxcx79xZS73ltfaw+2FZsIv8SJjT1C/iB/wc44oeA==
X-Received: by 2002:a05:6a00:9a5:b0:780:f6db:b1af with SMTP id d2e1a72fcca58-780fcea2fb2mr222078b3a.16.1758725249706;
        Wed, 24 Sep 2025 07:47:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f52c4e905sm5563011b3a.18.2025.09.24.07.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:47:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 07:47:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: pali@kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] hwmon: (dell-smm) Move clamping of fan speed out of
 i8k_set_fan()
Message-ID: <964da8dd-449f-42bb-90df-5ecf4b2d1e32@roeck-us.net>
References: <20250917181036.10972-1-W_Armin@gmx.de>
 <20250917181036.10972-3-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917181036.10972-3-W_Armin@gmx.de>

On Wed, Sep 17, 2025 at 08:10:34PM +0200, Armin Wolf wrote:
> Currently i8k_set_fan() clamps the fan speed before performing the
> SMM call to ensure that the speed is not negative and not greater than
> i8k_fan_max. This however is mostly unnecessary as the hwmon and
> thermal interfaces alread ensure this. Only the legacy ioctl interface
> does not ensure that the fan speed passed to i8k_set_fan() does meet
> the above criteria.
> 
> Move the clamping out of i8k_set_fan() and into the legacy ioctl
> handler to prepare for future changes.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied.

Guenter

