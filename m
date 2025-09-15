Return-Path: <linux-kernel+bounces-816264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED445B571AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DE817B425
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1B52D593D;
	Mon, 15 Sep 2025 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4TfD9VM"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEB221638D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921924; cv=none; b=JMFv3AEq85VU0+PjwprP007VHLv14k3YkyNNWHcBHdkbDExFNX4T4BxD0qKS3dOQ1Iwp0vBEzXRzCNbgHe86mFI5Q4JKsBFLnmI8Y6XgCFXv5NNXLtM6q9h+g72jlzzuhuaKBtHy8eUcuYE+0Hmd4Z+iYin/7WoNmx1It4PYa9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921924; c=relaxed/simple;
	bh=kGHwg3luaanPBk/Byu/i1GQ/JK31vdNJbOeeSmaUbuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkKkPorJ0SHfTp5liEC9iJ1LiZVjbcQ25hnB7MN1GT99QjfqW1ODmis1seVACzXFookVOKe6XLvy5mlb43P8R6klqAV8p4qc5K+fwF/0/cagH4hSV3BsOrhOjVrn8XmQ1t6zCjNzQEaPQ0aUEZXGc7TgZCNbqYadscJYPHFKGjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4TfD9VM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f2c9799a3so4551055e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757921921; x=1758526721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JanCUlFRjj5laV++kf8eFiKJiHLqqlH/hnFp+08fd18=;
        b=R4TfD9VMicu4a+dndbYW2Pupiy7oleCgttsD4I3EJ8FNX0Dk4WSl+mGHE4ABpzi14+
         2n7Cn+gdHLbe+EU5lHVgpccdC0M8BKIG8N4AJHQZh8lsZyC3TyA7Iu5Is3hz5gydaO7h
         EohqoQCSpPgI2JCwBnEUuYgjVDbk90PtV/YkY3sxNpFGpMBzLW4k04ikRlwG3RmTv3Xf
         cTq+BfPJH4okDNrqVE5Ay6eYO0hWzA2emOK1sGjSIX7hDfeKa95Fm4T2Rwxcp2NwjYwv
         fWfqMzpYFKVRwiMFzJ6sTIcmsrVmMehe54l+hX1oN7bf4pl4DuaKY+rMXA5ibUm5r6AL
         xylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757921921; x=1758526721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JanCUlFRjj5laV++kf8eFiKJiHLqqlH/hnFp+08fd18=;
        b=ulRLj7v5GPY7tj4vyzOMh6EyMLbdbIKaGTA+SVquddelGTPhijUGbHJ3XOlkDxRwwu
         YdASWyGUQyBFQHw+t/L28ZhfO+USh941R465E5uzbJM5AuCPt5AkKQgiq+8wRPDPIyyk
         rM0naSOq64H2ZGqynAIGoRaDtDbtcn7hrNEYOSPqM48d/VGJWXUtw5Wo7li2fMIFzf2O
         ZVnU7zxEsnEpcVbFiR4N7ka6wd3fVv672HLJHOLB3SS2RPoNbQW1pLOv9nLaCDCgByJY
         lzD4yvYx77b85FOcnllgf5UICH3/pr1h6kdp1MsVKilvRlng5JFgL1R3eAPT3DyN4pO/
         5McA==
X-Forwarded-Encrypted: i=1; AJvYcCXjRpqO1tfFHV/jPOsi/3v6nPEFpqYUoDFhbuBimQGKSgdkBTPmnyQDobW6b3LkByL8ZDH3u+lTDZhGsAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtvxvjTxRXec2dQ+V8tDieLWoxjG03S3F6001DfU5khKdmZddE
	QuRCA05y+3LxANg9nokJ+QxbzkcKaATCck8kLRANIslOV9N09ey3mkCR
