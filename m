Return-Path: <linux-kernel+bounces-844825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D9CBC2DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2324819A0D9D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D907257830;
	Tue,  7 Oct 2025 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZChMU1MJ"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC7246BC6
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759875816; cv=none; b=F9+WlekJrnSl95V2yZaMznyd5VTrZKLVw5R09Cf8uiYyZ8u9QL6aR2V5ct34wmzblArtohMIAx2vJYd1GI715YJkVJU2AzY023tRMpC54CdCaTilY0Bhbn8/epmLWAM+HDKmL8XICADkGDro558+atoyLLiLZhU4xP5DR7WO1RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759875816; c=relaxed/simple;
	bh=HLZmmlnEOK/+rMounk1d6rjHNRAMTqkMP+AI0sVPxqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfkU7mBP9W5eMBBCB8ooo162DBdsHPThWJXAvGIUVTxhKh435IEUWMEau8l+usLz6mzno2fpqEyLV3eXCJ83CzZvcBoKNrksrtj49v5r6pt+kbUF8GbiG6PiTAjcWD2sP8/3gKXNszIDum4Q62La6zF1Y5S5F/AsZKHs4g9Wsn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZChMU1MJ; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-9298eba27c2so292102939f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759875813; x=1760480613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31cl1fXsRMYUJckHJxsY+0hejvaCKyOwda/UZ5hvf0k=;
        b=ZChMU1MJvOP/ks0opwlGuml6MO0lhAxbtz3U/aFiq/Eb+yrIZcTePES+1ihhPvO9Es
         Lwiw+ZU/RHV5wiXrXeRw2B9q/u3UYLooOLkwfI8MLE+vGzphWiSJgQQbHDBAqQR2fC8L
         9vzwRIkkNkSq9fzecwvMvvpLpCMosIn9sB3ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759875813; x=1760480613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31cl1fXsRMYUJckHJxsY+0hejvaCKyOwda/UZ5hvf0k=;
        b=wfsRPDrTX/QTzfyldhF5KaBMMLe/jK6TsCRD7OqGYKGOTgp4/RH+p4SwHrzvgyOAZD
         4aFvpIBf9fuupdHPqI2o0UCdSbF2BMXNZuCBtadjD7FB9hTodg3B+xLj6no8WQvfAE3+
         YwsdGBL15QfnioqC/ZNxv+wE2Kfrb+lWeH5rxr2sefmDLOsUmN4NkWHi7ybqwqS+/vhA
         t5PmeAbC4TcoZJXZRNZVLpQAC4dXzqS78lJnSZO4Y8usK2dRdpmHYRAWkRYWVOSKFbPe
         R9fTprF6aWhifMaOn4HHZvG0fFUQG3Ws4lho4OQhVjZoEslOyBr68EwzUr0LlMDV6y7y
         pkdg==
X-Gm-Message-State: AOJu0Yx63idIMDoWhPaTnfbxUhjJn7xFsXfQjR78TwUV9GWLgwfs/CYJ
	agtxK50LhZ4gP9bwTS1WoQAuXjrnj/cxhNPaXOJmTbht5HmhzzRgKv8zfV//oMI0HqU=
X-Gm-Gg: ASbGncsD5eOvEeip6RkKbB2ID/wtDuOLwjNoz12cXbsqlUxaaa5qRwfA9Rb21JiMmtr
	S1jDg21DdzshMK0ch729D3E3q1yQgMn3asyeC2W+RDUUokL30hd932oCm5xNMsWwPsaWlWoWxi7
	qXkL+47qvUaNBNRw98y/WMRbINxG6w9K7CVyh6XbHzATMISx9Bk8olmYhMTa6nBy4EMIehtJvtn
	3WsEuDlHMCMVeJGgXS2GKerN95Wh1VIdWJpNxJ8V86lo5JPDZz3vaeErGvwelpJmDl3/hRxWY4q
	E2aDtmJQz5NK/bnYoA+PakKpbOUux1xKTAr7OXmZnxSWGMrYN+smghfqq2FsTtiPuD8G+p9+Cz6
	cszXQ2175MqGEg8fh7S1nv4GPVf17sWzOgwJPtz5c2jkYfHb9HkRpl6yWB0c=
X-Google-Smtp-Source: AGHT+IHCuNQVRRlLttXQ6quBeFGnqpFxQ1Yq9OjeBe2AwvWKaea5kF8NxYMgZLk9O/aGpWrj4AMUXw==
X-Received: by 2002:a05:6e02:1d8d:b0:42d:878b:6e40 with SMTP id e9e14a558f8ab-42f8737f064mr10813735ab.13.1759875813476;
        Tue, 07 Oct 2025 15:23:33 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b215dd6sm69116115ab.14.2025.10.07.15.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 15:23:32 -0700 (PDT)
Message-ID: <10082c41-4302-4cb3-a2bf-788e59bad0c8@linuxfoundation.org>
Date: Tue, 7 Oct 2025 16:23:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: cpu_rmap.c Refactor allocation size calculation in
 kzalloc()
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250930092327.27848-1-mehdi.benhadjkhelifa@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250930092327.27848-1-mehdi.benhadjkhelifa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 03:23, Mehdi Ben Hadj Khelifa wrote:
> Wrap allocation size calculation in size_add() and size_mul() to avoid
> any potential overflow.

How did you find this problem and how did you test this change?
> 
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
>   lib/cpu_rmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/cpu_rmap.c b/lib/cpu_rmap.c
> index f03d9be3f06b..18b2146a73d2 100644
> --- a/lib/cpu_rmap.c
> +++ b/lib/cpu_rmap.c
> @@ -36,7 +36,7 @@ struct cpu_rmap *alloc_cpu_rmap(unsigned int size, gfp_t flags)
>   	obj_offset = ALIGN(offsetof(struct cpu_rmap, near[nr_cpu_ids]),
>   			   sizeof(void *));
>   
> -	rmap = kzalloc(obj_offset + size * sizeof(rmap->obj[0]), flags);
> +	rmap = kzalloc(size_add(obj_offset, size_mul(size, sizeof(rmap->obj[0]))), flags);
>   	if (!rmap)
>   		return NULL;
>   

thanks,
-- Shuah

