Return-Path: <linux-kernel+bounces-794216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FBDB3DE86
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8271764DE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA2230E83E;
	Mon,  1 Sep 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OfIhd5jm"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A2C30E83B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718802; cv=none; b=bGNOzCVJN57v9a6QGwbGHpevydXuo30VJweFTp5KNexVlZcws4YCij4rF0CsXgzLz1bT9Mg9H5fBAqutXrzJ/OKnlAstQaGlsuQworqztwuRJcQPmyrT7BgIAsPVb9z0LAcdIxxw8VKGA0I75i5Q3St8TspV8CU953tsbbn+j+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718802; c=relaxed/simple;
	bh=PuOTylrxKSJkQjeSq7Xik4IP/OVb/FZm1rqZ2JBYkn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=iKFI8ApT4xK2F9fMZYlq2+BSvzRsC43yVRJCIDm+vBCxrC8Elowxnqtko3NjmG2uVNW1z+PgYejcTZQDSFhNiILQ2JsX3TAcbmLgUwyY/CyDM9rR8ibRKvs/YfbD0l6hu1s4mT4nVIHoBABEE0D50lRV7SR4vr9ba3L29Zfnga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OfIhd5jm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3d118d8fa91so394198f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756718798; x=1757323598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mOvkZu19+8XAACEUVfl5Tq7zDnwb7HvxWJivbhcsb7g=;
        b=OfIhd5jmA362+JAOUCmlSoETbHKYlUt5xhV+AK+i1oZXAHmCk+44tm4aLwBMoKHZVZ
         3wFsgAAz2tIjZ/6tzlJatl6G/tVd/I1lsWgiLNVjvSi5jstd1pObRVPZB12BD//XBGqA
         Br2Lf5uHLJ/m325sF5QaBYZ0uOn9dAJE/lFQXTtbFsIo15ocsHJYBu0y8UG/5nCI2s3b
         o2WeEnewBy930Vksc8gh87sM7pyG+JMoCZ6X9cezYLgWykTRMdobj5+SvkoRpJHZ4Iah
         73v80UgbJJ0/p6nwBJAr45DdPiIOiJl8u9hk2qCI6607p43O+25TJdQRkXrT9R6AVtjZ
         0K4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718798; x=1757323598;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOvkZu19+8XAACEUVfl5Tq7zDnwb7HvxWJivbhcsb7g=;
        b=oMZ5s+5sSl8lzEvoEMPbIoeFT/lvnSiG7IsoxAeYn2TW+LQNX2l/0pmsbmBpT0m121
         B1PGDdbpqJbfTsYMb2O/rr1v+iU/vd0W72nw9Jk2434iwX12QyNOkDHrFB6gZMl4UEqi
         dRnJgnEyOa0E6YP4vIFLbffQwUzYTneKhcxTg7LgEJQWOjCHzeweLbcWlUIOCWVGfON+
         M9Ckyfx/O6Vec8RJypT6uZCk3E9TCOmYK+EWTG5BUC09f2o/c9M6Q20+kL8Z4ic1Zfv4
         DXDgBjjRyvSNUBZSR0MFFS06RRPE6dMocpOCHM3icxlhsxnuxDwmyRhzjYEPcF8/IOmo
         86mw==
X-Forwarded-Encrypted: i=1; AJvYcCUUkZG00SzYIsOsdNIzgxb9cN5I5x/0Uj+JVDo3Y5LjV9mso4khCbj0T/KplwZFOyaxgoLdWoGd8mWfAJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLlt2nVSi5frfYJeu29WvNqmh8/8kvDl9DrPu42CddhjLedKug
	ZzYVNwQehQ5qrwIzODegg1RDJN9L45oKsEEpFTPIuyZSc4Jy3TwSpeDXsbO6iBUmbVL9FQ+RY0m
	PIfLS
X-Gm-Gg: ASbGnctY0xPOvS+acqG1Pau2sIa6stwEk4byN/RpHoaZc80S2DPbVSw8oprEEL7eH8T
	3/nyeB5Xa7F5lP+Q2eyuDnOyD01HvXofXmyVTjqvuA9YtreUEl7PBAbhgqxakWpzxpzLpZTz/Gf
	0m8iu0moRgrZhTFoncVv2YTAJ0zjO0RU2WDoADtPK0do1H4u3B1f59Nmu7WpcF79r8GELJjcVo+
	WCydz3kSC2wVLJRc/LXqjiTrgJjGA/OnQ5POryDmJkHrqWr5FcdXwejxVmy0Anf+lsWSXCLjW5n
	E2eZ2/GlbsSpy6BdGBNvNHFE1MAmWYPMDNXE4DmMrL+Ul/dL/qNs/Z4xrOekAzp5hhc2AQygdsY
	yaYy4WUqx/1Lff/BHm2Qw5WWh4PJ1TQSv40ydzL6dnBw=
X-Google-Smtp-Source: AGHT+IG1Kp1xJPG5uw2vE2hCaImIqhYqS1Z1P3fiEdun39Ri2iyt3w69ScnK0oY5gByY6uFnftmpxw==
X-Received: by 2002:a05:6000:18a9:b0:3ca:b6da:a5ce with SMTP id ffacd0b85a97d-3d1b1af2a09mr5596571f8f.23.1756718798498;
        Mon, 01 Sep 2025 02:26:38 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d5816sm14425964f8f.25.2025.09.01.02.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:26:38 -0700 (PDT)
Message-ID: <e4bd094a-9302-4a8e-af52-496deb57eeeb@suse.com>
Date: Mon, 1 Sep 2025 11:26:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] module: show why force load fails
To: Jinchao Wang <wangjinchao600@gmail.com>
References: <20250829084927.156676-1-wangjinchao600@gmail.com>
 <20250829084927.156676-3-wangjinchao600@gmail.com>
Content-Language: en-US
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829084927.156676-3-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 10:49 AM, Jinchao Wang wrote:
> Include reason in error message when force loading is disabled.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

