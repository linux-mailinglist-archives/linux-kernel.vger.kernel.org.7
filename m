Return-Path: <linux-kernel+bounces-861593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46908BF324C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1172918C0B07
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9362D63FF;
	Mon, 20 Oct 2025 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GWm1H33L"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DF32D7DE3
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987675; cv=none; b=AgHASQW4iBPXT1rjMweMjoeLmZpKJCrbfZCkCp/P3SY64lzMRuewVIrIp3mpOxFd2At6vJzlR5rrkK567GInyQ00BoBwaikD6fwPE7sGOP3goVo2b6thDZyhdAXM2/2liwkSwQvoTwbSRXNzqD9+tl/YAWjyuhmp/aOZ/L5AOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987675; c=relaxed/simple;
	bh=di/LJywwP3YN7hPrdCC/Eq5PJqERkGej3zMMq/HSx9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hecK5LEtavFVQ4661AbuIhk+hVSnvwG2a4xj3QGaYrMZ/aixDidpSGRvHBRvBUyKqt2zGTLKI+x2Q5N6x2Mil0h8UcKEW6ZCKphqiwhzHgaYPGvzsKFj0Zr0/lcVZXw+O/zuDIKCMnatiXxrc/3nAmxql97NyObyZ1vEJ9FYDzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GWm1H33L; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47103b6058fso33555885e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760987672; x=1761592472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SDlZJRYdimnRIVHlNMRHwg+YJzd0pv9ZGTDqzHt2hqg=;
        b=GWm1H33LHC5HYz4yYjR1Uz30eTN/UgQ/mApuYb6GJTF77xDNDq/KRBOd7g/RiucdAk
         D8tohFE2Js349v4zjkY83xQ+QRpvMJV/eYrslDOy8kIMKYjHBJwo07eSC5LCJCE4oEum
         kasLEGBlQqBSXdI9BmGMiFWmausFD80/KEd5Opu6uvC+zPan8SAuIX2+muPX4EK5DPZt
         zTmDQSW5OERj2Jf6mjTwxtQvIogQjrmC1XDOz10yzI1hUENGxYsfmVJ+1cNJv6unCuV/
         l9Fw/moqrIc+vJPywuML7rVS/I4xKyMfnZjGN/SZ6XcWxjJVHHYk3Jahzvg26AvO6rV3
         oBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760987672; x=1761592472;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDlZJRYdimnRIVHlNMRHwg+YJzd0pv9ZGTDqzHt2hqg=;
        b=PPjL5V4BT2j0SyfaG8ZdBY8N/BrjDv+ddHN9W5aB3Ltlan0cmfmcyeMDg1mxYt6fnI
         YoTAlB9ikcJp0LQlsx+6QCgllqLyBLJzvOG4DqK8Eb9osf9NDpf76PSHwrCpL2VEqUqA
         41xY4DUjcedtf9tzrf9qigfFUZMEsjfDa/PCFs9uZFcvSUFugCpzIkp3EneXisWC+Rnw
         WGkjmaxPtTBEPGFl/JCIAWb10A5bGWpEhi7UKa1nGDiWVXmEWVv62eMaszh3lzeYdDXb
         dtMu6anIIKAVd/H0qeGLM5Ekfo9GH3rq/3fPWqA4F5jnMUE1lYvvWpodaUZj5VBGqlHB
         44zg==
X-Forwarded-Encrypted: i=1; AJvYcCXRO6QY9k0cEbj/O4wTTu3ipiZljsjFrikRRgUIwMkNG+gwqOI4Aduy0o/Fy4SmJQhR1QZaK3tjoArGrns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpfJu/dbGLi6BMon+ChwdzQGj8kRzlakLagGkiCV/SUVFhDvp+
	lzTn4Tbev/HqB0BsrlHWZ0x7NlShzDrsaxP4mv4Soxh3p1binjd9dsj/upIwewxUPnc=
X-Gm-Gg: ASbGncv3O2bnXYBv8YqTO4+aZ6hoTvgrWsLNK+oIVkAW3nqiTLANN/LBQBGRExR0KF8
	FMhIcSfVmS71zA9O+hf8z0jUyINrHS58sRTPVvOy4onfpKdenDuzja1DRRdVNN6QmUZ/jNpaYW4
	y6yYSCvHui0POeCKXVH7TUNWMbI0cVDg2RHuLpDG9dRN9GK1h8wXoEWoE/fTlmX7v0pvY77KGPt
	XdowBNqh3014AMSfEPHLiNspgRbzHMKo+8gHp9GlJ+z1yYEOK0CJNmSwLKTPi+NLqhg1YZHVxLE
	HoDzl5pH7a99aPJ24fP3KauL0Xr7PkLKyJtY18nIKYSFjfFJVDyj2t+aTMLO8KgC6q1mPq+slln
	jwltrwtQU1RK5HD3wSSlZc8vCJKXi/8ur7MPQ/8NzdAgTmPytxN8zXIWbO/BFfYFw4k8M2mBr7G
	DnJ79a1zlk
X-Google-Smtp-Source: AGHT+IGmMD0YHvu73+iykCZumpj3yIaAy8xwP+HHCSMQ83VbmXhKKiVZhRtq1rwRrVeYCqqd8gymvA==
X-Received: by 2002:a05:600c:4e49:b0:46e:1a60:c995 with SMTP id 5b1f17b1804b1-4711721a463mr111865765e9.2.1760987672296;
        Mon, 20 Oct 2025 12:14:32 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c82c9sm243199115e9.14.2025.10.20.12.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:14:31 -0700 (PDT)
Message-ID: <7f478e52-eb82-4cac-a11c-e0e4977b3d33@tuxon.dev>
Date: Mon, 20 Oct 2025 22:14:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/31] clk: at91: clk-smd: add support for
 clk_parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
 <4e3f834e6901f7fcad0e697b56c85573c8e7ae52.1758226719.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <4e3f834e6901f7fcad0e697b56c85573c8e7ae52.1758226719.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 9/19/25 00:16, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Add support for parent_hw in smd clock drivers.

s/parent_hw/parent_data

> With this parent-child relation is described with pointers rather
> than strings making registration a bit faster.
> 
> All the SoC based drivers that rely on clk-smd were adapted
> to the new API change. The switch itself for SoCs will be done
> in subsequent patches.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
>

