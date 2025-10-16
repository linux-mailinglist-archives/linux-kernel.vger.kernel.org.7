Return-Path: <linux-kernel+bounces-855792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C29BE2575
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919DF3A2376
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682A030FC33;
	Thu, 16 Oct 2025 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="LK7n//8D"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6432E62AD
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606425; cv=none; b=WG7ogfHfvRWc6+TUdJakVx/5TckpkD+8nHAs/6AYD2FieUJS6SrHIB6wgnjySJiMlfxP69m/VzLAasHhYqTUYGQ5mGz+eZRAa8SSydFJTs2yC56twsVYNKu/TJ23PKjmOcM8APiUCYbZNuX0r7vzv2QF0/szq5uGYfZ99EblMPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606425; c=relaxed/simple;
	bh=co2f/hF5H+j/qSupABuMRAji68puIyS6hu4YwpGwasY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/N4NF6kwoanmabP5i5LUQUGQcRYEHzXeekXmKV6xi2P5z1E+wMhY6GeHHlEcS4B8nPxB2NywoaMO8AZkoBk6K/0WnEPzBmUYkLKo8mS1WWQoGHD9z904xdKrGj84Jg+tPB021sWZBcb3L0UHTyFLY3lzi2O7gVSVqYGooq/wgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=LK7n//8D; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0FA9A3F6AF
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1760606419;
	bh=OJ0lJAET4g4vdkI+q0D39xN1UQb7n+ShPw3yodFDk1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=LK7n//8DFwcsHAjVmYZh+l6OS0t6kSvL6IhJTGD53XmQqpZ0//9tzw0GUaSA/LS8+
	 h+/nCFGhNkzYOvGjX1aKScLgKL/qGDo1ZjE5hG6T14Srl4PhqvF1y7PPlOrvo+a7zv
	 mjBc1SCsA9/9sbsxiu6Uov5+k4FONBbcisgxILu91bQyruAOwKUeMW6sSLmMiF4/U4
	 lvX9PlLs45YhPnEJIf1FmEbrk4jtbQ1jvROsLXLZknIM8KAFPNfX0UOSo0KXUhWX7z
	 6uuQIukGRjRZ4rd9z9XCx235kUPpSfavT/SLN4uI/5hBJqDdvWEzYfm5lKXRlEMbX+
	 JI3KgdlQYfkhDPFXQkYrJNBuTuuzdZHJ6JYoKwyA85GlK10sLJxda0uEZ0k3lNwoJB
	 I0NKx1e1AeGIEJMbXPfxPftd0/2AnzCFMtDxC6Q5ows6hSErDICW7hsLTKNG0P2OEg
	 XKB/ub3Jaz4LR1wHIQ8ZG0e27wtbKY0dDmtQdy24ScsvMljSUI5P8mzQyKwNDBBOwu
	 UuvwghxM/T7cGtlc8eYnMbH6zLEvfHXqqum/KWhxnAB6+QSBEG1+STb5LKaR1q7YT+
	 ywRhW+SmH3f9ONtuzbeJ78qjNLBx7ezeWnfWvwQmoQdNyeEm3xSaXMSPdDZr9HPGZz
	 Q7HkrrjMJjUkzMt6Xjs6HSIE=
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-426ede1d66fso288190f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760606418; x=1761211218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJ0lJAET4g4vdkI+q0D39xN1UQb7n+ShPw3yodFDk1I=;
        b=ml2euIp5Qc/0Yj0PCRmvlPRIHf8nDcv7gVhhZ8rnfScPB6vayD1nVMyZYh9yGEeptO
         P0eVGznyHvZi12tyD8dMEdxRm82JAYOS3gYxO5QTPM3EMAc3Zzjn0O0VrC7LzJQ1m9NQ
         Zf+31j5zbYekS5urDWmqrYhVhGjX3uEZ94rIpUCG0sJZyvY8GflL8qsPSoZLijzT1B8x
         mJ26L820DJTVNlQHe7EIMZD7f0Hx0R29ABU/ASasmL9IgGxyNMPqk9qQX46ZYsYWCXiG
         yOzGI6vVzoxD9H5vPmkX+5Pp78otaACp3iD/johKx59K1PFOaDBmMzZGeHFC6ORAY3Or
         7ATw==
