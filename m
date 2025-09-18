Return-Path: <linux-kernel+bounces-822448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A437B83E85
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB4E1BC3840
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B3629B8EF;
	Thu, 18 Sep 2025 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pcEVHo+b"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5E9279DA1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188995; cv=none; b=iwWOQ41cjUMtN90v07QgYPwGhv2NPCsd1nHw07RCm12oRdT3J2XsKtwP2g7c1TJEWM3Y8xkmNQDEG4AioPSa2creQTY70w2AKEw+k57zXkqooQG3h7tB0zBllXjTciAwdbYLtvLlNaQzynvucV9Wd9JerfW+/on3mnkubdr2rxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188995; c=relaxed/simple;
	bh=pmKMdMwREhDVJrJVVTTvY6Y6Gzyv37bc8Q/TErqBVNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueOZCt53ryasNWUuPh9ggS7AGNzyb4pdqjKh0iwAc5gG0x9j91sRMgv+madgPLYdxEUMudNCzLjsNS56AqMwLMm+qff8+kQjxPIw5lbVl+ZwyRl87BzQg+Y8IQ+QpHlGtatlZeMhHKNNR0n1j9j2rT5smC/p+B7/s9paGEbhT7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pcEVHo+b; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so193183f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758188992; x=1758793792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I/gbtAHMr2GW0/OahgiAYUZjpkj23jMbWY9WrggA8X0=;
        b=pcEVHo+b5EGJhi6LpZy5k7N10TOe/7p96AWo3+WvaPa0+y9oMMDTYGdvZXdCtM1sZj
         ofoctBLYOCgCoN4W3vzL8yPM/sDbuyKByQhFfZXe+UDE9BLUPERp8jU2EG3nuYoL2z6G
         +fvqucKVpv2hqDgo/b4q+4GAPswY4r0HCXL1eykuImDxxiiYMlH/0TOmuCbd84dWyuGI
         otX/AVLoCb5ayqtLP9mCbY/mpZWP3TIwtaZ/F1W8ifGKJlL/ieSRue1NTVFWMEeFzFVD
         qTiyR5CnbzIKe7DqJ70NHjXXsTUJkAqzxPJmqrozedifiNSspc4ivqex+YoNscP2gGBI
         O8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758188992; x=1758793792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/gbtAHMr2GW0/OahgiAYUZjpkj23jMbWY9WrggA8X0=;
        b=IHmuPtzbyGtZF/fsBmCqHRjnaZTDVdVD9LbvxlSXfRf2eQrk3ecYfmtvs7xajkVIxc
         3y9V6q3vYaFoJV62QYmIM7Q5Sx/JvsyiHDtikRu1ST7h7QyBhLdrGSaBksYyDzBBGKaz
         r3nLwaeTzYQJ+h7xwmPvX4j9ODXcAuqv6zOMFh5iCFDjqLkw64XEQFigzsq2PS1Q2mwI
         lzsu0qeyUngvePTVO0ZJUKTcXJtDZmhzvkI54DN4dgNnM7cZGQtTJuLlwyKjO9AyxyuK
         N500oZ2LxmJIqgVkeEqpNyFdIkB7hCaF3P4a6QmSL4hHwl+PVGNxXZj41o99ifG5b3xf
         7J1w==
X-Forwarded-Encrypted: i=1; AJvYcCUmZvM/AmojJG7oLdXKmRKvexWz9UVuL9yLoVXi+PfAHSFocj6mP9M0r7WW8J0oV33HKa4cgkYVE5svcyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9IGTfAC9eGefj53Gyzp4DqCCibDJjnyJXvSVjyCKkgnMJ5Ecc
	pLx0rc8JGBZKfBDc3TwpByQzRJor9xUB1Xa4cwEL6JJuKvo3EsmVqqQtg6Qpx8DOR8z5mo1jByR
	lbUDV
X-Gm-Gg: ASbGncvlu/Ce4HWW4wGnUZ4RMIlhDHLhDX5/E//P3kfPXzdlTDlQw5oLwRoNmDqLSo3
	CIx42esPnXg7TDXASg7uRPTnTOgrDlLw0Kj9Rni7InPg8jjb54KwM+skzYi965magzrTdgPmfng
	jAyG7sb5JVcC/lrXeKNgqKvKErZaecCozu4EqIiF2XdD46b05hPVw1ZQVesynaRK020Jitk0qMc
	N6rMeviDe4naIAXnEBr4p7jh2fwOkiwUODEs6qmmqVeHYvNGG655lwfCyrU3/d6CoB3rWeHAG9o
	pqoUVS/MZkrAPooHdpyObsJrSLuI9XlPNTXfKwsR+lxP+HDFgEX7vhsfIrvJrlLAau3pRtc2oVF
	vcAFKtUmOvjh7/Fx9yTZLyldMuSBiXEgmAkAqW5pVzIm8sg==
X-Google-Smtp-Source: AGHT+IGxQiegj2o4mPFmZMrmoIXlBv9b1w/nkqkoOE8IISbZ7wbuT9+6TsbLyb+3Ro80AXibobzQxQ==
X-Received: by 2002:a05:6000:2284:b0:3ec:de3c:c56 with SMTP id ffacd0b85a97d-3ecdf9ffa65mr4464540f8f.16.1758188991925;
        Thu, 18 Sep 2025 02:49:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee0fbc72e6sm2816898f8f.29.2025.09.18.02.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:49:51 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:49:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rtc: optee: Fix error code in optee_rtc_read_alarm()
Message-ID: <9e3718fe1128964907619ad325c0c5f5c1354ace.1758182509.git.dan.carpenter@linaro.org>
References: <cover.1758182509.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758182509.git.dan.carpenter@linaro.org>

Return "optee_alarm" instead of "alarm".  The "alarm" pointer is a valid
pointer and not an error pointer.

Fixes: 6266aea864fa ("rtc: optee: add alarm related rtc ops to optee rtc driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/rtc/rtc-optee.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-optee.c b/drivers/rtc/rtc-optee.c
index 7b44d7723cae..3d5662aa1bd8 100644
--- a/drivers/rtc/rtc-optee.c
+++ b/drivers/rtc/rtc-optee.c
@@ -299,7 +299,7 @@ static int optee_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 	optee_alarm = tee_shm_get_va(priv->shm, 0);
 	if (IS_ERR(optee_alarm))
-		return PTR_ERR(alarm);
+		return PTR_ERR(optee_alarm);
 
 	if (param[0].u.memref.size != sizeof(*optee_alarm))
 		return -EPROTO;
-- 
2.51.0


