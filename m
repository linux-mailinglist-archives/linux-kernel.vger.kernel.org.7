Return-Path: <linux-kernel+bounces-802601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE046B4546A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858F51C86AA6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135DE2D541B;
	Fri,  5 Sep 2025 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GYj4I6st"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7350A2D47E9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067659; cv=none; b=dRAq7mlGlqMEkDijyyDQF1Td88z99HyzhnvTQVKUwMTnpgCQbb9Vjdl4krAm/o//mAd6O45Ui8Zb5dZUA13YsF5u+LNwhv9RL44fY3yr4Llziu6UHrApaF5ybdNhHbWetl4MKSQCv6JAD4QDxG90IJzznzN2TiD6uhqVyJjiw4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067659; c=relaxed/simple;
	bh=9DaGRIMFa5wnuM+lDqhThXQvVMo96FKQFngkI10LSAY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aOjRl6WfbTgCaiz4ICkjlE20SyEKdHTHq2FJnA5fy7ShIjGC6GcgJ5Vk2Ed9X1QnrnsW+qo9KTf6jOrNzigebJqaSbNDaDTVo46y5GGlEshL/Ue5IcW/nKYHi9eEdkD5i6Dvaq4W1l1g3f+TrqGch4/G6PqQooth0rl1v5TwXv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GYj4I6st; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so16231005e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757067656; x=1757672456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5vez/qigeUN3N+Im1RmVn0JRRYgZnIjim3ZE3xXKic=;
        b=GYj4I6stvYQARh2Phrm+3WG+YktUBi+XVQM672ZXMzS2SXdDDRknZsHenpj13mh8/7
         bBuvzm87ancmFp25gs+60EJdex4YF3ZWLfoofkgbRbY58AuUo5y7GYSbFLPWZeN7jmrD
         YhFfnLupO2wZV4OfX6dLBLfZNDUMHtFPoERdB6GAqU/oU+MYO0kPJiHmkLND8bKfqyLK
         T2yC9ZQC34R/RX4r8Y0ScREcA8kHM4b7pTn9KYPd9KIVrmiHme2V8zVdOaxZTCnlFy7X
         mtb6F5Z5JvNjEOkozkiItO5r4ojr+vkg7Jm6JLJRS07H0wVrYd1kk/bWpNptNA+sp2Uf
         aOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757067656; x=1757672456;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g5vez/qigeUN3N+Im1RmVn0JRRYgZnIjim3ZE3xXKic=;
        b=swOlpwY+Ey68YwEZkw7CGRxdoa/NW39yMq0o/ahstqH0yuVNVqTxtXItw0m1gtUVqq
         ZGR6xbnuroIABbxjpoU2flzKZDmGCPLEJNPjLkSSmyxLf/gjsuutQEaZB7vWpRUtWQb7
         j59INakRJ0BaFVh9SujcZ94j1Ba2UvpyU6WLHLkh8krnsOVdfT74HgHj4wTyUvKtSxi5
         FQIKdjdqkF37miMVlrM8adckTqEHus4cRKzh6vOm3dTVjzgZPQMM4onbLD93hHirznvE
         smlqRBirTbpKrj5xkngDpRUl88RRgKi4foICc1/fMEJ+9e+zrReCPGYLkdq/28oRdOIG
         KsXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwYkE9AVNsnH7idvBSpYXdnSKhi/qUPTVG7qBkAQSj6GHwRJbxGN16KuQBbAprCkvqq0OvS+auOrNl7eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmk3E2PT675ZzB8AJTrotg0FG8SCMaoX/NKkoczXvv+5ZisnyK
	5QkPA0AAbkl3TL/kUI3AtVUpw9dFInkEmZcdN56p5UQXws/KRl1+1D6kXvcuplSpzLE=
X-Gm-Gg: ASbGnctcLaH63acQ78+xVWdHfDdaGp2iYvaZ1lgyIzEg563vIw12Zjm6o7VZt7nR9Dp
	gd3zgpoFkXU04gGaJye0gFZkmrBh2ax+6Rbtsge/QQxcROE359NFE40ldg52QJy2ooZTIDhntC8
	UvqhiY2PdYD/nnkziWbQAfs2EVaNvV474mYy91WGc2vwqR0d1PhyEN+KLuJIaHKWn41nNBlgzay
	JeusGSiauqmRfqnyGXhgXOT928srBIOICrzqT4R0u9qFZ2zBC9EvAzEcWGGvBhB1GPHYlSZSB8p
	Uz65I/oWCtPfaUAYBZhn6ffGGAB6tYb/LPfq0uEEV8+piIIYXCW5eSLLTHZ8CNsuvJunBI46PCz
	NnDlDw8u1nYCLg4cADdztISmNc5J8hSiJ9DvB28mgqBLm7YKv+Fz9IRTSZZT6lW8QCYPsX1yn0+
	YZnQKmiMNsodR9Ve+AYDZ2
