Return-Path: <linux-kernel+bounces-736038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E77B09707
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F291894689
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2CC23817C;
	Thu, 17 Jul 2025 22:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xrG5ChQQ"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B56E233D85
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 22:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752792573; cv=none; b=IeMsJJKNjzp3dmGnEE1YFPs0I3uCGYAahVhc/EBL99da5xvFNSaoLAG5TMwbcq5usg8dn5B1PZnzNqDHdWMoE1R4UmqlMdFr10AmtS03DPuxfis+j6OktmzgJrg/y8AirxxylxrDIrvarp9JzqNiTKzSeMLzXmjePRPp5mNHvw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752792573; c=relaxed/simple;
	bh=XDLsgCqR5rMMhTJ2ZHC9T9KUKGgbxXXFWq028nihIsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfzQJCpuSbqp2VHwYetfOZqxKqvV8U4aNSKlsvg5yja6lLXLAwxq8RYFGKJ0xWUGJmYvsNVWxgXmaNFDFQ2+kOKoBuapl/uSaROr28U8wUm0NxTjn6q7p6pGBGZILBxP0NItjuXXX+1Y9G9PZdVSAcH7YW0DPYW/OWFuMN5eeUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xrG5ChQQ; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-41baecbdd33so888065b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752792571; x=1753397371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EKShhrgIbRW00JGya1WIC7YMrAAY4oSTlCo+yUKwCBQ=;
        b=xrG5ChQQhCuNQGsl5lJkodex51ilkIJrc7RpBPGDfYOB1FBLHMyN/oJRgAzp9lHLW4
         AYgwWdcMGhg3oyI5nIRCEuErJIzRMtHCRcqOz0T/WhNTuJDiT786i6otKc2Bk4lGrdMk
         PAwuG03I9Y/GHi+qNYvBz/3duQUNtF6nhKza0+ZWpmx/0TwqNqhT7YGuwduZ9smeSnYu
         hYKxByOiM7CQXXPTSzF3vv1Dd3UOFRRyuNh6m5Mlp4QqaW89WqCnvXkHj93zb8GYfr6O
         Z8gYxbvQSmhn2zIMIsD8eMEvtrvjC06wFIOwZ5YqdQTOnDLAz9+IsZXp2pCOrScwstBj
         hQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752792571; x=1753397371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EKShhrgIbRW00JGya1WIC7YMrAAY4oSTlCo+yUKwCBQ=;
        b=gLXIxDI6Bg7I+/VVtDLMU/iiIMxAaJY722SPhMeaOTaj+VWQ77pOQG+oePv21/3Zjf
         itzeK3LJLjZChLz51PeH4g8AyLbibPJ7MMSUvAuEVkkBS1yvmeJ9s5vIYjmteqW/Eqmc
         dBywy/iYDgUgdsIkJwLv5+uIP8epx/IRRflUpXkktX+VmVcM4imawrpFtrSwMEyry2NT
         dDNDABCc9Ge0eXuwKhTXmU4mRq7nBZ6ePa6GhsJUSdBWJjXKNdP3tBBHq1TpyWr+atSQ
         B1kMKHrbYb16pCgQSZ2/fRV7kGioVySAVjrMUxJl83mxVsEciCVhtlHcLSTIoOcR5O67
         0bhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5whjTKJwQW5FQF8IJmuBadMCMV4mW+pL7mOYyyiW6wBZdj7Kv6+vNUSIerCYtlF2bGWVbXnG7XLE90fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwafenSor65awL2S1BSf7SM4yewuTNkL5SAyrMycu2S7I5d/1zy
	CMnMhgvFBTcNYgT20n0JSxKzB0qAjbA1g9KzoLCt0FSJcyxuiKujAs9H8XkVBsuwAnw=
X-Gm-Gg: ASbGncttZQ2gb9DtYs1J1zI9sSod+dUjZm80tIc5KayYm1n34qoSi49ML8/KUH+t2aG
	fh6WJfrSUqTVh9RRsqrXO3in4Muf+nBSXKIMzJrIb+o6VjD5mCWVnA5UgjPomFuwef7Or8jjtKI
	oNV7qWDQtYajR72fT+E1oxRfENsEeeNbIh3jjmY1pliyuGkhrATzVt4FrsZDjFvrpGlmkvswxrB
	5ExFjINiVIUk/c5/Kv13VAallK8bwldxFT5k+UWwoxydIDFZAdWJhW18OH7qBh1Wrm2pbA2R8DK
	1ghWYu3kxmx06Ft4owJrUHXqb61Bxa3MDoC+xYP622ZESY9YQezquS2TEkKP7TTymyqRZ+6gKvr
	B/4eeiJgUyjFko/FzIitCmUF1abwLEU4U7pWaP18ac/jNAMJIYWXR0YSftO8RKFYz/w9dv4Um
X-Google-Smtp-Source: AGHT+IFn8VldGILt9QVnRC2e8VCRuk/cvLwVgRVrgNxGjoWGiWL+0N9XGLC53WFZJaK8sN6Pa3x2Mw==
X-Received: by 2002:a05:6808:4f22:b0:3f7:28ac:8068 with SMTP id 5614622812f47-41d034f2523mr6212172b6e.13.1752792570551;
        Thu, 17 Jul 2025 15:49:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:b499:5ccf:3f5:ecec? ([2600:8803:e7e4:1d00:b499:5ccf:3f5:ecec])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd498c1d6sm8494b6e.28.2025.07.17.15.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 15:49:30 -0700 (PDT)
Message-ID: <772b61e4-eebf-46e5-b83c-76e947d33043@baylibre.com>
Date: Thu, 17 Jul 2025 17:49:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel and
 avg sample before setting register
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250717221559.158872-1-rodrigo.gobbi.7@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250717221559.158872-1-rodrigo.gobbi.7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/25 5:13 PM, Rodrigo Gobbi wrote:
> avg sample info is a bit field coded inside the following
> bits: 5,6,7 and 8 of a device status register.
> 
> channel num info the same, but over bits: 1, 2 and 3.
> 
> mask both values in order to avoid touching other register bits,
> since the first info (avg sample), came from dt.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


