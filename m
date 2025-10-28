Return-Path: <linux-kernel+bounces-873040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C4EC12E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC8B04EE95E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475581758B;
	Tue, 28 Oct 2025 05:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+WJOpOy"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B10C35B121
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761627680; cv=none; b=Y+A1Ejtoon+URGq7aUnNykVLdPn5s8zzpiBamtnVtOFotZ+4cRCtAvaY771lM4GNgMFZd3D/aNvu/KniYyMjuyBUk2/HiVgJY6RcWEykhHqKy0PMM1ydfZ/We7TihMzGOPPDa/Wk8KWgbW4sKq7KxaZeE3BB5GBBFCf4+FXu25c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761627680; c=relaxed/simple;
	bh=eXt+qTwvJszO8Hou+806wGDbl19YgC8YGTf1MQAwWR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXvaLYpb7gQBNu3kL6/kLQqmf9AmpmS/vZc6Lx+Qx+1tVLngA3Qgls8cdK52ZpqxZua/1NgSUWkMYSIxtiF4FMW9nFOl17XI/fwIAihT9nt2Y38CgP7xKJEg8Gy1ZsniMvkUWQXzyoM9suVB6rsicAzdJB5j2Cj4seG261aeWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u+WJOpOy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2697899a202so44712035ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761627678; x=1762232478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gggGLr9hK/z0x3A0Z7RsJkNUk2lbt+1rtimRnOE0YoI=;
        b=u+WJOpOy4SoPnd6RXj3kAOT+B6BIXZ2j3QrRX8qogv9tck7i88pMIMtQPGtUAm7fJd
         qRtNr+6X2JAiPOzWRhu1hbUNEqg4mBfpAzL+//8FMSKouyXhmpPbKLFqe5J6UW4FmNhV
         GaO6H/ZwtQxrQVExPVpEKBQnnj15nWpgRol9Rbcsfh2INdASamgTqolNagNAlip4my2h
         39B168kF7MOYR5CO2PoIqBhnKgBwBGgBnmvkCA5IZfwu1EE6F4cqRg8pOn02OTbDQiug
         khjqSI9RGYdHieihoCfCvG8bkOKo8GK00QVY/V3y9KcL+q9LVDAMVXr5Abccgr/w/V2F
         BOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761627678; x=1762232478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gggGLr9hK/z0x3A0Z7RsJkNUk2lbt+1rtimRnOE0YoI=;
        b=xJ+6Pnz71NO7V+rs3wYq+tPgS3nnyPXouwJpMiErDv0Q8rDnrxpL5n0lop+1IZTv/h
         efhIumnXfs7K3d3vJiRaxKH6Ej2e+Qw3IC0/xWA8YgSSU2nbqDJme8V6T+P/V2htN4Gu
         uhta9KDGDiR/m+9fMj5q5IulUF27ATucc6O8lvY9i36ebbPGXc7O7UG8goVapYIzDnow
         9yhLe2FdRCcemdPt96f9kobsXXMHxPhDrEpQso9ieci3z5SAQIrvfe4E2A42ZkGzZHyt
         RIhhJJWCFoCE6N6F34XW7ohHbvJf3WoADAj7GU/R6y+7FPJX64Kw0QO2UIKnpFds4+wf
         orVg==
X-Forwarded-Encrypted: i=1; AJvYcCUC1qrT6FsynDOkdZbgZ0YEJXbPcUIV+3iUsaq76Brpj21zOszttueORZ+nVllQeyzVn8jsujAZeHW9HDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWagGshnwz8N5fZqPFXY4KPi7ZQdiv6A4BBwAsRVU7qHOY6boT
	1BRUqfhM+iGkRUX61lQkVt5E9IW5U1BsQFD3hcsZCWekBODEkm4bWjVdeMFa5ghYLXo=
X-Gm-Gg: ASbGncuWYC6D9ocPi6pEeGLaRZnL1uYK76tHYiyCGoWHUYZvkFQk5wuJpuUvjGqjNQS
	BMXqa6EMW2OffPpxTX63R1KEovAFpB/jOxGFfxG/uOgwLaEkBUEdpkRNYzrJYBIfs98oWmZZtwo
	k7xNTFYVBXOOJ4a5G3wjn9og20r+IpSSS0GkRO3ESi91LX4PtKRXqbAdDiNc/o3Atkr9+d5BAO6
	4In+tPJ8Xxvium6PUG/oXVpctQN5JKaLOBpRAs1EvkMUQoHw0i1oJSF+c+Z18QhrrNX6aN9l22K
	TAe8FyTJsm7cIykeAgQZ0GO1bWl4I9uyho/nR4FeD9ibhxlEzJgBMJC8BtsCFMxzfxm6SPoaiNt
	ga/yvoMmljZIFHoGjTiEO7h8emBJml41aou5i4utTYCvpLDu40/UYVKkF3zqx6QSXwFxo3ahDzg
	xkTA==
X-Google-Smtp-Source: AGHT+IEbFKSVcApo2b31IgKzoejiPT54f2Ug4CUN+na1QFDYVgo35NsLKOeM5ffDDNEZ2+JecClhPA==
X-Received: by 2002:a17:903:2443:b0:266:57f7:25f5 with SMTP id d9443c01a7336-294cc69eeefmr20200985ad.7.1761627678039;
        Mon, 27 Oct 2025 22:01:18 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf359asm99649655ad.12.2025.10.27.22.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 22:01:17 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:31:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: nforce2: fix reference count leak in nforce2
Message-ID: <v4lyy4fexh7erlokxhkm7ha3x5lqdb3fo4csuw5ltqgortapwr@dhtgpppyrwfv>
References: <20251027150447.58433-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027150447.58433-1-linmq006@gmail.com>

On 27-10-25, 23:04, Miaoqian Lin wrote:
> There are two reference count leaks in this driver:
> 
> 1. In nforce2_fsb_read(): pci_get_subsys() increases the reference count
>    of the PCI device, but pci_dev_put() is never called to release it,
>    thus leaking the reference.
> 
> 2. In nforce2_detect_chipset(): pci_get_subsys() gets a reference to the
>    nforce2_dev which is stored in a global variable, but the reference
>    is never released when the module is unloaded.
> 
> Fix both by:
> - Adding pci_dev_put(nforce2_sub5) in nforce2_fsb_read() after reading
>   the configuration.
> - Adding pci_dev_put(nforce2_dev) in nforce2_exit() to release the
>   global device reference.
> 
> Found via static analysis.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/cpufreq/cpufreq-nforce2.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied. Thanks.

-- 
viresh

