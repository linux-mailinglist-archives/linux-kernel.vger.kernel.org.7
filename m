Return-Path: <linux-kernel+bounces-893040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A287FC4667E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49730343550
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F1E307AD6;
	Mon, 10 Nov 2025 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yZ8sbvzu"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092152FE585
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775815; cv=none; b=kk333P2L9m8pE2b8YTxKEbNfrW7S0QEtgnnA/omK+yWigWWYSTH1UI2U540AXz2v4NdIA2H8qsEdwkjYsc+n5R4miR6ZEUBl1tjqW/HENtW3gNIowPTEdcVdHEwYAju0m8v1tFdEMXvkyrEISU3zBN2c/npZSKGlVzxlMHBJvqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775815; c=relaxed/simple;
	bh=oUgierYSU3dRBhCJGCsjS3J9M3HkXvV59r1SNiAzvk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJpx6PfaQfxoymiuI8idmki+H17Hi0pjrWNrRT2cYAjWxSILUonm6amJzrFJ7vGJo4PWSrHOZImaTZI6S1lLfeeuuRJTu5dB6KlNiG0Ctua4Ox18Busqs6JkC7bVuyjIIYNRGPNyoLBRa559OGKVA9T9ZcxVw5D8yGJB6rA1wNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yZ8sbvzu; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so2118695f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762775812; x=1763380612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4g2z/CUdSCaQjy9LxpwOngAggO4WOQO9SBX2pApcNyk=;
        b=yZ8sbvzuAGCw2mrF/znpax5qC41Ec7OITzSh/dmx2az4dedT5WWB6bpqwtSq1I4Nlr
         oIpLrJxktDxHg06jbPw7jL2jKcc+0jSEAQd3c+S4v1KeOvQi/QSH90zJ/r6OyfXi506r
         hmTKfE/X0/sdzVMa9BE+0dwJJQdEftjpNt6jt1tHT6/j6tfYT6HVn/algXMNXZKO3VB+
         dRSM/3B6u/fUySKFFntvkD2WpNch/ElHnxg6XbZjgr8WjqdfdMpnrFgmL2piHu4dwSty
         M8OWYVWlLYbBk3RJ3adi7uPuosp/yzM+ERCRJasi1lgQxCnJnXtKfsoEfV5hkEUCGeMw
         hsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762775812; x=1763380612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4g2z/CUdSCaQjy9LxpwOngAggO4WOQO9SBX2pApcNyk=;
        b=H87ujcMPkXeAQ+1YlWo/XEdfE1EL+sLNuMTOXR/VD1MVGsPIAPPAaDI1D5W6ZfTUiJ
         lgVJGnwMtQWT2NHjaRNS61AJqSyMGDTp6JuC8c+qSk8ADjn339NQ4dYz7e4yg8Tn0g7h
         zSIsKfnLcGol2gp1sG0ZgPNoeljxfwPYGE4rEEh5GIoklKD5Ni0RsAq3w9Adw3z5HLCs
         Hw+8EMpIWJnka8+M92eWbH4nUqw98LNf1MDaxd8b57MjY6uOe3UI/Pp/3YRKKZL4Lt25
         Z8GJU7O2OpSX/RDY2YtvJH/woFdozm1EcbPAZ7ljzE9u8l9SW7NHczRCA/QSEbzqOgkx
         lTVw==
X-Forwarded-Encrypted: i=1; AJvYcCU05yhmkQFH3gVcwoQvx5JH7JEWs9yXxWwrpu2LPFxcWSGwMckFYkLCRylBGvEu/o94LZE6wN1DpPdDUww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVcIrj6QSAg7+iy8ikY95W7S6C8iwU4i4M0wUMpTPb0LP0FoFa
	gBZAKTTL8OyuV+pUlrdA1ekQMRBr4StR7UfTOgNtP5TcIW/HsxM1GBz+rcHJ3iZWJAc=
X-Gm-Gg: ASbGncuOmBEevPdhA1smGg+qLjRsq96suXpk4DhnCXbRTOG8f1jwH0KGn+EumSYpOIb
	JLULJEiSOczTPzj2YCm23DxSf0rgofmaGk686e0jxZuED6yjVOgnnpMm7clYYKp9clOilCLFSWC
	eoaNKuIN90+s1FBdhYWDEgclsUYTMlbfCx0yjRR7milYCFyBxmdddyGn2Gl1qGaIv8gzFS+Y6SF
	5vQ83W77ENNb3DLDvfelFkftlEgLp9FeeDkT3yTLmv/Xtu0lOsptvqch0AOrthVuC3N0O5nygGj
	ZYvm++I3e+qi+bRH0m06Z35srsbT2FzfW+4em4woRGJzwoSga3TM4t07SarGvPbHRd03e2OEwTt
	NJwzbd+eZUPy7ZGj//Ynr6ikW1GzFw3U1trrgXklu+/dE0RxyDpOMnbd+/73LlgABwjcKzfDc6T
	G28WqVJ6WeqTuR+DxGlQn4vBvevg4euh5zaHJpECyi3VChilMjpy/aeZk=
X-Google-Smtp-Source: AGHT+IFbcw4K9ivqGLQddDZa5CrYY9iwv64S3IIlLZWbi+XRwqAEU+75TumzHzlJ4CnXK9gTK1CTaA==
X-Received: by 2002:a5d:5f42:0:b0:429:bca4:6b44 with SMTP id ffacd0b85a97d-42b2dc1f4e9mr6741662f8f.13.1762775812360;
        Mon, 10 Nov 2025 03:56:52 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:2b20:d700:6e9c:533c? ([2a05:6e02:1041:c10:2b20:d700:6e9c:533c])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42ac679c5dcsm24735244f8f.44.2025.11.10.03.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 03:56:51 -0800 (PST)
Message-ID: <d36f89d7-2d18-4c24-840c-243d4fa10de0@linaro.org>
Date: Mon, 10 Nov 2025 12:56:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: thermal: r9a09g047-tsu: Document
 RZ/V2H TSU
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 john.madieu.xa@bp.renesas.com, rafael@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
 mturquette@baylibre.com, sboyd@kernel.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20251020143107.13974-1-ovidiu.panait.rb@renesas.com>
 <20251020143107.13974-3-ovidiu.panait.rb@renesas.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251020143107.13974-3-ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/20/25 16:31, Ovidiu Panait wrote:
> The Renesas RZ/V2H SoC includes a Thermal Sensor Unit (TSU) block designed
> to measure the junction temperature. The device provides real-time
> temperature measurements for thermal management, utilizing two dedicated
> channels for temperature sensing.
> 
> The Renesas RZ/V2H SoC is using the same TSU IP found on the RZ/G3E SoC,
> the only difference being that it has two channels instead of one.
> 
> Add new compatible string "renesas,r9a09g057-tsu" for RZ/V2H and use
> "renesas,r9a09g047-tsu" as a fallback compatible to indicate hardware
> compatibility with the RZ/G3E implementation.
> 
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied patch 2/3

Thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

