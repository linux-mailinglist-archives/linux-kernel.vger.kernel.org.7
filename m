Return-Path: <linux-kernel+bounces-733215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7A3B071A5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C402D177821
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAB02F2344;
	Wed, 16 Jul 2025 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrHThjfg"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4462EF646
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658134; cv=none; b=Fl7XdHkm4DX07cZnew3yoWgoWJIc5skbU41tBZuz2ZDBcWJs6/fQu7KvmmpdSnurZQ+YrihLEfA3cKtAtgNtS2v0UZIJBWJjMIaBCBiHLUDrJ8Jf1Q7v8tUuf+gg9/DeO+kCRbr9V9DWz8V62MUO+x8ATdoqIi38WLBln+AcR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658134; c=relaxed/simple;
	bh=NCkP6yoCyLaOCvE5S2DmDKGtHd6haaVn/d7UWFUaoO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2LMq7qtQUR79ed8ej4R76nhOqqE8vuTv286AYgmUzxjUFie/dzO6Dq5Iw6wUYseDS5K0N95NSQik1OPgytFsCR0hLun+seL2xZj3EuZmjkl+n8U0MUShwUdUyWBb8MMDPKReozmkoxv1JNvfDLaf8c1adZ9NAieFkuqWxX0ScE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BrHThjfg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae3a4a773e1so101274766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752658131; x=1753262931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2+qxW1re6yvLk1X4gDMz7zxFCiH3GRYXCvI3tRZnObA=;
        b=BrHThjfgrBJsOBKz/nTyBiqmnzjMRj/xff2C2YjHsqODdv99Aal9+P2yoSKmd4xsAL
         83DeH/u08B168gfo4n7YkwO9MB2HDnNr+jvzv+nkheyBAIJAb9hRtP6qgKn06rT/4S9Q
         j+WuFVEvLvdiH+tVuqd+RTjeGP06IQeWAPus2Hbe1e+ajYouRP3YeJWPjGSambafSJvF
         PaEEng/eFDw3Re32k3hJAim9+2Y89wY6cEZd041dDf0ny8w9sO1wJbkhh+lqpu1qj5LO
         759754i1Qin2qFu/grQXmIo9KRIUP6o2VjpnUJEu4eN+Y0BF3IiMEQtwiCUOc3cSPvZz
         ZILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752658131; x=1753262931;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+qxW1re6yvLk1X4gDMz7zxFCiH3GRYXCvI3tRZnObA=;
        b=J581XtotEYny0RmGr00Mpu2W0HjzGg4E7fxp4AUqC5pB3w96wALTVRtQXf56DyNBFD
         nV0KoZSs+wJd5qMBOA8j0RhkWtq1Hw9yc7RR0i8yxsqXsUGl7Vm+cw/mjFreFrMDvu1S
         6jg+MZygT6QLL41uWdDmKiPxLZ9nOWJDykUDyocmhYIvGl0gqrOlc78WTToIWnMw5OVn
         Q+DKku6k/dXZlpfIUrkTfzZEPilfrnrzBS3SoD+NXNxL9A7w4IVlYhj7TPBnSjJidTgk
         NtYtMvoykrxlQ5ppNmkCbZ/PCDqCMVqaGewTRFMCXGfpzOwLuExQaW6UuQKDGpvmJ7c8
         aU6w==
X-Forwarded-Encrypted: i=1; AJvYcCXUdAbfXL/IghUqRVc6Y6o9gFL6Bpw3ymyERFE69hM9iwnegJlHi2OE6e+iZ914y+C2ggtQKRe6e7I2U7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy52lilRoYlJI91gO+7qyZXqSXZyOywOExpyBOVtp5l/Pva7dJK
	uiaJ5TwSlbRS6ftoqWqEx36GGKndVR8LItFNMAMJUxn1Yg7vOmd5YBXYvKRf/MVlDGU=
X-Gm-Gg: ASbGnctjgnsAfOy/GhJvWp6X5Bn+U6xPR//BcOebW7LXGWsyvzfacpIgoqPzpUWcfA0
	G3U81q7lG4FbaTxs09pGpnrnMAxBsmfSISF8/QMGWn/2JeS0qePnJV1YmmFF8Tj4qb73iyvObED
	LdvNwR2fAezntKMHzLWbPO+BXHVLbK28y/XY3S5Z98mrTWoDnRSrLFLz3bkC+EmgvcCXF87oSLk
	TpQok/AXoZIhXK+XSS503pe1HyycgH1m+jU4sbQA1/B7cFV5y6JHI9l7GZups2NNFs3ue6ve1WJ
	JHTWOvfYHkGZLT1oRZynea/YdaDkpqx5OOLJwd9SjNrpo+nOMxXi5b4OdoOEnEJAobo679pNl80
	8t4b8VJ1hPIjFseNbn8K4Pys0mfN3uqTjC6divE++GA==