X-Gm-Gg: ASbGncv+SZUyfBaV7a8tYDuV9DJAaWsFA1bOvT2JA2+o1gpmQoK8zBLpauJmKEbe41u
	F3deCLnbN6gZP63PihALymKYsZvFeFDUuKle0CM22B8/d5hTLB9J6kSHhOc7VcQ9zU6Dvd1pVJW
	VK1EWOvzRcbZ/W2tLAlhItAH9WVQq1rX/2OfnWO1pSP0RAgo2Lna8c8si9K7BzYE2p0p6vVZ3Re
	VP10BHGGzRBJ+UfupBVNIZKonLLGoqMiQ42VPWGhDmq2/yrQXcXsjPDR62jvu3aFWfYLOUn+mjz
	vG07pMl7mn7msWhJxPbyW/8WPJpKj75kcp5fHQsvjlziPSZ37RhZkD2ZKvx0xS2W+lF5ALOeWZ7
	o4LowCPkRr81cUn1WXq9tFLjlaeaVCxPTiU1U+WO9+GR6DnpxG3qJQA==
X-Google-Smtp-Source: AGHT+IGgiNZFCx3A7Cjv6G6Nbr0a0VbqLvidbmj1KLlT+PabE1SdR3T2bnemHbr80ONhrSj9iyyLsg==
X-Received: by 2002:a05:600c:3515:b0:45f:28ed:6e1e with SMTP id 5b1f17b1804b1-45f28ed71c9mr64761095e9.16.1757921920946;
        Mon, 15 Sep 2025 00:38:40 -0700 (PDT)
Received: from [10.80.3.86] ([72.25.96.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0157619fsm169321285e9.7.2025.09.15.00.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 00:38:40 -0700 (PDT)
Message-ID: <af70c86b-2345-4403-9078-be5c8ef0886f@gmail.com>
Date: Mon, 15 Sep 2025 10:38:39 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 10/11] net/mlx5e: Update and set Xon/Xoff upon port
 speed set
To: Jakub Kicinski <kuba@kernel.org>, Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, linux-rdma@vger.kernel.org,
 Alexei Lazar <alazar@nvidia.com>
References: <20250825143435.598584-1-mbloch@nvidia.com>
 <20250825143435.598584-11-mbloch@nvidia.com>
 <20250910170011.70528106@kernel.org> <20250911064732.2234b9fb@kernel.org>
 <fdd4a537-8fa3-42ae-bfab-80c0dc32a7c2@nvidia.com>
 <20250911073630.14cd6764@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250911073630.14cd6764@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/09/2025 17:36, Jakub Kicinski wrote:
> On Thu, 11 Sep 2025 17:25:22 +0300 Mark Bloch wrote:
>> On 11/09/2025 16:47, Jakub Kicinski wrote:
>>> On Wed, 10 Sep 2025 17:00:11 -0700 Jakub Kicinski wrote:
>>>> Hi, this is breaking dual host CX7 w/ 28.45.1300 (but I think most
>>>> older FW versions, too). Looks like the host is not receiving any
>>>> mcast (ping within a subnet doesn't work because the host receives
>>>> no ndisc), and most traffic slows down to a trickle.
>>>> Lost of rx_prio0_buf_discard increments.
>>>>
>>>> Please TAL ASAP, this change went to LTS last week.
>>>
>>> Any news on this? I heard that it also breaks DCB/QoS configuration
>>> on 6.12.45 LTS.
>>
>> We are looking into this, once we have anything I'll update.
>> Just to make sure, reverting this is one commit solves the
>> issue you are seeing?
> 
> It did for me, but Daniel (who is working on the PSP series)
> mentioned that he had reverted all three to get net-next working:
> 
>    net/mlx5e: Set local Xoff after FW update
>    net/mlx5e: Update and set Xon/Xoff upon port speed set
>    net/mlx5e: Update and set Xon/Xoff upon MTU set
> 

Hi Jakub,

Thanks for reporting.
We're investigating and will update soon.

Regards,
Tariq