X-Google-Smtp-Source: AGHT+IGQiU+kRp+7oSBH2pZIbGwL4AQMXeMBFNpTuAKX09/3FoPn8L5rNkO2mZKlz4GakzCW+U30BA==
X-Received: by 2002:a05:600c:1c88:b0:45c:b52d:8d30 with SMTP id 5b1f17b1804b1-45cb52d8f28mr86216625e9.26.1757067655677;
        Fri, 05 Sep 2025 03:20:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:ad6e:d9be:21dd:7b96? ([2a01:e0a:3d9:2080:ad6e:d9be:21dd:7b96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb61377a7sm115282475e9.13.2025.09.05.03.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 03:20:55 -0700 (PDT)
Message-ID: <32d93739-0ea9-4b75-ae73-c0c8b10f2c3b@linaro.org>
Date: Fri, 5 Sep 2025 12:20:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 00/11] Add cache information to Amlogic SoC
To: Anand Moon <linux.amoon@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Jerome Brunet
 <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250825065240.22577-1-linux.amoon@gmail.com>
 <175699250964.3374853.16885676491827667777.b4-ty@linaro.org>
 <CANAwSgQGCTs46DVm3gt4PpdSTBTvVg5zga_oBt=rUJh2yhRLtw@mail.gmail.com>
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
In-Reply-To: <CANAwSgQGCTs46DVm3gt4PpdSTBTvVg5zga_oBt=rUJh2yhRLtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/09/2025 06:01, Anand Moon wrote:
> Hi Neil,
> 
> On Thu, 4 Sept 2025 at 18:58, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> Hi,
>>
>> On Mon, 25 Aug 2025 12:21:40 +0530, Anand Moon wrote:
>>> Most publicly available Amlogic datasheets mention that the CPU employs
>>> a architecture, quad-core ARM Cortex-A53 and ARM Cortex A55 and
>>> Cortex-A73 and Cortex-A53 cluster, sharing a unified L2 cache to enhance
>>> overall system performance.
>>>
>>> However, these documents typically omit details regarding the sizes of the
>>> L1 data cache, L1 instruction cache, and L2 cache.
>>>
>>> [...]
>>
>> Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.18/arm64-dt)
>>
>> [01/11] arm64: dts: amlogic: Add cache information to the Amlogic GXBB and GXL SoC
>>          https://git.kernel.org/amlogic/c/d7fc05da8ba28d22fb9bd79d9308f928fcb81c19
>> [02/11] arm64: dts: amlogic: Add cache information to the Amlogic SM1 SoC
>>          https://git.kernel.org/amlogic/c/fd7b48b1f91e1830e22e73744e7525af24d8ae25
>> [03/11] arm64: dts: amlogic: Add cache information to the Amlogic G12A SoCS
>>          https://git.kernel.org/amlogic/c/a4428e52babdb682f47f99b0b816e227e51a3835
>> [04/11] arm64: dts: amlogic: Add cache information to the Amlogic AXG SoCS
>>          https://git.kernel.org/amlogic/c/3b6ad2a433672f4ed9e1c90e4ae6b94683d1f1a2
>> [05/11] arm64: dts: amlogic: Add cache information to the Amlogic GXM SoCS
>>          https://git.kernel.org/amlogic/c/fe2c12bc0a8f9e5db87bfbf231658eadef4cdd47
>> [06/11] arm64: dts: amlogic: Add cache information to the Amlogic A1 SoC
>>          https://git.kernel.org/amlogic/c/2d97773212f8516b2fe3177077b1ecf7b67a4e09
>> [07/11] arm64: dts: amlogic: Add cache information to the Amlogic A4 SoC
>>          https://git.kernel.org/amlogic/c/57273dc063d5a80e8cebc20878369099992be01a
>> [08/11] arm64: dts: amlogic: Add cache information to the Amlogic C3 SoC
>>          https://git.kernel.org/amlogic/c/6d4ab38a0a21c82076105e4cc37087ef92253c7b
>> [09/11] arm64: dts: amlogic: Add cache information to the Amlogic S7 SoC
>>          https://git.kernel.org/amlogic/c/494c362fa1633bba127045ace8f0eea0b277af28
>> [10/11] arm64: dts: amlogic: Add cache information to the Amlogic S922X SoC
>>          https://git.kernel.org/amlogic/c/e7f85e6c155aed3e10e698dd05bd04b2d52edb59
>> [11/11] arm64: dts: amlogic: Add cache information to the Amlogic T7 SoC
>>          https://git.kernel.org/amlogic/c/e97fdb9b8a0f8bd349de48815694f8a7200e3d62
>>
>> These changes has been applied on the intermediate git tree [1].
>>
>> The v6.18/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
>> for inclusion in their intermediate git branches in order to be sent to Linus during
>> the next merge window, or sooner if it's a set of fixes.
>>
>> In the cases of fixes, those will be merged in the current release candidate
>> kernel and as soon they appear on the Linux master branch they will be
>> backported to the previous Stable and Long-Stable kernels [2].
>>
>> The intermediate git branches are merged daily in the linux-next tree [3],
>> people are encouraged testing these pre-release kernels and report issues on the
>> relevant mailing-lists.
>>
>> If problems are discovered on those changes, please submit a signed-off-by revert
>> patch followed by a corrective changeset.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>
> Received feedback from Krzysztof to omit the comments in the commit message.
> Should I respin accordingly?

Sure, I'll re-apply the new version

Neil

>> --
>> Neil
>>
> Thanks
> -Anand


