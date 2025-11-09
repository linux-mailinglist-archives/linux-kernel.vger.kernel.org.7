Return-Path: <linux-kernel+bounces-891941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AD4C43DEC
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 13:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8CC72347355
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 12:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7992ECEAE;
	Sun,  9 Nov 2025 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RGw7p8hN"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6882EBDF0
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762692227; cv=none; b=LZaSFx6uqoe2ATEHpFqZ0dCdzaWubTwQmccdb2+ExVZvUxF5fKqan7kaxLYLq+gcdEGXUZ2KGCDvPXPN5FtljaPNQKdoo+U1ocOtre2Pg9s0Y7/Hvl7hO/O6wB3baENt0CdLvMOAn2X2YyOlZpAbGroVdfUtpVI/vM9LRXJlTVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762692227; c=relaxed/simple;
	bh=BS5KrCiw8PRT9pORU3Re/5WSroIZAKASnJGIlF3es7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMBNMzr3cOfLwmUWihL/hnuSCAvS1q3mczHawnVe/V5a/7TDuA++9eqHeEKbPeoCwlYk3UtZMYZrgWTjaToWoxugi6CoPFdD3YKg767j2ZezkG42e4VdA6QZ3YPJ4SEazjrYpeQH7iTynDxxKKMWRc78VSGgV6U/UmSnhB9PmQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RGw7p8hN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso4416130a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 04:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762692223; x=1763297023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GWErFsO2tEX/BOEFeY/JUuqvBv8pyRA62qDCMk8OHC0=;
        b=RGw7p8hNtL1ayOFEGVZTU4WouxNqK8yu2MEPSf5gx2EU7tVz01TOOgDt0KklgcbsWW
         mt9pfTmAXtzl8xEXjW7hV9P0SUiDz9nUaj4+ywh0YFutzB1TCTANBBXKi3v9kMnoSsba
         ljY56Sm/xgNKoeqOVnm/mqw7zLoJpZhvXIxbbX2Soxl4pQebys9n232zR58dzp+2VxXk
         7u/598z3jDO8PCP9uBd+BZwAQvLO3QmHq3XQ4Jw+8eDynnuO2hWrsEWZV9+grYQUOHka
         4wsCgKbtr1b6Q6+yrj1jxXtKzEA2XM4EXUqK6mkXl+nBdzkeNElVuGBtMb9udl1I2FBK
         n//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762692223; x=1763297023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWErFsO2tEX/BOEFeY/JUuqvBv8pyRA62qDCMk8OHC0=;
        b=TYcIvDkLgwvkk09o85Y7RkfnpTARlmIrhZI9BWybpFvkzyTbmYv4nv9ozkIE7fB9xe
         tqrsv4Gk+4Z0eWKbtIaAaG6C2l7DvdBWcEK23CQ/etSayYt/2dTzVobhWKDesPfBwhUA
         F870EKOsxYaLkUYw2EpYTtWkKBRsjAav1dGqJrLG0cEqmpLniGy8bNY2aFbDoGb7j3/1
         gxaS/XCba8oooArL7Pru+ILoED4AvEi29QQDCwFfanHpbzwI3nztDLX1egIioU4D8yXJ
         E1WTWUOPooC9C/KpOj8x33W9MIPix8A1MD37h2hhlNzKHuUaa65QgH2k3yD+w0ysJIr3
         da0w==
X-Forwarded-Encrypted: i=1; AJvYcCW2D2O00oqCpWREVx76JqnJWu3Bp8ycvZUp0bQDILHanRnmmg8E6JjpJ4l/u1Z01AcZZ1aM+ZCb3wi+c3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYokeg1P47uOon02i8P8WzMup8aZWKZLH8LMlguxF5HekNjs0D
	AyCNgN28Aoqp2eEYamWPnHJBBUn7jRtwtliC6HFnqelXOJKP55Yr8H7FfEoKoWjxKsw=
