Return-Path: <linux-kernel+bounces-769060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C98F7B26986
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A20A07D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5071DE3B5;
	Thu, 14 Aug 2025 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLGN12Hl"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6207214A4F0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181679; cv=none; b=HS7AXNNBMET6MfglSAcWqKcSqZnLPYicEFmUbsKl6oFPcyCM2i/EYpfryJY9jWzbm7SWSi68IbFC4MpHAUDBD8jcvoGzbe3JFaR8zpg/vng+0yaNalpk3Qpb+fo+dvkmKYDDRTDciXbDx6yQ88TI5m+0SYUoiYQ2QHky9zhEqNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181679; c=relaxed/simple;
	bh=S5b+eovL2iZeTDEqXyirVn9j6379z4XQaMNNJg6f4QQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XSOScvABCjN2gRXm0HGv0GXkucgmS6CT4GBkv+ZbM/v4Vh1OT54jX1BJbsFungqccvRxAKBtmYvC6XjAQfFP5a24RxQ3oDrYrVUyBti+Xzz8KgXQa0jgcHke7lHxCPwkrLlOfj9Rq+TagrUh4UmbxXMjuOQ3AOvyyzsukdboVVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YLGN12Hl; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb736dc8cso11392466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755181676; x=1755786476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8BBxrw5mS2tVpO6KfRm1eZFwAWJl/BjLqWDrRN6tfmg=;
        b=YLGN12HlggDPMGJjUJSXPSmVVkC+YdYPvQzqFCB6RykUiaoR62yqsGsBWc9kX6QETV
         rk08A1HUXNwIyAUiAfhiWlCzTB26AHZTr0joJ3DIrgzi9YxUKe5+RNSlMYCd60U+HNeb
         d500M5n5uB67lsJmVhUK7NPw7A3ZqSUsej/F656//k4mkmOQG0DWSI0jtMYp7KAQhTIx
         SlP2K8HThn/+JPqCb+Kq84LkzLyOWDkx2/fjTrG2Xh2dJbsgt/Zs7OnKvn8TJemqNakv
         TomHZ4uY+nGnEL5hlEvwOn/NIoVMPVinSXZEn2t7FtOJ446lFic+7Y3UjuqY49+lGBvH
         LH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755181676; x=1755786476;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BBxrw5mS2tVpO6KfRm1eZFwAWJl/BjLqWDrRN6tfmg=;
        b=EoCXUFTpOZmhHbe0n5JaxxhjBayJLrb6SwaNlLLCuL4UD3QulNMaJR3R/ZLlqehJKb
         PmCVhoMnrH7ZdMAdRfVF8J+/5I2ZTspYghGZqJOVtd+p0l+Ie8kLdiLE1qRZJ/rCOVgd
         ftatBJ63TST0wO+k48pM87AweaUwrlOY0DvQkOE7uf7AfKqn0IGJj64ywff1AqXTGHIS
         XcuWtdNuIruzgvpz6W3qAyuh4E3RHQaz40EhdVoR5L4UNwkKNirWasgLMWhCXA8HI+e7
         cEmvHQYSTR0zZQD7trX/vQC2Z9QO+f9wB7CLm5CRYZwJ0mljZtvrsRb1IfZIQtfBqqxh
         Kfiw==
X-Forwarded-Encrypted: i=1; AJvYcCUUnPY7+MCGne5yf5gE88vkZ8i8/Pckna979j9eBsIIkW0z6Y7X+Xopzj9mYc6MXa1yam2CaMLIx6AOVh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+NfNnu8IOrWjJolXYwOg6E5M042lwAke+eOb/sJGBpjNeoboU
	6yftFcevOPp3mxHMPLogaxDhnDGxZ3ghxNREDedzOrGX4K4HKPgPwXz4PVqXlhaBtkk=
X-Gm-Gg: ASbGncs1Nvj4CjiYVFwxSR3CBAf2oOPU3SwTujtept6+n8MhrDq73TM6slqDe8mZQzR
	Sq97miSIpDH1aB0NX8qVZWCVYJRZ0NblE3IjGSE/6ijWGR3+IHxs4aJUgtIXC3NmH8u9GEzeLwB
	k1KJtEXEbUt5SHm7YH896ozr5cu/vi+mc0fqGVxata6OocOuB5nqLQ+TNI5PV0MJuTrgddrkAKB
	FvfiN8bgDJo8ykRwglsOGsrEhBMGftPHixkI/NY1/RUVqc/D4nqIv62d/kaO2e5cejL2c9cteAu
	lRpBCKKEgsiFrAIeDjPC5sbVrPJW7oGrMhN3Jx7cXfDzBstoFpOqkweKInYRDXCVFObZ7dgABHS
	Wy+kTaxBJL07F6YA18orYGtjC/Ly2uyMZAOdSsNwDY4Y=
X-Google-Smtp-Source: AGHT+IHUx+e/lw5MDVZ0rY6gKaSjgvW6ovRBztdS9oKGaCQ3QSVpY/hSp2FXXMtRQW++YksiYRIWHw==
X-Received: by 2002:a17:907:1c08:b0:af9:6666:4acb with SMTP id a640c23a62f3a-afcb98d5019mr149229466b.10.1755181675607;
        Thu, 14 Aug 2025 07:27:55 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af96bc4fb0dsm2016534966b.112.2025.08.14.07.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:27:54 -0700 (PDT)
Message-ID: <89cb937b-4ae7-4edd-be54-c4fb25e06826@linaro.org>
Date: Thu, 14 Aug 2025 16:27:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] dt-bindings: ufs: qcom: Split SC7180, SM8650 and
 similar into separate file
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
References: <20250731-dt-bindings-ufs-qcom-v2-0-53bb634bf95a@linaro.org>
 <yq1ms8d9nx2.fsf@ca-mkp.ca.oracle.com>
 <279fb589-d22c-47f8-9c71-4e959bce3800@linaro.org>
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
In-Reply-To: <279fb589-d22c-47f8-9c71-4e959bce3800@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/08/2025 07:58, Krzysztof Kozlowski wrote:
> On 06/08/2025 04:37, Martin K. Petersen wrote:
>>
>> Krzysztof,
>>
>>> The binding for Qualcomm SoC UFS controllers grew and it will grow
>>> further. It already includes several conditionals, partially for
>>> difference in handling encryption block (ICE, either as phandle or as
>>> IO address space) but it will further grow for MCQ.
>>
>> Which tree did you intend to route this through?
> 
> 
> These are bindings, so please take them via UFS tree. Just like with
> every other driver or bindings patch.


Hi Martin,

Did my answer reach you? Any questions about applying/merging?

Best regards,
Krzysztof