X-Google-Smtp-Source: AGHT+IGlIMXkItAaY/OzwYeDTLiEVh96gQhVFE/zkYpq8e+AFXOVR0zsqmJ1KwqIO8MEqpD4mEx42Q==
X-Received: by 2002:a17:907:c0e:b0:ae0:cff8:5717 with SMTP id a640c23a62f3a-ae9c99c9c1emr91082566b.4.1752658130473;
        Wed, 16 Jul 2025 02:28:50 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee4652sm1176638566b.53.2025.07.16.02.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 02:28:49 -0700 (PDT)
Message-ID: <d4c39f2c-9f95-4e65-87a3-78173b39adf1@linaro.org>
Date: Wed, 16 Jul 2025 11:28:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] media: iris: Add support for SM8750 (VPU v3.5)
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250714-sm8750-iris-v1-0-3006293a5bc7@linaro.org>
 <20250714-sm8750-iris-v1-3-3006293a5bc7@linaro.org>
 <7b0a984f-b62a-ac4d-74bf-a6e839c59272@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCaBdQXwUJFpZbKgAKCRAbk0N9O0Fim07TD/92Vcmzn/jaEBcq
 yT48ODfDIQVvg2nIDW+qbHtJ8DOT0d/qVbBTU7oBuo0xuHo+MTBp0pSTWbThLsSN1AuyP8wF
 KChC0JPcwOZZRS0dl3lFgg+c+rdZUHjsa247r+7fvm2zGG1/u+33lBJgnAIH5lSCjhP4VXiG
 q5ngCxGRuBq+0jNCKyAOC/vq2cS/dgdXwmf2aL8G7QVREX7mSl0x+CjWyrpFc1D/9NV/zIWB
 G1NR1fFb+oeOVhRGubYfiS62htUQjGLK7qbTmrd715kH9Noww1U5HH7WQzePt/SvC0RhQXNj
 XKBB+lwwM+XulFigmMF1KybRm7MNoLBrGDa3yGpAkHMkJ7NM4iSMdSxYAr60RtThnhKc2kLI
 zd8GqyBh0nGPIL+1ZVMBDXw1Eu0/Du0rWt1zAKXQYVAfBLCTmkOnPU0fjR7qVT41xdJ6KqQM
 NGQeV+0o9X91X6VBeK6Na3zt5y4eWkve65DRlk1aoeBmhAteioLZlXkqu0pZv+PKIVf+zFKu
 h0At/TN/618e/QVlZPbMeNSp3S3ieMP9Q6y4gw5CfgiDRJ2K9g99m6Rvlx1qwom6QbU06ltb
 vJE2K9oKd9nPp1NrBfBdEhX8oOwdCLJXEq83vdtOEqE42RxfYta4P3by0BHpcwzYbmi/Et7T
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <7b0a984f-b62a-ac4d-74bf-a6e839c59272@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/07/2025 11:10, Dikshita Agarwal wrote:
> 
> 
> On 7/14/2025 7:11 PM, Krzysztof Kozlowski wrote:
>> Add support for SM8750 Iris codec with major differences against
>> previous generation SM8650:
>>
>> 1. New clocks and new resets, thus new power up and power down
>>    sequences,
>>
>> 2. New WRAPPER_IRIS_VCODEC_VPU_WRAPPER_SPARE_0 register programmed
>>    during boot-up
>>



Please kindly trim the replies from unnecessary context. It makes it
much easier to find new content.


