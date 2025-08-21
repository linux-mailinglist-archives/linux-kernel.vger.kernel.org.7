Return-Path: <linux-kernel+bounces-779203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F73B2F06F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E5B5C540E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D5F2EA75D;
	Thu, 21 Aug 2025 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lPXpavYv"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54982EA165
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763287; cv=none; b=MQpax84sFb4LBRHWo8dhf4hmRZJSM3gWUIVGqlCdCADHe9HoWshexsEI9uFgAC8XjdqshYjHO9/OlhX4YSSIQo7RjnSoXrGl81Hod4XWLCnysU5qvt5102vftBXSrV0kGDSjXRZgDd0RjxQMCXazIkQ8m5XYkRQRr/lvlahbmZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763287; c=relaxed/simple;
	bh=oZLJpaFA1XQqrArXlzUBWsQNthOhGI0qtYmaSRqQPTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXaoYgeLVfnbIgKcuE6pwPGYTkd5B3gfjN5+brn9Kf2Be26Iqw392/Q6i9H6MxoQu7e/S5BDDBikMKcHTnqfubLTXP8jumQWk0smnuj+CmP0JbZrDeOmNUeSVWyIgNVyTBuHJ1zwnG7oaC3XuMCfyTHDZJPrvIZ+89k7BCT4qro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lPXpavYv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b00797dso4818905e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755763284; x=1756368084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iNGT98klqSv2rZl0EJTYaB+wlY9yv0npHx6OP4ljkeY=;
        b=lPXpavYvHhVKV9hUtYe8IH3KqW1LI6mGgoofrXSLMjgtFK2hhEuX2V589fF4UFaS/d
         lLyu7i/mkUkhWlGL62hoqhdA6/WNDkruw1OBGLY4CPEfLaMaWSEgKkjXwgOZSApn7+b4
         sTwwe64yXZPLXsQ0kIjjIzlbEGXEtMIsIBYgzXczpmFuTH18LVrAHgHWfjl+RCEo5+WU
         eykx/hedcZUAZVx4RdMEmhcbyns/CHatxJgarQARMYAxzRKnO2SWCUmqJtCijOxuqhKQ
         sMR7gUYQUMtD7DUdZ17dIYYq7g89zaROF9callkTBZ9znyulHElpY7HLVyOX4C/i+r7T
         3RFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755763284; x=1756368084;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNGT98klqSv2rZl0EJTYaB+wlY9yv0npHx6OP4ljkeY=;
        b=UX/6hVCdD9/sNJc9/Zi+MF640KlYjNS35dNJaDvheONUO8pnQwix/nuKU2XLjtZp2r
         hdD+M1Dv8OwXqKtanIGfCua9rrHUM4CpjBrcBX32MnTi7LPClIlGDaV0d1Lgv8P4co3Y
         bxRpe6xWAqwlcZMWblb1XCudGV4jYinyYbMupgys2g9YXRI29qb6FAVz+/pmBtGivL7a
         DIAqiZE0cvscJPgCk2JPHZlt2hJ6zTFAImGu5gDsJDW236/FayM3bfoU0Kv/Av6K31Jx
         h6SGlS2TsfIZLQAKaomR/HhQ0tudEN8a7/S7hm5KEAv0FPrJ/PjvocSo7Yb4vzivC1H2
         R8kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVYKHjcfMwVNsSoFt23/w6CKEPy82V054UsGIf7m0nSnS/IZueofCHHG0Td6bSvGYLegEJFZGIj/TXqqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ssLZHkuIrplFRVZ3M5iwEQ4nVUmMYKt/T4n6vPsyIzJpuS8V
	TN5XD5hw8NB9JA/9OBuJI35bFpXg2cHITjoH5jkV5HIRqYa6cIgURf5XfUi05bWEoYs=
X-Gm-Gg: ASbGncvjE5HsCP81Aw8X32m4QKV+aCunN+NWKZql8+UDGHv17QRfiyW+Dqb1ahobQQA
	hIITLaLYDH1ZScdyptUhmHyTFJqP82nHGHaxEDbKrNi1ti/xwxVlkb53GD5PgPNLj6ymosMaMPx
	ZlgUzumt11/txfzIjpZM3hPWOjVQbzKsCj/dDOU97sjErIwIhI2Qav6PyjvOkH15fTOX5vLuiHD
	P9vbzWPTEekfzVbsglmdH6ZJ5bKi/4eOvrByjJaD0yddcngkaT+jIQG7MmbU79wBU867QJMsVEp
	P7GN7KZ8Sos8Pc8hYqYMM8z2/R0Spz+VeMql4KDjL5fT02GQaB52Gu+q0k/RQDGZ9LZbtGs3u8h
	VZE9PcJQ3Pg3LD092BBCbI91fXtn4ppuVIIZpNvJy7Jpwpv+wbx2Bav866F1UZTw=
