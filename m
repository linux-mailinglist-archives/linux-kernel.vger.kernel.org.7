Return-Path: <linux-kernel+bounces-791220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB4CB3B397
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6563C7A553B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE71525783B;
	Fri, 29 Aug 2025 06:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yYm34lB+"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488BE2AEFD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 06:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756449857; cv=none; b=hNa6T3zSVZS00P9GMGVU9ngmzE2ndIGrP5yxN75xRECGX/0uZtAHtlwMnaRCpdWoPeoFg2hPewO088db5my9OW9/9yhlrEWD5IAFnE4xUmB2dT30k4C0pWnYtb5/BfHJJeDWCHh/4F/XQvoF8S7o5640CWdLYpX5FqQR2/0EeYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756449857; c=relaxed/simple;
	bh=aW/STypnoYS2xy8qzUHRpUVErrScdjOQ9fkzUsRXA+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FaM7sziDn64ihqyM6Qn1Ek+F2I7/uKNc80rsv9k2b7VNzEQrdiwY4IsM75gzGVLcrwN2W0cD8CHrvw01H5Bvbi+Pd6+jUktKoB6bTdV5cBLhkt/ZmM6qmwvsPfwJEnnOLhvxm0OybdmBs5wOMZ6dVbcb5AitzvlmnYNQdN91rPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yYm34lB+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afe8493a5b7so26245766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 23:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756449853; x=1757054653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83BybW7Yt93cu72oVI9pCaitFHTKxmYkB5u+/G4lDRY=;
        b=yYm34lB+tWjBk0Jj/gPrBQkZNwvVZKLmCXCQ9xKw4apVHRdGUqR3acNnS4VWvZYuue
         T589dnbX5DOqClwp63rGuzyqEXoQoM4XfnK0Iq5hAxk8fOvH4VFnXs3Y2AHVMtMwz87O
         gCVuvQSozaifRh7H4SXRc1M4fXvFsuhO2xmelmGYMw/5RQTpja/19h8L/mIuXVajLEy/
         /h4rKYWXZx4PraJpBCUAnvNQNt70Oftc3zwdvUWD3BvCATYKYdrrbuIZeY5qpNDp5k3g
         lNW95Mhxux+bDl8w0FkJYaveLV+TjgxCLub1xap35YhqFmPR57vREu6F3HC3Y3zoOaNg
         NXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756449853; x=1757054653;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83BybW7Yt93cu72oVI9pCaitFHTKxmYkB5u+/G4lDRY=;
        b=kVOasr7X83CeuoFMCCImvRoIf17j/IaWhXcoKSdM6Yl+uFFSLNtOuWFFPbJk+gheu4
         B55/jrmihWashOl7SOJBTMDz7fwYczqN9oyiThTobLgxFBDC48tc8tPo9l4uQGkcG3IO
         AynC8ZPef4qGMBLdkds0pwd5VG3amVzHadjEDpJSAiR9f1wP/JcgAKMl1z/402DX/lS/
         BpsKxFdzQ24M4juiSXsAFLawDS7XbS9VjjyiILVbV3gt6DsFUw5iHSJGwsKR4jASVmCt
         u7HjiX55le74nIRj8RSzn3vmBscC442q8aWdS858jzQ2oEcTFt2kgFqq1LJJpGahmAeF
         3bIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOfoY/Ms43cZlvm31EMCbtoMprwOfeqTJlpdoEj4jvwf4zCc7rWrV4Y5y8XoNVu68phqIDdcLnPqb+xlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG+EWd0C62DMosAhhMFqFHgzYvm36lQy1FuQjhIXsWuXHBWDG3
	2Xemo5UQE3E6v7awVFi9VDWKfmRkMaGdcu1C7Vt4kxx+/2SEKZNE8DRh7TSYXeIzyeo=
X-Gm-Gg: ASbGncuzFpNTZcctFnAcGqnO0GMPMaQgi81paXS8GmfimDBCxP+Jf5TIqVSHZFU+cMW
	vhSmOvhqzxWmvh/UbWYO7sD3UpPR92dShlO1/0hn/h2JCcXPK/jtRG2rYrLa113msqgDWdrrZnR
	D5fPxpeC+WVLuHMtv1c6vB2RaXjRvMuW2eJU3u8tgIlczRaSA54eqOtMENr7DAs9Y7Nh+sxfhPO
	aTKxrynb/j3FW3WfxQPQUhwFRiAooF9LkRRu2IBY+p+IsvXtzjunXK7WD3U4gFa5GLTTiXpj9N0
	MHsizpngeQNBY3/I1oRLJosAix9ISdbq2Tmq/Fty7icsdHYhYeYhqwIvHX1qOJy6FBG0IQPmC8j
	asMfi/ua8jjyIHldvuofoOLU2C20737SC5cBvAkqO8o4=
X-Google-Smtp-Source: AGHT+IFHvJprnlETPQ+XeK9pQw0PrgtskKauEHZYdi65x+37D2xQfXJzG17NhjuMvTbbZsu2fiCaIA==
X-Received: by 2002:a17:907:26c3:b0:af9:3758:a85a with SMTP id a640c23a62f3a-aff0ee81aa2mr13066166b.5.1756449853478;
        Thu, 28 Aug 2025 23:44:13 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7eda86sm139359566b.3.2025.08.28.23.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 23:44:12 -0700 (PDT)
