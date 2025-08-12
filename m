Return-Path: <linux-kernel+bounces-764566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0A5B22493
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8882189B31C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFB22E92A8;
	Tue, 12 Aug 2025 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zi2mHvFO"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085D2E4249
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754994499; cv=none; b=TbZRHLz9tDjgwkoFo931ibeueOFLJLQSQwf2CVyTZLPy66g0IHePDzCSjsHdiy8hvPs7tEDpAjPnWoWnZoknlfYiskTqQP8E96Qa1hezGraw8fU6D6E/Kx6qfxGaMFI13Ft/suYhS36CltzA32aVazhxq+hR/IkChVZHYKPbS88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754994499; c=relaxed/simple;
	bh=B9Vrmcfl+8IVTDBQ/VpLV4BqgqKtRjIoSIkTrqYOTCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KO5F9tjwWlSj6LKqLDWmZtKT34u5tf3nChDiIvuYGU2QIYKImK5LIDX6Hrgs9q4RyGmfcg6OiQOZpfet1NKXm7SV6qdNBuyY0R7AE80GaVEQU/9imHMJBspS5A0FR8s+ixF57z4gXQMzd/W17ytqJewF1cvzrmxuvtNpgtbKNy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zi2mHvFO; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b78a034f17so4012970f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754994496; x=1755599296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pm63ILDmwa7xNpo98Np+0qeN8z2wnjVlHzO2eRsHLP8=;
        b=zi2mHvFOFQ0696LkV8C3hFZtIhBdaTDbS9RgFnPtvUZeTCCAqsoCubS38GfcJ7cUhM
         ToxOOYi+rtpYZVBrWEIY1aE+tiQ29O0uV5ngDMpD4gYB1onlPVExDq3ikLMFkG+okD05
         djwbVT7Hq/3w/wxpZ6ZU/4aS0aBp+3ghYv0GFVcqeIhTLAJFJSOE4ayK/7bBUX0K1LtF
         wvD3gixqpEWRWkP+tuC2Q+qB9ah86Eetlkmym/z6YUEvyD+5ngaeAhqiwLvtnGZWhR+5
         x17NmBLbunYEZzOawUR2vKQg0QEqUDFcfxJoyySFKCI2Ba1NR3PNImq8zLxjmJNTj4bt
         fexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754994496; x=1755599296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm63ILDmwa7xNpo98Np+0qeN8z2wnjVlHzO2eRsHLP8=;
        b=wq+0LX0DM//1HeLnqLb8IOJaYKc1ufCMxkhEJ7eh3QfUBjQ1bEnWMlz+P4JgGg7iN6
         HRQUsjWc2Hzea6/He3Q93v0N+JoqYZNg+rtLV6zR7WvablofOi9U/zA/OlbkO0WoRzcx
         9VdMclzJKrH055BjEDL/o5YATiamcrQhmaGtzFj2JbRvAW2mPtNYITGb6B4vlfC5UBFR
         zAqe4RNP5yknJ6VdbWgHIO50jwEHh4HbqSBsY1cinWSyyTbSuFEXPicNc9CYzhTaKYVc
         xzLAXglCERldOyrTeNsVnIkAwpjan3/VIQv58lZgg8YmiklbsNnToS6xHsZ+6x3ZQdsR
         Cnqg==
X-Forwarded-Encrypted: i=1; AJvYcCUqgNSd6rG/S9U+FCk4XB73L309FOuTM0EFdaOLcdL9Htaru3MYgi082zCT7dJNRFUNHMxIC5QkIIjN0Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/9hhOCtNAO6ackYwCk8d2ZoZZ7DKZGOfCYQMIR4OK1/kMXQaA
	Y3rvZflRmVrLuVEVl1Cr9AdimIYuLwYEibSVS38OMTuR2BBZgi9/dxoKySeYutt+vGg=
X-Gm-Gg: ASbGncv3q2JdLAHC4OtggDQwWusPpRJz/xwReKqsm4uRRO3EkiAM9Mg5UlHLPz/VBv6
	nKiQii0nG8vN1CxFeP1n0XJrkU8roi+S/EpuofwK1+eNUWZsRHFGNtsmoAlxSQ8W8NSSt/Lnfwo
	Eo1/VZm1TzKRhLlmXYL/QmsJS3td3OdKzKfDTHPSkETunY9G6Dt6nOwCmgtyrAAtPbOeGg8p98u
	sf70xXiE45a+TrkCojupqtEHfn2MLSxAUWOs2E+uDvH+X1ekvkDL4ofzofkhfNSzVBuyoSUrCEQ
	jUVKk/dpDCISgcc2k9s9pMUJ9rjg5uk5SL5xxhtnM9Y9GyK7CAUx25AoguJ8qDSJVjSs6hmLRxf
	L5jq9FlsKL5t0lkVuG1dDpMekTI67CQ28cZdCLIGOKMFUE2wPnvNVqH2XbQReCQ==
X-Google-Smtp-Source: AGHT+IFcdKMW5nagxZx6H4FgaqbvprQU5gv49abZvdzjaniK3RNc9c2E5u7r/cWE1TXNI9GVsZSWQw==
X-Received: by 2002:a05:6000:24c5:b0:3b7:8832:fdcc with SMTP id ffacd0b85a97d-3b900b751edmr12603011f8f.38.1754994495881;
        Tue, 12 Aug 2025 03:28:15 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b915deec6bsm9208f8f.7.2025.08.12.03.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 03:28:15 -0700 (PDT)
Message-ID: <b7a7f3fe-faa8-4143-a200-d91597d46124@linaro.org>
Date: Tue, 12 Aug 2025 12:28:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt: bindings: fsl,vf610-ftm-pwm: Add compatible
 for s32g2 and s32g3
To: Krzysztof Kozlowski <krzk@kernel.org>, ukleinek@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ghennadi.Procopciuc@nxp.com, s32@nxp.com
References: <20250811223044.3087090-1-daniel.lezcano@linaro.org>
 <20250811223044.3087090-2-daniel.lezcano@linaro.org>
 <758fb1ce-bf7e-4dd8-aa24-3f89d9be5652@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <758fb1ce-bf7e-4dd8-aa24-3f89d9be5652@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/08/2025 11:03, Krzysztof Kozlowski wrote:
> On 12/08/2025 00:30, Daniel Lezcano wrote:
>> The S32G2 and S32G3 have a FlexTimer (FTM) available which is the same
>> as the one found on the Vybrid Family and the i.MX8.
>>
>> Add the compatibles in the bindings
> I already asked in previous patches - prefix is always dt-bindings.

Yeah noted (again), thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

