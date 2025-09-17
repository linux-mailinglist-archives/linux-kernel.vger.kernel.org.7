Return-Path: <linux-kernel+bounces-820755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72902B7F14D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353C35283B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D155833C748;
	Wed, 17 Sep 2025 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpDI0AcA"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4422FBDE4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114054; cv=none; b=XnoGH39WHX6e4OJ49q3YpQVfrURV1Nk9cxLH5djlHd8Tq2nJ+TK1FMGaNPBtXjaqR/yPo30avcb3h/IO1qpt9SxOrg6ApGJsPejbn/pByD3R5dp155F3m0fWpxVNbdWvQJlSYb1w4k2+O/zHQvymJHXntKC8ZaZzgkQ7HlQRMSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114054; c=relaxed/simple;
	bh=wk9RXuVqpXxxFDzmO7M+cLF30Msy65hjjIojj2YuEdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQ3GR/OQOGBKc2viXpPIz2k/tIJhi78gM6zAOa7chQDnfuYXd31i1Yr0YT6cDFSYP1Rce2aGmnIVugEQZG7RVidJG5wOPysKyVIcagRmz9L0GY6ORgA/vf3lvPYNPa0lUg44pKrNUbBlzu+5Hqcsuc4EHeqkp1aUn8KFnFd4zSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpDI0AcA; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b5eee40cc0so64376241cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758114051; x=1758718851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X00c/S8lQpFd+72iK9PH+Axt2hlWX60fuXCEoXNETw8=;
        b=ZpDI0AcATciuya53zosHs+bmnW3OTx8VoXWz6sTxo/0uJTbjLtVFUPdnuwYLprGuRy
         bQcJ+kcAJPpDmClQUDIW2adQfTWzvVywMsZtJQgdc6Sv5DSS3SneCPP7ATe4Kt0l9/wd
         uids1L5u3xNU2mPVpMNrLw8YuarAyK5e9L36hcmUR7wSv65wP7MaSf5/ntQmXR5Dfmy3
         +mHR8f4ptCv2QXkdkwqrrQQbupELYcOCFhE2pc0uTB80ERRb6rUJIQWU6RCMDCFz7/0c
         pfb1fb7OSQAFFrpBdeavuT6IKg/opxA6wE7qUkwhulaZ5UMuiC4/WwLrme0FyONloy7N
         zxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758114051; x=1758718851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X00c/S8lQpFd+72iK9PH+Axt2hlWX60fuXCEoXNETw8=;
        b=n3wkQrHHNx8iBz8kmnNLo1iPz1FnYhVAxGBa9uCnHRW95IviRXLenbLbdWXDxdWauu
         OIQP6KODNVrZA9M0MIVY/ANc8lIv0KFuf2wi4gqcrHOn+K+YV7KYj+nW/MG6L2JfGKro
         HOrtR4pR+sSYdU+oJFU+ZMS9fvYdI4owW23WBOOwRQixL/DphtGo06HvARsb2VAccl/Z
         jTIGD+QOsHXDTKnJMpyyQQUQQpbRPxrw5mxP/erv/wcHLHYcK5v6dppkD45EI40fcSCH
         utDl9wSvQjqQbVdWfvDr450lWBU+etgzPSDw/fasp/32EAtzgbjOgEvc4t1DkTK+t3bh
         Giqw==
X-Forwarded-Encrypted: i=1; AJvYcCVAJ4fetAvhM9uWq4DdYFqk2vJ2Hox4CdS34U6mnyzjnK/HIRf27bjBuY3FGg58A+5rRyTneOjJs3Z8Ri8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5sTaDgDdC4VNX9FHN//6zc5LNpOLB12LAJHbn57j9Yc1bLkoH
	N0+/qDaKBYBVCGQ/xpsOLi+1RE2A6fmSOHrxQGhu4dx67t15lRBrhRMX
X-Gm-Gg: ASbGncsXqJGTgPtYQzRb5xEh7eH8ER0XWM/6DvojmbNvYLI4D1bQMkskqJHzTHW09ND
	h8GH9N5bq8GAwxRJxzA1Z6Pn3K6qPu8+yIscs7aSSahmNE3l098vXGSZpWSkbV+A8nm183BW0Dy
	SldUOdbJvFTLRy9w5NA11o8lNdchbz2SPDO7wRM3p1mTZrT1cNrCvAoZcZoFUJLGTZpKbDGk2KJ
	EA1eMRuRbmhMvrsm2LRq/HADfCBD6MjkV5WAtZbC7t67S+m+IkkEicXa3I6Cr0yXYWKDptKMEva
	LciNCx0QA/wBiAhqrsgV3fjhxKhSVm56fE2scqg1ezmWlhH4bJs5Fio9pmLlbHcgHEi4ohdiNQS
	ytoQLQlzXVQUIYUJTAOYLio1fukNwk9SMHEHX2bpLI+0s4WvaLthArvtn
