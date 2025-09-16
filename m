Return-Path: <linux-kernel+bounces-819694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F8FB7DCB2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224551C062ED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99E03294F5;
	Tue, 16 Sep 2025 22:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fr2M5uBR"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CBC2E2DF2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061626; cv=none; b=aNrWMQCRumzfI8QIwYWvBijWtlkKcCnogNI8roEJuKQyfiX7cDxUA+3JaYuiuN3/1jYOmL//2MOFE60/nt6EO6jWJ1lbM1/CHnCaKTv2pb78d4E/eY9JNm7WtL9cBSPlMe++OHHy9llSvxLsn/kVSxi0RnY4uuvGLIWpiMYBAr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061626; c=relaxed/simple;
	bh=WlaeWQkVe2LAkLTFg0HhhUwZq/eeWI5aMBXjarmFyNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPOSpf0nTUvvYYzjuNSaMrQQnZ8t92b9YsmiWhgfDFIC3CYFCnjZKGMYeQzrFvPaRtyHTRc5DI7rwcS+jhoVb1RnkNLeDzv5PPBKvpCfZ8Plck2hMhktC8Q4tPcdQ6qwkzL4xtrhwF8W+1TVPWKFzhi0vcK1fBhiOjNd28TUTB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fr2M5uBR; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8276e579242so339971285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758061622; x=1758666422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u+C7+Zt8EwqQNYjKFusHO5J9TEKhU19Ov+C897qHSB8=;
        b=fr2M5uBRr6Y3huoYNuH7MLpeTMkAVyUHL2zcYpioCgRl/Ar/zoJgHOhdEuFMTWM6Ad
         /tckOfipGFAHEwqs/EHwELXTK20aYChHKSMItHvnO4OzcE9pEPU3T32gsBQn5M8L9T3e
         dP3+Ets4kl4jePyv6jndHH3Ltw409xm7M00iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758061622; x=1758666422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+C7+Zt8EwqQNYjKFusHO5J9TEKhU19Ov+C897qHSB8=;
        b=nVvUa5DHAf2apjU+atyutpxqhUlIFlzzeE5cjiyp1mZV4WrSgoHbgW1CJBsPiNGDGz
         dStL7IKAgYmNGm6dWEBlOdYNWudhX+FdHxvXNWMxaDffk+Q5PVe9aZzNwFnEizWnFCqE
         UdEwYqKMlxv5PpMTT69XMUb5tBgqQednNydOeZV8mqFdGJ5umeAul6vzlJzwGy1ftMiZ
         kvVlX2O7lNKUuBRrB28vdLoWgdccjVBGOlb2xkVuhVGCPfJQG3rRH+rmJrbYTHkzZNRS
         a33AtZGgB88ll9R4WO7g8HzE5itLqc6r3jeGFSNpIXcZcqUV10pRypy2n/t2tj2ZhIkY
         836A==
X-Forwarded-Encrypted: i=1; AJvYcCVRFRorkxsei7N8Q4YeHzVPDZQaQUBgijY8Un2B+wFWtgMM7OljrcFcqDFOmxYCAvFvEbjI7/vYcVzeavY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz29HajS0oKug5aCLK2v5tRNNBS8ZegJUvsmDj8WoVx2nuv7BPS
	j2qbA6zpYjV1tb3zSx+6Dobpb/qqP53xcZwKAnGHyc97KG0NiclyrduT38uSAOrVrdY=
X-Gm-Gg: ASbGncvjOkgAt7ck8qEaaIB/la7uOJYNc0IEgzSfimS0/AHnFca7rOzOcq+Shv3xgp1
	3XHkBMzdbyibPZq6VonnHSpa5ftINMFvGaMVtxPJz/bFlPjmfO7hI8T/se1rSbls0zz9IWOf/KU
	FZbFHox5ZsStSAILUKaG0N3ni+aepnf6bTE+zh2yzmX0FBoabD9lvgCdUH1gPUdODbktN/0BqUO
	rHsvradxaSFuwLI/p90ssEGyo98Nuh8gfVHDg0hVsod9fJPLmuDQvyV3TozQk8pSw70mLSC0GWV
	FE1f4/5cuCy7vYdbM0i4KRTpaQSJgc0wfW7bwNHb2cqLRiGkcGikh5t8iZKjzWRmiWqHgyZe/wy
	4UcR5L3g3Rf4t5Spx8hN/2QAltYz6sO1mOBuZYdWbSrmnQMGHpUVIh0Q8ci4+OCqjEWwiHhjR6C
	zifPxz0aclH2Tjn2w/zcFFd0hgHQfd3e6tRSE2d59n4Jk=
X-Google-Smtp-Source: AGHT+IF8A//xxU9vWTH1NoQ844ar3JLd4TAf1UCHnEk5uY15aQNnLfP/3PdhKcb9dUMPQUzrxddg7A==
X-Received: by 2002:a05:620a:4629:b0:828:ee0c:64df with SMTP id af79cd13be357-828ee0c7269mr1213078385a.57.1758061622245;
        Tue, 16 Sep 2025 15:27:02 -0700 (PDT)
Received: from [192.168.226.35] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-827e59af36asm645591885a.46.2025.09.16.15.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 15:27:01 -0700 (PDT)
Message-ID: <5a9e1ecb-2905-4318-8669-c515568e1d42@linuxfoundation.org>
Date: Tue, 16 Sep 2025 16:27:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: fix memory leak in print_{on,off}line_cpus()
To: cryolitia@uniontech.com, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 niecheng1@uniontech.com, zhanjun@uniontech.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250827-power-memoryleak-v1-1-e4baf7b59a41@uniontech.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250827-power-memoryleak-v1-1-e4baf7b59a41@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/25 03:46, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> {on,off}online_cpus_str not free after use

How did you find this problem? The memory is released when cpupower
exits - do you need this free?

> 
> Suggested-by: Jun Zhan <zhanjun@uniontech.com>
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
> ---
>   tools/power/cpupower/utils/helpers/misc.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index 166dc1e470ea6d70079fea6570750885d549603a..f3b4fe95520ff96a1be8b1ba8e7be1ec116b1bc0 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -213,6 +213,8 @@ void print_online_cpus(void)
>   		bitmask_displaylist(online_cpus_str, str_len, online_cpus);
>   		printf(_("Following CPUs are online:\n%s\n"), online_cpus_str);
>   	}
> +
> +	free(online_cpus_str);
>   }
>   
>   /* print_offline_cpus
> @@ -232,6 +234,8 @@ void print_offline_cpus(void)
>   		printf(_("Following CPUs are offline:\n%s\n"), offline_cpus_str);
>   		printf(_("cpupower set operation was not performed on them\n"));
>   	}
> +
> +	free(offline_cpus_str);
>   }
>   
>   /*
> 

thanks,
-- Shuah