X-Gm-Gg: ASbGncuPYghnBnOnIVS8LN53L1yFzGMG20LnxZrE7dFIgX7qwROqjHQWsbToCoWpelV
	rVWHSyYAan+JOdpYDSA/nVwrHBqErb3keB8A3+QKNFUNpncIkfXU/pmWN2poXAb8QTsCtSNRf5X
	EDTlN46CW+R0Z6Dj++St0J1+vfaclQ67jUlyNCeNcyBjXd0axRAOaztDRSRQcfIQHH7dWakHVhS
	d3Mih0DZGcU4AivcIPhRm4YJwReYfI1VkD7wOfIxVY0ShLoay8i8NUIcCMkBXN7/vfKjIpHEn7K
	IDPm5oyrJXqiHDJYiWg9v1/dLJbDCAPydfFONH8mHs29OrSnOmzn2tDkeH7k1bzTHyF4CnxbMwZ
	QyHUpcSh0VfZMSK4LQROcCp5a6OHmIqBV7Jjyx5Sr1W9ryEP0KY/RU5pFH9UpF73y5BU9gRGIhS
	kXVo0sUiOmluW13O2WtcSUDuDi+fod8UAqOqwHrIKXTGuNxmtRewdaOCOWGUHHuQpLvSniudqP5
	IjtsaplHtSzG+SSwWULMiNNVzKYxI/gT8M8/almPu8hD6KeqWK6ALhxyNG78naee1UebHGBwRgI
	VPYwiPaNryw=
X-Google-Smtp-Source: AGHT+IEmKraCtXyz5pwfItQXmoPTPeRlR1wlc8EhkGzafL7gDnpHwT7RooYHeCo6KYAU03Bhf73/iA==
X-Received: by 2002:a05:6402:3042:20b0:640:c918:e3b with SMTP id 4fb4d7f45d1cf-6415e80b1d2mr3448160a12.26.1762692222982;
        Sun, 09 Nov 2025 04:43:42 -0800 (PST)
Received: from ?IPV6:2001:1c00:3b8a:ea00:4729:b0ef:dcc4:b0b6? (2001-1c00-3b8a-ea00-4729-b0ef-dcc4-b0b6.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b8a:ea00:4729:b0ef:dcc4:b0b6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e9d7sm8852874a12.36.2025.11.09.04.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 04:43:42 -0800 (PST)
Message-ID: <a13b5b89-ee13-4fe6-b57c-5e4ea724522f@linaro.org>
Date: Sun, 9 Nov 2025 13:43:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 8/8] media: qcom: camss: Remove D-PHY-only endpoint
 restriction
To: david@ixit.cz, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Petr Hodina <phodina@protonmail.com>,
 "Dr. Git" <drgitx@gmail.com>
Cc: Joel Selvaraj <foss@joelselvaraj.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20251109-qcom-cphy-v1-0-165f7e79b0e1@ixit.cz>
 <20251109-qcom-cphy-v1-8-165f7e79b0e1@ixit.cz>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251109-qcom-cphy-v1-8-165f7e79b0e1@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/9/25 10:39, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> C-PHY mode is now supported, so the endpoint bus-type restriction to
> D-PHY can be removed.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/media/platform/qcom/camss/camss.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 248aa6b21b5ad..1408e8a03f0bd 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -4044,15 +4044,6 @@ static int camss_of_parse_endpoint_node(struct device *dev,
>   	if (ret)
>   		return ret;
>   
> -	/*
> -	 * Most SoCs support both D-PHY and C-PHY standards, but currently only
> -	 * D-PHY is supported in the driver.
> -	 */
> -	if (vep.bus_type != V4L2_MBUS_CSI2_DPHY) {
> -		dev_err(dev, "Unsupported bus type %d\n", vep.bus_type);
> -		return -EINVAL;
> -	}

Might be better to just expand the check to include C-phy, since there 
are other bus types that are also unsupported.> -
>   	csd->interface.csiphy_id = vep.base.port;
>   
>   	mipi_csi2 = &vep.bus.mipi_csi2;
> 


