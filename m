Return-Path: <linux-kernel+bounces-763971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4BAB21C33
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD702A4641
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 04:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1C01E5B73;
	Tue, 12 Aug 2025 04:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NFxhnCw1"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE4829405
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754973949; cv=none; b=iq6zAqMM5D6mPy9kXG5fOiIqz+29/efFaW4GZC0buhtrFIdkrn+d1tSwRVqdAJcJF2HoXWIIE06IfY+4ZFvXQ1nG4ukxpQHB4gLnmmLxDBm0ASx1/Ou50BHVvmMrD75qEDr7/P15iS0b8B943J8A6IFSQcMwZsxAPATdtxE2uLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754973949; c=relaxed/simple;
	bh=8YY8yYgYkUZf52of1hCu2IIXLv71NlYAyzDXjbp3vXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXjE/AmEnAnU0hUkkhi7zqliD0bEVkcTr+ndOCcxWQt6SFBJq67koun5Df42eAamytMNGq8Vf7WB3MuWkwDp2htb3zBctdI8DvpgnGMJQp0+y/j725vWqLCE9pMHTAXBBTdxPmPgNrBljtEiLK3i2foVoIlKvnFJDsJDJjfQoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NFxhnCw1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2401b855635so38164465ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 21:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754973947; x=1755578747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9TUiW0R0NbHOtRdtKFyqHHtdZBiZDY311icZwmRIDg=;
        b=NFxhnCw1BWf3R25Dtqzg2Zou/thGCS304DwIBrvn3jhlVkoHcDDHfh1G6Tvf6knLqb
         yuV7/KX5XjHsQXr4dbIXqGWMoavGgB7LWGnuDehDONER/wsRhHrQ+1ivLaoTlAEklPRV
         2xuHqwhqE0gWErsOiGDj2nSFbBpXPKCrxNoMG36oQYVpzCGcLxNsCKtMW93s/vhKr9lh
         x1xz000PeCeofKZqYqZWzpiZOrDruhLzrOn7z8aXLCzckkgn7agSxabEalUwN3LPpHgH
         0mA0TPQyqXOyRFhabruaMAP8q036GGhKcRFkL0SUR9hMXZbBrGhpujyhrySomWLlWsmG
         EEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754973947; x=1755578747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9TUiW0R0NbHOtRdtKFyqHHtdZBiZDY311icZwmRIDg=;
        b=Rsg6uu5zrS7bwwFEyybSAwatvnaP8leCfUuDe947hp55tpZIbXqP3mYiiIpHrePo8o
         hIEJqtPr4PJSJ2JiwjCoLSehItr+EwBiWwxQTFlQDgnNzy3l0VQw2ltiqPSS/9CRp6cz
         GOIsDU1tXP15tUs4sRJJEp3qKsTLgtytY3cemwbqbF6BUJnZPD62cfcOHMdV/eJdcZEe
         oBXiZ8fv3kqzLDWFa6pw6PChwht4a4xXfyGQGm9KXht/4DdYu41UNKstkzSG8DDTwuVr
         yWzbRcKCfpFKVY5TQsbqNckfPoup7bqETPZzxFWI8oV0+J2lnQYnH9S7onTzrZG2Kcg0
         MLjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaTZCKdP1snga4S10RqQOCEHZGhGo2KCNb4I2MTMlsaQspMd/r7LmpZuJdaPxTrXt/X2Sc9I0ntUDjVAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGL+mPgHCQXpza7y+Z5xDeWTf94nTSb5IXk0qWuSwtMuPfkOTM
	9mNNfNfB8mQqxDNu9ezAb5U1uC0uGqqMXDEbQw9E1KIiZT1sz8tMKTvmDDyDmXBiCN8=
X-Gm-Gg: ASbGncuamm2Wa9zSUsKYbXVpddhYCZTkv5sLHnSxiqqFeeqpQbzw7mVyFAX6xEcQhWo
	0sqEkk96BrQZf2oejAbizJYj4+jNVQrwOGoqpg8EC/ag9qDSPSqmS6vrd3WKUOlHGnVcws5IvpQ
	+x4ClF3wRO+gWajx12x7SqBxW2YhynUtdmohINSlEOKPs28E/ChXJI+LxayFv9TBZ23DJX0S+BV
	YxcYucGfgsMf5S5vBDS+p+ADZU6z4QzXjQLjeMez+zwFycOuHmdFlAH9+yXjfb9Dv83u3M1zumX
	qowdq2cMPpMNLWuTiU5CS5uCTQm/Il7cIg0HfR8OyB3y2saI+e6vtSQQogdvndNbFrQzJiuKMq8
	VPoQ22tjsvkGLK95Tga29jc9a
X-Google-Smtp-Source: AGHT+IGQ7XozfiqUhboZX55NTM9KwUdBt1QaWWqLwnDbnoSlMVijh1WIf1yZDd377yQYi/XH0IPj5g==
X-Received: by 2002:a17:903:4b4f:b0:240:763d:e999 with SMTP id d9443c01a7336-242fc3680c8mr28229295ad.29.1754973947351;
        Mon, 11 Aug 2025 21:45:47 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6bcfsm289809355ad.5.2025.08.11.21.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 21:45:46 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:15:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as virtual-cpufreq maintainer
Message-ID: <20250812044544.52ahjc55kkgt3cpy@vireshk-i7>
References: <20250811215104.3469878-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811215104.3469878-1-saravanak@google.com>

On 11-08-25, 14:51, Saravana Kannan wrote:
> Forgot to update the MAINTAINERS file in the initial patch that landed
> the driver. Add myself as the maintainer for this driver.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied. Thanks.

-- 
viresh

