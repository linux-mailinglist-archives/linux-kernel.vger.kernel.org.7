Return-Path: <linux-kernel+bounces-897796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C22C53BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01B8254310A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D393451A3;
	Wed, 12 Nov 2025 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi31aoAG"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACFA340277
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966949; cv=none; b=srodLdI1XkwYvDRxQdpl63K++WZQWwbyMCTwg6XOMpVfSeQ2F9jZq3GtSo2PBC58jwcP0HdBmL5wqmr1gpY02hC4VFgBVtVHeI8n/TWnq00N4ZtzMSfi9uR5q8iXqz2t+bLNwjqSQfGeXxPJbg2dVgKHmJIexanPonGk5m4Dmzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966949; c=relaxed/simple;
	bh=ngNDA+yZ4zTUwtZtG5I6JVuMZQa4L9vej78HoJgmWmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4yNysX2Ir+cCfuWweXsb+VUO7Y1x2BNwmio9SZEii194KUhJqdlUUgW1JE68ZUnWQAyiv4cZnUtYqKR+hyPaWvSqxvZQowxznO7S3l5JnuTfehsuNhOHR6dAyy25klmmX/DeS4DoKSRFWoeKO213FLnJNo9JYbNDvSJtKaKTNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oi31aoAG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47118259fd8so8224595e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762966946; x=1763571746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RpxJUrH68rRTzK3W6ebRdgdts3S5XzYIMF8TSgTuh94=;
        b=Oi31aoAGL1nMlYO4k3gIK/VrlUUSqUjMbWbqrZb7AixDFm0D1S76WZ8MSH94nrotr5
         WWM0s3TvD3/X0uQ4l4iLKW67oW4jojSpXf7IHDoG+sFegGF1E6ShUaMye51AllJj8OyX
         0+3umsknEjlP3Qx7ad0nMEXdHmAV7dLvgd/NWPNcvkxqlKRgnhJkqjui+ybbO7elpsJs
         WYEp/VqK2zaKIhor/YYbPbGAwbdyq4Ga7bYx4dFvJq8LjRD6MOkJgPYTgKjJkarhCzMA
         4qX9jgYRARqD1IIhmZAn6QMqiV9lmpg5mvaKhH5CAP1Gltiy1Q5uyvbijqWCEFNyrNJb
         R2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966946; x=1763571746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpxJUrH68rRTzK3W6ebRdgdts3S5XzYIMF8TSgTuh94=;
        b=EryYpwwHw4DkhbN9I/4lB8PQ/TP1BUkfLnaGm+p5OuJmKqDeFk4dRFTT2OmmK4xGGr
         FGYam1Gwxu4OIjk8teRNFsPobWk7/8eOQTXz/wNdCisgAKb/I3BNKkI8Tnju3Kj1Zdgc
         zjdZw2cztLVPiXIDKLhN6KcF5YY4PQCqFg3YOua4RSSpqKblcfirJL0hLgrT7fN9B2xy
         XLB2XsH0uqjJ0znp5a+eekUF9HLfRsV26hEWlW7tseRKY5IKho8dPzIutxmgAHuwxSH/
         94iN3tHoN4OlmJBurUDj0oslaRA4CyH3BCXM2Sp60T6W5BWs6ZSaAQDi4DzfkDB/KzMA
         LwmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFrsITz/pW9CoEpqb1YuXza1zaQDd+18KkM8FBRjyyNWI2mTg5wCiOuYolCLIKy0j9LzxI7fMW4YOfvwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0eJtUymgvvHSMuR279PxDH/3znUa7xpzntUlDuK+aqHQJtwyf
	KquPJ5mSZd+QGcl/ZdpJUED5fYwG3+w+OmCP2z+2opE8OkQwGT2wdeOYDmL5lQ==
X-Gm-Gg: ASbGnctW8j7GOuQTbEXF73d5VizyB8IrfNfnk0zXE0oHb2yDcQ8F/7fXj8JRV+VwC3m
	X34eFyYxGtCsQGgzv7gIPORprTb0L8bFYWNJI0xUNH30RAcR5z0fwgX4sEEVwSZg+lVB5wBDSGO
	swwgjumkyKOeScDcKtvoTSBgmYswl6RUvAF+tB90zWDcMixtfTx+4efm3dKU+Av0nHl7KzTfNAz
	9hbKapxPiVNcV469LR0pVRLg0M1znbXNDURWN4NB7GodqfM0NsomH/i7wv0oa6soLE8364U6nDu
	KDdP6ED7l74xum5Nf0J5EREdFSpbbcWzqp5UpQ3NOj97Le+SIQohs4+7ikaqXyIGUgRdx5+F6By
	88k4WpQarA9lOWs+ogNCv2UIClKBdyRMUKpP4CsYPIaNupkxxNQI+4Vg9P5wIqixa9qPNS+1/lb
	CeG9ODDD/r8ZRUohYDNjPb6KtwlINGJ9dl3XyxUL0XgwmoJsIVBQzUAoEaMn4IWhhFNCTwuv1xs
	RHlYTaPlWNcKp1LPl4UJjJiNIW+X9neoPAI2zGaYrc=
X-Google-Smtp-Source: AGHT+IF3A2FgIRBiOzC9kR2tSI0jG4eAs6wb/P/xtcFVm2dyctb5r1FI1LpdlWldxO25ClS2vaHfKw==
X-Received: by 2002:a05:600c:3511:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-477871c33damr35789965e9.31.1762966945872;
        Wed, 12 Nov 2025 09:02:25 -0800 (PST)
Received: from ?IPV6:2003:ea:8f26:f700:b18b:e3d1:83c0:fb24? (p200300ea8f26f700b18be3d183c0fb24.dip0.t-ipconnect.de. [2003:ea:8f26:f700:b18b:e3d1:83c0:fb24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63e131sm35578303f8f.20.2025.11.12.09.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 09:02:25 -0800 (PST)
Message-ID: <85f7b9de-9f00-4238-878b-6ba73ab01134@gmail.com>
Date: Wed, 12 Nov 2025 18:02:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] r8169: add support for RTL8125K
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251111092851.3371-1-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20251111092851.3371-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2025 10:28 AM, javen wrote:
> This adds support for chip RTL8125K. Its XID is 0x68a. It is basically
> based on the one with XID 0x688, but with different firmware file.
> 
> Signed-off-by: javen <javen_xu@realsil.com.cn>
> ---
> v2: This adds support for chip RTL8125K. Reuse RTL_GIGA_MAC_VER_64 as its
> chip version number.
> 
> 
> ---

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

