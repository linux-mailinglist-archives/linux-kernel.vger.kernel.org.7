Return-Path: <linux-kernel+bounces-744748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF093B11075
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14C45A436B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8542EBB98;
	Thu, 24 Jul 2025 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JljQs7S9"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E701DFE0B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378912; cv=none; b=JTpMnYtjzTsL2JGGzzA29NNdkQpkRsTDg1OBpeiKxISpeY49m3jJ671FfzLhl9WJ/XHT1RKp+nzC/ShheyNQZOOfpx5hWHmNkz48/CUp/vsdNuQZ6rz1misV0rikhMUNkk9s9VS2kg2pCEKUyadu8GOLx3bFnzuOUPC+DJW0t2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378912; c=relaxed/simple;
	bh=fgWqeHfgCJcBkrOksa9HQ2z7P/duABERzffIh1q8E4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhO3toBA7l7F4H6Hr1/mk7F4PXdwUU2rKbdIbJfHqLPkDd9ZbVJwASl3oCMYyCsUMxYo0DVIs/ySKFkx14Lfi4/6ac4nbEgSAuG7N3wVJZNX0HUvTMOq+iaO+JYY4YX8ISI8GAc9iumJVpyULzjiqXwRpsxj0PsabqMzwjOcMXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JljQs7S9; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-306e88f0b0aso242630fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753378909; x=1753983709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uP7XLQMOquKVguuTHAZ/dpSwAgreurSzJW8FguPOIRE=;
        b=JljQs7S9xFiazo2M7h661nQ+p5aBqaOfOjluHTvWWXhsfJut7EvpzIO+7+SywteTU3
         MiwrqylMMizaPpMFKmGwJZS31EeBxt0sbIAUHnBCWEt/1Y38N+PwGgoS6ChNFIRmBx69
         xXG4RjhqeR995D3X8VEqzZHzY5RbrngAy6EW46hMwenpaadpi/5RdswDKrpbnEGFS8hF
         IjCCb9Jm9XoxPCjTYP6Fon3GFY9qtfR3zt13fZynVFPzGFqy1Hrd02LckdJfL/3LEnEL
         bpg316AbJIHMZk22mri9xkXKv+uIv5FjguIkcoiuKzT/XNJcVGKSgQG2HVK3GR2VKgRf
         I/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753378909; x=1753983709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uP7XLQMOquKVguuTHAZ/dpSwAgreurSzJW8FguPOIRE=;
        b=f7KXWIcC/8IGkQpoJhsP9V5ehL1D2E0BuApL4tcpiu/nyZ5OtP0mnH0RIibrUVjfkB
         Devm+KXfmW/Q7h3G5Y+r9jl3PDJvMJ2G13kLFVWwxaNy4vYtU52vPFAjohG0rLwo5iG2
         52+SsOoxCYodlKYCi0JaW69fSn39FO0MF7/BUCYaKJ9YCk0pkuNeij27NY8qMiZkG9+a
         4KacfwDRVRTpfqFjIrnnjq9j2uuKz7Wi+lt77w7dQ4DHyd3ukTRyjOh8BXcrNaeJBWkO
         07M71mGc/8w5k0svVZWxUVZSPsnBJLWzblmWIRVzmGKyWTmGjCwisyRpgosqG4xcSWtc
         XVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9Bx7tvqfrF21vxqU0TVc/C3KV7c6oSC3Z/bwG+z/gXjakLm0GEfEmN5FFF2KYmrTr5YG7S9V83fBiQac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxunZ+t44YCTvQhQO90Rr2H3WhnRpvb2uPDdBK7YsACr4gLXv1F
	kGMYgW8blM7K3SzksqSh4XLTVxOg9t7MrWreRkR6/CIlJmxuW9W0B2i1x1GMLg5vprU=
