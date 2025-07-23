Return-Path: <linux-kernel+bounces-742854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D87A3B0F763
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81AFB1C85683
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688701E2853;
	Wed, 23 Jul 2025 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+zz5HVH"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BF91534EC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285592; cv=none; b=pZzRRfJoesbTpBGYJKa354o5DwuySp5QCO27rZ9w0COstbPOO+1jt8lboQvvDh9gGjabMv0y26UjMcpSDmzdJMESkI0C9hfAO5pasunbbaLIqp0HRqtbk3BSsf1s3Vu0wSCORWWm3cRGzOSRkzHeIbzk7AqMJpMxW20wksIr+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285592; c=relaxed/simple;
	bh=ta/nnHN012LXj1+PlNtGr0OXiDJWbolzf2pyXA4jqnA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DmaEAWoFTFFKCuMe/JW/3ATZOgcF3IhBqUqkltJycJKEhj2YNoUGC+7JPPO1yZ9WG/8fX2Tvj5KOTMUV/jTjWwt2S3zbur10tTTi5eVE6VScyIdFJ/X+I+jnzesqhqAVymV+3lotsycoEzUrkuaqS1uu3nc0CoYX1RkEy/8nSP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P+zz5HVH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ab112dea41so4017309f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753285589; x=1753890389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmZ5bRV1PUfqwheCn0hCcu15gX58d2eDTkGCH+uULiU=;
        b=P+zz5HVHz84WH7Cc5Mb05ADRnoSJmdXntH5/wzYXMaDAA1vHAE6Qm0mzAhwbJjAGtR
         6LqMW5MKMIyeXj0vX+gSm8sz6imQjgV2ODfwcl/zPZQW3NxkbhmAH24ab7KEvFh0ertu
         KJZxRn0w6kCL4aB63tCCKrjoCL36Ry7d5FXX6vW/NfZytxyizLEOY4U22iwLu3ZE6YJZ
         IWzKqXp5R/2Z6Rsh+aeANmKxipRpYrvvctIkigg8M0iN7nr2iPxlq1saS+RZlaNMWD4I
         PpM38IrQsGWuXtZvHgk1zqWle7G7asfi4UigVJh7Z/u3kZYZ8ZCmW7Hu+F7sg8Zw0gur
         bt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753285589; x=1753890389;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wmZ5bRV1PUfqwheCn0hCcu15gX58d2eDTkGCH+uULiU=;
        b=nVNYfHvEmz/xF7ml1AGgEUqx4tvB8YtkiVMQzE/x31K8yF3FQJ4mloUdfkv3Z4MlhD
         4PV9OxLjUjHPrb3Y1VJ1Lmi1tOQCXOmn2tT5DIXV9504aHOWYynL3jVt47fsX6OcYxQ4
         sTDBsajpaK8j/f7y6uopg72Tl95Vj7JAMsk+Fmxu5Z4yWhnphSyngKSfkqVNAAeRJXKW
         Cyo7kPFpQbJis6h4lpyCrOwBHkNzXTaNCQS5jOxKwCh6r21gLRW2RlI9wyQJbVrPSRk2
         BrbvElNJqooc+HvkMfjJ/OiF9DRXqhRIrBhXfUKbhBxLGuYGGPVE4Tr7RERa14YW97Ov
         0OuA==
X-Forwarded-Encrypted: i=1; AJvYcCV5rlsHmh1wp28K5ry1Kx9q+OEGZLAoAYgWu5aB+9Z6ycrWAvoiyTNtYqZIsfUr5g6BxHPR0rMWshJ/OVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdX+7iFynzi5wYQckZ+KtaodB0z5X4orK+OkcVFTJiD42Nyog/
	+Q5vsxW5DbPicKv7e3nLS4oLGM7RGqdWUQQuQj8Sb/SA8msfx8QI853LBFTQl1fl/hM=
X-Gm-Gg: ASbGncujoKevm2UPCv1m2SMPaXNPrX+ZR6JKdLNJIvQ9NqFtGPszN5rvjm0wWDMWUEq
	LdunfucOE4/uaVQv+i/tpiH9fFlJOnUWq41ejr9i5j+v/M1IAyBou3KAVhRn/goKvUAVMdxx2AO
	U2iG5QwZxQaAinBThEh9+LfPaChNYVFsvYoxnKgVP2pcmsam7NitYbEaz98LEPzEJW9u5i2ERX4
	Fo6ITrot67+BvQysnDWWwLLoeUKRWoT3w9KdE5DyIPxCuAMHafSMcYMir+iEzcpVNrgiy1J2IQN
	5ftUxiTAfuqNFBfyinA2oKHox55y0yBFsaXlqED9r76ayUS+iAknSVPOpR5evdPjDaKMPf543Bc
	WTbiBey06PirRa+qEndtNjsG7DNckXBLq1LSEqkx7IeCnOoAyq/zW0mAqEV1DkBRW8K2BQCkqxi
	6UnME5IhxeXQZO
X-Google-Smtp-Source: AGHT+IHlgEnmQBXXUEyZi32pN5BCGwjGY8lZuXGj+tGjDArR+gc7x5W/LA/pSb/walkpnyfSxvl2nQ==
X-Received: by 2002:a05:6000:2389:b0:3aa:34f4:d437 with SMTP id ffacd0b85a97d-3b768ef9577mr2721271f8f.37.1753285588768;
        Wed, 23 Jul 2025 08:46:28 -0700 (PDT)
