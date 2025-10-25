Return-Path: <linux-kernel+bounces-869853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D031C08DDD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CF154E3C6C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 08:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20DF26AA93;
	Sat, 25 Oct 2025 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8QyQ8lJ"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6F224AF7
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761380399; cv=none; b=KZO42MrIcu1YMpnJRa5NAxOkNSxf4808be9EitFaUS/Ok63f0/OZc9cSOsr4s0yOjFLnMjof8WzbrNE2s+VSMN7Q6P+pYvnns6zhElU+FJE8e5o99SclsJ6AZ+qcziF+uALcHjJ+pqBl4xnKGSyfbbM8H68MSQc9djc2ixwmWX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761380399; c=relaxed/simple;
	bh=AzfeVbbRV3eREjYjS3QXyjhA7RuXufKczC6qDZJG4R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3JbianevAQFKbrv6mlw3A688H0kbWGrrGOuTwrWryZU0kCab7DyQAt2WvmxZffibQ6Ci0+G0ejEVN8681mM5EIe/o1WMUdMk2pMKKr3DgPLMiozz8bi4wNcrVcpsOjXvJuNiwh3aHvfgVkcX6Wp5Np03bOxzQeS9kHxJjGm1QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8QyQ8lJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-330b4739538so2853772a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 01:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761380397; x=1761985197; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0P1qCP4uZ3AAQgH9R2rp1FNOw4ZXslRjRKDSpwrrHA=;
        b=M8QyQ8lJBaQ80dl5sSR5pL5bDSaJIMAihZigDv3Nw88lcs1Xfib1c6y99/mZO/So3W
         EnjohnJsPaiqgSaCGY5A/n+Ckf9NIMWPbnW415BeH6p3lhohoMqgAgepa8hsgmSZDQyq
         fyyuQ2QytLN22VpW58mm3xXkf2ZYBliLlxHFlDc9+uBpSY4JOmpE/o7MEdmQO+3X69ng
         CaNMu23dUZrablAwuqNzElo1p/FZNQBWv/9vKuZUwdpZycPY1tnUBW4yZLHJ4OPUfS6i
         9R4P/FNDM1ynL0B3tiZcZY0yMggQDy9+ra4Pw0n8o9KHSADhSA4IZxsqHLxk/B0X6Xe8
         xQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761380397; x=1761985197;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0P1qCP4uZ3AAQgH9R2rp1FNOw4ZXslRjRKDSpwrrHA=;
        b=uX7VWeXdHDojxGZIgbzeYsI1KMX0cHFHW0Ag25UWN5/6a2uPv3t2OVFoKKhVZ2m5at
         2b63cwkjJmtvVQll6Ai4AgbPRnYNjKx34xwYQqg6FTDAEouCP8FZhCjR/cObsg3fIvUo
         nxkXATPAKEzJ1vUZCXgDMzgL4y4V4GEFGXuQHJxArSPLGQXz0JZ6nlOONaQFDyk7lTuU
         R9eNmyFNmbczIDSrVSoEFk4Qxe3hyB1bed9MNCu8aCpYBed9Zc9lEdfCKGYqmIEHLXsz
         NVDzLpuGwCysDm2bNa0Ye0nsGiZyqCVRb7+xjOxxAoax2/jMONIskGUWBPhXEB+2LdSD
         ssow==
X-Forwarded-Encrypted: i=1; AJvYcCUD/J+bByMA2r3oyQutpsn2DyqYvcID3mI+gXoxL7z5KoHJTvL6v94+n1NRJlWBVuc6szxnarPsq5aZ4zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YymdQbIkwgoTf738miqHnJSAUJaC2AR7l5ok/OzbMbcrulB1JT8
	VBxHvBd4yx+sh8B+gyrTzRkgnGDP8P1SMHLGFt5NgyBnAZ8qpKKAX+RU
X-Gm-Gg: ASbGncsYR11a23VP1B1cT8lhH9xxwkoa/+qQLhhCwX9btgAHYDxX5VgAS2404oSOdj0
	E7vzkCvL70LPTSxuvjl5ONrAlb64YPppEUXYSO7RxexuRGKnuxFyJYH+7dZxhhpdthUKBs7T/l6
	OM3p460j8jzWuodap+5GqGY4ytFiHK5ZFD/kpP2YdFkP6lRvfCyFvvS6qG/+xJ9T/I6rhtf3tWS
	qBvleFT17GYOiJ1KZOP8c3KrLFi2LVfHNvCQzvDUw0VG9YxR1DehOOAO7O9Y7E2i+sLWtFef4fw
	MdAInAgRXjlhjJMBTEGpFLt1ccKdFY/G2UAftJfihulMccvAOlNOMeqeSGM8VBnmuyzPO/pL1oj
	foMyEA+K/lSHou8cBSv8V6GcQAw86lZ66DVG9Np59tu/uKygQluMQGqPRzFm5eTYSfGSekTRw5G
	QiJXVme3MxI9I6dIcMbK6VHLU=
X-Google-Smtp-Source: AGHT+IHGTk9mHrG98F2le4aB1w/t0kcsoJBN6xOXR8de0Ny/hqGEZAIH8AH8oW3GDzOVT5iOt4o7jg==
X-Received: by 2002:a17:90b:530f:b0:330:6c5a:4af4 with SMTP id 98e67ed59e1d1-33fd662e554mr6574117a91.35.1761380396715;
        Sat, 25 Oct 2025 01:19:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81aa87sm1511375a91.20.2025.10.25.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 01:19:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 25 Oct 2025 01:19:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: cryolitia@uniontech.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] hwmon: (gpd-fan) Fix compilation error in non-ACPI builds
Message-ID: <6a1e1503-0529-41f6-806d-0ecf0f8e77fe@roeck-us.net>
References: <20251024202042.752160-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251024202042.752160-1-krishnagopi487@gmail.com>

On Sat, Oct 25, 2025 at 01:50:40AM +0530, Gopi Krishna Menon wrote:
> Building gpd-fan driver without CONFIG_ACPI results in the following
> build errors:
> 
> drivers/hwmon/gpd-fan.c: In function ‘gpd_ecram_read’:
> drivers/hwmon/gpd-fan.c:228:9: error: implicit declaration of function ‘outb’ [-Werror=implicit-function-declaration]
>   228 |         outb(0x2E, addr_port);
>       |         ^~~~
> drivers/hwmon/gpd-fan.c:241:16: error: implicit declaration of function ‘inb’ [-Werror=implicit-function-declaration]
>   241 |         *val = inb(data_port);
> 
> The definitions for inb() and outb() come from <linux/io.h>
> (specifically through <asm/io.h>), which is implicitly included via
> <acpi_io.h>. When CONFIG_ACPI is not set, <acpi_io.h> is not included
> resulting in <linux/io.h> to be omitted as well.
> 
> Since the driver does not depend on ACPI, remove <linux/acpi.h> and add
> <linux/io.h> directly to fix the compilation errors.
> 
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>

Applied.

Thanks,
Guenter

