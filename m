Return-Path: <linux-kernel+bounces-867774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E311C0377C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211F8189FF98
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B3026F2BD;
	Thu, 23 Oct 2025 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T65CGYWe"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42D326A1B9
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761253049; cv=none; b=iGlz6krqueqnRlFT5dV/1YDnlH///llJIFONxsLPdY4iEB5GKbgQHMutKSPogwEinlvCp2KdVl3Fr0m5etOsMR8WvX8+nnge4vtpW8fU+cg2L30cqFGHElNvztQe4GVOlp0RCpLmG/gKbg1/mSXKM1M/A8wI4PNdyhlgnPuNPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761253049; c=relaxed/simple;
	bh=m8ASc2OAY4fv8+TtsrJxQF9H5kewxn0+auSNH+ttR9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXG7niKCg1YnBMtmvNP6gRR9H5qrNbRlfQaTncsBxELSHNpuLBZZSQvr9uGTRPb20UbBcUvYwXfGHVDc9dw4LhMfmbDV78dTFxV5N+j5m6/jw+XejPXeukoTuwQoo3jOZw9fOwSR/Oa9JJd8cLS8I8Mtr8UQm2L21HOUgNGiPIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T65CGYWe; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33d962c0e9aso1143457a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761253047; x=1761857847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5tTG1pwP7TykWxe8MPff4LTF6nEVfVWG3Z8SQ568z2A=;
        b=T65CGYWeI/JtDHZc5Q8LaWWi8b2TJQGiEA+U0YTSZXNfm1HjolauayNPqv1XxhofWx
         FtgHjvLZ1c6Q3AbdhY/MhuKzLBVzJ1tCU6C3Nhp/taq+D5yVNVA137Gf5lo1/u+jiN0K
         1Z7D+ECmcmZx0IW+NWS4qmBtZEwDfszVihuUgs5nWuscZN/La7wIsjDnNRn3oPKVUrfG
         FYtiY38GS5VYupd+ObMSyJf4MwfHBcrWJBu2fTwoGPE+QKqn/dh40Sza8v2WInfHzY71
         dwMxWVkRdQb/U3VhSnkDyNzVMx7HyAHipzdIGdvAFCUwoHyFX2i5oISfgfNAyUq7rKjf
         I6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761253047; x=1761857847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tTG1pwP7TykWxe8MPff4LTF6nEVfVWG3Z8SQ568z2A=;
        b=XyGFVwTH4KgCV+f5U7qSSsWnolULXsCayGqaLe3LKecTrsleEHy32Vg9w5icdlcLV1
         w9pqFbp+/tawMrvFnfr+X5T6Di2oeM8+DPXHwuqGJRBUGHXC7ID/wf3WY/idW8VYM5hA
         DnRbJ8TeKe48fJkFauiHi3S9dfT5F8ou2a3gzZZN/o87xjmzQ21oe+F46KgDPwUrFNF6
         NSF3xxYnvILnOUJKaG1isEToBz6olSPNEQ52rPKeLFJqB3NEN/XjqSgiEh+Ff9kr1ZXR
         uTAe60Wx7owB8g70vXzTrEfanwOj0RDz0H4Xhvmiznb83PIHHMB7hW9zzaQIpd7+CeUU
         yk2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2uamZaZgG2C6s4YRKcTwouPfgE5W+afJPpUtzwwP+V1fZL7hiWuX+RYoJQfiGpuBrJ7tB7+cCqj5cgv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2WFmXUFx+/O1y7Y9bxPgzZ9YD4rmsejD0IYQ2JajoQ06rqzUW
	m+QHNSx/V9mR1HmivYT2HnQvnBQ+3Q4+FmTqn9pWqLYVNjQPgHLikL0z0LkCVTWd8g==
X-Gm-Gg: ASbGnctQFBgUarpvHW5IBKV84X/NbWf55T3qQv6cGEU9yaQ3UQCFxOrydF/bY+pjh87
	qjE5AOkagBjzeeW/TldjQ+1VMYPpbhehuCgBSlp3GNnQ7T7H/Q0uRrI7+eduretdDqbNSvOqqQF
	M7PsuDQhT9Pyo/YfNbyOt+E25Ge0OK5GaeXxI9UuwKvptOdRfI2dd7R1Mqudv7b/4MkvAsB5Tbh
	205qCcM1qxWPuX98dDEIDntu5MSXKJFgWHpodCFssdkGMdQuUbiMfZTTazNk89dMJ70wmB6VDNv
	ssN3NY9sTXYOQJe0EEiidzovxHj/1CbXesrPOsIcr1GOgrhGgS8SkOt9eaE58jR5zrIfocgQyqq
	wmJD8mkVEe0KjxBYATuMcSdM7UPiu74RKlxMMJxtyGrVIV3M86acXeoyIBa94yZsqOqJucRxcDM
	foDhBvI5GnR2FPBX2A4/k0FOjtbYQ7MYyQvQcjg2XxmGej4Ybu8guvUiLEvZ4=
X-Google-Smtp-Source: AGHT+IG8WEMgflsND+5AmBeFxzQTcqL/T08P5hnlVq90L3tdTnALjw3mEYnO3w9FtfRAZWoL1HpF8A==
X-Received: by 2002:a17:90b:50c7:b0:327:53f0:6368 with SMTP id 98e67ed59e1d1-33fd3a61ad3mr335524a91.2.1761253046760;
        Thu, 23 Oct 2025 13:57:26 -0700 (PDT)
Received: from google.com (80.88.82.34.bc.googleusercontent.com. [34.82.88.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2090eff6sm3795056a91.2.2025.10.23.13.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:57:26 -0700 (PDT)
Date: Thu, 23 Oct 2025 20:57:22 +0000
From: William McVicker <willmcvicker@google.com>
To: Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Hosung Kim <hosung0.kim@samsung.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Youngmin Nam <youngmin.nam@samsung.com>
Cc: Donghoon Yu <hoony.yu@samsung.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	John Stultz <jstultz@google.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-samsung-soc@vger.kernel.org, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/7] Add module support for Arm64 Exynos MCT driver
Message-ID: <aPqWsjUCmplMda_S@google.com>
References: <20251023205257.2029526-1-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023205257.2029526-1-willmcvicker@google.com>

Sorry, I missed the "v5" prefix for the patches in the first v5 series. Please
ignore this cover letter and refer to the updated series here:

  https://lore.kernel.org/all/20251023205257.2029526-1-willmcvicker@google.com/

Regards,
Will

