Return-Path: <linux-kernel+bounces-830680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89234B9A4A4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429363BEF56
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDD03090DD;
	Wed, 24 Sep 2025 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUBiMUp8"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57949307AF6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724699; cv=none; b=KgkUzcCoUIUuii/K8Ppuqr4I9whbRRhyAdSJgw6ev3UTSeK2n8SDytsfyR2Jwr9Nbwb8k7lhpMnBII2LW4RrLbq0Zqk9VuByF2Jg18drmIYWKnhT9mpfvg3HyiWcmka3Sy8ZKZ18sfDpAaUGqs7c/PlOix5h9XCPUrEve8fyYdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724699; c=relaxed/simple;
	bh=z4kOzNKrt1YHasVRJGOjxknq262Dt5Qz+bhd7P3hKW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tudnWVMQtdv/Glf7S/zlX3fboaqNK1KaR11EspZyfj7LW4d+Puved8YAbWgTYm6cXE3HMgzG5npLYSgeIv/GaRPcrCtTDpnrdTjy+SBf83N+e+AghXybdn0u4NLp8x/h/YLD2X87/MAI1Jalx0TfsLjD/KKRNMv8T27YaBM64cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUBiMUp8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-271d1305ad7so51230225ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758724697; x=1759329497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FKs+A770otT1hMK/+muE0W9EUNGUj8tGucYnsoqh3w=;
        b=OUBiMUp8eU8cP4tTldTSDz8HaBnzEjFkVN5VM6444aVpCHpyGZ8K0NEsDoRY3vW41R
         HnqXg4OMxuhYwta0IvDhMvA6cBXPoiFp75dEbby26G/m4ipXoBytvbs7WtyxkP0bPQDG
         l+CSmjNQ+co03g1SPLU5moDmqgdNVXiRuSbRxMOxlMosgvBgkJ6Yo24TQnE1C4EClAdY
         CLanv925t+TqJdyfMMQqoe7YHcAX2ZpaDx/aekzRgSMyY3OH01d+MmfhEzpzGpiWosCN
         i+lSzciJF1iESeY9shTKM+7CuDkT0w0ZiNwJmqu7aYv47AXiwUA9skGh6zVgE5jEqyu3
         PVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758724697; x=1759329497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FKs+A770otT1hMK/+muE0W9EUNGUj8tGucYnsoqh3w=;
        b=CBgwWH+do9eKUqVWJPAjDu6sTnr2RN5PGc9ZYspQnRpMaPwtGvvbK1wxFB9DM0DNXG
         QAQTrVW9UyJpeCCko9BizIOunhG5y6jhZrIiJQXK7W1rRZiJdiU2c9GNcvr+xpfTim5j
         uqIrWM1MjaxpZ/MQ7AY6gXcJQoeTai6ziVOAvknt/WztHh7Tb6kXComV15dNEm8BLqUI
         4HpozD8V73cHQoXAthv5/CsAYptlEPOMLFyf0s6qaJd24I9frGqVuwmwo0jQynP2xwPM
         Nkbxz/vL26L9tkxZuHiNPQDwUfy+B+TlkewP3lnj4zVWVW7pwlEVBR+v4m+wEUYkgPTc
         H9MA==
X-Forwarded-Encrypted: i=1; AJvYcCXa3K1KYuA+U12lpBcv6sZSTQcLfLX+joNp8XoEe67A0U166gN/JcSS6DrFQJLjZxAx1pGR0G1/au+7BT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/k/SKZVE85sDXuEN1ZSjDcDusgSGiiwlLme1S9ys5KMwPC3V+
	RraBUOzK7G8lLEkZIWU6t7m+ZoS/8l/h+CVqB7ywJFQWghS0Qy+g389cSBDK0O+t
X-Gm-Gg: ASbGncuX4aXajElwicVbv2LsJWTwARJdxh9W3RvKFF8FL8CnRl1sGv8f0nOTgJBOqCX
	heSZxcQ+NTKLQw7pbyOaPLh0vBCUMUF7rv+jgzp4kWh0mxbLSkkSfzaGH7wcQn5Ifng+ogX/bRB
	cuZ+71RaqQRNsHMjWQBLWnkgGgxsKMo3NCRlNE02eSLFBOlWFo28Hv/5Td3pIdNjM+/MUQEo6/A
	3ALJtfRHM8iI9KbTqVnedM5Lkcf1zeGKYhahIK+esboUm4Jjv8VX2aAoG8JyoA9aMTNov4m5KQD
	Ci4ApIbJHCA0gmW4EZwZKHLWg8DmoCAZSAT7e3yQaXueaG/bg0McTpZfJJFxsBd3RPu/aYXhKl/
	FGocqfCng2tA1IX7tjGLKL5cXkamz/FQOQjI=
X-Google-Smtp-Source: AGHT+IFnWLOdHL6EKD5bcnYki0oGZdxMqsJkwwvFoAddBVqOFVNBl9Ak/lLPOlpJgM6fEJ+dHVv4Pg==
X-Received: by 2002:a17:902:f549:b0:24b:62ef:9d38 with SMTP id d9443c01a7336-27cc34502b6mr74638195ad.19.1758724697443;
        Wed, 24 Sep 2025 07:38:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269800531a0sm194313035ad.16.2025.09.24.07.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:38:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 07:38:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cosmo Chou <chou.cosmo@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jdelvare@suse.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, cosmo.chou@quantatw.com
Subject: Re: [PATCH 2/2] hwmon: (pmbus/mp5990) add support for MP5998
Message-ID: <a3658e9c-6039-4591-9ccf-c429bd900803@roeck-us.net>
References: <20250916095026.800164-1-chou.cosmo@gmail.com>
 <20250916095026.800164-2-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916095026.800164-2-chou.cosmo@gmail.com>

On Tue, Sep 16, 2025 at 05:50:26PM +0800, Cosmo Chou wrote:
> Add support for the MPS MP5998 hot-swap controller. Like MP5990, MP5998
> uses EFUSE_CFG (0xC4) bit 9 to indicate linear/direct data format.
> 
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>

Applied.

Guenter

