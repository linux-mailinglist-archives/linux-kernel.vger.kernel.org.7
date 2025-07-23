Return-Path: <linux-kernel+bounces-742723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75A4B0F5CC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7361CC30C3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B382F5485;
	Wed, 23 Jul 2025 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BSOfFOzl"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301D22E719B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282019; cv=none; b=gON2EpE7JLVkDSBHC/DFxy+ZXwA0LiPMfR4hcr1Ifp8vkv77SAWrr1SfBib2fhQuITO/+Ofk2jmcw8T8KYsqyg50stI1h2fxKX1T/4Pz63OmwXwLPngD1JiXKQqI4JXL1VmoD1illbHYsnCO/wpz7oslgLE3hiCSlSpF6K4Mvro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282019; c=relaxed/simple;
	bh=pNF5x/KnFiLldz0sKiX5Sar4huY0ieTZ2jOl0Mw64+M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qY7IjGrFQQ/8HC5NPr988gij2PoSD9SVlClSmxB47ydk+HId/reQhoD7MgxxmFd/5teJ+jUdtnPjDct50kTP4W4Xw7kxAMLISk4ooyB/8y5Tem+WGf1OlkYA2MuY233iEAom3X9N4gbJf/fRGiM+R7jbvuH7CV9OS+qRQRit5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BSOfFOzl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4550709f2c1so52723555e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753282014; x=1753886814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L29h6EKArV20tELErS9C9+UIvpslfClXnLtlZ1Dwf+I=;
        b=BSOfFOzlq+2WO54TbQOjDYZDr7MPIzj9p6ZS7aSkkkT/EDkGmELqR7n2G67oLmQ1H3
         XUzJF71Q4hWLJh8FuXKODnkhsdZYQnr9/QvsV/At4BlrN+ZUq9Wthbvbb2Xrjl+JhiW7
         wvV3kSg1aHWTJsiokrFRnsgOc1hTAO8ni/rFc2IV2ZbHdwKhST99qibzsVoBwjEDyPlA
         TeWzSTiRo/DVifOm9JS40TIzv2uNtjntu69E/o/m/7s0A56nUGxQob/+8nrzmAf16Itf
         pN8xGGScb/boW68QtzeMmWpHCWWBQb4uMfFKd5du+b6ZktCPHBNcjXkD1XGqgAKcB+Du
         cQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282014; x=1753886814;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L29h6EKArV20tELErS9C9+UIvpslfClXnLtlZ1Dwf+I=;
        b=DEKtRZcrmN2N30nQrDYi45MmCvfqpNQlqLBQDhHe9rmUgCpKpi3fJM+jurhJQ4OtM6
         XNpWzMDPkiiLBaoe6Yj3jcqEmnJQB7pNl4msuCCRC/FCh5ySGq1n7fo74iu5+9+NEi2x
         GOGbt+Rx597puEj8aQL+jblOOIzn4QJX9oN1NOHJ5/5a+EhHOBfCiiwd5a55wQz+7vwk
         uO05JX96OJpmHh5Db9idaBV7TkAiFBElUj873Q/yn8CYlY8uMQqI7oFOoTZ+aSb9irDk
         G/knAlxBbcI/DZS4MYZoI44mz/bVDPUMi0xgfp68TtRhihAMbybKgICCkWsAPbItsujN
         pdIw==
X-Forwarded-Encrypted: i=1; AJvYcCX/yl2WBVH6BEBWlTSzj6+4MES95I64pdnvYn8b5pnZzvkTQF2L/m6QE6b8LG3iKA1rb5LxVL2okFYwHYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKTiPqPAk/ZIn+HN3Vf3ZQWOLj1Sxo4dQSBC0BhjCGrDQL0JmW
	QtXHMNyfwjkGSqZ31OzLGK0ftvtkbQMuA4JmDyLz6nfPFIvfQPGKojTSGf1HeTZmRvc=
X-Gm-Gg: ASbGncutmWGzvFDJmq/PQZwM/bG/K0tIY9/mNWwscW8aNO/ixjyTsdv6kOO96FfoqYB
	NP2ZSRip9rpPZ8vbIYpWa17E9qn5S8wjiv9s2r8l83qEuG6RRI1w5TddYeHYjlwhl50wjjnnhhI
	C68mNFe+/xu/7MXD37CX7qTbs/f2C690jMfzuXT/CpYOAzpvHi92olW9Lav0NU5Mmli4CrXMdxO
	i4yhLwPg+OZZfjZ7a6wR6USiFgGF33VgW58vrTFStcxw/dBp/fk51vMb51n9EeBqymaVbgBMNAs
	xjlgTYbUP2e02+kVqaHeiR0dxA+kDVI6Fb/HEwMG2MahtnCxcrK2I1v9FLI3YHtGmKDpwnsSchY
	svBmNdiNpHM/nnCMaliA44q5+j+JeN1ixqGymAa04UTkfe/ZfoMUy/UN7s1rCsWIxd7Z5zc5tsx
	MKWA==
X-Google-Smtp-Source: AGHT+IFfNwcscWk8yTXaSaqSwGrS5jaSAAkFnZ9U4aRsYEXlqsL1Eq4oLL6kohZIRvs7+CcnQw3YTQ==
X-Received: by 2002:a05:6000:26cd:b0:3b6:c88:7b74 with SMTP id ffacd0b85a97d-3b768f2e446mr2720020f8f.59.1753282014234;
        Wed, 23 Jul 2025 07:46:54 -0700 (PDT)
