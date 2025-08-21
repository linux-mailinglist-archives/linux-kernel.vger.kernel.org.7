Return-Path: <linux-kernel+bounces-779199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84046B2F053
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66D6A7A2AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C11F2E9ED0;
	Thu, 21 Aug 2025 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gd1NkhYU"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EE02E9EC7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763235; cv=none; b=I96TxZ8huSrTFV4z0+VG00wBhIX1uiEILYuk1kmjyvp2MXGQyfe97dDY8yZvSsa0yqEKxgxoBhrA4A3Y5C9E9PonF77B+574QB7Sf5Aphid4YX7uPfuhuGng9prO7ivvhM2EleZOYbBC/CczQ5XDN9oSY1KuATQ5ZnCAPRRrulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763235; c=relaxed/simple;
	bh=nSdFX6YFiyQhA1sMkUP24ByKKzkW03EQP5slt9hoFcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxnWNSo7RygzmT5ZtR6QUi9RiuKA2wjk8lYts+c1HSC7lnuOh6DkJb7UaoQBZnu2ImGjlTA00WpVbnuQzaeLnieHYC7CAigMXH2qBon5mAUyvUveTX2IjprlCnc6RkHE+U8kypQeVvmCPvMuvN7LqB6kXWp3KCSta93Mr+9J0sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gd1NkhYU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9edf504e6so460390f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755763232; x=1756368032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k4CZogp1YICkFW9UCwIu4Zro2p9ruYldDB1qCwvtg0I=;
        b=Gd1NkhYUBfQwfUD8TZb9oSdAWpAYuflXMXItstJrNGoypTRMYeUhF75PozduoYWqsa
         paL1eYVkC1Brjnqar3K9mNro6inOd4EqrKXgIQBF8czynhSw7IrTLhb55i1oFlXUKtku
         0G72HJiRyb/zof+VPXn1jY6e/OmHZ2R0b1G1iVYkMbEZV3NOxv3bEC2fQYFVTlUPcxal
         Juygx3u3sp3U5dwcL1gJO6FK++nev6NYivgV5L7nxcwJpQWeLigQctFoe6p1SIs61FDn
         LNCkWsuRPSJeNawA5lWAMdvvObFttVYiGAXu82fkcQ1TfQyqmjWMT4tI3E1oRIP46WNM
         x+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755763232; x=1756368032;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4CZogp1YICkFW9UCwIu4Zro2p9ruYldDB1qCwvtg0I=;
        b=hPx2oM4MSxpywRQCqGO0CpWz6Gxswuauu49QFtb3qdNEWL7YE/m2uJqYElebUg0NkA
         DEAf5Xi7EGORYOzRCjTcN4KDy4v4Gb99HhJNi471r81nDX1OIJCEygWireA/CHAHSznW
         tyYTYD/Z7ZdDnXZXe2J0d5a4BsqvoC9FiiS5NiecvD2ZhByKLQqB1fj2cvcozhm9gev/
         4Ur0FDhm5YKXhRzLrXnwRBTZg7ZohoILywOKNaqAL7cFajhirWGqIn0wW0d4iRym2MmB
         yLDOqE061kN3qGTXmN1QMeCdBZqJTSgji9kEQ52Kjkn5DLEW6zcdIOeR1anMhYYw1z9v
         eK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlIlJ5hbFKZsD4Da9EbQavbk1HPY61FioiNQov9E1vco27ZD1ASjZHymyG3fI6xMO9Qwi//CVyUeKXVhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5hXdXDJgHub7+ONQ8iVXag0eTqw/72hUUO1Dptng/YdbmN3p4
	4uOa3pEpWHXTaziw7tea1iZWCAFlBauP/5TMaRaezfogdIZG6YXX5PvPUG3kqnWeP5I=
