Return-Path: <linux-kernel+bounces-889436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8DBC3D8D1
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 23:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222EA3B2801
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 22:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACA830AD11;
	Thu,  6 Nov 2025 22:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S8g1w3Zw"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BC230AADB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467109; cv=none; b=O8/PAmggp/Jy1q1OOP2vryqwGr9Kd3sQ+o+yNX6rAADZ8KTsXanI5kzhgdfLFw73HNSZtxSfeLgJokBWa8mFOhneFs+cCnMdCFBbjDRCsWobDuP/JptVTW+lZqj3IG75ne9K/oIPDuq6mSv0w9JcFQ1fNT+13ZNZFgbGUmIU1QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467109; c=relaxed/simple;
	bh=Bi2Yt4Ngg6ixxYQSJNuK/iEuLrWfWoQ6o15OZw1g1Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ROKJ1ExT1/tKC2f/uImvrEuz1R765Ab8CsHQYVKHfUIhWRenE+cUsnit+0y/LgYNYISbuiuRzDmV/3G6lx1zxbmCLWthpxapAyl+qZrgBH22oxIIxhnQhzZC7Paf1JCi8zZyC0HiY4TH34BcTF2J82X2Ao4TSFi0kbbUE03upLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S8g1w3Zw; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-948673fdc47so4126139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 14:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762467105; x=1763071905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ABbZOPBq1dfxtSa36L+4dZcBVwYdc+U8A9iGTSp5qas=;
        b=S8g1w3Zw3f6cPXiNKO7r1dH+gLKZmTn6D4FCi9rqXmmJluN3YppE/fUlcUPvrP47sx
         OzHZ86auVoFSMzgBZ8wAYZxqxaDZPZK6xSd0CHdlWKmDhvw5UiZsOypVJh534GQ65Jhn
         GWU/RNUB0h8Sgcd+1To3Ni0kM9AO3HEG1/Z64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762467105; x=1763071905;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABbZOPBq1dfxtSa36L+4dZcBVwYdc+U8A9iGTSp5qas=;
        b=hz1UGpcZKJphbXR1gTMOPZYn2HEOV6Hhry6FDpZ2n3Efq6KC66tCG2NcTqyVrlwk2v
         z4t031LVKZ29uqaEKhwnsex6UU+fj2YAmIsnxQRG5SYC7XK89USbxaaPUaWP+n8QnSAD
         0xbDBG/br1Be1d0cEWO2mSybkMEhcqIdyN2oyYSH0mkUYBpyi8mIor/HLFz1ZB9kaul/
         vRA6Yd4Wo9SIbKePpMsUEz+g+IHyNrDJ92iVD8mKuz9b/Zy/JzJjjo28rZ00r8WbLm0S
         ePXgF3IxuCpO30CDvWLqu2HWhyklwgtWdyUizKJNJsOdCw4Q4QX3atbA79ZzacGkmgVn
         Gt4A==
X-Forwarded-Encrypted: i=1; AJvYcCUWlLXqXz3jzkm6BVUMr63SKB8xZ1icH9ywohNysU1+0GzaAc5GToR62CT4mizJzNOzb6NjQgyYJVYtTho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxez9/KtQ0xxH9CiHS7s2IncVsseXhJbv6mG8TJP4HnKbT7mCb1
	BvogaKri5n9xLwsFOA27NQZwMIVwrpzgzbR150Pk0mduRDVmzzeU/SHPZaxIgbxvLQA=
X-Gm-Gg: ASbGncv3NkhtrvAI8o/eXRozFx63fCy9lrG2bcdqJGxlCT0xN629ro4kijQNpvRp38j
	tnCeVmczWlyU4hApdr6g+XawDRvw+dmB1yJBSv3HrLEOuCk7elmUIV/LZkjTPB9i3Hp091B4GQo
	b184sWnMkkm4G5mYbcNJxUVOeodhyuH3HAFCR5YkxZeUalYAtHev/tnw8NylnFUoj4i9Ayjm0O2
	Mw5B7jm5yStHISlwYxaKFiumyIHNUISAzL0OTiTdljchEi15QK6vm/HhCfZgI7sYkXSKWwxfPa5
	QE0+WDbuwToaaC8SpS+S3uQT75iLDHNzei8fzhxO9+keUlMgbUGw0oXq3h0/lW2Dwl31CeQxX3j
	bwKeUynwnBrdVedFPkQvwGyV5j78Y+tx46TooPtQgJ7dWB+O5SuvN5UFKzqDe97NoG9aAHx7dtP
	HXmtUcJ3tfx4vm
X-Google-Smtp-Source: AGHT+IGkxzH4f9BKMCWmQ5xEz4PiUURagXcKMgKwkO27ppVtMljJUXfPmqbiwiBOR5OWXl+uA2Cgtg==
X-Received: by 2002:a05:6e02:1947:b0:433:5ad1:6c69 with SMTP id e9e14a558f8ab-4335f42e51fmr20094685ab.17.1762467105571;
        Thu, 06 Nov 2025 14:11:45 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4334f45c7d9sm15509785ab.16.2025.11.06.14.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 14:11:45 -0800 (PST)
Message-ID: <787bb77f-4271-43bc-96bd-4e22895d761b@linuxfoundation.org>
Date: Thu, 6 Nov 2025 15:11:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/dma: fix invalid array access in printf
To: Zhang Chujun <zhangchujun@cmss.chinamobile.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251104025234.2363-1-zhangchujun@cmss.chinamobile.com>
Content-Language: en-US
Cc: Shuah Khan <skhan@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251104025234.2363-1-zhangchujun@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 19:52, Zhang Chujun wrote:
> The printf statement attempts to print the DMA direction string using
> the syntax 'dir[directions]', which is an invalid array access. The
> variable 'dir' is an integer, and 'directions' is a char pointer array.
> This incorrect syntax should be 'directions[dir]', using 'dir' as the
> index into the 'directions' array. Fix this by correcting the array
> access from 'dir[directions]' to 'directions[dir]'.

How did you find this problem? The patch looks good to me, but
I do want to know how you found this because compiler doesn't
complain and I can build this fine.> 
> Signed-off-by: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
> 
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
> index b12f1f9babf8..b925756373ce 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -118,7 +118,7 @@ int main(int argc, char **argv)
>   	}
>   
>   	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s granule: %d\n",
> -			threads, seconds, node, dir[directions], granule);
> +			threads, seconds, node, directions[dir], granule);
>   	printf("average map latency(us):%.1f standard deviation:%.1f\n",
>   			map.avg_map_100ns/10.0, map.map_stddev/10.0);
>   	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",
thanks,
-- Shuah


