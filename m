Return-Path: <linux-kernel+bounces-779488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4488AB2F4BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330F56831DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353CD2DC332;
	Thu, 21 Aug 2025 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJnFEL2p"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0D42DBF5B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770285; cv=none; b=iyJltLnTUsUH4XiALlYwlVkg1c4dqbCGzbWlj2RjODGheXBaFTtaYttpi5fBQha0KD80URMr/Oatzr6sE/aD8Gur9kdMKlBNygVwdBXFKkjQ3ZimIjKmzfew97iTg/raB1qH/q7GSR0B8AnlzaUSNBcBnm3/YTGKuHhfPJSLTM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770285; c=relaxed/simple;
	bh=Y0xqoB0kDnAvuY65CHSIR5fT8Bs48jQwKDm5ofrl6jE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdirfyugXK6zlnUEkhoZenXG+qR3CS5BlGS1duvWXBiXMyHOJCxXRK0c7aZLyxNUZvvK7rBSFuUvvH6DjKakTbBZDOoNCpA/0as/hPUrvAZe8Ge1+uQt8R6wzwgQmDmhTTyDeWI1cTyF32mFgAV1nl4/Kl4QuRvK3XA2eUsRH6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CJnFEL2p; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61a483149e8so142732a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755770282; x=1756375082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G7kwoRhv5U13/GFymqVCODeONSBqbAmGbkHT2iXWExw=;
        b=CJnFEL2pXD1cX/kdmNKjBLM9HS7SkdUHrtgfHEWynBs5AQxjo7Nzgha/wSOpBslgmI
         m25tr1qKvfzGrwVG1Lywvye+4Mj0dZQ0pbLNtNwWiOZ5KUMOuyapNuXpSs7Qm282LNzb
         ujfTo62bxj/i0eij1dhWeTXy/K0DM4fLZMx7SWCnDCGMZzUaErq4SPNUFuMoLpMYK4gj
         3Oz8i+e+0ExuY36C46nXo1K0zu3/feXC3GE4vmRzjO7j0KECQJFPPjinT0fJXTeHpLC4
         dYFW1cVMsqgiPLL1f2InBIfo3ErvljzvdaPg7kuZpH4H+r6sjsxQnzK8mXANrFcOJvRd
         6Aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755770282; x=1756375082;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7kwoRhv5U13/GFymqVCODeONSBqbAmGbkHT2iXWExw=;
        b=A7E5CafES3iYZS39SBwjDFm+jlvsm/wx3mRB32iBD0Uo0konhXreVmsAjbv9+/dO0/
         ndnbbn/v2DSEXfxCijHoof6yhsLK5zJo15gu8+8vKqJC54iR1xQ8rOTFAH4I/xWXrHRQ
         NAKOM2CgwtKisSjx6L+cA2Cal/o6T6bXGyZxYN3R3I26u5O4+fvZIFXNGHw/XSrB7rDB
         EcJeaFkG5i9xiohOeB1OY29LabuAe/L37eJaIUAzT3gZNh974QnualRnG9gG69R6pptE
         qR2e3VreoeZDASSEkXm/34mfL1nbQAJxRQlldts3H2zl2buTfl0TcAVa2oN0cH/kAaC0
         P3Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUXBGh1hEi6IM1A+W9rzFre1yKS+jUdpMCp+yDwsp5KwFUB9KaVZao+2hWzU/f6EEpM4/JHz7REZ2Sy1Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxITPBlRQhZU1Y5w+vBzvthvlgAFpZJ8P7+31WSOrbcbh4UyTZ1
	CLO4rh9EIEuELNR/2EpgLzfJ90CTjBRTEHsKXGLeOJOnWiF/z/B4FzfYMBWDx8ueGAw=
X-Gm-Gg: ASbGncvjg7AkGZQ0mIK9cDeKyCsEv7wQJeqNwnRL4qn8ADad8ONPG4hpLe5GEfMwNgi
	23JnwgyqRwFKOot9Wtlc/YI0Tx+neY2BcNfnQGVm8PQynBDxyercVn9w/23JKuqpGMqs+eiK8aN
	cAOKyrOmWUUhGQy8r86s3NS/XtS3Ixb6It4Fw62CoGMHs5RLsSNG7SufAQ26lzPrqXONrpgjf75
	P1kvffg7YIimHGKLYLTm9+63L0skaL3W8H08tvrGjmEX2gY0Nob13uLN/PcERxiTBUUtlN69SHt
	rwc0Jmqw46K1nTjLcw0x6lRLJ5uCnDxLrnLkYWChFtvMMDo4CzRy4emjtbzAFQUhTZwuL6KkQ2Q
	7iDKlWJWquoGksZvQ2HNKwsUbYyQe0ER+pQe0tshop8I=
X-Google-Smtp-Source: AGHT+IFLr5HkEv+4HL9B+7RKl4Q1VhprAQyB2qmHlrSgwTVDxI9DXA0oDCg848cy7aztpCLDLQ5Qwg==
X-Received: by 2002:a05:6402:2355:b0:615:c741:ec18 with SMTP id 4fb4d7f45d1cf-61bf86da6cbmr920430a12.2.1755770281965;
        Thu, 21 Aug 2025 02:58:01 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a758bedf1sm4825360a12.52.2025.08.21.02.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 02:58:01 -0700 (PDT)
Message-ID: <7d2bea94-b6a0-49c2-bd83-e5421a6ce567@linaro.org>
Date: Thu, 21 Aug 2025 11:57:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: Move embedded controllers to own
 directory
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, Tim Harvey <tharvey@gateworks.com>,
 Michael Walle <mwalle@kernel.org>, Lee Jones <lee@kernel.org>,
 devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Mathew McBride <matt@traverse.com.au>
References: <20250821062840.9383-2-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20250821062840.9383-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/2025 08:28, Krzysztof Kozlowski wrote:
> Move ChromeOS Embedded Controller, Gateworks System Controller and
> Kontron sl28cpld Board Management Controller to new subdirectory
> "embedded-controller" matching their purpose.  MFD is coming from Linux
> and does not really fit the actual purpose of this hardware.
> 
> Rename Gateworks GSC filename to match compatible, as preferred for
> bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Mathew McBride <matt@traverse.com.au>
> 
> Lee,
> Can you take it via MFD?
> ---
>  .../bindings/{mfd => embedded-controller}/google,cros-ec.yaml | 2 +-
>  .../gateworks-gsc.yaml => embedded-controller/gw,gsc.yaml}    | 2 +-
>  .../{mfd => embedded-controller}/kontron,sl28cpld.yaml        | 2 +-

I forgot to update references in other files (except maintainers). This
needs v2.

Best regards,
Krzysztof

