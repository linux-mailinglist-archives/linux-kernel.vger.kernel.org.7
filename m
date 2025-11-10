Return-Path: <linux-kernel+bounces-892443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B6EC451C2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90DCE188EEA5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D342212551;
	Mon, 10 Nov 2025 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDz545vz"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D16D23BCE4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762756825; cv=none; b=JohM+zjM5jYUvQ0hCcZ5Is8JCHbOb6eCrNPwvPGPwRNIH2ojvEThwGcvhQ0h4yZPyQyteIoxAoy3IB25kRcKEwK1J24vOzVirKvZRaoyg+yfiLxXJIA7T0NpXkIVyy4kO1i/4avUjjsDW6bfWalz3KAMdIP8a4nVL3B2G/Dclho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762756825; c=relaxed/simple;
	bh=KigUZ2jK8l3FAFeu8HfbDV/ulYwYwMOzZCAktxcvJQk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EM+sCHLg3ywEH28Ij+WvhLfxjlSBIr+/Hw5lIpuSXMQNHQcbR9biXCjtuaA2WXzWBoIFfxWZ4GBBiTD+kbsYeLy28mlxpXjioRHbF6Jc4A+uPZ0Hs8uqTh4NJltgXj8u0+6hgToMAeUiT4bahY62dYKBquVlHtsVtbvOkwy5lnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CDz545vz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so12346625e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 22:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762756822; x=1763361622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JD4y8dFL4Qc3UIMVu1ByWGHKasnWIhJOmctGKB7rHNk=;
        b=CDz545vz6s18xFePAd/R0A6HvnJQrY45YZyaR65gAj6JjhXUpXlM1KpIaZvaOfAIIC
         FeYHwC0MavRD8mqeMQcFEDsYg9iz2tu4m0eoxz8eCVr+cI3pX7tBaWnBTF56r6Zdmuou
         VoCBPGHPNc7wTaRK7b0/XXjyJu3C05TI1ZjTxPaFf5Q50In1xJOSp7ooIifR6Gm3hQ23
         YD/owhXMqQxLY2JCJAfL9DhbK78OBsmHCt5p9hxuuVp5XivH0PrXrIKeUJRwWh13IUTu
         iN7YF7E/hLe5q2pFAKr+K8LE4W+F+DKHUuxRMiwEfMC06hva+edzX57N5CnaTOXuER08
         9t4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762756822; x=1763361622;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JD4y8dFL4Qc3UIMVu1ByWGHKasnWIhJOmctGKB7rHNk=;
        b=mlgZvVSdnqpHnR/vNY4iIwIBI0pY8yINMutfoX8UvfrSb2GO6IrG60N1S4KAzPmnK7
         TvERybGE4WiX7VrmGGmWmIzsZk0sWEMjt95XVS+bnDkRG3m6uy+yCSgHjppDwxf5cd00
         j1cSxB5CNenmLsNxzqhVJAp7NXeoWocAYJ1izqyBA43uKwt/WH1ZJ/sW4lNi0PZ+3RI9
         oTTr+urn0tZ7d7F487n6l2tHumvAPB4x0yqOKYseWWNiwz4H11nsamchd3/YV+aA2j/E
         eFRVPflznHgCdXVg/TavbyvK3T65gXI+wGigNfHQ9XPgDTUYDFN+SJdcdAkEKHOvehxV
         CsYg==
X-Forwarded-Encrypted: i=1; AJvYcCUI8vfMCVT/SOtZ+VHfya0i0xb5bDwjZyIBU3041E/jFNauRsvhan92qWLYB3EuJi/Dn9bEbWMQmDJG97o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXTDpddns/jx4t15XnFIyCXtAzFYOjYr6Uu8r+ziF8R4Nw87Nz
	OCJ1WWIp/llB1v4yKoaKEw0XxujPGm99ZRIpEs49lJXfGmYwNYdpQCwbmaZI5zh+q0U=
