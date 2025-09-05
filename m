Return-Path: <linux-kernel+bounces-803705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED7BB463F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4ABA66F9E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4285F2820B7;
	Fri,  5 Sep 2025 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zo/88RbZ"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE431DED5C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101749; cv=none; b=S7tF+KPwPBlYA4ana1XX3ZqBiTZSwjVdhMCtQJFqbQMIJzxUpcr6w3LYNWEPp8zmF5HV+buD5fif4JGN1fcSRRMfOZDJlGmFyScATr7sc+d3ZraTP1SycS4OyVBUpAmSfQ/kJAUe7ituzFGkwf9oobmIcaUA/7FyXbO+PmIwfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101749; c=relaxed/simple;
	bh=SDXmXmmQ1vFXl5JZs1WJtKI6JEciS/jqDcvT58tTS3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDNBx8bkZVZY+VbW9DGCUNQcqYRovhu47wryqvmJYRXCzXjtJvtId4B2ugIHzo7xqMMmaWFqYZqQtqdeFveyVAV9sbbqbZUkIFXHalqUEcz7XRzwLFj+xGpSo2ggCb4HV++SMNNlvXNCJcFS5d9xp7q6dXquDIUjWJizndScw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Zo/88RbZ; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-30cce872d9cso2374439fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757101747; x=1757706547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Szv82Yg+I4qLiwXwVi16VMgcWXR81jSEFdZnsxSabZg=;
        b=Zo/88RbZ8lyQFhw9ebZaQt80sP8CNUlPBN7QFTYbY7uYEhD9sEhlMiKaOWPucu9vYi
         Z+vNYCJuXYTpkvPOprh3Ax1h0qj1Mas6y0HCobeHzgv4g/2Tiuamkt76y62jViwwH+h/
         uqbBGWx8NoiCWMrPQpt5gkXd+VpRNWgLmkBWpjl6duA8Zf/esd4gZbxJypYlB/gkf0Ov
         eUblqhPoltvH5PMDFaQhltsEX4bB4EVspdVkakHYifC4tSCeGamL9AnBO1D39JVX5aqk
         9ec31rWFBRQQTaePZ33eaG92gUmoysdl52K66KMZlUOAvdRm09r4BRPmqQ8NIFPvXdxX
         yVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757101747; x=1757706547;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Szv82Yg+I4qLiwXwVi16VMgcWXR81jSEFdZnsxSabZg=;
        b=oHWbPrIpEMvrCWPbDc0t6hCcmu980SkEFcvVq9VQI/6Wx2C5YzuHFkCJAQAaQHYdDR
         V45hi6Ueg+3X9K22N7R7VkJayRW4ZPP9EKYu7JYdxzv453kRhn2FsWdSLhd7VN/945kE
         ZDZXJXmubzvsY4Zn0BHUME/Z5ZObfvUx0T9BaKOYRMfx0JuhjSl2xRm7RLsJntqXqBNV
         Lu/iXrIBtQhiARxgDCRd9lFAX3O0kHbIdLJU3z2d787XQB4aesavg+k1HLYq7SjVCNqg
         YZ9oHRqjeEpfvjylLacfUybwcfSBFuzLOVxfBVunNw+KP9ujmg5HIymYEspExUhgh76h
         rgdw==
X-Forwarded-Encrypted: i=1; AJvYcCXsFW10igcjSwtkzygVZ8+Sk2P6qdrWW49CFhf2hXFy6ZBS+fJUmODBqv5GRlb81LqYwaZD9qtnSnh7yjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVPRfC9AUqkUBTGVTw85Ux9yb2dFbjmAuOwcSLKuxKmp3zt0nu
	2yUtcsYN+m43895UY00fvXzg0UAIGmv+cMKAbZlZcV0uUx1uNtwstVqhQohT8YI4Vbo=
X-Gm-Gg: ASbGncvHcoQ7GKwYXYhuYNsHbPhuXasmizxMnGYLDc7Rdb5vGVGoJudJWJOooQidOfa
	lS4S4uSYoHo6qGxD+WtgdydsEW0PPncmntbSRwRrlfJXW3S/NAxaO4XzA1nTgLr/jodVfbvv5Ox
	8hSTWAiW/05x0BeCUT2PopLyzZeUInaRU85Jk23Zyn3pfIvl5/5BGYmpPrmL4nvPV+HT0JzEvWA
	AqM1R3VFm6MGK3t60DDcoFheELTugk2J0nNOd7O8b3uUvSpZQi9uq7lIaUeBuJGcX+SjDx/CCkL
	gxlbf9CMhx2sI8XyPbbHtPMkybqtpSWqK12gMecRiF8DtMx6YZleD5EotvGP9cnF6II623NMz3g
	k/dkvMO35S9DiGe4gTyERyy4YMDwpdrm7lzd2uW5xCr1sV71asmDYHZTfKGObscnFJmo5PKPFV6
	Qw4DYsojM=
X-Google-Smtp-Source: AGHT+IFRxRKk8LtvZ6He+rGVAow3FoQP7Fwy9rnhW18mDzyKWJ4V4U2SXMzMRn0S6iDAapzSQorQTA==
X-Received: by 2002:a05:6870:b013:b0:321:8f88:a39c with SMTP id 586e51a60fabf-3218f88c130mr1286348fac.47.1757101746811;
        Fri, 05 Sep 2025 12:49:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-319b5fcbbaasm3996358fac.15.2025.09.05.12.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:49:06 -0700 (PDT)
Message-ID: <e97130f5-9ec6-4ac4-9944-96f992eb215f@baylibre.com>
Date: Fri, 5 Sep 2025 14:49:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] iio: imu: inv_icm42600: Use
 devm_regulator_get_enable() for vdd regulator
To: Sean Nyekjaer <sean@geanix.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, rafael@kernel.org,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250901-icm42pmreg-v3-0-ef1336246960@geanix.com>
 <20250901-icm42pmreg-v3-4-ef1336246960@geanix.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250901-icm42pmreg-v3-4-ef1336246960@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 2:49 AM, Sean Nyekjaer wrote:
> The vdd regulator is not used for runtime power management, so it does
> not need explicit enable/disable handling.
> Use devm_regulator_get_enable() to let the regulator be managed
> automatically by devm.
> 
> This simplifies the code by removing the manual enable and cleanup
> logic.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


