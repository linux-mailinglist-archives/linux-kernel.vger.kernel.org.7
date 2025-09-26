Return-Path: <linux-kernel+bounces-834598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDA7BA50C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A582A8195
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F75284B3C;
	Fri, 26 Sep 2025 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NIR2hyag"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C507260A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758917462; cv=none; b=E5LZGpFy4PWOJQkGHDENlB8peK5zzOWI6Wr7KdOR4ovJ4qJBc8gXx3UIr/JgVg++mzOkNQuvdkF3PIP7kSN+xBBComM4rrRp3Ug+4b/xKTmUzdAIMZQ3S1/xl85jzEAlB/kHhf7cCjhl4hrScV0lyX9Osjr5J7lQFGgVOvydU9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758917462; c=relaxed/simple;
	bh=1yQrANvKpY0ljywMGibLEmI7xpn2zjzMdiYcXzsnAYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nddd3X9mpxi/HBr41Bh2bPnFaLKPAn05PGVoILjulSRbYS5EU4/dlN4g2id+4SUjr9D+y6yRB1MY4N9c0vPKR7G3b/VU1ceC9CY4QM/9yVro4ndxfB9lKedw2o5zQWoABEyIQ4mOOW96Z2KvnXpcARs+zWXmUcwifB/HvKogCOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NIR2hyag; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-30cceb3be82so2534888fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758917459; x=1759522259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+S0IT5rLN8S3zlzSf3mYl4iNyco/hSRX1g8S5jZJwo=;
        b=NIR2hyag1RqA8AF1uJamKoGp6Qxa1F7sW0kbnJez0PCJEj/dZiKozZ/eFP9Pvw0RLB
         /MQNX0kstKLVKRGLl7SDv0r6PrRpHouo1i+Fsoegz16Wh3S+KbawDZPSGzHrGYNqJA8N
         SdwMFlF+9Z8id2DXI/fjTK/M3gNJbTWKFhRbAUupFOKkjzCFPsjYUglUespA5MwW90Q9
         u/Z8bY/hDh4oW2fuNqwH5pZt1gf0HYP4amzfBs2ZOJMAxlJUArFDw9ihqt1N2PmezpP6
         vQk71EqtYYzmCVcGsmPw+cBWZTnUNbYYBKJ/+ABsfu/UGCwyRxFdtjLvYz5TAae1SfmB
         vV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758917459; x=1759522259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+S0IT5rLN8S3zlzSf3mYl4iNyco/hSRX1g8S5jZJwo=;
        b=SDhNoWN5Mq0OCbZvrrtdZw4yX+nMlgOrEwzfwm+MhnCgEWiwnOc5iRiLjnefLCJNaT
         0q9oCVeLyihRHQDUWOh0a2I/4IxWe0wPi42h0qPo0rX8dXVEU8q8Gzeelse9MneQQXcI
         +MA7B7Qv2jiRgnWWdwMRw2StbEJfAe1cPwdNLkRkUc8rIG0rD8V5vL6kUnmzqK2WXHlx
         x/xioBKeunJZ4ukFgo3T8+HmEEEjQKna92Sc4qKhj5kyik7BXuxGm1UX1heKUcVlAGPg
         4u+TmHfGbsAC630kq9lLf+sLQSFTn+r66GsLNFMfaQE72SL6p1oFJjdVSjQB53O2c1QO
         ixQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsmkpAuIphtZq1S6JdeWS1mXI4rvyqm+du2cBdVPHv9liMreE1sRZxY9WBWsy75/zwpDO8BYVT40EBdBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLK/9B6Y+8tAldaToFXMg788p4E+in8uNk9WKq5q4JjusWNwWm
	JJTf/KpYZkGU+UskifQm+sh3ciskCBn0BBtgWFbU0+jfgXS0+Fdtb8GlFINnrKOU/Ug=
X-Gm-Gg: ASbGnctT9xoPXJ6+ji90c+wq0aYHTE7YOf8fDwb6+sdxXOXTsRgIR583I83uqWJlzMS
	vST0IFc2UTJc4Ns2iLsSMf2E4TWjrH7gefxqYY1ly9NVzKXOQtYHu3dV4Y956JIVMMcm/J1Eisy
	RwcAq37WJeEBsCqfQc6eGet+Nc/hgi75ZcCW98Rpfwg+/eL4Vs5iAU7PYPk2++lidZscUkiIBOh
	BW6RcVAnVIdEkP+GTyDnVjsaUQSseUwT0iqBdkYp4PyciaAOy+RGACtYylUie99FFPLQYmTwbpY
	9kJovk/pSk5Kf7h9alsJTLpLasJduGeGY9Qs2GImPhpmJPZ7UTLB9ABN05Sd8gW5umhXPNpeFVC
	cM7Mv71RuKQEVUe2s1SaaBejgrL/tFTCsCz0W6gtdOCJ497YGDHedwQ/XaEpqHLSutgcQbPGgUo
	ZBsJmm5YE=
X-Google-Smtp-Source: AGHT+IFcyHFcbzgQMQ366fdi1lF7AzQiOaOUKjLiAJa9T6IxReaoQRfsmCjDR6l7iAESo+0k6Yda1A==
X-Received: by 2002:a05:6870:6586:b0:30b:7d90:1061 with SMTP id 586e51a60fabf-35ebed296c1mr5766812fac.4.1758917459275;
        Fri, 26 Sep 2025 13:10:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:7871:889:3150:8454? ([2600:8803:e7e4:1d00:7871:889:3150:8454])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-363a3f3610bsm1640539fac.14.2025.09.26.13.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 13:10:58 -0700 (PDT)
Message-ID: <c8c6390d-825f-48bb-9aba-7d91ecf1e3ee@baylibre.com>
Date: Fri, 26 Sep 2025 15:10:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] spi: offload: Add offset parameter
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Axel Haslam <ahaslam@baylibre.com>, broonie@kernel.org, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com
References: <cover.1758913065.git.marcelo.schmitt@analog.com>
 <d73804d605d494c6420adb7c0b67f6707628832d.1758913065.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <d73804d605d494c6420adb7c0b67f6707628832d.1758913065.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 2:01 PM, Marcelo Schmitt wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Add an offset parameter that can be passed in the periodic trigger.
> This is useful for example when ADC drivers implement a separate periodic
> signal to trigger conversion and need offload to read the result with
> some delay. While at it, add some documentation to offload periodic trigger
> parameters.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


