Return-Path: <linux-kernel+bounces-736337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C117B09BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75F83BD917
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD191E5B60;
	Fri, 18 Jul 2025 06:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="p+46mRF8"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0995320296E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752821108; cv=none; b=kyqQ4iqx2rI9oSqigC1QMBKpg7DQ+/WP4j7FyxIm3ZFUEJl19hvZVd0GInW+AuXkIk+NrZrPTJ4M6BAxzakgUuyXmJt42T08pRydp+Gb8eBYxu1FmUIstEQ8jDOoaf9B/SrQieSlgnuXyV7rMUi9bEiYDyIZSS3MmTJCSidJDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752821108; c=relaxed/simple;
	bh=kkKL1VIQ7AWWYCZaWSpkudCpDzgwoDkadDURjd3l7z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lR93bGRT3KfFSYtY/pD/9N1aN834+fGaghYrBUDQbIDzOctGIsgbNZgJC8fi8w0Rwd2mQgl4CG37QwBipFhczYAlP16invR1iQPT8bYNWvDkHdblmzDhKUnhRiaiUM7WRL65p/D7oe7Yh7haGd1y7zLkHrlEuVQK5O/Hztq8XgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=p+46mRF8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso342105966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1752821104; x=1753425904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVar5g8zOX9FTPpiuRdJzd042YFwcWfhs7Wgs601zJE=;
        b=p+46mRF8dXSuoJXK8J471qfovjTuI/pR+M5XqBZm71A7mooeHNcPZsd5V7jtqSpvMa
         S80Rii1nUu5sFLwEqjJpVlqM6RnQSCcwcVyaQcX6FSXhs9/5ysdRtb0WrTvuBCXOJYhu
         sgN8vJCysHz1VjfJxuK56AI90AdT2bQirh+y7pZHwChq3HD0oisFoWDEmAZMZvPeIvtO
         W9SL9F/GVG0UdTp8OXV6DY1UUTC5R3Efs+u0+16r8w0Go+O+ws0hDqqWRq69OtyghvMv
         /wNAerkEomvM8+loFRetKVxIemCnuOdr3LC4jfoW7rGuwLkQScRnVD3PJ4Ubj+HTITrV
         fkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752821104; x=1753425904;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVar5g8zOX9FTPpiuRdJzd042YFwcWfhs7Wgs601zJE=;
        b=ucC4xCQvQ8rZOcGyRG94gL726nK7zatCGCHULCU8uVCRKIoYp92AfUCscBvrNa+6FD
         G/HZTffo8qiVTDNbIGLPJ5PrFEaC6s2MbG5NwqWTh4AYDK+F6IaGkhB8Kq91772xIJda
         L7Pi98xoBPX8boGkTkalOyRdCS1nu5pRNrVn8Cm4azjTAr57SOJ1hNpf//QHXLH3GdM4
         /dDUlR7ZReSh4/MgKKboCxSE6GShonUhcqls7Kwh67p/FsZpZ21BEC2Dkz9yq1f0Yo9i
         iSGFfpDZ+83jDPYXTZaLg4fkrRUgg8tI9u4OgVt1gQlZjjxT3/4YktmmEuwkJpP1I4vT
         u3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXaQoAAYdtrFAX0jI8bDFdWMNI31LUZrwMvYuD+bMe3I/Hn5F85ZtDColSrXnfBm1aQKg9cFDvUmTreus4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzkx5ahtmvjnHqGCfwVtd/jfXfr8TwMYE8t2LJraCy4x6u3CP6
	bQiG7TdurQEvtBo4FoWM2ZWZwnDRCKcT6yAnyfDyyxbQSEiFuFcS58z6xs8WcbPvUXc=
X-Gm-Gg: ASbGncsswVlTdwgTlzqGCVPjC2dXsDZ12rHtp/ANaRC9S/mxxIFetvt34HG9TCWOwNM
	h9PHN8X3RQro6wsftYkDWg4oiHEVMmvy40A3XKzWL+4/BOl8mbEm2NA+ISuklAHjT57VFwPhLAO
	3PqGmDK/rCBjxrfiRs9eMuFCeynr7IXUJirFZ4sDIS1yoro+BhO4Xeha9naTF8pbHMYiocXjIfK
	bHzehayWMnkFQbe9KoO608GMyoxQbo3q8bWI8rTe72yInClHuT2naUyfxKWH1TWEOGL5dQDP70Y
	4qZVabKhDMkm4wJJrSuAjj9mGomZjgtbegVvaSe6MMzMf+CF0Ib/GgdqI0aA2yuVpvrZpVAe8c4
	KeNltGwJrqCuKlFnVwHlL/dAnVkyN1w==
X-Google-Smtp-Source: AGHT+IHxkNxiwjD0/BPXsctCLjJokMhGtGvK5gTIY+yWmoyQySHcBMCNgSHU8nTNi4mvXEKWD1jTxQ==
X-Received: by 2002:a17:907:1747:b0:ade:316e:bfc with SMTP id a640c23a62f3a-ae9cde242camr688547966b.21.1752821104166;
        Thu, 17 Jul 2025 23:45:04 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6caf80e5sm63293766b.163.2025.07.17.23.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 23:45:03 -0700 (PDT)
Message-ID: <39b57899-4e8d-445f-a3b5-3b7f9ba3c3cb@tuxon.dev>
Date: Fri, 18 Jul 2025 09:45:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: at91: sam9x7: update pll clk ranges
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 mturquette@baylibre.com, sboyd@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Patrice Vilchez <Patrice.Vilchez@microchip.com>
References: <20250714093512.29944-1-varshini.rajendran@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250714093512.29944-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14.07.2025 12:35, Varshini Rajendran wrote:
> Update the min, max ranges of the PLL clocks according to the latest
> datasheet to be coherent in the driver. This patch solves the issues in
> configuring the clocks related to peripherals with the desired frequency
> within the range.
> 
> Fixes: 33013b43e271 ("clk: at91: sam9x7: add sam9x7 pmc driver")
> Suggested-by: Patrice Vilchez <Patrice.Vilchez@microchip.com>
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Applied to clk-microchip, thanks!

