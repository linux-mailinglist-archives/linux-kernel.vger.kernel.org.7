Return-Path: <linux-kernel+bounces-752719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE1CB17A25
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCEA81C27085
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A851F289813;
	Thu, 31 Jul 2025 23:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO7391M2"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696D3289378;
	Thu, 31 Jul 2025 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754005404; cv=none; b=SJZnK+rp5cRmRInUmK0gbDT7skZsn0ZDqtJAPZJEt2wawa0/dV811Lz8c4cBM0qbcEE4aFf/RAFTvMYxO4TqORl9TnpW3VLLAv+3EUpUZaAJTjBIKbHbSszGRhX34mHqOS4G5FIc8fNaRxAg+N3Kx+zVe8BuQnUQFYKW14FHs0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754005404; c=relaxed/simple;
	bh=pnLAWcQQSftJqgNdVH1qyuLz+1XwjkIHtpzLlJu7CjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZA1YXbmDsq1jHa5UNBsk54tQ7EeEQkgpc8l2v/HbH8KSbMHVdwwvBgHJ6ZZ2jgD7NOC8W5/Sg4BK/J0mFiMO0KBK2iVeYUbdVzthhvpr6Ldn+K3HA/EMzdPzhkCxmjea2tRASc+uROcnzuQ/0ksGEwkhCoxKDhx1jpUBqqxPi/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FO7391M2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76aea119891so2404565b3a.1;
        Thu, 31 Jul 2025 16:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754005400; x=1754610200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RaB7m4pDbnrTf62al5PgUT2DPVQcJSeGCk56nwXmKt0=;
        b=FO7391M2gV8SiV8e89AJ2hfuRa1QE/hJeGSY+tUhHaHLSyxkUn35Wyz3oPO/4ELCEp
         o+EolBKAAwiI8/0YHSRdHobU4P3fB6pwYkASx7e6J+HBiMHMnDYH+bMURJcemmFv8Vnb
         gKqDJBdYLjFvA8s5klTR2ZpY/JeC80QpHsgql7Eslf3LIsXqy+lHPLNkm84ecqbNNJCl
         sxERaUL/57sbhV503VqptErYtU88izkdLuED6i6zChOKstC4cBDjloOEfxY0scGbRMhL
         8NKtSRZyVsaP1efy2BaqjrdUbyuAfPzHJC1zeWOSBFgvX28xEukrp6RVZaWnM78jvaZW
         YtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754005400; x=1754610200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaB7m4pDbnrTf62al5PgUT2DPVQcJSeGCk56nwXmKt0=;
        b=oY1AN450OLysEVMCyYJPnC954pz5PPThIcic/FMTyHLAIapfvUb/w59Y4JifApDnZK
         gDP8AAg4Qa6fs3aY2ahHfsd3KB0ZyPYD1122M3Uv1o9EJQbwmLftUV6PUMx2P2CYql+y
         GiS47Pk7rlIlqMVsrFyr20SkTRH/Knla5ioP/vRVw3lHpF3K6PBEUKNoRCVYPUd6htzU
         ulKive418cHMGnde+26sKn9IzKboLpSUSK1QXYOOGYyWPXS9xKXmV4yMHkOt2EzDSyfR
         fMqkUsxyMq+7JSwW5rtKxZJ4hjsBOlGzK6Ce3KQXX5EjVgpDY70t/NOfERn2fwFV/xmf
         NitA==
X-Forwarded-Encrypted: i=1; AJvYcCXxWSbwU7ZZs6wPNXoi5IKFUHLDrCHvftRtrtESW4CqCz3cS+FJApzFjsHEZ9Q7aeJaocoSj0eD+ENz0DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGs92CbZh7qTFfo074sKgcsJITi1bO59+jTjjILP0B81GBky1x
	NLT6n2fXHQ0+EBRevZW4875eTseIRRyImeghUKq4GXB5Hrv7erwyjqigYXIHNg==
X-Gm-Gg: ASbGncvb+CWNNqkv7r4VY7gTX5h9bwk6oJOYOilMLA0WUuuBL3EeWVfWtNyP8sJhXAQ
	X5Po4GqZskCRFkZWc8JJgZDSHyy5GGoUZadUyivpwcoAWrwf7B4S2U0T3rYhAG8TaNCFQhlQSX6
	2MN4KZDf7HxAbsOT1stQdj/tzWyjlyUvu7dFVil0+3Ew9haxgtYfIr5zk9U5IEzdZvHE7YwM6ku
	KruWDhOBdEWRgz4Zbdo6JC8aOJwvoc8meHN8ZelJrnUFfZS+KHdpZV9UWxKspf7XnqWd4xzV4l3
	RgDl9+TAoJpmGeHDKl1JXqlwWdlO5L4z04K1ZxIZZ5f2N4uYWIQwQrOCPC9/UBrPZXjxrPD5wK0
	eLzBaUSn22Z3vOEvkGSq7u2COWEbeCASgl+Q=
X-Google-Smtp-Source: AGHT+IGU3M6SJHJWRdYGqEaHXEqftmX2Jt35qy4OpcUFlPQ+lYbndT3elXbjXjhKrzn9y+q17Tqoig==
X-Received: by 2002:a05:6300:218c:b0:238:abe:6363 with SMTP id adf61e73a8af0-23dd7bd86ddmr7142265637.14.1754005399687;
        Thu, 31 Jul 2025 16:43:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac0d14sm2382038a12.41.2025.07.31.16.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:43:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 31 Jul 2025 16:43:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-hwmon@vger.kernel.org, jdelvare@suse.com, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org, avadnaik@amd.com
Subject: Re: [PATCH v2] hwmon: (k10temp) Add thermal support for AMD Family
 1Ah-based models
Message-ID: <169c715a-d30f-4e72-a901-5ca58cc66e55@roeck-us.net>
References: <20250729001644.257645-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729001644.257645-1-avadhut.naik@amd.com>

On Tue, Jul 29, 2025 at 12:15:43AM +0000, Avadhut Naik wrote:
> Add thermal info support for newer AMD Family 1Ah-based models.
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>

Applied.

Thanks,
Guenter