X-Gm-Gg: ASbGncu2c+7fCEw2JoBwCfhpupj5xe3kyhzMamMP4m3YrQX7PWxwHz+tBFr4Z5oOLUb
	v8rmoKBDf/Y/vOLA39U8utwTPoq8bSVUgjtuUfS7ASiygyk2uyv0TZ36+lrsLRnEoym38ZLsgbe
	t2GRmdjHL2by+kDGc/kKY548+EPZJjO9JoKAqtmZum1g1NtSLrQ2UjtoNbJFqA6CigJIF9NfI4P
	NbXt/u4KRAQZWYLRd0NIxqTYKNyBqbeV91wRVgk7X0Q78xc6Gopr6DKEdYbEzbjq50G4zinPky1
	2XlVt9N49JGeV3FXscDa7/Wuk7NfHlqTewoRLk5G3YBurJE1WWnWLqgC2Rxo652O75v+dm+GHZi
	WtYzGaD4FCkYpERyvNamwwJYYx85tvEvTVKsWaW44b8Qwic7rFj5huwcYEVDWN0TYz0PmiCbXnB
	K1ggcVWe8c9h6I5Fwv1IFPzHr+LGmG+Wtsu74FB7T9PQ94bxi+zsvOji6jivutQRk=
X-Google-Smtp-Source: AGHT+IGOz9+9CDJ3QnsnAcx96wfbo8Uh+Kija8Qn/BBtDb3lYcNFsN3pjUBwX1/h1H29lxDD/6wJ8A==
X-Received: by 2002:a05:600c:4448:b0:46e:206a:78cc with SMTP id 5b1f17b1804b1-47773290517mr61287685e9.28.1762756821769;
        Sun, 09 Nov 2025 22:40:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:f168:a23e:c1b2:ae61? ([2a01:e0a:3d9:2080:f168:a23e:c1b2:ae61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763b5714dsm111549355e9.0.2025.11.09.22.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 22:40:21 -0800 (PST)
Message-ID: <b341a3b3-c215-4335-a962-799a64a3c1b7@linaro.org>
Date: Mon, 10 Nov 2025 07:40:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RESEND 1/3] dt-bindings: PCI: amlogic: Fix the register
 name of the DBI region
To: Manivannan Sadhasivam <mani@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Yue Wang <yue.wang@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Andrew Murray <amurray@thegoodpenguin.co.uk>,
 Jingoo Han <jingoohan1@gmail.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
 <20251101-pci-meson-fix-v1-1-c50dcc56ed6a@oss.qualcomm.com>
 <31271df3-73e1-4eea-9bba-9e5b3bf85409@linaro.org>
 <rguwscxck7vel3hjdd2hlkypzdbwdvafdryxtz5benweduh4eg@sny4rr2nx5aq>
 <20251106-positive-attractive-tiger-ec9c1c@kuoka>
 <lsue7hlgybqpru3qfetlpee2mswnycvhxjffwyxtplmpqved2u@aohtwjtxesr4>
 <65hstqcfcca7xj3cdtq7iikcdojbltfu42zlfdelskakesu3cd@hl3kydp6dw2t>
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
In-Reply-To: <65hstqcfcca7xj3cdtq7iikcdojbltfu42zlfdelskakesu3cd@hl3kydp6dw2t>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/25 11:40, Manivannan Sadhasivam wrote:
> On Thu, Nov 06, 2025 at 02:37:17PM +0530, Manivannan Sadhasivam wrote:
>> On Thu, Nov 06, 2025 at 09:30:15AM +0100, Krzysztof Kozlowski wrote:
>>> On Mon, Nov 03, 2025 at 03:42:58PM +0530, Manivannan Sadhasivam wrote:
>>>> On Mon, Nov 03, 2025 at 10:47:36AM +0100, Neil Armstrong wrote:
>>>>> Hi Mani,
>>>>>
>>>>> On 11/1/25 05:29, Manivannan Sadhasivam wrote:
>>>>>> Binding incorrectly specifies the 'DBI' region as 'ELBI'. DBI is a must
>>>>>> have region for DWC controllers as it has the Root Port and controller
>>>>>> specific registers, while ELBI has optional registers.
>>>>>>
>>>>>> Hence, fix the binding. Though this is an ABI break, this change is needed
>>>>>> to accurately describe the PCI memory map.
>>>>>
>>>>> Not fan of this ABI break, the current bindings should be marked as deprecated instead.
>>>>>
>>>>
>>>> Fair enough. Will make it as deprecated.
>>>
>>> The true question is what value was being passed as that item (ELBI)?
>>> Because if this was always DBI - device has DBI there - then what
>>> deprecation would change?
>>
>> Nothing, except not breaking old DTs with the binding check. That's why I
>> decided to remove it in the first place.
>>
> 
> Neil, do you still insist on marking the 'elbi' region deprecated than removing
> it?

Not really. if the original definition was wrong, let's fix it.

Neil

> 
> - Mani
> 


