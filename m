Return-Path: <linux-kernel+bounces-886848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FC8C36A25
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02DB7661462
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF3533554E;
	Wed,  5 Nov 2025 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+H8tiNB"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B5A33554D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358809; cv=none; b=Js3Qhn8dtm1kAgJs4GzJ5yvCnemVx1MNTzvQAiJZRy06ay6i/ILT8ZZ9ebzYNpX0dXUUPRuPGysYe7PmO06XZTn4ri9d0f/WbK2ahXly6Ae1/Aoz0cNsasfq2PsTjUUqQtbEUQhH8CJvmsrTfv0jLtRBDZHEvd5bPFchaKN65ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358809; c=relaxed/simple;
	bh=m9b+6Qd0RrFy0k4qrFIgFV3TWvTpO/YcaGxKS9mqK3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAgYETJoH+y5e0SdtfbdFShdkA8HSBG+Hzd+tlH/7sQ4ltNrBaVcIO55Nam0hDqOXuhvPI9Ud3e5zhak89oW/BFzdf4hiE6KvsSsqmKe1Qqv4yKc5SfBZjkK51Rtz5lOtM/Y/3ZQrUESe0vh+Dtqjs+bdZCVo5QGwKoRZj4Cqeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m+H8tiNB; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3e9d633b78so217639066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762358806; x=1762963606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m9b+6Qd0RrFy0k4qrFIgFV3TWvTpO/YcaGxKS9mqK3E=;
        b=m+H8tiNB0Jl+JKTf8/gJ3pAmFH6LyH6aKRw6nyZkHQbg1rZtOW07SPuIPkhwSkOPWR
         5GEAeq0hvqChRaXYF5ozqVos9Y4J4t1ZI1caTPjUpnBWxu3hhzNfzYstiJpOIkArS8qk
         VvoUttWhpzBq2tmIC8s+RMsZYfvbVN3pAimBPVI7+zsOIdz0wzLCxX4L/pjsRUAP50sK
         LBHrd7JFyrfJ2m/vDVAr3NJLqk5XLnfhqZQSgwia+nDX60U6b8eXigQKjNcQk+fKxzHJ
         N5Wy4jkOYGQR4MrW5d4Iphkd2M17Idz3S7vn+ThkKRt/9TPRLnN9Fig2X/9M9y9F3CmN
         NBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358806; x=1762963606;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9b+6Qd0RrFy0k4qrFIgFV3TWvTpO/YcaGxKS9mqK3E=;
        b=wcyQqCpu681o0DWU0HfJ0qMDiTLZsAj49Ed9FJySs24TiysAPzZYrg2tMSWSpQ1vw2
         +Y3J8HLc+YnU0I4eY1g3PwW23rhYgWuApW5RROiQJ9QdU2YuyjsymrxNZ6fdzNkJskLe
         UqgGtli64iNfckSij3tHiK0Cb9Ylq14AOXuE56veNxSRLjCpThDuUIM848TydEnLZ2IN
         x5Nb/IWIiiDgbSa7cemw5p2BM2wEiOAo5R/nQWpt5M/iF3wAL5mV1XKA+qxM4KHShsK4
         NErxFjr7v1QBAG5rM2I9fx+8rgli5/eqJhbY9x+7StqZv37HJvt4Zu/47iXwXj/6OywS
         uhZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7M2LtH66gnCTjQzKgzeTOA0gRG5wUklQcEad2JOPSopHFOXEj0EAtJtmys5/5Q1jq6jo7NJaKbF+2LhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzNaR5gkFR1zwg6Mn6oEpvH5AVvwiejCoNTE1ZzlziX6b066yk
	bpdVdlYows+UlaoX2f+g7l7VpqH2LIFwCibRZUcCSDKi1tChZaYYp44InW5PD0+CY+A=
X-Gm-Gg: ASbGncvjHmQpslWsGsQ82BlL+9Yaig/zAW3Rb6wy3PXB/Vu9IGE8wGADkc2pLfeh0zI
	XhGiDYSB2/hydaY7VX4lCJHK5ClY5+/zTR7bEx1tntIWdLRm9WTQwsXxTg6T1+awQprbpOBTbLt
	+SvQGSqkOAyLG1pjNF+vNKvnsksKutOy3Ylu1yeG2O6DewJbn+7nGl4/Bej1ewxZUsiInRZNia6
	+8T7NGyscdUhxg+RLzr5IMXV0p1AsQqldMUyCs7Tm5oe8KPMPvE8EZ0H41oHGQT959xIa/tTJ1v
	vCVV9YZLLFoMP0oCfCUrynokhJvifWiHQ4hPo0+ajLOI7cYH+/Z7trR2vx4pbDTOdB0xv8OXLM5
	+zfQQoqco4v0Th/fKiEifufht+taXH/Q7bvjOH2yffIpZewJ1U1PUIMcN+KJOGQitK07kzZKgde
	eSaRts9/E6rR5QlfExF/vUpMw=
X-Google-Smtp-Source: AGHT+IG75jAMbaFvc4eUbrny4N5h/msFWd7WmC5fwk/VMEKKvJ9mo2OYEnDfZlTd6IeuC0xb1XzJNw==
X-Received: by 2002:a17:907:94ca:b0:b70:b9fe:aa56 with SMTP id a640c23a62f3a-b726320200dmr415235466b.20.1762358806257;
        Wed, 05 Nov 2025 08:06:46 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fe3902bsm512775666b.63.2025.11.05.08.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:06:45 -0800 (PST)
Message-ID: <a852781a-70e1-4da3-a283-a81be10daac5@linaro.org>
Date: Wed, 5 Nov 2025 17:06:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/28] mtd: spinand: Use standard return values
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-7-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-7-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/31/25 6:26 PM, Miquel Raynal wrote:
> Replace -ENOTSUP

do you care to fix all mtd? :)

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

