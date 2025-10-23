Return-Path: <linux-kernel+bounces-866321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ECBBFF766
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE3E19A75F4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A2B2BCF43;
	Thu, 23 Oct 2025 07:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbkC7Nqi"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B39239E80
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203324; cv=none; b=ViBkroNI+BAiS0MDHHC2Jw1RjqDqnHZsQyNzgNJmsLzYHhDspg/hI/L3ENLU3CNeaU5niCxi7f/dbk0WuCcj1ptCOmswQ7HOgjKH8lgkReHB7P1ZdysN7X8U1MOs8M6b0OnrDylEx5nCkIOyVUWZd5rLMnogrS8IYcp+P32p+kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203324; c=relaxed/simple;
	bh=7NwiN/K8SGK+Ygyet595Hy+1Nxn5KCZoHo1ul8wBViA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnAxFnx8RG+swVewYOPh6dh+GNoTr9XMwC0uxEe5K/5z6mBjh0PWqxhDnSlQpg1vEP84mOFgv1nWmCE2TYPrY2A4XJNE7iNMEpjUTgJg92pd3v2Gm9oyucsyC9f0Nx2Z8JhhhV3YQMlACemWSgno5JsP/M13fyLaEKuydyA1qMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbkC7Nqi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475c696ab23so2108775e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761203321; x=1761808121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AM6QKcwomZS5ILh9rEXNjcNyg7KgGv74b4bvo9G7Kp8=;
        b=lbkC7NqifFyc1F3EZAzZLywqG5Ulb5RgbsqnN9jklPfeat5M+70OY0CYWU9Nnj81UK
         R/Kg73vTXWX2+XRALzinluRJFwSYyLtKE9wrsq7GJC1MLRZVgndtEpKYHR68OkmEt4tg
         vyzoh5a3C3JD3EmCbY0vLk6fLo+RkvHQOAQ6fOuVP0NlsrxH9H7aW0hwZ5PE9pIsgXNe
         cj+TLjZCopvWCWmQbXpw7tdau0i/SOdABvaWaNpzZ6pgXnHFKG+gjnTYmSL29O//jDmk
         ntEzsa/UsYPtNUTYj0Y1447wfZ8fhoGjWFkLuDg37Y46BOHk8V0TAl2nWFD6/3Buewka
         N75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761203321; x=1761808121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AM6QKcwomZS5ILh9rEXNjcNyg7KgGv74b4bvo9G7Kp8=;
        b=PsQ/zdl+QnjJ96+QKB9HD76CwD0Br5q0zz4CdfAZmiROM9HQmwa+fFuY9kp8PoZElk
         2pL3IGloroQn68MiLis2TKC3JHpTK0BdY0ZxygSOmI8HHJeOsJ9dHHyqikTCBWg9xzMX
         l3dHJz4dRSwJo7DiJ98s2TLGsRsVcDbBbmp86e4/Az6QmFuTZaZmAgW5zpx78PofsV2+
         iu9cEoKr9kvSlzBTT/Cm7SUMRwGjC7ullFGYJRfV0j6FYXn51SDi1Pgj0C7T6VG5OCR8
         vX4OtHxFbQrbxUFU1RG5emou7BIgZ8wLg1OzfRjwmcHyiqXLb8MOWl/WQoZVoa/ZkZ72
         Cj/g==
X-Forwarded-Encrypted: i=1; AJvYcCVXDKCht+8G8LMNbt0ohKGW00+vDma/cypV6E1sR0MFJvzJLzo2F1Hsdtzs9AYvzKf2pX9pRW/XNZzOeBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFSUBOQ9lTTSveLblYG7RQZwTfoY58UW/eQ8rsxSgw8/6UqNjb
	iRdTY+7uw/PZiAFHqY19SwZANsCvQtXhcFo9JE37+oo9DlBqLpWe2+kf
