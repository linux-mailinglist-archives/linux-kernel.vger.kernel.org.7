Return-Path: <linux-kernel+bounces-791130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 752CFB3B250
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BBF64E1965
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAF81F03FB;
	Fri, 29 Aug 2025 05:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H8kXuusF"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F1BCA52
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756444464; cv=none; b=uS6TwoKDvkcTOQNSC6tSBwcr654wG5eILiGuE62u4k1XS/I187SEXS0RHw7IvJaUzKW/0vcMAiRvhWqOVwreAHUShcqUXXordqS5wCKcntUlcDWWDC2fmdWjLTgolwB4asLJum6xn1LA8Hi0u44IAZ8t5ETsd6YeAAaMuZpnyEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756444464; c=relaxed/simple;
	bh=XvxzWgF0tVpSBEanJzBrM6B3ZbAaP+LtEnf7mGHux6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRqawCTYXjE7W/YFyyHHcqOzZ57n0cOEhvq3oLNuyq79yrVYSMGWxXOIbHplpEQkpgq1SOcQlhc4TrhlCVpnge7N63mFEWI6eSOX9LPSKkqqR1m4FRG1u0LNd5BEdN7cyH8sXo5mNv7hZoE2T79YSZsAPLDGos9xnNq8ZRbcIPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H8kXuusF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3cbb3ff70a0so1027250f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756444459; x=1757049259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c7UODCIXZhdTmzt7aUneD9LIvgM+jweZ/BcMDAqopHc=;
        b=H8kXuusF7oQyk7/dTXYbokjjro4sXUpLdrdFDeI2HZW0DdkqZLDDudNUuOVa4wAPg6
         ZKaP9GXkH/11g8jZiTPLfXt373BIJ8NXmalz77g7I7Tar1ARdJGNy7WV+pMmUS7G07A8
         f/S6Mn/mkfRr+LNiG6nUI56RruTmNZB/KTsyJm1eWLjPg9/j0BalzamVM+L9Tji5wyf+
         zYJAw64swg0t3quC9OlA7UZY18qX0NJVGl23uaXxWA7hSRCUcxNzHT94F25Q8a0fIaLa
         tPBToy9CIew0k0tPeRb/jESr5/ioMfQB7sHmI7bngxGSlEYNLYWsA40NMNSjQBdWzDCU
         /qEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756444459; x=1757049259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7UODCIXZhdTmzt7aUneD9LIvgM+jweZ/BcMDAqopHc=;
        b=qwImyBqXukf30N/0qByA5R+LqbrOITVJK8xoiZkQPbOMS9icUfUXVOihIwlY/T3gPw
         bX254FN50HihK9cKrw/WTD+1iKfTkfUP7wFn0dZkHukgHJ2Lp7GRadtZh4ZkTW6fKO72
         KFZv7kvv883eqEOUeFrZ6suypKmhf0WyfaFX4NhDxNiC/S1WpOAGQNG8ALPG7Hyr2TAS
         77D5qLOVAKNmkkLZFDmOQe/mIZeEog4KmtDtOt894JI1kweiUSEsKiJQ0bF2K/j3WBTp
         wH5rPQooCENxOqIGhOVE1meNblyhpZEmT6xHE90+4KHSdVbk7N9iQBLqbvqvc/FDnFtU
         cv9A==
X-Forwarded-Encrypted: i=1; AJvYcCX0mbVT8CeU0o5k2hXpMcr59g5f8URjE2xfjKxUG++qTODOOzpiTUocZglFKJIXx7ZAyv2nkNTm7RccZPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJKIeqYbUMC+pkngjQLSjAuOnuma/kd75h4ed7EDR7Z8W4ha3g
	nWDAtMIov5yCYxZZpZhSaXIjVVMYDYshFFIIzdobNtpjJiNxAGZku75cNJ99PziCzJQ=
X-Gm-Gg: ASbGncswY9RlBBsyABTEUktb33KnfawwbyRx7TJcrgWg/3n3EHn8MWXtQQ/GgFrcuRA
	zm6ju+rHfxJKHiVR+i+nj75mrQD492V4bj1aN7mfDS703VAoOxlk9PuDxBIl7b8OQdOqKFH0azD
	rOx10g76IyTN239CWsW4GFwGuEf4t+DH3CznuFcTGA2L1FxKx7jUX4ieLYWJCNd3f8wqIAxK31R
	h9ZNsqnStE3hqhBdwfG3575Cc3UwiZs/3piz7qfwc7TrKJlGIG5xUtCVIw1cneShC3l2hLoZVdi
	OgPQ0MDFMQRp9dKEXgwaixCWqiZ7ZqmMCFlZm3FXoYBTl6fEtRTTaQJccyT+O9NwAcqC9+Wj69l
	MJMBq3FpIPw9xEKBWmRhjyHfPTTE=
X-Google-Smtp-Source: AGHT+IH5pdSjboysPCn2XrxwCkBFPtLeBzZ4Q5yRET3A1gZcifDhgAPI9FpftrUsQJLw/YseU2kF2Q==
X-Received: by 2002:a05:600c:45ce:b0:459:dba8:bb7b with SMTP id 5b1f17b1804b1-45b517ad7ebmr226210555e9.13.1756444458949;
        Thu, 28 Aug 2025 22:14:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6f0d32a2sm111769355e9.9.2025.08.28.22.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 22:14:18 -0700 (PDT)
Date: Fri, 29 Aug 2025 08:14:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: yingche <zxcv2569763104@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: fix fortify warnings by using
 struct_group
Message-ID: <aLE3JgL4WQW2BA5k@stanley.mountain>
References: <20250828094537.884046-1-zxcv2569763104@gmail.com>
 <20250829040906.895221-1-zxcv2569763104@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829040906.895221-1-zxcv2569763104@gmail.com>

On Fri, Aug 29, 2025 at 12:09:06PM +0800, yingche wrote:
> Fix fortify_memcpy_chk warnings in rtw_BIP_verify() and
> rtw_mgmt_xmitframe_coalesce() functions by using struct_group
> to access consecutive address fields.
> 
> Changed memcpy calls to use &hdr->addrs instead of hdr->addr1
> when copying 18 bytes (addr1 + addr2 + addr3).
> 
> This resolves 'detected read beyond size of field' warnings
> by using the proper struct_group mechanism as suggested by
> the compiler.
> 
> Signed-off-by: yingche <zxcv2569763104@gmail.com>
> 
> ---
> v2: Use sizeof() instead of magic number 18 (Dan Carpenter)

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


