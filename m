Return-Path: <linux-kernel+bounces-776046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79471B2C7DD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F8C5C3ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3298029CB24;
	Tue, 19 Aug 2025 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P+UGCskE"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0286A2868AD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615449; cv=none; b=EL+8kIDtblPOmnmLTa8OjNDBTx8+AoeM9Fi4/nzoERXRopY+CIwNPhZLXfmxBiqnGyXPUdpPFEQko/TTtRczMKRD8lUZWEuv1038qmiEpb/1N10ZWY3e3JwUaXM4QzglYDLphghTtKokxkh/90jB6jdCdaTKDKt5HJjGwdVR1Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615449; c=relaxed/simple;
	bh=7EZJU8EieTZCa/QAirNvhaC/lS67AJjOcGCkNE4mpJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qROqqHalOgN9+2HalB71VpCtED2FfEs+vVzdUrQXnIBv9pwdXu0N8sEDcIlsK4Cj6Fd1X0ZAswD/G0ipEZZeBcdsZn7qO9PAwPcI3VDpqUHzyyHY09QBJdcv22sqq3H4kW34Xj1stWmED/SqXd+SJQEhH08tirmKtzO4HqLGc9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P+UGCskE; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-743749537caso5459219a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755615447; x=1756220247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j33DSRA1EWH9BS/A4h9RpWvd4kG0MI4exSJuHlC5IE8=;
        b=P+UGCskE1WjuiKE0pLB5MUSoaUAj6INjm0wy4K99rcn303ZEA0wnl/TubSUJq/uiPf
         IeSMXmyUtSkOHAItbuHnoFOkzaQnbvf0pSp5JRdJ9d60plMYMp7B+iqg7HEcl/OvMNpo
         k0jUgJQT3T7Dz4Uo0BhQvXd4Gg3aj9s7IfvdMkAIiynn7+GLiM+OBwNAtN+5kdFRY6Ca
         nWUf7yrVnD2OEjGt51nnb2F0QQQ1eSH3Kjs4RhxyDh1AO5LidmcYJF3LjdWQmh8iTHCs
         vNPLu8s3tdjtyGhf2BSE0IWAchQHzT7Pmufpb+LUY5g3vq6UZxSG+hqOJxEI7jk1lAF5
         2/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615447; x=1756220247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j33DSRA1EWH9BS/A4h9RpWvd4kG0MI4exSJuHlC5IE8=;
        b=Y4EHJG/3B9KNFU7WumD8PPg175zuGI7/46JRdYd6ZjqYQBCORj3f9SzBRGGZlpFnIo
         AtVP05VoSYboO0hdXervHVmjTGiGNfxL6YJOA1wKepXlCCDXCWXZlNQt8t6h5jGR0SU/
         QBBveOTl9Mzghe28vsb1u5hp/y8KAj1Qhdpjrd28UQwGyfANxTWI1hgY5y0dCN1MbzA6
         It7FzYpw8wCRqppVEEZ+rO1XT7pFTHNyrFK0n6uaOrfdR1yIk7fOmhZyUtpkTaZNJQkS
         DO76BGHLYlHWrwR6+PJ7sakSr/PBY7BkRfhlpRb3RCBjgWHUydbbwWTEe7ItZ/55H4RL
         PoVg==
X-Forwarded-Encrypted: i=1; AJvYcCWuyhROJpZBE0OAUPY7ee7tJuHTd+tPOIoyzsqXpwB/VnPz/iNaLH6d7L3Vd8cDAct1f39Zx6rVGlRBggw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCUbGwusVgnXPwnaW8TAMz+rhoEYNYpbLuh7QXQhfhV5M6pKAg
	5C6mDFxRrK5S81V1Jvb099bGlSi2S1SWgGz/reqvVFqbwedCeHq46Y7NE7EktdoIQgY=
X-Gm-Gg: ASbGncvgA38vH1vRsY9OtBsuKJ/DI7ZmZfmp+mejTBaqq9ReqB7Pue4MQpUrCPU1rlh
	CW9fY/oJCyyJXepFd4Vu416O2gKTqlO9dfnk5JPfm8tOdcsoZMth/72f6foK7Th7CurwL7NFG0f
	MkUpD/Re3s1R7q9yJs5V0LTFL08OSM2pODsKLeoO9VSRJ223s1sU25BVMudYWikJsthRbaeXSC4
	Ja8YjT8vamB1Vwqlb9MN3A03srGawk2mjHXF2h54clB7gLi85LVjgFJEGpAdtU6cOTbPsJhr2oL
	7qvOwtWfvK7jpW0ODHzZSXTs8m1jXHMxZ5gWf8cIefk/LDS7Gt6egUCd/17ibvxO6uOiS0bkMAI
	CbAJ+MDPuGQwNESgqvpETheGZUMpP6bjjYu7fSaDSGhx8ejESdyaWN+upHrxVWfhdnBBWE5HEdg
	g=
X-Google-Smtp-Source: AGHT+IHPlSLH6hZeAeLnJjJgwE76N7/FQQiTxPqI0a0U3Io0rzBzG0AsFNUvGq8BqYM0uzYltC2DgQ==
X-Received: by 2002:a05:6808:1191:b0:434:8e2:33c1 with SMTP id 5614622812f47-43738c2d23cmr1484476b6e.10.1755615446945;
        Tue, 19 Aug 2025 07:57:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:990c:4d50:9c6c:f367? ([2600:8803:e7e4:1d00:990c:4d50:9c6c:f367])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ed205941sm2284247b6e.32.2025.08.19.07.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 07:57:26 -0700 (PDT)
Message-ID: <a9724713-6787-45e4-95e9-f020e5e510e7@baylibre.com>
Date: Tue, 19 Aug 2025 09:57:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] iio: mcp9600: Recognize chip id for mcp9601
To: Ben Collins <bcollins@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: Ben Collins <bcollins@watter.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250818183214.380847-1-bcollins@kernel.org>
 <20250818183214.380847-5-bcollins@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250818183214.380847-5-bcollins@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 1:32 PM, Ben Collins wrote:
> From: Ben Collins <bcollins@watter.com>
> 
> The current driver works with mcp9601, but emits a warning because it
> does not recognize the chip id.
> 
> MCP9601 is a superset of MCP9600. The drivers works without changes
> on this chipset.
> 
> However, the 9601 chip supports open/closed-circuit detection if wired
> properly, so we'll need to be able to differentiate between them.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>