X-Gm-Gg: ASbGncvAMWtIehlT/y7thHSQ44TRay8CNs2JBeo7KD733Uu1aaEPDc4uetV5APvdUgO
	wFLIevpGPHw50nt3CuH92MPOurx+0i/no/Fj6rzJtJeAWcT87q2Au5IFejGPfJhTdrztK7pSEuI
	wYkHS7a0kiIHd7Pi63Qaxl8Dg8EoGw7XSFIT2JRJWS0WMsqnmvQxN0zs1k29LUsIW6kryQ9ZAw+
	jBUJ+IUpbXKHdYHXale7XIRjQ3gvKo6iyl5ZlC8tbKTdRv4hXDyQhShg8HcJULiohLDlyi/nG24
	W5qwFYVaOsRPH5SPSctnbRSjIT/TYYQ0IDtxmcCgoR+chtER78kkOSS7MfehkVy385xJDb5mTo7
	3cJrCZPqFn7x786X9FPD4mShctj3CJDQJtY8skZxiejy55gE4ei0GKg6Kd83crnhq4aHFK+Zarg
	I=
X-Google-Smtp-Source: AGHT+IHIBoD5+60ILvNrRuL51aRLze0Nj1Fv/v/YFPLVjYQO+Ww+vfePgSdA61nj5rHd6wRMcPS7lQ==
X-Received: by 2002:a05:6870:9586:b0:2d6:2a40:fbe7 with SMTP id 586e51a60fabf-306c6f0b1a4mr5571012fac.6.1753378909346;
        Thu, 24 Jul 2025 10:41:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:9829:e9f9:e475:a206? ([2600:8803:e7e4:1d00:9829:e9f9:e475:a206])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-306e1c4f78asm570748fac.12.2025.07.24.10.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 10:41:48 -0700 (PDT)
Message-ID: <7e70075d-f91f-4ea8-b5e5-ccec6fba425d@baylibre.com>
Date: Thu, 24 Jul 2025 12:41:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: light: ltr390: Add sysfs attribute to report
 data freshness
To: Akshay Jindal <akshayaj.lkd@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: anshulusr@gmail.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250721195419.526920-1-akshayaj.lkd@gmail.com>
 <a88e1a8e-d29c-41e7-b3cd-5db965a055df@baylibre.com>
 <CAE3SzaTG-re2HPRAcPWuo2YmM9mxLWndpN_SQOAZg7MP_B3xDg@mail.gmail.com>
 <8f924da6-c5f6-4f88-9cb1-3e7e1aae491b@baylibre.com>
 <20250724133933.220d00e4@jic23-huawei>
 <CAE3SzaQcsuHihe2-7VTnXAKYab03Cyu1kAPsA2-E4d1kQzCCNQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAE3SzaQcsuHihe2-7VTnXAKYab03Cyu1kAPsA2-E4d1kQzCCNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/24/25 11:55 AM, Akshay Jindal wrote:
> On Thu, Jul 24, 2025 at 6:09 PM Jonathan Cameron <jic23@kernel.org> wrote:
>> Agreed.  Is the interrupt wired on this board?  If it is and you
>> want to do filtering with the knowledge that the data is fresh then
>> add a data ready trigger and buffered capture support.
>> It's a much bigger job, but it is standard ABI and as such of more
>> general use.
>>
>> Jonathan
>>
> Yes, the interrupt is wired in and enabled.
> 
> For LTR390, data_freshness is not the same as data-ready.
> Here the sensor does not support a data-ready interrupt.
> It only supports threshold violation interrupts where thresholds are
> configurable.
> LTR390 datasheet Pg 17:
> https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-390UV_Final_%20DS_V1%201.pdf
> 
> Correct me, if I am wrong, but as per my understanding, trigger based interrupts
> are more appropriate where the application requires storing multiple samples
> in a buffer at specific time intervals, provided the sensor supports
> data-ready interrupts.
> 

Interrupts works just as well for single samples when devices have a
data ready signal. But you are right, that doesn't help us here
since the interrupt is just for threshold alerts.


