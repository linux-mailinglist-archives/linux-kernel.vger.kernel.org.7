Return-Path: <linux-kernel+bounces-600137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF37A85C48
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 13:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7473B4539
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 11:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DF326AD9;
	Fri, 11 Apr 2025 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DJJeqFET"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9DE298CBF
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744372333; cv=none; b=mDCkgn7TclpshM6VCXd8kh+/Pd7/dfsiFhZk59Tb4r9ugXYEPx/lSgigWMECDagFgIPVAv2NQzofsFRE2iikbcCKIbONo4rhlNDq46b+dG3sCsig2LY19XfHdmUxw57D4gUzM8yaHXmxjs0qYlsJWGcArtiIm239okBqUIBROXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744372333; c=relaxed/simple;
	bh=xl8pYd1ICKUbfI8bR/MoNAxS2Yv5qFYEOJdtbYDx6hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5BUsYfIbQoV268336m0EZ9fiy1QVeoaRx/XkXZFk/lsDJXfBzZyJKS/1+8vIegW7j7cIQ57HyhHnyH2mzQoK1lOhHQI/GxvGmq4CQ5zXBgsf4FXmZq6iZVVTJcm5/pEMcrqjiwT1jvmgnyD+CKHBpPG01RUYvicFJuS5JzV1C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DJJeqFET; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so20047975e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 04:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744372330; x=1744977130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5HVy/7nosTmDrt0FNCHkltOQQArKbp0G/tf2pSSqz3k=;
        b=DJJeqFET+W5ud+joBHyEAp51CWQVCrIUPkDjBV23bi5x9du538YpsU+bUMHe/RiCJf
         Kiqy93IjOZo0j24BZhGC/iY1vnyZmtDOU6YMJ1WQ+MtOuniB+wsCXI8IQW5ZMwMo9mmv
         yUdh1W8aZqDfWlv+dg/KbVgUoutChw15J8H0vEFHtgdKcNu+gpB7F/G7M4ZjbKIf8ZNB
         KEQ78Gc9KxtXGWktBLdcEX8bKfjxGzu+DKPZs2Jl6FwcfNSq89x3v0HzJjAbXRC/6Nfm
         4a/hbXR+4r/WmTyYyecP+SChh1WQeTMT3XiGzIu2+kzvsTgypOs7Hz1Wn3ScleN3wAIb
         qbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744372330; x=1744977130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5HVy/7nosTmDrt0FNCHkltOQQArKbp0G/tf2pSSqz3k=;
        b=mhZhEpa5xpl99gb/vkdhYt/vX1pBsNsGstuUtnXJYy1ut/WaXZu7cz5JKJ2U5dlRCA
         spF/ZsQqIenVBwC1gSkAsUZsnKAu+9J0S7jXJ0HLim3oeqXChUI0e45FeCZrniVfPQKS
         D+A+UO5hJfLl48fkTke6GRy+XGhkl0UobyBhbK45bufgEh9lBSrRCq1TGfSLBV/LLlKg
         xax7/4W3uJhfL1iQOOHz38YRmlOkVD37X9+Q4w8rcvmBzX3sjxwFX+JFwyr+yrnquWN2
         4ZFQmSnINEFiELaPyNW6XvIaF3HYbFGnQF6sLd5ZR6yNO8IlxDY3VroBZHTopTXyl2Ah
         wG1Q==
X-Gm-Message-State: AOJu0YzfL8U7lvfv69rbW3fdjlVxdLm3WL0cyGwZk1XmwU8w/3leMHSS
	1gs0OJJDFiOILyN4k6hxOOfdrswq/oyRqJrnOtUTLxYksZhok/gwTZSG9bKk+/k=
X-Gm-Gg: ASbGnctGGbAOPeTwRwlPpkOACvq5ABKbXGXOeP1c2e+6+uDiaRacDEX5eTBDlLq3aYu
	ysCA2S9IvSfZaOP4uJWQqz27/Mavqudg3u905jPxXIM//UdjysGlqxD/3YCggpD6iac21U71bnB
	d2KEcB6LD7mhkwwl2ndzLxKMy/5GJkdzLxXoF7/4Gtb1TYgRj62vw42vA7/tnhR3/WeYQhpXJ7u
	1DlzYMxb15JEP75eqfm0EJWTE4N70BUAxlXNXaYNw087Q6guCwbIXfFfFM9U8YIlt7Ajc9l/q5i
	GJ2JyiYhVCGXec1jmIkZufZmIZkuhX4ID6NO1xLDtgE6ieMrRh8cK0J6REY4QkthF8hxKznVSfm
	6w4Byzg==
X-Google-Smtp-Source: AGHT+IGzWSil6xEbNUfevW8M1sWzZW1l6nSFBVdrW8vg7rvy79cA0XlcgS4RI4O6ocfdrpULPe2L4w==
X-Received: by 2002:a05:600c:34cc:b0:43d:fa59:bcee with SMTP id 5b1f17b1804b1-43f3a9c025fmr19884005e9.33.1744372329911;
        Fri, 11 Apr 2025 04:52:09 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf44577dsm1782251f8f.94.2025.04.11.04.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 04:52:09 -0700 (PDT)
Message-ID: <23cb349e-6fd0-460e-9f11-7f57609be9c6@linaro.org>
Date: Fri, 11 Apr 2025 12:52:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 2/8] media: qcom: iris: move sm8550 to gen2 catalog
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250410-topic-sm8x50-upstream-iris-catalog-v5-0-44a431574c25@linaro.org>
 <3pe2YgIPZDCWHxBWThGQ5xqa-pGXmJC_-sPtFTNKIGg7NoAdMhRl70BzWLZE5B2_zGnnYvimmhqB2Q--OCXwuA==@protonmail.internalid>
 <20250410-topic-sm8x50-upstream-iris-catalog-v5-2-44a431574c25@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250410-topic-sm8x50-upstream-iris-catalog-v5-2-44a431574c25@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/04/2025 17:30, Neil Armstrong wrote:
> Re-organize the platform support core into a gen2 catalog C file
> declaring common platform structure and include platform headers
> containing platform specific entries and iris_platform_data
> structure.
> 
> The goal is to share most of the structure while having
> clear and separate per-SoC catalog files.
> 
> The organization is based on the current drm/msm dpu1 catalog
> entries.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Same comment on alphanumeric sort and header __PREFIXES__ fixup then

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

