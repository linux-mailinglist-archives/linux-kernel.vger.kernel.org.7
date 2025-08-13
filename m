Return-Path: <linux-kernel+bounces-767660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBEEB25755
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40D65A45D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA902FB99C;
	Wed, 13 Aug 2025 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eoeJE20g"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467462FB98D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755126751; cv=none; b=NN3ED3+Ev7on/L3ugqDyv3xbjVqDphvIqFxKacQUieJAEC9UyOit3NyE6jbCmYFh61AHQPGKVfNknYic1eOMBl9VzNjlXS+rb4jP9x9O6RNFrHTQjWjYZ2hfZug0bCsFayzQ1FOWzxZLEe6W9pftXBo5YLs75/z377tNnwHjRno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755126751; c=relaxed/simple;
	bh=J0fQmYN0td9BbUutnx5hhUXkf/3YV2ZNu1t6raM0LRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpVQ3a7+UBrfTh/w8QQPYVREcbiJ6Pcl/9rjr84kpRSZWz7/aUMz3TG2WWHc9loHG1VTd8PrWG6go6ZqQY5ZoLPfnhBmKhyvDN6wRYIES1ueq7Pu+gAkkhhRlePQzrfRKvJTASagEtT/pvf63Lr8+jwaeyw7dEAZAj1AKRfKJzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eoeJE20g; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-74381ee9bc9so263540a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755126748; x=1755731548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5P13aKoekVtyFP6DFw45bojcRd5Z/0K56R01yQ6Y0BM=;
        b=eoeJE20gXYdhn484UOPPhgOP9UvdyLF7fXoMpw0h9oJLxrIJrFLcc/1NM6Q4IdzAq2
         Rl5Y36gOuHTKk459RmRs+Sg96jwds5Bm+z+TwkxDgbixSfPYxS/xzy13RXB2eJKUY0Jj
         9P1iFm0mHUoTxn5D7gPdGsr55fLK7g6+pMhyBSILNFe9sOEXmRHVRJ+fkClrP8pl5nEx
         +CPN0YJxU5uRzQCBJH06JAvYNqmH47yBHEW+FvFaCWEnSaIlYfZ9vB8gog3YO8SnuXhO
         bTOAUJR69YvPhUS/9SmMDGYzmL7kKDLBOTatrgrkwvshmweZJEYF0YoC7Bmf6hxV5TpJ
         I1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755126748; x=1755731548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5P13aKoekVtyFP6DFw45bojcRd5Z/0K56R01yQ6Y0BM=;
        b=t41B/QZlarS828pUhzIhBnK5UuGHWt7yBdrm6A00cvmK389rReHkL6C9nyBCkx9MAg
         fUN5iGnBB1SjHgMWHMWIEtJNmaiKWcwGpuMtymBxiJBZMr/MBbQT/zx5tc9MqKRXDdb8
         ZyTjLDv7yG4LQNHoyC/ys14HCWZyjDWo09uuKVH3n/YIwxc5lPGiS+1/6mS48vpQU2z+
         OrtKLhQ4M3ROrS/Z/vb5TSHTZ8WCVJO6LJNSNpa1B3fTXtERh9u28TY8vMID+j6iWqGv
         DmrM3BgtdIix8yIYkszVTyWq68m3OXjYAtbUzlJO8M4LxJd4HhYHr+R8wtV2Ao3HX3TG
         9YWg==
X-Forwarded-Encrypted: i=1; AJvYcCX8mfuTzaaEUUzyh6FucmoklBIDGTXposImYSt4Aeojo187FeuNWT8t2sYr5lma2GkBil+0kklIam/AFRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaMxRJVDqyIVLAgG5u95mrJtYznlXjcrcR+Fmf6Q87oK33XowG
	k4DbqTh3V1lox8C+PFK9QNyol1rPWGCWkwMJtn70d5aWkUW1E+w5E/aa8jYkJeezl2s=
X-Gm-Gg: ASbGncvgMjPXc0AeHuZpFPJ7wmHzsahKRRXGxIvd/K99GMYciXL6Uq6OX3m1/HDejUQ
	3EP1U51VS1PzDYPuKF9BUbyOnB30Hm+B4LG2GJM9TEOfVlFD8htNGoSNiHIEHfTi7wSGkqXhe0h
	d6BuYBrQ9Iv/2eWNcqJTVcrRtjM8QWBYsuf0LSTTCLFM7jxB9PK/hywfP56uoUDst0n+QzAMWkC
	/iVCmdIls70jSDpyTBdHYBfhlGQ+1J/jEQ1QYH5Ael79Kvv9UKw2IY0agV1f3jEkuep9p+quo/+
	qjTKAP9nmZsGSpf0ZBBhpivQogWwHfkTR94m3QOCBJiHMcrWeLVTeahMd+ZJCchUTlLWdVswoZa
	TSpLn+qA101BLgwGUS7nSJCelGwG9JXjI/ISkpUR3Bv0qDYJiOgW8/xzncp7ncq42RHthJASF
X-Google-Smtp-Source: AGHT+IHYzwo2bMR0+x+++sRYWHwfN72nCHTfvR4CPHAeB3wV36pwiHYsEgW+gCnOX3eWHG3onNxoBQ==
X-Received: by 2002:a05:6808:1813:b0:435:7126:fc82 with SMTP id 5614622812f47-435df6c07a7mr661060b6e.3.1755126748288;
        Wed, 13 Aug 2025 16:12:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ae46:dfe2:81c8:dde? ([2600:8803:e7e4:1d00:ae46:dfe2:81c8:dde])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ce72b2fdsm860695b6e.11.2025.08.13.16.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 16:12:26 -0700 (PDT)
Message-ID: <4e109905-347d-4830-aea6-a93d88252481@baylibre.com>
Date: Wed, 13 Aug 2025 18:12:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] iio: health: afe4403: Use devm_regulator_get_enable()
 helper
To: Andrew Davis <afd@ti.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250813225840.576305-1-afd@ti.com>
 <20250813225840.576305-2-afd@ti.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250813225840.576305-2-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 5:58 PM, Andrew Davis wrote:
> This takes care of both getting and enabling the regulator in one
> function, it also handles the devm action, so remove that. Also
> do not disable the regulator on suspend, this will be handled for

I didn't know that this worked automatically. What is the mechanism
that makes it work? I've seen lots of drivers doing the disable/
enable in suspend/resume, so I just always assumed that was how one
is supposed to do it.

> us. We now do not need to track the regulator at all, so drop it
> from the device struct.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

