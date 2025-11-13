Return-Path: <linux-kernel+bounces-898840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF152C56212
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA3E534C952
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDFC32F775;
	Thu, 13 Nov 2025 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MnE9TKaA"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0007832ED28
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763020549; cv=none; b=f6km4xEcJ1/mpnqmWR8ZtTCPPcovQ/6um5i8gorW+LAA8It94eHknzfDSsnDccsrFA2lBk2w+6ImuPO+1AccVRfdJsdrWhIDZtF3L/4+NGWoARAg3y9gKS77+HE4PaqQQI4pvchc/LJ6FOgEUkS2xD7pMrcL+nftQxWaMS2eVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763020549; c=relaxed/simple;
	bh=eGCFzE3FTJolIZuT03VIztGS+4PbmTrojtX2VPB4hNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByUAXC8sdMqxjLAzPd9CfqcwM2jGP9gmIFkHo3ZxZ8FY98a3R0LTmNiTdDkJY3z4OCf6LjAF5s8nb8CPnpLomQhhTJfSAhYXGS1FwcjjQBaj1NFCASlQB3+i72HqLokzZ1K4MH4cb43M9v/hf8jkFSoOTsqgh7TIjffECCpU4qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MnE9TKaA; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso396158a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 23:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763020547; x=1763625347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BqOCdzG8TVwmmpstxldCFsocgLp9/QVeRrpBCk4yxaQ=;
        b=MnE9TKaA3HEmrHiKHYRS+t+vWPcTMrcs0rXUHkq+C2PduJ8pJS6ms53NyCH5xqwN5+
         kDDcytqHUZ74OgmVDMHsQcAwvpmYJc/HiDiuDGYb55BzpLsVtKzoEH/MAgBar9ixPH4+
         0o1O07IURmMEvcUb8mrDemOsMQ72dlWX58zDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763020547; x=1763625347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqOCdzG8TVwmmpstxldCFsocgLp9/QVeRrpBCk4yxaQ=;
        b=B982wRWIqz376dJnwz4f8Q35ndOPr2SeZg1SFlqbCiWczEp49d7ulQT6unh5tSZtF+
         ykVqtjyDlsM811uab8/ipXClqwIbvipHbmIRir7M/Bfw1ncq+17A/wscO8h67n8SG22D
         fn9O1MTluRDPa8HMuWZzQTaa1rAbSveDTeCvgJGayASLKg8CIddEkJSqyxUQJHN6mUBK
         /g+Jr3BG13R8fXgc+aUQZyVUBAghM4ppnhxYGMSaahorUJ1tyz/R9EX4WZJxfYTIyxF2
         ddHUmvHhQphRkaifnQ7I2T9HRJJS+HaeW48jVNEL+BZAd+yFMsCzoKDpSCGIzwsPZoMc
         0bbw==
X-Forwarded-Encrypted: i=1; AJvYcCXndHUr68ie+B4VRb7W5Pn89pmgFvDqVPV2WAziaw/YuxDkVo0noa5NZHvwNU1wCd7PtqnGK/kajYPKFdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+48tZRX/36Jz8wZUDGvv5aNHF4zzYf646mNJFcnd8NtnRknwL
	L4xhudXyshaK2BquSmQc4ljnBCDRJR+czinIzWhIAVqeG/vQEewjTB2ZM5TAP6vwKQ==
X-Gm-Gg: ASbGncsXzSphEwuWjI36wRyQT+CoJYHGVAkSvOcwUsp2yEyApeYUx50sQhb7Su7KXYG
	LDvei7ZiAPymjGAMmoP9K5Hb2/A4GQUWzX6zOrssALX0jndOTPLLu9wlC48HYY7fsbIwuYfCD/h
	cv3DATxPn0Es+tdtNDi5MIIi9UAP18BgMVsX3NmdIQ//G0557inoN8PNjGmS5jMvb8BvalkYA0Z
	WaUMt4anc/ZMdUl7yv2fS8PWnYAbH+0LUdVA1nPxUcxDO6wjtYIAP/4BvDK+WtYIbElIBo78y04
	7oJKQHJZJH5ynFZtcza1djMsqL4tfdkgfDNjmePcS1zP+5u/Nr+LpYL2h+CAw0fP2fgEDvIfRQG
	ByrbCFWnk3VCUojTihSfGs2MkT/SGTsYQJseHKE1/r+VaCMOlgm+Ck/nRi9isY8l7mZNvwCD9fK
	iZp/RB
X-Google-Smtp-Source: AGHT+IFeFnwmYEOF77S5xrw0OtwdfxalTIPfjFUnxj2d/tiwYlK6zp64b1GatmlTBDH62gN5nOONJA==
X-Received: by 2002:a17:902:d54e:b0:297:dabf:98f9 with SMTP id d9443c01a7336-2984ec8e279mr73263485ad.0.1763020547289;
        Wed, 12 Nov 2025 23:55:47 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0c4bsm15357275ad.62.2025.11.12.23.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 23:55:46 -0800 (PST)
Date: Thu, 13 Nov 2025 16:55:41 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org, richardycc@google.com, 
	senozhatsky@chromium.org
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <ob2qytrsog2ydftywgdxdis25c2ygboqqltbwcfuaks4iaxzct@lwx7xyklzdde>
References: <83d64478-d53c-441f-b5b4-55b5f1530a03@kernel.dk>
 <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>

Just a minor side not:

> +
> +static struct zram_wb_request *zram_writeback_next_request(struct zram_wb_request *pool,
> +	int pool_cnt, int *cnt_off)
> +{

This is not in accordance with the kernel coding style.

If you use the best code editor (vim/nvim) then I'd highly
recommend the linuxsty plugin [1]

[1] https://github.com/gregkh/kernel-coding-style

