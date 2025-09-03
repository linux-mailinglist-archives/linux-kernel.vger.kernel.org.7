Return-Path: <linux-kernel+bounces-798707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30098B421B0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329675E5772
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5F4308F0E;
	Wed,  3 Sep 2025 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zK1y7ofR"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA0307AE1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906322; cv=none; b=MRogYfJUu1Uzy04yjlmL1Zw0ODh2OjTD0Z+fYsjQ3DKN302sOX4xJbOiXjpRafsb0mtJXj6EhD2haYKDyBLkrfEF7ZfTUjMNhwIHv/p09clXhpE5xRnwvHm8a5JRYNNTcjdXvC4O0hRhIZWG1GMJcldy6sbas9r7yoIOU9VY/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906322; c=relaxed/simple;
	bh=HMyrqafZWVvnCp8l3xl9EjMdbJHyX9qnKtyEFsPn8dE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=krBDDfeCUYkNyH0dihPJ8PCLL2XipzpmLeIFcaA5ZSEPeTVIj8nSuVnlTCL6vQe/cDCdHX84J6xhhpbAz7nl8tBhp0vIfJSu30J9XjHhIEWkyF2aEPPA/5FeUaKjSZUH6K6FO4g0By6atR3cKZEGr4u+c/h20nEVPW0f6fnIiSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zK1y7ofR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b8b7ac427so21456475e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756906319; x=1757511119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jV/+kNQU+fID5A7W7F8ncUimxdPkwRhQZObi8KDWFN4=;
        b=zK1y7ofRkabpTVTCK72t1pu/W63oE1k9cWiQ7iCp8g6fJ56OmbzmKaB+VGNKqm+k74
         RstJas+QJu2w5nvLmF4MwLl0M/Q8ETcXt5DSXHJlcW4W03dhGsfoD6IXKgqZlFKhWY3q
         9TIyKEBiFY2RcJ+cyPlpUKB65IimGqbZ0ejuUyM9VKd03F5oY69T623wErhxaflnw48V
         7EXfQNnsDwkd0uTwHR+4MV/NCMoctN5+HfVYyFcq8nd2AfPhs+IX5A3yCEt0AR6hhWuo
         +tuf/SgYnGUzpfUKlDUTC7NmZUD9xSS3co5ihP6W2kj5CmIEknNA1owGStToRsNoVs0Z
         8Hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756906319; x=1757511119;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jV/+kNQU+fID5A7W7F8ncUimxdPkwRhQZObi8KDWFN4=;
        b=gWqk37V91RDeGEu1qKt3U2Y1gG2RoQx+DAu/C3V9HjS8GdCG39wl+LH5L5KthN1KmK
         e0z65h6lDWLORh1tCw3B/6/WXIu3ngCjTRs4VWX4JrT8XzlzEiVNj8MfqG5p/OtjmF0m
         OnDgzM0slP5/4MVNyUlhx0JmR6cmfOR++qTGP3d7GxqQLfjW/q2QlWntqjtGUzVnA54Y
         ESTspGLF4a2ac5vDvWPiimsNzzC+0Pp5Af1A8DjFuFSTgXv+YGSipG3VZGu2I6oKbes3
         CiP1BQRMYzSkq/TVGqBGZenyP8ln8sv5FduRzm4ofEH0nArkLilxUOP8FdQEtp+zDun3
         Ttqg==
X-Forwarded-Encrypted: i=1; AJvYcCUMSxvZJxhPajSbrMKkor0+RKnBTFDMopj2LBdxbw/8TKswxrbNcXVA40BDXjZD2er0mvCcHDCSs3MuHRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7VHlDN8U3/Yv/86moYpFJmaZDSCBOZHXZDqpykMiJYAdElY3c
	XYsZO+jQFGI2iwzJIXxV5HVesnD4k7IVTJwvuBTQEEWjK+5vgMIDsoh40jsAM7Q9aA4=
X-Gm-Gg: ASbGncul8WjmLWei2I4N/haT0rclqRQ+kkyWYBYCC5mKL8wGVAH0Wiu2CDMEK0Rg/vM
	HXGXF3cm5Im9Ei84HSCgSS+imucAfmaZBVV5RjrPn9uEbCFjvyx/kBgY2tsXjXaY5lr2jPmvSH2
	BKaRqqDdjxLjad9fxQkbf+mHYqU/5preFPci8uVWettkI+erOsm1sN2baTf+5EaaBztgBVCb0tt
	cd6gArTwU1Uwtro0XrK+lPHYiXsb473Isb/Qh3QBVzRqy1/wUP7Qjxiuf+L1hzkgjcuiuHoDrZ6
	kXMtG/cqy9HYGtESgQT1rM/P8aG03hvb5SptRYhw5ztjrxoGYFiObZzby6OGJSY9gqj4mOI+31B
	6kItWRPxlqtUN6eZrRSNJgwK2a2l7oUJRPnsw5Nq9dQvriNm1Eb+6eMGZL01HNYG4iLkItVeb6k
	lGS2H9zhS8varjDxoxr8qpTDGHqcl9O7cQxhGG0Lf4
X-Google-Smtp-Source: AGHT+IHgsBA9rledeTVeo8KQley7QFRDXyCYgnqMKEv7MzsQIBH95kbaAiwwLJ8XXVf/C9Q9lEUUqQ==
X-Received: by 2002:a05:600c:46c8:b0:450:d386:1afb with SMTP id 5b1f17b1804b1-45b85532ec8mr134876395e9.9.1756906318707;
        Wed, 03 Sep 2025 06:31:58 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f306c22sm327450385e9.13.2025.09.03.06.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 06:31:58 -0700 (PDT)
Message-ID: <b5a0ad0d-ceba-40d3-a111-0831c4538cea@linaro.org>
Date: Wed, 3 Sep 2025 14:31:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] Peripheral Image Loader support for Qualcomm
 SoCs running Linux host at EL2
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 linux-remoteproc@vger.kernel.org
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <660c2594-9a93-450e-9a2e-17ef6b4c696d@linaro.org>
 <20250820112242.usd4sdd3avxdlcas@hu-mojha-hyd.qualcomm.com>
 <f5582304-8f55-4c3b-b752-9cefa1e4df96@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <f5582304-8f55-4c3b-b752-9cefa1e4df96@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2025 12:56, Konrad Dybcio wrote:
>> Can you try with this next-20250814 tag ?
> You sent it on the 19th, so it's in your best interest to run a quick
> 
> git rebase --onto linux-next/master $(git describe --abbrev=0)
> 
> and giving the series a prompt re-test before sending, because there might have
> been incompatible changes, whether ones that would prevent applying, or break
> things functionally

I can't even find that tag next-20250814 closets thing is

| * \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \   00062ea01d35e - Merge 
tag 'drm-xe-fixes-2025-08-14' of 
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes (3 weeks ago)

but patch #9 in this series stubbornly won't apply to any SHA I've tried.

meh

---
bod