>> +struct iris_platform_data sm8750_data = {
>> +	.get_instance = iris_hfi_gen2_get_instance,
>> +	.init_hfi_command_ops = iris_hfi_gen2_command_ops_init,
>> +	.init_hfi_response_ops = iris_hfi_gen2_response_ops_init,
>> +	.vpu_ops = &iris_vpu35_ops,
>> +	.set_preset_registers = iris_set_sm8550_preset_registers,
>> +	.icc_tbl = sm8550_icc_table,
>> +	.icc_tbl_size = ARRAY_SIZE(sm8550_icc_table),
>> +	.clk_rst_tbl = sm8750_clk_reset_table,
>> +	.clk_rst_tbl_size = ARRAY_SIZE(sm8750_clk_reset_table),
>> +	.bw_tbl_dec = sm8550_bw_table_dec,
>> +	.bw_tbl_dec_size = ARRAY_SIZE(sm8550_bw_table_dec),
>> +	.pmdomain_tbl = sm8550_pmdomain_table,
>> +	.pmdomain_tbl_size = ARRAY_SIZE(sm8550_pmdomain_table),
>> +	.opp_pd_tbl = sm8550_opp_pd_table,
>> +	.opp_pd_tbl_size = ARRAY_SIZE(sm8550_opp_pd_table),
>> +	.clk_tbl = sm8750_clk_table,
>> +	.clk_tbl_size = ARRAY_SIZE(sm8750_clk_table),
>> +	/* Upper bound of DMA address range */
>> +	.dma_mask = 0xe0000000 - 1,
>> +	.fwname = "qcom/vpu/vpu35_4v.mbn",
> Could you clarify where this firmware has been merged? Also, it appears
> that the naming convention hasn't been followed.


I mentioned in the DTS patchset but not here, so I will add it in the
cover letter - firmware is not released. About the name I cannot
comment, that's the name I got from qcom. Happy to use whatever name you
prefer.



>> +static int iris_vpu35_power_on_hw(struct iris_core *core)
>> +{
>> +	int ret;
>> +	u32 val;
>> +
>> +	ret = iris_enable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Switch GDSC to SW control */
>> +	writel(0x0, core->reg_base + WRAPPER_CORE_POWER_CONTROL);
> GDSCs have been transitioned from HW_CTRL to HW_CTRL_TRIGGER, placing them
> under software control by default, what is the need of doing this?
>> +	ret = readl_poll_timeout(core->reg_base + WRAPPER_CORE_POWER_STATUS,
>> +				 val, val & BIT(1), 200, 2000);


The need comes from differences between this and previous generation,
mostly based on downstream sources. I think the hardware just did not
boot up without it.

You need to fix your email client to add line breaks around your
replies, because it is very difficult to spot them. It's close to
impossible...


>> +	if (ret)
>> +		goto err_disable_power;
>> +
>> +	ret = iris_prepare_enable_clock(core, IRIS_AXI_CLK);
>> +	if (ret)
>> +		goto err_gdsc;
>> +
>> +	ret = iris_prepare_enable_clock(core, IRIS_HW_FREERUN_CLK);
>> +	if (ret)
>> +		goto err_disable_axi_clk;
>> +
>> +	ret = iris_prepare_enable_clock(core, IRIS_HW_CLK);
>> +	if (ret)
>> +		goto err_disable_hw_free_clk;
>> +
>> +	ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], true);
>> +	if (ret)
>> +		goto err_disable_hw_clk;
>> +
>> +	return 0;
>> +
>> +err_disable_hw_clk:
>> +	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
>> +err_disable_hw_free_clk:
>> +	iris_disable_unprepare_clock(core, IRIS_HW_FREERUN_CLK);
>> +err_disable_axi_clk:
>> +	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
>> +err_gdsc:
>> +	writel(BIT(0), core->reg_base + WRAPPER_CORE_POWER_CONTROL);
>> +err_disable_power:
>> +	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
>> +
>> +	return ret;
>> +}
>> +
>> +static void iris_vpu35_power_off_hw(struct iris_core *core)
>> +{
>> +	u32 val = 0, value, i;
>> +	int ret;
>> +
>> +	if (iris_vpu3x_hw_power_collapsed(core))
>> +		goto disable_power;
>> +
>> +	value = readl(core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
>> +	if (value)
>> +		writel(CORE_CLK_RUN, core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
>> +
>> +	for (i = 0; i < core->iris_platform_data->num_vpp_pipe; i++) {
>> +		ret = readl_poll_timeout(core->reg_base + VCODEC_SS_IDLE_STATUSN + 4 * i,
>> +					 val, val & 0x400000, 2000, 20000);
>> +		if (ret)
>> +			goto disable_power;
>> +	}
>> +
>> +	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS,
>> +				 val, val & BIT(0), 200, 2000);
> what are you polling here for?


This is not different than existing code. I don't understand why you are
commenting on something which is already there.

>> +	if (ret)
>> +		goto disable_power;
>> +
>> +	/* set MNoC to low power, set PD_NOC_QREQ (bit 0) */
> Could you share the reference for this sqeunece, this looks half-cooked.
> Would recommend following Hardware programmin guide(HPG) for this.


Why? Look at existing code. It's the same.

I think I responded to all your comments - it barely possible to spot
them in the quote.

Best regards,
Krzysztof