Received: from ?IPV6:2a01:cb14:150f:cf00:b6af:e6a0:6569:3a1? ([2a01:cb14:150f:cf00:b6af:e6a0:6569:3a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm16730245f8f.80.2025.07.23.07.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 07:46:53 -0700 (PDT)
Message-ID: <aec9cd03-6fc2-4dc8-b937-8b7cf7bf4128@linaro.org>
Date: Wed, 23 Jul 2025 16:46:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] soc: qcom: mdt_loader: Fix error return values in
 mdt_header_valid()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <db57c01c-bdcc-4a0f-95db-b0f2784ea91f@sabinyo.mountain>
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
In-Reply-To: <db57c01c-bdcc-4a0f-95db-b0f2784ea91f@sabinyo.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 25/06/2025 17:22, Dan Carpenter wrote:
> This function is supposed to return true for valid headers and false for
> invalid.  In a couple places it returns -EINVAL instead which means the
> invalid headers are counted as true.  Change it to return false.
> 
> Fixes: 9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read past the ELF header")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/soc/qcom/mdt_loader.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index 1b4ebae458f3..0ca268bdf1f8 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -33,14 +33,14 @@ static bool mdt_header_valid(const struct firmware *fw)
>   		return false;
>   
>   	if (ehdr->e_phentsize != sizeof(struct elf32_phdr))
> -		return -EINVAL;
> +		return false;
>   
>   	phend = size_add(size_mul(sizeof(struct elf32_phdr), ehdr->e_phnum), ehdr->e_phoff);
>   	if (phend > fw->size)
>   		return false;
>   
>   	if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
> -		return -EINVAL;
> +		return false;
>   
>   	shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
>   	if (shend > fw->size)

This patch on linux-next breaks loading DSP firmwares on at least SM8550, SM8650, X1E8:

[    7.572665] remoteproc remoteproc1: Booting fw image qcom/sm8550/adsp.mbn, size 28342616
[    7.615176] remoteproc remoteproc1: Failed to load program segments: -22

CI runs:
https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/jobs/248846#L1323
https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/jobs/248850#L2037

Bisect log:
# bad: [a933d3dc1968fcfb0ab72879ec304b1971ed1b9a] Add linux-next specific files for 20250723
# good: [89be9a83ccf1f88522317ce02f854f30d6115c41] Linux 6.16-rc7
git bisect start 'a933d3dc1968fcfb0ab72879ec304b1971ed1b9a' 'v6.16-rc7'
# bad: [a56f8f8967ad980d45049973561b89dcd9e37e5d] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect bad a56f8f8967ad980d45049973561b89dcd9e37e5d
# bad: [f6a8dede4030970707e9bae5b3ae76f60df4b75a] Merge branch 'fs-next' of linux-next
git bisect bad f6a8dede4030970707e9bae5b3ae76f60df4b75a
# bad: [b863560c5a26fbcf164f5759c98bb5e72e26848d] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
git bisect bad b863560c5a26fbcf164f5759c98bb5e72e26848d
# good: [6fe8797df6f2e3a7e3c736d5bd4862915a06a690] Merge branch 'for-next/core' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect good 6fe8797df6f2e3a7e3c736d5bd4862915a06a690
# good: [c522d00e1b4b00c5224c2acb9c2738bcc9c04ff5] Merge tag 'ti-k3-dt-for-v6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into soc/dt
git bisect good c522d00e1b4b00c5224c2acb9c2738bcc9c04ff5
# good: [6a323f22a8b925f3646c884e2f9c733c79393f1d] Merge branch 'soc/drivers' into for-next
git bisect good 6a323f22a8b925f3646c884e2f9c733c79393f1d
# good: [5d8b3562faac8030b5c26efc1cd739a41c4db722] Merge branch 'soc/dt' into for-next
git bisect good 5d8b3562faac8030b5c26efc1cd739a41c4db722
# bad: [b79c0d780e519d760c2529f0bf849111b9270192] Merge tag 'apple-soc-drivers-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/sven/linux into soc/drivers
git bisect bad b79c0d780e519d760c2529f0bf849111b9270192
# good: [9841d92754d0f3846977a39844c3395ee2463381] Merge tag 'memory-controller-drv-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
git bisect good 9841d92754d0f3846977a39844c3395ee2463381
# good: [64a026dd896e423a177fe87e11aa69bf5348c27b] soc: qcom: socinfo: Add support to retrieve TME build details
git bisect good 64a026dd896e423a177fe87e11aa69bf5348c27b
# good: [9cea10a4f5a39fde32bf7b8addfa5f9175174e0e] dt-bindings: sram: qcom,imem: Add a number of missing compatibles
git bisect good 9cea10a4f5a39fde32bf7b8addfa5f9175174e0e
# good: [0445eee835d6e59d635e242ba1d9273f168035fa] soc: apple: rtkit: Make shmem_destroy optional
git bisect good 0445eee835d6e59d635e242ba1d9273f168035fa
# bad: [5b8141596b06fba7313cdfbd5f589649d7fde662] Merge tag 'qcom-drivers-for-6.17' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/drivers
git bisect bad 5b8141596b06fba7313cdfbd5f589649d7fde662
# bad: [9f35ab0e53ccbea57bb9cbad8065e0406d516195] soc: qcom: mdt_loader: Fix error return values in mdt_header_valid()
git bisect bad 9f35ab0e53ccbea57bb9cbad8065e0406d516195
# first bad commit: [9f35ab0e53ccbea57bb9cbad8065e0406d516195] soc: qcom: mdt_loader: Fix error return values in mdt_header_valid()

Neil

