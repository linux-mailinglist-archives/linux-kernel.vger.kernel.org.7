Return-Path: <linux-kernel+bounces-775464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE69B2BF73
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF1A1899EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AC1322DB6;
	Tue, 19 Aug 2025 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSpf9Uxm"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E265322A39
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600928; cv=none; b=rkNFZe+vgx4l09j6TjpwD0bz+fxIP2pKPUf2QSFvSlPBnA5JjdE5gKI7KqHDJA1zxvbVSrYY7KEBRakeUfZIXv5LqywZCHFTebIsoJqp11+aHvYSdmNZZh7lHeJV6HLm2DeKK40Fx6eCS+aUNiLZSxhyih+thDXR/oMiRwrDAbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600928; c=relaxed/simple;
	bh=nuiHYEdT4SzyCZDKFC2g1kk23b+Yq+E2mszEFq+217Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IljiESHdqPl8USn5fTN4PbpLV0vxhDSylnZY2+9lNLFHo0dR7FPKBRSWaCfVnWG1BNbpkz9BU9xdcBvNcAngg30VG/abjI3GCEmpK0DcsdYj7xn7cDjVh7dUkxpxSzlEhhlHB7voHeskSmQQJeCBKSToYUk6NK483WJhsM6iwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kSpf9Uxm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2eb9ae80so3957039b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755600927; x=1756205727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3YwzkRnMfZVeEk+/7Wvw5WSR6O0I8sjCpbeLDEFgGJA=;
        b=kSpf9Uxm5W41FR3kE8VDOD/j7CzHia9I9b/aFNWgUjyRAEPTqv5ZDosN4dztDy0aSi
         yLuZY5i0gpHQ/kbUlMiXh7YVF9mwew1lH59Y0d25qjZUOcEwJ2vYoI2oYhpkMOQY1Vr1
         P8ovAU7mDKCpEYhSvl8yTywNscJLnEgHMNIousck3LLhM7EIuntpR5IDTXZSvYL+le/+
         bowqT/WqOLn7u5RkLOlI6IqDk8oW81k5/ZwhJiUS3+XqVm33kMw32PlVbkXStsesE+Ln
         Oqm6AcnKtTaF804x1xP0IWi7DgMmqngpHrDDIs0cdKgs0K+DfawdwjRJcspo1ZpkqpsY
         rH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600927; x=1756205727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YwzkRnMfZVeEk+/7Wvw5WSR6O0I8sjCpbeLDEFgGJA=;
        b=bFxw9wJpNogZdorwcIFSZlha84kCe7QWmUIN1MEMyf6Ew/eomBgF8wrS+equv8l/ev
         RusgrYBU2e2ULgFxg8wusqsu7rs2w29cXHe3RLy/8URc7Bpc4XFw1jafQi8zAZfmiHyK
         TvrlksJfGPl8g8J8n+VnFap3ffQV/aXuO3w1Sa223CFR/fLhZiWweNg/zPE4PH7qrCTu
         aMdnugVVdhOzkNVbJQfPFIP+cMWmcP9E13DVtdHqN3qfo0zd1UugC/ucRD22kdNwh6Gz
         EFzU4tT4U6noPSgASx9QsbMaJZ9VcECEAHKQt2mGF2gVrLDetVcxsikT0I4xn5r4vnSC
         5RKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl5kwj8NsLyjfp9AW7IXZB0WQxd9OjBpfCvRCXrJ5Xz7DeDGCl8qMlLPGjcdZykXs2K/ZIFCqyRRIJwFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lvGlCs9T0YiKX7osAu95ojhwJGe86e/5uNCrJW5mfJSihDVi
	cVqhH34G6vw0+lU8m7CKVNMzfxMjFHJher14BrNxeDNdCQ5vZh0IU1IWE7MPdb07laHCqJAJjwo
	EeU9K
X-Gm-Gg: ASbGnctyyHjzsn6cfvxHsS3PwbAyQFcBLrdd0B801JhsPCropvk/P2kf2N+Qc2lOBoA
	pjmCJtnxNquiUBjKm3/v9BMiWMuSXLDunmM8iKnJNoDQoXLQa6ok/n186v5eyb6m91Z1o0YyoOZ
	3SU4yJ/L2oG2hvD3M+6XKVCsVi0rmj1X8izjHCqdh4dsBs/1+87QPvRMfGnfW/wWOKld9l97e6N
	DvXpfAnk6oKGrEkIrI5d8z0jIxyR3J8QcnIJuhfP0Lka9Utpp8CuYnra98/cDjuq4/A4Tw9OiGP
	rt8yrdgFieoZE2x59+FbRxLlgN0GaPit2hcJS+2oSl2AmFhmwhxRuAtdSWbirmsp+1MI7jSy+dg
	fqPpZ9CI9ZZP8vbb6ALdLuKOv
X-Google-Smtp-Source: AGHT+IFaK9RKrxontcegpY0+M2PaHOjm3xrQx5EcdYPu8HX51IFFACknUu6tNWBen+MUCg8qKI/aUA==
X-Received: by 2002:a05:6a00:2e9c:b0:76b:e561:9e1b with SMTP id d2e1a72fcca58-76e80e90bbbmr2517917b3a.1.1755600926733;
        Tue, 19 Aug 2025 03:55:26 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d54e0cfsm2110954b3a.109.2025.08.19.03.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:55:26 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:25:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: use strlen() for governor name comparison
Message-ID: <20250819105524.qdkitat35fvnfmh2@vireshk-i7>
References: <20250819103940.342774-1-zhangzihuan@kylinos.cn>
 <20250819103940.342774-2-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819103940.342774-2-zhangzihuan@kylinos.cn>

On 19-08-25, 18:39, Zihuan Zhang wrote:
> Most kernel code using strncasecmp()/strncmp() passes strlen("xxx")
> as the length argument. cpufreq_parse_policy() previously used
> CPUFREQ_NAME_LEN (16), which is longer than the actual strings
> ("performance" is 11 chars, "powersave" is 9 chars).
> 
> This patch switches to strlen() for the comparison, making the
> matching slightly more permissive (e.g., "powersavexxx" will now
> also match "powersave"). While this is unlikely to cause functional
> issues, it aligns cpufreq with common kernel style and makes the
> behavior more intuitive.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

