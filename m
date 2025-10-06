Return-Path: <linux-kernel+bounces-843223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5DEBBEAC1
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D523ABFEF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533BA2DCF52;
	Mon,  6 Oct 2025 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sXaTjoOA"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB972DA759
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759768589; cv=none; b=gKUKdNLL2fkPs4NXv9HrEpwC2lpdiTgEvyXFfhWtcX042BRkpIYiYOt5w3XyqukFXB/vlkMESWKmopirkMXgGm9F8g3L/l8NUQ7G98WtHLbkILyJjy54EAneyXiWtEw9BeF54qDzqazISqQkES4jk500i/gt6GiwI6xy1rRdHHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759768589; c=relaxed/simple;
	bh=XupdU8p7RDNBPxkCkrppIhSp1IiOvpdpp1bberfEOrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zc6jhXdHqnXqicaYNjjaZFSbAINIg0ZH/Zw+lqaKASiifoLs5DCDifkZ24STO+JFt6PvCPDnnpO1X3YKEo4BYEk/g7gCY6L4ErhG/jzSVYhy+Kj2nV7aXNGMkkkUR8IL7yboXjTx0cAIBUnFoRLrKpMIT/NrbSuX/olC0BC3d3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sXaTjoOA; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7b4f7a856acso1795353a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759768585; x=1760373385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbcfXyJqSZx7fTHy1yz/EONzLBPcuXMGSsDmeC55Fxk=;
        b=sXaTjoOARxNqAWo4sVZA9X9GOXatwtec4DlhDddXDCiMn0z+Tq6sa1d+uDzMqYxIaD
         /M4PC3DHA2p6dL2q1iD6u17rogcviqVZHe9rrPWrr+w3oRzuqBhvLbBikjN6438OxLjv
         I/EEnEjuyZCzv6pOhn3ZwdYVL0cTn5eQPpPibcJnHdWi6jfa7HDt5wAqp8tRBTVMlb/U
         c3llZYgCDjUhrkbN6hxGiVKQRyn22PJpLZiCokWk8Y/n6NMEVRJfAot/dMlL8s5ufTcW
         OvnRAqcMX+2A2SHqbQiobgTRhUrHBxw+EcynPRP368PdiJFRuONzwoCOnmXx5qJ3Qz3V
         wFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759768585; x=1760373385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbcfXyJqSZx7fTHy1yz/EONzLBPcuXMGSsDmeC55Fxk=;
        b=osJ9lPmw6f2M0vdSfmX7hqASdokea3lAQ9FTFWU0y15NdtW9HQ5hfFGTtzvjWOF55i
         2Rp1RxwUZ9E+FCDxYSJwcnZCMcbBuTvklEmMyxFvxJHKxFh/r+kBkC/5SmyuWzY0ZzWa
         jIekj66su9fW2cHvmIEA/KgjAjzYiPNLpDa8C8JVMVpvqBbWioNQAQZG0wKMbtv/5HND
         uO8hKZnHK0PwSJ75aJQK/SpN7SRZk4nZcSO+QjhfDNhnxen0jt/7dZKw5WNgD+XY3yS/
         H8ybimJ03+TRyPFPI5P+Ky6lj0GAat23WNlorFpnZ3DFIxNhTDLCpEaqZdiCOgBkB7ey
         8ZxA==
X-Forwarded-Encrypted: i=1; AJvYcCVtl0Q16+7QcvD599isgIUorYv+p1wkkOjfmKBl9KVzqMlaL8qBbFnjBjvkjzcQqK7/w8U40xasafs8ryQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS4cKyAvxp24fgQSl2C+jxS0pTmPd000Fq56hDo2yAhYYdg5Nz
	kpCEQmZfqUvKYmWtYcwmGfyApT9GLbVTwWbvbMm85rmx42UM7LpexMZiezzTQe03ygUifdfNcek
	V1cIVbs0=
