Return-Path: <linux-kernel+bounces-759594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8304AB1DFD6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31421727AE4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E9E264605;
	Thu,  7 Aug 2025 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXXN72hp"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3430B218858;
	Thu,  7 Aug 2025 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754610632; cv=none; b=WupUwW02T9SOd/iyN8bbmb3EXGtbWQ3r5oNFWKXjpJf6IfHdKo30GRhyL66s4/Z2NyqWw9Ix+AosqgiSLkZzLowz6BjRXDQysUPnHZ0hOXsyAfILNmJ4RG/nDR1NHJ0ymS67Mwe3kwf8bNSQ5NWEwMIQP+SysK8jv0TtyapH9Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754610632; c=relaxed/simple;
	bh=9Um8y979Wstd2tE41eL1s43NBn6jLBIMxzoP0FMR4Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzminSlDRHYkRSb9dalqJBqXks32luO+CDN4hFqzTCmkR7eBnSje0Bq0IalSrQxR0zIVmphJ+YiphdXvnY+E1+Ysf+Fz6Ao1bGGbnBgVorbVkX/2UA+A9dDzHkOCoZE1hUs7Y8n9ZR8YuuzoIoAF+4zJH7z1KBK1dFD9y4nETiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXXN72hp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso1575452b3a.0;
        Thu, 07 Aug 2025 16:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754610629; x=1755215429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrOaXML2hSKoH6wUuGCJEAATJOKIVpI0PkhspY3E9Bo=;
        b=MXXN72hpba1HIneVKVe+ZAluXm5FGKxwnVFX9eb2fE9mpVoZB7c/TQw6LI/ffSJgbj
         oCCJzsJjT66AJB9aNiem5k3HpNUPbz0yc1mEwDYKQnb1COYIkKdfiUN3vSGfTVdaQeLB
         gQ4Z/BJmDetIlpz4OjAkkJ57/liiP+PXgX0zCWZLB1Zdsu0yCYHdXjHUYpqtj/vmHd2X
         oDr5VfmtM/lTJVT2JK+7Qz1AEXn2FelfWA+iPSYFAkBxH1GVnFT7EcSBRL7lBQ9I9XFC
         No4QkFuzCRMDH22LZuyH/cMwYCLGxa8feu3jcHEgqkWaOhza9EWfq8PeiPRGxPazyys4
         t26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754610629; x=1755215429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrOaXML2hSKoH6wUuGCJEAATJOKIVpI0PkhspY3E9Bo=;
        b=NWcA9c2fqpEGNybL8TryfVHj6uxQxn4l+wMDeaZk4d+x/oMAsWZ5GX59lki2Vy4YzG
         Eus8o11rMFm41I6U69JZGltX+KEQH3cZ/9pgDfT5XOodKrIsbr9ae9KugzyOvGQ2yBes
         kDyRFM6FwfICmILkEYm95Decx/ATSW7907irvAr98UQCfP8Va7Z/5rzxrB62MNlCV4Ur
         Fxn49Z0OMQAr96zFuenQtUo78oqQrsGKGsxT/J3MDK3vCLWB48DtH7UE3+3SA7QX1BLc
         oSmHzcBH2id0jT6POGE/WBEk4xLrMG+xoAoQF5zxQskfQzfObRUSZE5zEMYAKOpJlowc
         pFKw==
X-Forwarded-Encrypted: i=1; AJvYcCV5rI4nvlzNCPU5cJPaFQZqf9/86okvrPBlmG6K2EmZ40ofc+mbCiEvwdzHd8X/+LPygQSutN080gQedtY=@vger.kernel.org, AJvYcCVIPjpFvS25Bl69XRDXMWBvhEyNFeUuZihv/D2qEBeSn5Gl31DGfmoLD8T3/+dzgBuH5bklexsaiE8=@vger.kernel.org, AJvYcCX6md6rlPZUq9Rx/bjlphw83cIidrg7JAr/HUWy7PWisP3by0Cg1XUlHlDO3nRI5ULWJE1H+8aofFNHZFr2@vger.kernel.org
X-Gm-Message-State: AOJu0YzreIH0cb0Q2xbr4N2cUFgCjtGaR3r+ScU4YFY5jkQAYtR7y8bQ
	MizQdd788aMrbdx3G18pM7rTphOUcnacURkUKW4noAilkFBYKS8hcokQR46faw==
X-Gm-Gg: ASbGncsCs9fMaEcOtGkSwNI5xFZ4apaVUKqQvWgWk3NsZfqWuEUhZRTZIIWLHR3o9Gx
	zdyU854M6ON2lEXAhmpNz+IlPrdly/v0973d/jgunFfzM3bt3+7y4+UPq0HtzG+WTJQeYPX+dFf
	/mc5dRVTwDU7qDFHP//t4oeHHoPitoxdW/peTXvAH/wYFvqVMfSoDAYwbOUbgmPwVrffwUZ2Qzu
	vVI2CcfjYNqyM1tVLweXUIOQ5/4LI3q9iJJHtheWhPZANoZT18Nez+Y43bY2VDnfvElkndPuA0f
	gSCtcAwQMRVCkSunYWMR8bhkOoAZM4eoFHhuOasUNcUp7K2NMIPaIyuLXfwLlADdcVmoh9X8CXM
	yq0SylKIXULUK/tjqhz1ywE3wasQ/i4dVHtgVaRmcOzHCJg==
X-Google-Smtp-Source: AGHT+IGBAccxVlKZJT+cdrUE27nIQPQqlNAR8k+vkt00YhGC2dyspCOwoARi+3rlDtp9PhcffW8mkA==
X-Received: by 2002:a05:6a00:3cc8:b0:76b:ee57:986c with SMTP id d2e1a72fcca58-76c46193620mr1400438b3a.14.1754610629248;
        Thu, 07 Aug 2025 16:50:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf1c6d5dcsm13667891b3a.74.2025.08.07.16.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 16:50:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 7 Aug 2025 16:50:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Jamie Vickery <j.a.d.mcmillan@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add Z790-I GAMING WIFI
Message-ID: <c5088140-1e78-4130-bd76-95d75c673612@roeck-us.net>
References: <20250802130912.175543-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802130912.175543-1-eugene.shalygin@gmail.com>

On Sat, Aug 02, 2025 at 03:09:02PM +0200, Eugene Shalygin wrote:
> From: Jamie Vickery <j.a.d.mcmillan@gmail.com>
> 
> Add support for the ROG STRIX Z790-I GAMING WIFI board
> 
> Signed-off-by: Jamie Vickery <j.a.d.mcmillan@gmail.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Thanks,
Guenter

