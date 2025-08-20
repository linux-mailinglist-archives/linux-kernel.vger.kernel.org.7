Return-Path: <linux-kernel+bounces-777213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 431F5B2D6E1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090CA3AD17C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AEA2DA75F;
	Wed, 20 Aug 2025 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jP3kgYXe"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E672BEC22
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679041; cv=none; b=nHzRpCs90Vja8qQxxxkqEn9ptaxXoCWcFoCvrMPSgk30CmkCmiULYeOjg8hTseLTPhHVTh7kmD525FmFrtX3z1gAibATJZvAKNfST0/4m3xenXHqJCyn7xHa/Eo7kFnUHvee+FzgA+OQM5HTEDqS9VGyjUbtBpoBJTT6bwrJw6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679041; c=relaxed/simple;
	bh=xZW3/6BdFNENaqcayraBvFNOb+CJk1Z7mxMRZBIVkS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oz6y9DoSBn82RzmSnIIYLteRrS23m2JsxCr1ooubVuxXU/MlKo7MUv3eImWX6EIE+id2UKfyKZtdY+ornQg5gmBmpivoRo0ZRFoZHkSEgD2DPdzxC//jb3tkn2hAHlLUH8mnlq256geqg8rWEqiMMzHwqyIErWyGV6iy7FNzhJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jP3kgYXe; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e1ff326bbso543579b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755679038; x=1756283838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o46xinVR1s0iYeN1jBFkHlapCwoj6PpvJWdxxR0YCtE=;
        b=jP3kgYXeMCZPevJHb+4/ACiZ00jcjBk9LKtF0O0uhTGM+tFo5jJNWKmvSk6xfHVRXB
         iXGeevw+85nQF36jX/cTzl9MlV4jh0HOXKpzLVLcUjhRIQ/vuyqnQrIMNGtwQB5+LCg1
         qfZoeq/wy0eBougAezCP1YmxIH6dWciawMRKGI5ub1HZRlsLiIujBf2aI03bbSo5vCCg
         7C4LHa6CTgZYvTc3H0tVRlY7WWO72Y8niwadUfQvRCg7flgd6CWwWjgNNTeX7Ozo9tJo
         RrBhhpdEwhxMczjKH1+8CWIYVkiHXvP9gyX0QPEB48HPrlVE4o27UPIUx4WqHaxHy01Z
         NyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755679038; x=1756283838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o46xinVR1s0iYeN1jBFkHlapCwoj6PpvJWdxxR0YCtE=;
        b=fzjUv+4sjSGXKgrIqt1trnrN5E5U1dNIuje0gQ8+T7Z2L8Ev+X3IXFW+Cezj592g14
         6jv0tb63MqL+GxLe50EDKSb4VbgK6NIaSu71CFyFDnxqoy3Y6V6AxBecdWLpwCAgTBYd
         hDj1INeuDunnpYU5FhyFD/P21GhSQGt6bDnkkKKyQikaKH3EjhsSdwXA72cplXWnMoOT
         NZz4f9iQGxSHlBtJKAFxb4uPC6Mn5GeT/cT+lVBczZZ/ZtyYWc715Nf+TVR30bWKqd/i
         +l/1tptOI8Skk1b1WXAo4OeyQ+Dhvd+LLuoLtS8bKVsHrkhwMED6/ZCwAbKlVyYmuP8K
         JdbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyNuO7iS53TItXBcBwbu/nwieOny/Zkdrlu6b4LKqmuhgriuR5TBJe6loUzciIfKjqFc67Kyw1Qu7H/gY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyU/uO6wG9O1zTN98FuzFyvUjKd6rOzJ6ZzL8gLAtFcO4nOuCj
	BMTLD2+qVRXAmJAeF/fv+GHbXttjJUch8j1Hm6bub1rZxR/AOUrdE8X75rmYUWYWQpV+thS75n6
	PqZx2
X-Gm-Gg: ASbGnctwfkxrfr1FCd1yuBaciegb6k3/ubIW65Fz+uOp6nLZRTAT3at/umtljQXRaCG
	73SRBGlHDQdf+/rb/YNKEN7K7eh1UUmtaTZyHF4tkM8mV+TvkEgwBljYbiM3vj98gcP8EfnC60n
	jdtQ45GoA5dY00RxoWP0X0U1B3PRwqTlOMLG6l2yJ7x8vbEjMZr/TihrXRgtxBo96Xpw//O54wj
	kMu+eKPhHnEAmLrSVVZlc9XyO3Vry00QMrsf0bTK0HMidVq3GIHSv1YhGCIqUbvZ5VqvCJujNv1
	uHBejSE5TJIniCdAyFW0eAiDuPYN2mEWrOtZBKYCuwFEFnz0cQx9gp/0CeIRxe6sRjqcQHaP8kO
	Sh+6KTm8A/a6WOqd8krP74UJj
X-Google-Smtp-Source: AGHT+IHpJFoo2XVLENsEBA/Y5llAs8G7zIxVfwM+c4WxloFPk+FGCECVKHDac8lZXlFp3d+0H3OcQA==
X-Received: by 2002:a05:6a20:9389:b0:1f3:31fe:c1da with SMTP id adf61e73a8af0-2431b7c629amr3202399637.11.1755679037542;
        Wed, 20 Aug 2025 01:37:17 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e2625998sm1600813a91.16.2025.08.20.01.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:37:16 -0700 (PDT)
Date: Wed, 20 Aug 2025 14:07:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Paresh Bhagat <p-bhagat@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, praneeth@ti.com, kristo@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	rafael@kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, khasim@ti.com, v-singh1@ti.com,
	afd@ti.com, bb@ti.com, s-vadapalli@ti.com
Subject: Re: [PATCH 0/4] Add cpufreq and USB support for AM62D2
Message-ID: <20250820083714.bvocz6cmcbhnrsmt@vireshk-i7>
References: <20250820083331.3412378-1-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820083331.3412378-1-p-bhagat@ti.com>

On 20-08-25, 14:03, Paresh Bhagat wrote:
>   cpufreq: dt-platdev: Blacklist ti,am62d2 SoC
>   cpufreq: ti: Add support for AM62D2

Applied these two patches. Thanks.

-- 
viresh