X-Google-Smtp-Source: AGHT+IGo7e3giCzoRWJPH5fuNrErSKA+sW5Jg+vdwA1lvHisc0+bw0iNJTwvMQIo5DNK9p/Hsz6KRg==
X-Received: by 2002:a05:622a:59ca:b0:4b3:50b0:d7f with SMTP id d75a77b69052e-4ba6b089cdemr27166391cf.61.1758114050366;
        Wed, 17 Sep 2025 06:00:50 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:d14c:9eca:ff3a:fa00? ([2620:10d:c091:500::5:59da])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820ce19df73sm1094771885a.51.2025.09.17.06.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:00:48 -0700 (PDT)
Message-ID: <71ce45fc-5214-4d40-b8c4-abab1d44314a@gmail.com>
Date: Wed, 17 Sep 2025 09:00:46 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 10/11] net/mlx5e: Update and set Xon/Xoff upon port
 speed set
To: Tariq Toukan <ttoukan.linux@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, linux-rdma@vger.kernel.org,
 Alexei Lazar <alazar@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
References: <20250825143435.598584-1-mbloch@nvidia.com>
 <20250825143435.598584-11-mbloch@nvidia.com>
 <20250910170011.70528106@kernel.org> <20250911064732.2234b9fb@kernel.org>
 <fdd4a537-8fa3-42ae-bfab-80c0dc32a7c2@nvidia.com>
 <20250911073630.14cd6764@kernel.org>
 <af70c86b-2345-4403-9078-be5c8ef0886f@gmail.com>
 <1407e41e-2750-4594-adaf-77f8d9f8ccf7@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <1407e41e-2750-4594-adaf-77f8d9f8ccf7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/17/25 6:39 AM, Tariq Toukan wrote:
>
>
> On 15/09/2025 10:38, Tariq Toukan wrote:
>>
>>
>> On 11/09/2025 17:36, Jakub Kicinski wrote:
>>> On Thu, 11 Sep 2025 17:25:22 +0300 Mark Bloch wrote:
>>>> On 11/09/2025 16:47, Jakub Kicinski wrote:
>>>>> On Wed, 10 Sep 2025 17:00:11 -0700 Jakub Kicinski wrote:
>>>>>> Hi, this is breaking dual host CX7 w/ 28.45.1300 (but I think most
>>>>>> older FW versions, too). Looks like the host is not receiving any
>>>>>> mcast (ping within a subnet doesn't work because the host receives
>>>>>> no ndisc), and most traffic slows down to a trickle.
>>>>>> Lost of rx_prio0_buf_discard increments.
>>>>>>
>>>>>> Please TAL ASAP, this change went to LTS last week.
>>>>>
>>>>> Any news on this? I heard that it also breaks DCB/QoS configuration
>>>>> on 6.12.45 LTS.
>>>>
>>>> We are looking into this, once we have anything I'll update.
>>>> Just to make sure, reverting this is one commit solves the
>>>> issue you are seeing?
>>>
>>> It did for me, but Daniel (who is working on the PSP series)
>>> mentioned that he had reverted all three to get net-next working:
>>>
>>>    net/mlx5e: Set local Xoff after FW update
>>>    net/mlx5e: Update and set Xon/Xoff upon port speed set
>>>    net/mlx5e: Update and set Xon/Xoff upon MTU set
>>>
>>
>> Hi Jakub,
>>
>> Thanks for reporting.
>> We're investigating and will update soon.
>>
>> Regards,
>> Tariq
>>
>
> Hi,
>
> We prefer reverting the single patch [1] for now. We'll submit a fixed 
> version later.
>
> Regarding the other two patches [2], initial testing showed no issues.
> Can you/Daniel share more info? What issues you see, and the repro steps.
>
> Thanks,
> Tariq
>
> [1]
> net/mlx5e: Update and set Xon/Xoff upon port speed set
>
> [2]
> net/mlx5e: Set local Xoff after FW update
> net/mlx5e: Update and set Xon/Xoff upon MTU set
>

Hello Tariq,

My notes for the situation were that I was running a vanilla net-next 
kernel on a dual host, CX7 system, with the 28.45.1300 FW at commit:

deb105f49879 net: phy: marvell: Fix 88e1510 downshift counter errata

and I was having the issues that Jakub described. No ping working in a 
subnet. Extremely slow bandwidth on a large transfer. My notes say that 
reverting just [1] (from your message) did not fix the problem, but then 
reverting [2] and [3] restored normal behavior.

However, I did attempt to reproduce again on the same system this 
morning, and now I'm seeing that reverting just [1] is sufficient to fix 
the issues.

