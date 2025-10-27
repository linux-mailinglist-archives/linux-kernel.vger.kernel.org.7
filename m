Return-Path: <linux-kernel+bounces-871950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB31C0EF28
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B4B34F7E82
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5E12C0286;
	Mon, 27 Oct 2025 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AkHuYLsS"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAC82C3768
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578359; cv=none; b=ZZmMO2ySQUBVOyvIlBV+zhn/1l6DUZjhPq83Y4gE1BHOW4ER5/5dHVsWDtTh2ZpeGZFNgjZjgtA8BJVLHXmVBoXb254cvc6wNiTyYo5TXbQikTVH+LnwmyWv1J710PyDSOeO+/A39epEpLbrRnTkGE5aChjeLX5Z/U7v65KnZ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578359; c=relaxed/simple;
	bh=KixK2y+JDj2jpYzeklb+J7CuSxEOJKGpkz49v27WZzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnPURs3sR0tqlEWKc8xHH1kYpl9wseBqkOao9TDPbgSJT0LCEdYMn93cU0wl9kvDOHCQKOYGHxzQ6zOwQRHrjsVGs5izIFKxHDaZNWhIMFjIPUr5WeqL4V7oN462SOvU2h5blTvEqjvm1tmrytW15x4kob/Hv/Nk3K+QZASqge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AkHuYLsS; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4445c606626so1161334b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761578356; x=1762183156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOEpFoGH59PM/ywxUlp4N3kjMG7XFuzAFXwRgcemaNY=;
        b=AkHuYLsSvNKHLktPzVrPstr0klzNEz01NL13g79nQmNPcly/Z07qvjCI8edqfCwONy
         AGVWtbn5Bj5GucX25v4Y8pGXuDNa2Y85TqUR+zM/tu2lh7ib5jFMVAC+xYfwzri4XLKc
         OWWIuLYy7ch/RrNi/532T/urjiSXFAofGva1YPz09uwvLOruta+wQ83gTL8xJqjjvcLJ
         bS4ckwDaCBUyjfYGsjngIzzgbCjk7ggb58lvlFAEpOckKCE934lGfSXxhLZw0fOudjPJ
         XNSB3d6B1+ZnyAvvbuqG7Qh9qDpJ6ncda8OQgEd+5BlLxm6KoxY/zbmLXB8zFQhSPFzy
         3ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761578356; x=1762183156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOEpFoGH59PM/ywxUlp4N3kjMG7XFuzAFXwRgcemaNY=;
        b=ILgojpkiSKaRTbfUHfQwVf/uujFGzo6EcjZPZxdpRa8MGsCj9kQol0BhMQNi82C6Oy
         Dzp2ab6NkFaParbRF5J5Wv0i0v+0gpocMGkiqhmH2ZQ74WcPfhd0iV3p1djuGrprtTf1
         g3mj+D5/FdViuSDEWiGobPoZzRwnZtNOhypgXzA65ITm/UFyBrFIK2QLgkinxhikORGT
         wEar4GURJQKeDZhUHhK0JQOJ9QlBp6A//WHdSWh5huaBP/M9LVIm5JCr4lS1xBWtuP23
         vr+y7C1WVLFkcULIO9ggTX6vALnHMi/08y2/OVMLBlZYoIkfp9dAU/69+SkfZ+mmfeBl
         or7w==
X-Forwarded-Encrypted: i=1; AJvYcCU+z+KwEK1PfVKzkz8KQnDgk3rnjl11gknhQgdcnzpej9MsERnOUFnJQaz69KUfpkOSLAVv5q0KZ1lAL+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2aqbZpdIl9wjcYxt+EdC1q0TE0EcRMmgAPj1UvjIIAuTpDXp2
	g/QxmeLJOsyRPaybgeluPS6iBT5xAIjH3hqYDS1n41CknClJN/uCCZ7uJWPygjLrbH8=
X-Gm-Gg: ASbGnct1Ky/vEVhRkbmuUgWLgBVrr+mcGvXAgPZiffqawe9s9gWyHtjS49JWvURAiw/
	/gtsir0huttEppSyOtS97du9TpnfxC/VsVvNhx86ifnH5cHaiCImesMdZG1d1CSa9x6aXRqDcOt
	Xs+F1I1/YxdEEPCeZmuXV3dIobaXLcZUQeKrCIhLa7kJnkTYxdfhRVmJ9OxUm0V5sYCW+69XBa+
	HBLShXFFEDrjhvEPaLNQl9W45Wh3grJM5rs4CM9b7MGggW3b74MYQTUOEqS+mBz5dLoTqzreLqi
	H2G3QE36AycuHf8pizROQbbW45fa6RI6wDfTixEWCAQyq8ddN3dTex+tbxI8wW8Q4e17wft3p0e
	Q8tUXTG7l1QEBEhnoeBtW/02V++oVrn5s8SsbnyV971fz/Vrt+qf6IEYaiw3EiFs965r9eUd7IP
	gbkabp6T4aX151RgQkmzN9q/h3b6od6Lxjrx2Tb7/Gddea4SDmxA==
X-Google-Smtp-Source: AGHT+IET1m0Og168FNkiHiiqS/dkK0Q1Ob1wq3rotBlVC0PelMHhFuKEOpxhv9FYgyGB4FjHQFu58w==
X-Received: by 2002:a05:6808:21a6:b0:439:ae49:9159 with SMTP id 5614622812f47-44f6bb045aamr63228b6e.36.1761578356367;
        Mon, 27 Oct 2025 08:19:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:46d5:c880:64c8:f854? ([2600:8803:e7e4:500:46d5:c880:64c8:f854])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-654ef272326sm1909058eaf.2.2025.10.27.08.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 08:19:15 -0700 (PDT)
Message-ID: <0d423afe-9aa5-4423-935e-1acf71f457ee@baylibre.com>
Date: Mon, 27 Oct 2025 10:19:14 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix out-of-bound write in
 ad3552r_hs_write_data_source
To: Miaoqian Lin <linmq006@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Angelo Dureghello <adureghello@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20251027150713.59067-1-linmq006@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251027150713.59067-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 10:07 AM, Miaoqian Lin wrote:
> When simple_write_to_buffer() succeeds, it returns the number of bytes
> actually copied to the buffer, which may be less than the requested
> 'count' if the buffer size is insufficient. However, the current code
> incorrectly uses 'count' as the index for null termination instead of
> the actual bytes copied, leading to out-of-bound write.
> 
> Add a check for the count and use the return value as the index.
> 
> Found via static analysis. This is similar to the
> commit da9374819eb3 ("iio: backend: fix out-of-bound write")
> 
> Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


