Return-Path: <linux-kernel+bounces-841111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFBEBB6490
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27B4C344B21
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C52227B33E;
	Fri,  3 Oct 2025 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oPajp2fj"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD5D261B77
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482121; cv=none; b=MPvx4cErd7ZLM5ZVRMlqkWvphEeaSF061Ssd0HiYVPWNrwrwIjERg7shhR5OFqpswxxQ8TSkerf+Zl4gnXQErAAOYIby/0jkB8PZJKbO6XhbhuzmQBmB4IOVjwXg4SD/2TGwI63rIn1nk20VpXiJ0UWOoK7PP93OMf3bag3yb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482121; c=relaxed/simple;
	bh=2ld2W7PXE3Fjnk8Fmg4gzRneXSYKkf8M/z6fC8H7ieM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZnMjQAYX+Ho+mhUQBfFmf0WJiqaNt2pxW+HP2R0DImW8N2cMnHjHad2CbDYyJCGWVvpL72rPCdNIoSQ70A8PaEUfJgsknrOiOA8Y8vhtvYXsBcmE45VQdUQSaeR5G6uEASxC1EQLoeAYncHbB9OGOjmeAV568Z+3VBnpS3y1D+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oPajp2fj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e2e363118so17923105e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759482118; x=1760086918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8htaH5UmD3BZCsFSEXxOl4TBkWtC5hWepzt68CD6TCQ=;
        b=oPajp2fj4+QyliATVaBcLOcSavorcZVkucJQh1SVNoyPXBdDQTBBg0ozJUtPhGWGrY
         ZgB1CC2i/7OqHK/8EdfggGHuLOdRl4K9iFLmZu/wG3j/TcGwTT237TYZXfEv74eb35Q7
         59xoMxkCEHemEkyBdsRjEnkajrH1Te3vV5DjEJdNB0AMWnTdjs3b9tQYgxc+Jl5MnoWR
         gmxoNTApOCtEOBtS+2hMjBZK+ezxwZ5LnVwMbNMBf5Gw7BEZ9Hut2lSFWql2Y0ttk8nE
         uaNwCeBwHYwK3zt/myzJxQ9mZHV0zh19Syoc4c+NvufhzuXFXyobW4ECoIqMSlyyqNPs
         Y+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482118; x=1760086918;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8htaH5UmD3BZCsFSEXxOl4TBkWtC5hWepzt68CD6TCQ=;
        b=JIK8wfjXH9yPvv8KP/DAIH/b7GNybg6EyuqaIq5Mm9LoYEK+dswNdnRhtyrYh2XsPC
         RsTnDaFpc7OoSh6qm7wwKkfx6PnirqXLmknwPHYdFv9m73Azs4vAf45BRDYtr9PdEBML
         as8nevprMDPgXTuaYI5iDsUJjb0GHxP0jH+mCJPxr6W0Obwyae/Yk8Xot/9HXGrzz9ym
         J83Pjj5jCt/9Accqj/euS+ldIC09qQrMsnCEmTxCdHm9nNbO2ELh4WquqSgVg2zUdz1x
         cJ2zz/Lt/ugnY+GASUIi+GfNTqWf9r6gjkT2h5mj+6DmePhw7FPBVL7SeSZ7dGF3chv1
         e9mA==
X-Forwarded-Encrypted: i=1; AJvYcCXkVIn03GTSgXpsEzlofEnpCCuS3j47ULfhsP7ehazkLMgCgZ1PvkmA0LgcUgaWlZjezJkbZqcSYRWV7e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGAtvD9NxfNCeboorz1PYB9YfMqeHQmpt39IIzk49fJ4njP21e
	zp2YsAarNGjSgxc4A4IE7FkdhaCQIO94quMhEETZX5XNjzRY4d7OzgtxhA8jhM0bYSc=
X-Gm-Gg: ASbGncs4Vqmdl4jOnWafhzXKw7aQ5ocaCb1Kq8OiXQit8TVFURDgIv1KrA9fUGzz6ud
	g0LYtnJ6KTAtAYfeETaTnRFt9ea/z58tkbUDXpIokOKwbrBUJlPZPdqcLqsjYKvpRJrNzCCT1Xl
	5InafADDv/t9/2ae8wBgNYqHVgzTa/NEg2Km7gswklEKJXRx3QN9LditWSCjRq03tT6l9ff9nxw
	BaGS336ZJtoUOHeuIfn1oFCG4y74Q6HFGOecP2LAbtZivf4EOGqdRhI+VZEPCduuz/ncvnYS2TI
	U+acWP2IemYm4aPwRyW4KUW74o67/na4TNjA8lxzUyVR5JV9scm6wE7XrSZB+S4IFp7xsf1tEBD
	+MTDmEk2av2Bbka5hHhN5n4ouyPVsieznJd8yK9i2MeKSep0cPVO0hDF6gGKDM+kDDDCL9Vjq9z
	6LdSPuxSHxEts+M15KHbDLJd35IXo=
X-Google-Smtp-Source: AGHT+IFXXFYBejNEk62TTVbsZCkjTfoWLoHDUC8jbliGeXsvvT//1ANw01aVm2hkqA2pgnjHgXrrcw==
X-Received: by 2002:a05:600c:1f8f:b0:46e:4922:6855 with SMTP id 5b1f17b1804b1-46e71111c0cmr13814655e9.3.1759482117724;
        Fri, 03 Oct 2025 02:01:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1516:b5be:def8:9a0b? ([2a01:e0a:3d9:2080:1516:b5be:def8:9a0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e72362344sm21796015e9.15.2025.10.03.02.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 02:01:57 -0700 (PDT)
Message-ID: <e42176e9-cac0-4142-b463-9eaf86906c46@linaro.org>
Date: Fri, 3 Oct 2025 11:01:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Update Jessica Zhang's email address
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
References: <20251002-quit-qcom-v1-1-0898a63ffddd@oss.qualcomm.com>
 <35jqgias5o4ruhkc72oacepcq4skfzpe4gyivg2pz7bnpy5luj@d5saa7y7rcus>
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
In-Reply-To: <35jqgias5o4ruhkc72oacepcq4skfzpe4gyivg2pz7bnpy5luj@d5saa7y7rcus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 03:17, Dmitry Baryshkov wrote:
> On Thu, Oct 02, 2025 at 04:57:35PM -0700, Jessica Zhang wrote:
>> My current email will stop working soon. Update my email address to
>> jesszhan0024@gmail.com
>>
>> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>> ---
>>   MAINTAINERS | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> 

So dim complains you didn't review with the right address...

dim: ERROR: 261785a47e0b ("MAINTAINERS: Update Jessica Zhang's email address"): Mandatory Maintainer Acked-by missing., aborting

I guess it expects Dmitry Baryshkov <lumag@kernel.org>

Neil