X-Gm-Gg: ASbGncsU8DTgvKh33OUj5dU4W+wIKUEzodCBsXCr9Cqmyex7ZnWBr+xCYUvXYgRJA7u
	JLpawKCTdP29+PkXCzl5ViLoPQHwMWP1Jr/R4duDnyI8dOCrPg+nUIbz3XH4bzKT/p1slFvv35N
	igC3NRuSKzn0agoMEglf7c+UK0Z2f2UIKBjsZzhDW2TTYOATpTKWPEQxkc2endcL3MXvBgYdOsC
	PL9cY97xIwtkWLSdz56bKTGH92YzrPywRC+3CTs0U/MXH7pTekpYW+dHz09gKwXx1y9XqMkLCBc
	nBzSHEyQWVVw0t1zHWqOYdgljqQVXtfOeZo91quD9ZiwUGxz576HHCKcX29W94GUap2H0OL4dlv
	HwIU1aCrwAQMRMmAuszwT2lmO9p/z2aJByJ6YKzouYbmFhy++vlpvx65MPItpiCV+IRMFEUA0IS
	VLfaazbm74IqEKLUlYMG6MlrBcW9MjEKG5DlQAKVwPBbIu
X-Google-Smtp-Source: AGHT+IE+s66uq6txDkspOfSvOVKKS0M3qJTnSdw0NOGPySxvEJLlIa6shKJ7jyPKDkvJTaOBdI0yrw==
X-Received: by 2002:a05:6808:2e48:b0:43f:7dee:469c with SMTP id 5614622812f47-43fc1798d8cmr6884069b6e.11.1759768585304;
        Mon, 06 Oct 2025 09:36:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a1fd:4fbd:e7a6:9246? ([2600:8803:e7e4:1d00:a1fd:4fbd:e7a6:9246])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43fb25b991esm3008529b6e.26.2025.10.06.09.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 09:36:24 -0700 (PDT)
Message-ID: <5e043789-75b4-4586-b9ea-a6cda8532431@baylibre.com>
Date: Mon, 6 Oct 2025 11:36:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12-1 3/3] iio: ABI: Add voltage mean raw attribute
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Kim Seer Paller <kimseer.paller@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>
References: <6106ee185045ade8e1938f87f9588733d6358844.1759123847.git.marilene.agarcia@gmail.com>
 <c9c3b7e67703313913a7fd411cb0cc152a288c82.1759123847.git.marilene.agarcia@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <c9c3b7e67703313913a7fd411cb0cc152a288c82.1759123847.git.marilene.agarcia@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/25 12:59 AM, Marilene Andrade Garcia wrote:
> Add the missing in_voltageY_mean_raw attribute for the average of voltage
> measurements.
> 
> Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> ---
> 
> When I use _mean_raw (IIO_CHAN_INFO_AVERAGE_RAW), I get a file called 
> in_voltageY_mean_raw, so I added it to the documentation. 
> Thanks.
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 352ab7b8476c..3efaf91248ca 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -422,6 +422,7 @@ Description:
>  		Scaled humidity measurement in milli percent.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_Y_mean_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_mean_raw
>  KernelVersion:	3.5
>  Contact:	linux-iio@vger.kernel.org
>  Description:

I did a search of the IIO subsystem for IIO_CHAN_INFO_AVERAGE_RAW and saw
that it is also being used for temperature channels (both indexed and not)
and indexed current and capacitance channels and also one indexed light
channel.

So we could either delete the line with in_Y_mean_raw and add all of the
ones that are actually being used or we could leave it as-is since I think
in_Y_mean_raw is meant to be in_<any type>Y_mean_raw. This is the only
attribute in the docs like that though, so making it more explicit like
everything else seems like an improvement to me.

If we do change it, the change stands on it's own, so you can just start
a new series for it rather than calling it v13-1. Just include a link to
the previous discussion after the --- so we don't forget about it. And you
can drop some of the folks from the Cc:, like the DT maintainers that don't
need to be bothered with this.


