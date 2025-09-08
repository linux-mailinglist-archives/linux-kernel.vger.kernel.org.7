Return-Path: <linux-kernel+bounces-805176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 136B3B484F4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB563BEB0D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276BC2E7635;
	Mon,  8 Sep 2025 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IyrE6Mcx"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FDF1DF75C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315965; cv=none; b=k1DZ7cyh0H7D5yTQmglRXiHUdILhO74+tXfibjomrnaELdv7SYWTdOjQlGHt/8VfcizgSr/gve4FC/+gQL+qFKz6UEJNVxw7mRnSi9YypM5asw/l/D31HIPSNX432n97xk0rQlVzR0XzVnF/WLf44gWg/O7VsP76kHv/N18whpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315965; c=relaxed/simple;
	bh=BNab8fxj6k4MoaVoioxBMFT5EleFAL7yVEPKiqdUPtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBIajXInzcpe4WCvaSCU3pSmHIQ19ZljrlaMW2HjhwLVvUDB2xz5RPzMhPjwuii//0ULs3C/12/3f51LoO3Zz7ibKm/sR92ycI1vWFqZ+GbxPOfN6ZGX4FmEPsOL+pe7i4z2kWIP2Z7mba/wHJ/OBXXkuF3NGWGTQxq4WPRGr2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IyrE6Mcx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-329a41dc2ebso2783893a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 00:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757315963; x=1757920763; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EAYHh9lMCon16obCKSDbDwXrZiRV9IijM32QmOk0Irw=;
        b=IyrE6McxbIno15jOCpRhIRWmQhIO/QSeck7pHYwltifaTe4FNuRAv4pdet67wQtJDN
         cuKaKb7pDWOj5a3elfmyyAq5QQAeqA1D0oR7GEtCv3gLuo5nlKMBK/qEA/X/iY1vrsFU
         m4a//ozVtUmVSZiFpXK5U66uA3CT/bTmWyLR3bD/OUHc/cNbotGDo3HCoV9ngZJJGPoZ
         HfqrtL+u7CqdPkw7nZgPHddXyZllxqGdAl+y9EfsbwG14Y2gw2yAO6YuZKwAiWbnX/+9
         RzRN1V+XLnLnYg1My7FxA/WzM1a8hFbdqdwgwGWmxT6Rfp9HQK+Vt039qfJisuc+WNkz
         XAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757315963; x=1757920763;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAYHh9lMCon16obCKSDbDwXrZiRV9IijM32QmOk0Irw=;
        b=qKrmYMzI/NCGnNLIM3IqdVRs+xTXSmhauZpu2oBENe1+De/dw22ukHj+YxOC7sbGhp
         J1Qr61l2xqsGv33hmoJ15miJTS1WGT/gCBeddulU/wtYyKcnrMEHpUXWZN6gI+skmB2L
         P6N/v+WJYy+NhW3T8MCVco8jzgEwI9A3dPgOa+NwkD1GQSmcAlXA07KNa45QAG0EfVmz
         XN5FvtCcMMzysfxDJbA5tuJXdUPHzJgLivBnZa9SoSs4WpLmCWRToppGBzKAvmli/thw
         oxbk1XBYXwPT7OSs3RCBeIbkNgTd2JpUIcJEZccoxI+7EqUFhEWsKmEO7gw5rIqP6IG2
         LX7A==
X-Forwarded-Encrypted: i=1; AJvYcCVsA/k8o1Svt2LXb3ynoUfHVQn5Gi5aNqm7rX8fUBhSuaMDcJhtq0+MeQQh1USdanJ+rM1IPvg/1ntMvl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9mc6UZ4wZzEH7NSO82lFbr4YCNu7XJRjTMI5mWp+DiBPK58vV
	aDuGcY8XivDi/2K12/ipO2JnBqBBjrxhlVqxHaaMfENogV9Z/hd+jwLepWs2msbz/x8=
X-Gm-Gg: ASbGncvX36xVAl/VQaiLAmXW6EFI24Bfs57CtxA7Sxco4UwrshrOFPmKjFuHZ9Waydi
	KMqXD3fDRb5eFTOckQzcsjV3FlaCWdUlua2KGSBRUJLEEI78Z4s+lFgVUNMqUgO2Lp5MOzyIIEG
	zrnoQeq7lRHjZ0WyJvYsBfLetdsSqDed/yeB3ABVXSWMi/f4DRR8LaT7H1NAKBWsOl5RwePi5mp
	Zs/k/NUdxYSGxNmKNHnGEHUa/YEPOJ5CvKn5hvBigpA94c0HsL5xj3vsVquXIsNqhNhN4fLpjNT
	ift5+ATMlWC3qSktVLnlcKd72Y21dZrKNYdcvotAawuM8jEI265UVyusfAWTaabmbgg75hB9XG+
	RJ0PSirXOJAOjd73XlHSM697C
X-Google-Smtp-Source: AGHT+IFbQ/ROCLh/kJlbdFwGJO4vxc2c9jB5WIc/klPQSxj62Iq0l6v0xGicUZ+w2V1X0FNVzLoiIQ==
X-Received: by 2002:a17:90b:48d2:b0:32b:5f2f:f675 with SMTP id 98e67ed59e1d1-32d43f7d78cmr8221350a91.19.1757315963366;
        Mon, 08 Sep 2025 00:19:23 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32d89f32ebfsm1763987a91.0.2025.09.08.00.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 00:19:22 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:49:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cpufreq: Always enforce policy limits even
 without frequency table
Message-ID: <20250908071920.f6ppfr7shy2cb2wg@vireshk-i7>
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904032210.92978-3-zhangzihuan@kylinos.cn>
 <20250904044812.cpadajrtz3mrz2ke@vireshk-i7>
 <540469c3-9bc5-444e-87da-95dc27fc481b@kylinos.cn>
 <20250904053700.abdkh23zwi5x65do@vireshk-i7>
 <e91bd1e9-8db4-4923-92fe-52893623487e@kylinos.cn>
 <20250908061333.rwzq5dj4nxlav6x5@vireshk-i7>
 <cbe36377-6f92-4913-8cd7-087e718af368@kylinos.cn>
 <20250908065551.d5jhp5ejix4fzgd2@vireshk-i7>
 <67b55ae1-60b0-4d54-8220-59f7e3ba7c29@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67b55ae1-60b0-4d54-8220-59f7e3ba7c29@kylinos.cn>

On 08-09-25, 15:08, Zihuan Zhang wrote:
> One idea we are considering is to check whether driver->verify points to
> cpufreq_generic_frequency_table_verify and use that as a heuristic to
> enforce the presence of target_index():
> 
>  ((driver_data->verify == cpufreq_generic_frequency_table_verify) !=
> !!driver_data->target_index)
> 
> I haven’t tested this approach yet, so I’m not sure if it will be fully
> reliable.

I don't this is a good idea. It isn't necessary for any driver to use
the generic functions.

-- 
viresh

