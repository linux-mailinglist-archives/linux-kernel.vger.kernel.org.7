Return-Path: <linux-kernel+bounces-794151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC69B3DD8F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA6517901B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5DA30146E;
	Mon,  1 Sep 2025 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LMG/FE5B"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95432FFDDB
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717482; cv=none; b=UWc2Lms/D/So+oKkilbrYUCFjkKYjUQHMzVOssBZeUpi2UPDERFQBr2U22+mqJ3gPNleO58ULC65HMlbLbFtkwxadRfDBD5PZo2zcPuyV9aGDYzK3xP1Rbgv3nUaHyccdq7LdS601+sgXFtKVEKRFt6RjJawXPlexVC8Y9Xu1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717482; c=relaxed/simple;
	bh=ylfMvwdHcWV67FG167GMSdGd2pzSjGgujwNJPJyPlGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGcWUhf/zfjpqwr0WdzaLFlJWQGML+MdP8q45d0pKLI11tE7tUEwXGduIP1CjJBnExQNUQuWZfRyqXdUpHCGuCUvLlSCzVkboYq2z3eFum2XKclw0eo50bARI5ywk9FNWrRpVo/z713byKjecF7UFf9Vi89KxnLULG5LCbNXRbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LMG/FE5B; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3cef6debedcso1724579f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756717479; x=1757322279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwVv68lybtG/3lTbSeRMLSCB2s0eqf0axoIfKgt8qqM=;
        b=LMG/FE5BJKm93DBOnVGlJFPT1lQt94MTpajgNUoh04UkSfYEfuJjgap1E4uZgrPAOc
         7QF3InzlGGE5uxWvcMClzots8u0hG5ahU1Mu8JepZB8mkT+yDZryKY+HuynHDWZAbyJJ
         p459GGXBmi7zkM7E8p5LMn31ma2tgGe8sBxBIIbikGGanhufGqYL4YZR/6DshimcLXez
         XHRWESp+VMi+5NZpywAHuUiLajvuzaVmHWmO1KSTmeafwmA5iW5bNG9snqXk/GESJjjP
         ATgnqOi/TpS68GIdS64kQWcKuFzjCYtw5Ip1KP9hwkwRXHxEl6JnGfi5zikwYfvHz+yv
         dg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756717479; x=1757322279;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwVv68lybtG/3lTbSeRMLSCB2s0eqf0axoIfKgt8qqM=;
        b=f//seHpK/u0MkZlegRLXKjonWBE7npGXa9bnSjF4DAGU2sLnUBGcTYxP7EaHLIIG1s
         0ZuOfrkofgerRdMfdzUJpvyIP3ZDw0dNWlF7knw3NV59D5zExAJ9MyRedjlBpkUp60dl
         QLcs2gmjawg/XCUa6wr6Khe8Bb38s2MSv4HmmjDSZYZ5gA9H/yNSyDDqAv0qJ8HnA/XB
         I9ZfdybpXdo3VcOH58erj9RhHB8Ep1QOe4U2c+gAT8JQdtnygB8oLkIMvizt4QCrDidV
         7TpJYwKf4a6KoFSQzzz/HJA7paeK6YGRS1DMga2YSO4Rps6EsMSmwqmtV+ZnELg6wMg/
         GYvg==
X-Forwarded-Encrypted: i=1; AJvYcCXACkrrrVWa29tR9/8E3zHjSf+34Q/VgTzlZ/ds9vVH4tlEWPkI2oZi7Lyia1AhXzCiAYH7Jym/XEN1hWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxgkBi8CaYrDuVMDdJsdyi1DM4aNRDOgQu4i1bjFvjLH4bOpcn
	6lgJLHYcZyYT3F3CAIedawZdgtL3lTSHE7tXT3eqEHTU1vWYVslY69d6Xaw/dk8FiBM=
X-Gm-Gg: ASbGncvN6taRT9cnFowU2Uxu78mQkPkOyiv9LjZI5URdt5TKJp8X8NYY66qeYenPDQW
	Z8sbWq32b8r3HgJwIBh133S/7RC9vUyzZarfJHrvSjJcF9dqLmSH26POFxysqrvN1fcHPfRaQq5
	m1OlmaFX3/K+zRiwXYFCEjvzlnEOnwC6RUsBorAMYYa77m4ZAox+7WRW+6ZwWzGRb9olIjqVy5W
	/a0OsVM6BNPk/wSdfAY+fEWXXm+13byOm1sGApeIuXyJHNlc5YKAtvuW/HHQIrRdOlT3/33hjOV
	a9KRU0GNONg4V+DB99eyWzlkXSkEPduo0Aqtt3+oMJgRpUhSriiMh7HPBlkRUqCJHSd0w722iqB
	PcC4p8m9VNZ+ZC99kwb0YENRFNt3Ix6GrsRXYUSmoSxOfga0h9ZMzX/r0YWGLPF0BXwvYstKxRy
	tGqTgMR6NER3SDZlqyg941E8V5hpLgcg==
X-Google-Smtp-Source: AGHT+IF5ozFXuC12DhRU7wnhvEb/Eaxn298/3hrvqF72A12C7sUxgS1LCCpfGamLqO+HTku4EuOKTg==
X-Received: by 2002:a05:6000:1ac8:b0:3d1:9202:9e with SMTP id ffacd0b85a97d-3d1de4bb305mr6081112f8f.36.1756717479121;
        Mon, 01 Sep 2025 02:04:39 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e9c41cfsm147188325e9.21.2025.09.01.02.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:04:38 -0700 (PDT)
Message-ID: <498db18b-f6bc-4678-9d70-7741e3025185@linaro.org>
Date: Mon, 1 Sep 2025 10:04:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] media: qcom: camss: Add support for VFE 690
To: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
 cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, quic_svankada@quicinc.com,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250703171938.3606998-1-quic_vikramsa@quicinc.com>
 <20250703171938.3606998-9-quic_vikramsa@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250703171938.3606998-9-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/07/2025 18:19, Vikram Sharma wrote:
> +		!strcmp(clock->name, "camnoc_axi"));

This is causing a regression on other platforms because they define 
camnnoc_axi but not @ the rate of the pixel clock.

In fact its not very obvious why the CAMNOC AXI would want to have a 
pixel clock applied to the interconnect fabric.

The following resolves the regression for me. I can either merge with 
this change or I'll have to drop the VFE690 changes until you come back 
with something else.

➜ deckard@sagittarius-a  ~/Development/qualcomm/qlt-kernel 
git:(aaa8b5ab704f3) ✗ git diff
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c 
b/drivers/media/platform/qcom/camss/camss-vfe.c
index e969de74818f1..1aa0ba5ad8d60 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -913,8 +913,7 @@ static int vfe_match_clock_names(struct vfe_device *vfe,

         return (!strcmp(clock->name, vfe_name) ||
                 !strcmp(clock->name, vfe_lite_name) ||
-               !strcmp(clock->name, "vfe_lite") ||
-               !strcmp(clock->name, "camnoc_axi"));
+               !strcmp(clock->name, "vfe_lite"));

---
bod

