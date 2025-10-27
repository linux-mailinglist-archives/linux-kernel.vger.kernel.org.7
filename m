Return-Path: <linux-kernel+bounces-871625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB07C0DF73
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FE37506324
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6177277023;
	Mon, 27 Oct 2025 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goIKsUGh"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FD01FBEB9
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569873; cv=none; b=gk0PghkifVFWZowh23ssZRUeab9eMFm3n+JObiicVxoCqKOKf1AJtgq1zhF/WAaaJNZc64TV0uLwK4IfIouGgizsKp+hZ4NGzHXd3PnXWYd8dZN97zkkcB5IcQ/cX1DYrU8FpbCg40tPMTBMqA7oS4iPRwK0Ma5qzVL9eq72S3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569873; c=relaxed/simple;
	bh=pyPde2tD7sta07ClcWgjDqzIlXAZYN7QTmeWbVa9+zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6Kkt5KnJrUkl5/sfBz+ZyDIxxIQ09O8Qd2/ikbFlS0sqim3QwerfgZQ0WtHPh8w4WL/3o5MLVEiihZZEy5acbfexw+Jk3UOqsQp3tnkHYFLwOXD5cL0GwfvPjsL3gGx3aL2rSqwNYAMAvbT6HL/rc8YqpJzz9mhooP9mAiiuv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goIKsUGh; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso950525166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761569870; x=1762174670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bt8hfhs9I+4cz9Kty8JRd8Yh2y/LgGssMY+3G+FzciA=;
        b=goIKsUGhOjoRtQk1Jt59gsWztP48EVpJqsOEkocv1dUwH1WXrcyWnlepn3HRu6jRc6
         WXlzVIG9SxQoOITptfv+el+tFXH2HfrrTS/ffZrmVmZxV4uJyD8mJz2dq0kyc9hn0YfM
         RNNgZF7CYLuo3OOFz9S5/UIdQnR9y7Ld2qlVXgYnXb+RSDKfgNKxiGdLiSzqrBbUVVzJ
         lBmewy1frf4pK//CzRIM6bVRjrNR1wGzqwmQF9hkzhwGjVHmd0rm1YsGblOAy3rlQUE7
         jFtnHA2vXDL1bXaEwDZIqNcvzOWyqcikQpq3GwUIm41hwDLn7MElkA/YQZwIpfilaCno
         2jwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761569870; x=1762174670;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bt8hfhs9I+4cz9Kty8JRd8Yh2y/LgGssMY+3G+FzciA=;
        b=VS5KmxAWH7WgDIEEzY8a7/jAMXyZYf7OczyJNSl66ZlNpAa49yTQRVykeeVucy0MfO
         atlU4dbk/1Gwp+tRlC4DOHBgbcCCoYY0dmrg57svtHF8N1QFxdXrsxZgqSfz6zx/qmOJ
         P2lje1su/EnQ18hYnmPxGFz1O0D35+6EFPei/4yVQk4S2PjlqTVhbuM1RfWXCmzZC6Pi
         mRKzJUm46et3eCDu4/VGJcMjXLE3wP0YyqV3/+yWxp4Hkj7khhScVrHqnEgZ3iAqOpDU
         nCiKxP7eeqlqV3ddf6EJZgQ5VCIiphm3tJ7F9uuH4ki2NaMgrciWNGKhQtUY6sVgIdRY
         uQpw==
X-Forwarded-Encrypted: i=1; AJvYcCWxbkY9IZjx36EglHYJSrUy+G5ZqYdBjLTveBi4kvZ08GXdRFjoXnc679TfNa4YgtIAVQcbWB9IWoDPi8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3e0uLmSooRiwXU+mkzxUIczJXRcdTretCywSKtZIoDXrnY5z3
	efeSuwCvVNbgCcHRtYEPM3xwa+dePWZG+E5xg4WW5ZqY2IYsFcW83/jz
