Return-Path: <linux-kernel+bounces-787804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD75B37B57
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A68F681505
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44872EACFF;
	Wed, 27 Aug 2025 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D1pVV/NX"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C391A9FB8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756278942; cv=none; b=ItlLBHHkB1F6iIR2P+od59zMwhRV/rOSaDRQEU1URYb0PkaUP5RY61M2ikoRVzd4roHxr7x20udVmBdCEYCZogdflB4nsTTjH8hFKc1CbugZy6TjOttX+basThHYb3k1zp0tLtq1MQZkXMWBRurR5VPePklmJJ2VT4whLoU6Hy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756278942; c=relaxed/simple;
	bh=eJUdkWuojsgRcPJQERC9HoSP+HFyVytDvOc649sWpJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUgPT+l9+eJtrcB6C3AuV5Zn4iKN4yuWXk4PWe/Snovfb5H6j5BCzaL4uzaTzBAI7TMT9YAX40jrOSs3H/19ZA9ZDjpVsCF8fKjrCVVqplE7NRpxqAbp7AQzB3djf9gC5G4+RIB+BHdtlCOwd+VY45PG9BbOUE0nyV3TbMUxFHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D1pVV/NX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3cb9268511bso720892f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 00:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756278939; x=1756883739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hlLv4S/UPFBuBEfiiKihhCuycUkTi3/tZ4pnK9d2kGk=;
        b=D1pVV/NX8eOf5fqe7L3D32r48rrgVbftlA6cy0lqO2hrxTCbOIL9yW4FfCvffSsXXK
         Lh6wJOnvRb13PvczBGGX8Hi9QlB5n/adzirgJ7gzePWPf6+Z/Awl+J7yVj8N7Ky5gJsQ
         dAWdA0w87M5QYFP2dxlo6OhW6iqvCEeI5M+/MeBnjFN36lSzuZnXXtat+OmWcbsYGYjJ
         WOZtQekNeyWGjTqItj1xNASXN5pTxfJ21n+Ffq+MAHD+oNMDCO6relp3p3YxPXRs/K7n
         gfG/GYe5zIcRp54ALuoWtDLv0xa05bFUKZ8B2fI3c8Ca+4YRuKxrM+e7vticJ6G4AEzl
         GOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756278939; x=1756883739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlLv4S/UPFBuBEfiiKihhCuycUkTi3/tZ4pnK9d2kGk=;
        b=t4YVqpEyG/nnZJayPZLQR2NR7EaRabv2fC0BnyR/LbecOigpeUEBbe/SFs3LCbm3qO
         Cfn978vnxGdYebfWO3tarVs/l44Y2tEhKzhLY1FXDhWtiImx9iEibaeczZ32JicGLYZj
         krAGizSSewRG52nsFXPeT1VkIQ6rbXW7mMNV3prp3888kHEx9E21hfP+HHgEOrcBLaw0
         FlWrY7HKRLvIP9Sxd9Na7ELtyKoF5LAWx1Q27HLRF54hYxwz9B7PwJ9l4W4TJCWJzH52
         7750i84EDispRCjOfAMl69mSnLbTrDC/RPY1d4knx/DD0h+g0kPlXr/Qh/hPO/I3r32J
         Ukrg==
X-Forwarded-Encrypted: i=1; AJvYcCWQsMqzKRX2Q0A25VQgNMJgJn2ZzXGe6Sbs47Fy4wzkAwk8xferfZkqeiodV4lY+NpbNXlvGJ6By1l0Thg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNNxraSHXtf9FkQzg3lLLkK17kNhoOZ5VHut/Ri6z9mZ2ZgvcN
	Fu9VVjMApdvu4W5p5qSNfDj1K9+n0T/zyGGqYBz2ETUPA/+5Vw9F3ontMRicg44n+fM=
X-Gm-Gg: ASbGncu65tT8MawWyhDjdXaSzhkXloSFb0AkQjnIFbywAClsoilL7C8wGGJ4C51lyN5
	aG86pytsaHQo8xzXpHbHxFO8DI8V46q3BiiI3LkYtKv3Je1y9nJrWHPrdQh6iIBhyJO0refB90s
	vIB87/eV+ApAp26FpnWbgyFc7obxjKmLbK9ldqVbcQmBGrEBRfiUyxWVau2swcCvLaHP7lTNkG1
	EYZhKwUIFXImNf5/wYurYeNoR2ek8PEg762o9RX6vcXFo7w3VIPrb94KVS88zdC7u6YIUstHIMf
	D4pOJ2/0d7zsZLh7khG1CcMqOZyGWRI/Pw5OHv1vhpR9wkZ9CVjn9cAcQxyy83diaHZAQywgxja
	SQsUGA9TTZpEQucgirZQQJrduMBI=
X-Google-Smtp-Source: AGHT+IHGLQK+/bIqO0EGakdV6TeJY1UPjMkYcLkAtbFxpvXgRAwvr0BTLtLlmQ9ZA9cZOdmyT34Qdw==
X-Received: by 2002:a05:6000:2304:b0:3ca:ad45:6363 with SMTP id ffacd0b85a97d-3caad456a18mr5084286f8f.17.1756278938614;
        Wed, 27 Aug 2025 00:15:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6b1cdf05sm14123395e9.1.2025.08.27.00.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 00:15:37 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:15:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: gregkh@linuxfoundation.org, dpenkler@gmail.com,
	matchstick@neverthere.org, arnd@arndb.de,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: gpib: simplify and fix get_data_lines
Message-ID: <aK6wlcLBN1HclMpl@stanley.mountain>
References: <20250826220502.210485-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826220502.210485-1-osama.abdelkader@gmail.com>

On Wed, Aug 27, 2025 at 12:05:02AM +0200, Osama Abdelkader wrote:
> The function `get_data_lines()` in gpib_bitbang.c currently reads 8
> GPIO descriptors individually and combines them into a byte.
> This has two issues:
> 
>   * `gpiod_get_value()` returns an `int` which may be negative on
>     error. Assigning it directly into a `u8` may propagate unexpected
>     values. Masking ensures only the LSB is used.

Using the last bit in an error code is not really "error handling"...

What you could do instead would be something like:

	int ret;

	for (i = 0; i < 8; i++) {
		ret |= (gpiod_get_value(lines[i]) & 1) << i;
		if (ret < 0) {
			pr_err("something failed\n");
			return -EINVAL;
		}
	}

	return ~ret;

Which might also not be correct, but it's probably closer to being okay.

regards,
dan carpenter


