Return-Path: <linux-kernel+bounces-798034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CEEB418A3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5FA3AEA4F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2BB2E719C;
	Wed,  3 Sep 2025 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOidAohS"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6F4EEC0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888426; cv=none; b=pr+Ut9HoLrmL3VaqZAiNHXi88acCQ9CK5dR6yVLIpElw5mjUj1qIL+A8MAjXn8pRvh3S9Q4gy6vIFfrnlCI1xIXsUxqpGXbWfO6SD5TTqt4/yPmMCyxeD+b0iG5vTEY++Qmf66j2aoxaO6+m42LW8ve7iHCBtqkKRkfVq2XXyOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888426; c=relaxed/simple;
	bh=5JjXs/rejxxYrw6K8OJPrjT2P7IUPezcjLzaibZ5qlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TM6rzRQ29GpET9/+we6qZOtwErXeq6tu3YLCpSyHd/M2/hlc2OSLZMTWi1TvOmDxIutPPbtLQrr/ZGBmfakUxNGHo+zK0Gr3COSoHl+K/59JTgT7mw/PS8sWqgt/HdY8e3Tl/zt5JHEw+71f+INQh8QV9zZeYE8loM26ekxz2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gOidAohS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b046d1cd1fdso5197966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756888423; x=1757493223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ACBHr8NfKb4KEMutVyQMnq5jr9ymWyUyWjylgBNBrHc=;
        b=gOidAohSTiPc9mN1S0UtZnAFc/qAFHNGn3ZPrgr24p5X31Kwb2QovDMwl6JMkJcRQp
         uNXf+opW2RpV4khHvZLN61PVoB3JnMs2nL2+T9H9lIE4IiR5RtgtgQy6N+tsIytAfXqP
         HNnnXISNSAGAZdVSQAi/Qi2cO2P78a4AVpCE2CPCN57FdzG+YHCDOy7mGKbupeGyFhpX
         KylEENeHmxbxhc68thnVjy8s52DHIpsoSZYgfst5pgTkJeXl/mUtjQBrjt33tFF0BfTV
         OoyG1LTDM/AD4MEA9Y2sQD9kZrhnz4GSE4rTSBluPG++kjYCTQhXvTIeNSEfgLKx613S
         JRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756888423; x=1757493223;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACBHr8NfKb4KEMutVyQMnq5jr9ymWyUyWjylgBNBrHc=;
        b=PjbxxFFp3HgydIPoTVBK1dG4llh2LDT4MfcARhrRqxkw1fh0xhelm+XK+G0MDzoXjU
         QxI/7G/+jQQXdMyfJXZr5ooYtXIdJ9j0aCDE9zxdulAdduWKIvHm+8tU/Jf52wCSd5tH
         HQQ4Uhn6qWjyFHdpPswxVfP2iGg+GxrSgLSZjCp7UPjqoHVhTqfU+RyUfdw0Wf58tTa8
         G+yXNdJ4VZLfuiOWmOGVvkbFEXAJlTARY7iUfsLB9o31qZ5Jz4Xa+UujkMzoxqNmajFd
         5nV3IU+rn/tUg5tI1XfdnljwruRGhhEpP9oLsvnFYozAEOHsSiSrYIXNX5JlDqI1REdT
         jJUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA2M+Phiu8sYG75LCgQXJRqnT2iZra2duCILoDYeIZrr46M4jGBQmajgMY5D2IENOQ9XFnQRLSOnIdDvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTDpw89uZD11XEvwER8GRSrJjKzNu0ow2/ON87R2HYf+WJxsKU
	iKrMG6fuA8CQUfKiE6zLT2v3q2eUc6PlktMf2PKMF0SmBcVEHjUJQBoDMwr2KXieTN8=
X-Gm-Gg: ASbGnctF9vDm/0zGW6yMy3JVJuQqSMxOE7mABhs+8wedrwJrCR3Xd32e+x/Huc1B7m4
	Lk/fzwBuiSBcRSEQvFxtSCbZW/E1Ib0eMS4NdKkNUihKch9zxJKoX91cw6v6iIIClKza3OIfKTu
	85Fc2fPfDwzVh3X0DduH0hd4G6LKCvyihbMPAZqB9hwzIaOVbYOfQaDe/vIrpZFEy6OGx82AmI3
	OCEPPd5yI4jYJ6N7EHwvzJgucY1U6ODgfMkoEIq67hm/IJh9VfNcJq5F9HcQM2p/sVc8AUrvm/s
	1q5TewgsqVpAZeh5rsOU6X8SQ5Mrj/kbj5W7AzRWvJazQIFHngiKyDChaUdGvCUc3lUETlju1vB
	vnvFnn2K5RptEVVbM4tb+F8eBAqHAe2tqzKzukbYpTDg=
X-Google-Smtp-Source: AGHT+IEh6tjHeFfJIDCd8AKcwONOhnH25T4xzmJnYzxd49mM1RN2+9yjvTmGddLtFB3bt6z3KxaSrw==
X-Received: by 2002:a05:6402:2105:b0:61c:1bb3:2473 with SMTP id 4fb4d7f45d1cf-61cfe999d10mr9232214a12.3.1756888423438;
        Wed, 03 Sep 2025 01:33:43 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc231561sm11146936a12.23.2025.09.03.01.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 01:33:42 -0700 (PDT)
Message-ID: <b50f9d10-88a3-4b1c-a75e-6c67b9d1504c@linaro.org>
Date: Wed, 3 Sep 2025 10:33:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_ecm: Fix ecm_opts->bound logic in bind
 path
To: Kuen-Han Tsai <khtsai@google.com>, gregkh@linuxfoundation.org,
 prashanth.k@oss.qualcomm.com, Thinh.Nguyen@synopsys.com,
 s.hauer@pengutronix.de
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org
References: <20250903083017.795065-1-khtsai@google.com>
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
In-Reply-To: <20250903083017.795065-1-khtsai@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/09/2025 10:30, Kuen-Han Tsai wrote:
> The bound flag in ecm_opts is being set to true even if
> gether_register_netdev() failed.
> 
> Set ecm_opts->bound to true only upon success.
> 
> Fixes: d65e6b6e884a ("usb: gadget: f_ecm: Always set current gadget in ecm_bind()")
> Cc: stable@kernel.org
> Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> ---
>  drivers/usb/gadget/function/f_ecm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
> index 027226325039..9f5ed6f32a62 100644
> --- a/drivers/usb/gadget/function/f_ecm.c
> +++ b/drivers/usb/gadget/function/f_ecm.c
> @@ -690,13 +690,14 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
>  
>  	if (!ecm_opts->bound) {
>  		status = gether_register_netdev(ecm_opts->net);
> -		ecm_opts->bound = true;
>  	}
>  
>  	mutex_unlock(&ecm_opts->lock);
>  	if (status)
>  		return status;
>  
> +	ecm_opts->bound = true;

Now it is outside of mutex, so this is raising questions you should have
answered in commit msg.

Best regards,
Krzysztof

