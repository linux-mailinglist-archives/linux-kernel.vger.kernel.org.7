Return-Path: <linux-kernel+bounces-768641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 837B8B2639E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF4756185A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865922FA0F8;
	Thu, 14 Aug 2025 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LDLttLyJ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEB42EE29B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168783; cv=none; b=jq2+1ZxFRqEnm9oOa5qN+hnEDqT8glqyS2AIwTyuOaOxszXxXb7+KPqJ9CyWgAJNB1goU/1ZFkJO1aCpoADjaAQJHCOaTYRngg5Wl7giJRBwp1l9mfEzAVfIkQsyrU0pl3IWpO+n5iYazmS8E8D9hgjQ2S8pMjN/cuDCHWs8xTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168783; c=relaxed/simple;
	bh=ka/jUq4yCqIEorJzV/5xmpImjwjrsdrkUanK0zvno4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXzw6xU4NYBhhXCNOR1T7eItB69dsvfXq8flAtjZ1caGuHAyf0pvqW2WhpZuWEDzOpB1nw/3xwtcbNB2mKmqUHQ3ca6j9/OBeZHbdVD5SsyOCPdosFEZYEbof8s+mhDkr/Ds58MkE8FFs7ZFydbwMdTOJqr/M3YOQIogLim42Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LDLttLyJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b05d252so4733995e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755168780; x=1755773580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tImSMCBfpCfAguMLKN6Kk0z7PZRhwzJcoMFbZ4yvY9s=;
        b=LDLttLyJ0lE+bJN7uojsZFD/y5vfSJJ/3WU/suF73uJCV23O1IxtNbreD+iOX0L7/z
         XMrxsuckC4d5FL1mgBCDi54U9zQhMiSUQEHV1OUK8pU6sy3ePkW8hsGmPfzJtQsyF5t+
         TJub7z9oW+J3m+z7u3mjZQZh5dIlTl8aofXCkpZozFplBL/WeZXuyCJ2FoIg2frC0MZs
         79Sc1rJb1DRCz9OXmikXHqP20Y/ZhoHh9NUOl9ylN+wJQVywnbhj7tHMn2eADs+O17Jr
         LY1KZJpiuFLPIA1nHzPbf5C3XfbVFjnMOvVCVdzbWM5cDB73xdWhm2FO1kTjZ2TS8T1J
         2FzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168780; x=1755773580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tImSMCBfpCfAguMLKN6Kk0z7PZRhwzJcoMFbZ4yvY9s=;
        b=HzFBAdspn8x87KF/25KOnMXuFQK/2Yiq3Whx+pnXKwDBaDZ0F/hCz6KeZcoBlrFJr1
         vA/gpUWzKPjh5cEZ6rVCQsxPfxi5kd57yhA1xBp+OA4wGpPFfNwrfJfM+U7az4Ae03mA
         YfDRPEtVAbOj03D0pBSjQDSMMHDIGTRZlzbWmSp693uhuyA7CqgzCklKyw0+t5V99yEu
         SAObUTECz9Ftrfwk2InfYzaML22e2bkTC1Qa2EeKEizJxXkqzF6JO+sZ7cSvusoYs4tc
         rZnhkNUunXSRRxG2l49TRZhKYSvfglqss3yBAJkqI/q7r5DAO0KdgGMl1Q+jQVqLWZR0
         IVrA==
X-Forwarded-Encrypted: i=1; AJvYcCWDAHGmmhqoqta6gvejSYLUYDVrOZZAvKPosXRwf3mm/eHKsT7jlpvqVDA+XTr/PbKUf7tI2NKYrQEomHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTaJFkLvXXJAPId0+fFrlns88p5j+8uGtOejS3VjODvBafXc7y
	nrok7X8RPBEp3dyQkbySOjy70nKuRrDSFX5U74u/+EsrfUCGtis8jjVk2EVNBC4fPjU=
X-Gm-Gg: ASbGncvtDijjqoewkHH1Js3wGNhnSNhP55NZjCyDeG4o7kFECFANU8t4lHGb2j1JRfe
	t0q0Q3Q4lRavhP/bDll26ShnP/ENS8jLi3TniXWaUYFROPm6foUDd4lWjAqq874pEoqCL5RQAVP
	y50ZjnsTDIIqHmTxjkiGFoPNeu07aVKdwGZocQtnPhj91UkGOzTcI3TTYeqmcX/fJDC3tJM4nKZ
	U9HDAwRaDCsnMMq4sDHXTqjSFybBXw3W3s77AArfAkuZHEYuIT/Fl4dcNu2jAfSwCREIV/otA1W
	tB+yOY+tRaNhJn1DBgq/5cyLfy9Pldbicmk1vNNgfPlNp8PM6pvLsmdCaAZ73hQJ6IO+83VsVTC
	SRfZAqGgjpS9vb5TGsBW/sX7neQQMniBS/k86HQ==
X-Google-Smtp-Source: AGHT+IHKxNnld9A1d20cONaio87iOt454m7EZDnnHaLrl6u8S7+JXFZk59fTMw/iWM3XR3mOUXGciQ==
X-Received: by 2002:a05:600c:3b87:b0:458:a847:671e with SMTP id 5b1f17b1804b1-45a1b6758bfmr16491255e9.23.1755168779967;
        Thu, 14 Aug 2025 03:52:59 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bc93fsm16985865e9.2.2025.08.14.03.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 03:52:59 -0700 (PDT)
Message-ID: <3da37a91-9512-405b-ba74-c1feb80b4dd2@linaro.org>
Date: Thu, 14 Aug 2025 11:52:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] coresight-etm4x: Conditionally access register
 TRCEXTINSELR
To: Mike Leach <mike.leach@linaro.org>
Cc: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
 kernel@oss.qualcomm.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
References: <20250812-trcextinselr_issue-v2-1-e6eb121dfcf4@oss.qualcomm.com>
 <272077d5-12b1-4922-b924-a96c34b3b1c9@linaro.org>
 <CAJ9a7Vif9__iXasPWi0uUhXNJ63xQBtBksT17MvQ-+rDMVxuAQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAJ9a7Vif9__iXasPWi0uUhXNJ63xQBtBksT17MvQ-+rDMVxuAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2025 11:25 am, Mike Leach wrote:
> On Thu, 14 Aug 2025 at 10:51, James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 12/08/2025 9:24 am, Yuanfang Zhang wrote:
>>> The TRCEXTINSELR is only implemented if TRCIDR5.NUMEXTINSEL > 0.
>>> To avoid invalid accesses, introduce a check on numextinsel
>>> (derived from TRCIDR5[11:9]) before reading or writing to this register.
>>>
>>> Fixes: f5bd523690d2 ("coresight: etm4x: Convert all register accesses")
>>
>> This tag isn't right. Although this is where the register accesses were
>> last touched, the root issue was present from the introduction of the
>> driver.
>>
> 
> Memory mapped access to unimplemented registers are RES0 so won't fail
> - the issue is the system register access where an undefined exception
> can be triggered.
> 
> Mike
> 

Ah, good point. I assumed that commit was just a refactor.