X-Gm-Gg: ASbGncsXP9VGz4VsiVZU5qO/C0fEcH4psz3pEbj6gTu4fx5NYXVUvt/Z+MfzkspcI3A
	AWOTehUErAP0NHXNYV+/rCoguXAkrV7ls8W72F4Mc7o4NtDfnWMcD+70xCMQOU+WZ9Nw/QgRkqO
	w9yT3NAIP6MSr+0fsjXDeMT6+KPSnP4NndwW+9IuE3Z0tKd7riPYUvNWfEpPgx2tB6K2bhvoV31
	AiVf4pnyNXhNBSIWEgs06HURQUBGJz/Dl/W05Z0/3wk/OBrGts4PNFgQcA/CqJ/FzBgxXjax5x1
	R4yOxqsYLEr0ZcT7ISmjWfscbVAwxO4YeGtQPbZMV90IMHKkcFTNPUcKh/d7x/w8gI3I3/ctHKV
	b4B1txHC90q8n42hc4Rnyhug1gbGTPK6OVw9v1A8ysG2FOg9m2s2G/OVIoqhCM0oFUjw4h3P/N5
	lgOc6AJHJjwQWRuihj/np4pSo=
X-Google-Smtp-Source: AGHT+IENim35HOxVARbSDioYu5EEQEHmf8ELuhvz8cK4iifEtwKu94+xGBpW12KkX7avks399OoeFQ==
X-Received: by 2002:a05:600d:416b:b0:46e:45f7:34f3 with SMTP id 5b1f17b1804b1-47117874b06mr185455635e9.8.1761203321082;
        Thu, 23 Oct 2025 00:08:41 -0700 (PDT)
Received: from [10.221.206.54] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496d4b923sm50682035e9.14.2025.10.23.00.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 00:08:40 -0700 (PDT)
Message-ID: <efab6280-a27b-4ba8-b744-9d1e12bd418e@gmail.com>
Date: Thu, 23 Oct 2025 10:08:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] driver core: auxiliary bus: Fix sysfs creation on
 bind
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
 Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Aya Levin <ayal@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Simon Horman <horms@kernel.org>,
 Shay Drory <shayd@nvidia.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Parav Pandit <parav@nvidia.com>,
 Amir Tzin <amirtz@nvidia.com>
References: <1761200367-922346-1-git-send-email-tariqt@nvidia.com>
 <2025102355-abstract-subgroup-aa97@gregkh>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <2025102355-abstract-subgroup-aa97@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/10/2025 9:47, Greg Kroah-Hartman wrote:
> On Thu, Oct 23, 2025 at 09:19:27AM +0300, Tariq Toukan wrote:
>> From: Amir Tzin <amirtz@nvidia.com>
>>
>> In case an auxiliary device with IRQs directory is unbinded, the
>> directory is released, but auxdev->sysfs.irq_dir_exists remains true.
>> This leads to a failure recreating the directory on bind [1].
>>
>> Using the attributes group visibility interface, expose the IRQs
>> attributes group if"f the xarray storing IRQs entries is not empty. Now
>> irq_dir_exists field is redundant and can be removed.
>>
>> [1]
>> [] mlx5_core.sf mlx5_core.sf.2: mlx5_irq_affinity_request:167:(pid 1939):
>>     Failed to create sysfs entry for irq 56, ret = -2
>> [] mlx5_core.sf mlx5_core.sf.2: mlx5_eq_table_create:1195:(pid 1939):
>>     Failed to create async EQs
>> [] mlx5_core.sf mlx5_core.sf.2: mlx5_load:1362:(pid 1939):
>>     Failed to create EQs
>>
>> Fixes: a808878308a8 ("driver core: auxiliary bus: show auxiliary device IRQs")
>> Signed-off-by: Amir Tzin <amirtz@nvidia.com>
>> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   drivers/base/auxiliary.c       |  13 +++-
>>   drivers/base/auxiliary_sysfs.c | 117 +++++++++++++++++++++++++--------
>>   include/linux/auxiliary_bus.h  |  26 ++++++--
> 
> Why would auxbus patches go through the net tree?
> 

It shouldn't...
Honest mistake passing the argument to my script.


