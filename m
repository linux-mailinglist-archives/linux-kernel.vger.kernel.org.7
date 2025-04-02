Return-Path: <linux-kernel+bounces-584711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 921DAA78A8C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 11:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A561892DEC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 09:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C87023536F;
	Wed,  2 Apr 2025 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="btGHyABx"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE7235354
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743584511; cv=none; b=jJaRFuApccx5U4EMQOVupJiGneLimxwvKVusrKQ2MMSWaT7sZVOSHLUeZTbzTekGqEFZySsqDKZnz0occQo+/nP4rRTgXcTOcyQjQVkWkNSP0sndp9g9SOEAYn3obPnpe8e2oQN50Yxp98i0qJaN0Y0MtU6WNvk/amK0ct+H82M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743584511; c=relaxed/simple;
	bh=3CCmkidKF9IDQdKhdwjJgIsHJC5pS7jYdLVJRJOyglI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oj7LfLkxju7nAvqYujPoGXygLEsRjxaTMQ028U8L25yMsEALDzxMeZRv9Ac8y5DAvE7/jeF/ugB67nHL5cUsPy+6FaVJntFkifM5+T6Seit0kBAafZZUIMKo1v46GGdSnvEhVzEqw+S9AoFX8Qz3fbPenmGQy4jQAvXZpusxeHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=btGHyABx; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3912622c9c0so654070f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Apr 2025 02:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743584508; x=1744189308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M85tsvp+4MpFOBD8kVovGad8SfbEn736WsbIo6AC64E=;
        b=btGHyABxAS9+xarPCEpUbtmBWJpJkz0SgPjcE/OPb6q9j8tIKX+vSkmO/+EuMNSxp9
         aOj0Q7qapG8N/5OlJCKsu4R52MVVs31VDAfJltaOvaufUJ3P3QhLGcsGItfT4tqN8vse
         Z741AdPLOxuBioNY6u+TfUl8P9vt1l6bgH+tIHA7PuNzCTqNL6j56DB7UejogBbQepzS
         m+r66kzvPMc04TDJwQ4D7wm0W2rrZsOLzwewqr4iqWYZD5yDcTbY67655hJUD6fC/TK9
         LVuPyUcpmdNaSEZeX8ucYv7hITuiEAV6TkBlqYIATjf5hzhUSmZW8k88Rdov0jA3IWMc
         5K2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743584508; x=1744189308;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M85tsvp+4MpFOBD8kVovGad8SfbEn736WsbIo6AC64E=;
        b=PbJEY1wegGxZ872elqVzv/OUv+cY5HU2tlLUU0DUHsacZ3K+rjqRuUX8Xq005EBDxO
         CbG3OC6P9Nbr4k43KPJJggMV538HleMd2Oij6WNxFuJdS8MIUVRdHmE4y/7wnWsGmdr7
         DGnbVmNvU2wvo0xQAze0h39cAVGHLL9IY0gRJZk7ghfK+7t0fxD8X6AKcrRXaySvuxZ0
         oTzgnRkIyjZM5wVkSUcNn1sojz/4+SAH0P9yJEaNX3hB/E/Ugic+2OuDL/gPf5926Uph
         rcVLSJV5tEhklLbmrS9awTk3E+xCPIfEfdw94f9h0KlxD4P/fop0vR6t90dGt6ZUnZOe
         idxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPomhXXm8ifnRKcgHP7ruKyV+b2LNmSYMfvkrVu0ziNRtICnlVNc0HpFCyOP58NwGNkgSELE8TWzbduQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4JOTUw5MH03O4u87dUVpyc13pcKJK4CG6hOlzbn3YkZDuGtKN
	nBoQvSNWz3EBWShOv2DlgxA7xregjJQCK6NWZM4h3ktIvWqYC+ze1coL7srsCKCqLve94I/nscP
	b
X-Gm-Gg: ASbGncvq/AESKQpMpMzpROjovkMXTV9sVMz+4aKcD35gUh+tqjtt6w/dWZh5kB31/sT
	31zbnLTbhHANQtJBKGW8e6Swjmd3De6q//taMU9AEy5elGLZzshrh0m7CIEvklcCycGGpMaqiYg
	u8kZNTkHcayyj6Z4tP4mutAq1vSLsQrF5FhBVKq0qYVH/zkxzNz41NjG8BqctkioHFua3ic0pCx
	+0o5KNrPjBtFLmklwLxIs9bv5ZPvMvzYr2cdXmAKSxbM1cXS1H3feY9paj00ugnNpVl+YK3i+t7
	Efy9UnRYde52ZLL7FJQIamAUixB+bNdZsR9LlNM2eMWYekflUojPALCTnsOScREEN4s96pxCLg=
	=
X-Google-Smtp-Source: AGHT+IHV8BiqotAbvtPquS8z9o07EqiSDbTdAe7JQndgh705gnCx7RFynt1+jDOX/cPqR1dlY0zeJw==
X-Received: by 2002:a05:6000:144b:b0:391:320d:95de with SMTP id ffacd0b85a97d-39c246f6531mr1705326f8f.4.1743584508174;
        Wed, 02 Apr 2025 02:01:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eb613ae24sm14005265e9.40.2025.04.02.02.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 02:01:47 -0700 (PDT)
Message-ID: <37385f5e-da9b-472c-81f7-7a939869d438@linaro.org>
Date: Wed, 2 Apr 2025 11:01:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: qcom: Add Asus Zenbook A14
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, maud_spierings@hotmail.com,
 dmitry.baryshkov@oss.qualcomm.com
References: <20250402084646.10098-1-alex.vinarskis@gmail.com>
 <20250402084646.10098-2-alex.vinarskis@gmail.com>
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
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20250402084646.10098-2-alex.vinarskis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/04/2025 10:44, Aleksandrs Vinarskis wrote:
> Document the X1E-78-100 and X1P-42-100/X1-26-100 variants.
> 
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

