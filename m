Return-Path: <linux-kernel+bounces-805097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8028BB483F3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF80172C35
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F4F22A4D6;
	Mon,  8 Sep 2025 06:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XE1EdX49"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5E33FF1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 06:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757312018; cv=none; b=WZtFeE3WSJ7bSk1ijtPiXwIgrvalkShDzKqrqrgq071W9SOUXlnQ78M57m+bughQcMwlIwcT7dqYO4vCeRnUCzaSbQdiC6v86uHf+81CwR3h9SaL+2+1EA2wcLFO+ZnoyQxKfrgoGGkr5f3s2WCTMQmvDsQPmqb5A7cFRVXXPrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757312018; c=relaxed/simple;
	bh=bzc4qQuEEvgrgwrE2R9mbQf6DBRnuUtN62w99zNOguw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMjx1mmM/ZUmIW+jgLLiriiWAO2+y9e+CH+GWIYsZAU2ll944eRVPX2JDRziIofZFyC4//rY7QTvcMQ6YSQwzhtMxLIIgLBa+JONvnb3AYntumk5Th6Dy448HNaVB1EeDcdhonLvXq9rHkhsWAk+KuZOG2UwLGWHm19qoBPvwno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XE1EdX49; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-25221fa3c9bso9490015ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 23:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757312017; x=1757916817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XSpWzyyEZu+Bxd21h2rvWlPTRVpUiAP49N8nWNLhFfU=;
        b=XE1EdX49wqiDC3s+fRpfBhAWMKP/7n6EH8/tAvCx0UcqpmP1RL7mROAIK4G2ZAv70S
         UxG6Vn8sZeWyZ+LWtESy+4f3/aUCqHUvxD9luMUvt9dZVxinZSQzYl4Oy8r0/Wa3vRtI
         fdupl2Kps5Tl54vL5xfRQn4Xk34BIAdSSeAO88Zpcx76E7FJ0bZzMyMkHJugyJ5+0OCL
         e7ZDN3jVNeMPf+HkR5PsEZq9xdBWsyuuEKmCXamaTTdaxpC4KEyr3zhKm+wC9KrfZtYY
         jZt7fr1tcxF27p6baRY8flZRUoWlvyj+L9f0485BIG7e/9ztgnl2qyOFHDzfsUf7hhjv
         tZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757312017; x=1757916817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSpWzyyEZu+Bxd21h2rvWlPTRVpUiAP49N8nWNLhFfU=;
        b=T54zm0GuC7pTVP35meTjwGBOdmEBXkw30aFS7NmpHlkbQb9rZ5vwAWaocW0G0qOYif
         nz+DVv4+sbn0d/6Vz/26lGuAMGqF1DljZUYs6rr2j6oSxf/1GpQ20OP1/OrBw/x4UQ4f
         9k93SHUqd39D9+GleGdH6cu4mi1k0ikt5Qf7h0BKUVnA0lK2V0dVD/OnopgK9XclOwmh
         Td/Oz81wwz5b1rkq4xw9o2AEFygb1NqEiX1VwyHTB5Sqaj8byR01RVfX8AB3O60Rt7ph
         IVPbK/YrA1n4Cv1NuX0Vns4n3EARnCeNP0azIP3HMCUMUmgj0MRrWixrf2BTn1TgpMGt
         htdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU62qhGw6ITDvZ/nRs+kNPZfh9qBcGOr7pPiXrCoTceG27i+GtA59mEgCZXgYfNwSscFJsT/1EjH5Voar8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxN3w4k55YkhjQ73bJwumCCA698qJPHUyFiwn4kuuTog9YkIKB
	zhZxLowVGDtgFHwml59ZBm7vFA51obOXZN3Wkk7PaMKsWsu2LH4WBorjcRwArHJCQZA=
X-Gm-Gg: ASbGncv+yYhkxMq+QF/4nFfPaNV9yu/FjEZVgdZnmni8hA6LOra3H0SJPS9KlsBCbBL
	mF+lSJp75f0HMbm4bAM6+JoVZdoXxkMfBoSS9XlalLFXgeUAeTK7mtYIqFqsfEqlXreh9LwRrMa
	8m99DKqNlHs2nfVFgF2/VRU14JW74uL7Y4tzQPgRJ3AGA9uyyoDdnKcLING1U7B30lUNzxDhpNi
	UDZCDRHNJcXyVk3RSqBOD5vuv4GUgDo/+81W6OWPbSmuYsDgRcTf6tyqL5RV4WnY5fXIBJFzvNd
	OYcCHRTekuKkteDsRJXKXY9WirIXkrr08EHu3iWrPYGEjIiw8aNlhtMW7UX54YGoJjcyfDrNVic
	qXuB3xJvJXtYZKlFctpjhK38h
X-Google-Smtp-Source: AGHT+IHdBfGAMTNAQaghtyqFNtIGW5Wx0vAdVoZp4XMlTkw8tyPs8PqBh9LaIqQl5x4IILpeatDJQg==
X-Received: by 2002:a17:902:fc4f:b0:248:aa0d:bb22 with SMTP id d9443c01a7336-2516e1be7a9mr86223805ad.0.1757312016597;
        Sun, 07 Sep 2025 23:13:36 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b14206426sm164265075ad.17.2025.09.07.23.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 23:13:35 -0700 (PDT)
Date: Mon, 8 Sep 2025 11:43:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cpufreq: Always enforce policy limits even
 without frequency table
Message-ID: <20250908061333.rwzq5dj4nxlav6x5@vireshk-i7>
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904032210.92978-3-zhangzihuan@kylinos.cn>
 <20250904044812.cpadajrtz3mrz2ke@vireshk-i7>
 <540469c3-9bc5-444e-87da-95dc27fc481b@kylinos.cn>
 <20250904053700.abdkh23zwi5x65do@vireshk-i7>
 <e91bd1e9-8db4-4923-92fe-52893623487e@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e91bd1e9-8db4-4923-92fe-52893623487e@kylinos.cn>

On 04-09-25, 13:48, Zihuan Zhang wrote:
> I understand your point about the potential duplicate call to
> cpufreq_verify_within_cpu_limits() for drivers with a valid freq-table.
> However, in the third patch of this series, we removed the call to
> cpufreq_generic_frequency_table_verify() from the table_verify path.

Yeah, I missed that.

-- 
viresh

