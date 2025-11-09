Return-Path: <linux-kernel+bounces-892209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A386EC449FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535953A54CD
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 23:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF2626D4D8;
	Sun,  9 Nov 2025 23:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaoKgs/r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqoVMxun"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726C472602
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 23:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730314; cv=none; b=BKnkYgRy8AwmjRzcexB31t/Gi1lIg/tyFx2cpfXFXypNUhDJ5O8IX468vpJiK78s8l72Fujs8harJ4ZzF+B2ZBfAVjtV7hCbhl52Ot4O2vkW2Hl0Wh1TWVnEC9E3H3qvaxuNArZXQ7u8ixkd2+Q32RLP0GgfC4S0tZrctCTllmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730314; c=relaxed/simple;
	bh=jVRwO6u+KFtMJdZTz0EnPMtiDoeQNjIrcwl2T1le3Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYRx2lMcR2TnknxuGMeu3NPvrBYW/NsFPRXp53NiO1qwjnWOs563PE29Jv163IsH/Q5+GNlvKNR5E7Ym6pkB0x5ECliLTnnCFjy1icIAORohUW62kX5n4nSvomTQMyFGlCHZNPpEwpQzRFp+s2nml10cUAt9jo82fUMyB3tlryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iaoKgs/r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cqoVMxun; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762730311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n99PJkbrVztG5y0o6lXl7OvJ8hPSY/Pukv4ngg5F/xE=;
	b=iaoKgs/rG2d58ndI1ZrSVgPEUZc+6dF4PiRDKIzhwbn+yR2gUxmpqBoxHHoeC0ehIB+3WH
	dU71I5BTOyKhKA2x6QCsw1CzhKVIQC8UtA679G5+ZLbb7qZW+d6pGGi6qYJai2gD8aFxA9
	IKczxz8XWCzmgXxtaMBRVq0RtOX0Buk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-wFMyuQ2YPl-dZIWWZWNIfg-1; Sun, 09 Nov 2025 18:18:29 -0500
X-MC-Unique: wFMyuQ2YPl-dZIWWZWNIfg-1
X-Mimecast-MFC-AGG-ID: wFMyuQ2YPl-dZIWWZWNIfg_1762730309
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a4c4eeeef2so4704071b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 15:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762730308; x=1763335108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n99PJkbrVztG5y0o6lXl7OvJ8hPSY/Pukv4ngg5F/xE=;
        b=cqoVMxunlTffR36lzABG7KnQGeR1krIRslY/4zHQakcvdUlrY/dZuYg4WvcDKbgf4h
         Yq6yWiaWmE65c6PEZzDdoU8Cf7OItlUP9bj/dBJ9DFHPmetOFATXQbaLM99aLtd5ixS2
         AJVyrlbrUkjIeAZIZJnYAspofnivU6S64jxesamY7zL4X/9BxHfsguGPZA6NIln+fSe3
         HTB6jVeDaWieH5MGyll5FlbqCHg5TgmyU2ZRp1YeEylLfOpewHGsY+sn9LTIS7P/VkvP
         WuWTT312gwUOjJ5IbIEBwORBzRehEdxsaV/9KjgGbfAtliO6+AtP0zL8DwHal3bCpqXq
         VEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762730308; x=1763335108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n99PJkbrVztG5y0o6lXl7OvJ8hPSY/Pukv4ngg5F/xE=;
        b=CUQCOTHt2pOKW6ro1i2hPhf4feKrI3HOSZE4CVplg07esY3bqmloATOaqcsmGaGu/g
         YxdS8l40OOY0OLiLFKodelg6A8G/uqJe1zkxLmyhF1r5tK42uM/GS+/JdsCH85uDjKvK
         9/uvmIeRKWLo+U1Zu3DF8f1yCuHyQBN/ZbPVyKcUmH0grK6XnqQ3u5aYiVGzVaToOBTn
         Y3BYHNVtWigL05DSA9ZOxi4TyE5I/QQf/fJo09yQtJuj5Kb6P87kwjkpmIHRMT3dlk7v
         LELga7SJrvvMWFgEsR+gLuGSbzim80JVdylLd6Tob6p2+MwuJVUkmOcZ17es0kHFlxfg
         uvnA==
X-Forwarded-Encrypted: i=1; AJvYcCX9GXklqmVYfQ4NbN2nwSIIPOXcWpC8EQfutDINDoIaNSmg/oprl74CulZivWnJrqiI4bFy/vKIJC5adYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6SS2m3IHLAxRcFcA/nRYZFCWk4qR/km2dBYX2XWDukaa2Ldcu
	ZGz94GKNuF8sOQt3tCuRZcRwFBZcP3KfGdpDPNIUv0ZGOAymkmNxwQD96z7XZDzl3OuDZWT1tnD
	/uRveIRpwIbb9ZRqzYx/mJpo272Duy2oFvfHF5YEWIkSq01P4BZtgD/me9IjfO3lrNA==
X-Gm-Gg: ASbGncsBx29pueMZB1+SBbr22XsADSpnRd4xhm0QSD5NapbawQem8kgTz4oh8r11kNy
	eQpZHNEw3mYBRp2c6J3Eyk+Sn4zuwi4l5mu67NSwdPcwjAZD2Zbxp4cmwXK07D/1dorZRrKkVyJ
	uHtwMknAz8b+Wr9nmiT7Cgv8AnQHJvykaio8+eLHivCfXjxiu1OyvAkfv2soyGOvSer0gpAPHgV
	sEjvwegS8hGTZqiIoFum0q7kRzLQLyAg93kxM3QGcGGVDffwFIhwd2rjZPzi3DVZvQkszA1S8f2
	OIYGvRorMCP0Y8pjkZhDptT5RSwWja0mhz7CKFZl9IiMBfYpk+NciKvke5RCcpR4Bx8CQKHDNpF
	ltHgrW6CxPLbtzaxWGYaQlvb5KGsYAJR9LOQEiyo=
X-Received: by 2002:a05:6a00:3e1b:b0:7a2:6485:f336 with SMTP id d2e1a72fcca58-7b226696673mr7522412b3a.16.1762730308729;
        Sun, 09 Nov 2025 15:18:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2mSuUUE/RVfgQqmRz/YBiUVDNGBy59LbywexIFQuJ2RZ6fbmp3YuWDNYpjDv3UjdhEXNI9Q==
X-Received: by 2002:a05:6a00:3e1b:b0:7a2:6485:f336 with SMTP id d2e1a72fcca58-7b226696673mr7522389b3a.16.1762730308356;
        Sun, 09 Nov 2025 15:18:28 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c08ee9sm9664548b3a.21.2025.11.09.15.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 15:18:27 -0800 (PST)
Message-ID: <67a36e6d-daab-479f-a1c5-3b2444a71d7c@redhat.com>
Date: Mon, 10 Nov 2025 09:18:14 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/33] arm_mpam: Add helper to reset saved mbwu state
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Fenghua Yu <fenghuay@nvdia.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-32-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-32-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> resctrl expects to reset the bandwidth counters when the filesystem
> is mounted.
> 
> To allow this, add a helper that clears the saved mbwu state. Instead
> of cross calling to each CPU that can access the component MSC to
> write to the counter, set a flag that causes it to be zero'd on the
> the next read. This is easily done by forcing a configuration update.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvdia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Cc: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Correct type checking, use mpam_feat_msmon_mbwu_<n>counter
> ---
>   drivers/resctrl/mpam_devices.c  | 48 ++++++++++++++++++++++++++++++++-
>   drivers/resctrl/mpam_internal.h |  2 ++
>   2 files changed, 49 insertions(+), 1 deletion(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>