X-Gm-Gg: ASbGncuJDyWG5zGGyb5x4E6NXUUB8K0C8eJEMBNfE+/PIfRG2J6ExQ+v9gVeGJsC4HJ
	JCYvSNgtFgJ/hnD7q8km2ZwScXf/Orm/nU9tWpao0ZdfYLkFnS5yt8p2c49BL+O80PY2uWAOmrJ
	RUTtkYOHLUMZcDVlnW3BOzaxwdlXOV2qVa9vHTObne2A5936yh646TfBP3YE5loS1uO6Hjcwq5n
	MIRzuJTsewrZkXHTwi7Q7Ms8QBukfGFv1aM8pymuGVlphnpERtw9Z5PkH7bwMvKbvHXGh3f50+k
	CKro6522n6D6YpO9hTDFqLDkd6Hg99EHQWORyFnywGUBX/jm/KmtTBG9r9nLJJgTVnVZWVxEx12
	weTRkmZfjW/MX8iTDyKjdtzux/Z5i2eWISI9oh4oTrXENIVAxIu7NDUtXAswToms=
X-Google-Smtp-Source: AGHT+IH6Fqdcvjum39HyYWBDMdga7HLUho0U+lPcQsWM3iSqd4stDmY2DPoOefkvyeKyeOFswOcWHA==
X-Received: by 2002:a05:6000:26cb:b0:3b9:1684:e10 with SMTP id ffacd0b85a97d-3c49549d218mr1161419f8f.23.1755763232064;
        Thu, 21 Aug 2025 01:00:32 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db41103sm16897695e9.15.2025.08.21.01.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 01:00:31 -0700 (PDT)