Message-ID: <ba78f528-dd3c-49b6-920a-0c0758946f16@linaro.org>
Date: Fri, 29 Aug 2025 08:44:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: qcom: audioreach: Add support for Speaker
 Protection module
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250821141625.131990-3-krzysztof.kozlowski@linaro.org>
 <2566eea5-a153-42e6-9a43-1c0af5a4c11c@oss.qualcomm.com>
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
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+AhsD
 BQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmgXUEoF
 CRaWdJoACgkQG5NDfTtBYpudig/+Inb3Kjx1B7w2IpPKmpCT20QQQstx14Wi+rh2FcnV6+/9
 tyHtYwdirraBGGerrNY1c14MX0Tsmzqu9NyZ43heQB2uJuQb35rmI4dn1G+ZH0BD7cwR+M9m
 lSV9YlF7z3Ycz2zHjxL1QXBVvwJRyE0sCIoe+0O9AW9Xj8L/dmvmRfDdtRhYVGyU7fze+lsH
 1pXaq9fdef8QsAETCg5q0zxD+VS+OoZFx4ZtFqvzmhCs0eFvM7gNqiyczeVGUciVlO3+1ZUn
 eqQnxTXnqfJHptZTtK05uXGBwxjTHJrlSKnDslhZNkzv4JfTQhmERyx8BPHDkzpuPjfZ5Jp3
 INcYsxgttyeDS4prv+XWlT7DUjIzcKih0tFDoW5/k6OZeFPba5PATHO78rcWFcduN8xB23B4
 WFQAt5jpsP7/ngKQR9drMXfQGcEmqBq+aoVHobwOfEJTErdku05zjFmm1VnD55CzFJvG7Ll9
 OsRfZD/1MKbl0k39NiRuf8IYFOxVCKrMSgnqED1eacLgj3AWnmfPlyB3Xka0FimVu5Q7r1H/
 9CCfHiOjjPsTAjE+Woh+/8Q0IyHzr+2sCe4g9w2tlsMQJhixykXC1KvzqMdUYKuE00CT+wdK
 nXj0hlNnThRfcA9VPYzKlx3W6GLlyB6umd6WBGGKyiOmOcPqUK3GIvnLzfTXR5DOwU0EVUNc
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
In-Reply-To: <2566eea5-a153-42e6-9a43-1c0af5a4c11c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/08/2025 12:39, Srinivas Kandagatla wrote:
>> +static int audioreach_speaker_protection(struct q6apm_graph *graph,
>> +					 struct audioreach_module *module,
>> +					 uint32_t operation_mode)
>> +{
>> +	return audioreach_send_u32_param(graph, module, PARAM_ID_SP_OP_MODE,
>> +					 operation_mode);
>> +}
>> +
>> +
>>  int audioreach_set_media_format(struct q6apm_graph *graph, struct audioreach_module *module,
>>  				struct audioreach_module_config *cfg)
>>  {
>> @@ -1299,6 +1308,10 @@ int audioreach_set_media_format(struct q6apm_graph *graph, struct audioreach_mod
>>  	case MODULE_ID_GAPLESS:
>>  		rc = audioreach_gapless_set_media_format(graph, module, cfg);
>>  		break;
>> +	case MODULE_ID_SPEAKER_PROTECTION:
>> +		rc = audioreach_speaker_protection(graph, module,
>> +						   PARAM_ID_SP_OP_MODE_CALIBRATION);
> 
> Are we leaving this in calibration mode forever? When does the mode change?

That should be a normal mode, thanks for catching this.

> 
>> +		break;
>>  	default:
>>  		rc = 0;
>>  	}
>> diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
>> index 790fba96e34d..0ad566e45e09 100644
>> --- a/sound/soc/qcom/qdsp6/audioreach.h
>> +++ b/sound/soc/qcom/qdsp6/audioreach.h
>> @@ -31,6 +31,7 @@ struct q6apm_graph;
>>  #define MODULE_ID_MP3_DECODE		0x0700103B
>>  #define MODULE_ID_GAPLESS		0x0700104D
>>  #define MODULE_ID_DISPLAY_PORT_SINK	0x07001069
>> +#define MODULE_ID_SPEAKER_PROTECTION	0x070010E2
>>  
>>  #define APM_CMD_GET_SPF_STATE		0x01001021
>>  #define APM_CMD_RSP_GET_SPF_STATE	0x02001007
>> @@ -542,6 +543,16 @@ struct data_logging_config {
>>  	uint32_t mode;
>>  } __packed;
>>  
>> +/* Speaker Protection */
>> +#define PARAM_ID_SP_OP_MODE			0x080011e9
> 
> 
> Are we missing
> 
> #define PARAM_ID_SP_OP_MODE_NORMAL		0

I'll double check with the docs, but indeed feels like that.

> ?
> 
>> +#define PARAM_ID_SP_OP_MODE_CALIBRATION		1
>> +#define PARAM_ID_SP_OP_MODE_FACTORY_TEST	2
>> +#define PARAM_ID_SP_OP_MODE_VALIDATION		3
> 
>> +



Best regards,
Krzysztof

