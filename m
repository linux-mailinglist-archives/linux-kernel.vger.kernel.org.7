Return-Path: <linux-kernel+bounces-831240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF252B9C2C8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B904265AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B985132899E;
	Wed, 24 Sep 2025 20:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M+Jfq1Fo"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6618B2566DD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746497; cv=none; b=Mb6MrUwBkhtIYIQTaNUqPKu/8DE/2uMDt8mkUobJUCMMy0axr8CycTU6DXb8NDuLAx3U/RxYeK/2aP0VaIJ4eCmWBnln3hcj7llI/AAcT61+kYBCrKN011dRWKvmzIWlU4PtbAPsEa/+EukflHLWF0UmGWHWHE7zBoHNwrTsnpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746497; c=relaxed/simple;
	bh=kXwStSJzUUM2wTjVcQqIiMRHPqvIep/0eotaHzEAHoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLUo3JVmoWaJ+SlU61t2sBXHhnLeHDGfF+gZG47ZOjGj76BISdqNEiaJi7Ar1A4Ra9rCrXR3kfLHz0ZDJAXPh+HPioEcRyu10M6/7t8GgKW6idYXwhkZwx2yH43v3GlgeP51cjKLmPBYTMfR/YQDr57M1+LGjt+Ki4bn8RORRcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M+Jfq1Fo; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-4257f2b59ffso7407845ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758746494; x=1759351294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TlmrI7hpUi0HNqRBLgmvEzqTujMsR83VWTin/t3tj/I=;
        b=M+Jfq1FoKV0zfynI3dhaNa/ZZ50ZiYO24IM72esclLkd2XoNBVqkDvUgHeCuArUjlB
         knQMLZnbNVJ/uHpaHB/iqGYXPES/a1jcuLtdyBYRd3DN049yeBNfCBnvn3qPkSxRF/FJ
         Y0XmPbMFHA72OKvn0hKDuVykeidKjjnF+Z5PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758746494; x=1759351294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlmrI7hpUi0HNqRBLgmvEzqTujMsR83VWTin/t3tj/I=;
        b=bO72POp1ns0tDEWXRhcxpMCOEe+zAlr6k8fWvkrKR63wK2TtNI/EjnI0a1mdZZHPPz
         7rKIGAzY9igTgKuAaH+UGyIoGQksWIR4z6qVT0sKb8ZYcZoXGQ9STjjqAI2Hgt+kVzcR
         CifjwiUe33sUYfjSvv9Q95a0n1Mv2F3uE0OwU1Nl+FfORzvyDOb44xvSOnBWq08BhV7u
         N2m54QHQcaYXPP80anTenNOWeILidzJOvBhnqH0ONgghjDa/EhwKaEYAgz2iedg/FfEi
         jG1TzKrLBN5f98GWW0KiEunjBSRxYeQdO1dHkbYfXWNiIeYFm50N4IdggO0oCQ8L37iq
         AkLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz29pECVDIjv9apv8Vz/Jf9AW9HWhUWvQ6oU0eOeOEXEo+sCI62UXwGW1QV0oPecGGwW/cl4dynxX0lbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz04hOGngq+65Ea/xJSX7lHpr8AnNyLLBI5ml4ynRfMaN9073u7
	VI5sVFVwSL6bkAl58RMcdcQbtMLUQKkhu92R/FwRJnjstb7Wl4ddH3NHltqQE0pQpPQ=
X-Gm-Gg: ASbGncvBX6wAJymizybPUYT3w+dRD6NbXLIN6fxXROpp7JYZ9iNlqURGVgB5A6XHQkr
	IPTTagrXP7mXi8/9p9YvpHn++BA4E5a6VIAR0Fih/cXdfWRjBLypmE7JPaKhOUoPtlrK8nk3ifV
	wHDa/qEcnHPnli9N+iR4D00GykPyuWwk83quSACSVly2m2wpd3zrRcLpPKngWWJqidgyodHtE9o
	LuShFa3D1aYD1V0BfyZJhyHE3davlQAN2xo7hBhsHw65apDX3sHyfUipg2oSFqKQ/TpJZa6pGw3
	Od1I+3MmAjwKz0TMj4c6nJJHdyF21CABznpm4pGB9YknX6U/imbWibCZG0DUtYZWPN+DT4pzV9b
	Dsh5wHjRhAKivvyILNEfI38gpsMXfyG1o7eY=
X-Google-Smtp-Source: AGHT+IGNshkXrQ7jqueT0uM6B6VLdLEXbxxLiC3Daw8fjI5R8aeGXHxnL/5gMD5P8xdu4OEt9TU7xQ==
X-Received: by 2002:a05:6e02:1d8a:b0:423:2666:4687 with SMTP id e9e14a558f8ab-425c36bb2cdmr2782795ab.15.1758746494490;
        Wed, 24 Sep 2025 13:41:34 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425bc0b059bsm910745ab.10.2025.09.24.13.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 13:41:34 -0700 (PDT)
Message-ID: <cf6f39ec-60c7-4779-971b-1f52b7253f4f@linuxfoundation.org>
Date: Wed, 24 Sep 2025 14:41:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/17] usb: vhci-hcd: Replace pr_*() with dev_*() logging
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Valentina Manea <valentina.manea.m@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
 <20250902-vhci-hcd-cleanup-v1-17-1d46247cb234@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-17-1d46247cb234@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/25 05:56, Cristian Ciocaltea wrote:
> Where possible, use driver model logging helpers dev_*() instead of
> pr_*() to ensure the messages are always associated with the
> corresponding device/driver.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