X-Gm-Gg: ASbGncu1HFcTo1PN+lt4k1p6nM8EFXbjlgxec93d5qvfv35U7ZeOFgbcSBedP21woog
	COfAxlJiiVibVzJ0zXig4KUsbXM7SoVc4PGx8XzGFgF73zdjjNBjorUYVGPmL5U2npfWyNgpmhQ
	rLVtUFtj9JWO/6rzQcdbOaak8+azovA/aMM4ItJJ8aCC8P0vhXaa0tNjDbApJtvxj8GSrD4Dnm3
	brcmOvwkw2ZPvUHD7NJp/LvYTN1Fmt/OnNFI8xOAyFkW2C/omhRjHtKS7J2YvxI1xETsq7Ycrje
	GBBdSZGJ5tUntMnsFV5I2wE8oJNKc9GEtolk51GVUw3W6uuyr3qfCfmUssae0BvNm7EqNMS5GcZ
	EqE3WoyY+Dy+ynC7Qi9UdN4MdItw1VxfoYQYy+bEERsuYjnx+Zy2RYMnMuqk5F/qWqGmPGTDSDJ
	6uIdXBdt2HYdrEKncLCq1C9rk+izHLoeJc05XWat4cMG65dH7d/mmg4xxFDK8/hwCKqA5B
X-Google-Smtp-Source: AGHT+IED0eySwGPSv4J4ugqV6CUDIFAw1J6FA5wA/AsapNt34ctbaLqKSrQbZ5/x2zVCw69/ezCHyg==
X-Received: by 2002:a17:907:728a:b0:b2e:9926:3919 with SMTP id a640c23a62f3a-b6d51b0d5cdmr1586027866b.22.1761569869610;
        Mon, 27 Oct 2025 05:57:49 -0700 (PDT)
Received: from [10.0.1.60] (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853c5bd8sm753870466b.38.2025.10.27.05.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 05:57:49 -0700 (PDT)
Message-ID: <664ef58b-d7e6-4f08-b88f-e7c2cf08c83c@gmail.com>
Date: Mon, 27 Oct 2025 13:57:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net: phy: dp83867: Disable EEE support as not
 implemented
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Russell King <linux@armlinux.org.uk>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
 <ae723e7c-f876-45ef-bc41-3b39dc1dc76b@lunn.ch>
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Content-Language: en-US
In-Reply-To: <ae723e7c-f876-45ef-bc41-3b39dc1dc76b@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/10/2025 00:45, Andrew Lunn wrote:
>> Since the introduction of phylink-managed EEE support in the stmmac driver,
>> EEE is now enabled by default, leading to issues on systems using the
>> DP83867 PHY.
> 
> Did you do a bisect to prove this?
Yes, I have done a bisect and the commit that introduced the behavior on our
board is 4218647d4556 ("net: stmmac: convert to phylink managed EEE support").

> 
>> Fixes: 2a10154abcb7 ("net: phy: dp83867: Add TI dp83867 phy")
> 
> What has this Fixes: tag got to do with phylink?
I think that the phylink commit is just enabling by default the EEE support,
and my commit is not really fixing that. It is why I didn't put a Fixes: tag
pointing to that.

I’ve tried to trace the behavior, but it’s quite complex. From my testing, I
can summarize the situation as follows:

- ethtool, after that patch, returns:
ethtool --show-eee end0
EEE settings for end0:
        EEE status: enabled - active
        Tx LPI: 1000000 (us)
        Supported EEE link modes:  100baseT/Full
                                   1000baseT/Full
        Advertised EEE link modes:  100baseT/Full
                                    1000baseT/Full
        Link partner advertised EEE link modes:  100baseT/Full
                                                 1000baseT/Full
- before that patch returns, after boot:
EEE settings for end0:
        EEE status: disabled
        Tx LPI: disabled
        Supported EEE link modes:  100baseT/Full
                                   1000baseT/Full
        Advertised EEE link modes:  Not reported
        Link partner advertised EEE link modes:  100baseT/Full
                                                 1000baseT/Full
- Enabling EEE manually using ethtool, triggers the problem too (and ethtool
-show-eee report eee status enabled):
ethtool --set-eee end0 eee on tx-lpi on
ethtool --show-eee end0
EEE settings for end0:
        EEE status: enabled - active
        Tx LPI: 1000000 (us)
        Supported EEE link modes:  100baseT/Full
                                   1000baseT/Full
        Advertised EEE link modes:  100baseT/Full
                                    1000baseT/Full
        Link partner advertised EEE link modes:  100baseT/Full
                                                 1000baseT/Full

I understand Russell point of view but from my point of view EEE is now
enabled by default, and before it wasn't, at least on my setup.

> 
> I hope you have seen Russell is not so happy you claim phylink is to
> blame here...
> 
> 	Andrew
>  

Emanuele

