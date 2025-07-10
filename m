Return-Path: <linux-kernel+bounces-725246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11633AFFC67
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2CA1C85290
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A0D290D98;
	Thu, 10 Jul 2025 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mieGZXOz"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C12B29114A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136268; cv=none; b=YiSCMSOIb9vbvCfwS6XWFCo/fM13AJ8+NhqBD6/mBRDgc/LgElpBSqPPQypb8N8XGIU65VlGl0JpAvbGqOYI05RONgfSFtNalgMjFLeSZqep/isWyp/QvEx+78Yq85bEPsN6XXT//dturdHOuLUSx8mHO8V9hSuwl25sedpsKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136268; c=relaxed/simple;
	bh=WsQN4AVlXf6DNHQIYvtvjyCfMrCxf4ucZTnCnKQt3b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pz2ajnoITL6wMxLWa5R43stKm2+Cm1I+DroywRFdX7gAriiMokL8cCzDheGrCAtn6wiGxfyYmYAyiyt/In8yZFcWdkGYxn+CRkyXRbJF8/BxYxyWBXL1LJSpfERoAgNIW9TfaBY31uk2H/HuPiNaOidN0Ni3odrSLSvGqyte0v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mieGZXOz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so1173532f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752136265; x=1752741065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5T0s6fRLYxxIaq2WBuc24+EuGA04MXZWrPntdjj62uY=;
        b=mieGZXOzXDxmxTJWeemMPS/peoyDrdAGg2PzSakUidCb8kuINovtMMmt+nRcxTxrwS
         CtDzCCPRrcX/owIFeX/KJqKjX4wCTzGgHcW268gSqiCfQ+qGnIUYEp/kupCXgvozSucl
         EY9NZFzOa2dIt8b8GaZyDPwfsULYL/dfUJmTtwEVL6EKLwE9S0FhdJEz02xxnoMayqLc
         x5NvDmMTR9kzALg6M5PW5Bqsz8gRWccTDa2it8hRWy+rFfcSJKQjerFdFLm0JQOFwwJV
         Jyj2wKpgjmYOU4WCwjinvWfSEPTeGyOt/Ngj/po8AJuKdXt9jMsd+cqrsAJHn2ErlLq2
         RjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752136265; x=1752741065;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5T0s6fRLYxxIaq2WBuc24+EuGA04MXZWrPntdjj62uY=;
        b=CYI8c6R7j1UDg3Bpi7bDxa+RZ0XfKNhuqkh+CbBYNpWpd9ZIX1HxQHuMkXGdeEF2Jd
         A1lTWUtfwceOavUsgp7j7Grwbpyu6pgR5iQiUoupTgyOEYspmpwM04bzsvkfEsccZpcY
         NAd7OCuq54QAjqEBV7p+Td0MLFCGGEQ65+P8wK2vpoX5B8B731LedU+bz4qyFRzahTXQ
         OTA4o0YprgT8bvMoT7ye0PLHkFYPeC1BT+1nNSbUvwzc9gXHZwaS0OMlQvjLhWFcui95
         3JqrkGV89wcWsoKewVFaUdeC3VrSuMszdBc/5R3g+sy/GESF2FoftPVWsa0Ym6APyUE3
         qg+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdEBWQLIWBU1evyv+Nz+cpfStdgWhzv9+6W+D3j2x+JoGNLxMP09X3zrwGaG+LqqGnVKqdc45BCOS3z5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGRpbZg/HJq+gGBZ0+nITEn7hmAwBKGR2NMw2E/kcx155k3qrB
	BQIl6lDHooNh4CRK4pTLX8TZ7Y4wj7auQTx/PLM6jQQ0sk2MVV8c4MY01lO9HJlHroE=
X-Gm-Gg: ASbGncs1h/152YxaPC52wVa6bfsQnU7yuGYNvHgxkTk07zROHk9rq9o/SU4aOsGwGrB
	cHaIrGyiGcWLddJIidHBXSRP1y511SFxDtykSA4Y1fV1ZSXRawBhIypt43w6susmbt2X0NVx3Pa
	SkOsh32xNjI5ZWhLqSpNp0aKo8Atc6tB5hPn71Lb4wf6SOHIyqyGnyg6IJ6+qZj2K9UPaAk9UXf
	0m/0YDmVwyJHE3UwSvep18627XC8jm13tSTvpgocl52JY9jucv5LYVkKBTTROzb3lGA/5XAlJxt
	uIX0Jk2bBhdANH2vaGThRfxF4u+x/7+4BcPfNgcPElLf8CbxWYtCb5Cr9/vIG0HfV7g2mh2E798
	mI7jtz0VVZ5AmhYKF/QYP62spd8U=
X-Google-Smtp-Source: AGHT+IFU0Q1GT8CthgyTMpfXzMuRqsidgoW02v5oz+3a7iCJdRIC1Om/NLFfrvO3zbka8NSBVQRzkA==
X-Received: by 2002:a05:6000:240e:b0:3a3:70ab:b274 with SMTP id ffacd0b85a97d-3b5e7f13a0amr1817266f8f.12.1752136264447;
        Thu, 10 Jul 2025 01:31:04 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5103082sm49616575e9.29.2025.07.10.01.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 01:31:04 -0700 (PDT)
Message-ID: <102359db-8126-4379-aef0-86617d174110@linaro.org>
Date: Thu, 10 Jul 2025 09:31:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] arm64: dts: qcom: x1-hp-x14: Commonalize HP
 Omnibook X14 device tree
To: jens.glathe@oldschoolsolutions.biz, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250709-hp-x14-x1p-v6-0-f45cc186a62d@oldschoolsolutions.biz>
 <ikWa9Ih3mm9syAlXHTPoLiEwAKXm-3TOHfErQcGGx8GwtsYean4OqEnm_gHgnAJZyejUXUY8uxRamsl7EkeY4w==@protonmail.internalid>
 <20250709-hp-x14-x1p-v6-2-f45cc186a62d@oldschoolsolutions.biz>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250709-hp-x14-x1p-v6-2-f45cc186a62d@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/07/2025 20:26, Jens Glathe via B4 Relay wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> Commonalize the HP Omnibook X14 device tree for derivation of Hamoa (x1e*/x1p6*)
> and Purwa (x1p4*/x1*) variants. Required because the device trees are not
> compatible.
> 
Commonalize is not a word, "commonize" isn't really a word either.

Any of -> "aggregate", "unify", "integrate" would do.

---
bod

