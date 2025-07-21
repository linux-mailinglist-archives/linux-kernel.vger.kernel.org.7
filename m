Return-Path: <linux-kernel+bounces-739862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2C5B0CC33
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321F5189F316
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4712023AB8D;
	Mon, 21 Jul 2025 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M1Ro/V2u"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E227456
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753131684; cv=none; b=Qui2z4LhTtQElTHn4sAtC1pZ8jjyBc41NRs1sK414tEffF5/zV5jU5809hYKuXfoMhiSAxxgYvOHqHCkzwHiu5zaQOsk38otdbLoJTe905QZUV6v7+87PCH3rM8j6hqV8vvT9zHsbBl0xwI8q8R8gX3j1pURa43mNDjw/773H4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753131684; c=relaxed/simple;
	bh=CMKwmcoyYWnuqYTxRDyFEXVj/77a1Rs4755k1CQKGi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDgnwksF9HuYVTSzNNfDtU1pVVNpMc7toRKjckm63dxxGXXsH9oKHFy+bvaQ/bFKx1gZep35GDsxPPrIhZzLFIegubh4lwQUeynJ5vCyRWwHHKn6FG9wEXtF/Dv2Um3L6uy/FQ4QV2HCQmLFC5391pmAB/IG8kuxFACRiZkpkmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M1Ro/V2u; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-41b4ebb15e2so2313539b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753131682; x=1753736482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rXWBks1EUAciZOD3ioE8/iGRBfqG2hakCkxED7hvB1Y=;
        b=M1Ro/V2uwKxv6dVzBOR1jZZV9E1W6+EfXzG0Zz+kjen9gwjQdCbcNsiDjawHrw54it
         jmFWXN86sZk9+Mdxt1v+mHsSsv6vwc2hgqmgB7DCvp67M2QRyEow6DzI1kR58KlSy4X9
         8P0XiB723gHrJxR81eAAPYj8KJX/ydz/EiXyWOqxXEeNB3ZQdO5QxIIMjvvpCZpBQwtV
         ZjCunRU+Ay1xCCmEihOgNw4mPGsjrwvDxA4RrhczHnZepZb5Irnu32fHUYe13/jlFeaA
         B19VasqxPi7YdXI9NgzMPGyyKXiE2mO4XEq5JsphrnfekhjfEpnFJN0cwZpg4Gu64eTV
         il0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753131682; x=1753736482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXWBks1EUAciZOD3ioE8/iGRBfqG2hakCkxED7hvB1Y=;
        b=W2IYcVT3K67DV3G0czEoItYXhqyWoEjhdn+IXK8sMgWe7bbeKXxT9TiLY+dHvGSwNf
         uBHeTcTaemRxAyyEqZgUdsWTr+5XiWGnUqaiHbPYr/8VryUANEYbKiRDCPdek1axT0Yn
         4WNK2A2+zBvtpyWcXvBmPK1xrTSvtcA61+THEW5XsUHrTmgWnD6xIHDRgVyTDCg8+098
         TlGEGaDKWT8uyPcW4ncdhG5ektqgAtL3AlpC7oGBiUys2tJJtniWxYVVMMramJTw0FPD
         yqko6PN69IIgGlelvsj1kksoSzOfqWZOLbJGUkjIACof8mBkgwUKevOm6bRHEyD/9rfi
         61cw==
X-Forwarded-Encrypted: i=1; AJvYcCU0MXMmCX0LKYmwPxZ2B0iUYahYWnWzDcofmGp7lgexJBeJrpbf9wKIxsGPktMKmq5lpZHVSKwsVw2MP3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6rh2D+2EvCK99b2MLYG1jxxYOKnP14nbyQvX+g8iXzzC5C0LV
	23AErDQN0Q4zSZNJLhWsh8fOP6SqHoUDNTad9dMJ0nnuvg6DhcGJoYRWJ6rUTzOR7Fk=
X-Gm-Gg: ASbGncslSpis4JraVn5R43PIRMGLVeC31Ph2dMCzFCk/W3tpeVMPrC7xl+mDbI5xEE/
	d/moW86J2uGZ2t22jReCaCvy5GSXbFCjkW7KttEfCUOLuFwk/6khonDUx3rWFTNgL2RSOY3g1AH
	NXVnA8BvBG5mQAm5heobLN/cpuzo0uKtnnG7zJ6Ktrk+HMjH6SQilkQeHy4DXxqLII5L/iJU/GQ
	a10IQP1kkY80n9vDra8d23pme7v0Nt3x2KeTXYomkgC0NGb+kEh+qARodeXMTF3zqHC9gAuJJLh
	2KaQGyI73XVSrpFX5uy55QMOSQK3H/0JxGwpnFQ0VdY51zlZ6BmXCQwvG1fDJdC19zLNjkizySy
	QYVw0oOGlmJmfYt/q5LOAPi935Y5h5C5pEezsjyZFFt4qupO11Fs4RRB8fszfSnlc+VJcxWA56H
	/MguMRqg/Vtw==
X-Google-Smtp-Source: AGHT+IEPt2O2BlG+TVDknWLjyVyFRxHH6uNruZppfA/oxvYn8tf3hlEwc1xHZLSg37PVYVenHK/2vA==
X-Received: by 2002:a05:6808:30a9:b0:40b:2b2e:89f4 with SMTP id 5614622812f47-41e4500b356mr12724226b6e.10.1753131681608;
        Mon, 21 Jul 2025 14:01:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3bea:f296:60f2:c6cb? ([2600:8803:e7e4:1d00:3bea:f296:60f2:c6cb])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd10c0ea6sm2827533b6e.1.2025.07.21.14.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 14:01:21 -0700 (PDT)
Message-ID: <83798680-8e3f-4899-8c58-d7da5587653e@baylibre.com>
Date: Mon, 21 Jul 2025 16:01:20 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I3C
 interface
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, michal.simek@amd.com, lorenzo@kernel.org, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, radhey.shyam.pandey@amd.com,
 srinivas.goud@amd.com, manion05gk@gmail.com
References: <20250721110741.2380963-1-manikanta.guntupalli@amd.com>
 <aH4mwkh80TUTNXtS@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aH4mwkh80TUTNXtS@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/25 6:38 AM, Andy Shevchenko wrote:
> On Mon, Jul 21, 2025 at 04:37:41PM +0530, Manikanta Guntupalli wrote:
>> Add a shutdown handler for the ST LSM6DSx I3C driver to perform a hardware
>> reset during system shutdown. This ensures the sensor is placed in a
>> well-defined reset state, preventing issues during subsequent reboots,
>> such as kexec, where the device may fail to respond correctly during
>> enumeration.
> 
> Do you imply that tons of device drivers missing this? I don't think we have
> even 5% of the drivers implementing the feature.
> 
In the IIO drivers I've worked on, we always do reset in the probe()
function. The shutdown() function might not run, e.g. if the board
loses power, so it doesn't fix 100% of the cases.

