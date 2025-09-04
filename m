Return-Path: <linux-kernel+bounces-799874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D31FB43113
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079EA16B779
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE58E84039;
	Thu,  4 Sep 2025 04:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ysla949L"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8291BC58
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959886; cv=none; b=TqiLuU0KZLO873g9DhEz3CR8IrJmNzqZE31sbuzIw49pBNurpjcXOsjNZrZ7kCenFzTHmcnN7YKWdHMSTW8p3p+rsu+y2R9OJ6xgzkBqlWj+DTqMqYgTnu+5Bda27tlAZeZngZztgaLQOdeWvBfkp/73O4+NEVlMWA1w7JB3YVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959886; c=relaxed/simple;
	bh=BlocP7MwiM84zTw8l2xU0A4o7JLp4SDHYC7LCxGs640=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmBQGSva2n2N5Yh70anbH0rTGdOZvcS1JMgFpxshNeGPcQUvabmzopYTmbbLmsVLK2LP4OP8ChnFiYCTFdgSEvu134aEUKYzb20Pv51tB83F7a+ibBaMhT4c2DrJ6GdK2JMOVtNbAO95thLXVIQN259Yn5ZvmO+TsFHbtSMFLHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ysla949L; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4c72885c8bso497479a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756959884; x=1757564684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CLY5VEpf6kI9v75HUPtjsvheqw5PZsBr+MuTXkiBsJw=;
        b=Ysla949LTE2Wd9hQIMADanUPTqltvUit+7oflVgEd/Se/UQyVmhMXayyaMJ2CYQx8u
         Q00+AT55YEdldwwLCPIJvP2USYTdphSUPo4LMgX3ywoYzqKQIHrLv501NpPNtgqlIDmS
         wDtzRsGAUVbs43zhDA652V/onOHURDjTfdidwUR3fdmeRf0qt3twcbuX6dpRTu3ZRz/m
         TpZsBbIzOeD3Z7tPcbiCvYIz6GF5IT7s2/+k+BpGuJvSvbbgm3Rvs0/wFgUZQxBuhdi3
         6uNy8QftFIYrW+dPimJHFsFMndozzoSinnbK5E21ZPVHwasYxaAtQ5ik71TrClpFQF6Y
         X6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756959884; x=1757564684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLY5VEpf6kI9v75HUPtjsvheqw5PZsBr+MuTXkiBsJw=;
        b=eKS83mBfkXCuKd+mHMyTwFFmHbCRXAwk6yyF1cZwzTcnJhbAH7tG7sgI2AcC43Qz3q
         3uKxvqdtlIKTRDhoxcz58WEKEQJTsDiVFk0tB/HdHC7SA8LNZRk7cP9MEcLQGb6J7BAt
         DzSR0ZcnlO0Yap+Zh0ijIYsf+3YXaQK18VAEZiY+5dt6GPi5NBBI6bkeOeVEwdSKOzTf
         xtcXrVIG+UEKZj5oKD2GW/d4QkbGy3ila27OmFA0yciEYbwtXfNg4NmFSMJ2GQj1PINM
         00fCzO3O+3gY8/2kKpDVqevsaj8UYM2m5Y15IQzX73ew9Y4dHe5KNfLRUIACpl2mXk2Q
         uE7A==
X-Forwarded-Encrypted: i=1; AJvYcCVseAu/H/6Y79S2AzVVmDsZD1NdudhXRA3CStRXdoYX6dh7PXO9qjTKToF7nK4OrMN5GMoNo2zMSJcDknk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuNhnPDDC8xwmqA07On7Q73Dl4OC5FCFd2Ww9f6+pGCuvXfVoy
	Q4k1w+g2ERiuvyyFw0SF5iWgnGlNz2hW5PoeM4TtNSA+1PaVTYYIT6sloy+1RVFJpcM=
X-Gm-Gg: ASbGncu/ypC6IiDnt8jIEg9Qngr9Ei9XbqpPVsULx7lSCN1EPQF14eQMc/UMwISaCq7
	bgOhOserTMIdugyqeVpa+NnIIfjetF6N8OPy1tZP2VzgZZuy/p2ZJGQ+yMOwcpAaKoOYNoXFSMi
	XMritkqH+PrbrklmahT06nn9LsOyS7RC5kC7bqcOOHMtwjc+RxthkFH+8IfSkLSnCywlOYvtKiS
	EsURLVEnqlZy3dFp67XXHZ2NkIem9H/oc531khzw4694DeytDr3h21J+i3bdU142q4r9RXSu9yH
	SK8RflXGKe/Cv4I+IYUg+isk2lYnDuvKdRHNB4lBKk34nqZvmhKco1Ucy9ZyyBc30zd9+rx/8r9
	CPdvaTvuWN7WwSjl5T4oNkLSyhT89h+blO5w=
X-Google-Smtp-Source: AGHT+IH6SAJ37BO+3kio8PbN58nKVnNdU3sLaoNCLGczjGVmoy/lbBbnmdm+LSrJv42mxLoEdacpbw==
X-Received: by 2002:a05:6a20:9190:b0:248:4d59:93ed with SMTP id adf61e73a8af0-2484d599595mr6862040637.53.1756959884008;
        Wed, 03 Sep 2025 21:24:44 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4e673ad423sm12919546a12.50.2025.09.03.21.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 21:24:43 -0700 (PDT)
Date: Thu, 4 Sep 2025 09:54:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] cpufreq: Clean up frequency table handling
Message-ID: <20250904042441.y6os6koxp5giglx4@vireshk-i7>
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904032210.92978-1-zhangzihuan@kylinos.cn>

On 04-09-25, 11:22, Zihuan Zhang wrote:
> This series contains a set of cleanups around cpufreq frequency table
> handling.
> 
> The first patch drops the redundant @freq_table parameter from
> cpufreq_frequency_table_verify(). This has already been Acked, but is
> included here to avoid build issues with the following changes.

Yeah, this is not okay. You are resending an earlier patch, which is
already Acked as V1 now. You could have just mentioned the link to the
dependency patch here, and that's all.

Don't mix things like this, it doesn't look nice.

-- 
viresh