Received: from ?IPV6:2a01:cb14:150f:cf00:b6af:e6a0:6569:3a1? ([2a01:cb14:150f:cf00:b6af:e6a0:6569:3a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b75baa7072sm9616199f8f.2.2025.07.23.08.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 08:46:28 -0700 (PDT)
Message-ID: <c052931d-9bbf-42d0-9ccf-4fdc62d408bb@linaro.org>
Date: Wed, 23 Jul 2025 17:46:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] soc: qcom: mdt_loader: Fix error return values in
 mdt_header_valid()
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <db57c01c-bdcc-4a0f-95db-b0f2784ea91f@sabinyo.mountain>
 <aec9cd03-6fc2-4dc8-b937-8b7cf7bf4128@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <aec9cd03-6fc2-4dc8-b937-8b7cf7bf4128@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/07/2025 16:46, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 25/06/2025 17:22, Dan Carpenter wrote:
>> This function is supposed to return true for valid headers and false for
>> invalid.  In a couple places it returns -EINVAL instead which means the
>> invalid headers are counted as true.  Change it to return false.
>>
>> Fixes: 9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read past the ELF header")
>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>> ---
>>   drivers/soc/qcom/mdt_loader.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
>> index 1b4ebae458f3..0ca268bdf1f8 100644
>> --- a/drivers/soc/qcom/mdt_loader.c
>> +++ b/drivers/soc/qcom/mdt_loader.c
>> @@ -33,14 +33,14 @@ static bool mdt_header_valid(const struct firmware *fw)
>>           return false;
>>       if (ehdr->e_phentsize != sizeof(struct elf32_phdr))
>> -        return -EINVAL;
>> +        return false;
>>       phend = size_add(size_mul(sizeof(struct elf32_phdr), ehdr->e_phnum), ehdr->e_phoff);
>>       if (phend > fw->size)
>>           return false;
>>       if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
>> -        return -EINVAL;
>> +        return false;
>>       shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
>>       if (shend > fw->size)
> 
> This patch on linux-next breaks loading DSP firmwares on at least SM8550, SM8650, X1E8:
> 
> [    7.572665] remoteproc remoteproc1: Booting fw image qcom/sm8550/adsp.mbn, size 28342616
> [    7.615176] remoteproc remoteproc1: Failed to load program segments: -22

It also breaks GMU loading on the same platforms:
[    7.418330] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22

Neil

> 
> CI runs:
> https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/jobs/248846#L1323
> https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/jobs/248850#L2037
> 
> Bisect log:
> # bad: [a933d3dc1968fcfb0ab72879ec304b1971ed1b9a] Add linux-next specific files for 20250723
> # good: [89be9a83ccf1f88522317ce02f854f30d6115c41] Linux 6.16-rc7
> git bisect start 'a933d3dc1968fcfb0ab72879ec304b1971ed1b9a' 'v6.16-rc7'
> # bad: [a56f8f8967ad980d45049973561b89dcd9e37e5d] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> git bisect bad a56f8f8967ad980d45049973561b89dcd9e37e5d
> # bad: [f6a8dede4030970707e9bae5b3ae76f60df4b75a] Merge branch 'fs-next' of linux-next
> git bisect bad f6a8dede4030970707e9bae5b3ae76f60df4b75a
> # bad: [b863560c5a26fbcf164f5759c98bb5e72e26848d] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
> git bisect bad b863560c5a26fbcf164f5759c98bb5e72e26848d
> # good: [6fe8797df6f2e3a7e3c736d5bd4862915a06a690] Merge branch 'for-next/core' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> git bisect good 6fe8797df6f2e3a7e3c736d5bd4862915a06a690
> # good: [c522d00e1b4b00c5224c2acb9c2738bcc9c04ff5] Merge tag 'ti-k3-dt-for-v6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into soc/dt
> git bisect good c522d00e1b4b00c5224c2acb9c2738bcc9c04ff5
> # good: [6a323f22a8b925f3646c884e2f9c733c79393f1d] Merge branch 'soc/drivers' into for-next
> git bisect good 6a323f22a8b925f3646c884e2f9c733c79393f1d
> # good: [5d8b3562faac8030b5c26efc1cd739a41c4db722] Merge branch 'soc/dt' into for-next
> git bisect good 5d8b3562faac8030b5c26efc1cd739a41c4db722
> # bad: [b79c0d780e519d760c2529f0bf849111b9270192] Merge tag 'apple-soc-drivers-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/sven/linux into soc/drivers
> git bisect bad b79c0d780e519d760c2529f0bf849111b9270192
> # good: [9841d92754d0f3846977a39844c3395ee2463381] Merge tag 'memory-controller-drv-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
> git bisect good 9841d92754d0f3846977a39844c3395ee2463381
> # good: [64a026dd896e423a177fe87e11aa69bf5348c27b] soc: qcom: socinfo: Add support to retrieve TME build details
> git bisect good 64a026dd896e423a177fe87e11aa69bf5348c27b
> # good: [9cea10a4f5a39fde32bf7b8addfa5f9175174e0e] dt-bindings: sram: qcom,imem: Add a number of missing compatibles
> git bisect good 9cea10a4f5a39fde32bf7b8addfa5f9175174e0e
> # good: [0445eee835d6e59d635e242ba1d9273f168035fa] soc: apple: rtkit: Make shmem_destroy optional
> git bisect good 0445eee835d6e59d635e242ba1d9273f168035fa
> # bad: [5b8141596b06fba7313cdfbd5f589649d7fde662] Merge tag 'qcom-drivers-for-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/drivers
> git bisect bad 5b8141596b06fba7313cdfbd5f589649d7fde662
> # bad: [9f35ab0e53ccbea57bb9cbad8065e0406d516195] soc: qcom: mdt_loader: Fix error return values in mdt_header_valid()
> git bisect bad 9f35ab0e53ccbea57bb9cbad8065e0406d516195
> # first bad commit: [9f35ab0e53ccbea57bb9cbad8065e0406d516195] soc: qcom: mdt_loader: Fix error return values in mdt_header_valid()
> 
> Neil


