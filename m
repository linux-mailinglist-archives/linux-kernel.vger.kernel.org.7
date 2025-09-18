Return-Path: <linux-kernel+bounces-823508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CA6B86AED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306573B46F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F78F2D7D2A;
	Thu, 18 Sep 2025 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ih3qsp01"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15B32D46BC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223948; cv=none; b=QlcEygKpthxm0kqpi6P2NdeWlmobmaA8sev9irX4tiP5rd4JoHkkq779I6y0mqLMzAGxWpFQIX1+23/ngkCu6y/Khy4Rv/avclKtz1xTrvx+gI8Uft5b2gZe9BQBAKokIsN5gAGdQUUeg5w135T6P/KEp5OIFdloLlp5GHPUTzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223948; c=relaxed/simple;
	bh=qivYkST2C7b7yAkJHzipE9NJQefbbXWWzWHSNDOD73w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QK959b1vKvzjnslFQncB7mN7pDyAfobQIsMnKR+AwB8F5wEel9sihX+xaNC2/j/kUPlWLpqzqVAAagUx3JXc6PBFyNggS5bOKTr3+/dp3OofGSm7MsSj2RseB/ZCQBqJgGAexFcBg5Di9F5OVV5TyDHHDyXA7dD8cAjMvIMGPgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ih3qsp01; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30ccec59b4bso976360fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758223945; x=1758828745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uC46HYcJYoz9+sBv/kVNcz3yRxRfTKz6LdiKNeN6Wo=;
        b=Ih3qsp01kdSLJ2q/2QwIxMJN0GL/kcgzGrUyckPu227ZjWJJL6W5yap9lRy34m11MB
         vGh3SJARh2b92Ugt2v4SFw9IZmd+529d+jyiTZpZeRJdPCTrBy88Meg9O0cOaww1R6Qh
         chRmJ9UYbcR/ZXARIo7Jk9E27jp4RBVgBWQz6Cmz9V/bJmYHlffS7Q2xZsMdoY/5ub0+
         kvPCv7ecBYr5MId493prXKdRR7MtW70zR3yfDi5WP+6JiVNJE1g/+8kM7BZzsfB4vSyZ
         V+OYmP/VIUhL9oznThYpmBe5OHyFZ6Ryd4pRfqhZm21ILSWP54hW++EyF0Nv5dZcAeic
         ERrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758223945; x=1758828745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uC46HYcJYoz9+sBv/kVNcz3yRxRfTKz6LdiKNeN6Wo=;
        b=Hi539bVy/vkSu0NffrP2nSTBCD6JsRQuZqRCDe9QO9XJh/8mbLEI0UPE+0wj7cU49K
         S11ZBQolJMgIjRak3oo7PdiUMZ0M1Qy3AXEGNPRW+RtyeU4e9FafhOdtncl93EFKYd3e
         QApw65ghBOL37VRGxK958XsCECsJRcxb4pD5iH6qKv9m+xuL4VgaMWV4dvKzbTzZbsxo
         H7UMgF1vTjLy6xv3iXMrDNcHlDi6kdJ+NTscCUBSSF2vWOrbYPuvLMCR4XSYJflFC2Fq
         Xj8Nvk725PSZohLjkAu+eFLL7LeNOdfByiZayoJ7qVb8+tX7b7InrOC0ac418yu5LO2E
         MNyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWhE4UCrB/eF9Klz6VwNkvhQygS76SCivoMUt3PYvbUxqw/f3AT60QBwf3ECYgDgwcFPxYRyoK3cjBqBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw50QCAhhBQ1F54ehcRBwD3SjNoyZQptF7V2JudjX6MGp+f2VPw
	dKVmg7/w/S9iNSzWltFzPq1RhdQbUE0G2+byGVEDDI8xkVZ7JXAmze59m1qfiXaUxIU=
X-Gm-Gg: ASbGncsLVsF6ylmujbdJUgLjZRyTMaOwvkjnIv3WtWoCJh8vLvw4AkuDdcspXANwNx5
	rtp6hObKe7wt4HayCydpszh+esiyRzsPB6LsZb6Dlg4yu6LrjptNHItRpz4VmuP0Dwyfq6Bk97B
	V5Y/yK0D/mB8rlM1WzvAkew8A43MB1bwaBU9/S9bWTaznY89mIn5ccNpql2U/t5dE/mluPazKJY
	kZC1YtP0CcwkqfA1yOquv/Icbl7GN2tyvX1jpvVWY6dIfeFxXZE6qMT0NDwdlIV2x38KGvQsggT
	LDmYEzAqn4EE6WkcbSkqCmdreFiVvkciWibZrbRfnemsmYToRpn/s0wrKDcm/qgpFhbf6Ub0aoB
	m+5obbJWIvRXOJFBnyOEj5YKWzY6dRTHi6VEEA8jtxNnHTyw52V86AWSvZQX33nCYcCA2pKI6ec
	1dCM70IqBQX3DLt3NtKQ==
X-Google-Smtp-Source: AGHT+IERFs5Dq//LaVtzyCCdTNAhiZ4f4o05CjfcgmjDwNiiOFdseuqJHqY+PhbFovbfmMpCoV8JxQ==
X-Received: by 2002:a05:6808:f94:b0:437:e3ab:fa02 with SMTP id 5614622812f47-43d6c24f008mr346527b6e.26.1758223944929;
        Thu, 18 Sep 2025 12:32:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43d5c6bcb8asm1132156b6e.8.2025.09.18.12.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:32:24 -0700 (PDT)
Message-ID: <280f7145-8800-4f50-b316-3a604150a980@baylibre.com>
Date: Thu, 18 Sep 2025 14:32:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] iio: adc: ad4030: Fix _scale value for common-mode
 channels
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <b05f763506fdecf0d21a53dde82355418d6fb915.1758214628.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <b05f763506fdecf0d21a53dde82355418d6fb915.1758214628.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 12:37 PM, Marcelo Schmitt wrote:
> Previously, the driver always used the amount of precision bits of
> differential input channels to provide the scale to mV. Though,
> differential and common-mode voltage channels have different amount of
> precision bits and the correct number of precision bits must be considered
> to get to a proper mV scale factor for each one. Use channel specific
> number of precision bits to provide the correct scale value for each
> channel.
> 
> Fixes: de67f28abe58 ("iio: adc: ad4030: check scan_type for error")
> Fixes: 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


