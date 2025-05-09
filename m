Return-Path: <linux-kernel+bounces-640957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29792AB0B58
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 09:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E772A9E0BB9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 07:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EF6270557;
	Fri,  9 May 2025 07:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBa/MuqE"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10FC26FDBA
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 07:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746774784; cv=none; b=BT0NQapVrNrTC1ulYhh8f27BOAvZe1waXAF/ILaMOn4Xg7hfktSeMSc9pbr8eJlaTp98TbG7O57eN3pDGWt9fbTM+GiwKZ9B62OSdMAfOkfVzGJlFT/e8HtaEVl5jjhHqgY+eZLcbfQ5yswpGo4HRbGJ3zffM36hNVKh34jlI78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746774784; c=relaxed/simple;
	bh=i0cUZ68tMP35ApnlfI0tWYcH4KKFdfv10ggfYh5WwU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCM+2RVwK5/E8lOW191zAsH2QyjrOXeYOU4MNAh8TYJRb2uCfLvRaH+JxXp3k8vbulOdXOpzSAik48R6kRQ190DZgVjks+ZONRgg0C1neYYAWao7Zj6biMuW5KubTj9Hglh0PSTU1WGUdoljUOHDmHP4HnQDRtYhc+KQy2DmHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CBa/MuqE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a0b4c828c1so227580f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 May 2025 00:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746774781; x=1747379581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zygcD5cxKecvUC+A/s11DnKczn9AVL7SsQoS8s8eFz0=;
        b=CBa/MuqE1jqNFMMA5xS2VdmJYJ9aDg+aFgxgd/GjeSi3BUprD13siRn1Uqnpi0miCm
         OzoOc1gIsdjY8Lz7Te66G90eGh65twXHcbuU57VrOvnO6zX2f72/fDtXQCiFqulWsF4Z
         496YNYyw6iUW1JdJubEY1KLZItYtwKgZAR/dylI6PxK/lKtcghiA9gN4C0AlLQQfXT6j
         /xFpBe5QOJqnCYfGsRz5ljpaHed4IzSvo6VzXoQdeW7OolFYCCq4ZijFAOBzRl1lqPdZ
         qqDGNYtasGvO8jqQD3y0vF3TYgW+IFyEJ/aY5V7k1Tl4bKnGdNWpyuX4eDGY7pjKCzsy
         2WTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746774781; x=1747379581;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zygcD5cxKecvUC+A/s11DnKczn9AVL7SsQoS8s8eFz0=;
        b=I1hV6ihoyXggDUyFxYRwE5hWUPcIhBZkDX1Mj+kbZ9e7jVk2gNusN7qwv9lgkUdbe8
         kJ/nGNsoRL1tOhbb41HQwSMdUSPI7EmLM291AdEn2jGmF6g6DYDh29nWYexH3GnBkfAZ
         0sTC5+54tLSdD5a6pUaYglFnr8/JeJnhYEvyLWA7233wSj+2G8+fUc8LXGmjo7mwAGpJ
         /rsGXYzPiWef3/a/buRMW8GxlaaarXCHqVEjrkI8ozPi1O6mvcQrmZlxy1deLeJsA0kn
         qIf/TBBVeRa2FguA35JrKIMrR+Ay3TQJSGGcDjANFlFM2HnzRVKYTg5zWNC0Q3+ja4kL
         X4oA==
X-Gm-Message-State: AOJu0YzwBuuRRThUTqEo9FFspPq1KcTLNifxSQAzcWZeE/BDu6FIn84q
	tj8nYlv7y3kvqJMJ50yVw9gbtM4EzaSGTUAt+Krsp/IZtcoVRa20NU7LfXZLIPQ=
X-Gm-Gg: ASbGnctwzvp5A+fR1Y8XWXd/jHSYnJ9d+KvnwLXYLs84MdBr0Y7+4du828OuWZwNwMP
	Lj8hjBhAg+UwG0wveWjIgs4kg0dGcQVKJUMha685EHi1TN1IVMX5uuIeSG9aNNLFaGERmlmhbU2
	Xn2EVH0k04lSsB4oSqoTvRWtnFUeGsH3RNhZfVL9F1Npn0IFrKOsVPEIpWcRzKr3IWMln0GKfp2
	bkxk92tvw01ZWM9xI5F2ZcoXkJqKgpZfjH7oAvHosq6S7Gz6xZ7KbIfwNQE6rE625KFMehONzXT
	iO8T8NjBb9mqfVQ6b41bkkhUURUFERXxCQJQDQwe3HOxkL4fMjkkgQZyoVI=
X-Google-Smtp-Source: AGHT+IFoNjfyY+1UgYfYS1mZkqrJ6Og4lYAOL08XkOMU8OFrRqY/OHKMWzrghCreNlUwl1oeK3Yw8w==
X-Received: by 2002:a05:600c:8215:b0:439:94f8:fc7b with SMTP id 5b1f17b1804b1-442d6c39708mr6500555e9.0.1746774780879;
        Fri, 09 May 2025 00:13:00 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58eb91bsm2371970f8f.33.2025.05.09.00.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 00:13:00 -0700 (PDT)
Message-ID: <1cd209e0-bdfa-49f0-8430-fec7e6108f35@linaro.org>
Date: Fri, 9 May 2025 09:12:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] extcon: adc-jack: Fix wakeup source leaks on
 device unbind
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Hans de Goede <hdegoede@redhat.com>,
 Chen-Yu Tsai <wens@csie.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250501-device-wakeup-leak-extcon-v2-0-7af77802cbea@linaro.org>
 <20250501-device-wakeup-leak-extcon-v2-1-7af77802cbea@linaro.org>
 <22aaebb7-553b-4571-8a43-58a523241082@wanadoo.fr>
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
In-Reply-To: <22aaebb7-553b-4571-8a43-58a523241082@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/05/2025 08:20, Christophe JAILLET wrote:
>>   drivers/extcon/extcon-adc-jack.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc-jack.c
>> index 46c40d85c2ac89599ffbe7b6d11b161b295d5564..557930394abd25771799733a22121d1f8e254918 100644
>> --- a/drivers/extcon/extcon-adc-jack.c
>> +++ b/drivers/extcon/extcon-adc-jack.c
>> @@ -164,6 +164,7 @@ static void adc_jack_remove(struct platform_device *pdev)
>>   {
>>   	struct adc_jack_data *data = platform_get_drvdata(pdev);
>>   
>> +	device_init_wakeup(&pdev->dev, false);
> 
> Hi,
> 
> Shouldn't this be:
> 
> 	if (data->wakeup_source)
> 		device_init_wakeup(&pdev->dev, false);
> 
> to match how things are done in the probe?

Yes, it should. I'll fix it.

Best regards,
Krzysztof