X-Forwarded-Encrypted: i=1; AJvYcCUIJ7HyxG0/0DQ0i2y5Wxp7VqgatNbILHVI2QmUn2bwhnlHlyH2a6jaIILK4a3Dg7k1Yv2dSyOsjNL7u+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvdpbqIPTRFSJZ+JpMGMSjzIIBbo0mPrT13VZt5vA8QErzyr2Q
	7Y6u6KUdw4K98Ilx4x9+f6OTYz0TAm/5eqZtTXEmfjrEh/+7Yf9ZGh18sHmgY25+Fm/pw2iY4r9
	kptnyVNlNgwVTsVsVcgWz3ViVxWrrRBUeSvoDtxNnM8yuCP/aUJttmgbE0m2QK7KIpFQ1frhWMI
	f7lVXkxg==
X-Gm-Gg: ASbGnctiJPW1yDrGuNv1y4F4TPWXSSvp7DVLHynQXD2TzmHCnfyf5DAs7tR+8KkSZ4Y
	qc54iDk5+RffSVRfKXwW/1uF0DSmDzXR5Txqx4OSSpm6dc3IuzOKqGSNcmY/xFLq25FaS2zD7TD
	I6So/ogdRpJNHuX98Maan/E26A+6QMBlDYC4xNtWjLpBDAW5nl/4IcaYHKgcxRbfVfc0RA7XxwK
	vZEMFNXBJHRVv/sjeH2eU7PNTFy0d1MGNeYBz0WlaCbs6looWqb4GwqXcwwFwRloVQOeHcmBFdH
	3g6EPw2bwX/xPdfVgVJ6668lrw3fIdLCVW/GZie8oEaKHYGZVt0FPVArRqN7U6fVu+h6HhFpDNd
	6Kdkhb+9QEz708tAqGrmeQR9qRjznrHMI99SNG+UcJxpM5brt+Xf5NMmDcWYP2YMTfd24ykVH
X-Received: by 2002:a05:6000:2486:b0:427:38b:cbc5 with SMTP id ffacd0b85a97d-427038bcbc9mr260383f8f.46.1760606418630;
        Thu, 16 Oct 2025 02:20:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWHxnhRr0zKaTqXSmx48RroXO5zvyasty5TJo0MiU49h1Rjj308rIrfJTyIkIDwj6SkbzYYA==
X-Received: by 2002:a05:6000:2486:b0:427:38b:cbc5 with SMTP id ffacd0b85a97d-427038bcbc9mr260346f8f.46.1760606418226;
        Thu, 16 Oct 2025 02:20:18 -0700 (PDT)
Received: from [192.168.103.116] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8207sm32742853f8f.47.2025.10.16.02.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 02:20:17 -0700 (PDT)
Message-ID: <48c20b5e-ad6e-425c-857c-79f76742456d@canonical.com>
Date: Thu, 16 Oct 2025 11:20:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] cpufreq: dt-platdev: Add JH7110S SOC to the
 allowlist
To: Hal Feng <hal.feng@starfivetech.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 E Shattow <e@freeshell.de>, Paul Walmsley <pjw@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>
References: <20251016080054.12484-1-hal.feng@starfivetech.com>
 <20251016080054.12484-2-hal.feng@starfivetech.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251016080054.12484-2-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/25 10:00, Hal Feng wrote:
> Add the compatible strings for supporting the generic
> cpufreq driver on the StarFive JH7110S SoC.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index cd1816a12bb9..dc11b62399ad 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -87,6 +87,7 @@ static const struct of_device_id allowlist[] __initconst = {
>   	{ .compatible = "st-ericsson,u9540", },
>   
>   	{ .compatible = "starfive,jh7110", },
> +	{ .compatible = "starfive,jh7110s", },
>   
>   	{ .compatible = "ti,omap2", },
>   	{ .compatible = "ti,omap4", },


