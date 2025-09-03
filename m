Return-Path: <linux-kernel+bounces-797719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BABB41476
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F0754233B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB93A2D5406;
	Wed,  3 Sep 2025 05:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJkN5Ubk"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C6A20EB;
	Wed,  3 Sep 2025 05:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756878398; cv=none; b=HlXFAwAJq1eEPr1PwJul5FtDhTkbnwGeq1PIDahuHi6eoMA5vViTiH+XI71IWWM9PB9FumH7te2TApFDYVb6xiTz9sbOfnMkfx/nlvRlNxYb++i6nqZRWHO0a+uB6I8sBuCaT6Dlx+mBjHNlVwE3wSAGTM1nXSrWfSij6lFoAaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756878398; c=relaxed/simple;
	bh=lba/onyM72LkmC40tYiUqo276H57gB2CvydBi6T6zoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9jfzYPoawK8XZ7DRe0cJZ48BGpezrBfYonkV5QJNM2JZJGvYRGuqpkby2Qth583VDBIUbrKflXCIcXOm/NBqiP9l1xBLSg4LiO4vQPoE/XSYvz89YNbNP3LeBNMaSpzPL5i4oU1uTGdRb0NKoVmy234s/sPfndZpNzj9Dro8cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJkN5Ubk; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7723bf02181so2794064b3a.1;
        Tue, 02 Sep 2025 22:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756878395; x=1757483195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N56o4i6wpcq7MoneUhLU2w8v3e0MP3V6I9jOXvxsGzI=;
        b=LJkN5UbkpIgKi9hWzW1+ZvtofG/CEDOFrSEFpvhWgJ+ev7GZRKEb0kMjVQtMAJ3mAG
         Tp32nEJpT9Jnl+jCpCqL1S4RdDLajm1Coj5JPj5NXBtj0VE7dXZVR6UPUWNTB9/rJ7Am
         53ZAaNc0khBgKAKE5X7idgU7O0Wv9xcMUKHPkJghw9EhIla1Bpi6KGDUGSSdcRTHT+Ga
         ciX1ZzsLM3Hkqvm8GyeR9k6BJ+IIBK4NAKtfXfoUaqyJipVGr3uSiBPCM6/GacJjTLUJ
         Awxv86vzyy1lS/c/FAtcQnaTIRHLOR7MLzzRNM5z6sABu4ENIVzLKSHH1/qfRmlfSOrZ
         Qfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756878395; x=1757483195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N56o4i6wpcq7MoneUhLU2w8v3e0MP3V6I9jOXvxsGzI=;
        b=K2aobvkYBJqksVBfHjoFRl+WjdS62PjKuPKPTWK1aqk+rcLW41cm/Rn1rHvBPetir6
         5/+f//K4QpruK6qJEVadb9DY9YBFN399eEBorAnut8q2AWdLluQU58shcsHwBIPRA4Eo
         gDw203omn4nOnXm0I1VK8kf3BuIfCuRE1+kmrb/jc8DXK6vgpxWPtVTl5qqYAVod/nb7
         eHmj+a67rtfGXXV0tmevK1GONkyFAuWfg7aufY7GGgYTD35DDSIxgv8MT2ZUdUG3rftg
         o5WkaIJXpX4fb237lQ9kpRk91XISRWGH3UPuGZmG5I9BKcpfkQJQP01RGX5AiDwVwJnf
         5lqg==
X-Forwarded-Encrypted: i=1; AJvYcCV6YunO1MBlyY0jl6IbeHjjDpg0PxfmKMeieNh5zF7gogmYERNnzZVllsJLqFgrcrLt+Xb2sAiO6WA=@vger.kernel.org, AJvYcCWG8HdCkgdVynKUG0xsnnRljJNlaDDfL70RWz9Hw0SxGGM8qtOomz+VUKnnpeFROiN/9Gzjk0RBReO2wbkJ@vger.kernel.org, AJvYcCXb3oBiptDVB7b2pda9G4hgYng5mN+3VHuTfOcUAV/KTroCa2zEWq6UtdUqqutJ07TH9kz+JEtS7vDptGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoKnpRxomMlZpheSCvyaGsVm8LE8/ygOx3SOAA60KxV3h+rjxh
	DNMM1zEGeViiTpTzJlsYHbvsdkMk+1XqPkeTF4cot/jCLU4I7eqry4V5
X-Gm-Gg: ASbGncu3JoeS3ipIe9fiGwV+kWiqf4tWI61ObgGNsnrRrO+f0GJVf2RtOEBoCPQeBSd
	i+qD7D7xBxPn4ByCThT8JTb6cdo6Hv1C+Fq/BSSMxMnd6mLkkSD3+RC/58RVQe7pGbvqn2wZPR0
	xWMv2w8iex9jbJeO1ry/r6KTqZma4gYH+vCRSoC5JGKPHZQz0kMXZjURTH88KP66DsrusHQEVA3
	Vsb0rj87fBpvN4izkMJKUFGyQYSYSNU1ZnqZ07tfySP0y5NUCWXSSoxmYWm4CpA0OazHq41MlzU
	xYyMkwlZ65tZ3Bw+bQd8tWhNqi6b4oveUjQBNC39HPibDz5ssbSpy9plygVlIsVVPsS9YNjjR1D
	JYnRq9RSP2/0XjSzUOuyg5H0HTJR4tOlAGdSBqyj4FRSJOA==
X-Google-Smtp-Source: AGHT+IEV4Vd2Y2C/hEN7OzTOzJalF3mXaqeIzl0gxBoE8BM9yE4GNNUoGTh8tHsozmaUEx+RVqUCyA==
X-Received: by 2002:a05:6a20:1595:b0:243:af83:6c75 with SMTP id adf61e73a8af0-243d6f0293fmr19716646637.28.1756878395509;
        Tue, 02 Sep 2025 22:46:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f317ee7cfsm8828644a12.3.2025.09.02.22.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 22:46:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 2 Sep 2025 22:46:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tom Ingleby <tom@ewsting.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Eugene Shalygin <eugene.shalygin@gmail.com>,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (asus-ec-sensors) add ROG STRIX Z690-E GAMING
 WIFI
Message-ID: <cb9a8cf7-4e20-49a0-b590-8190d329178c@roeck-us.net>
References: <20250903031800.4173-1-tom@ewsting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903031800.4173-1-tom@ewsting.com>

On Tue, Sep 02, 2025 at 08:17:56PM -0700, Tom Ingleby wrote:
> Add support for the ASUS ROG STRIX Z690-E GAMING WIFI
> 
> Signed-off-by: Tom Ingleby <tom@ewsting.com>

Applied.

Guenter