Message-ID: <2a6f2c48-1a05-460e-951b-417fb617e737@linaro.org>
Date: Thu, 21 Aug 2025 09:00:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: iris: fix module removal if firmware download
 failed
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250820-topic-sm8x50-iris-remove-fix-v1-1-07b23a0bd8fc@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250820-topic-sm8x50-iris-remove-fix-v1-1-07b23a0bd8fc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2025 18:06, Neil Armstrong wrote:
> Fix remove if firmware failed to load:
> qcom-iris aa00000.video-codec: Direct firmware load for qcom/vpu/vpu33_p4.mbn failed with error -2
> qcom-iris aa00000.video-codec: firmware download failed
> qcom-iris aa00000.video-codec: core init failed
> 
> then:
> $ echo aa00000.video-codec > /sys/bus/platform/drivers/qcom-iris/unbind
> 
> Triggers:
> genpd genpd:1:aa00000.video-codec: Runtime PM usage count underflow!
> ------------[ cut here ]------------
> video_cc_mvs0_clk already disabled
> WARNING: drivers/clk/clk.c:1206 at clk_core_disable+0xa4/0xac, CPU#1: sh/542
> <snip>
> pc : clk_core_disable+0xa4/0xac
> lr : clk_core_disable+0xa4/0xac
> <snip>
> Call trace:
>   clk_core_disable+0xa4/0xac (P)
>   clk_disable+0x30/0x4c
>   iris_disable_unprepare_clock+0x20/0x48 [qcom_iris]
>   iris_vpu_power_off_hw+0x48/0x58 [qcom_iris]
>   iris_vpu33_power_off_hardware+0x44/0x230 [qcom_iris]
>   iris_vpu_power_off+0x34/0x84 [qcom_iris]
>   iris_core_deinit+0x44/0xc8 [qcom_iris]
>   iris_remove+0x20/0x48 [qcom_iris]
>   platform_remove+0x20/0x30
>   device_remove+0x4c/0x80
> <snip>
> ---[ end trace 0000000000000000 ]---
> ------------[ cut here ]------------
> video_cc_mvs0_clk already unprepared
> WARNING: drivers/clk/clk.c:1065 at clk_core_unprepare+0xf0/0x110, CPU#2: sh/542
> <snip>
> pc : clk_core_unprepare+0xf0/0x110
> lr : clk_core_unprepare+0xf0/0x110
> <snip>
> Call trace:
>   clk_core_unprepare+0xf0/0x110 (P)
>   clk_unprepare+0x2c/0x44
>   iris_disable_unprepare_clock+0x28/0x48 [qcom_iris]
>   iris_vpu_power_off_hw+0x48/0x58 [qcom_iris]
>   iris_vpu33_power_off_hardware+0x44/0x230 [qcom_iris]
>   iris_vpu_power_off+0x34/0x84 [qcom_iris]
>   iris_core_deinit+0x44/0xc8 [qcom_iris]
>   iris_remove+0x20/0x48 [qcom_iris]
>   platform_remove+0x20/0x30
>   device_remove+0x4c/0x80
> <snip>
> ---[ end trace 0000000000000000 ]---
> genpd genpd:0:aa00000.video-codec: Runtime PM usage count underflow!
> ------------[ cut here ]------------
> gcc_video_axi0_clk already disabled
> WARNING: drivers/clk/clk.c:1206 at clk_core_disable+0xa4/0xac, CPU#4: sh/542
> <snip>
> pc : clk_core_disable+0xa4/0xac
> lr : clk_core_disable+0xa4/0xac
> <snip>
> Call trace:
>   clk_core_disable+0xa4/0xac (P)
>   clk_disable+0x30/0x4c
>   iris_disable_unprepare_clock+0x20/0x48 [qcom_iris]
>   iris_vpu33_power_off_controller+0x17c/0x428 [qcom_iris]
>   iris_vpu_power_off+0x48/0x84 [qcom_iris]
>   iris_core_deinit+0x44/0xc8 [qcom_iris]
>   iris_remove+0x20/0x48 [qcom_iris]
>   platform_remove+0x20/0x30
>   device_remove+0x4c/0x80
> <snip>
> ------------[ cut here ]------------
> gcc_video_axi0_clk already unprepared
> WARNING: drivers/clk/clk.c:1065 at clk_core_unprepare+0xf0/0x110, CPU#4: sh/542
> <snip>
> pc : clk_core_unprepare+0xf0/0x110
> lr : clk_core_unprepare+0xf0/0x110
> <snip>
> Call trace:
>   clk_core_unprepare+0xf0/0x110 (P)
>   clk_unprepare+0x2c/0x44
>   iris_disable_unprepare_clock+0x28/0x48 [qcom_iris]
>   iris_vpu33_power_off_controller+0x17c/0x428 [qcom_iris]
>   iris_vpu_power_off+0x48/0x84 [qcom_iris]
>   iris_core_deinit+0x44/0xc8 [qcom_iris]
>   iris_remove+0x20/0x48 [qcom_iris]
>   platform_remove+0x20/0x30
>   device_remove+0x4c/0x80
> <snip>
> ---[ end trace 0000000000000000 ]---
> 
> Skip deinit if initialization never succeeded.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/media/platform/qcom/iris/iris_core.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_core.c b/drivers/media/platform/qcom/iris/iris_core.c
> index 0fa0a3b549a23877af57c9950a5892e821b9473a..8406c48d635b6eba0879396ce9f9ae2292743f09 100644
> --- a/drivers/media/platform/qcom/iris/iris_core.c
> +++ b/drivers/media/platform/qcom/iris/iris_core.c
> @@ -15,10 +15,12 @@ void iris_core_deinit(struct iris_core *core)
>   	pm_runtime_resume_and_get(core->dev);
>   
>   	mutex_lock(&core->lock);
> -	iris_fw_unload(core);
> -	iris_vpu_power_off(core);
> -	iris_hfi_queues_deinit(core);
> -	core->state = IRIS_CORE_DEINIT;
> +	if (core->state != IRIS_CORE_DEINIT) {
> +		iris_fw_unload(core);
> +		iris_vpu_power_off(core);
> +		iris_hfi_queues_deinit(core);
> +		core->state = IRIS_CORE_DEINIT;
> +	}
>   	mutex_unlock(&core->lock);
>   
>   	pm_runtime_put_sync(core->dev);
> 
> ---
> base-commit: 5303936d609e09665deda94eaedf26a0e5c3a087
> change-id: 20250820-topic-sm8x50-iris-remove-fix-76f86621d6ac
> 
> Best regards,

missing a fixes tag, once included please add

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