X-Google-Smtp-Source: AGHT+IHCjFPjgsVt7tr3xezlGae2i3luW4j7fhzwL2N2wuLceLA5EUcPHt7ylepsbKjsUGTs+yYXqg==
X-Received: by 2002:a05:600c:45d4:b0:459:da76:d7aa with SMTP id 5b1f17b1804b1-45b4d84ff9fmr10651545e9.25.1755763284010;
        Thu, 21 Aug 2025 01:01:24 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4dba004bsm17558505e9.24.2025.08.21.01.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 01:01:23 -0700 (PDT)
Message-ID: <8f337afc-32aa-47cc-afb5-7d5785d3e377@linaro.org>
Date: Thu, 21 Aug 2025 09:01:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: venus: firmware: Use correct reset sequence for
 IRIS2
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250820-venus-iris2-no-tz-v1-1-9ebcc343195a@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250820-venus-iris2-no-tz-v1-1-9ebcc343195a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2025 16:16, Stephan Gerhold wrote:
> When starting venus with the "no_tz" code path, IRIS2 needs the same
> boot/reset sequence as IRIS2_1. This is because most of the registers were
> moved to the "wrapper_tz_base", which is already defined for both IRIS2 and
> IRIS2_1 inside core.c. Add IRIS2 to the checks inside firmware.c as well to
> make sure that it uses the correct reset sequence.
> 
> Both IRIS and IRIS2_1 are HFI v6 variants, so the correct sequence was used
> before commit c38610f8981e ("media: venus: firmware: Sanitize
> per-VPU-version").
> 
> Fixes: c38610f8981e ("media: venus: firmware: Sanitize per-VPU-version")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/firmware.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 66a18830e66dac2acbe11751a8c250876e20d795..4e2636b0536693a86dc51503d01dc2bca40b532a 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -30,7 +30,7 @@ static void venus_reset_cpu(struct venus_core *core)
>   	u32 fw_size = core->fw.mapped_mem_size;
>   	void __iomem *wrapper_base;
>   
> -	if (IS_IRIS2_1(core))
> +	if (IS_IRIS2(core) || IS_IRIS2_1(core))
>   		wrapper_base = core->wrapper_tz_base;
>   	else
>   		wrapper_base = core->wrapper_base;
> @@ -42,7 +42,7 @@ static void venus_reset_cpu(struct venus_core *core)
>   	writel(fw_size, wrapper_base + WRAPPER_NONPIX_START_ADDR);
>   	writel(fw_size, wrapper_base + WRAPPER_NONPIX_END_ADDR);
>   
> -	if (IS_IRIS2_1(core)) {
> +	if (IS_IRIS2(core) || IS_IRIS2_1(core)) {
>   		/* Bring XTSS out of reset */
>   		writel(0, wrapper_base + WRAPPER_TZ_XTSS_SW_RESET);
>   	} else {
> @@ -68,7 +68,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>   	if (resume) {
>   		venus_reset_cpu(core);
>   	} else {
> -		if (IS_IRIS2_1(core))
> +		if (IS_IRIS2(core) || IS_IRIS2_1(core))
>   			writel(WRAPPER_XTSS_SW_RESET_BIT,
>   			       core->wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
>   		else
> @@ -181,7 +181,7 @@ static int venus_shutdown_no_tz(struct venus_core *core)
>   	void __iomem *wrapper_base = core->wrapper_base;
>   	void __iomem *wrapper_tz_base = core->wrapper_tz_base;
>   
> -	if (IS_IRIS2_1(core)) {
> +	if (IS_IRIS2(core) || IS_IRIS2_1(core)) {
>   		/* Assert the reset to XTSS */
>   		reg = readl(wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
>   		reg |= WRAPPER_XTSS_SW_RESET_BIT;
> 
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250815-venus-iris2-no-tz-f9b52f33c4d0
> 
> Best regards,
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

